-- @FileName:   DankeBulletFire.lua
-- @Description:   蛋壳子弹燃烧弹-火焰
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.playerBullet.DankeBulletFire', Class.impl(danke.DankeBullet))

function resetData(self)
    super.resetData(self)
    local skillParam = self.m_data.params.param

    self.m_fireTime = skillParam[2] * 0.001 --火焰持续时间
    self.m_damageInterval = skillParam[3] * 0.001 --火焰火焰伤害间隔

    self.m_lastDamageTime = -1 --上一个造成伤害的时间

end

function onFrame(self)
    super.onFrame(self)

    if self.m_deltaTime >= self.m_fireTime then
        self:poolRecover()
    end
end

--攻击
function onAttack(self, thing, collider_args, isforce)
    local va = self.m_deltaTime - self.m_lastDamageTime
    if self.m_lastDamageTime < 0 or va <= 0 or va >= self.m_damageInterval then
        thing:onHit(self.m_data.damage)

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
    self.m_ColliderCall:InitCapsuleCollider(0.9, 0.9)
end

function getScale(self)
    return self.m_data.scale
end

return _M
