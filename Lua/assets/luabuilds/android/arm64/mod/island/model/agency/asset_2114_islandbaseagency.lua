local IslandBaseAgency = class("IslandBaseAgency")

function IslandBaseAgency:Ctor(arg_1_1, arg_1_2)
	self.host = arg_1_1

	self:Init(arg_1_2)
	self:Register()

	self.isInit = false

	return
end

function IslandBaseAgency:GetHost()
	return self.host
end

function IslandBaseAgency:DispatchEvent(arg_3_1, ...)
	self:GetHost():DispatchEvent(arg_3_1, ...)

	return
end

function IslandBaseAgency:On(arg_4_1, arg_4_2)
	self:GetHost():On(arg_4_1, arg_4_2)

	return
end

function IslandBaseAgency:Init(arg_5_1)
	self.isInit = true

	self:OnInit(arg_5_1)

	return
end

function IslandBaseAgency:IsInitData()
	return self.isInit
end

function IslandBaseAgency:SetDirty()
	self.isInit = false

	return
end

function IslandBaseAgency:Register()
	return
end

function IslandBaseAgency:OnInit(arg_9_1)
	return
end

function IslandBaseAgency:UpdatePerDay()
	return
end

function IslandBaseAgency:UpdatePerDay()
	return
end

function IslandBaseAgency:UpdatePerSecond()
	return
end

return IslandBaseAgency
