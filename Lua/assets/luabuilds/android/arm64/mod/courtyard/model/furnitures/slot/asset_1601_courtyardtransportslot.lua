local CourtYardTransportSlot = class("CourtYardTransportSlot", import(".CourtYardFurnitureBaseSlot"))

function CourtYardTransportSlot:OnInit(arg_1_1)
	self.name = arg_1_1[1][1]
	self.defaultAction = arg_1_1[1][2]
	self.actions = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1[2]) do
		table.insert(self.actions, {
			userAction = iter_1_1[1],
			ownerAction = iter_1_1[2],
			time = iter_1_1[3]
		})
	end

	self.animators = {}

	return
end

function CourtYardTransportSlot:SetAnimators(arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		table.insert(self.animators, {
			key = self.id .. "_" .. iter_2_0,
			value = iter_2_1
		})
	end

	return
end

function CourtYardTransportSlot:GetSpineDefaultAction()
	return self.defaultAction
end

function CourtYardTransportSlot:OnAwake()
	self.animatorIndex = self.index

	return
end

function CourtYardTransportSlot:OnStart()
	self.user:UpdateInteraction({
		action = self.actions[self.index].userAction,
		slot = self
	})
	self.owner:UpdateInteraction({
		action = self.actions[self.index].ownerAction,
		slot = self
	})
	Timer.New(function()
		self:End()

		return
	end, self.actions[self.index].time, 1):Start()

	return
end

function CourtYardTransportSlot:Occupy(arg_7_1, arg_7_2, arg_7_3)
	self.index = 1

	CourtYardTransportSlot.super.Occupy(self, arg_7_1, arg_7_2, arg_7_3)

	return
end

function CourtYardTransportSlot:Link(arg_8_1, arg_8_2, arg_8_3)
	self.index = 2

	CourtYardTransportSlot.super.Occupy(self, arg_8_1, arg_8_2, arg_8_3)

	return
end

function CourtYardTransportSlot:IsFirstTime()
	return self.index == 1
end

return CourtYardTransportSlot
