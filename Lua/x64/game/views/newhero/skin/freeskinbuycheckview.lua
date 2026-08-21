local var_0_0 = class("FreeSkinBuyCheckView", ReduxView)
local var_0_1 = {
	ViewDlc = 1,
	notViewDlc = 2
}

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Recharge/RechargeSkinPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.dlcselController = arg_4_0.controller_:GetController("dlcsel")
	arg_4_0.dlcbtnController = arg_4_0.controller_:GetController("dlcbtn")
	arg_4_0.dlcbgController = arg_4_0.controller_:GetController("dlcbg")
	arg_4_0.dlcIconController = arg_4_0.controller_:GetController("dlcIcon")
	arg_4_0.discountController = arg_4_0.controller_:GetController("discount")
	arg_4_0.giveBackItem2 = CommonItemView.New(arg_4_0.giveBackGo2_, true)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.calcelBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.checkBtn_, nil, function()
		local var_8_0, var_8_1, var_8_2 = ShopTools.GetPrice(arg_5_0.goodID)
		local var_8_3 = var_8_0
		local var_8_4 = {
			arg_5_0.goodID,
			arg_5_0.dlcID
		}

		local function var_8_5()
			if ShopTools.IsRMB(arg_5_0.goodID) == false and ShopTools.GetCostCount(arg_5_0.goodID) < var_8_3 then
				ShopTools.ConfirmBuySkin(var_8_4, {
					1,
					1
				})
			else
				ShopTools.ConfirmBuySkin(var_8_4, {
					1,
					1
				})
				SDKTools.SendPaymentMessageToSDK("payment_touch", {
					payment_skin_buy_unlock = 0
				})
			end
		end

		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_skin_buy_check = arg_5_0.skinID
		})

		if ShopData.IsGoodOutOfDate(arg_5_0.goodID) then
			ShowTips("SKIN_SALE_FINISH")
			arg_5_0:Back()

			return
		end

		if HeroData:GetHeroData(arg_5_0.heroID).unlock == 0 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("NOT_HAVE_HERO_SKIN_CONFIRM"), GetI18NText(arg_5_0.heroCfg.name)),
				OkCallback = var_8_5,
				CancelCallback = function()
					SDKTools.SendPaymentMessageToSDK("payment_touch", {
						payment_skin_buy_unlock = 1
					})
				end
			})
		else
			var_8_5()
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.freeViewBtn_, nil, function()
		arg_5_0.showModel = var_0_1.ViewDlc

		arg_5_0:UpdateView()
	end)
	arg_5_0:AddBtnListener(arg_5_0.freeViewBackBtn_, nil, function()
		arg_5_0.showModel = var_0_1.notViewDlc

		arg_5_0:UpdateView()
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnView_, nil, function()
		JumpTools.OpenPageByJump("/skinDlcShow", {
			goodId = arg_5_0.goodID
		})
	end)
end

function var_0_0.OnShopBuyResult(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	if arg_14_1 == 0 then
		arg_14_0:Back()
	else
		arg_14_0:Back()
	end
end

function var_0_0.UpdateBar(arg_15_0)
	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_DIAMOND,
		CurrencyConst.GetPlatformDiamondId(),
		CurrencyConst.CURRENCY_TYPE_SKIN
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_SKIN, true)
	manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_TYPE_SKIN, true)
end

function var_0_0.OnTop(arg_16_0)
	arg_16_0:UpdateBar()
	manager.windowBar:SetAsLastSibling()
end

function var_0_0.UpdateData(arg_17_0)
	arg_17_0.shopCfg = getShopCfg(arg_17_0.goodID)
	arg_17_0.shopID = arg_17_0.shopCfg.shop_id
	arg_17_0.skinCfg = SkinCfg[arg_17_0.skinID]
	arg_17_0.heroCfg = HeroCfg[arg_17_0.skinCfg.hero]
	arg_17_0.desCfg = RechargeShopDescriptionCfg[arg_17_0.shopCfg.description]
	arg_17_0.descID = arg_17_0.desCfg.id
	arg_17_0.dlcID = arg_17_0.shopCfg.dlc or nil
	arg_17_0.shopDlcCfg = getShopCfg(arg_17_0.dlcID)
	arg_17_0.itemDlcCfg = RechargeShopDescriptionCfg[arg_17_0.shopDlcCfg.description]
	arg_17_0.showModel = var_0_1.ViewDlc
end

