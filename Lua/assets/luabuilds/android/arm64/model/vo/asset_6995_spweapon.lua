local SpWeapon = class("SpWeapon", import(".BaseVO"))

SpWeapon.type = DROP_TYPE_SPWEAPON
SpWeapon.CONFIRM_OP_DISCARD = 0
SpWeapon.CONFIRM_OP_EXCHANGE = 1

function SpWeapon:Ctor(arg_1_1)
	SpWeapon.super.Ctor(self, arg_1_1)

	self.configId = arg_1_1.id

	return
end

function SpWeapon:CreateByNet()
	if self.template_id == 0 then
		return
	end

	return SpWeapon.New({
		uid = self.id,
		id = self.template_id,
		attr1 = self.attr_1,
		attr2 = self.attr_2,
		attrTemp1 = self.attr_temp_1,
		attrTemp2 = self.attr_temp_2,
		pt = self.pt
	})
end

function SpWeapon:bindConfigTable()
	return pg.spweapon_data_statistics
end

function SpWeapon:GetUID()
	return self.uid
end

function SpWeapon:IsReal()
	return tobool(self:GetUID())
end

function SpWeapon:GetConfigID()
	return self.configId
end

function SpWeapon:GetOriginID()
	return self:getConfig("base") or self:GetConfigID()
end

function SpWeapon:IsImportant()
	return self:getConfig("important") == 2
end

function SpWeapon:IsUnique()
	return self:getConfig("unique") ~= 0
end

function SpWeapon:GetUniqueGroup()
	return self:getConfig("unique")
end

function SpWeapon:GetType()
	return self:getConfig("type")
end

function SpWeapon:GetName()
	return self:getConfig("name")
end

function SpWeapon:GetLevel()
	return self:getConfig("level")
end

function SpWeapon:GetTechTier()
	return self:getConfig("tech")
end

function SpWeapon:GetIconPath()
	return "SpWeapon/" .. self:getConfig("icon")
end

function SpWeapon:GetRarity()
	return self:getConfig("rarity")
end

function SpWeapon:GetPt()
	return (self:IsReal() or nil) and (self.pt or 0)
end

function SpWeapon:SetPt(arg_18_1)
	assert(arg_18_1)

	self.pt = arg_18_1 or 0

	return
end

function SpWeapon:GetEffect()
	return self:getConfig("effect_id")
end

function SpWeapon:GetDisplayEffect()
	return self:getConfig("effect_id_display")
end

function SpWeapon:GetUpgradableSkillIds()
	return self:getConfig("skill_upgrade")
end

function SpWeapon:GetUpgradableHiddenSkillIds()
	return self:getConfig("hide_buff_upgrade")
end

function SpWeapon:GetNextUpgradeID()
	return self:getConfig("next")
end

function SpWeapon:GetPrevUpgradeID()
	return self:getConfig("prev")
end

function SpWeapon:MigrateTo(arg_25_1)
	local var_25_0 = Clone(self)

	var_25_0.id = arg_25_1
	var_25_0.configId = arg_25_1
	var_25_0.pt = 0

	return var_25_0
end

function SpWeapon:GetLabel()
	return self:getConfig("label")
end

function SpWeapon:SetShipId(arg_27_1)
	self.shipId = arg_27_1

	return
end

function SpWeapon:GetShipId()
	return self.shipId
end

function SpWeapon:GetSkill()
	local var_29_0 = self:GetEffect()

	return var_29_0 > 0 and getSkillConfig(var_29_0) or nil
end

function SpWeapon:GetSkillInfo()
	local var_30_0 = {
		lv = 1,
		skillId = self:GetDisplayEffect()
	}

	var_30_0.unlock = var_30_0.skillId == self:GetEffect()

	local var_30_1 = self:GetShipId()

	if not var_30_1 or var_30_1 == 0 then
		var_30_0.descTrigger = true
	end

	return var_30_0
end

function SpWeapon:GetUpgradableSkillInfo()
	local var_31_0 = self:GetShipId()
	local var_31_1 = {}
	local var_31_2
	local var_31_3

	if var_31_0 then
		var_31_2 = getProxy(BayProxy):getShipById(var_31_0)
		var_31_3 = self:GetActiveUpgradableSkillList(var_31_2)
	end

	for iter_31_0, iter_31_1 in ipairs(self:GetUpgradableSkillIds()) do
		local var_31_4 = iter_31_1[2]
		local var_31_5 = 1
		local var_31_6 = false

		if var_31_2 then
			for iter_31_2, iter_31_3 in ipairs(var_31_3) do
				if iter_31_3.mapSkillID == iter_31_1[2] and iter_31_3.originalSkillID == iter_31_1[1] then
					var_31_5 = var_31_2.skills[iter_31_3.originalSkillID] and var_31_2.skills[iter_31_3.originalSkillID].level or 1
					var_31_6 = true

					break
				end
			end
		else
			var_31_6 = var_31_6 or iter_31_1[1] ~= 0
		end

		table.insert(var_31_1, {
			skillId = var_31_4,
			lv = var_31_5,
			unlock = var_31_6,
			descTrigger = not var_31_2 or nil
		})
	end

	return var_31_1
