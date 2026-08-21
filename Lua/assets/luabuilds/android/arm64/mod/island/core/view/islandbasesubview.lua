local var_0_0 = class("IslandBaseSubView", import("Mod.Island.Core.View.IslandBaseUnit"))

function var_0_0.Init(arg_1_0, ...)
	local var_1_0 = packEx(...)

	arg_1_0:LoadUI(function(arg_2_0)
		arg_1_0:DoInit(arg_2_0, var_1_0)

		return
	end)

	return
end

function var_0_0.LoadUI(arg_3_0, arg_3_1)
	arg_3_0.loadingId = IslandAssetLoadDispatcher.Instance:Enqueue("UI/" .. arg_3_0:GetUIName(), "", typeof(GameObject), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_4_0)
		arg_3_0.insId = FrameAsyncInstantiateManager.Instance:EnqueueInstantiateUI(arg_4_0, arg_3_0:GetUIParent(), Vector3.zero, arg_3_1)

		return
	end), true, true)

	return
end

function var_0_0.DoInit(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._go = arg_5_1
	arg_5_0._tf = arg_5_1.transform

	var_0_0.super.Init(arg_5_0, arg_5_1)

	arg_5_0._tf.localPosition = Vector3.zero

	arg_5_1.transform:SetAsFirstSibling()
	arg_5_0:OnBeforeLoaded()
	arg_5_0:FirstFlush()
	arg_5_0:Flush(unpackEx(arg_5_2))
	arg_5_0:OnLoaded()

	return
end

function var_0_0.OnDispose(arg_6_0)
	arg_6_0:UnloadUI()

	arg_6_0._go = nil
	arg_6_0._tf = nil

	return
end

function var_0_0.UnloadUI(arg_7_0)
	if not IsNil(arg_7_0._go) then
		Object.Destroy(arg_7_0._go)
	end

	if arg_7_0.loadingId then
		IslandAssetLoadDispatcher.Instance:Cancel(arg_7_0.loadingId)

		arg_7_0.loadingId = nil
	end

	if arg_7_0.insId then
		FrameAsyncInstantiateManager.Instance:Cancel(arg_7_0.insId)

		arg_7_0.insId = nil
	end

	arg_7_0.exited = true

	return
end

function var_0_0.ShowMsgbox(arg_8_0, arg_8_1)
	arg_8_0:GetView():ShowMsgbox(arg_8_1)

	return
end

function var_0_0.GetPlayerUnit(arg_9_0)
	return arg_9_0:GetView().player
end

function var_0_0.CreateSubView(arg_10_0, arg_10_1)
	return arg_10_1.New(arg_10_0:GetView())
end

function var_0_0.GetUIName(arg_11_0)
	assert(false, "overwrite me")

	return
end

function var_0_0.GetUIParent(arg_12_0, arg_12_1)
	assert(false, "overwrite me")

	return
end

function var_0_0.Flush(arg_13_0, ...)
	return
end

function var_0_0.FirstFlush(arg_14_0)
	return
end

function var_0_0.OnBeforeLoaded(arg_15_0)
	return
end

function var_0_0.OnLoaded(arg_16_0)
	return
end

return var_0_0
