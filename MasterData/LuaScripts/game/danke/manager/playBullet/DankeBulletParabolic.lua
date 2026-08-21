-- @FileName:   DankeBulletParabolic.lua
-- @Description:   蛋壳子弹抛物类
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.playerBullet.DankeBulletParabolic', Class.impl(danke.DankeBullet))

function resetData(self)
    super.resetData(self)

    self.m_gravity = 9.8
    self.vertical_speed = self.m_data.vertical_speed
end

function loadFinish(self, go)
    super.loadFinish(self, go)
end

function onFrame(self)
    super.onFrame(self)

    self.vertical_speed = self.vertical_speed - gs.Time.deltaTime * self.m_gravity

    local distance = gs.Vector3(self.m_data.fly_dir * self.m_data.horizontal_speed, 1 * self.vertical_speed, 0) * gs.Time.deltaTime
    self.m_trans:Translate(distance, gs.Space.World)

    if self.m_deltaTime >= self.m_data.life_time then
        self:poolRecover()
    end
end

function clearData(self)
    super.clearData(self)

    self.m_flyDir = nil
    self.m_isBack = nil
end

function initCollider(self)
    self.m_ColliderCall:InitCapsuleCollider(0.5, 0.5)
end

return _M
