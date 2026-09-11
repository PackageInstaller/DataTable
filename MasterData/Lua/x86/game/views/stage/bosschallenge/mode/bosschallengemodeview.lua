local BossChallengeModeView = class("BossChallengeModeView", ReduxView)

function BossChallengeModeView:UIName()
	return "Widget/System/Challenge_Boss/BossSelectModeUI"
end

function BossChallengeModeView:UIParent()
	return manager.ui.uiMain.transform
end

function BossChallengeModeView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.selectController_ = ControllerUtil.GetController(self.btnTransform_, "conName")
	self.chooseHandler_ = handler(self, self.ChooseMode)
	self.modeUIList_ = LuaList.New(handler(self, self.RefreshItem), self.uiList_, BossChallengeModeItem)
end

function BossChallengeModeView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("BOSS_CHALLENGE_MODE_DESC")
	manager.notify:RegistListener(CHALLENGE_CHOOSE_MODE, self.chooseHandler_)
	self.modeUIList_:StartScroll(#BossChallengeAdvanceCfg.all, 1)
	self:RefreshUI()
	BossTools.SaveFirstEnterUIValue()
end

function BossChallengeModeView:OnExit()
	self.chooseIndex_ = nil

	manager.windowBar:HideBar()
	manager.notify:RemoveListener(CHALLENGE_CHOOSE_MODE, self.chooseHandler_)
end

function BossChallengeModeView:Dispose()
	BossChallengeModeView.super.Dispose(self)

	self.chooseHandler_ = nil

	if self.modeUIList_ then
		self.modeUIList_:Dispose()

		self.modeUIList_ = nil
	end
end

function BossChallengeModeView:AddListeners()
	self:AddBtnListener(self.chooseBtn_, nil, function()
		if self.chooseIndex_ == nil then
			return
		end

		self:ClickBtn()
	end)
end

function BossChallengeModeView:ClickBtn()
	if BossChallengeAdvanceCfg[BossChallengeAdvanceCfg.all[self.chooseIndex_]].type == 1 then
		BattleBossChallengeAction.RequireBossChallengeData(BossChallengeAdvanceCfg.all[self.chooseIndex_], function()
			self:Go("/bossSwitch", nil, true)
		end)
	else
		BattleBossChallengeAction.RequireBossChallengeData(BossChallengeAdvanceCfg.all[self.chooseIndex_], function()
			self:Go("/bossAdvanceSwitch", nil, true)
		end)
	end
end

function BossChallengeModeView:RefreshUI()
	self:ChooseMode(self.chooseIndex_)
end

function BossChallengeModeView:RefreshItem(arg_13_1, arg_13_2)
	arg_13_2:SetData(arg_13_1, self.chooseIndex_)
end

function BossChallengeModeView:ChooseMode(arg_14_1)
	self.chooseIndex_ = arg_14_1

	if arg_14_1 then
		self.selectController_:SetSelectedState("yellow")
	else
		self.selectController_:SetSelectedState("black")
	end
end

return BossChallengeModeView
