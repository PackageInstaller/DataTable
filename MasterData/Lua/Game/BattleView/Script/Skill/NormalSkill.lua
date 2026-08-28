--[[
    author:luqucheng
    time:2020-09-23 11:28:08
]]

local settingMgr = SettingMgr:GetInstance()
local cs_coroutine = import('XLua.cs_coroutine')
local gameUtils = CS.GameUtils
local KTool = CS.Engine.Lib.KTool
local util = require "XLua.util"
local WaitForEndOfFrame = CS.UnityEngine.WaitForEndOfFrame
local WaitForSeconds = CS.UnityEngine.WaitForSeconds

local NormalSkill = {}
--[[
    @desc: 
    author:luqucheng
    time:2019-12-10 11:10:14
    --@record:
	--@skillViewVo:[Game.Setting.Vo.SkillViewVo#SkillViewVo]
	--@target:[Game.BattleView.Entity.RoleView#RoleView]
	--@attacker:[Game.BattleView.Entity.RoleView#RoleView]
	--@star: 
    @return:
]]
function NormalSkill:Show(record, skillViewVo, actionVo, target, attacker, star, onHit, isFinishSkill)

    --找到移动点，如果是aoe，移动点就是aoe点，如果是单体，则移动到主目标hitpos点

    --3星的镜头需要能绑定骨骼来移动相机
    -- local needFollowBone = attacker.rootBone and star >= 3
    -- self.updateCameraAttach = nil
    -- if needFollowBone then
    --     local rootBone = attacker.rootBone
    --     local initPos = rootBone.localPosition
    --     self.updateCameraAttach = function ()
    --         local nowPos = rootBone.localPosition
    --         attacker.cameraAttach.localPosition = Vector3.New(nowPos.x - initPos.x, nowPos.y - initPos.y, nowPos.z - initPos.z)
    --     end

    -- end
    local targets = RecordReader.SkillRecordReader:GetSkillTargets(record)
    
    

    

   
    -- local offset = targetPos


    --播放动画
    -- local info = attacker.animator:GetCurrentAnimatorStateInfo(0)
    -- if info:IsName(actionVo.actionName) then
    --     -- attacker:PlayAnimation("idle", true, 1)
    --     -- coroutine.yield( )
    --     -- attacker:PlayAnimation(actionVo.actionName, true)--相同动画切换不做过渡

    --     attacker.animator:CrossFadeInFixedTime(actionVo.actionName, 0.15, 0)
    -- else
    --     attacker:PlayAnimation(actionVo.actionName, true)
    -- end
    attacker:PlayAnimation(actionVo.actionName, true)
    attacker:SyncAnimation()
    --播放所有攻击特效
    for i,v in ipairs(skillViewVo.attackFXs) do
        BattleViewMgr.FXMgr:PlayFXOnRole(v, attacker)
    end

    if not Tools.isNullKey(skillViewVo.aimAoeFX) then
        BattleViewMgr.FXMgr:PlayFX(skillViewVo.aimAoeFX, BattleViewMgr:GetAoe(target.camp), 1)
    end

    --所有目标都释放瞄准特效
    for i,v in ipairs(targets) do
        BattleViewMgr.FXMgr:PlayFXOnRole(skillViewVo.aimFX, v)
    end
    
    if actionVo.forwardStart > 0 and target.id ~= attacker.id then
        local moveCoId = nil
        --移动
        local moveCo = cs_coroutine.start(
            function (  )
                --@RefType [Frame.UnityEngine.Vector3#Vector3]
                local targetPos = self.GetMoveTargetPos(attacker, target, skillViewVo, actionVo)
                --先做准备运动
                coroutine.yield( WaitForSeconds(actionVo.forwardStart * AnimFrameTime) )
                --移动过去
                --移动到attackpos和hitpos的重合点
                local t = (actionVo.forwardEnd - actionVo.forwardStart) * AnimFrameTime
                attacker.transform:DOMove( targetPos, t )
                -- attacker.transform:DOLookAt( target.transform.position, t )
                --冲刺开始时播放冲刺音效
                -- BattleViewMgr:PlaySFX(skillViewVo.dashSFX, attacker)
                coroutine.yield( WaitForSeconds(t) )
                coroutine.yield( WaitForSeconds( (actionVo.returnStart - actionVo.forwardEnd) * AnimFrameTime ) )
                --移动回来
                local t = (actionVo.returnEnd - actionVo.returnStart) * AnimFrameTime
                attacker.transform:DOMove( attacker.defaultStand.position, t )
                coroutine.yield( WaitForSeconds(t) )
                local t = (actionVo.frame - actionVo.returnEnd) * AnimFrameTime
                coroutine.yield( WaitForSeconds(t) )

                CoManager:RemoveCoById(moveCoId)
                attacker:RemovePerformCo(moveCoId)
            end
        )
        moveCoId = CoManager:AddCo(moveCo)
        attacker:AddPerformCo(moveCoId)
    end

    local shoot = function ( i, target )
        --释放子弹
        local projectileCoId = nil
        local index = i > #skillViewVo.projectileIds and #skillViewVo.projectileIds or i
        local projectileId = skillViewVo.projectileIds[index]
        local script, bulletVo = Core:GetProjectile(projectileId)
        local projectile = script.New(bulletVo, target, attacker, function ( proj )
        end, skillViewVo.isAoe, i ~= 1--第一颗子弹不随机位置
        )
        local co = cs_coroutine.start(function (  )
            coroutine.yield( projectile:ShootProjectile() )
            CoManager:RemoveCoById(projectileCoId)
            attacker:RemovePerformCo(projectileCoId)
        end)
        --把发射子弹的id当做tag
        projectileCoId = CoManager:AddCo(co)
        attacker:AddPerformCo(projectileCoId)
    end

    if #actionVo.bulletFrames > 0 then
        local shootCoId = nil
        --子弹
        local shootCo = cs_coroutine.start(function ()
            local f = 0
            for i,v in ipairs(actionVo.bulletFrames) do
                --获取当前hit的目标
                
                local t = (v - f) * AnimFrameTime
                coroutine.yield( WaitForSeconds(t) )
                f = v

                local ts = RecordReader.SkillRecordReader:GetSkillHitTargets(record, i)
                if skillViewVo.isAoe then
                    shoot(i, target)
                else
                    for j,role in ipairs(ts) do
                        shoot(i, role)
                    end
                end
                
            end
            CoManager:RemoveCoById(shootCoId)
            attacker:RemovePerformCo(shootCoId)
        end)
        shootCoId = CoManager:AddCo(shootCo)
        attacker:AddPerformCo(shootCoId)
    end

    local hitCoId = nil
    --命中
    local hitCo = cs_coroutine.start(function (  )
        --判定打击点
        local nowF = 0
        for i,v in ipairs(actionVo.hits) do
            local t = (v.frame - nowF) * AnimFrameTime
            -- print("wait", t, v.frame)
            coroutine.yield( WaitForSeconds(t) )
            nowF = v.frame
            cs_coroutine.start(function (  )
                onHit(i, actionVo)
            end)
            -- for p,tt in ipairs(targets) do
            --     --播放受击特效
            --     if v.hurt then
            --         local effectName = skillViewVo.hitFX[i] or skillViewVo.hitFX[#skillViewVo.hitFX]
            --         if skillViewVo.skillShowType == Constants.SkillShowType.Shot then
            --             BattleViewMgr.FXMgr:PlayFX(effectName, tt.fxNode, 1, target.modelVo.bulletHitPos)
            --         else
            --             BattleViewMgr.FXMgr:PlayFX(effectName, tt.fxNode)
            --         end
            --     end
            -- end
            if skillViewVo.isAoe then
                BattleViewMgr.FXMgr:PlayFX(skillViewVo.aoeHitFX[i] or skillViewVo.aoeHitFX[#skillViewVo.aoeHitFX], BattleViewMgr:GetAoe(target.camp))
            end

            if not (isFinishSkill and i >= #actionVo.hits) and not Tools.isNullKey(v.hitPause) and (star < 3 or not attacker:UseThreeStarCamera() ) then
                local pauseCoId = nil
                local pauseCo = cs_coroutine.start(function (  )
                    coroutine.yield()
                    coroutine.yield()

                    local speed = Core:GetBattleParamNum("hitPauseTimeScale")
                    if speed <= 0 then
                        speed = 0.1
                    end
                    local time = Core:GetBattleParamNum("hitPauseTime", true)[v.hitPause] or 0
                    BattleViewMgr:ChangeGameSpeed(speed, true)
                    coroutine.yield( WaitForSeconds(time * speed) )
                    BattleViewMgr:ChangeGameSpeed(BattleViewMgr.gameSpeed)
                    CoManager:RemoveCoById(pauseCoId)
                    attacker:RemovePerformCo(pauseCoId)
                end)
                pauseCoId = CoManager:AddCo(pauseCo)
                attacker:AddPerformCo(pauseCoId)
            end
            
        end
        CoManager:RemoveCoById(hitCoId)
        attacker:RemovePerformCo(hitCoId)
    end)
    hitCoId = CoManager:AddCo(hitCo)
    attacker:AddPerformCo(hitCoId)

    local beforeFrame = 2
    local time1 = (actionVo.frame - beforeFrame) * AnimFrameTime
    local time2 = beforeFrame * AnimFrameTime
    coroutine.yield( WaitForSeconds(time1) )
    -- 技能结束时触发切换动画状态机
    -- 提前两帧，防止时间计算不准，先进入到idle动画里面
    attacker:TrigSwitchAnimatorController(2, attacker.id)
    coroutine.yield( WaitForSeconds(time2) )
end


function NormalSkill.GetMoveTargetPos(attacker, target, skillViewVo, actionVo)
    --@RefType [Frame.UnityEngine.Vector3#Vector3]
    local targetPos = nil
    local offset = nil

    if skillViewVo.isAoe then
        targetPos = BattleInfo:IsUserCamp(attacker.camp) and BattleViewMgr.sceneVo.enemyAoe or BattleViewMgr.sceneVo.teamAoe
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

function NormalSkill:Clear(  )
end



return  NormalSkill