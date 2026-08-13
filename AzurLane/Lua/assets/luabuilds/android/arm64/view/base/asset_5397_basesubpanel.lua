class = var_0_10000

local var_0_0 = "BaseSubPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

import = var_0_10001

local var_0_2 = var_0_10001("view.util.FuncBuffer")

import = var_0_0

local var_0_3 = var_0_0("view.util.AutoLoader")

function var_0_1.Ctor(arg_1_0, arg_1_1)
	assert = var_1_10002

	var_1_10002(arg_1_1, "NIL Parent View")

	local var_1_0 = arg_1_1 and arg_1_1._tf

	if arg_1_1 then
		isa = var_1_10003

		local var_1_1 = arg_1_1

		BaseEventLogic = var_1_10006

		local var_1_2

		if not var_1_10003(var_1_1, var_1_10006) or not arg_1_1.event then
			var_1_2 = nil
		end

		local var_1_3 = {}

		var_0_1.super.Ctor(arg_1_0, var_1_0, var_1_2, var_1_3)

		arg_1_0.buffer = var_0_2.New()
		arg_1_0.loader = var_0_3.New()
		arg_1_0.viewParent = arg_1_1

		return
	end
end

function var_0_1.Init(arg_2_0)
	if arg_2_0._state ~= var_0_1.STATES.LOADED then
		return
	end

	arg_2_0._state = var_0_1.STATES.INITED
	bindComponent = var_1

	var_1(arg_2_0, arg_2_0._go)
	arg_2_0:OnInit()
	arg_2_0:Show()
	arg_2_0:HandleFuncQueue()

	local var_2_0 = arg_2_0.buffer

	var_1.SetNotifier(var_2_0, arg_2_0)

	local var_2_1 = arg_2_0.buffer

	var_1.ExcuteAll(var_2_1)

	return
end

function var_0_1.Destroy(arg_3_0)
	if arg_3_0._state == var_0_1.STATES.DESTROY then
		return
	end

	if not arg_3_0:GetLoaded() then
		arg_3_0._state = var_0_1.STATES.DESTROY

		return
	end

	arg_3_0._state = var_0_1.STATES.DESTROY
	pg = var_1

	var_1.DelegateInfo.Dispose(arg_3_0)
	arg_3_0:Hide()
	arg_3_0:OnDestroy()

	local var_3_0 = arg_3_0.loader

	var_1.Clear(var_3_0)

	local var_3_1 = arg_3_0.buffer

	var_1.Clear(var_3_1)

	bindComponent = var_1

	var_1(arg_3_0, arg_3_0._go, true)
	arg_3_0:disposeEvent()
	arg_3_0:cleanManagedTween()

	arg_3_0._tf = nil
	PoolMgr = var_1

	local var_3_2 = var_1.GetInstance()
	local var_3_3 = arg_3_0:getUIName()

	if arg_3_0._go ~= nil and var_3_3 then
		var_3_2:ReturnUI(var_3_3, arg_3_0._go)

		arg_3_0._go = nil
	end

	return
end

function var_0_1.Hide(arg_4_0)
	arg_4_0:OnHide()
	var_0_1.super.Hide(arg_4_0)

	return
end

function var_0_1.RawHide(arg_5_0)
	var_0_1.super.Hide(arg_5_0)

	return
end

function var_0_1.Show(arg_6_0)
	var_0_1.super.Show(arg_6_0)
	arg_6_0:OnShow()

	return
end

function var_0_1.RawShow(arg_7_0)
	var_0_1.super.Show(arg_7_0)

	return
end

function var_0_1.IsShowing(arg_8_0)
	local var_8_0

	if arg_8_0:GetLoaded() then
		isActive = var_8_0
		var_8_0 = var_8_0(arg_8_0._go)
	end

	return var_8_0
end

function var_0_1.IsHiding(arg_9_0)
	local var_9_0

	if arg_9_0:GetLoaded() then
		isActive = var_9_0
		var_9_0 = not var_9_0(arg_9_0._go)
	end

	return var_9_0
end

function var_0_1.SetParent(arg_10_0, arg_10_1, ...)
	setParent = var_1_10002

	var_1_10002(arg_10_0._tf, arg_10_1, ...)

	return
end

function var_0_1.OnShow(arg_11_0)
	return
end

function var_0_1.OnHide(arg_12_0)
	return
end

return var_0_1
