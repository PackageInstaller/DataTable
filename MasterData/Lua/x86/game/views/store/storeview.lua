local StoreView = class("StoreView", ReduxView)

function StoreView:UIName()
	return "Widget/System/Bag/BagUI"
end

function StoreView:UIParent()
	return manager.ui.uiMain.transform
end

function StoreView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.uiList_ = LuaList.New(handler(self, self.IndexItem), self.uiListGo_, CommonItemView)
	self.showEquipController_ = self.controllerEx_:GetController("equip")
	self.showNothingController_ = self.controllerEx_:GetController("nothing")
	self.equipPositionController_ = self.equipPositionControllerEx_:GetController("tab")
	self.leftBtnList_ = {
		[StoreConst.STORE_TYPE.MATERIAL] = StoreBtnView.New(self.materialGo_, CommonBtnTypeConst.STORE, StoreConst.STORE_TYPE.MATERIAL),
		[StoreConst.STORE_TYPE.HERO_PIECE] = StoreBtnView.New(self.heroPieceGo_, CommonBtnTypeConst.STORE, StoreConst.STORE_TYPE.HERO_PIECE),
		[StoreConst.STORE_TYPE.EQUIP] = StoreBtnView.New(self.equipGo_, CommonBtnTypeConst.STORE, StoreConst.STORE_TYPE.EQUIP),
		[StoreConst.STORE_TYPE.GIFT] = StoreBtnView.New(self.giftGo_, CommonBtnTypeConst.STORE, StoreConst.STORE_TYPE.GIFT),
		[StoreConst.STORE_TYPE.MEMORY] = StoreBtnView.New(self.memoryGo_, CommonBtnTypeConst.STORE, StoreConst.STORE_TYPE.MEMORY)
	}
	self.OnSwitchStoreTypeHandler_ = handler(self, self.OnSwitchStoreType)
	self.OnSwitchSortEquipHandler_ = handler(self, self.OnSwitchSortEquip)
	self.OnSwitchSortEquipRareHandler_ = handler(self, self.OnSwitchSortEquipRare)
	self.OnMaterialUpdateHandler_ = handler(self, self.OnMaterialUpdate)
	self.OnMaterialListUpdateHandler_ = handler(self, self.OnMaterialListUpdate)
	self.OnEquipListUpdateHandler_ = handler(self, self.OnEquipListUpdate)
	self.OnEquipLockUpdateHandler_ = handler(self, self.OnEquipLockUpdate)
	self.OnEquipFilterUpdateHandler_ = handler(self, self.OnEquipFilterUpdate)
	self.OnMaterialExpriedHandler_ = handler(self, self.CheckExpiredList)
	self.OnBackHandler_ = handler(self, self.OnBack)
	self.storeItemInfoView_ = StoreItemInfo.New(self.itemInfoGo_)
	self.storeEquipInfoView_ = StoreEquipInfo.New(self.equipInfoGo_)
	self.storeEquipFilterPanel_ = StoreEquipFilterPanel.New(self.equipFilterGo_)

	self:InitEquipFilterParams()
end

