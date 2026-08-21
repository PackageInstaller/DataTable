local var_0_0 = import("game.views.activity.Submodule.Zuma.Normal.View.ZumaMainView")
local var_0_1 = class("SpringFestivalZumaMainView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/Version/CORGUI_3_11/SandPlay_3_11/SandPlay_3_11_Zuma/SandPlay_3_11_ZumaMainUI"
end

function var_0_1.InitData(arg_2_0)
	arg_2_0.difficultList = {
		ZumaConst.ZUMA_DIFFICULT.ESAY,
		ZumaConst.ZUMA_DIFFICULT.HARD,
		ZumaConst.ZUMA_DIFFICULT.ENDLESS
	}
	arg_2_0.chapterCalss = SpringFestivalZumaMainViewChapterInfo
end

function var_0_1.InitUI(arg_3_0)
	var_0_1.super.InitUI(arg_3_0)

	arg_3_0.talentInfo = SpringFestivalZumaTalentInfoView.New(arg_3_0.talentInfoObj_)

	local var_3_0 = ActivityCfg[ActivityConst.ACTIVITY_3_11_ZUMA]

	arg_3_0.titleTxt_.text = GetI18NText(var_3_0.remark)
end

function var_0_1.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.easyBtn_, nil, function()
		if arg_4_0.chapterInfoView.isShow == true then
			return
		end

		arg_4_0:OnClickStageDifficultChangeBtn(ZumaConst.ZUMA_DIFFICULT.ESAY)
	end)
	arg_4_0:AddBtnListener(arg_4_0.hardBtn_, nil, function()
		if arg_4_0.chapterInfoView.isShow == true then
			return
		end

		arg_4_0:OnClickStageDifficultChangeBtn(ZumaConst.ZUMA_DIFFICULT.HARD)
	end)
	arg_4_0:AddBtnListener(arg_4_0.nightmareBtn_, nil, function()
		if arg_4_0.chapterInfoView.isShow == true then
			return
		end

		arg_4_0:OnClickStageDifficultChangeBtn(ZumaConst.ZUMA_DIFFICULT.ENDLESS)
	end)
	arg_4_0:AddBtnListener(arg_4_0.taskBtn_, nil, function()
		TaskTools:ShowActivityTaskPop(ZumaData:GetZumaActivityID(), "Widget/Version/CORGUI_SandPlay_Com/SandPlay_Com/SandPlay_Com_rewardPopUI")
	end)
	arg_4_0:AddBtnListener(arg_4_0.talentBtn_, nil, function()
		JumpTools.OpenPageByJump("/springFestivalZumaTalentView")
	end)
	arg_4_0:AddBtnListener(arg_4_0.bgBtn_, nil, function()
		arg_4_0:RefreshZumaChapterInfo()
	end)
	arg_4_0:AddBtnListener(arg_4_0.mask1Btn_, nil, function()
		arg_4_0:RefreshZumaChapterInfo()
	end)
	arg_4_0:AddBtnListener(arg_4_0.mask2Btn_, nil, function()
		arg_4_0:RefreshZumaChapterInfo()
	end)
	arg_4_0:AddBtnListener(arg_4_0.btnrankingBtn_, nil, function()
		arg_4_0:OnClickRankBtn()
	end)
	arg_4_0:RegistEventListener(ACTIVITY_UPDATE, function(arg_14_0)
		local var_14_0 = ActivityTools.GetActivityType(arg_14_0)

		if var_14_0 == ActivityTemplateConst.ACTIVITY_ZUMA_ENTER or var_14_0 == ActivityTemplateConst.ACTIVITY_ZUMA then
			arg_4_0:UpdateStageList()
			arg_4_0.chapterInfoView:UpdateBtnController()
		end
	end)
end

function var_0_1.UpdateZumaSkillInfoView(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_2 and not arg_15_0.talentInfo:CheckIsShow() then
		return false
	end

	if arg_15_1 then
		arg_15_0.talentInfo:RefreshTalentInfoUI(arg_15_1, true)
	else
		arg_15_0.talentInfo:Show(false)
	end
end

function var_0_1.OnClickRankBtn(arg_16_0)
	local var_16_0 = 312881

	JumpTools.OpenPageByJump("/springFestivalZumaRankView", {
		rank_activity_id = var_16_0
	})
end

function var_0_1.RefreshZumaChapterInfo(arg_17_0, arg_17_1)
	if arg_17_0.talentInfo:CheckIsShow() then
		arg_17_0.talentInfo:Show(false)

		return
	end

	if arg_17_0:CheckIsEndless() then
		if not arg_17_1 then
			arg_17_0.stageInfoViewList[arg_17_0.selectDifficultType]:ChangeSelectState(false)
		else
			arg_17_0.stageInfoViewList[arg_17_0.selectDifficultType]:ChangeSelectState(true)
		end
	end

	var_0_1.super.RefreshZumaChapterInfo(arg_17_0, arg_17_1)
end

function var_0_1.OnEnter(arg_18_0)
	arg_18_0:UpdateStageList()
	arg_18_0:DefaultSelectChapter()
	arg_18_0:ShowDiffcultRed(true)
	manager.redPoint:bindUIandKey(arg_18_0.taskBtn_.transform, RedPointConst.ZUMA_REWARD)
	manager.redPoint:bindUIandKey(arg_18_0.talentBtn_.transform, RedPointConst.ZUMA_TALENT)
	arg_18_0:RefreshTime()
	arg_18_0.chapterInfoView:OnEnter()

	arg_18_0.tipsTimer_ = nil
	arg_18_0.tipsTimer_ = Timer.New(function()
		if GuideData:IsFinish(116) then
			if not getData("SandPlayZumaGame", "showHelp") then
				local var_19_0 = GameSetting.activity_zuma_describe and GameSetting.activity_zuma_describe.value or {}

				JumpTools.OpenPageByJump("gameHelpPro", {
					isPrefab = true,
					pages = var_19_0
				})
				saveData("SandPlayZumaGame", "showHelp", 1)
			end

			arg_18_0.tipsTimer_:Stop()

			arg_18_0.tipsTimer_ = nil
		end
	end, 0.1, -1)

	arg_18_0.tipsTimer_:Start()
end

function var_0_1.Dispose(arg_20_0)
	var_0_1.super.Dispose(arg_20_0)

	if arg_20_0.talentInfo then
		arg_20_0.talentInfo:Dispose()

		arg_20_0.talentInfo = nil
	end

	if arg_20_0.tipsTimer_ then
		arg_20_0.tipsTimer_:Stop()

		arg_20_0.tipsTimer_ = nil
	end
end

return var_0_1
