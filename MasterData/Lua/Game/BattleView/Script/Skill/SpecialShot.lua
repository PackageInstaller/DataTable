--
-- Author:luqucheng
-- Date: 2019-12-10 10:49:53
--


local settingMgr = SettingMgr:GetInstance()
local gameUtils = CS.GameUtils
local KTool = CS.Engine.Lib.KTool
local util = require "XLua.util"
local cs_coroutine = import('XLua.cs_coroutine')
local WaitForEndOfFrame = CS.UnityEngine.WaitForEndOfFrame
local WaitForSeconds = CS.UnityEngine.WaitForSeconds

local SpecialShot = {}

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
function SpecialShot:Show(record, skillViewVo, actionVo, target, attacker, star, onHit)
    --找到移动点，如果是aoe，移动点就是aoe点，如果是单体，则移动到主目标hitpos点

    local targets = RecordReader.SkillRecordReader:GetSkillTargets(record)


    --@RefType [Frame.UnityEngine.Vector3#Vector3]
    local targetPos = nil

    if skillViewVo.isAoe then
        targetPos = attacker.camp == Constants.TargetCamp.Friend and BattleViewMgr.sceneVo.enemyAoe or BattleViewMgr.sceneVo.teamAoe
    else
        -- local forword = target.modelVo.hitPos:Clone():Sub(target.transform.position)
        -- local q = Quaternion.Euler(forword.x, forword.y, forword.z)
        -- local rq = target.transform.localRotation
        -- local q = Quaternion.New(rq.x, rq.y, rq.z, rq.w)
        targetPos = target.transform.position
    end

    --播放动画
    attacker:PlayAnimation(actionVo.actionName)
    for i,v in ipairs(skillViewVo.attackFXs) do
        BattleViewMgr.FXMgr:PlayFXOnRole(v, attacker)
    end

    -- --先做准备运动
    -- coroutine.yield( WaitForSeconds(actionVo.forwardStart * AnimFrameTime) )

    -- --移动过去
    -- --移动到attackpos和hitpos的重合点
    -- local t = (actionVo.forwardEnd - actionVo.forwardStart) * AnimFrameTime
    -- coroutine.yield( WaitForSeconds(t) )

    --判定打击点
    local nowF = 0
    for i,v in ipairs(actionVo.hits) do
        local t = (v.frame - nowF) * AnimFrameTime
        coroutine.yield( WaitForSeconds(t) )
        nowF = v.frame
        onHit(i, actionVo)
        for p,tt in ipairs(targets) do
            --播放受击特效
            if v.hurt then
                BattleViewMgr.FXMgr:PlayFXOnRole(skillViewVo.hitFX, tt)
            end
        end
        if skillViewVo.isAoe and v.hurt then
            BattleViewMgr.FXMgr:PlayFX(skillViewVo.aoeHitFX, BattleViewMgr:GetAoe(target.camp))
        end
    end

    local t = (actionVo.frame - nowF) * AnimFrameTime
    -- attacker.transform:DOLocalRotate( attacker.defaultStand.rotation, t )
    coroutine.yield( WaitForSeconds(t) )
    -- attacker:SyncStand()

    coroutine.yield( WaitForEndOfFrame() )
end

function SpecialShot:Clear(  )

end

return  SpecialShot