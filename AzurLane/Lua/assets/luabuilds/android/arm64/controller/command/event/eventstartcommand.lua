class = var_0_10000

local var_0_0 = "EventStartCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().event.id
	local var_1_1 = var_3.shipIds

	getProxy = var_1_10006
	EventProxy = var_1_10008

	local var_1_2 = var_1_10006(var_1_10008)

	if not var_3:IsActivityType() and not var_1_2:CanStartEvent() then
		pg = var_8

		local var_1_3 = var_8.TipsMgr.GetInstance()
		local var_1_4 = var_8.ShowTips

		i18n = var_1_10011

		var_1_4(var_1_3, var_1_10011("event_fleet_busy"))

		return
	end

	local var_1_5 = var_1_2
	local var_1_6, var_1_7 = var_1_2.CanJoinEvent(var_1_5, var_3)

	if not var_1_6 then
		if var_1_7 then
			pg = var_1_5

			local var_1_8 = var_1_5.TipsMgr.GetInstance()

			var_10.ShowTips(var_1_8, var_1_7)
		end

		return
	end

	local function var_1_9()
		local var_2_1

		if var_0 then
			local var_2_0 = arg_1_0

			var_2_1 = var_2_1.sendNotification
			GAME = var_2_10003

			local var_2_2 = var_2_10003.ACT_COLLECTION_EVENT_OP
			local var_2_3 = {
				arg2 = 0
			}

			ActivityConst = var_2_10005
			var_2_3.cmd = var_2_10005.COLLETION_EVENT_OP_JOIN
			var_2_3.arg1 = var_1_0
			var_2_3.arg_list = var_1_1
			var_2_3.event = var_0

			var_2_1(var_2_0, var_2_2, var_2_3)
		else
			pg = var_2_1

			local var_2_4 = var_2_1.ConnectionMgr.GetInstance()

			var_0.Send(var_2_4, 13003, {
				id = var_1_0,
				ship_id_list = var_1_1
			}, 13004, function(arg_3_0)
				if arg_3_0.result == 0 then
					var_0_1.OnStart(var_0)
				else
					pg = var_1

					local var_3_0 = var_1.TipsMgr.GetInstance()
					local var_3_1 = var_1.ShowTips

					errorTip = var_3_10004

					var_3_1(var_3_0, var_3_10004("event_start_fail", arg_3_0.result))
				end

				return
			end)
		end

		return
	end

	local var_1_10 = var_3:getOilConsume()

	if 0 < var_1_10 then
		pg = var_12

		local var_1_11 = var_12.MsgboxMgr.GetInstance()
		local var_1_12 = var_12.ShowMsgBox
		local var_1_13 = {}

		i18n = var_1_10016
		var_1_13.content = var_1_10016("event_oil_consume", var_1_10)
		var_1_13.onYes = var_1_9

		var_1_12(var_1_11, var_1_13)
	else
		var_1_9()
	end

	return
end

function var_0_1.OnStart(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.TipsMgr.GetInstance()
	local var_4_1 = var_1.ShowTips

	i18n = var_1_10004

	var_4_1(var_4_0, var_1_10004("event_start_success"))

	getProxy = var_4_1
	EventProxy = var_4_0

	local var_4_2 = var_4_1(var_4_0)

	getProxy = var_1_10002
	PlayerProxy = var_4

	local var_4_3 = var_1_10002(var_4)
	local var_4_4 = var_2.getData(var_4_3)
	local var_4_5 = arg_4_0:getOilConsume()

	var_4_4:consume({
		oil = var_4_5
	})
	var_2:updatePlayer(var_4_4)

	pg = var_5

	local var_4_6 = var_5.TimeMgr.GetInstance()

	arg_4_0.finishTime = var_5.GetServerTime(var_4_6) + arg_4_0.template.collect_time

	var_4_2:updateInfoList({
		arg_4_0
	})

	return
end

return var_0_1
