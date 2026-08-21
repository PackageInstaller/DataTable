local var_0_0 = class("CourtYardFeastShip", import(".CourtYardShip"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.bubble = arg_1_2.bubble or 0
	arg_1_0.isSpecial = arg_1_2.isSpecial

	local var_1_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_FEAST)

	arg_1_0.interActionConfig = {}

	if var_1_0 and not var_1_0:isEnd() then
		arg_1_0.interActionConfig = var_1_0:getConfig("config_client")
	end

	return
end

function var_0_0.GetShipType(arg_2_0)
	return CourtYardConst.SHIP_TYPE_FEAST
end

function var_0_0.IsSpecial(arg_3_0)
	return arg_3_0.isSpecial
end

function var_0_0.GetIsSpecialValue(arg_4_0)
	return arg_4_0.isSpecial and 1 or 0
end

function var_0_0.UpdateBubble(arg_5_0, arg_5_1)
	arg_5_0.bubble = arg_5_1 or 0

	arg_5_0:DispatchEvent(CourtYardEvent.FEAST_SHIP_BUBBLE_CHANGE, arg_5_1)

	return
end

function var_0_0.ExistBubble(arg_6_0)
	return arg_6_0.bubble > 0
end

function var_0_0.UpdateChatBubble(arg_7_0, arg_7_1)
	arg_7_0:DispatchEvent(CourtYardEvent.FEAST_SHIP_CHAT_CHANGE, arg_7_1)

	return
end

function var_0_0.EnterFeast(arg_8_0)
	if arg_8_0:IsSpecial() then
		arg_8_0:DispatchEvent(CourtYardEvent.FEAST_SHIP_SHOW_EXPRESS, 1)
	end

	return
end

function var_0_0.OnInterAction(arg_9_0, arg_9_1)
	var_0_0.super.OnInterAction(arg_9_0, arg_9_1)

	local var_9_0 = arg_9_1:GetOwner()

	if isa(var_9_0, CourtYardFurniture) and arg_9_0:ExistBubble() and arg_9_0:IsSameInterAction(var_9_0, arg_9_0.bubble) then
		arg_9_0:DispatchEvent(CourtYardEvent.FEAST_SHIP_BUBBLE_INTERACTION, arg_9_0.bubble)

		if not arg_9_0:IsSpecial() then
			arg_9_0:DispatchEvent(CourtYardEvent.FEAST_SHIP_SHOW_EXPRESS, (arg_9_0:GetInterActionExpress(var_9_0)))
		end
	end

	return
end

function var_0_0.GetInterActionExpress(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.interActionConfig[7] or {}

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		if iter_10_1[1] == arg_10_1.configId and #iter_10_1[2] > 0 then
			return iter_10_1[2][math.random(1, #iter_10_1[2])]
		end
	end

	return
end

function var_0_0.IsSameInterAction(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.interActionConfig[arg_11_2] or {}

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		if arg_11_1.configId == iter_11_1 then
			return true
		end
	end

	return false
end

function var_0_0._ChangeState(arg_12_0, arg_12_1, arg_12_2)
	var_0_0.super._ChangeState(arg_12_0, arg_12_1, arg_12_2)

	if arg_12_1 == CourtYardShip.STATE_TOUCH and arg_12_0.bubble == FeastShip.BUBBLE_TYPE_GREET then
		arg_12_0:DispatchEvent(CourtYardEvent.FEAST_SHIP_BUBBLE_INTERACTION, arg_12_0.bubble)
	end

	return
end

return var_0_0
