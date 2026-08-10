local var_0_0 = class("AutoChessIllustratedWindow", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_OsirisHorus/Activity_OsirisHorus_Main/Activity_OsirisHorus_IllustratedUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.staticContext = {
		page = {
			ChessShop = {
				opened = false,
				idx = 1,
				obj = "chessshoppanelGo_",
				state = "chessshop",
				script = AutoChessIllustratedChessShopPanel
			},
			Skill = {
				opened = false,
				idx = 2,
				obj = "adminskillpanelGo_",
				state = "skill",
				script = AutoChessIllustratedAdminSkillPanel
			}
		},
		functionController_ = arg_4_0.controller_:GetController("function"),
		timerController_ = arg_4_0.controller_:GetController("timer")
	}
	arg_4_0.autoChessCountDownView_ = AutoChessCountDownView.New(arg_4_0.timerGo_)
end

function var_0_0.AddCaptureEventListener(arg_5_0)
	arg_5_0:RegistEventListener(AUTO_CHESS_ILLUSTATED_CLICK, handler(arg_5_0, arg_5_0.OnClickItem))
end

function var_0_0.OnClickItem(arg_6_0, arg_6_1, arg_6_2)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.staticContext.page) do
		if iter_6_1.opened then
			iter_6_1.entity:ClickChessItem(arg_6_1, arg_6_2)
			OperationRecorder.RecordButtonTouch({
				button_name = "activity_autochess_illustration_item_touch",
				activity_id = AutoChessData:GetActivityID(),
				type = arg_6_2 == AutoChessConst.ILLUSTRATE_TYPE.CHESS_SHOP and 1 or 2,
				item_id = arg_6_1
			})
		end
	end
end

function var_0_0.AddUIListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.chessshopBtn_, nil, function()
		arg_7_0:EnterPage(arg_7_0.staticContext.page.ChessShop.idx)
	end)
	arg_7_0:AddBtnListener(arg_7_0.skillBtn_, nil, function()
		if AutoChessData:GetActivityID() == ActivityConst.ACTIVITY_AUTO_CHESS_MAIN and AutoChessTools.GetStageState(GameSetting.auto_chess_pro_admin_unlock.value[1]) == AutoChessConst.STAGE_STATE.LOCK then
			ShowTips("AUTO_CHESS_INDEX_LOCKED")
		else
			arg_7_0:EnterPage(arg_7_0.staticContext.page.Skill.idx)
		end

		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_illustration_item_touch",
			type = 3,
			activity_id = AutoChessData:GetActivityID()
		})
	end)
end

function var_0_0.EnterPage(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.staticContext.page) do
		if iter_10_1.idx == arg_10_1 then
			if not iter_10_1.opened then
				arg_10_0:InstOrCreatePage(iter_10_1, iter_10_1.idx)
				iter_10_1.entity:OnEnter(iter_10_1.idx, arg_10_0.isInGame)

				iter_10_1.opened = true

				arg_10_0.staticContext.functionController_:SetSelectedState(iter_10_1.state)
			end
		elseif iter_10_1.opened then
			iter_10_1.entity:OnExit()

			iter_10_1.opened = false
		end
	end

	saveData("AutoChess", "IllustratedSwitch", arg_10_1)
end

function var_0_0.InstOrCreatePage(arg_11_0, arg_11_1)
	if arg_11_1.entity == nil then
		arg_11_1.entity = arg_11_1.script.New(arg_11_0[arg_11_1.obj])
	end
end

function var_0_0.OnTop(arg_12_0)
	if arg_12_0.isInGame then
		manager.windowBar:SwitchBar({
			BACK_BAR
		})
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end
end

function var_0_0.GetDefaultSwitch(arg_13_0)
	local var_13_0 = getData("AutoChess", "IllustratedSwitch") or arg_13_0.staticContext.page.ChessShop.idx

	if var_13_0 == arg_13_0.staticContext.page.Skill.idx and AutoChessTools.GetStageState(AutoChessConst.ADMIN_ILLUSTRATE_UNLOCK_STAGE) == AutoChessConst.STAGE_STATE.LOCK then
		var_13_0 = arg_13_0.staticContext.page.ChessShop.idx
	end

	return var_13_0
end

function var_0_0.OnEnter(arg_14_0)
	arg_14_0:AddCaptureEventListener()
	arg_14_0:CheckTimer()
	arg_14_0:EnterPage(arg_14_0:GetDefaultSwitch())

	if AutoChessData:GetActivityID() == ActivityConst.ACTIVITY_AUTO_CHESS_MAIN and AutoChessTools.GetStageState(GameSetting.auto_chess_pro_admin_unlock.value[1]) == AutoChessConst.STAGE_STATE.LOCK then
		arg_14_0.skillText_.text = "? ? ? ? ? ?"
		arg_14_0.skillSelectText_.text = "? ? ? ? ? ?"
	else
		arg_14_0.skillText_.text = GetTips("AUTO_CHESS_ADMIN_SKILLS")
		arg_14_0.skillSelectText_.text = GetTips("AUTO_CHESS_ADMIN_SKILLS")
	end

	arg_14_0.shopSelectText_.text = GetTips("AUTO_CHESS_INDEX_TAB_CARD")
	arg_14_0.shopText_.text = GetTips("AUTO_CHESS_INDEX_TAB_CARD")
end

function var_0_0.CheckTimer(arg_15_0)
	arg_15_0.isInGame = arg_15_0.params_.isInGame or false
	arg_15_0.isInOnlineGame = arg_15_0.isInGame and AutoChessData:GetCurGameType() == AutoChessConst.GAME_TYPE.ONLINE

	arg_15_0.staticContext.timerController_:SetSelectedState(arg_15_0.isInOnlineGame and "show" or "hide")

	if arg_15_0.isInOnlineGame then
		arg_15_0.autoChessCountDownView_:UpdateCountDownTime()
	end
end

function var_0_0.OnExit(arg_16_0)
	manager.windowBar:HideBar()

	for iter_16_0, iter_16_1 in pairs(arg_16_0.staticContext.page) do
		if iter_16_1.opened then
			iter_16_1.entity:OnExit()

			iter_16_1.opened = false
		end
	end

	if arg_16_0.autoChessCountDownView_ then
		arg_16_0.autoChessCountDownView_:OnExit()
	end

	arg_16_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_17_0)
	for iter_17_0, iter_17_1 in pairs(arg_17_0.staticContext.page) do
		if iter_17_1.entity then
			iter_17_1.entity:Dispose()

			iter_17_1.opened = false
		end

		iter_17_1.entity = nil
	end

	if arg_17_0.autoChessCountDownView_ then
		arg_17_0.autoChessCountDownView_:Dispose()
	end

	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
