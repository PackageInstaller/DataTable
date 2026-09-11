local NewShopView = class("NewShopView", ReduxView)

function NewShopView:UIName()
	return "Widget/System/Shop/ShopUI"
end

function NewShopView:UIParent()
	return manager.ui.uiMain.transform
end

function NewShopView:Init()
	self.updateDirty_ = true

	self:InitUI()
	self:AddUIListener()
end

function NewShopView:GetTreeDataByParams()
	local var_4_0 = {}

	if self.params_.showShops then
		var_4_0 = self.params_.showShops
	else
		for iter_4_0, iter_4_1 in ipairs(ShopListCfg.get_id_list_by_system[1]) do
			if ShopListCfg[iter_4_1].show_in_shop == 1 then
				table.insert(var_4_0, iter_4_1)
			end
		end
	end

	local var_4_1 = {}

	for iter_4_2, iter_4_3 in ipairs(var_4_0) do
		if ShopTools.IsShopOpen(iter_4_3) then
			table.insert(var_4_1, iter_4_3)
		end
	end

	self.groups = {}
	self.groupIndexes = {}

	local var_4_2 = UITreeData.New()

	for iter_4_4, iter_4_5 in ipairs(var_4_1) do
		if not self.groups[ShopListCfg[iter_4_5].display_group] then
			self.groups[ShopListCfg[iter_4_5].display_group] = {
				itemIndexes_ = {}
			}

			table.insert(self.groupIndexes, ShopListCfg[iter_4_5].display_group)
		end

		self.groups[ShopListCfg[iter_4_5].display_group][ShopListCfg[iter_4_5].display_index] = ShopListCfg[iter_4_5]

		table.insert(self.groups[ShopListCfg[iter_4_5].display_group].itemIndexes_, ShopListCfg[iter_4_5].display_index)
	end

	for iter_4_6, iter_4_7 in pairs(self.groups) do
		table.sort(iter_4_7.itemIndexes_, function(arg_5_0, arg_5_1)
			return arg_5_0 < arg_5_1
		end)
	end

	table.sort(self.groupIndexes, function(arg_6_0, arg_6_1)
		return arg_6_0 < arg_6_1
	end)

	for iter_4_8, iter_4_9 in pairs(self.groupIndexes) do
		local var_4_3 = UITreeGroupData.New()

		var_4_3.text = GetI18NText(ShopListCfg.get_id_list_by_system_and_group[1][iter_4_9][1].group_name)
		var_4_3.controllerStateValue = tostring(iter_4_9)
		var_4_3.id = iter_4_9

		var_4_2.groupDatas:Add(var_4_3)
	end

	return var_4_2
end

function NewShopView:InitUI()
	self:BindCfgUI()

	self.shopController = self.controller_:GetController("shop")
	self.stateController = self.controller_:GetController("state")
	self.colorController = self.sortController_:GetController("color")
	self.tree_ = LuaTree.New(self.treeGo_)

	self.tree_:SetSelectedHandler(handler(self, self.OnGroupSelect))

	self.list1 = LuaList.New(handler(self, self.SetItem1), self.list1Go_, ExchangeItemView)
	self.equipList = LuaList.New(handler(self, self.SetEquipItem), self.equipListGo_, EquipSiftShopItem)
	self.titleTogList = {
		RechargeTitleItem.New(self.tag01_),
		RechargeTitleItem.New(self.tag02_),
		RechargeTitleItem.New(self.tag03_),
		RechargeTitleItem.New(self.tag04_),
		(RechargeTitleItem.New(self.tag05_))
	}
	self.selectSuitTable = {}
	self.selectSiftList = {}
	self.loopScrollView_ = LoopScrollView.New(self, self.diaScrollEx_, self.diaGridTrs_, self.diaViewPortTrs_, self.diaViewPortTrs_.rect.height, self.diaGridTrs_:GetComponent("VerticalLayoutGroup").spacing, true)
	self.filterBottomView_ = CommonFilterBottom.New(self.fillListGo_)

	self.filterBottomView_:RegisteClearBtnListener(handler(self, self.ClearFilter))

	self.itemListPool = {}
	self.itemEquipPool = {}
	self.itemEquipBuyPool = {}
end

function NewShopView:SetItem1(arg_8_1, arg_8_2)
	arg_8_2:SetData(self.shopDataList[arg_8_1])
end

function NewShopView:SetEquipItem(arg_9_1, arg_9_2)
	arg_9_2:SetData(self.suitList[arg_9_1], self.selectSuitTable, handler(self, self.EquipCallback), self.isClickClean)
end

