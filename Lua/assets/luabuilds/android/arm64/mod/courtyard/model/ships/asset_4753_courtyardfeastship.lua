local CourtYardFeastShip = class("CourtYardFeastShip", import(".CourtYardShip"))

function CourtYardFeastShip:Ctor(arg_1_1, arg_1_2)
	CourtYardFeastShip.super.Ctor(self, arg_1_1, arg_1_2)

	self.bubble = arg_1_2.bubble or 0
	self.isSpecial = arg_1_2.isSpecial

	local var_1_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_FEAST)

	self.interActionConfig = {}

	if var_1_0 and not var_1_0:isEnd() then
		self.interActionConfig = var_1_0:getConfig("config_client")
	end

	return
end

function CourtYardFeastShip:GetShipType()
	return CourtYardConst.SHIP_TYPE_FEAST
end

function CourtYardFeastShip:IsSpecial()
	return self.isSpecial
end

function CourtYardFeastShip:GetIsSpecialValue()
	return self.isSpecial and 1 or 0
end

function CourtYardFeastShip:UpdateBubble(arg_5_1)
	self.bubble = arg_5_1 or 0

	self:DispatchEvent(CourtYardEvent.FEAST_SHIP_BUBBLE_CHANGE, arg_5_1)

	return
end

function CourtYardFeastShip:ExistBubble()
	return self.bubble > 0
end

function CourtYardFeastShip:UpdateChatBubble(arg_7_1)
	self:DispatchEvent(CourtYardEvent.FEAST_SHIP_CHAT_CHANGE, arg_7_1)

	return
end

function CourtYardFeastShip:EnterFeast()
	if self:IsSpecial() then
		self:DispatchEvent(CourtYardEvent.FEAST_SHIP_SHOW_EXPRESS, 1)
	end

	return
end

function CourtYardFeastShip:OnInterAction(arg_9_1)
	CourtYardFeastShip.super.OnInterAction(self, arg_9_1)

	local var_9_0 = arg_9_1:GetOwner()

	if isa(var_9_0, CourtYardFurniture) and self:ExistBubble() and self:IsSameInterAction(var_9_0, self.bubble) then
		self:DispatchEvent(CourtYardEvent.FEAST_SHIP_BUBBLE_INTERACTION, self.bubble)

		if not self:IsSpecial() then
			self:DispatchEvent(CourtYardEvent.FEAST_SHIP_SHOW_EXPRESS, (self:GetInterActionExpress(var_9_0)))
		end
	end

	return
end

function CourtYardFeastShip:GetInterActionExpress(arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(self.interActionConfig[7] or {}) do
		if iter_10_1[1] == arg_10_1.configId and #iter_10_1[2] > 0 then
			return iter_10_1[2][math.random(1, #iter_10_1[2])]
		end
	end

	return
end

function CourtYardFeastShip:IsSameInterAction(arg_11_1, arg_11_2)
	for iter_11_0, iter_11_1 in ipairs(self.interActionConfig[arg_11_2] or {}) do
		if arg_11_1.configId == iter_11_1 then
			return true
		end
	end

	return false
end

function CourtYardFeastShip:_ChangeState(arg_12_1, arg_12_2)
	CourtYardFeastShip.super._ChangeState(self, arg_12_1, arg_12_2)

	if arg_12_1 == CourtYardShip.STATE_TOUCH and self.bubble == FeastShip.BUBBLE_TYPE_GREET then
		self:DispatchEvent(CourtYardEvent.FEAST_SHIP_BUBBLE_INTERACTION, self.bubble)
	end

	return
end

return CourtYardFeastShip
