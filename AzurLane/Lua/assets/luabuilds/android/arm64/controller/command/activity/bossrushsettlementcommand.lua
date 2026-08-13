class = var_0_10000

local var_0_0 = "BossRushSettlementCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.body

	pg = var_1_10003

	local var_1_1 = var_1_10003.ConnectionMgr.GetInstance()

	var_3.Send(var_1_1, 11202, {
		cmd = 2,
		activity_id = var_1_0.actId
	}, 11203, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			ActivityProxy = var_2_10003

			local var_2_0 = var_1(var_2_10003)

			var_2_10004 = var_1.getActivityById(var_2_0, var_1_0.actId)

			local var_2_1 = var_1.GetSeriesData(var_2_10004)

			var_1:SetSeriesData(nil)

			PlayerConst = var_3

			local var_2_2 = var_3.GetTranAwards(var_1_0, arg_2_0)

			var_2_10004 = var_1_0.actId
			getProxy = var_5
			ActivityProxy = var_2_10007

			local var_2_3 = var_5(var_2_10007)
			local var_2_4 = var_5.GetBossRushRuntime(var_2_3, var_2_10004).settlementData

			getProxy = var_6
			ActivityProxy = var_8

			local var_2_5 = var_6(var_8)

			var_6.GetBossRushRuntime(var_2_5, var_1.id).settlementData = nil

			local var_2_6

			if var_2_4.win then
				local var_2_7 = var_1

				var_1.AddPassSeries(var_2_7, var_2_4.seriesId)

				getProxy = var_7
				ChapterProxy = var_2_7

				local var_2_8 = var_7(var_2_7)

				var_7.addRemasterPassCount(var_2_8, var_2_4.seriesId, var_1_0.actId)

				BossRushChapterRemasterHelper = var_7
				var_2_6 = var_7.GetActivityRemasterByFinalSeriesId(var_1_0.actId, var_2_4.seriesId) and var_7.memory_group

				local var_2_9 = var_1:getConfig("type")

				ActivityConst = var_9

				if var_2_9 ~= var_9.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB then
					var_1:AddUsedBonus(var_2_4.seriesId)
				end
			end

			ipairs = var_7

			for iter_2_0, iter_2_1 in var_7(var_2_4) do
				table = var_2_10012

				var_2_10012.insertto(var_2_2, iter_2_1.drops)

				table = var_2_10012

				var_2_10012.insertto(var_2_2, iter_2_1.extraDrops)
			end

			local var_2_10

			if var_2_1 then
				var_2_10 = var_2_1

				var_2_1.AddFinalResults(var_2_10, var_2_4)
			end

			getProxy = var_7
			ActivityProxy = var_2_10

			local var_2_11 = var_7(var_2_10)

			var_7.updateActivity(var_2_11, var_1)

			seriesAsync = var_7

			var_7({
				function(arg_3_0, arg_3_1)
					local var_3_0 = {
						seriesData = var_2_1,
						activityId = var_1_0.actId,
						awards = var_2_2,
						callback = arg_3_0
					}

					if var_1_0.callback then
						var_1_0.callback(var_3_0)
					else
						local var_3_1 = arg_1_0
						local var_3_2 = var_3.sendNotification

						GAME = var_3_10006

						var_3_2(var_3_1, var_3_10006.BOSSRUSH_SETTLE_DONE, var_3_0)
					end

					return
				end,
				function(arg_4_0)
					BossRushChapterRemasterHelper = var_3_10001

					if not var_3_10001.UnlockMemoryGroupStoriesAndShowMsgBox(var_2_6, function(arg_5_0)
						arg_4_0(arg_5_0)

						return
					end) then
						arg_4_0({})
					end

					return
				end
			})
		else
			pg = var_1

			local var_2_12 = var_1.TipsMgr.GetInstance()
			local var_2_13 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_13(var_2_12, var_2_10004("", arg_2_0.result))
		end

		return
	end)

	return
end

