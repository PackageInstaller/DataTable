class = var_0_10000

local var_0_0 = "IslandBaseSubView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("Mod.Island.Core.View.IslandBaseUnit"))

function var_0_1.Init(arg_1_0, ...)
	packEx = var_1_10001

	local var_1_0 = var_1_10001(...)

	arg_1_0:LoadUI(function(arg_2_0)
		local var_2_0 = arg_1_0

		var_1.DoInit(var_2_0, arg_2_0, var_1_0)

		return
	end)

	return
end

function var_0_1.LoadUI(arg_3_0, arg_3_1)
	IslandAssetLoadDispatcher = var_1_10002

	local var_3_0 = var_1_10002.Instance
	local var_3_1 = var_2.Enqueue
	local var_3_2 = "UI/"
	local var_3_3 = arg_3_0
	local var_3_4 = var_3_2 .. arg_3_0.GetUIName(var_3_3)
	local var_3_5 = ""

	typeof = var_1_10007
	GameObject = var_1_10009

	local var_3_6 = var_1_10007(var_1_10009)

	UnityEngine = var_3_3
	arg_3_0.loadingId = var_3_1(var_3_0, var_3_4, var_3_5, var_3_6, var_3_3.Events.UnityAction_UnityEngine_Object(function(arg_4_0)
		local var_4_0 = arg_3_0
		local var_4_1 = var_1.GetUIParent(var_4_0)
		local var_4_2 = arg_3_0

		FrameAsyncInstantiateManager = var_4_0

		local var_4_3 = var_4_0.Instance
		local var_4_4 = var_3.EnqueueInstantiateUI
		local var_4_5 = arg_4_0
		local var_4_6 = var_4_1

		Vector3 = var_2_10008
		var_4_2.insId = var_4_4(var_4_3, var_4_5, var_4_6, var_2_10008.zero, arg_3_1)

		return
	end), true, true)

	return
end

function var_0_1.DoInit(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._go = arg_5_1
	arg_5_0._tf = arg_5_1.transform

	var_0_1.super.Init(arg_5_0, arg_5_1)

	local var_5_0 = arg_5_0._tf

	Vector3 = var_1_10004
	var_5_0.localPosition = var_1_10004.zero

	local var_5_1 = arg_5_1.transform

	var_3.SetAsFirstSibling(var_5_1)
	arg_5_0:OnBeforeLoaded()
	arg_5_0:FirstFlush()

	local var_5_2 = arg_5_0
	local var_5_3 = arg_5_0.Flush

	unpackEx = var_6

	var_5_3(var_5_2, var_6(arg_5_2))
	arg_5_0:OnLoaded()

	return
end

function var_0_1.OnDispose(arg_6_0)
	arg_6_0:UnloadUI()

	arg_6_0._go = nil
	arg_6_0._tf = nil

	return
end

function var_0_1.UnloadUI(arg_7_0)
	IsNil = var_1_10001

	if not var_1_10001(arg_7_0._go) then
		Object = var_1

		var_1.Destroy(arg_7_0._go)
	end

	if arg_7_0.loadingId then
		IslandAssetLoadDispatcher = var_1

		local var_7_0 = var_1.Instance

		var_1.Cancel(var_7_0, arg_7_0.loadingId)

		arg_7_0.loadingId = nil
	end

	if arg_7_0.insId then
		FrameAsyncInstantiateManager = var_1

		local var_7_1 = var_1.Instance

		var_1.Cancel(var_7_1, arg_7_0.insId)

		arg_7_0.insId = nil
	end

	arg_7_0.exited = true

	return
end

function var_0_1.ShowMsgbox(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:GetView()

	var_2.ShowMsgbox(var_8_0, arg_8_1)

	return
end

function var_0_1.GetPlayerUnit(arg_9_0)
	return arg_9_0:GetView().player
end

function var_0_1.CreateSubView(arg_10_0, arg_10_1)
	return arg_10_1.New(arg_10_0:GetView())
end

function var_0_1.GetUIName(arg_11_0)
	assert = var_1_10001

	var_1_10001(false, "overwrite me")

	return
end

function var_0_1.GetUIParent(arg_12_0, arg_12_1)
	assert = var_1_10002

	var_1_10002(false, "overwrite me")

	return
end

function var_0_1.Flush(arg_13_0, ...)
	return
end

function var_0_1.FirstFlush(arg_14_0)
	return
end

function var_0_1.OnBeforeLoaded(arg_15_0)
	return
end

function var_0_1.OnLoaded(arg_16_0)
	return
end

return var_0_1
