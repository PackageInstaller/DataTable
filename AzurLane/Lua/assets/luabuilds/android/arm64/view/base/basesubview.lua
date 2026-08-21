local var_0_0 = class("BaseSubView", import("view.base.BaseEventLogic"))

var_0_0.STATES = {
	LOADED = 3,
	DESTROY = 5,
	LOADING = 2,
	INITED = 4,
	NONE = 1
}

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.Ctor(arg_1_0, arg_1_2)

	arg_1_0.contextData = arg_1_3
	arg_1_0._parentTf = arg_1_1
	arg_1_0.event = arg_1_2
	arg_1_0._go = nil
	arg_1_0._tf = nil
	arg_1_0._state = var_0_0.STATES.NONE
	arg_1_0._funcQueue = {}

	return
end

var_0_0.InheritFuncs = {
	"getGroupName",
	"Add2Overlay",
	"DelFromOverlay",
	"OverlayPanel",
	"UnOverlayPanel",
	"BlurPanel",
	"TempOverlayPanelPB",
	"TempUnOverlayPanelPB"
}

function var_0_0.RegisterView(arg_2_0, arg_2_1)
	arg_2_0.viewComponent = arg_2_1

	for iter_2_0, iter_2_1 in ipairs(var_0_0.InheritFuncs) do
		arg_2_0[iter_2_1] = arg_2_0[iter_2_1] or function(arg_3_0, ...)
			return arg_3_0.viewComponent[iter_2_1](arg_3_0.viewComponent, ...)
		end
	end

	return
end

function var_0_0.Load(arg_4_0, arg_4_1)
	if arg_4_0._state ~= var_0_0.STATES.NONE then
		return
	end

	arg_4_0._state = var_0_0.STATES.LOADING

	pg.UIMgr.GetInstance():LoadingOn()

	local var_4_0 = PoolMgr.GetInstance()

	seriesAsync({
		function(arg_5_0)
			if arg_4_1 then
				arg_4_0.noReturnPrefab = true

				arg_5_0(arg_4_1)
			else
				var_4_0:GetUI(arg_4_0:getUIName(), true, arg_5_0)
			end

			return
		end
	}, function(arg_6_0)
		if arg_4_0._state == var_0_0.STATES.DESTROY and not arg_4_0.noReturnPrefab then
			pg.UIMgr.GetInstance():LoadingOff()
			var_4_0:ReturnUI(arg_4_0:getUIName(), arg_6_0)
		else
			arg_4_0:Loaded(arg_6_0)
			arg_4_0:Init()
		end

		return
	end)

	return
end

function var_0_0.Loaded(arg_7_0, arg_7_1)
	pg.UIMgr.GetInstance():LoadingOff()

	if arg_7_0._state ~= var_0_0.STATES.LOADING then
		return
	end

	arg_7_0._state = var_0_0.STATES.LOADED
	arg_7_0._go = arg_7_1
	arg_7_0._tf = tf(arg_7_1)

	setActiveViaLayer(arg_7_0._tf, true)
	pg.DelegateInfo.New(arg_7_0)

	if arg_7_0._tf.parent ~= arg_7_0._parentTf then
		SetParent(arg_7_0._tf, arg_7_0._parentTf, false)
	end

	bindComponent(arg_7_0, arg_7_0._go)
	arg_7_0:OnLoaded()

	return
end

function var_0_0.Init(arg_8_0)
	if arg_8_0._state ~= var_0_0.STATES.LOADED then
		return
	end

	arg_8_0._state = var_0_0.STATES.INITED

	arg_8_0:OnInit()
	arg_8_0:HandleFuncQueue()

	return
end

function var_0_0.Destroy(arg_9_0)
	if arg_9_0._state == var_0_0.STATES.DESTROY then
		return
	end

	if not arg_9_0:GetLoaded() then
		arg_9_0._state = var_0_0.STATES.DESTROY

		return
	end

	arg_9_0._state = var_0_0.STATES.DESTROY

	pg.DelegateInfo.Dispose(arg_9_0)
	arg_9_0:OnDestroy()
	bindComponent(arg_9_0, arg_9_0._go, true)
	arg_9_0:disposeEvent()
	arg_9_0:cleanManagedTween()

	arg_9_0._tf = nil

	if arg_9_0._go ~= nil and not arg_9_0.noReturnPrefab then
		PoolMgr.GetInstance():ReturnUI(arg_9_0:getUIName(), arg_9_0._go)

		arg_9_0._go = nil
	end

	arg_9_0.noReturnPrefab = nil

	return
