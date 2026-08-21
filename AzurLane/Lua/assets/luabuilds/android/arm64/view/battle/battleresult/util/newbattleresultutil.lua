local var_0_0 = class("NewBattleResultUtil")

function var_0_0.Score2Grade(arg_1_0, arg_1_1)
	local var_1_0
	local var_1_1
	local var_1_2

	if arg_1_0 > 0 then
		var_1_2 = ({
			"d",
			"c",
			"b",
			"a",
			"s"
		})[arg_1_0 + 1]
		var_1_0 = "battlescore/battle_score_" .. ({
			"d",
			"c",
			"b",
			"a",
			"s"
		})[arg_1_0 + 1] .. "/letter_" .. ({
			"d",
			"c",
			"b",
			"a",
			"s"
		})[arg_1_0 + 1]
		var_1_1 = "battlescore/battle_score_" .. ({
			"d",
			"c",
			"b",
			"a",
			"s"
		})[arg_1_0 + 1] .. "/label_" .. ({
			"d",
			"c",
			"b",
			"a",
			"s"
		})[arg_1_0 + 1]
	else
		local var_1_3

		if arg_1_1 == ys.Battle.BattleConst.DEAD_FLAG then
			var_1_2 = ({
				"d",
				"c",
				"b",
				"a",
				"s"
			})[2]
			var_1_3 = "flag_destroy"
		else
			var_1_2 = ({
				"d",
				"c",
				"b",
				"a",
				"s"
			})[1]
		end

		var_1_0 = "battlescore/battle_score_" .. var_1_2 .. "/letter_" .. var_1_2
		var_1_1 = "battlescore/battle_score_" .. var_1_2 .. "/label_" .. (var_1_3 or var_1_2)
	end

	return var_1_0, var_1_1
end

function var_0_0.Score2Bg(arg_2_0)
	return arg_2_0 > 1 and "Victory" or "Failed"
end

function var_0_0.GetChapterName(arg_3_0)
	if pg.expedition_data_template[arg_3_0.stageId] then
		return pg.expedition_data_template[arg_3_0.stageId].name or ""
	end
end

