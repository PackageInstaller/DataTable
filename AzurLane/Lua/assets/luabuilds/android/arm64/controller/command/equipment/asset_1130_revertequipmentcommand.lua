class = var_0_10000

local var_0_0 = "RevertEquipmentCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).id

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_4.Send(var_1_2, 14010, {
		equip_id = var_1_1
	}, 14011, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			EquipmentProxy = var_2_10003
			var_2_10004 = var_1(var_2_10003)

			local var_2_0 = var_1.getEquipmentById(var_2_10004, var_1_1)

			var_1:removeEquipmentById(var_2_0.id, 1)

			local var_2_1 = var_2_0:GetRootEquipment()
			local var_2_2 = var_1

			var_1.addEquipmentById(var_2_2, var_2_1.id, var_2_1.count)

			getProxy = var_2_10004
			BagProxy = var_2_2

			local var_2_3 = var_2_10004(var_2_2)
			local var_2_4 = var_2_10004.removeItemById

			Item = var_8

			var_2_4(var_2_3, var_8.REVERT_EQUIPMENT_ID, 1)

			local var_2_5 = var_2_0:getRevertAwards()

			pairs = var_2_2

			for iter_2_0, iter_2_1 in var_2_2(var_2_5) do
				local var_2_6 = arg_1_0
				local var_2_7 = var_11.sendNotification

				GAME = var_2_10014

				var_2_7(var_2_6, var_2_10014.ADD_ITEM, iter_2_1)
			end

			local var_2_8 = arg_1_0
			local var_2_9 = var_6.sendNotification

			GAME = iter_2_0

			var_2_9(var_2_8, iter_2_0.REVERT_EQUIPMENT_DONE, {
				awards = var_2_5
			})
		else
			pg = var_1

			local var_2_10 = var_1.TipsMgr.GetInstance()
			local var_2_11 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_11(var_2_10, var_2_10004("equipment_destroyEquipments", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
