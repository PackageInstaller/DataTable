local var_0_0 = class("AdminSelectChipView", ReduxView)
local var_0_1 = {
	MIMIR = 2,
	CHAR = 1
}

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Administrators/AdministratorsHelpBattleUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.switchController_ = arg_3_0.switchConEx_:GetController("switch")
	arg_3_0.btnController_ = arg_3_0.btnConEx_:GetController("state")
	arg_3_0.contTrs_ = arg_3_0.scroll_.content
	arg_3_0.viewTrs_ = arg_3_0.scroll_.viewport

	local var_3_0 = 999999
	local var_3_1 = arg_3_0.contTrs_:GetComponent("HorizontalLayoutGroup").spacing

	arg_3_0.loopScrollView_ = LoopScrollView.New(arg_3_0, arg_3_0.scroll_, arg_3_0.contTrs_, arg_3_0.viewTrs_, var_3_0, var_3_1, nil, true)
	arg_3_0.itemPoolChar_ = {}
	arg_3_0.itemPoolMimir_ = {}
	arg_3_0.animInfo_ = {}
	arg_3_0.filterView_ = NewHeroListFilterView.New(arg_3_0.filterGo_)

	arg_3_0.filterView_:SetListChangeHandler(handler(arg_3_0, arg_3_0.OnListChange))

	arg_3_0.heroViewProxy_ = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
	arg_3_0.charChipHeroFiltteredList_ = {}

	SetActive(arg_3_0.roleItem_, false)
	SetActive(arg_3_0.mimirItem_, false)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_3_0.battleBtnGroup_.transform)
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.switchBtn_, nil, function()
		arg_4_0.isMimir_ = not arg_4_0.isMimir_
		arg_4_0.selectID_ = 0

		arg_4_0:ResetAnimInfo()
		arg_4_0:RefreshUI()
	end)
	arg_4_0:AddBtnListener(arg_4_0.mimirChipBtn_, nil, function()
		arg_4_0:Go("/chipInfo", {
			noBattle = true,
			chipManagerID = 1,
			chipDataTemplate = arg_4_0.chipManagerDataTemplate_
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.detailBtn_, nil, function()
		if arg_4_0.isMimir_ then
			arg_4_0:OpenMimirDetail()
		else
			arg_4_0:OpenCharDetail()
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.wearBtn_, nil, function()
		if arg_4_0.isMimir_ then
			arg_4_0:SetMimirID(arg_4_0.selectID_)
		else
			arg_4_0:SetCharBaseID(arg_4_0.selectID_)
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.dropBtn_, nil, function()
		if arg_4_0.isMimir_ then
			arg_4_0:SetMimirID(0)
		else
			arg_4_0:SetCharBaseID(0)
		end
	end)
end

function var_0_0.CameraEnter(arg_10_0, arg_10_1)
	var_0_0.super.ReserveCameraEnter(arg_10_0, arg_10_1)

	local var_10_0 = AdminSystemTools.HeroUsingSkinInfo(1001)

	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		8,
		2
	})
	manager.heroRaiseTrack:SetModelState(var_10_0)
end

function var_0_0.ReserveCameraEnter(arg_11_0, arg_11_1)
	return
end

function var_0_0.OnEnter(arg_12_0)
	manager.ui:SetMainCamera("admin_sys_chip")
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	if not arg_12_0.params_.isBack then
		arg_12_0.isMimir_ = arg_12_0.params_.isMimir

		if arg_12_0.isMimir_ == nil then
			arg_12_0.isMimir_ = not ChipTools.HasUnlockCharChip() and not ChipTools.CanUnlockAnyCharChip()
		end

		arg_12_0.params_.isMimir = nil
		arg_12_0.isFroming_ = arg_12_0.params_.isFroming or false
		arg_12_0.stageType_ = arg_12_0.params_.stageType
		arg_12_0.stageID_ = arg_12_0.params_.stageID
		arg_12_0.sectionProxy_ = arg_12_0.params_.sectionProxy
		arg_12_0.selectID_ = arg_12_0.params_.selectID or 0

		HeroData:ResetSortValue()
		arg_12_0.filterView_:Reset()
		CommonFilterData:ClearFilter(Filter_Root_Define.Hero_Filter_List.filter_id)
	end

	if not arg_12_0.chipManagerDataTemplate_ then
		arg_12_0.chipManagerDataTemplate_ = arg_12_0:GetChipDataTemplate()
	end

	arg_12_0:SetViewParam()

	arg_12_0.chipManagerList_ = arg_12_0:GetChipManagerList()
	arg_12_0.charChipBaseList_ = ChipTools.GetAllCharChipBaseIDList(true)
	arg_12_0.charChipHeroIDList_ = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.charChipBaseList_) do
		table.insert(arg_12_0.charChipHeroIDList_, ChipCfg[iter_12_1].spec_char)
	end

	arg_12_0:ResetAnimInfo()
	arg_12_0:RefreshUI()
