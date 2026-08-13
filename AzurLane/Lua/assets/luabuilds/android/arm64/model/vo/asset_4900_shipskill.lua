class = var_0_10000

local var_0_0 = "ShipSkill"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0

	if not arg_1_1.skill_id then
		var_1_0 = arg_1_1.id
	end

	arg_1_0.id = var_1_0
	arg_1_0.configId = arg_1_0.id

	local var_1_1

	if not arg_1_1.skill_lv and not arg_1_1.lv then
		var_1_1 = arg_1_1.level
	end

	arg_1_0.level = var_1_1

	local var_1_2

	if not arg_1_1.skill_exp then
		var_1_2 = arg_1_1.exp
	end

	arg_1_0.exp = var_1_2
	arg_1_0.maxLevel = arg_1_0:getConfig("max_level")
	pg = var_3
	arg_1_0.buff = var_3.buffCfg["buff_" .. arg_1_0.id]
	arg_1_0.shipId = arg_1_2

	return
end

function var_0_1.AddExp(arg_2_0, arg_2_1)
	if arg_2_0:IsMaxLevel() then
		return
	end

	local var_2_0 = arg_2_0:GetMaxLevel()
	local var_2_1 = arg_2_1 + arg_2_0.exp
	local var_2_2 = arg_2_0.level

	::label_2_0::

	pg = var_1_10005

	if var_1_10005.skill_need_exp[var_2_2].exp <= var_2_1 then
		repeat
			pg = var_1_10005
			var_2_1 = var_2_1 - var_1_10005.skill_need_exp[var_2_2].exp

			if var_2_2 + 1 == var_2_0 then
				var_2_1 = 0

				break
			end

			goto label_2_0
		until true
	end

	arg_2_0.level = var_2_2
	arg_2_0.exp = var_2_1

	return
end

function var_0_1.GetExp(arg_3_0)
	return arg_3_0.exp
end

function var_0_1.bindConfigTable(arg_4_0)
	pg = var_1_10001

	return var_1_10001.skill_data_template
end

function var_0_1.GetMaxLevel(arg_5_0)
	return arg_5_0.maxLevel
end

function var_0_1.WillReachMaxLevel(arg_6_0)
	return arg_6_0.level == arg_6_0.maxLevel - 1
end

function var_0_1.IsMaxLevel(arg_7_0)
	return arg_7_0.maxLevel <= arg_7_0.level
end

function var_0_1.GetNextLevelExp(arg_8_0)
	getConfigFromLevel1 = var_1_10001
	pg = var_1_10003

	return var_1_10001(var_1_10003.skill_need_exp, arg_8_0.level).exp
end

function var_0_1.StaticGetNextLevelExp(arg_9_0)
	getConfigFromLevel1 = var_1_10001
	pg = var_1_10003

	return var_1_10001(var_1_10003.skill_need_exp, arg_9_0).exp
end

function var_0_1.GetName(arg_10_0)
	local var_10_0 = arg_10_0:GetDisplayId()

	getSkillName = var_1_10002

	return var_1_10002(var_10_0)
end

function var_0_1.GetDesc(arg_11_0)
	local var_11_0 = arg_11_0:GetDisplayId()

	getSkillDesc = var_1_10002

	return var_1_10002(var_11_0, arg_11_0.level)
end

function var_0_1.GetTacticsDesc(arg_12_0)
	local var_12_0 = arg_12_0:GetDisplayId()

	Student = var_1_10002

	return var_1_10002.getSkillDesc(var_12_0, arg_12_0.level)
end

function var_0_1.GetIcon(arg_13_0)
	if arg_13_0:GetDisplayId() ~= arg_13_0.id then
		pg = var_2

		return var_2.buffCfg["buff_" .. var_1].icon
	else
		return arg_13_0.buff.icon
	end

	return
end

function var_0_1.GetColorType(arg_14_0)
	if arg_14_0:GetDisplayId() ~= arg_14_0.id then
		return var_0_1.bindConfigTable()[var_1].type
	else
		return arg_14_0:getConfig("type")
	end

	return
end

function var_0_1.GetDisplayId(arg_15_0)
	getProxy = var_1_10001
	BayProxy = var_1_10003

	local var_15_0 = var_1_10001(var_1_10003)
	local var_15_1

	if not var_1.RawGetShipById(var_15_0, arg_15_0.shipId) or not var_1:RemapSkillId(arg_15_0.id) then
		var_15_1 = arg_15_0.id
	end

	return var_15_1
end

return var_0_1
