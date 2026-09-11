local ZumaMainView = class("ZumaMainView", ReduxView)
local var_0_1 = {
	tabState = {
		hard = "state1",
		name = "tab",
		endless = "state2",
		night = "state2",
		easy = "state0"
	},
	tabLockState = {
		onlyNightLock = "state1",
		name = "lock",
		onlyEasyOpen = "state2",
		allOpen = "state0"
	},
	rankShow = {
		noData = "state0",
		name = "ranking",
		showData = "state1"
	}
}

function ZumaMainView:UIName()
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ZumaUI/NorseUI_3_0_ZumaUI"
end

function ZumaMainView:UIParent()
	return manager.ui.uiMain.transform
end

function ZumaMainView:InitData()
	self.difficultList = {
		ZumaConst.ZUMA_DIFFICULT.ESAY,
		ZumaConst.ZUMA_DIFFICULT.HARD,
		ZumaConst.ZUMA_DIFFICULT.NIGHT
	}
	self.chapterCalss = ZumaMainViewChapterInfo
end

function ZumaMainView:Init()
	self:InitData()
	self:InitUI()
	self:AddUIListener()
end

function ZumaMainView:InitUI()
	self:BindCfgUI()

	self.leftRootTrsCanvas = self.leftRootTrs_:GetComponent(typeof(CanvasGroup))
	self.tabStateController = self.controllerexcollection_:GetController(var_0_1.tabState.name)
	self.tabLockStateController = self.controllerexcollection_:GetController(var_0_1.tabLockState.name)
	self.rankShowController = self.controllerexcollection_:GetController(var_0_1.rankShow.name)
	self.chapterInfoView = self.chapterCalss.New(self.chaptersectioninfouiGo_)

	self.chapterInfoView:IsShowPanel(false)

	self.stageInfoViewList = {}

	for iter_5_0, iter_5_1 in ipairs(self.difficultList) do
		self.stageInfoViewList[iter_5_1] = iter_5_1 == ZumaConst.ZUMA_DIFFICULT.ENDLESS and SpringFestivalZumaEndlessStageInfoView.New(self[ZumaConst.ZUMA_DIFFICULT_VIEW_NAME[iter_5_1]], iter_5_1) or ZumaMainStageInfoView.New(self[ZumaConst.ZUMA_DIFFICULT_VIEW_NAME[iter_5_1]], iter_5_1)
	end
end

function ZumaMainView:CheckIsEndless()
	if self.selectDifficultType and self.selectDifficultType == ZumaConst.ZUMA_DIFFICULT.ENDLESS then
		return true
	end

	return false
end

function ZumaMainView:AddUIListener()
	self:AddBtnListener(self.easyBtn_, nil, function()
		self:OnClickStageDifficultChangeBtn(ZumaConst.ZUMA_DIFFICULT.ESAY)
	end)
	self:AddBtnListener(self.hardBtn_, nil, function()
		self:OnClickStageDifficultChangeBtn(ZumaConst.ZUMA_DIFFICULT.HARD)
	end)

	if self.nightmareBtn_ then
		self:AddBtnListener(self.nightmareBtn_, nil, function()
			self:OnClickStageDifficultChangeBtn(ZumaConst.ZUMA_DIFFICULT.NIGHT)
		end)
	end

	self:AddBtnListener(self.taskBtn_, nil, function()
		JumpTools.OpenPageByJump("ZumaTask")
	end)
	self:AddBtnListener(self.talentBtn_, nil, function()
		JumpTools.OpenPageByJump("/ZumaTalent")
	end)
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:RefreshZumaChapterInfo()
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:RefreshZumaChapterInfo()
	end)
	self:AddBtnListener(self.btnrankingBtn_, nil, function()
		self:OnClickRankBtn()
	end)
	self:RegistEventListener(ACTIVITY_UPDATE, function(arg_16_0)
		local var_16_0 = ActivityTools.GetActivityType(arg_16_0)

		if var_16_0 == ActivityTemplateConst.ACTIVITY_ZUMA_ENTER or var_16_0 == ActivityTemplateConst.ACTIVITY_ZUMA then
			self:UpdateStageList()
			self.chapterInfoView:UpdateBtnController()
		end
	end)
end

function ZumaMainView:OnClickRankBtn()
	local var_17_0 = {}

	var_17_0.rank_activity_id = 242881

	JumpTools.OpenPageByJump("/ZumaRank", var_17_0)
