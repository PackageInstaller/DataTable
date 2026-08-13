class = var_0_10000

local var_0_0 = "IslandTradePriceTrendPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "IslandTradePriceTrendUI"
end

function var_0_1.OnLoaded(arg_2_0)
	UIItemList = var_1_10001

	local var_2_0 = var_1_10001.New
	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_3.Find(var_2_1, "frame/prices")
	local var_2_3 = arg_2_0._tf

	arg_2_0.uiPriceList = var_2_0(var_2_2, var_4.Find(var_2_3, "frame/prices/tpl"))
	UIItemList = var_1

	local var_2_4 = var_1.New
	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_3.Find(var_2_5, "frame/date")
	local var_2_7 = arg_2_0._tf

	arg_2_0.uiDateList = var_2_4(var_2_6, var_4.Find(var_2_7, "frame/date/tpl"))

	local var_2_8 = arg_2_0._tf

	arg_2_0.tpl = var_1.Find(var_2_8, "frame/tpl")

	local var_2_9 = arg_2_0._tf

	arg_2_0.dotContainer = var_1.Find(var_2_9, "frame/dots")
	arg_2_0.dots = {}

	return
end

function var_0_1.Show(arg_3_0, arg_3_1, arg_3_2)
	var_0_1.super.Show(arg_3_0)

	arg_3_0.mode = arg_3_2
	arg_3_0.island = arg_3_1

	arg_3_0:InitPrices()
	arg_3_0:InitDate()

	onNextTick = var_3

	var_3(function()
		local var_4_0 = arg_3_0

		var_0.UpdateCurve(var_4_0)

		return
	end)

	return
end

