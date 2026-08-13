class = var_0_10000

local var_0_0 = "InvitedFeastShip"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.BaseVO"))

var_0_1.STATE_EMPTY = 0
var_0_1.STATE_MAKE_TICKET = 1
var_0_1.STATE_GOT_TICKET = 2
var_0_1.GIFT_STATE_EMPTY = 0
var_0_1.GIFT_STATE_GOT = 1

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.tid
	arg_1_0.tid = arg_1_0.id
	arg_1_0.configId = arg_1_0:FindFeastConfigIdByGroupId(arg_1_0.id)
	assert = var_2

	var_2(arg_1_0.configId)

	arg_1_0.invitationStatus = var_0_1.STATE_EMPTY
	arg_1_0.giftState = var_0_1.GIFT_STATE_EMPTY

	return
end

function var_0_1.FindFeastConfigIdByGroupId(arg_2_0, arg_2_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	local var_2_0 = var_1_10002(var_1_10004)
	local var_2_1 = var_2.getActivityByType

	ActivityConst = var_1_10005

	local var_2_2 = var_2_1(var_2_0, var_1_10005.ACTIVITY_TYPE_FEAST)

	assert = var_1_10003

	var_1_10003(var_2_2)

	local var_2_3 = var_2_2:getConfig("config_data")

	ipairs = var_2_0

	local var_2_4

	if not var_2_3[3] then
		var_2_4 = {}
	end

	for iter_2_0, iter_2_1 in var_2_0(var_2_4) do
		pg = var_1_10009

		if var_1_10009.activity_partyinvitation_template[iter_2_1].groupid == arg_2_1 then
			return iter_2_1
		end
	end

	return nil
end

function var_0_1.bindConfigTable(arg_3_0)
	pg = var_1_10001

	return var_1_10001.activity_partyinvitation_template
end

function var_0_1.SetInvitationState(arg_4_0, arg_4_1)
	arg_4_0.invitationStatus = arg_4_1

	return
end

function var_0_1.GetInvitationState(arg_5_0)
	return arg_5_0.invitationStatus
end

function var_0_1.SetGiftState(arg_6_0, arg_6_1)
	arg_6_0.giftState = arg_6_1

	return
end

function var_0_1.GetGiftState(arg_7_0)
	return arg_7_0.giftState
end

function var_0_1.GetTicketConsume(arg_8_0)
	local var_8_0 = arg_8_0:getConfig("invitationID")

	return {
		type = var_8_0[1],
		id = var_8_0[2],
		count = var_8_0[3]
	}
end

function var_0_1.GetGiftConsume(arg_9_0)
	local var_9_0 = arg_9_0:getConfig("giftID")

	return {
		type = var_9_0[1],
		id = var_9_0[2],
		count = var_9_0[3]
	}
end

function var_0_1.GetSkinId(arg_10_0)
	return arg_10_0:getConfig("skinId")
end

function var_0_1.GetPrefab(arg_11_0)
	local var_11_0 = arg_11_0:GetSkinId()

	pg = var_1_10002

	return var_1_10002.ship_skin_template[var_11_0].prefab
end

function var_0_1.GotTicket(arg_12_0)
	return arg_12_0:GetInvitationState() == var_0_1.STATE_GOT_TICKET
end

function var_0_1.GotGift(arg_13_0)
	return arg_13_0:GetGiftState() == var_0_1.GIFT_STATE_GOT
end

function var_0_1.HasTicket(arg_14_0)
	return arg_14_0:GetInvitationState() == var_0_1.STATE_MAKE_TICKET
end

function var_0_1.GetShipName(arg_15_0)
	ShipGroup = var_1_10001

	return var_1_10001.getDefaultShipConfig(arg_15_0.tid).name
end

function var_0_1.GetDialogueForTicket(arg_16_0)
	if arg_16_0:GotTicket() then
		return arg_16_0:getConfig("getletter")
	else
		return arg_16_0:getConfig("uninvitation")
	end

	return
end

function var_0_1.GetDialogueForGift(arg_17_0)
	if arg_17_0:GotGift() then
		return arg_17_0:getConfig("getgift")
	else
		return arg_17_0:getConfig("ungift")
	end

	return
end

function var_0_1.GetSpeechContent(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_1
	local var_18_1 = {
		"feeling",
		"drinkfeeling",
		"foodfeeling",
		"dancefeeling"
	}

	if var_18_0 <= 0 or var_18_0 > #var_18_1 or arg_18_2 <= 0 then
		return ""
	end

	local var_18_2 = var_18_1[var_18_0]
	local var_18_3

	if not arg_18_0:getConfig(var_18_2)[arg_18_2] then
		var_18_3 = ""
	end

	return var_18_3
end

function var_0_1.GetInvitationStory(arg_19_0)
	return arg_19_0:getConfig("getletter_story")
end

function var_0_1.GetGiftStory(arg_20_0)
	return arg_20_0:getConfig("getgift_story")
end

return var_0_1