function StoreView:OnEnter()
	self:CheckExpiredList()
	manager.notify:RegistListener(COMMON_BTN_TYPE_SWITCH, self.OnSwitchStoreTypeHandler_)
	manager.notify:RegistListener(SWITCH_SORT, self.OnSwitchSortEquipHandler_)
	manager.notify:RegistListener(SWITCH_SORT_RARE, self.OnSwitchSortEquipRareHandler_)
	manager.notify:RegistListener(CURRENCY_UPDATE, self.OnMaterialListUpdateHandler_)
	manager.notify:RegistListener(MATERIAL_MODIFY, self.OnMaterialUpdateHandler_)
	manager.notify:RegistListener(MATERIAL_LIST_UPDATE, self.OnMaterialListUpdateHandler_)
	manager.notify:RegistListener(FUKUBURO_LIST_UPDATE, self.OnMaterialListUpdateHandler_)
	manager.notify:RegistListener(EQUIP_LIST_UPDATE, self.OnEquipListUpdateHandler_)
	manager.notify:RegistListener(EQUIP_LOCK, self.OnEquipLockUpdateHandler_)
	manager.notify:RegistListener(EQUIP_FILTER_SELECT_APPLY, self.OnEquipFilterUpdateHandler_)
	manager.notify:RegistListener(MATERIAL_EXPIRED, self.OnMaterialExpriedHandler_)
	manager.notify:RegistListener(PLAY_STORY_FINISH, self.OnBackHandler_)

	if self.params_.isBack then
		self.selectStoreType_ = self.selectStoreType_ or self.params_.type or StoreConst.STORE_TYPE.MATERIAL
		self.params_.type = nil
	else
		self.lastPosition_ = nil
		self.selectID_ = nil
		self.selectIndex_ = 0
		self.selectStoreType_ = self.params_.type or StoreConst.STORE_TYPE.MATERIAL

		self:InitEquipFilterParams()
	end

	self:RefreshData()

	if self.params_.isBack then
		self:RevertLastSelectIndex()
	end

	self:RefreshUI(self.params_.isBack)

	self.params_.isBack = false

	self.storeItemInfoView_:OnEnter()
	self.storeEquipInfoView_:OnEnter()
	self:StartTimer()
end

function StoreView:OnTop()
	self:UpdateBar()

	if self.params_.type and self.selectStoreType_ ~= self.params_.type then
		self.selectStoreType_ = self.params_.type
		self.lastPosition_ = nil
		self.selectID_ = nil
		self.selectIndex_ = 0

		self:RefreshData()
		self:RefreshUI()
	end
end

function StoreView:OnExit()
	manager.notify:RemoveListener(COMMON_BTN_TYPE_SWITCH, self.OnSwitchStoreTypeHandler_)
	manager.notify:RemoveListener(SWITCH_SORT, self.OnSwitchSortEquipHandler_)
	manager.notify:RemoveListener(SWITCH_SORT_RARE, self.OnSwitchSortEquipRareHandler_)
	manager.notify:RemoveListener(CURRENCY_UPDATE, self.OnMaterialListUpdateHandler_)
	manager.notify:RemoveListener(MATERIAL_MODIFY, self.OnMaterialUpdateHandler_)
	manager.notify:RemoveListener(MATERIAL_LIST_UPDATE, self.OnMaterialListUpdateHandler_)
	manager.notify:RemoveListener(FUKUBURO_LIST_UPDATE, self.OnMaterialListUpdateHandler_)
	manager.notify:RemoveListener(EQUIP_LIST_UPDATE, self.OnEquipListUpdateHandler_)
	manager.notify:RemoveListener(EQUIP_LOCK, self.OnEquipLockUpdateHandler_)
	manager.notify:RemoveListener(EQUIP_FILTER_SELECT_APPLY, self.OnEquipFilterUpdateHandler_)
	manager.notify:RemoveListener(MATERIAL_EXPIRED, self.OnMaterialExpriedHandler_)
	manager.notify:RemoveListener(PLAY_STORY_FINISH, self.OnBackHandler_)

	self.lastPosition_ = self.uiList_:GetScrolledPosition()

	self.storeItemInfoView_:OnExit()
	self.storeEquipInfoView_:OnExit()
	self:StopTimer()
	manager.windowBar:HideBar()
end

function StoreView:Dispose()
	self.OnSwitchStoreTypeHandler_ = nil
	self.OnSwitchSortEquipHandler_ = nil
	self.OnSwitchSortEquipRareHandler_ = nil
	self.OnMaterialUpdateHandler_ = nil
	self.OnMaterialListUpdateHandler_ = nil
	self.OnEquipListUpdateHandler_ = nil
	self.OnEquipLockUpdateHandler_ = nil
	self.OnEquipFilterUpdateHandler_ = nil
	self.OnMaterialExpriedHandler_ = nil
	self.OnBackHandler_ = nil

	self.storeEquipFilterPanel_:Dispose()

	self.storeEquipFilterPanel_ = nil

	self.storeItemInfoView_:Dispose()

	self.storeItemInfoView_ = nil

	self.storeEquipInfoView_:Dispose()

	self.storeEquipInfoView_ = nil

	for iter_7_0, iter_7_1 in ipairs(self.leftBtnList_) do
		iter_7_1:Dispose()
	end

	self.leftBtnList_ = nil

	StoreView.super.Dispose(self)
	self.uiList_:Dispose()

	self.uiList_ = nil