local function var_0_1(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0 == 1 or arg_4_0 == 4 or arg_4_0 == 8 then
		return arg_4_1.score > 1
	elseif arg_4_0 == 2 or arg_4_0 == 3 then
		return not arg_4_1.statistics._deadUnit
	elseif arg_4_0 == 6 then
		return arg_4_1.statistics._boss_destruct < 1
	elseif arg_4_0 == 5 then
		return not arg_4_1.statistics._badTime
	elseif arg_4_0 == 7 then
		return true
	elseif arg_4_0 == 10 then
		return arg_4_2 > arg_4_1.statistics._bossHP * 100
	end

	return nil
end

local function var_0_2(arg_5_0)
	return ({
		"battle_result_victory",
		"battle_result_undefeated",
		"battle_result_sink_limit",
		"battle_preCombatLayer_time_hold",
		"battle_result_time_limit",
		"battle_result_boss_destruct",
		"battle_preCombatLayer_damage_before_end",
		"battle_result_defeat_all_enemys",
		"",
		"battle_result_boss_hp_lower"
	})[arg_5_0]
end

function var_0_0.ColorObjective(arg_6_0)
	local var_6_0
	local var_6_2

	if arg_6_0 == nil then
		var_6_0 = "check_mark"
		var_6_2 = "#FFFFFFFF"
	elseif arg_6_0 == true then
		var_6_0 = "jiesuan_bg22"
		var_6_2 = "#FFFFFFFF"
	else
		var_6_0 = "jiesuan_bg23"
		var_6_2 = "#FFFFFF80"
	end

	return var_6_0, var_6_2
end

function var_0_0.GetObjectives(arg_7_0)
	local var_7_0 = {}

	for iter_7_0 = 1, 3 do
		(function(arg_8_0)
			if not arg_8_0 or type(arg_8_0) ~= "table" then
				return
			end

			local var_8_0 = i18n(var_0_2(arg_8_0[1]), arg_8_0[2])
			local var_8_1, var_8_2 = var_0_0.ColorObjective((var_0_1(arg_8_0[1], arg_7_0, arg_8_0[2])))

			table.insert(var_7_0, {
				text = setColorStr(var_8_0, var_8_2),
				icon = var_8_1
			})

			return
		end)(pg.expedition_data_template[arg_7_0.stageId]["objective_" .. iter_7_0])
	end

	return {}
end

function var_0_0.IsOpBonus(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0) do
		if pg.benefit_buff_template[iter_9_1].benefit_type == Chapter.OPERATION_BUFF_TYPE_EXP then
			return true
		end
	end

	return false
end

function var_0_0.GetPlayerExpOffset(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.level
	local var_10_1 = arg_10_1.exp - arg_10_0.exp

	while var_10_0 < arg_10_1.level do
		var_10_1 = var_10_1 + pg.user_level[var_10_0].exp
		var_10_0 = var_10_0 + 1
	end

	if var_10_0 == pg.user_level[#pg.user_level].level then
		var_10_1 = 0
	end

	return var_10_1
end

function var_0_0.HasSubShip(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0) do
		if table.contains(ShipType.SubShipType, ys.Battle.BattleDataFunction.GetPlayerShipTmpDataFromID(iter_11_1.configId).type) then
			return true
		end
	end

	return false
end

function var_0_0.HasSurfaceShip(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0) do
		if not table.contains(ShipType.SubShipType, ys.Battle.BattleDataFunction.GetPlayerShipTmpDataFromID(iter_12_1.configId).type) then
			return true
		end
	end

	return false
end

function var_0_0.SeparateSurfaceAndSubShips(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0) do
		if table.contains(ShipType.SubShipType, ys.Battle.BattleDataFunction.GetPlayerShipTmpDataFromID(iter_13_1.configId).type) then
			table.insert({}, iter_13_1)
		else
			table.insert({}, iter_13_1)
		end
	end

	return {}, {}
end

function var_0_0.SeparateMvpShip(arg_14_0, arg_14_1, arg_14_2)
	if not arg_14_1 or arg_14_1 == 0 then
		arg_14_1 = arg_14_2
	end

	local var_14_0

	for iter_14_0, iter_14_1 in ipairs(arg_14_0) do
		if iter_14_1.id ~= arg_14_1 then
			local var_14_1 = ShipType.GetTeamFromShipType(ys.Battle.BattleDataFunction.GetPlayerShipTmpDataFromID(iter_14_1.configId).type)

			if var_14_1 == TeamType.Vanguard then
				table.insert({}, iter_14_1)
			elseif var_14_1 == TeamType.Main then
				table.insert({}, iter_14_1)
			elseif var_14_1 == TeamType.Submarine then
				table.insert({}, iter_14_1)
			end
		else
			var_14_0 = iter_14_1
		end
	end

	return {}, {}, {}, var_14_0
end

function var_0_0.SpecialInsertItem(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		table.insert(arg_15_0, iter_15_1)
	end

	for iter_15_2, iter_15_3 in ipairs(arg_15_2) do
		table.insert(arg_15_0, iter_15_3)
	end

	for iter_15_4, iter_15_5 in ipairs(arg_15_3) do
		table.insert(arg_15_0, iter_15_5)
	end

	table.insert(arg_15_0, #arg_15_0, arg_15_4)

	return
end

function var_0_0.GetShipExpOffset(arg_16_0, arg_16_1)
	assert(arg_16_1, arg_16_0:getConfig("name"))

	if arg_16_0.level < arg_16_1.level then
		local var_16_0 = arg_16_0:getConfig("rarity")
		local var_16_1 = 0

		for iter_16_0 = arg_16_0.level, arg_16_1.level - 1 do
			var_16_1 = var_16_1 + getExpByRarityFromLv1(var_16_0, iter_16_0)
		end

		return var_16_1 + arg_16_1:getExp() - arg_16_0:getExp()
	else
		return math.ceil(arg_16_1:getExp() - arg_16_0:getExp())
	end

	return
end

function var_0_0.GetSeasonScoreOffset(arg_17_0, arg_17_1)
	return arg_17_1.score - arg_17_0.score
end

function var_0_0.GetMaxOutput(arg_18_0, arg_18_1)
	local var_18_0 = 0

	if arg_18_1.mvpShipID == -1 then
		for iter_18_0, iter_18_1 in ipairs(arg_18_0) do
			local var_18_1 = arg_18_1[iter_18_1.id] or {}
			local var_18_3 = var_18_1.output or 0

			var_18_0 = var_18_2(var_18_3, var_18_0)
		end
	elseif arg_18_1.mvpShipID and arg_18_1.mvpShipID ~= 0 then
		local var_18_4 = arg_18_1[arg_18_1.mvpShipID] or {}

		var_18_0 = var_18_4.output or 0
	end

	return var_18_0
end

function var_0_0.RemoveNonStatisticShips(arg_19_0, arg_19_1)
	for iter_19_0, iter_19_1 in ipairs(arg_19_0) do
		if arg_19_1[iter_19_1.id] then
			table.insert({}, iter_19_1)
		end
	end

	return {}
end

return var_0_0
