local var_0_0 = class("NewShopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Shop/ShopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.updateDirty_ = true

	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.GetTreeDataByParams(arg_4_0)
	local var_4_0 = {}

	if arg_4_0.params_.showShops then
		var_4_0 = arg_4_0.params_.showShops
	else
		local var_4_1 = ShopListCfg.get_id_list_by_system[1]

		for iter_4_0, iter_4_1 in ipairs(var_4_1) do
			if ShopListCfg[iter_4_1].show_in_shop == 1 then
				table.insert(var_4_0, iter_4_1)
			end
		end
	end

	local var_4_2 = {}

	for iter_4_2, iter_4_3 in ipairs(var_4_0) do
		if ShopTools.IsShopOpen(iter_4_3) then
			table.insert(var_4_2, iter_4_3)
		end
	end

	arg_4_0.groups = {}
	arg_4_0.groupIndexes = {}

	local var_4_3 = UITreeData.New()

	for iter_4_4, iter_4_5 in ipairs(var_4_2) do
		local var_4_4 = ShopListCfg[iter_4_5]

		if not arg_4_0.groups[var_4_4.display_group] then
			arg_4_0.groups[var_4_4.display_group] = {
				itemIndexes_ = {}
			}

			table.insert(arg_4_0.groupIndexes, var_4_4.display_group)
		end

		arg_4_0.groups[var_4_4.display_group][var_4_4.display_index] = var_4_4

		table.insert(arg_4_0.groups[var_4_4.display_group].itemIndexes_, var_4_4.display_index)
	end

	for iter_4_6, iter_4_7 in pairs(arg_4_0.groups) do
		table.sort(iter_4_7.itemIndexes_, function(arg_5_0, arg_5_1)
			return arg_5_0 < arg_5_1
		end)
	end

	table.sort(arg_4_0.groupIndexes, function(arg_6_0, arg_6_1)
		return arg_6_0 < arg_6_1
	end)

	for iter_4_8, iter_4_9 in pairs(arg_4_0.groupIndexes) do
		local var_4_5 = UITreeGroupData.New()
		local var_4_6 = ShopListCfg.get_id_list_by_system_and_group[1][iter_4_9][1].group_name

		var_4_5.text = GetI18NText(var_4_6)
		var_4_5.controllerStateValue = tostring(iter_4_9)
		var_4_5.id = iter_4_9

		var_4_3.groupDatas:Add(var_4_5)
	end

	return var_4_3
end

function var_0_0.InitUI(arg_7_0)
	arg_7_0:BindCfgUI()

	arg_7_0.shopController = arg_7_0.controller_:GetController("shop")
	arg_7_0.stateController = arg_7_0.controller_:GetController("state")
	arg_7_0.colorController = arg_7_0.sortController_:GetController("color")
	arg_7_0.tree_ = LuaTree.New(arg_7_0.treeGo_)

	arg_7_0.tree_:SetSelectedHandler(handler(arg_7_0, arg_7_0.OnGroupSelect))

	arg_7_0.list1 = LuaList.New(handler(arg_7_0, arg_7_0.SetItem1), arg_7_0.list1Go_, ExchangeItemView)
	arg_7_0.equipList = LuaList.New(handler(arg_7_0, arg_7_0.SetEquipItem), arg_7_0.equipListGo_, EquipSiftShopItem)
	arg_7_0.titleTogList = {
		RechargeTitleItem.New(arg_7_0.tag01_),
		RechargeTitleItem.New(arg_7_0.tag02_),
		RechargeTitleItem.New(arg_7_0.tag03_),
		RechargeTitleItem.New(arg_7_0.tag04_),
		(RechargeTitleItem.New(arg_7_0.tag05_))
	}
	arg_7_0.selectSuitTable = {}
	arg_7_0.selectSiftList = {}

	local var_7_0 = arg_7_0.diaViewPortTrs_.rect.height
	local var_7_1 = arg_7_0.diaGridTrs_:GetComponent("VerticalLayoutGroup").spacing

	arg_7_0.loopScrollView_ = LoopScrollView.New(arg_7_0, arg_7_0.diaScrollEx_, arg_7_0.diaGridTrs_, arg_7_0.diaViewPortTrs_, var_7_0, var_7_1, true)
	arg_7_0.filterBottomView_ = CommonFilterBottom.New(arg_7_0.fillListGo_)

	arg_7_0.filterBottomView_:RegisteClearBtnListener(handler(arg_7_0, arg_7_0.ClearFilter))

	arg_7_0.itemListPool = {}
	arg_7_0.itemEquipPool = {}
	arg_7_0.itemEquipBuyPool = {}
end

function var_0_0.SetItem1(arg_8_0, arg_8_1, arg_8_2)
	arg_8_2:SetData(arg_8_0.shopDataList[arg_8_1])
end

function var_0_0.SetEquipItem(arg_9_0, arg_9_1, arg_9_2)
	arg_9_2:SetData(arg_9_0.suitList[arg_9_1], arg_9_0.selectSuitTable, handler(arg_9_0, arg_9_0.EquipCallback), arg_9_0.isClickClean)
end

function var_0_0.ClearFilter(arg_10_0)
	arg_10_0.isClickClean = true
	arg_10_0.selectSuitTable = {}
	arg_10_0.selectSiftList = {}

	arg_10_0.equipList:StartScrollWithoutAnimator(#arg_10_0.suitList, arg_10_0.equipList:GetScrolledPosition())
	arg_10_0.filterBottomView_:Refresh({})
end

function var_0_0.EquipCallback(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.isClickClean = nil

	if arg_11_0.selectSuitTable[arg_11_1] then
		arg_11_0.selectSuitTable[arg_11_1] = nil

		arg_11_2:SetSelectedState("false")

		local var_11_0

		for iter_11_0, iter_11_1 in ipairs(arg_11_0.selectSiftList) do
			if iter_11_1.id == arg_11_1 then
				var_11_0 = iter_11_0
			end
		end

		table.remove(arg_11_0.selectSiftList, var_11_0)
	else
		arg_11_0.selectSuitTable[arg_11_1] = true

		table.insert(arg_11_0.selectSiftList, {
			type = 1,
			id = arg_11_1
		})
		arg_11_2:SetSelectedState("select")
	end

	arg_11_0:RefreshBottom()
end

function var_0_0.RefreshBottom(arg_12_0)
	local var_12_0 = {}
	local var_12_1 = 1

	for iter_12_0 = 1, #arg_12_0.selectSiftList do
		table.insert(var_12_0, {
			name = GetI18NText(EquipSuitCfg[arg_12_0.selectSiftList[iter_12_0].id].name),
			id = var_12_1
		})

		var_12_1 = var_12_1 + 1
	end

	arg_12_0.filterBottomView_:Refresh(var_12_0)
end

function var_0_0.OnGroupSelect(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	local var_13_0 = arg_13_0.groupIndexes[arg_13_1]

	arg_13_0.groupInfo = arg_13_0.groups[var_13_0]

	if arg_13_0.currentGroupIndex ~= arg_13_2 then
		arg_13_0.currentItemIndex_ = nil
	end

	arg_13_0.currentGroupIndex = arg_13_2

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.titleTogList) do
		if iter_13_0 <= #arg_13_0.groupInfo.itemIndexes_ then
			SetActive(iter_13_1.gameObject_, #arg_13_0.groupInfo.itemIndexes_ ~= 1)

			local var_13_1 = arg_13_0.groupInfo[arg_13_0.groupInfo.itemIndexes_[iter_13_0]].id

			iter_13_1:SetData(arg_13_0.groupInfo[arg_13_0.groupInfo.itemIndexes_[iter_13_0]], iter_13_0, handler(arg_13_0, arg_13_0.ClickTitle), var_13_1)
			SetActive(arg_13_0["newGo" .. iter_13_0 .. "_"], arg_13_0:CheckShopRedPoint(var_13_1))
			SetActive(arg_13_0["redGo" .. iter_13_0 .. "_"], arg_13_0:SpecialShop(var_13_1))
		else
			SetActive(iter_13_1.gameObject_, false)
		end
	end

	for iter_13_2 = 1, 4 do
		SetActive(arg_13_0["line" .. iter_13_2 .. "Go_"], iter_13_2 < #arg_13_0.groupInfo.itemIndexes_)
	end

	if #arg_13_0.groupInfo.itemIndexes_ == 1 then
		if #ShopListCfg[arg_13_0.groupInfo[arg_13_0.groupInfo.itemIndexes_[1]].id].shop_label >= 1 then
			arg_13_0.stateController:SetSelectedState("state2")
		else
			arg_13_0.stateController:SetSelectedState("state1")
		end
	else
		arg_13_0.stateController:SetSelectedState("normal")
	end

	if arg_13_0.currentGroupIndex_ == arg_13_1 then
		arg_13_0:ClickTitle(arg_13_0.itemToSelect_ or arg_13_0.currentItemIndex_)
	else
		arg_13_0:ClickTitle(arg_13_0.itemToSelect_ or 1)
	end

	arg_13_0.itemToSelect_ = nil

	arg_13_0:EnterSendMgr(arg_13_1)
end

function var_0_0.ClickTitle(arg_14_0, arg_14_1)
	if arg_14_0.currentItemIndex_ == arg_14_1 then
		return
	end

	arg_14_0.currentItemIndex_ = arg_14_1

	arg_14_0:EnterSendMgr(nil, arg_14_1)

	local var_14_0 = arg_14_0.groupInfo[arg_14_0.groupInfo.itemIndexes_[arg_14_1]].id

	if not ShopTools.CheckShopIsUnLock(var_14_0, arg_14_0.curShopId_) then
		local var_14_1 = ShopTools.GetShopIsUnLockDesc(var_14_0, arg_14_0.curShopId_)

		if not string.isNullOrEmpty(var_14_1) then
			ShowTips(var_14_1)
		end
	end

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.titleTogList) do
		iter_14_1.controller:SetSelectedState(iter_14_0 == arg_14_1 and "false" or "true")
	end

	TimeTools.StartAfterSeconds(0.01, function()
		arg_14_0:UpdateShopList(var_14_0)
		arg_14_0.loopScrollView_:SetContentHeight(arg_14_0.diaViewPortTrs_.rect.height)
	end, {})

	if ShopData.GetRedPointData()[var_14_0] then
		ShopAction.RemoveShopRedPoint(var_14_0)
		SetActive(arg_14_0["newGo" .. arg_14_1 .. "_"], false)
	end

	if arg_14_0.curShopId_ ~= var_14_0 then
		arg_14_0.selectSuitTable = {}
		arg_14_0.selectSiftList = {}
	else
		return
	end

	arg_14_0.equipData = nil
	arg_14_0.clickIndex = nil
	arg_14_0.isClickClean = nil
	arg_14_0.copyList1 = nil
	arg_14_0.copyList2 = nil

	arg_14_0:UpdateBarByShopId(var_14_0)

	arg_14_0.params_.shopId = var_14_0
	arg_14_0.inSelect = false

	arg_14_0.colorController:SetSelectedState("normal")
end

function var_0_0.UpdateBottomView(arg_16_0)
	if arg_16_0.curShopId_ == ShopConst.SHOP_ID.DAILY_SHOP then
		arg_16_0.shopController:SetSelectedState("state0")

		if arg_16_0:GetRefreshCount() ~= ShopListCfg[arg_16_0.curShopId_].refresh_num_limit then
			arg_16_0.refreshTimesTxt_.text = GetTips("CLUB_REFRES_TEXT") .. string.format("(%d/%d)", ShopListCfg[arg_16_0.curShopId_].refresh_num_limit - arg_16_0:GetRefreshCount(), ShopListCfg[arg_16_0.curShopId_].refresh_num_limit)
		else
			arg_16_0.refreshTimesTxt_.text = GetTips("CLUB_REFRES_TEXT") .. string.format("(<color=#FF000B>%d</color>/%d)", ShopListCfg[arg_16_0.curShopId_].refresh_num_limit - arg_16_0:GetRefreshCount(), ShopListCfg[arg_16_0.curShopId_].refresh_num_limit)
		end

		if ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_TYPE_DIAMOND.item_id) < arg_16_0:GetDiamondCount() then
			arg_16_0.refreshCostTxt_.text = "<color=#FF000B>" .. arg_16_0:GetDiamondCount() .. "</color>"
		else
			arg_16_0.refreshCostTxt_.text = arg_16_0:GetDiamondCount()
		end

		SetActive(arg_16_0.costGo_, arg_16_0:GetRefreshCount() ~= ShopListCfg[arg_16_0.curShopId_].refresh_num_limit)
	elseif arg_16_0.curShopId_ == ShopConst.SHOP_ID.REPORT_SHOP then
		arg_16_0.shopController:SetSelectedState("state2")
	elseif arg_16_0.curShopId_ == ShopConst.SHOP_ID.COHOMOLOGY_TRACKS then
		arg_16_0.shopController:SetSelectedState("state3")
	elseif arg_16_0.curShopId_ == ShopConst.SHOP_ID.BLACK_AREA or arg_16_0.curShopId_ == ShopConst.SHOP_ID.EQUIP_DEVELOP then
		arg_16_0.shopController:SetSelectedState("state4")
	elseif arg_16_0.curShopId_ == ShopConst.SHOP_ID.DRAW_EXCHANGE_ASSET_SHOP or arg_16_0.curShopId_ == ShopConst.SHOP_ID.GUIDE_SHOP or arg_16_0.curShopId_ == ShopConst.SHOP_ID.PASSPORT_SHOP or arg_16_0.curShopId_ == ShopConst.SHOP_ID.NEW_DUO_WEI then
		arg_16_0.shopController:SetSelectedState("state5")
	else
		arg_16_0.shopController:SetSelectedState("state1")
	end

	TimeTools.StartAfterSeconds(0.01, function()
		arg_16_0.loopScrollView_:SetContentHeight(arg_16_0.diaViewPortTrs_.rect.height)
	end, {})
end

function var_0_0.AddEventListeners(arg_18_0)
	arg_18_0:RegistEventListener(SHOP_LIST_UPDATE, function(arg_19_0)
		if arg_19_0 == 0 or arg_18_0.curShopId_ == arg_19_0 then
			arg_18_0:UpdateShopList(arg_18_0.curShopId_)
		end
	end)
	arg_18_0:RegistEventListener(SHOP_REFRESH_ALL_SHOP, function(arg_20_0)
		arg_18_0.needKeepPos1 = true

		arg_18_0:OnRefreshAllShop(arg_20_0)
	end)
	arg_18_0:RegistEventListener(SHOP_ITEM_UPDATE, function(arg_21_0, arg_21_1)
		if arg_18_0.curShopId_ ~= arg_21_0 then
			return
		end

		arg_18_0.needKeepPos1 = true

		arg_18_0:RefreshList()
	end)
	arg_18_0:RegistEventListener(CURRENCY_UPDATE, function(arg_22_0)
		local var_22_0 = getShopIDListByCurrency(arg_22_0)

		if var_22_0 ~= nil and #var_22_0 > 0 then
			arg_18_0.needKeepPos1 = true

			arg_18_0:UpdateShopList(arg_18_0.curShopId_, true)
		end
	end)
end

function var_0_0.AddUIListener(arg_23_0)
	arg_23_0:AddBtnListenerScale(arg_23_0.refreshBtn_, nil, function()
		if arg_23_0:GetRefreshCount() >= ShopListCfg[arg_23_0.curShopId_].refresh_num_limit then
			ShowTips("SHOP_REFRESH_LIMIT")

			return
		end

		if _G.SkipTip.SkipShopRefreshTip then
			ShopAction.RefreshSingleShop(ShopConst.SHOP_ID.DAILY_SHOP, arg_23_0:GetDiamondCount())

			return
		end

		JumpTools.OpenPageByJump("popCostItem", {
			costId = CurrencyConst.CURRENCY_TYPE_DIAMOND,
			itemId = MaterialConst.MYTHIC_REFRESH_ITEM_ID,
			popCostCallBack = function()
				OperationRecorder.Record("shop", "okRefresh")
				ShopAction.RefreshSingleShop(ShopConst.SHOP_ID.DAILY_SHOP, arg_23_0:GetDiamondCount())

				_G.SkipTip.SkipShopRefreshTip = arg_23_0.skipShopRefreshTip_
			end,
			ToggleCallback = function(arg_26_0)
				arg_23_0.skipShopRefreshTip_ = arg_26_0

				if arg_26_0 then
					OperationRecorder.Record("shop", "toggle")
				end
			end,
			content = string.format(GetTips("MATRIX_SHOP_REFRESH"), ItemTools.getItemName(CurrencyConst.CURRENCY_TYPE_DIAMOND), arg_23_0:GetDiamondCount())
		})
	end)
	arg_23_0:AddBtnListener(arg_23_0.heroPieceExchangeBtn_, nil, function()
		JumpTools.OpenPopUp("fragmentExchange", nil, ViewConst.SYSTEM_ID.SHOP)
	end)
	arg_23_0:AddBtnListener(arg_23_0.quashBtn_, nil, function()
		JumpTools.OpenPageByJump("moduleItemResolveView")
	end)
	arg_23_0:AddBtnListener(arg_23_0.siftBtn_, nil, function()
		SetActive(arg_23_0.siftGo_, true)

		if arg_23_0.isClickClean then
			arg_23_0.inSelect = false
			arg_23_0.selectSuitTable = {}
			arg_23_0.selectSiftList = {}
		else
			arg_23_0.inSelect = true
		end

		if arg_23_0.copyList1 then
			arg_23_0.selectSiftList = arg_23_0.copyList1
		end

		if arg_23_0.copyList2 then
			arg_23_0.selectSuitTable = arg_23_0.copyList2
		end

		arg_23_0.equipList:StartScroll(#arg_23_0.suitList)
		arg_23_0:RefreshBottom(true)
	end)
	arg_23_0:AddBtnListener(arg_23_0.siftSuitBtn_, nil, function()
		SetActive(arg_23_0.siftGo_, false)

		if arg_23_0.isClickClean then
			arg_23_0.inSelect = false
			arg_23_0.isClickClean = nil
		else
			arg_23_0.inSelect = true
		end

		arg_23_0.selectList = arg_23_0:GetSelectList()
		arg_23_0.clickIndex = nil
		arg_23_0.equipData = nil
		arg_23_0.clickItem = nil

		arg_23_0:RefreshList()

		arg_23_0.copyList1 = clone(arg_23_0.selectSiftList)
		arg_23_0.copyList2 = clone(arg_23_0.selectSuitTable)

		arg_23_0.colorController:SetSelectedState(#arg_23_0.selectSiftList == 0 and "normal" or "orange")
	end)
	arg_23_0:AddBtnListener(arg_23_0.maskBtn_, nil, function()
		SetActive(arg_23_0.siftGo_, false)

		arg_23_0.isClickClean = nil

		if arg_23_0.colorController:GetSelectedState() == "normal" then
			arg_23_0.selectSuitTable = {}
			arg_23_0.selectSiftList = {}
			arg_23_0.isClickClean = nil
		end
	end)
end

function var_0_0.BindRedPoints(arg_32_0)
	for iter_32_0, iter_32_1 in pairs(arg_32_0.groups) do
		local var_32_0 = arg_32_0.tree_:GetGroupRedPointContainerById(iter_32_0)

		if var_32_0 then
			SetActive(var_32_0, true)

			local var_32_1 = false
			local var_32_2 = false
			local var_32_3 = var_32_0.transform:Find("notice_img/Default")
			local var_32_4 = var_32_0.transform:Find("notice_img/NewRed")

			for iter_32_2, iter_32_3 in pairs(iter_32_1) do
				if arg_32_0:CheckShopRedPoint(iter_32_3.id) then
					var_32_1 = true
				end

				if arg_32_0:SpecialShop(iter_32_3.id) then
					var_32_2 = true
				end
			end

			SetActive(var_32_4, var_32_1)
			SetActive(var_32_3, var_32_2)
		end
	end

	manager.redPoint:bindUIandKey(arg_32_0.heroPieceExchangeBtn_.transform, RedPointConst.HERO_PIECE_EXCHANGE)

	arg_32_0.updateTimer_ = Timer.New(function()
		for iter_33_0, iter_33_1 in ipairs(arg_32_0.titleTogList) do
			if iter_33_0 <= #arg_32_0.groupInfo.itemIndexes_ then
				local var_33_0 = arg_32_0.groupInfo[arg_32_0.groupInfo.itemIndexes_[iter_33_0]].id

				SetActive(arg_32_0["newGo" .. iter_33_0 .. "_"], arg_32_0:CheckShopRedPoint(var_33_0))
				SetActive(arg_32_0["redGo" .. iter_33_0 .. "_"], arg_32_0:SpecialShop(var_33_0))
			end
		end

		for iter_33_2, iter_33_3 in pairs(arg_32_0.groups) do
			local var_33_1 = arg_32_0.tree_:GetGroupRedPointContainerById(iter_33_2)

			if var_33_1 then
				SetActive(var_33_1, true)

				local var_33_2 = false
				local var_33_3 = false
				local var_33_4 = var_33_1.transform:Find("notice_img/Default")
				local var_33_5 = var_33_1.transform:Find("notice_img/NewRed")

				for iter_33_4, iter_33_5 in pairs(iter_33_3) do
					if arg_32_0:CheckShopRedPoint(iter_33_5.id) then
						var_33_2 = true
					end

					if arg_32_0:SpecialShop(iter_33_5.id) then
						var_33_3 = true
					end
				end

				SetActive(var_33_5, var_33_2)
				SetActive(var_33_4, var_33_3)
			end
		end
	end, 1, -1, 1)

	arg_32_0.updateTimer_:Start()
end

function var_0_0.SpecialShop(arg_34_0, arg_34_1)
	if ShopConst.SHOP_ID_TO_RED_CONST[arg_34_1] then
		return manager.redPoint:getTipValue(ShopConst.SHOP_ID_TO_RED_CONST[arg_34_1]) == 1
	else
		return false
	end
end

function var_0_0.CheckShopRedPoint(arg_35_0, arg_35_1)
	return ShopData.GetRedPointData()[arg_35_1] == true
end

function var_0_0.UnBindRedPoints(arg_36_0)
	if arg_36_0.updateTimer_ then
		arg_36_0.updateTimer_:Stop()

		arg_36_0.updateTimer_ = nil
	end

	manager.redPoint:unbindUIandKey(arg_36_0.heroPieceExchangeBtn_.transform, RedPointConst.HERO_PIECE_EXCHANGE)
end

function var_0_0.OnRefreshOneShop(arg_37_0, arg_37_1)
	arg_37_0:RefreshList()
end

function var_0_0.UpdateShopList(arg_38_0, arg_38_1)
	arg_38_0.curShopId_ = arg_38_1

	local var_38_0 = ShopListCfg[arg_38_1]

	for iter_38_0, iter_38_1 in ipairs(arg_38_0.itemListPool) do
		iter_38_1.itemView:OnExit()
	end

	for iter_38_2, iter_38_3 in ipairs(arg_38_0.itemEquipPool) do
		iter_38_3.itemView:OnExit()
	end

	for iter_38_4, iter_38_5 in ipairs(arg_38_0.itemEquipBuyPool) do
		iter_38_5.itemView:OnExit()
	end

	arg_38_0.list = arg_38_0.list1
	arg_38_0.RefreshList = arg_38_0.RefreshListType1

	if #var_38_0.shop_label >= 1 then
		arg_38_0.RefreshList = arg_38_0.RefreshListType2
	end

	arg_38_0:RefreshList()
	arg_38_0:UpdateBottomView()
	arg_38_0:UpdateTimer()
end

function var_0_0.RefreshListType1(arg_39_0)
	local var_39_0 = ShopListCfg[arg_39_0.curShopId_]

	SetActive(arg_39_0.list1Go_, true)
	SetActive(arg_39_0.proofGo_, false)

	arg_39_0.shopDataList = ShopTools.FilterShopDataList(arg_39_0.curShopId_, var_39_0.chain_last_visible == 1)
	arg_39_0.shopDataList = ShopTools.CommonSort(arg_39_0.shopDataList)

	if arg_39_0.needKeepPos1 then
		arg_39_0.pos = arg_39_0.list:GetScrolledPosition()
	else
		arg_39_0.pos = nil
	end

	TimeTools.StartAfterSeconds(0.1, function()
		arg_39_0.list:StartScrollWithoutAnimator(#arg_39_0.shopDataList, arg_39_0.pos)
	end, {})

	arg_39_0.needKeepPos1 = nil

	arg_39_0:UpdateBarByShopId(arg_39_0.curShopId_)
end

function var_0_0.RefreshListType2(arg_41_0)
	SetActive(arg_41_0.proofGo_, true)
	SetActive(arg_41_0.list1Go_, false)

	local var_41_0 = ShopListCfg[arg_41_0.curShopId_]

	if arg_41_0.isFist == nil then
		arg_41_0.isFist = true
	end

	arg_41_0.shopDataList = ShopTools.FilterShopDataList(arg_41_0.curShopId_, var_41_0.chain_last_visible == 1)
	arg_41_0.shopDataList = ShopTools.CommonSort(arg_41_0.shopDataList)
	arg_41_0.shopDataList, arg_41_0.titleList, arg_41_0.suitList = ShopTools.SplitDataByShopID(arg_41_0.shopDataList, arg_41_0.curShopId_)

	arg_41_0:UpdateBarByShopId(arg_41_0.curShopId_)

	local var_41_1 = arg_41_0.diaScrollEx_.verticalNormalizedPosition

	if arg_41_0.needKeepPos1 then
		arg_41_0.needKeepPos1 = false

		arg_41_0.loopScrollView_:RefreshScrollView(arg_41_0.isFist)

		arg_41_0.isFist = false
		arg_41_0.diaScrollEx_.verticalNormalizedPosition = var_41_1

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_0.diaScrollEx_.transform)

		arg_41_0.diaScrollEx_.verticalNormalizedPosition = var_41_1
	else
		arg_41_0.loopScrollView_:NavigateIndex(1)

		if arg_41_0.isFist then
			arg_41_0.isFist = false

			TimeTools.StartAfterSeconds(0.1, function()
				arg_41_0.loopScrollView_:NavigateIndex(1)
			end, {})
		end
	end

	arg_41_0:UpdateBottomView()
end

function var_0_0.GetShowList(arg_43_0, arg_43_1)
	local var_43_0 = {
		{}
	}
	local var_43_1 = 0

	arg_43_0.indexList = {}

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_0.item1Trs_.transform)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_0.shopItemTrs_.transform)

	arg_43_0.lineCount = math.floor((arg_43_0.item1Trs_.rect.width - 20) / arg_43_0.shopItemTrs_.rect.width)

	for iter_43_0 = 1, #arg_43_1 do
		var_43_1 = var_43_1 + 1
		arg_43_0.indexList[iter_43_0] = var_43_1

		for iter_43_1, iter_43_2 in ipairs(arg_43_1[iter_43_0]) do
			if var_43_0[var_43_1] == nil then
				var_43_0[var_43_1] = {}
			end

			if #var_43_0[var_43_1] >= arg_43_0.lineCount then
				var_43_1 = var_43_1 + 1
			end

			if var_43_0[var_43_1] == nil then
				var_43_0[var_43_1] = {}
			end

			table.insert(var_43_0[var_43_1], iter_43_2)
		end
	end

	if arg_43_0.clickIndex and arg_43_0.equipData then
		table.insert(var_43_0, arg_43_0.clickIndex + 1, arg_43_0.equipData)
	end

	return var_43_0, var_43_1
end

function var_0_0.UpdateBarByShopId(arg_44_0, arg_44_1)
	local var_44_0 = {}

	table.insert(var_44_0, BACK_BAR)

	if arg_44_0.params_.hideHomeBtn ~= 1 then
		table.insert(var_44_0, HOME_BAR)
		manager.windowBar:RegistHomeCallBack(function()
			gameContext:Go("/home", nil, nil, true)
		end)
	end

	table.insert(var_44_0, NAVI_BAR)

	local var_44_1 = {}
	local var_44_2 = ShopListCfg[arg_44_1]

	for iter_44_0 = 1, #var_44_2.cost_id do
		local var_44_3

		if CurrencyIdMapCfg[var_44_2.cost_id[iter_44_0]] then
			var_44_3 = CurrencyIdMapCfg[var_44_2.cost_id[iter_44_0]].item_id
		else
			var_44_3 = var_44_2.cost_id[iter_44_0]
		end

		if var_44_3 == CurrencyIdMapCfg.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE.item_id then
			var_44_3 = CurrencyConst.GetPlatformDiamondId()
		end

		table.insert(var_44_0, var_44_3)
		table.insert(var_44_1, var_44_3)
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

function var_0_0.SelectTreeByShopId(arg_47_0, arg_47_1)
	if next(arg_47_0.groupIndexes) == nil then
		return
	end

	local var_47_0 = -1
	local var_47_1 = ShopListCfg[arg_47_1].display_group

	for iter_47_0, iter_47_1 in ipairs(arg_47_0.groupIndexes) do
		if iter_47_1 == var_47_1 then
			var_47_0 = iter_47_0
		end
	end

	local var_47_2 = -1

	for iter_47_2, iter_47_3 in ipairs(arg_47_0.groups[var_47_1].itemIndexes_) do
		if arg_47_0.groups[var_47_1][iter_47_3].id == arg_47_1 then
			var_47_2 = iter_47_2

			break
		end
	end

	if var_47_2 > 0 then
		arg_47_0.itemToSelect_ = var_47_2
	end

	arg_47_0.tree_:SelectGroup(var_47_0)
end

function var_0_0.OnEnter(arg_48_0)
	arg_48_0:UpdateViewByParams()
	arg_48_0:InitShopByParams()
	arg_48_0:AddEventListeners()
	arg_48_0:BindRedPoints()
	arg_48_0:SetTimer()
end

function var_0_0.InitShopByParams(arg_49_0)
	if not arg_49_0.updateDirty_ then
		return
	end

	local var_49_0 = arg_49_0.params_.goodId
	local var_49_1 = arg_49_0.params_.shopId

	if var_49_0 then
		local var_49_2 = getShopCfg(var_49_0)

		arg_49_0.curShopId_ = ShopListCfg[var_49_2.shop_id].id
	else
		arg_49_0.curShopId_ = tonumber(var_49_1 or 2)
	end

	arg_49_0.currentGroupIndex_ = ShopListCfg[arg_49_0.curShopId_].display_group
end

function var_0_0.UpdateViewByParams(arg_50_0)
	local var_50_0 = arg_50_0:GetTreeDataByParams()

	if next(arg_50_0.groupIndexes) == nil then
		return
	end

	arg_50_0.tree_:SetData(var_50_0)

	local var_50_1 = arg_50_0.params_.goodId

	if arg_50_0.params_.shopId == nil and arg_50_0.params_.goodId then
		local var_50_2 = getShopCfg(var_50_1)

		arg_50_0.params_.shopId = var_50_2.shop_id
	end

	arg_50_0:SelectTreeByShopId(arg_50_0.params_.shopId)
	TimeTools.StartAfterSeconds(0.1, function()
		if var_50_1 and ShopTools.IsGoodCanBuy(arg_50_0.params_.shopId, var_50_1) then
			arg_50_0.params_.goodId = nil

			local var_51_0 = getShopCfg(var_50_1)
			local var_51_1 = {
				id = var_50_1,
				shopId = var_51_0.shop_id,
				buyTime = ShopData.GetShop(var_51_0.shop_id)[var_50_1] ~= nil and ShopData.GetShop(var_51_0.shop_id)[var_50_1].buy_times or 0
			}

			JumpTools.OpenPopUp("shopBuy", {
				mainShopID = arg_50_0.curShopId_,
				goodInfo = var_51_1
			})
		end
	end, {})

	arg_50_0.updateDirty_ = false
end

function var_0_0.OnTop(arg_52_0)
	if arg_52_0.params_.shopId == arg_52_0.curShopId_ then
		arg_52_0:UpdateBarByShopId(arg_52_0.curShopId_)

		return
	end

	if arg_52_0.curShopId_ ~= nil then
		arg_52_0.needKeepPos1 = true

		arg_52_0:UpdateViewByParams()
	end
end

function var_0_0.OnBehind(arg_53_0)
	arg_53_0.updateDirty_ = true
end

function var_0_0.OnExit(arg_54_0)
	manager.windowBar:HideBar()
	SetActive(arg_54_0.siftGo_, false)

	arg_54_0.currentItemIndex_ = nil

	for iter_54_0, iter_54_1 in pairs(arg_54_0.list1:GetItemList()) do
		iter_54_1:OnExit()
	end

	for iter_54_2, iter_54_3 in ipairs(arg_54_0.itemListPool) do
		iter_54_3.itemView:OnExit()
	end

	for iter_54_4, iter_54_5 in ipairs(arg_54_0.itemEquipPool) do
		iter_54_5.itemView:OnExit()
	end

	for iter_54_6, iter_54_7 in ipairs(arg_54_0.itemEquipBuyPool) do
		iter_54_7.itemView:OnExit()
	end

	arg_54_0.isFist = nil

	arg_54_0:StopTimer()
	arg_54_0:RemoveAllEventListener()
	arg_54_0:UnBindRedPoints()
	arg_54_0:ExitUITime()
end

function var_0_0.StopTimer(arg_55_0)
	if arg_55_0.refreshTimer_ then
		arg_55_0.refreshTimer_:Stop()

		arg_55_0.refreshTimer_ = nil
	end
end

function var_0_0.SetTimer(arg_56_0)
	arg_56_0:StopTimer()

	local var_56_0 = _G.gameTimer:GetNextDayFreshTime() - manager.time:GetServerTime()

	if var_56_0 < 0 then
		var_56_0 = 0
	end

	if arg_56_0.curShopId_ == ShopConst.SHOP_ID.DAILY_SHOP then
		arg_56_0.refreshTimeTxt_.text = string.format(GetTips("TIME_DISPLAY_8"), TimeMgr.GetInstance():GetLostTimeStrWith2Unit(_G.gameTimer:GetNextDayFreshTime()))
	elseif arg_56_0.curShopId_ == ShopConst.SHOP_ID.DRAW_EXCHANGE_ASSET_SHOP then
		arg_56_0.refreshTimeTxt_.text = string.format(GetTips("SHOP_LIMITED_GOOD_REFRESH_TIME"), TimeMgr.GetInstance():GetLostTimeStrWith2Unit(_G.gameTimer:GetNextMonthFreshTime()))
	elseif arg_56_0.curShopId_ == ShopConst.SHOP_ID.PASSPORT_SHOP then
		arg_56_0.refreshTimeTxt_.text = string.format(GetTips("SHOP_LIMITED_GOOD_REFRESH_TIME"), manager.time:GetLostTimeStrWith2Unit(ActivityData:GetActivityData(201).stopTime))
	elseif arg_56_0.curShopId_ == ShopConst.SHOP_ID.GUIDE_SHOP then
		arg_56_0.refreshTimeTxt_.text = string.format(GetTips("SHOP_LIMITED_GOOD_REFRESH_TIME"), TimeMgr.GetInstance():GetLostTimeStrWith2Unit(_G.gameTimer:GetNextWeekFreshTime()))
	elseif arg_56_0.curShopId_ == ShopConst.SHOP_ID.NEW_DUO_WEI then
		local var_56_1 = PolyhedronData:GetActivityID()

		arg_56_0.refreshTimeTxt_.text = string.format(GetTips("SHOP_LIMITED_GOOD_REFRESH_TIME"), TimeMgr.GetInstance():GetLostTimeStrWith2Unit(ActivityData:GetActivityData(var_56_1).stopTime))
	elseif arg_56_0.curShopId_ == ShopConst.SHOP_ID.REPORT_SHOP then
		arg_56_0.refreshTimeTxt_.text = manager.time:GetLostTimeStrWith2Unit(arg_56_0:GetReportShopRefreshTime())
	end

	arg_56_0.refreshTimer_ = Timer.New(function()
		arg_56_0:UpdateTimer()
	end, 1, var_56_0, 1)

	arg_56_0.refreshTimer_:Start()
end

function var_0_0.UpdateTimer(arg_58_0)
	for iter_58_0, iter_58_1 in pairs(arg_58_0.list1:GetItemList()) do
		iter_58_1:UpdateTimerView()
	end

	for iter_58_2, iter_58_3 in ipairs(arg_58_0.itemListPool) do
		iter_58_3.itemView:UpdateTimerView()
	end

	for iter_58_4, iter_58_5 in ipairs(arg_58_0.itemEquipPool) do
		iter_58_5.itemView:UpdateTimerView()
	end

	for iter_58_6, iter_58_7 in ipairs(arg_58_0.itemEquipBuyPool) do
		iter_58_7.itemView:UpdateTimerView()
	end

	if not arg_58_0.waitingRefresh_ then
		if arg_58_0.curShopId_ == ShopConst.SHOP_ID.DAILY_SHOP then
			if _G.gameTimer:GetNextDayFreshTime() - manager.time:GetServerTime() <= 0 then
				arg_58_0:Complete()
				arg_58_0:StopTimer()

				arg_58_0.refreshTimeTxt_.text = string.format(GetTips("TIME_DISPLAY_8"), TimeMgr.GetInstance():GetLostTimeStrWith2Unit(_G.gameTimer:GetNextDayFreshTime(), true))

				return
			end

			arg_58_0.refreshTimeTxt_.text = string.format(GetTips("TIME_DISPLAY_8"), TimeMgr.GetInstance():GetLostTimeStrWith2Unit(_G.gameTimer:GetNextDayFreshTime(), true))
		elseif arg_58_0.curShopId_ == ShopConst.SHOP_ID.DRAW_EXCHANGE_ASSET_SHOP then
			arg_58_0.refreshTimeTxt_.text = string.format(GetTips("SHOP_LIMITED_GOOD_REFRESH_TIME"), TimeMgr.GetInstance():GetLostTimeStrWith2Unit(_G.gameTimer:GetNextMonthFreshTime()))
		elseif arg_58_0.curShopId_ == ShopConst.SHOP_ID.PASSPORT_SHOP then
			arg_58_0.refreshTimeTxt_.text = string.format(GetTips("SHOP_LIMITED_GOOD_REFRESH_TIME"), manager.time:GetLostTimeStrWith2Unit(ActivityData:GetActivityData(201).stopTime))
		elseif arg_58_0.curShopId_ == ShopConst.SHOP_ID.REPORT_SHOP then
			arg_58_0.refreshTimeTxt_.text = string.format(GetTips("SHOP_LIMITED_GOOD_REFRESH_TIME"), manager.time:GetLostTimeStrWith2Unit(arg_58_0:GetReportShopRefreshTime()))
		elseif arg_58_0.curShopId_ == ShopConst.SHOP_ID.GUIDE_SHOP then
			arg_58_0.refreshTimeTxt_.text = string.format(GetTips("SHOP_LIMITED_GOOD_REFRESH_TIME"), TimeMgr.GetInstance():GetLostTimeStrWith2Unit(_G.gameTimer:GetNextWeekFreshTime()))
		elseif arg_58_0.curShopId_ == ShopConst.SHOP_ID.NEW_DUO_WEI then
			local var_58_0 = PolyhedronData:GetActivityID()

			arg_58_0.refreshTimeTxt_.text = string.format(GetTips("SHOP_LIMITED_GOOD_REFRESH_TIME"), TimeMgr.GetInstance():GetLostTimeStrWith2Unit(ActivityData:GetActivityData(var_58_0).stopTime))
		end
	end
end

function var_0_0.GetReportShopRefreshTime(arg_59_0)
	if arg_59_0.curShopId_ == ShopConst.SHOP_ID.REPORT_SHOP then
		return ActivityData:GetActivityRefreshTime(ShopListCfg[arg_59_0.curShopId_].activity_id)
	end

	return 0
end

function var_0_0.Complete(arg_60_0)
	arg_60_0.waitingRefresh_ = true

	ShopAction.RefreshAllShop()
end

function var_0_0.OnRefreshAllShop(arg_61_0, arg_61_1)
	if arg_61_1.result == 0 then
		if arg_61_0.resumeTimer_ == nil then
			arg_61_0.resumeTimer_ = Timer.New(function()
				arg_61_0.waitingRefresh_ = false
				arg_61_0.resumeTimer_ = nil

				arg_61_0:SetTimer()
			end, 1, 1)
		end

		arg_61_0.resumeTimer_:Start()
	else
		return
	end
end

function var_0_0.GetRefreshCount(arg_63_0)
	local var_63_0 = arg_63_0.curShopId_

	if ShopData.GetShop(var_63_0) then
		return ShopData.GetShop(var_63_0).refreshCount
	end

	return 0
end

function var_0_0.GetDiamondCount(arg_64_0)
	local var_64_0 = arg_64_0.curShopId_
	local var_64_1 = ShopData.GetShop(var_64_0)
	local var_64_2 = GameCurrencyBuySetting[#GameCurrencyBuySetting.all].shop_money_refresh

	if var_64_1.refreshCount < #GameCurrencyBuySetting.all then
		return GameCurrencyBuySetting[var_64_1.refreshCount + 1].shop_money_refresh
	else
		return var_64_2
	end
end

function var_0_0.Dispose(arg_65_0)
	if arg_65_0.tree_ then
		arg_65_0.tree_:Dispose()

		arg_65_0.tree_ = nil
	end

	arg_65_0.filterBottomView_:Dispose()

	if arg_65_0.list1 then
		arg_65_0.list1:Dispose()

		arg_65_0.list1 = nil
	end

	if arg_65_0.equipList then
		arg_65_0.equipList:Dispose()

		arg_65_0.equipList = nil
	end

	for iter_65_0, iter_65_1 in ipairs(arg_65_0.itemListPool) do
		iter_65_1.itemView:Dispose()
	end

	for iter_65_2, iter_65_3 in ipairs(arg_65_0.itemEquipPool) do
		iter_65_3.itemView:Dispose()
	end

	for iter_65_4, iter_65_5 in ipairs(arg_65_0.itemEquipBuyPool) do
		iter_65_5.itemView:Dispose()
	end

	arg_65_0.itemListPool = nil
	arg_65_0.itemEquipPool = nil
	arg_65_0.itemEquipBuyPool = nil

	for iter_65_6, iter_65_7 in ipairs(arg_65_0.titleTogList) do
		iter_65_7:Dispose()
	end

	arg_65_0:RemoveAllListeners()

	arg_65_0.curShopId_ = nil

	var_0_0.super.Dispose(arg_65_0)
end

function var_0_0.LsGetItemData(arg_66_0)
	arg_66_0.detailList, arg_66_0.count = arg_66_0:GetShowList(arg_66_0.shopDataList)

	local var_66_0 = ShopListCfg[arg_66_0.curShopId_]

	if arg_66_0.inSelect then
		arg_66_0.titleList = {}
		arg_66_0.indexList = {}

		return arg_66_0:GetSelectList()
	elseif var_66_0.shop_label ~= "" and #var_66_0.shop_label > 0 then
		return arg_66_0.detailList
	else
		return {}
	end
end

function var_0_0.LsAddItem(arg_67_0, arg_67_1, arg_67_2)
	local var_67_0

	if arg_67_0.equipData and arg_67_2 - 1 == arg_67_0.clickIndex then
		var_67_0 = arg_67_0:GetFreeItem(arg_67_0.itemEquipBuyPool, function()
			return ExchangEquipBuyItem.New(arg_67_0.item3Go_, arg_67_0.diaGridGo_)
		end)
	elseif arg_67_1[1][1] == nil then
		var_67_0 = arg_67_0:GetFreeItem(arg_67_0.itemListPool, function()
			return ExchangeSplitItem.New(arg_67_0.item1Go_, arg_67_0.diaGridGo_)
		end)
	else
		var_67_0 = arg_67_0:GetFreeItem(arg_67_0.itemEquipPool, function()
			return ExchangeEquipItem.New(arg_67_0.item2Go_, arg_67_0.diaGridGo_)
		end)
	end

	var_67_0.itemView:SetData(arg_67_1, arg_67_0.titleList, arg_67_0.indexList, arg_67_2, handler(arg_67_0, arg_67_0.ClickCallBack), arg_67_0.equipData)

	return var_67_0
end

function var_0_0.ClickCallBack(arg_71_0, arg_71_1, arg_71_2)
	if arg_71_0.clickIndex == nil then
		arg_71_0.clickIndex = arg_71_1
		arg_71_0.equipData = arg_71_2

		arg_71_0.loopScrollView_:NavigateIndex(arg_71_0.clickIndex)
	elseif arg_71_0.equipData ~= arg_71_2 and arg_71_2 ~= nil then
		arg_71_0.equipData = arg_71_2

		if arg_71_1 > arg_71_0.clickIndex then
			arg_71_0.clickIndex = arg_71_1 - 1
		else
			arg_71_0.clickIndex = arg_71_1
		end

		arg_71_0.loopScrollView_:NavigateIndex(arg_71_0.clickIndex)
	else
		arg_71_0.clickIndex = nil
		arg_71_0.equipData = nil

		arg_71_0.loopScrollView_:RefreshScrollView(false, true)
	end
end

function var_0_0.LsRemoveItem(arg_72_0, arg_72_1)
	arg_72_1.itemView:Show(false)

	arg_72_1.isFree = true
end

function var_0_0.GetFreeItem(arg_73_0, arg_73_1, arg_73_2)
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

function var_0_0.GetSelectList(arg_74_0)
	local var_74_0 = {}
	local var_74_1

	for iter_74_0, iter_74_1 in ipairs(arg_74_0.shopDataList) do
		if iter_74_1[1][1] then
			var_74_1 = iter_74_1
		end
	end

	if next(arg_74_0.selectSuitTable) == nil then
		arg_74_0.inSelect = false

		arg_74_0.colorController:SetSelectedState("normal")

		return {}
	end

	for iter_74_2, iter_74_3 in ipairs(var_74_1) do
		local var_74_2 = EquipCfg[getShopCfg(iter_74_3[1].id).give_id]

		if arg_74_0.selectSuitTable[var_74_2.suit] then
			table.insert(var_74_0, iter_74_3)
		end
	end

	local var_74_3 = {}
	local var_74_4 = 1

	for iter_74_4, iter_74_5 in ipairs(var_74_0) do
		if var_74_3[var_74_4] == nil then
			var_74_3[var_74_4] = {}
		end

		table.insert(var_74_3[var_74_4], iter_74_5)

		if #var_74_3[var_74_4] >= 5 then
			var_74_4 = var_74_4 + 1
		end
	end

	if arg_74_0.equipData then
		table.insert(var_74_3, arg_74_0.clickIndex + 1, arg_74_0.equipData)
	end

	if next(var_74_3[1]) == nil then
		return {}
	else
		return var_74_3
	end
end

function var_0_0.LsUpdateItem(arg_75_0, arg_75_1, arg_75_2, arg_75_3)
	arg_75_1.itemView:SetData(arg_75_2, arg_75_0.titleList, arg_75_0.indexList, arg_75_3, handler(arg_75_0, arg_75_0.ClickCallBack), arg_75_0.equipData)
end

function var_0_0.EnterSendMgr(arg_76_0, arg_76_1, arg_76_2)
	arg_76_0.groupIndex_ = arg_76_1 or arg_76_0.groupIndex_
	arg_76_0.titleIndex_ = arg_76_2 or arg_76_0.titleIndex_

	local var_76_0 = string.format("%s_%s_%s", UITimeConst.shopTransactionGifts, arg_76_0.groupIndex_, arg_76_0.titleIndex_)

	if arg_76_0.groupIndex_ and arg_76_0.titleIndex_ and var_76_0 ~= arg_76_0.lastShopId_ then
		arg_76_0:ExitSendMgr()
		manager.uiTime:OnEnterRoute(var_76_0, true)

		arg_76_0.lastShopId_ = var_76_0
	end
end

function var_0_0.ExitSendMgr(arg_77_0)
	if arg_77_0.lastShopId_ then
		manager.uiTime:OnExitRoute(arg_77_0.lastShopId_, true)
	end
end

function var_0_0.ExitUITime(arg_78_0)
	arg_78_0:ExitSendMgr()

	arg_78_0.lastShopId_ = nil
	arg_78_0.groupIndex_ = nil
	arg_78_0.titleIndex_ = nil
end

return var_0_0
