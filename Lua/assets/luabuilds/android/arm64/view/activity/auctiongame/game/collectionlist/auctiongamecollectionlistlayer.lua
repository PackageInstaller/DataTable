local var_0_0 = class("AuctionGameCollectionListLayer", import("view.base.BaseUI"))

var_0_0.ON_SWITCH_RARITY = "AuctionGameCollectionListLayer::ON_SWITCH_RARITY"
var_0_0.ON_SWITCH_CONTOUR = "AuctionGameCollectionListLayer::ON_SWITCH_CONTOUR"

function var_0_0.getUIName(arg_1_0)
	return "AuctionGameCollectionListUI"
end

function var_0_0.init(arg_2_0)
	setText(arg_2_0.uiTitleText, i18n("auction_collection_title"))
	setText(arg_2_0.uiCollectTitleText, i18n("auction_collect_unlock"))
	onButton(arg_2_0, arg_2_0.uiBgBtn, function()
		arg_2_0:closeView()

		return
	end, SOUND_BACK)
	onButton(arg_2_0, arg_2_0.uiCloseBtn, function()
		arg_2_0:closeView()

		return
	end, SOUND_BACK)

	arg_2_0.uiScrollView = LuaList.New(arg_2_0, handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.uiList, AuctionGameCollectionItem)

	arg_2_0:GetFilterData()

	arg_2_0.rarityItemList = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.rarityList) do
		arg_2_0.rarityItemList[iter_2_0] = AuctionGameCollectionRarityItem.New(arg_2_0[string.format("uiRarityItem%s", iter_2_0)], arg_2_0)

		arg_2_0.rarityItemList[iter_2_0]:didEnter(iter_2_1)
	end

	arg_2_0.contourItemList = {}

	for iter_2_2, iter_2_3 in pairs(arg_2_0.contourList) do
		table.insert(arg_2_0.contourItemList, AuctionGameCollectionContourItem.New(arg_2_0[string.format("uiContourItem%s", iter_2_2)], arg_2_0))
		arg_2_0.contourItemList[#arg_2_0.contourItemList]:didEnter(iter_2_3[2], iter_2_3[1])
	end

	return
end

function var_0_0.didEnter(arg_5_0)
	arg_5_0:OverlayPanel(arg_5_0._tf, {
		pbList = {
			arg_5_0.uiBg
		}
	})

	arg_5_0.rarityIndex = arg_5_0.contextData.rarityIndex or 0
	arg_5_0.contourData = arg_5_0.contextData.contour or {
		0,
		0
	}

	arg_5_0:RefreshCollectionList()

	arg_5_0.eventIDList = {
		arg_5_0:bind(var_0_0.ON_SWITCH_RARITY, handler(arg_5_0, arg_5_0.OnSwitchRarity)),
		arg_5_0:bind(var_0_0.ON_SWITCH_CONTOUR, handler(arg_5_0, arg_5_0.OnSwitchContour))
	}

	setText(arg_5_0.uiCollectText, string.format("%s/%s", getProxy(AuctionGameBaseProxy).unlockCollectionCnt, #pg.auction_collection.all))

	return
end

function var_0_0.RefreshCollectionList(arg_6_0)
	arg_6_0:GetCollectionList(arg_6_0.rarityIndex, arg_6_0.contourData)
	arg_6_0.uiScrollView:StartScroll(#arg_6_0.idList)

	local var_6_0, var_6_1 = arg_6_0:GetPriceArea(minValue, maxValue)

	setText(arg_6_0.uiPriceAreaText, string.format("%s - %s", StringHelper.ForamtNumber(var_6_0), StringHelper.ForamtNumber(var_6_1)))

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.rarityItemList) do
		iter_6_1:SetSelectedRarity(arg_6_0.rarityIndex)
	end

	for iter_6_2, iter_6_3 in ipairs(arg_6_0.contourItemList) do
		iter_6_3:SetSelectedContour(arg_6_0.contourData)
	end

	return
end

function var_0_0.IndexItem(arg_7_0, arg_7_1, arg_7_2)
	arg_7_2:didEnter(arg_7_0.idList[arg_7_1])
	arg_7_2:ShowLockState()

	return
end

function var_0_0.GetCollectionList(arg_8_0, arg_8_1, arg_8_2)
	for iter_8_0, iter_8_1 in ipairs(pg.auction_collection.all) do
		if (arg_8_1 == 0 or pg.auction_collection[iter_8_1].rarity == arg_8_1) and (arg_8_2[1] == 0 or arg_8_2[1] == pg.auction_collection[iter_8_1].contour[1] and arg_8_2[2] == pg.auction_collection[iter_8_1].contour[2]) then
			table.insert({}, iter_8_1)
		end
	end

	table.sort({}, function(arg_9_0, arg_9_1)
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

	arg_8_0.idList = {}

	return
end

function var_0_0.GetPriceArea(arg_10_0)
	local var_10_0 = 0
	local var_10_1 = 0

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.idList) do
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

function var_0_0.GetFilterData(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(pg.auction_collection.all) do
		if not table.keyof({
			0
		}, pg.auction_collection[iter_11_1].rarity) then
			table.insert({
				0
			}, pg.auction_collection[iter_11_1].rarity)
		end

		local var_11_0 = pg.auction_collection[iter_11_1].contour[1]
		local var_11_1 = ({})[pg.auction_collection[iter_11_1].contour[1]]

		if not ({})[pg.auction_collection[iter_11_1].contour[1]] then
			var_11_1 = {}
		end

		;({})[var_11_0] = var_11_1

		if not table.keyof(({})[pg.auction_collection[iter_11_1].contour[1]], pg.auction_collection[iter_11_1].contour[2]) then
			table.insert(({})[pg.auction_collection[iter_11_1].contour[1]], pg.auction_collection[iter_11_1].contour[2])
		end
	end

	table.sort({
		0
	}, function(arg_12_0, arg_12_1)
		return arg_12_0 < arg_12_1
	end)

	for iter_11_2, iter_11_3 in pairs({}) do
		table.sort(iter_11_3, function(arg_13_0, arg_13_1)
			return arg_13_0 < arg_13_1
		end)
		table.insert({}, iter_11_2)
	end

	table.sort({}, function(arg_14_0, arg_14_1)
		return arg_14_0 < arg_14_1
	end)

	arg_11_0.rarityList = {
		0
	}
	arg_11_0.contourList = {
		{
			0,
			0
		}
	}

	for iter_11_4, iter_11_5 in ipairs({}) do
		for iter_11_6, iter_11_7 in ipairs(({})[iter_11_5]) do
			table.insert(arg_11_0.contourList, {
				iter_11_5,
				iter_11_7
			})
		end
	end

	return
end

function var_0_0.OnSwitchRarity(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0.rarityIndex = arg_15_2

	arg_15_0:RefreshCollectionList()

	return
end

function var_0_0.OnSwitchContour(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0.contourData = arg_16_2

	arg_16_0:RefreshCollectionList()

	return
end

function var_0_0.willExit(arg_17_0)
	arg_17_0:UnOverlayPanel(arg_17_0._tf)

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.eventIDList) do
		arg_17_0:disconnect(iter_17_1)
	end

	arg_17_0.eventIDList = nil

	for iter_17_2, iter_17_3 in ipairs(arg_17_0.rarityItemList) do
		iter_17_3:willExit()
	end

	arg_17_0.rarityItemList = nil

	for iter_17_4, iter_17_5 in ipairs(arg_17_0.contourItemList) do
		iter_17_5:willExit()
	end

	arg_17_0.contourItemList = nil

	arg_17_0.uiScrollView:Dispose()

	arg_17_0.uiScrollView = nil

	return
end

return var_0_0