end

function var_0_0.HandleFuncQueue(arg_10_0)
	if arg_10_0._state == var_0_0.STATES.INITED then
		while #arg_10_0._funcQueue > 0 do
			local var_10_0 = table.remove(arg_10_0._funcQueue, 1)

			var_10_0.func(unpackEx(var_10_0.params))
		end
	end

	return
end

function var_0_0.Reset(arg_11_0)
	arg_11_0._state = var_0_0.STATES.NONE

	return
end

function var_0_0.ActionInvoke(arg_12_0, arg_12_1, ...)
	assert(arg_12_0[arg_12_1], "func not exist >>>" .. arg_12_1)

	arg_12_0._funcQueue[#arg_12_0._funcQueue + 1] = {
		funcName = arg_12_1,
		func = arg_12_0[arg_12_1],
		params = packEx(arg_12_0, ...)
	}

	arg_12_0:HandleFuncQueue()

	return
end

function var_0_0.ActionInvokeExclusive(arg_13_0, arg_13_1, ...)
	while #arg_13_0._funcQueue > 0 do
		if arg_13_0._funcQueue[#arg_13_0._funcQueue].funcName == arg_13_1 then
			table.remove(arg_13_0._funcQueue, #arg_13_0._funcQueue)
		end
	end

	arg_13_0:ActionInvoke(arg_13_1, ...)

	return
end

function var_0_0.CallbackInvoke(arg_14_0, arg_14_1, ...)
	arg_14_0._funcQueue[#arg_14_0._funcQueue + 1] = {
		func = arg_14_1,
		params = packEx(...)
	}

	arg_14_0:HandleFuncQueue()

	return
end

function var_0_0.ExecuteAction(arg_15_0, arg_15_1, ...)
	arg_15_0:Load()
	arg_15_0:ActionInvoke(arg_15_1, ...)

	return
end

function var_0_0.GetLoaded(arg_16_0)
	return arg_16_0._state >= var_0_0.STATES.LOADED
end

function var_0_0.CheckState(arg_17_0, arg_17_1)
	return arg_17_0._state == arg_17_1
end

function var_0_0.Show(arg_18_0)
	setActive(arg_18_0._tf, true)
	arg_18_0:ShowOrHideResUI(true)
	arg_18_0:PlayBGM()

	return
end

function var_0_0.Hide(arg_19_0)
	setActive(arg_19_0._tf, false)
	arg_19_0:ShowOrHideResUI(false)
	arg_19_0:StopBgm()

	return
end

function var_0_0.isShowing(arg_20_0)
	return arg_20_0._tf and isActive(arg_20_0._tf) or false
end

function var_0_0.getBGM(arg_21_0, arg_21_1)
	return getBgm(arg_21_1 or arg_21_0.__cname)
end

function var_0_0.PlayBGM(arg_22_0)
	local var_22_0 = arg_22_0:getBGM()

	if var_22_0 then
		pg.BgmMgr.GetInstance():Push(arg_22_0.__cname, var_22_0)
	end

	return
end

function var_0_0.StopBgm(arg_23_0)
	pg.BgmMgr.GetInstance():Pop(arg_23_0.__cname)

	return
end

function var_0_0.getTpl(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = (arg_24_2 or arg_24_0._tf):Find(arg_24_1)

	var_24_0:SetParent(arg_24_0._tf, false)
	SetActive(var_24_0, false)

	return var_24_0
end

function var_0_0.getUIName(arg_25_0)
	return nil
end

function var_0_0.OnLoaded(arg_26_0)
	return
end

function var_0_0.OnInit(arg_27_0)
	return
end

function var_0_0.OnDestroy(arg_28_0)
	return
end

function var_0_0.ResUISettings(arg_29_0)
	return nil
end

function var_0_0.ShowOrHideResUI(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0:ResUISettings()

	if not var_30_0 then
		return
	end

	if var_30_0 == true then
		var_30_0 = {
			anim = true,
			showType = PlayerResUI.TYPE_ALL
		}
	end

	local var_30_1 = arg_30_0:getGroupName()

	if arg_30_1 then
		pg.playerResUI:SetSettings(var_30_1, setmetatable({
			groupName = var_30_1
		}, {
			__index = var_30_0
		}))
	else
		pg.playerResUI:RemoveSettings(var_30_1)
	end

	return
end

function var_0_0.getGroupName(arg_31_0)
	return arg_31_0.contextData.groupName or arg_31_0.__cname
end

return var_0_0
