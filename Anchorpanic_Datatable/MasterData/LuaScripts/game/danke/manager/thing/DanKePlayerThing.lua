-- @FileName:   DanKePlayerThing.lua
-- @Description:  沙盒实体基类
-- @Author: ZDH
-- @Date:   2023-07-25 12:00:06
-- @Copyright:   (LY) 2023 雷焰网络
module('game.danke.thing.DanKePlayerThing', Class.impl(danke.DanKeBaseThing))

function resetData(self)
    super.resetData(self)

    self.m_attr =
    {
        max_hp = self.m_data.config.hp,
        hp = self.m_data.config.hp,
        exp = 0,
        max_level = table.nums(self.m_data.config.level_data),
        level = 1,
        kill_num = 0,

        add_bullet_flyspeed = 0, --附加子弹飞行速度增加
        damage_ratio = 0, --附加伤害
        addExp_ratio = 0, --附加经验值比例
        hit_ratio = 0, --受伤降低比例
        attact_range = 0, --附加伤害范围
        add_move_speed = 0, --附加移动速度
        add_max_hp = 0, --附加血量上限
    }

    self.skill_list =
    {
        [DanKeConst.PlayerSkill_Type.Initiative] = {},
        [DanKeConst.PlayerSkill_Type.Passive] = {},
    }

    self.m_lasteHit_DeltaTime = 0
end

function addEventListener(self)
    GameDispatcher:addEventListener(EventName.FIELDEXPLORATION_JOYSTICK_UPDATE, self.onControlMove, self)
    GameDispatcher:addEventListener(EventName.DANKE_SELECT_SKILL, self.onRefresSkill, self)
end

function removeEventListener(self)
    GameDispatcher:removeEventListener(EventName.FIELDEXPLORATION_JOYSTICK_UPDATE, self.onControlMove, self)
    GameDispatcher:removeEventListener(EventName.DANKE_SELECT_SKILL, self.onRefresSkill, self)
end

function onModelLoadFinish(self)
    super.onModelLoadFinish(self)

    -- local trans = self:getTrans()
    -- trans.gameObject.layer = gs.LayerMask.NameToLayer("Role")

    self:addColliderGo()

    self:setPosition({x = 0, y = 0, z = 0})
    self:setAngle(0)
    self:playAction("stand")

    self:clearRefreshAttrTimeOutSn()
    self.m_RefreshAttrTimeOutSn = LoopManager:setFrameout(10, nil, function ()
        GameDispatcher:dispatchEvent(EventName.DANKE_PLAYERTHING_ATTRREFRESH)
    end)
end

function initCharacterControllerSize(self)
    gs.UnityEngineUtil.InitCharacterController(self.m_CharacterController, 30, 0.1, self.m_data.config.agent_radius, 0.6, gs.Vector3(0, 0, 0))
end

function clearRefreshAttrTimeOutSn(self)
    if self.m_RefreshAttrTimeOutSn then
        LoopManager:removeFrameByIndex(self.m_RefreshAttrTimeOutSn)
        self.m_RefreshAttrTimeOutSn = nil
    end
end

--添加碰撞检测
function addColliderGo(self)
    self.m_ColliderGo = gs.GameObject()
    self.m_ColliderGo.name = "collider_Go"
    gs.TransQuick:SetParentOrg(self.m_ColliderGo.transform, self.m_spriteModel.m_trans)

    self.m_ColliderCall = self.m_ColliderGo:AddComponent(ty.ColliderCall)
    self.m_ColliderCall:InitCapsuleCollider(self.m_data.config.agent_radius + 0.05, 0.65)
    local colliderTags = {DanKeConst.ColliderTag.Normal_Monster, DanKeConst.ColliderTag.Elite_Monster, DanKeConst.ColliderTag.Enemy_Bullet}
    self.m_ColliderCall:AddColliderTags(colliderTags)
    self.m_ColliderCall:OpenColliderCheck()
    self.m_ColliderCall.IsTrigger = true

    self.m_ColliderCall.SelfColliderTag = DanKeConst.ColliderTag.Player
    self.m_ColliderCall.ColliderTagID = self.m_snId

    self.m_ColliderCall.onTriggerEnterCall = function (tag, colliderTagID)
        local data = {attack_id = colliderTagID, hit_id = self.m_snId, attack_tag = tag, hit_tag = DanKeConst.ColliderTag.Player}
        GameDispatcher:dispatchEvent(EventName.DANKE_COLLIDER_ENTER, data)
    end

    self.m_ColliderCall.onTriggerExitCall = function (tag, colliderTagID)
        local data = {attack_id = colliderTagID, hit_id = self.m_snId, attack_tag = tag, hit_tag = DanKeConst.ColliderTag.Player}
        GameDispatcher:dispatchEvent(EventName.DANKE_COLLIDER_EIXT, data)
    end
