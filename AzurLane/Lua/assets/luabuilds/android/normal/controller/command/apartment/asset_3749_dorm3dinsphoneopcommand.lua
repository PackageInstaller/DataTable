class = var_0_10000

local var_0_0 = "Dorm3dInsPhoneOpCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_0
	Dorm3dInsProxy = var_1_10004

	local var_1_2 = var_1_0(var_1_10004)
	local var_1_3 = var_3.GetPhoneListByGroup(var_1_2, var_1_1.groupId)

	_ = var_1_2

	if not var_1_2.detect(var_1_3, function(arg_2_0)
		return arg_2_0.id == var_1_1.id
	end) then
		return
	end

	pg = var_5

	local var_1_4 = var_5.ConnectionMgr.GetInstance()

	var_5.Send(var_1_4, 28026, {
		type = 2,
		ship_id = var_1_1.groupId,
		id_list = {
			var_1_1.id
		}
	}, 28027, function(arg_3_0)
		local var_3_2

		if arg_3_0.result == 0 then
			local var_3_0 = var_0

			var_3_2.MarkRead(var_3_0)

			local var_3_1 = arg_1_0

			var_3_2 = var_3_2.sendNotification
			GAME = var_2_10003

			var_3_2(var_3_1, var_2_10003.DORM3D_INS_PHONE_OP_DONE)
		else
			pg = var_3_2

			local var_3_3 = var_3_2.TipsMgr.GetInstance()
			local var_3_4 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_3_4(var_3_3, var_2_10003[arg_3_0.result] .. arg_3_0.result)
		end

		return
	end)

	return
end

return var_0_1
