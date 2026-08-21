local var_0_0 = class("SkinDiscountGiftShopView", ReduxView)

var_0_0.TIPS_STATE = {
	INFO = "detail",
	NULL = "hide",
	NORMAL = "normal"
}

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Recharge/RechargeSkinEventShopUI_new"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	local var_3_0 = arg_3_0.viewTrs_.rect.width
	local var_3_1 = arg_3_0.contTrs_:GetComponent("HorizontalLayoutGroup").spacing

	arg_3_0.loopScrollView_ = LoopScrollView.New(arg_3_0, arg_3_0.scrollEx_, arg_3_0.contTrs_, arg_3_0.viewTrs_, var_3_0, var_3_1, nil, true)
	arg_3_0.item1Pool = {}
	arg_3_0.item2Pool = {}
	arg_3_0.maxCntController_ = arg_3_0.controllerEx_:GetController("maxCnt")
	arg_3_0.stateController_ = arg_3_0.controllerEx_:GetController("costDisplayState")
	arg_3_0.btnStateController_ = arg_3_0.controllerEx_:GetController("btnState")
	arg_3_0.OnSelectSkinGoodsHandler_ = handler(arg_3_0, arg_3_0.OnSelectSkinGoods)
	arg_3_0.OnSelectSceneHandler_ = handler(arg_3_0, arg_3_0.OnSelectScene)
	arg_3_0.skinCommonItem1_ = SkinDiscountGiftShopCommonItem.New(arg_3_0.skinItem1_, true)
	arg_3_0.sceneCommonItem1_ = SkinDiscountGiftShopCommonItem.New(arg_3_0.sceneItem1_, true)
	arg_3_0.skinCommonItem2_ = SkinDiscountGiftShopCommonItem.New(arg_3_0.skinItem2_, true)
	arg_3_0.sceneCommonItem2_ = SkinDiscountGiftShopCommonItem.New(arg_3_0.sceneItem2_, true)
end

function var_0_0.OnTop(arg_4_0)
	if SkinDiscountGiftData:GetUsedTimes(arg_4_0.giftID_) >= ActivitySkinDiscountCfg[arg_4_0.giftID_].limit_num then
		arg_4_0:Back()
	end
end

function var_0_0.OnEnter(arg_5_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_SKIN
	})
	manager.windowBar:SetGameHelpKey("SKIN_DISCOUNT_GIFT_DESC")
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_SKIN, true)
	manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_TYPE_SKIN, true)
	manager.notify:RegistListener(SKIN_DISCOUNT_GIFT_SELECT_GOODS, arg_5_0.OnSelectSkinGoodsHandler_)
	manager.notify:RegistListener(SKIN_DISCOUNT_FIGT_SELECT_SCENE, arg_5_0.OnSelectSceneHandler_)

	arg_5_0.giftID_ = arg_5_0.params_.giftID

	local var_5_0 = ActivitySkinDiscountCfg[arg_5_0.giftID_]

	arg_5_0.activityID_ = var_5_0.activity_id
	arg_5_0.goodsList_ = SkinDiscountGiftTools.GetGoodsList(arg_5_0.giftID_, var_5_0.discount / 100)

	arg_5_0.loopScrollView_:NavigateIndex(1)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_5_0.loopScrollView_.rectGrid_)

	arg_5_0.loopScrollView_.scrollView_.horizontalNormalizedPosition = 0

	arg_5_0:RefreshMaxCnt()
	arg_5_0:RefreshUI()
end

