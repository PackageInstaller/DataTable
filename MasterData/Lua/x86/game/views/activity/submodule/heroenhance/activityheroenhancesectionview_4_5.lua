local ActivityHeroEnhanceSectionView_4_5 = class("ActivityHeroEnhanceSectionView_4_5", (import("game.views.sectionSelect.SectionBaseView")))

function ActivityHeroEnhanceSectionView_4_5:UIName()
	return ActivityHeroEnhanceTools.GetStageUIName(self.params_.activityID)
end

function ActivityHeroEnhanceSectionView_4_5:GetCfgName()
	return BattleHeroEnhanceCfg
end

function ActivityHeroEnhanceSectionView_4_5:GetSectionItemClass()
	return ActivityHeroEnhanceSectionItem
end

function ActivityHeroEnhanceSectionView_4_5:IsOpenSectionInfo()
	return self:IsOpenRoute("activityHeroEnhanceSectionInfo")
end

function ActivityHeroEnhanceSectionView_4_5:RefreshBGM()
	return
end

function ActivityHeroEnhanceSectionView_4_5:Init()
	ActivityHeroEnhanceSectionView_4_5.super.Init(self)
end

function ActivityHeroEnhanceSectionView_4_5:InitCustom()
	self:BindCfgUI()
end

function ActivityHeroEnhanceSectionView_4_5:OnEnter()
	self.stopAni_ = true
	self.activityId_ = self.params_.activityID

	local var_8_0 = ActivityHeroEnhanceTools.GetIsNewTalent(self.activityId_)

	if var_8_0 ~= -1 then
		self.cacheNewTalent_ = var_8_0

		JumpTools.OpenPageByJump("/activityHeroEnhancePopView_4_5", {
			talentID = var_8_0,
			activityID = self.activityId_
		})

		return
	end

	self:GetAttachView():PlayTalentAnim(self.cacheNewTalent_)

	self.cacheNewTalent_ = nil

	if self.params_.cfgId then
		self:ChangeCfgID(self.params_.cfgId)
	end

	local var_8_1 = ActivityHeroEnhanceTools.GetCfgIdList(self.activityId_)

	for iter_8_0 = #var_8_1, 1, -1 do
		local var_8_2, var_8_3 = ActivityHeroEnhanceTools.IsCfgHeroLock(ActivityHeroEnhanceCfg[var_8_1[iter_8_0]])

		if not var_8_2 then
			if iter_8_0 > 1 and not getData("heroEnhanceUnlockCfgID" .. self.activityId_, tostring(var_8_1[iter_8_0])) then
				saveData("heroEnhanceUnlockCfgID" .. self.activityId_, tostring(var_8_1[iter_8_0]), true)

				if iter_8_0 - 1 > 0 then
					self:ChangeCfgID(var_8_1[iter_8_0 - 1])
				else
					self:ChangeCfgID(var_8_1[iter_8_0])
				end

				FrameTimer.New(function()
					self:GetAttachView():PlayAnim(var_8_1[iter_8_0], function()
						self:ChangeCfgID(var_8_1[iter_8_0])
					end)
				end, 1, 1):Start()
			elseif self.params_.cfgId then
				self.params_.cfgId = nil
			else
				self:ChangeCfgID(var_8_1[iter_8_0])
			end

			break
		end
	end

	ActivityHeroEnhanceSectionView_4_5.super.OnEnter(self)
end

function ActivityHeroEnhanceSectionView_4_5:RefreshData()
	if not self.cfgId_ then
		return
	end

	local var_11_0 = ActivityHeroEnhanceCfg[self.cfgId_]

	self.stageList_ = ActivityHeroEnhanceCfg[self.cfgId_].stage_list
	self.oepnStageList_ = {}

	for iter_11_0, iter_11_1 in ipairs(self.stageList_) do
		if ActivityHeroEnhanceTools.IsCfgStageUnlock(var_11_0, iter_11_1) then
			table.insert(self.oepnStageList_, iter_11_1)
		end
	end

	local var_11_1 = self:GetAttachView()

	var_11_1:SetData(self.cfgId_, (ActivityHeroEnhanceTools.GetCfgTalentList(var_11_0)))
	var_11_1:RefreshUI()
end

function ActivityHeroEnhanceSectionView_4_5:GetAttachView()
	if self.attachView_ == nil then
		self.attachView_ = ActivityHeroEnhanceSectionAttachView_4_5.New(self.setionAttachGo_, ActivityHeroEnhanceTools.GetStageAttachUIName(self.activityId_), self.activityId_, function(arg_13_0)
			self:ChangeCfgID(arg_13_0)
		end)
	end

	return self.attachView_
end