end

function ZumaMainView:OnClickStageDifficultChangeBtn(arg_18_1)
	if self.selectDifficultType == arg_18_1 then
		return
	end

	local var_18_0

	if arg_18_1 == ZumaConst.ZUMA_DIFFICULT.ESAY then
		var_18_0 = var_0_1.tabState.easy
	elseif arg_18_1 == ZumaConst.ZUMA_DIFFICULT.HARD then
		var_18_0 = var_0_1.tabState.hard
	elseif arg_18_1 == ZumaConst.ZUMA_DIFFICULT.NIGHT then
		var_18_0 = var_0_1.tabState.night
	elseif arg_18_1 == ZumaConst.ZUMA_DIFFICULT.ENDLESS then
		var_18_0 = var_0_1.tabState.endless
	end

	self.tabStateController:SetSelectedState(var_18_0)

	self.selectDifficultType = arg_18_1

	if self.selectDifficultType == ZumaConst.ZUMA_DIFFICULT.NIGHT or self.selectDifficultType == ZumaConst.ZUMA_DIFFICULT.ENDLESS then
		local var_18_1 = self.stageInfoViewList[arg_18_1]:GetAllScore()

		if var_18_1 == 0 then
			self.rankShowController:SetSelectedState(var_0_1.rankShow.noData)
		else
			self.rankShowController:SetSelectedState(var_0_1.rankShow.showData)
		end

		self.numText_.text = var_18_1
	end

	if arg_18_1 == ZumaConst.ZUMA_DIFFICULT.ENDLESS then
		ZumaData:SetZumaEndless(true)
	else
		ZumaData:SetZumaEndless(false)
	end
end

function ZumaMainView:RefreshZumaChapterInfo(arg_19_1)
	if not arg_19_1 then
		self.chapterInfoView:IsShowPanel(false)

		if self.selectStageItem then
			self.selectStageItem:UpdateSelectState(false)
			self.stageInfoViewList[self.selectDifficultType]:UpdateMoveView()
		end

		self.selectStageItem = nil
		self.leftRootTrsCanvas.blocksRaycasts = true

		return
	end

	self.chapterInfoView:RefreshUI(arg_19_1)

	self.leftRootTrsCanvas.blocksRaycasts = false
end

function ZumaMainView:UpdateZumaStageSelectItem(arg_20_1)
	if self:CheckIsEndless() then
		self:RefreshZumaChapterInfo((self.stageInfoViewList[self.selectDifficultType]:GetLevelCfg()))

		return
	end

	self:SelectStageItem(arg_20_1)
end

function ZumaMainView:SelectStageItem(arg_21_1)
	if self:CheckIsEndless() then
		return
	end

	local var_21_0 = self.stageInfoViewList[self.selectDifficultType]:GetTragetItem(arg_21_1)

	if self.selectStageItem == var_21_0 then
		return
	end

	if self.selectStageItem then
		self.selectStageItem:UpdateSelectState(false)
	end

	self.selectStageItem = var_21_0

	self.selectStageItem:UpdateSelectState(true)
	self:RefreshZumaChapterInfo((self.selectStageItem:GetLevelCfg()))
	self.stageInfoViewList[self.selectDifficultType]:UpdateMoveView(arg_21_1)
end

function ZumaMainView:DefaultSelectChapter()
	if self:CheckIsEndless() then
		return
	end

	if self.selectDifficultType ~= nil then
		return
	end

	local var_22_0 = ZumaData:GetZumaGameId()

	self:OnClickStageDifficultChangeBtn((ActivityZumaLevelCfg[var_22_0] or nil) and (ActivityZumaLevelCfg[var_22_0].difficult or ZumaConst.ZUMA_DIFFICULT.ESAY))
	self.stageInfoViewList[self.selectDifficultType]:DefalutSelect(var_22_0)
	ZumaData:SetZumaGameId(0)
end

function ZumaMainView:UpdateStageList(arg_23_1, arg_23_2)
	if arg_23_1 then
		self.stageInfoViewList[arg_23_1]:RefreshStageUI(arg_23_2)
	else
		for iter_23_0, iter_23_1 in pairs(self.stageInfoViewList) do
			iter_23_1:RefreshStageUI()
		end
	end
end

