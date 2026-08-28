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
local NormalBackProjectile = Class("NormalBackProjectile", ProjectileBase)


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
function NormalBackProjectile:ShootProjectile(  )
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
        obj.transform.localRotation = Quaternion.FromToRotation( Vector3.forward, targetPos:Clone():Sub(startPos) )
    end
    obj.transform.position = startPos
    -- obj:SetActive(false)

    --位移
    local t = bulletVo.forwardFrame * AnimFrameTime
    -- print("ShootProjectile", table.toString(bulletVo), t, table.toString(obj), table.toString(targetPos), table.toString(target.modelVo.bulletHitPos))
    -- obj.transform:DOMove( targetPos, t )
    self:SetMove(startPos, targetPos, t)
    --等待时间结束，
    coroutine.yield( WaitForSeconds(t) )

    local t = (bulletVo.backFrame - bulletVo.forwardFrame) * AnimFrameTime
    coroutine.yield( WaitForSeconds(t) ) 


    -- local t = (bulletVo.hitFrame - bulletVo.forwardFrame) * AnimFrameTime
    -- coroutine.yield( WaitForSeconds(t) ) 
    -- --受击，受击特效
    -- if OnHit then
    --     OnHit(self)
    -- end

    -- local t = (bulletVo.backFrame - bulletVo.hitFrame) * AnimFrameTime
    -- coroutine.yield( WaitForSeconds(t) ) 

    local t = (bulletVo.frame - bulletVo.backFrame) * AnimFrameTime
    -- obj.transform:DOMove( startPos, t )
    --回来
    self:SetMove(targetPos, startPos, t)
    coroutine.yield( WaitForSeconds(t) ) 
    self:ResetPosition()
    self.co = nil
    self:Dipose()
end

return  NormalBackProjectile