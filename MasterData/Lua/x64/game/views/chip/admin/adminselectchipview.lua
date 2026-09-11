local AdminSelectChipView = class("AdminSelectChipView", ReduxView)
local var_0_1 = {
	MIMIR = 2,
	CHAR = 1
}

function AdminSelectChipView:UIName()
	return "Widget/System/Administrators/AdministratorsHelpBattleUI"
end

function AdminSelectChipView:UIParent()
	return manager.ui.uiMain.transform
end

function AdminSelectChipView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.switchController_ = self.switchConEx_:GetController("switch")
	self.btnController_ = self.btnConEx_:GetController("state")
	self.contTrs_ = self.scroll_.content
	self.viewTrs_ = self.scroll_.viewport
	self.loopScrollView_ = LoopScrollView.New(self, self.scroll_, self.contTrs_, self.viewTrs_, 999999, self.contTrs_:GetComponent("HorizontalLayoutGroup").spacing, nil, true)
	self.itemPoolChar_ = {}
	self.itemPoolMimir_ = {}
	self.animInfo_ = {}
	self.filterView_ = NewHeroListFilterView.New(self.filterGo_)

	self.filterView_:SetListChangeHandler(handler(self, self.OnListChange))

	self.heroViewProxy_ = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
	self.charChipHeroFiltteredList_ = {}

	SetActive(self.roleItem_, false)
	SetActive(self.mimirItem_, false)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.battleBtnGroup_.transform)
end

function AdminSelectChipView:AddListeners()
	self:AddBtnListener(self.switchBtn_, nil, function()
		self.isMimir_ = not self.isMimir_
		self.selectID_ = 0

		self:ResetAnimInfo()
		self:RefreshUI()
	end)
	self:AddBtnListener(self.mimirChipBtn_, nil, function()
		self:Go("/chipInfo", {
			noBattle = true,
			chipManagerID = 1,
			chipDataTemplate = self.chipManagerDataTemplate_
		})
	end)
	self:AddBtnListener(self.detailBtn_, nil, function()
		if self.isMimir_ then
			self:OpenMimirDetail()
		else
			self:OpenCharDetail()
		end
	end)
	self:AddBtnListener(self.wearBtn_, nil, function()
		if self.isMimir_ then
			self:SetMimirID(self.selectID_)
		else
			self:SetCharBaseID(self.selectID_)
		end
	end)
	self:AddBtnListener(self.dropBtn_, nil, function()
		if self.isMimir_ then
			self:SetMimirID(0)
		else
			self:SetCharBaseID(0)
		end
	end)
end

function AdminSelectChipView:CameraEnter(arg_10_1)
	AdminSelectChipView.super.ReserveCameraEnter(self, arg_10_1)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		8,
		2
	})
	manager.heroRaiseTrack:SetModelState((AdminSystemTools.HeroUsingSkinInfo(1001)))
end

function AdminSelectChipView:ReserveCameraEnter(arg_11_1)
	return
end

function AdminSelectChipView:OnEnter()
	manager.ui:SetMainCamera("admin_sys_chip")
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	if not self.params_.isBack then
		self.isMimir_ = self.params_.isMimir

		if self.isMimir_ == nil then
			self.isMimir_ = not ChipTools.HasUnlockCharChip() and not ChipTools.CanUnlockAnyCharChip()
		end

		self.params_.isMimir = nil
		self.isFroming_ = self.params_.isFroming or false
		self.stageType_ = self.params_.stageType
		self.stageID_ = self.params_.stageID
		self.sectionProxy_ = self.params_.sectionProxy
		self.selectID_ = self.params_.selectID or 0

		HeroData:ResetSortValue()
		self.filterView_:Reset()
		CommonFilterData:ClearFilter(Filter_Root_Define.Hero_Filter_List.filter_id)
	end

	self.chipManagerDataTemplate_ = self.chipManagerDataTemplate_ or self:GetChipDataTemplate()

	self:SetViewParam()

	self.chipManagerList_ = self:GetChipManagerList()
	self.charChipBaseList_ = ChipTools.GetAllCharChipBaseIDList(true)
	self.charChipHeroIDList_ = {}

	for iter_12_0, iter_12_1 in ipairs(self.charChipBaseList_) do
		table.insert(self.charChipHeroIDList_, ChipCfg[iter_12_1].spec_char)
	end

	self:ResetAnimInfo()
	self:RefreshUI()
