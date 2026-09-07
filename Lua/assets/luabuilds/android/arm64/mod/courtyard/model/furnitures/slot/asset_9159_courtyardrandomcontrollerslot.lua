local CourtYardRandomControllerSlot = class("CourtYardRandomControllerSlot", import(".CourtYardFurnitureBaseSlot"))

function CourtYardRandomControllerSlot:OnInit(arg_1_1)
	self.name = arg_1_1[1][1]
	self.defaultAction = arg_1_1[1][2]
	self.mask = arg_1_1[2] and arg_1_1[2][1]

	if self.mask then
		self.maskDefaultAction = arg_1_1[2][2]
	end

	self.actions = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1[3][2]) do
		table.insert(self.actions, {
			userAction = iter_1_1[3],
			controller = iter_1_1[2],
			ownerAction = iter_1_1[1]
		})
	end

	return
end

function CourtYardRandomControllerSlot:SetAnimators(arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1[1]) do
		table.insert(self.animators, {
			key = self.id .. "_" .. iter_2_0,
			value = iter_2_1
		})
	end

	return
end

function CourtYardRandomControllerSlot:GetSpineDefaultAction()
	return self.defaultAction
end

function CourtYardRandomControllerSlot:GetSpineMaskDefaultAcation()
	return self.maskDefaultAction
end

function CourtYardRandomControllerSlot:OnAwake()
	local var_5_0 = self.actions[math.random(1, #self.actions)]

	self.animatorIndex = 0

	for iter_5_0, iter_5_1 in ipairs(self.animators) do
		if iter_5_1.value == var_5_0.controller then
			self.animatorIndex = iter_5_0
		end
	end

	self.actionData = var_5_0

	return
end

function CourtYardRandomControllerSlot:OnStart()
	self.user:UpdateInteraction({
		action = self.actionData.userAction,
		slot = self
	})
	self.owner:UpdateInteraction({
		action = self.actionData.ownerAction,
		slot = self
	})

	return
end

function CourtYardRandomControllerSlot:OnContinue(arg_7_1)
	if arg_7_1 == self.owner then
		self:End()
	end

	return
end

function CourtYardRandomControllerSlot:Clear(arg_8_1)
	CourtYardRandomControllerSlot.super.Clear(self, arg_8_1)

	self.actionData = nil

	return
end

return CourtYardRandomControllerSlot
