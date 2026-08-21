local var_0_0 = class("StoreView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Bag/BagUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.uiList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.uiListGo_, CommonItemView)
	arg_3_0.showEquipController_ = arg_3_0.controllerEx_:GetController("equip")
	arg_3_0.showNothingController_ = arg_3_0.controllerEx_:GetController("nothing")
	arg_3_0.equipPositionController_ = arg_3_0.equipPositionControllerEx_:GetController("tab")
	arg_3_0.leftBtnList_ = {
		[StoreConst.STORE_TYPE.MATERIAL] = StoreBtnView.New(arg_3_0.materialGo_, CommonBtnTypeConst.STORE, StoreConst.STORE_TYPE.MATERIAL),
		[StoreConst.STORE_TYPE.HERO_PIECE] = StoreBtnView.New(arg_3_0.heroPieceGo_, CommonBtnTypeConst.STORE, StoreConst.STORE_TYPE.HERO_PIECE),
		[StoreConst.STORE_TYPE.EQUIP] = StoreBtnView.New(arg_3_0.equipGo_, CommonBtnTypeConst.STORE, StoreConst.STORE_TYPE.EQUIP),
		[StoreConst.STORE_TYPE.GIFT] = StoreBtnView.New(arg_3_0.giftGo_, CommonBtnTypeConst.STORE, StoreConst.STORE_TYPE.GIFT),
		[StoreConst.STORE_TYPE.MEMORY] = StoreBtnView.New(arg_3_0.memoryGo_, CommonBtnTypeConst.STORE, StoreConst.STORE_TYPE.MEMORY)
	}
	arg_3_0.OnSwitchStoreTypeHandler_ = handler(arg_3_0, arg_3_0.OnSwitchStoreType)
	arg_3_0.OnSwitchSortEquipHandler_ = handler(arg_3_0, arg_3_0.OnSwitchSortEquip)
	arg_3_0.OnSwitchSortEquipRareHandler_ = handler(arg_3_0, arg_3_0.OnSwitchSortEquipRare)
	arg_3_0.OnMaterialUpdateHandler_ = handler(arg_3_0, arg_3_0.OnMaterialUpdate)
	arg_3_0.OnMaterialListUpdateHandler_ = handler(arg_3_0, arg_3_0.OnMaterialListUpdate)
	arg_3_0.OnEquipListUpdateHandler_ = handler(arg_3_0, arg_3_0.OnEquipListUpdate)
	arg_3_0.OnEquipLockUpdateHandler_ = handler(arg_3_0, arg_3_0.OnEquipLockUpdate)
	arg_3_0.OnEquipFilterUpdateHandler_ = handler(arg_3_0, arg_3_0.OnEquipFilterUpdate)
	arg_3_0.OnMaterialExpriedHandler_ = handler(arg_3_0, arg_3_0.CheckExpiredList)
	arg_3_0.OnBackHandler_ = handler(arg_3_0, arg_3_0.OnBack)
	arg_3_0.storeItemInfoView_ = StoreItemInfo.New(arg_3_0.itemInfoGo_)
	arg_3_0.storeEquipInfoView_ = StoreEquipInfo.New(arg_3_0.equipInfoGo_)
	arg_3_0.storeEquipFilterPanel_ = StoreEquipFilterPanel.New(arg_3_0.equipFilterGo_)

	arg_3_0:InitEquipFilterParams()
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0:CheckExpiredList()
	manager.notify:RegistListener(COMMON_BTN_TYPE_SWITCH, arg_4_0.OnSwitchStoreTypeHandler_)
	manager.notify:RegistListener(SWITCH_SORT, arg_4_0.OnSwitchSortEquipHandler_)
	manager.notify:RegistListener(SWITCH_SORT_RARE, arg_4_0.OnSwitchSortEquipRareHandler_)
	manager.notify:RegistListener(CURRENCY_UPDATE, arg_4_0.OnMaterialListUpdateHandler_)
	manager.notify:RegistListener(MATERIAL_MODIFY, arg_4_0.OnMaterialUpdateHandler_)
	manager.notify:RegistListener(MATERIAL_LIST_UPDATE, arg_4_0.OnMaterialListUpdateHandler_)
	manager.notify:RegistListener(FUKUBURO_LIST_UPDATE, arg_4_0.OnMaterialListUpdateHandler_)
	manager.notify:RegistListener(EQUIP_LIST_UPDATE, arg_4_0.OnEquipListUpdateHandler_)
	manager.notify:RegistListener(EQUIP_LOCK, arg_4_0.OnEquipLockUpdateHandler_)
	manager.notify:RegistListener(EQUIP_FILTER_SELECT_APPLY, arg_4_0.OnEquipFilterUpdateHandler_)
	manager.notify:RegistListener(MATERIAL_EXPIRED, arg_4_0.OnMaterialExpriedHandler_)
	manager.notify:RegistListener(PLAY_STORY_FINISH, arg_4_0.OnBackHandler_)

	if arg_4_0.params_.isBack then
		arg_4_0.selectStoreType_ = arg_4_0.selectStoreType_ or arg_4_0.params_.type or StoreConst.STORE_TYPE.MATERIAL
		arg_4_0.params_.type = nil
	else
		arg_4_0.lastPosition_ = nil
		arg_4_0.selectID_ = nil
		arg_4_0.selectIndex_ = 0
		arg_4_0.selectStoreType_ = arg_4_0.params_.type or StoreConst.STORE_TYPE.MATERIAL

		arg_4_0:InitEquipFilterParams()
	end

	arg_4_0:RefreshData()

	if arg_4_0.params_.isBack then
		arg_4_0:RevertLastSelectIndex()
	end

	arg_4_0:RefreshUI(arg_4_0.params_.isBack)

	arg_4_0.params_.isBack = false

	arg_4_0.storeItemInfoView_:OnEnter()
	arg_4_0.storeEquipInfoView_:OnEnter()
	arg_4_0:StartTimer()
end

function var_0_0.OnTop(arg_5_0)
	arg_5_0:UpdateBar()

	if arg_5_0.params_.type and arg_5_0.selectStoreType_ ~= arg_5_0.params_.type then
		arg_5_0.selectStoreType_ = arg_5_0.params_.type
		arg_5_0.lastPosition_ = nil
		arg_5_0.selectID_ = nil
		arg_5_0.selectIndex_ = 0

		arg_5_0:RefreshData()
		arg_5_0:RefreshUI()
	end
end

function var_0_0.OnExit(arg_6_0)
	manager.notify:RemoveListener(COMMON_BTN_TYPE_SWITCH, arg_6_0.OnSwitchStoreTypeHandler_)
	manager.notify:RemoveListener(SWITCH_SORT, arg_6_0.OnSwitchSortEquipHandler_)
	manager.notify:RemoveListener(SWITCH_SORT_RARE, arg_6_0.OnSwitchSortEquipRareHandler_)
	manager.notify:RemoveListener(CURRENCY_UPDATE, arg_6_0.OnMaterialListUpdateHandler_)
	manager.notify:RemoveListener(MATERIAL_MODIFY, arg_6_0.OnMaterialUpdateHandler_)
	manager.notify:RemoveListener(MATERIAL_LIST_UPDATE, arg_6_0.OnMaterialListUpdateHandler_)
	manager.notify:RemoveListener(FUKUBURO_LIST_UPDATE, arg_6_0.OnMaterialListUpdateHandler_)
	manager.notify:RemoveListener(EQUIP_LIST_UPDATE, arg_6_0.OnEquipListUpdateHandler_)
	manager.notify:RemoveListener(EQUIP_LOCK, arg_6_0.OnEquipLockUpdateHandler_)
	manager.notify:RemoveListener(EQUIP_FILTER_SELECT_APPLY, arg_6_0.OnEquipFilterUpdateHandler_)
	manager.notify:RemoveListener(MATERIAL_EXPIRED, arg_6_0.OnMaterialExpriedHandler_)
	manager.notify:RemoveListener(PLAY_STORY_FINISH, arg_6_0.OnBackHandler_)

	arg_6_0.lastPosition_ = arg_6_0.uiList_:GetScrolledPosition()

	arg_6_0.storeItemInfoView_:OnExit()
	arg_6_0.storeEquipInfoView_:OnExit()
	arg_6_0:StopTimer()
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0.OnSwitchStoreTypeHandler_ = nil
	arg_7_0.OnSwitchSortEquipHandler_ = nil
	arg_7_0.OnSwitchSortEquipRareHandler_ = nil
	arg_7_0.OnMaterialUpdateHandler_ = nil
	arg_7_0.OnMaterialListUpdateHandler_ = nil
	arg_7_0.OnEquipListUpdateHandler_ = nil
	arg_7_0.OnEquipLockUpdateHandler_ = nil
	arg_7_0.OnEquipFilterUpdateHandler_ = nil
	arg_7_0.OnMaterialExpriedHandler_ = nil
	arg_7_0.OnBackHandler_ = nil

	arg_7_0.storeEquipFilterPanel_:Dispose()

	arg_7_0.storeEquipFilterPanel_ = nil

	arg_7_0.storeItemInfoView_:Dispose()

	arg_7_0.storeItemInfoView_ = nil

	arg_7_0.storeEquipInfoView_:Dispose()

	arg_7_0.storeEquipInfoView_ = nil

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.leftBtnList_) do
		iter_7_1:Dispose()
	end

	arg_7_0.leftBtnList_ = nil

	var_0_0.super.Dispose(arg_7_0)
	arg_7_0.uiList_:Dispose()

	arg_7_0.uiList_ = nil
