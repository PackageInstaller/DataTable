local var_0_0 = class("AutoChessQuitPopView", ReduxView)

function var_0_0.Init(arg_1_0)
	arg_1_0:InitUI()

	arg_1_0.nodeList = {}

	arg_1_0:AddListeners()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.quitController = arg_2_0.controllerEx_:GetController("pause")
	arg_2_0.cancelController = arg_2_0.controllerEx_:GetController("cancel")
	arg_2_0.tipsController = arg_2_0.controllerEx_:GetController("tips")
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiPop.transform
end

function var_0_0.UIName(arg_4_0)
	return "Widget/System/Activity_OsirisHorus/Com/Activity_OsirisHorus_PopUI"
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.cancelBtn_, nil, function()
		arg_5_0:Back()

		if arg_5_0.cancelCb then
			arg_5_0.cancelCb()
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.okBtn_, nil, function()
		arg_5_0:Back()

		if arg_5_0.okCb then
			arg_5_0.okCb()
		end

		if arg_5_0.type_ == AutoChessConst.POP_TYPE.REMAIN_MONEY then
			saveData("auto_chess_pop", "skip_" .. arg_5_0.gameType_, arg_5_0.isSkip)
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.giveUpBtn_, nil, function()
		if arg_5_0.type_ ~= AutoChessConst.POP_TYPE.PVP_SYNC_RECONNECT then
			arg_5_0:Back()
		end

		saveData("auto_chess_pop", "skip_" .. arg_5_0.gameType_, false)
		AutoChessTools.CancelGame(arg_5_0.gameType_)
	end)
	arg_5_0:AddBtnListener(arg_5_0.tipsBtn_, nil, function()
		arg_5_0.isSkip = not arg_5_0.isSkip

		arg_5_0.tipsController:SetSelectedState(tostring(arg_5_0.isSkip))
	end)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.gameType_ = arg_10_0.params_.gameType
	arg_10_0.type_ = arg_10_0.params_.type
	arg_10_0.okCb = arg_10_0.params_.okCb
	arg_10_0.cancelCb = arg_10_0.params_.cancelCb

	SetActive(arg_10_0.tipsGo_, false)

	if arg_10_0.type_ == AutoChessConst.POP_TYPE.PVE then
		arg_10_0.tipContent_.text = GetTips("AUTO_CHESS_QUIT_CONFIRM")
		arg_10_0.cancelText_.text = GetTips("CANCEL")
		arg_10_0.confirmText_.text = GetTips("AUTO_CHESS_2_LEAVE")

		arg_10_0.quitController:SetSelectedState("show")
		arg_10_0.cancelController:SetSelectedState("show")

		return
	end

	if arg_10_0.type_ == AutoChessConst.POP_TYPE.REMAIN_MONEY then
		SetActive(arg_10_0.tipsGo_, true)

		arg_10_0.isSkip = false

		arg_10_0.tipsController:SetSelectedState(tostring(arg_10_0.isSkip))

		arg_10_0.tipContent_.text = GetTips("AUTO_CHESS_START_CONFIRM")
		arg_10_0.cancelText_.text = GetTips("CANCEL")
		arg_10_0.confirmText_.text = GetTips("CONFIRM")

		arg_10_0.quitController:SetSelectedState("hide")
		arg_10_0.cancelController:SetSelectedState("show")

		return
	end

	if arg_10_0.type_ == AutoChessConst.POP_TYPE.PVP_ASYNC then
		arg_10_0.tipContent_.text = GetTips("AUTO_CHESS_QUIT_CONFIRM")
		arg_10_0.cancelText_.text = GetTips("CANCEL")
		arg_10_0.confirmText_.text = GetTips("CONFIRM")

		arg_10_0.quitController:SetSelectedState("hide")
		arg_10_0.cancelController:SetSelectedState("show")

		return
	end

	if arg_10_0.type_ == AutoChessConst.POP_TYPE.PVE_FALLBACK then
		arg_10_0.tipContent_.text = GetTips("AUTO_CHESS_DISCONNECT_CONFIRM")
		arg_10_0.cancelText_.text = GetTips("CANCEL")
		arg_10_0.confirmText_.text = GetTips("CONFIRM")

		arg_10_0.quitController:SetSelectedState("hide")
		arg_10_0.cancelController:SetSelectedState("hide")

		return
	end

	if arg_10_0.type_ == AutoChessConst.POP_TYPE.PVP_SYNC then
		local var_10_0 = GameSetting.auto_chess_2_abandon_punish_round.value[1]
		local var_10_1 = AutoChessTools.GetCurRound(arg_10_0.gameType_)

		arg_10_0.tipContent_.text = var_10_1 <= var_10_0 and GetTips("AUTO_CHESS_2_ABANDON_EARLY_TIP") or GetTips("AUTO_CHESS_2_ABANDON_TIP")
		arg_10_0.cancelText_.text = GetTips("CANCEL")
		arg_10_0.confirmText_.text = GetTips("CONFIRM")

		arg_10_0.quitController:SetSelectedState("hide")
		arg_10_0.cancelController:SetSelectedState("show")

		return
	end

	if arg_10_0.type_ == AutoChessConst.POP_TYPE.PVP_SYNC_RECONNECT then
		arg_10_0.tipContent_.text = GetTips("AUTO_CHESS_2_RECONNECT_TIP")
		arg_10_0.confirmText_.text = GetTips("CONFIRM")

		arg_10_0.quitController:SetSelectedState("show")
		arg_10_0.cancelController:SetSelectedState("hide")
	end

	if arg_10_0.type_ == AutoChessConst.POP_TYPE.PREVIOUS_ADVICE then
		arg_10_0.tipContent_.text = GetTips("AUTO_CHESS_2_PREVIOUS_ADVICE")
		arg_10_0.confirmText_.text = GetTips("CONFIRM")
		arg_10_0.cancelText_.text = GetTips("CANCEL")

		arg_10_0.quitController:SetSelectedState("hide")
		arg_10_0.cancelController:SetSelectedState("show")
	end

	if arg_10_0.type_ == AutoChessConst.POP_TYPE.SKIP_TEACHING then
		arg_10_0.tipContent_.text = GetTips("AUTO_CHESS_2_SKIP_WINDOW")
		arg_10_0.confirmText_.text = GetTips("AUTO_CHESS_2_BUTTON_SKIP")
		arg_10_0.cancelText_.text = GetTips("AUTO_CHESS_2_BUTTON_RESUME")

		arg_10_0.quitController:SetSelectedState("hide")
		arg_10_0.cancelController:SetSelectedState("show")
	end

	if arg_10_0.type_ == AutoChessConst.POP_TYPE.TEACHING then
		arg_10_0.tipContent_.text = GetTips("AUTO_CHESS_2_TUTORIAL_SKIP")
		arg_10_0.confirmText_.text = GetTips("AUTO_CHESS_2_BUTTON_SKIP")
		arg_10_0.cancelText_.text = GetTips("CANCEL")

		arg_10_0.quitController:SetSelectedState("hide")
		arg_10_0.cancelController:SetSelectedState("show")
	end
end

return var_0_0
