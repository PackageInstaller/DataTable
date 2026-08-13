class = var_0_10000

local var_0_0 = "EventGiveUpCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id

	getProxy = var_1_10004
	EventProxy = var_1_10005

	local var_1_1 = var_1_10004(var_1_10005)
	local var_1_2 = var_4.getEventInfo(var_1_1, var_1_0)
	local var_1_4

	if var_5.IsActivityType(var_1_2) then
		local var_1_3 = arg_1_0

		var_1_4 = arg_1_0.sendNotification
		GAME = var_1_10008

		local var_1_5 = var_1_10008.ACT_COLLECTION_EVENT_OP
		local var_1_6 = {
			arg2 = 0
		}

		ActivityConst = var_1_10010
		var_1_6.cmd = var_1_10010.COLLETION_EVENT_OP_GIVE_UP
		var_1_6.arg1 = var_1_0
		var_1_6.arg_list = {}

		var_1_4(var_1_3, var_1_5, var_1_6)
	else
		pg = var_1_4

		local var_1_7 = var_1_4.ConnectionMgr.GetInstance()

		var_6.Send(var_1_7, 13007, {
			id = var_1_0
		}, 13008, function(arg_2_0)
			if arg_2_0.result == 0 then
				var_0_1.OnCancel(var_1_0)
			else
				pg = var_1

				local var_2_0 = var_1.TipsMgr.GetInstance()
				local var_2_1 = var_1.ShowTips

				errorTip = var_2_10003

				var_2_1(var_2_0, var_2_10003("event_giveup_fail", arg_2_0.result))
			end

			return
		end)
	end

	return
end

function var_0_1.OnCancel(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.TipsMgr.GetInstance()
	local var_3_1 = var_1.ShowTips

	i18n = var_1_10003

	var_3_1(var_3_0, var_1_10003("event_giveup_success"))

	getProxy = var_3_1
	EventProxy = var_3_0

	local var_3_2 = var_3_1(var_3_0)
	local var_3_3 = var_1.getEventInfo(var_3_2, arg_3_0)

	var_3_3.finishTime = 0
	var_3_3.shipIds = {}

	var_1:updateInfoList({
		var_3_3
	})

	return
end

return var_0_1