end

function StoreView:AddListeners()
	for iter_8_0 = 0, 6 do
		self:AddBtnListener(self[string.format("equipPositionBtn%s_", iter_8_0)], nil, function()
			if self.equipFilterParams_.position == iter_8_0 then
				return
			end

			self.equipFilterParams_.position = iter_8_0

			self.equipPositionController_:SetSelectedState(tostring(iter_8_0))
			self:RefreshData()
			self:RefreshUI()
		end)
	end
end

function StoreView:UpdateBar()
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

function StoreView:CheckExpiredList()
	local var_11_0 = self:GetHideItemList()
	local var_11_1 = {}

	for iter_11_0, iter_11_1 in ipairs((MaterialData:CheckExpiredMaterialList())) do
		if not table.keyof(var_11_0, iter_11_1.id) then
			table.insert(var_11_1, iter_11_1)
		end
	end

	for iter_11_2, iter_11_3 in ipairs((CurrencyData:CheckExpiredCurrencyList())) do
		if not table.keyof(var_11_0, iter_11_3.id) then
			table.insert(var_11_1, iter_11_3)
		end
	end

	if #var_11_1 > 0 then
		JumpTools.OpenPageByJump("bagExpired", {
			expiredList = var_11_1
		})
		MaterialAction.ReadExpiredMaterial()
		CurrencyAction.ReadExpiredCurrency()

		return true
	end

	return false
end

function StoreView:OnSwitchStoreType(arg_12_1, arg_12_2)
	if arg_12_1 ~= CommonBtnTypeConst.STORE then
		return
	end

	if self.selectStoreType_ ~= arg_12_2 then
		self.selectStoreType_ = arg_12_2
		self.selectIndex_ = 1

		self:RefreshData()
		self:RefreshUI()
	end
end

function StoreView:OnSwitchSortEquip()
	self.equipFilterParams_.order = self.equipFilterParams_.order == ItemConst.SORT_TYPE.DOWN and ItemConst.SORT_TYPE.UP or ItemConst.SORT_TYPE.DOWN

	self:RefreshData()
	self:RefreshUI()
end

function StoreView:OnSwitchSortEquipRare(arg_14_1)
	if self.equipFilterParams_.priority ~= arg_14_1 then
		self.equipFilterParams_.priority = arg_14_1 == 0 and EquipConst.EQUIP_SORT.LEVEL or EquipConst.EQUIP_SORT.RARE
	end

	self:RefreshData()
	self:RefreshUI()
end

function StoreView:OnMaterialUpdate(arg_15_1, arg_15_2, arg_15_3)
	if arg_15_1 == CurrencyConst.CURRENCY_TYPE_VITALITY then
		return
	end

	if self.selectStoreType_ ~= StoreConst.STORE_TYPE.MATERIAL and self.selectStoreType_ ~= StoreConst.STORE_TYPE.GIFT then
		return
	end

	for iter_15_0, iter_15_1 in pairs(self.itemList_) do
		if iter_15_1.id == arg_15_1 and iter_15_1.timeValid == arg_15_2 then
			iter_15_1.number = arg_15_3
		end
	end

	self:RefreshSelectItem()
end

function StoreView:OnMaterialListUpdate()
	if self.selectStoreType_ ~= StoreConst.STORE_TYPE.MATERIAL and self.selectStoreType_ ~= StoreConst.STORE_TYPE.GIFT then
		return
	end

	self:RefreshData()
	self:RefreshUI()
end

function StoreView:OnEquipListUpdate()
	self:RefreshData()
	self:RefreshUI()
end

