-- @FileName:   DankeBulletFallMine.lua
-- @Description:   蛋壳子弹回旋镖类
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.playerBullet.DankeBulletFallMine', Class.impl(danke.DankeBullet))

function resetData(self)
    super.resetData(self)

    self.m_lifeTime = 1.2
    self.m_attackStartTime = 0.05
    self.m_attackEndTime = 0.25

    self.m_attackerThingDic = {}
end

function onFrame(self)
    super.onFrame(self)

    if self.m_deltaTime >= self.m_lifeTime then
        self:poolRecover()
    end
end

--攻击
function onAttack(self, thing, collider_args, isforce)
    if self.m_deltaTime - self.m_attackStartTime <= self.m_attackEndTime then
        if self.m_attackerThingDic[thing.m_snId] == nil then
            super.onAttack(self, thing, collider_args)
            self.m_attackerThingDic[thing.m_snId] = 1
        end
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

function clearData(self)
    super.clearData(self)

    self.m_lifeTime = nil
    self.m_attackTime = nil
    self.m_attackerThingDic = nil
end

function initCollider(self)
    self.m_ColliderCall:InitCapsuleCollider(0.5, 0.5)
end

function getScale(self)
    return self.m_data.scale
end

return _M
