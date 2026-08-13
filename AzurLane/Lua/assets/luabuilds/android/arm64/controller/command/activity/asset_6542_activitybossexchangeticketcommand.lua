class = var_0_10000

local var_0_0 = "ActivityBossExchangeTicketCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1

	if not arg_1_1.getBody(var_1_0).stageId then
		return
	end

	getProxy = var_1_0
	ActivityProxy = var_1_10006

	local var_1_1 = var_1_0(var_1_10006)
	local var_1_2 = var_4.getActivityByType

	ActivityConst = var_1_10007

	if not var_1_2(var_1_1, var_1_10007.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2) or var_4:isEnd() then
		return
	end

	pg = var_1_10005

	local var_1_3 = var_1_10005.activity_event_worldboss
	local var_1_4 = var_4

	if not var_1_3[var_4.getConfig(var_1_4, "config_id")] then
		return
	end

	getProxy = var_6
	PlayerProxy = var_1_4

	local var_1_5 = var_6(var_1_4)
	local var_1_6 = var_6.getRawData(var_1_5)
	local var_1_7 = var_5.ticket

	if var_1_6:getResource(var_1_7) <= 0 then
		return
	end

	pg = var_8

	local var_1_8 = var_8.ConnectionMgr.GetInstance()

	var_8.Send(var_1_8, 11202, {
		cmd = 1,
		activity_id = var_4.id,
		arg1 = var_3,
		arg_list = {}
	}, 11203, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			PlayerProxy = var_2_10003
			var_2_10004 = var_1(var_2_10003)

			local var_2_0 = var_1.getRawData(var_2_10004)
			local var_2_1 = var_2.consume
			local var_2_2 = {}

			id2res = var_2_10007
			var_2_2[var_2_10007(var_1_7)] = 1

			var_2_1(var_2_0, var_2_2)

			local var_2_3 = arg_1_0
			local var_2_4 = var_3.sendNotification

			GAME = var_2_2

			var_2_4(var_2_3, var_2_2.ACT_BOSS_NORMAL_UPDATE, {
				num = 1,
				stageId = var_0
			})

			local var_2_5 = arg_1_0
			local var_2_6 = var_3.sendNotification

			GAME = var_6

			var_2_6(var_2_5, var_6.ACT_BOSS_EXCHANGE_TICKET_DONE)
		else
			pg = var_1

			local var_2_7 = var_1.TipsMgr.GetInstance()
			local var_2_8 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_8(var_2_7, var_2_10004("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
