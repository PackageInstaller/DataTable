class = var_0_10000

local var_0_0 = "BaseSubView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseEventLogic"))

var_0_1.STATES = {
	LOADED = 3,
	DESTROY = 5,
	LOADING = 2,
	INITED = 4,
	NONE = 1
}

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_1.super.Ctor(arg_1_0, arg_1_2)

	arg_1_0.contextData = arg_1_3
	arg_1_0._parentTf = arg_1_1
	arg_1_0.event = arg_1_2
	arg_1_0._go = nil
	arg_1_0._tf = nil
	arg_1_0._state = var_0_1.STATES.NONE
	arg_1_0._funcQueue = {}

	return
end

var_0_1.InheritFuncs = {
	"getGroupName",
	"Add2Overlay",
	"DelFromOverlay",
	"OverlayPanel",
	"UnOverlayPanel",
	"BlurPanel",
	"TempOverlayPanelPB",
	"TempUnOverlayPanelPB"
}

function var_0_1.RegisterView(arg_2_0, arg_2_1)
	arg_2_0.viewComponent = arg_2_1
	ipairs = var_1_10002

	for iter_2_0, iter_2_1 in var_1_10002(var_0_1.InheritFuncs) do
		local var_2_0

		if not arg_2_0[iter_2_1] then
			function var_2_0(arg_3_0, ...)
				return arg_3_0.viewComponent[iter_2_1](arg_3_0.viewComponent, ...)
			end
		end

		arg_2_0[iter_2_1] = var_2_0
	end

	return
end

function var_0_1.Load(arg_4_0, arg_4_1)
	if arg_4_0._state ~= var_0_1.STATES.NONE then
		return
	end

	arg_4_0._state = var_0_1.STATES.LOADING
	pg = var_2

	local var_4_0 = var_2.UIMgr.GetInstance()

	var_2.LoadingOn(var_4_0)

	PoolMgr = var_2

	local var_4_1 = var_2.GetInstance()

	seriesAsync = var_3

	var_3({
		function(arg_5_0)
			if arg_4_1 then
				arg_4_0.noReturnPrefab = true

				arg_5_0(arg_4_1)
			else
				local var_5_0 = var_4_1
				local var_5_1 = var_1.GetUI
				local var_5_2 = arg_4_0

				var_5_1(var_5_0, var_4.getUIName(var_5_2), true, arg_5_0)
			end

			return
		end
	}, function(arg_6_0)
		if arg_4_0._state == var_0_1.STATES.DESTROY and not arg_4_0.noReturnPrefab then
			pg = var_1

			local var_6_0 = var_1.UIMgr.GetInstance()

			var_1.LoadingOff(var_6_0)

			local var_6_1 = var_4_1
			local var_6_2 = var_1.ReturnUI
			local var_6_3 = arg_4_0

			var_6_2(var_6_1, var_4.getUIName(var_6_3), arg_6_0)
		else
			local var_6_4 = arg_4_0

			var_1.Loaded(var_6_4, arg_6_0)

			local var_6_5 = arg_4_0

			var_1.Init(var_6_5)
		end

		return
	end)

	return
end

function var_0_1.Loaded(arg_7_0, arg_7_1)
	pg = var_1_10002

	local var_7_0 = var_1_10002.UIMgr.GetInstance()

	var_2.LoadingOff(var_7_0)

	if arg_7_0._state ~= var_0_1.STATES.LOADING then
		return
	end

	arg_7_0._state = var_0_1.STATES.LOADED
	arg_7_0._go = arg_7_1
	tf = var_2
	arg_7_0._tf = var_2(arg_7_1)
	setActiveViaLayer = var_2

	var_2(arg_7_0._tf, true)

	pg = var_2

	var_2.DelegateInfo.New(arg_7_0)

	if arg_7_0._tf.parent ~= arg_7_0._parentTf then
		SetParent = var_2

		var_2(arg_7_0._tf, arg_7_0._parentTf, false)
	end

	bindComponent = var_2

	var_2(arg_7_0, arg_7_0._go)
	arg_7_0:OnLoaded()

	return
end

function var_0_1.Init(arg_8_0)
	if arg_8_0._state ~= var_0_1.STATES.LOADED then
		return
	end

	arg_8_0._state = var_0_1.STATES.INITED

	arg_8_0:OnInit()
	arg_8_0:HandleFuncQueue()

	return
end

function var_0_1.Destroy(arg_9_0)
	if arg_9_0._state == var_0_1.STATES.DESTROY then
		return
	end

	if not arg_9_0:GetLoaded() then
		arg_9_0._state = var_0_1.STATES.DESTROY

		return
	end

	arg_9_0._state = var_0_1.STATES.DESTROY
	pg = var_1

	var_1.DelegateInfo.Dispose(arg_9_0)
	arg_9_0:OnDestroy()

	bindComponent = var_1

	var_1(arg_9_0, arg_9_0._go, true)
	arg_9_0:disposeEvent()
	arg_9_0:cleanManagedTween()

	arg_9_0._tf = nil

	if arg_9_0._go ~= nil and not arg_9_0.noReturnPrefab then
		PoolMgr = var_1

		local var_9_0 = var_1.GetInstance()

		var_1.ReturnUI(var_9_0, arg_9_0:getUIName(), arg_9_0._go)

		arg_9_0._go = nil
	end

	arg_9_0.noReturnPrefab = nil

	return
end

function var_0_1.HandleFuncQueue(arg_10_0)
	if arg_10_0._state == var_0_1.STATES.INITED then
		while #arg_10_0._funcQueue > 0 do
			table = var_1

			local var_10_0 = var_1.remove(arg_10_0._funcQueue, 1).func

			unpackEx = var_4

			var_10_0(var_4(var_1.params))
		end
	end

	return
