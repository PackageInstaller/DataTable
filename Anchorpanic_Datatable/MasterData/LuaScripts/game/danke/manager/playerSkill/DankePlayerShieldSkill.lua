-- @FileName:   DankePlayerShieldSkill.lua
-- @Description:   玩家护盾技能类
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.playerSkill.DankePlayerShieldSkill', Class.impl(danke.DankePlayerInitiativeSkill))

function resetData(self)
    super.resetData(self)

    self.m_bulletList = {}
end

function refreshParam(self)
    super.refreshParam(self)
    local count = self.m_skillParam[1]--数量
    self.m_radius = self.m_skillParam[2] --半径
    self.m_time = self.m_skillParam[3] * 0.001 --持续时间

    local angle = 360 / count
    self.m_angleList = {}
    for i = 1, count do
        self.m_angleList[i] = (i - 1) * angle
    end

    if self.m_cd <= self.m_time then
        logError("护盾技能Cd太短")
    end
end

function onFrame(self)
    super.onFrame(self)
    if self.m_deltaTime - self.m_lastExecuteTime >= self.m_time then
        self:clearBullet()
    end
end

function onExecute(self)
    super.onExecute(self)

    self:clearBullet()

    local playThing_attr = self.m_playerThing:getAttr()
    for i = 1, #self.m_angleList do
        local data =
        {
            path = self.m_skillVo:getRes(),
            speed = self.m_bulletSpeed,
            damage = self.m_bulletDamage,
            add_scale = playThing_attr.attact_range,
            params = self.m_skillLevel,

            angle = self.m_angleList[i],
            radius = self.m_radius,
            born_pos = gs.Vector3(10000, 10000, 0),
        }
        local bullet = danke.DanKeSceneController:createPlayerBullet(self.m_skillVo.type, self.m_skillVo.subtype, data)

        table.insert(self.m_bulletList, bullet)
    end
end

function clearBullet(self)
    for _, bullet in pairs(self.m_bulletList) do
        bullet:poolRecover()
    end

    self.m_bulletList = {}
end

function onRecover(self)
    super.onRecover(self)

    self.m_radius = nil
    self.m_time = nil
    self.m_angleList = nil
end

return _M
