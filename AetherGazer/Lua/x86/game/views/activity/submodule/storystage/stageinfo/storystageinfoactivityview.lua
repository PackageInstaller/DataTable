SectionInfoBaseView = import("game.views.sectionInfo.SectionInfoBaseView")

local var_0_0 = class("SotryStageInfoActivityView", SectionInfoBaseView)

function var_0_0.InitUI(arg_1_0)
	var_0_0.super.InitUI(arg_1_0)
	SetActive(arg_1_0.tipsPanel_, true)

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "name")

	arg_1_0.controller_:SetSelectedState("activity")

	if arg_1_0.readyTxt_ then
		arg_1_0.readyTxt_.text = GetTips("BATTLE_READY_1")
	end
end

function var_0_0.OnClickBtn(arg_2_0)
	local var_2_0 = arg_2_0.stageID_
	local var_2_1 = BattleStageTools.GetStageCfg(arg_2_0.stageType_, arg_2_0.stageID_)
	local var_2_2 = ActivityStoryChapterCfg[arg_2_0.params_.chapterID].activity_id

	if BattleConst.BATTLE_TAG.STORY == var_2_1.tag then
		BattleController.GetInstance():LaunchStoryBattle(arg_2_0.stageType_, arg_2_0.stageID_, var_2_2)
	else
		arg_2_0:Go("/sectionSelectHero", {
			section = var_2_0,
			sectionType = arg_2_0.stageType_,
			activityID = var_2_2
		})
	end
end

function var_0_0.RefreshData(arg_3_0)
	var_0_0.super.RefreshData(arg_3_0)

	local var_3_0 = BattleStageTools.GetStageCfg(arg_3_0.stageType_, arg_3_0.stageID_)

	arg_3_0.lock_ = PlayerData:GetPlayerInfo().userLevel < var_3_0.level
	arg_3_0.lockTips_ = string.format(GetTips("PLAYER_LEVEL_UNLOCK"), var_3_0.level)
	arg_3_0.drop_lib_id = var_3_0.drop_lib_id_list[1]
	arg_3_0.isFirstClear_ = StoryStageActivityData:GetStageData(arg_3_0.params_.chapterID)[arg_3_0.stageID_].clear_times <= 0
	arg_3_0.cost = var_3_0.cost or 0
end

function var_0_0.RefreshStageInfo(arg_4_0)
	local var_4_0 = BattleStageTools.GetStageCfg(arg_4_0.stageType_, arg_4_0.stageID_)

	if arg_4_0.oldCfgID_ ~= var_4_0.id then
		arg_4_0.sectionName_.text = GetI18NText(var_4_0.name)
		arg_4_0.sectionImage_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, var_4_0.background_1))
		arg_4_0.textStory_.text = GetI18NText(var_4_0.tips)
		arg_4_0.oldCfgID_ = var_4_0.id
	end
end

return var_0_0
