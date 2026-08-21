local var_0_0 = class("CommanderSkill", import("..BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.exp = arg_1_1.exp

	return
end

function var_0_0.getExp(arg_2_0)
	return arg_2_0.exp
end

function var_0_0.bindConfigTable(arg_3_0)
	return pg.commander_skill_template
end

function var_0_0.getLevel(arg_4_0)
	return arg_4_0:getConfig("lv")
end

function var_0_0.isMaxLevel(arg_5_0)
	return arg_5_0:getConfig("next_id") == 0
end

function var_0_0.getNextLevelExp(arg_6_0)
	return arg_6_0:getConfig("exp")
end

function var_0_0.addExp(arg_7_0, arg_7_1)
	arg_7_0.exp = arg_7_0.exp + arg_7_1

	while arg_7_0:canLevelUp() do
		arg_7_0.exp = arg_7_0.exp - arg_7_0:getNextLevelExp()
		arg_7_0.id = arg_7_0:getConfig("next_id")
		arg_7_0.configId = arg_7_0.id
	end

	return
end

function var_0_0.canLevelUp(arg_8_0)
	return arg_8_0:getNextLevelExp() <= arg_8_0.exp and not arg_8_0:isMaxLevel()
end

function var_0_0.getTacticSkill(arg_9_0)
	return arg_9_0:getConfig("effect_tactic")
end

function var_0_0.GetTacticSkillForWorld(arg_10_0)
	return arg_10_0:getConfig("effect_tactic_world")
end

function var_0_0.GetSkillGroup(arg_11_0)
	local var_11_0 = arg_11_0:getConfig("prev_id")

	while var_11_0 and var_11_0 ~= 0 do
		table.insert({}, pg.commander_skill_template[var_11_0])

		var_11_0 = pg.commander_skill_template[var_11_0].prev_id
	end

	table.insert({}, pg.commander_skill_template[arg_11_0.configId])

	local var_11_1 = arg_11_0:getConfig("next_id")

	while var_11_1 and var_11_1 ~= 0 do
		table.insert({}, pg.commander_skill_template[var_11_1])

		var_11_1 = pg.commander_skill_template[var_11_1].next_id
	end

	table.sort({}, function(arg_12_0, arg_12_1)
		return arg_12_0.lv < arg_12_1.lv
	end)

	return {}
end

return var_0_0
