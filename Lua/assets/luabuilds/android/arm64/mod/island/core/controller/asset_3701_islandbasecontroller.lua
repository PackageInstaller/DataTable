local IslandBaseController = class("IslandBaseController")

function IslandBaseController:Ctor(arg_1_1, arg_1_2)
	self.core = arg_1_1
	self.island = arg_1_2
	self.__callbacks = {}

	self:Init()

	return
end

function IslandBaseController:GetIsland()
	return self.island
end

function IslandBaseController:GetSelfIsland()
	return (getProxy(IslandProxy):GetIsland())
end

function IslandBaseController:IsSelfIsland()
	return getProxy(IslandProxy):GetIsland().id == self.island.id
end

function IslandBaseController:GetCore()
	return self.core
end

function IslandBaseController:GetView()
	return self.core:GetView()
end

function IslandBaseController:OnCoreStateChanged(arg_7_1)
	if arg_7_1 == IslandCore.STATE_INIT_FINISH then
		self:AddListeners()
		self:OnCoreInitFinish()
	end

	return
end

function IslandBaseController:Dispose()
	self:RemoveListeners()
	self:OnDispose()

	return
end

function IslandBaseController:AddIslandListener(arg_9_1, arg_9_2)
	local function var_9_0(arg_10_0, ...)
		arg_9_2(self, ...)

		return
	end

	assert(self.__callbacks[arg_9_2] == nil, "This method has been monitored. Please use another one" .. arg_9_1)

	self.__callbacks[arg_9_2] = var_9_0

	self.island:AddListener(arg_9_1, var_9_0)

	return
end

function IslandBaseController:RemoveIslandListener(arg_11_1, arg_11_2)
	if self.__callbacks[arg_11_2] then
		self.island:RemoveListener(arg_11_1, self.__callbacks[arg_11_2])

		self.__callbacks[self.__callbacks[arg_11_2]] = nil
	end

	return
end

function IslandBaseController:NotifiyCore(arg_12_1, ...)
	self.core:DispatchEvent(arg_12_1, ...)

	return
end

function IslandBaseController:NotifiyIsland(arg_13_1, ...)
	self.island:DispatchEvent(arg_13_1, ...)

	return
end

function IslandBaseController:NotifiyMeditor(arg_14_1, ...)
	self:NotifiyIsland(ISLAND_EX_EVT.EMIT, arg_14_1, ...)

	return
end

function IslandBaseController:Receive(arg_15_1, ...)
	if self[arg_15_1] then
		self[arg_15_1](self, ...)
	end

	return
end

function IslandBaseController:AddListeners()
	return
end

function IslandBaseController:RemoveListeners()
	return
end

function IslandBaseController:Init()
	return
end

function IslandBaseController:SetUp()
	return
end

function IslandBaseController:OnCoreInitFinish()
	return
end

function IslandBaseController:Update()
	return
end

function IslandBaseController:LateUpdate()
	return
end

function IslandBaseController:OnDispose()
	return
end

return IslandBaseController
