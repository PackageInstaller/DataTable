class = var_0_10000

local var_0_0 = "DailiyQuickBattleCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().dailyLevelId
	local var_1_1 = var_2.stageId
	local var_1_2 = var_2.cnt

	getProxy = var_1_10006
	DailyLevelProxy = var_1_10008

	local var_1_3

	if not var_1_10006(var_1_10008).data[var_1_0] then
		var_1_3 = 0
	end

	pg = var_1_10008

	local var_1_4 = var_1_10008.expedition_daily_template[var_1_0]
	local var_1_6

	if var_1_3 + var_1_2 > var_1_4.limit_time then
		pg = var_1_6

		local var_1_5 = var_1_6.TipsMgr.GetInstance()

		var_1_6 = var_1_6.ShowTips
		i18n = var_1_10012

		var_1_6(var_1_5, var_1_10012("dailyLevel_restCount_notEnough"))

		return
	end

	pg = var_1_6

	local var_1_7 = var_1_6.ConnectionMgr.GetInstance()
	local var_1_8 = var_9.Send
	local var_1_9 = 40007
	local var_1_10 = {}

	SYSTEM_ROUTINE = var_1_10014
	var_1_10.system = var_1_10014
	var_1_10.id = var_1_1
	var_1_10.cnt = var_1_2

	var_1_8(var_1_7, var_1_9, var_1_10, 40008, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			var_2_0 = {}
			ipairs = var_2_10002

			for iter_2_0, iter_2_1 in var_2_10002(arg_2_0.reward_list) do
				table = var_2_10007
				var_2_10007 = var_2_10007.insertto

				local var_2_1 = var_2_0

				PlayerConst = var_2_10010

				var_2_10007(var_2_1, var_2_10010.addTranDrop(iter_2_1.drop_list))

				table = var_2_10007
				var_2_10007 = var_2_10007.insertto

				local var_2_2 = var_2_0

				underscore = var_2_10010
				var_2_10010 = var_2_10010.map
				PlayerConst = var_12

				local var_2_3 = var_12.addTranDrop
				local var_2_4

				if not iter_2_1.extra_drop_list then
					var_2_4 = {}
				end

				var_2_10007(var_2_2, var_2_10010(var_2_3(var_2_4), function(arg_3_0)
					arg_3_0.riraty = true

					return arg_3_0
				end))
			end

			local var_2_5 = var_0.data
			local var_2_6 = var_1_0

			if not var_0.data[var_1_0] then
				var_2_10004 = 0
			end

			var_2_5[var_2_6] = var_2_10004 + var_1_2
			var_2_10004 = arg_1_0

			local var_2_7 = var_2.sendNotification

			GAME = var_5

			var_2_7(var_2_10004, var_5.DAILY_LEVEL_QUICK_BATTLE_DONE, {
				awards = var_2_0,
				stageId = var_1_1,
				dailyLevelId = var_1_0
			})
		else
			pg = var_2_0

			local var_2_8 = var_2_0.TipsMgr.GetInstance()
			local var_2_9 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_9(var_2_8, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
