local SkinDiscountGiftShopView = class("SkinDiscountGiftShopView", ReduxView)

SkinDiscountGiftShopView.TIPS_STATE = {
	INFO = "detail",
	NULL = "hide",
	NORMAL = "normal"
}

function SkinDiscountGiftShopView:UIName()
	return "Widget/System/Recharge/RechargeSkinEventShopUI_new"
end

function SkinDiscountGiftShopView:UIParent()
	return manager.ui.uiMain.transform
end

function SkinDiscountGiftShopView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.loopScrollView_ = LoopScrollView.New(self, self.scrollEx_, self.contTrs_, self.viewTrs_, self.viewTrs_.rect.width, self.contTrs_:GetComponent("HorizontalLayoutGroup").spacing, nil, true)
	self.item1Pool = {}
	self.item2Pool = {}
	self.maxCntController_ = self.controllerEx_:GetController("maxCnt")
	self.stateController_ = self.controllerEx_:GetController("costDisplayState")
	self.btnStateController_ = self.controllerEx_:GetController("btnState")
	self.OnSelectSkinGoodsHandler_ = handler(self, self.OnSelectSkinGoods)
	self.OnSelectSceneHandler_ = handler(self, self.OnSelectScene)
	self.skinCommonItem1_ = SkinDiscountGiftShopCommonItem.New(self.skinItem1_, true)
	self.sceneCommonItem1_ = SkinDiscountGiftShopCommonItem.New(self.sceneItem1_, true)
	self.skinCommonItem2_ = SkinDiscountGiftShopCommonItem.New(self.skinItem2_, true)
	self.sceneCommonItem2_ = SkinDiscountGiftShopCommonItem.New(self.sceneItem2_, true)
end

function SkinDiscountGiftShopView:OnTop()
	if SkinDiscountGiftData:GetUsedTimes(self.giftID_) >= ActivitySkinDiscountCfg[self.giftID_].limit_num then
		self:Back()
	end
end

function SkinDiscountGiftShopView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_SKIN
	})
	manager.windowBar:SetGameHelpKey("SKIN_DISCOUNT_GIFT_DESC")
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_SKIN, true)
	manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_TYPE_SKIN, true)
	manager.notify:RegistListener(SKIN_DISCOUNT_GIFT_SELECT_GOODS, self.OnSelectSkinGoodsHandler_)
	manager.notify:RegistListener(SKIN_DISCOUNT_FIGT_SELECT_SCENE, self.OnSelectSceneHandler_)

	self.giftID_ = self.params_.giftID
	self.activityID_ = ActivitySkinDiscountCfg[self.giftID_].activity_id
	self.goodsList_ = SkinDiscountGiftTools.GetGoodsList(self.giftID_, ActivitySkinDiscountCfg[self.giftID_].discount / 100)

	self.loopScrollView_:NavigateIndex(1)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.loopScrollView_.rectGrid_)

	self.loopScrollView_.scrollView_.horizontalNormalizedPosition = 0

	self:RefreshMaxCnt()
	self:RefreshUI()
end

function SkinDiscountGiftShopView:OnExit()
	manager.notify:RemoveListener(SKIN_DISCOUNT_GIFT_SELECT_GOODS, self.OnSelectSkinGoodsHandler_)
	manager.notify:RemoveListener(SKIN_DISCOUNT_FIGT_SELECT_SCENE, self.OnSelectSceneHandler_)

	self.tipsState_ = SkinDiscountGiftShopView.TIPS_STATE.NORMAL

	manager.windowBar:HideBar()
end

function SkinDiscountGiftShopView:Dispose()
	self.loopScrollView_:Dispose()

	self.loopScrollView_ = nil

	self.skinCommonItem1_:Dispose()

	self.skinCommonItem1_ = nil

	self.sceneCommonItem1_:Dispose()

	self.sceneCommonItem1_ = nil

	self.skinCommonItem2_:Dispose()

	self.skinCommonItem2_ = nil

	self.sceneCommonItem2_:Dispose()

	self.sceneCommonItem2_ = nil
	self.OnSelectSkinGoodsHandler_ = nil
	self.OnSelectSceneHandler_ = nil

	SkinDiscountGiftShopView.super.Dispose(self)
