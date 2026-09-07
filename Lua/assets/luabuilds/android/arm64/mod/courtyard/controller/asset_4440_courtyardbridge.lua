local CourtYardBridge = class("CourtYardBridge")

function CourtYardBridge:Ctor(arg_1_1)
	self.core = arg_1_1.core
	self.isSetup = false
	self.controller = self:System2Controller(arg_1_1.system, arg_1_1)
	self.view = CourtYardView.New(arg_1_1.name, self.controller:GetStorey())
	self.handle = self.handle or UpdateBeat:CreateListener(self.Update, self)

	UpdateBeat:AddListener(self.handle)

	return
end

function CourtYardBridge:SetUp()
	if self.controller then
		self.isSetup = true

		self.controller:SetUp()
	end

	return
end

function CourtYardBridge:Update()
	if not self.isSetup and self.view:IsInit() then
		self:SetUp()
	end

	if self.isSetup and self.controller then
		self.controller:Update()
	end

	return
end

function CourtYardBridge:IsLoaed()
	if not self.controller then
		return false
	end

	return self.controller:IsLoaed()
end

function CourtYardBridge:GetView()
	return self.view
end

function CourtYardBridge:GetController()
	return self.controller
end

function CourtYardBridge:Exit()
	if self.controller then
		self.controller:Dispose()

		self.controller = nil
	end

	if self.view then
		self.view:Dispose()

		self.view = nil
	end

	return
end

function CourtYardBridge:SendNotification(arg_8_1, arg_8_2)
	if self.core then
		self.core:sendNotification(arg_8_1, arg_8_2)
	end

	return
end

function CourtYardBridge:Dispose()
	if self.handle then
		UpdateBeat:RemoveListener(self.handle)
	end

	self:Exit()

	return
end

function CourtYardBridge:System2Controller(arg_10_1, arg_10_2)
	if arg_10_1 == CourtYardConst.SYSTEM_FEAST then
		return CourtYardFeastController.New(self, arg_10_2)
	else
		return CourtYardController.New(self, arg_10_2)
	end

	return
end

return CourtYardBridge
