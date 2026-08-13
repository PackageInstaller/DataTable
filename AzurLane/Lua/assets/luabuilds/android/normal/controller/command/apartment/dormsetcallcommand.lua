class = var_0_10000

local var_0_0 = "DormSetCallCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0

	var_1_0 = arg_1_1:getBody() and var_2.callback
	getProxy = var_1_10004
	ApartmentProxy = var_1_10005

	local var_1_1 = var_1_10004(var_1_10005)
	local var_1_2 = var_4.getApartment(var_1_1, var_2.groupId)

	if var_5.GetSetCallCd(var_1_2) > 0 then
		return
	end

	pg = var_6

	local var_1_3 = var_6.ConnectionMgr.GetInstance()

	var_6.Send(var_1_3, 28021, {
		ship_group = var_2.groupId,
		name = var_2.callName
	}, 28022, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			local var_2_0 = var_0

			var_2_1 = var_2_1.ModifyApartment
			var_2_10003 = var_0.groupId

			local var_2_2 = {
				callName = var_0.callName
			}

			pg = var_5

			local var_2_3 = var_5.TimeMgr.GetInstance()

			var_2_2.setCallCd = var_5.GetServerTime(var_2_3) + 0

			var_2_1(var_2_0, var_2_10003, var_2_2)

			local var_2_4 = arg_1_0

			var_2_1 = var_2_1.sendNotification
			GAME = var_2_10003
			var_2_10003 = var_2_10003.DORM_SET_CALL_DONE

			local var_2_5 = {}
			local var_2_6 = var_0

			var_2_5.apartment = var_5.getApartment(var_2_6, var_0.groupId)

			var_2_1(var_2_4, var_2_10003, var_2_5)
		else
			pg = var_2_1

			local var_2_7 = var_2_1.TipsMgr.GetInstance()
			local var_2_8 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_8(var_2_7, var_2_10003("dorm3d set call name error: ", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
