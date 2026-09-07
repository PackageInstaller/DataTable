local CourtYardFollowerSlot = class("CourtYardFollowerSlot", import(".CourtYardFurnitureBaseSlot"))

function CourtYardFollowerSlot:OnInit(arg_1_1)
	self.name = arg_1_1[1][1]
	self.defaultAction = arg_1_1[1][2]
	self.skewValue = Vector3(arg_1_1[3][1][1], arg_1_1[3][1][2])
	self.aciton = arg_1_1[3][2]

	return
end

function CourtYardFollowerSlot:OnInitCombine(arg_2_1)
	self.combineData = arg_2_1

	return
end

function CourtYardFollowerSlot:GetSpineDefaultAction()
	local var_3_0 = self:GetCombineFurnitureAnimator()

	if var_3_0 then
		return var_3_0[2] or self.defaultAction
	end

	return self.defaultAction
end

function CourtYardFollowerSlot:Occupy(arg_4_1, arg_4_2, arg_4_3)
	if self:IsEmpty() then
		self.owner = arg_4_2
		self.user = arg_4_1
		self.observer = arg_4_3

		self:Use()
		self:OnAwake()
		arg_4_3:StartInteraction(self)
		arg_4_1:StartInteraction(self)
		arg_4_2:StartInteraction(self, true)
		self:OnStart()
	end

	return
end

function CourtYardFollowerSlot:OnAwake()
	self:ClearTimer()

	return
end

function CourtYardFollowerSlot:Clear(arg_6_1)
	if self:IsUsing() then
		self:Empty()
		self.observer:WillClearInteraction(self, arg_6_1)
		self.user:ClearInteraction(self, arg_6_1)
		self.owner:ClearInteraction(self, arg_6_1, true)
		self.observer:ClearInteraction(self, arg_6_1)

		self.user = nil
		self.owner = nil
		self.observer = nil
	end

	return
end

function CourtYardFollowerSlot:OnStart()
	local var_7_0 = self:GetCombineFurnitureAnimator()
	local var_7_1 = self.aciton

	var_7_1 = var_7_0 and var_7_0[3] or var_7_1

	self.user:UpdateInteraction({
		action = var_7_1,
		slot = self
	})

	return
end

function CourtYardFollowerSlot:ClearTimer()
	return
end

function CourtYardFollowerSlot:OnStop()
	self:ClearTimer()

	return
end

function CourtYardFollowerSlot:OnEnd()
	self:ClearTimer()

	return
end

function CourtYardFollowerSlot:GetBodyMask()
	return false
end

function CourtYardFollowerSlot:GetUsingAnimator()
	return false
end

function CourtYardFollowerSlot:GetFollower()
	return nil
end

return CourtYardFollowerSlot
