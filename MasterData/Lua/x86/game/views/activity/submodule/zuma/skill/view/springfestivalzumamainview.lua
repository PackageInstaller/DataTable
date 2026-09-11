local SpringFestivalZumaMainView = class("SpringFestivalZumaMainView", (import("game.views.activity.Submodule.Zuma.Normal.View.ZumaMainView")))

function SpringFestivalZumaMainView:UIName()
	return "Widget/Version/CORGUI_3_11/SandPlay_3_11/SandPlay_3_11_Zuma/SandPlay_3_11_ZumaMainUI"
end

function SpringFestivalZumaMainView:InitData()
	self.difficultList = {
		ZumaConst.ZUMA_DIFFICULT.ESAY,
		ZumaConst.ZUMA_DIFFICULT.HARD,
		ZumaConst.ZUMA_DIFFICULT.ENDLESS
	}
	self.chapterCalss = SpringFestivalZumaMainViewChapterInfo
end

function SpringFestivalZumaMainView:InitUI()
	SpringFestivalZumaMainView.super.InitUI(self)

	self.talentInfo = SpringFestivalZumaTalentInfoView.New(self.talentInfoObj_)
	self.titleTxt_.text = GetI18NText(ActivityCfg[ActivityConst.ACTIVITY_3_11_ZUMA].remark)
end

function SpringFestivalZumaMainView:AddUIListener()
	self:AddBtnListener(self.easyBtn_, nil, function()
		if self.chapterInfoView.isShow == true then
			return
		end

		self:OnClickStageDifficultChangeBtn(ZumaConst.ZUMA_DIFFICULT.ESAY)
	end)
	self:AddBtnListener(self.hardBtn_, nil, function()
		if self.chapterInfoView.isShow == true then
			return
		end

		self:OnClickStageDifficultChangeBtn(ZumaConst.ZUMA_DIFFICULT.HARD)
	end)
	self:AddBtnListener(self.nightmareBtn_, nil, function()
		if self.chapterInfoView.isShow == true then
			return
		end

		self:OnClickStageDifficultChangeBtn(ZumaConst.ZUMA_DIFFICULT.ENDLESS)
	end)
	self:AddBtnListener(self.taskBtn_, nil, function()
		TaskTools:ShowActivityTaskPop(ZumaData:GetZumaActivityID(), "Widget/Version/CORGUI_SandPlay_Com/SandPlay_Com/SandPlay_Com_rewardPopUI")
	end)
	self:AddBtnListener(self.talentBtn_, nil, function()
		JumpTools.OpenPageByJump("/springFestivalZumaTalentView")
	end)
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:RefreshZumaChapterInfo()
	end)
	self:AddBtnListener(self.mask1Btn_, nil, function()
		self:RefreshZumaChapterInfo()
	end)
	self:AddBtnListener(self.mask2Btn_, nil, function()
		self:RefreshZumaChapterInfo()
	end)
	self:AddBtnListener(self.btnrankingBtn_, nil, function()
		self:OnClickRankBtn()
	end)
	self:RegistEventListener(ACTIVITY_UPDATE, function(arg_14_0)
		local var_14_0 = ActivityTools.GetActivityType(arg_14_0)

		if var_14_0 == ActivityTemplateConst.ACTIVITY_ZUMA_ENTER or var_14_0 == ActivityTemplateConst.ACTIVITY_ZUMA then
			self:UpdateStageList()
			self.chapterInfoView:UpdateBtnController()
		end
	end)
end

function SpringFestivalZumaMainView:UpdateZumaSkillInfoView(arg_15_1, arg_15_2)
	if arg_15_2 and not self.talentInfo:CheckIsShow() then
		return false
	end

	if arg_15_1 then
		self.talentInfo:RefreshTalentInfoUI(arg_15_1, true)
	else
		self.talentInfo:Show(false)
	end
end

function SpringFestivalZumaMainView:OnClickRankBtn()
	local var_16_0 = {}

	var_16_0.rank_activity_id = 312881

	JumpTools.OpenPageByJump("/springFestivalZumaRankView", var_16_0)
end

function SpringFestivalZumaMainView:RefreshZumaChapterInfo(arg_17_1)
	if self.talentInfo:CheckIsShow() then
		self.talentInfo:Show(false)

		return
	end

	if self:CheckIsEndless() then
		if not arg_17_1 then
			self.stageInfoViewList[self.selectDifficultType]:ChangeSelectState(false)
		else
			self.stageInfoViewList[self.selectDifficultType]:ChangeSelectState(true)
		end
	end

	SpringFestivalZumaMainView.super.RefreshZumaChapterInfo(self, arg_17_1)
end

function SpringFestivalZumaMainView:OnEnter()
	self:UpdateStageList()
	self:DefaultSelectChapter()
	self:ShowDiffcultRed(true)
	manager.redPoint:bindUIandKey(self.taskBtn_.transform, RedPointConst.ZUMA_REWARD)
	manager.redPoint:bindUIandKey(self.talentBtn_.transform, RedPointConst.ZUMA_TALENT)
	self:RefreshTime()
	self.chapterInfoView:OnEnter()

	self.tipsTimer_ = nil
	self.tipsTimer_ = Timer.New(function()
		if GuideData:IsFinish(116) then
			if not getData("SandPlayZumaGame", "showHelp") then
				JumpTools.OpenPageByJump("gameHelpPro", {
					isPrefab = true,
					pages = (GameSetting.activity_zuma_describe or nil) and (GameSetting.activity_zuma_describe.value or {})
				})
				saveData("SandPlayZumaGame", "showHelp", 1)
			end

			self.tipsTimer_:Stop()

			self.tipsTimer_ = nil
		end
	end, 0.1, -1)

	self.tipsTimer_:Start()
end

function SpringFestivalZumaMainView:Dispose()
	SpringFestivalZumaMainView.super.Dispose(self)

	if self.talentInfo then
		self.talentInfo:Dispose()

		self.talentInfo = nil
	end

	if self.tipsTimer_ then
		self.tipsTimer_:Stop()

		self.tipsTimer_ = nil
	end
end

return SpringFestivalZumaMainView
