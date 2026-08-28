--
-- Author:luqucheng
-- Date: 2019-12-10 10:50:01
--
local settingMgr = SettingMgr:GetInstance()
local gameUtils = CS.GameUtils

local util = require "XLua.util"
local cs_coroutine = import('XLua.cs_coroutine')
local WaitForEndOfFrame = CS.UnityEngine.WaitForEndOfFrame
local WaitForSeconds = CS.UnityEngine.WaitForSeconds

local NormalShot = {}

NormalShot.projectiles = {}
NormalShot.shootCo = nil
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
function NormalShot:Show(record, skillViewVo, actionVo, target, attacker, star, onHit)
    --找到移动点，如果是aoe，移动点就是aoe点，如果是单体，则移动到主目标hitpos点
    -- attacker.transform:DOLookAt( target.transform.position, 0 )
    local targets = RecordReader.SkillRecordReader:GetSkillTargets(record)

    self.projectiles = {}
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
        BattleViewMgr.FXMgr:PlayFX(v, attacker.fxNode, 1)
    end

    -- --先做准备运动
    -- coroutine.yield( WaitForSeconds(actionVo.forwardStart * AnimFrameTime) )

    -- --移动过去
    -- --移动到attackpos和hitpos的重合点
    -- local t = (actionVo.forwardEnd - actionVo.forwardStart) * AnimFrameTime
    -- coroutine.yield( WaitForSeconds(t) )

    --判定打击点
    self.shootCo = cs_coroutine.start(function ()
        local f = 0
        for i,v in ipairs(actionVo.bulletFrames) do
            local t = (v - f) * AnimFrameTime
            coroutine.yield( WaitForSeconds(t) )
            f = v
            --释放子弹
            local index = i > #skillViewVo.projectileIds and #skillViewVo.projectileIds or i
            local projectileId = skillViewVo.projectileIds[index]
            local script, bulletVo = self:GetProjectile(projectileId)
            local projectile = script.New(bulletVo, skillViewVo, target, attacker, function ( proj )

                -- onHit(i, actionVo)

                -- --播放受击特效
                -- --骨骼子弹还是再受击点放
                -- if bulletVo.bulletType == Constants.BulletType.Back then
                --     BattleViewMgr.FXMgr:PlayFX(skillViewVo.hitFX, target.fxNode, 1, target.modelVo.bulletHitPos)
                -- else
                --     BattleViewMgr.FXMgr:PlayFX(skillViewVo.hitFX, nil, 1, proj.bulletObj.transform.position)
                -- end
                

                -- if skillViewVo.isAoe then
                --     BattleViewMgr.FXMgr:PlayFX(skillViewVo.aoeHitFX, BattleViewMgr:GetAoe(target.camp))
                -- end
            end, i ~= 1--第一颗子弹不随机位置
            )
            table.insert(self.projectiles, projectile)
            projectile.co = cs_coroutine.start( projectile.ShootProjectile, projectile )
        end
    end)
    
    local nowF = 0
    for i,v in ipairs(actionVo.hits) do
        local t = (v.frame - nowF) * AnimFrameTime
        coroutine.yield( WaitForSeconds(t) )
        nowF = v.frame
        onHit(i, actionVo)
        for p,tt in ipairs(targets) do
            --播放受击特效
            if v.hurt then
                BattleViewMgr.FXMgr:PlayFX(skillViewVo.hitFX, target.fxNode, 1, target.modelVo.bulletHitPos)
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

function NormalShot:GetProjectile( projectileId )
    -- print(projectileId)
    local setting = settingMgr:GetSetting(AutoIds.IdSetting275, "BulletVo")
    --@RefType [Game.Setting.Vo.BulletVo#BulletVo]
    local bulletVo = setting:Get(projectileId)
    -- print(projectileId, table.toString(bulletVo, "bulletVo"))
    assert(bulletVo, "找不到对应的子弹配置:"..projectileId)

    local switch = {
        [Constants.BulletType.OneWay] = function (  )
            return import('Game.BattleView.Script.Projectile.NormalOneWayProjectile'), bulletVo
        end,
        [Constants.BulletType.Back] = function (  )
            return import('Game.BattleView.Script.Projectile.NormalBackProjectile'), bulletVo
        end
    }
    return switch[bulletVo.bulletType]()
end

function NormalShot:Clear(  )
    if self.projectiles == nil then
        return
    end
    for i,v in ipairs(self.projectiles) do
        if v then
            v:Dipose()
        end
    end
    self.projectiles = {}
end

return  NormalShot