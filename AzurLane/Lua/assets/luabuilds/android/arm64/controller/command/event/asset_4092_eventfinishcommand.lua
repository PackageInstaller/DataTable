class = var_0_10000

local var_0_0 = "EventFinishCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.callback
	local var_1_2 = var_2.onConfirm

	getProxy = var_1_10006
	EventProxy = var_1_10008

	local var_1_3 = var_1_10006(var_1_10008)
	local var_1_4 = var_6.getEventInfo(var_1_3, var_1_0)
	local var_1_5 = var_6
	local var_1_6, var_1_7 = var_6.CanFinishEvent(var_1_5, var_1_4)

	if not var_1_6 then
		if var_1_7 then
			pg = var_1_5

			local var_1_8 = var_1_5.TipsMgr.GetInstance()

			var_10.ShowTips(var_1_8, var_1_7)
		end

		if var_1_1 then
			var_1_1()
		end

		return
	end

	local var_1_10

	if var_1_4:IsActivityType() then
		local var_1_9 = arg_1_0

		var_1_10 = arg_1_0.sendNotification
		GAME = var_1_10014

		local var_1_11 = var_1_10014.ACT_COLLECTION_EVENT_OP
		local var_1_12 = {
			arg2 = 0
		}

		ActivityConst = var_1_10016
		var_1_12.cmd = var_1_10016.COLLETION_EVENT_OP_SUBMIT
		var_1_12.arg1 = var_1_0
		var_1_12.arg_list = {}
		var_1_12.callBack = var_1_1
		var_1_12.onConfirm = var_1_2

		var_1_10(var_1_9, var_1_11, var_1_12)
	else
		pg = var_1_10

		local var_1_13 = var_1_10.ConnectionMgr.GetInstance()

		var_11.Send(var_1_13, 13005, {
			id = var_1_0
		}, 13006, function(arg_2_0)
			if arg_2_0.result == 0 then
				getProxy = var_1
				EventProxy = var_2_10003
				var_2_10004 = var_1(var_2_10003)
				var_2_10004 = var_1.getEventInfo(var_2_10004, var_1_0)

				var_2.SavePrevFormation(var_2_10004)
				var_0_1.OnFinish(var_1_0, arg_2_0, var_1_2)

				if var_1_1 then
					var_1_1()
				end
			else
				pg = var_1

				local var_2_0 = var_1.TipsMgr.GetInstance()
				local var_2_1 = var_1.ShowTips

				errorTip = var_2_10004

				var_2_1(var_2_0, var_2_10004("event_finish_fail", arg_2_0.result))

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

	i18n = var_1_10006

	var_3_1(var_3_0, var_1_10006("event_finish_success"))

	getProxy = var_3_1
	EventProxy = var_3_0

	local var_3_2 = var_3_1(var_3_0)
	local var_3_3 = {}
	local var_3_4 = {}
	local var_3_5 = arg_3_1.exp
	local var_3_6

	if 0 < var_3_5 then
		getProxy = var_3_5
		BayProxy = var_8
		var_3_5 = var_3_5(var_8)
		var_1_10009 = var_3_2
		var_3_6 = var_3_2.getEventInfo(var_1_10009, arg_3_0).shipIds
		ipairs = var_8

		for iter_3_0, iter_3_1 in var_8(var_3_6) do
			if var_3_5:getShipById(iter_3_1) then
				Clone = var_1_10014

				local var_3_7 = var_1_10014(var_13)

				var_1_10014.addExp(var_3_7, arg_3_1.exp)
				var_3_5:updateShip(var_1_10014)

				table = var_15

				var_15.insert(var_3_3, var_13)

				table = var_15

				var_15.insert(var_3_4, var_1_10014)
			end
		end
	end

	PlayerConst = var_3_5

	local var_3_8 = var_3_5.addTranDrop(arg_3_1.drop_list)

	getProxy = var_3_6
	ActivityProxy = var_1_10009

	local var_3_9 = var_3_6(var_1_10009)
	local var_3_10 = var_7.getAliveActivityByType

	ActivityConst = var_1_10010

	local var_3_11

	if var_3_10(var_3_9, var_1_10010.ACTIVITY_TYPE_EVENT) then
		var_3_11 = var_7

		if var_7.getConfig(var_3_11, "config_client").shopActID then
			pg = var_3_9

			local var_3_12 = var_3_9.activity_template[var_8].config_client.pt_id

			_ = var_3_11

			var_3_11.each(var_3_8, function(arg_4_0)
				if arg_4_0.id == var_3_12 then
					arg_4_0.catchupActTag = true
				end

				return
			end)

			table = var_3_11
			var_3_11 = var_3_11.sort

			local var_3_13 = var_3_8

			CompareFuncs = var_13

			var_3_11(var_3_13, var_13({
				function(arg_5_0)
					return arg_5_0.id == var_3_12 and 1 or 0
				end
			}))
		end
	end

	getProxy = var_8
	PlayerProxy = var_3_11

	local var_3_14 = var_8(var_3_11)

	var_9.collect_attack_count = var_8.getData(var_3_14).collect_attack_count + 1

	var_8:updatePlayer(var_9)

	local var_3_15 = var_3_2:getEventInfo(arg_3_0)
	local var_3_16 = {
		{
			id = arg_3_0
		}
	}

	_ = var_12

	var_12.each(arg_3_1.new_collection, function(arg_6_0)
		table = var_2_10001

		local var_6_0 = var_2_10001.insert
		local var_6_1 = var_3_16

		EventInfo = var_2_10004

		var_6_0(var_6_1, var_2_10004.New(arg_6_0))

		return
	end)
	var_3_2:updateInfoList(var_3_16)

	pg = var_12

	local var_3_17 = var_12.m02
	local var_3_18 = var_12.sendNotification

	GAME = var_15

	var_3_18(var_3_17, var_15.EVENT_SHOW_AWARDS, {
		eventId = arg_3_0,
		oldShips = var_3_3,
		newShips = var_3_4,
		awards = var_3_8,
		isCri = arg_3_1.is_cri > 0,
		onConfirm = arg_3_2
	})

	return
end

return var_0_1
