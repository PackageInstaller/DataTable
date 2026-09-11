local ActivityReforgeBattleResultView = class("ActivityReforgeBattleResultView", ReduxView)

function ActivityReforgeBattleResultView:UIName()
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ActivityReforge/NorseUI_3_0_ActivityReforgeBattleResultUI"
end

function ActivityReforgeBattleResultView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityReforgeBattleResultView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityReforgeBattleResultView:InitUI()
	self:BindCfgUI()

	self.timeInfoItem_ = ActivityReforgeBattleResultItem.New(self.timeInfoGo_)
	self.pointInfoItem_ = ActivityReforgeBattleResultItem.New(self.pointInfoGo_)
	self.goldInfoItem_ = ActivityReforgeBattleResultItem.New(self.goldInfoGo_)
	self.controller_ = self.controllerEx_:GetController("levelIndex")
end

function ActivityReforgeBattleResultView:OnEnter()
	self.IsBattleBack_ = self.params_.IsBattleBack
	self.chapterActivityID_ = self.params_.chapterActivityID
	self.levelID_ = self.params_.levelID

	self.controller_:SetSelectedState(table.indexof(ActivityReforgeChapterCfg[self.chapterActivityID_].level_list, self.levelID_))

	self.levelName_.text = ActivityReforgeLevelCfg[self.levelID_].name

	local var_5_0 = ActivityReforgeData:GetCurFinishLevelServerData()
	local var_5_1 = ActivityReforgeData:GetLevelAllPlayerServerData(self.levelID_)

	ActivityReforgeData:FinishLevel(self.chapterActivityID_, self.levelID_, var_5_0)
	self.timeInfoItem_:SetData(1, ActivityReforgeGameSettingCfg[self.params_.activityID].bar_num_min, self.levelID_, var_5_0.minUseSeconds, var_5_1.minUseSeconds.rangeValue, var_5_1.minUseSeconds.rangeLength)
	self.pointInfoItem_:SetData(2, ActivityReforgeGameSettingCfg[self.params_.activityID].bar_num_min, self.levelID_, var_5_0.minLosePoint, var_5_1.minLosePoint.rangeValue, var_5_1.minLosePoint.rangeLength)
	self.goldInfoItem_:SetData(3, ActivityReforgeGameSettingCfg[self.params_.activityID].bar_num_min, self.levelID_, var_5_0.minUseGold, var_5_1.minUseGold.rangeValue, var_5_1.minUseGold.rangeLength)
end

function ActivityReforgeBattleResultView:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		ActivityReforgeData:ClearCurLevelData()

		if self.IsBattleBack_ then
			BattleInstance.QuitBattle(self.params_.stageData)
		else
			JumpTools.OpenPageByJump("/activityReforgeLevelView", {
				activityID = self.params_.activityID,
				chapterActivityID = self.params_.chapterActivityID
			})
		end
	end)
end

function ActivityReforgeBattleResultView:Dispose()
	self.timeInfoItem_:Dispose()
	self.pointInfoItem_:Dispose()
	self.goldInfoItem_:Dispose()

	self.timeInfoItem_ = nil
	self.pointInfoItem_ = nil
	self.goldInfoItem_ = nil

	self.super.Dispose(self)
end

return ActivityReforgeBattleResultView
