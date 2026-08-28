--
-- Author:luqucheng
-- Date: 2019-12-10 10:49:53
--


local settingMgr = SettingMgr:GetInstance()
local gameUtils = CS.GameUtils
local KTool = CS.Engine.Lib.KTool
local util = require "XLua.util"
local WaitForEndOfFrame = CS.UnityEngine.WaitForEndOfFrame
local WaitForSeconds = CS.UnityEngine.WaitForSeconds

local NormalMelee = {}

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
function NormalMelee:Show(record, skillViewVo, actionVo, target, attacker, star, onHit)
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
    
    --@RefType [Frame.UnityEngine.Vector3#Vector3]
    local targetPos = nil

    if skillViewVo.isAoe then
        targetPos = attacker.camp == Constants.TargetCamp.Friend and BattleViewMgr.sceneVo.enemyAoe or BattleViewMgr.sceneVo.teamAoe
    else
        -- local forword = target.modelVo.hitPos:Clone():Sub(target.transform.position)
        -- local q = Quaternion.Euler(forword.x, forword.y, forword.z)
        -- local rq = target.transform.localRotation
        -- local q = Quaternion.New(rq.x, rq.y, rq.z, rq.w)
        -- local offset = Quaternion.MulVec3(target.transform.localRotation, target.modelVo.hitPos)
        -- targetPos = offset:Add(target.transform.position)
        targetPos = target:GetOffsetPosition(target.modelVo.hitPos)
    end
    targetPos.y = 0

    --根据朝向和attackerpos计算真实目标点
    local tp = Tools.getGroundVector3(target.transform.localPosition)
    local ap = Tools.getGroundVector3(attacker.transform.localPosition)
    local offset = Tools.rotateVector3(  tp:Sub(ap), actionVo.attackPos)
    -- local offset = targetPos


    --播放动画
    attacker:PlayAnimation(actionVo.actionName)
    --播放所有攻击特效
    for i,v in ipairs(skillViewVo.attackFXs) do
        BattleViewMgr.FXMgr:PlayFX(v, attacker.fxNode, 1)
    end
    

    --先做准备运动
    coroutine.yield( WaitForSeconds(actionVo.forwardStart * AnimFrameTime) )
    
    --移动过去
    --移动到attackpos和hitpos的重合点
    local t = (actionVo.forwardEnd - actionVo.forwardStart) * AnimFrameTime
    attacker.transform:DOMove( targetPos:Clone():Sub(offset), t )
    attacker.transform:DOLookAt( target.transform.position, t )

    --冲刺开始时播放冲刺音效
    -- BattleViewMgr:PlaySFX(skillViewVo.dashSFX, attacker)

    coroutine.yield( WaitForSeconds(t) )

    local targets = RecordReader.SkillRecordReader:GetSkillTargets(record)

    --判定打击点
    local nowF = actionVo.forwardEnd
    for i,v in ipairs(actionVo.hits) do
        local t = (v.frame - nowF) * AnimFrameTime
        coroutine.yield( WaitForSeconds(t) )
        nowF = v.frame
        coroutine.yield(onHit(i, actionVo))
        for p,tt in ipairs(targets) do
            --播放受击特效
            if v.hurt then
                BattleViewMgr.FXMgr:PlayFX(skillViewVo.hitFX, tt.fxNode)
            end

        end
        if skillViewVo.isAoe and v.hurt then
            BattleViewMgr.FXMgr:PlayFX(skillViewVo.aoeHitFX, BattleViewMgr:GetAoe(target.camp))
        end
    end

    coroutine.yield( WaitForSeconds( (actionVo.returnStart - nowF) * AnimFrameTime ) )


    --移动回来
    local t = (actionVo.returnEnd - actionVo.returnStart) * AnimFrameTime
    attacker.transform:DOMove( attacker.defaultStand.position, t )
    -- .OnComplete(
    --     function (  )
    --         attacker:SyncStand()
    --     end
    -- )
    -- attacker.transform:DOLocalRotate( attacker.defaultStand.rotation, t )
    
    coroutine.yield( WaitForSeconds(t) )
   
    local t = (actionVo.frame - actionVo.returnEnd) * AnimFrameTime
    -- attacker:SyncStand()
    -- if needFollowBone then
    --     self.updateCameraAttach = nil
    --     KTool.ResetTransform(attacker.cameraAttach)
    -- end
    
    coroutine.yield( WaitForSeconds(t) )
end

function NormalMelee:Clear(  )

end


return  NormalMelee