end

function var_0_0.OnExit(arg_13_0)
	if arg_13_0.filterView_ and arg_13_0.filterView_.OnExit then
		arg_13_0.filterView_:OnExit()
	end

	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(arg_13_0.charNotice_)
	manager.redPoint:unbindUIandKey(arg_13_0.mimirNotice_)
	manager.redPoint:unbindUIandKey(arg_13_0.mimirChipBtn_.transform)
	manager.redPoint:unbindUIandKey(arg_13_0.detailBtn_.transform)
	arg_13_0:StopAlignTimer()
end

function var_0_0.OnClickCharItem(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0.selectID_ = arg_14_2

	arg_14_0:RefreshScrollView()
	arg_14_0:RefreshBtnUI()
end

function var_0_0.OnClickMimirItem(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0.selectID_ = arg_15_2

	arg_15_0:RefreshScrollView()
	arg_15_0:RefreshBtnUI()
end

function var_0_0.OnListChange(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_0.charChipHeroFiltteredList_ = arg_16_1

	if #arg_16_0.charChipHeroFiltteredList_ > 0 then
		if arg_16_0.selectID_ and not table.indexof(arg_16_0.charChipHeroFiltteredList_, ChipCfg[arg_16_0.selectID_] and ChipCfg[arg_16_0.selectID_].spec_char or 0) then
			arg_16_0.selectID_ = arg_16_0:GetCharChipID(arg_16_0.charChipHeroFiltteredList_[1])
		end
	else
		arg_16_0.selectID_ = 0
	end

	arg_16_0:RefreshCharChipUI()
	arg_16_0:RefreshBtnUI()
end

function var_0_0.OnHeroSort(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
	arg_17_0.filterView_:RefreshSort(arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
end

function var_0_0.RefreshUI(arg_18_0)
	if arg_18_0.selectID_ == 0 or arg_18_0.selectID_ == nil then
		if arg_18_0.isMimir_ then
			arg_18_0.selectID_ = arg_18_0.chipManagerList_[1]
		else
			arg_18_0.selectID_ = arg_18_0.charChipBaseList_[1]
		end
	end

	SetActive(arg_18_0.btnConEx_.gameObject, arg_18_0.isFroming_)
	arg_18_0.switchController_:SetSelectedState(arg_18_0.isMimir_ and "mimir" or "char")

	if arg_18_0.isMimir_ then
		local var_18_0 = table.indexof(arg_18_0.chipManagerList_, arg_18_0.selectID_) or 1

		arg_18_0:AlignToIndex(var_18_0)
		SetActive(arg_18_0.filterGo_, false)
	else
		local var_18_1 = arg_18_0.charChipHeroIDList_

		arg_18_0.filterView_:OnEnter(arg_18_0.heroViewProxy_)
		arg_18_0.filterView_:SetExtraSorter(function(arg_19_0, arg_19_1)
			local var_19_0 = table.indexof(arg_18_0.charChipHeroIDList_, arg_19_0.id)
			local var_19_1 = table.indexof(arg_18_0.charChipHeroIDList_, arg_19_1.id)

			return true, var_19_0 < var_19_1
		end)
		arg_18_0.filterView_:SetHeroIdList(var_18_1)
		arg_18_0:RefreshCharChipUI()
		SetActive(arg_18_0.filterGo_, true)
	end

	arg_18_0:RefreshBtnUI()
end

function var_0_0.RefreshCharChipUI(arg_20_0)
	local var_20_0 = 1
	local var_20_1 = ChipCfg[arg_20_0.selectID_] and ChipCfg[arg_20_0.selectID_].spec_char or 0

	for iter_20_0, iter_20_1 in ipairs(arg_20_0.charChipHeroFiltteredList_) do
		if iter_20_1 == var_20_1 then
			var_20_0 = iter_20_0

			break
		end
	end

	arg_20_0:AlignToIndex(var_20_0)
end

function var_0_0.RefreshBtnUI(arg_21_0)
	arg_21_0.wearBtn_.interactable = arg_21_0.isFroming_

	if arg_21_0.selectID_ == 0 or arg_21_0.selectID_ == nil then
		arg_21_0.detailBtn_.interactable = false

		SetActive(arg_21_0.detailBtn_.gameObject, false)
	else
		arg_21_0.detailBtn_.interactable = true

		SetActive(arg_21_0.detailBtn_.gameObject, true)
	end

	if arg_21_0.isMimir_ then
		SetActive(arg_21_0.mimirChipBtn_.gameObject, not arg_21_0.isFroming_)

		if arg_21_0.chipManagerDataTemplate_:GetChipManagerIsUnLock(arg_21_0.selectID_) then
			if arg_21_0.chipManagerDataTemplate_:GetISUseChipmanager(arg_21_0.selectID_) then
				arg_21_0.btnController_:SetSelectedState("drop")
			else
				arg_21_0.btnController_:SetSelectedState("wear")
			end
		else
			arg_21_0.btnController_:SetSelectedState("locked")
		end

		if arg_21_0:IsCharChipCanOperate() then
			manager.redPoint:bindUIandKey(arg_21_0.detailBtn_.transform, string.format("%s_%s", RedPointConst.CHIP_MANAGER, arg_21_0.selectID_))
		end
	else
		SetActive(arg_21_0.mimirChipBtn_.gameObject, false)

		if arg_21_0:IsCharChipBaseUnlock(arg_21_0.selectID_) then
			if arg_21_0.selectID_ == arg_21_0:GetUsingCharChipID() then
				arg_21_0.btnController_:SetSelectedState("drop")
			else
				arg_21_0.btnController_:SetSelectedState("wear")
			end
		else
			arg_21_0.btnController_:SetSelectedState("locked")
		end

		if arg_21_0:IsCharChipCanOperate() then
			manager.redPoint:bindUIandKey(arg_21_0.detailBtn_.transform, string.format("%s_%s", RedPointConst.CHIP_CHAR_CHIP, arg_21_0.selectID_))
		end
	end

	if arg_21_0:IsCharChipCanOperate() then
		manager.redPoint:bindUIandKey(arg_21_0.charNotice_, RedPointConst.CHIP_CHAR_CHIP)
		manager.redPoint:bindUIandKey(arg_21_0.mimirNotice_, RedPointConst.CHIP_MANAGER_CHIP)
		manager.redPoint:bindUIandKey(arg_21_0.mimirChipBtn_.transform, RedPointConst.CHIP_CHIP)
	end
end

function var_0_0.IsCharChipCanOperate(arg_22_0)
	if arg_22_0.sectionProxy_ == nil then
		return true
	end

	return arg_22_0.sectionProxy_:IsCharChipCanOperate()
end

function var_0_0.IsCharChipBaseUnlock(arg_23_0, arg_23_1)
	if arg_23_0.sectionProxy_ == nil then
		return ChipTools.IsCharChipBaseUnlock(arg_23_1)
	end

	return arg_23_0.sectionProxy_:IsCharChipBaseUnlock(arg_23_1)
end

function var_0_0.OpenMimirDetail(arg_24_0)
	if arg_24_0.isFroming_ then
		arg_24_0:Go("/battleChipManager", {
			chipManagerID = arg_24_0.selectID_,
			stageType = arg_24_0.stageType_,
			stageID = arg_24_0.stageID_,
			sectionProxy = arg_24_0.sectionProxy_
		})
	else
		arg_24_0:Go("/chipManager", {
			chipManagerID = arg_24_0.selectID_
		})
	end
end

function var_0_0.OpenCharDetail(arg_25_0)
	arg_25_0:Go("/charChip", {
		baseID = arg_25_0.selectID_,
		stageType = arg_25_0.stageType_,
		stageID = arg_25_0.stageID_,
		sectionProxy = arg_25_0.sectionProxy_
	})
end

function var_0_0.SetMimirID(arg_26_0, arg_26_1)
	arg_26_0.chipManagerDataTemplate_:SetUseChipmanagerId(arg_26_1)
	arg_26_0.chipManagerDataTemplate_.sectionProxy_:SetMimirID(arg_26_1)

	if arg_26_1 == 0 then
		ShowTips("CHIP_MANAGER_UNLOAD_SUCCESS")
	else
		ShowTips("CHIP_MANAGER_USE_SUCCESS")
	end

	arg_26_0:RefreshScrollView()
	arg_26_0:RefreshBtnUI()
end

function var_0_0.SetCharBaseID(arg_27_0, arg_27_1)
	arg_27_0.sectionProxy_:SetCharChipBaseID(arg_27_1)

	if arg_27_1 == 0 then
		ShowTips("CHIP_CHAR_UNLOAD_SUCCESS")
	else
		arg_27_0.chipManagerDataTemplate_:SetUseChipmanagerId(0)
		ShowTips("CHIP_CHAR_USE_SUCCESS")
	end

	arg_27_0:RefreshScrollView()
	arg_27_0:RefreshBtnUI()
end

function var_0_0.Dispose(arg_28_0)
	var_0_0.super.Dispose(arg_28_0)

	for iter_28_0, iter_28_1 in ipairs(arg_28_0.itemPoolChar_) do
		iter_28_1.itemView:Dispose()
	end

	arg_28_0.itemPoolChar_ = nil

	for iter_28_2, iter_28_3 in ipairs(arg_28_0.itemPoolMimir_) do
		iter_28_3.itemView:Dispose()
	end

	arg_28_0.itemPoolMimir_ = nil

	arg_28_0:ResetAnimInfo()
	arg_28_0.loopScrollView_:Dispose()

	arg_28_0.loopScrollView_ = nil

	if arg_28_0.filterView_ then
		arg_28_0.filterView_:Dispose()

		arg_28_0.filterView_ = nil
	end
end

function var_0_0.GetChipDataTemplate(arg_29_0)
	return ChipManagerDataTemplate.New({
		id = arg_29_0.defaultSelectID_,
		unlockChipManagerIDList_ = arg_29_0:GetUnlockChipManagerList(),
		unlockChipIDList_ = arg_29_0:GetUnlockChipList()
	})
end

local function var_0_2(arg_30_0)
	local var_30_0 = ChipData:GetChipManagerList()
	local var_30_1 = {}
	local var_30_2 = {}
	local var_30_3 = {}
	local var_30_4 = ChipData:GetUnlockChipManagerIDList()

	for iter_30_0, iter_30_1 in pairs(var_30_0) do
		if iter_30_0 ~= arg_30_0 then
			if table.keyof(var_30_4, iter_30_0) then
				table.insert(var_30_1, iter_30_0)
			elseif IsConditionAchieved(ChipCfg[iter_30_0].new_condition) then
				table.insert(var_30_2, iter_30_0)
			else
				table.insert(var_30_3, iter_30_0)
			end
		end
	end

	table.sort(var_30_1, function(arg_31_0, arg_31_1)
		return arg_31_0 < arg_31_1
	end)
	table.sort(var_30_2, function(arg_32_0, arg_32_1)
		return arg_32_0 < arg_32_1
	end)
	table.sort(var_30_3, function(arg_33_0, arg_33_1)
		return arg_33_0 < arg_33_1
	end)

	local var_30_5 = {}

	table.insertto(var_30_5, var_30_2)
	table.insertto(var_30_5, var_30_1)
	table.insertto(var_30_5, var_30_3)

	if arg_30_0 ~= 0 then
		table.insert(var_30_5, 1, arg_30_0)
	end

	if manager.guide:IsPlaying() then
		local var_30_6 = table.indexof(var_30_5, 6)

		if var_30_6 then
			table.remove(var_30_5, var_30_6)
			table.insert(var_30_5, 1, 6)
		end
	end

	return var_30_5
end

function var_0_0.GetChipManagerList(arg_34_0)
	local var_34_0 = ChipData:GetEnabledChipManagerID()

	return var_0_2(var_34_0)
end

function var_0_0.GetUnlockChipManagerList(arg_35_0)
	return ChipData:GetUnlockChipManagerIDList()
end

function var_0_0.GetUnlockChipList(arg_36_0)
	return ChipData:GetUnlockChipIDList()
end

function var_0_0.SetViewParam(arg_37_0)
	local var_37_0

	if arg_37_0.params_.sectionProxy then
		var_37_0 = arg_37_0.params_.sectionProxy
	else
		local var_37_1 = arg_37_0.params_.reserveParams or ReserveTools.GetReserveParams(arg_37_0.params_.stageType, arg_37_0.params_.stageID)

		var_37_0 = SectionSelectHeroTools.GetProxyClass(arg_37_0.params_.stageType).New({
			section = arg_37_0.params_.stageID,
			sectionType = arg_37_0.params_.stageType
		}, var_37_1)
	end

	arg_37_0.chipManagerDataTemplate_:SetTeamInfo(arg_37_0.params_.stageType, arg_37_0.params_.stageID, var_37_0)
end

function var_0_0.GetCharChipID(arg_38_0, arg_38_1)
	for iter_38_0, iter_38_1 in ipairs(arg_38_0.charChipBaseList_) do
		if arg_38_1 == ChipCfg[iter_38_1].spec_char then
			return iter_38_1
		end
	end

	return 0
end

function var_0_0.GetUsingCharChipID(arg_39_0)
	return arg_39_0.isFroming_ and arg_39_0.sectionProxy_:GetCharChipBaseID() or 0
end

function var_0_0.LsRemoveItem(arg_40_0, arg_40_1)
	arg_40_1.itemView:Show(false)

	arg_40_1.isFree = true
end

function var_0_0.GetFreeItem(arg_41_0, arg_41_1, arg_41_2)
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

function var_0_0.LsAddItem(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0

	if arg_42_1.type == var_0_1.CHAR then
		var_42_0 = arg_42_0:GetFreeItem(arg_42_0.itemPoolChar_, function()
			return AdminCharChipItem.New(arg_42_0.roleItem_, arg_42_0.contTrs_.gameObject)
		end)
	elseif arg_42_1.type == var_0_1.MIMIR then
		var_42_0 = arg_42_0:GetFreeItem(arg_42_0.itemPoolMimir_, function()
			return AdminMimirChipItem.New(arg_42_0.mimirItem_, arg_42_0.contTrs_.gameObject)
		end)
	end

	arg_42_0:LsUpdateItem(var_42_0, arg_42_1, arg_42_2)

	return var_42_0
end

function var_0_0.LsGetItemData(arg_45_0)
	local var_45_0 = {}

	if arg_45_0.isMimir_ then
		for iter_45_0, iter_45_1 in ipairs(arg_45_0.chipManagerList_) do
			table.insert(var_45_0, {
				type = var_0_1.MIMIR,
				id = iter_45_1
			})
		end
	else
		for iter_45_2, iter_45_3 in ipairs(arg_45_0.charChipHeroFiltteredList_) do
			local var_45_1 = arg_45_0:GetCharChipID(iter_45_3)

			table.insert(var_45_0, {
				type = var_0_1.CHAR,
				id = var_45_1
			})
		end
	end

	return var_45_0
end

function var_0_0.LsUpdateItem(arg_46_0, arg_46_1, arg_46_2, arg_46_3)
	local var_46_0 = arg_46_0.animInfo_[arg_46_2.id]

	if not var_46_0 then
		var_46_0 = {}
		arg_46_0.animInfo_[arg_46_2.id] = var_46_0
	end

	local var_46_1

	if arg_46_2.type == var_0_1.CHAR then
		local var_46_2 = arg_46_0.charChipHeroFiltteredList_[arg_46_3]
		local var_46_3 = arg_46_0:GetCharChipID(var_46_2)

		var_46_1 = var_46_3 == arg_46_0.selectID_

		arg_46_1.itemView:SetData(arg_46_2.id, arg_46_3, var_46_1, var_46_3 == arg_46_0:GetUsingCharChipID(), var_46_0, arg_46_0.sectionProxy_)
	elseif arg_46_2.type == var_0_1.MIMIR then
		local var_46_4 = arg_46_0.chipManagerList_[arg_46_3]

		arg_46_1.itemView:SetTemplateData(arg_46_0.chipManagerDataTemplate_)

		var_46_1 = var_46_4 == arg_46_0.selectID_

		arg_46_1.itemView:SetData(arg_46_2.id, arg_46_3, var_46_1, var_46_0)
	end

	if var_46_1 then
		arg_46_0.selectedItem_ = arg_46_1.itemView
	end
end

function var_0_0.ResetAnimInfo(arg_47_0)
	arg_47_0.animInfo_ = {}
end

function var_0_0.AlignToIndex(arg_48_0, arg_48_1)
	local var_48_0 = arg_48_0.isMimir_ and #arg_48_0.chipManagerList_ or #arg_48_0.charChipHeroFiltteredList_

	if var_48_0 == 0 then
		arg_48_0.loopScrollView_:DeleteAllItem()

		return
	end

	if var_48_0 < arg_48_1 + 2 then
		arg_48_0.loopScrollView_:NavigateIndex(math.max(arg_48_1 - 2, 1))
	else
		arg_48_0.loopScrollView_:NavigateIndex(arg_48_1)
	end

	local var_48_1 = arg_48_0.loopScrollView_:GetItemList()

	if #var_48_1 <= 0 then
		return
	end

	if var_48_1[1].itemView.index_ == arg_48_1 then
		arg_48_0.scroll_.horizontalNormalizedPosition = 0

		return
	end

	if var_48_1[#var_48_1].itemView.index_ == arg_48_1 then
		arg_48_0.scroll_.horizontalNormalizedPosition = 1

		return
	end
end

function var_0_0.StartAlignTimer(arg_49_0)
	arg_49_0:StopAlignTimer()

	arg_49_0.alignTimer_ = FrameTimer.New(function()
		arg_49_0:AlignFunc()
	end, 1, -1)

	arg_49_0.alignTimer_:Start()
end

function var_0_0.StopAlignTimer(arg_51_0)
	if arg_51_0.alignTimer_ then
		arg_51_0.alignTimer_:Stop()

		arg_51_0.alignTimer_ = nil
	end
end

function var_0_0.AlignFunc(arg_52_0)
	if not arg_52_0.selectedItem_ then
		arg_52_0:StopAlignTimer()

		return
	end

	local var_52_0 = arg_52_0.selectedItem_.transform_
	local var_52_1 = arg_52_0.contTrs_
	local var_52_2 = arg_52_0.viewTrs_
	local var_52_3 = var_52_0.localPosition.x
	local var_52_4 = var_52_3 + var_52_0.rect.width
	local var_52_5 = var_52_1.localPosition.x
	local var_52_6 = var_52_2.rect.width
	local var_52_7 = var_52_3 + var_52_5
	local var_52_8 = var_52_4 + var_52_5

	if var_52_7 < 0 then
		local var_52_9 = -var_52_7

		var_52_1.localPosition = Vector3(var_52_5 + var_52_9, var_52_1.localPosition.y, 0)
	elseif var_52_6 < var_52_8 then
		local var_52_10 = var_52_8 - var_52_6

		var_52_1.localPosition = Vector3(var_52_5 - var_52_10, var_52_1.localPosition.y, 0)
	elseif arg_52_0.selectedItem_:GetAnimTime() > 0.999 then
		arg_52_0:StopAlignTimer()
	end
end

function var_0_0.RefreshScrollView(arg_53_0)
	arg_53_0.loopScrollView_:RefreshScrollView(false, true)
	arg_53_0:StartAlignTimer()
end

return var_0_0
