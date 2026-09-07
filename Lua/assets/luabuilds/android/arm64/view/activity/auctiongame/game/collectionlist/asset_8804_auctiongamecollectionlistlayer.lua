local AuctionGameCollectionListLayer = class("AuctionGameCollectionListLayer", import("view.base.BaseUI"))

AuctionGameCollectionListLayer.ON_SWITCH_RARITY = "AuctionGameCollectionListLayer::ON_SWITCH_RARITY"
AuctionGameCollectionListLayer.ON_SWITCH_CONTOUR = "AuctionGameCollectionListLayer::ON_SWITCH_CONTOUR"

function AuctionGameCollectionListLayer:getUIName()
	return "AuctionGameCollectionListUI"
end

function AuctionGameCollectionListLayer:init()
	setText(self.uiTitleText, i18n("auction_collection_title"))
	setText(self.uiCollectTitleText, i18n("auction_collect_unlock"))
	onButton(self, self.uiBgBtn, function()
		self:closeView()

		return
	end, SOUND_BACK)
	onButton(self, self.uiCloseBtn, function()
		self:closeView()

		return
	end, SOUND_BACK)

	self.uiScrollView = LuaList.New(self, handler(self, self.IndexItem), self.uiList, AuctionGameCollectionItem)

	self:GetFilterData()

	self.rarityItemList = {}

	for iter_2_0, iter_2_1 in ipairs(self.rarityList) do
		self.rarityItemList[iter_2_0] = AuctionGameCollectionRarityItem.New(self[string.format("uiRarityItem%s", iter_2_0)], self)

		self.rarityItemList[iter_2_0]:didEnter(iter_2_1)
	end

	self.contourItemList = {}

	for iter_2_2, iter_2_3 in pairs(self.contourList) do
		table.insert(self.contourItemList, AuctionGameCollectionContourItem.New(self[string.format("uiContourItem%s", iter_2_2)], self))
		self.contourItemList[#self.contourItemList]:didEnter(iter_2_3[2], iter_2_3[1])
	end

	return
end

function AuctionGameCollectionListLayer:didEnter()
	self:OverlayPanel(self._tf, {
		pbList = {
			self.uiBg
		}
	})

	self.rarityIndex = self.contextData.rarityIndex or 0
	self.contourData = self.contextData.contour or {
		0,
		0
	}

	self:RefreshCollectionList()

	self.eventIDList = {
		self:bind(AuctionGameCollectionListLayer.ON_SWITCH_RARITY, handler(self, self.OnSwitchRarity)),
		self:bind(AuctionGameCollectionListLayer.ON_SWITCH_CONTOUR, handler(self, self.OnSwitchContour))
	}

	setText(self.uiCollectText, string.format("%s/%s", getProxy(AuctionGameBaseProxy).unlockCollectionCnt, #pg.auction_collection.all))

	return
end

function AuctionGameCollectionListLayer:RefreshCollectionList()
	self:GetCollectionList(self.rarityIndex, self.contourData)
	self.uiScrollView:StartScroll(#self.idList)

	local var_6_0, var_6_1 = self:GetPriceArea(minValue, maxValue)

	setText(self.uiPriceAreaText, string.format("%s - %s", StringHelper.ForamtNumber(var_6_0), StringHelper.ForamtNumber(var_6_1)))

	for iter_6_0, iter_6_1 in ipairs(self.rarityItemList) do
		iter_6_1:SetSelectedRarity(self.rarityIndex)
	end

	for iter_6_2, iter_6_3 in ipairs(self.contourItemList) do
		iter_6_3:SetSelectedContour(self.contourData)
	end

	return
end

function AuctionGameCollectionListLayer:IndexItem(arg_7_1, arg_7_2)
	arg_7_2:didEnter(self.idList[arg_7_1])
	arg_7_2:ShowLockState()

	return
end

function AuctionGameCollectionListLayer:GetCollectionList(arg_8_1, arg_8_2)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(pg.auction_collection.all) do
		if (arg_8_1 == 0 or pg.auction_collection[iter_8_1].rarity == arg_8_1) and (arg_8_2[1] == 0 or arg_8_2[1] == pg.auction_collection[iter_8_1].contour[1] and arg_8_2[2] == pg.auction_collection[iter_8_1].contour[2]) then
			table.insert(var_8_0, iter_8_1)
		end
	end

	table.sort(var_8_0, function(arg_9_0, arg_9_1)
		local var_9_0 = pg.auction_collection[arg_9_0]
		local var_9_1 = pg.auction_collection[arg_9_1]

		if pg.auction_collection[arg_9_0].rarity ~= pg.auction_collection[arg_9_1].rarity then
			return var_9_0.rarity > var_9_1.rarity
		end

		if var_9_0.contour[1] ~= var_9_1.contour[1] then
			return var_9_0.contour[1] > var_9_1.contour[1]
		end

		if var_9_0.contour[2] ~= var_9_1.contour[2] then
			return var_9_0.contour[2] > var_9_1.contour[2]
		end

		return var_9_0.value > var_9_1.value
	end)

	self.idList = var_8_0

	return
end

function AuctionGameCollectionListLayer:GetPriceArea()
	local var_10_0 = 0
	local var_10_1 = 0

	for iter_10_0, iter_10_1 in ipairs(self.idList) do
		if iter_10_0 == 1 then
			var_10_0 = pg.auction_collection[iter_10_1].value
			var_10_1 = pg.auction_collection[iter_10_1].value
		else
			var_10_0 = var_10_0 > pg.auction_collection[iter_10_1].value and pg.auction_collection[iter_10_1].value or var_10_0
			var_10_1 = var_10_1 < pg.auction_collection[iter_10_1].value and pg.auction_collection[iter_10_1].value or var_10_1
		end
	end

	return var_10_0, var_10_1
end

function AuctionGameCollectionListLayer:GetFilterData()
	local var_11_0 = {
		0
	}
	local var_11_1 = {}

	for iter_11_0, iter_11_1 in ipairs(pg.auction_collection.all) do
		if not table.keyof(var_11_0, pg.auction_collection[iter_11_1].rarity) then
			table.insert(var_11_0, pg.auction_collection[iter_11_1].rarity)
		end

		var_11_1[pg.auction_collection[iter_11_1].contour[1]] = var_11_1[pg.auction_collection[iter_11_1].contour[1]] or {}

		if not table.keyof(var_11_1[pg.auction_collection[iter_11_1].contour[1]], pg.auction_collection[iter_11_1].contour[2]) then
			table.insert(var_11_1[pg.auction_collection[iter_11_1].contour[1]], pg.auction_collection[iter_11_1].contour[2])
		end
	end

	table.sort(var_11_0, function(arg_12_0, arg_12_1)
		return arg_12_0 < arg_12_1
	end)

	local var_11_2 = {}

	for iter_11_2, iter_11_3 in pairs(var_11_1) do
		table.sort(iter_11_3, function(arg_13_0, arg_13_1)
			return arg_13_0 < arg_13_1
		end)
		table.insert(var_11_2, iter_11_2)
	end

	table.sort(var_11_2, function(arg_14_0, arg_14_1)
		return arg_14_0 < arg_14_1
	end)

	self.rarityList = var_11_0
	self.contourList = {
		{
			0,
			0
		}
	}

	for iter_11_4, iter_11_5 in ipairs(var_11_2) do
		for iter_11_6, iter_11_7 in ipairs(var_11_1[iter_11_5]) do
			table.insert(self.contourList, {
				iter_11_5,
				iter_11_7
			})
		end
	end

	return
end

function AuctionGameCollectionListLayer:OnSwitchRarity(arg_15_1, arg_15_2)
	self.rarityIndex = arg_15_2

	self:RefreshCollectionList()

	return
end

function AuctionGameCollectionListLayer:OnSwitchContour(arg_16_1, arg_16_2)
	self.contourData = arg_16_2

	self:RefreshCollectionList()

	return
end

function AuctionGameCollectionListLayer:willExit()
	self:UnOverlayPanel(self._tf)

	for iter_17_0, iter_17_1 in ipairs(self.eventIDList) do
		self:disconnect(iter_17_1)
	end

	self.eventIDList = nil

	for iter_17_2, iter_17_3 in ipairs(self.rarityItemList) do
		iter_17_3:willExit()
	end

	self.rarityItemList = nil

	for iter_17_4, iter_17_5 in ipairs(self.contourItemList) do
		iter_17_5:willExit()
	end

	self.contourItemList = nil

	self.uiScrollView:Dispose()

	self.uiScrollView = nil

	return
end

return AuctionGameCollectionListLayer