end

--控制移动
function onControlMove(self, args)
    self.m_joystickDir = args

    --开始移动
    if self.m_joystickDir.deltaRatioX == 0 and self.m_joystickDir.deltaRatioY == 0 then
        self:playAction("stand")
    else
        self:onMove()
    end
end

function onMove(self, dir)
    self:playAction("move")

    if self.m_joystickDir.deltaRatioX < 0 then
        self:setAngle(0)
    elseif self.m_joystickDir.deltaRatioX > 0 then
        self:setAngle(180)
    end

    local dir = gs.Vector3(self.m_joystickDir.deltaRatioX, self.m_joystickDir.deltaRatioY, 0)
    self:setTranForward(self.m_data.config.normal_speed * gs.Time.deltaTime * (1 + self.m_attr.add_move_speed), dir)

    GameDispatcher:dispatchEvent(EventName.DANKE_PLAYERTHING_REFRESHPOS, self:getPosition())
end

function onRefresSkill(self, skillVo)
    local skillType, skillSubType = skillVo.type, skillVo.subtype
    if not self.skill_list[skillType][skillSubType] then
        self.skill_list[skillType][skillSubType] = {}
    end

    local skill = self.skill_list[skillType][skillSubType][skillVo.tid]
    if skill == nil then
        if skillType == DanKeConst.PlayerSkill_Type.Initiative then
            if skillSubType == DanKeConst.PlayerSkill_SubType.FlyKnife then
                skill = danke.DankePlayerFlyKnifeSkill:create(skillVo)
            elseif skillSubType == DanKeConst.PlayerSkill_SubType.Shield then
                skill = danke.DankePlayerShieldSkill:create(skillVo)
            elseif skillSubType == DanKeConst.PlayerSkill_SubType.Magnetic then
                skill = danke.DankePlayerMagneticSkill:create(skillVo)
            elseif skillSubType == DanKeConst.PlayerSkill_SubType.Whip then
                skill = danke.DankePlayerWhipSkill:create(skillVo)
            elseif skillSubType == DanKeConst.PlayerSkill_SubType.Bumerang then
                skill = danke.DankePlayerBumerangSkill:create(skillVo)
            elseif skillSubType == DanKeConst.PlayerSkill_SubType.FireBomb then
                skill = danke.DankePlayerFireBombSkill:create(skillVo)
            elseif skillSubType == DanKeConst.PlayerSkill_SubType.Potshoot then
                skill = danke.DankePlayerPotShootSkill:create(skillVo)
            elseif skillSubType == DanKeConst.PlayerSkill_SubType.Parabolic then
                skill = danke.DankePlayerParabolicSkill:create(skillVo)
            elseif skillSubType == DanKeConst.PlayerSkill_SubType.FallMine then
                skill = danke.DankePlayerFallMineSkill:create(skillVo)
            else
                skill = danke.DankePlayerInitiativeSkill:create(skillVo)
            end
        elseif skillType == DanKeConst.PlayerSkill_Type.Passive then
            skill = danke.DankePlayerPassiveSkill:create(skillVo)
        end

        self.skill_list[skillType][skillSubType][skillVo.tid] = skill
    else
        skill:addLevel()
    end
    GameDispatcher:dispatchEvent(EventName.DANKE_PLAYERTHING_SKILL_REFRESH, skill:getDataVo())
end

--------------------------------------------------属性-----

function getMaxHp(self)
    return self.m_attr.max_hp * (1 + self.m_attr.add_max_hp)
end

function addHp(self, hp)
    self.m_attr.hp = self.m_attr.hp + hp
    if self.m_attr.hp > self:getMaxHp() then
        self.m_attr.hp = self:getMaxHp()
    end
end

