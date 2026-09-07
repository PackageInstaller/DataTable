local InvitedFeastShip = class("InvitedFeastShip", import("model.vo.BaseVO"))

InvitedFeastShip.STATE_EMPTY = 0
InvitedFeastShip.STATE_MAKE_TICKET = 1
InvitedFeastShip.STATE_GOT_TICKET = 2
InvitedFeastShip.GIFT_STATE_EMPTY = 0
InvitedFeastShip.GIFT_STATE_GOT = 1

function InvitedFeastShip:Ctor(arg_1_1)
	self.id = arg_1_1.tid
	self.tid = self.id
	self.configId = self:FindFeastConfigIdByGroupId(self.id)

	assert(self.configId)

	self.invitationStatus = InvitedFeastShip.STATE_EMPTY
	self.giftState = InvitedFeastShip.GIFT_STATE_EMPTY

	return
end

function InvitedFeastShip:FindFeastConfigIdByGroupId(arg_2_1)
	local var_2_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_FEAST)

	assert(var_2_0)

	for iter_2_0, iter_2_1 in ipairs(var_2_0:getConfig("config_data")[3] or {}) do
		if pg.activity_partyinvitation_template[iter_2_1].groupid == arg_2_1 then
			return iter_2_1
		end
	end

	return nil
end

function InvitedFeastShip:bindConfigTable()
	return pg.activity_partyinvitation_template
end

function InvitedFeastShip:SetInvitationState(arg_4_1)
	self.invitationStatus = arg_4_1

	return
end

function InvitedFeastShip:GetInvitationState()
	return self.invitationStatus
end

function InvitedFeastShip:SetGiftState(arg_6_1)
	self.giftState = arg_6_1

	return
end

function InvitedFeastShip:GetGiftState()
	return self.giftState
end

function InvitedFeastShip:GetTicketConsume()
	local var_8_0 = self:getConfig("invitationID")

	return {
		type = var_8_0[1],
		id = var_8_0[2],
		count = var_8_0[3]
	}
end

function InvitedFeastShip:GetGiftConsume()
	local var_9_0 = self:getConfig("giftID")

	return {
		type = var_9_0[1],
		id = var_9_0[2],
		count = var_9_0[3]
	}
end

function InvitedFeastShip:GetSkinId()
	return self:getConfig("skinId")
end

function InvitedFeastShip:GetPrefab()
	return pg.ship_skin_template[self:GetSkinId()].prefab
end

function InvitedFeastShip:GotTicket()
	return self:GetInvitationState() == InvitedFeastShip.STATE_GOT_TICKET
end

function InvitedFeastShip:GotGift()
	return self:GetGiftState() == InvitedFeastShip.GIFT_STATE_GOT
end

function InvitedFeastShip:HasTicket()
	return self:GetInvitationState() == InvitedFeastShip.STATE_MAKE_TICKET
end

function InvitedFeastShip:GetShipName()
	return ShipGroup.getDefaultShipConfig(self.tid).name
end

function InvitedFeastShip:GetDialogueForTicket()
	if self:GotTicket() then
		return self:getConfig("getletter")
	else
		return self:getConfig("uninvitation")
	end

	return
end

function InvitedFeastShip:GetDialogueForGift()
	if self:GotGift() then
		return self:getConfig("getgift")
	else
		return self:getConfig("ungift")
	end

	return
end

function InvitedFeastShip:GetSpeechContent(arg_18_1, arg_18_2)
	local var_18_0 = {
		"feeling",
		"drinkfeeling",
		"foodfeeling",
		"dancefeeling"
	}

	if arg_18_1 <= 0 or arg_18_1 > #var_18_0 or arg_18_2 <= 0 then
		return ""
	end

	return self:getConfig(var_18_0[arg_18_1])[arg_18_2] or ""
end

function InvitedFeastShip:GetInvitationStory()
	return self:getConfig("getletter_story")
end

function InvitedFeastShip:GetGiftStory()
	return self:getConfig("getgift_story")
end

return InvitedFeastShip
