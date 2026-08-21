local var_0_0 = class("ShipSkill", import(".BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1.skill_id or arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.level = arg_1_1.skill_lv or arg_1_1.lv or arg_1_1.level
	arg_1_0.exp = arg_1_1.skill_exp or arg_1_1.exp
	arg_1_0.maxLevel = arg_1_0:getConfig("max_level")
	arg_1_0.buff = pg.buffCfg["buff_" .. arg_1_0.id]
	arg_1_0.shipId = arg_1_2

	return
end

function var_0_0.AddExp(arg_2_0, arg_2_1)
	if arg_2_0:IsMaxLevel() then
		return
	end

	local var_2_0 = arg_2_0:GetMaxLevel()
	local var_2_1 = arg_2_1 + arg_2_0.exp
	local var_2_2 = arg_2_0.level

	while var_2_1 >= pg.skill_need_exp[var_2_2].exp do
		var_2_1 = var_2_1 - pg.skill_need_exp[var_2_2].exp
		var_2_2 = var_2_2 + 1

		if var_2_2 == var_2_0 then
			var_2_1 = 0

			break
		end
	end

	arg_2_0.level = var_2_2
	arg_2_0.exp = var_2_1

	return
end

function var_0_0.GetExp(arg_3_0)
	return arg_3_0.exp
end

function var_0_0.bindConfigTable(arg_4_0)
	return pg.skill_data_template
end

function var_0_0.GetMaxLevel(arg_5_0)
	return arg_5_0.maxLevel
end

function var_0_0.WillReachMaxLevel(arg_6_0)
	return arg_6_0.level == arg_6_0.maxLevel - 1
end

function var_0_0.IsMaxLevel(arg_7_0)
	return arg_7_0.maxLevel <= arg_7_0.level
end

function var_0_0.GetNextLevelExp(arg_8_0)
	return getConfigFromLevel1(pg.skill_need_exp, arg_8_0.level).exp
end

function var_0_0.StaticGetNextLevelExp(arg_9_0)
	return getConfigFromLevel1(pg.skill_need_exp, arg_9_0).exp
end

function var_0_0.GetName(arg_10_0)
	return getSkillName((arg_10_0:GetDisplayId()))
end

function var_0_0.GetDesc(arg_11_0)
	return getSkillDesc(arg_11_0:GetDisplayId(), arg_11_0.level)
end

function var_0_0.GetTacticsDesc(arg_12_0)
	return Student.getSkillDesc(arg_12_0:GetDisplayId(), arg_12_0.level)
end

function var_0_0.GetIcon(arg_13_0)
	local var_13_0 = arg_13_0:GetDisplayId()

	if var_13_0 ~= arg_13_0.id then
		return pg.buffCfg["buff_" .. var_13_0].icon
	else
		return arg_13_0.buff.icon
	end

	return
end

function var_0_0.GetColorType(arg_14_0)
	local var_14_0 = arg_14_0:GetDisplayId()

	if var_14_0 ~= arg_14_0.id then
		return var_0_0.bindConfigTable()[var_14_0].type
	else
		return arg_14_0:getConfig("type")
	end

	return
end

function var_0_0.GetDisplayId(arg_15_0)
	local var_15_0 = getProxy(BayProxy):RawGetShipById(arg_15_0.shipId)

	return var_15_0 and var_15_0:RemapSkillId(arg_15_0.id) or arg_15_0.id
end

return var_0_0
