-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/trading/view/TradingCentreView.lua

module("logic.extensions.trading.view.TradingCentreView", package.seeall)

local InformationItem = class("InformationItem")

function InformationItem:ctor(compContainer)
	self._go = compContainer.gameObject
	self._imgIcon = goutil.findChildImageComponent(self._go, "")
	self._goRecommend1 = goutil.findChild(self._go, "")
	self._goRecommend2 = goutil.findChild(self._go, "")
	self._goRecommends = {
		self._goRecommend1,
		self._goRecommend2
	}
end

function InformationItem:updateData(data)
	IconLoader.setSprite(self._imgIcon, IconType.DynSpriteAtlas_Battle, data.icon)

	for i = 1, #self._goRecommends do
		goutil.setActive(self._goRecommends[i], i <= data.recommend)
	end
end

local SORT_TYPE = TradingModel.instance.SORT_TYPE
local M = class("TradingCentreView", ViewComponent)

M.PRICE_UP_TYPE = {
	UP = 1,
	DOWN = 3,
	UP_UP = 2,
	DOWN_DOWN = 4,
	NONE = 5
}

function M:ctor()
	M.super.ctor(self)

	self._goodItems = {}
end

function M:buildUI()
	local cell1 = self:getGo("trade_center_view_-1009979153")
	local cell2 = self:getGo("trade_center_view_1715944264")

	self._recommendGo = {
		{
			go = cell1,
			item = Astral.LuaComponentContainer.Add(goutil.findChild(cell1, "backpack_item").gameObject, ItemCell),
			txtName = goutil.findChildTextComponent(cell1, "txtName"),
			priceMarks = {
				[M.PRICE_UP_TYPE.UP] = goutil.findChild(cell1, "priceChanges/type3").gameObject,
				[M.PRICE_UP_TYPE.UP_UP] = goutil.findChild(cell1, "priceChanges/type4").gameObject,
				[M.PRICE_UP_TYPE.DOWN] = goutil.findChild(cell1, "priceChanges/type1").gameObject,
				[M.PRICE_UP_TYPE.DOWN_DOWN] = goutil.findChild(cell1, "priceChanges/type2").gameObject
			}
		},
		{
			go = cell2,
			item = Astral.LuaComponentContainer.Add(goutil.findChild(cell2, "backpack_item").gameObject, ItemCell),
			txtName = goutil.findChildTextComponent(cell2, "txtName"),
			priceMarks = {
				[M.PRICE_UP_TYPE.UP] = goutil.findChild(cell2, "priceChanges/type3").gameObject,
				[M.PRICE_UP_TYPE.UP_UP] = goutil.findChild(cell2, "priceChanges/type4").gameObject,
				[M.PRICE_UP_TYPE.DOWN] = goutil.findChild(cell2, "priceChanges/type1").gameObject,
				[M.PRICE_UP_TYPE.DOWN_DOWN] = goutil.findChild(cell2, "priceChanges/type2").gameObject
			}
		}
	}

	goutil.setActive(cell1, false)
	goutil.setActive(cell2, false)

	for _, val in ipairs(self._recommendGo) do
		val.item:setShowSelectedEffect(false)

		for _, _priceMark in pairs(val.priceMarks or {}) do
			goutil.setActive(_priceMark, false)
		end
	end

	self._txtDesc = self:getText("trade_center_view_-1684064264")
	self._txtRecommendEmpty = self:getText("trade_center_view_-40742190")
	self._rectTrDesc = self._txtDesc.gameObject:GetComponent(UIComponentType.RectTransform)

	local _, anchoredY = Astral.TransformUtil.GetAnchoredPos(self._rectTrDesc, 0, 0)

	self._descAnchoredY = anchoredY
	self._txtDesc.text = nil
	self._txtRecommendEmpty.text = nil
	self._traGoodsContent = self:getGo("trade_center_view_-264226406").transform
	self._goGoodItem = self:getGo("trade_center_view_-221325667")
	self._txtRefreshTime = self:getText("trade_center_view_-962745324")
	self._btnSort = self:getBtn("trade_center_view_-1867810885")
	self._toggleSort = self:getUIComponent("trade_center_view_-1867810885", UIComponentType.SpaceXToggle)
	self._btnDropdown = self:getUIComponent("trade_center_view_-1926944163", UIComponentType.DropdownApapter)
	self._dropDownFilter = self:getUIComponent("trade_center_view_-1926944163", UIComponentType.Dropdown)
	self._refreshTimer = SchedulerCtrl.New(self.refreshTimeCountdown, self)
end

function M:destroyUI()
	self._refreshTimer:clear()

	self._refreshTimer = nil
end

function M:bindEvents()
	self._btnSort:AddClickListener(self._clickSortGoods, self)
	self._btnDropdown:AddListener(self._clickDropDown, self)
end

function M:unbindEvents()
	self._btnSort:RemoveClickListener()
	self._btnDropdown:RemoveClickListener()
