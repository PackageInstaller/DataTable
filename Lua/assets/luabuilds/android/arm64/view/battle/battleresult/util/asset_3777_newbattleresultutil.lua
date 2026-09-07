local NewBattleResultUtil = class("NewBattleResultUtil")

function NewBattleResultUtil:Score2Grade(arg_1_1)
	local var_1_0 = {
		"d",
		"c",
		"b",
		"a",
		"s"
	}
	local var_1_1
	local var_1_2
	local var_1_3

	if self > 0 then
		var_1_3 = var_1_0[self + 1]
		var_1_1 = "battlescore/battle_score_" .. var_1_0[self + 1] .. "/letter_" .. var_1_0[self + 1]
		var_1_2 = "battlescore/battle_score_" .. var_1_0[self + 1] .. "/label_" .. var_1_0[self + 1]
	else
		local var_1_4

		if arg_1_1 == ys.Battle.BattleConst.DEAD_FLAG then
			var_1_3 = var_1_0[2]
			var_1_4 = "flag_destroy"
		else
			var_1_3 = var_1_0[1]
		end

		var_1_1 = "battlescore/battle_score_" .. var_1_3 .. "/letter_" .. var_1_3
		var_1_2 = "battlescore/battle_score_" .. var_1_3 .. "/label_" .. (var_1_4 or var_1_3)
	end

	return var_1_1, var_1_2
end

function NewBattleResultUtil:Score2Bg()
	return self > 1 and "Victory" or "Failed"
end

function NewBattleResultUtil:GetChapterName()
	return (pg.expedition_data_template[self.stageId] or nil) and (pg.expedition_data_template[self.stageId].name or "")
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

function NewBattleResultUtil:ColorObjective()
	local var_6_0
	local var_6_2

	if self == nil then
		var_6_0 = "check_mark"
		var_6_2 = "#FFFFFFFF"
	elseif self == true then
		var_6_0 = "jiesuan_bg22"
		var_6_2 = "#FFFFFFFF"
	else
		var_6_0 = "jiesuan_bg23"
		var_6_2 = "#FFFFFF80"
	end

	return var_6_0, var_6_2
end

function NewBattleResultUtil:GetObjectives()
	local var_7_0 = {}

	local function var_7_1(arg_8_0)
		if not arg_8_0 or type(arg_8_0) ~= "table" then
			return
		end

		local var_8_0 = i18n(var_0_2(arg_8_0[1]), arg_8_0[2])
		local var_8_1, var_8_2 = NewBattleResultUtil.ColorObjective((var_0_1(arg_8_0[1], self, arg_8_0[2])))

		table.insert(var_7_0, {
			text = setColorStr(var_8_0, var_8_2),
			icon = var_8_1
		})

		return
	end

	for iter_7_0 = 1, 3 do
		var_7_1(pg.expedition_data_template[self.stageId]["objective_" .. iter_7_0])
	end

	return var_7_0
end

function NewBattleResultUtil:IsOpBonus()
	for iter_9_0, iter_9_1 in ipairs(self) do
		if pg.benefit_buff_template[iter_9_1].benefit_type == Chapter.OPERATION_BUFF_TYPE_EXP then
			return true
		end
	end

	return false
end

