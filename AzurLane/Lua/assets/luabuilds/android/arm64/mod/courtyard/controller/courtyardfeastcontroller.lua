class = var_0_10000

local var_0_0 = "CourtYardFeastController"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".CourtYardController"))

function var_0_1.ShipBubbleInterActionFinish(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0.storey

	if var_2.GetShip(var_1_0, arg_1_1) then
		local var_1_1 = var_2:GetIsSpecialValue()
		local var_1_2 = arg_1_0
		local var_1_3 = arg_1_0.SendNotification

		CourtYardEvent = var_1_10007

		var_1_3(var_1_2, var_1_10007._FEAST_INTERACTION, {
			groupId = arg_1_1,
			special = var_1_1
		})
	end

	return
end

function var_0_1.UpdateBubble(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0.storey
	local var_2_1 = var_3.GetShip(var_2_0, arg_2_1)

	assert = var_1_10004

	var_1_10004(var_2_1, arg_2_1)

	if var_2_1 then
		var_2_1:UpdateBubble(arg_2_2)
	end

	return
end

function var_0_1.UpdateChatBubble(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0.storey
	local var_3_1 = var_3.GetShip(var_3_0, arg_3_1)

	assert = var_1_10004

	var_1_10004(var_3_1, arg_3_1)

	if var_3_1 then
		var_3_1:UpdateChatBubble(arg_3_2)
	end

	return
end

function var_0_1.ExitAllShip(arg_4_0)
	pairs = var_1_10001

	for iter_4_0, iter_4_1 in var_1_10001(arg_4_0.storey.ships) do
		local var_4_0 = arg_4_0.storey

		var_6.ExitShip(var_4_0, iter_4_0)
	end

	return
end

function var_0_1.AddShipWithSpecialPosition(arg_5_0, arg_5_1)
	if not arg_5_0.storey then
		return
	end

	local var_5_0 = arg_5_0:DataToShip(arg_5_1)
	local var_5_1 = var_2.SetPosition

	Vector2 = var_1_10006

	var_5_1(var_5_0, var_1_10006(25, 11))

	local var_5_2 = arg_5_0.storey

	if var_3.GetAroundEmptyPosition(var_5_2, var_2) then
		var_2:SetPosition(var_3)

		local var_5_3 = arg_5_0.storey

		var_4.AddShip(var_5_3, var_2)
	else
		local var_5_4 = arg_5_0
		local var_5_5 = arg_5_0.SendNotification

		CourtYardEvent = var_1_10007

		var_5_5(var_5_4, var_1_10007._NO_POS_TO_ADD_SHIP, var_2.id)
	end

	return
end

function var_0_1.ShipEnterFeast(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.storey

	if var_2.GetShip(var_6_0, arg_6_1) then
		var_2:EnterFeast()
	end

	return
end

return var_0_1
