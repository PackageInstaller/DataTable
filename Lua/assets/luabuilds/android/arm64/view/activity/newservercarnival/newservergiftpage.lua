local var_0_0 = class("NewServerGiftPage", import("...base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "NewServerGiftPage"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0:initData()
	arg_2_0:initUI()

	return
end

function var_0_0.initData(arg_3_0)
	arg_3_0.player = getProxy(PlayerProxy):getData()
	arg_3_0.activity = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_NEWSERVER_GIFT)
	arg_3_0.goodIdList = arg_3_0.activity:getConfig("config_data")

	arg_3_0:updateGiftGoodsVOList()

	return
end

function var_0_0.initUI(arg_4_0)
	arg_4_0.content = arg_4_0._tf:Find("scrollrect/content")
	arg_4_0.soldOutTF = arg_4_0._tf:Find("sold_out")

	setText(arg_4_0.soldOutTF:Find("Text"), i18n("newserver_soldout"))
	setActive(arg_4_0.soldOutTF, #arg_4_0.giftGoodsVOList == 0)

	arg_4_0.giftItemList = UIItemList.New(arg_4_0.content, arg_4_0._tf:Find("gift_tpl"))
	arg_4_0.chargeCardTable = {}

	arg_4_0.giftItemList:make(function(arg_5_0, arg_5_1, arg_5_2)
		arg_5_1 = arg_5_1 + 1

		if arg_5_0 == UIItemList.EventInit then
			arg_4_0:initGift(go(arg_5_2))
		elseif arg_5_0 == UIItemList.EventUpdate then
			arg_4_0:updateGift(go(arg_5_2), arg_5_1)
		end

		return
	end)
	arg_4_0.giftItemList:align(#arg_4_0.giftGoodsVOList)

	return
end

function var_0_0.initGift(arg_6_0, arg_6_1)
	local var_6_0 = OldChargeCard.New(arg_6_1)

	onButton(arg_6_0, var_6_0.tr, function()
		arg_6_0:confirm(var_6_0.goods)

		return
	end, SFX_PANEL)

	arg_6_0.chargeCardTable[arg_6_1] = var_6_0

	return
end

function var_0_0.updateGift(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.chargeCardTable[arg_8_1]

	if not arg_8_0.chargeCardTable[arg_8_1] then
		arg_8_0.initGift(arg_8_1)

		var_8_0 = arg_8_0.chargeCardTable[arg_8_1]
	end

	local var_8_1 = arg_8_0.giftGoodsVOList[arg_8_2]

	if arg_8_0.giftGoodsVOList[arg_8_2] then
		var_8_0:update(var_8_1, arg_8_0.player, arg_8_0.firstChargeIds)
	end

	return
end

function var_0_0.confirm(arg_9_0, arg_9_1)
	if not arg_9_1 then
		return
	end

	arg_9_1 = Clone(arg_9_1)

	local var_9_0 = Item.getConfigData(arg_9_1:getConfig("effect_args")[1])

	if type(var_9_0.display_icon) == "table" then
		for iter_9_0, iter_9_1 in ipairs(var_9_0.display_icon) do
			table.insert({}, Drop.Create(iter_9_1))
		end
	end

	arg_9_0:emit(NewServerCarnivalMediator.GIFT_OPEN_ITEM_PANEL, {
		isLocalPrice = false,
		isChargeType = false,
		isMonthCard = false,
		commodity = arg_9_1,
		icon = var_9_0.icon,
		name = var_9_0.name,
		tipExtra = i18n("charge_title_getitem"),
		extraItems = {},
		price = arg_9_1:getConfig("resource_num"),
		tagType = arg_9_1:getConfig("tag"),
		onYes = function()
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("charge_scene_buy_confirm", arg_9_1:getConfig("resource_num"), var_9_0.name),
				onYes = function()
					arg_9_0:emit(NewServerCarnivalMediator.GIFT_BUY_ITEM, arg_9_1.id, 1)

					return
				end
			})

			return
		end
	})

	return
end

function var_0_0.onUpdatePlayer(arg_12_0, arg_12_1)
	arg_12_0.player = arg_12_1

	return
end

function var_0_0.onUpdateGift(arg_13_0)
	arg_13_0:updateGiftGoodsVOList()
	arg_13_0.giftItemList:align(#arg_13_0.giftGoodsVOList)
	setActive(arg_13_0.soldOutTF, #arg_13_0.giftGoodsVOList == 0)

	return
end

function var_0_0.updateGiftGoodsVOList(arg_14_0)
	arg_14_0.normalList = getProxy(ShopsProxy):GetNormalList()
	arg_14_0.giftGoodsVOList = {}

	for iter_14_0, iter_14_1 in pairs(arg_14_0.goodIdList) do
		table.insert(arg_14_0.giftGoodsVOList, (Goods.Create({
			shop_id = iter_14_1
		}, Goods.TYPE_NEW_SERVER)))
	end

	for iter_14_2, iter_14_3 in ipairs(arg_14_0.giftGoodsVOList) do
		iter_14_3:updateBuyCount((ChargeConst.getBuyCount(arg_14_0.normalList, iter_14_3.id)))

		if iter_14_3:canPurchase() then
			table.insert({}, iter_14_3)
		end
	end

	arg_14_0.giftGoodsVOList = {}

	return
end

function var_0_0.isTip(arg_15_0)
	arg_15_0.playerId = arg_15_0.playerId or getProxy(PlayerProxy):getData().id

	return PlayerPrefs.GetInt("newserver_gift_first_" .. arg_15_0.playerId) == 0
end

function var_0_0.OnDestroy(arg_16_0)
	return
end

return var_0_0
