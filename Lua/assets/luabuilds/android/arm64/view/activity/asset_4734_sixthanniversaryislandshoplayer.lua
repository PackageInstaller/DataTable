local SixthAnniversaryIslandShopLayer = class("SixthAnniversaryIslandShopLayer", import("..base.BaseUI"))

function SixthAnniversaryIslandShopLayer:getUIName()
	return "SixthAnniversaryIslandShopUI"
end

function SixthAnniversaryIslandShopLayer:setShop(arg_2_1)
	self.shop = arg_2_1
	self.goodsList = arg_2_1:getSortGoods()
	self.activity = getProxy(ActivityProxy):getActivityById(arg_2_1.activityId)

	return
end

function SixthAnniversaryIslandShopLayer:setPlayer(arg_3_1)
	self.player = arg_3_1

	setText(self.rtRes:Find("Text"), self.player:getResById(350) or 0)

	return
end

function SixthAnniversaryIslandShopLayer:init()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	local var_4_0 = self._tf:Find("main")

	setText(var_4_0:Find("time/Text"), i18n("islandshop_tips1"))

	self.rtTime = var_4_0:Find("time/Text_2")
	self.rtRes = var_4_0:Find("tpl")

	local var_4_1 = self._tf:Find("main/view/content")

	self.goodsItemList = UIItemList.New(var_4_1, var_4_1:Find("goods"))

	self.goodsItemList:make(function(arg_5_0, arg_5_1, arg_5_2)
		arg_5_1 = arg_5_1 + 1

		if arg_5_0 == UIItemList.EventUpdate then
			self.goodsCardDic[self.goodsList[arg_5_1].id] = arg_5_2

			onButton(self, arg_5_2, function()
				self:emit(SixthAnniversaryIslandShopMediator.OPEN_GOODS_WINDOW, self.goodsList[arg_5_1])

				return
			end, SFX_PANEL)
			self:updateGoodsCard(arg_5_2, self.goodsList[arg_5_1])
		end

		return
	end)
	onButton(self, self._tf:Find("bg"), function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("main/btn_back"), function()
		self:closeView()

		return
	end, SFX_CANCEL)

	return
end

function SixthAnniversaryIslandShopLayer:updateGoodsCard(arg_9_1, arg_9_2)
	local var_9_0 = arg_9_2:CheckCntLimit()

	setActive(arg_9_1:Find("mask"), not var_9_0)
	setGray(arg_9_1, var_9_0 and not arg_9_2:CheckArgLimit())

	local var_9_1 = arg_9_2:GetConsume()

	setActive(arg_9_1:Find("btn_unable"), var_9_1:getOwnedCount() < var_9_1.count)
	setButtonEnabled(arg_9_1, var_9_0)

	local var_9_2 = {
		type = arg_9_2:getConfig("commodity_type"),
		id = arg_9_2:getConfig("commodity_id"),
		count = arg_9_2:getConfig("num")
	}

	updateDrop(arg_9_1:Find("icon/IconTpl"), var_9_2)
	onNextTick(function()
		changeToScrollText(arg_9_1:Find("Text"), var_9_2:getConfig("name"))

		return
	end)
	GetImageSpriteFromAtlasAsync(Drop.New({
		type = arg_9_2:getConfig("resource_category"),
		id = arg_9_2:getConfig("resource_type")
	}):getIcon(), "", arg_9_1:Find("res_icon"))
	setText(arg_9_1:Find("btn_pay/cost"), arg_9_2:getConfig("resource_num"))
	setText(arg_9_1:Find("btn_unable/cost"), arg_9_2:getConfig("resource_num"))

	local var_9_3 = arg_9_2:getConfig("num_limit")

	if var_9_3 == 0 then
		setText(arg_9_1:Find("limit"), i18n("common_no_limit"))
	else
		setText(arg_9_1:Find("limit"), i18n("islandshop_tips2") .. math.max(arg_9_2:GetPurchasableCnt(), 0) .. "/" .. var_9_3)
	end

	return
end

function SixthAnniversaryIslandShopLayer:refreshGoodsCard(arg_11_1)
	self:updateGoodsCard(self.goodsCardDic[arg_11_1], self.shop:getGoodsById(arg_11_1))

	return
end

function SixthAnniversaryIslandShopLayer:didEnter()
	local var_12_0 = pg.TimeMgr.GetInstance()

	self.timer = Timer.New(function()
		if self.delta then
			self.delta = self.delta - 1 or self.activity.stopTime - var_12_0:GetServerTime()
		end

		local var_13_0 = string.format("%d" .. i18n("word_date") .. "%d" .. i18n("word_hour"), var_12_0:parseTimeFrom(self.delta))

		if self.strTime ~= var_13_0 then
			setText(self.rtTime, var_13_0)
		end

		return
	end, 1)

	self.timer.func()
	self.timer:Start()

	self.goodsCardDic = {}

	self.goodsItemList:align(#self.goodsList)

	return
end

function SixthAnniversaryIslandShopLayer:willExit()
	self.timer:Stop()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return SixthAnniversaryIslandShopLayer
