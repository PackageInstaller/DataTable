local var_0_0 = class("BaseExtraSystem")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.event = arg_1_1
	arg_1_0.scene = arg_1_2
	arg_1_0.context = arg_1_0:WrapContext(arg_1_2)
	arg_1_0.bindings = {}
	arg_1_0.isInitialized = false

	return
end

function var_0_0.WrapContext(arg_2_0, arg_2_1)
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

function var_0_0.Init(arg_9_0)
	if arg_9_0.isInitialized then
		warning(arg_9_0.__cname .. " already initialized")

		return
	end

	arg_9_0.isInitialized = true

	arg_9_0:OnInit()
	arg_9_0:RegisterEvents()

	return
end

function var_0_0.OnInit(arg_10_0)
	return
end

function var_0_0.RegisterEvents(arg_11_0)
	return
end

function var_0_0.Emit(arg_12_0, arg_12_1, ...)
	arg_12_0.event:emit(arg_12_1, ...)

	return
end

function var_0_0.Bind(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0.bindings[arg_13_1] = arg_13_0.bindings[arg_13_1] or {}

	table.insert(arg_13_0.bindings[arg_13_1], arg_13_2)
	arg_13_0.event:connect(arg_13_1, arg_13_2)

	return
end

function var_0_0.Unbind(arg_14_0, arg_14_1)
	if not arg_14_0.bindings[arg_14_1] then
		return
	end

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.bindings[arg_14_1]) do
		arg_14_0.event:disconnect(arg_14_1, iter_14_1)
	end

	arg_14_0.bindings[arg_14_1] = nil

	return
end

function var_0_0.UnbindAll(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(arg_15_0.bindings) do
		arg_15_0:Unbind(iter_15_0)
	end

	arg_15_0.bindings = {}

	return
end

function var_0_0.Update(arg_16_0, arg_16_1)
	if not arg_16_0.isInitialized then
		return
	end

	arg_16_0:OnUpdate(arg_16_1)

	return
end

function var_0_0.OnUpdate(arg_17_0, arg_17_1)
	return
end

function var_0_0.LateUpdate(arg_18_0, arg_18_1)
	if not arg_18_0.isInitialized then
		return
	end

	arg_18_0:OnLateUpdate(arg_18_1)

	return
end

function var_0_0.OnLateUpdate(arg_19_0, arg_19_1)
	return
end

function var_0_0.HandleNotification(arg_20_0, arg_20_1, arg_20_2)
	if not arg_20_0.isInitialized then
		return
	end

	arg_20_0:OnHandleNotification(arg_20_1, arg_20_2)

	return
end

function var_0_0.OnHandleNotification(arg_21_0, arg_21_1, arg_21_2)
	return
end

function var_0_0.GetInterests()
	return {}
end

function var_0_0.Func(arg_23_0, arg_23_1, ...)
	if not arg_23_0.isInitialized then
		return nil
	end

	local var_23_0 = arg_23_0.scene

	if not arg_23_0.scene then
		warning("Scene is nil")

		return nil
	end

	if not var_23_0[arg_23_1] then
		warning("Method " .. arg_23_1 .. " not found in scene")

		return nil
	end

	return var_23_1(var_23_0, ...)
end

function var_0_0.Get(arg_24_0, arg_24_1)
	if not arg_24_0.isInitialized then
		return nil
	end

	return arg_24_0.scene[arg_24_1]
end

function var_0_0.GetModelRoot(arg_25_0)
	return arg_25_0.context.GetModelRoot()
end

function var_0_0.GetCurrentLadyEnv(arg_26_0)
	return arg_26_0.context.GetCurrentLadyEnv()
end

function var_0_0.GetSceneItem(arg_27_0, arg_27_1)
	return arg_27_0.context.GetSceneItem(arg_27_1)
end

function var_0_0.GetFurnitureByName(arg_28_0, arg_28_1)
	return arg_28_0.context.GetFurnitureByName(arg_28_1)
end

function var_0_0.GetLoader(arg_29_0)
	return arg_29_0.context.GetLoader()
end

function var_0_0.GetRoom(arg_30_0)
	return arg_30_0.context.GetRoom()
end

function var_0_0.IsOpen()
	return true
end

function var_0_0.GetName(arg_32_0)
	return arg_32_0.__cname or "BaseExtraSystem"
end

function var_0_0.Dispose(arg_33_0)
	arg_33_0:OnDispose()
	arg_33_0:UnbindAll()

	arg_33_0.event = nil
	arg_33_0.context = nil
	arg_33_0.scene = nil
	arg_33_0.isInitialized = false

	return
end

function var_0_0.OnDispose(arg_34_0)
	return
end

return var_0_0