function var_0_0.UpdatePrice(arg_18_0)
	local var_18_0, var_18_1, var_18_2 = ShopTools.GetPrice(arg_18_0.goodID)
	local var_18_3 = 0
	local var_18_4 = 0
	local var_18_5 = 0

	if arg_18_0.dlcID and arg_18_0.dlcID ~= 0 then
		local var_18_6

		var_18_3, var_18_4, var_18_6 = ShopTools.GetPrice(arg_18_0.dlcID)
	end

	local var_18_7 = ItemCfg[arg_18_0.skinCfg.hero]

	SetActive(arg_18_0.oriOriceTxt_.gameObject, false)
	SetActive(arg_18_0.skinOriginTxt_.gameObject, false)
	SetActive(arg_18_0.dlcPrice_.gameObject, false)
	arg_18_0.dlcbgController:SetSelectedState("false")

	local var_18_8, var_18_9, var_18_10 = ShopTools.IsOnDiscountArea(arg_18_0.goodID)

	arg_18_0.buyDesc_.text = string.format(GetTips("BUY_SKIN_FREE_DLC_TIPS"), ItemTools.getItemName(arg_18_0.shopCfg.cost_id), var_18_0, ItemTools.getItemName(var_18_7.id), ItemTools.getItemName(arg_18_0.shopCfg.description), ItemTools.getItemName(arg_18_0.itemDlcCfg.id))

	SetActive(arg_18_0.costiconImg_.gameObject, true)

	if var_18_8 and var_18_10 then
		SetActive(arg_18_0.skinOriginTxt_.gameObject, var_18_0 ~= var_18_1)

		if var_18_0 ~= var_18_1 then
			arg_18_0.skinOriginTxt_.text = var_18_1
		end
	end

	arg_18_0.costiconImg_.sprite = ItemTools.getItemLittleSprite(arg_18_0.shopCfg.cost_id)
	arg_18_0.priceText_.text = var_18_0 + var_18_3

	if var_18_0 > ItemTools.getItemNum(arg_18_0.shopCfg.cost_id) then
		arg_18_0.priceText_.text = "<color=#FF000B>" .. var_18_0 .. "</color>"
	end

	if #arg_18_0.shopCfg.give_back_list ~= 0 then
		arg_18_0.rebackSkinTicketText_.text = arg_18_0.shopCfg.give_back_list[1].num
		arg_18_0.allrebackTxt_.text = ""
	end

	if arg_18_0.showModel == var_0_1.notViewDlc then
		arg_18_0.allPriceTxt_.text = ""

		SetActive(arg_18_0.kuoGo_, false)
	else
		SetActive(arg_18_0.oriOriceTxt_.gameObject, true)

		arg_18_0.oriOriceTxt_.text = var_18_4

		SetActive(arg_18_0.dlcPrice_.gameObject, true)

		arg_18_0.allPriceTxt_.text = string.format("( %d", var_18_0)
		arg_18_0.dlcPrice_.text = "+0"

		SetActive(arg_18_0.kuoGo_, true)
	end
end

function var_0_0.UpdateTitle(arg_19_0)
	if arg_19_0.showModel == var_0_1.ViewDlc then
		arg_19_0.textnameText_.text = ItemTools.getItemName(arg_19_0.itemDlcCfg.id)
		arg_19_0.textinfoText_.text = string.format(GetTips("BUY_SKIN_CHANGE"), ItemTools.getItemName(arg_19_0.itemDlcCfg.id)) .. ItemTools.getItemDesc(arg_19_0.itemDlcCfg.id)
	else
		arg_19_0.textnameText_.text = ItemTools.getItemName(arg_19_0.shopCfg.description)
		arg_19_0.textinfoText_.text = string.format(GetTips("BUY_SKIN_CHANGE"), ItemTools.getItemName(arg_19_0.shopCfg.description)) .. ItemTools.getItemDesc(arg_19_0.descID)
	end
end

function var_0_0.UpdateView(arg_20_0)
	arg_20_0:UpdatePrice()
	arg_20_0:UpdateTitle()
	SetActive(arg_20_0.dlcItemLimit_, false)
	SetActive(arg_20_0.freeGiveGo_, true)
	SetActive(arg_20_0.freeForeverGo_, false)
	arg_20_0.dlcselController:SetSelectedState(arg_20_0.showModel == var_0_1.ViewDlc and "true" or "false")
	SetActive(arg_20_0.giveBackGo_, #arg_20_0.shopCfg.give_back_list ~= 0)

	if nullable(arg_20_0.shopCfg.give_back_list, 2) then
		local var_20_0 = rewardToItemTemplate(formatReward(arg_20_0.shopCfg.give_back_list[2]), nil, true)

		arg_20_0.giveBackItem2:SetData(var_20_0)
		SetActive(arg_20_0.giveBackItem2.gameObject_, true)
	else
		SetActive(arg_20_0.giveBackItem2.gameObject_, false)
	end

	SetActive(arg_20_0.skinRemainGo_, false)

	arg_20_0.skinImg_.sprite = getSpriteViaConfig("HeroIcon", arg_20_0.skinCfg.picture_id)

	arg_20_0.skinImg_:SetNativeSize()
	arg_20_0.dlcIconController:SetSelectedState(arg_20_0.shopDlcCfg and "true" or "false")

	if arg_20_0.dlcID and ShopTools.CheckDlcCanBuy(arg_20_0.dlcID) and ShopTools.CheckDlcPurchased(arg_20_0.dlcID) == false and arg_20_0.shopDlcCfg.shop_id == arg_20_0.shopID then
		if arg_20_0.showModel == var_0_1.ViewDlc then
			arg_20_0.dlcbtnController:SetSelectedState("gift2")
		else
			arg_20_0.dlcbtnController:SetSelectedState("gift1")
		end

		arg_20_0.dlcIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. arg_20_0.skinCfg.id .. "_character")
		arg_20_0.dlcLittleIcon_.sprite = ItemTools.getItemSprite(arg_20_0.itemDlcCfg.id)
		arg_20_0.dlcBgImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/BackgroundQuad/" .. HomeSceneSettingCfg[arg_20_0.itemDlcCfg.id].prefix)
		arg_20_0.dlcbuyTxt_.text = string.format(GetTips("BUY_SKIN_DLC_TIPS"), ItemTools.getItemName(arg_20_0.itemDlcCfg.id))
		arg_20_0.dlcItemNameTxt_.text = string.format(ItemTools.getItemName(arg_20_0.itemDlcCfg.id))
	end

	arg_20_0:UpdateTimeView()
