--
-- Author:luqucheng
-- Date: 2019-12-13 16:44:00
--
local WaitForSeconds = CS.UnityEngine.WaitForSeconds
local WaitForSecondsRealtime = CS.UnityEngine.WaitForSecondsRealtime
local KTool = CS.Engine.Lib.KTool
local ResourceModule = CS.Engine.Modules.ResourceModule
local AppEngine = CS.Engine.Lib.AppEngine
local CameraExtensions = CS.UnityEngine.Camera

local settingMgr = SettingMgr:GetInstance()
local gameUtils = CS.GameUtils
local cs_coroutine = import('XLua.cs_coroutine')

local NormalMelee = import('Game.BattleView.Script.Skill.NormalMelee')
local NormalBuff = import('Game.BattleView.Script.Skill.NormalBuff')
local NormalShot = import('Game.BattleView.Script.Skill.NormalShot')
local NormalUltra = import('Game.BattleView.Script.Skill.NormalUltra')
local TimelineUltra = import('Game.BattleView.Script.Skill.TimelineUltra')
local SpecialShot = import('Game.BattleView.Script.Skill.SpecialShot')
local NormalSkill = import('Game.BattleView.Script.Skill.NormalSkill')


local UIBattlingCtrlMgr = import("Game.UI.UIBattling.UIBattlingCtrlMgr")

---@class SkillRecordReader
local SkillRecordReader = {}

SkillRecordReader.speedLineCo = nil
SkillRecordReader.motionBlurCo = nil
SkillRecordReader.rolePerformTime = nil
SkillRecordReader.lerpAudioCo = nil

function SkillRecordReader:Init(  )
    self:ClearPerformTime()
end

function SkillRecordReader:ClearPerformTime(  )
    self.rolePerformTime = {}
end

function SkillRecordReader:GetLastHitTime(  )
    return self.rolePerformTime["lastHitFrame"] or 0
end

function SkillRecordReader:GetMaxPerformTime(  )
    local max = 0
    for k,v in pairs(self.rolePerformTime) do
        if v > max then
            max = v
        end
    end
    return max
end

