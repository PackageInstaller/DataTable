local var_0_0 = class("BlisterMessageView", ReduxView)

function var_0_0.Init(arg_1_0)
	arg_1_0:InitUI()

	arg_1_0.nodeList = {}

	arg_1_0:AddListeners()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiPop.transform
end

function var_0_0.UIName(arg_4_0)
	return "Widget/System/Summer2024/Summer2024_Bubble/BubbleresultPop02UI"
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.suminibtn01Btn_, nil, function()
		arg_5_0:Back()
		BlisterGameTool.ReStartGame()
	end)
	arg_5_0:AddBtnListener(arg_5_0.bgmaskBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.suminibtn02Btn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.suminibtn03Btn_, nil, function()
		arg_5_0:Back()

		if arg_5_0.params_ and arg_5_0.params_.OkCallback then
			arg_5_0.params_.OkCallback()
		end
	end)
end

function var_0_0.OnEnter(arg_10_0)
	var_0_0.super.OnEnter(arg_10_0)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_0.btncontentTrs_)
end

function var_0_0.OnExit(arg_11_0)
	var_0_0.super.OnExit(arg_11_0)
	BlisterGameLuaBridge.PauseGame()
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
