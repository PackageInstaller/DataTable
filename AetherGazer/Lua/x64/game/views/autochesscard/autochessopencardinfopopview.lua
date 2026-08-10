local var_0_0 = class("AutoChessOpenCardInfoPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Pool/PoolInfoPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.stateCon_ = arg_4_0.controllerEx_:GetController("state")
	arg_4_0.recordView = AutoChessOpenCardInfoPopRecordView.New(arg_4_0.recordGo_)
	arg_4_0.bonusController_ = arg_4_0.controllerEx_:GetController("ExtractReturn")
	arg_4_0.pieceController_ = arg_4_0.controllerEx_:GetController("ExtractPiece")
	arg_4_0.hideTab4Controller_ = arg_4_0.controllerEx_:GetController("tabltem04")

	arg_4_0.hideTab4Controller_:SetSelectedState("off")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgMask_, nil, function()
		arg_5_0.stateCon_:SetSelectedState("info")
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnInfo_, nil, function()
		arg_5_0.stateCon_:SetSelectedState("info")
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnRecord_, nil, function()
		AutoChessCardAction.RequestRecord(handler(arg_5_0, arg_5_0.OnRequestRecordBack))
		arg_5_0.stateCon_:SetSelectedState("record")
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.stateCon_:SetSelectedState("info")
	arg_9_0.ani_:Update(0)
	arg_9_0:RefreshInfo()
	arg_9_0.recordView:OnEnter()
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_0.contentTrs_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_0.layout_1)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_0.infoContent_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_0.layout_2)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_0.layout_3)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_0.layout_4)
	TimeTools.StartAfterSeconds(0.033, function()
		arg_9_0.contentTrs_.localPosition = Vector3.New(0, 0, 0)
		arg_9_0.infoContent_.localPosition = Vector3.New(0, 0, 0)
	end, {})
end

function var_0_0.OnRequestRecordBack(arg_11_0)
	arg_11_0:RefreshRecord()
end

function var_0_0.RefreshInfo(arg_12_0)
	arg_12_0.infoTxt_.text = GetTips("AUTO_CHESS_2_CARD_DRAW_RULE")
	arg_12_0.txtSelectTab1_.text = GetTips("AUTO_CHESS_2_DRAW_TAB_RULE")
	arg_12_0.txtTab1_.text = GetTips("AUTO_CHESS_2_DRAW_TAB_RULE")
	arg_12_0.txtSelectTab3_.text = GetTips("AUTO_CHESS_2_DRAW_TAB_HISTORY")
	arg_12_0.txtTab3_.text = GetTips("AUTO_CHESS_2_DRAW_TAB_HISTORY")
end

function var_0_0.RefreshRecord(arg_13_0)
	arg_13_0.recordView:RefreshRecord()
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0.recordView:Dispose()
	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
