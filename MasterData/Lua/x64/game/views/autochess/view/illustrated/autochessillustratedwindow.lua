local AutoChessIllustratedWindow = class("AutoChessIllustratedWindow", ReduxView)

function AutoChessIllustratedWindow:UIName()
	return "Widget/System/Activity_OsirisHorus/Activity_OsirisHorus_Main/Activity_OsirisHorus_IllustratedUI"
end

function AutoChessIllustratedWindow:UIParent()
	return manager.ui.uiMain.transform
end

function AutoChessIllustratedWindow:Init()
	self:InitUI()
	self:AddUIListeners()
end

function AutoChessIllustratedWindow:InitUI()
	self:BindCfgUI()

	self.staticContext = {
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
		functionController_ = self.controller_:GetController("function"),
		timerController_ = self.controller_:GetController("timer")
	}
	self.autoChessCountDownView_ = AutoChessCountDownView.New(self.timerGo_)
end

function AutoChessIllustratedWindow:AddCaptureEventListener()
	self:RegistEventListener(AUTO_CHESS_ILLUSTATED_CLICK, handler(self, self.OnClickItem))
end

function AutoChessIllustratedWindow:OnClickItem(arg_6_1, arg_6_2)
	for iter_6_0, iter_6_1 in pairs(self.staticContext.page) do
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

function AutoChessIllustratedWindow:AddUIListeners()
	self:AddBtnListener(self.chessshopBtn_, nil, function()
		self:EnterPage(self.staticContext.page.ChessShop.idx)
	end)
	self:AddBtnListener(self.skillBtn_, nil, function()
		if AutoChessData:GetActivityID() == ActivityConst.ACTIVITY_AUTO_CHESS_MAIN and AutoChessTools.GetStageState(GameSetting.auto_chess_pro_admin_unlock.value[1]) == AutoChessConst.STAGE_STATE.LOCK then
			ShowTips("AUTO_CHESS_INDEX_LOCKED")
		else
			self:EnterPage(self.staticContext.page.Skill.idx)
		end

		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_illustration_item_touch",
			type = 3,
			activity_id = AutoChessData:GetActivityID()
		})
	end)
end

function AutoChessIllustratedWindow:EnterPage(arg_10_1)
	for iter_10_0, iter_10_1 in pairs(self.staticContext.page) do
		if iter_10_1.idx == arg_10_1 then
			if not iter_10_1.opened then
				self:InstOrCreatePage(iter_10_1, iter_10_1.idx)
				iter_10_1.entity:OnEnter(iter_10_1.idx, self.isInGame)

				iter_10_1.opened = true

				self.staticContext.functionController_:SetSelectedState(iter_10_1.state)
			end
		elseif iter_10_1.opened then
			iter_10_1.entity:OnExit()

			iter_10_1.opened = false
		end
	end

	saveData("AutoChess", "IllustratedSwitch", arg_10_1)
end

function AutoChessIllustratedWindow:InstOrCreatePage(arg_11_1)
	if arg_11_1.entity == nil then
		arg_11_1.entity = arg_11_1.script.New(self[arg_11_1.obj])
	end
end

function AutoChessIllustratedWindow:OnTop()
	if self.isInGame then
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

function AutoChessIllustratedWindow:GetDefaultSwitch()
	local var_13_0 = getData("AutoChess", "IllustratedSwitch") or self.staticContext.page.ChessShop.idx

	if var_13_0 == self.staticContext.page.Skill.idx and AutoChessTools.GetStageState(AutoChessConst.ADMIN_ILLUSTRATE_UNLOCK_STAGE) == AutoChessConst.STAGE_STATE.LOCK then
		var_13_0 = self.staticContext.page.ChessShop.idx
	end

	return var_13_0
end

function AutoChessIllustratedWindow:OnEnter()
	self:AddCaptureEventListener()
	self:CheckTimer()
	self:EnterPage(self:GetDefaultSwitch())

	if AutoChessData:GetActivityID() == ActivityConst.ACTIVITY_AUTO_CHESS_MAIN and AutoChessTools.GetStageState(GameSetting.auto_chess_pro_admin_unlock.value[1]) == AutoChessConst.STAGE_STATE.LOCK then
		self.skillText_.text = "? ? ? ? ? ?"
		self.skillSelectText_.text = "? ? ? ? ? ?"
	else
		self.skillText_.text = GetTips("AUTO_CHESS_ADMIN_SKILLS")
		self.skillSelectText_.text = GetTips("AUTO_CHESS_ADMIN_SKILLS")
	end

	self.shopSelectText_.text = GetTips("AUTO_CHESS_INDEX_TAB_CARD")
	self.shopText_.text = GetTips("AUTO_CHESS_INDEX_TAB_CARD")
end

function AutoChessIllustratedWindow:CheckTimer()
	self.isInGame = self.params_.isInGame or false
	self.isInOnlineGame = self.isInGame and AutoChessData:GetCurGameType() == AutoChessConst.GAME_TYPE.ONLINE

	self.staticContext.timerController_:SetSelectedState(self.isInOnlineGame and "show" or "hide")

	if self.isInOnlineGame then
		self.autoChessCountDownView_:UpdateCountDownTime()
	end
end

function AutoChessIllustratedWindow:OnExit()
	manager.windowBar:HideBar()

	for iter_16_0, iter_16_1 in pairs(self.staticContext.page) do
		if iter_16_1.opened then
			iter_16_1.entity:OnExit()

			iter_16_1.opened = false
		end
	end

	if self.autoChessCountDownView_ then
		self.autoChessCountDownView_:OnExit()
	end

	self:RemoveAllEventListener()
end

function AutoChessIllustratedWindow:Dispose()
	for iter_17_0, iter_17_1 in pairs(self.staticContext.page) do
		if iter_17_1.entity then
			iter_17_1.entity:Dispose()

			iter_17_1.opened = false
		end

		iter_17_1.entity = nil
	end

	if self.autoChessCountDownView_ then
		self.autoChessCountDownView_:Dispose()
	end

	AutoChessIllustratedWindow.super.Dispose(self)
end

return AutoChessIllustratedWindow
