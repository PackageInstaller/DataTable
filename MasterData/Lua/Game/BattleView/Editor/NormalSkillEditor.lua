--[[
    author:luqucheng
    time:2022-06-20 10:26:13
]]
local settingMgr = SettingMgr:GetInstance()

local GameObject = CS.UnityEngine.GameObject
local KTool = CS.Engine.Lib.KTool
local PlayableDirector = CS.UnityEngine.Playables.PlayableDirector
local TimelineAsset = CS.UnityEngine.Timeline.TimelineAsset
local AnimationTrack = CS.UnityEngine.Timeline.AnimationTrack
local AnimationPlayableAsset = CS.UnityEngine.Timeline.AnimationPlayableAsset
local BattleSimulatorTool = CS.BattleTools.BattleSimulatorTool
local MonoHelper = CS.Engine.Lib.MonoHelper
local TransformTweenTrack = CS.TransformTweenTrack
local TimeDilationTrack = CS.TimeDilationTrack
local ControlTrack = CS.UnityEngine.Timeline.ControlTrack
local NormalSkill = import('Game.BattleView.Script.Skill.NormalSkill')
local ResourceModule = CS.Engine.Modules.ResourceModule

local NormalSkillEditor = {}

NormalSkillEditor.playableDirector = nil

function NormalSkillEditor:CreateByEditor(attackerPos, attackerCamp, targetPos, targetCamp, skillIndex)
    local a = BattleMgr:FindRoleByCampAndPos(attackerCamp, attackerPos)
    if not a then
        return
    end
    local attacker = BattleViewMgr:FindRoleView(a.id)
    if not attacker then
        return
    end

    local t = BattleMgr:FindRoleByCampAndPos(targetCamp, targetPos)
    if not t then
        return
    end
    local target = BattleViewMgr:FindRoleView(t.id)
    if not target then
        return
    end

    self:CreateSkillTimeline(attacker, target, skillIndex)
end

function NormalSkillEditor:Clear()
    for i,roleView in ipairs(BattleViewMgr.roleViews) do
        if roleView.animatorController then
            roleView.animator.runtimeAnimatorController = roleView.animatorController
        end
    end
    if not isNull(self.timeline) then
        CS.UnityEngine.GameObject.DestroyImmediate(self.timeline)
    end
end

