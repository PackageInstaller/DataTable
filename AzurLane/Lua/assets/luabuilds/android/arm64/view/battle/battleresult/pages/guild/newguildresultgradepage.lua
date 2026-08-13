class = var_0_10000

local var_0_0 = "NewGuildResultGradePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..NewBattleResultGradePage"))

function var_0_1.LoadBG(arg_1_0, arg_1_1)
	local var_1_0 = "Victory"

	LoadAnyAsync = var_1_10003

	var_1_10003("BattleResultItems/" .. var_1_0, "", nil, function(arg_2_0)
		if not arg_1_0.exited then
			IsNil = var_1

			if var_1(arg_2_0) then
				if arg_1_1 then
					arg_1_1()
				end

				return
			end

			Object = var_1

			local var_2_0 = var_1.Instantiate(arg_2_0, arg_1_0.bgTr).transform

			var_2.SetAsFirstSibling(var_2_0)

			if arg_1_1 then
				arg_1_1()
			end

			return
		end
	end)

	return
end

function var_0_1.LoadGrade(arg_3_0, arg_3_1)
	local var_3_0 = "battlescore/grade_label_clear"

	LoadImageSpriteAsync = var_1_10003

	var_1_10003(var_3_0, arg_3_0.gradeTxt, true)

	if arg_3_1 then
		arg_3_1()
	end

	return
end

function var_0_1.GetContributionPoint(arg_4_0)
	local var_4_0 = 0

	pg = var_1_10002

	local var_4_1 = var_1_10002.guildset.guild_damage_resource.key_value

	ipairs = var_1_10003

	for iter_4_0, iter_4_1 in var_1_10003(arg_4_0.contextData.drops) do
		if iter_4_1.configId == var_4_1 then
			var_4_0 = iter_4_1.count
		end
	end

	return var_4_0
end

function var_0_1.GetGetObjectives(arg_5_0)
	local var_5_0 = {}

	i18n = var_1_10002

	local var_5_1 = var_1_10002("battle_result_total_damage")

	table = var_1_10003

	local var_5_2 = var_1_10003.insert
	local var_5_3 = var_5_0
	local var_5_4 = {}

	setColorStr = var_1_10007
	var_5_4.text = var_1_10007(var_5_1, "#FFFFFFFF")
	setColorStr = var_7

	local var_5_5 = arg_5_0.contextData.statistics.specificDamage

	COLOR_BLUE = var_10
	var_5_4.value = var_7(var_5_5, var_10)

	var_5_2(var_5_3, var_5_4)

	i18n = var_5_2

	local var_5_6 = var_5_2("battle_result_contribution")

	table = var_4

	local var_5_7 = var_4.insert
	local var_5_8 = var_5_0
	local var_5_9 = {}

	setColorStr = var_1_10008
	var_5_9.text = var_1_10008(var_5_6, "#FFFFFFFF")
	setColorStr = var_8

	local var_5_10 = arg_5_0:GetContributionPoint()

	COLOR_YELLOW = var_11
	var_5_9.value = var_8(var_5_10, var_11)

	var_5_7(var_5_8, var_5_9)

	return var_5_0
end

return var_0_1
