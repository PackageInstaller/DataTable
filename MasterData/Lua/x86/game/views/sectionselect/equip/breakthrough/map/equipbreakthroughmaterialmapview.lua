local EquipBreakThroughMaterialMapView = class("EquipBreakThroughMaterialMapView", ReduxView)

function EquipBreakThroughMaterialMapView:UIName()
	return "UI/Stage/EquipBreakThroughMaterial/EquipBreakThroughMaterialMapUI"
end

function EquipBreakThroughMaterialMapView:UIParent()
	return manager.ui.uiMain.transform
end

function EquipBreakThroughMaterialMapView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.scrollMoveView_ = ScrollMoveView.New(self, self.scrollViewGo_)
	self.itemList_ = {}
	self.lineList_ = {}
	self.affixItemList_ = {}
	self.updateHandler_ = handler(self, self.UpdateBreakThroughData)
	self.refreshHandler_ = handler(self, self.RefreshUI)
	self.refreshItemHandler_ = handler(self, self.RefreshItem)
	self.showController_ = ControllerUtil.GetController(self.transform_, "show")
end

function EquipBreakThroughMaterialMapView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("EQUIP_BREAK_THROUGH_INFO")
	EquipBreakThroughMaterialAction.CheckTimeout()
	self:RefreshUI()
	manager.notify:RegistListener(EQUIP_BREAK_THROUGH_MATERIAL_UPDATE, self.updateHandler_)
	manager.notify:RegistListener(EQUIP_BREAK_THROUGH_MATERIAL_CHANGE, self.refreshHandler_)
	manager.notify:RegistListener(EQUIP_BREAK_THROUGH_MATERIAL_STAGE_UPDATE, self.refreshItemHandler_)
	manager.redPoint:bindUIandKey(self.rewardBtn_.transform, RedPointConst.EQUIP_BREAK_THROUGH_MATERIAL_REWARD)
end

function EquipBreakThroughMaterialMapView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})

	self.selectMapStageID_ = nil

	for iter_5_0, iter_5_1 in pairs(self.itemList_) do
		iter_5_1:OnTop()
	end

	SetActive(self.difficultyPanel_, true)
end

function EquipBreakThroughMaterialMapView:OnUpdate()
	for iter_6_0, iter_6_1 in pairs(self.itemList_) do
		iter_6_1:OnBehind()
	end

	if self:IsOpenSectionInfo() then
		self:RefreshScroll()
	else
		self.scrollView_.enabled = true
	end
end

function EquipBreakThroughMaterialMapView:OnBehind()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	SetActive(self.difficultyPanel_, false)
end

function EquipBreakThroughMaterialMapView:OnExit()
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(EQUIP_BREAK_THROUGH_MATERIAL_UPDATE, self.updateHandler_)
	manager.notify:RemoveListener(EQUIP_BREAK_THROUGH_MATERIAL_CHANGE, self.refreshHandler_)
	manager.notify:RemoveListener(EQUIP_BREAK_THROUGH_MATERIAL_STAGE_UPDATE, self.refreshItemHandler_)
	manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, RedPointConst.EQUIP_BREAK_THROUGH_MATERIAL_REWARD)

	for iter_8_0, iter_8_1 in pairs(self.itemList_) do
		iter_8_1:OnExit()
	end

	self.scrollMoveView_:OnExit()
end

function EquipBreakThroughMaterialMapView:Dispose()
	EquipBreakThroughMaterialMapView.super.Dispose(self)
	self.scrollMoveView_:Dispose()

	self.scrollMoveView_ = nil
	self.updateHandler_ = nil
	self.refreshHandler_ = nil
	self.refreshItemHandler_ = nil

	for iter_9_0, iter_9_1 in pairs(self.itemList_) do
		iter_9_1:Dispose()
	end

	self.itemList_ = nil

	for iter_9_2, iter_9_3 in pairs(self.lineList_) do
		iter_9_3:Dispose()
	end

	self.lineList_ = nil

	for iter_9_4, iter_9_5 in pairs(self.affixItemList_) do
		iter_9_5:Dispose()
	end

	self.affixItemList_ = nil
end

function EquipBreakThroughMaterialMapView:AddListeners()
	self:AddBtnListener(self.resetBtn_, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("EQUIP_BREAK_THROUGH_RESET_MAP"),
			OkCallback = function()
				EquipBreakThroughMaterialAction.ResetMap(function(arg_13_0)
					if isSuccess(arg_13_0.result) then
						ShowTips("ASTROLABE_RESET")
						self:RefreshUI()
					end
				end)
			end
		})
	end)
	self:AddBtnListener(self.difficultyBtn_, nil, function()
		if self:IsOpenSectionInfo() then
			JumpTools.Back()
			self:RefreshScroll()

			return
		end

		if table.length(EquipBreakThroughMaterialData:GetReceivedList()) <= 0 then
			self:Go("equipBreakThroughMaterialMode")
		end
	end)
	self:AddBtnListener(self.teamInfoBtn_, nil, function()
		if self:IsOpenSectionInfo() then
			JumpTools.Back()
			self:RefreshScroll()

			return
		end

		JumpTools.OpenPageByJump("equipBreakThroughMaterialMapInfo", {
			toggleType = EquipBreakThroughMaterialConst.TOGGLE_TYPE.TEAM
		})
	end)
	self:AddBtnListener(self.buffInfoBtn_, nil, function()
		if self:IsOpenSectionInfo() then
			JumpTools.Back()
			self:RefreshScroll()

			return
		end

		JumpTools.OpenPageByJump("equipBreakThroughMaterialMapInfo", {
			toggleType = EquipBreakThroughMaterialConst.TOGGLE_TYPE.BUFF
		})
	end)
	self:AddBtnListener(self.rewardBtn_, nil, function()
		if self:IsOpenSectionInfo() then
			JumpTools.Back()
			self:RefreshScroll()

			return
		end

		JumpTools.OpenPageByJump("equipBreakThroughMaterialTask", {})
	end)
	self:AddBtnListener(self.bgBtn_, nil, function()
		manager.notify:Invoke(CLICK_AFFIX)
	end)
