local var_0_0 = class("BossRushSettlementCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(11202, {
		cmd = 2,
		activity_id = arg_1_1.body.actId
	}, 11203, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(ActivityProxy):getActivityById(var_0.actId)
			local var_2_1 = var_2_0:GetSeriesData()

			var_2_0:SetSeriesData(nil)

			local var_2_2 = PlayerConst.GetTranAwards(var_0, arg_2_0)
			local var_2_3 = getProxy(ActivityProxy):GetBossRushRuntime(var_0.actId).settlementData

			getProxy(ActivityProxy):GetBossRushRuntime(var_2_0.id).settlementData = nil

			local var_2_4

			if var_2_3.win then
				var_2_0:AddPassSeries(var_2_3.seriesId)
				getProxy(ChapterProxy):addRemasterPassCount(var_2_3.seriesId, var_0.actId)

				local var_2_5 = BossRushChapterRemasterHelper.GetActivityRemasterByFinalSeriesId(var_0.actId, var_2_3.seriesId)

				var_2_4 = var_2_5 and var_2_5.memory_group

				if var_2_0:getConfig("type") ~= ActivityConst.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB then
					var_2_0:AddUsedBonus(var_2_3.seriesId)
				end
			end

			for iter_2_0, iter_2_1 in ipairs(var_2_3) do
				table.insertto(var_2_2, iter_2_1.drops)
				table.insertto(var_2_2, iter_2_1.extraDrops)
			end

			if var_2_1 then
				var_2_1:AddFinalResults(var_2_3)
			end

			getProxy(ActivityProxy):updateActivity(var_2_0)
			seriesAsync({
				function(arg_3_0, arg_3_1)
					if var_0.callback then
						var_0.callback({
							seriesData = var_2_1,
							activityId = var_0.actId,
							awards = var_2_2,
							callback = arg_3_0
						})
					else
						arg_1_0:sendNotification(GAME.BOSSRUSH_SETTLE_DONE, {
							seriesData = var_2_1,
							activityId = var_0.actId,
							awards = var_2_2,
							callback = arg_3_0
						})
					end

					return
				end,
				function(arg_4_0)
					if not BossRushChapterRemasterHelper.UnlockMemoryGroupStoriesAndShowMsgBox(var_2_4, function(arg_5_0)
						arg_4_0(arg_5_0)

						return
					end) then
						arg_4_0({})
					end

					return
				end
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end)

	return
end

function var_0_0.ConcludeEXP(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.arg1
	local var_6_1

	if arg_6_0.system == SYSTEM_BOSS_RUSH_COLLABRATE then
		for iter_6_0, iter_6_1 in ipairs(pg.extraenemy_series_template) do
			if table.contains(pg.extraenemy_series_template[iter_6_1].activity_series_enemy_id, var_6_0) then
				var_6_1 = CollabrateBossRushSeriesData.New({
					id = iter_6_1,
					actId = arg_6_1.id
				})
				var_6_0 = iter_6_1

				break
			end
		end
	else
		var_6_1 = BossRushSeriesData.New({
			id = var_6_0
		})
	end

	local var_6_2 = {
		seriesId = var_6_0
	}
	local var_6_3 = true
	local var_6_4 = arg_6_2 and arg_6_2[#arg_6_0.re40004]

	if arg_6_2 and arg_6_2[#arg_6_0.re40004] then
		var_6_3 = var_6_4.statistics._battleScore > ys.Battle.BattleConst.BattleScore.C
	end

	var_6_2.win = var_6_3

	for iter_6_2, iter_6_3 in ipairs(arg_6_0.re40004) do
		var_6_2[iter_6_2] = {}

		local var_6_5, var_6_6 = var_0_0.addShipsExp(iter_6_3.ship_exp_list, arg_6_0.system == SYSTEM_BOSS_RUSH or arg_6_0.system == SYSTEM_BOSS_RUSH_COLLABRATE)

		var_6_2[iter_6_2].oldShips = var_6_5
		var_6_2[iter_6_2].newShips = var_6_6

		local var_6_7, var_6_8 = var_0_0.GenerateCommanderExp(iter_6_3.commander_exp)

		var_6_2[iter_6_2].oldCmds = var_6_7
		var_6_2[iter_6_2].newCmds = var_6_8
		var_6_2[iter_6_2].mvp = iter_6_3.mvp

		local var_6_9, var_6_10 = var_0_0.GeneralLoot(iter_6_3)

		var_6_2[iter_6_2].drops = var_6_9
		var_6_2[iter_6_2].extraDrops = var_6_10

		local var_6_11 = 0

		if pg.battle_cost_template[arg_6_0.system].oil_cost > 0 then
			local var_6_12 = {
				{
					0,
					0
				},
				{
					0,
					0
				}
			}

			table.Foreach(var_6_5, function(arg_7_0, arg_7_1)
				local var_7_0 = arg_7_1:getEndBattleExpend()
				local var_7_1 = arg_7_1:getTeamType() == TeamType.Submarine and 2 or 1

				var_6_12[var_7_1][1] = var_6_12[var_7_1][1] + arg_7_1:getStartBattleExpend()
				var_6_12[var_7_1][2] = var_6_12[var_7_1][2] + var_7_0

				return
			end)

			local var_6_13 = var_6_1:GetOilLimit()
			local var_6_14 = ({
				{
					0,
					0
				},
				{
					0,
					0
				}
			})[1][2]

			if var_6_13[1] > 0 then
				var_6_14 = math.clamp(var_6_13[1] - ({
					{
						0,
						0
					},
					{
						0,
						0
					}
				})[1][1], 0, ({
					{
						0,
						0
					},
					{
						0,
						0
					}
				})[1][2])
			end

			local var_6_15 = ({
				{
					0,
					0
				},
				{
					0,
					0
				}
			})[2][2]

			if var_6_13[1] > 0 then
				var_6_15 = math.clamp(var_6_13[2] - ({
					{
						0,
						0
					},
					{
						0,
						0
					}
				})[2][1], 0, ({
					{
						0,
						0
					},
					{
						0,
						0
					}
				})[2][2])
			end

			var_6_11 = var_6_14 + var_6_15
		end

		var_6_2[iter_6_2].playerExp = var_0_0.GeneralPlayerCosume(arg_6_0.system, var_6_3, var_6_11, iter_6_3.player_exp)
	end

	return var_6_2
end

function var_0_0.addShipsExp(arg_8_0, arg_8_1)
	local var_8_0 = getProxy(BayProxy)

	for iter_8_0, iter_8_1 in ipairs(arg_8_0) do
		local var_8_1 = var_8_0:getShipById(iter_8_1.ship_id)

		;({})[iter_8_1.ship_id] = Clone(var_8_1)
		;({})[iter_8_1.ship_id].expAdd = iter_8_1.exp

		var_8_1:addExp(iter_8_1.exp, arg_8_1)

		if arg_8_1 then
			if (pg.gameset.level_get_proficency.key_value < var_8_1.level or var_8_1.level == pg.gameset.level_get_proficency.key_value and var_8_1.exp > 0) and pg.ship_data_template[var_8_1.configId].can_get_proficency == 1 then
				getProxy(NavalAcademyProxy):AddCourseProficiency(iter_8_1.exp)
			end
		end

		if iter_8_1.intimacy then
			var_8_1:addLikability(iter_8_1.intimacy - 16)
		end

		if iter_8_1.energy then
			var_8_1:cosumeEnergy(iter_8_1.energy)
		end

		;({})[iter_8_1.ship_id] = Clone(var_8_1)

		var_8_0:updateShip(var_8_1)
	end

	return {}, {}
end

function var_0_0.GenerateCommanderExp(arg_9_0)
	local var_9_0 = getProxy(CommanderProxy)

	for iter_9_0, iter_9_1 in ipairs(arg_9_0) do
		local var_9_1 = var_9_0:getCommanderById(iter_9_1.commander_id)

		;({})[iter_9_1.commander_id] = Clone(var_9_1)
		;({})[iter_9_1.commander_id].expAdd = iter_9_1.exp

		var_9_1:addExp(iter_9_1.exp)

		;({})[iter_9_1.commander_id] = Clone(var_9_1)

		var_9_0:updateCommander(var_9_1)
	end

	return {}, {}
end

function var_0_0.GeneralLoot(arg_10_0)
	for iter_10_0, iter_10_1 in pairs({
		drops = arg_10_0.drop_info,
		extraDrops = arg_10_0.extra_drop_info
	}) do
		({
			drops = arg_10_0.drop_info,
			extraDrops = arg_10_0.extra_drop_info
		})[iter_10_0] = PlayerConst.addTranDrop(iter_10_1)

		underscore.each(({
			drops = arg_10_0.drop_info,
			extraDrops = arg_10_0.extra_drop_info
		})[iter_10_0], function(arg_11_0)
			if arg_11_0.type == DROP_TYPE_SHIP then
				local var_11_0 = getProxy(CollectionProxy)

				arg_11_0.virgin = var_11_0 and var_11_0.shipGroups[pg.ship_data_template[arg_11_0.id].group_type] == nil
			end

			return
		end)
	end

	return ({
		drops = arg_10_0.drop_info,
		extraDrops = arg_10_0.extra_drop_info
	}).drops, ({
		drops = arg_10_0.drop_info,
		extraDrops = arg_10_0.extra_drop_info
	}).extraDrops
end

function var_0_0.GeneralPlayerCosume(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = getProxy(PlayerProxy)
	local var_12_1 = var_12_0:getData()

	var_12_1:addExp(arg_12_3)

	if pg.battle_cost_template[arg_12_0].oil_cost > 0 and arg_12_1 then
		var_12_1:consume({
			gold = 0,
			oil = arg_12_2
		})
	end

	if pg.battle_cost_template[arg_12_0].attack_count > 0 then
		if pg.battle_cost_template[arg_12_0].attack_count == 1 then
			var_12_1:increaseAttackCount()

			if arg_12_1 then
				var_12_1:increaseAttackWinCount()
			end
		elseif pg.battle_cost_template[arg_12_0].attack_count == 2 then
			var_12_1:increasePvpCount()

			if arg_12_1 then
				var_12_1:increasePvpWinCount()
			end
		end
	end

	var_12_0:updatePlayer(var_12_1)

	;({
		oldPlayer = {
			level = var_12_1.level,
			exp = var_12_1.exp
		},
		addExp = arg_12_3
	}).newPlayer = Clone(var_12_1)

	return {
		oldPlayer = {
			level = var_12_1.level,
			exp = var_12_1.exp
		},
		addExp = arg_12_3
	}
end

return var_0_0