function StoreView:OnEquipLockUpdate(arg_18_1)
	if self.selectStoreType_ ~= StoreConst.STORE_TYPE.EQUIP then
		return
	end

	local var_18_0 = arg_18_1.equipID

	for iter_18_0, iter_18_1 in pairs((self.uiList_:GetItemList())) do
		if iter_18_1:GetData().equip_id == var_18_0 then
			iter_18_1:RefreshEquipLock(arg_18_1.lock)
		end
	end

	for iter_18_2, iter_18_3 in pairs(self.itemList_) do
		if iter_18_3.equip_id == var_18_0 then
			iter_18_3.equipedLocked = arg_18_1.lock
		end
	end
end

function StoreView:OnEquipFilterUpdate(arg_19_1)
	self.equipFilterParams_.suit = clone(arg_19_1.suitList)
	self.equipFilterParams_.skill = clone(arg_19_1.skillList)

	self:RefreshData()
	self:RefreshUI()
end

function StoreView:OnBack()
	self:RefreshUI()
	self:UpdateBar()
end

function StoreView:StartTimer()
	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			self:UpdateTimer()
		end, 1, -1)
	end

	self.timer_:Start()
	self:RefreshTimeTag()
end

function StoreView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function StoreView:UpdateTimer()
	self:RefreshTimeTag()

	if self.selectStoreType_ ~= StoreConst.STORE_TYPE.MATERIAL then
		return
	end

	for iter_24_0, iter_24_1 in pairs((self.uiList_:GetItemList())) do
		iter_24_1:RefreshCountdown(iter_24_1:GetData())
	end
end

function StoreView:RefreshTimeTag()
	local var_25_0
	local var_25_1 = manager.time:GetServerTime()

	for iter_25_0, iter_25_1 in ipairs(self.materialList_ or {}) do
		local var_25_2 = ItemTools.GetItemExpiredTimeByInfo(iter_25_1)

		if var_25_2 > 0 then
			if var_25_0 == nil then
				var_25_0 = var_25_2
			elseif var_25_2 < var_25_0 then
				var_25_0 = var_25_2
			end
		end
	end

	if not var_25_0 then
		SetActive(self.timeGo_, false)

		return
	end

	self.timeText_.text = ItemTools.GetItemCountdownText(var_25_0)

	SetActive(self.timeGo_, true)
end

function StoreView:UpdatePageItemDataList()
	self.itemList_ = {}

	local var_26_0 = self:GetMaterialDataList()

	self.materialList_ = clone(var_26_0)

	if self.selectStoreType_ == StoreConst.STORE_TYPE.MATERIAL then
		self.itemList_ = var_26_0
	elseif self.selectStoreType_ == StoreConst.STORE_TYPE.HERO_PIECE then
		self.itemList_ = self:GetHeroPieceData()
	elseif self.selectStoreType_ == StoreConst.STORE_TYPE.EQUIP then
		self.itemList_ = self:GetEquipData()
	elseif self.selectStoreType_ == StoreConst.STORE_TYPE.GIFT then
		self.itemList_ = self:GetGiftData()
	elseif self.selectStoreType_ == StoreConst.STORE_TYPE.MEMORY then
		self.itemList_ = self:GetMemoryData()
	end
end

function StoreView:GetMemoryData()
	local var_27_0 = {}

	for iter_27_0, iter_27_1 in pairs(StoreTools.GetMaterialListByTypes({
		ItemConst.ITEM_TYPE.MATERIAL
	})) do
		if iter_27_1.num > 0 and ItemCfg[iter_27_1.id].sub_type == ItemConst.ITEM_SUB_TYPE.MEMORY_ITEM then
			local var_27_1 = clone(ItemTemplateData)

			var_27_1.id = iter_27_1.id
			var_27_1.number = iter_27_1.num

			table.insert(var_27_0, var_27_1)
		end
	end

	for iter_27_2, iter_27_3 in pairs(StoreTools.GetMaterialListByTypes({
		ItemConst.ITEM_TYPE.PROPS
	})) do
		if iter_27_3.num > 0 and (ItemCfg[iter_27_3.id].sub_type == ItemConst.ITEM_SUB_TYPE.BIRTHDAY_ITEM or ItemCfg[iter_27_3.id].sub_type == ItemConst.ITEM_SUB_TYPE.STORY_ITEM) then
			local var_27_2 = clone(ItemTemplateData)

			var_27_2.id = iter_27_3.id
			var_27_2.number = iter_27_3.num

			table.insert(var_27_0, var_27_2)
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

