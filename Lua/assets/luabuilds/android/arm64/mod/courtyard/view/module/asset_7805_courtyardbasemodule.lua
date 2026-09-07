local CourtYardBaseModule = class("CourtYardBaseModule")
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2

function CourtYardBaseModule:Ctor(arg_1_1, arg_1_2)
	self.state = var_0_1

	pg.DelegateInfo.New(self)

	self._go = arg_1_2
	self._tf = arg_1_2.transform
	self.data = arg_1_1
	self.callbacks = {}

	self:Init()

	return
end

function CourtYardBaseModule:Init()
	if self.state == var_0_1 then
		self.state = var_0_2

		self:OnInit()
		self:AddListeners()
	end

	return
end

function CourtYardBaseModule:IsInit()
	return self.state == var_0_2
end

function CourtYardBaseModule:AddListener(arg_4_1, arg_4_2)
	local function var_4_0(arg_5_0, arg_5_1, ...)
		arg_4_2(self, ...)

		return
	end

	self.callbacks[arg_4_2] = var_4_0

	self.data:AddListener(arg_4_1, var_4_0)

	return
end

function CourtYardBaseModule:RemoveListener(arg_6_1, arg_6_2)
	if self.callbacks[arg_6_2] then
		self.data:RemoveListener(arg_6_1, self.callbacks[arg_6_2])

		self.callbacks[self.callbacks[arg_6_2]] = nil
	end

	return
end

function CourtYardBaseModule:GetController()
	return self.data:GetHost()
end

function CourtYardBaseModule:GetView()
	return self:GetController():GetBridge():GetView()
end

function CourtYardBaseModule:Emit(arg_9_1, ...)
	self:GetController():Receive(arg_9_1, ...)

	return
end

function CourtYardBaseModule:Dispose()
	pg.DelegateInfo.Dispose(self)

	if self.state == var_0_2 then
		self:RemoveListeners()
		self:OnDispose()
	end

	self.state = var_0_3

	self:OnDestroy()

	self._go = nil
	self.callbacks = nil

	return
end

function CourtYardBaseModule:IsExit()
	return self.state == var_0_3 or IsNil(self._go) or IsNil(self._tf)
end

function CourtYardBaseModule:OnInit()
	return
end

function CourtYardBaseModule:AddListeners()
	return
end

function CourtYardBaseModule:RemoveListeners()
	return
end

function CourtYardBaseModule:OnDispose()
	return
end

function CourtYardBaseModule:OnDestroy()
	return
end

return CourtYardBaseModule