end

function AdminSelectChipView:OnExit()
	if self.filterView_ and self.filterView_.OnExit then
		self.filterView_:OnExit()
	end

	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(self.charNotice_)
	manager.redPoint:unbindUIandKey(self.mimirNotice_)
	manager.redPoint:unbindUIandKey(self.mimirChipBtn_.transform)
	manager.redPoint:unbindUIandKey(self.detailBtn_.transform)
	self:StopAlignTimer()
end

function AdminSelectChipView:OnClickCharItem(arg_14_1, arg_14_2)
	self.selectID_ = arg_14_2

	self:RefreshScrollView()
	self:RefreshBtnUI()
end

function AdminSelectChipView:OnClickMimirItem(arg_15_1, arg_15_2)
	self.selectID_ = arg_15_2

	self:RefreshScrollView()
	self:RefreshBtnUI()
end

function AdminSelectChipView:OnListChange(arg_16_1, arg_16_2, arg_16_3)
	self.charChipHeroFiltteredList_ = arg_16_1

	if #self.charChipHeroFiltteredList_ > 0 then
		if self.selectID_ then
			if ChipCfg[self.selectID_] then
				if not table.indexof(self.charChipHeroFiltteredList_, ChipCfg[self.selectID_].spec_char or 0) then
					self.selectID_ = self:GetCharChipID(self.charChipHeroFiltteredList_[1])
				end
			end
		end
	else
		self.selectID_ = 0
	end

	self:RefreshCharChipUI()
	self:RefreshBtnUI()
end