function NewBattleResultUtil:GetPlayerExpOffset(arg_10_1)
	local var_10_0 = self.level
	local var_10_1 = arg_10_1.exp - self.exp

	while var_10_0 < arg_10_1.level do
		var_10_1 = var_10_1 + pg.user_level[var_10_0].exp
		var_10_0 = var_10_0 + 1
	end

	if var_10_0 == pg.user_level[#pg.user_level].level then
		var_10_1 = 0
	end

	return var_10_1
end

function NewBattleResultUtil:HasSubShip()
	for iter_11_0, iter_11_1 in ipairs(self) do
		if table.contains(ShipType.SubShipType, ys.Battle.BattleDataFunction.GetPlayerShipTmpDataFromID(iter_11_1.configId).type) then
			return true
		end
	end

	return false
end

function NewBattleResultUtil:HasSurfaceShip()
	for iter_12_0, iter_12_1 in ipairs(self) do
		if not table.contains(ShipType.SubShipType, ys.Battle.BattleDataFunction.GetPlayerShipTmpDataFromID(iter_12_1.configId).type) then
			return true
		end
	end

	return false
end

function NewBattleResultUtil:SeparateSurfaceAndSubShips()
	local var_13_0 = {}
	local var_13_1 = {}

	for iter_13_0, iter_13_1 in ipairs(self) do
		if table.contains(ShipType.SubShipType, ys.Battle.BattleDataFunction.GetPlayerShipTmpDataFromID(iter_13_1.configId).type) then
			table.insert(var_13_1, iter_13_1)
		else
			table.insert(var_13_0, iter_13_1)
		end
	end

	return var_13_0, var_13_1
end

function NewBattleResultUtil:SeparateMvpShip(arg_14_1, arg_14_2)
	if not arg_14_1 or arg_14_1 == 0 then
		arg_14_1 = arg_14_2
	end

	local var_14_0
	local var_14_1 = {}
	local var_14_2 = {}
	local var_14_3 = {}

	for iter_14_0, iter_14_1 in ipairs(self) do
		if iter_14_1.id ~= arg_14_1 then
			local var_14_4 = ShipType.GetTeamFromShipType(ys.Battle.BattleDataFunction.GetPlayerShipTmpDataFromID(iter_14_1.configId).type)

			if var_14_4 == TeamType.Vanguard then
				table.insert(var_14_1, iter_14_1)
			elseif var_14_4 == TeamType.Main then
				table.insert(var_14_2, iter_14_1)
			elseif var_14_4 == TeamType.Submarine then
				table.insert(var_14_3, iter_14_1)
			end
		else
			var_14_0 = iter_14_1
		end
	end

	return var_14_1, var_14_2, var_14_3, var_14_0
end

function NewBattleResultUtil:SpecialInsertItem(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		table.insert(self, iter_15_1)
	end

	for iter_15_2, iter_15_3 in ipairs(arg_15_2) do
		table.insert(self, iter_15_3)
	end

	for iter_15_4, iter_15_5 in ipairs(arg_15_3) do
		table.insert(self, iter_15_5)
	end

	table.insert(self, #self, arg_15_4)

	return
end

function NewBattleResultUtil:GetShipExpOffset(arg_16_1)
	assert(arg_16_1, self:getConfig("name"))

	if self.level < arg_16_1.level then
		local var_16_0 = self:getConfig("rarity")
		local var_16_1 = 0

		for iter_16_0 = self.level, arg_16_1.level - 1 do
			var_16_1 = var_16_1 + getExpByRarityFromLv1(var_16_0, iter_16_0)
		end

		return var_16_1 + arg_16_1:getExp() - self:getExp()
	else
		return math.ceil(arg_16_1:getExp() - self:getExp())
	end

	return
end

function NewBattleResultUtil:GetSeasonScoreOffset(arg_17_1)
	return arg_17_1.score - self.score
end

function NewBattleResultUtil:GetMaxOutput(arg_18_1)
	local var_18_0 = 0

	if arg_18_1.mvpShipID == -1 then
		for iter_18_0, iter_18_1 in ipairs(self) do
			var_18_0 = math.max((arg_18_1[iter_18_1.id] or {}).output or 0, var_18_0)
		end
	elseif arg_18_1.mvpShipID and arg_18_1.mvpShipID ~= 0 then
		var_18_0 = (arg_18_1[arg_18_1.mvpShipID] or {}).output or 0
	end

	return var_18_0
end

function NewBattleResultUtil:RemoveNonStatisticShips(arg_19_1)
	local var_19_0 = {}

	for iter_19_0, iter_19_1 in ipairs(self) do
		if arg_19_1[iter_19_1.id] then
			table.insert(var_19_0, iter_19_1)
		end
	end

	return var_19_0
end

return NewBattleResultUtil
