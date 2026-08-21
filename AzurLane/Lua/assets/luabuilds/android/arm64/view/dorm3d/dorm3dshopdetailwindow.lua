local var_0_0 = class("Dorm3dShopDetailWindow", import("view.base.BaseUI"))

var_0_0.SELECTED_WIDTH = 52
var_0_0.UNSELECTED_WIDTH = 12
var_0_0.LOOP_DURATION = 5

function var_0_0.getUIName(arg_1_0)
	return "Dorm3dShopDetailWindow"
end

function var_0_0.init(arg_2_0)
	arg_2_0.previewTf = arg_2_0._tf:Find("Window/Preview")
	arg_2_0.bubbleContent = arg_2_0._tf:Find("Window/Bubbles/content")
	arg_2_0.bubbleTpl = arg_2_0._tf:Find("Window/Bubbles/tpl")
	arg_2_0.bubbleList = UIItemList.New(arg_2_0.bubbleContent, arg_2_0.bubbleTpl)
	arg_2_0.scrollSnap = BannerScrollRect4Dorm.New(arg_2_0._tf:Find("Window/banner/mask/content"), arg_2_0._tf:Find("Window/banner/dots"))

	setActive(arg_2_0.bubbleTpl, false)

	arg_2_0.minusBtn = arg_2_0._tf:Find("Window/countList/minusBtn")
	arg_2_0.addBtn = arg_2_0._tf:Find("Window/countList/addBtn")
	arg_2_0.maxBtn = arg_2_0._tf:Find("Window/countList/maxBtn")
	arg_2_0.countText = arg_2_0._tf:Find("Window/countList/count/Text")
	arg_2_0.shopCfg = arg_2_0.contextData.shopCfg
	arg_2_0.unlockTips = pg.dorm3d_gift[arg_2_0.shopCfg.item_id].unlock_tips or {}

	local var_2_0 = arg_2_0.shopCfg.room_id

	arg_2_0.unlockBanners = arg_2_0.shopCfg.banners

	if arg_2_0.contextData.groupId ~= 0 then
		var_2_0 = arg_2_0.contextData.groupId

		local var_2_1 = pg.dorm3d_gift[arg_2_0.shopCfg.item_id].unlock_banners or {}
		local var_2_2 = table.Find(var_2_1, function(arg_3_0, arg_3_1)
			if arg_3_1[1] == var_2_0 then
				return true
			end

			return
		end)

		arg_2_0.unlockBanners = var_2_2 and var_2_2[2]
	end

	arg_2_0.isExclusive = pg.dorm3d_gift[arg_2_0.shopCfg.item_id].ship_group_id ~= 0
	arg_2_0.isSpecial = false
	arg_2_0.addFavor = pg.dorm3d_favor_trigger[pg.dorm3d_gift[arg_2_0.shopCfg.item_id].favor_trigger_id].num

	setActive(arg_2_0._tf:Find("Window/Title/gift"), true)

	arg_2_0.curCount = 1
	arg_2_0.buyCount = getProxy(ApartmentProxy):GetGiftShopCount(arg_2_0.shopCfg.item_id)

	return
end