end

function var_0_0.AddListeners(arg_8_0)
	for iter_8_0 = 0, 6 do
		arg_8_0:AddBtnListener(arg_8_0[string.format("equipPositionBtn%s_", iter_8_0)], nil, function()
			if arg_8_0.equipFilterParams_.position == iter_8_0 then
				return
			end

			arg_8_0.equipFilterParams_.position = iter_8_0

			arg_8_0.equipPositionController_:SetSelectedState(tostring(iter_8_0))
			arg_8_0:RefreshData()
			arg_8_0:RefreshUI()
		end)
	end
end

function var_0_0.UpdateBar(arg_10_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR,
		CurrencyConst.CURRENCY_TYPE_VITALITY,
		CurrencyConst.CURRENCY_TYPE_GOLD,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
end

function var_0_0.CheckExpiredList(arg_11_0)
	local var_11_0 = MaterialData:CheckExpiredMaterialList()
	local var_11_1 = CurrencyData:CheckExpiredCurrencyList()
	local var_11_2 = arg_11_0:GetHideItemList()
	local var_11_3 = {}

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		if not table.keyof(var_11_2, iter_11_1.id) then
			table.insert(var_11_3, iter_11_1)
		end
	end

	for iter_11_2, iter_11_3 in ipairs(var_11_1) do
		if not table.keyof(var_11_2, iter_11_3.id) then
			table.insert(var_11_3, iter_11_3)
		end
	end

	if #var_11_3 > 0 then
		JumpTools.OpenPageByJump("bagExpired", {
			expiredList = var_11_3
		})
		MaterialAction.ReadExpiredMaterial()
		CurrencyAction.ReadExpiredCurrency()

		return true
	end

	return false
end

function var_0_0.OnSwitchStoreType(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 ~= CommonBtnTypeConst.STORE then
		return
	end

	if arg_12_0.selectStoreType_ ~= arg_12_2 then
		arg_12_0.selectStoreType_ = arg_12_2
		arg_12_0.selectIndex_ = 1

		arg_12_0:RefreshData()
		arg_12_0:RefreshUI()
	end
end

function var_0_0.OnSwitchSortEquip(arg_13_0)
	if arg_13_0.equipFilterParams_.order == ItemConst.SORT_TYPE.DOWN then
		arg_13_0.equipFilterParams_.order = ItemConst.SORT_TYPE.UP
	else
		arg_13_0.equipFilterParams_.order = ItemConst.SORT_TYPE.DOWN
	end

	arg_13_0:RefreshData()
	arg_13_0:RefreshUI()
end

function var_0_0.OnSwitchSortEquipRare(arg_14_0, arg_14_1)
	if arg_14_0.equipFilterParams_.priority ~= arg_14_1 then
		if arg_14_1 == 0 then
			arg_14_0.equipFilterParams_.priority = EquipConst.EQUIP_SORT.LEVEL
		else
			arg_14_0.equipFilterParams_.priority = EquipConst.EQUIP_SORT.RARE
		end
	end

	arg_14_0:RefreshData()
	arg_14_0:RefreshUI()
end

function var_0_0.OnMaterialUpdate(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	if arg_15_1 == CurrencyConst.CURRENCY_TYPE_VITALITY then
		return
	end

	if arg_15_0.selectStoreType_ ~= StoreConst.STORE_TYPE.MATERIAL and arg_15_0.selectStoreType_ ~= StoreConst.STORE_TYPE.GIFT then
		return
	end

	for iter_15_0, iter_15_1 in pairs(arg_15_0.itemList_) do
		if iter_15_1.id == arg_15_1 and iter_15_1.timeValid == arg_15_2 then
			iter_15_1.number = arg_15_3
		end
	end

	arg_15_0:RefreshSelectItem()
end

function var_0_0.OnMaterialListUpdate(arg_16_0)
	if arg_16_0.selectStoreType_ ~= StoreConst.STORE_TYPE.MATERIAL and arg_16_0.selectStoreType_ ~= StoreConst.STORE_TYPE.GIFT then
		return
	end

	arg_16_0:RefreshData()
	arg_16_0:RefreshUI()
end

function var_0_0.OnEquipListUpdate(arg_17_0)
	arg_17_0:RefreshData()
	arg_17_0:RefreshUI()
end

function var_0_0.OnEquipLockUpdate(arg_18_0, arg_18_1)
	if arg_18_0.selectStoreType_ ~= StoreConst.STORE_TYPE.EQUIP then
		return
	end

	local var_18_0 = arg_18_1.equipID
	local var_18_1 = arg_18_1.lock
	local var_18_2 = arg_18_0.uiList_:GetItemList()

	for iter_18_0, iter_18_1 in pairs(var_18_2) do
		if iter_18_1:GetData().equip_id == var_18_0 then
			iter_18_1:RefreshEquipLock(var_18_1)
		end
	end

	for iter_18_2, iter_18_3 in pairs(arg_18_0.itemList_) do
		if iter_18_3.equip_id == var_18_0 then
			iter_18_3.equipedLocked = var_18_1
		end
	end
end

function var_0_0.OnEquipFilterUpdate(arg_19_0, arg_19_1)
	arg_19_0.equipFilterParams_.suit = clone(arg_19_1.suitList)
	arg_19_0.equipFilterParams_.skill = clone(arg_19_1.skillList)

	arg_19_0:RefreshData()
	arg_19_0:RefreshUI()
end

function var_0_0.OnBack(arg_20_0)
	arg_20_0:RefreshUI()
	arg_20_0:UpdateBar()
end

function var_0_0.StartTimer(arg_21_0)
	if arg_21_0.timer_ == nil then
		arg_21_0.timer_ = Timer.New(function()
			arg_21_0:UpdateTimer()
		end, 1, -1)
	end

	arg_21_0.timer_:Start()
	arg_21_0:RefreshTimeTag()
end

function var_0_0.StopTimer(arg_23_0)
	if arg_23_0.timer_ then
		arg_23_0.timer_:Stop()

		arg_23_0.timer_ = nil
	end
end

function var_0_0.UpdateTimer(arg_24_0)
	arg_24_0:RefreshTimeTag()

	if arg_24_0.selectStoreType_ ~= StoreConst.STORE_TYPE.MATERIAL then
		return
	end

	local var_24_0 = arg_24_0.uiList_:GetItemList()

	for iter_24_0, iter_24_1 in pairs(var_24_0) do
		iter_24_1:RefreshCountdown(iter_24_1:GetData())
	end
end

function var_0_0.RefreshTimeTag(arg_25_0)
	local var_25_0
	local var_25_1 = manager.time:GetServerTime()
	local var_25_2 = arg_25_0.materialList_ or {}

	for iter_25_0, iter_25_1 in ipairs(var_25_2) do
		local var_25_3 = ItemTools.GetItemExpiredTimeByInfo(iter_25_1)

		if var_25_3 > 0 then
			if var_25_0 == nil then
				var_25_0 = var_25_3
			elseif var_25_3 < var_25_0 then
				var_25_0 = var_25_3
			end
		end
	end

	if not var_25_0 then
		SetActive(arg_25_0.timeGo_, false)

		return
	end

	arg_25_0.timeText_.text = ItemTools.GetItemCountdownText(var_25_0)

	SetActive(arg_25_0.timeGo_, true)
end

function var_0_0.UpdatePageItemDataList(arg_26_0)
	arg_26_0.itemList_ = {}

	local var_26_0 = arg_26_0:GetMaterialDataList()

	arg_26_0.materialList_ = clone(var_26_0)

	if arg_26_0.selectStoreType_ == StoreConst.STORE_TYPE.MATERIAL then
		arg_26_0.itemList_ = var_26_0
	elseif arg_26_0.selectStoreType_ == StoreConst.STORE_TYPE.HERO_PIECE then
		arg_26_0.itemList_ = arg_26_0:GetHeroPieceData()
	elseif arg_26_0.selectStoreType_ == StoreConst.STORE_TYPE.EQUIP then
		arg_26_0.itemList_ = arg_26_0:GetEquipData()
	elseif arg_26_0.selectStoreType_ == StoreConst.STORE_TYPE.GIFT then
		arg_26_0.itemList_ = arg_26_0:GetGiftData()
	elseif arg_26_0.selectStoreType_ == StoreConst.STORE_TYPE.MEMORY then
		arg_26_0.itemList_ = arg_26_0:GetMemoryData()
	end
end

function var_0_0.GetMemoryData(arg_27_0)
	local var_27_0 = {}

	for iter_27_0, iter_27_1 in pairs(StoreTools.GetMaterialListByTypes({
		ItemConst.ITEM_TYPE.MATERIAL
	})) do
		local var_27_1 = ItemCfg[iter_27_1.id]

		if iter_27_1.num > 0 and var_27_1.sub_type == ItemConst.ITEM_SUB_TYPE.MEMORY_ITEM then
			local var_27_2 = clone(ItemTemplateData)

			var_27_2.id = iter_27_1.id
			var_27_2.number = iter_27_1.num

			table.insert(var_27_0, var_27_2)
		end
	end

	for iter_27_2, iter_27_3 in pairs(StoreTools.GetMaterialListByTypes({
		ItemConst.ITEM_TYPE.PROPS
	})) do
		local var_27_3 = ItemCfg[iter_27_3.id]

		if iter_27_3.num > 0 and (var_27_3.sub_type == ItemConst.ITEM_SUB_TYPE.BIRTHDAY_ITEM or var_27_3.sub_type == ItemConst.ITEM_SUB_TYPE.STORY_ITEM) then
			local var_27_4 = clone(ItemTemplateData)

			var_27_4.id = iter_27_3.id
			var_27_4.number = iter_27_3.num

			table.insert(var_27_0, var_27_4)
		end
	end

	table.sort(var_27_0, function(arg_28_0, arg_28_1)
		local var_28_0 = ItemCfg[arg_28_0.id]
		local var_28_1 = ItemCfg[arg_28_1.id]
		local var_28_2 = ItemTools.GetItemExpiredTimeByInfo(arg_28_0)
		local var_28_3 = ItemTools.GetItemExpiredTimeByInfo(arg_28_1)

		if var_28_2 == var_28_3 then
			if var_28_0.use == var_28_1.use then
				if var_28_0.type == ItemConst.ITEM_TYPE.CURRENCY and var_28_1.type ~= ItemConst.ITEM_TYPE.CURRENCY then
					return true
				elseif var_28_0.type ~= ItemConst.ITEM_TYPE.CURRENCY and var_28_1.type == ItemConst.ITEM_TYPE.CURRENCY then
					return false
				elseif var_28_0.rare == var_28_1.rare then
					return var_28_0.id > var_28_1.id
				else
					return var_28_0.rare > var_28_1.rare
				end
			else
				return var_28_0.use > var_28_1.use
			end
		elseif var_28_2 ~= 0 and var_28_3 ~= 0 then
			return var_28_2 < var_28_3
		elseif var_28_3 == 0 then
			return true
		else
			return false
		end
	end)

	return var_27_0
end

function var_0_0.InitEquipFilterParams(arg_29_0)
	arg_29_0.equipFilterParams_ = {
		position = 0,
		order = ItemConst.SORT_TYPE.DOWN,
		priority = EquipConst.EQUIP_SORT.LEVEL,
		suit = {},
		skill = {}
	}
end

function var_0_0.GetMaterialDataList(arg_30_0)
	local var_30_0 = StoreTools.getMaterialList()

	table.sort(var_30_0, function(arg_31_0, arg_31_1)
		local var_31_0 = ItemCfg[arg_31_0.id]
		local var_31_1 = ItemCfg[arg_31_1.id]
		local var_31_2 = ItemTools.GetItemExpiredTimeByInfo(arg_31_0)
		local var_31_3 = ItemTools.GetItemExpiredTimeByInfo(arg_31_1)

		if var_31_2 == var_31_3 then
			if var_31_0.use == var_31_1.use then
				if var_31_0.type == ItemConst.ITEM_TYPE.CURRENCY and var_31_1.type ~= ItemConst.ITEM_TYPE.CURRENCY then
					return true
				elseif var_31_0.type ~= ItemConst.ITEM_TYPE.CURRENCY and var_31_1.type == ItemConst.ITEM_TYPE.CURRENCY then
					return false
				elseif var_31_0.rare == var_31_1.rare then
					return var_31_0.id > var_31_1.id
				else
					return var_31_0.rare > var_31_1.rare
				end
			else
				return var_31_0.use > var_31_1.use
			end
		elseif var_31_2 ~= 0 and var_31_3 ~= 0 then
			return var_31_2 < var_31_3
		elseif var_31_3 == 0 then
			return true
		else
			return false
		end
	end)

	return var_30_0
end

function var_0_0.GetHideItemList(arg_32_0)
	return {
		InviteData:GetDataByPara("drawItemId")
	}
end

function var_0_0.GetHeroPieceData(arg_33_0)
	local var_33_0 = {}

	for iter_33_0, iter_33_1 in pairs(HeroData:GetHeroList()) do
		if iter_33_1.piece > 0 then
			local var_33_1 = clone(ItemTemplateData)

			var_33_1.id = ItemCfg[iter_33_1.id].fragment
			var_33_1.number = iter_33_1.piece

			table.insert(var_33_0, var_33_1)
		end
	end

	table.sort(var_33_0, function(arg_34_0, arg_34_1)
		local var_34_0 = ItemCfg[arg_34_0.id]
		local var_34_1 = ItemCfg[arg_34_1.id]

		if var_34_0.rare == var_34_1.rare then
			return var_34_0.id > var_34_1.id
		else
			return var_34_0.rare > var_34_1.rare
		end
	end)

	return var_33_0
end

function var_0_0.GetEquipData(arg_35_0)
	local var_35_0 = {}
	local var_35_1 = EquipData:GetEquipListComplex(arg_35_0.equipFilterParams_.order, arg_35_0.equipFilterParams_.priority, arg_35_0.equipFilterParams_.position, arg_35_0.equipFilterParams_.suit, arg_35_0.equipFilterParams_.skill)
	local var_35_2 = HeroTools.GetEquipMap(HeroData:GetHeroList())

	for iter_35_0, iter_35_1 in pairs(var_35_1) do
		local var_35_3 = clone(ItemTemplateData)

		var_35_3.id = iter_35_1.prefab_id
		var_35_3.equipLevel = EquipTools.CountEquipLevel(iter_35_1)
		var_35_3.equip_id = iter_35_1.equip_id
		var_35_3.equipEnchantCount = iter_35_1:GetEnchantCount()

		local var_35_4 = RaceEffectCfg.all
		local var_35_5 = iter_35_1.race

		if var_35_5 == 0 or table.keyof(var_35_4, var_35_5) ~= nil then
			var_35_3.race = iter_35_1.race or 0
			var_35_3.bindHeroID = 0
		else
			local var_35_6 = var_35_5

			var_35_3.race = HeroCfg[var_35_6].race or 0
			var_35_3.bindHeroID = var_35_6
		end

		var_35_3.equipedLocked = iter_35_1.is_lock or false
		var_35_3.equipedHeroID = var_35_2[iter_35_1.equip_id] ~= nil and var_35_2[iter_35_1.equip_id] or 0

		table.insert(var_35_0, var_35_3)
	end

	return var_35_0
end

function var_0_0.GetGiftData(arg_36_0)
	local var_36_0 = {}
	local var_36_1 = 30011

	for iter_36_0, iter_36_1 in pairs(StoreTools.GetMaterialListByTypes({
		ItemConst.ITEM_TYPE.ARCHIVE_GIFT
	})) do
		if iter_36_1.num > 0 then
			local var_36_2 = clone(ItemTemplateData)

			var_36_2.id = iter_36_1.id
			var_36_2.number = iter_36_1.num

			table.insert(var_36_0, var_36_2)
		end
	end

	if ItemTools.getItemNum(var_36_1) > 0 then
		local var_36_3 = clone(ItemTemplateData)

		var_36_3.id = var_36_1
		var_36_3.number = ItemTools.getItemNum(var_36_1)

		table.insert(var_36_0, var_36_3)
	end

	table.sort(var_36_0, function(arg_37_0, arg_37_1)
		local var_37_0 = ItemCfg[arg_37_0.id]
		local var_37_1 = ItemCfg[arg_37_1.id]

		if arg_37_0.id == var_36_1 and arg_37_1.id ~= var_36_1 or arg_37_0.id ~= var_36_1 and arg_37_1.id == var_36_1 then
			return math.abs(arg_37_0.id - var_36_1) < math.abs(arg_37_1.id - var_36_1)
		end

		if var_37_0.rare == var_37_1.rare then
			return var_37_0.id > var_37_1.id
		else
			return var_37_0.rare > var_37_1.rare
		end
	end)

	return var_36_0
end

function var_0_0.RefreshData(arg_38_0)
	arg_38_0:UpdatePageItemDataList()
end

function var_0_0.RefreshUI(arg_39_0, arg_39_1)
	arg_39_0:SetSelectItemIndex(arg_39_0.selectIndex_ or 1)
	arg_39_0:SwitchEquipPanel()

	if arg_39_0.lastPosition_ ~= nil then
		arg_39_0.uiList_:StartScrollByPosition(#arg_39_0.itemList_, arg_39_0.lastPosition_)

		arg_39_0.lastPosition_ = nil
	else
		arg_39_0.uiList_:StartScroll(#arg_39_0.itemList_, arg_39_0.selectIndex_)
	end

	arg_39_0:RefreshEmptyPanel()
	arg_39_0:RefreshStoreBtn()
	arg_39_0:RefreshSelectItem(arg_39_1)
end

function var_0_0.RefreshEmptyPanel(arg_40_0)
	if #arg_40_0.itemList_ <= 0 then
		arg_40_0.showNothingController_:SetSelectedState("true")

		if arg_40_0.selectStoreType_ == StoreConst.STORE_TYPE.MATERIAL then
			OperationRecorder.Record("BagView", "material")

			arg_40_0.nothingText_.text = GetTips("NO_MATERIAL")
		elseif arg_40_0.selectStoreType_ == StoreConst.STORE_TYPE.HERO_PIECE then
			OperationRecorder.Record("BagView", "qingbao")

			arg_40_0.nothingText_.text = GetTips("NO_HERO_PIECE")
		elseif arg_40_0.selectStoreType_ == StoreConst.STORE_TYPE.EQUIP then
			OperationRecorder.Record("BagView", "equip")

			arg_40_0.nothingText_.text = GetTips("NO_EQUIP")
		elseif arg_40_0.selectStoreType_ == StoreConst.STORE_TYPE.GIFT then
			OperationRecorder.Record("BagView", "gift")

			arg_40_0.nothingText_.text = GetTips("NO_GIFT")
		elseif arg_40_0.selectStoreType_ == StoreConst.STORE_TYPE.MEMORY then
			OperationRecorder.Record("BagView", "memeory")

			arg_40_0.nothingText_.text = GetTips("NO_MEMORY")
		end
	else
		arg_40_0.showNothingController_:SetSelectedState("false")
	end
end

function var_0_0.IndexItem(arg_41_0, arg_41_1, arg_41_2)
	arg_41_0.itemList_[arg_41_1].clickFun = function(arg_42_0)
		OperationRecorder.Record("NewBagView", "bag_qingbao_item")
		arg_41_0:SetSelectItemIndex(arg_41_1)
		arg_41_0:RefreshSelectItem()
	end
	arg_41_0.itemList_[arg_41_1].need_count_down = true

	arg_41_2:SetData(arg_41_0.itemList_[arg_41_1])
end

function var_0_0.RevertLastSelectIndex(arg_43_0)
	if arg_43_0.selectID_ == nil then
		return
	end

	for iter_43_0, iter_43_1 in pairs(arg_43_0.itemList_) do
		if arg_43_0.selectStoreType_ == StoreConst.STORE_TYPE.EQUIP then
			if iter_43_1.equip_id == arg_43_0.selectID_ then
				if arg_43_0.selectIndex_ ~= iter_43_0 then
					arg_43_0.lastPosition_ = nil
					arg_43_0.selectIndex_ = iter_43_0
				end

				return
			end
		elseif iter_43_1.id == arg_43_0.selectID_ then
			if arg_43_0.selectIndex_ ~= iter_43_0 then
				arg_43_0.lastPosition_ = nil
				arg_43_0.selectIndex_ = iter_43_0
			end

			return
		end
	end

	arg_43_0.selectIndex_ = 1
end

function var_0_0.SetSelectItemIndex(arg_44_0, arg_44_1)
	if arg_44_1 > #arg_44_0.itemList_ then
		arg_44_1 = 1
	end

	if arg_44_1 == 0 and #arg_44_0.itemList_ > 0 then
		arg_44_1 = 1
	end

	if #arg_44_0.itemList_ <= 0 then
		arg_44_1 = 0
	end

	arg_44_0.selectIndex_ = arg_44_1

	if arg_44_1 == 0 then
		arg_44_0.selectID_ = nil

		return
	end

	for iter_44_0, iter_44_1 in ipairs(arg_44_0.itemList_) do
		if iter_44_0 == arg_44_1 then
			arg_44_0.itemList_[iter_44_0].selectStyle2 = true
		else
			arg_44_0.itemList_[iter_44_0].selectStyle2 = false
		end
	end

	if arg_44_0.selectStoreType_ == StoreConst.STORE_TYPE.EQUIP then
		arg_44_0.selectID_ = arg_44_0.itemList_[arg_44_1].equip_id
	else
		arg_44_0.selectID_ = arg_44_0.itemList_[arg_44_1].id
	end
end

function var_0_0.RefreshSelectItem(arg_45_0, arg_45_1)
	local var_45_0 = arg_45_0.selectIndex_

	if var_45_0 > #arg_45_0.itemList_ or var_45_0 < 1 then
		return
	end

	local var_45_1 = arg_45_0.itemList_[var_45_0]

	if arg_45_0.selectStoreType_ == StoreConst.STORE_TYPE.EQUIP then
		arg_45_0.storeEquipInfoView_:SetData(var_45_1, arg_45_1)
	else
		arg_45_0.storeItemInfoView_:SetData(var_45_1, arg_45_1)
	end

	for iter_45_0, iter_45_1 in pairs(arg_45_0.uiList_:GetItemList()) do
		iter_45_1:SetData(arg_45_0.itemList_[iter_45_0])
	end
end

function var_0_0.RefreshStoreBtn(arg_46_0)
	for iter_46_0, iter_46_1 in pairs(arg_46_0.leftBtnList_) do
		iter_46_1:RefreshUI(arg_46_0.selectStoreType_)
	end
end

function var_0_0.SwitchEquipPanel(arg_47_0)
	if arg_47_0.selectStoreType_ == StoreConst.STORE_TYPE.EQUIP then
		arg_47_0.showEquipController_:SetSelectedState("true")
		arg_47_0.storeEquipFilterPanel_:RefreshUI(arg_47_0.equipFilterParams_, arg_47_0.equipFilterParams_.position)
		arg_47_0.equipPositionController_:SetSelectedState(tostring(arg_47_0.equipFilterParams_.position))
	else
		arg_47_0.showEquipController_:SetSelectedState("false")
	end
end

return var_0_0
