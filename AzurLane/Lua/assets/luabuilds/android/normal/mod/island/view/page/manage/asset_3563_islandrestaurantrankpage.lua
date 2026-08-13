class = var_0_10000

local var_0_0 = "IslandRestaurantRankPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.IslandBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandRestaurantRankUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.viewTF = var_1.Find(var_2_0, "window/view")

	local var_2_1 = arg_2_0.viewTF
	local var_2_2 = var_1.Find(var_2_1, "content")
	local var_2_3 = var_1.Find(var_2_2, "tpl")

	setText = var_2_2

	local var_2_4 = var_2_3
	local var_2_5 = var_2_3.Find(var_2_4, "info/top/exp/name")

	i18n = var_2_4

	var_2_2(var_2_5, var_2_4("island_manage_need_ext"))

	setText = var_2_2

	local var_2_6 = var_2_3
	local var_2_7 = var_2_3.Find(var_2_6, "info/top/finished/Text")

	i18n = var_2_6

	var_2_2(var_2_7, var_2_6("island_manage_reach"))

	setText = var_2_2

	local var_2_8 = var_2_3
	local var_2_9 = var_2_3.Find(var_2_8, "info/bottom/content/shelf/info/name")

	i18n = var_2_8

	var_2_2(var_2_9, var_2_8("island_manage_slot"))

	setText = var_2_2

	local var_2_10 = var_2_3
	local var_2_11 = var_2_3.Find(var_2_10, "info/bottom/content/capacity/info/name")

	i18n = var_2_10

	var_2_2(var_2_11, var_2_10("island_manage_food_cnt"))

	setText = var_2_2

	local var_2_12 = var_2_3
	local var_2_13 = var_2_3.Find(var_2_12, "info/bottom/content/percent/info/name")

	i18n = var_2_12

	var_2_2(var_2_13, var_2_12("island_manage_sale_ratio"))

	setText = var_2_2

	local var_2_14 = var_2_3
	local var_2_15 = var_2_3.Find(var_2_14, "info/bottom/content/assistant/info/name")

	i18n = var_2_14

	var_2_2(var_2_15, var_2_14("island_manage_worker_cnt"))

	UIItemList = var_2_2
	arg_2_0.uiList = var_2_2.New(var_1, var_2_3)

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_3.Find(var_3_1, "mask")

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_0, var_3_2, var_3_3, var_5)

	onButton = var_1_10001

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0._tf
	local var_3_6 = var_3.Find(var_3_5, "window/close")

	local function var_3_7()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_4, var_3_6, var_3_7, var_5)

	local var_3_8 = arg_3_0.uiList

	var_1.make(var_3_8, function(arg_6_0, arg_6_1, arg_6_2)
		UIItemList = var_2_10003

		if arg_6_0 == var_2_10003.EventInit then
			local var_6_0 = arg_3_0

			var_3.InitItem(var_6_0, arg_6_1, arg_6_2)
		else
			UIItemList = var_3

			if arg_6_0 == var_3.EventUpdate then
				local var_6_1 = arg_3_0

				var_3.UpdataItem(var_6_1, arg_6_1, arg_6_2)
			end
		end

		return
	end)

	pg = var_1
	arg_3_0.rankIds = var_1.island_manage_rank.all
	table = var_1

	var_1.sort(arg_3_0.rankIds)

	return
end

