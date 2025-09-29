-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/trading/view/TradingGoodsItem.lua

module("logic.extensions.trading.view.TradingGoodsItem", package.seeall)

local M = class("TradingGoodsItem")

M.Color_Up = "#FF0000"
M.Color_Down = "#26FF00"

function M:ctor(compContainer)
	self._go = compContainer.gameObject

	self:init()
end

function M:init()
	local go = self._go

	self._imgIcon = goutil.findChildImageComponent(go, "cell/backpack_item/imgIcon")
	self._imgQuality = goutil.findChildImageComponent(go, "cell/backpack_item/imgQuality")
	self._imgTypeIcon = goutil.findChildImageComponent(go, "price/imgIcon")
	self._txtName = goutil.findChildTextComponent(go, "txtName")
	self._txtPrice = goutil.findChildTextComponent(go, "price/txtValue")
	self._txtCount = goutil.findChildTextComponent(go, "txtHave")
	self._btnClick = UIComponentType.ButtonAdapter(goutil.findChild(go, "click"))
	self._goType1 = goutil.findChild(go, "priceChanges/type1")
	self._goType2 = goutil.findChild(go, "priceChanges/type2")
	self._goType3 = goutil.findChild(go, "priceChanges/type3")
	self._goType4 = goutil.findChild(go, "priceChanges/type4")
	self._goTypes = {
		self._goType3,
		self._goType4,
		self._goType1,
		self._goType2
	}
	self._txtPriceChanges = goutil.findChildTextComponent(go, "txtPriceChanges")
	self._lineChartWrap = LineChartWraper.Get(goutil.findChild(go, "LineChart"))

	self:bindEvents()
end

function M:bindEvents()
	self._btnClick:AddClickListener(self.onClick, self)
end

function M:unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:updateData(data)
	local co = data.co

	self._id = data.id
	self._priceUpType = data.priceUpType
	self._txtName.text = data.name
	self._txtPrice.text = data.price
	self._txtCount.text = string.format(lang("tip_trading_lang_14"), data.count)

	IconLoader.setSprite(self._imgIcon, IconType.ItemIcon, data.icon)
	MoneyUtil.setMoneyIcon(self._imgTypeIcon, CommEnum.CurrencyCodeEnum.LzbCode)
	IconLoader.setSprite(self._imgQuality, IconType.Skinlib, CommEnum.Quality2ItemBg[data.quality])

	self._mo = data.mo

	for k, v in pairs(self._goTypes) do
		goutil.setActive(v, k == data.priceUpType)
	end

	local percent = MathUtil.preciseDecimal(data.upPercent * 100, 1)
	local percentStr = "%s%%"

	if percent > 0 then
		percentStr = "<color=#F77F80>+%s%%</color>"
	elseif percent < 0 then
		percentStr = "<color=#aae8bd>%s%%</color>"
	end

	self._txtPriceChanges.text = string.format(percentStr, percent)
	self._percentNum = percent

	goutil.setActive(self._go, true)
	self:updateLineChart()
end

function M:updateLineChart()
	local recentPrices = self._mo.recentPrices

	if #recentPrices < 28 then
		printError(string.format("商品[%s]价格曲线长度 %s < 28", self._mo.itemId, #recentPrices))
	end

	local nowTS = ServerTime.now()
	local nowWday = TimeUtil.instance:getNowWeekDay(nowTS)
	local nowHour = tonumber(os.date("%H", nowTS))
	local nowPoint = nowWday * 2

	if nowHour < 5 then
		nowPoint = nowPoint - 2
	elseif nowHour < 17 then
		nowPoint = nowPoint - 1
	end

	nowPoint = nowPoint + 14

	local priceMonday = recentPrices[15]
	local tempRecentDate = {}
	local tempRecentPricePercent = {}
	local tempPriceLine = {}

	for i = 1, 28 do
		table.insert(tempRecentDate, i)

		local pricePercent = (recentPrices[i] - priceMonday) / priceMonday * 100

		pricePercent = math.ceil(pricePercent * 10) / 10

		table.insert(tempRecentPricePercent, pricePercent)
		table.insert(tempPriceLine, 0)
	end

	local priceTyp = TradingCentreView.PRICE_UP_TYPE
	local _color = (self._priceUpType == priceTyp.DOWN or self._priceUpType == priceTyp.DOWN_DOWN) and M.Color_Down or M.Color_Up

	self._lineChartWrap:AddData(tempRecentDate, tempRecentPricePercent)
	self._lineChartWrap:SetLineColor(0, _color, 0.462)
	self._lineChartWrap:SetMinMaxShow(0, 0, nowPoint)
	self._lineChartWrap:SetAreaColor(0, _color .. "FF", _color .. "00", 1)

	local serieId = self._lineChartWrap:ChangeSerieAndData(1, tempPriceLine, 0, 6)

	self._lineChartWrap:ShowSymbol(serieId, false)
	self._lineChartWrap:SetLineColor(serieId, "#ffffff", 0.3)
end

function M:onClick()
	local luaTable = {}

	luaTable.goodsMO = self._mo
	luaTable.priceUpType = self._priceUpType
	luaTable.percentNum = self._percentNum

	ViewMgr.instance:open(ViewName.TradingProductDetail, luaTable)
end

function M:OnDestroy()
	self:unbindEvents()
end

return M