end

function SkinDiscountGiftShopView:AddListeners()
	self:AddBtnListener(self.buyBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(ActivitySkinDiscountCfg[self.giftID_].activity_id) then
			ShopTips("TIME_OVER")

			return
		end

		if #SkinDiscountGiftData:GetGoodsIDList() < ActivitySkinDiscountCfg[self.giftID_].optional_skin_num then
			ShowTips("PLEASE_SELECT_SKIN_GOODS")

			return
		end

		self:CheckBeforeBuy()
	end)
	self:AddBtnListener(self.infoBtn_, nil, function()
		SetActive(self.mask_, true)

		self.tipsState_ = SkinDiscountGiftShopView.TIPS_STATE.INFO

		self.stateController_:SetSelectedState(self.tipsState_)
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		SetActive(self.mask_, false)

		self.tipsState_ = SkinDiscountGiftShopView.TIPS_STATE.NORMAL

		self.stateController_:SetSelectedState(self.tipsState_)
	end)
end

function SkinDiscountGiftShopView:CheckBeforeBuy(arg_12_1)
	local var_12_0 = arg_12_1 or {}
	local var_12_1 = ActivitySkinDiscountCfg[self.giftID_]

	if not var_12_0.ignore_has_cheap_goods and SkinDiscountGiftTools.HasCheapGoodsList(self.giftID_) then
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("ACTIVITY_SKIN_DISCOUNT_HIGH_COST_EFFECTIVENESS_TIPS_2"),
			OkCallback = function()
				OperationRecorder.RecordButtonTouch({
					button_name = string.format("message_push_activity_%s_enter", var_12_1.activity_id),
					source = SkinDiscountGiftConst.EXIST_MORE_CHEAP_SKIN_TIPS
				})

				var_12_0.ignore_has_cheap_goods = true

				self:CheckBeforeBuy(var_12_0)
			end,
			CancelCallback = function()
				OperationRecorder.RecordButtonTouch({
					button_name = string.format("message_push_activity_%s_close", var_12_1.activity_id),
					source = SkinDiscountGiftConst.EXIST_MORE_CHEAP_SKIN_TIPS
				})
			end
		})
	elseif not var_12_0.ignore_has_dlc_scene and self:IsNotSelectScene() then
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("ACTIVITY_SKIN_DISCOUNT_HIGH_COST_EFFECTIVENESS_TIPS_3"),
			OkCallback = function()
				OperationRecorder.RecordButtonTouch({
					button_name = string.format("message_push_activity_%s_enter", var_12_1.activity_id),
					source = SkinDiscountGiftConst.BUY_SCENE_TIPS
				})

				var_12_0.ignore_has_dlc_scene = true

				self:CheckBeforeBuy(var_12_0)
			end,
			CancelCallback = function()
				OperationRecorder.RecordButtonTouch({
					button_name = string.format("message_push_activity_%s_close", var_12_1.activity_id),
					source = SkinDiscountGiftConst.BUY_SCENE_TIPS
				})
			end
		})
	else
		self:OnBuyItem()
	end
end

