local var_0_0 = class("BlackFridayGiftPage", import("...base.BaseActivityPage"))

var_0_0.DAY_COLOR = {
	"110C08",
	"C8A471"
}

function var_0_0.OnInit(arg_1_0)
	arg_1_0.rtGift = arg_1_0._tf:Find("AD/gift")
	arg_1_0.rtFreeGift = arg_1_0._tf:Find("AD/gift_free")

	local var_1_0 = arg_1_0._tf:Find("AD/days")

	arg_1_0.uiList = UIItemList.New(var_1_0, var_1_0:Find("day"))

	arg_1_0.uiList:make(function(arg_2_0, arg_2_1, arg_2_2)
		arg_2_1 = arg_2_1 + 1

		if arg_2_0 == UIItemList.EventUpdate then
			setText(arg_2_2:Find("Text"), "DAY" .. arg_2_1)
			setTextColor(arg_2_2:Find("Text"), Color.NewHex(arg_1_0.DAY_COLOR[2]))
			setActive(arg_2_2:Find("lock"), arg_2_1 > arg_1_0.nday)
			setActive(arg_2_2:Find("tip"), arg_2_1 <= arg_1_0.nday and arg_1_0.freeGifts[arg_2_1]:canPurchase())
			onToggle(arg_1_0, arg_2_2, function(arg_3_0)
				if arg_3_0 then
					arg_1_0.index = arg_2_1

					arg_1_0:ShowGifts(arg_2_1)
				end

				setTextColor(arg_2_2:Find("Text"), Color.NewHex(arg_1_0.DAY_COLOR[arg_3_0 and 1 or 2]))

				return
			end, SFX_PANEL)
		end

		return
	end)

	return
end

