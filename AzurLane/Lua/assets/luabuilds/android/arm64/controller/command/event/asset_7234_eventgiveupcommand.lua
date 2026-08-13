class = var_0_10000

local var_0_0 = "EventGiveUpCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).id

	getProxy = var_1_0
	EventProxy = var_1_10006

	local var_1_2 = var_1_0(var_1_10006)
	local var_1_3 = var_4.getEventInfo(var_1_2, var_1_1)
	local var_1_5

	if var_5.IsActivityType(var_1_3) then
		local var_1_4 = arg_1_0

		var_1_5 = arg_1_0.sendNotification
		GAME = var_1_10009

		local var_1_6 = var_1_10009.ACT_COLLECTION_EVENT_OP
		local var_1_7 = {
			arg2 = 0
		}

		ActivityConst = var_1_10011
		var_1_7.cmd = var_1_10011.COLLETION_EVENT_OP_GIVE_UP
		var_1_7.arg1 = var_1_1
		var_1_7.arg_list = {}

		var_1_5(var_1_4, var_1_6, var_1_7)
	else
		pg = var_1_5

		local var_1_8 = var_1_5.ConnectionMgr.GetInstance()

		var_6.Send(var_1_8, 13007, {
			id = var_1_1
		}, 13008, function(arg_2_0)
			if arg_2_0.result == 0 then
				var_0_1.OnCancel(var_1_1)
			else
				pg = var_1

				local var_2_0 = var_1.TipsMgr.GetInstance()
				local var_2_1 = var_1.ShowTips

				errorTip = var_2_10004

				var_2_1(var_2_0, var_2_10004("event_giveup_fail", arg_2_0.result))
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

	i18n = var_1_10004

	var_3_1(var_3_0, var_1_10004("event_giveup_success"))

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
