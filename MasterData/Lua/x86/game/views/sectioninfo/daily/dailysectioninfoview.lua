local DailySectionInfoView = class("DailySectionInfoView", import("..SectionInfoMultipleBaseView"))

function DailySectionInfoView:Init()
	DailySectionInfoView.super.Init(self)
	self.hideStageDescController_:SetSelectedState("false")
	self.hideDropPanelController_:SetSelectedState("false")
end

function DailySectionInfoView:OnClickBtn()
	self:Go("/sectionSelectHero", {
		section = self.stageID_,
		multiple = self.multiple_,
		sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_DAILY
	})
end

function DailySectionInfoView:RefreshData()
	self.cost_ = BattleDailyStageCfg[self.stageID_].cost
	self.dropLibID_ = BattleDailyStageCfg[self.stageID_].drop_lib_id
	self.isFirstClear_ = false

	self:RefreshLock()
	DailySectionInfoView.super.RefreshData(self)
end

function DailySectionInfoView:RefreshLock()
	local var_4_0 = BattleDailyStageCfg[self.stageID_]

	BattleFieldData:SetCacheStage(getChapterAndSectionID(self.stageID_), self.stageID_)

	self.lock_ = PlayerData:GetPlayerInfo().userLevel < var_4_0.level
	self.lockTips_ = string.format(GetTips("PLAYER_LEVEL_UNLOCK"), var_4_0.level)

	if self.lock_ then
		return
	end

	local var_4_1 = BattleStageData:GetStageData()

	for iter_4_0, iter_4_1 in pairs(var_4_0.pre_unlock_id_list or {}) do
		if var_4_1[iter_4_1] == nil or var_4_1[iter_4_1] and var_4_1[iter_4_1].clear_times <= 0 then
			self.lock_ = true

			local var_4_2, var_4_3 = BattleStageTools.GetChapterSectionIndex(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_DAILY, iter_4_1)

			self.lockTips_ = string.format(GetTips("ACTIVITY_RACE_UNLOCK"), string.format("%s-%s", GetI18NText(var_4_2), GetI18NText(var_4_3)))

			return
		end
	end

	self.lock_ = false
end

function DailySectionInfoView:RefreshStageInfo()
	DailySectionInfoView.super.RefreshStageInfo(self)

	self.storyText_.text = GetI18NText(BattleStageTools.GetStageCfg(self.stageType_, self.stageID_).tips)
end

return DailySectionInfoView
