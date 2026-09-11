local EquipSectionView = class("EquipSectionView", import("..SectionBaseView"))

function EquipSectionView:GetSectionItemClass()
	return EquipSectionItemView
end

function EquipSectionView:IsOpenSectionInfo()
	return self:IsOpenRoute("equipSectionInfo")
end

function EquipSectionView:InitCustom()
	SetActive(self.equipPanel_, true)
	self:AddBtnListener(self.switchBtn_, nil, function()
		if self.isUnChoose_ then
			RedPointAction.HandleRedPoint(RED_POINT_ID.BATTLE_EQUIP)
			manager.redPoint:SetRedPointIndependent(self.switchBtn_.transform, false)
		end

		JumpTools.OpenPageByJump("suitSelect", {
			suitId = self.upSuitId_,
			currentSuitId = self.upSuitId_
		})
	end)
end

function EquipSectionView:RefreshData()
	self.battleEquipData_ = BattleEquipData:GetBattleEquipData()

	if self:IsOpenSectionInfo() and self.lastBaseStageId_ and self.lastBaseStageId_ ~= self.battleEquipData_.baseStageId then
		self.isOpenInfoView_ = false

		JumpTools.Back()
	end

	self.lastBaseStageId_ = self.battleEquipData_.baseStageId
	self.stageList_ = StageGroupCfg[self.battleEquipData_.baseStageId].stage_list
	self.stageData_ = {}

	for iter_5_0, iter_5_1 in ipairs(self.stageList_) do
		self.stageData_[iter_5_1] = {
			id = self.stageList_[iter_5_0]
		}
	end

	self:RefreshCustomData()

	self.oepnStageList_ = self.stageList_
end

function EquipSectionView:RefreshUI()
	self:RefreshMissionList()

	local var_6_0 = self.params_.section

	if not self.params_.section then
		var_6_0 = BattleFieldData:GetCacheStage(self.chapterID_)
		var_6_0 = var_6_0 or self.stageList_[1]
	end

	self.selectSection_ = var_6_0

	if table.keyof(self.stageList_, var_6_0) == nil then
		self.selectSection_ = self.stageList_[1]
	end

	self.scrollMoveView_:RefreshUI(self:GetScrollPos(), (self:GetScrollWidth()))
	self:RefreshSelectItem()
	self:RefreshRemainTime()
	self:RefreshUpSuit()

	if self.params_.equipId then
		JumpTools.OpenPageByJump("suitSelect", {
			suitId = EquipCfg[self.params_.equipId].suit,
			currentSuitId = self.upSuitId_
		})

		self.params_.equipId = nil
	end

	self:SwitchBG()
end

function EquipSectionView:GetCfgName()
	return BattleEquipStageCfg
end

function EquipSectionView:RefreshUpSuit()
	self.upSuitId_ = self.battleEquipData_.upSuitId
	self.equipName_.text = GetI18NText(EquipSuitCfg[self.upSuitId_].name)

	SetSpriteWithoutAtlasAsync(self.equipIcon_, SpritePathCfg.EquipIcon_s.path .. self.upSuitId_)
end

function EquipSectionView:RefreshRemainTime()
	if self.updateTimer_ then
		self.updateTimer_:Stop()

		self.updateTimer_ = nil
	end

	local var_9_0 = self.battleEquipData_.next_refresh_time - manager.time:GetServerTime()

	self.timeText_.text = string.format(GetTips("TIME_DISPLAY_15"), manager.time:DescCDTime(var_9_0))
	self.updateTimer_ = Timer.New(function()
		var_9_0 = var_9_0 - 1
		self.timeText_.text = string.format(GetTips("TIME_DISPLAY_15"), manager.time:DescCDTime(var_9_0))

		if var_9_0 <= 0 then
			BattleEquipAction.RequestBattleEquipInfo()
		end
	end, 1, var_9_0, 1)

	self.updateTimer_:Start()
end

function EquipSectionView:RefreshMissionList()
	for iter_11_0 = 1, #self.stageList_ do
		if self.missionItem_[iter_11_0] then
			self.missionItem_[iter_11_0]:SetData(self.chapterID_, self.stageList_[iter_11_0])
		else
			self.missionItem_[iter_11_0] = self:GetSectionItemClass().New(self.sectionItem_, self.content_, self.stageList_[iter_11_0], self.chapterID_)
		end
	end

	self:CreateLineItemList()
end

function EquipSectionView:RefreshRedPoint()
	self.isUnChoose_ = not RedPointData:GetIsRedPointOpen(RED_POINT_ID.BATTLE_EQUIP)

	if self.isUnChoose_ then
		manager.redPoint:SetRedPointIndependent(self.switchBtn_.transform, true)
	end
end

function EquipSectionView:OnBattleEquipUpdate()
	self:RefreshData()
	self:RefreshUI()
end

function EquipSectionView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("EQUIP_STAGE_DESCRIPE")
	manager.windowBar:RegistBackCallBack(function()
		if self:IsOpenSectionInfo() then
			self.isOpenInfoView_ = false
		end

		JumpTools.Back()
	end)
end

function EquipSectionView:OnEnter()
	manager.ui:SetMainCamera("null")
	self:ShowPanel()
	BattleEquipAction.RequestBattleEquipInfo()

	self.chapterID_ = ChapterCfg.get_id_list_by_type[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_EQUIP][1]

	self:RefreshBGM()
	self:RefreshMultiReward()
	self:RefreshRedPoint()
end

function EquipSectionView:OnExit()
	EquipSectionView.super.OnExit(self)

	if self.updateTimer_ then
		self.updateTimer_:Stop()

		self.updateTimer_ = nil
	end
end

function EquipSectionView:CreateLineItemList()
	for iter_18_0, iter_18_1 in pairs(self.lineList_) do
		iter_18_1:Show(false)
	end

	for iter_18_2, iter_18_3 in ipairs(self.stageList_) do
		if iter_18_2 > 1 then
			local var_18_0 = self.missionItem_[iter_18_2]:GetLocalPosition() + Vector3(0, 0, 0)
			local var_18_1 = self.missionItem_[iter_18_2 - 1]:GetLocalPosition() + Vector3(0, 0, 0)

			self.lineList_[1] = self.lineList_[1] or self:GetLineClass(0).New(self.lineGo_, self.content_, self.pointGo_)

			self.lineList_[1]:Show(true)
			self.lineList_[1]:RefreshUI(var_18_1, var_18_0)
		end
	end
end

return EquipSectionView
