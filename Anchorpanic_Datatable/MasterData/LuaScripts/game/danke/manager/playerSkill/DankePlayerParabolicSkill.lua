-- @FileName:   DankePlayerParabolicSkill.lua
-- @Description:   玩家上抛技能类
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.playerSkill.DankePlayerParabolicSkill', Class.impl(danke.DankePlayerInitiativeSkill))

function resetData(self)
    super.resetData(self)

    self.m_lastShootTime = 0 --上一次发射子弹的时间
    self.m_waveShootCount = 0 --每次发射的子弹计数
end

function refreshParam(self)
    super.refreshParam(self)

    self.m_minVerticalSpeed = self.m_skillParam[1] --纵向最小速度
    self.m_maxVerticalSpeed = self.m_skillParam[2] --纵向最大速度
    self.m_minHorizontalSpeed = self.m_skillParam[3] --横向最小速度
    self.m_maxHorizontalSpeed = self.m_skillParam[4] --横向最大速度
    self.m_lifeTime = self.m_skillParam[5] * 0.001 --子弹持续时间
    self.m_shootCount = self.m_skillParam[6] --子弹数量
    self.m_shootInterval = self.m_skillParam[7] * 0.001 --发射间隔
end

function onExecute(self)
    super.onExecute(self)

    local playThing_attr = self.m_playerThing:getAttr()
    self.m_bulletDamage = self.m_skillLevel.damage * (1 + playThing_attr.damage_ratio)

    if self.m_lastShootTime == 0 or self.m_deltaTime - self.m_lastShootTime >= self.m_shootInterval then
        self:onShoot()
    end
end

function onShoot(self)
    local playThing_attr = self.m_playerThing:getAttr()

    local playerThing_pos = self.m_playerThing:getPosition()
    local born_pos = gs.Vector3(playerThing_pos.x, playerThing_pos.y, 0)

    local random_index = math.random(0, 1) --0左、1右
    local fly_dir = 1
    if random_index == 0 then
        fly_dir = -1
    end
    local horizontalSpeed = math.random(self.m_minHorizontalSpeed, self.m_maxHorizontalSpeed) * (1 + playThing_attr.add_bullet_flyspeed) --子弹飞行速度
    local verticalSpeed = math.random(self.m_minVerticalSpeed, self.m_maxVerticalSpeed) * (1 + playThing_attr.add_bullet_flyspeed) --子弹飞行速度

    local data =
    {
        path = self.m_skillVo:getRes(),
        damage = self.m_bulletDamage,
        add_scale = playThing_attr.attact_range,
        params = self.m_skillLevel,

        fly_dir = fly_dir,
        born_pos = born_pos,

        vertical_speed = verticalSpeed,
        horizontal_speed = horizontalSpeed,
        life_time = self.m_lifeTime,
    }

    danke.DanKeSceneController:createPlayerBullet(self.m_skillVo.type, self.m_skillVo.subtype, data)
    self.m_waveShootCount = self.m_waveShootCount + 1

    if self.m_waveShootCount >= self.m_shootCount then
        self.m_lastExecuteTime = self.m_deltaTime
        self.m_lastShootTime = self.m_deltaTime

        self.m_waveShootCount = 0
    end
end

function onRecover(self)
    super.onRecover(self)

    self.m_minHeight = nil
    self.m_maxHeight = nil
    self.m_minWide = nil
    self.m_maxWide = nil
    self.m_lifeTime = nil
    self.m_bulletNum = nil
    self.m_shootTime = nil

    self.m_lastShootTime = nil
    self.m_waveShootCount = nil
end

return _M
