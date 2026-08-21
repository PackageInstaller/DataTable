local var_0_0 = class("ActivityPtNotView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Activity/Submodule/ActivityPt/ActivityPtNoteUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
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
	return
end

function var_0_0.OnTop(arg_9_0)
	arg_9_0:UpdateBar()
end

function var_0_0.UpdateBar(arg_10_0)
	return
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0:AddEventListeners()

	arg_11_0.contentText_.text = GetTips("ACTIVITY_SUMMER_PT_REPEAT_DESCRIPE")
end

function var_0_0.OnExit(arg_12_0)
	arg_12_0:RemoveAllEventListener()
end

function var_0_0.OnMainHomeViewTop(arg_13_0)
	return
end

function var_0_0.Dispose(arg_14_0)
	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
