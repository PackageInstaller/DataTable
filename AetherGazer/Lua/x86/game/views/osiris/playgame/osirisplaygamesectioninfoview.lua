local var_0_0 = import("game.views.sectionInfo.SectionInfoBaseView")
local var_0_1 = class("OsirisPlayGameSectionInfoView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/System/Activity_Osiris/Activity_Osiris_ChapterSectionInfoUI"
end

function var_0_1.Init(arg_2_0)
	var_0_1.super.Init(arg_2_0)
end

function var_0_1.OnEnter(arg_3_0)
	arg_3_0.stageID_ = arg_3_0.params_.section
	arg_3_0.stageType_ = arg_3_0.params_.sectionType or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_UNDEFINED

	manager.notify:RegistListener(CURRENCY_UPDATE, arg_3_0.currencyUpdateHandle_)
	arg_3_0:RefreshData()
	arg_3_0:RefreshUI()
	arg_3_0:RefreshTitleDesc()
	arg_3_0:UpdateBar()

	arg_3_0.backCall = arg_3_0.params_.backCall
end

function var_0_1.OnClickBtn(arg_4_0)
	local var_4_0 = ActivityGeneralityStageCfg[arg_4_0.stageID_].stage_id

	JumpTools.OpenPageByJump("/osirisPlayGameSectionSelectHeroView", {
		section = var_4_0,
		sectionType = BattleConst.STAGE_TYPE_NEW.OSIRIS_PLAY_GAME,
		activityID = arg_4_0.params_.activityID_,
		heroDataType = HeroConst.HERO_DATA_TYPE.OSIRISPLAYGAME
	})
end

function var_0_1.RefreshStageInfo(arg_5_0)
	arg_5_0.hideFatigueController_:SetSelectedState("close")

	local var_5_0 = ActivityGeneralityStageCfg[arg_5_0.stageID_].stage_id
	local var_5_1 = BattleStageTools.GetStageCfg(arg_5_0.stageType_, var_5_0)

	if arg_5_0.oldCfgID_ ~= var_5_1.id then
		local var_5_2, var_5_3 = BattleStageTools.GetChapterSectionIndex(arg_5_0.stageType_, arg_5_0.stageID_)

		arg_5_0.sectionText_.text = string.format("%s-%s", GetI18NText(var_5_2), GetI18NText(var_5_3))
		arg_5_0.sectionName_.text = GetI18NText(var_5_1.name)
		arg_5_0.oldCfgID_ = var_5_1.id

		local var_5_4 = ActivityGeneralityStageCfg[arg_5_0.stageID_].generality
		local var_5_5 = ActivityGeneralityTagCfg[var_5_4]

		arg_5_0.titleText_.text = GetI18NText(var_5_5.name)
		arg_5_0.descText_.text = GetI18NText(var_5_5.desc)

		local var_5_6 = OsirisPlayGameData:GetStageInfoById(var_5_0)

		arg_5_0.maxScoreText_.text = var_5_6.point and var_5_6.point or 0
		arg_5_0.typeTagIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_Osiris/" .. var_5_4)
	end
end

function var_0_1.UpdateBar(arg_6_0)
	local var_6_0 = BattleStageTools.GetStageCfg(arg_6_0.stageType_, arg_6_0.stageID_)

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		arg_6_0.backCall()
		JumpTools.Back()
	end)
	manager.windowBar:RegistHomeCallBack(function()
		arg_6_0.backCall()
		gameContext:Go("/home", nil, nil, true)
	end)
end

function var_0_1.OnExit(arg_9_0)
	arg_9_0.super.OnExit(arg_9_0)
	manager.windowBar:HideBar()
end

return var_0_1
