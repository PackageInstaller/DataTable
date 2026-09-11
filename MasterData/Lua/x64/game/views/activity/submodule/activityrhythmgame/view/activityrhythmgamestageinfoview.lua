local ActivityRhythmGameStageInfoView = class("ActivityRhythmGameStageInfoView", ReduxView)

function ActivityRhythmGameStageInfoView:UIName()
	return "Widget/System/Summer2024/Summer2024_MuiscUI/SummerUI_3_4_InfoUI"
end

function ActivityRhythmGameStageInfoView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityRhythmGameStageInfoView:OnEnter()
	self:SetData(self.params_.activityID, self.params_.cfgID, self.params_.stageID)
	self:RefreshUI()
end

function ActivityRhythmGameStageInfoView:OnUpdate()
	if self.cfgID_ == self.params_.cfgID then
		return
	end

	self:SetData(self.params_.activityID, self.params_.cfgID, self.params_.stageID)
	self:RefreshUI()
end

function ActivityRhythmGameStageInfoView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
end

function ActivityRhythmGameStageInfoView:OnBehind()
	manager.windowBar:HideBar()
end

function ActivityRhythmGameStageInfoView:Init()
	self:InitOwnData()
	self:BindCfgUI()
	self:BindController()
	self:AddUIListeners()

	self.sectionTargets_ = {}

	for iter_7_0 = 1, 3 do
		self.sectionTargets_[iter_7_0] = ActivityRhythmGameStageInfoStarItem.New(self[string.format("ndnum0%sGo_", iter_7_0)], iter_7_0)
	end

	self.DefaultConditionText_ = self.conditionText_.text
end

function ActivityRhythmGameStageInfoView:Dispose()
	for iter_8_0, iter_8_1 in pairs(self.sectionTargets_) do
		iter_8_1:Dispose()
	end

	self.sectionTargets_ = {}

	ActivityRhythmGameStageInfoView.super.Dispose(self)
end

function ActivityRhythmGameStageInfoView:InitOwnData()
	self.activityID_ = 0
	self.cfgID_ = 0
	self.stageID_ = 0
end

function ActivityRhythmGameStageInfoView:BindController()
	self.lockController_ = self.btnControllerexcollection_:GetController("lock")
end

function ActivityRhythmGameStageInfoView:ChangeLockController(arg_11_1)
	self.lockController_:SetSelectedIndex(arg_11_1)
end

function ActivityRhythmGameStageInfoView:AddUIListeners()
	self:AddBtnListener(nil, self.battleBtn_, function()
		ActivityRhythmGameTools.StartBattle(self.cfgID_, self.stageID_, self.activityID_)
	end)
end

function ActivityRhythmGameStageInfoView:SetData(arg_14_1, arg_14_2, arg_14_3)
	self.activityID_ = arg_14_1
	self.cfgID_ = arg_14_2
	self.stageID_ = arg_14_3
end

function ActivityRhythmGameStageInfoView:RefreshUI()
	SetActive(self.backBtn_, false)
	self:RefreshStarUI()
	self:RefreshTimeUI()
	self:RefreshBtnUI()
	self:RefreshTitleUI()
end

function ActivityRhythmGameStageInfoView:RefreshStarUI()
	local var_16_0 = ActivityRhythmGameData:GetStarsByCfgID(self.cfgID_)
	local var_16_1 = {}

	for iter_16_0 = 1, 3 do
		local var_16_2 = false

		if var_16_0 then
			for iter_16_1, iter_16_2 in pairs(var_16_0) do
				if iter_16_2 == 100 + iter_16_0 then
					var_16_2 = true
				end
			end
		end

		var_16_1[iter_16_0] = {
			var_16_2,
			ActivityRhythmGameCfg[self.cfgID_].three_star_need[iter_16_0]
		}
	end

	for iter_16_3, iter_16_4 in pairs(var_16_1) do
		self.sectionTargets_[iter_16_3]:Refresh(iter_16_4[1], iter_16_4[2])
	end
end

function ActivityRhythmGameStageInfoView:RefreshTimeUI()
	self.textnum01Text_.text = manager.time:DescCdTime2((ActivityRhythmGameData:GetTimeByStageID(self.stageID_)))
end

function ActivityRhythmGameStageInfoView:RefreshBtnUI()
	if ActivityRhythmGameData:IsUnlock(self.cfgID_) then
		self:ChangeLockController(0)
	else
		self:ChangeLockController(1)

		if ActivityRhythmGameCfg[self.cfgID_] and ActivityRhythmGameCfg[self.cfgID_].condition_list and ActivityRhythmGameCfg[self.cfgID_].condition_list ~= 0 and not IsConditionAchieved(ActivityRhythmGameCfg[self.cfgID_].condition_list) then
			self.conditionText_.text = ConditionCfg[ActivityRhythmGameCfg[self.cfgID_].condition_list].desc

			return
		end

		if not ActivityRhythmGameData:IsUnlockPreStage(self.cfgID_) then
			self.conditionText_.text = self.DefaultConditionText_
		end
	end
end

function ActivityRhythmGameStageInfoView:RefreshTitleUI()
	self.textcheckpointnameText_.text = GetI18NText(BattleRhythmGameStageCfg[self.stageID_].name)
	self.bgImg_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, BattleRhythmGameStageCfg[self.stageID_].background_1))
end

return ActivityRhythmGameStageInfoView