end

function EquipBreakThroughMaterialMapView:UpdateBreakThroughData()
	EquipBreakThroughMaterialAction.EquipBTMaterialBackEntrace()
end

function EquipBreakThroughMaterialMapView:RefreshUI()
	self:RefreshDifficultyBtn()

	self.pointText_.text = EquipBreakThroughMaterialData:GetTotalPoint()

	self:RefreshItem()
	self:CreateLineItemList()
	self:RefreshAffix()
	self:RefreshScroll()
	self:RefreshButton()
end

function EquipBreakThroughMaterialMapView:RefreshScroll()
	self.selectMapStageID_ = EquipBreakThroughMaterialData:GetChooseMapStageID()

	if self.selectMapStageID_ == nil then
		local var_21_0 = EquipBreakThroughMaterialData:GetFinishStageList()

		if var_21_0[#var_21_0] == nil then
			self.selectMapStageID_ = EquipBreakThroughMaterialMapCfg.get_id_list_by_map_id[EquipBreakThroughMaterialData:GetMapID()][1]
		end
	end

	self.scrollMoveView_:RefreshUI(self:GetScrollPos(), (self:GetScrollWidth()))
end

function EquipBreakThroughMaterialMapView:RefreshDifficultyBtn()
	local var_22_0 = EquipBreakThroughMaterialData:GetSelectModeID()

	self.difficultyText_.text = GetI18NText(EquipBreakThroughMaterialDifficultyCfg[var_22_0].name)
	self.difficultyBtn_.interactable = table.length(EquipBreakThroughMaterialData:GetReceivedList()) <= 0
	self.difficultyImage_.sprite = getSprite("Atlas/Switch", string.format("bg_n%s", var_22_0))
end

function EquipBreakThroughMaterialMapView:RefreshItem()
	local var_23_0 = EquipBreakThroughMaterialMapCfg.get_id_list_by_map_id[EquipBreakThroughMaterialData:GetMapID()]

	for iter_23_0, iter_23_1 in ipairs(var_23_0) do
		self.itemList_[iter_23_0] = self.itemList_[iter_23_0] or EquipBreakThroughMaterialMapItem.New(self.item_, self.itemParent_)

		self.itemList_[iter_23_0]:SetData(iter_23_1)
	end

	for iter_23_2 = #self.itemList_, #var_23_0 + 1, -1 do
		self.itemList_[iter_23_2]:Dispose()

		self.itemList_[iter_23_2] = nil
	end
end

function EquipBreakThroughMaterialMapView:RefreshButton()
	if table.length(EquipBreakThroughMaterialData:GetFinishStageList()) > 0 then
		self.showController_:SetSelectedState("true")
	else
		self.showController_:SetSelectedState("false")
	end
end

function EquipBreakThroughMaterialMapView:RefreshAffix()
	local var_25_0 = EquipBreakThroughMaterialData:GetGlobalAffixList()

	for iter_25_0, iter_25_1 in ipairs(var_25_0) do
		if self.affixItemList_[iter_25_0] then
			self.affixItemList_[iter_25_0]:SetData(iter_25_1)
		else
			self.affixItemList_[iter_25_0] = AffixItemView.New(self.affixItem_, self.affixPanel_, iter_25_1)
		end
	end

	for iter_25_2 = #self.affixItemList_, #var_25_0 + 1, -1 do
		self.affixItemList_[iter_25_2]:Show(false)
	end
end

function EquipBreakThroughMaterialMapView:GetScrollWidth()
	local var_26_0 = EquipBreakThroughMaterialMapCfg.get_id_list_by_map_id[EquipBreakThroughMaterialData:GetMapID()]

	return EquipBreakThroughMaterialStagePositionCfg[0].row_position * EquipBreakThroughMaterialMapCfg[var_26_0[#var_26_0]].col
end

function EquipBreakThroughMaterialMapView:GetScrollPos()
	return EquipBreakThroughMaterialMapCfg[self.selectMapStageID_].col * EquipBreakThroughMaterialStagePositionCfg[0].row_position
end

function EquipBreakThroughMaterialMapView:CreateLineItemList()
	for iter_28_0, iter_28_1 in pairs(self.lineList_) do
		iter_28_1:Show(false)
	end

	local var_28_0 = EquipBreakThroughMaterialMapCfg.get_id_list_by_map_id[EquipBreakThroughMaterialData:GetMapID()]

	for iter_28_2, iter_28_3 in pairs(var_28_0) do
		local var_28_1 = self.itemList_[iter_28_2]:GetLocalPosition() + Vector3(50, 10, 0)

		for iter_28_4, iter_28_5 in ipairs(EquipBreakThroughMaterialMapCfg[iter_28_3].next_id_list) do
			local var_28_2 = self.itemList_[table.keyof(var_28_0, iter_28_5)]:GetLocalPosition() + Vector3(-50, 10, 0)

			self.lineList_[1] = self.lineList_[1] or EquipBreakThroughMaterialLine.New(self.lineGo_, self.itemParent_, self.pointGo_)

			self.lineList_[1]:Show(true)
			self.lineList_[1]:RefreshUI(var_28_1, var_28_2)
		end
	end
end

function EquipBreakThroughMaterialMapView:IsOpenSectionInfo()
	return self:IsOpenRoute("equipBreakThroughMaterialStageInfo")
end

return EquipBreakThroughMaterialMapView
