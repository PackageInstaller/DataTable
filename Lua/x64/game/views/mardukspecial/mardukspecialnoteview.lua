local var_0_0 = class("MardukSpecialNoteView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/MardukUI/special/MardukSpecialNoteUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.bgBtn_, nil, function()
		arg_6_0:Back()
	end)
end

function var_0_0.AddEventListeners(arg_8_0)
	arg_8_0:RegistEventListener(GUILD_EXIT, function()
		arg_8_0:Go("/home")
	end)
end

function var_0_0.OnTop(arg_10_0)
	arg_10_0:UpdateBar()
end

function var_0_0.UpdateBar(arg_11_0)
	return
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0:AddEventListeners()

	arg_12_0.contentText_.text = GetTips("MARDUK_SPECIAL_NOTE")

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_0.content_)
end

function var_0_0.OnExit(arg_13_0)
	arg_13_0:RemoveAllEventListener()
end

function var_0_0.OnMainHomeViewTop(arg_14_0)
	return
end

function var_0_0.Dispose(arg_15_0)
	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
