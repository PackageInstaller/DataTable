class = var_0_10000

local var_0_0 = "EventFinishCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.callback
	local var_1_2 = var_2.onConfirm

	getProxy = var_1_10006
	EventProxy = var_1_10007

	local var_1_3 = var_1_10006(var_1_10007)
	local var_1_4 = var_6.getEventInfo(var_1_3, var_1_0)
	local var_1_5, var_1_6 = var_6:CanFinishEvent(var_1_4)

	if not var_1_5 then
		if var_1_6 then
			pg = var_10

			local var_1_7 = var_10.TipsMgr.GetInstance()

			var_10.ShowTips(var_1_7, var_1_6)
		end

		if var_1_1 then
			var_1_1()
		end

		return
	end

	local var_1_8 = var_1_4

	if var_1_4.IsActivityType(var_1_8) then
		local var_1_9 = arg_1_0

		var_1_8 = arg_1_0.sendNotification
		GAME = var_1_10013

		local var_1_10 = var_1_10013.ACT_COLLECTION_EVENT_OP
		local var_1_11 = {
			arg2 = 0
		}

		ActivityConst = var_1_10015
		var_1_11.cmd = var_1_10015.COLLETION_EVENT_OP_SUBMIT
		var_1_11.arg1 = var_1_0
		var_1_11.arg_list = {}
		var_1_11.callBack = var_1_1
		var_1_11.onConfirm = var_1_2

		var_1_8(var_1_9, var_1_10, var_1_11)
	else
		pg = var_1_8

		local var_1_12 = var_1_8.ConnectionMgr.GetInstance()

		var_11.Send(var_1_12, 13005, {
			id = var_1_0
		}, 13006, function(arg_2_0)
			if arg_2_0.result == 0 then
				getProxy = var_1
				EventProxy = var_2_10002
				var_2_10003 = var_1(var_2_10002)
				var_2_10003 = var_1.getEventInfo(var_2_10003, var_1_0)

				var_2.SavePrevFormation(var_2_10003)
				var_0_1.OnFinish(var_1_0, arg_2_0, var_1_2)

				if var_1_1 then
					var_1_1()
				end
			else
				pg = var_1

				local var_2_0 = var_1.TipsMgr.GetInstance()
				local var_2_1 = var_1.ShowTips

				errorTip = var_2_10003

				var_2_1(var_2_0, var_2_10003("event_finish_fail", arg_2_0.result))

				if var_1_1 then
					var_1_1()
				end
			end

			return
		end)
	end

	return
end

function var_0_1.OnFinish(arg_3_0, arg_3_1, arg_3_2)
	pg = var_1_10003

	local var_3_0 = var_1_10003.TipsMgr.GetInstance()
	local var_3_1 = var_3.ShowTips

	i18n = var_1_10005

	var_3_1(var_3_0, var_1_10005("event_finish_success"))

	getProxy = var_3_1
	EventProxy = var_3_0

	local var_3_2 = var_3_1(var_3_0)
	local var_3_3 = {}
	local var_3_4 = {}
	local var_3_5 = arg_3_1.exp

	if 0 < var_3_5 then
		getProxy = var_3_5
		BayProxy = var_7
		var_3_5 = var_3_5(var_7)
		var_1_10008 = var_3_2

		local var_3_6 = var_3_2.getEventInfo(var_1_10008, arg_3_0).shipIds

		ipairs = var_1_10008

		for iter_3_0, iter_3_1 in var_1_10008(var_3_6) do
			local var_3_7 = var_3_5

			if var_3_5.getShipById(var_3_7, iter_3_1) then
				Clone = var_3_7

				local var_3_8 = var_3_7(var_13)

				var_14.addExp(var_3_8, arg_3_1.exp)
				var_3_5:updateShip(var_14)

				table = var_15

				var_15.insert(var_3_3, var_13)

				table = var_15

				var_15.insert(var_3_4, var_14)
			end
		end
	end

	PlayerConst = var_3_5

	local var_3_9 = var_3_5.addTranDrop(arg_3_1.drop_list)

	getProxy = var_7
	ActivityProxy = var_1_10008

	local var_3_10 = var_7(var_1_10008)
	local var_3_11 = var_7.getAliveActivityByType

	ActivityConst = var_1_10009

	local var_3_12

	if var_3_11(var_3_10, var_1_10009.ACTIVITY_TYPE_EVENT) then
		var_3_12 = var_7

		if var_7.getConfig(var_3_12, "config_client").shopActID then
			pg = var_3_12
			var_3_12 = var_3_12.activity_template[var_3_10].config_client.pt_id
			_ = var_10

			var_10.each(var_3_9, function(arg_4_0)
				if arg_4_0.id == var_3_12 then
					arg_4_0.catchupActTag = true
				end

				return
			end)

			table = var_10

			local var_3_13 = var_10.sort
			local var_3_14 = var_3_9

			CompareFuncs = var_12

			var_3_13(var_3_14, var_12({
				function(arg_5_0)
					return arg_5_0.id == var_3_12 and 1 or 0
				end
			}))
		end
	end

	getProxy = var_3_10
	PlayerProxy = var_3_12

	local var_3_15 = var_3_10(var_3_12)

	var_9.collect_attack_count = var_8.getData(var_3_15).collect_attack_count + 1

	var_8:updatePlayer(var_9)

	local var_3_16 = var_3_2:getEventInfo(arg_3_0)
	local var_3_17 = {
		{
			id = arg_3_0
		}
	}

	_ = var_12

	var_12.each(arg_3_1.new_collection, function(arg_6_0)
		table = var_2_10001

		local var_6_0 = var_2_10001.insert
		local var_6_1 = var_3_17

		EventInfo = var_2_10003

		var_6_0(var_6_1, var_2_10003.New(arg_6_0))

		return
	end)
	var_3_2:updateInfoList(var_3_17)

	pg = var_12

	local var_3_18 = var_12.m02
	local var_3_19 = var_12.sendNotification

	GAME = var_14

	var_3_19(var_3_18, var_14.EVENT_SHOW_AWARDS, {
		eventId = arg_3_0,
		oldShips = var_3_3,
		newShips = var_3_4,
		awards = var_3_9,
		isCri = arg_3_1.is_cri > 0,
		onConfirm = arg_3_2
	})

	return
end

return var_0_1
