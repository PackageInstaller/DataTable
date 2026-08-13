class = var_0_10000

local var_0_0 = var_0_10000("IslandBaseController")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.core = arg_1_1
	arg_1_0.island = arg_1_2
	arg_1_0.__callbacks = {}

	arg_1_0:Init()

	return
end

function var_0_0.GetIsland(arg_2_0)
	return arg_2_0.island
end

function var_0_0.GetSelfIsland(arg_3_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_3_0 = var_1_10001(var_1_10003)

	return (var_1.GetIsland(var_3_0))
end

function var_0_0.IsSelfIsland(arg_4_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_4_0 = var_1_10001(var_1_10003)

	return var_1.GetIsland(var_4_0).id == arg_4_0.island.id
end

function var_0_0.GetCore(arg_5_0)
	return arg_5_0.core
end

function var_0_0.GetView(arg_6_0)
	local var_6_0 = arg_6_0.core

	return var_1.GetView(var_6_0)
end

function var_0_0.OnCoreStateChanged(arg_7_0, arg_7_1)
	IslandCore = var_1_10002

	if arg_7_1 == var_1_10002.STATE_INIT_FINISH then
		arg_7_0:AddListeners()
		arg_7_0:OnCoreInitFinish()
	end

	return
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0:RemoveListeners()
	arg_8_0:OnDispose()

	return
end

function var_0_0.AddIslandListener(arg_9_0, arg_9_1, arg_9_2)
	local function var_9_0(arg_10_0, ...)
		arg_9_2(arg_9_0, ...)

		return
	end

	assert = var_1_10004

	var_1_10004(arg_9_0.__callbacks[arg_9_2] == nil, "This method has been monitored. Please use another one" .. arg_9_1)

	arg_9_0.__callbacks[arg_9_2] = var_9_0

	local var_9_1 = arg_9_0.island

	var_4.AddListener(var_9_1, arg_9_1, var_9_0)

	return
end

function var_0_0.RemoveIslandListener(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0.__callbacks[arg_11_2] then
		local var_11_0 = arg_11_0.island

		var_4.RemoveListener(var_11_0, arg_11_1, var_3)

		arg_11_0.__callbacks[var_3] = nil
	end

	return
end

function var_0_0.NotifiyCore(arg_12_0, arg_12_1, ...)
	local var_12_0 = arg_12_0.core

	var_2.DispatchEvent(var_12_0, arg_12_1, ...)

	return
end

function var_0_0.NotifiyIsland(arg_13_0, arg_13_1, ...)
	local var_13_0 = arg_13_0.island

	var_2.DispatchEvent(var_13_0, arg_13_1, ...)

	return
end

function var_0_0.NotifiyMeditor(arg_14_0, arg_14_1, ...)
	local var_14_0 = arg_14_0
	local var_14_1 = arg_14_0.NotifiyIsland

	ISLAND_EX_EVT = var_1_10005

	var_14_1(var_14_0, var_1_10005.EMIT, arg_14_1, ...)

	return
end

function var_0_0.Receive(arg_15_0, arg_15_1, ...)
	if arg_15_0[arg_15_1] then
		arg_15_0[arg_15_1](arg_15_0, ...)
	end

	return
end

function var_0_0.AddListeners(arg_16_0)
	return
end

function var_0_0.RemoveListeners(arg_17_0)
	return
end

function var_0_0.Init(arg_18_0)
	return
end

function var_0_0.SetUp(arg_19_0)
	return
end

function var_0_0.OnCoreInitFinish(arg_20_0)
	return
end

function var_0_0.Update(arg_21_0)
	return
end

function var_0_0.LateUpdate(arg_22_0)
	return
end

function var_0_0.OnDispose(arg_23_0)
	return
end

return var_0_0