function var_0_1.InitItem(arg_7_0, arg_7_1, arg_7_2)
	pg = var_1_10003
	arg_7_2.name = var_1_10003.island_manage_rank[arg_7_0.rankIds[arg_7_1 + 1]].id
	LoadImageSpriteAsync = var_4

	var_4("island/islandrestaurant/" .. var_3.icon, arg_7_2:Find("icon"))

	setText = var_4

	var_4(arg_7_2:Find("info/top/name"), var_3.name)

	local var_7_0 = arg_7_2
	local var_7_1 = arg_7_2.Find(var_7_0, "info/bottom/content")

	setText = var_7_0

	var_7_0(var_7_1:Find("shelf/info/value"), var_3.slot_num[1])

	setText = var_7_0

	var_7_0(var_7_1:Find("capacity/info/value"), var_3.slot_num[2])

	setText = var_7_0

	var_7_0(var_7_1:Find("percent/info/value"), var_3.bonus_coefficient / 100 .. "%")

	setText = var_7_0

	var_7_0(var_7_1:Find("assistant/info/value"), var_3.assistant_num)

	setActive = var_7_0

	var_7_0(arg_7_2:Find("dot/silder"), arg_7_1 + 1 ~= #arg_7_0.rankIds)

	return
end

function var_0_1.UpdataItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.rankIds[arg_8_1 + 1]
	local var_8_1 = arg_8_0.rankIds[arg_8_1]
	local var_8_2 = arg_8_0.expData[var_8_0]
	local var_8_3 = var_8_0 <= arg_8_0.level

	setActive = var_1_10007

	var_1_10007(arg_8_2:Find("dot/finished"), var_8_3)

	setActive = var_1_10007

	var_1_10007(arg_8_2:Find("info/top/finished"), var_8_3)

	setActive = var_1_10007

	var_1_10007(arg_8_2:Find("info/top/exp"), not var_8_3)

	local var_8_4

	if not arg_8_0.expData[var_8_1] then
		var_8_4 = 0
	end

	local var_8_5 = 0

	if var_8_2 ~= var_8_4 then
		var_8_5 = (arg_8_0.sales - var_8_4) / (var_8_2 - var_8_4)
	end

	setSlider = var_9

	var_9(arg_8_2:Find("dot/silder"), 0, 1, var_8_5)

	setText = var_9

	var_9(arg_8_2:Find("info/top/exp/value"), arg_8_0.sales .. "/" .. var_8_4)

	return
end

function var_0_1.OnShow(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0

	arg_9_0.BlurPanel(var_9_0)

	getProxy = var_2
	IslandProxy = var_9_0

	local var_9_1 = var_2(var_9_0)
	local var_9_2 = var_2.GetIsland(var_9_1)
	local var_9_3 = var_2.GetManageAgency(var_9_2)

	arg_9_0.rest = var_2.GetRestaurant(var_9_3, arg_9_1)

	local var_9_4 = arg_9_0.rest

	arg_9_0.level = var_2.GetRankLevel(var_9_4)

	local var_9_5 = arg_9_0.rest

	arg_9_0.sales = var_2.GetSales(var_9_5)
	IslandRestaurant = var_2
	arg_9_0.expData = var_2.GET_RNAK_EXPS(arg_9_1)

	local var_9_6 = arg_9_0.uiList

	var_2.align(var_9_6, #arg_9_0.rankIds)

	local var_9_7 = {}
	local var_9_8 = arg_9_0.uiList

	var_3.eachActive(var_9_8, function(arg_10_0, arg_10_1)
		local var_10_0 = arg_10_1
		local var_10_1 = arg_10_1.GetComponent

		typeof = var_2_10004
		CanvasGroup = var_2_10005

		local var_10_2 = var_10_1(var_10_0, var_2_10004(var_2_10005))

		var_10_2.alpha = 0
		table = var_10_2

		var_10_2.insert(var_9_7, function(arg_11_0)
			local var_11_0 = arg_10_1
			local var_11_1 = var_1.GetComponent

			typeof = var_3_10003
			CanvasGroup = var_3_10004
			var_11_1(var_11_0, var_3_10003(var_3_10004)).alpha = 1

			local var_11_2 = arg_10_1
			local var_11_3 = var_1.GetComponent

			typeof = var_3
			Animation = var_3_10004

			local var_11_4 = var_11_3(var_11_2, var_3(var_3_10004))

			var_1.Play(var_11_4)

			local var_11_5 = arg_9_0
			local var_11_6 = var_1.managedTween

			LeanTween = var_3

			var_11_6(var_11_5, var_3.delayedCall, function()
				arg_11_0()

				return
			end, 0.03, nil)

			return
		end)

		return
	end)

	seriesAsync = var_3

	var_3(var_9_7, function()
		scrollTo = var_2_10000

		var_2_10000(arg_9_0.viewTF, 0, 1 - (arg_9_0.level - 1) / (#arg_9_0.rankIds - 3))

		return
	end)

	return
end

function var_0_1.OnHide(arg_14_0)
	arg_14_0:UnBlurPanel()

	return
end

function var_0_1.OnDestroy(arg_15_0)
	arg_15_0:OnHide()

	return
end

return var_0_1
