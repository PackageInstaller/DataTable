local CourtYardFollowerFurniture = class("CourtYardFollowerFurniture", import(".CourtYardFurniture"))

function CourtYardFollowerFurniture:InitSlots()
	self.ratios = {}

	table.insert(self.slots, CourtYardFollowerSlot.New(1, self.config.spine, self.config.spine_combine_action_replace, self.host))

	return
end

function CourtYardFollowerFurniture:GetInterActionTime()
	return math.random(5, 10)
end

function CourtYardFollowerFurniture:GetRatio(arg_3_1)
	return self.ratios[arg_3_1] or 0
end

function CourtYardFollowerFurniture:IncreaseRatio(arg_4_1)
	self.ratios[arg_4_1] = 100

	return
end

function CourtYardFollowerFurniture:ReduceRatio(arg_5_1)
	self.ratios[arg_5_1] = self:GetRatio(arg_5_1) - 20

	return
end

function CourtYardFollowerFurniture:CanFollower(arg_6_1)
	if self:IsUsing() then
		return false
	end

	local var_6_0 = self:GetRatio(arg_6_1) <= 0

	if not var_6_0 then
		self:ReduceRatio(arg_6_1)
	end

	return var_6_0
end

function CourtYardFollowerFurniture:IsUsing()
	return self.slots[1]:IsUsing()
end

function CourtYardFollowerFurniture:StartInteraction(arg_8_1)
	CourtYardFollowerFurniture.super.StartInteraction(self, arg_8_1)
	self:IncreaseRatio((arg_8_1:GetOwner()))

	return
end

function CourtYardFollowerFurniture:GetOwner()
	if self:IsUsing() then
		return self.slots[1]:GetOwner()
	end

	return
end

function CourtYardFollowerFurniture:Stop()
	self.slots[1]:Stop()

	return
end

function CourtYardFollowerFurniture:SetPosition(arg_11_1)
	CourtYardFollowerFurniture.super.SetPosition(self, arg_11_1)
	self:DispatchEvent(CourtYardEvent.ROTATE_FURNITURE, self.dir)

	return
end

return CourtYardFollowerFurniture