end

function var_0_1.Reset(arg_11_0)
	arg_11_0._state = var_0_1.STATES.NONE

	return
end

function var_0_1.ActionInvoke(arg_12_0, arg_12_1, ...)
	assert = var_1_10002

	var_1_10002(arg_12_0[arg_12_1], "func not exist >>>" .. arg_12_1)

	local var_12_0 = arg_12_0._funcQueue
	local var_12_1 = #arg_12_0._funcQueue + 1
	local var_12_2 = {
		funcName = arg_12_1,
		func = arg_12_0[arg_12_1]
	}

	packEx = var_5
	var_12_2.params = var_5(arg_12_0, ...)
	var_12_0[var_12_1] = var_12_2

	arg_12_0:HandleFuncQueue()

	return
end

function var_0_1.ActionInvokeExclusive(arg_13_0, arg_13_1, ...)
	local var_13_0 = #arg_13_0._funcQueue

	while var_13_0 > 0 do
		if arg_13_0._funcQueue[var_13_0].funcName == arg_13_1 then
			table = var_4

			var_4.remove(arg_13_0._funcQueue, var_13_0)
		end

		var_13_0 = var_13_0 - 1
	end

	arg_13_0:ActionInvoke(arg_13_1, ...)

	return
end

function var_0_1.CallbackInvoke(arg_14_0, arg_14_1, ...)
	local var_14_0 = arg_14_0._funcQueue
	local var_14_1 = #arg_14_0._funcQueue + 1
	local var_14_2 = {
		func = arg_14_1
	}

	packEx = var_1_10005
	var_14_2.params = var_1_10005(...)
	var_14_0[var_14_1] = var_14_2

	arg_14_0:HandleFuncQueue()

	return
end

function var_0_1.ExecuteAction(arg_15_0, arg_15_1, ...)
	arg_15_0:Load()
	arg_15_0:ActionInvoke(arg_15_1, ...)

	return
end

function var_0_1.GetLoaded(arg_16_0)
	return arg_16_0._state >= var_0_1.STATES.LOADED
end

function var_0_1.CheckState(arg_17_0, arg_17_1)
	return arg_17_0._state == arg_17_1
end

function var_0_1.Show(arg_18_0)
	setActive = var_1_10001

	var_1_10001(arg_18_0._tf, true)
	arg_18_0:ShowOrHideResUI(true)
	arg_18_0:PlayBGM()

	return
end

function var_0_1.Hide(arg_19_0)
	setActive = var_1_10001

	var_1_10001(arg_19_0._tf, false)
	arg_19_0:ShowOrHideResUI(false)
	arg_19_0:StopBgm()

	return
end

function var_0_1.isShowing(arg_20_0)
	if arg_20_0._tf then
		isActive = var_1

		local var_20_0

		if not var_1(arg_20_0._tf) then
			var_20_0 = false
		end

		return var_20_0
	end
end

function var_0_1.getBGM(arg_21_0, arg_21_1)
	getBgm = var_1_10002

	return var_1_10002(arg_21_1 or arg_21_0.__cname)
end

function var_0_1.PlayBGM(arg_22_0)
	if arg_22_0:getBGM() then
		pg = var_1_10002

		local var_22_0 = var_1_10002.BgmMgr.GetInstance()

		var_2.Push(var_22_0, arg_22_0.__cname, var_1)
	end

	return
end

function var_0_1.StopBgm(arg_23_0)
	pg = var_1_10001

	local var_23_0 = var_1_10001.BgmMgr.GetInstance()

	var_1.Pop(var_23_0, arg_23_0.__cname)

	return
end

function var_0_1.getTpl(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_2 or arg_24_0._tf
	local var_24_1 = var_3.Find(var_24_0, arg_24_1)

	var_3.SetParent(var_24_1, arg_24_0._tf, false)

	SetActive = var_4

	var_4(var_3, false)

	return var_3
end

function var_0_1.getUIName(arg_25_0)
	return nil
end

function var_0_1.OnLoaded(arg_26_0)
	return
end

function var_0_1.OnInit(arg_27_0)
	return
end

function var_0_1.OnDestroy(arg_28_0)
	return
end

function var_0_1.ResUISettings(arg_29_0)
	return nil
end

function var_0_1.ShowOrHideResUI(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0

	if not arg_30_0.ResUISettings(var_30_0) then
		return
	end

	local var_30_2

	if var_30_2 == true then
		local var_30_1 = {
			anim = true
		}

		PlayerResUI = var_30_0
		var_30_1.showType = var_30_0.TYPE_ALL
		var_30_2 = var_30_1
	end

	local var_30_3 = arg_30_0:getGroupName()

	if arg_30_1 then
		pg = var_30_0

		local var_30_4 = var_30_0.playerResUI

		var_30_0 = var_30_0.SetSettings

		local var_30_5 = var_30_3

		setmetatable = var_1_10008

		var_30_0(var_30_4, var_30_5, var_1_10008({
			groupName = var_30_3
		}, {
			__index = var_30_2
		}))
	else
		pg = var_30_0

		local var_30_6 = var_30_0.playerResUI

		var_4.RemoveSettings(var_30_6, var_30_3)
	end

	return
end

function var_0_1.getGroupName(arg_31_0)
	local var_31_0

	if not arg_31_0.contextData.groupName then
		var_31_0 = arg_31_0.__cname
	end

	return var_31_0
end

return var_0_1