function var_0_0.OnDataSetting(arg_4_0)
	if not arg_4_0.idLists then
		arg_4_0.idLists = arg_4_0.activity:getConfig("config_client").gifts

		assert(#arg_4_0.idLists[1] == #arg_4_0.idLists[2])
	end

	arg_4_0.nday = math.min(#arg_4_0.idLists[1], arg_4_0.activity:getNDay())

	local var_4_0 = getProxy(ShopsProxy)

	arg_4_0.gifts = underscore.map(arg_4_0.idLists[1], function(arg_5_0)
		return var_4_0:GetGiftCommodity(arg_5_0, Goods.TYPE_CHARGE)
	end)
	arg_4_0.freeGifts = underscore.map(arg_4_0.idLists[2], function(arg_6_0)
		return var_4_0:GetGiftCommodity(arg_6_0, Goods.TYPE_GIFT_PACKAGE)
	end)

	return
end

function var_0_0.OnUpdateFlush(arg_7_0)
	arg_7_0.uiList:align(#arg_7_0.idLists[1])

	if not arg_7_0.index then
		arg_7_0.index = arg_7_0.nday

		while arg_7_0.index > 0 and not arg_7_0.gifts[arg_7_0.index]:canPurchase() and not arg_7_0.freeGifts[arg_7_0.index]:canPurchase() do
			arg_7_0.index = arg_7_0.index - 1
		end

		arg_7_0.index = (arg_7_0.index - 1) % arg_7_0.nday + 1

		triggerToggle(arg_7_0.uiList.container:GetChild(arg_7_0.index - 1), true)
	else
		arg_7_0:ShowGifts(arg_7_0.index)
	end

	return
end

function var_0_0.ShowGifts(arg_8_0, arg_8_1)
	arg_8_0:UpdateCard(arg_8_0.rtGift, arg_8_0.gifts[arg_8_0.index])
	arg_8_0:UpdateCard(arg_8_0.rtFreeGift, arg_8_0.freeGifts[arg_8_0.index])

	return
end

local function var_0_1(arg_9_0)
	local var_9_0 = ({
		"hot",
		"new_tag",
		"tuijian",
		"shuangbei_tag",
		"activity",
		"xianshi"
	})[arg_9_0]

	if not ({
		"hot",
		"new_tag",
		"tuijian",
		"shuangbei_tag",
		"activity",
		"xianshi"
	})[arg_9_0] then
		var_9_0 = "hot"
	end

	return var_9_0
end

function var_0_0.UpdateCard(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0

	if arg_10_2:isChargeType() then
		local var_10_1 = {
			isFree = false,
			name = arg_10_2:getConfig("name_display"),
			price = arg_10_2:getConfig("money"),
			count = arg_10_2:GetLimitDesc(),
			desc = arg_10_2:getConfig("descrip"),
			free = i18n("shop_free_tag"),
			purchased = i18n("blackfriday_pack_purchased"),
			icon = "ChargeIcon/" .. arg_10_2:getConfig("picture")
		}

		var_10_1.items = underscore(arg_10_2:getConfig("display")):chain():first(3):map(function(arg_11_0)
			local var_11_0 = {}

			var_11_0.type, var_11_0.id, var_11_0.count = unpack(arg_11_0)

			return {}
		end):value()
		var_10_0 = var_10_1
	else
		local var_10_2 = Item.getConfigData(arg_10_2:getConfig("effect_args")[1])
		local var_10_3 = {
			isFree = true,
			name = var_10_2.name,
			price = arg_10_2:getConfig("resource_num"),
			count = arg_10_2:GetLimitDesc(),
			desc = var_10_2.display,
			free = i18n("shop_free_tag"),
			purchased = i18n("blackfriday_pack_purchased"),
			icon = var_10_2.icon
		}

		var_10_3.items = underscore(var_10_2.display_icon):chain():first(3):map(function(arg_12_0)
			local var_12_0 = {}

			var_12_0.type, var_12_0.id, var_12_0.count = unpack(arg_12_0)

			return {}
		end):value()
		var_10_0 = var_10_3
	end

	setText(arg_10_1:Find("name/Text"), var_10_0.name)

	local var_10_4 = var_10_0.isFree

	if not tonumber(var_10_0.price) then
		setText(arg_10_1:Find("price"), var_10_0.price)
	else
		setText(arg_10_1:Find("price"), GetMoneySymbol() .. var_10_0.price)
	end

	setText(arg_10_1:Find("count"), var_10_0.count)
	setText(arg_10_1:Find("desc"), var_10_0.desc)
	setText(arg_10_1:Find("free"), var_10_0.free)
	setText(arg_10_1:Find("purchased"), var_10_0.purchased)

	local var_10_5 = arg_10_2:inTime()

	setActive(arg_10_1:Find("mask_lock"), not var_10_5)

	local var_10_6 = arg_10_2:canPurchase()

	setActive(arg_10_1:Find("mask_purchased"), not var_10_6)
	setActive(arg_10_1:Find("purchased"), not var_10_6)
	setActive(arg_10_1:Find("free"), var_10_6 and var_10_4)
	setActive(arg_10_1:Find("price"), var_10_6 and not var_10_4)
	GetImageSpriteFromAtlasAsync(var_10_0.icon, "", arg_10_1:Find("icon/Image"), true)
	GetImageSpriteFromAtlasAsync("chargeTag", var_0_1(arg_10_2:getConfig("tag")), arg_10_1:Find("icon/tag"), true)
	UIItemList.StaticAlign(arg_10_1:Find("awards"), arg_10_1:Find("awards/award"), #var_10_0.items, function(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_0 == UIItemList.EventUpdate then
			updateDrop(arg_13_2, var_10_0.items[arg_13_1 + 1])
			onButton(arg_10_0, arg_13_2, function()
				arg_10_0:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)
		end

		return
	end)

	local var_10_7 = arg_10_1:Find("tip")

	if var_10_7 then
		setActive(var_10_7, var_10_5 and var_10_6)
	end

	local var_10_8 = pg.TimeMgr.GetInstance():STimeDescS(arg_10_2:getTimeStamp(), "%m.%d")

	onButton(arg_10_0, arg_10_1, function()
		if not var_10_5 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("blackfriday_pack_lock", var_10_8))
		elseif not arg_10_2:canPurchase() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("buy_countLimit"))
		else
			arg_10_0:OnCharge(arg_10_2)
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnCharge(arg_16_0, arg_16_1)
	if arg_16_1:isChargeType() then
		local var_16_0 = {
			isChargeType = true,
			commodity = arg_16_1,
			infoTip = arg_16_1:GetInfoTip(),
			icon = "chargeicon/" .. arg_16_1:getConfig("picture"),
			name = arg_16_1:getConfig("name_display"),
			tipExtra = i18n("charge_title_getitem"),
			extraItems = arg_16_1:GetExtraServiceItem(),
			price = arg_16_1:getConfig("money"),
			isLocalPrice = arg_16_1:IsLocalPrice(),
			tagType = arg_16_1:getConfig("tag"),
			isMonthCard = arg_16_1:isMonthCard()
		}

		var_16_0.tipBonus = nil
		var_16_0.bonusItem = nil
		var_16_0.extraDrop = nil
		var_16_0.descExtra = arg_16_1:getConfig("descrip_extra")
		var_16_0.limitArgs = arg_16_1:getConfig("limit_args")

		function var_16_0.onYes()
			if ChargeConst.isNeedSetBirth() then
				arg_16_0:emit(ActivityMediator.OPEN_CHARGE_BIRTHDAY)
			else
				arg_16_0:emit(ActivityMediator.CHARGE, arg_16_1.id)
			end

			return
		end

		arg_16_0:emit(ActivityMediator.OPEN_CHARGE_ITEM_PANEL, var_16_0)
	else
		local var_16_1 = {}
		local var_16_2 = Item.getConfigData(arg_16_1:getConfig("effect_args")[1])

		if type(var_16_2.display_icon) == "table" then
			for iter_16_0, iter_16_1 in ipairs(var_16_2.display_icon) do
				table.insert(var_16_1, {
					type = iter_16_1[1],
					id = iter_16_1[2],
					count = iter_16_1[3]
				})
			end
		end

		arg_16_0:emit(ActivityMediator.OPEN_CHARGE_ITEM_PANEL, {
			isLocalPrice = false,
			isChargeType = false,
			isMonthCard = false,
			commodity = arg_16_1,
			icon = var_16_2.icon,
			name = var_16_2.name,
			tipExtra = i18n("charge_title_getitem"),
			extraItems = var_16_1,
			price = arg_16_1:getConfig("resource_num"),
			tagType = arg_16_1:getConfig("tag"),
			onYes = function()
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("charge_scene_buy_confirm", arg_16_1:getConfig("resource_num"), var_16_2.name),
					onYes = function()
						arg_16_0:emit(ActivityMediator.BUY_ITEM, arg_16_1.id, 1)

						return
					end
				})

				return
			end
		})
	end

	return
end

function var_0_0.OnDestroy(arg_20_0)
	return
end

return var_0_0
