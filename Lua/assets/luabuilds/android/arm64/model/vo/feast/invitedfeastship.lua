local var_0_0 = class("InvitedFeastShip", import("model.vo.BaseVO"))

var_0_0.STATE_EMPTY = 0
var_0_0.STATE_MAKE_TICKET = 1
var_0_0.STATE_GOT_TICKET = 2
var_0_0.GIFT_STATE_EMPTY = 0
var_0_0.GIFT_STATE_GOT = 1

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.tid
	arg_1_0.tid = arg_1_0.id
	arg_1_0.configId = arg_1_0:FindFeastConfigIdByGroupId(arg_1_0.id)

	assert(arg_1_0.configId)

	arg_1_0.invitationStatus = var_0_0.STATE_EMPTY
	arg_1_0.giftState = var_0_0.GIFT_STATE_EMPTY

	return
end

function var_0_0.FindFeastConfigIdByGroupId(arg_2_0, arg_2_1)
	local var_2_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_FEAST)

	assert(var_2_0)

	local var_2_1 = var_2_0:getConfig("config_data")[3] or {}

	for iter_2_0, iter_2_1 in ipairs(var_2_1) do
		if pg.activity_partyinvitation_template[iter_2_1].groupid == arg_2_1 then
			return iter_2_1
		end
	end

	return nil
end

function var_0_0.bindConfigTable(arg_3_0)
	return pg.activity_partyinvitation_template
end

function var_0_0.SetInvitationState(arg_4_0, arg_4_1)
	arg_4_0.invitationStatus = arg_4_1

	return
end

function var_0_0.GetInvitationState(arg_5_0)
	return arg_5_0.invitationStatus
end

function var_0_0.SetGiftState(arg_6_0, arg_6_1)
	arg_6_0.giftState = arg_6_1

	return
end

function var_0_0.GetGiftState(arg_7_0)
	return arg_7_0.giftState
end

function var_0_0.GetTicketConsume(arg_8_0)
	local var_8_0 = arg_8_0:getConfig("invitationID")

	return {
		type = var_8_0[1],
		id = var_8_0[2],
		count = var_8_0[3]
	}
end

function var_0_0.GetGiftConsume(arg_9_0)
	local var_9_0 = arg_9_0:getConfig("giftID")

	return {
		type = var_9_0[1],
		id = var_9_0[2],
		count = var_9_0[3]
	}
end

function var_0_0.GetSkinId(arg_10_0)
	return arg_10_0:getConfig("skinId")
end

function var_0_0.GetPrefab(arg_11_0)
	return pg.ship_skin_template[arg_11_0:GetSkinId()].prefab
end

function var_0_0.GotTicket(arg_12_0)
	return arg_12_0:GetInvitationState() == var_0_0.STATE_GOT_TICKET
end

function var_0_0.GotGift(arg_13_0)
	return arg_13_0:GetGiftState() == var_0_0.GIFT_STATE_GOT
end

function var_0_0.HasTicket(arg_14_0)
	return arg_14_0:GetInvitationState() == var_0_0.STATE_MAKE_TICKET
end

function var_0_0.GetShipName(arg_15_0)
	return ShipGroup.getDefaultShipConfig(arg_15_0.tid).name
end

function var_0_0.GetDialogueForTicket(arg_16_0)
	if arg_16_0:GotTicket() then
		return arg_16_0:getConfig("getletter")
	else
		return arg_16_0:getConfig("uninvitation")
	end

	return
end

function var_0_0.GetDialogueForGift(arg_17_0)
	if arg_17_0:GotGift() then
		return arg_17_0:getConfig("getgift")
	else
		return arg_17_0:getConfig("ungift")
	end

	return
end

function var_0_0.GetSpeechContent(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_1 <= 0 or arg_18_1 > #{
		"feeling",
		"drinkfeeling",
		"foodfeeling",
		"dancefeeling"
	} or arg_18_2 <= 0 then
		return ""
	end

	return arg_18_0:getConfig(({
		"feeling",
		"drinkfeeling",
		"foodfeeling",
		"dancefeeling"
	})[arg_18_1])[arg_18_2] or ""
end

function var_0_0.GetInvitationStory(arg_19_0)
	return arg_19_0:getConfig("getletter_story")
end

function var_0_0.GetGiftStory(arg_20_0)
	return arg_20_0:getConfig("getgift_story")
end

return var_0_0