function ZumaMainView:GetDiffcultBtnRedTrs(arg_24_1)
	local var_24_0

	if arg_24_1 == ZumaConst.ZUMA_DIFFICULT.ESAY then
		var_24_0 = self.easyBtn_.transform
	elseif arg_24_1 == ZumaConst.ZUMA_DIFFICULT.HARD then
		var_24_0 = self.hardBtn_.transform
	elseif arg_24_1 == ZumaConst.ZUMA_DIFFICULT.NIGHT then
		var_24_0 = self.nightmareBtn_.transform
	elseif arg_24_1 == ZumaConst.ZUMA_DIFFICULT.ENDLESS then
		var_24_0 = self.endlessBtn_.transform
	end

	return var_24_0
end

function ZumaMainView:ShowDiffcultRed(arg_25_1)
	for iter_25_0, iter_25_1 in pairs(self.stageInfoViewList) do
		local var_25_0 = iter_25_1:GetDifficultCfgList()

		iter_25_1:SetRedState(arg_25_1)

		for iter_25_2, iter_25_3 in pairs(var_25_0 or {}) do
			local var_25_2 = self:GetDiffcultBtnRedTrs(iter_25_0)

			if arg_25_1 then
				manager.redPoint:bindUIandKey(var_25_2, string.format("%s_%s", RedPointConst.ZUMA_DIFFICULT, iter_25_0))
			else
				manager.redPoint:unbindUIandKey(var_25_2, string.format("%s_%s", RedPointConst.ZUMA_DIFFICULT, iter_25_0))
			end
		end
	end
end

function ZumaMainView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if self.chapterInfoView and self.chapterInfoView.isShow then
			self:RefreshZumaChapterInfo()
		else
			JumpTools.Back()
		end
	end)

	if GameSetting.activity_zuma_describe then
		local var_26_0 = GameSetting.activity_zuma_describe.value or {}
	end

	manager.windowBar:RegistInfoCallBack(function()
		if self.chapterInfoView and self.chapterInfoView.isShow then
			self:RefreshZumaChapterInfo()
		else
			JumpTools.OpenPageByJump("gameHelpPro", {
				isPrefab = true,
				pages = var_26_0
			})
		end
	end)
end

function ZumaMainView:OnEnter()
	self:UpdateStageList()
	self:DefaultSelectChapter()
	self:ShowDiffcultRed(true)
	manager.redPoint:bindUIandKey(self.taskBtn_.transform, RedPointConst.ZUMA_REWARD)
	manager.redPoint:bindUIandKey(self.talentBtn_.transform, RedPointConst.ZUMA_TALENT)
	self:RefreshTime()
	self.chapterInfoView:OnEnter()

	if not getData("ZumaGame", "showHelp") then
		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = (GameSetting.activity_zuma_describe or nil) and (GameSetting.activity_zuma_describe.value or {})
		})
		saveData("ZumaGame", "showHelp", 1)
	end
end

function ZumaMainView:RefreshTime()
	self.activityData_ = ActivityData:GetActivityData(ZumaData:GetZumaActivityID())
	self.startTime_ = self.activityData_.startTime
	self.stopTime_ = self.activityData_.stopTime
	self.timeLable_.text = manager.time:GetLostTimeStrWith2Unit(self.stopTime_, true)
	self.timer_ = Timer.New(function()
		self.timeLable_.text = manager.time:GetLostTimeStrWith2Unit(self.stopTime_, true)
		self.stopTime_ = self.stopTime_ - 1
	end, 1, -1)

	self.timer_:Start()
end

function ZumaMainView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ZumaMainView:OnExit()
	self:RefreshZumaChapterInfo()
	manager.windowBar:HideBar()
	self:StopTimer()
	self:ShowDiffcultRed(false)
	self.chapterInfoView:OnExit()
	manager.redPoint:unbindUIandKey(self.taskBtn_.transform, RedPointConst.ZUMA_REWARD)
	manager.redPoint:unbindUIandKey(self.talentBtn_.transform, RedPointConst.ZUMA_TALENT)
end

function ZumaMainView:Dispose()
	for iter_34_0, iter_34_1 in pairs(self.stageInfoViewList) do
		iter_34_1:Dispose()
	end

	ZumaMainView.super.Dispose(self)
	self.chapterInfoView:Dispose()
end

return ZumaMainView
