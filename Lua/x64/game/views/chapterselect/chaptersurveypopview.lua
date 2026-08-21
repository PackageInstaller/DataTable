local var_0_0 = class("ChapterSurveyPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Operation/QuestionnairePopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.checkController_ = arg_3_0.controllerEx_:GetController("checked")
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.surveyBtn_, nil, function()
		if not SurveyData:GetChapterSurveyUrl(arg_5_0.chapterID_) or SurveyData:GetChapterSurveyUrl(arg_5_0.chapterID_) == "" then
			Debug.LogError("没有问卷链接chapterClientID_:" .. arg_5_0.chapterID_)

			return
		end

		if SurveyData:GetChapterSurveyIsFinish(arg_5_0.chapterID_) then
			return
		end

		local var_7_0 = SurveyData:GetChapterSurveyUrl(arg_5_0.chapterID_)
		local var_7_1 = PlayerData:GetPlayerInfo().userID
		local var_7_2 = PlayerData:GetPlayerInfo().signUserId

		LuaForUtil.OpenWebView(var_7_0 .. var_7_1 .. "_" .. var_7_2, true)
	end)
	arg_5_0:AddBtnListener(arg_5_0.chapterBtn_, nil, function()
		local var_8_0 = {}

		if not BattleStageData:GetDiscussUrl(arg_5_0.chapterID_) or BattleStageData:GetDiscussUrl(arg_5_0.chapterID_) == "" then
			Debug.LogError("没有讨论链接chapterClientID_:" .. arg_5_0.chapterID_)

			return
		end

		if _G.ChannelLoginInfo.channelAppId and _G.ChannelLoginInfo.channelToken then
			var_8_0.userId = PlayerData:GetPlayerInfo().userID
			var_8_0.signUserId = PlayerData:GetPlayerInfo().signUserId
			var_8_0.gameAppId = _G.ChannelLoginInfo.channelAppId
			var_8_0.token = _G.ChannelLoginInfo.channelToken
		end

		OperationAction.OpenOperationUrl(BattleStageData:GetDiscussKey(arg_5_0.chapterID_), var_8_0)
	end)
	arg_5_0:AddBtnListener(arg_5_0.questionBtn_, nil, function()
		local var_9_0 = {}

		if not BattleStageData:GetQuestionUrl(arg_5_0.chapterID_) or BattleStageData:GetQuestionUrl(arg_5_0.chapterID_) == "" then
			Debug.LogError("没有答疑链接chapterClientID_:" .. arg_5_0.chapterID_)

			return
		end

		if _G.ChannelLoginInfo.channelAppId and _G.ChannelLoginInfo.channelToken then
			var_9_0.userId = PlayerData:GetPlayerInfo().userID
			var_9_0.signUserId = PlayerData:GetPlayerInfo().signUserId
			var_9_0.gameAppId = _G.ChannelLoginInfo.channelAppId
			var_9_0.token = _G.ChannelLoginInfo.channelToken
		end

		OperationAction.OpenOperationUrl(BattleStageData:GetQuestionKey(arg_5_0.chapterID_), var_9_0)
	end)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.chapterID_ = arg_10_0.params_.chapterID

	arg_10_0:RefreshUI()
	SetActive(arg_10_0.chapterBtn_.gameObject, BattleStageData:GetDiscussUrl(arg_10_0.chapterID_) and BattleStageData:GetDiscussUrl(arg_10_0.chapterID_) ~= "" and _G.CHANNEL_MASTER_ID == 1)
	SetActive(arg_10_0.questionBtn_.gameObject, BattleStageData:GetQuestionUrl(arg_10_0.chapterID_) and BattleStageData:GetQuestionUrl(arg_10_0.chapterID_) ~= "" and _G.CHANNEL_MASTER_ID == 1)
end

function var_0_0.RefreshUI(arg_11_0)
	local var_11_0 = ChapterClientCfg[arg_11_0.chapterID_]
	local var_11_1 = SpritePathCfg.ChapterPaint.path .. var_11_0.chapter_paint

	SetSpriteWithoutAtlasAsync(arg_11_0.bgImg_, var_11_1)

	arg_11_0.descText_.text = GetTips("STORY_PLATFORM_SURVEY_DESCRIPTION")

	arg_11_0.checkController_:SetSelectedState(tostring(SurveyData:GetChapterSurveyIsFinish(arg_11_0.chapterID_)))
end

function var_0_0.OnFinishSurvey(arg_12_0)
	arg_12_0:RefreshUI()
end

function var_0_0.Dispose(arg_13_0)
	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
