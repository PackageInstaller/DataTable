-- @FileName:   DankeBulletFireBom.lua
-- @Description:   蛋壳子弹燃烧弹 - 子弹
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.playerBullet.DankeBulletFireBom', Class.impl(danke.DankeBullet))

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

    if self.m_flyDistance >= self.m_data.bullet_distance then
        self:onBomb()
    end
end

--攻击
function onAttack(self, thing, collider_args, isforce)
    if self.m_data.params.is_pass ~= 1 then
        self:onBomb()
    end
end

--炸开
function onBomb(self)
    local born_pos = self:getTrans().position
    local data =
    {
        path = self.m_data.fire_resPath,
        damage = self.m_data.damage,
        add_scale = self.m_data.add_scale,
        params = self.m_data.params,

        scale = self.m_data.scale,

        born_pos = born_pos,
    }
    danke.DanKeSceneController:createPlayerBullet(self.m_data.skill_type, self.m_data.skill_subType, data)

    self:poolRecover()
end

function clearData(self)
    super.clearData(self)

    self.m_flyDistance = nil
end

function initCollider(self)
    self.m_ColliderCall:InitBoxCollider(0.1, 0.5, 0.5)
end

return _M
