class = var_0_10000

local var_0_0 = "NewSkinMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.SET_SKIN = "NewSkinMediator:SET_SKIN"
var_0_1.ON_EXIT = "NewSkinMediator:ON_EXIT"

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0.viewComponent

	var_1.setSkin(var_1_0, arg_1_0.contextData.skinId)
	arg_1_0:bind(var_0_1.SET_SKIN, function(arg_2_0, arg_2_1, arg_2_2)
		ipairs = var_2_10003

		for iter_2_0, iter_2_1 in var_2_10003(arg_2_1) do
			ShipPhantom = var_2_10008

			local var_2_0

			var_2_10008, var_2_0 = var_2_10008.UnpackMark(iter_2_1)

			local var_2_1 = arg_1_0
			local var_2_2 = var_10.sendNotification

			GAME = var_2_10013

			var_2_2(var_2_1, var_2_10013.SET_SHIP_SKIN, {
				shipId = var_2_10008,
				phantomId = var_2_0,
				skinId = arg_1_0.contextData.skinId
			})
		end

		getProxy = var_3
		SettingsProxy = var_5

		local var_2_3 = var_3(var_5)

		var_3.SetFlagShip(var_2_3, arg_2_2)

		local var_2_5

		if arg_2_2 then
			local var_2_4 = arg_2_1[1]

			getProxy = var_4
			PlayerProxy = var_2_5
			var_2_5 = var_4(var_2_5)
			var_2_5 = var_4.getRawData(var_2_5)

			local var_2_6 = var_4.GetShipPhantomMarks(var_2_5)

			var_2_6[1] = var_2_4

			local var_2_7 = arg_1_0
			local var_2_8 = var_5.sendNotification

			GAME = var_2_10008

			var_2_8(var_2_7, var_2_10008.CHANGE_PLAYER_ICON, {
				skinPage = true,
				after = var_2_6
			})
		end

		local var_2_9 = arg_1_0.viewComponent
		local var_2_10 = var_3.emit

		BaseUI = var_2_5

		var_2_10(var_2_9, var_2_5.ON_CLOSE)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	return {}
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	return
end

return var_0_1