function ActivityHeroEnhanceSectionView_4_5:OnClickSectionItem(arg_14_1, arg_14_2)
	if arg_14_2 then
		-- block empty
	else
		self:Go("activityHeroEnhanceSectionInfo", {
			section = arg_14_1,
			sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_HERO_ENHANCE,
			activityID = self.activityId_,
			heroEnhance_CfgID = self.cfgId_
		})
	end
end

function ActivityHeroEnhanceSectionView_4_5:RefreshUI()
	self:RefreshMissionList()

	local var_15_0 = self.stageList_[1]

	for iter_15_0 = 1, #self.stageList_ do
		if not not ActivityHeroEnhanceTools.IsCfgStageUnlock(ActivityHeroEnhanceCfg[self.cfgId_], self.stageList_[iter_15_0]) then
			var_15_0 = self.stageList_[iter_15_0]
		end
	end

	local var_15_1 = self.params_.section

	if not self.params_.section then
		var_15_1 = BattleFieldData:GetCacheStage(self.chapterID_)
		var_15_1 = var_15_1 or var_15_0
	end

	self.selectSection_ = var_15_1

	local var_15_2 = self:GetScrollPos()
	local var_15_3 = self:GetScrollWidth()

	if self.stopMove_ then
		-- block empty
	elseif self.stopAni_ then
		self.stopAni_ = false

		self.scrollMoveView_:RefreshUI(var_15_2, var_15_3, true)
	else
		self.scrollMoveView_:RefreshUI(var_15_2, var_15_3)
	end

	self:RefreshSelectItem()
end

function ActivityHeroEnhanceSectionView_4_5:RefreshMissionList()
	if not self.cfgId_ then
		return
	end

	for iter_16_0 = #self.stageList_ + 1, #self.missionItem_ do
		self.missionItem_[iter_16_0]:Show(false)
	end

	for iter_16_1 = 1, #self.stageList_ do
		local var_16_1 = self.missionItem_[iter_16_1]

		if self.missionItem_[iter_16_1] == nil then
			var_16_1 = self:GetSectionItemClass().New(self.sectionItem_, self.content_)
			self.missionItem_[iter_16_1] = var_16_1

			var_16_1:SetClickHandler(function(arg_17_0, arg_17_1)
				self:OnClickSectionItem(arg_17_0, arg_17_1)
			end)
		end

		var_16_1:SetData(self.cfgId_, self.stageList_[iter_16_1])
		var_16_1:RefreshData()
		var_16_1:RefreshUI()
	end

	self:CreateLineItemList()
end

function ActivityHeroEnhanceSectionView_4_5:CreateLineItemList()
	self.lineType_ = 0

	local var_18_0 = 0

	for iter_18_0, iter_18_1 in ipairs(self.oepnStageList_) do
		local var_18_1 = self.missionItem_[table.keyof(self.stageList_, iter_18_1)]
		local var_18_2 = var_18_1:GetLocalPosition() + Vector3(0, 0, 0)
		local var_18_3 = self:GetCfgName()[iter_18_1].next_unlock_id_list

		for iter_18_2, iter_18_3 in ipairs((not var_18_1 or nil) and {}) do
			local var_18_4 = self:GetCfgName()[iter_18_1]

			if table.keyof(self.oepnStageList_, iter_18_3) then
				local var_18_5 = self.missionItem_[table.keyof(self.stageList_, iter_18_3)]:GetLocalPosition() + Vector3(0, 0, 0)

				var_18_0 = var_18_0 + 1
				self.lineList_[var_18_0] = self.lineList_[var_18_0] or self:GetLineClass(self.lineType_).New(self:GetLineGo(self.lineType_), self.content_, self:GetPointGo(self.lineType_))

				self.lineList_[var_18_0]:Show(true)
				self.lineList_[var_18_0]:RefreshUI(var_18_2, var_18_5)
			end
		end
	end

	for iter_18_4, iter_18_5 in pairs(self.lineList_) do
		iter_18_5:Show(iter_18_4 <= var_18_0)
	end
end

function ActivityHeroEnhanceSectionView_4_5:ChangeCfgID(arg_19_1)
	if self.cfgId_ == arg_19_1 then
		return
	end

	self.stopAni_ = true
	self.cfgId_ = arg_19_1

	self:RefreshData()
	self.attachView_:ChooseCfg(self.cfgId_)
	self:RefreshUI()
end

function ActivityHeroEnhanceSectionView_4_5:Dispose()
	if self.attachView_ then
		self.attachView_:Dispose()
	end

	ActivityHeroEnhanceSectionView_4_5.super.Dispose(self)
end

return ActivityHeroEnhanceSectionView_4_5
