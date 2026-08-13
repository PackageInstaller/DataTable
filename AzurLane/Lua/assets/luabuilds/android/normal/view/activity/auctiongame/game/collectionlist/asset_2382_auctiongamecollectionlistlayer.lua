class = var_0_10000

local var_0_0 = "AuctionGameCollectionListLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

var_0_1.ON_SWITCH_RARITY = "AuctionGameCollectionListLayer::ON_SWITCH_RARITY"
var_0_1.ON_SWITCH_CONTOUR = "AuctionGameCollectionListLayer::ON_SWITCH_CONTOUR"

function var_0_1.getUIName(arg_1_0)
	return "AuctionGameCollectionListUI"
end

function var_0_1.init(arg_2_0)
	setText = var_1_10001

	local var_2_0 = arg_2_0.uiTitleText

	i18n = var_1_10003

	var_1_10001(var_2_0, var_1_10003("auction_collection_title"))

	setText = var_1_10001

	local var_2_1 = arg_2_0.uiCollectTitleText

	i18n = var_3

	var_1_10001(var_2_1, var_3("auction_collect_unlock"))

	onButton = var_1_10001

	local var_2_2 = arg_2_0
	local var_2_3 = arg_2_0.uiBgBtn

	local function var_2_4()
		local var_3_0 = arg_2_0

		var_0.closeView(var_3_0)

		return
	end

	SOUND_BACK = var_1_10005

	var_1_10001(var_2_2, var_2_3, var_2_4, var_1_10005)

	onButton = var_1_10001

	local var_2_5 = arg_2_0
	local var_2_6 = arg_2_0.uiCloseBtn

	local function var_2_7()
		local var_4_0 = arg_2_0

		var_0.closeView(var_4_0)

		return
	end

	SOUND_BACK = var_1_10005

	var_1_10001(var_2_5, var_2_6, var_2_7, var_1_10005)

	LuaList = var_1_10001

	local var_2_8 = var_1_10001.New
	local var_2_9 = arg_2_0

	handler = var_2_6

	local var_2_10 = var_2_6(arg_2_0, arg_2_0.IndexItem)
	local var_2_11 = arg_2_0.uiList

	AuctionGameCollectionItem = var_5
	arg_2_0.uiScrollView = var_2_8(var_2_9, var_2_10, var_2_11, var_5)

	arg_2_0:GetFilterData()

	arg_2_0.rarityItemList = {}
	ipairs = var_1

	for iter_2_0, iter_2_1 in var_1(arg_2_0.rarityList) do
		local var_2_12 = arg_2_0.rarityItemList

		AuctionGameCollectionRarityItem = var_1_10007
		var_1_10007 = var_1_10007.New
		string = var_1_10008
		var_2_12[iter_2_0] = var_1_10007(arg_2_0[var_1_10008.format("uiRarityItem%s", iter_2_0)], arg_2_0)
		var_1_10007 = arg_2_0.rarityItemList[iter_2_0]

		var_6.didEnter(var_1_10007, iter_2_1)
	end

	arg_2_0.contourItemList = {}
	pairs = var_1

	for iter_2_2, iter_2_3 in var_1(arg_2_0.contourList) do
		local var_2_13 = iter_2_3[1]
		local var_2_14 = iter_2_3[2]

		table = var_1_10008
		var_1_10008 = var_1_10008.insert

		local var_2_15 = arg_2_0.contourItemList

		AuctionGameCollectionContourItem = var_1_10010
		var_1_10010 = var_1_10010.New
		string = var_1_10011

		var_1_10008(var_2_15, var_1_10010(arg_2_0[var_1_10011.format("uiContourItem%s", iter_2_2)], arg_2_0))

		local var_2_16 = arg_2_0.contourItemList[#arg_2_0.contourItemList]

		var_1_10008.didEnter(var_2_16, var_2_14, var_2_13)
	end

	return
end

function var_0_1.didEnter(arg_5_0)
	arg_5_0:OverlayPanel(arg_5_0._tf, {
		pbList = {
			arg_5_0.uiBg
		}
	})

	local var_5_0

	if not arg_5_0.contextData.rarityIndex then
		var_5_0 = 0
	end

	arg_5_0.rarityIndex = var_5_0

	local var_5_1

	if not arg_5_0.contextData.contour then
		var_5_1 = {
			0,
			0
		}
	end

	arg_5_0.contourData = var_5_1

	arg_5_0:RefreshCollectionList()

	local var_5_2 = {}
	local var_5_3 = arg_5_0
	local var_5_4 = arg_5_0.bind
	local var_5_5 = var_0_1.ON_SWITCH_RARITY

	handler = var_5
	var_5_2[1] = var_5_4(var_5_3, var_5_5, var_5(arg_5_0, arg_5_0.OnSwitchRarity))

	local var_5_6 = arg_5_0
	local var_5_7 = arg_5_0.bind
	local var_5_8 = var_0_1.ON_SWITCH_CONTOUR

	handler = var_5
	var_5_2[2] = var_5_7(var_5_6, var_5_8, var_5(arg_5_0, arg_5_0.OnSwitchContour))
	arg_5_0.eventIDList = var_5_2
	getProxy = var_5_2
	AuctionGameBaseProxy = var_2

	local var_5_9 = var_5_2(var_2)

	setText = var_2

	local var_5_10 = arg_5_0.uiCollectText

	string = var_5_8

	local var_5_11 = var_5_8.format
	local var_5_12 = "%s/%s"
	local var_5_13 = var_5_9.unlockCollectionCnt

	pg = var_7

	var_2(var_5_10, var_5_11(var_5_12, var_5_13, #var_7.auction_collection.all))

	return
end

function var_0_1.RefreshCollectionList(arg_6_0)
	arg_6_0:GetCollectionList(arg_6_0.rarityIndex, arg_6_0.contourData)

	local var_6_0 = arg_6_0.uiScrollView

	var_1.StartScroll(var_6_0, #arg_6_0.idList)

	local var_6_1 = arg_6_0
	local var_6_2 = arg_6_0.GetPriceArea

	minValue = var_3
	maxValue = var_4

	local var_6_3, var_6_4 = var_6_2(var_6_1, var_3, var_4)

	setText = var_3

	local var_6_5 = arg_6_0.uiPriceAreaText

	string = var_1_10005

	local var_6_6 = var_1_10005.format
	local var_6_7 = "%s - %s"

	StringHelper = var_1_10007

	local var_6_8 = var_1_10007.ForamtNumber(var_6_3)

	StringHelper = var_8

	var_3(var_6_5, var_6_6(var_6_7, var_6_8, var_8.ForamtNumber(var_6_4)))

	ipairs = var_3

	for iter_6_0, iter_6_1 in var_3(arg_6_0.rarityItemList) do
		iter_6_1:SetSelectedRarity(arg_6_0.rarityIndex)
	end

	ipairs = var_3

	for iter_6_2, iter_6_3 in var_3(arg_6_0.contourItemList) do
		iter_6_3:SetSelectedContour(arg_6_0.contourData)
	end

	return
end

function var_0_1.IndexItem(arg_7_0, arg_7_1, arg_7_2)
	arg_7_2:didEnter(arg_7_0.idList[arg_7_1])
	arg_7_2:ShowLockState()

	return
end

function var_0_1.GetCollectionList(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = {}

	ipairs = var_1_10004
	pg = var_1_10005

	for iter_8_0, iter_8_1 in var_1_10004(var_1_10005.auction_collection.all) do
		pg = var_1_10009
		var_1_10009 = var_1_10009.auction_collection[iter_8_1]

		if (arg_8_1 == 0 or var_1_10009.rarity == arg_8_1) and (arg_8_2[1] == 0 or arg_8_2[1] == var_1_10009.contour[1] and arg_8_2[2] == var_1_10009.contour[2]) then
			table = var_10

			var_10.insert(var_8_0, iter_8_1)
		end
	end

	table = var_4

	var_4.sort(var_8_0, function(arg_9_0, arg_9_1)
		pg = var_2_10002

		local var_9_0 = var_2_10002.auction_collection[arg_9_0]

		pg = var_2_10003

		local var_9_1 = var_2_10003.auction_collection[arg_9_1]

		if var_9_0.rarity ~= var_9_1.rarity then
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

	arg_8_0.idList = var_8_0

	return
end

function var_0_1.GetPriceArea(arg_10_0)
	local var_10_0 = 0
	local var_10_1 = 0

	ipairs = var_1_10003

	for iter_10_0, iter_10_1 in var_1_10003(arg_10_0.idList) do
		pg = var_1_10008
		var_1_10008 = var_1_10008.auction_collection[iter_10_1]

		if iter_10_0 == 1 then
			var_10_0 = var_1_10008.value
			var_10_1 = var_1_10008.value
		else
			var_10_0 = var_10_0 > var_1_10008.value and var_1_10008.value or var_10_0
			var_10_1 = var_10_1 < var_1_10008.value and var_1_10008.value or var_10_1
		end
	end

	return var_10_0, var_10_1
end

function var_0_1.GetFilterData(arg_11_0)
	local var_11_0 = {
		0
	}
	local var_11_1 = {}

	ipairs = var_1_10003
	pg = var_1_10004

	for iter_11_0, iter_11_1 in var_1_10003(var_1_10004.auction_collection.all) do
		pg = var_1_10008
		var_1_10008 = var_1_10008.auction_collection[iter_11_1]
		table = var_1_10009

		if not var_1_10009.keyof(var_11_0, var_1_10008.rarity) then
			table = var_1_10009

			var_1_10009.insert(var_11_0, var_1_10008.rarity)
		end

		var_1_10009 = var_1_10008.contour[1]

		local var_11_2

		if not var_11_1[var_1_10008.contour[1]] then
			var_11_2 = {}
		end

		var_11_1[var_1_10009] = var_11_2
		table = var_1_10009

		if not var_1_10009.keyof(var_11_1[var_1_10008.contour[1]], var_1_10008.contour[2]) then
			table = var_1_10009

			var_1_10009.insert(var_11_1[var_1_10008.contour[1]], var_1_10008.contour[2])
		end
	end

	table = var_3

	var_3.sort(var_11_0, function(arg_12_0, arg_12_1)
		return arg_12_0 < arg_12_1
	end)

	local var_11_3 = {}

	pairs = var_4

	for iter_11_2, iter_11_3 in var_4(var_11_1) do
		table = var_1_10009

		var_1_10009.sort(iter_11_3, function(arg_13_0, arg_13_1)
			return arg_13_0 < arg_13_1
		end)

		table = var_1_10009

		var_1_10009.insert(var_11_3, iter_11_2)
	end

	table = var_4

	var_4.sort(var_11_3, function(arg_14_0, arg_14_1)
		return arg_14_0 < arg_14_1
	end)

	arg_11_0.rarityList = var_11_0
	arg_11_0.contourList = {
		{
			0,
			0
		}
	}
	ipairs = var_4

	for iter_11_4, iter_11_5 in var_4(var_11_3) do
		ipairs = var_1_10009

		for iter_11_6, iter_11_7 in var_1_10009(var_11_1[iter_11_5]) do
			table = var_1_10014

			var_1_10014.insert(arg_11_0.contourList, {
				iter_11_5,
				iter_11_7
			})
		end
	end

	return
end

function var_0_1.OnSwitchRarity(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0.rarityIndex = arg_15_2

	arg_15_0:RefreshCollectionList()

	return
end

function var_0_1.OnSwitchContour(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0.contourData = arg_16_2

	arg_16_0:RefreshCollectionList()

	return
end

function var_0_1.willExit(arg_17_0)
	arg_17_0:UnOverlayPanel(arg_17_0._tf)

	ipairs = var_1

	for iter_17_0, iter_17_1 in var_1(arg_17_0.eventIDList) do
		arg_17_0:disconnect(iter_17_1)
	end

	arg_17_0.eventIDList = nil
	ipairs = var_1

	for iter_17_2, iter_17_3 in var_1(arg_17_0.rarityItemList) do
		iter_17_3:willExit()
	end

	arg_17_0.rarityItemList = nil
	ipairs = var_1

	for iter_17_4, iter_17_5 in var_1(arg_17_0.contourItemList) do
		iter_17_5:willExit()
	end

	arg_17_0.contourItemList = nil

	local var_17_0 = arg_17_0.uiScrollView

	var_1.Dispose(var_17_0)

	arg_17_0.uiScrollView = nil

	return
end

return var_0_1