end

function var_0_0.UpdateTimer(arg_21_0)
	arg_21_0:UpdateTimeView()

	if arg_21_0.timer_ == nil then
		arg_21_0.timer_ = Timer.New(function()
			arg_21_0:UpdateTimeView()
		end, 1, -1, -1)

		arg_21_0.timer_:Start()
	end
end

function var_0_0.UpdateTimeView(arg_23_0)
	if arg_23_0.shopDlcCfg then
		local var_23_0, var_23_1, var_23_2 = ShopTools.IsOnDiscountArea(arg_23_0.dlcID)

		if var_23_0 and var_23_2 then
			SetActive(arg_23_0.dlcItemLimit_, arg_23_0.shopDlcCfg.is_limit_time_discount == 1)

			arg_23_0.dlcItemLimitTxt_.text = manager.time:GetLostTimeStr(TimeMgr.GetInstance():parseTimeFromConfig(arg_23_0.shopDlcCfg.cheap_close_time))
		else
			SetActive(arg_23_0.dlcItemLimit_, false)
		end
	end

	arg_23_0.freeRemainTxt_.text = manager.time:GetLostTimeStr(TimeMgr.GetInstance():parseTimeFromConfig(arg_23_0.shopDlcCfg.cheap_close_time))

	local var_23_3 = arg_23_0.shopCfg.close_time
	local var_23_4 = arg_23_0.shopCfg

	SetActive(arg_23_0.timeGo_, #var_23_3 > 0)

	if #var_23_3 <= 0 then
		arg_23_0.discountController:SetSelectedState("none")
	end

	if #var_23_3 > 0 then
		local var_23_5 = TimeMgr.GetInstance():GetServerTime()
		local var_23_6 = TimeMgr.GetInstance():parseTimeFromConfig(var_23_3)

		if var_23_6 <= var_23_5 then
			arg_23_0.remainTxt_.text = GetTips("TIP_EXPIRED")
		else
			arg_23_0.remainTxt_.text = string.format("%s", manager.time:GetLostTimeStr(var_23_6))
		end
	end

	if #var_23_4.cheap_close_time > 0 then
		local var_23_7, var_23_8, var_23_9 = ShopTools.IsOnDiscountArea(var_23_4.goods_id)

		if var_23_7 and var_23_9 then
			arg_23_0.discountController:SetSelectedState("none")
			SetActive(arg_23_0.skinRemainGo_, var_23_4.is_limit_time_discount == 1)

			arg_23_0.skinRemianTxt_.text = manager.time:GetLostTimeStr(TimeMgr.GetInstance():parseTimeFromConfig(var_23_4.cheap_close_time))
		else
			arg_23_0.discountController:SetSelectedState("none")
			SetActive(arg_23_0.skinRemainGo_, false)
		end
	end

	arg_23_0:UpdatePrice()
end

function var_0_0.OnEnter(arg_24_0)
	arg_24_0.goodID = arg_24_0.params_.goodID
	arg_24_0.heroID = arg_24_0.params_.heroID
	arg_24_0.skinID = arg_24_0.params_.skinID

	arg_24_0:UpdateData()
	arg_24_0:UpdateView()
	arg_24_0:UpdateTimer()
	arg_24_0:RegistEventListener(RECHARGE_SUCCESS, function(arg_25_0)
		local var_25_0 = HeroTools.GetSkinChangeItem(arg_24_0.skinID)

		arg_24_0:Back()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("USE_SKIN_CHANGE"), ItemTools.getItemName(var_25_0)),
			OkCallback = function()
				CommonAction.TryToUseItem({
					{
						item_info = {
							num = 1,
							id = var_25_0
						},
						use_list = {}
					}
				})
			end
		})
	end)
end

function var_0_0.OnExit(arg_27_0)
	if arg_27_0.timer_ ~= nil then
		arg_27_0.timer_:Stop()

		arg_27_0.timer_ = nil
	end

	manager.windowBar:HideBar()
	arg_27_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_28_0)
	arg_28_0.giveBackItem2:Dispose()
	var_0_0.super.Dispose(arg_28_0)
end

return var_0_0
