-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/trading/view/TradingProductDetailsView.lua

module("logic.extensions.trading.view.TradingProductDetailsView", package.seeall)

local M = class("TradingProductDetailsView", ViewComponent)

function M:buildUI()
	self._txtProductName = self:getText("trade_center_sold_tips_-2035733258")
	self._txtPrice = self:getText("trade_center_sold_tips_-1614244917")
	self._txtTotalCount = self:getText("trade_center_sold_tips_copy_-1129483234")
	self._txtTotalPrice = self:getText("trade_center_sold_tips_-460555465")
	self._imgProductPriceIcon = self:getImage("trade_center_sold_tips_-1316023963")
	self._imgConsumeIcon = self:getImage("trade_center_sold_tips_-1532812234")
	self._btnCancel = self:getBtn("trade_center_sold_tips_-1036067933")
	self._btnConfirm = self:getBtn("trade_center_sold_tips_-1879874642")
	self._btnClose = self:getBtn("2&middle_tips_common_bg_-1205189576")
	self._goLineChart = self:getGo("trade_center_sold_tips_copy_-1610111301")

	local autoInputGO = self:getGoByPath("allContent/right/autoInput")

	self._autoInputBeh = Astral.LuaComponentContainer.Add(autoInputGO, InputIntegerItem)

	self._autoInputBeh:setValueChangeSuccessListener(self._onNumChange, self)
	self._autoInputBeh:setValueChangeFailListener(self._onNumChangeFail, self)

	self._lineChartWrap = LineChartWraper.Get(self._goLineChart)

	local itemGO = self:getGoByPath("allContent/right/cell/backpack_item")

	self._item = Astral.LuaComponentContainer.Add(itemGO, ItemCell)
	self._goType1 = self:getGoByPath("allContent/right/priceChanges/type1")
	self._goType2 = self:getGoByPath("allContent/right/priceChanges/type2")
	self._goType3 = self:getGoByPath("allContent/right/priceChanges/type3")
	self._goType4 = self:getGoByPath("allContent/right/priceChanges/type4")
	self._goTypes = {
		self._goType3,
		self._goType4,
		self._goType1,
		self._goType2
	}
	self._goPriceUp = self:getGoByPath("allContent/right/unitprice/txtValue/changesDi1")
	self._goPriceDown = self:getGoByPath("allContent/right/unitprice/txtValue/changesDi2")
	self._txtPercent1 = goutil.findChildTextComponent(self._goPriceUp, "txtPriceChanges")
	self._txtPercent2 = goutil.findChildTextComponent(self._goPriceDown, "txtPriceChanges")
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnCancel:AddClickListener(self._onClickCancel, self)
	self._btnConfirm:AddClickListener(self._onClickConfirm, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._autoInputBeh:bindEvents()
end

function M:unbindEvents()
	self._btnCancel:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._autoInputBeh:unbindEvents()
end

function M:onEnter()
	local luaTable = self:getFirstParam()

	self._mo = luaTable.goodsMO
	self._priceUpType = luaTable.priceUpType
	self._percentNum = luaTable.percentNum

	self:_printStatus()
	self:refreshUseItem()
	self:refreshPrice()
	self:updateItemInfo()
end

function M:onExit()
	return
end

function M:onExitFinished()
	return
end

function M:_onClickCancel()
	self:close()
end

function M:updateItemInfo()
	local itemCO = BackpackConfig.instance:getItemInfoByItemId(self._mo.itemId)

	self._txtProductName.text = itemCO.name

	local itemData = ItemUtil.createItemData({
		itemId = self._mo.itemId
	})

	self._item:updateData(itemData)
	self._item:setShowSelectedEffect(false)
	self._item:getComponent("num"):setVisible(false)
end

function M:refreshUseItem()
	local curNum = ItemModel.instance:getItemCountByItemId(self._mo.itemId)
	local minNum = 1

	self._autoInputBeh:setInterval(minNum, curNum)
	self._autoInputBeh:setValue(minNum)

	self._txtTotalCount.text = curNum

	local price = self._mo.price

	self._txtTotalPrice.text = price * self._autoInputBeh:getValue()

	IconLoader.setSprite(self._imgProductPriceIcon, IconType.ItemIcon, 1100003)
	IconLoader.setSprite(self._imgConsumeIcon, IconType.ItemIcon, 1100003)

	for k, v in pairs(self._goTypes) do
		goutil.setActive(v, k == self._priceUpType)
	end

	goutil.setActive(self._goPriceUp, self._percentNum > 0)
	goutil.setActive(self._goPriceDown, self._percentNum < 0)

	self._txtPercent1.text = self._percentNum .. "%"
	self._txtPercent2.text = self._percentNum .. "%"
end

function M:refreshPrice()
	self._txtPrice.text = self._mo.price

	local timeStep = 43200
	local pointLen = 14
	local nowTS = ServerTime.now()
	local mondayTS = TimeUtil.instance:getWDayTimeStamp(nowTS, 1, 5)
	local nowHour = tonumber(os.date("%H", nowTS))

	if nowHour < 5 then
		nowTS = TimeUtil.instance:getTodaySpTimeStamp(0, -1, 17)
	elseif nowHour >= 17 then
		nowTS = TimeUtil.instance:getTodaySpTimeStamp(0, 0, 17)
	else
		nowTS = TimeUtil.instance:getTodaySpTimeStamp(0, 0, 5)
		pointLen = 13
	end

	local offsetPoint = (nowTS - mondayTS) / timeStep
	local dataIndex = 15 + offsetPoint - pointLen + 1
	local recentPrices = {}
	local index = dataIndex

	for i = 1, pointLen do
		table.insert(recentPrices, self._mo.recentPrices[index])

		index = index + 1
	end

	if Astral.OSDef.isEditor then
		printWarn(string.format("本周一[%s],当前规整时间[%s],价格点数量[%s],与周一5点偏差[%s]个点,数据起始[%s]点", mondayTS, nowTS, pointLen, offsetPoint, dataIndex))
	end

	local recentDate = {}

	index = dataIndex

	for i = 1, pointLen do
		local _t = mondayTS + (index - 15) * timeStep
		local _str = os.date("%m/%d", _t)

		table.insert(recentDate, _str)

		index = index + 1
	end

	self._lineChartWrap:AddData(recentDate, recentPrices)
end

function M:_onClickConfirm()
	local count = self._autoInputBeh:getValue()
	local id = self._mo.itemId
	local price = self._mo.price

	if count <= 0 then
		FloatWordMgr.instance:show(lang("tip_not_enough_sell"))
	else
		TradingAgent.instance:sendSaleTradeGoodsRequest(id, count, price)
		self:close()
	end
end

function M:_onClickClose()
	self:close()
end

function M:_onNumChange(num)
	self:_judgeTxtColor()

	local price = self._mo.price

	self._txtTotalPrice.text = price * self._autoInputBeh:getValue()
end

function M:_onNumChangeFail(num, failNum)
	return
end

function M:_judgeTxtColor()
	return
end

function M:_printStatus()
	if not Astral.OSDef.isEditor then
		return
	end

	local t = {
		string.format("商品[%s]信息:", self._mo.itemId)
	}

	table.insert(t, string.format("价格:%s", self._mo.price))
	table.insert(t, string.format("价格档位:%s", self._mo.priceLevel))
	table.insert(t, string.format("本周推荐:%s", self._mo.recommend))

	if self._mo.recentPrices and #self._mo.recentPrices > 0 then
		local _m = "价格曲线： "

		for index, value in ipairs(self._mo.recentPrices) do
			_m = string.format("%s (%s) %s ", _m, index, value)
		end

		table.insert(t, _m)
	else
		table.insert(t, "价格曲线: 空")
	end

	printWarn(table.concat(t, "\n"))
end

return M
