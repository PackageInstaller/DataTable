-- @FileName:   DankePlayerPassiveSkill.lua
-- @Description:   玩家被动技能基类类
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.playerSkill.DankePlayerPassiveSkill', Class.impl(danke.DankePlayerBaseSkill))

function resetData(self)
    super.resetData(self)

    self.m_add_attrValue = 0 --附加的属性值

    self:onExecute()
end

function onExecute(self)
    local addValue = self.m_skillParam[1] * 0.01

    local skillType, skillSubType = self.m_skillVo.type, self.m_skillVo.subtype
    if skillSubType == DanKeConst.PlayerSkill_SubType.Energy then
        addValue = self.m_skillParam[2] * 0.01
        self:clearTimerSn()
        self:setTimerSn(self.m_skillParam[1], function ()
            local max_hp = self.m_playerThing:getMaxHp()
            local add_hp = max_hp * addValue
            self.m_playerThing:addHp(add_hp)
        end)
    elseif skillSubType == DanKeConst.PlayerSkill_SubType.AddBulletSpeed then
        self.m_add_attrValue = self.m_add_attrValue + addValue
        self.m_playerThing:addAttr("add_bullet_flyspeed", addValue)
    elseif skillSubType == DanKeConst.PlayerSkill_SubType.AddAttackDamage then
        self.m_add_attrValue = self.m_add_attrValue + addValue
        self.m_playerThing:addAttr("damage_ratio", addValue)

    elseif skillSubType == DanKeConst.PlayerSkill_SubType.AddExp then
        self.m_add_attrValue = self.m_add_attrValue + addValue
        self.m_playerThing:addAttr("addExp_ratio", addValue)

    elseif skillSubType == DanKeConst.PlayerSkill_SubType.Hit_reduce then
        self.m_add_attrValue = self.m_add_attrValue + addValue
        self.m_playerThing:addAttr("hit_ratio", addValue)

    elseif skillSubType == DanKeConst.PlayerSkill_SubType.AddAttackRange then
        self.m_add_attrValue = self.m_add_attrValue + addValue
        self.m_playerThing:addAttr("attact_range", addValue)

    elseif skillSubType == DanKeConst.PlayerSkill_SubType.AddMoveSpeed then
        self.m_add_attrValue = self.m_add_attrValue + addValue
        self.m_playerThing:addAttr("add_move_speed", addValue)

    elseif skillSubType == DanKeConst.PlayerSkill_SubType.AddMaxHp then
        self.m_add_attrValue = self.m_add_attrValue + addValue
        self.m_playerThing:addAttr("add_max_hp", addValue)
    end
end

-- --禁用技能
-- function disable(self)
--     super.disable(self)

--     self.m_add_attrValue = self.m_add_attrValue * -1

--     local skillType, skillSubType = self.m_skillVo.type, self.m_skillVo.subtype
--     if skillSubType == DanKeConst.PlayerSkill_SubType.Energy then
--         self:clearTimerSn()
--     elseif skillSubType == DanKeConst.PlayerSkill_SubType.AddBulletSpeed then
--         self.m_playerThing:addAttr("add_bullet_flyspeed", self.m_add_attrValue)
--     elseif skillSubType == DanKeConst.PlayerSkill_SubType.AddAttackDamage then
--         self.m_playerThing:addAttr("damage_ratio", self.m_add_attrValue)
--     elseif skillSubType == DanKeConst.PlayerSkill_SubType.AddExp then
--         self.m_playerThing:addAttr("addExp_ratio", self.m_add_attrValue)
--     elseif skillSubType == DanKeConst.PlayerSkill_SubType.Hit_reduce then
--         self.m_playerThing:addAttr("hit_ratio", self.m_add_attrValue)
--     elseif skillSubType == DanKeConst.PlayerSkill_SubType.AddAttackRange then
--         self.m_playerThing:addAttr("attact_range", self.m_add_attrValue)
--     elseif skillSubType == DanKeConst.PlayerSkill_SubType.AddMoveSpeed then
--         self.m_playerThing:addAttr("add_move_speed", self.m_add_attrValue)
--     elseif skillSubType == DanKeConst.PlayerSkill_SubType.AddMaxHp then
--         self.m_playerThing:addAttr("add_max_hp", self.m_add_attrValue)
--     end
-- end

function setTimerSn(self, time, func)
    self.m_timerSn = LoopManager:addTimer(time, 0, nil, func)
end

function clearTimerSn(self)
    if self.m_timerSn then
        LoopManager:removeTimerByIndex(self.m_timerSn)
        self.m_timerSn = nil
    end
end

function onRecover(self)
    super.onRecover(self)

    self:clearTimerSn()
    self.m_add_attrValue = nil
end

return _M
