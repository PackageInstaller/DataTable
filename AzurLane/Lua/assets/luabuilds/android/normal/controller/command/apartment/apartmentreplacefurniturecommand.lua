class = var_0_10000

local var_0_0 = "ApartmentReplaceFurnitureCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.body.roomId
	local var_1_1 = var_2.furnitures

	_ = var_1_10005

	local var_1_2 = var_1_10005.map(var_1_1, function(arg_2_0)
		return {
			slot_id = arg_2_0.slotId,
			furniture_id = arg_2_0.furnitureId
		}
	end)

	pg = var_6

	local var_1_3 = var_6.ConnectionMgr.GetInstance()

	var_6.Send(var_1_3, 28007, {
		room_id = var_1_0,
		furnitures = var_1_2
	}, 28008, function(arg_3_0)
		local var_3_0

		if arg_3_0.result ~= 0 then
			pg = var_3_0
			var_2_10002 = var_3_0.TipsMgr.GetInstance()
			var_3_0 = var_3_0.ShowTips
			errorTip = var_2_10003

			var_3_0(var_2_10002, var_2_10003("", arg_3_0.result))

			var_2_10002 = arg_1_0
			var_3_0 = var_3_0.sendNotification
			GAME = var_3

			var_3_0(var_2_10002, var_3.APARTMENT_REPLACE_FURNITURE_ERROR)

			return
		end

		getProxy = var_3_0
		ApartmentProxy = var_2_10002

		local var_3_1 = var_3_0(var_2_10002)

		var_1.ModifyRoom(var_3_1, var_1_0, function(arg_4_0)
			arg_4_0:ReplaceFurnitures(var_1_1)

			return
		end)

		pg = var_1

		local var_3_2 = var_1.TipsMgr.GetInstance()
		local var_3_3 = var_1.ShowTips

		i18n = var_3

		var_3_3(var_3_2, var_3("dorm3d_furniture_save_success"))

		local var_3_4 = arg_1_0
		local var_3_5 = var_1.sendNotification

		GAME = var_3

		var_3_5(var_3_4, var_3.APARTMENT_REPLACE_FURNITURE_DONE)

		return
	end)

	return
end

return var_0_1
