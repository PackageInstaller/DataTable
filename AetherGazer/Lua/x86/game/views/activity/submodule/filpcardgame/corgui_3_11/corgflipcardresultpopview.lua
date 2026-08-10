local var_0_0 = class("CORGflipCardResultPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return XH3rdFlipCardTool:GetResultUI()
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

	arg_4_0.resultController_ = arg_4_0.controller_:GetController("result")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.backBtn_, nil, function()
		local var_6_0 = XH3rdFlipCardTool:GetIsSuccess()

		XH3rdFlipCardTool:ResetGame()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.clueID_ = arg_7_0.params_.clueID or 0

	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_8_0)
	if XH3rdFlipCardTool.GetIsSuccess() then
		arg_8_0.useTimeText_.text = string.format(GetTips("ACTIVITY_FLIP_CARD_TIME_COST"), XH3rdFlipCardTool:GetUseTime())

		if arg_8_0.clueID_ ~= 0 then
			SetActive(arg_8_0.successClueGo_, true)
		else
			SetActive(arg_8_0.successClueGo_, false)
		end

		arg_8_0.resultController_:SetSelectedState("win")
	else
		arg_8_0.resultController_:SetSelectedState("lose")
	end
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
end

function var_0_0.OnExit(arg_10_0)
	return
end

return var_0_0
