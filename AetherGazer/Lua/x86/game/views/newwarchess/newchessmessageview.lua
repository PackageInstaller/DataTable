local var_0_0 = class("NewChessMessageView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/NewWarChess/NewWarChessTextPopUI"
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

	arg_4_0.controller_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "conName")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:Back()
		arg_5_0.cancelCallBack()
	end)
	arg_5_0:AddBtnListener(arg_5_0.checkBtn_, nil, function()
		arg_5_0:Back()
		arg_5_0.checkCallBack()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.logId_ = arg_8_0.params_.logId
	arg_8_0.checkCallBack = arg_8_0.params_.checkCallBack
	arg_8_0.cancelCallBack = arg_8_0.params_.cancelCallBack
	arg_8_0.style_ = arg_8_0.params_.style

	arg_8_0:RefreshUI()
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0.controller_:SetSelectedState(arg_10_0.style_)

	if arg_10_0.style_ == "cantReach" then
		arg_10_0.checkBtn_.interactable = false
		arg_10_0.checkText_.text = GetTips("CAN_NOT_TEACH")
	elseif arg_10_0.style_ == "no" then
		arg_10_0.checkBtn_.interactable = true
		arg_10_0.checkText_.text = GetTips("CONFIRM")
	else
		arg_10_0.checkBtn_.interactable = true
		arg_10_0.checkText_.text = GetTips("GO_UP_TO")
	end

	if not WarchessContentCfg[arg_10_0.logId_] then
		error("不存在的Id :", arg_10_0.logId_)
	end

	arg_10_0.textinfoText_.text = WarchessContentCfg[arg_10_0.logId_].content

	local var_10_0 = WarchessContentCfg[arg_10_0.logId_].icon

	if var_10_0 ~= "" then
		arg_10_0.itemiconImg_.sprite = getSpriteViaConfig("WarchessItem", var_10_0)
	end

	arg_10_0.textnameText_.text = WarchessContentCfg[arg_10_0.logId_].name
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
