local IslandShipSkill = class("IslandShipSkill", import("model.vo.BaseVO"))

function IslandShipSkill:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.configId = self.id
	self.level = arg_1_1.level or 1
	self.isUsedToday = defaultValue(arg_1_1.isUseToday, false)
	self.maxLevel = 1

	self:InitMaxLevel()

	self.lock = true

	return
end

function IslandShipSkill:bindConfigTable()
	return pg.island_chara_skill
end

function IslandShipSkill:GetName()
	return self:getConfig("name")
end

function IslandShipSkill:GetIcon()
	return self:getConfig("icon")
end

function IslandShipSkill:Unlock()
	self.lock = false

	if self.level <= 0 then
		self.level = 1
	end

	return
end

function IslandShipSkill:IsUnlock()
	return not self.lock
end

function IslandShipSkill:GetLevel()
	return self.level
end

function IslandShipSkill:IsMaxLevel()
	return self.level >= self.maxLevel
end

function IslandShipSkill:InitMaxLevel()
	self.maxLevel = #self:getConfig("skill_effect")

	return
end

function IslandShipSkill:Upgrade()
	if self:IsMaxLevel() then
		return
	end

	self.level = self.level + 1

	return
end

function IslandShipSkill:IsGreetingType()
	return underscore.any(self:GetEffectIds(), function(arg_12_0)
		return IslandBuffType.IsGreetingType(pg.island_buff_template[arg_12_0].buff_type)
	end)
end

local function var_0_1(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_2.buff_type == IslandBuffType.SHIP_POWER_RECOVER_BY_GREETING then
		return not arg_13_0 and (function()
			return arg_13_1:GetCurrentEnergy() <= arg_13_2.type_use[1]
		end)()
	elseif arg_13_2.buff_type == IslandBuffType.SHIP_AWARD_BY_GREETING then
		return not arg_13_0
	else
		return true
	end

	return
end

function IslandShipSkill:CanUse4Ship(arg_15_1, arg_15_2)
	return underscore.any(self:GetEffectIds(), function(arg_16_0)
		return table.contains(arg_15_2, pg.island_buff_template[arg_16_0].buff_type) and var_0_1(self.isUsedToday, arg_15_1, pg.island_buff_template[arg_16_0])
	end)
end

function IslandShipSkill:Apply(arg_17_1, arg_17_2)
	if arg_17_2 == IslandBuffType.SHIP_POWER_RECOVER_BY_GREETING then
		for iter_17_0, iter_17_1 in ipairs(self:GetEffectIds()) do
			if pg.island_buff_template[iter_17_1].buff_type == arg_17_2 then
				arg_17_1:UpdateEnergy(arg_17_1:GetEnergy() + pg.island_buff_template[iter_17_1].type_use[2])
				self:UpdateUsedToday(true)
			end
		end
	elseif arg_17_2 == IslandBuffType.SHIP_AWARD_BY_GREETING then
		self:UpdateUsedToday(true)
	end

	return
end

function IslandShipSkill:UpdateUsedToday(arg_18_1)
	self.isUsedToday = arg_18_1

	return
end

function IslandShipSkill:GetLastEffectIds()
	return self:getConfig("skill_effect")[self.level - 1] or {}
end

function IslandShipSkill:GetEffectIds()
	return self:getConfig("skill_effect")[self.level] or {}
end

function IslandShipSkill:GetUnlockShipEffectIds()
	if self.lock then
		return {}
	end

	return underscore.select(self:GetEffectIds(), function(arg_22_0)
		return not IslandBuffType.IsGlobalType(pg.island_buff_template[arg_22_0].buff_type)
	end)
end

function IslandShipSkill:GetEffectDesc()
	if self.lock then
		return ""
	end

	local var_23_0 = Clone(self:getConfig("desc"))

	for iter_23_0, iter_23_1 in ipairs(self:getConfig("desc_add")) do
		var_23_0 = string.gsub(var_23_0, "$" .. iter_23_0, iter_23_1[self.level][1])
	end

	return var_23_0
end

function IslandShipSkill:IsEffectiveInPlace(arg_24_1)
	return underscore.any(self:GetEffectIds(), function(arg_25_0)
		if pg.island_buff_template[arg_25_0].buff_type == IslandBuffType.SHIP_POWER_RECOVER then
			return true
		end

		return IslandBuffType.IsLimitPlaceType(pg.island_buff_template[arg_25_0].buff_type) and table.contains(pg.island_buff_template[arg_25_0].type_use[1], arg_24_1)
	end)
end

function IslandShipSkill:IsEffectiveInRest(arg_26_1)
	return underscore.any(self:GetEffectIds(), function(arg_27_0)
		return IslandBuffType.IsLimitRestaurantType(pg.island_buff_template[arg_27_0].buff_type) and table.contains(pg.island_buff_template[arg_27_0].type_use[1], arg_26_1)
	end)
end

function IslandShipSkill:IsAllEffectiveType()
	return underscore.any(self:GetEffectIds(), function(arg_29_0)
		return pg.island_buff_template[arg_29_0].buff_type == IslandBuffType.SHIP_ATTR
	end)
end

function IslandShipSkill:IsPlaceDefaultEffectiveType()
	return underscore.any(self:GetEffectIds(), function(arg_31_0)
		return pg.island_buff_template[arg_31_0].buff_type == IslandBuffType.SHIP_POWER_RECOVER
	end)
end

function IslandShipSkill:GetUpgradeMaterial()
	local var_32_0 = {}

	for iter_32_0, iter_32_1 in ipairs(self:getConfig("material")[self.level] or {}) do
		table.insert(var_32_0, {
			type = DROP_TYPE_ISLAND_ITEM,
			id = iter_32_1[1],
			count = iter_32_1[2]
		})
	end

	return var_32_0
end

return IslandShipSkill
