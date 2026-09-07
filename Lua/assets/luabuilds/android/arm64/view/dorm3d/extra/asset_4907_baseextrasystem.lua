local BaseExtraSystem = class("BaseExtraSystem")

function BaseExtraSystem:Ctor(arg_1_1, arg_1_2)
	self.event = arg_1_1
	self.scene = arg_1_2
	self.context = self:WrapContext(arg_1_2)
	self.bindings = {}
	self.isInitialized = false

	return
end

function BaseExtraSystem:WrapContext(arg_2_1)
	return {
		GetModelRoot = function()
			return arg_2_1:GetModelRoot()
		end,
		GetCurrentLadyEnv = function()
			return arg_2_1:GetCurrentLadyEnv()
		end,
		GetSceneItem = function(arg_5_0)
			return arg_2_1:GetSceneItem(arg_5_0)
		end,
		GetFurnitureByName = function(arg_6_0)
			return arg_2_1:GetFurnitureByName(arg_6_0)
		end,
		GetLoader = function()
			return arg_2_1.loader
		end,
		GetRoom = function()
			return arg_2_1.room
		end,
		_raw = arg_2_1
	}
end

function BaseExtraSystem:Init()
	if self.isInitialized then
		warning(self.__cname .. " already initialized")

		return
	end

	self.isInitialized = true

	self:OnInit()
	self:RegisterEvents()

	return
end

function BaseExtraSystem:OnInit()
	return
end

function BaseExtraSystem:RegisterEvents()
	return
end

function BaseExtraSystem:Emit(arg_12_1, ...)
	self.event:emit(arg_12_1, ...)

	return
end

function BaseExtraSystem:Bind(arg_13_1, arg_13_2)
	self.bindings[arg_13_1] = self.bindings[arg_13_1] or {}

	table.insert(self.bindings[arg_13_1], arg_13_2)
	self.event:connect(arg_13_1, arg_13_2)

	return
end

function BaseExtraSystem:Unbind(arg_14_1)
	if not self.bindings[arg_14_1] then
		return
	end

	for iter_14_0, iter_14_1 in ipairs(self.bindings[arg_14_1]) do
		self.event:disconnect(arg_14_1, iter_14_1)
	end

	self.bindings[arg_14_1] = nil

	return
end

function BaseExtraSystem:UnbindAll()
	for iter_15_0, iter_15_1 in pairs(self.bindings) do
		self:Unbind(iter_15_0)
	end

	self.bindings = {}

	return
end

function BaseExtraSystem:Update(arg_16_1)
	if not self.isInitialized then
		return
	end

	self:OnUpdate(arg_16_1)

	return
end

function BaseExtraSystem:OnUpdate(arg_17_1)
	return
end

function BaseExtraSystem:LateUpdate(arg_18_1)
	if not self.isInitialized then
		return
	end

	self:OnLateUpdate(arg_18_1)

	return
end

function BaseExtraSystem:OnLateUpdate(arg_19_1)
	return
end

function BaseExtraSystem:HandleNotification(arg_20_1, arg_20_2)
	if not self.isInitialized then
		return
	end

	self:OnHandleNotification(arg_20_1, arg_20_2)

	return
end

function BaseExtraSystem:OnHandleNotification(arg_21_1, arg_21_2)
	return
end

function BaseExtraSystem.GetInterests()
	return {}
end

function BaseExtraSystem:Func(arg_23_1, ...)
	if not self.isInitialized then
		return nil
	end

	local var_23_0 = self.scene

	if not self.scene then
		warning("Scene is nil")

		return nil
	end

	local var_23_1 = var_23_0[arg_23_1]

	if not var_23_0[arg_23_1] then
		warning("Method " .. arg_23_1 .. " not found in scene")

		return nil
	end

	return var_23_1(var_23_0, ...)
end

function BaseExtraSystem:Get(arg_24_1)
	if not self.isInitialized then
		return nil
	end

	return self.scene[arg_24_1]
end

function BaseExtraSystem:GetModelRoot()
	return self.context.GetModelRoot()
end

function BaseExtraSystem:GetCurrentLadyEnv()
	return self.context.GetCurrentLadyEnv()
end

function BaseExtraSystem:GetSceneItem(arg_27_1)
	return self.context.GetSceneItem(arg_27_1)
end

function BaseExtraSystem:GetFurnitureByName(arg_28_1)
	return self.context.GetFurnitureByName(arg_28_1)
end

function BaseExtraSystem:GetLoader()
	return self.context.GetLoader()
end

function BaseExtraSystem:GetRoom()
	return self.context.GetRoom()
end

function BaseExtraSystem.IsOpen()
	return true
end

function BaseExtraSystem:GetName()
	return self.__cname or "BaseExtraSystem"
end

function BaseExtraSystem:Dispose()
	self:OnDispose()
	self:UnbindAll()

	self.event = nil
	self.context = nil
	self.scene = nil
	self.isInitialized = false

	return
end

function BaseExtraSystem:OnDispose()
	return
end

return BaseExtraSystem
