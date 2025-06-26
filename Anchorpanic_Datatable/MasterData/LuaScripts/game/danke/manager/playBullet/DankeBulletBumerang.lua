-- @FileName:   DankeBulletBumerang.lua
-- @Description:   蛋壳子弹回旋镖类
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.playerBullet.DankeBulletBumerang', Class.impl(danke.DankeBullet))

function resetData(self)
    super.resetData(self)

    self.m_flyDir = self.m_data.fly_dir
    self.m_flySpeed = self.m_data.speed

    self.m_drag = 9.8
end

function loadFinish(self, go)
    super.loadFinish(self, go)
end

function onFrame(self)
    super.onFrame(self)

   self.m_flySpeed = self.m_flySpeed - gs.Time.deltaTime * self.m_drag
    self.m_trans:Translate(self.m_flyDir * gs.Time.deltaTime * self.m_flySpeed, gs.Space.World)

    if self.m_deltaTime >= self.m_data.lifeTime then
        self:poolRecover()
    end
end


function clearData(self)
    super.clearData(self)

    self.m_flyDir = nil
end

function initCollider(self)
    self.m_ColliderCall:InitCapsuleCollider(0.5, 0.5)
end

return _M