function var_0_1.ConcludeEXP(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.system
	local var_6_1 = arg_6_0.arg1
	local var_6_2

	SYSTEM_BOSS_RUSH_COLLABRATE = var_1_10006

	if var_6_0 == var_1_10006 then
		ipairs = var_1_10006
		pg = var_1_10008

		for iter_6_0, iter_6_1 in var_1_10006(var_1_10008.extraenemy_series_template) do
			pg = var_1_10011
			var_1_10011 = var_1_10011.extraenemy_series_template[iter_6_1]
			table = var_1_10012

			if var_1_10012.contains(var_1_10011.activity_series_enemy_id, var_6_1) then
				CollabrateBossRushSeriesData = var_1_10012
				var_6_2 = var_1_10012.New({
					id = iter_6_1,
					actId = arg_6_1.id
				})
				var_6_1 = iter_6_1

				break
			end
		end
	else
		BossRushSeriesData = var_1_10006
		var_6_2 = var_1_10006.New({
			id = var_6_1
		})
	end

	local var_6_3 = {
		seriesId = var_6_1
	}
	local var_6_4 = true

	if arg_6_2 and arg_6_2[#arg_6_0.re40004] then
		iter_6_0 = var_8.statistics._battleScore
		ys = iter_6_1
		var_6_4 = iter_6_0 > iter_6_1.Battle.BattleConst.BattleScore.C
	end

	var_6_3.win = var_6_4
	ipairs = iter_6_0

	for iter_6_2, iter_6_3 in iter_6_0(arg_6_0.re40004) do
		var_6_3[iter_6_2] = {}

		local var_6_5 = var_0_1.addShipsExp
		local var_6_6 = iter_6_3.ship_exp_list

		SYSTEM_BOSS_RUSH = var_1_10017

		if var_6_0 ~= var_1_10017 then
			SYSTEM_BOSS_RUSH_COLLABRATE = var_1_10017

			if var_6_0 ~= var_1_10017 then
				var_1_10017 = false

				goto label_6_0
			end
		end

		var_1_10017 = true

		::label_6_0::

		local var_6_7, var_6_8 = var_6_5(var_6_6, var_1_10017)

		var_6_3[iter_6_2].oldShips = var_6_7
		var_6_3[iter_6_2].newShips = var_6_8

		local var_6_9

		var_6_9, var_1_10017 = var_0_1.GenerateCommanderExp(iter_6_3.commander_exp)
		var_6_3[iter_6_2].oldCmds = var_6_9
		var_6_3[iter_6_2].newCmds = var_1_10017
		var_6_3[iter_6_2].mvp = iter_6_3.mvp

		local var_6_10, var_6_11 = var_0_1.GeneralLoot(iter_6_3)

		var_6_3[iter_6_2].drops = var_6_10
		var_6_3[iter_6_2].extraDrops = var_6_11

		local var_6_12 = 0

		pg = var_1_10021

		if var_1_10021.battle_cost_template[var_6_0].oil_cost > 0 then
			local var_6_13 = {
				{
					0,
					0
				},
				{
					0,
					0
				}
			}

			table = var_23

			var_23.Foreach(var_6_7, function(arg_7_0, arg_7_1)
				local var_7_0 = arg_7_1:getStartBattleExpend()
				local var_7_1 = arg_7_1
				local var_7_2 = arg_7_1.getEndBattleExpend(var_7_1)
				local var_7_3 = arg_7_1:getTeamType()

				TeamType = var_7_1

				local var_7_4 = var_7_3 == var_7_1.Submarine and 2 or 1

				var_6_13[var_7_4][1] = var_6_13[var_7_4][1] + var_7_0
				var_6_13[var_7_4][2] = var_6_13[var_7_4][2] + var_7_2

				return
			end)

			local var_6_14 = var_6_2:GetOilLimit()
			local var_6_15 = var_6_13[1][2]

			if var_6_14[1] > 0 then
				math = var_25
				var_6_15 = var_25.clamp(var_6_14[1] - var_6_13[1][1], 0, var_6_13[1][2])
			end

			local var_6_16 = var_6_13[2][2]

			if var_6_14[1] > 0 then
				math = var_26
				var_6_16 = var_26.clamp(var_6_14[2] - var_6_13[2][1], 0, var_6_13[2][2])
			end

			var_6_12 = var_6_15 + var_6_16
		end

		var_6_3[iter_6_2].playerExp = var_0_1.GeneralPlayerCosume(var_6_0, var_6_4, var_6_12, iter_6_3.player_exp)
	end

	return var_6_3
end

function var_0_1.addShipsExp(arg_8_0, arg_8_1)
	local var_8_0 = {}
	local var_8_1 = {}

	getProxy = var_1_10004
	BayProxy = var_1_10006

	local var_8_2 = var_1_10004(var_1_10006)

	ipairs = var_1_10005

	for iter_8_0, iter_8_1 in var_1_10005(arg_8_0) do
		local var_8_3 = iter_8_1.ship_id
		local var_8_4 = iter_8_1.exp
		local var_8_5 = iter_8_1.intimacy
		local var_8_6 = iter_8_1.energy
		local var_8_7 = var_8_2:getShipById(var_8_3)

		Clone = var_1_10015
		var_8_0[var_8_3] = var_1_10015(var_8_7)
		var_1_10015 = var_8_0[var_8_3]
		var_1_10015.expAdd = var_8_4

		var_8_7:addExp(var_8_4, arg_8_1)

		if arg_8_1 then
			pg = var_1_10015

			if var_1_10015.gameset.level_get_proficency.key_value < var_8_7.level or var_8_7.level == var_1_10015 and var_8_7.exp > 0 then
				pg = var_16

				if var_16.ship_data_template[var_8_7.configId].can_get_proficency == 1 then
					getProxy = var_17
					NavalAcademyProxy = var_19

					local var_8_8 = var_17(var_19)

					var_17.AddCourseProficiency(var_8_8, var_8_4)
				end
			end
		end

		if var_8_5 then
			var_8_7:addLikability(var_8_5 - 16)
		end

		if var_8_6 then
			var_8_7:cosumeEnergy(var_8_6)
		end

		Clone = var_1_10015
		var_8_1[var_8_3] = var_1_10015(var_8_7)

		var_8_2:updateShip(var_8_7)
	end

	return var_8_0, var_8_1
end

function var_0_1.GenerateCommanderExp(arg_9_0)
	local var_9_0 = {}
	local var_9_1 = {}

	getProxy = var_1_10003
	CommanderProxy = var_1_10005

	local var_9_2 = var_1_10003(var_1_10005)

	ipairs = var_1_10004

	for iter_9_0, iter_9_1 in var_1_10004(arg_9_0) do
		local var_9_3 = iter_9_1.commander_id
		local var_9_4 = iter_9_1.exp
		local var_9_5 = var_9_2:getCommanderById(var_9_3)

		Clone = var_1_10012
		var_9_0[var_9_3] = var_1_10012(var_9_5)
		var_1_10012 = var_9_0[var_9_3]
		var_1_10012.expAdd = iter_9_1.exp

		var_9_5:addExp(var_9_4)

		Clone = var_1_10012
		var_9_1[var_9_3] = var_1_10012(var_9_5)

		var_9_2:updateCommander(var_9_5)
	end

	return var_9_0, var_9_1
end

function var_0_1.GeneralLoot(arg_10_0)
	local var_10_0 = {
		drops = arg_10_0.drop_info,
		extraDrops = arg_10_0.extra_drop_info
	}

	pairs = var_2

	for iter_10_0, iter_10_1 in var_2(var_10_0) do
		PlayerConst = var_1_10007
		var_10_0[iter_10_0] = var_1_10007.addTranDrop(iter_10_1)
		underscore = var_1_10007

		var_1_10007.each(var_10_0[iter_10_0], function(arg_11_0)
			local var_11_0 = arg_11_0.type

			DROP_TYPE_SHIP = var_2_10002

			if var_11_0 == var_2_10002 then
				pg = var_11_0

				local var_11_1 = var_11_0.ship_data_template[arg_11_0.id].group_type

				getProxy = var_2
				CollectionProxy = var_2_10004
				arg_11_0.virgin = var_2(var_2_10004) and var_2.shipGroups[var_11_1] == nil
			end

			return
		end)
	end

	return var_10_0.drops, var_10_0.extraDrops
end

function var_0_1.GeneralPlayerCosume(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	getProxy = var_1_10004
	PlayerProxy = var_1_10006

	local var_12_0 = var_1_10004(var_1_10006)
	local var_12_1 = var_4.getData(var_12_0)
	local var_12_2 = {
		oldPlayer = {
			level = var_12_1.level,
			exp = var_12_1.exp
		},
		addExp = arg_12_3
	}

	var_12_1:addExp(arg_12_3)

	pg = var_7

	if var_7.battle_cost_template[arg_12_0].oil_cost > 0 and arg_12_1 then
		var_12_1:consume({
			gold = 0,
			oil = arg_12_2
		})
	end

	if var_7.attack_count > 0 then
		if var_7.attack_count == 1 then
			var_12_1:increaseAttackCount()

			if arg_12_1 then
				var_12_1:increaseAttackWinCount()
			end
		elseif var_7.attack_count == 2 then
			var_12_1:increasePvpCount()

			if arg_12_1 then
				var_12_1:increasePvpWinCount()
			end
		end
	end

	var_4:updatePlayer(var_12_1)

	Clone = var_8
	var_12_2.newPlayer = var_8(var_12_1)

	return var_12_2
end

return var_0_1
