class = var_0_10000

local var_0_0 = "FeastShip"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.Ship"))

var_0_1.BUBBLE_TYPE_EMPTY = 0
var_0_1.BUBBLE_TYPE_GREET = 1
var_0_1.BUBBLE_TYPE_DRINK = 2
var_0_1.BUBBLE_TYPE_EAT = 3
var_0_1.BUBBLE_TYPE_DANCE = 4
var_0_1.BUBBLE_TYPE_SLEEP = 5
var_0_1.CHAT_BUBBLE_TYPE_EMPTY = 0
var_0_1.CHAT_BUBBLE_TYPE_1 = 1
var_0_1.CHAT_BUBBLE_TYPE_2 = 2

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.tid = arg_1_1.tid
	ShipGroup = var_2

	local var_1_0 = var_2.getDefaultShipConfig(arg_1_0.tid)
	local var_1_1 = arg_1_0
	local var_1_2 = arg_1_0.FilterSkinId

	ShipGroup = var_1_10005

	local var_1_3 = var_1_2(var_1_1, var_1_10005.getSkinList(arg_1_0.tid))

	var_0_1.super.Ctor(arg_1_0, {
		id = arg_1_0.tid,
		configId = var_1_0.id,
		skin_id = var_1_3
	})

	local var_1_4

	if not arg_1_1.bubble then
		var_1_4 = 0
	end

	arg_1_0.bubble = var_1_4

	local var_1_5

	if not arg_1_1.speech_bubble then
		var_1_5 = 0
	end

	arg_1_0.speechBubble = var_1_5
	arg_1_0.isSpecial = false

	return
end

function var_0_1.SetSkinId(arg_2_0, arg_2_1)
	arg_2_0.skinId = arg_2_1

	arg_2_0:SetIsSpecial(true)

	return
end

function var_0_1.FilterSkinId(arg_3_0, arg_3_1)
	local var_3_0 = {}

	ipairs = var_1_10003

	for iter_3_0, iter_3_1 in var_1_10003(arg_3_1) do
		ShipSkin = var_1_10008

		if var_1_10008.GetShopTypeIdBySkinId(iter_3_1.id, var_3_0) == 7 then
			return iter_3_1.id
		end
	end

	if #arg_3_1 > 0 then
		math = var_3

		return arg_3_1[var_3.random(1, #arg_3_1)].id
	else
		return 0
	end

	return
end

function var_0_1.UpdateBubble(arg_4_0, arg_4_1)
	arg_4_0.bubble = arg_4_1

	return
end

function var_0_1.ClearBubble(arg_5_0)
	arg_5_0.bubble = 0

	return
end

function var_0_1.GetBubble(arg_6_0)
	return arg_6_0.bubble
end

function var_0_1.HasBubble(arg_7_0)
	return arg_7_0.bubble ~= 0
end

function var_0_1.UpdateSpeechBubble(arg_8_0, arg_8_1)
	arg_8_0.speechBubble = arg_8_1

	return
end

function var_0_1.SetIsSpecial(arg_9_0, arg_9_1)
	arg_9_0.isSpecial = arg_9_1

	return
end

function var_0_1.IsSpecial(arg_10_0)
	return arg_10_0.isSpecial
end

return var_0_1
