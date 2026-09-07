local CourtYardVariedInteraction = class("CourtYardVariedInteraction", import(".CourtYardInteraction"))

function CourtYardVariedInteraction:InitData()
	CourtYardVariedInteraction.super.InitData(self)

	self.total = 1

	return
end

function CourtYardVariedInteraction:GetInterActionUserCnt()
	local var_2_0 = self.host:GetOwner()

	if isa(var_2_0, CourtYardFurniture) then
		return #var_2_0:GetUsingSlots()
	else
		return 1
	end

	return
end

function CourtYardVariedInteraction:GetUserAction()
	return self.userActions[self:GetInterActionUserCnt()]
end

function CourtYardVariedInteraction:GetOwnerAction()
	return self.ownerActions[self:GetInterActionUserCnt()]
end

function CourtYardVariedInteraction:Reset()
	self.index = 0

	self:Update(self.loop)

	return
end

function CourtYardVariedInteraction:OnStepEnd()
	if self:IsCompleteOwnerStep() then
		self:DoStep()
	end

	return
end

return CourtYardVariedInteraction
