local CourtYardInteraction = class("CourtYardInteraction")

function CourtYardInteraction:Ctor(arg_1_1)
	self.host = arg_1_1
	self.isReset = false

	self:Clear()

	return
end

function CourtYardInteraction:Update(arg_2_1)
	self.loop = arg_2_1

	self:InitData()
	self:DoPreheatStep(self.ownerPreheat, self.userPreheat)

	return
end

function CourtYardInteraction:InitData()
	local var_3_0, var_3_1, var_3_2, var_3_3, var_3_4, var_3_5, var_3_6 = self.host:GetActions()

	self.ownerPreheat = var_3_3
	self.userPreheat = var_3_4
	self.tailAction = var_3_5
	self.ownerActions = var_3_0
	self.userActions = var_3_1
	self.closeBodyMask = var_3_2
	self.preheatOnlyHost = var_3_6
	self.total = #var_3_0
	self.index = 0

	return
end

function CourtYardInteraction:DoPreheatStep(arg_4_1, arg_4_2)
	self.preheatProcess = false

	if arg_4_1 then
		self.preheatProcess = true

		self.host:GetOwner():UpdateInteraction(self:PackData(arg_4_1, true))

		if arg_4_2 then
			self.host:GetUser():UpdateInteraction(self:PackData(arg_4_2, true))
		end
	else
		self:DoStep()
	end

	return
end

function CourtYardInteraction:DoStep()
	if self.index >= self.total then
		self:AllStepEnd()

		return
	end

	self.index = self.index + 1
	self.states[self.host.user] = false
	self.states[self.host.owner] = false

	self.host:GetUser():UpdateInteraction(self:PackData(self:GetUserAction()))
	self.host:GetOwner():UpdateInteraction(self:PackData(self:GetOwnerAction()))

	self.isReset = false

	return
end

function CourtYardInteraction:GetUserAction()
	return self.userActions[self.index]
end

function CourtYardInteraction:GetOwnerAction()
	return self.ownerActions[self.index]
end

function CourtYardInteraction:DoTailStep()
	self.index = 0

	self.host:GetUser():UpdateInteraction(self:PackData(self.tailAction))
	self.host:GetOwner():UpdateInteraction(self:PackData(self.tailAction))

	return
end

function CourtYardInteraction:PackData(arg_9_1, arg_9_2)
	return {
		action = arg_9_1,
		slot = self.host,
		closeBodyMask = self.closeBodyMask[self.index],
		progress = self.index / self.total,
		total = self.total,
		index = self.index,
		isReset = self.isReset,
		block = arg_9_2
	}
end

function CourtYardInteraction:StepEnd(arg_10_1)
	if self.preheatProcess then
		local function var_10_0()
			self:OnPreheatDone()
			self:DoStep()

			return
		end

		if self.preheatOnlyHost then
			if arg_10_1 == self.host.owner then
				var_10_0()
			end
		else
			var_10_0()
		end
	else
		if self.index == 0 then
			return
		end

		self.states[arg_10_1] = true

		self:OnStepEnd()
	end

	return
end

function CourtYardInteraction:OnPreheatDone()
	self.host:GetOwner():OnPreheatActionEnd(self.host)

	return
end

function CourtYardInteraction:AllStepEnd()
	if self.loop and self.total > 1 then
		self.isReset = true
		self.index = 0

		self:DoStep()
	elseif self.loop and self.total == 1 then
		-- block empty
	elseif not self.loop and self.tailAction then
		self:DoTailStep()
	else
		self.host:End()
		self:Clear()
	end

	return
end

function CourtYardInteraction:Clear()
	self.index = 0
	self.states = {}
	self.total = 0
	self.loop = nil

	return
end

function CourtYardInteraction:GetIndex()
	return self.index
end

function CourtYardInteraction:IsCompleteStep()
	return self:IsCompleteUserStep() and self:IsCompleteOwnerStep()
end

function CourtYardInteraction:IsCompleteUserStep()
	return self.states[self.host.user] == true
end

function CourtYardInteraction:IsCompleteOwnerStep()
	return self.states[self.host.owner] == true
end

function CourtYardInteraction:OnStepEnd()
	if self:IsCompleteStep() then
		self:DoStep()
	end

	return
end

function CourtYardInteraction:Reset()
	return
end

return CourtYardInteraction
