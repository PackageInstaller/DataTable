-- @FileName:   DankePlayerFlyKnifeSkill.lua
-- @Description:   玩家飞刀技能类
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.playerSkill.DankePlayerFlyKnifeSkill', Class.impl(danke.DankePlayerInitiativeSkill))

function resetData(self)
    super.resetData(self)
    self.m_bulletList = {}

    self.m_lastShootTime = 0 --上一次发射子弹的时间
    self.m_waveShootCount = 0 --每次发射的子弹计数
end

function refreshParam(self)
    super.refreshParam(self)
    self.m_shootCount = self.m_skillParam[1] --每次发射数量
    self.m_shootInterval = self.m_skillParam[2] * 0.001 --每颗子弹的发射间隔

    self.m_bulletDistance = self.m_skillParam[3] --子弹飞行距离

    self.m_bullet_bornPos = {}
    if self.m_shootCount % 2 == 1 then
        self.m_bullet_bornPos[1] = {distance = 0}
        if self.m_shootCount >= 3 then
            for i = 2, self.m_shootCount do
                local distance = 0
                if i % 2 == 0 then
                    distance = (i - 1) * 0.4
                else
                    distance = (i - 2) * -0.4
                end

                self.m_bullet_bornPos[i] = {distance = distance}
            end
        end
    else
        for i = 1, self.m_shootCount do
            local distance = 0
            if i % 2 == 0 then
                distance = (i - 1) * 0.4
            else
                distance = (i - 2) * -0.4
            end

            self.m_bullet_bornPos[i] = {distance = distance}
        end
    end
end

function onExecute(self)
    local playThing_attr = self.m_playerThing:getAttr()
    self.m_bulletSpeed = self.m_skillLevel.bullet_speed * (1 + playThing_attr.add_bullet_flyspeed) --子弹飞行速度
    self.m_bulletDamage = self.m_skillLevel.damage * (1 + playThing_attr.damage_ratio)

    if self.m_lastShootTime == 0 or self.m_deltaTime - self.m_lastShootTime >= self.m_shootInterval then
        self:onShoot()
    end
end

function onShoot(self)
    local fly_dir = self.m_playerThing:getMoveDir()
    local born_pos = self:getBulletPos(fly_dir)
    local playThing_attr = self.m_playerThing:getAttr()

    local data =
    {
        path = self.m_skillVo:getRes(),
        speed = self.m_bulletSpeed,
        damage = self.m_bulletDamage,
        add_scale = playThing_attr.attact_range,
        
        fly_dir = fly_dir,
        born_pos = born_pos,
        distance = self.m_bulletDistance,
        params = self.m_skillLevel,
    }

    danke.DanKeSceneController:createPlayerBullet(self.m_skillVo.type, self.m_skillVo.subtype, data)
    self.m_waveShootCount = self.m_waveShootCount + 1

    if self.m_waveShootCount >= self.m_shootCount then
        self.m_lastExecuteTime = self.m_deltaTime
        self.m_lastShootTime = self.m_deltaTime

        for k, posInfo in pairs(self.m_bullet_bornPos) do
            posInfo.isCreate = false
        end

        self.m_waveShootCount = 0
    end
end

function getBulletPos(self, dir)
    local distance_list = {}
    for k, posInfo in pairs(self.m_bullet_bornPos) do
        if not posInfo.isCreate then
            table.insert(distance_list, posInfo)
        end
    end
    if table.empty(distance_list) then
        return gs.Vector3(0, 0, 0)
    end

    local random = math.random(1, #distance_list)
    local distance = distance_list[random].distance

    for _, posInfo in pairs(self.m_bullet_bornPos) do
        if posInfo.distance == distance then
            posInfo.isCreate = true
            break
        end
    end

    local layer = danke.DanKeSceneController:getLayer(DanKeConst.LayerName.Player_bullet)
    local bullet_parent = layer.node
    local playThing_bulletPos = bullet_parent:InverseTransformPoint(self.m_playerThing:getPosition())

    local targetRotation = gs.Quaternion.LookRotation(gs.Vector3(dir.x * -1, 0, dir.y))
    local angle_y = targetRotation.eulerAngles.y * gs.Mathf.Deg2Rad

    return gs.Vector3(playThing_bulletPos.x + gs.Mathf.Cos(angle_y) * distance, playThing_bulletPos.y + gs.Mathf.Sin(angle_y) * distance, 0)
end

function onRecover(self)
    super.onRecover(self)

    self.m_lastShootTime = nil
    self.m_waveShootCount = nil

    self.m_shootCount = nil
    self.m_shootInterval = nil

    self.m_bulletDistance = nil

    self.m_bullet_bornPos = nil
end

return _M
