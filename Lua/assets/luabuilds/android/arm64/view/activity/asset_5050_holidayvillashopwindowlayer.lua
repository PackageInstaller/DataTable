local HolidayVillaShopWindowLayer = class("HolidayVillaShopWindowLayer", import("..base.BaseUI"))

function HolidayVillaShopWindowLayer:getUIName()
	return "HolidayVillaGoodsWindow"
end

function HolidayVillaShopWindowLayer:setGoods(arg_2_1)
	self.goods = arg_2_1
	self.singleCost = arg_2_1:getConfig("resource_num")
	self.max = arg_2_1:GetPurchasableCnt()

	if arg_2_1:getConfig("num_limit") ~= 0 then
		self.max = math.min(self.max, math.max(arg_2_1:GetPurchasableCnt(), 0))
	end

	return
end

function HolidayVillaShopWindowLayer:init()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	local var_3_0 = self._tf:Find("content/calc")

	setText(var_3_0:Find("cost/Text_cost"), i18n("islandshop_tips3"))

	self.rtCost = var_3_0:Find("cost/number")
	self.rtCount = var_3_0:Find("dashboard/view/Text")

	onButton(self, var_3_0:Find("dashboard/minus_10"), function()
		self:updateCount(-10)

		return
	end, SFX_PANEL)
	onButton(self, var_3_0:Find("dashboard/plus_10"), function()
		self:updateCount(10)

		return
	end, SFX_PANEL)
	onButton(self, var_3_0:Find("dashboard/view/minus"), function()
		self:updateCount(-1)

		return
	end, SFX_PANEL)
	onButton(self, var_3_0:Find("dashboard/view/plus"), function()
		self:updateCount(1)

		return
	end, SFX_PANEL)
	onButton(self, var_3_0:Find("dashboard/plus_max"), function()
		self:updateCount(self.max - self.count)

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("bg"), function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("content/bottom/btn_cancel"), function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("content/bottom/btn_confirm"), function()
		if self.count > self.max then
			pg.TipsMgr.GetInstance():ShowTips(i18n("islandshop_tips4", Drop.New({
				type = self.goods:getConfig("resource_category"),
				id = self.goods:getConfig("resource_type")
			}):getName()))

			return
		end

		self:emit(HolidayVillaShopWindowMediator.SHOPPING_CONFIRM, self.count)

		return
	end, SFX_CANCEL)

	return
end

function HolidayVillaShopWindowLayer:updateCount(arg_12_1)
	self.count = math.clamp(self.count + arg_12_1, 1, math.max(self.max, 1))

	setText(self.rtCount, self.count)
	setText(self.rtCost, self.count * self.singleCost)

	return
end

function HolidayVillaShopWindowLayer:didEnter()
	local var_13_0 = {
		type = self.goods:getConfig("commodity_type"),
		id = self.goods:getConfig("commodity_id"),
		count = self.goods:getConfig("num")
	}
	local var_13_1 = self._tf:Find("content/main")

	updateDrop(var_13_1:Find("icon/IconTpl"), var_13_0)

	local var_13_2, var_13_3 = var_13_0:getOwnedCount()

	setActive(var_13_1:Find("owner"), var_13_3)

	if var_13_3 then
		setText(var_13_1:Find("owner"), i18n("word_own1") .. var_13_2)
	end

	setText(var_13_1:Find("line/name"), var_13_0:getConfig("name"))
	setText(var_13_1:Find("line/content/Text"), string.gsub(var_13_0.desc or var_13_0:getConfig("desc"), "<[^>]+>", ""))
	GetImageSpriteFromAtlasAsync(Drop.New({
		type = self.goods:getConfig("resource_category"),
		id = self.goods:getConfig("resource_type")
	}):getIcon(), "", self._tf:Find("content/calc/cost/icon"))

	self.count = 1

	self:updateCount(0)

	return
end

function HolidayVillaShopWindowLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return HolidayVillaShopWindowLayer