--@attacker: [Game.BattleView.Entity.RoleView#RoleView]
--@target: [Game.BattleView.Entity.RoleView#RoleView]
function NormalSkillEditor:CreateSkillTimeline(attacker, target, skillIndex)
    self:Clear()

    local skillViewId = attacker:GetSkillShowId(skillIndex)
    --判断技能类型，普通，大招
    local setting = settingMgr:GetSetting(AutoIds.IdSetting272, "SkillViewVo")
    --@RefType [Game.Setting.Vo.SkillViewVo#SkillViewVo]
    local skillViewVo = setting:Get(skillViewId)
    local actionVo = self:GetActionVoBySkillIndex(attacker, skillIndex)
    if isNull(attacker.animatorController) then
        attacker.animatorController = attacker.animator.runtimeAnimatorController
    else
        attacker.animator.runtimeAnimatorController = attacker.animatorController
    end
    if isNull(target.animatorController) then
        target.animatorController = target.animator.runtimeAnimatorController
    else
        target.animator.runtimeAnimatorController = target.animatorController
    end

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

    local timeline = GameObject("timeline")

    self.timeline = timeline
    local playableDirector = KTool.GetOrAddComponent(timeline, typeof(PlayableDirector))
    local asset = TimelineAsset.CreateInstance(typeof(TimelineAsset))
    playableDirector.playableAsset = asset

    asset.editorSettings.frameRate = 30

    local totalFrame = actionVo.frame
    local totalTime = totalFrame * AnimFrameTime

    --攻击动作
    local attackerTrack = asset:CreateTrack(typeof(AnimationTrack), nil, "attacker")
    playableDirector:SetGenericBinding(attackerTrack, attacker.gameObject)
    local attackerClip = BattleSimulatorTool.CreateClipWithAnimationPlayableAsset(attackerTrack)
    attackerClip.asset.clip = self:GetClip(attacker, actionVo.actionName)
    attackerClip.duration = totalTime

    --攻击特效
    for i,v in ipairs(skillViewVo.attackFXs) do
        self:PlayRoleFX(asset, v, attacker)
    end
    if not Tools.isNullKey(skillViewVo.aimAoeFX) then
        self:PlayFX(asset, skillViewVo.aimAoeFX, BattleViewMgr:GetAoe(target.camp))
    end

    self:PlayRoleFX(asset, skillViewVo.aimFX, target)


    --移动
    if actionVo.forwardStart > 0 then
        local moveTrack = asset:CreateTrack(typeof(TransformTweenTrack), nil, "attacker move")
        playableDirector:SetGenericBinding(moveTrack, attacker.transform)
        local moveTarget = GameObject()
        moveTarget.name = "move target"
        moveTarget.transform:SetParent(timeline.transform)
        moveTarget.transform.position = NormalSkill.GetMoveTargetPos(attacker, target, skillViewVo, actionVo)


        local moveInClip = BattleSimulatorTool.CreateClipWithTransformTweenClip(moveTrack)
        moveInClip.asset.startLocation = BattleSimulatorTool.GetExposedReferenceTransform(attacker.defaultNode)
        moveInClip.asset.endLocation = BattleSimulatorTool.GetExposedReferenceTransform( moveTarget.transform)
        moveInClip.start = actionVo.forwardStart * AnimFrameTime
        moveInClip.duration = (actionVo.forwardEnd - actionVo.forwardStart) * AnimFrameTime
        moveInClip.asset.template.tweenRotation = false
       

        local moveOutClip = BattleSimulatorTool.CreateClipWithTransformTweenClip(moveTrack)
        moveOutClip.asset.startLocation = BattleSimulatorTool.GetExposedReferenceTransform( moveTarget.transform)
        moveOutClip.asset.endLocation = BattleSimulatorTool.GetExposedReferenceTransform(attacker.defaultNode)
        moveOutClip.start = actionVo.returnStart * AnimFrameTime
        moveOutClip.duration = (actionVo.returnEnd - actionVo.returnStart) * AnimFrameTime
        moveOutClip.asset.template.tweenRotation = false
    end

    --子弹
    if #actionVo.bulletFrames > 0 then
        local f = 0
        for i,v in ipairs(actionVo.bulletFrames) do
            --获取当前hit的目标
            --释放子弹
            local index = i > #skillViewVo.projectileIds and #skillViewVo.projectileIds or i
            local projectileId = skillViewVo.projectileIds[index]
            local script, bulletVo = Core:GetProjectile(projectileId)

            local start = v * AnimFrameTime
            local duration = bulletVo.frame * AnimFrameTime

            attacker.animator:Play(actionVo.actionName, 0, start / totalTime)
            attacker:SyncAnimation()

            local projectile = GameObject("bullet"..i)
            projectile.transform:SetParent(timeline.transform)
            self:PlayFX(asset, bulletVo.FX, projectile, start, duration)

            local moveTrack = asset:CreateTrack(typeof(TransformTweenTrack), nil, "bullet move"..i)
            playableDirector:SetGenericBinding(moveTrack, projectile.transform)
            local bulletFrom = GameObject()
            bulletFrom.name = "bullet from"
            bulletFrom.transform:SetParent(timeline.transform)
            bulletFrom.transform.position = attacker:GetShotPosition()

            local bulletTo = GameObject()
            bulletTo.name = "bullet to"
            bulletTo.transform:SetParent(timeline.transform)
            bulletTo.transform.position = self:GetProjectileTargetPosition(bulletVo, attacker, target)
    
            local moveInClip = BattleSimulatorTool.CreateClipWithTransformTweenClip(moveTrack)
            moveInClip.asset.startLocation = BattleSimulatorTool.GetExposedReferenceTransform(bulletFrom.transform)
            moveInClip.asset.endLocation = BattleSimulatorTool.GetExposedReferenceTransform(bulletTo.transform)
            moveInClip.start = start
            moveInClip.duration = duration
            moveInClip.asset.template.tweenRotation = false

            --强行清除z轴旋转
            projectile.transform.position = bulletFrom.transform.position
            projectile.transform:LookAt( bulletTo.transform.position )
        end
    end

    if target then
        local timeTrack = asset:CreateTrack(typeof(TimeDilationTrack), nil, "time")
       
        local speed = Core:GetBattleParamNum("hitPauseTimeScale")
        if speed <= 0 then
            speed = 0.1
        end

        --受击
        local targetTrack = asset:CreateTrack(typeof(AnimationTrack), nil, "target")
        playableDirector:SetGenericBinding(targetTrack, target.gameObject)
        local isFloating = false
        for i,v in ipairs(actionVo.hits) do
            local nextFrame = actionVo.hits[i + 1] and actionVo.hits[i + 1].frame or 999999
            local targetClip = BattleSimulatorTool.CreateClipWithAnimationPlayableAsset(targetTrack)
            local hitType = v.hitType
            local clip = nil
            if hitType == Constants.HitType.Normal and isFloating then
                clip = self:GetClip(target, "float_hit")
            elseif hitType == Constants.HitType.Float then
                if not target:CanFloat() then
                    clip = self:GetClip(target, "attack_hit")
                else
                    clip = self:GetClip(target, "float_up")
                    isFloating = true
                end
            elseif hitType == Constants.HitType.Normal then
                clip = self:GetClip(target, "attack_hit")
            elseif hitType == Constants.HitType.Left then
                clip = self:GetClip(target, "left_hit")
            elseif hitType == Constants.HitType.Right then
                clip = self:GetClip(target, "right_hit")
            elseif hitType == Constants.HitType.Tiny then
                clip = self:GetClip(target, "small_hit")
            elseif hitType == Constants.HitType.Heavy then
                clip = self:GetClip(target, "heavy_hit")
            elseif hitType == Constants.HitType.Down then
                clip = self:GetClip(target, "down_hit")
            end
            targetClip.asset.clip = clip
            targetClip.duration = math.min( (nextFrame - v.frame) * AnimFrameTime, clip.length) 
            targetClip.start = v.frame * AnimFrameTime

            

            if skillViewVo.isAoe then
                local aoeEffectName = skillViewVo.aoeHitFX[i] or skillViewVo.aoeHitFX[#skillViewVo.aoeHitFX]
                self:PlayFX(asset, aoeEffectName, BattleViewMgr:GetAoe(target.camp), v.frame * AnimFrameTime)
                print("aoeEffectName", aoeEffectName)
            end
            local effectName = skillViewVo.hitFX[i] or skillViewVo.hitFX[#skillViewVo.hitFX]
            self:PlayRoleFX(asset, effectName, target, v.frame * AnimFrameTime)

            if not Tools.isNullKey(v.hitPause) then
                local timeClip = BattleSimulatorTool.CreateClipWithTimeDilationClip(timeTrack)
                local time = Core:GetBattleParamNum("hitPauseTime", true)[v.hitPause] or 0
                timeClip.asset.template.timeScale = speed
                timeClip.start = (v.frame + 2) * AnimFrameTime
                timeClip.duration = time * speed
            end
        end
        
        target.animator.runtimeAnimatorController = nil
    end

    playableDirector.playOnAwake = false
    -- playableDirector.duration = totalTime

    self.playableDirector = playableDirector

    -- if isNull(self.__lateUpdateHandle)  then
    --     self.__lateUpdateHandle = Bind(self, self.LateUpdate)
    --     MonoHelper.AddLateUpdateListener(self.__lateUpdateHandle)
    -- end
   
    
    -- if self.__lateUpdateHandle then
    --     MonoHelper.RemoveLateUpdateListener(self.__lateUpdateHandle)
    --     self.__lateUpdateHandle = nil
    -- end
    attacker.animator.runtimeAnimatorController = nil
end

function NormalSkillEditor:GetMoveTargetPos(attacker, target, skillViewVo, actionVo)
    --@RefType [Frame.UnityEngine.Vector3#Vector3]
    local targetPos = nil
    local offset = nil

    if skillViewVo.isAoe then
        targetPos = attacker.camp == Constants.Camp.One and BattleViewMgr.sceneVo.enemyAoe or BattleViewMgr.sceneVo.teamAoe
        local tp = Tools.getGroundVector3(targetPos)
        local ap = Tools.getGroundVector3(attacker.transform.localPosition)
        offset = Tools.rotateVector3(  tp:Sub(ap), actionVo.attackPos)
    else
        targetPos = target:GetOffsetPosition(target.modelVo.hitPos)
        targetPos.y = 0
         --根据朝向和attackerpos计算真实目标点
        local tp = Tools.getGroundVector3(target.transform.localPosition)
        local ap = Tools.getGroundVector3(attacker.transform.localPosition)
        offset = Tools.rotateVector3(  tp:Sub(ap), actionVo.attackPos)
    end

    return targetPos:Clone():Sub(offset)
end

function NormalSkillEditor:PlayFX(asset, fxId, node, start, duration)
    start = start or 0
    --@RefType [Game.Setting.Vo.FXResVo#FXResVo]
    local fxVo = BattleViewMgr.FXMgr:GetFxVo(fxId)
    if not fxVo then
        return
    end
    local poolName = CS.GameUtils.GetEffectFullPath(fxVo.resourcesId)
    local loader = ResourceModule.LoadBundleSync(poolName, nil, true)--"Timeline/Timeline.prefab"
    if not loader.IsError then
        local controlTrack = asset:CreateTrack(typeof(ControlTrack), nil, poolName)
        local controlClip = BattleSimulatorTool.CreateClipWithControlPlayable(controlTrack)
        controlClip.start = start
        controlClip.duration = duration or fxVo.fxTime
        controlClip.asset.prefabGameObject = loader.ResultObject
        controlClip.asset.searchHierarchy = true
      
        controlClip.asset.sourceGameObject = BattleSimulatorTool.GetExposedReferenceGameObject(node)
    end
end

function NormalSkillEditor:PlayRoleFX(asset, fxId, role, start, duration)
    local fxVo = BattleViewMgr.FXMgr:GetFxVo(fxId)
    if not fxVo then
        return
    end
    if fxVo.fxType == Constants.FXType.Bone then
        local bone = role.gameObject:FindGameObjectByName(fxVo.bonesName[1])
        if bone then
            self:PlayFX(asset, fxId, bone.gameObject, start, duration)
        end
    else
        self:PlayFX(asset, fxId, role.fxNode.gameObject, start, duration)
    end
end

function NormalSkillEditor:GetProjectileTargetPosition(bulletVo, attacker, target)
    local offset = Quaternion.MulVec3(attacker.transform.localRotation, bulletVo.targetOffsetPos)
    local hitOffset = Quaternion.MulVec3(target.transform.localRotation, target.modelVo.bulletHitPos)
    offset:Add(hitOffset)
    offset:Add(target.transform.position)
    return offset
end
-- function NormalSkillEditor:LateUpdate()
--     if isNull(self.playableDirector) then
--         return
--     end

--     self.playableDirector:Evaluate()
-- end

function NormalSkillEditor:GetClip(role, clipName)
    print("NormalSkillEditor:GetClip", clipName, role.animatorController, role.animator.runtimeAnimatorController)
    local animatorController = role.animatorController or role.animator.runtimeAnimatorController
    if animatorController then
        local clips = animatorController.animationClips;
        local len = clips.Length
        for i=0,len-1 do
            local clip = clips[i]
            if not isNull(clip) and clipName == clip.name then
                return clip
            end
        end
    end
end

--@return [Game.Setting.Vo.ActionVo#ActionVo]
function NormalSkillEditor:GetActionVoBySkillIndex(attacker, skillIndex)
    local skillViewId = attacker:GetSkillShowId(skillIndex)
    --判断技能类型，普通，大招
    local setting = settingMgr:GetSetting(AutoIds.IdSetting272, "SkillViewVo")
    --@RefType [Game.Setting.Vo.SkillViewVo#SkillViewVo]
    local skillViewVo = setting:Get(skillViewId)
    -- print("[GetPerformTime]", skillViewId, table.toString(record, 'record'))
    assert(skillViewVo, "找不到技能表现的配置 id:"..skillViewId .. " 序号:"..skillIndex)

    --读取动画数据
    local setting = settingMgr:GetSetting(AutoIds.IdSetting271, "ActionVo")
    --@RefType [Game.Setting.Vo.ActionVo#ActionVo]
    local actionVo = setting:Get(skillViewVo.actionId)
    assert(actionVo, "找不到动作的配置 id:"..skillViewVo.actionId .. "  skillId:"..skillViewVo.id)

    return actionVo
end

return NormalSkillEditor