end

function SpWeapon:GetActiveUpgradableSkillList(arg_32_1)
	local var_32_0 = {}

	for iter_32_0, iter_32_1 in ipairs(arg_32_1:getSkillList()) do
		local var_32_1, var_32_2 = self:RemapSkillId(iter_32_1)

		if var_32_2 then
			table.insert(var_32_0, {
				mapSkillID = var_32_1,
				originalSkillID = iter_32_1
			})
		end
	end

	for iter_32_2, iter_32_3 in ipairs(pg.ship_data_template[arg_32_1.configId].hide_buff_list) do
		local var_32_3, var_32_4 = self:RemapSkillId(iter_32_3)

		if var_32_4 then
			table.insert(var_32_0, {
				mapSkillID = var_32_3,
				originalSkillID = iter_32_3
			})
		end
	end

	return var_32_0
end

function SpWeapon:RemapSkillId(arg_33_1)
	for iter_33_0, iter_33_1 in ipairs(self:GetUpgradableSkillIds()) do
		if iter_33_1[1] == arg_33_1 then
			return iter_33_1[2], true
		end
	end

	return arg_33_1, false
end

function SpWeapon:RemapHiddenSkillId(arg_34_1)
	for iter_34_0, iter_34_1 in ipairs(self:GetUpgradableHiddenSkillIds()) do
		if iter_34_1[1] == arg_34_1 then
			return iter_34_1[2], true
		end
	end

	return arg_34_1, false
end

function SpWeapon:GetSkillGroup()
	return {
		self:GetSkillInfo(),
		(self:GetUpgradableSkillInfo())
	}
end

function SpWeapon:GetConfigAttributes()
	return {
		self:getConfig("value_1"),
		self:getConfig("value_2")
	}
end

function SpWeapon:GetAttributesRange()
	return {
		self:getConfig("value_1_random"),
		self:getConfig("value_2_random")
	}
end

function SpWeapon:GetAttributes()
	local var_38_0 = self:GetConfigAttributes()

	if self:IsReal() then
		var_38_0[1] = var_38_0[1] + self.attr1
		var_38_0[2] = var_38_0[2] + self.attr2
	end

	return var_38_0
end

function SpWeapon:GetBaseAttributes()
	local var_39_0 = {}

	var_39_0[1] = self.attr1 or 0
	var_39_0[2] = self.attr2 or 0

	return var_39_0
end

function SpWeapon:SetBaseAttributes(arg_40_1)
	self.attr1 = arg_40_1[1]
	self.attr2 = arg_40_1[2]

	return
end

function SpWeapon:GetAttributeOptions()
	local var_41_0 = {}

	var_41_0[1] = self.attrTemp1 or 0
	var_41_0[2] = self.attrTemp2 or 0

	return var_41_0
end

function SpWeapon:SetAttributeOptions(arg_42_1)
	self.attrTemp1 = arg_42_1[1]
	self.attrTemp2 = arg_42_1[2]

	return
end

function SpWeapon:GetPropertiesInfo()
	local var_43_0 = {
		attrs = {}
	}
	local var_43_1 = self:GetAttributes()

	table.insert(var_43_0.attrs, {
		type = self:getConfig("attribute_1"),
		value = var_43_1[1]
	})
	table.insert(var_43_0.attrs, {
		type = self:getConfig("attribute_2"),
		value = var_43_1[2]
	})

	var_43_0.weapon = {
		sub = {}
	}
	var_43_0.equipInfo = {
		sub = {}
	}

	local var_43_2 = self:GetWearableShipTypes()

	var_43_0.part = {
		var_43_2,
		var_43_2
	}

	return var_43_0
end

function SpWeapon:GetWearableShipTypes()
	local var_44_0 = self:getConfig("usability")

	if var_44_0 and #var_44_0 > 0 then
		return var_44_0
	end

	return pg.spweapon_type[self:GetType()].ship_type
end

function SpWeapon:IsCraftable()
	return not self:IsUnCraftable() and self:GetUpgradeConfig().create_use_gold > 0
end

function SpWeapon:GetUpgradeConfig()
	return pg.spweapon_upgrade[self:getConfig("upgrade_id")]
end

function SpWeapon:IsUnCraftable()
	return self:getConfig("uncraftable") == 1
end

function SpWeapon:CalculateHistoryPt(arg_48_1)
	return (_.reduce(arg_48_1, _.reduce(self, 0, function(arg_49_0, arg_49_1)
		return arg_49_0 + Item.getConfigData(arg_49_1.id).usage_arg[1] * arg_49_1.count
	end), function(arg_50_0, arg_50_1)
		return arg_50_0 + (0 + arg_50_1:GetUpgradeConfig().upgrade_supply_pt)
	end))
end

function SpWeapon:IsMatchKey(arg_51_1)
	return EquipmentTools.IsMatchKey({
		self:getConfig("name")
	}, arg_51_1)
end

return SpWeapon
