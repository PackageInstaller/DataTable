class = var_0_10000

local var_0_0 = "FetchEvaluationCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	pg = var_1_10003

	local var_1_2 = var_1_10003.TimeMgr.GetInstance()
	local var_1_3 = var_3.GetServerTime(var_1_2)

	getProxy = var_1_0
	CollectionProxy = var_1_10006

	local var_1_4 = var_1_0(var_1_10006)

	if not var_4.getShipGroup(var_1_4, var_1_1) then
		return
	end

	assert = var_1_10006

	var_1_10006(var_5, "shipGroup is nil" .. var_1_1)

	local var_1_5 = var_1_3 - var_5.lastReqStamp

	ShipGroup = var_1_4

	if var_1_5 > var_1_4.REQ_INTERVAL then
		pg = var_1_5

		local var_1_6 = var_1_5.ConnectionMgr.GetInstance()

		var_6.Send(var_1_6, 17101, {
			ship_group_id = var_1_1
		}, 17102, function(arg_2_0)
			if arg_2_0.ship_discuss and var_1.ship_group_id == var_1_1 then
				if var_0 then
					var_2_10002 = var_0
					ShipEvaluation = var_3
					var_2_10002.evaluation = var_3.New(var_1)
					var_2_10002 = var_0
					pg = var_3
					var_2_10005 = var_3.TimeMgr.GetInstance()
					var_2_10002.lastReqStamp = var_3.GetServerTime(var_2_10005)

					local var_2_0 = var_0

					var_2_10002.updateShipGroup(var_2_0, var_0)

					local var_2_1 = arg_1_0

					var_2_10002 = var_2_10002.sendNotification
					GAME = var_2_10005

					var_2_10002(var_2_1, var_2_10005.FETCH_EVALUATION_DONE, var_1_1)
				end
			else
				pg = var_2_10002

				local var_2_2 = var_2_10002.TipsMgr.GetInstance()
				local var_2_3 = var_2.ShowTips

				errorTip = var_2_10005

				var_2_3(var_2_2, var_2_10005("fetch_ship_eva", arg_2_0.result))
			end

			return
		end)
	elseif var_5.evaluation then
		local var_1_7 = arg_1_0
		local var_1_8 = arg_1_0.sendNotification

		GAME = var_9

		var_1_8(var_1_7, var_9.FETCH_EVALUATION_DONE, var_1_1)
	end

	return
end

return var_0_1
