class = var_0_10000

local var_0_0 = "CommanderSkill"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.exp = arg_1_1.exp

	return
end

function var_0_1.getExp(arg_2_0)
	return arg_2_0.exp
end

function var_0_1.bindConfigTable(arg_3_0)
	pg = var_1_10001

	return var_1_10001.commander_skill_template
end

function var_0_1.getLevel(arg_4_0)
	return arg_4_0:getConfig("lv")
end

function var_0_1.isMaxLevel(arg_5_0)
	return arg_5_0:getConfig("next_id") == 0
end

function var_0_1.getNextLevelExp(arg_6_0)
	return arg_6_0:getConfig("exp")
end

function var_0_1.addExp(arg_7_0, arg_7_1)
	arg_7_0.exp = arg_7_0.exp + arg_7_1

	while arg_7_0:canLevelUp() do
		arg_7_0.exp = arg_7_0.exp - arg_7_0:getNextLevelExp()
		arg_7_0.id = arg_7_0:getConfig("next_id")
		arg_7_0.configId = arg_7_0.id
	end

	return
end

function var_0_1.canLevelUp(arg_8_0)
	return arg_8_0:getNextLevelExp() <= arg_8_0.exp and not arg_8_0:isMaxLevel()
end

function var_0_1.getTacticSkill(arg_9_0)
	return arg_9_0:getConfig("effect_tactic")
end

function var_0_1.GetTacticSkillForWorld(arg_10_0)
	return arg_10_0:getConfig("effect_tactic_world")
end

function var_0_1.GetSkillGroup(arg_11_0)
	local var_11_0 = {}
	local var_11_1 = arg_11_0
	local var_11_2 = arg_11_0.getConfig(var_11_1, "prev_id")

	while var_11_2 and var_11_2 ~= 0 do
		pg = var_11_1
		var_11_1 = var_11_1.commander_skill_template[var_11_2]
		table = var_4

		var_4.insert(var_11_0, var_11_1)

		var_11_2 = var_11_1.prev_id
	end

	table = var_11_1

	local var_11_3 = var_11_1.insert
	local var_11_4 = var_11_0

	pg = var_1_10005

	var_11_3(var_11_4, var_1_10005.commander_skill_template[arg_11_0.configId])

	local var_11_5 = arg_11_0
	local var_11_6 = arg_11_0.getConfig(var_11_5, "next_id")

	while var_11_6 and var_11_6 ~= 0 do
		pg = var_11_5
		var_11_5 = var_11_5.commander_skill_template[var_11_6]
		table = var_5

		var_5.insert(var_11_0, var_11_5)

		var_11_6 = var_11_5.next_id
	end

	table = var_11_5

	var_11_5.sort(var_11_0, function(arg_12_0, arg_12_1)
		return arg_12_0.lv < arg_12_1.lv
	end)

	return var_11_0
end

return var_0_1
