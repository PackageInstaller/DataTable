local ReversePacmanHomeScene = class("ReversePacmanHomeScene", import("view.base.BaseUI"))

function ReversePacmanHomeScene:getUIName()
	return "ReversePacmanHomeUI"
end

function ReversePacmanHomeScene:forceGC()
	return true
end

function ReversePacmanHomeScene:PlayBGM()
	pg.CriMgr.GetInstance():StopBGM()

	return
end

function ReversePacmanHomeScene:init()
	onButton(self, self.uiHomeBtn, function()
		self:emit(BaseUI.ON_HOME)

		return
	end, SFX_PANEL)
	onButton(self, self.uiBackBtn, function()
		self:emit(ReversePacmanHomeScene.ON_BACK)

		return
	end, SOUND_BACK)
	onButton(self, self.uiHelpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip["20260908gameplay_main_window"].tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.uiTechnologyBtn, function()
		if not ReversePacmanTools.HasHireRole() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("reverse_pacman_no_char"))

			return
		end

		self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			viewComponent = ReversePacmanTechnologyScene,
			mediator = ReversePacmanTechnologyMediator
		}))

		return
	end, SFX_PANEL)
	onButton(self, self.uiBattleBtn, function()
		if not ReversePacmanTools.HasHireRole() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("reverse_pacman_no_char"))

			return
		end

		self:emit(ReversePacmanHomeMediator.GO_GAME_SCENE)

		return
	end, SFX_PANEL)
	onButton(self, self.uiTaskBtn, function()
		self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			viewComponent = ReversePacmanTaskScene,
			mediator = ReversePacmanTaskMediator
		}))

		return
	end, SFX_PANEL)
	onButton(self, self.uiInterviewBtn, function()
		self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			viewComponent = ReversePacmanInterviewScene,
			mediator = ReversePacmanInterviewMediator
		}))

		return
	end, SFX_PANEL)

	return
end

function ReversePacmanHomeScene:didEnter()
	self:BlockEvents()
	self:SetUpCourtYard()
	self:RefreshTips()
	self:RefreshBtns()

	if self.contextData.technologyType then
		if not ReversePacmanTools.HasHireRole() then
			return
		end

		self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			viewComponent = ReversePacmanTechnologyScene,
			mediator = ReversePacmanTechnologyMediator,
			data = {
				toggleType = self.contextData.technologyType
			}
		}))
	end

	pg.NewStoryMgr.GetInstance():Play(ReversePacmanTools.GetActivity():getConfig("config_client").story[1])

	return
end

function ReversePacmanHomeScene:OnCourtYardLoaded()
	self:UnBlockEvents()

	if self.contextData.openTaskID then
		self.contextData.openTaskID = nil

		self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			viewComponent = ReversePacmanTaskScene,
			mediator = ReversePacmanTaskMediator,
			data = {
				taskID = self.contextData.openTaskID
			}
		}))

		return
	end

	if self.contextData.openInterview then
		self.contextData.openInterview = nil

		self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			viewComponent = ReversePacmanInterviewScene,
			mediator = ReversePacmanInterviewMediator
		}))

		return
	end

	if #ReversePacmanTools.GetUnreadyHireStory() > 0 then
		self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			viewComponent = ReversePacmanInterviewScene,
			mediator = ReversePacmanInterviewMediator
		}))
	end

	return
end

function ReversePacmanHomeScene:SetUpCourtYard()
	self.contextData.mode = CourtYardConst.SYSTEM_REVERSE_PACMAN

	self:emit(ReversePacmanHomeMediator.SET_UP, 1)

	return
end

function ReversePacmanHomeScene:BlockEvents()
	self.uiMainCanvasGrop.blocksRaycasts = false

	return
end

function ReversePacmanHomeScene:UnBlockEvents()
	self.uiMainCanvasGrop.blocksRaycasts = true

	return
end

function ReversePacmanHomeScene:RefreshBtns()
	local var_17_0 = ReversePacmanTools.HasHireRole()

	setGray(self.uiTechnologyBtn, not var_17_0)
	setGray(self.uiBattleBtn, not var_17_0)

	return
end

function ReversePacmanHomeScene:RefreshTips()
	local var_18_0 = ReversePacmanTools.GetActivity()

	setActive(self.uiTechnologyTipGo, var_18_0:GetTechnologyTip())
	setActive(self.uiBattleTipGo, var_18_0:GetGameTip())
	setActive(self.uiTaskTipGo, var_18_0:GetTaskTip())
	setActive(self.uiInterviewTipGo, var_18_0:GetHireTip())

	return
end

function ReversePacmanHomeScene:willExit()
	return
end

return ReversePacmanHomeScene
