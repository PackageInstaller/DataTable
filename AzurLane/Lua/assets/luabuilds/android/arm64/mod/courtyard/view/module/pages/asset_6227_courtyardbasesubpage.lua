class = var_0_10000

local var_0_0 = var_0_10000("CourtYardBaseSubPage")

var_0_0.STATES = {
	LOADED = 3,
	DESTROY = 5,
	LOADING = 2,
	INITED = 4,
	NONE = 1
}

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.contextData = arg_1_2
	arg_1_0.parent = arg_1_1
	arg_1_0._parentTf = arg_1_1._tf
	arg_1_0._go = nil
	arg_1_0._tf = nil
	arg_1_0._state = var_0_0.STATES.NONE
	arg_1_0._funcQueue = {}

	return
end

function var_0_0.Load(arg_2_0)
	if arg_2_0._state ~= var_0_0.STATES.NONE then
		return
	end

	arg_2_0._state = var_0_0.STATES.LOADING
	pg = var_1

	local var_2_0 = var_1.UIMgr.GetInstance()

	var_1.LoadingOn(var_2_0)

	PoolMgr = var_1

	local var_2_1 = var_1.GetInstance()

	var_1.GetUI(var_2_1, arg_2_0:getUIName(), true, function(arg_3_0)
		if arg_2_0._state == var_0_0.STATES.DESTROY then
			pg = var_1

			local var_3_0 = var_1.UIMgr.GetInstance()

			var_1.LoadingOff(var_3_0)

			local var_3_1 = var_0
			local var_3_2 = var_1.ReturnUI
			local var_3_3 = arg_2_0

			var_3_2(var_3_1, var_4.getUIName(var_3_3), arg_3_0)
		else
			local var_3_4 = arg_2_0

			var_1.Loaded(var_3_4, arg_3_0)

			local var_3_5 = arg_2_0

			var_1.Init(var_3_5)
		end

		return
	end)

	return
end

function var_0_0.Loaded(arg_4_0, arg_4_1)
	pg = var_1_10002

	local var_4_0 = var_1_10002.UIMgr.GetInstance()

	var_2.LoadingOff(var_4_0)

	if arg_4_0._state ~= var_0_0.STATES.LOADING then
		return
	end

	arg_4_0._state = var_0_0.STATES.LOADED
	arg_4_0._go = arg_4_1
	tf = var_2
	arg_4_0._tf = var_2(arg_4_1)
	pg = var_2

	var_2.DelegateInfo.New(arg_4_0)

	SetParent = var_2

	var_2(arg_4_0._tf, arg_4_0._parentTf, false)
	arg_4_0:OnLoaded()

	return
end

function var_0_0.Init(arg_5_0)
	if arg_5_0._state ~= var_0_0.STATES.LOADED then
		return
	end

	arg_5_0._state = var_0_0.STATES.INITED

	arg_5_0:OnInit()
	arg_5_0:HandleFuncQueue()

	return
end

function var_0_0.Destroy(arg_6_0)
	if arg_6_0._state == var_0_0.STATES.DESTROY then
		return
	end

	if not arg_6_0:GetLoaded() then
		arg_6_0._state = var_0_0.STATES.DESTROY

		return
	end

	arg_6_0._state = var_0_0.STATES.DESTROY
	pg = var_1

	var_1.DelegateInfo.Dispose(arg_6_0)
	arg_6_0:OnDestroy()

	arg_6_0._tf = nil
	PoolMgr = var_1

	local var_6_0 = var_1.GetInstance()
	local var_6_1 = arg_6_0:getUIName()

	if arg_6_0._go ~= nil and var_6_1 then
		var_6_0:ReturnUI(var_6_1, arg_6_0._go)

		arg_6_0._go = nil
	end

	return
end

function var_0_0.HandleFuncQueue(arg_7_0)
	if arg_7_0._state == var_0_0.STATES.INITED then
		while #arg_7_0._funcQueue > 0 do
			table = var_1

			local var_7_0 = var_1.remove(arg_7_0._funcQueue, 1).func

			unpack = var_4

			var_7_0(var_4(var_1.params, 1, var_1.params.len))
		end
	end

	return
end

function var_0_0.Reset(arg_8_0)
	arg_8_0._state = var_0_0.STATES.NONE

	return
end

function var_0_0.ActionInvoke(arg_9_0, arg_9_1, ...)
	assert = var_1_10002

	var_1_10002(arg_9_0[arg_9_1], "func not exist >>>" .. arg_9_1)

	local var_9_0 = arg_9_0._funcQueue
	local var_9_1 = #arg_9_0._funcQueue + 1
	local var_9_2 = {
		funcName = arg_9_1,
		func = arg_9_0[arg_9_1]
	}
	local var_9_3 = {}

	select = var_6
	var_9_3.len = 1 + var_6("#", ...)
	var_9_3[1] = arg_9_0
	var_9_3[2] = ...
	var_9_2.params = var_9_3
	var_9_0[var_9_1] = var_9_2

	arg_9_0:HandleFuncQueue()

	return
end

function var_0_0.CallbackInvoke(arg_10_0, arg_10_1, ...)
	local var_10_0 = arg_10_0._funcQueue
	local var_10_1 = #arg_10_0._funcQueue + 1
	local var_10_2 = {
		func = arg_10_1
	}

	packEx = var_1_10005
	var_10_2.params = var_1_10005(...)
	var_10_0[var_10_1] = var_10_2

	arg_10_0:HandleFuncQueue()

	return
end

function var_0_0.ExecuteAction(arg_11_0, arg_11_1, ...)
	arg_11_0:Load()
	arg_11_0:ActionInvoke(arg_11_1, ...)

	return
end

function var_0_0.GetLoaded(arg_12_0)
	return arg_12_0._state >= var_0_0.STATES.LOADED
end

function var_0_0.CheckState(arg_13_0, arg_13_1)
	return arg_13_0._state == arg_13_1
end

function var_0_0.Show(arg_14_0)
	setActive = var_1_10001

	var_1_10001(arg_14_0._tf, true)

	return
end

function var_0_0.Hide(arg_15_0)
	setActive = var_1_10001

	var_1_10001(arg_15_0._tf, false)

	return
end

function var_0_0.isShowing(arg_16_0)
	local var_16_0

	if arg_16_0._tf then
		isActive = var_16_0
		var_16_0 = var_16_0(arg_16_0._tf)
	end

	return var_16_0
end

function var_0_0.Emit(arg_17_0, arg_17_1, ...)
	local var_17_0 = arg_17_0.parent

	var_2.Emit(var_17_0, arg_17_1, ...)

	return
end

function var_0_0.getTpl(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_2:Find(arg_18_1)

	var_3.SetParent(var_18_0, arg_18_0._tf, false)

	SetActive = var_4

	var_4(var_3, false)

	return var_3
end

function var_0_0.getUIName(arg_19_0)
	return nil
end

function var_0_0.OnLoaded(arg_20_0)
	return
end

function var_0_0.OnInit(arg_21_0)
	return
end

function var_0_0.OnDestroy(arg_22_0)
	return
end

return var_0_0