function StoreView:InitEquipFilterParams()
	self.equipFilterParams_ = {
		position = 0,
		order = ItemConst.SORT_TYPE.DOWN,
		priority = EquipConst.EQUIP_SORT.LEVEL,
		suit = {},
		skill = {}
	}
end

function StoreView:GetMaterialDataList()
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

function StoreView:GetHideItemList()
	return {
		InviteData:GetDataByPara("drawItemId")
	}
end

function StoreView:GetHeroPieceData()
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

		if ItemCfg[arg_34_0.id].rare == ItemCfg[arg_34_1.id].rare then
			return var_34_0.id > var_34_1.id
		else
			return var_34_0.rare > var_34_1.rare
		end
	end)

	return var_33_0
end

function StoreView:GetEquipData()
	local var_35_0 = {}
	local var_35_1 = HeroTools.GetEquipMap(HeroData:GetHeroList())

	for iter_35_0, iter_35_1 in pairs((EquipData:GetEquipListComplex(self.equipFilterParams_.order, self.equipFilterParams_.priority, self.equipFilterParams_.position, self.equipFilterParams_.suit, self.equipFilterParams_.skill))) do
		local var_35_2 = clone(ItemTemplateData)

		var_35_2.id = iter_35_1.prefab_id
		var_35_2.equipLevel = EquipTools.CountEquipLevel(iter_35_1)
		var_35_2.equip_id = iter_35_1.equip_id
		var_35_2.equipEnchantCount = iter_35_1:GetEnchantCount()

		if iter_35_1.race == 0 or table.keyof(RaceEffectCfg.all, iter_35_1.race) ~= nil then
			var_35_2.race = iter_35_1.race or 0
			var_35_2.bindHeroID = 0
		else
			if not HeroCfg[iter_35_1.race].race then
				var_35_2.race = 0
			end

			var_35_2.bindHeroID = iter_35_1.race
		end

		var_35_2.equipedLocked = iter_35_1.is_lock or false

		if var_35_1[iter_35_1.equip_id] ~= nil then
			var_35_2.equipedHeroID = var_35_1[iter_35_1.equip_id] or 0
		end

		table.insert(var_35_0, var_35_2)
	end

	return var_35_0
end

function StoreView:GetGiftData()
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

	if ItemTools.getItemNum(30011) > 0 then
		local var_36_3 = clone(ItemTemplateData)

		var_36_3.id = 30011
		var_36_3.number = ItemTools.getItemNum(30011)

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

function StoreView:RefreshData()
	self:UpdatePageItemDataList()
end

