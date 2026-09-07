local BossRushTracingCommand = class("BossRushTracingCommand", pm.SimpleCommand)

function BossRushTracingCommand:execute(arg_1_1)
	if BeginStageCommand.DockOverload() then
		return
	end

	local var_1_0 = arg_1_1.body
	local var_1_1 = arg_1_1.body.seriesId
	local var_1_2 = arg_1_1.body.actId
	local var_1_3 = getProxy(ActivityProxy):getActivityById(arg_1_1.body.actId)

	if not var_1_3 then
		return
	end

	local var_1_4 = var_1_0.mode
	local var_1_5

	if var_1_3:getConfig("type") == ActivityConst.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB then
		var_1_5 = var_1_3:GetCollabSeriesData(var_1_1)
		var_1_5.mode = var_1_4
		var_1_1 = var_1_5:GetActivitySeriesID()
	else
		var_1_5 = BossRushSeriesData.New({
			id = var_1_1,
			actId = var_1_2,
			mode = var_1_4
		})
	end

	local var_1_6 = var_1_5:GetFleetIds()
	local var_1_7, var_1_8 = var_1_5:GetModeFleetIDs(var_1_0.mode)
	local var_1_9 = var_1_5:GetFleets(var_1_7)
	local var_1_10 = var_1_5:GetFleets(var_1_8)[1]
	local var_1_11

	if var_1_10:isEmpty() then
		table.remove(var_1_8)

		var_1_11 = var_1_5:GetOilCost()
	end

	local var_1_12 = (function()
		local var_2_1

		if var_1_5.__cname == "CollabrateBossRushSeriesData" then
			var_2_1 = SYSTEM_BOSS_RUSH_COLLABRATE
		else
			if var_1_5:GetType() == BossRushSeriesData.TYPE.EXTRA then
				var_2_1 = SYSTEM_BOSS_RUSH_EX
			end

			local var_2_2

			do
				var_2_1 = SYSTEM_BOSS_RUSH
				var_2_2 = var_1_5:GetOilLimit()
			end
		end

		local var_2_3 = pg.battle_cost_template[var_2_1].oil_cost > 0

		local function var_2_4(arg_3_0, arg_3_1)
			local var_3_0 = 0

			if var_2_3 then
				var_3_0 = arg_3_0:GetCostSum().oil

				if arg_3_1 > 0 then
					var_3_0 = math.min(arg_3_1, var_3_0)
				end
			end

			return var_3_0
		end

		local var_2_5 = #var_1_5:GetExpeditionIds()
		local var_2_6 = var_2_4(var_1_10, var_2_2[2]) * var_2_5

		for iter_2_0 = 1, var_2_5 do
			var_2_6 = var_2_6 + var_2_4(var_1_9[iter_2_0] or var_1_9[1], var_2_2[1])
		end

		return var_2_6
	end)() + var_1_11

	if var_1_12 > getProxy(PlayerProxy):getRawData().oil then
		if not ItemTipPanel.ShowOilBuyTip(var_1_12) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_resource"))
		end

		return
	end

	local var_1_13 = var_1_0.remasterTicketCost or BossRushChapterRemasterHelper.GetPermanentActivityTicketCost(var_1_2, var_1_0.seriesId)
	local var_1_14 = getProxy(ChapterProxy)

	if var_1_13 > 0 and var_1_13 > var_1_14.remasterTickets then
		pg.TipsMgr.GetInstance():ShowTips(i18n("levelScene_remaster_tickets_not_enough"))
		self:sendNotification(GAME.BOSSRUSH_TRACE_ERROR)

		return
	end

	pg.ConnectionMgr.GetInstance():Send(11202, {
		cmd = 1,
		activity_id = var_1_2,
		arg1 = var_1_1,
		arg2 = var_1_0.mode,
		arg_list = var_1_7,
		arg_list2 = var_1_8
	}, 11203, function(arg_4_0)
		if arg_4_0.result == 0 then
			getProxy(ActivityProxy):getActivityById(var_1_2):SetSeriesData(var_1_5)

			if var_1_11 > 0 then
				local var_4_0 = getProxy(PlayerProxy):getRawData()

				var_4_0:consume({
					oil = var_1_11
				})
				getProxy(PlayerProxy):updatePlayer(var_4_0)
			end

			if var_1_13 > 0 then
				var_1_14:updateRemasterTicketsNum(var_1_14.remasterTickets - var_1_13)
			end

			;(function()
				local var_5_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_EXTRA_BOSSRUSH_RANK)

				if not var_5_0 then
					return
				end

				var_5_0:ResetLast()
				getProxy(ActivityProxy):updateActivity(var_5_0)

				return
			end)()
			self:sendNotification(GAME.BOSSRUSH_TRACE_DONE, var_1_5)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_4_0.result))
			self:sendNotification(GAME.BOSSRUSH_TRACE_ERROR, arg_4_0.result)
		end

		return
	end)

	return
end

return BossRushTracingCommand
