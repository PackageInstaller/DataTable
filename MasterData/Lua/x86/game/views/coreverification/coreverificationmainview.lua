local CoreVerificationMainView = class("CoreVerificationMainView", ReduxView)

function CoreVerificationMainView:UIName()
	return "Widget/System/Core_Verification/CoreVerificationMain"
end

function CoreVerificationMainView:UIParent()
	return manager.ui.uiMain.transform
end

function CoreVerificationMainView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function CoreVerificationMainView:InitUI()
	self:BindCfgUI()

	self.updateInfoHandler = handler(self, self.UpdateCoreVerification)
	self.mainBossItem_ = CoreVerificationBossItem.New(self.boss1Go_, 1)
	self.subBossItem_ = CoreVerificationBossItem.New(self.boss2Go_, 2)
	self.recordController = self.rankingControllerexcollection_:GetController("haveRecord")
	self.isSuperController = self.coreverificationmainControllerexcollection_:GetController("isSuper")
end

function CoreVerificationMainView:AddUIListeners()
	self:AddBtnListener(self.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("/coreVerificationReward", {})
	end)
	self:AddBtnListener(self.shopBtn_, nil, function()
		JumpTools.GoToSystem("/shop", {
			shopId = ShopConst.SHOP_ID.CORE_VERIFICATION
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	self:AddBtnListener(self.previewBtn_, nil, function()
		JumpTools.OpenPageByJump("coreVerificationPre", {})
	end)
	self:AddBtnListener(self.btn_flushedBtn_, nil, function()
		ShowMessageBox({
			isTop = true,
			content = GetTips("CORE_VERIFICATION_RESETTIPS1"),
			OkCallback = function()
				CoreVerificationAction.ResetChallenge(0)
			end
		})
	end)
	self:AddBtnListener(self.btn_flushed2Btn_, nil, function()
		ShowMessageBox({
			isTop = true,
			content = GetTips("CORE_VERIFICATION_TAB_DES_5"),
			OkCallback = function()
				CoreVerificationAction.ResetChallenge(1)
			end
		})
	end)
	self:AddBtnListener(self.scourebtnBtn_, nil, function()
		JumpTools.OpenPageByJump("/coreVerificationTeamCheck", {
			dataList = {
				CoreVerificationData:GetMaxScoreHeroInfo(1),
				(CoreVerificationData:GetMaxScoreHeroInfo(2))
			}
		})
	end)
	self:AddBtnListener(self.rankbtnBtn_, nil, function()
		JumpTools.OpenPageByJump("/coreVerificationRank", {})
	end)
end

function CoreVerificationMainView:UpdateCoreVerification()
	CoreVerificationAction.UpdateChallengeRedPoints()
	self:RefreshTitle()
	self:RefreshRecord()
end

function CoreVerificationMainView:OnEnter()
	saveData("CoreVerification", "click_time", _G.gameTimer:GetNextDayFreshTime())
	CoreVerificationAction.UpdateChallengeRedPoints()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("CORE_VERIFICATION_DES")
	manager.redPoint:bindUIandKey(self.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_CHALLENGE_NORMAL_REWARD)
	self:RefreshTitle()
	self:RefreshRecord()
	manager.notify:RegistListener(CORE_VERIFICATION_CYCLE_UPDATE, self.updateInfoHandler)
	SetActive(self.rankingGo_, false)
end

function CoreVerificationMainView:OnExit()
	manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_CHALLENGE_NORMAL_REWARD)
	manager.notify:RemoveListener(CORE_VERIFICATION_CYCLE_UPDATE, self.updateInfoHandler)
	manager.windowBar:HideBar()
end

function CoreVerificationMainView:RefreshTitle()
	self.timeText_.text = manager.time:GetLostTimeStrWith2Unit(CoreVerificationData:GetRefreshTime())

	self.mainBossItem_:RefreshUI()
	self.subBossItem_:RefreshUI()
	SetActive(self.btn_flushedBtn_.gameObject, CoreVerificationData:GetCanReset())
	self.isSuperController:SetSelectedState(CoreVerificationTool.IsPassSuperStage() and "true" or "false")
end

function CoreVerificationMainView:RefreshRecord()
	self.scoreText_.text = CoreVerificationData:GetMaxScore()
end

function CoreVerificationMainView:Dispose()
	if self.subBossItem_ then
		self.subBossItem_:Dispose()

		self.subBossItem_ = nil
	end

	if self.mainBossItem_ then
		self.mainBossItem_:Dispose()

		self.mainBossItem_ = nil
	end

	CoreVerificationMainView.super.Dispose(self)
end

return CoreVerificationMainView
