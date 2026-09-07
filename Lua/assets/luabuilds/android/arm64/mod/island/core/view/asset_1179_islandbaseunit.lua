local IslandBaseUnit = class("IslandBaseUnit")
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3

function IslandBaseUnit:Ctor(arg_1_1)
	pg.DelegateInfo.New(self)

	self.__state = var_0_1
	self.view = arg_1_1

	return
end

function IslandBaseUnit:IsSelfIsland()
	return self.view:IsSelfIsland()
end

function IslandBaseUnit:NotifiyCore(arg_3_1, ...)
	self.view:NotifiyCore(arg_3_1, ...)

	return
end

function IslandBaseUnit:Op(...)
	self:GetView():Op(...)

	return
end

function IslandBaseUnit:NotifiyIsland(...)
	self:GetView():NotifiyIsland(...)

	return
end

function IslandBaseUnit:NotifiyMeditor(arg_6_1, ...)
	self:GetView():NotifiyMeditor(arg_6_1, ...)

	return
end

function IslandBaseUnit:Init(...)
	if self:IsEmpty() then
		self:OnInit(...)

		self.__state = var_0_2
	else
		self:OnAnomalyInit(...)
	end

	return
end

function IslandBaseUnit:IsEmpty()
	return self.__state == var_0_1
end

function IslandBaseUnit:IsLoaded()
	return self.__state == var_0_2
end

function IslandBaseUnit:GetView()
	return self.view
end

function IslandBaseUnit:GetPoolMgr()
	return self.view:GetPoolMgr()
end

function IslandBaseUnit:GetIsland()
	return self.view:GetIsland()
end

function IslandBaseUnit:GetSelfIsland()
	return self.view:GetSelfIsland()
end

function IslandBaseUnit:Reset()
	if self:IsLoaded() then
		self:OnDispose()
	end

	self:OnDestroy()

	self.__state = var_0_1

	return
end

function IslandBaseUnit:Dispose()
	if self.__state == var_0_3 then
		return
	end

	pg.DelegateInfo.Dispose(self)

	if self:IsLoaded() then
		self:OnDispose()
	end

	self.__state = var_0_3

	self:OnDestroy()

	self.view = nil

	return
end

function IslandBaseUnit:Update()
	if not self:IsLoaded() then
		return
	end

	self:OnUpdate()

	return
end

function IslandBaseUnit:LateUpdate()
	if not self:IsLoaded() then
		return
	end

	self:OnLateUpdate()

	return
end

function IslandBaseUnit:OnInit(...)
	return
end

function IslandBaseUnit:OnAnomalyInit(...)
	return
end

function IslandBaseUnit:Start()
	return
end

function IslandBaseUnit:OnUpdate()
	return
end

function IslandBaseUnit:OnLateUpdate()
	return
end

function IslandBaseUnit:OnDispose()
	return
end

function IslandBaseUnit:OnDestroy()
	return
end

return IslandBaseUnit