function StoreView:RefreshUI(arg_39_1)
	self:SetSelectItemIndex(self.selectIndex_ or 1)
	self:SwitchEquipPanel()

	if self.lastPosition_ ~= nil then
		self.uiList_:StartScrollByPosition(#self.itemList_, self.lastPosition_)

		self.lastPosition_ = nil
	else
		self.uiList_:StartScroll(#self.itemList_, self.selectIndex_)
	end

	self:RefreshEmptyPanel()
	self:RefreshStoreBtn()
	self:RefreshSelectItem(arg_39_1)
end

function StoreView:RefreshEmptyPanel()
	if #self.itemList_ <= 0 then
		self.showNothingController_:SetSelectedState("true")

		if self.selectStoreType_ == StoreConst.STORE_TYPE.MATERIAL then
			OperationRecorder.Record("BagView", "material")

			self.nothingText_.text = GetTips("NO_MATERIAL")
		elseif self.selectStoreType_ == StoreConst.STORE_TYPE.HERO_PIECE then
			OperationRecorder.Record("BagView", "qingbao")

			self.nothingText_.text = GetTips("NO_HERO_PIECE")
		elseif self.selectStoreType_ == StoreConst.STORE_TYPE.EQUIP then
			OperationRecorder.Record("BagView", "equip")

			self.nothingText_.text = GetTips("NO_EQUIP")
		elseif self.selectStoreType_ == StoreConst.STORE_TYPE.GIFT then
			OperationRecorder.Record("BagView", "gift")

			self.nothingText_.text = GetTips("NO_GIFT")
		elseif self.selectStoreType_ == StoreConst.STORE_TYPE.MEMORY then
			OperationRecorder.Record("BagView", "memeory")

			self.nothingText_.text = GetTips("NO_MEMORY")
		end
	else
		self.showNothingController_:SetSelectedState("false")
	end
end

function StoreView:IndexItem(arg_41_1, arg_41_2)
	self.itemList_[arg_41_1].clickFun = function(arg_42_0)
		OperationRecorder.Record("NewBagView", "bag_qingbao_item")
		self:SetSelectItemIndex(arg_41_1)
		self:RefreshSelectItem()
	end
	self.itemList_[arg_41_1].need_count_down = true

	arg_41_2:SetData(self.itemList_[arg_41_1])
end

function StoreView:RevertLastSelectIndex()
	if self.selectID_ == nil then
		return
	end

	for iter_43_0, iter_43_1 in pairs(self.itemList_) do
		if self.selectStoreType_ == StoreConst.STORE_TYPE.EQUIP then
			if iter_43_1.equip_id == self.selectID_ then
				if self.selectIndex_ ~= iter_43_0 then
					self.lastPosition_ = nil
					self.selectIndex_ = iter_43_0
				end

				return
			end
		elseif iter_43_1.id == self.selectID_ then
			if self.selectIndex_ ~= iter_43_0 then
				self.lastPosition_ = nil
				self.selectIndex_ = iter_43_0
			end

			return
		end
	end

	self.selectIndex_ = 1
end

function StoreView:SetSelectItemIndex(arg_44_1)
	if arg_44_1 > #self.itemList_ then
		arg_44_1 = 1
	end

	if arg_44_1 == 0 and #self.itemList_ > 0 then
		arg_44_1 = 1
	end

	if #self.itemList_ <= 0 then
		arg_44_1 = 0
	end

	self.selectIndex_ = arg_44_1

	if arg_44_1 == 0 then
		self.selectID_ = nil

		return
	end

	for iter_44_0, iter_44_1 in ipairs(self.itemList_) do
		self.itemList_[iter_44_0].selectStyle2 = iter_44_0 == arg_44_1
	end

	self.selectID_ = self.selectStoreType_ == StoreConst.STORE_TYPE.EQUIP and self.itemList_[arg_44_1].equip_id or self.itemList_[arg_44_1].id
end

function StoreView:RefreshSelectItem(arg_45_1)
	if self.selectIndex_ > #self.itemList_ or self.selectIndex_ < 1 then
		return
	end

	local var_45_0 = self.itemList_[self.selectIndex_]

	if self.selectStoreType_ == StoreConst.STORE_TYPE.EQUIP then
		self.storeEquipInfoView_:SetData(var_45_0, arg_45_1)
	else
		self.storeItemInfoView_:SetData(var_45_0, arg_45_1)
	end

	for iter_45_0, iter_45_1 in pairs(self.uiList_:GetItemList()) do
		iter_45_1:SetData(self.itemList_[iter_45_0])
	end
end

function StoreView:RefreshStoreBtn()
	for iter_46_0, iter_46_1 in pairs(self.leftBtnList_) do
		iter_46_1:RefreshUI(self.selectStoreType_)
	end
end

function StoreView:SwitchEquipPanel()
	if self.selectStoreType_ == StoreConst.STORE_TYPE.EQUIP then
		self.showEquipController_:SetSelectedState("true")
		self.storeEquipFilterPanel_:RefreshUI(self.equipFilterParams_, self.equipFilterParams_.position)
		self.equipPositionController_:SetSelectedState(tostring(self.equipFilterParams_.position))
	else
		self.showEquipController_:SetSelectedState("false")
	end
end

return StoreView