function var_0_0.didEnter(arg_4_0)
	onButton(arg_4_0, arg_4_0._tf:Find("Window/Cancel"), function()
		arg_4_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_4_0, arg_4_0._tf:Find("Mask"), function()
		arg_4_0:closeView()

		return
	end)
	arg_4_0:InitUIList()
	arg_4_0:InitDropIcon()
	arg_4_0:InitBanner()

	local var_4_0 = Dorm3dGift.New({
		configId = arg_4_0.shopCfg.item_id
	})
	local var_4_1 = CommonCommodity.New({
		id = var_4_0:GetShopID()
	}, Goods.TYPE_SHOPSTREET)
	local var_4_2, var_4_3, var_4_4 = var_4_1:GetPrice()
	local var_4_5 = Drop.New({
		type = DROP_TYPE_RESOURCE,
		id = var_4_1:GetResType(),
		count = var_4_2
	})
	local var_4_6 = i18n("dorm3d_shop_buy_tips", "<icon name=" .. var_4_1:GetResIcon() .. " w=1.1 h=1.1/>", "x" .. var_4_5.count, "x" .. var_4_5.count, arg_4_0.shopCfg.name)
	local var_4_7
	local var_4_8 = 0

	_.each(var_4_0:getConfig("shop_id"), function(arg_7_0)
		if pg.shop_template[arg_7_0].group_type == 2 then
			var_4_8 = math.max(pg.shop_template[arg_7_0].group_limit, var_4_8)
		end

		return
	end)

	if 0 > 0 then
		var_4_7 = {
			arg_4_0.buyCount,
			0
		}
	end

	if var_4_7 then
		var_4_6 = var_4_6 .. i18n("dorm3d_purchase_weekly_limit", var_4_7[1], var_4_7[2])
	end

	setText(arg_4_0._tf:Find("Window/Content"), var_4_6)
	setText(arg_4_0._tf:Find("Window/Confirm/Text"), i18n("msgbox_text_confirm"))
	setText(arg_4_0._tf:Find("Window/Cancel/Text"), i18n("msgbox_text_cancel"))
	pg.UIMgr.GetInstance():OverlayPanel(arg_4_0._tf)

	local var_4_9 = var_4_0:GetShopID()

	arg_4_0.itemList = {
		var_4_9
	}
	arg_4_0.sumPrice = arg_4_0:GetGoodPrice(var_4_9)

	setText(arg_4_0.countText, arg_4_0.curCount)

	local var_4_10 = 1

	if var_4_7 then
		var_4_10 = var_4_7[2] - var_4_7[1]
	end

	local function var_4_11(arg_8_0)
		arg_8_0 = math.max(arg_8_0, 1)
		arg_8_0 = math.min(arg_8_0, var_4_10)
		arg_4_0.curCount = arg_8_0

		setText(arg_4_0.countText, arg_8_0)

		arg_4_0.sumPrice = 0

		for iter_8_0 = arg_4_0.buyCount, arg_4_0.buyCount + arg_4_0.curCount - 1 do
			arg_4_0.sumPrice = arg_4_0.sumPrice + arg_4_0:GetGoodPrice(arg_4_0:GetShopId(iter_8_0))
		end

		local var_8_0 = i18n("dorm3d_shop_buy_tips", "<icon name=" .. var_4_1:GetResIcon() .. " w=1.1 h=1.1/>", "x" .. arg_4_0:GetGoodPrice((arg_4_0:GetShopId(arg_4_0.buyCount + arg_4_0.curCount - 1))), "x" .. arg_4_0.sumPrice, arg_4_0.shopCfg.name)

		if var_4_7 then
			var_8_0 = var_8_0 .. i18n("dorm3d_purchase_weekly_limit", var_4_7[1], var_4_7[2])
		end

		setText(arg_4_0._tf:Find("Window/Content"), var_8_0)
		arg_4_0.contextData.changeCount(arg_8_0)

		return
	end

	onButton(arg_4_0, arg_4_0.minusBtn, function()
		if arg_4_0.curCount - 1 > 0 then
			table.remove(arg_4_0.itemList, #arg_4_0.itemList)
		end

		var_4_11(arg_4_0.curCount - 1)

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.addBtn, function()
		if arg_4_0.buyCount + arg_4_0.curCount + 1 <= var_4_8 then
			table.insert(arg_4_0.itemList, arg_4_0:GetShopId(arg_4_0.buyCount + arg_4_0.curCount))
		end

		var_4_11(arg_4_0.curCount + 1)

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.maxBtn, function()
		arg_4_0.itemList = {}

		for iter_11_0 = arg_4_0.buyCount, var_4_8 - 1 do
			table.insert(arg_4_0.itemList, arg_4_0:GetShopId(iter_11_0))
		end

		var_4_11(var_4_10)

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0._tf:Find("Window/Confirm"), function()
		local var_12_0 = getProxy(PlayerProxy):getData()

		if var_12_0[id2res(pg.shop_template[arg_4_0.itemList[1]].resource_type)] < arg_4_0.sumPrice then
			if pg.shop_template[arg_4_0.itemList[1]].resource_type == 1 then
				GoShoppingMsgBox(i18n("switch_to_shop_tip_2", i18n("word_gold")), ChargeScene.TYPE_ITEM, {
					{
						59001,
						arg_4_0.sumPrice - var_12_0[id2res(pg.shop_template[arg_4_0.itemList[1]].resource_type)],
						arg_4_0.sumPrice
					}
				})
			elseif pg.shop_template[arg_4_0.itemList[1]].resource_type == 4 or pg.shop_template[arg_4_0.itemList[1]].resource_type == 14 then
				GoShoppingMsgBox(i18n("switch_to_shop_tip_3", i18n("word_gem")), ChargeScene.TYPE_DIAMOND)
			elseif not ItemTipPanel.ShowItemTip(DROP_TYPE_RESOURCE, pg.shop_template[arg_4_0.itemList[1]].resource_type) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("buyProp_noResource_error", (Drop.New({
					type = DROP_TYPE_RESOURCE,
					id = pg.shop_template[arg_4_0.itemList[1]].resource_type
				}):getName())))
			end

			arg_4_0:closeView()

			return
		end

		for iter_12_0, iter_12_1 in ipairs(arg_4_0.itemList) do
			arg_4_0:emit(Dorm3dShopDetailMediator.SHOPPING, {
				silentTip = true,
				count = 1,
				shopId = iter_12_1
			})
		end

		arg_4_0:closeView()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.InitBanner(arg_13_0)
	for iter_13_0 = 1, #arg_13_0.unlockBanners do
		LoadImageSpriteAsync("dorm3dbanner/" .. arg_13_0.unlockBanners[iter_13_0], (arg_13_0.scrollSnap:AddChild()))
	end

	arg_13_0.scrollSnap:SetUp()

	return
end

function var_0_0.InitUIList(arg_14_0)
	arg_14_0.bubbleList:make(function(arg_15_0, arg_15_1, arg_15_2)
		if arg_15_0 == UIItemList.EventInit then
			LoadImageSpriteAtlasAsync("ui/shoptip_atlas", "icon_" .. arg_14_0.unlockTips[arg_15_1 + 1], arg_15_2:Find("icon/icon"), true)
			setText(arg_15_2:Find("bubble/Text"), i18n("dorm3d_shop_tag" .. arg_14_0.unlockTips[arg_15_1 + 1]))
			setActive(arg_15_2:Find("bubble"), false)
			onToggle(arg_14_0, arg_15_2, function(arg_16_0)
				setActive(arg_15_2:Find("icon/select"), arg_16_0)
				setActive(arg_15_2:Find("icon/unselect"), not arg_16_0)
				setActive(arg_15_2:Find("bubble"), arg_16_0)

				return
			end)
		end

		return
	end)
	arg_14_0.bubbleList:align(#arg_14_0.unlockTips)

	return
end

function var_0_0.InitDropIcon(arg_17_0)
	({
		type = DROP_TYPE_DORM3D_GIFT,
		id = arg_17_0.shopCfg.item_id
	}).count = getProxy(ApartmentProxy):getGiftCount(arg_17_0.shopCfg.item_id)

	LoadImageSpriteAtlasAsync(Drop.New({
		type = DROP_TYPE_DORM3D_GIFT,
		id = arg_17_0.shopCfg.item_id
	}):getIcon(), "", arg_17_0._tf:Find("Window/Item/Dorm3dIconTpl/icon"), true)
	GetImageSpriteFromAtlasAsync("weaponframes", "dorm3d_" .. ItemRarity.Rarity2Print(arg_17_0.shopCfg.rarity), arg_17_0._tf:Find("Window/Item/Dorm3dIconTpl"))

	local var_17_0 = arg_17_0.isExclusive or arg_17_0.isSpecial

	setActive(arg_17_0._tf:Find("Window/Item/sp"), var_17_0)

	if arg_17_0.isSpecial then
		setText(arg_17_0._tf:Find("Window/Item/sp/Text"), i18n("dorm3d_purchase_label_special"))
	elseif arg_17_0.isExclusive then
		setText(arg_17_0._tf:Find("Window/Item/sp/Text"), i18n("dorm3d_purchase_confirm_tip"))
	end

	if arg_17_0.addFavor then
		setActive(arg_17_0._tf:Find("Window/Item/gift"), true)
		setText(arg_17_0._tf:Find("Window/Item/gift/Text"), "+" .. arg_17_0.addFavor)
	end

	return
end

function var_0_0.GetShopId(arg_18_0, arg_18_1)
	for iter_18_0 = 1, #arg_18_0.shopCfg.shop_id - 1 do
		if not pg.shop_template[arg_18_0.shopCfg.shop_id[iter_18_0]].limit_args[1] and pg.shop_template[arg_18_0.shopCfg.shop_id[iter_18_0]].group_type == 0 then
			return arg_18_0.shopCfg.shop_id[iter_18_0]
		elseif pg.shop_template[arg_18_0.shopCfg.shop_id[iter_18_0]].limit_args[1] and (pg.shop_template[arg_18_0.shopCfg.shop_id[iter_18_0]].limit_args[1][1] == "dailycount" or pg.shop_template[arg_18_0.shopCfg.shop_id[iter_18_0]].limit_args[1][1] == "count") then
			if arg_18_1 < pg.shop_template[arg_18_0.shopCfg.shop_id[iter_18_0]].limit_args[1][3] then
				return arg_18_0.shopCfg.shop_id[iter_18_0]
			end
		elseif pg.shop_template[arg_18_0.shopCfg.shop_id[iter_18_0]].group_type == 2 then
			if arg_18_1 < pg.shop_template[arg_18_0.shopCfg.shop_id[iter_18_0]].group_limit then
				return arg_18_0.shopCfg.shop_id[iter_18_0]
			end
		else
			return arg_18_0.shopCfg.shop_id[iter_18_0]
		end
	end

	return arg_18_0.shopCfg.shop_id[#arg_18_0.shopCfg.shop_id] or 0
end

function var_0_0.GetGoodPrice(arg_19_0, arg_19_1)
	return (CommonCommodity.New({
		id = arg_19_1
	}, Goods.TYPE_SHOPSTREET):GetPrice())
end

function var_0_0.willExit(arg_20_0)
	if arg_20_0.timerRefreshTime then
		arg_20_0.timerRefreshTime:Stop()

		arg_20_0.timerRefreshTime = nil
	end

	arg_20_0.scrollSnap:Dispose()

	arg_20_0.scrollSnap = nil

	pg.UIMgr.GetInstance():UnOverlayPanel(arg_20_0._tf)

	return
end

return var_0_0
