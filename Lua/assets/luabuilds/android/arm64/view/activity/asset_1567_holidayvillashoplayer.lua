local HolidayVillaShopLayer = class("HolidayVillaShopLayer", import(".SixthAnniversaryIslandShopLayer"))

function HolidayVillaShopLayer:getUIName()
	return "HolidayVillaShopUI"
end

function HolidayVillaShopLayer:setPlayer(arg_2_1)
	self.player = arg_2_1

	setText(self.rtRes:Find("Text"), getProxy(ActivityProxy):getActivityById(ActivityConst.HOLIDAY_ACT_ID):getVitemNumber(66005))

	return
end

function HolidayVillaShopLayer:refreshAllGoodsCard()
	self.goodsList = self.shop:getSortGoods()

	self.goodsItemList:align(#self.goodsList)

	return
end

function HolidayVillaShopLayer:init()
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
				self:emit(HolidayVillaShopMediator.OPEN_GOODS_WINDOW, self.goodsList[arg_5_1])

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

return HolidayVillaShopLayer
