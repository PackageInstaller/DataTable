-- @FileName:   DankePlayerPotShootSkill.lua
-- @Description:   玩家同时发散子弹技能类
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.monsterSkill.DankePlayerPotShootSkill', Class.impl(danke.DankePlayerInitiativeSkill))

function resetData(self)
    super.resetData(self)

    self.m_shootWheelCount = 0--已经发射的轮数
    self.m_shootTime = 0 --上一轮发射的时间
end

function refreshParam(self)
    super.refreshParam(self)

    self.m_shootInitAngle = self.m_skillParam[1] --每轮发射的初始角度
    self.m_shootAngle = self.m_skillParam[2] --每次发射间隔的角度
    self.m_shootNum = self.m_skillParam[3] --每轮发射的数量
    self.m_shootWheelNum = self.m_skillParam[4] --发射的轮数
    self.m_shootWheelInterval = self.m_skillParam[5] * 0.001 --每轮发射的间隔
    self.m_bulletFlyDistance = self.m_skillParam[6] --子弹飞行距离
end

function onExecute(self, deltaTime)
    local playThing_attr = self.m_playerThing:getAttr()
    self.m_bulletSpeed = self.m_skillLevel.bullet_speed * (1 + playThing_attr.add_bullet_flyspeed) --子弹飞行速度
    self.m_bulletDamage = self.m_skillLevel.damage * (1 + playThing_attr.damage_ratio)

    if self.m_shootTime == 0 or self.m_deltaTime - self.m_shootTime >= self.m_shootWheelInterval then
        self:onShoot()
    end
end

function onShoot(self)
    for i = 1, self.m_shootNum do
        local angle = self.m_shootInitAngle + (self.m_shootAngle * i)

        local quaternion = gs.Quaternion.Euler(0, 0, angle)
        local disVect3 = gs.Vector3.right
        local dir_pos = quaternion * disVect3
        local shoot_dir = dir_pos.normalized

        local playerThing_pos = self.m_playerThing:getPosition()
        local born_pos = gs.Vector3(playerThing_pos.x, playerThing_pos.y, 0)

        local playThing_attr = self.m_playerThing:getAttr()
        local data =
        {
            path = self.m_skillVo:getRes(),
            speed = self.m_bulletSpeed,
            damage = self.m_bulletDamage,
            add_scale = playThing_attr.attact_range,
            params = self.m_skillLevel,
            fly_distance = self.m_bulletFlyDistance,

            shoot_dir = shoot_dir,
            born_pos = born_pos,
        }
        danke.DanKeSceneController:createPlayerBullet(self.m_skillVo.type, self.m_skillVo.subtype, data)
    end
    self.m_shootTime = self.m_deltaTime

    self.m_shootWheelCount = self.m_shootWheelCount + 1
    if self.m_shootWheelCount >= self.m_shootWheelNum then
        self.m_lastExecuteTime = self.m_deltaTime
    end
end

function onRecover(self)
    super.onRecover(self)

    self.m_shootInitAngle = nil
    self.m_shootAngle = nil
    self.m_shootNum = nil
    self.m_shootWheelNum = nil
    self.m_shootWheelInterval = nil

    self.m_shootWheelCount = nil
    self.m_shootTime = nil
end

return _M
