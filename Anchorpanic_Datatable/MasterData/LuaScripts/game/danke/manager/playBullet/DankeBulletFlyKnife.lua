-- @FileName:   DankeBulletFlyKnife.lua
-- @Description:   蛋壳子弹飞刀类
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.playerBullet.DankeBulletFlyKnife', Class.impl(danke.DankeBullet))

function resetData(self)
    super.resetData(self)

    self.m_flyDistance = 0
end

function loadFinish(self, go)
    super.loadFinish(self, go)

    local targetRotation = gs.Quaternion.LookRotation(gs.Vector3(self.m_data.fly_dir.x * -1, 0, self.m_data.fly_dir.y))
    gs.TransQuick:SetRotation(self:getTrans(), 0, 0, targetRotation.eulerAngles.y)
end

function onFrame(self)
    super.onFrame(self)
    
    local distance = self.m_data.fly_dir * gs.Time.deltaTime * self.m_data.speed
    self.m_flyDistance = self.m_flyDistance + distance.magnitude
    self.m_trans:Translate(distance, gs.Space.World)

    if self.m_flyDistance >= self.m_data.distance then
        self:poolRecover()
    end
end

function clearData(self)
    super.clearData(self)

    self.m_flyDistance = nil
end

function initCollider(self)
    self.m_ColliderCall:InitBoxCollider(0.1, 0.5, 0.2)
end

return _M
