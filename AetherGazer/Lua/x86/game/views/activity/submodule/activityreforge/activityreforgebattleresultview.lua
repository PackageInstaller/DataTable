local var_0_0 = class("ActivityReforgeBattleResultView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ActivityReforge/NorseUI_3_0_ActivityReforgeBattleResultUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.timeInfoItem_ = ActivityReforgeBattleResultItem.New(arg_4_0.timeInfoGo_)
	arg_4_0.pointInfoItem_ = ActivityReforgeBattleResultItem.New(arg_4_0.pointInfoGo_)
	arg_4_0.goldInfoItem_ = ActivityReforgeBattleResultItem.New(arg_4_0.goldInfoGo_)
	arg_4_0.controller_ = arg_4_0.controllerEx_:GetController("levelIndex")
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0.IsBattleBack_ = arg_5_0.params_.IsBattleBack
	arg_5_0.chapterActivityID_ = arg_5_0.params_.chapterActivityID
	arg_5_0.levelID_ = arg_5_0.params_.levelID

	local var_5_0 = ActivityReforgeChapterCfg[arg_5_0.chapterActivityID_]

	arg_5_0.controller_:SetSelectedState(table.indexof(var_5_0.level_list, arg_5_0.levelID_))

	arg_5_0.levelName_.text = ActivityReforgeLevelCfg[arg_5_0.levelID_].name

	local var_5_1 = ActivityReforgeGameSettingCfg[arg_5_0.params_.activityID].bar_num_min
	local var_5_2 = ActivityReforgeData:GetCurFinishLevelServerData()
	local var_5_3 = ActivityReforgeData:GetLevelAllPlayerServerData(arg_5_0.levelID_)

	ActivityReforgeData:FinishLevel(arg_5_0.chapterActivityID_, arg_5_0.levelID_, var_5_2)
	arg_5_0.timeInfoItem_:SetData(1, var_5_1, arg_5_0.levelID_, var_5_2.minUseSeconds, var_5_3.minUseSeconds.rangeValue, var_5_3.minUseSeconds.rangeLength)
	arg_5_0.pointInfoItem_:SetData(2, var_5_1, arg_5_0.levelID_, var_5_2.minLosePoint, var_5_3.minLosePoint.rangeValue, var_5_3.minLosePoint.rangeLength)
	arg_5_0.goldInfoItem_:SetData(3, var_5_1, arg_5_0.levelID_, var_5_2.minUseGold, var_5_3.minUseGold.rangeValue, var_5_3.minUseGold.rangeLength)
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.btn_, nil, function()
		ActivityReforgeData:ClearCurLevelData()

		if arg_6_0.IsBattleBack_ then
			BattleInstance.QuitBattle(arg_6_0.params_.stageData)
		else
			JumpTools.OpenPageByJump("/activityReforgeLevelView", {
				activityID = arg_6_0.params_.activityID,
				chapterActivityID = arg_6_0.params_.chapterActivityID
			})
		end
	end)
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0.timeInfoItem_:Dispose()
	arg_8_0.pointInfoItem_:Dispose()
	arg_8_0.goldInfoItem_:Dispose()

	arg_8_0.timeInfoItem_ = nil
	arg_8_0.pointInfoItem_ = nil
	arg_8_0.goldInfoItem_ = nil

	arg_8_0.super.Dispose(arg_8_0)
end

return var_0_0
