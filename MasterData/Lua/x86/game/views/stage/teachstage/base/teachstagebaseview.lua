local TeachStageBaseView = class("TeachStageBaseView", ReduxView)

function TeachStageBaseView:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.switchType_ = arg_1_2

	self:InitUI()
	self:AddListeners()

	self.missionItem_ = {}
	self.lineList_ = {}
end

function TeachStageBaseView:OnEnter()
	self:RefreshData()
	self:RefreshUI()
end

function TeachStageBaseView:OnUpdate()
	self:RefreshUI()
end

function TeachStageBaseView:OnClickTeachViewBtn()
	return
end

function TeachStageBaseView:OnExit()
	BattleTeachData:SetBaseScrollViewHorizontal(self.scrollMoveView_:GetHorizontalNormalizedPosition())

	self.isFirst_ = false

	self.scrollMoveView_:OnExit()
end

function TeachStageBaseView:Dispose()
	for iter_6_0, iter_6_1 in ipairs(self.missionItem_) do
		iter_6_1:Dispose()
	end

	self.missionItem_ = nil

	for iter_6_2, iter_6_3 in pairs(self.lineList_) do
		iter_6_3:Dispose()
	end

	self.lineList_ = nil

	self.scrollMoveView_:Dispose()

	self.scrollMoveView_ = nil

	self:RemoveListeners()

	self.scrollViewEvent_ = nil
	self.scrollViewGo_ = nil
	self.scrollView_ = nil
	self.viewportRect_ = nil
	self.content_ = nil
	self.contentRect_ = nil
	self.sectionItem_ = nil
	self.lineGo_ = nil
end

function TeachStageBaseView:InitUI()
	self:BindCfgUI()

	self.scrollMoveView_ = ScrollMoveView.New(self, self.basiScrollView_)
end

function TeachStageBaseView:AddListeners()
	return
end

function TeachStageBaseView:RemoveListeners()
	return
end

function TeachStageBaseView:RefreshData()
	self.stageList_ = ChapterCfg[ChapterCfg.get_id_list_by_type[self.switchType_][1]].section_id_list

	self:GetScrollWidth()
end

function TeachStageBaseView:GetScrollWidth()
	self.scrollWidth_ = BattleBaseTeachStageCfg[self.stageList_[#self.stageList_]].position[1]
end

function TeachStageBaseView:SwitchPageUI(arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = self.switchType_ == arg_12_1

	SetActive(self.gameObject_, self.switchType_ == arg_12_1)

	if var_12_0 then
		BattleTeachAction.CancelBaseTeachRedPoint()
	end

	if arg_12_3 then
		BattleFieldData:SetCacheStage(ChapterCfg.get_id_list_by_type[self.switchType_][1], ChapterCfg[ChapterCfg.get_id_list_by_type[self.switchType_][1]].section_id_list[1])
		BattleTeachData:SetBaseScrollViewHorizontal(0)
	end
end

function TeachStageBaseView:IsOpenSectionInfo()
	return self:IsOpenRoute("teachSectionInfo")
end

function TeachStageBaseView:RefreshUI()
	self:RefreshMissionList()

	local var_14_0 = BattleFieldData:GetCacheStage(ChapterCfg.get_id_list_by_type[self.switchType_][1]) or self.stageList_[1]
	local var_14_1 = table.keyof(self.stageList_, var_14_0)

	self.lastSelect_ = var_14_1

	if not self.isFirst_ then
		self.scrollMoveView_:SetHorizontalNormalizedPosition(BattleTeachData:GetBaseScrollViewHorizontal(), self.scrollWidth_)

		self.isFirst_ = true
	else
		self.scrollMoveView_:RefreshUI(BattleBaseTeachStageCfg[self.stageList_[var_14_1]].position[1], self.scrollWidth_, not self:IsOpenSectionInfo())
	end

	if self:IsOpenSectionInfo() then
		for iter_14_0, iter_14_1 in ipairs(self.missionItem_) do
			iter_14_1:RefreshSelect(var_14_0)
		end
	else
		for iter_14_2, iter_14_3 in ipairs(self.missionItem_) do
			iter_14_3:RefreshSelect(0)
		end
	end
end

function TeachStageBaseView:GetSectionItemClass()
	return TeachStageBaseItem
end

function TeachStageBaseView:RefreshMissionList()
	for iter_16_0 = 1, #self.missionItem_ do
		self.missionItem_[iter_16_0]:Show(false)
	end

	for iter_16_1 = 1, #self.stageList_ do
		if self.missionItem_[iter_16_1] then
			self.missionItem_[iter_16_1]:SetData(self.stageList_[iter_16_1])
		else
			self.missionItem_[iter_16_1] = self:GetSectionItemClass().New(self.sectionItem_, self.content_, self.stageList_[iter_16_1])
		end
	end

	self:CreateLineItemList()
end

function TeachStageBaseView:CreateLineItemList()
	for iter_17_0, iter_17_1 in pairs(self.lineList_) do
		iter_17_1:Show(false)
	end

	for iter_17_2, iter_17_3 in ipairs(self.stageList_) do
		if iter_17_2 > 1 then
			local var_17_0 = self.missionItem_[iter_17_2 - 1]:GetLocalPosition() + Vector3(150, 6.2, 0)
			local var_17_1 = self.missionItem_[iter_17_2]:GetLocalPosition() + Vector3(-157, 6.2, 0)

			self.lineList_[iter_17_2] = self.lineList_[iter_17_2] or SectionLineItem.New(self.lineGo_, self.content_, self.pointGo_)

			self.lineList_[iter_17_2]:RefreshUI(var_17_0, var_17_1)
			self.lineList_[iter_17_2]:Show(true)
		end
	end
end

return TeachStageBaseView