function var_0_0.OnExit(arg_6_0)
	manager.notify:RemoveListener(SKIN_DISCOUNT_GIFT_SELECT_GOODS, arg_6_0.OnSelectSkinGoodsHandler_)
	manager.notify:RemoveListener(SKIN_DISCOUNT_FIGT_SELECT_SCENE, arg_6_0.OnSelectSceneHandler_)

	arg_6_0.tipsState_ = var_0_0.TIPS_STATE.NORMAL

	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0.loopScrollView_:Dispose()

	arg_7_0.loopScrollView_ = nil

	arg_7_0.skinCommonItem1_:Dispose()

	arg_7_0.skinCommonItem1_ = nil

	arg_7_0.sceneCommonItem1_:Dispose()

	arg_7_0.sceneCommonItem1_ = nil

	arg_7_0.skinCommonItem2_:Dispose()

	arg_7_0.skinCommonItem2_ = nil

	arg_7_0.sceneCommonItem2_:Dispose()

	arg_7_0.sceneCommonItem2_ = nil
	arg_7_0.OnSelectSkinGoodsHandler_ = nil
	arg_7_0.OnSelectSceneHandler_ = nil

	var_0_0.super.Dispose(arg_7_0)
end

function var_0_0.AddListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.buyBtn_, nil, function()
		local var_9_0 = ActivitySkinDiscountCfg[arg_8_0.giftID_]

		if not ActivityData:GetActivityIsOpen(var_9_0.activity_id) then
			ShopTips("TIME_OVER")

			return
		end

		if #SkinDiscountGiftData:GetGoodsIDList() < var_9_0.optional_skin_num then
			ShowTips("PLEASE_SELECT_SKIN_GOODS")

			return
		end

		arg_8_0:CheckBeforeBuy()
	end)
	arg_8_0:AddBtnListener(arg_8_0.infoBtn_, nil, function()
		SetActive(arg_8_0.mask_, true)

		arg_8_0.tipsState_ = var_0_0.TIPS_STATE.INFO

		arg_8_0.stateController_:SetSelectedState(arg_8_0.tipsState_)
	end)
	arg_8_0:AddBtnListener(arg_8_0.maskBtn_, nil, function()
		SetActive(arg_8_0.mask_, false)

		arg_8_0.tipsState_ = var_0_0.TIPS_STATE.NORMAL

		arg_8_0.stateController_:SetSelectedState(arg_8_0.tipsState_)
	end)
end

function var_0_0.CheckBeforeBuy(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1 or {}
	local var_12_1 = ActivitySkinDiscountCfg[arg_12_0.giftID_]

	if not var_12_0.ignore_has_cheap_goods and SkinDiscountGiftTools.HasCheapGoodsList(arg_12_0.giftID_) then
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("ACTIVITY_SKIN_DISCOUNT_HIGH_COST_EFFECTIVENESS_TIPS_2"),
			OkCallback = function()
				OperationRecorder.RecordButtonTouch({
					button_name = string.format("message_push_activity_%s_enter", var_12_1.activity_id),
					source = SkinDiscountGiftConst.EXIST_MORE_CHEAP_SKIN_TIPS
				})

				var_12_0.ignore_has_cheap_goods = true

				arg_12_0:CheckBeforeBuy(var_12_0)
			end,
			CancelCallback = function()
				OperationRecorder.RecordButtonTouch({
					button_name = string.format("message_push_activity_%s_close", var_12_1.activity_id),
					source = SkinDiscountGiftConst.EXIST_MORE_CHEAP_SKIN_TIPS
				})
			end
		})
	elseif not var_12_0.ignore_has_dlc_scene and arg_12_0:IsNotSelectScene() then
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("ACTIVITY_SKIN_DISCOUNT_HIGH_COST_EFFECTIVENESS_TIPS_3"),
			OkCallback = function()
				OperationRecorder.RecordButtonTouch({
					button_name = string.format("message_push_activity_%s_enter", var_12_1.activity_id),
					source = SkinDiscountGiftConst.BUY_SCENE_TIPS
				})

				var_12_0.ignore_has_dlc_scene = true

				arg_12_0:CheckBeforeBuy(var_12_0)
			end,
			CancelCallback = function()
				OperationRecorder.RecordButtonTouch({
					button_name = string.format("message_push_activity_%s_close", var_12_1.activity_id),
					source = SkinDiscountGiftConst.BUY_SCENE_TIPS
				})
			end
		})
	else
		arg_12_0:OnBuyItem()
	end
end

