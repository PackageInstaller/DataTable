-- @FileName:   DankeBulletWhip.lua
-- @Description:   蛋壳子弹皮鞭
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.playerBullet.DankeBulletWhip', Class.impl(danke.DankeBullet))

function resetData(self)
    super.resetData(self)
    
end

function onFrame(self)
    super.onFrame(self)
    
    local playThing_pos = self.m_playerThing:getPosition()
    self.m_trans.position = gs.Vector3(playThing_pos.x, playThing_pos.y, 0)
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
    self.m_ColliderCall:InitBoxCollider(4, 1, 0.2)
end

function getScale(self)
    return self.m_data.scale
end

return _M