function var_0_1.InitPrices(arg_5_0)
	arg_5_0.priceList = {}
	pg = var_1

	local var_5_0 = var_1.island_set.treasure_price_scale_y.key_value_varchar
	local var_5_1 = arg_5_0.uiPriceList

	var_2.make(var_5_1, function(arg_6_0, arg_6_1, arg_6_2)
		UIItemList = var_2_10003

		if arg_6_0 == var_2_10003.EventUpdate then
			local var_6_0 = var_5_0[arg_6_1 + 1]

			setText = var_4

			var_4(arg_6_2:Find("Text"), var_6_0)

			table = var_4

			var_4.insert(arg_5_0.priceList, {
				var_6_0,
				arg_6_2
			})
		end

		return
	end)

	local var_5_2 = arg_5_0.uiPriceList

	var_2.align(var_5_2, #var_5_0)

	table = var_2

	var_2.sort(arg_5_0.priceList, function(arg_7_0, arg_7_1)
		return arg_7_0[1] < arg_7_1[1]
	end)

	return
end

function var_0_1.CollectDate(arg_8_0)
	pg = var_1_10001

	local var_8_0 = var_1_10001.TimeMgr.GetInstance()
	local var_8_1 = var_1.GetServerHour(var_8_0)

	GetZeroTime = var_1_10002

	local var_8_2 = var_1_10002()

	if var_8_1 <= 2 then
		var_8_2 = var_8_2 - 0
	end

	local var_8_3 = var_8_2 - 0 + 10800
	local var_8_4 = {}
	local var_8_5 = 0

	for iter_8_0 = 6, 1, -1 do
		local var_8_6 = arg_8_0.island
		local var_8_7 = var_10.GetTradeAgency(var_8_6)

		if var_10.ExistTrade(var_8_7, var_8_3 - iter_8_0 * 0) then
			var_8_5 = iter_8_0

			break
		end
	end

	for iter_8_1 = var_8_5, 1, -1 do
		local var_8_8 = var_8_3 - iter_8_1 * 0

		table = var_1_10011

		var_1_10011.insert(var_8_4, var_8_8)
	end

	table = var_6

	var_6.insert(var_8_4, var_8_3)

	for iter_8_2 = 1, 7 - #var_8_4 do
		local var_8_9 = var_8_3 + iter_8_2 * 0

		table = var_1_10011

		var_1_10011.insert(var_8_4, var_8_9)
	end

	return var_8_4
end

function var_0_1.InitDate(arg_9_0)
	arg_9_0.dateList = {}

	local var_9_0 = arg_9_0:CollectDate()

	assert = var_1_10002

	var_1_10002(#var_9_0 == 7)

	local var_9_1 = arg_9_0.uiDateList

	var_2.make(var_9_1, function(arg_10_0, arg_10_1, arg_10_2)
		UIItemList = var_2_10003

		if arg_10_0 == var_2_10003.EventUpdate then
			local var_10_0 = var_9_0[arg_10_1 + 1]

			pg = var_4

			local var_10_1 = var_4.TimeMgr.GetInstance()
			local var_10_2 = var_4.STimeDescS(var_10_1, var_10_0, "%m.%d")

			setText = var_2_10005

			var_2_10005(arg_10_2:Find("Text"), var_10_2)

			arg_9_0.dateList[var_10_0] = arg_10_2
		end

		return
	end)

	local var_9_2 = arg_9_0.uiDateList

	var_2.align(var_9_2, #var_9_0)

	return
end

function var_0_1.UpdateCurve(arg_11_0)
	eachChild = var_1_10001

	var_1_10001(arg_11_0.dotContainer, function(arg_12_0)
		setActive = var_2_10001

		var_2_10001(arg_12_0, false)

		return
	end)

	local var_11_0 = arg_11_0.island
	local var_11_1 = var_1.GetTradeAgency(var_11_0)
	local var_11_2
	local var_11_3 = arg_11_0.mode

	IslandTradePage = var_4

	if var_11_3 == var_4.MODE_SELL then
		var_11_2 = var_11_1:GetSellPriceTrend()
	else
		local var_11_4 = arg_11_0.mode

		IslandTradePage = var_4

		if var_11_4 == var_4.MODE_PURCHAS then
			var_11_2 = var_11_1:GetPriceTrend()
		end
	end

	local var_11_5 = {}

	pairs = var_4

	for iter_11_0, iter_11_1 in var_4(arg_11_0.dateList) do
		if var_11_2[iter_11_0] then
			local var_11_6 = arg_11_0:UpdateCurveItem(iter_11_0, iter_11_1, var_9)

			table = var_1_10011

			var_1_10011.insert(var_11_5, {
				iter_11_0,
				var_11_6
			})
		end
	end

	table = var_4

	var_4.sort(var_11_5, function(arg_13_0, arg_13_1)
		return arg_13_0[1] < arg_13_1[1]
	end)

	_ = var_4

	local var_11_7 = var_4.map(var_11_5, function(arg_14_0)
		return arg_14_0[2]
	end)

	ipairs = var_5

	for iter_11_2, iter_11_3 in var_5(var_11_5) do
		local var_11_8 = iter_11_3[1]
		local var_11_9 = arg_11_0.dots[var_11_8]
		local var_11_10 = var_11.Find(var_11_9, "line")
		local var_11_11 = var_11_5[iter_11_2 + 1]

		if var_11_10 and var_11_11 and var_11_11[1] - iter_11_3[1] == 0 then
			Vector2 = var_11_9
			var_11_9 = var_11_9.Distance(iter_11_3[2].localPosition, var_11_11[2].localPosition)
			Vector2 = var_14
			var_11_10.sizeDelta = var_14(4, var_11_9)
			var_11_10.up = (var_11_11[2].position - iter_11_3[2].position).normalized
			setActive = var_15

			var_15(var_11_10, true)
		elseif var_11_10 then
			setActive = var_11_9

			var_11_9(var_11_10, false)
		end
	end

	arg_11_0:PlayDotAnimations(var_11_7)

	return
end

function var_0_1.PlayDotAnimations(arg_15_0, arg_15_1)
	local var_15_0 = {}

	table = var_1_10003

	var_1_10003.insert(var_15_0, function(arg_16_0)
		onDelayTick = var_2_10001

		var_2_10001(arg_16_0, 0.33)

		return
	end)

	ipairs = var_3

	for iter_15_0, iter_15_1 in var_3(arg_15_1) do
		setActive = var_1_10008

		var_1_10008(iter_15_1, false)

		table = var_1_10008

		var_1_10008.insert(var_15_0, function(arg_17_0)
			IsNil = var_2_10001

			if var_2_10001(iter_15_1) then
				return
			end

			setActive = var_1

			var_1(iter_15_1, true)

			local var_17_0 = iter_15_1

			if not var_1.GetComponent(var_17_0, "Animation") then
				return
			end

			var_1:Play("anim_IslandTradePriceTrendUI_res_tpl_in")

			onDelayTick = var_2

			var_2(arg_17_0, 0.33)

			return
		end)
	end

	seriesAsync = var_3

	var_3(var_15_0)

	return
end

function var_0_1.UpdateCurveItem(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0

	if not arg_18_0.dots[arg_18_1] then
		cloneTplTo = var_1_10005
		var_18_0 = var_1_10005(arg_18_0.tpl, arg_18_0.dotContainer)
		var_1_10005 = arg_18_0.dots
		var_1_10005[arg_18_1] = var_18_0
	end

	setActive = var_1_10005

	var_1_10005(var_18_0, true)

	local var_18_1 = arg_18_0.dotContainer
	local var_18_2 = var_5.InverseTransformPoint
	local var_18_3 = arg_18_2
	local var_18_4 = var_18_2(var_18_1, arg_18_2.Find(var_18_3, "Text").position)
	local var_18_5 = arg_18_0:GetPriceYScale(arg_18_3)

	setLocalPosition = var_18_1

	local var_18_6 = var_18_0

	Vector3 = var_18_3

	var_18_1(var_18_6, var_18_3(var_18_4.x, var_18_5, 0))

	setActive = var_18_1

	local var_18_7 = var_18_0:Find("dot/current")

	pg = var_10

	local var_18_8 = var_10.TimeMgr.GetInstance()
	local var_18_9 = var_10.IsSameDay
	local var_18_10 = arg_18_1

	pg = var_14

	local var_18_11 = var_14.TimeMgr.GetInstance()

	var_18_1(var_18_7, var_18_9(var_18_8, var_18_10, var_14.GetServerTime(var_18_11)))

	return var_18_0
end

function var_0_1.GetPriceYScale(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0.priceList[1]
	local var_19_1 = arg_19_0.priceList[2][2].localPosition.y - var_19_0[2].localPosition.y
	local var_19_2

	ipairs = var_1_10006

	for iter_19_0, iter_19_1 in var_1_10006(arg_19_0.priceList) do
		if arg_19_1 >= iter_19_1[1] then
			var_19_2 = iter_19_0
		end
	end

	if not var_19_2 then
		return
	end

	local var_19_3 = 0
	local var_19_4 = 0

	if var_19_2 == #arg_19_0.priceList then
		var_19_3 = arg_19_0.priceList[var_19_2][1] + 1000
		var_19_4 = arg_19_0.priceList[var_19_2][1]
	else
		var_19_3 = arg_19_0.priceList[var_19_2 + 1][1]
		var_19_4 = arg_19_0.priceList[var_19_2][1]
	end

	local var_19_5 = (arg_19_1 - var_19_4) / (var_19_3 - var_19_4)
	local var_19_6 = arg_19_0.priceList[var_19_2][2]
	local var_19_7 = arg_19_0.dotContainer

	return var_10.InverseTransformPoint(var_19_7, var_19_6:Find("Text").position).y + var_19_1 * var_19_5
end

return var_0_1