function SkinDiscountGiftShopView:OnBuyItem()
	local var_17_0 = ItemConst.SKIN_TICKET
	local var_17_1 = {}

	for iter_17_0, iter_17_1 in ipairs((SkinDiscountGiftData:GetGoodsIDList())) do
		local var_17_2 = iter_17_1.isSelectSceneID and iter_17_1.sceneGoodsID

		var_17_0 = getShopCfg(iter_17_1.skinGoodsID).cost_id

		if not SkinDiscountGiftTools.HasSkin(iter_17_1.skinGoodsID) then
			table.insert(var_17_1, iter_17_1.skinGoodsID)
		end

		if var_17_2 and not SkinDiscountGiftTools.HasScene(var_17_2) then
			table.insert(var_17_1, var_17_2)
		end
	end

	local var_17_3 = ActivitySkinDiscountCfg[self.giftID_]
	local var_17_4 = SkinDiscountGiftTools.GetTotalDiscountPrice(ActivitySkinDiscountCfg[self.giftID_].discount / 100)

	ShowMessageBox({
		title = GetTips("PROMPT"),
		content = string.format(GetTips("SKIN_GIFT_BUY_TIPS"), ItemTools.getItemName(var_17_0), var_17_4, GetI18NText(ActivitySkinDiscountCfg[self.giftID_].goods_name)),
		OkCallback = function()
			if ItemTools.getItemNum(var_17_0) >= var_17_4 then
				SkinDiscountGiftAction.BuySkinDiscountGift(var_17_3.activity_id, self.giftID_, var_17_1, function(arg_19_0)
					self.loopScrollView_:NavigateIndex(1)
					self:RefreshUI()
				end)
			else
				ShowMessageBox({
					title = GetTips("PROMPT"),
					content = GetTips("ERROR_ITEM_NOT_SKIN_TICKET_C"),
					OkCallback = function()
						JumpTools.GoToSystem("/rechargeMain", {
							childShopIndex = 4,
							page = 2
						}, ViewConst.SYSTEM_ID.RECHARGE_MAIN)
					end
				})
			end
		end
	})
end

function SkinDiscountGiftShopView:RefreshMaxCnt()
	self.discountText_.text = string.format("%.1f%s", ActivitySkinDiscountCfg[self.giftID_].discount / 10, GetI18NText(GetTips("LABEL_DISCOUNT")))

	if ActivitySkinDiscountCfg[self.giftID_].optional_skin_num == 1 then
		self.maxCntController_:SetSelectedState("false")
	else
		self.maxCntController_:SetSelectedState("true")
	end
end

function SkinDiscountGiftShopView:OnSelectSkinGoods(arg_22_1, arg_22_2)
	if SkinDiscountGiftTools.IsSelectSkinGoodsID(arg_22_1) then
		SkinDiscountGiftData:RemoveGoodsIDList(arg_22_1)
	else
		if SkinDiscountGiftTools.IsFullSkinGoodsID(ActivitySkinDiscountCfg[self.giftID_].optional_skin_num) then
			ShowTips("ACTIVITY_SKIN_DISCOUNT_SKIN_NUM_LIMIT_TIPS")

			return
		end

		SkinDiscountGiftData:AddGoodsIDList(arg_22_1, arg_22_2, not SkinDiscountGiftTools.HasScene(arg_22_2))
	end

	self.loopScrollView_:RefreshScrollView(true, true)
	self:RefreshUI()
end

function SkinDiscountGiftShopView:OnSelectScene(arg_23_1)
	SkinDiscountGiftData:UpdateGoodsIDList(arg_23_1)
	self.loopScrollView_:RefreshScrollView(true, true)
	self:RefreshUI()
end

function SkinDiscountGiftShopView:RefreshUI()
	self:RefreshSelectPanel()
	self:RefreshTotalCost()
end

