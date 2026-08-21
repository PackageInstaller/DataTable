local var_0_0 = import("game.views.sectionInfo.SectionInfoBaseView")
local var_0_1 = class("ActivityHeroEnhanceSectionInfoView", var_0_0)

function var_0_1.Init(arg_1_0)
	var_0_1.super.Init(arg_1_0)

	arg_1_0.sectionInfoThreeStarBar_ = SectionInfoThreeStarBar.New(arg_1_0.threeStarGo_)

	arg_1_0.hideThreeStarController_:SetSelectedState("false")
	arg_1_0.hideStageDescController_:SetSelectedState("false")
	arg_1_0.btnWebController_:SetSelectedState("notshow")
	arg_1_0.hideFatigueController_:SetSelectedState("close")
end

function var_0_1.OnClickBtn(arg_2_0)
	local var_2_0 = ActivityHeroEnhanceCfg[arg_2_0.params_.heroEnhance_CfgID]
	local var_2_1 = ActivityHeroEnhanceTools.GetCfgTalentList(var_2_0)
	local var_2_2 = {}

	for iter_2_0, iter_2_1 in ipairs(var_2_1) do
		var_2_2[TalentTreeCfg[iter_2_1].stage] = iter_2_1
	end

	local var_2_3
	local var_2_4 = ActivityHeroEnhanceTools.GetCfgTalentMaxStage(var_2_0)

	for iter_2_2 = 1, var_2_4 do
		if not var_2_2[iter_2_2] and not ActivityHeroEnhanceTools.IsCfgTalentStageLock(var_2_0, iter_2_2) then
			local var_2_5 = iter_2_2

			break
		end
	end

	arg_2_0:GoBattle()
end

function var_0_1.GoBattle(arg_3_0)
	local var_3_0 = arg_3_0.stageID_
	local var_3_1 = BattleStageTools.GetStageCfg(arg_3_0.stageType_, var_3_0)
	local var_3_2 = arg_3_0.params_.activityID

	gameContext:Go("/sectionSelectHero", {
		section = var_3_0,
		sectionType = arg_3_0.stageType_,
		activityID = var_3_2,
		heroEnhance_CfgID = arg_3_0.params_.heroEnhance_CfgID
	})
end

function var_0_1.RefreshData(arg_4_0)
	var_0_1.super.RefreshData(arg_4_0)

	local var_4_0 = BattleStageTools.GetStageCfg(arg_4_0.stageType_, arg_4_0.stageID_)
	local var_4_1 = ActivityHeroEnhanceCfg[arg_4_0.params_.heroEnhance_CfgID]

	arg_4_0.lock_ = not ActivityHeroEnhanceTools.IsCfgStageUnlock(var_4_1, arg_4_0.stageID_)
	arg_4_0.lockTips_ = GetTips("ERROR_STAGE_NOT_CLEAR")
	arg_4_0.dropLibID_ = var_4_0.drop_lib_id

	local var_4_2 = ActivityHeroEnhanceData:IsStageClear(arg_4_0.params_.activityID, arg_4_0.stageID_)

	arg_4_0.isFirstClear_ = not var_4_2
	arg_4_0.cost = 0
	arg_4_0.threeStarDataList_ = {
		{
			var_4_2,
			{
				8
			}
		},
		{
			false
		},
		{
			false
		}
	}
end

function var_0_1.RefreshStageInfo(arg_5_0)
	local var_5_0 = BattleStageTools.GetStageCfg(arg_5_0.stageType_, arg_5_0.stageID_)

	arg_5_0.sectionName_.text = GetI18NText(var_5_0.name)
	arg_5_0.storyText_.text = GetI18NText(var_5_0.tips)
end

function var_0_1.RefreshUI(arg_6_0)
	var_0_1.super.RefreshUI(arg_6_0)
	arg_6_0.sectionInfoThreeStarBar_:SetData(arg_6_0.threeStarDataList_)
end

function var_0_1.Dispose(arg_7_0)
	arg_7_0.sectionInfoThreeStarBar_:Dispose()

	arg_7_0.sectionInfoThreeStarBar_ = nil

	var_0_1.super.Dispose(arg_7_0)
end

return var_0_1
