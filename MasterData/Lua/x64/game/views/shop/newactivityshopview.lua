local NewActivityShopView = class("NewActivityShopView", ReduxView)

function NewActivityShopView:UIName()
	return "Widget/System/Shop/ActiveStoreUI"
end

function NewActivityShopView:UIParent()
	return manager.ui.uiMain.transform
end

function NewActivityShopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function NewActivityShopView:InitUI()
	self:BindCfgUI()

	self.list = LuaList.New(handler(self, self.SetItem), self.listGo_, ExchangeItemView)
	self.stateController = self.controller_:GetController("state")
	self.titleTogList = {
		RechargeTitleItem.New(self.tag01_),
		RechargeTitleItem.New(self.tag02_),
		(RechargeTitleItem.New(self.tag03_))
	}
end

function NewActivityShopView:SetItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.shopDataList[arg_5_1])
end

function NewActivityShopView:AddUIListener()
	return
end

function NewActivityShopView:AddEventListeners()
	self:RegistEventListener(SHOP_LIST_UPDATE, function(arg_8_0)
		if arg_8_0 == 0 or self.curShopId_ == arg_8_0 then
			self:UpdateShopList(self.curShopId_)
		end
	end)
	self:RegistEventListener(SHOP_REFRESH_ALL_SHOP, function(arg_9_0)
		self.needKeepPos1 = true

		self:UpdateShopList(self.curShopId_)
	end)
	self:RegistEventListener(SHOP_ITEM_UPDATE, function(arg_10_0, arg_10_1)
		if self.curShopId_ ~= arg_10_0 then
			return
		end

		self.needKeepPos1 = true

		self:UpdateShopList(self.curShopId_)
	end)
	self:RegistEventListener(CURRENCY_UPDATE, function(arg_11_0)
		local var_11_0 = getShopIDListByCurrency(arg_11_0)

		if var_11_0 ~= nil and #var_11_0 > 0 then
			self.needKeepPos1 = true

			self:UpdateShopList(self.curShopId_, true)
		end
	end)
	self:RegistEventListener(MATERIAL_MODIFY, function(arg_12_0)
		local var_12_0 = getShopIDListByCurrency(arg_12_0)

		if var_12_0 ~= nil and #var_12_0 > 0 then
			self.needKeepPos1 = true

			self:UpdateShopList(self.curShopId_)
		end
	end)
end

function NewActivityShopView:OnEnter()
	self:InitShopByParams()
	self:UpdateViewByParams()
	self:UpdateTitle()
	self:AddEventListeners()
	self:SetTimer()
end

function NewActivityShopView:OnTop()
	if self.params_.shopId == self.curShopId_ then
		self:UpdateBarByShopId(self.curShopId_)

		return
	end

	self.curShopId_ = self.params_.shopId

	if self.curShopId_ ~= nil then
		self.needKeepPos1 = true

		self:UpdateViewByParams()
	end
end

