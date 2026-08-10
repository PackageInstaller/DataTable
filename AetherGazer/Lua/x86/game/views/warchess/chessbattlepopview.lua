local var_0_0 = class("ChessBattlePopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/WarChess_Battle/WarChessBattlePopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:Back()
		arg_5_0.info_.MaskCallback()
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnOK_, nil, function()
		arg_5_0:Back()
		arg_5_0.info_.OkCallback()
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnCancel_, nil, function()
		arg_5_0:Back()
		arg_5_0.info_.CancelCallback()
	end)
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0.contentText_.text = GetI18NText(arg_9_0.info_.content)
end

function var_0_0.OnEnter(arg_10_0)
	manager.ui:SetMainCamera(WarchessLevelCfg[WarChessData:GetCurrentWarChessMapData().mapId].scene_id, true)

	arg_10_0.info_ = arg_10_0.params_

	arg_10_0:RefreshUI()
end

function var_0_0.OnExit(arg_11_0)
	return
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
