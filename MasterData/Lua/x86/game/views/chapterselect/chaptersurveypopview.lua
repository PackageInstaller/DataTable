local ChapterSurveyPopView = class("ChapterSurveyPopView", ReduxView)

function ChapterSurveyPopView:UIName()
	return "Widget/System/Operation/QuestionnairePopUI"
end

function ChapterSurveyPopView:UIParent()
	return manager.ui.uiPop.transform
end

function ChapterSurveyPopView:Init()
	self:InitUI()
	self:AddUIListener()

	self.checkController_ = self.controllerEx_:GetController("checked")
end

function ChapterSurveyPopView:InitUI()
	self:BindCfgUI()
end

function ChapterSurveyPopView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.surveyBtn_, nil, function()
		if not SurveyData:GetChapterSurveyUrl(self.chapterID_) or SurveyData:GetChapterSurveyUrl(self.chapterID_) == "" then
			Debug.LogError("没有问卷链接chapterClientID_:" .. self.chapterID_)

			return
		end

		if SurveyData:GetChapterSurveyIsFinish(self.chapterID_) then
			return
		end

		LuaForUtil.OpenWebView(SurveyData:GetChapterSurveyUrl(self.chapterID_) .. PlayerData:GetPlayerInfo().userID .. "_" .. PlayerData:GetPlayerInfo().signUserId, true)
	end)
	self:AddBtnListener(self.chapterBtn_, nil, function()
		local var_8_0 = {}

		if not BattleStageData:GetDiscussUrl(self.chapterID_) or BattleStageData:GetDiscussUrl(self.chapterID_) == "" then
			Debug.LogError("没有讨论链接chapterClientID_:" .. self.chapterID_)

			return
		end

		if _G.ChannelLoginInfo.channelAppId and _G.ChannelLoginInfo.channelToken then
			var_8_0.userId = PlayerData:GetPlayerInfo().userID
			var_8_0.signUserId = PlayerData:GetPlayerInfo().signUserId
			var_8_0.gameAppId = _G.ChannelLoginInfo.channelAppId
			var_8_0.token = _G.ChannelLoginInfo.channelToken
		end

		OperationAction.OpenOperationUrl(BattleStageData:GetDiscussKey(self.chapterID_), var_8_0)
	end)
	self:AddBtnListener(self.questionBtn_, nil, function()
		local var_9_0 = {}

		if not BattleStageData:GetQuestionUrl(self.chapterID_) or BattleStageData:GetQuestionUrl(self.chapterID_) == "" then
			Debug.LogError("没有答疑链接chapterClientID_:" .. self.chapterID_)

			return
		end

		if _G.ChannelLoginInfo.channelAppId and _G.ChannelLoginInfo.channelToken then
			var_9_0.userId = PlayerData:GetPlayerInfo().userID
			var_9_0.signUserId = PlayerData:GetPlayerInfo().signUserId
			var_9_0.gameAppId = _G.ChannelLoginInfo.channelAppId
			var_9_0.token = _G.ChannelLoginInfo.channelToken
		end

		OperationAction.OpenOperationUrl(BattleStageData:GetQuestionKey(self.chapterID_), var_9_0)
	end)
end

function ChapterSurveyPopView:OnEnter()
	self.chapterID_ = self.params_.chapterID

	self:RefreshUI()
	SetActive(self.chapterBtn_.gameObject, BattleStageData:GetDiscussUrl(self.chapterID_) and BattleStageData:GetDiscussUrl(self.chapterID_) ~= "" and _G.CHANNEL_MASTER_ID == 1)
	SetActive(self.questionBtn_.gameObject, BattleStageData:GetQuestionUrl(self.chapterID_) and BattleStageData:GetQuestionUrl(self.chapterID_) ~= "" and _G.CHANNEL_MASTER_ID == 1)
end

function ChapterSurveyPopView:RefreshUI()
	SetSpriteWithoutAtlasAsync(self.bgImg_, SpritePathCfg.ChapterPaint.path .. ChapterClientCfg[self.chapterID_].chapter_paint)

	self.descText_.text = GetTips("STORY_PLATFORM_SURVEY_DESCRIPTION")

	self.checkController_:SetSelectedState(tostring(SurveyData:GetChapterSurveyIsFinish(self.chapterID_)))
end

function ChapterSurveyPopView:OnFinishSurvey()
	self:RefreshUI()
end

function ChapterSurveyPopView:Dispose()
	ChapterSurveyPopView.super.Dispose(self)
end

return ChapterSurveyPopView