function AdminSelectChipView:OnHeroSort(arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
	self.filterView_:RefreshSort(arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
end

function AdminSelectChipView:RefreshUI()
	if self.selectID_ == 0 or self.selectID_ == nil then
		self.selectID_ = self.isMimir_ and self.chipManagerList_[1] or self.charChipBaseList_[1]
	end

	SetActive(self.btnConEx_.gameObject, self.isFroming_)
	self.switchController_:SetSelectedState(self.isMimir_ and "mimir" or "char")

	if self.isMimir_ then
		self:AlignToIndex(table.indexof(self.chipManagerList_, self.selectID_) or 1)
		SetActive(self.filterGo_, false)
	else
		local var_18_0 = self.charChipHeroIDList_

		self.filterView_:OnEnter(self.heroViewProxy_)
		self.filterView_:SetExtraSorter(function(arg_19_0, arg_19_1)
			return true, table.indexof(self.charChipHeroIDList_, arg_19_0.id) < table.indexof(self.charChipHeroIDList_, arg_19_1.id)
		end)
		self.filterView_:SetHeroIdList(var_18_0)
		self:RefreshCharChipUI()
		SetActive(self.filterGo_, true)
	end

	self:RefreshBtnUI()
end

function AdminSelectChipView:RefreshCharChipUI()
	local var_20_0 = 1

	for iter_20_0, iter_20_1 in ipairs(self.charChipHeroFiltteredList_) do
		if iter_20_1 == ((ChipCfg[self.selectID_] or nil) and (ChipCfg[self.selectID_].spec_char or 0)) then
			var_20_0 = iter_20_0

			break
		end
	end

	self:AlignToIndex(var_20_0)
end

function AdminSelectChipView:RefreshBtnUI()
	self.wearBtn_.interactable = self.isFroming_

	if self.selectID_ == 0 or self.selectID_ == nil then
		self.detailBtn_.interactable = false

		SetActive(self.detailBtn_.gameObject, false)
	else
		self.detailBtn_.interactable = true

		SetActive(self.detailBtn_.gameObject, true)
	end

	if self.isMimir_ then
		SetActive(self.mimirChipBtn_.gameObject, not self.isFroming_)

		if self.chipManagerDataTemplate_:GetChipManagerIsUnLock(self.selectID_) then
			if self.chipManagerDataTemplate_:GetISUseChipmanager(self.selectID_) then
				self.btnController_:SetSelectedState("drop")
			else
				self.btnController_:SetSelectedState("wear")
			end
		else
			self.btnController_:SetSelectedState("locked")
		end

		if self:IsCharChipCanOperate() then
			manager.redPoint:bindUIandKey(self.detailBtn_.transform, string.format("%s_%s", RedPointConst.CHIP_MANAGER, self.selectID_))
		end
	else
		SetActive(self.mimirChipBtn_.gameObject, false)

		if self:IsCharChipBaseUnlock(self.selectID_) then
			if self.selectID_ == self:GetUsingCharChipID() then
				self.btnController_:SetSelectedState("drop")
			else
				self.btnController_:SetSelectedState("wear")
			end
		else
			self.btnController_:SetSelectedState("locked")
		end

		if self:IsCharChipCanOperate() then
			manager.redPoint:bindUIandKey(self.detailBtn_.transform, string.format("%s_%s", RedPointConst.CHIP_CHAR_CHIP, self.selectID_))
		end
	end

	if self:IsCharChipCanOperate() then
		manager.redPoint:bindUIandKey(self.charNotice_, RedPointConst.CHIP_CHAR_CHIP)
		manager.redPoint:bindUIandKey(self.mimirNotice_, RedPointConst.CHIP_MANAGER_CHIP)
		manager.redPoint:bindUIandKey(self.mimirChipBtn_.transform, RedPointConst.CHIP_CHIP)
	end
end

function AdminSelectChipView:IsCharChipCanOperate()
	if self.sectionProxy_ == nil then
		return true
	end

	return self.sectionProxy_:IsCharChipCanOperate()
end

function AdminSelectChipView:IsCharChipBaseUnlock(arg_23_1)
	if self.sectionProxy_ == nil then
		return ChipTools.IsCharChipBaseUnlock(arg_23_1)
	end

	return self.sectionProxy_:IsCharChipBaseUnlock(arg_23_1)
end

function AdminSelectChipView:OpenMimirDetail()
	if self.isFroming_ then
		self:Go("/battleChipManager", {
			chipManagerID = self.selectID_,
			stageType = self.stageType_,
			stageID = self.stageID_,
			sectionProxy = self.sectionProxy_
		})
	else
		self:Go("/chipManager", {
			chipManagerID = self.selectID_
		})
	end
end

function AdminSelectChipView:OpenCharDetail()
	self:Go("/charChip", {
		baseID = self.selectID_,
		stageType = self.stageType_,
		stageID = self.stageID_,
		sectionProxy = self.sectionProxy_
	})
end

function AdminSelectChipView:SetMimirID(arg_26_1)
	self.chipManagerDataTemplate_:SetUseChipmanagerId(arg_26_1)
	self.chipManagerDataTemplate_.sectionProxy_:SetMimirID(arg_26_1)

	if arg_26_1 == 0 then
		ShowTips("CHIP_MANAGER_UNLOAD_SUCCESS")
	else
		ShowTips("CHIP_MANAGER_USE_SUCCESS")
	end

	self:RefreshScrollView()
	self:RefreshBtnUI()
end

function AdminSelectChipView:SetCharBaseID(arg_27_1)
	self.sectionProxy_:SetCharChipBaseID(arg_27_1)

	if arg_27_1 == 0 then
		ShowTips("CHIP_CHAR_UNLOAD_SUCCESS")
	else
		self.chipManagerDataTemplate_:SetUseChipmanagerId(0)
		ShowTips("CHIP_CHAR_USE_SUCCESS")
	end

	self:RefreshScrollView()
	self:RefreshBtnUI()
end

function AdminSelectChipView:Dispose()
	AdminSelectChipView.super.Dispose(self)

	for iter_28_0, iter_28_1 in ipairs(self.itemPoolChar_) do
		iter_28_1.itemView:Dispose()
	end

	self.itemPoolChar_ = nil

	for iter_28_2, iter_28_3 in ipairs(self.itemPoolMimir_) do
		iter_28_3.itemView:Dispose()
	end

	self.itemPoolMimir_ = nil

	self:ResetAnimInfo()
	self.loopScrollView_:Dispose()

	self.loopScrollView_ = nil

	if self.filterView_ then
		self.filterView_:Dispose()

		self.filterView_ = nil
	end
end

function AdminSelectChipView:GetChipDataTemplate()
	return ChipManagerDataTemplate.New({
		id = self.defaultSelectID_,
		unlockChipManagerIDList_ = self:GetUnlockChipManagerList(),
		unlockChipIDList_ = self:GetUnlockChipList()
	})
end

local function var_0_2(arg_30_0)
	local var_30_0 = {}
	local var_30_1 = {}
	local var_30_2 = {}
	local var_30_3 = ChipData:GetUnlockChipManagerIDList()

	for iter_30_0, iter_30_1 in pairs((ChipData:GetChipManagerList())) do
		if iter_30_0 ~= arg_30_0 then
			if table.keyof(var_30_3, iter_30_0) then
				table.insert(var_30_0, iter_30_0)
			elseif IsConditionAchieved(ChipCfg[iter_30_0].new_condition) then
				table.insert(var_30_1, iter_30_0)
			else
				table.insert(var_30_2, iter_30_0)
			end
		end
	end

	table.sort(var_30_0, function(arg_31_0, arg_31_1)
		return arg_31_0 < arg_31_1
	end)
	table.sort(var_30_1, function(arg_32_0, arg_32_1)
		return arg_32_0 < arg_32_1
	end)
	table.sort(var_30_2, function(arg_33_0, arg_33_1)
		return arg_33_0 < arg_33_1
	end)

	local var_30_4 = {}

	table.insertto(var_30_4, var_30_1)
	table.insertto(var_30_4, var_30_0)
	table.insertto(var_30_4, var_30_2)

	if arg_30_0 ~= 0 then
		table.insert(var_30_4, 1, arg_30_0)
	end

	if manager.guide:IsPlaying() then
		local var_30_5 = table.indexof(var_30_4, 6)

		if var_30_5 then
			table.remove(var_30_4, var_30_5)
			table.insert(var_30_4, 1, 6)
		end
	end

	return var_30_4
end

function AdminSelectChipView:GetChipManagerList()
	return var_0_2((ChipData:GetEnabledChipManagerID()))
end

function AdminSelectChipView:GetUnlockChipManagerList()
	return ChipData:GetUnlockChipManagerIDList()
end

function AdminSelectChipView:GetUnlockChipList()
	return ChipData:GetUnlockChipIDList()
end

function AdminSelectChipView:SetViewParam()
	self.chipManagerDataTemplate_:SetTeamInfo(self.params_.stageType, self.params_.stageID, self.params_.sectionProxy and self.params_.sectionProxy or SectionSelectHeroTools.GetProxyClass(self.params_.stageType).New({
		section = self.params_.stageID,
		sectionType = self.params_.stageType
	}, self.params_.reserveParams or ReserveTools.GetReserveParams(self.params_.stageType, self.params_.stageID)))
end

function AdminSelectChipView:GetCharChipID(arg_38_1)
	for iter_38_0, iter_38_1 in ipairs(self.charChipBaseList_) do
		if arg_38_1 == ChipCfg[iter_38_1].spec_char then
			return iter_38_1
		end
	end

	return 0
end

function AdminSelectChipView:GetUsingCharChipID()
	return self.isFroming_ and self.sectionProxy_:GetCharChipBaseID() or 0
end

function AdminSelectChipView:LsRemoveItem(arg_40_1)
	arg_40_1.itemView:Show(false)

	arg_40_1.isFree = true
end

function AdminSelectChipView:GetFreeItem(arg_41_1, arg_41_2)
	for iter_41_0, iter_41_1 in pairs(arg_41_1) do
		if iter_41_1.isFree == true then
			iter_41_1.isFree = false

			return iter_41_1
		end
	end

	local var_41_0 = {
		isFree = false,
		itemView = arg_41_2()
	}

	table.insert(arg_41_1, var_41_0)

	return var_41_0
end

function AdminSelectChipView:LsAddItem(arg_42_1, arg_42_2)
	local var_42_0

	if arg_42_1.type == var_0_1.CHAR then
		var_42_0 = self:GetFreeItem(self.itemPoolChar_, function()
			return AdminCharChipItem.New(self.roleItem_, self.contTrs_.gameObject)
		end)
	elseif arg_42_1.type == var_0_1.MIMIR then
		var_42_0 = self:GetFreeItem(self.itemPoolMimir_, function()
			return AdminMimirChipItem.New(self.mimirItem_, self.contTrs_.gameObject)
		end)
	end

	self:LsUpdateItem(var_42_0, arg_42_1, arg_42_2)

	return var_42_0
end

function AdminSelectChipView:LsGetItemData()
	local var_45_0 = {}

	if self.isMimir_ then
		for iter_45_0, iter_45_1 in ipairs(self.chipManagerList_) do
			table.insert(var_45_0, {
				type = var_0_1.MIMIR,
				id = iter_45_1
			})
		end
	else
		for iter_45_2, iter_45_3 in ipairs(self.charChipHeroFiltteredList_) do
			table.insert(var_45_0, {
				type = var_0_1.CHAR,
				id = self:GetCharChipID(iter_45_3)
			})
		end
	end

	return var_45_0
end

function AdminSelectChipView:LsUpdateItem(arg_46_1, arg_46_2, arg_46_3)
	local var_46_0 = self.animInfo_[arg_46_2.id]

	if not self.animInfo_[arg_46_2.id] then
		var_46_0 = {}
		self.animInfo_[arg_46_2.id] = var_46_0
	end

	local var_46_1

	if arg_46_2.type == var_0_1.CHAR then
		local var_46_2 = self:GetCharChipID(self.charChipHeroFiltteredList_[arg_46_3])

		var_46_1 = var_46_2 == self.selectID_

		arg_46_1.itemView:SetData(arg_46_2.id, arg_46_3, var_46_1, var_46_2 == self:GetUsingCharChipID(), var_46_0, self.sectionProxy_)
	elseif arg_46_2.type == var_0_1.MIMIR then
		arg_46_1.itemView:SetTemplateData(self.chipManagerDataTemplate_)

		var_46_1 = self.chipManagerList_[arg_46_3] == self.selectID_

		arg_46_1.itemView:SetData(arg_46_2.id, arg_46_3, var_46_1, var_46_0)
	end

	if var_46_1 then
		self.selectedItem_ = arg_46_1.itemView
	end
end

function AdminSelectChipView:ResetAnimInfo()
	self.animInfo_ = {}
end

function AdminSelectChipView:AlignToIndex(arg_48_1)
	if self.isMimir_ then
		local var_48_0 = #self.chipManagerList_ or #self.charChipHeroFiltteredList_

		if var_48_0 == 0 then
			self.loopScrollView_:DeleteAllItem()

			return
		end

		if var_48_0 < arg_48_1 + 2 then
			self.loopScrollView_:NavigateIndex(math.max(arg_48_1 - 2, 1))

			goto label_48_0
		end
	end

	self.loopScrollView_:NavigateIndex(arg_48_1)

	::label_48_0::

	local var_48_1 = self.loopScrollView_:GetItemList()

	if #var_48_1 <= 0 then
		return
	end

	if var_48_1[1].itemView.index_ == arg_48_1 then
		self.scroll_.horizontalNormalizedPosition = 0

		return
	end

	if var_48_1[#var_48_1].itemView.index_ == arg_48_1 then
		self.scroll_.horizontalNormalizedPosition = 1

		return
	end
end

function AdminSelectChipView:StartAlignTimer()
	self:StopAlignTimer()

	self.alignTimer_ = FrameTimer.New(function()
		self:AlignFunc()
	end, 1, -1)

	self.alignTimer_:Start()
end

function AdminSelectChipView:StopAlignTimer()
	if self.alignTimer_ then
		self.alignTimer_:Stop()

		self.alignTimer_ = nil
	end
end

function AdminSelectChipView:AlignFunc()
	if not self.selectedItem_ then
		self:StopAlignTimer()

		return
	end

	local var_52_0 = self.selectedItem_.transform_.localPosition.x + self.selectedItem_.transform_.rect.width + self.contTrs_.localPosition.x

	if self.selectedItem_.transform_.localPosition.x + self.contTrs_.localPosition.x < 0 then
		self.contTrs_.localPosition = Vector3(self.contTrs_.localPosition.x + -(self.selectedItem_.transform_.localPosition.x + self.contTrs_.localPosition.x), self.contTrs_.localPosition.y, 0)
	elseif self.viewTrs_.rect.width < var_52_0 then
		self.contTrs_.localPosition = Vector3(self.contTrs_.localPosition.x - (var_52_0 - self.viewTrs_.rect.width), self.contTrs_.localPosition.y, 0)
	elseif self.selectedItem_:GetAnimTime() > 0.999 then
		self:StopAlignTimer()
	end
end

function AdminSelectChipView:RefreshScrollView()
	self.loopScrollView_:RefreshScrollView(false, true)
	self:StartAlignTimer()
end

return AdminSelectChipView
