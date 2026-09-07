local CourtYardMonglineInteraction = class("CourtYardMonglineInteraction", import(".CourtYardInteraction"))

function CourtYardMonglineInteraction:DoStep()
	self.statesCnt[self.host.user] = 1
	self.statesCnt[self.host.owner] = 1
	self.totalUserActionCnt = #self.userActions
	self.totalOwnerActionCnt = #self.ownerActions

	CourtYardMonglineInteraction.super.DoStep(self)

	return
end

function CourtYardMonglineInteraction:PlayUserAction()
	if self.statesCnt[self.host.user] + 1 > self.totalUserActionCnt then
		return
	end

	self.statesCnt[self.host.user] = self.statesCnt[self.host.user] + 1
	self.states[self.host.user] = false

	print("ship..............", self.statesCnt[self.host.user] + 1, self.userActions[self.statesCnt[self.host.user] + 1])
	self.host:GetUser():UpdateInteraction(self:PackData(self.userActions[self.statesCnt[self.host.user] + 1]))

	return
end

function CourtYardMonglineInteraction:PlayOwnerAction()
	if self.statesCnt[self.host.owner] + 1 > self.totalOwnerActionCnt then
		return
	end

	self.statesCnt[self.host.owner] = self.statesCnt[self.host.owner] + 1
	self.states[self.host.owner] = false

	print("furn", self.statesCnt[self.host.owner] + 1, self.ownerActions[self.statesCnt[self.host.owner] + 1])
	self.host:GetOwner():UpdateInteraction(self:PackData(self.ownerActions[self.statesCnt[self.host.owner] + 1]))

	return
end

function CourtYardMonglineInteraction:StepEnd(arg_4_1)
	if self.preheatProcess then
		self:DoStep()

		self.preheatProcess = false
	else
		if self.index == 0 then
			return
		end

		self.states[arg_4_1] = true

		if self.host:GetUser() == arg_4_1 then
			self:PlayUserAction()
		elseif self.host:GetOwner() == arg_4_1 then
			self:PlayOwnerAction()
		end

		if self:IsFinishAll() then
			self:AllStepEnd()
		end
	end

	return
end

function CourtYardMonglineInteraction:IsFinishAll()
	return self.statesCnt[self.host.owner] >= self.totalOwnerActionCnt and self.statesCnt[self.host.user] >= self.totalUserActionCnt
end

function CourtYardMonglineInteraction:Clear()
	CourtYardMonglineInteraction.super.Clear(self)

	self.statesCnt = {}

	return
end

return CourtYardMonglineInteraction