end

function M:onEnter()
	self:setEvent(true)
	self:_refreshLastFilter()
	TradingAgent.instance:sendGetGoodsPriceRequest()
	self:_printStatus()
end

function M:onExit()
	self._refreshTimer:stop()
	self._txtDesc:DOKill(false)
	self._rectTrDesc:DOKill(false)
end

function M:onExitFinished()
	self:setEvent(false)
end

function M:setEvent(add)
	if add then
		Scheduler.addListener(5, self.updateTradeInfo, self, true)
		GlobalDispatcher:addEventListener(EventType.TRADING_GOOD_LIST, self._onTradingGoodListRefresh, self)
		GlobalDispatcher:addEventListener(EventType.TRADING_REFRESH_TIME, self._onRefreshTimeChange, self)
	else
		Scheduler.removeListener(self.updateTradeInfo, self)
		GlobalDispatcher:removeEventListener(EventType.TRADING_GOOD_LIST, self._onTradingGoodListRefresh, self)
		GlobalDispatcher:removeEventListener(EventType.TRADING_REFRESH_TIME, self._onRefreshTimeChange, self)
	end
end

function M:_refreshLastFilter()
	self:unbindEvents()

	self._sortType, self._sortUp = TradingModel.instance:getTradeCenterInfo()
	self._dropDownFilter.value = self._sortType
	self._toggleSort.IsOn = not self._sortUp

	self:bindEvents()
end

function M:_clickSortGoods()
	self._sortUp = not self._sortUp

	TradingModel.instance:setTradeCenterInfo(self._sortType, self._sortUp)
	self:sortGoodList()
end

function M:_clickDropDown(index)
	self._sortType = index

	TradingModel.instance:setTradeCenterInfo(self._sortType, self._sortUp)
	self:sortGoodList()
end

function M:sortGoodList(goodListTemp)
	local goodList = goodListTemp ~= nil and goodListTemp or TradingModel.instance:getGoodList()

	table.sort(goodList, function(a, b)
		local itemCOA = BackpackConfig.instance:getItemInfoByItemId(a.itemId)
		local itemCOB = BackpackConfig.instance:getItemInfoByItemId(b.itemId)
		local qualityA = itemCOA.quality
		local qualityB = itemCOB.quality
		local priceA = a.price
		local priceB = b.price

		if self._sortType == SORT_TYPE.QUALITY then
			if self._sortUp then
				if qualityA ~= qualityB then
					return qualityB < qualityA
				end

				return false
			else
				return qualityA < qualityB
			end
		elseif self._sortType == SORT_TYPE.PRICE then
			if self._sortUp then
				if priceA ~= priceB then
					return priceB < priceA
				end

				return false
			else
				return priceA < priceB
			end
		else
			local countA = ItemModel.instance:getItemCountByItemId(a.itemId)
			local countB = ItemModel.instance:getItemCountByItemId(b.itemId)

			if countA ~= countB then
				if self._sortUp then
					return countB < countA
				else
					return countA < countB
				end
			end

			if qualityA ~= qualityB then
				return qualityB < qualityA
			elseif priceA ~= priceB then
				return priceB < priceA
			elseif a.itemId ~= b.itemId then
				return a.itemId > b.itemId
			end

			return false
		end
	end)
	self:showGoodList(goodList)
end

function M:getPriceUpType(goodMo)
	local curPrice = goodMo.price
	local prePrice = goodMo.recentPrices[15] or 0

	if prePrice == 0 then
		return M.PRICE_UP_TYPE.NONE, 0
	else
		local up = (curPrice - prePrice) / prePrice

		if up >= 0.1 then
			return M.PRICE_UP_TYPE.UP_UP, up
		elseif up == 0 then
			return M.PRICE_UP_TYPE.NONE, up
		elseif up > 0 then
			return M.PRICE_UP_TYPE.UP, up
		elseif up > -0.1 then
			return M.PRICE_UP_TYPE.DOWN, up
		else
			return M.PRICE_UP_TYPE.DOWN_DOWN, up
		end
	end
end

function M:showGoodList(goodList)
	for i = 0, self._traGoodsContent.childCount - 1 do
		goutil.setActive(self._traGoodsContent:GetChild(i).gameObject, false)
	end

	for k, v in ipairs(goodList) do
		local itemCO = BackpackConfig.instance:getItemInfoByItemId(v.itemId)
		local item = self._goodItems[k]

		if not item then
			local go = Astral.GameObjectUtil.CloneAndSetParent(self._goGoodItem, self._traGoodsContent, nil)

			item = Astral.LuaComponentContainer.Add(go, TradingGoodsItem)
			self._goodItems[k] = item
		end

		local data = {}

		data.id = v.itemId
		data.mo = v
		data.name = itemCO.name
		data.co = itemCO
		data.icon = itemCO.icon
		data.price = v.price

		local curNum = ItemModel.instance:getItemCountByItemId(v.itemId)

		data.count = curNum
		data.quality = itemCO.quality
		data.priceUpType, data.upPercent = self:getPriceUpType(v)

		item:updateData(data)
	end
