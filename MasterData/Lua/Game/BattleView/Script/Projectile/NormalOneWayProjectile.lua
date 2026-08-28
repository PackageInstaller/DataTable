--
-- Author:luqucheng
-- Date: 2019-12-12 16:53:29
--
local settingMgr = SettingMgr:GetInstance()
local gameUtils = CS.GameUtils

local util = require "XLua.util"
local cs_coroutine = import('XLua.cs_coroutine')
local WaitForEndOfFrame = CS.UnityEngine.WaitForEndOfFrame
local WaitForSeconds = CS.UnityEngine.WaitForSeconds


local ProjectileBase = import("Game.BattleView.Script.Projectile.ProjectileBase")
local NormalOneWayProjectile = Class("NormalOneWayProjectile", ProjectileBase)


--[[
    @desc: 
    author:luqucheng
    time:2019-12-12 17:15:47
    --@projectileId:
	--@bulletVo:[Game.Setting.Vo.BulletVo#BulletVo]
	--@target:[Game.BattleView.Entity.RoleView#RoleView]
	--@attacker: [Game.BattleView.Entity.RoleView#RoleView]
    @return:
]]
function NormalOneWayProjectile:ShootProjectile( bulletVo, target, attacker, OnHit )
    local bulletVo = self.bulletVo
    local target = self.target
    local attacker = self.attacker
    local OnHit = self.OnHit
    --创建子弹
    local obj = self.bulletObj

    --设置初始点，初始旋转
    --@RefType [Frame.UnityEngine.Vector3#Vector3]
    local startPos = self.startPos
    -- local startPos = attacker:GetOffsetPosition(Vector3.New(0, 1, 2))
    --@RefType [Frame.UnityEngine.Vector3#Vector3]
    local targetPos = self:GetTargetPosition()
    if not bulletVo:IsBoneBullet() then
        local q = Quaternion.FromToRotation( Vector3.forward, targetPos:Clone():Sub(startPos) )
        local euler = q:ToEulerAngles()
        --强行清除z轴旋转
        obj.transform.localRotation = q:SetEuler(euler.x, euler.y, 0)
    end
    obj.transform.position = startPos
    --位移
    local t = bulletVo.forwardFrame * AnimFrameTime
    self:SetMove(startPos, targetPos, t)

    --等待时间结束，
    coroutine.yield( WaitForSeconds(t) )
    

    -- local t = (bulletVo.hitFrame - bulletVo.forwardFrame) * AnimFrameTime
    -- coroutine.yield( WaitForSeconds(t) )
    
    -- --受击，受击特效
    if OnHit then
        OnHit(self)
    end

    local t = (bulletVo.frame - bulletVo.forwardFrame) * AnimFrameTime
    coroutine.yield( WaitForSeconds(t) )

    self.co = nil
    --移除子弹
    self:Dipose()
end

return  NormalOneWayProjectile