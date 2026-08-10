local var_0_0 = class("MythicSectionInfoView", import("..SectionInfoBaseView"))

function var_0_0.Init(arg_1_0)
	var_0_0.super.Init(arg_1_0)
	arg_1_0.hideStageNumController_:SetSelectedState("true")

	arg_1_0.sectionInfoThreeStarBar_ = SectionInfoThreeStarBar.New(arg_1_0.threeStarGo_)
	arg_1_0.sectionInfoAffixBar_ = SectionInfoAffixBar.New(arg_1_0.affixGo_)
end

function var_0_0.RefreshData(arg_2_0)
	local var_2_0 = BattleMythicStageCfg[arg_2_0.stageID_]

	arg_2_0.lock_ = false
	arg_2_0.lockTips_ = ""
	arg_2_0.cost_ = 0
	arg_2_0.dropLibID_ = {}
	arg_2_0.isFirstClear_ = MythicData:GetIsFirstClear(arg_2_0.partition_)

	arg_2_0:RefreshThreeStarData()
end

function var_0_0.OnEnter(arg_3_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_3_0.partition_ = arg_3_0.params_.partition
	arg_3_0.stageID_ = arg_3_0.params_.stageID

	arg_3_0:RefreshData()
	arg_3_0:RefreshUI()

	arg_3_0.stageType_ = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC

	arg_3_0:RefreshTitleDesc()
end

function var_0_0.OnExit(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.notify:RemoveListener(CURRENCY_UPDATE, arg_4_0.currencyUpdateHandle_)
	SetActive(arg_4_0.debuffAffixBtn_.gameObject, true)
end

function var_0_0.OnUpdate(arg_5_0)
	if arg_5_0.partition_ == arg_5_0.params_.partition and arg_5_0.stageID_ == arg_5_0.params_.stageID then
		return
	end

	arg_5_0.partition_ = arg_5_0.params_.partition
	arg_5_0.stageID_ = arg_5_0.params_.stageID

	arg_5_0:RefreshData()
	arg_5_0:RefreshUI()
end

function var_0_0.RefreshThreeStarData(arg_6_0)
	arg_6_0.threeStarDataList_ = {}

	local var_6_0 = BattleMythicStageCfg[arg_6_0.stageID_]
	local var_6_1 = MythicData:GetStarOpen(arg_6_0.stageID_)

	for iter_6_0 = 1, 3 do
		arg_6_0.threeStarDataList_[iter_6_0] = {
			var_6_1 and var_6_1.stars[iter_6_0] == 1 or false,
			var_6_0.three_star_need[iter_6_0]
		}
	end
end

function var_0_0.RefreshUI(arg_7_0)
	arg_7_0:RefreshStageInfo()
	arg_7_0.hideFatigueController_:SetSelectedState("close")
	arg_7_0.hideBattleAffixController_:SetSelectedState("true")
	arg_7_0.hideAffixController_:SetSelectedState("false")

	if arg_7_0.params_.isMain then
		arg_7_0.hideStageDescController_:SetSelectedState("true")
		arg_7_0.sectionInfoAffixBar_:SetData(arg_7_0.params_.isMain, arg_7_0.params_.affix, GetTips("MYTHIC_CUR_AFFIX"))
		arg_7_0.hideThreeStarController_:SetSelectedState("false")
		arg_7_0.sectionInfoThreeStarBar_:SetData(arg_7_0.threeStarDataList_)
	else
		arg_7_0.hideStageDescController_:SetSelectedState("false")
		arg_7_0.sectionInfoAffixBar_:SetData(arg_7_0.params_.isMain, arg_7_0.params_.affix, GetTips("MYTHIC_LEVEL_UNLOCK_AFFIX"))
		arg_7_0.hideThreeStarController_:SetSelectedState("true")
	end
end

function var_0_0.RefreshStageInfo(arg_8_0)
	local var_8_0 = arg_8_0.stageID_
	local var_8_1 = BattleMythicStageCfg[var_8_0]

	arg_8_0.sectionName_.text = GetI18NText(var_8_1.name)
	arg_8_0.sectionImage_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, var_8_1.background_1))
	arg_8_0.storyText_.text = GetI18NText(var_8_1.tips)
end

function var_0_0.OnClickBtn(arg_9_0)
	local var_9_0 = arg_9_0.stageID_
	local var_9_1 = arg_9_0.partition_
	local var_9_2 = arg_9_0.params_.difficulty

	arg_9_0:Go("/sectionSelectHero", {
		section = var_9_0,
		partition = var_9_1,
		difficulty = var_9_2,
		sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC
	})
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.sectionInfoThreeStarBar_:Dispose()

	arg_10_0.sectionInfoThreeStarBar_ = nil

	arg_10_0.sectionInfoAffixBar_:Dispose()

	arg_10_0.sectionInfoAffixBar_ = nil

	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