end

function M:_onTradingGoodListRefresh(sender, goodList)
	self:sortGoodList()
	self:updateRecommendGoods()
	self:updateTradeInfo()
end

function M:_onRefreshTimeChange(sender, refreshTime)
	self._refreshTime = refreshTime
	self._txtRefreshTime.text = self:getRefreshTime() .. lang("tip_trading_lang_12")

	self._refreshTimer:restart(1, true)
end

function M:refreshTimeCountdown()
	self._txtRefreshTime.text = self:getRefreshTime() .. lang("tip_trading_lang_12")
end

function M:getRefreshTime()
	local curTime = ServerTime.now()
	local expiredTime = self._refreshTime

	if expiredTime < curTime then
		return lang("tip_trading_lang_13")
	end

	local offset = expiredTime - curTime

	return TextFormatter.formatFullExpireTime(offset)
end

function M:updateRecommendGoods()
	local protomerIds = {}
	local priceUpTyps = {}

	for _, good in ipairs(TradingModel.instance:getRecommendGoodLst()) do
		local cfg = BackpackConfig.instance:getConfigByKey(ConfigName.ItemHouse, good.itemId)
		local protomerId = cfg and cfg.protomerId or 0

		if protomerId > 0 and not table.indexof(protomerIds, protomerId) then
			table.insert(protomerIds, protomerId)

			local _priceUpType = -1

			if good.priceLevel == 1 then
				_priceUpType = M.PRICE_UP_TYPE.UP
			elseif good.priceLevel == 4 then
				_priceUpType = M.PRICE_UP_TYPE.DOWN
			end

			table.insert(priceUpTyps, _priceUpType)
		end
	end

	local hasShowRecommendGoods = false

	for i, val in ipairs(self._recommendGo) do
		local show = i <= #protomerIds

		if show then
			local itemData = ItemUtil.createItemData({
				itemId = protomerIds[i]
			})

			val.item:updateData(itemData)

			val.txtName.text = itemData:getName()
			hasShowRecommendGoods = true
		end

		goutil.setActive(val.go, show)
	end

	if hasShowRecommendGoods then
		self._txtRecommendEmpty.text = nil
	else
		self._txtRecommendEmpty.text = lang("tip_trading_no_recommend_good")
	end
end

function M:updateTradeInfo()
	self._txtDesc:DOKill(false)
	self._rectTrDesc:DOKill(false)

	local ease = DG.Tweening.Ease.Linear
	local duration_hide = 0.4
	local duration_show = 0.5

	Astral.GeometryUtil.SetAnchorPosY(self._rectTrDesc, self._descAnchoredY)
	self._rectTrDesc:DOAnchorPosY(self._descAnchoredY + 20, duration_hide):SetEase(ease):SetAutoKill(true)
	self._txtDesc:DOFade(0, duration_hide):SetEase(ease):SetAutoKill(true):OnComplete(function()
		self._txtDesc.text = TextUtils.GetPunctuationFixedText(TradingModel.instance:getNextTradeInfo(), self._txtDesc, 0, 200)

		Astral.GeometryUtil.SetAnchorPosY(self._rectTrDesc, self._descAnchoredY - 20)
		self._rectTrDesc:DOAnchorPosY(self._descAnchoredY, duration_show):SetEase(ease):SetAutoKill(true)
		self._txtDesc:DOFade(1, duration_show):SetEase(ease):SetAutoKill(true)
	end, self)
end

function M:_printStatus()
	if not Astral.OSDef.isEditor then
		return
	end

	local t = {
		"贸易站信息:"
	}
	local recommendLst = TradingModel.instance:getRecommendGoodLst()

	if recommendLst and #recommendLst > 0 then
		local _m = "推荐商品:"

		for index, good in ipairs(recommendLst) do
			_m = string.format("%s (%s) %s ", _m, index, good.itemId)
		end

		table.insert(t, _m)
	else
		table.insert(t, "推荐商品：空")
	end

	for i = 1, 4 do
		local goodLst = TradingModel.instance:getGoodLstByPriceLv(i)

		if goodLst and #goodLst > 0 then
			local _m = string.format("价格挡%s: ", i)

			for index, good in ipairs(goodLst) do
				_m = string.format("%s (%s) %s ", _m, index, good.itemId)
			end

			table.insert(t, _m)
		else
			table.insert(t, string.format("价格挡%s: 空", i))
		end
	end

	local ids = TradingModel.instance:getTradeInfoIds()

	if #ids > 0 then
		local str = table.concat(ids, ",")

		table.insert(t, string.format("流言ids:  %s", str))
	else
		table.insert(t, "流言ids: 空")
	end

	printWarn(table.concat(t, "\n"))
end

return M