function NewActivityShopView:UpdateTitle()
	self.groupInfo = self.groups[self.groupIndexes[1]]

	for iter_15_0, iter_15_1 in ipairs(self.titleTogList) do
		if iter_15_0 <= #self.groupInfo.itemIndexes_ then
			SetActive(iter_15_1.gameObject_, true)
			iter_15_1:SetData(self.groupInfo[self.groupInfo.itemIndexes_[iter_15_0]], iter_15_0, handler(self, self.ClickTitle), self.groupInfo[self.groupInfo.itemIndexes_[iter_15_0]].id)
		else
			SetActive(iter_15_1.gameObject_, false)
		end
	end

	if #ShopListCfg[self.groupInfo[self.groupInfo.itemIndexes_[1]].id].shop_label >= 1 then
		self.stateController:SetSelectedState("true")
	else
		self.stateController:SetSelectedState("false")
	end

	for iter_15_2 = 1, 2 do
		SetActive(self["line" .. iter_15_2 .. "Go_"], iter_15_2 < #self.groupInfo.itemIndexes_)
	end

	if self.currentGroupIndex_ == 1 then
		self:ClickTitle(self.itemToSelect_ or self.currentItemIndex_)
	else
		self:ClickTitle(self.itemToSelect_ or 1)
	end
end

function NewActivityShopView:ClickTitle(arg_16_1)
	local var_16_0 = self.groupInfo[self.groupInfo.itemIndexes_[arg_16_1]].id

	SetActive(self.lockGo_, not ShopTools.CheckShopIsUnLock(self.groupInfo[self.groupInfo.itemIndexes_[arg_16_1]].id))

	self.lockDescTxt_.text = ShopTools.GetShopIsUnLockDesc(self.groupInfo[self.groupInfo.itemIndexes_[arg_16_1]].id)
	self.currentItemIndex_ = arg_16_1
	self.titleTxt_.text = GetI18NText(ShopListCfg[self.groupInfo[self.groupInfo.itemIndexes_[arg_16_1]].id].remark)

	for iter_16_0, iter_16_1 in ipairs(self.titleTogList) do
		iter_16_1.controller:SetSelectedState(iter_16_0 == arg_16_1 and "false" or "true")
	end

	self.roleBg_.sprite = pureGetSpriteWithoutAtlas(ShopListCfg[self.groupInfo[self.groupInfo.itemIndexes_[arg_16_1]].id].shop_background)

	self:UpdateBarByShopId(self.groupInfo[self.groupInfo.itemIndexes_[arg_16_1]].id)

	self.params_.shopId = self.groupInfo[self.groupInfo.itemIndexes_[arg_16_1]].id
	self.enterTimer = TimeTools.StartAfterSeconds(0.05, function()
		if self.enterTimer == nil then
			return
		end

		self:UpdateShopList(var_16_0)

		self.enterTimer = nil
	end, {})
end

function NewActivityShopView:UpdateViewByParams()
	self:GetTreeDataByParams()

	if next(self.groupIndexes) == nil then
		return
	end

	local var_18_0 = self.params_.goodId

	if self.params_.goodId and ShopTools.IsGoodCanBuy(self.curShopId_, var_18_0) then
		self.timer_ = FrameTimer.New(function()
			self.params_.goodId = nil

			local var_19_0 = getShopCfg(var_18_0)
			local var_19_1 = {
				id = var_18_0,
				shopId = var_19_0.shop_id
			}

			var_19_1.buyTime = ShopData.GetShop(var_19_0.shop_id)[var_18_0] ~= nil and ShopData.GetShop(var_19_0.shop_id)[var_18_0].buy_times or 0

			JumpTools.OpenPopUp("shopBuy", {
				mainShopID = self.curShopId_,
				goodInfo = var_19_1
			})

			self.timer_ = nil
		end, 1, 1)

		self.timer_:Start()
	end
end

function NewActivityShopView:GetTreeDataByParams()
	local var_20_0 = {}

	if self.params_.showShops then
		var_20_0 = self.params_.showShops
	else
		for iter_20_0, iter_20_1 in ipairs(ShopListCfg.get_id_list_by_system[1]) do
			if ShopListCfg[iter_20_1].show_in_shop == 1 then
				table.insert(var_20_0, iter_20_1)
			end
		end
	end

	local var_20_1 = {}

	for iter_20_2, iter_20_3 in ipairs(var_20_0) do
		if ShopTools.IsShopOpen(iter_20_3) then
			table.insert(var_20_1, iter_20_3)
		end
	end

	self.groups = {}
	self.groupIndexes = {}

	for iter_20_4, iter_20_5 in ipairs(var_20_1) do
		if not self.groups[ShopListCfg[iter_20_5].display_group] then
			self.groups[ShopListCfg[iter_20_5].display_group] = {
				itemIndexes_ = {}
			}

			table.insert(self.groupIndexes, ShopListCfg[iter_20_5].display_group)
		end

		self.groups[ShopListCfg[iter_20_5].display_group][ShopListCfg[iter_20_5].display_index] = ShopListCfg[iter_20_5]

		table.insert(self.groups[ShopListCfg[iter_20_5].display_group].itemIndexes_, ShopListCfg[iter_20_5].display_index)
	end

	for iter_20_6, iter_20_7 in pairs(self.groups) do
		table.sort(iter_20_7.itemIndexes_, function(arg_21_0, arg_21_1)
			return arg_21_0 < arg_21_1
		end)
	end

	table.sort(self.groupIndexes, function(arg_22_0, arg_22_1)
		return arg_22_0 < arg_22_1
	end)
end

function NewActivityShopView:InitShopByParams()
	self.curShopId_ = self.params_.goodId and ShopListCfg[getShopCfg(self.params_.goodId).shop_id].id or tonumber(self.params_.shopId or 2)
	self.currentGroupIndex_ = ShopListCfg[self.curShopId_].display_group
end

function NewActivityShopView:UpdateBarByShopId(arg_24_1)
	local var_24_0 = {}

	table.insert(var_24_0, BACK_BAR)

	if self.params_.hideHomeBtn ~= 1 then
		table.insert(var_24_0, HOME_BAR)
		manager.windowBar:RegistHomeCallBack(function()
			self:GoHome()
		end)
	end

	if self.params_.infoKey and self.params_.infoKey ~= "" then
		table.insert(var_24_0, INFO_BAR)
		manager.windowBar:SetGameHelpKey(self.params_.infoKey)
	end

	table.insert(var_24_0, NAVI_BAR)

	local var_24_1 = {}

	for iter_24_0 = 1, #ShopListCfg[arg_24_1].cost_id do
		local var_24_2 = CurrencyIdMapCfg[ShopListCfg[arg_24_1].cost_id[iter_24_0]] and CurrencyIdMapCfg[ShopListCfg[arg_24_1].cost_id[iter_24_0]].item_id or ShopListCfg[arg_24_1].cost_id[iter_24_0]

		if var_24_2 == CurrencyIdMapCfg.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE.item_id then
			var_24_2 = CurrencyConst.GetPlatformDiamondId()
		end

		table.insert(var_24_0, var_24_2)
		table.insert(var_24_1, var_24_2)
	end

	manager.windowBar:SwitchBar(var_24_0)

	for iter_24_1 = 1, #var_24_1 do
		manager.windowBar:SetBarCanAdd(var_24_1[iter_24_1], ShopConst.ADD_CURRENCY[var_24_1[iter_24_1]] == true)
		manager.windowBar:SetBarCanClick(var_24_1[iter_24_1], true)
	end

	manager.windowBar:RegistHomeCallBack(function()
		self:GoHome()
	end)
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.Back()
	end)