function NewShopView:ClearFilter()
	self.isClickClean = true
	self.selectSuitTable = {}
	self.selectSiftList = {}

	self.equipList:StartScrollWithoutAnimator(#self.suitList, self.equipList:GetScrolledPosition())
	self.filterBottomView_:Refresh({})
end

function NewShopView:EquipCallback(arg_11_1, arg_11_2)
	self.isClickClean = nil

	if self.selectSuitTable[arg_11_1] then
		self.selectSuitTable[arg_11_1] = nil

		arg_11_2:SetSelectedState("false")

		local var_11_0

		for iter_11_0, iter_11_1 in ipairs(self.selectSiftList) do
			if iter_11_1.id == arg_11_1 then
				var_11_0 = iter_11_0
			end
		end

		table.remove(self.selectSiftList, var_11_0)
	else
		self.selectSuitTable[arg_11_1] = true

		table.insert(self.selectSiftList, {
			type = 1,
			id = arg_11_1
		})
		arg_11_2:SetSelectedState("select")
	end

	self:RefreshBottom()
end

function NewShopView:RefreshBottom()
	local var_12_0 = {}

	for iter_12_0 = 1, #self.selectSiftList do
		table.insert(var_12_0, {
			name = GetI18NText(EquipSuitCfg[self.selectSiftList[iter_12_0].id].name),
			id = 1
		})
	end

	self.filterBottomView_:Refresh(var_12_0)
end

function NewShopView:OnGroupSelect(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	self.groupInfo = self.groups[self.groupIndexes[arg_13_1]]

	if self.currentGroupIndex ~= arg_13_2 then
		self.currentItemIndex_ = nil
	end

	self.currentGroupIndex = arg_13_2

	for iter_13_0, iter_13_1 in ipairs(self.titleTogList) do
		if iter_13_0 <= #self.groupInfo.itemIndexes_ then
			SetActive(iter_13_1.gameObject_, #self.groupInfo.itemIndexes_ ~= 1)
			iter_13_1:SetData(self.groupInfo[self.groupInfo.itemIndexes_[iter_13_0]], iter_13_0, handler(self, self.ClickTitle), self.groupInfo[self.groupInfo.itemIndexes_[iter_13_0]].id)
			SetActive(self["newGo" .. iter_13_0 .. "_"], self:CheckShopRedPoint(self.groupInfo[self.groupInfo.itemIndexes_[iter_13_0]].id))
			SetActive(self["redGo" .. iter_13_0 .. "_"], self:SpecialShop(self.groupInfo[self.groupInfo.itemIndexes_[iter_13_0]].id))
		else
			SetActive(iter_13_1.gameObject_, false)
		end
	end

	for iter_13_2 = 1, 4 do
		SetActive(self["line" .. iter_13_2 .. "Go_"], iter_13_2 < #self.groupInfo.itemIndexes_)
	end

	if #self.groupInfo.itemIndexes_ == 1 then
		if #ShopListCfg[self.groupInfo[self.groupInfo.itemIndexes_[1]].id].shop_label >= 1 then
			self.stateController:SetSelectedState("state2")
		else
			self.stateController:SetSelectedState("state1")
		end
	else
		self.stateController:SetSelectedState("normal")
	end

	if self.currentGroupIndex_ == arg_13_1 then
		self:ClickTitle(self.itemToSelect_ or self.currentItemIndex_)
	else
		self:ClickTitle(self.itemToSelect_ or 1)
	end

	self.itemToSelect_ = nil

	self:EnterSendMgr(arg_13_1)
end

function NewShopView:ClickTitle(arg_14_1)
	if self.currentItemIndex_ == arg_14_1 then
		return
	end

	self.currentItemIndex_ = arg_14_1

	self:EnterSendMgr(nil, arg_14_1)

	local var_14_0 = self.groupInfo[self.groupInfo.itemIndexes_[arg_14_1]].id

	if not ShopTools.CheckShopIsUnLock(self.groupInfo[self.groupInfo.itemIndexes_[arg_14_1]].id, self.curShopId_) then
		local var_14_1 = ShopTools.GetShopIsUnLockDesc(self.groupInfo[self.groupInfo.itemIndexes_[arg_14_1]].id, self.curShopId_)

		if not string.isNullOrEmpty(var_14_1) then
			ShowTips(var_14_1)
		end
	end

	for iter_14_0, iter_14_1 in ipairs(self.titleTogList) do
		iter_14_1.controller:SetSelectedState(iter_14_0 == arg_14_1 and "false" or "true")
	end

	TimeTools.StartAfterSeconds(0.01, function()
		self:UpdateShopList(var_14_0)
		self.loopScrollView_:SetContentHeight(self.diaViewPortTrs_.rect.height)
	end, {})

	if ShopData.GetRedPointData()[self.groupInfo[self.groupInfo.itemIndexes_[arg_14_1]].id] then
		ShopAction.RemoveShopRedPoint(self.groupInfo[self.groupInfo.itemIndexes_[arg_14_1]].id)
		SetActive(self["newGo" .. arg_14_1 .. "_"], false)
	end

	if self.curShopId_ ~= self.groupInfo[self.groupInfo.itemIndexes_[arg_14_1]].id then
		self.selectSuitTable = {}
		self.selectSiftList = {}
	else
		return
	end

	self.equipData = nil
	self.clickIndex = nil
	self.isClickClean = nil
	self.copyList1 = nil
	self.copyList2 = nil

	self:UpdateBarByShopId(self.groupInfo[self.groupInfo.itemIndexes_[arg_14_1]].id)

	self.params_.shopId = self.groupInfo[self.groupInfo.itemIndexes_[arg_14_1]].id
	self.inSelect = false

	self.colorController:SetSelectedState("normal")
end

function NewShopView:UpdateBottomView()
	if self.curShopId_ == ShopConst.SHOP_ID.DAILY_SHOP then
		self.shopController:SetSelectedState("state0")

		self.refreshTimesTxt_.text = self:GetRefreshCount() ~= ShopListCfg[self.curShopId_].refresh_num_limit and GetTips("CLUB_REFRES_TEXT") .. string.format("(%d/%d)", ShopListCfg[self.curShopId_].refresh_num_limit - self:GetRefreshCount(), ShopListCfg[self.curShopId_].refresh_num_limit) or GetTips("CLUB_REFRES_TEXT") .. string.format("(<color=#FF000B>%d</color>/%d)", ShopListCfg[self.curShopId_].refresh_num_limit - self:GetRefreshCount(), ShopListCfg[self.curShopId_].refresh_num_limit)
		self.refreshCostTxt_.text = ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_TYPE_DIAMOND.item_id) < self:GetDiamondCount() and "<color=#FF000B>" .. self:GetDiamondCount() .. "</color>" or self:GetDiamondCount()

		SetActive(self.costGo_, self:GetRefreshCount() ~= ShopListCfg[self.curShopId_].refresh_num_limit)
	elseif self.curShopId_ == ShopConst.SHOP_ID.REPORT_SHOP then
		self.shopController:SetSelectedState("state2")
	elseif self.curShopId_ == ShopConst.SHOP_ID.COHOMOLOGY_TRACKS then
		self.shopController:SetSelectedState("state3")
	elseif self.curShopId_ == ShopConst.SHOP_ID.BLACK_AREA or self.curShopId_ == ShopConst.SHOP_ID.EQUIP_DEVELOP then
		self.shopController:SetSelectedState("state4")
	elseif self.curShopId_ == ShopConst.SHOP_ID.DRAW_EXCHANGE_ASSET_SHOP or self.curShopId_ == ShopConst.SHOP_ID.GUIDE_SHOP or self.curShopId_ == ShopConst.SHOP_ID.PASSPORT_SHOP or self.curShopId_ == ShopConst.SHOP_ID.NEW_DUO_WEI then
		self.shopController:SetSelectedState("state5")
	else
		self.shopController:SetSelectedState("state1")
	end

	TimeTools.StartAfterSeconds(0.01, function()
		self.loopScrollView_:SetContentHeight(self.diaViewPortTrs_.rect.height)
	end, {})
end

function NewShopView:AddEventListeners()
	self:RegistEventListener(SHOP_LIST_UPDATE, function(arg_19_0)
		if arg_19_0 == 0 or self.curShopId_ == arg_19_0 then
			self:UpdateShopList(self.curShopId_)
		end
	end)
	self:RegistEventListener(SHOP_REFRESH_ALL_SHOP, function(arg_20_0)
		self.needKeepPos1 = true

		self:OnRefreshAllShop(arg_20_0)
	end)
	self:RegistEventListener(SHOP_ITEM_UPDATE, function(arg_21_0, arg_21_1)
		if self.curShopId_ ~= arg_21_0 then
			return
		end

		self.needKeepPos1 = true

		self:RefreshList()
	end)
	self:RegistEventListener(CURRENCY_UPDATE, function(arg_22_0)
		local var_22_0 = getShopIDListByCurrency(arg_22_0)

		if var_22_0 ~= nil and #var_22_0 > 0 then
			self.needKeepPos1 = true

			self:UpdateShopList(self.curShopId_, true)
		end
	end)
end

function NewShopView:AddUIListener()
	self:AddBtnListenerScale(self.refreshBtn_, nil, function()
		if self:GetRefreshCount() >= ShopListCfg[self.curShopId_].refresh_num_limit then
			ShowTips("SHOP_REFRESH_LIMIT")

			return
		end

		if _G.SkipTip.SkipShopRefreshTip then
			ShopAction.RefreshSingleShop(ShopConst.SHOP_ID.DAILY_SHOP, self:GetDiamondCount())

			return
		end

		JumpTools.OpenPageByJump("popCostItem", {
			costId = CurrencyConst.CURRENCY_TYPE_DIAMOND,
			itemId = MaterialConst.MYTHIC_REFRESH_ITEM_ID,
			popCostCallBack = function()
				OperationRecorder.Record("shop", "okRefresh")
				ShopAction.RefreshSingleShop(ShopConst.SHOP_ID.DAILY_SHOP, self:GetDiamondCount())

				_G.SkipTip.SkipShopRefreshTip = self.skipShopRefreshTip_
			end,
			ToggleCallback = function(arg_26_0)
				self.skipShopRefreshTip_ = arg_26_0

				if arg_26_0 then
					OperationRecorder.Record("shop", "toggle")
				end
			end,
			content = string.format(GetTips("MATRIX_SHOP_REFRESH"), ItemTools.getItemName(CurrencyConst.CURRENCY_TYPE_DIAMOND), self:GetDiamondCount())
		})
	end)
	self:AddBtnListener(self.heroPieceExchangeBtn_, nil, function()
		JumpTools.OpenPopUp("fragmentExchange", nil, ViewConst.SYSTEM_ID.SHOP)
	end)
	self:AddBtnListener(self.quashBtn_, nil, function()
		JumpTools.OpenPageByJump("moduleItemResolveView")
	end)
	self:AddBtnListener(self.siftBtn_, nil, function()
		SetActive(self.siftGo_, true)

		if self.isClickClean then
			self.inSelect = false
			self.selectSuitTable = {}
			self.selectSiftList = {}
		else
			self.inSelect = true
		end

		if self.copyList1 then
			self.selectSiftList = self.copyList1
		end

		if self.copyList2 then
			self.selectSuitTable = self.copyList2
		end

		self.equipList:StartScroll(#self.suitList)
		self:RefreshBottom(true)
	end)
	self:AddBtnListener(self.siftSuitBtn_, nil, function()
		SetActive(self.siftGo_, false)

		if self.isClickClean then
			self.inSelect = false
			self.isClickClean = nil
		else
			self.inSelect = true
		end

		self.selectList = self:GetSelectList()
		self.clickIndex = nil
		self.equipData = nil
		self.clickItem = nil

		self:RefreshList()

		self.copyList1 = clone(self.selectSiftList)
		self.copyList2 = clone(self.selectSuitTable)

		self.colorController:SetSelectedState(#self.selectSiftList == 0 and "normal" or "orange")
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		SetActive(self.siftGo_, false)

		self.isClickClean = nil

		if self.colorController:GetSelectedState() == "normal" then
			self.selectSuitTable = {}
			self.selectSiftList = {}
			self.isClickClean = nil
		end
	end)
end

function NewShopView:BindRedPoints()
	for iter_32_0, iter_32_1 in pairs(self.groups) do
		local var_32_0 = self.tree_:GetGroupRedPointContainerById(iter_32_0)

		if var_32_0 then
			SetActive(var_32_0, true)

			local var_32_1 = false
			local var_32_2 = false
			local var_32_3 = var_32_0.transform:Find("notice_img/Default")
			local var_32_4 = var_32_0.transform:Find("notice_img/NewRed")

			for iter_32_2, iter_32_3 in pairs(iter_32_1) do
				if self:CheckShopRedPoint(iter_32_3.id) then
					var_32_1 = true
				end

				if self:SpecialShop(iter_32_3.id) then
					var_32_2 = true
				end
			end

			SetActive(var_32_4, var_32_1)
			SetActive(var_32_3, var_32_2)
		end
	end

	manager.redPoint:bindUIandKey(self.heroPieceExchangeBtn_.transform, RedPointConst.HERO_PIECE_EXCHANGE)

	self.updateTimer_ = Timer.New(function()
		for iter_33_0, iter_33_1 in ipairs(self.titleTogList) do
			if iter_33_0 <= #self.groupInfo.itemIndexes_ then
				SetActive(self["newGo" .. iter_33_0 .. "_"], self:CheckShopRedPoint(self.groupInfo[self.groupInfo.itemIndexes_[iter_33_0]].id))
				SetActive(self["redGo" .. iter_33_0 .. "_"], self:SpecialShop(self.groupInfo[self.groupInfo.itemIndexes_[iter_33_0]].id))
			end
		end

		for iter_33_2, iter_33_3 in pairs(self.groups) do
			local var_33_0 = self.tree_:GetGroupRedPointContainerById(iter_33_2)

			if var_33_0 then
				SetActive(var_33_0, true)

				local var_33_1 = false
				local var_33_2 = false
				local var_33_3 = var_33_0.transform:Find("notice_img/Default")
				local var_33_4 = var_33_0.transform:Find("notice_img/NewRed")

				for iter_33_4, iter_33_5 in pairs(iter_33_3) do
					if self:CheckShopRedPoint(iter_33_5.id) then
						var_33_1 = true
					end

					if self:SpecialShop(iter_33_5.id) then
						var_33_2 = true
					end
				end

				SetActive(var_33_4, var_33_1)
				SetActive(var_33_3, var_33_2)
			end
		end
	end, 1, -1, 1)

	self.updateTimer_:Start()
end

function NewShopView:SpecialShop(arg_34_1)
	if ShopConst.SHOP_ID_TO_RED_CONST[arg_34_1] then
		return manager.redPoint:getTipValue(ShopConst.SHOP_ID_TO_RED_CONST[arg_34_1]) == 1
	else
		return false
	end
end

function NewShopView:CheckShopRedPoint(arg_35_1)
	return ShopData.GetRedPointData()[arg_35_1] == true
end

function NewShopView:UnBindRedPoints()
	if self.updateTimer_ then
		self.updateTimer_:Stop()

		self.updateTimer_ = nil
	end

	manager.redPoint:unbindUIandKey(self.heroPieceExchangeBtn_.transform, RedPointConst.HERO_PIECE_EXCHANGE)
end

function NewShopView:OnRefreshOneShop(arg_37_1)
	self:RefreshList()
end

function NewShopView:UpdateShopList(arg_38_1)
	self.curShopId_ = arg_38_1

	for iter_38_0, iter_38_1 in ipairs(self.itemListPool) do
		iter_38_1.itemView:OnExit()
	end

	for iter_38_2, iter_38_3 in ipairs(self.itemEquipPool) do
		iter_38_3.itemView:OnExit()
	end

	for iter_38_4, iter_38_5 in ipairs(self.itemEquipBuyPool) do
		iter_38_5.itemView:OnExit()
	end

	self.list = self.list1
	self.RefreshList = self.RefreshListType1

	if #ShopListCfg[arg_38_1].shop_label >= 1 then
		self.RefreshList = self.RefreshListType2
	end

	self:RefreshList()
	self:UpdateBottomView()
	self:UpdateTimer()
end

function NewShopView:RefreshListType1()
	local var_39_0 = ShopListCfg[self.curShopId_]

	SetActive(self.list1Go_, true)
	SetActive(self.proofGo_, false)

	self.shopDataList = ShopTools.FilterShopDataList(self.curShopId_, var_39_0.chain_last_visible == 1)
	self.shopDataList = ShopTools.CommonSort(self.shopDataList)
	self.pos = self.needKeepPos1 and self.list:GetScrolledPosition() or nil

	TimeTools.StartAfterSeconds(0.1, function()
		self.list:StartScrollWithoutAnimator(#self.shopDataList, self.pos)
	end, {})

	self.needKeepPos1 = nil

	self:UpdateBarByShopId(self.curShopId_)
end

function NewShopView:RefreshListType2()
	SetActive(self.proofGo_, true)
	SetActive(self.list1Go_, false)

	if self.isFist == nil then
		self.isFist = true
	end

	self.shopDataList = ShopTools.FilterShopDataList(self.curShopId_, ShopListCfg[self.curShopId_].chain_last_visible == 1)
	self.shopDataList = ShopTools.CommonSort(self.shopDataList)
	self.shopDataList, self.titleList, self.suitList = ShopTools.SplitDataByShopID(self.shopDataList, self.curShopId_)

	self:UpdateBarByShopId(self.curShopId_)

	if self.needKeepPos1 then
		self.needKeepPos1 = false

		self.loopScrollView_:RefreshScrollView(self.isFist)

		self.isFist = false
		self.diaScrollEx_.verticalNormalizedPosition = self.diaScrollEx_.verticalNormalizedPosition

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.diaScrollEx_.transform)

		self.diaScrollEx_.verticalNormalizedPosition = self.diaScrollEx_.verticalNormalizedPosition
	else
		self.loopScrollView_:NavigateIndex(1)

		if self.isFist then
			self.isFist = false

			TimeTools.StartAfterSeconds(0.1, function()
				self.loopScrollView_:NavigateIndex(1)
			end, {})
		end
	end

	self:UpdateBottomView()
end

function NewShopView:GetShowList(arg_43_1)
	local var_43_0 = {
		{}
	}
	local var_43_1 = 0

	self.indexList = {}

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.item1Trs_.transform)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.shopItemTrs_.transform)

	self.lineCount = math.floor((self.item1Trs_.rect.width - 20) / self.shopItemTrs_.rect.width)

	for iter_43_0 = 1, #arg_43_1 do
		var_43_1 = var_43_1 + 1
		self.indexList[iter_43_0] = var_43_1

		for iter_43_1, iter_43_2 in ipairs(arg_43_1[iter_43_0]) do
			if var_43_0[var_43_1] == nil then
				var_43_0[var_43_1] = {}
			end

			if #var_43_0[var_43_1] >= self.lineCount then
				var_43_1 = var_43_1 + 1
			end

			if var_43_0[var_43_1] == nil then
				var_43_0[var_43_1] = {}
			end

			table.insert(var_43_0[var_43_1], iter_43_2)
		end
	end

	if self.clickIndex and self.equipData then
		table.insert(var_43_0, self.clickIndex + 1, self.equipData)
	end

	return var_43_0, var_43_1
end

function NewShopView:UpdateBarByShopId(arg_44_1)
	local var_44_0 = {}

	table.insert(var_44_0, BACK_BAR)

	if self.params_.hideHomeBtn ~= 1 then
		table.insert(var_44_0, HOME_BAR)
		manager.windowBar:RegistHomeCallBack(function()
			gameContext:Go("/home", nil, nil, true)
		end)
	end

	table.insert(var_44_0, NAVI_BAR)

	local var_44_1 = {}

	for iter_44_0 = 1, #ShopListCfg[arg_44_1].cost_id do
		local var_44_2 = CurrencyIdMapCfg[ShopListCfg[arg_44_1].cost_id[iter_44_0]] and CurrencyIdMapCfg[ShopListCfg[arg_44_1].cost_id[iter_44_0]].item_id or ShopListCfg[arg_44_1].cost_id[iter_44_0]

		if var_44_2 == CurrencyIdMapCfg.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE.item_id then
			var_44_2 = CurrencyConst.GetPlatformDiamondId()
		end

		table.insert(var_44_0, var_44_2)
		table.insert(var_44_1, var_44_2)
	end

	manager.windowBar:SwitchBar(var_44_0)

	for iter_44_1 = 1, #var_44_1 do
		manager.windowBar:SetBarCanAdd(var_44_1[iter_44_1], ShopConst.ADD_CURRENCY[var_44_1[iter_44_1]] == true)
		manager.windowBar:SetBarCanClick(var_44_1[iter_44_1], true)
	end

	manager.windowBar:RegistBackCallBack(function()
		JumpTools.Back()
	end)
end

function NewShopView:SelectTreeByShopId(arg_47_1)
	if next(self.groupIndexes) == nil then
		return
	end

	local var_47_0 = -1

	for iter_47_0, iter_47_1 in ipairs(self.groupIndexes) do
		if iter_47_1 == ShopListCfg[arg_47_1].display_group then
			var_47_0 = iter_47_0
		end
	end

	local var_47_1 = -1

	for iter_47_2, iter_47_3 in ipairs(self.groups[ShopListCfg[arg_47_1].display_group].itemIndexes_) do
		if self.groups[ShopListCfg[arg_47_1].display_group][iter_47_3].id == arg_47_1 then
			var_47_1 = iter_47_2

			break
		end
	end

	if var_47_1 > 0 then
		self.itemToSelect_ = var_47_1
	end

	self.tree_:SelectGroup(var_47_0)
end

function NewShopView:OnEnter()
	self:UpdateViewByParams()
	self:InitShopByParams()
	self:AddEventListeners()
	self:BindRedPoints()
	self:SetTimer()
end

function NewShopView:InitShopByParams()
	if not self.updateDirty_ then
		return
	end

	self.curShopId_ = self.params_.goodId and ShopListCfg[getShopCfg(self.params_.goodId).shop_id].id or tonumber(self.params_.shopId or 2)
	self.currentGroupIndex_ = ShopListCfg[self.curShopId_].display_group
end

function NewShopView:UpdateViewByParams()
	if next(self.groupIndexes) == nil then
		return
	end

	self.tree_:SetData((self:GetTreeDataByParams()))

	local var_50_0 = self.params_.goodId

	if self.params_.shopId == nil and self.params_.goodId then
		self.params_.shopId = getShopCfg(self.params_.goodId).shop_id
	end

	self:SelectTreeByShopId(self.params_.shopId)
	TimeTools.StartAfterSeconds(0.1, function()
		if var_50_0 and ShopTools.IsGoodCanBuy(self.params_.shopId, var_50_0) then
			self.params_.goodId = nil

			local var_51_0 = getShopCfg(var_50_0)
			local var_51_1 = {
				id = var_50_0,
				shopId = var_51_0.shop_id
			}

			var_51_1.buyTime = ShopData.GetShop(var_51_0.shop_id)[var_50_0] ~= nil and ShopData.GetShop(var_51_0.shop_id)[var_50_0].buy_times or 0

			JumpTools.OpenPopUp("shopBuy", {
				mainShopID = self.curShopId_,
				goodInfo = var_51_1
			})
		end
	end, {})

	self.updateDirty_ = false
end

function NewShopView:OnTop()
	if self.params_.shopId == self.curShopId_ then
		self:UpdateBarByShopId(self.curShopId_)

		return
	end

	if self.curShopId_ ~= nil then
		self.needKeepPos1 = true

		self:UpdateViewByParams()
	end
end

function NewShopView:OnBehind()
	self.updateDirty_ = true
end

function NewShopView:OnExit()
	manager.windowBar:HideBar()
	SetActive(self.siftGo_, false)

	self.currentItemIndex_ = nil

	for iter_54_0, iter_54_1 in pairs(self.list1:GetItemList()) do
		iter_54_1:OnExit()
	end

	for iter_54_2, iter_54_3 in ipairs(self.itemListPool) do
		iter_54_3.itemView:OnExit()
	end

	for iter_54_4, iter_54_5 in ipairs(self.itemEquipPool) do
		iter_54_5.itemView:OnExit()
	end

	for iter_54_6, iter_54_7 in ipairs(self.itemEquipBuyPool) do
		iter_54_7.itemView:OnExit()
	end

	self.isFist = nil

	self:StopTimer()
	self:RemoveAllEventListener()
	self:UnBindRedPoints()
	self:ExitUITime()
end

function NewShopView:StopTimer()
	if self.refreshTimer_ then
		self.refreshTimer_:Stop()

		self.refreshTimer_ = nil
	end
end

function NewShopView:SetTimer()
	self:StopTimer()

	local var_56_0 = _G.gameTimer:GetNextDayFreshTime() - manager.time:GetServerTime()

	if var_56_0 < 0 then
		var_56_0 = 0
	end

	if self.curShopId_ == ShopConst.SHOP_ID.DAILY_SHOP then
		self.refreshTimeTxt_.text = string.format(GetTips("TIME_DISPLAY_8"), TimeMgr.GetInstance():GetLostTimeStrWith2Unit(_G.gameTimer:GetNextDayFreshTime()))
	elseif self.curShopId_ == ShopConst.SHOP_ID.DRAW_EXCHANGE_ASSET_SHOP then
		self.refreshTimeTxt_.text = string.format(GetTips("SHOP_LIMITED_GOOD_REFRESH_TIME"), TimeMgr.GetInstance():GetLostTimeStrWith2Unit(_G.gameTimer:GetNextMonthFreshTime()))
	elseif self.curShopId_ == ShopConst.SHOP_ID.PASSPORT_SHOP then
		self.refreshTimeTxt_.text = string.format(GetTips("SHOP_LIMITED_GOOD_REFRESH_TIME"), manager.time:GetLostTimeStrWith2Unit(ActivityData:GetActivityData(201).stopTime))
	elseif self.curShopId_ == ShopConst.SHOP_ID.GUIDE_SHOP then
		self.refreshTimeTxt_.text = string.format(GetTips("SHOP_LIMITED_GOOD_REFRESH_TIME"), TimeMgr.GetInstance():GetLostTimeStrWith2Unit(_G.gameTimer:GetNextWeekFreshTime()))
	elseif self.curShopId_ == ShopConst.SHOP_ID.NEW_DUO_WEI then
		self.refreshTimeTxt_.text = string.format(GetTips("SHOP_LIMITED_GOOD_REFRESH_TIME"), TimeMgr.GetInstance():GetLostTimeStrWith2Unit(ActivityData:GetActivityData((PolyhedronData:GetActivityID())).stopTime))
	elseif self.curShopId_ == ShopConst.SHOP_ID.REPORT_SHOP then
		self.refreshTimeTxt_.text = manager.time:GetLostTimeStrWith2Unit(self:GetReportShopRefreshTime())
	end

	self.refreshTimer_ = Timer.New(function()
		self:UpdateTimer()
	end, 1, var_56_0, 1)

	self.refreshTimer_:Start()
end

function NewShopView:UpdateTimer()
	for iter_58_0, iter_58_1 in pairs(self.list1:GetItemList()) do
		iter_58_1:UpdateTimerView()
	end

	for iter_58_2, iter_58_3 in ipairs(self.itemListPool) do
		iter_58_3.itemView:UpdateTimerView()
	end

	for iter_58_4, iter_58_5 in ipairs(self.itemEquipPool) do
		iter_58_5.itemView:UpdateTimerView()
	end

	for iter_58_6, iter_58_7 in ipairs(self.itemEquipBuyPool) do
		iter_58_7.itemView:UpdateTimerView()
	end

	if not self.waitingRefresh_ then
		if self.curShopId_ == ShopConst.SHOP_ID.DAILY_SHOP then
			if _G.gameTimer:GetNextDayFreshTime() - manager.time:GetServerTime() <= 0 then
				self:Complete()
				self:StopTimer()

				self.refreshTimeTxt_.text = string.format(GetTips("TIME_DISPLAY_8"), TimeMgr.GetInstance():GetLostTimeStrWith2Unit(_G.gameTimer:GetNextDayFreshTime(), true))

				return
			end

			self.refreshTimeTxt_.text = string.format(GetTips("TIME_DISPLAY_8"), TimeMgr.GetInstance():GetLostTimeStrWith2Unit(_G.gameTimer:GetNextDayFreshTime(), true))
		elseif self.curShopId_ == ShopConst.SHOP_ID.DRAW_EXCHANGE_ASSET_SHOP then
			self.refreshTimeTxt_.text = string.format(GetTips("SHOP_LIMITED_GOOD_REFRESH_TIME"), TimeMgr.GetInstance():GetLostTimeStrWith2Unit(_G.gameTimer:GetNextMonthFreshTime()))
		elseif self.curShopId_ == ShopConst.SHOP_ID.PASSPORT_SHOP then
			self.refreshTimeTxt_.text = string.format(GetTips("SHOP_LIMITED_GOOD_REFRESH_TIME"), manager.time:GetLostTimeStrWith2Unit(ActivityData:GetActivityData(201).stopTime))
		elseif self.curShopId_ == ShopConst.SHOP_ID.REPORT_SHOP then
			self.refreshTimeTxt_.text = string.format(GetTips("SHOP_LIMITED_GOOD_REFRESH_TIME"), manager.time:GetLostTimeStrWith2Unit(self:GetReportShopRefreshTime()))
		elseif self.curShopId_ == ShopConst.SHOP_ID.GUIDE_SHOP then
			self.refreshTimeTxt_.text = string.format(GetTips("SHOP_LIMITED_GOOD_REFRESH_TIME"), TimeMgr.GetInstance():GetLostTimeStrWith2Unit(_G.gameTimer:GetNextWeekFreshTime()))
		elseif self.curShopId_ == ShopConst.SHOP_ID.NEW_DUO_WEI then
			self.refreshTimeTxt_.text = string.format(GetTips("SHOP_LIMITED_GOOD_REFRESH_TIME"), TimeMgr.GetInstance():GetLostTimeStrWith2Unit(ActivityData:GetActivityData((PolyhedronData:GetActivityID())).stopTime))
		end
	end
end

function NewShopView:GetReportShopRefreshTime()
	if self.curShopId_ == ShopConst.SHOP_ID.REPORT_SHOP then
		return ActivityData:GetActivityRefreshTime(ShopListCfg[self.curShopId_].activity_id)
	end

	return 0
end

function NewShopView:Complete()
	self.waitingRefresh_ = true

	ShopAction.RefreshAllShop()
end

function NewShopView:OnRefreshAllShop(arg_61_1)
	if arg_61_1.result == 0 then
		if self.resumeTimer_ == nil then
			self.resumeTimer_ = Timer.New(function()
				self.waitingRefresh_ = false
				self.resumeTimer_ = nil

				self:SetTimer()
			end, 1, 1)
		end

		self.resumeTimer_:Start()
	else
		return
	end
end

function NewShopView:GetRefreshCount()
	if ShopData.GetShop(self.curShopId_) then
		return ShopData.GetShop(self.curShopId_).refreshCount
	end

	return 0
end

function NewShopView:GetDiamondCount()
	local var_64_0 = ShopData.GetShop(self.curShopId_)

	if var_64_0.refreshCount < #GameCurrencyBuySetting.all then
		return GameCurrencyBuySetting[var_64_0.refreshCount + 1].shop_money_refresh
	else
		return GameCurrencyBuySetting[#GameCurrencyBuySetting.all].shop_money_refresh
	end
end

function NewShopView:Dispose()
	if self.tree_ then
		self.tree_:Dispose()

		self.tree_ = nil
	end

	self.filterBottomView_:Dispose()

	if self.list1 then
		self.list1:Dispose()

		self.list1 = nil
	end

	if self.equipList then
		self.equipList:Dispose()

		self.equipList = nil
	end

	for iter_65_0, iter_65_1 in ipairs(self.itemListPool) do
		iter_65_1.itemView:Dispose()
	end

	for iter_65_2, iter_65_3 in ipairs(self.itemEquipPool) do
		iter_65_3.itemView:Dispose()
	end

	for iter_65_4, iter_65_5 in ipairs(self.itemEquipBuyPool) do
		iter_65_5.itemView:Dispose()
	end

	self.itemListPool = nil
	self.itemEquipPool = nil
	self.itemEquipBuyPool = nil

	for iter_65_6, iter_65_7 in ipairs(self.titleTogList) do
		iter_65_7:Dispose()
	end

	self:RemoveAllListeners()

	self.curShopId_ = nil

	NewShopView.super.Dispose(self)
end

function NewShopView:LsGetItemData()
	self.detailList, self.count = self:GetShowList(self.shopDataList)

	if self.inSelect then
		self.titleList = {}
		self.indexList = {}

		return self:GetSelectList()
	elseif ShopListCfg[self.curShopId_].shop_label ~= "" and #ShopListCfg[self.curShopId_].shop_label > 0 then
		return self.detailList
	else
		return {}
	end
end

function NewShopView:LsAddItem(arg_67_1, arg_67_2)
	local var_67_0 = self.equipData and arg_67_2 - 1 == self.clickIndex and self:GetFreeItem(self.itemEquipBuyPool, function()
		return ExchangEquipBuyItem.New(self.item3Go_, self.diaGridGo_)
	end) or arg_67_1[1][1] == nil and self:GetFreeItem(self.itemListPool, function()
		return ExchangeSplitItem.New(self.item1Go_, self.diaGridGo_)
	end) or self:GetFreeItem(self.itemEquipPool, function()
		return ExchangeEquipItem.New(self.item2Go_, self.diaGridGo_)
	end)

	var_67_0.itemView:SetData(arg_67_1, self.titleList, self.indexList, arg_67_2, handler(self, self.ClickCallBack), self.equipData)

	return var_67_0
end

function NewShopView:ClickCallBack(arg_71_1, arg_71_2)
	if self.clickIndex == nil then
		self.clickIndex = arg_71_1
		self.equipData = arg_71_2

		self.loopScrollView_:NavigateIndex(self.clickIndex)
	elseif self.equipData ~= arg_71_2 and arg_71_2 ~= nil then
		self.equipData = arg_71_2
		self.clickIndex = arg_71_1 > self.clickIndex and arg_71_1 - 1 or arg_71_1

		self.loopScrollView_:NavigateIndex(self.clickIndex)
	else
		self.clickIndex = nil
		self.equipData = nil

		self.loopScrollView_:RefreshScrollView(false, true)
	end
end

function NewShopView:LsRemoveItem(arg_72_1)
	arg_72_1.itemView:Show(false)

	arg_72_1.isFree = true
end

function NewShopView:GetFreeItem(arg_73_1, arg_73_2)
	for iter_73_0, iter_73_1 in pairs(arg_73_1) do
		if iter_73_1.isFree == true then
			iter_73_1.isFree = false

			return iter_73_1
		end
	end

	local var_73_0 = {
		isFree = false,
		itemView = arg_73_2()
	}

	table.insert(arg_73_1, var_73_0)

	return var_73_0
end

function NewShopView:GetSelectList()
	local var_74_0 = {}
	local var_74_1

	for iter_74_0, iter_74_1 in ipairs(self.shopDataList) do
		if iter_74_1[1][1] then
			var_74_1 = iter_74_1
		end
	end

	if next(self.selectSuitTable) == nil then
		self.inSelect = false

		self.colorController:SetSelectedState("normal")

		return {}
	end

	for iter_74_2, iter_74_3 in ipairs(var_74_1) do
		if self.selectSuitTable[EquipCfg[getShopCfg(iter_74_3[1].id).give_id].suit] then
			table.insert(var_74_0, iter_74_3)
		end
	end

	local var_74_2 = {}

	for iter_74_4, iter_74_5 in ipairs(var_74_0) do
		if var_74_2[1] == nil then
			var_74_2[1] = {}
		end

		table.insert(var_74_2[1], iter_74_5)

		if #var_74_2[1] >= 5 then
			-- block empty
		end
	end

	if self.equipData then
		table.insert(var_74_2, self.clickIndex + 1, self.equipData)
	end

	if next(var_74_2[1]) == nil then
		return {}
	else
		return var_74_2
	end
end

function NewShopView:LsUpdateItem(arg_75_1, arg_75_2, arg_75_3)
	arg_75_1.itemView:SetData(arg_75_2, self.titleList, self.indexList, arg_75_3, handler(self, self.ClickCallBack), self.equipData)
end

function NewShopView:EnterSendMgr(arg_76_1, arg_76_2)
	self.groupIndex_ = arg_76_1 or self.groupIndex_
	self.titleIndex_ = arg_76_2 or self.titleIndex_

	local var_76_0 = string.format("%s_%s_%s", UITimeConst.shopTransactionGifts, self.groupIndex_, self.titleIndex_)

	if self.groupIndex_ and self.titleIndex_ and var_76_0 ~= self.lastShopId_ then
		self:ExitSendMgr()
		manager.uiTime:OnEnterRoute(var_76_0, true)

		self.lastShopId_ = var_76_0
	end
end

function NewShopView:ExitSendMgr()
	if self.lastShopId_ then
		manager.uiTime:OnExitRoute(self.lastShopId_, true)
	end
end

function NewShopView:ExitUITime()
	self:ExitSendMgr()

	self.lastShopId_ = nil
	self.groupIndex_ = nil
	self.titleIndex_ = nil
end

return NewShopView