function addExp(self, exp)
    local add_exp = exp * (1 + self.m_attr.addExp_ratio)
    self.m_attr.exp = self.m_attr.exp + add_exp

    local levelExp = self:getLevelExp()
    if self.m_attr.exp >= levelExp then
        self:addLevel()
        self.m_attr.exp = self.m_attr.exp % levelExp
    end

    GameDispatcher:dispatchEvent(EventName.DANKE_PLAYERTHING_ATTRREFRESH)
end

function addLevel(self)
    if not self:isMaxLevel() then
        self.m_attr.level = self.m_attr.level + 1
        GameDispatcher:dispatchEvent(EventName.DANKE_RANDOM_PLAYERSKILL)
    end
end

function isMaxLevel(self)
    return self.m_attr.level >= self.m_attr.max_level
end

function addKillNum(self, num)
    self.m_attr.kill_num = self.m_attr.kill_num + num

    GameDispatcher:dispatchEvent(EventName.DANKE_PLAYERTHING_ATTRREFRESH)
end

function onHit(self, damage)
    local dupTime = danke.DanKeSceneController:getDupTime()
    if dupTime - self.m_lasteHit_DeltaTime >= self.m_data.config.affected_time then
        local _damage = damage * (1 - self.m_attr.hit_ratio)
        super.onHit(self, _damage)

        self.m_lasteHit_DeltaTime = dupTime
        GameDispatcher:dispatchEvent(EventName.DANKE_PLAYERTHING_ATTRREFRESH)
    end
end

function setAttr(self, attrKey, attrValue)
    self.m_attr[attrKey] = attrValue
end

function addAttr(self, attrKey, addValue)
    self.m_attr[attrKey] = self.m_attr[attrKey] + addValue
end

--死亡
function onDie(self)
    GameDispatcher:dispatchEvent(EventName.DANKE_ONREQ_PASSSTAGE, 0)
end

function getLevelExp(self)
    local level_data = self.m_data.config.level_data[self.m_attr.level]
    if not level_data then
        logError("当前等级没有找到升级配置  配置表 = danke_hero_data  等级 = " .. self.m_attr.level)
        return 0
    end
    return self.m_data.config.level_data[self.m_attr.level].exp
end

function getSkill(self, skill_id)
    for skillType, skillList in pairs(self.skill_list) do
        for skillSubType, skillDic in pairs(skillList) do
            for skill_tid, skill in pairs(skillDic) do
                local skillVo = skill:getDataVo()
                if skillVo and skillVo.tid == skill_id then
                    return skill
                end
            end
        end
    end
end

function getSkillCount(self, skllType)
    return table.nums(self.skill_list[skllType])
end

--------------------------------------------------公共

function setPosition(self, lpos)
    super.setPosition(self, lpos)
    GameDispatcher:dispatchEvent(EventName.DANKE_PLAYERTHING_REFRESHPOS, self:getPosition())
end

--获取移动方向
function getMoveDir(self)
    if self.m_joystickDir.deltaRatioX == 0 and self.m_joystickDir.deltaRatioY == 0 then
        local angle_y = self:getAngle()
        if angle_y == 0 then
            return gs.Vector3(-1, 0, 0)
        else
            return gs.Vector3(1, 0, 0)
        end
    end
    return gs.Vector3(self.m_joystickDir.deltaRatioX, self.m_joystickDir.deltaRatioY, 0)
end

function getSpriteModel(self)
    return danke.DanKeBaseSpriteModel
end

function getPrefabPath(self)
    return "arts/character/scene_module/dake/role/modelrole.prefab"
end

function clearData(self)
    super.clearData(self)

    self:clearRefreshAttrTimeOutSn()
    for skillType, skillList in pairs(self.skill_list) do
        for subSkillType, skillDic in pairs(skillList) do
            for skillTid, skill in pairs(skillDic) do
                skill:recover()
            end
        end
    end

    self.skill_list = nil

    if self.m_ColliderCall and not gs.GoUtil.IsCompNull(self.m_ColliderCall) then
        self.m_ColliderCall.onTriggerEnterCall = nil
        self.m_ColliderCall.onTriggerExitCall = nil
    end

    if self.m_ColliderGo and not gs.GoUtil.IsGoNull(self.m_ColliderGo) then
        gs.GameObject.Destroy(self.m_ColliderGo)
        self.m_ColliderGo = nil
    end
end

return _M
