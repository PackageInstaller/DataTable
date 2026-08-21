-- @FileName:   DankeMonsterStraightBullet.lua
-- @Description:   怪物直射类型子弹
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.monsterBullet.DankeMonsterStraightBullet', Class.impl(danke.DankeMonsterBaseBullet))

function resetData(self)
    self.m_flyDistance = 0
end

function loadFinish(self, go)
    super.loadFinish(self, go)

    local targetRotation = gs.Quaternion.LookRotation(gs.Vector3(self.m_data.shoot_dir.x * -1, 0, self.m_data.shoot_dir.y))
    gs.TransQuick:SetRotation(self:getTrans(), 0, 0, targetRotation.eulerAngles.y)
end

function onFrame(self)
    local distance = self.m_data.shoot_dir * gs.Time.deltaTime * self.m_data.config.bullet_speed
    local pos = self.m_trans.position + distance
    -- self.m_trans:Translate(distance, gs.Space.World)
    gs.TransQuick:LPos(self.m_trans, pos.x, pos.y, 0)

    self.m_flyDistance = self.m_flyDistance + distance.magnitude
    if self.m_flyDistance >= 20 then
        self:poolRecover()
    end
end

function initCollider(self)
    self.m_ColliderCall:InitCapsuleCollider(0.01, 0.01)
end

function clearData(self)
    super.clearData(self)

    self.m_flyDistance = nil
end

return _M