end

function NewActivityShopView:GoHome()
	gameContext:Go("/home", nil, nil, true)
end

function NewActivityShopView:UpdateShopList(arg_29_1)
	self.curShopId_ = arg_29_1
	self.shopDataList = ShopTools.FilterShopDataList(self.curShopId_, ShopListCfg[arg_29_1].chain_last_visible == 1)
	self.shopDataList = ShopTools.CommonSort(self.shopDataList)
	self.pos = self.needKeepPos1 and self.list:GetScrolledPosition() or nil

	self.list:StartScrollWithoutAnimator(#self.shopDataList, self.pos)

	self.needKeepPos1 = nil

	self:UpdateBarByShopId(self.curShopId_)
	self:UpdateTimer()
end

function NewActivityShopView:UpdateTimer()
	self.remainTimeTxt_.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStrWith2Unit(ActivityData:GetActivityData(ShopListCfg[self.curShopId_].activity_id).stopTime))

	for iter_30_0, iter_30_1 in pairs(self.list:GetItemList()) do
		iter_30_1:UpdateTimerView()
	end
end

function NewActivityShopView:SetTimer()
	SetActive(self.timebgGo_, not ShopConst.NEED_HIDE_TIME[self.curShopId_])
	self:StopTimer()
	self:UpdateTimer()

	self.refreshTimer_ = Timer.New(function()
		self:UpdateTimer()
	end, 1, -1, 1)

	self.refreshTimer_:Start()
end

function NewActivityShopView:OnExit()
	for iter_33_0, iter_33_1 in pairs(self.list:GetItemList()) do
		iter_33_1:OnExit()
	end

	self.enterTimer = nil

	manager.windowBar:HideBar()

	self.params_.hideHomeBtn = nil

	self:StopTimer()
	self:RemoveAllEventListener()
end

function NewActivityShopView:StopTimer()
	if self.refreshTimer_ then
		self.refreshTimer_:Stop()

		self.refreshTimer_ = nil
	end
end

function NewActivityShopView:Dispose()
	if self.list then
		self.list:Dispose()

		self.list = nil
	end

	for iter_35_0, iter_35_1 in ipairs(self.titleTogList) do
		iter_35_1:Dispose()
	end

	self:RemoveAllListeners()

	self.curShopId_ = nil

	NewActivityShopView.super.Dispose(self)
end

return NewActivityShopView