function SkillRecordReader:GetPerformTime( record )
    local noAction = record.na
    if noAction then
        return 0
    end

    local star = record.ss
    
    local attacker = BattleViewMgr:FindRoleView(record.a)
    if not attacker then
        return 0
    end
    local target = BattleViewMgr:FindRoleView(record.t)
    local skillViewId = attacker:GetSkillShowId(record.idx)


    --判断技能类型，普通，大招
    local setting = settingMgr:GetSetting(AutoIds.IdSetting272, "SkillViewVo")
    --@RefType [Game.Setting.Vo.SkillViewVo#SkillViewVo]
    local skillViewVo = setting:Get(skillViewId)
    -- print("[GetPerformTime]", skillViewId, table.toString(record, 'record'))
    assert(skillViewVo, "找不到技能表现的配置 id:"..skillViewId .. " 序号:"..record.idx .. " 技能id:"..record.s)

    --读取动画数据
    local setting = settingMgr:GetSetting(AutoIds.IdSetting271, "ActionVo")
    --@RefType [Game.Setting.Vo.ActionVo#ActionVo]
    local actionVo = setting:Get(skillViewVo.actionId)
    assert(actionVo, "找不到动作的配置 id:"..skillViewVo.actionId .. "  skillId:"..skillViewVo.id)

  

    local isUltra = skillViewVo.skillShowType == Constants.SkillShowType.Ultra
        or skillViewVo.skillShowType == Constants.SkillShowType.TimelineUltra

    
    local skillCameraVo = BattleViewMgr:GetSkillCameraVo(skillViewVo)
    if isUltra or (star >= 3 and attacker:UseThreeStarCamera() and skillCameraVo and skillCameraVo.openThreeStarCam) then
        return -1
    end

   

    local targets = self:GetSkillTargets(record)


    --判定延迟时间,选择一个综合最晚时间
    local maxFrame = 0
    for i,v in ipairs(targets) do
        local frame = self.rolePerformTime[v.id]
        if frame and frame > maxFrame then
            maxFrame = frame
        end
    end
    local attackerFrame = self.rolePerformTime[attacker.id] or 0
    if attackerFrame and attackerFrame > maxFrame then
        maxFrame = attackerFrame
    end

    local attackerHitEndFrame = self.rolePerformTime[attacker.id .. "_hit"] or 0
    if attackerHitEndFrame and attackerHitEndFrame > maxFrame then
        maxFrame = attackerHitEndFrame
    end

    --最后打击点，前一个技能的最后打击点需要在后一个技能之前
    local lastHitFrame = self.rolePerformTime["lastHitFrame"] or 0
    maxFrame = math.max(lastHitFrame, maxFrame)

    local readyFrame = 0
    --1,2星没有准备动作了
    --去除掉自己的准备动作和前进准备时间
    -- if star > 2 and attacker.camp == Constants.TargetCamp.Friend then
    --     readyFrame = skillViewVo.readyFrame
    -- end
    -- maxFrame = maxFrame - readyFrame

     

    --如果找不到目标的话，说明目标可能因为死亡召唤的原因，还没有召唤出来，因此，需要等前面的hit完成才能走前摇，这里不能减前摇
    if target then
        maxFrame  = maxFrame - actionVo.hits[1].frame
    else
        maxFrame = maxFrame + 60
    end

    --判断跟上一个释放技能的人阵营是否相同
    local camp = self.lastAttackCamp
    if camp and camp ~= attacker.camp then
       self.lastAttackCamp = attacker.camp
       maxFrame = self:GetMaxPerformTime()
    else
        local rs = BattleViewMgr:FindCampRoles(camp)
        local maxAttackerFrame = 0
        for i,v in ipairs(rs) do
            local f = self.rolePerformTime[v.id] or 0
            if f > maxAttackerFrame then
                maxAttackerFrame = f
            end
        end
        maxFrame = math.max(maxAttackerFrame + Core:GetBattleParamNum("maxFuseTime"), maxFrame)
    end
    
    --减下来的时间需要不早于当前这个攻击者的最晚演出结束时间
    maxFrame = math.max(attackerFrame + 10,  maxFrame)
    -- print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ " .. maxFrame .. "  " .. lastHitFrame)

    --如果这次的攻击者是上一次的受击者，则动画开始时间需要计算受击的时间
    --如果这次的受击者是上次的攻击者，需要等待其所有攻击动画播完回到原位

    local lastHitType = actionVo.hits[#actionVo.hits].hitType

    local lf = actionVo.hits[#actionVo.hits].frame
    if skillViewVo.skillShowType == Constants.SkillShowType.Melee then
        lf = math.max(lf, actionVo.returnStart)
    end
    --处理这个技能动画所有相关角色的延迟时间
    for i,v in ipairs(targets) do
        --目标的时间都是最后一个打击点
        local frame = self.rolePerformTime[v.id] or 0
        frame = math.max(frame, lf + maxFrame + readyFrame)


        -- local prevHitType = self.rolePerformTime[v.id .. "_hitType"] or Constants.HitType.Normal
        -- local prevHitEndTime = self.rolePerformTime[v.id .. "_hit"] or 0
        -- local isTargetFloating = prevHitType == Constants.HitType.Float and (frame - prevHitEndTime <= v:GetAnimationFrame("float_getup"))
        -- if isTargetFloating and hitType == Constants.HitType.Normal  then
        --     hitType = Constants.HitType.Float
        -- end
        -- hitType = Constants.HitType.Float

        -- local hitTime = v:GetHitTime(hitType, isTargetFloating ) 
        local hitFrame, endHitType = self:GetHitFrame(actionVo, v, maxFrame, readyFrame)
        local hitEndFrame = math.max(frame, lf + maxFrame + readyFrame + hitFrame)
        -- print("rolePerformTime haha", hitFrame, endHitType)

        -- if target and v.id == target.id and skillViewVo.skillShowType == Constants.SkillShowType.Melee then
        --     frame = math.max(frame, actionVo.returnStart + maxFrame + readyFrame)
        --     hitEndFrame = math.max(frame, actionVo.hits[#actionVo.hits].frame + maxFrame + readyFrame + v:GetHitTime(lastHitType))
        -- else
        --     frame = math.max(frame, actionVo.hits[#actionVo.hits].frame + bulletHitFrame + maxFrame + readyFrame)
        --     hitEndFrame = math.max(frame, actionVo.hits[#actionVo.hits].frame + bulletHitFrame + maxFrame + readyFrame + v:GetHitTime(lastHitType))
        -- end
        self.rolePerformTime[v.id] = frame
        self.rolePerformTime[v.id .. "_hit"] = hitEndFrame
        self.rolePerformTime[v.id .. "_hitType"] = endHitType
    end
    self.rolePerformTime[attacker.id] = math.max(attackerFrame, actionVo.fuseFrame + maxFrame + readyFrame)
    --为了保证下一个角色的最初打击点晚于这个角色的最后打击点
    self.rolePerformTime["lastHitFrame"] = math.max(lastHitFrame, lf + maxFrame + readyFrame + skillViewVo.interval + 30)
    self.lastAttackCamp = attacker.camp

    -- print(maxFrame, actionVo.frame, table.toString(self.rolePerformTime, "self.rolePerformTime"))


    --全部减少maxframe的等待时间
    for k,v in pairs(self.rolePerformTime) do
        if not string.contains(k, "_hitType") then
            self.rolePerformTime[k] = math.max( 0, v - maxFrame )
        end
    end

    --等待间隔时间最少不少于这些，防止打击点接近的情况几乎同时行动
    if BattleInfo:IsUserCamp(attacker.camp) then
        maxFrame = math.max(20, maxFrame)
    else
        maxFrame = math.max(30, maxFrame)
    end
    return maxFrame
end

function SkillRecordReader:GetHitFrame(actionVo, target, maxFrame, readyFrame)
    local prevHitType = self.rolePerformTime[target.id .. "_hitType"] or Constants.HitType.Normal
    local prevHitEndFrame = self.rolePerformTime[target.id .. "_hit"] or 0
    local hitFrame = 0
    local getUpFrame = target:GetAnimationFrame("float_getup")
    --怪物如果还在浮空中收到普通受击，则会继续浮空，需要延长判定
    for i, hit in ipairs(actionVo.hits) do
        local isTargetFloating = prevHitType == Constants.HitType.Float and (hit.frame + maxFrame + readyFrame <= prevHitEndFrame - getUpFrame)
        if isTargetFloating and hit.hitType == Constants.HitType.Normal then
            hitFrame = target:GetHitTime(Constants.HitType.Float, isTargetFloating )
            prevHitType = Constants.HitType.Float
        else
            hitFrame = target:GetHitTime(hit.hitType)
            prevHitType = hit.hitType
        end
        prevHitEndFrame = hitFrame + hit.frame + maxFrame + readyFrame
    end
    return hitFrame, prevHitType
end

function SkillRecordReader:DoRecord( record, isFinishSkill )
    local roleRemoveRecords = self:ExtractRoleRemoveRecord(record)  -- 提取角色死亡战报，等伤害全打出来再表现死亡

    local BattleViewMgr = BattleViewMgr
    -- print("SkillRecordReader:DoRecord", table.toString(record, "record"))
    --对应 SkillRecord
    local star = record.ss
    local skillId = record.s
    local skillIndex = record.idx
    local lv = record.sl

    local noAction = record.na
    local attacker = BattleViewMgr:FindRoleView(record.a)

    if noAction or not attacker then
        for i,subRecord in ipairs(record.subs) do
            RecordReader:DoSubRecord(subRecord)
        end
        return
    end
    local target = BattleViewMgr:FindRoleView(record.t)

    local skillViewId = attacker:GetSkillShowId(skillIndex)

    --判断技能类型，普通，大招
    local setting = settingMgr:GetSetting(AutoIds.IdSetting272, "SkillViewVo")
    --@RefType [Game.Setting.Vo.SkillViewVo#SkillViewVo]
    local skillViewVo = setting:Get(skillViewId)
    -- print(table.toString(record, 'record'))

    --读取动画数据
    local setting = settingMgr:GetSetting(AutoIds.IdSetting271, "ActionVo")
    --@RefType [Game.Setting.Vo.ActionVo#ActionVo]
    local actionVo = setting:Get(skillViewVo.actionId)
    assert(actionVo, "找不到动作的配置 id:"..skillViewVo.actionId .. "  skillId:"..skillViewVo.id)

    --普通技能按照近战远程划分

    local isUltra = skillViewVo.skillShowType == Constants.SkillShowType.Ultra
                        or skillViewVo.skillShowType == Constants.SkillShowType.TimelineUltra



    --近战技能，前冲，打击，后退
    --找到脚本
    local scriptName = skillViewVo.scriptName
    local script = self:FindScript(scriptName, skillViewVo.skillShowType)
    -- print(table.toString(skillViewVo, 'skillViewVo') )

    

    --站位在这里重置，为了让镜头不会因为人物旋转改变而变动
    -- BattleViewMgr:ResetAllStand()
    if skillViewVo.skillShowType == Constants.SkillShowType.Melee 
        or skillViewVo.skillShowType == Constants.SkillShowType.Shot
        or skillViewVo.skillShowType == Constants.SkillShowType.SpecialShot
        or skillViewVo.skillShowType == Constants.SkillShowType.TimelineUltra

        then
            if target then
                local aim = nil
                if skillViewVo.isAoe then
                    aim = BattleViewMgr:GetAoe(target.camp)
                else
                    aim = target
                end
                --近战和远程事先做旋转，保证初始镜头的角度
                ---TODO 大boss战时配置为2时不进行lookAt
                if attacker:GetLookAtState() == 1 then
                    local pos = Vector3.New(aim.transform.position.x, 0, aim.transform.position.z)
                    attacker:GetRotateNode().transform:LookAt( pos )
                end
            end
    end
    
    --发送开始技能表现的消息
    local ids = {}
    Events.Broadcast(Constants.EventNames.BattleSkillStartShow, 
        {roleId = attacker.id, skillId = skillId, skillIndex = skillIndex, star = star, lv = lv, targetIds = record.mts, isInput = record.ip})

    --技能前触发
    -- local preRecord = record.subs[1]
    -- coroutine.yield( RecordReader:DoSubRecord(preRecord) )
  
    local nowHurtIndex = 0
    local hitType = actionVo.hitType
    local targets = {}

    local onHit = function ( index, actionVo )
        local hitInfo = actionVo.hits[index]
        local hitRecord = nil
        local targets = {}
        if hitInfo.hurt then
            nowHurtIndex  = nowHurtIndex + 1

            if nowHurtIndex == 1 then
                local preRecord = record.subs[1]        -- RecordType.SkillStart，他的subs可能是比如RecordType.UltraPointChange等
                RecordReader:DoSubRecord(preRecord)
            end

            --不能占了post的位置
            if nowHurtIndex + 1 < #record.subs then
                hitRecord = record.subs[nowHurtIndex + 1]
            end
            targets = self:GetSkillHitTargets(record, nowHurtIndex)
        end

        -- print("nowHurtIndex:"..nowHurtIndex .. "  \n" .. table.toString(hitRecord, "hitRecord") .. "  \n" .. table.toString(record, "record"))

        local max = actionVo.maxHurt

        if hitInfo.hurt and hitRecord then
            self:DoSkillHitRecord(hitRecord, targets, hitType, hitInfo.hitType)
            --添加buff,添加之后会清除，保证只会走一次
            RecordReader:DoSubRecord(hitRecord)
        end
        for i, r in ipairs(targets) do
            -- r:PlayHurt(actionVo.hitType, hitInfo.hitType, true)
            -- if hitInfo.floatUp then
            --     r:LockHurt()
            --     r:PlayFloatUp()
            -- end
            -- if hitInfo.floatDown then
            --     r:LockHurt()
            --     -- r:PlayFloatDown()
            -- end
            -- if hitInfo.heavyHit then
            --     r:LockHurt()
            --     r:HeavyHit()
            -- end
            if hitInfo.hurt then
                local effectName = skillViewVo.hitFX[index] or skillViewVo.hitFX[#skillViewVo.hitFX]
                -- print("on hit", effectName, i, skillViewVo.hitFX[index], skillViewVo.hitFX[#skillViewVo.hitFX])
                if hitInfo.hitFXType == 2 then
                    BattleViewMgr.FXMgr:PlayFXOnRole(effectName, r, false, r.modelVo.bulletHitPos)
                else
                    BattleViewMgr.FXMgr:PlayFXOnRole(effectName, r)
                end
                BattleViewMgr:PlaySFX(skillViewVo.hitSFX, r)
            end
        end

       


        --最后次连击之后需要同步血量
        if index >= #actionVo.hits then
            --处理没有处理过的hit
            for i=nowHurtIndex + 2,#record.subs - 1 do
                local rec = record.subs[i]
                RecordReader:DoSubRecord(rec)
            end
            --如果最后一次hit并不是伤害，则需要再取一下
            --同步血量
            -- for k,v in pairs(lastFinalHp) do
            --     local r = BattleViewMgr:FindRoleView(k)
            --     r:SetNowHp(v)
            -- end

            --技能后触发
            local postRecord = record.subs[#record.subs]    -- RecordType.SkillEnd，他的subs可能是比如RecordType.AddBuff
            coroutine.yield( RecordReader:DoSubRecord(postRecord))

            Events.Broadcast(Constants.EventNames.BattleSkillLastHitPoint, {roleId = attacker.id, skillId = skillId})

            -- 角色死亡
            if #roleRemoveRecords > 0 then
                self:CheckCardDeathVoice(roleRemoveRecords)
                for i, v in ipairs(roleRemoveRecords) do
                    -- print("[流程] record:", Constants.RecordTypeName[v.r], table.dump(v))
                    self:DoSubRecord(v)
                end
            end

            local questId = BattleViewMgr.initData.questId
                --终结一击需要慢动作
            if isFinishSkill and BattleInfo:IsUserCamp(attacker.camp)
            and not (questId == Constants.QUEST_OP_LEVEL[2] or questId == Constants.QUEST_OP_LEVEL[3]) then
                coroutine.yield(self:DoFinalDamage(attacker, skillViewVo.skillShowType == Constants.SkillShowType.Melee))
            end
            attacker:UnlockHurt()
        end
    end

    
    --攻击者攻击过程中不播放受击动作
    attacker:BeforeSkill()
    attacker:LockHurt()

    local skillCameraVo = BattleViewMgr:GetSkillCameraVo(skillViewVo)
    local skillCameraType = Constants.SkillCameraType.None
    if star == 3 and not isUltra and attacker:UseThreeStarCamera() and skillCameraVo and skillCameraVo.openThreeStarCam then
        skillCameraType = Constants.SkillCameraType.ThreeStar
    elseif not isUltra and attacker:UseNormalSkillCamera() then
        skillCameraType = Constants.SkillCameraType.Normal
    end

    -- print("skillCameraType", skillCameraType)

    if skillCameraType == Constants.SkillCameraType.None then
        BattleViewMgr:ResetCamera()
    else
        local aim = nil
        if skillViewVo.isAoe then
            aim = BattleViewMgr:GetAoe(target.camp)
        else
            aim = target
        end

        local s = skillCameraType == Constants.SkillCameraType.Normal and 1 or star
        KTool.ResetTransform(attacker.cameraAttach)
        local SkillCameraMgr = CS.Game.Native.Battle.BattleSkillCameraMgr.Instance
        SkillCameraMgr:PlaySkillByStarAndStandLocation(attacker.cameraAttach, 
        {skillId = checkString(skillViewId) , star = s, standLocation = attacker.standIndex, isFollow = skillViewVo.skillShowType == Constants.SkillShowType.Melee}
        ,aim.transform, attacker.defaultNode)
    end
   
    if skillCameraType == Constants.SkillCameraType.ThreeStar then
        --超过两星，播放准备动作
        self:ChangeRoleQuilty(CS.CameraCustomData.RoleSettingEnum.MediumQuality)
        -- BattleViewMgr:ChangeGameSpeed(1)
        attacker:HideLoopFXNode()
        BattleViewMgr:AddCommonSignals(attacker.cameraAttach)

        attacker:PlayAnimation(skillViewVo.readyName)
        BattleViewMgr:PlaySFX(skillViewVo.readySFX, attacker)
        Events.Broadcast(Constants.EventNames.BattlePrepareStartShow, {})
        coroutine.yield( WaitForSeconds(skillViewVo.readyFrame * AnimFrameTime) )
        Events.Broadcast(Constants.EventNames.BattlePrepareEndShow, {})
    end

    if isUltra then
        --准备动作结束之后，如果是大招，开始cutin
        Events.Broadcast(Constants.EventNames.BattleCutInStart, {roleId = attacker.id, skillId = skillId, star = star})
    else
        --音效
        BattleViewMgr:PlaySFX(skillViewVo.attackSFX, attacker)
    end

    --速度线和模糊处理
    -- self.motionBlurCo = cs_coroutine.start(self.DoBlur, self, actionVo)
    if BattleInfo:IsUserCamp(attacker.camp) then
        self.speedLineCo = cs_coroutine.start(self.DoSpeedLine, self, actionVo)
    end

    --需要延时一会结束战斗准备动作，不然会闪一下
    self.resetIdleCo = cs_coroutine.start(function ()
        coroutine.yield(WaitForSeconds(1.5))
        attacker:OnResetCard()
    end)
    --命中时候处理，按照连击数显示伤害
    coroutine.yield( script:Show(record, skillViewVo, actionVo, target, attacker, star, onHit, isFinishSkill) ) 
    attacker:AfterSkill()

    -- 放完技能重置角色的朝向（如果这个角色已经开始下一个攻击了，那不要重置）
    if not attacker.isSkillPerforming then
        attacker:SyncStand()
    end

    local ts = self:GetSkillTargets(record)
    -- for i, r in ipairs(ts) do
    --     r:UnlockHurt()
    -- end

    Events.Broadcast(Constants.EventNames.BattleSkillEndShow, 
    {roleId = attacker.id, skillId = skillId, star = star })

    if skillCameraType == Constants.SkillCameraType.ThreeStar then
        self:ChangeRoleQuilty(CS.CameraCustomData.RoleSettingEnum.LowQuality)
        if not attacker:IsDead() then
            attacker:ShowLoopFXNode()
        end
            
        coroutine.yield( WaitForSeconds(0.7)) 
        -- BattleViewMgr:ResetAllStand()
        --超过两星，结束后重置一下速度,因为timeline有可能改变速度
        BattleViewMgr:ChangeGameSpeed(BattleViewMgr.gameSpeed)
    end

    -- print("[加载] 技能结束", record.a, record.s, CS.UnityEngine.Time.realtimeSinceStartup)
end


function SkillRecordReader:FindScript( scriptName, skillShowType )
    local script = nil
    if scriptName and scriptName ~= "0" then
        --寻找技能脚本
        script = import('Game.BattleView.Script.Skill.'..scriptName)
    else
        local switch = {
            [Constants.SkillShowType.Melee] = NormalSkill,
            [Constants.SkillShowType.Shot] = NormalSkill,
            [Constants.SkillShowType.Buff] = NormalSkill,
            [Constants.SkillShowType.Ultra] = NormalUltra,
            [Constants.SkillShowType.TimelineUltra] = TimelineUltra,
            [Constants.SkillShowType.SpecialShot] = NormalSkill,
            
        }
        script = switch[skillShowType]
    end
    local questId = BattleViewMgr.initData.questId
    if questId == Constants.QUEST_OP_LEVEL[2] or questId == Constants.QUEST_OP_LEVEL[3] then
        if skillShowType == Constants.SkillShowType.TimelineUltra then
            self.tl = script
        end
    end
    return script
end

function SkillRecordReader:DestroyTl()
    if self.tl then
        self.tl:DestroyGO()
        self.tl = nil
    end
end

--@return [Game.BattleView.Entity.RoleView#RoleView<>]
function SkillRecordReader:GetSkillTargets( skillRecData )
    --找到主伤害效果
    local targets = {}
    local hts = skillRecData.hts
    for j,ts in ipairs(hts) do
        for i,v in ipairs(ts) do
            local target = BattleViewMgr:FindRoleView(v)
            if target and not table.isContain(targets, target) then
                table.insert(targets, target)
            end
        end
    end
    

    -- local oes = skillRecData.oe

    -- for i,effect in ipairs(oes) do
    --     for j,v in ipairs(effect.ts) do
    --         local target = BattleViewMgr:FindRoleView(v)
    --         if not table.isContain(targets, target) then
    --             table.insert(targets, target)
    --         end
    --     end
    -- end
    return targets
end

--@return [Game.BattleView.Entity.RoleView#RoleView<>]
function SkillRecordReader:GetSkillHitTargets( skillRecData, hitIndex )
    --找到主伤害效果
    local targets = {}
    local hts = skillRecData.hts
    local ts = skillRecData.hts[hitIndex] or {}
    for i,v in ipairs(ts) do
        local target = BattleViewMgr:FindRoleView(v)
        if target and not table.isContain(targets, target) then
            table.insert(targets, target)
        end
    end
    return targets
end

function SkillRecordReader:Handle(  )
    --处理三个阶段的数据（技能释放前，技能释放中，技能释放后）
end

--命中伤害要根据连击做分割的，先记录
function SkillRecordReader:DoSkillHitRecord( record, targets, hitElementType, hitType )
    --拿出所有伤害效果
    --统计所有收到伤害的人本次的总伤害,做伤害合并
    local rt = Constants.RecordType

    local IsInTargets = function ( targetId )
        for i,v in ipairs(targets) do
            if v.id == targetId then
                return true
            end
        end
        return false
    end

    if record.subs then
        for i,record in ipairs(record.subs) do
            if record.r == rt.Damage then
                local targetId = record.t
                local inTargets = IsInTargets(targetId)
                record.hitType = inTargets and hitType or 1
                record.hitElementType = hitElementType
            elseif record.r == rt.Effect and record.subs then
                for j,r in ipairs(record.subs) do
                    if r.r == rt.Damage then
                        local targetId = r.t
                        local inTargets = IsInTargets(targetId)
                        r.hitType = inTargets and hitType or 1
                        r.hitElementType = hitElementType
                    end
                end
            end
        end
    end
end

function SkillRecordReader:DoSubRecord( record, isFinishDamage )
    local rt = Constants.RecordType
    -- local subs = record.subs
    -- if not subs then
    --     return
    -- end
    
    local v = record
    -- for i,v in ipairs(subs) do
        if v.r == rt.Damage then
            self:HandleDamageRecord(v, isFinishDamage)
        elseif v.r == rt.AddBuff then
            self:HandleAddBuffRecord(v)
        elseif v.r == rt.RemoveBuff then
            self:HandleRemoveBuffRecord(v)    
        elseif v.r == rt.ChangeBuff then
            self:HandleChangeBuffRecord(v)
        elseif v.r == rt.Effect then
            self:HandleEffectRecord(v)
        elseif v.r == rt.ShieldChange then
            self:HandleChangeShield(v)
        elseif v.r == rt.WeakExpose then
            self:HandleWeakExpose(v)
        elseif v.r == rt.ElementBreak then
            self:HandleElementBreak(v)
        elseif v.r == rt.Weak then
            self:HandleWeak(v)
        elseif v.r == rt.RoleDead then
            self:HandleRoleDead(v)
        elseif v.r == rt.RoleExit then
            self:HandleRoleExit(v)
        elseif v.r == rt.Trigger then
            self:HandleTrigger(v)
        elseif v.r == rt.DodgeBuff then
            self:HandleDodgeBuff(v)
        elseif v.r == rt.MissBuff then
            self:HandleMissBuff(v)
        elseif v.r == rt.RoleRemove then
            self:HandleRoleRemove(v)
        end
        
    -- end
end

function SkillRecordReader:HandleDodgeBuff( record )
    Events.Broadcast(Constants.EventNames.BattleBuffDodgeShow,
     {roleId = record.p1})
end

function SkillRecordReader:HandleMissBuff( record )
    Events.Broadcast(Constants.EventNames.BattleBuffMissShow,
     {roleId = record.p1})
end

function SkillRecordReader:HandleTrigger( record )
    Events.Broadcast(Constants.EventNames.BattleBuffTrig,
     {roleId = record.o, targetId = record.t, triggerBuffId = record.bId, triggerBuffTypeId = record.tId})
end

function SkillRecordReader:HandleWeak( record )
     Events.Broadcast(Constants.EventNames.BattleWeak,
     {roleId = record.id, round = record.ro, breakCount = record.wc})
end

function SkillRecordReader:HandleElementBreak( record )
     Events.Broadcast(Constants.EventNames.BattleElementBreak,
     {roleId = record.id, stars = record.re})
end

function SkillRecordReader:HandleWeakExpose( record )
    --通知ui添加相应的ui
     Events.Broadcast(Constants.EventNames.BattleWeakExpose,
     {roleId = record.id, stars = record.el, breakCount = record.wc})
end

function SkillRecordReader:HandleChangeShield( record )
    Events.Broadcast(Constants.EventNames.BattleChangeShield,
    {roleId = record.id, shieldValue = record.sv, shieldValueMax = record.svm})
end

function SkillRecordReader:HandleRoleDead( record )
    local role = BattleViewMgr:FindRoleView(record.id)
    if role then
        role:SetNowHp(0)
    end
end

function SkillRecordReader:HandleRoleExit( record )
    local role = BattleViewMgr:FindRoleView(record.id)
    if role then
        role:ForceSetNowHp(0)
        role:Remove()
    end
end

function SkillRecordReader:HandleRoleRemove(record)
    local role = BattleViewMgr:FindRoleView(record.id)
    if role then
        role:PlayDeath()
    end
end

function SkillRecordReader:HandleEffectRecord( record )
    --生效时候添加特效
    -- print("HandleEffectRecord", record.effectData.id)
    local effectId = record.e
    local targetIds = record.ts
    local showId = record.si
    local attackerId = record.a
    local attacker = BattleViewMgr:FindRoleView(attackerId)
    

    if showId == 0 or showId == "" then
        return
    end
    --移除特效
    local setting = settingMgr:GetSetting(AutoIds.IdSetting273, "SkillEffectViewVo")
    --@RefType [Game.Setting.Vo.SkillEffectViewVo#SkillEffectViewVo]
    local skillEffectViewVo = setting:Get(showId)

    if not skillEffectViewVo then
        return
    end

    if not Tools.isNullKey(skillEffectViewVo.bulletId)  then
         --发射子弹
        local finish = false
        local projectileId = skillEffectViewVo.bulletId
        local script, bulletVo = Core:GetProjectile(projectileId)
        local ps = {}
        for i,v in ipairs(targetIds) do
            local roleView = BattleViewMgr:FindRoleView(v)
            if roleView and attacker then
                local projectile = script.New(bulletVo, roleView, attacker, function ( proj )
                    finish = true
                end, false--第一颗子弹不随机位置
                )
                table.insert(ps, projectile)
            end
        
        end
        local shoot = function ( projectile )
            local projectileCoId = nil
            local co = cs_coroutine.start(function (  )
                coroutine.yield( projectile:ShootProjectile() )
                CoManager:RemoveCoById(projectileCoId)
            end)
            --把发射子弹的id当做tag
            projectileCoId = CoManager:AddCo(co)
        end
        for i,projectile in ipairs(ps) do
            shoot(projectile)
        end

        while not finish do
            coroutine.yield()
        end
    end
   

    --特效
    for i,v in ipairs(targetIds) do
        local roleView = BattleViewMgr:FindRoleView(v)
        if roleView and skillEffectViewVo.buffLoopFX == 0 then --没有循环特效的时候直接播放，有的话则再buff中做处理
            BattleViewMgr.FXMgr:PlayFXOnRole(skillEffectViewVo.addFX, roleView)
        end

        if roleView then
            --音效
            BattleViewMgr:PlaySFX(skillEffectViewVo.addSFX, roleView)
        end
    end

end

--处理伤害相关的战报
function SkillRecordReader:HandleDamageRecord( record, isFinishDamage )
    local target = BattleViewMgr:FindRoleView(record.t)
    local isHit = record.h
    local isCrit = record.c
    local damageType = record.dt
    local damage = record.d
    local finalDamage = record.fd
    local hpChange = record.hc
    local shieldRemain = record.s
    local nowHp = record.hp
    local dotHotType = record.dh
    local element = record.e
    local hitType = record.hitType
    local hitElementType = record.hitElementType
    local isPureShow = record.isPureShow--专门用来标记是不是技能中的伤害，如果是，则只改变血条不判断死亡
    local shieldAbsorb = record.sa --护盾吸收值
    local isBounce = record.ib
    local attackerId = record.a
    -- print("PlayHurt HandleDamageRecord",  record.t, isPureShow, damageType )
    if damageType == Constants.DamageType.HPChange then
        hitType = 0
    end
    --改变血量
    if target and target.attr then
        if isPureShow then
            target:PureChangeNowHp(hpChange, hitElementType, hitType)
        else
    -- print("HandleDamageRecord", record.t, hpChange, nowHp, target.attr:GetValue(Constants.AttrTypeId.NowHp) - hpChange)
            target:ChangeNowHp(hpChange, nowHp, hitElementType, hitType, isBounce)
        end
        if shieldAbsorb > 0 and hpChange == 0 then
            target.buffViewMgr:ShowLoopFXHurt()
        end
        --伤害消息
        -- BattleDamageShow = "BattleDamageShow",--战斗中跳数字{roleId = 1, damage = 200(正数伤害，负数治疗), isCrit = true(是否暴击), isDot = false(是否是dot), dotType = 1}
        Events.Broadcast(Constants.EventNames.BattleDamageShow,
            {roleId = target.id, damage = finalDamage, isCrit = isCrit, damageType = damageType, isHit = isHit, 
            isDot = (not string.isEmpty(dotHotType)) and dotHotType ~= nil, dotType = dotHotType, element = element, 
            shieldAbsorb = shieldAbsorb, attackerId = attackerId, hpChange = hpChange}
        )
    end

    if not isPureShow then
        --非技能内飘字等待4帧
        -- coroutine.yield()
        -- coroutine.yield()
        -- coroutine.yield()
        -- coroutine.yield()
    end

    if isFinishDamage and (not string.isEmpty(dotHotType)) and (not BattleInfo:IsUserCamp(target.camp)) then
        coroutine.yield(self:DoFinalDamage(nil, false))
    end
end
--处理添加buff香瓜你的战报
function SkillRecordReader:HandleAddBuffRecord( record )
    local uid = record.id
    local owner = BattleViewMgr:FindRoleView(record.t)
    local attackerId = record.a
    local buffId = record.b
    local lay = record.l
    local lv = record.lv
    local star = record.s
    local showId = record.si
    local remainRound = record.rr
    -- print('HandleAddBuffRecord BuffView', buffId)
    if owner and  owner.buffViewMgr then
        -- print("SkillRecordReader HandleAddBuffRecord", uid, buffId)
        owner.buffViewMgr:AddBuff(uid, attackerId, buffId, star, lv, lay, remainRound, record.st)
    end
end
--处理移除buff相关的战报
function SkillRecordReader:HandleRemoveBuffRecord( record )
    local uid = record.id
    local owner = BattleViewMgr:FindRoleView(record.t)
    if owner and owner.buffViewMgr then
        -- print("SkillRecordReader HandleRemoveBuffRecord", uid)
        owner.buffViewMgr:RemoveBuff(uid)
    end
end

function SkillRecordReader:HandleChangeBuffRecord( record )
    local uid = record.id
    local owner = BattleViewMgr:FindRoleView(record.t)
    local lay = record.l
    local remainRound = record.rr
    if owner and owner.buffViewMgr then
        owner.buffViewMgr:ChangeBuff(uid, lay, remainRound)
    end
end

--@actionVo [Game.Setting.Vo.ActionVo#ActionVo]
function SkillRecordReader:DoBlur( actionVo )
    if actionVo.useMotionBlur then
        local blur = BattleViewMgr.blur
        coroutine.yield( WaitForSeconds( actionVo.motionBlur[1] * AnimFrameTime ) )
        --开始
        blur.enabled = true
        BattleViewMgr:ResetCameraRadiaBlur()
        coroutine.yield( WaitForSeconds( (actionVo.motionBlur[2] - actionVo.motionBlur[1]) * AnimFrameTime ) )
        local time = 0.2
        local spd = blur.Level / time
        local dt = AnimFrameTime
        while blur.Level > 1 do
            blur.Level = math.floor( math.max(1, blur.Level - spd * dt) )
            coroutine.yield( WaitForSeconds( AnimFrameTime ) )
        end
        blur.enabled = false
    end
    self.motionBlurCo = nil
end

--@actionVo [Game.Setting.Vo.ActionVo#ActionVo]
function SkillRecordReader:DoSpeedLine( actionVo )
    if actionVo.useSpeedLine then
        coroutine.yield( WaitForSeconds( actionVo.speedLine[1] * AnimFrameTime ) )
        --开始
        BattleViewMgr.speedLine:SetActive(true)
        coroutine.yield( WaitForSeconds( (actionVo.speedLine[2] - actionVo.speedLine[1]) * AnimFrameTime ) )
        BattleViewMgr.speedLine:SetActive(false)
    end
    self.speedLineCo = nil
end

function SkillRecordReader:DoFinalDamage(attacker, isMelee)
    UIBattlingCtrlMgr:GetInstance():HideBattleUI() -- 隐藏战斗UI
    coroutine.yield(WaitForSecondsRealtime(0.01667 * 4)) -- 等跳字跳出来
    -- coroutine.yield( WaitForSecondsRealtime(0.016 * 5) )    -- 暴击的时候多等一小会儿，防止暴击特效遮挡UI文字
    -- 传输一下最后的伤害者
    if attacker then
        if attacker.isSummonCreep then
        else
            UIBattlingCtrlMgr:GetInstance():SetDamagingCharactorBattleFieldId(attacker.id)
        end
    end

    BattleViewMgr:ChangeGameSpeed(0, true)
    -- 如果是近战最后一击，会有一个推镜
    local vcam, vcamFocalLength, targetFocalLength
    local SkillCameraMgr = CS.Game.Native.Battle.BattleSkillCameraMgr.Instance
    local CMDollyTrack = SkillCameraMgr:GetNowFollowCamera()
    if not isNull(CMDollyTrack) then
        vcam = CMDollyTrack.FollowCamera
        local vcamLens = vcam.m_Lens
        vcamFocalLength = CameraExtensions.FieldOfViewToFocalLength(vcamLens.FieldOfView, vcamLens.SensorSize.y)
        targetFocalLength = 60
    end

    -- 角色技能音效音量渐弱
    local hasPushLens = isMelee and isNotNull(vcam)
    self.lerpAudioCo = BattleViewMgr:LerpAllRoleAudioVolume(0.4, hasPushLens and 0.3 or 0.15)

    -- 推镜
    if hasPushLens then
        BattleViewMgr:VCamPushLens(vcam, vcamFocalLength, targetFocalLength, 0.15)
    end

    -- 径向模糊配合尾刀UI动画节奏
    coroutine.yield(BattleViewMgr:LerpRadialBlur({
        innerRadiusFrom = 1,
        innerRadiusTo = 0.85,
        outerRadiusFrom = 1,
        outerRadiusTo = 0.8,
        bufferRadiusFrom = 0,
        bufferRadiusTo = 0.35
    }, 0.15))

    -- 这里暂停角色技能音效
    BattleViewMgr:PauseAllRoleAudio()

    -- 开始尾刀UI展示
    Events.Broadcast(Constants.EventNames.BattleFinalDamageShow)
    coroutine.yield(WaitForSecondsRealtime(1))
    coroutine.yield(BattleViewMgr:LerpRadialBlur({
        innerRadiusFrom = 0.85,
        innerRadiusTo = 1,
        outerRadiusFrom = 0.8,
        outerRadiusTo = 1,
        bufferRadiusFrom = 0.35,
        bufferRadiusTo = 0
    }, 0.45))
    -- coroutine.yield( WaitForSecondsRealtime(0.15) )
    -- coroutine.yield( WaitForSecondsRealtime(1.5) )
    BattleViewMgr:RemoveRadialBlur()
    -- 尾刀UI结束
    BattleViewMgr:ChangeGameSpeed(1)

    -- 这里继续角色技能音效
    BattleViewMgr:ResumeAllRoleAudio()
    BattleViewMgr:SetAllRoleAudioVolume(1)
    -- 角色技能音效音量渐强
    -- self.lerpAudioCo = BattleViewMgr:LerpAllRoleAudioVolume(1, 0.4)

    -- 拉镜
    if hasPushLens then
        BattleViewMgr:VCamPushLens(vcam, targetFocalLength, vcamFocalLength, 0.4)
    end
end

function SkillRecordReader:ChangeRoleQuilty(quality)
    local ccd = BattleViewMgr.camera.gameObject:GetComponent(typeof(CS.CameraCustomData))
    if not isNull(ccd) then
        ccd.Role = quality
    end
end

--- 提取RoleRemove战报
---@param skillRecord any
function SkillRecordReader:ExtractRoleRemoveRecord(skillRecord)
    local roleRemoveRecords = {}
    local subs = {}
    table.link(subs, skillRecord.subs)
    while #subs > 0 do
        local record = table.remove(subs)
        if record.r == Constants.RecordType.RoleRemove then
            table.insert(roleRemoveRecords, record)
            table.removebyvalue(record.parent.subs, record) -- 从parent里面移除
        end
        if record.subs and #record.subs > 0 then
            for i, r in ipairs(record.subs) do
                r.parent = record   -- 记录parent
                table.insert(subs, r)
            end
        end
    end
    -- print("提取RoleRemove战报", table.dump(roleRemoveRecords, nil, 3))

    return roleRemoveRecords
end

---检测是否需要播放角色死亡语音, 多角色同时死亡时随机一位播放
function SkillRecordReader:CheckCardDeathVoice(roleRemoveRecords)
    local t = {}
    for _, record in ipairs(checkTable(roleRemoveRecords)) do
        local role = BattleViewMgr:FindRoleView(record.id)
        if role.isPlayer then
            table.insert(t, role)
        end
    end
    if #t == 0 then return end
    
    -- print("131",table.dump(t))
    local role = t[math.random(1, #t)]
    RoleVoiceMgr:PlayBattleRoleDeathVoiceByCardId(role.typeId, nil, role.skinId)
end

function SkillRecordReader:Reset(  )
    if self.speedLineCo then
        cs_coroutine.stop(self.speedLineCo)
        self.speedLineCo = nil
    end
    if self.motionBlurCo then
        cs_coroutine.stop(self.motionBlurCo)
        self.motionBlurCo = nil
    end

    if self.resetIdleCo then
        cs_coroutine.stop(self.resetIdleCo)
        self.resetIdleCo = nil
    end

    if self.lerpAudioCo then
        cs_coroutine.stop(self.lerpAudioCo)
        self.lerpAudioCo = nil
    end
    
    -- self:ChangeRoleQuilty(CS.CameraCustomData.RoleSettingEnum.LowQuality)

    -- NormalMelee:Clear()
    -- NormalBuff:Clear()
    -- NormalShot:Clear()
    -- NormalUltra:Clear()
    TimelineUltra:Clear()
    NormalSkill:Clear()
    -- SpecialShot:Clear()
end

return  SkillRecordReader
