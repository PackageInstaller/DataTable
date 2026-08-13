class = var_0_10000

local var_0_0 = "BossRushTracingCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	BeginStageCommand = var_1_10002

	if var_1_10002.DockOverload() then
		return
	end

	local var_1_0 = arg_1_1.body.seriesId
	local var_1_1 = var_2.actId

	getProxy = var_1_10005
	ActivityProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)

	if not var_5.getActivityById(var_1_2, var_1_1) then
		return
	end

	local var_1_3 = var_2.mode
	local var_1_4
	local var_1_5 = var_5
	local var_1_6 = var_5.getConfig(var_1_5, "type")

	ActivityConst = var_1_5

	if var_1_6 == var_1_5.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB then
		var_1_4 = var_5:GetCollabSeriesData(var_1_0)
		var_1_4.mode = var_1_3
		var_1_0 = var_1_4:GetActivitySeriesID()
	else
		BossRushSeriesData = var_1_6
		var_1_4 = var_1_6.New({
			id = var_1_0,
			actId = var_1_1,
			mode = var_1_3
		})
	end

	local var_1_7 = var_1_4:GetFleetIds()
	local var_1_8 = var_2.mode
	local var_1_9, var_1_10 = var_1_4:GetModeFleetIDs(var_1_8)
	local var_1_11 = var_1_4:GetFleets(var_1_9)
	local var_1_12 = var_1_4:GetFleets(var_1_10)[1]

	if var_13.isEmpty(var_1_12) then
		table = var_14

		var_14.remove(var_1_10)
	end

	local var_1_13 = (function()
		local var_2_0 = 0
		local var_2_1
		local var_2_3

		if var_1_4.__cname == "CollabrateBossRushSeriesData" then
			SYSTEM_BOSS_RUSH_COLLABRATE = var_2_1
		else
			local var_2_2 = var_1_4

			var_2_3 = var_2_3.GetType(var_2_2)
			BossRushSeriesData = var_2_2

			if var_2_3 == var_2_2.TYPE.EXTRA then
				SYSTEM_BOSS_RUSH_EX = var_2_1
			else
				SYSTEM_BOSS_RUSH = var_2_1
			end
		end

		pg = var_2_3

		local var_2_4 = var_2_3.battle_cost_template[var_2_1]
		local var_2_5 = var_1_4
		local var_2_6 = var_3.GetOilLimit(var_2_5)
		local var_2_7 = var_2_4.oil_cost > 0

		local function var_2_8(arg_3_0, arg_3_1)
			local var_3_0 = 0

			if var_2_7 then
				var_3_0 = arg_3_0:GetCostSum().oil

				if 0 < arg_3_1 then
					math = var_3
					var_3_0 = var_3.min(arg_3_1, var_3_0)
				end
			end

			return var_3_0
		end

		local var_2_9 = var_1_4
		local var_2_10 = #var_6.GetExpeditionIds(var_2_9)
		local var_2_11 = var_2_8(var_0, var_2_6[2]) * var_2_10

		for iter_2_0 = 1, var_2_10 do
			local var_2_12 = var_2_8
			local var_2_13

			if not var_1_11[iter_2_0] then
				var_2_13 = var_1_11[1]
			end

			var_2_11 = var_2_11 + var_2_12(var_2_13, var_2_6[1])
		end

		return var_2_11
	end)()
	local var_1_14 = var_1_4
	local var_1_15 = var_1_13 + var_1_4.GetOilCost(var_1_14)

	getProxy = var_1_14
	PlayerProxy = var_1_10018

	local var_1_16 = var_1_14(var_1_10018)

	if var_17.getRawData(var_1_16).oil < var_1_15 then
		ItemTipPanel = var_17

		if not var_17.ShowOilBuyTip(var_1_15) then
			pg = var_17
			var_1_16 = var_17.TipsMgr.GetInstance()

			local var_1_17 = var_17.ShowTips

			i18n = var_1_10019

			var_1_17(var_1_16, var_1_10019("common_no_resource"))
		end

		return
	end

	local var_1_18

	if not var_2.remasterTicketCost then
		BossRushChapterRemasterHelper = var_1_18
		var_1_18 = var_1_18.GetPermanentActivityTicketCost(var_1_1, var_2.seriesId)
	end

	getProxy = var_1_16
	ChapterProxy = var_1_10019

	local var_1_19 = var_1_16(var_1_10019)
	local var_1_21

	if 0 < var_1_18 and var_1_19.remasterTickets < var_1_18 then
		pg = var_1_21

		local var_1_20 = var_1_21.TipsMgr.GetInstance()

		var_1_21 = var_1_21.ShowTips
		i18n = var_1_10021

		var_1_21(var_1_20, var_1_10021("levelScene_remaster_tickets_not_enough"))

		local var_1_22 = arg_1_0

		var_1_21 = arg_1_0.sendNotification
		GAME = var_21

		var_1_21(var_1_22, var_21.BOSSRUSH_TRACE_ERROR)

		return
	end

	pg = var_1_21

	local var_1_23 = var_1_21.ConnectionMgr.GetInstance()

	var_19.Send(var_1_23, 11202, {
		cmd = 1,
		activity_id = var_1_1,
		arg1 = var_1_0,
		arg2 = var_1_8,
		arg_list = var_1_9,
		arg_list2 = var_1_10
	}, 11203, function(arg_4_0)
		if arg_4_0.result == 0 then
			getProxy = var_1
			ActivityProxy = var_2_10002

			local var_4_0 = var_1(var_2_10002)

			var_2_10003 = var_1.getActivityById(var_4_0, var_1_1)

			var_1.SetSeriesData(var_2_10003, var_1_4)

			local var_4_1 = var_0

			if 0 < var_4_1 then
				getProxy = var_4_1
				PlayerProxy = var_2_10003
				var_2_10003 = var_4_1(var_2_10003)

				local var_4_2 = var_2.getRawData(var_2_10003)

				var_2.consume(var_4_2, {
					oil = var_0
				})

				getProxy = var_2_10003
				PlayerProxy = var_4_2

				local var_4_3 = var_2_10003(var_4_2)

				var_2_10003.updatePlayer(var_4_3, var_2)
			end

			local var_4_4 = var_1_18

			if 0 < var_4_4 then
				var_2_10003 = var_1_19

				var_2.updateRemasterTicketsNum(var_2_10003, var_1_19.remasterTickets - var_1_18)
			end

			;(function()
				getProxy = var_3_10000
				ActivityProxy = var_3_10001

				local var_5_0 = var_3_10000(var_3_10001)
				local var_5_1 = var_0.getActivityByType

				ActivityConst = var_3_10002

				if not var_5_1(var_5_0, var_3_10002.ACTIVITY_TYPE_EXTRA_BOSSRUSH_RANK) then
					return
				end

				local var_5_2 = var_0

				var_0.ResetLast(var_5_2)

				getProxy = var_1
				ActivityProxy = var_5_2

				local var_5_3 = var_1(var_5_2)

				var_1.updateActivity(var_5_3, var_0)

				return
			end)()

			local var_4_5 = arg_1_0

			var_2_10003 = var_2_10003.sendNotification
			GAME = var_2_10005

			var_2_10003(var_4_5, var_2_10005.BOSSRUSH_TRACE_DONE, var_1_4)
		else
			pg = var_1

			local var_4_6 = var_1.TipsMgr.GetInstance()
			local var_4_7 = var_1.ShowTips

			errorTip = var_2_10003

			var_4_7(var_4_6, var_2_10003("", arg_4_0.result))

			local var_4_8 = arg_1_0
			local var_4_9 = var_1.sendNotification

			GAME = var_3

			var_4_9(var_4_8, var_3.BOSSRUSH_TRACE_ERROR, arg_4_0.result)
		end

		return
	end)

	return
end

return var_0_1