function SkinDiscountGiftShopView:RefreshSelectPanel()
	local var_25_0 = SkinDiscountGiftData:GetGoodsIDList()

	for iter_25_0 = 1, 2 do
		local var_25_1 = var_25_0[iter_25_0]

		if iter_25_0 == 1 then
			local var_25_2 = var_25_1 and var_25_1.skinGoodsID
			local var_25_3 = var_25_1 and var_25_1.sceneGoodsID

			if (var_25_1 and var_25_1.skinGoodsID) == nil then
				self.skinCommonItem1_:SetData(nil)
			else
				local var_25_4 = clone(ItemTemplateData)

				var_25_4.id = SkinDiscountGiftTools.GetItemIDByGoodsID(var_25_2)
				var_25_4.number = nil
				var_25_4.skinGiftSelect = true

				function var_25_4.clickFun()
					self:OnSelectSkinGoods(var_25_2, var_25_3)
				end

				self.skinCommonItem1_:SetData(var_25_4)
			end

			if var_25_3 == nil then
				self.sceneCommonItem1_:SetData(nil)
				self.sceneCommonItem1_:Show(var_25_2 == nil)
			else
				self.sceneCommonItem1_:Show(true)

				local var_25_5 = clone(ItemTemplateData)

				var_25_5.id = SkinDiscountGiftTools.GetItemIDByGoodsID(var_25_3)
				var_25_5.number = nil
				var_25_5.skinGiftSelect = var_25_1.isSelectSceneID

				function var_25_5.clickFun()
					self:OnSelectScene(var_25_2)
				end

				self.sceneCommonItem1_:SetData(var_25_5)
			end
		else
			local var_25_6 = var_25_1 and var_25_1.skinGoodsID
			local var_25_7 = var_25_1 and var_25_1.sceneGoodsID

			if (var_25_1 and var_25_1.skinGoodsID) == nil then
				self.skinCommonItem2_:SetData(nil)
			else
				local var_25_8 = clone(ItemTemplateData)

				var_25_8.id = SkinDiscountGiftTools.GetItemIDByGoodsID(var_25_6)
				var_25_8.number = nil
				var_25_8.skinGiftSelect = true

				function var_25_8.clickFun()
					self:OnSelectSkinGoods(var_25_6, var_25_7)
				end

				self.skinCommonItem2_:SetData(var_25_8)
			end

			if var_25_7 == nil then
				self.sceneCommonItem2_:SetData(nil)
				self.sceneCommonItem2_:Show(var_25_6 == nil)
			else
				self.sceneCommonItem2_:Show(true)

				local var_25_9 = clone(ItemTemplateData)

				var_25_9.id = SkinDiscountGiftTools.GetItemIDByGoodsID(var_25_7)
				var_25_9.number = nil
				var_25_9.skinGiftSelect = var_25_1.isSelectSceneID

				function var_25_9.clickFun()
					self:OnSelectScene(var_25_6)
				end

				self.sceneCommonItem2_:SetData(var_25_9)
			end
		end
	end
end

local var_0_1 = "%s"
local var_0_2 = "<color=#D64646>%s</color>"

function SkinDiscountGiftShopView:RefreshTotalCost()
	local var_30_0 = 0
	local var_30_3 = SkinDiscountGiftData:GetGoodsIDList()

	for iter_30_0 = 1, 2 do
		local var_30_4 = var_30_3[iter_30_0]
		local var_30_5 = 0
		local var_30_6 = 0

		if var_30_3[iter_30_0] then
			local var_30_7, var_30_8 = ShopTools.GetPrice(var_30_4.skinGoodsID)

			if var_30_4.isSelectSceneID and var_30_4.sceneGoodsID then
				local var_30_9, var_30_10 = ShopTools.GetPrice(var_30_4.sceneGoodsID)

				self[string.format("priceText%s_", iter_30_0)].text = iter_30_0 > 1 and string.format("+%s+%s", var_30_7, var_30_9) or string.format("%s+%s", var_30_7, var_30_9)
				var_30_6 = var_30_8 + var_30_10
				var_30_5 = var_30_7 + var_30_9
			else
				self[string.format("priceText%s_", iter_30_0)].text = iter_30_0 > 1 and string.format("+%s", var_30_7) or string.format("%s", var_30_7)
				var_30_6 = var_30_8
				var_30_5 = var_30_7
			end

			self[string.format("originPriceText%s_", iter_30_0)].text = iter_30_0 > 1 and string.format("+%s", var_30_6) or var_30_6
		end

		SetActive(self[string.format("originPriceText%s_", iter_30_0)].gameObject, var_30_6 ~= 0 and var_30_6 ~= var_30_5)
		SetActive(self[string.format("priceText%s_", iter_30_0)].gameObject, var_30_4 ~= nil)

		var_30_0 = var_30_0 + var_30_5
	end

	local var_30_14 = SkinDiscountGiftTools.GetTotalDiscountPrice(ActivitySkinDiscountCfg[self.giftID_].discount / 100)

	self.priceText_.text = string.format(var_30_14 <= ItemTools.getItemNum(ItemConst.SKIN_TICKET) and var_0_1 or var_0_2, var_30_14)
	self.originPriceText_.text = var_30_0
	self.returnText_.text = SkinDiscountGiftTools.GetReturePrice()

	if #var_30_3 == 0 then
		self.tipsState_ = SkinDiscountGiftShopView.TIPS_STATE.NULL
	elseif self.tipsState_ == SkinDiscountGiftShopView.TIPS_STATE.NULL then
		self.tipsState_ = SkinDiscountGiftShopView.TIPS_STATE.NORMAL
	end

	self.stateController_:SetSelectedState(self.tipsState_)
	self:RefreshBtnState()