function var_0_0.OnBuyItem(arg_17_0)
	local var_17_0 = ItemConst.SKIN_TICKET
	local var_17_1 = {}
	local var_17_2 = SkinDiscountGiftData:GetGoodsIDList()

	for iter_17_0, iter_17_1 in ipairs(var_17_2) do
		local var_17_3 = iter_17_1.skinGoodsID
		local var_17_4 = iter_17_1.isSelectSceneID and iter_17_1.sceneGoodsID

		var_17_0 = getShopCfg(var_17_3).cost_id

		if not SkinDiscountGiftTools.HasSkin(var_17_3) then
			table.insert(var_17_1, var_17_3)
		end

		if var_17_4 and not SkinDiscountGiftTools.HasScene(var_17_4) then
			table.insert(var_17_1, var_17_4)
		end
	end

	local var_17_5 = ActivitySkinDiscountCfg[arg_17_0.giftID_]
	local var_17_6 = SkinDiscountGiftTools.GetTotalDiscountPrice(var_17_5.discount / 100)

	ShowMessageBox({
		title = GetTips("PROMPT"),
		content = string.format(GetTips("SKIN_GIFT_BUY_TIPS"), ItemTools.getItemName(var_17_0), var_17_6, GetI18NText(var_17_5.goods_name)),
		OkCallback = function()
			if ItemTools.getItemNum(var_17_0) >= var_17_6 then
				SkinDiscountGiftAction.BuySkinDiscountGift(var_17_5.activity_id, arg_17_0.giftID_, var_17_1, function(arg_19_0)
					arg_17_0.loopScrollView_:NavigateIndex(1)
					arg_17_0:RefreshUI()
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

function var_0_0.RefreshMaxCnt(arg_21_0)
	local var_21_0 = ActivitySkinDiscountCfg[arg_21_0.giftID_]
	local var_21_1 = var_21_0.discount

	arg_21_0.discountText_.text = string.format("%.1f%s", var_21_1 / 10, GetI18NText(GetTips("LABEL_DISCOUNT")))

	if var_21_0.optional_skin_num == 1 then
		arg_21_0.maxCntController_:SetSelectedState("false")
	else
		arg_21_0.maxCntController_:SetSelectedState("true")
	end
end

function var_0_0.OnSelectSkinGoods(arg_22_0, arg_22_1, arg_22_2)
	if SkinDiscountGiftTools.IsSelectSkinGoodsID(arg_22_1) then
		SkinDiscountGiftData:RemoveGoodsIDList(arg_22_1)
	else
		if SkinDiscountGiftTools.IsFullSkinGoodsID(ActivitySkinDiscountCfg[arg_22_0.giftID_].optional_skin_num) then
			ShowTips("ACTIVITY_SKIN_DISCOUNT_SKIN_NUM_LIMIT_TIPS")

			return
		end

		local var_22_0 = true

		if SkinDiscountGiftTools.HasScene(arg_22_2) then
			var_22_0 = false
		end

		SkinDiscountGiftData:AddGoodsIDList(arg_22_1, arg_22_2, var_22_0)
	end

	arg_22_0.loopScrollView_:RefreshScrollView(true, true)
	arg_22_0:RefreshUI()
end

function var_0_0.OnSelectScene(arg_23_0, arg_23_1)
	SkinDiscountGiftData:UpdateGoodsIDList(arg_23_1)
	arg_23_0.loopScrollView_:RefreshScrollView(true, true)
	arg_23_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_24_0)
	arg_24_0:RefreshSelectPanel()
	arg_24_0:RefreshTotalCost()
end

function var_0_0.RefreshSelectPanel(arg_25_0)
	local var_25_0 = SkinDiscountGiftData:GetGoodsIDList()

	for iter_25_0 = 1, 2 do
		local var_25_1 = var_25_0[iter_25_0]

		if iter_25_0 == 1 then
			local var_25_2 = var_25_1 and var_25_1.skinGoodsID
			local var_25_3 = var_25_1 and var_25_1.sceneGoodsID

			if var_25_2 == nil then
				arg_25_0.skinCommonItem1_:SetData(nil)
			else
				local var_25_4 = clone(ItemTemplateData)

				var_25_4.id = SkinDiscountGiftTools.GetItemIDByGoodsID(var_25_2)
				var_25_4.number = nil
				var_25_4.skinGiftSelect = true

				function var_25_4.clickFun()
					arg_25_0:OnSelectSkinGoods(var_25_2, var_25_3)
				end

				arg_25_0.skinCommonItem1_:SetData(var_25_4)
			end

			if var_25_3 == nil then
				arg_25_0.sceneCommonItem1_:SetData(nil)
				arg_25_0.sceneCommonItem1_:Show(var_25_2 == nil)
			else
				arg_25_0.sceneCommonItem1_:Show(true)

				local var_25_5 = clone(ItemTemplateData)

				var_25_5.id = SkinDiscountGiftTools.GetItemIDByGoodsID(var_25_3)
				var_25_5.number = nil
				var_25_5.skinGiftSelect = var_25_1.isSelectSceneID

				function var_25_5.clickFun()
					arg_25_0:OnSelectScene(var_25_2)
				end

				arg_25_0.sceneCommonItem1_:SetData(var_25_5)
			end
		else
			local var_25_6 = var_25_1 and var_25_1.skinGoodsID
			local var_25_7 = var_25_1 and var_25_1.sceneGoodsID

			if var_25_6 == nil then
				arg_25_0.skinCommonItem2_:SetData(nil)
			else
				local var_25_8 = clone(ItemTemplateData)

				var_25_8.id = SkinDiscountGiftTools.GetItemIDByGoodsID(var_25_6)
				var_25_8.number = nil
				var_25_8.skinGiftSelect = true

				function var_25_8.clickFun()
					arg_25_0:OnSelectSkinGoods(var_25_6, var_25_7)
				end

				arg_25_0.skinCommonItem2_:SetData(var_25_8)
			end

			if var_25_7 == nil then
				arg_25_0.sceneCommonItem2_:SetData(nil)
				arg_25_0.sceneCommonItem2_:Show(var_25_6 == nil)
			else
				arg_25_0.sceneCommonItem2_:Show(true)

				local var_25_9 = clone(ItemTemplateData)

				var_25_9.id = SkinDiscountGiftTools.GetItemIDByGoodsID(var_25_7)
				var_25_9.number = nil
				var_25_9.skinGiftSelect = var_25_1.isSelectSceneID

				function var_25_9.clickFun()
					arg_25_0:OnSelectScene(var_25_6)
				end

				arg_25_0.sceneCommonItem2_:SetData(var_25_9)
			end
		end
	end
end

local var_0_1 = "%s"
local var_0_2 = "<color=#D64646>%s</color>"

function var_0_0.RefreshTotalCost(arg_30_0)
	local var_30_0 = ItemConst.SKIN_TICKET
	local var_30_1 = 0
	local var_30_2 = {}
	local var_30_3 = {}
	local var_30_4 = SkinDiscountGiftData:GetGoodsIDList()
	local var_30_5 = ActivitySkinDiscountCfg[arg_30_0.giftID_].discount / 100

	for iter_30_0 = 1, 2 do
		local var_30_6 = var_30_4[iter_30_0]
		local var_30_7 = 0
		local var_30_8 = 0

		if var_30_6 then
			local var_30_9, var_30_10 = ShopTools.GetPrice(var_30_6.skinGoodsID)

			if var_30_6.isSelectSceneID and var_30_6.sceneGoodsID then
				local var_30_11, var_30_12 = ShopTools.GetPrice(var_30_6.sceneGoodsID)

				arg_30_0[string.format("priceText%s_", iter_30_0)].text = iter_30_0 > 1 and string.format("+%s+%s", var_30_9, var_30_11) or string.format("%s+%s", var_30_9, var_30_11)
				var_30_8 = var_30_10 + var_30_12
				var_30_7 = var_30_9 + var_30_11
			else
				arg_30_0[string.format("priceText%s_", iter_30_0)].text = iter_30_0 > 1 and string.format("+%s", var_30_9) or string.format("%s", var_30_9)
				var_30_8 = var_30_10
				var_30_7 = var_30_9
			end

			arg_30_0[string.format("originPriceText%s_", iter_30_0)].text = iter_30_0 > 1 and string.format("+%s", var_30_8) or var_30_8
		end

		SetActive(arg_30_0[string.format("originPriceText%s_", iter_30_0)].gameObject, var_30_8 ~= 0 and var_30_8 ~= var_30_7)
		SetActive(arg_30_0[string.format("priceText%s_", iter_30_0)].gameObject, var_30_6 ~= nil)

		var_30_1 = var_30_1 + var_30_7
	end

	local var_30_13 = SkinDiscountGiftTools.GetTotalDiscountPrice(var_30_5)
	local var_30_14

	if var_30_13 <= ItemTools.getItemNum(var_30_0) then
		var_30_14 = var_0_1
	else
		var_30_14 = var_0_2
	end

	arg_30_0.priceText_.text = string.format(var_30_14, var_30_13)
	arg_30_0.originPriceText_.text = var_30_1
	arg_30_0.returnText_.text = SkinDiscountGiftTools.GetReturePrice()

	if #var_30_4 == 0 then
		arg_30_0.tipsState_ = var_0_0.TIPS_STATE.NULL
	elseif arg_30_0.tipsState_ == var_0_0.TIPS_STATE.NULL then
		arg_30_0.tipsState_ = var_0_0.TIPS_STATE.NORMAL
	end

	arg_30_0.stateController_:SetSelectedState(arg_30_0.tipsState_)
	arg_30_0:RefreshBtnState()
end

function var_0_0.RefreshBtnState(arg_31_0)
	local var_31_0 = ActivitySkinDiscountCfg[arg_31_0.giftID_]

	if #SkinDiscountGiftData:GetGoodsIDList() < var_31_0.optional_skin_num then
		arg_31_0.btnStateController_:SetSelectedState("false")
	else
		arg_31_0.btnStateController_:SetSelectedState("true")
	end
end

function var_0_0.IsNotSelectScene(arg_32_0)
	local var_32_0 = SkinDiscountGiftData:GetGoodsIDList()

	for iter_32_0, iter_32_1 in ipairs(var_32_0) do
		local var_32_1 = iter_32_1.sceneGoodsID

		if var_32_1 ~= 0 and not SkinDiscountGiftTools.HasScene(var_32_1) and iter_32_1.isSelectSceneID == false then
			return true
		end
	end

	return false
end

function var_0_0.IndexItem(arg_33_0, arg_33_1, arg_33_2)
	arg_33_2:SetData(arg_33_0.goodsList_[arg_33_1])
end

function var_0_0.LsRemoveItem(arg_34_0, arg_34_1)
	arg_34_1.itemView:Show(false)

	arg_34_1.isFree = true
end

function var_0_0.GetFreeItem(arg_35_0, arg_35_1, arg_35_2)
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

function var_0_0.LsAddItem(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0

	if SkinDiscountGiftTools.IsSelectSkinGoodsID(arg_36_1[1]) and arg_36_1[2] then
		var_36_0 = arg_36_0:GetFreeItem(arg_36_0.item1Pool, function()
			return SkinDiscountGiftShopSkinDLCItem.New(arg_36_0.itemDLCGo_, arg_36_0.contTrs_.gameObject)
		end)
	else
		var_36_0 = arg_36_0:GetFreeItem(arg_36_0.item2Pool, function()
			return SkinDiscountGiftShopItem.New(arg_36_0.itemGo_, arg_36_0.contTrs_.gameObject)
		end)
	end

	var_36_0.itemView:SetData(arg_36_1, arg_36_2)

	return var_36_0
end

function var_0_0.LsGetItemData(arg_39_0)
	return arg_39_0.goodsList_
end

function var_0_0.LsUpdateItem(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	arg_40_1.itemView:SetData(arg_40_2, arg_40_3)
end

return var_0_0
