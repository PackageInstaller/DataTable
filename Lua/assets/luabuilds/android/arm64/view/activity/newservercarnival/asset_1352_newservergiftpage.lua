local NewServerGiftPage = class("NewServerGiftPage", import("...base.BaseSubView"))

function NewServerGiftPage:getUIName()
	return "NewServerGiftPage"
end

function NewServerGiftPage:OnInit()
	self:initData()
	self:initUI()

	return
end

function NewServerGiftPage:initData()
	self.player = getProxy(PlayerProxy):getData()
	self.activity = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_NEWSERVER_GIFT)
	self.goodIdList = self.activity:getConfig("config_data")

	self:updateGiftGoodsVOList()

	return
end

function NewServerGiftPage:initUI()
	self.content = self._tf:Find("scrollrect/content")
	self.soldOutTF = self._tf:Find("sold_out")

	setText(self.soldOutTF:Find("Text"), i18n("newserver_soldout"))
	setActive(self.soldOutTF, #self.giftGoodsVOList == 0)

	self.giftItemList = UIItemList.New(self.content, self._tf:Find("gift_tpl"))
	self.chargeCardTable = {}

	self.giftItemList:make(function(arg_5_0, arg_5_1, arg_5_2)
		arg_5_1 = arg_5_1 + 1

		if arg_5_0 == UIItemList.EventInit then
			self:initGift(go(arg_5_2))
		elseif arg_5_0 == UIItemList.EventUpdate then
			self:updateGift(go(arg_5_2), arg_5_1)
		end

		return
	end)
	self.giftItemList:align(#self.giftGoodsVOList)

	return
end

function NewServerGiftPage:initGift(arg_6_1)
	local var_6_0 = OldChargeCard.New(arg_6_1)

	onButton(self, var_6_0.tr, function()
		self:confirm(var_6_0.goods)

		return
	end, SFX_PANEL)

	self.chargeCardTable[arg_6_1] = var_6_0

	return
end

function NewServerGiftPage:updateGift(arg_8_1, arg_8_2)
	local var_8_0 = self.chargeCardTable[arg_8_1]

	if not self.chargeCardTable[arg_8_1] then
		self.initGift(arg_8_1)

		var_8_0 = self.chargeCardTable[arg_8_1]
	end

	if self.giftGoodsVOList[arg_8_2] then
		var_8_0:update(self.giftGoodsVOList[arg_8_2], self.player, self.firstChargeIds)
	end

	return
end

function NewServerGiftPage:confirm(arg_9_1)
	if not arg_9_1 then
		return
	end

	arg_9_1 = Clone(arg_9_1)

	local var_9_0 = {}
	local var_9_1 = Item.getConfigData(arg_9_1:getConfig("effect_args")[1])

	if type(var_9_1.display_icon) == "table" then
		for iter_9_0, iter_9_1 in ipairs(var_9_1.display_icon) do
			table.insert(var_9_0, Drop.Create(iter_9_1))
		end
	end

	self:emit(NewServerCarnivalMediator.GIFT_OPEN_ITEM_PANEL, {
		isLocalPrice = false,
		isChargeType = false,
		isMonthCard = false,
		commodity = arg_9_1,
		icon = var_9_1.icon,
		name = var_9_1.name,
		tipExtra = i18n("charge_title_getitem"),
		extraItems = var_9_0,
		price = arg_9_1:getConfig("resource_num"),
		tagType = arg_9_1:getConfig("tag"),
		onYes = function()
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("charge_scene_buy_confirm", arg_9_1:getConfig("resource_num"), var_9_1.name),
				onYes = function()
					self:emit(NewServerCarnivalMediator.GIFT_BUY_ITEM, arg_9_1.id, 1)

					return
				end
			})

			return
		end
	})

	return
end

function NewServerGiftPage:onUpdatePlayer(arg_12_1)
	self.player = arg_12_1

	return
end

function NewServerGiftPage:onUpdateGift()
	self:updateGiftGoodsVOList()
	self.giftItemList:align(#self.giftGoodsVOList)
	setActive(self.soldOutTF, #self.giftGoodsVOList == 0)

	return
end

function NewServerGiftPage:updateGiftGoodsVOList()
	self.normalList = getProxy(ShopsProxy):GetNormalList()
	self.giftGoodsVOList = {}

	for iter_14_0, iter_14_1 in pairs(self.goodIdList) do
		table.insert(self.giftGoodsVOList, (Goods.Create({
			shop_id = iter_14_1
		}, Goods.TYPE_NEW_SERVER)))
	end

	local var_14_1 = {}

	for iter_14_2, iter_14_3 in ipairs(self.giftGoodsVOList) do
		iter_14_3:updateBuyCount((ChargeConst.getBuyCount(self.normalList, iter_14_3.id)))

		if iter_14_3:canPurchase() then
			table.insert(var_14_1, iter_14_3)
		end
	end

	self.giftGoodsVOList = var_14_1

	return
end

function NewServerGiftPage:isTip()
	self.playerId = self.playerId or getProxy(PlayerProxy):getData().id

	return PlayerPrefs.GetInt("newserver_gift_first_" .. self.playerId) == 0
end

function NewServerGiftPage:OnDestroy()
	return
end

return NewServerGiftPage
