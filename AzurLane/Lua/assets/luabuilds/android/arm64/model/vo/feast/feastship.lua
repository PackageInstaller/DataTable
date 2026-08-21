local var_0_0 = class("FeastShip", import("model.vo.Ship"))

var_0_0.BUBBLE_TYPE_EMPTY = 0
var_0_0.BUBBLE_TYPE_GREET = 1
var_0_0.BUBBLE_TYPE_DRINK = 2
var_0_0.BUBBLE_TYPE_EAT = 3
var_0_0.BUBBLE_TYPE_DANCE = 4
var_0_0.BUBBLE_TYPE_SLEEP = 5
var_0_0.CHAT_BUBBLE_TYPE_EMPTY = 0
var_0_0.CHAT_BUBBLE_TYPE_1 = 1
var_0_0.CHAT_BUBBLE_TYPE_2 = 2

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.tid = arg_1_1.tid

	var_0_0.super.Ctor(arg_1_0, {
		id = arg_1_0.tid,
		configId = ShipGroup.getDefaultShipConfig(arg_1_0.tid).id,
		skin_id = arg_1_0:FilterSkinId(ShipGroup.getSkinList(arg_1_0.tid))
	})

	arg_1_0.bubble = arg_1_1.bubble or 0
	arg_1_0.speechBubble = arg_1_1.speech_bubble or 0
	arg_1_0.isSpecial = false

	return
end

function var_0_0.SetSkinId(arg_2_0, arg_2_1)
	arg_2_0.skinId = arg_2_1

	arg_2_0:SetIsSpecial(true)

	return
end

function var_0_0.FilterSkinId(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		if ShipSkin.GetShopTypeIdBySkinId(iter_3_1.id, {}) == 7 then
			return iter_3_1.id
		end
	end

	if #arg_3_1 > 0 then
		return arg_3_1[math.random(1, #arg_3_1)].id
	else
		return 0
	end

	return
end

function var_0_0.UpdateBubble(arg_4_0, arg_4_1)
	arg_4_0.bubble = arg_4_1

	return
end

function var_0_0.ClearBubble(arg_5_0)
	arg_5_0.bubble = 0

	return
end

function var_0_0.GetBubble(arg_6_0)
	return arg_6_0.bubble
end

function var_0_0.HasBubble(arg_7_0)
	return arg_7_0.bubble ~= 0
end

function var_0_0.UpdateSpeechBubble(arg_8_0, arg_8_1)
	arg_8_0.speechBubble = arg_8_1

	return
end

function var_0_0.SetIsSpecial(arg_9_0, arg_9_1)
	arg_9_0.isSpecial = arg_9_1

	return
end

function var_0_0.IsSpecial(arg_10_0)
	return arg_10_0.isSpecial
end

return var_0_0
