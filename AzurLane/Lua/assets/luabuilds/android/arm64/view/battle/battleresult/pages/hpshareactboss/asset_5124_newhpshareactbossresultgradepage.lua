class = var_0_10000

local var_0_0 = "NewHpShareActBossResultGradePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..activityBoss.NewActivityBossResultGradePage"))

function var_0_1.LoadGrade(arg_1_0, arg_1_1)
	local var_1_0 = "battlescore/grade_label_clear"

	LoadImageSpriteAsync = var_1_10003

	var_1_10003(var_1_0, arg_1_0.gradeTxt, true)

	if arg_1_1 then
		arg_1_1()
	end

	return
end

function var_0_1.GetContributionPoint(arg_2_0)
	local var_2_0 = arg_2_0.contextData

	pg = var_1_10002

	local var_2_1 = var_1_10002.activity_template[var_2_0.actId]

	pg = var_3

	local var_2_2 = var_3.activity_event_worldboss[var_2_1.config_id].damage_resource
	local var_2_3 = 0

	ipairs = var_1_10005

	for iter_2_0, iter_2_1 in var_1_10005(var_2_0.drops) do
		if iter_2_1.configId == var_2_2 then
			var_2_3 = iter_2_1.count
		end
	end

	return var_2_3
end

function var_0_1.GetGetObjectives(arg_3_0)
	local var_3_0 = arg_3_0.contextData
	local var_3_1 = {}
	local var_3_2 = arg_3_0
	local var_3_3 = arg_3_0.GetContributionPoint(var_3_2)

	i18n = var_1_10004

	local var_3_4 = var_1_10004("battle_result_total_damage")

	table = var_3_2

	local var_3_5 = var_3_2.insert
	local var_3_6 = var_3_1
	local var_3_7 = {}

	setColorStr = var_1_10009
	var_3_7.text = var_1_10009(var_3_4, "#FFFFFFFF")
	setColorStr = var_9

	local var_3_8 = var_3_0.statistics.specificDamage

	COLOR_BLUE = var_12
	var_3_7.value = var_9(var_3_8, var_12)

	var_3_5(var_3_6, var_3_7)

	i18n = var_3_5

	local var_3_9 = var_3_5("battle_result_contribution")

	table = var_6

	local var_3_10 = var_6.insert
	local var_3_11 = var_3_1
	local var_3_12 = {}

	setColorStr = var_1_10010
	var_3_12.text = var_1_10010(var_3_9, "#FFFFFFFF")
	setColorStr = var_10

	local var_3_13 = var_3_3

	COLOR_YELLOW = var_13
	var_3_12.value = var_10(var_3_13, var_13)

	var_3_10(var_3_11, var_3_12)

	return var_3_1
end

return var_0_1