end

function SkinDiscountGiftShopView:RefreshBtnState()
	if #SkinDiscountGiftData:GetGoodsIDList() < ActivitySkinDiscountCfg[self.giftID_].optional_skin_num then
		self.btnStateController_:SetSelectedState("false")
	else
		self.btnStateController_:SetSelectedState("true")
	end
end

function SkinDiscountGiftShopView:IsNotSelectScene()
	for iter_32_0, iter_32_1 in ipairs((SkinDiscountGiftData:GetGoodsIDList())) do
		if iter_32_1.sceneGoodsID ~= 0 and not SkinDiscountGiftTools.HasScene(iter_32_1.sceneGoodsID) and iter_32_1.isSelectSceneID == false then
			return true
		end
	end

	return false
end

function SkinDiscountGiftShopView:IndexItem(arg_33_1, arg_33_2)
	arg_33_2:SetData(self.goodsList_[arg_33_1])
end

function SkinDiscountGiftShopView:LsRemoveItem(arg_34_1)
	arg_34_1.itemView:Show(false)

	arg_34_1.isFree = true
end

function SkinDiscountGiftShopView:GetFreeItem(arg_35_1, arg_35_2)
	for iter_35_0, iter_35_1 in pairs(arg_35_1) do
		if iter_35_1.isFree == true then
			iter_35_1.isFree = false

			return iter_35_1
		end
	end

	local var_35_0 = {
		isFree = false,
		itemView = arg_35_2()
	}

	table.insert(arg_35_1, var_35_0)

	return var_35_0
end

function SkinDiscountGiftShopView:LsAddItem(arg_36_1, arg_36_2)
	local var_36_0 = SkinDiscountGiftTools.IsSelectSkinGoodsID(arg_36_1[1]) and arg_36_1[2] and self:GetFreeItem(self.item1Pool, function()
		return SkinDiscountGiftShopSkinDLCItem.New(self.itemDLCGo_, self.contTrs_.gameObject)
	end) or self:GetFreeItem(self.item2Pool, function()
		return SkinDiscountGiftShopItem.New(self.itemGo_, self.contTrs_.gameObject)
	end)

	var_36_0.itemView:SetData(arg_36_1, arg_36_2)

	return var_36_0
end

function SkinDiscountGiftShopView:LsGetItemData()
	return self.goodsList_
end

function SkinDiscountGiftShopView:LsUpdateItem(arg_40_1, arg_40_2, arg_40_3)
	arg_40_1.itemView:SetData(arg_40_2, arg_40_3)
end

return SkinDiscountGiftShopView
