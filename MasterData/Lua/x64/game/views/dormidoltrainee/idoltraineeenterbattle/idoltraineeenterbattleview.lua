local IdolTraineeEnterBattleView = class("IdolTraineeEnterBattleView", ReduxView)

function IdolTraineeEnterBattleView:UIName()
	return "Widget/BackHouseUI/IdolTrainee/IdolBattleEnterView"
end

function IdolTraineeEnterBattleView:UIParent()
	return manager.ui.uiMain.transform
end

function IdolTraineeEnterBattleView:Init()
	self:InitUI()
	self:AddUIListener()
end

function IdolTraineeEnterBattleView:InitUI()
	self:BindCfgUI()

	self.raceData_ = {}
	self.styleData_ = {}
	self.selectHeroPage_ = EnterBattleSelectHeroPage.New(self.selectHeroGo_)

	self.selectHeroPage_:ShowPage(false)

	self.selectOpponentPage_ = EnterBattleSelectOpponentPage.New(self.selectOpponentGo_)

	self.selectOpponentPage_:ShowPage(false)

	self.stageInfoPage = IdolTraineeStageInfoPage.New(self.stageInfo)

	self.stageInfoPage:ShowPage(true)

	self.showHistoryController = self.mainControllerEx_:GetController("showHistory")
end

function IdolTraineeEnterBattleView:AddUIListener()
	self:AddBtnListener(self.historyBtn_, nil, function()
		if self.pvpBattle_ then
			IdolTraineeAction.AskHistoryBattleData(function()
				JumpTools.OpenPageByJump("idolTraineeBattleHistoryPop")
			end)
		end
	end)
	self:AddBtnListener(self.enterBtn_, nil, function()
		local var_8_0

		if self.selectOpponentPage_.showFlag and self.pvpBattle_ then
			return
		end

		for iter_8_0, iter_8_1 in pairs((IdolTraineeData:GetCurAttackHero())) do
			if iter_8_1 == true then
				var_8_0 = iter_8_0
			end
		end

		if var_8_0 then
			if self.pvpBattle_ then
				self.selectOpponentPage_:ShowPage(true)
				SetActive(self.maskImg_.gameObject, true)
			elseif self.stageID_ then
				BackHomeCricketAction:AskPvEBattleData(self.stageID_)
			end
		end
	end)
	self:AddBtnListener(self.heroBtn, nil, function()
		self.selectHeroPage_:ShowPage(true)
		SetActive(self.maskImg_.gameObject, true)
	end)
end

function IdolTraineeEnterBattleView:RefreshBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if self.selectOpponentPage_.showFlag then
			self.selectOpponentPage_:ShowPage(false)

			if not self.selectHeroPage_.showFlag then
				SetActive(self.maskImg_.gameObject, false)
			end

			return
		end

		if self.selectHeroPage_.showFlag then
			self.selectHeroPage_:ShowPage(false)
			SetActive(self.maskImg_.gameObject, false)

			self.selectHeroPage_.curHeroID_ = nil

			self.showHistoryController:SetSelectedState("open")

			if self.pvpBattle_ then
				self.showHistoryController:SetSelectedState("open")
			else
				self.showHistoryController:SetSelectedState("close")
			end

			return
		end

		IdolTraineeCampBridge.SetVCamActive("CamShootAtTrainningPos", false)
		self:Back()
	end)
	manager.windowBar:RegistHomeCallBack(function()
		self.selectOpponentPage_:ShowPage(false)
		SetActive(self.maskImg_.gameObject, false)
		self.selectHeroPage_:ShowPage(false)

		self.selectHeroPage_.curHeroID_ = nil

		IdolTraineeCampBridge.SetVCamActive("CamShootAtTrainningPos", false)
		JumpTools.OpenPageByJump("/idolTraineeCamp")
	end)
end

function IdolTraineeEnterBattleView:OnEnter()
	IdolTraineeCampBridge.SetVCamActive("CamShootAtTrainningPos", true)
	self:RefreshBar()

	self.pvpBattle_ = self.params_.pvpBattle
	self.stageID_ = self.params_.stageID

	if self.pvpBattle_ then
		self.stageID_ = IdolTraineeData:GetCurPVPStage()

		self.showHistoryController:SetSelectedState("open")
	else
		self.showHistoryController:SetSelectedState("close")
	end

	self.stageInfoPage:SetParams(self.params_)
	self.stageInfoPage:OnEnter()
	self.selectHeroPage_:OnEnter()
	self.selectHeroPage_:RefreshUI()
	self.selectOpponentPage_:OnEnter()
end

function IdolTraineeEnterBattleView:StopWaitCamBlend()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

function IdolTraineeEnterBattleView:OnExit()
	manager.windowBar:HideBar()
	self.selectHeroPage_:OnExit()
	self.selectOpponentPage_:OnExit()
	self:StopWaitCamBlend()
end

function IdolTraineeEnterBattleView:OnIdolPvpStageUpdateFromServer()
	if self.pvpBattle_ and self.stageInfoPage then
		self.stageID_ = IdolTraineeData:GetCurPVPStage()

		self.stageInfoPage:OnIdolPvpStageUpdateFromServer()
	end
end

function IdolTraineeEnterBattleView:Dispose()
	self:StopWaitCamBlend()
	self.selectHeroPage_:Dispose()
	self.selectOpponentPage_:Dispose()
	self.stageInfoPage:Dispose()
	IdolTraineeEnterBattleView.super.Dispose(self)
end

function IdolTraineeEnterBattleView:OnTop()
	self.gameObject_.layer = 18
	self.maskImg_.enabled = true
end

function IdolTraineeEnterBattleView:OnBehind()
	self.gameObject_.layer = 5
	self.maskImg_.enabled = false
end

return IdolTraineeEnterBattleView
