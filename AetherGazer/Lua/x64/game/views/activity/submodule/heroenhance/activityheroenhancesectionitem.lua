local var_0_0 = import("game.views.sectionSelect.SectionBaseItem")
local var_0_1 = class("ActivityHeroEnhanceSectionItem", var_0_0)

function var_0_1.IsOpenSectionInfo(arg_1_0)
	return arg_1_0:IsOpenRoute("activityHeroEnhanceSectionInfo")
end

function var_0_1.OnCtor(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.gameObject_ = Object.Instantiate(arg_2_1, arg_2_2.transform)
	arg_2_0.transform_ = arg_2_0.gameObject_.transform

	arg_2_0:Init()
end

function var_0_1.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListeners()
end

function var_0_1.InitUI(arg_4_0)
	var_0_1.super.InitUI(arg_4_0)
end

function var_0_1.RefreshStar(arg_5_0)
	local var_5_0 = BattleHeroEnhanceCfg[arg_5_0.stageID_]
	local var_5_1 = ActivityHeroEnhanceData:IsStageClear(arg_5_0.activityId_, arg_5_0.stageID_)

	for iter_5_0 = 1, 3 do
		arg_5_0.threeStarBarList_[iter_5_0]:SetData(var_5_1)
	end
end

function var_0_1.GetTag(arg_6_0)
	local var_6_0 = BattleHeroEnhanceCfg[arg_6_0.stageID_]

	return var_6_0 and var_6_0.tag or 0
end

function var_0_1.GetPosition(arg_7_0)
	local var_7_0 = BattleHeroEnhanceCfg[arg_7_0.stageID_]

	return var_7_0 and var_7_0.position or {
		0,
		0
	}
end

function var_0_1.RefreshData(arg_8_0)
	arg_8_0.enoughLevel_ = true
	arg_8_0.isLock_ = not arg_8_0:IsUnlockPreStage()
end

function var_0_1.IsUnlockPreStage(arg_9_0)
	local var_9_0 = ActivityHeroEnhanceCfg[arg_9_0.cfgId_]

	return ActivityHeroEnhanceTools.IsCfgStageUnlock(var_9_0, arg_9_0.stageID_)
end

function var_0_1.SetData(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = ActivityHeroEnhanceCfg[arg_10_1]

	arg_10_0.cfgId_ = arg_10_1
	arg_10_0.activityId_ = var_10_0.activity_id
	arg_10_0.stageID_ = arg_10_2
	arg_10_0.stageType_ = BattleConst.STAGE_TYPE_NEW.ACTIVITY_HERO_ENHANCE

	arg_10_0:RefreshData()
	arg_10_0:RefreshUI()
end

function var_0_1.SetClickHandler(arg_11_0, arg_11_1)
	arg_11_0.onClickCallback_ = arg_11_1
end

function var_0_1.OnClick(arg_12_0)
	if arg_12_0.onClickCallback_ then
		arg_12_0.onClickCallback_(arg_12_0.stageID_, arg_12_0.isLock_)
	end
end

function var_0_1.RefreshText(arg_13_0)
	local var_13_0 = BattleStageTools.GetStageCfg(arg_13_0.stageType_, arg_13_0.stageID_)

	arg_13_0.text_.text = GetI18NText(var_13_0.name)
end

return var_0_1
