local ActivityHeroEnhanceSectionView = class("ActivityHeroEnhanceSectionView", (import("game.views.sectionSelect.SectionBaseView")))

function ActivityHeroEnhanceSectionView:UIName()
	return ActivityHeroEnhanceTools.GetStageUIName(self.params_.activityID)
end

function ActivityHeroEnhanceSectionView:GetCfgName()
	return BattleHeroEnhanceCfg
end

function ActivityHeroEnhanceSectionView:GetSectionItemClass()
	return ActivityHeroEnhanceSectionItem
end

function ActivityHeroEnhanceSectionView:IsOpenSectionInfo()
	return self:IsOpenRoute("activityHeroEnhanceSectionInfo")
end

function ActivityHeroEnhanceSectionView:RefreshBGM()
	return
end

function ActivityHeroEnhanceSectionView:Init()
	ActivityHeroEnhanceSectionView.super.Init(self)
end

function ActivityHeroEnhanceSectionView:InitCustom()
	self:BindCfgUI()
end

function ActivityHeroEnhanceSectionView:OnEnter()
	ActivityHeroEnhanceSectionView.super.OnEnter(self)

	if self.params_.exitFromBattle then
		ActivityHeroEnhanceHeroView.enterBattleCfgId_ = self.params_.cfgId
		self.params_.exitFromBattle = nil
	end
end

function ActivityHeroEnhanceSectionView:RefreshData()
	self.activityId_ = self.params_.activityID
	self.cfgId_ = self.params_.cfgId
	self.stageList_ = ActivityHeroEnhanceCfg[self.params_.cfgId].stage_list
	self.oepnStageList_ = {}

	for iter_9_0, iter_9_1 in ipairs(self.stageList_) do
		if ActivityHeroEnhanceTools.IsCfgStageUnlock(ActivityHeroEnhanceCfg[self.params_.cfgId], iter_9_1) then
			table.insert(self.oepnStageList_, iter_9_1)
		end
	end

	local var_9_0 = self:GetAttachView()

	var_9_0:SetData(self.params_.cfgId, (ActivityHeroEnhanceTools.GetCfgActivatedTalentDict(ActivityHeroEnhanceCfg[self.params_.cfgId])))
	var_9_0:RefreshUI()
end

function ActivityHeroEnhanceSectionView:GetAttachView()
	if self.attachView_ == nil then
		self.attachView_ = ActivityHeroEnhanceSectionAttachView.New(self.setionAttachGo_, (ActivityHeroEnhanceTools.GetStageAttachUIName(self.activityId_)))
	end

	return self.attachView_
end

function ActivityHeroEnhanceSectionView:OnClickSectionItem(arg_11_1, arg_11_2)
	if arg_11_2 then
		-- block empty
	else
		self:Go("activityHeroEnhanceSectionInfo", {
			section = arg_11_1,
			sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_HERO_ENHANCE,
			activityID = self.activityId_,
			heroEnhance_CfgID = self.cfgId_
		})
	end
end

function ActivityHeroEnhanceSectionView:RefreshMissionList()
	for iter_12_0 = #self.stageList_ + 1, #self.missionItem_ do
		self.missionItem_[iter_12_0]:Show(false)
	end

	for iter_12_1 = 1, #self.stageList_ do
		local var_12_0 = self.missionItem_[iter_12_1]

		if self.missionItem_[iter_12_1] == nil then
			var_12_0 = self:GetSectionItemClass().New(self.sectionItem_, self.content_)
			self.missionItem_[iter_12_1] = var_12_0

			var_12_0:SetClickHandler(function(arg_13_0, arg_13_1)
				self:OnClickSectionItem(arg_13_0, arg_13_1)
			end)
		end

		var_12_0:SetData(self.cfgId_, self.stageList_[iter_12_1])
		var_12_0:RefreshData()
		var_12_0:RefreshUI()
	end

	self:CreateLineItemList()
end

function ActivityHeroEnhanceSectionView:CreateLineItemList()
	self.lineType_ = 0

	local var_14_0 = 0

	for iter_14_0, iter_14_1 in ipairs(self.oepnStageList_) do
		local var_14_1 = self.missionItem_[table.keyof(self.stageList_, iter_14_1)]
		local var_14_2 = var_14_1:GetLocalPosition() + Vector3(0, 0, 0)
		local var_14_3 = self:GetCfgName()[iter_14_1].next_unlock_id_list

		for iter_14_2, iter_14_3 in ipairs((not var_14_1 or nil) and {}) do
			local var_14_4 = self:GetCfgName()[iter_14_1]

			if table.keyof(self.oepnStageList_, iter_14_3) then
				local var_14_5 = self.missionItem_[table.keyof(self.stageList_, iter_14_3)]:GetLocalPosition() + Vector3(0, 0, 0)

				var_14_0 = var_14_0 + 1
				self.lineList_[var_14_0] = self.lineList_[var_14_0] or self:GetLineClass(self.lineType_).New(self:GetLineGo(self.lineType_), self.content_, self:GetPointGo(self.lineType_))

				self.lineList_[var_14_0]:Show(true)
				self.lineList_[var_14_0]:RefreshUI(var_14_2, var_14_5)
			end
		end
	end

	for iter_14_4, iter_14_5 in pairs(self.lineList_) do
		iter_14_5:Show(iter_14_4 <= var_14_0)
	end
end

function ActivityHeroEnhanceSectionView:Dispose()
	if self.attachView_ then
		self.attachView_:Dispose()
	end

	ActivityHeroEnhanceSectionView.super.Dispose(self)
end

return ActivityHeroEnhanceSectionView
