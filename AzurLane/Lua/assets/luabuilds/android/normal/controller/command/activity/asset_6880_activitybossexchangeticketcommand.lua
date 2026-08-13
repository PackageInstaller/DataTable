class = var_0_10000

local var_0_0 = "ActivityBossExchangeTicketCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	if not arg_1_1:getBody().stageId then
		return
	end

	getProxy = var_1_10004
	ActivityProxy = var_1_10005

	local var_1_0 = var_1_10004(var_1_10005)
	local var_1_1 = var_4.getActivityByType

	ActivityConst = var_1_10006

	if not var_1_1(var_1_0, var_1_10006.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2) or var_4:isEnd() then
		return
	end

	pg = var_1_0

	local var_1_2 = var_1_0.activity_event_worldboss
	local var_1_3 = var_4

	if not var_1_2[var_4.getConfig(var_1_3, "config_id")] then
		return
	end

	getProxy = var_6
	PlayerProxy = var_1_3

	local var_1_4 = var_6(var_1_3)
	local var_1_5 = var_6.getRawData(var_1_4)
	local var_1_6 = var_5.ticket

	if var_1_5:getResource(var_1_6) <= 0 then
		return
	end

	pg = var_8

	local var_1_7 = var_8.ConnectionMgr.GetInstance()

	var_8.Send(var_1_7, 11202, {
		cmd = 1,
		activity_id = var_4.id,
		arg1 = var_3,
		arg_list = {}
	}, 11203, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			PlayerProxy = var_2_10002
			var_2_10003 = var_1(var_2_10002)

			local var_2_0 = var_1.getRawData(var_2_10003)

			var_2_10003 = var_2.consume

			local var_2_1 = {}

			id2res = var_2_10006
			var_2_1[var_2_10006(var_1_6)] = 1

			var_2_10003(var_2_0, var_2_1)

			local var_2_2 = arg_1_0

			var_2_10003 = var_2_10003.sendNotification
			GAME = var_2_1

			var_2_10003(var_2_2, var_2_1.ACT_BOSS_NORMAL_UPDATE, {
				num = 1,
				stageId = var_0
			})

			local var_2_3 = arg_1_0

			var_2_10003 = var_2_10003.sendNotification
			GAME = var_5

			var_2_10003(var_2_3, var_5.ACT_BOSS_EXCHANGE_TICKET_DONE)
		else
			pg = var_1

			local var_2_4 = var_1.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_5(var_2_4, var_2_10003("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
