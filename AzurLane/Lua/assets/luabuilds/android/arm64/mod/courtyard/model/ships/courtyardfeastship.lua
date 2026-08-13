class = var_0_10000

local var_0_0 = "CourtYardFeastShip"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".CourtYardShip"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	local var_1_0

	if not arg_1_2.bubble then
		var_1_0 = 0
	end

	arg_1_0.bubble = var_1_0
	arg_1_0.isSpecial = arg_1_2.isSpecial
	getProxy = var_3
	ActivityProxy = var_5

	local var_1_1 = var_3(var_5)
	local var_1_2 = var_3.getActivityByType

	ActivityConst = var_6

	local var_1_3 = var_1_2(var_1_1, var_6.ACTIVITY_TYPE_FEAST)

	arg_1_0.interActionConfig = {}

	if var_1_3 and not var_1_3:isEnd() then
		arg_1_0.interActionConfig = var_1_3:getConfig("config_client")
	end

	return
end

function var_0_1.GetShipType(arg_2_0)
	CourtYardConst = var_1_10001

	return var_1_10001.SHIP_TYPE_FEAST
end

function var_0_1.IsSpecial(arg_3_0)
	return arg_3_0.isSpecial
end

function var_0_1.GetIsSpecialValue(arg_4_0)
	return arg_4_0.isSpecial and 1 or 0
end

function var_0_1.UpdateBubble(arg_5_0, arg_5_1)
	arg_5_0.bubble = arg_5_1 or 0

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.DispatchEvent

	CourtYardEvent = var_1_10005

	var_5_1(var_5_0, var_1_10005.FEAST_SHIP_BUBBLE_CHANGE, arg_5_1)

	return
end

function var_0_1.ExistBubble(arg_6_0)
	return arg_6_0.bubble > 0
end

function var_0_1.UpdateChatBubble(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.DispatchEvent

	CourtYardEvent = var_1_10005

	var_7_1(var_7_0, var_1_10005.FEAST_SHIP_CHAT_CHANGE, arg_7_1)

	return
end

function var_0_1.EnterFeast(arg_8_0)
	if arg_8_0:IsSpecial() then
		local var_8_0 = arg_8_0
		local var_8_1 = arg_8_0.DispatchEvent

		CourtYardEvent = var_1_10004

		var_8_1(var_8_0, var_1_10004.FEAST_SHIP_SHOW_EXPRESS, 1)
	end

	return
end

function var_0_1.OnInterAction(arg_9_0, arg_9_1)
	var_0_1.super.OnInterAction(arg_9_0, arg_9_1)

	local var_9_0 = arg_9_1:GetOwner()

	isa = var_1_10003

	local var_9_1 = var_9_0

	CourtYardFurniture = var_1_10006

	if var_1_10003(var_9_1, var_1_10006) and arg_9_0:ExistBubble() and arg_9_0:IsSameInterAction(var_9_0, arg_9_0.bubble) then
		local var_9_2 = arg_9_0
		local var_9_3 = arg_9_0.DispatchEvent

		CourtYardEvent = var_6

		var_9_3(var_9_2, var_6.FEAST_SHIP_BUBBLE_INTERACTION, arg_9_0.bubble)

		if not arg_9_0:IsSpecial() then
			local var_9_4 = arg_9_0:GetInterActionExpress(var_9_0)
			local var_9_5 = arg_9_0
			local var_9_6 = arg_9_0.DispatchEvent

			CourtYardEvent = var_7

			var_9_6(var_9_5, var_7.FEAST_SHIP_SHOW_EXPRESS, var_9_4)
		end
	end

	return
end

function var_0_1.GetInterActionExpress(arg_10_0, arg_10_1)
	local var_10_0

	if not arg_10_0.interActionConfig[7] then
		var_10_0 = {}
	end

	ipairs = var_1_10003

	for iter_10_0, iter_10_1 in var_1_10003(var_10_0) do
		local var_10_1 = iter_10_1[1]
		local var_10_2 = iter_10_1[2]

		if var_10_1 == arg_10_1.configId and #var_10_2 > 0 then
			math = var_10

			return var_10_2[var_10.random(1, #var_10_2)]
		end
	end

	return
end

function var_0_1.IsSameInterAction(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0

	if not arg_11_0.interActionConfig[arg_11_2] then
		var_11_0 = {}
	end

	ipairs = var_1_10005

	for iter_11_0, iter_11_1 in var_1_10005(var_11_0) do
		if arg_11_1.configId == iter_11_1 then
			return true
		end
	end

	return false
end

function var_0_1._ChangeState(arg_12_0, arg_12_1, arg_12_2)
	var_0_1.super._ChangeState(arg_12_0, arg_12_1, arg_12_2)

	CourtYardShip = var_3

	if arg_12_1 == var_3.STATE_TOUCH then
		local var_12_0 = arg_12_0.bubble

		FeastShip = var_1_10004

		if var_12_0 == var_1_10004.BUBBLE_TYPE_GREET then
			local var_12_1 = arg_12_0
			local var_12_2 = arg_12_0.DispatchEvent

			CourtYardEvent = var_6

			var_12_2(var_12_1, var_6.FEAST_SHIP_BUBBLE_INTERACTION, arg_12_0.bubble)
		end
	end

	return
end

return var_0_1
