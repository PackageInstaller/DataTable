local ShipSkill = class("ShipSkill", import(".BaseVO"))

function ShipSkill:Ctor(arg_1_1, arg_1_2)
	self.id = arg_1_1.skill_id or arg_1_1.id
	self.configId = self.id
	self.level = arg_1_1.skill_lv or arg_1_1.lv or arg_1_1.level
	self.exp = arg_1_1.skill_exp or arg_1_1.exp
	self.maxLevel = self:getConfig("max_level")
	self.buff = pg.buffCfg["buff_" .. self.id]
	self.shipId = arg_1_2

	return
end

function ShipSkill:AddExp(arg_2_1)
	if self:IsMaxLevel() then
		return
	end

	local var_2_0 = self:GetMaxLevel()
	local var_2_1 = arg_2_1 + self.exp
	local var_2_2 = self.level

	while var_2_1 >= pg.skill_need_exp[var_2_2].exp do
		var_2_1 = var_2_1 - pg.skill_need_exp[var_2_2].exp
		var_2_2 = var_2_2 + 1

		if var_2_2 == var_2_0 then
			var_2_1 = 0

			break
		end
	end

	self.level = var_2_2
	self.exp = var_2_1

	return
end

function ShipSkill:GetExp()
	return self.exp
end

function ShipSkill:bindConfigTable()
	return pg.skill_data_template
end

function ShipSkill:GetMaxLevel()
	return self.maxLevel
end

function ShipSkill:WillReachMaxLevel()
	return self.level == self.maxLevel - 1
end

function ShipSkill:IsMaxLevel()
	return self.maxLevel <= self.level
end

function ShipSkill:GetNextLevelExp()
	return getConfigFromLevel1(pg.skill_need_exp, self.level).exp
end

function ShipSkill:StaticGetNextLevelExp()
	return getConfigFromLevel1(pg.skill_need_exp, self).exp
end

function ShipSkill:GetName()
	return getSkillName((self:GetDisplayId()))
end

function ShipSkill:GetDesc()
	return getSkillDesc(self:GetDisplayId(), self.level)
end

function ShipSkill:GetTacticsDesc()
	return Student.getSkillDesc(self:GetDisplayId(), self.level)
end

function ShipSkill:GetIcon()
	local var_13_0 = self:GetDisplayId()

	if var_13_0 ~= self.id then
		return pg.buffCfg["buff_" .. var_13_0].icon
	else
		return self.buff.icon
	end

	return
end

function ShipSkill:GetColorType()
	local var_14_0 = self:GetDisplayId()

	if var_14_0 ~= self.id then
		return ShipSkill.bindConfigTable()[var_14_0].type
	else
		return self:getConfig("type")
	end

	return
end

function ShipSkill:GetDisplayId()
	local var_15_0 = getProxy(BayProxy):RawGetShipById(self.shipId)

	return var_15_0 and var_15_0:RemapSkillId(self.id) or self.id
end

return ShipSkill
