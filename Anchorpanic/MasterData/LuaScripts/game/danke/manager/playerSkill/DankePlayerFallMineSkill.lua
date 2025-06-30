-- @FileName:   DankePlayerFallMineSkill.lua
-- @Description:   落雷技能类
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.playerSkill.DankePlayerFallMineSkill', Class.impl(danke.DankePlayerInitiativeSkill))

function resetData(self)
    super.resetData(self)

    self.m_lastShootTime = 0 --上一次发射子弹的时间
    self.m_waveShootCount = 0 --每次发射的子弹计数
end

function refreshParam(self)
    super.refreshParam(self)

    self.m_range = self.m_skillParam[1] --攻击范围
    self.m_shootCount = self.m_skillParam[2] --子弹数量
    self.m_bulletScale = self.m_skillParam[3] * 0.01--子弹伤害范围
    self.m_shootInterval = self.m_skillParam[4] * 0.001 --子弹发射间隔
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
    self:initAttackPos()
    local attack_pos = self:getAttackPos()
    if attack_pos == nil then
        return
    end

    local playThing_attr = self.m_playerThing:getAttr()

    local data =
    {
        path = self.m_skillVo:getRes(),
        damage = self.m_bulletDamage,
        add_scale = playThing_attr.attact_range,
        params = self.m_skillLevel,

        born_pos = attack_pos,
        scale = self.m_bulletScale,
    }

    danke.DanKeSceneController:createPlayerBullet(self.m_skillVo.type, self.m_skillVo.subtype, data)
    self.m_waveShootCount = self.m_waveShootCount + 1

    if self.m_waveShootCount >= self.m_shootCount then
        self.m_lastExecuteTime = self.m_deltaTime
        self.m_lastShootTime = self.m_deltaTime

        self.m_waveShootCount = 0
    end
end

function getAttackPos(self)
    if table.empty(self.m_attackPosList) then
        return nil
    end
    local random_index = math.random(1, #self.m_attackPosList)
    return self.m_attackPosList[random_index]
end

function initAttackPos(self)
    self.m_attackPosList = {}

    local monster_tagList = {DanKeConst.ColliderTag.Normal_Monster, DanKeConst.ColliderTag.Elite_Monster}
    for _, monsterTag in pairs(monster_tagList) do
        local monsterThingDic = danke.DanKeSceneController:getLayerThingDic(monsterTag)
        if monsterThingDic and not table.empty(monsterThingDic) then
            local playThing_pos = self.m_playerThing:getPosition()
            for snId, monsterThing in pairs(monsterThingDic) do
                local monster_pos = monsterThing:getPosition()
                local pos_distance = gs.Vector3.Distance(gs.Vector3(monster_pos.x, monster_pos.y, 0), gs.Vector3(playThing_pos.x, playThing_pos.y, 0))
                if math.abs(pos_distance) <= self.m_range then
                    table.insert(self.m_attackPosList, {x = monster_pos.x, y = monster_pos.y, 0})
                end
            end
        end
    end

end

function onRecover(self)
    super.onRecover(self)

    self.m_lastShootTime = nil
    self.m_waveShootCount = nil
    self.m_attackThingList = nil

    self.m_range = nil
    self.m_shootCount = nil
    self.m_bulletScale = nil
    self.m_shootInterval = nil
end

return _M
