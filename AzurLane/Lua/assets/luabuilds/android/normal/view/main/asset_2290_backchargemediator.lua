class = var_0_10000

local var_0_0 = "BackChargeMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.CHARGE = "BackChargeMediator:CHARGE"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_1_0 = var_1_10001(var_1_10002)
	local var_1_1 = var_1.getData(var_1_0)
	local var_1_2 = arg_1_0.viewComponent

	var_3.setPlayer(var_1_2, var_1_1)

	getProxy = var_3
	ShopsProxy = var_1_2

	local var_1_3 = var_3(var_1_2)

	if var_3.getChargedList(var_1_3) then
		local var_1_4 = arg_1_0.viewComponent

		var_5.setChargedList(var_1_4, var_4)
	end

	arg_1_0:bind(var_0_1.CHARGE, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.REFUND_CHHARGE, {
			shopId = arg_2_1
		})

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	local var_3_0 = {}

	PlayerProxy = var_1_10002
	var_3_0[1] = var_1_10002.UPDATED
	GAME = var_2
	var_3_0[2] = var_2.CHARGE_SUCCESS
	GAME = var_2
	var_3_0[3] = var_2.REFUND_INFO_UPDATE

	return var_3_0
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1
	local var_4_2 = arg_4_1.getBody(var_4_1)

	PlayerProxy = var_4_1

	if var_4_0 == var_4_1.UPDATED then
		-- block empty
	else
		ShopsProxy = var_4

		if var_4_0 == var_4.CHARGED_LIST_UPDATED then
			-- block empty
		else
			GAME = var_4

			if var_4_0 == var_4.CHARGE_CONFIRM_FAILED then
				-- block empty
			else
				GAME = var_4

				local var_4_4

				if var_4_0 == var_4.CHARGE_SUCCESS then
					local var_4_3 = arg_4_0

					var_4_4 = arg_4_0.sendNotification
					GAME = var_1_10006

					var_4_4(var_4_3, var_1_10006.GET_REFUND_INFO)
				else
					GAME = var_4_4

					if var_4_0 == var_4_4.REFUND_INFO_UPDATE then
						local var_4_5 = arg_4_0.viewComponent

						var_4.refundUpdate(var_4_5)
					end
				end
			end
		end
	end

	return
end

return var_0_1
