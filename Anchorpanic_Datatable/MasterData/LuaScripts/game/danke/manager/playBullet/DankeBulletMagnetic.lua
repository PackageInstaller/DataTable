-- @FileName:   DankeBulletMagnetic.lua
-- @Description:   蛋壳子弹AT磁场
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.playerBullet.DankeBulletMagnetic', Class.impl(danke.DankeBullet))

function resetData(self)
    super.resetData(self)
    
    self.m_lastDamageTime = -1 --上一个造成伤害的时间

    self.m_damageTime = self.m_data.params.param[2] * 0.001
end

function onFrame(self)
    super.onFrame(self)

    local playThing_pos = self.m_playerThing:getPosition()
    self.m_trans.position = gs.Vector3(playThing_pos.x, playThing_pos.y, 0)
end

--攻击
function onAttack(self, thing, collider_args, isforce)
    local va = self.m_deltaTime - self.m_lastDamageTime
    if self.m_lastDamageTime < 0 or va <= 0 or va >= self.m_damageTime then
        super.onAttack(self, thing, collider_args)
        self.m_lastDamageTime = self.m_deltaTime
    end
end

function initColliderCall(self)
    self.m_ColliderCall.onTriggerStayCall = function (tag, colliderTagID)
        local data = {attack_id = self.m_snId, hit_id = colliderTagID, attack_tag = DanKeConst.ColliderTag.Player_Bullet, hit_tag = tag}
        GameDispatcher:dispatchEvent(EventName.DANKE_COLLIDER_STAY, data)
    end

    self.m_ColliderCall.onTriggerExitCall = function (tag, colliderTagID)
        local data = {attack_id = self.m_snId, hit_id = colliderTagID, attack_tag = DanKeConst.ColliderTag.Player_Bullet, hit_tag = tag}
        GameDispatcher:dispatchEvent(EventName.DANKE_COLLIDER_EIXT, data)
    end
end

function initCollider(self)
    self.m_ColliderCall:InitCapsuleCollider(0.5, 0.5)
end

function getScale(self)
    return self.m_data.radius
end

return _M
