class = var_0_10000

local var_0_0 = "IslandRestaurantUpgradePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.IslandBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandRestaurantUpgradeUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.titleTF = var_1.Find(var_2_0, "title/name/Text")

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_1.Find(var_2_1, "window/summary")

	setText = var_1_10002

	local var_2_3 = var_2_2:Find("title/Text")

	i18n = var_1_10005

	var_1_10002(var_2_3, var_1_10005("island_manage_result_3"))

	arg_2_0.shelfTF = var_2_2:Find("shelf/info/value")
	setText = var_2

	local var_2_4 = var_2_2:Find("shelf/info/name")

	i18n = var_5

	var_2(var_2_4, var_5("island_manage_slot"))

	arg_2_0.capacityTF = var_2_2:Find("capacity/info/value")
	setText = var_2

	local var_2_5 = var_2_2:Find("capacity/info/name")

	i18n = var_5

	var_2(var_2_5, var_5("island_manage_food_cnt"))

	arg_2_0.percentTF = var_2_2:Find("percent/info/value")
	setText = var_2

	local var_2_6 = var_2_2:Find("percent/info/name")

	i18n = var_5

	var_2(var_2_6, var_5("island_manage_sale_ratio"))

	arg_2_0.assistantTF = var_2_2:Find("assistant/info/value")
	setText = var_2

	local var_2_7 = var_2_2:Find("assistant/info/name")

	i18n = var_5

	var_2(var_2_7, var_5("island_manage_worker_cnt"))

	local var_2_8 = arg_2_0._tf

	arg_2_0.viewTF = var_2.Find(var_2_8, "window/rank")
	UIItemList = var_2

	local var_2_9 = var_2.New
	local var_2_10 = arg_2_0.viewTF
	local var_2_11 = var_4.Find(var_2_10, "content")
	local var_2_12 = arg_2_0.viewTF

	arg_2_0.uiList = var_2_9(var_2_11, var_5.Find(var_2_12, "content/tpl"))
	setText = var_2

	local var_2_13 = arg_2_0._tf
	local var_2_14 = var_4.Find(var_2_13, "tip")

	i18n = var_5

	var_2(var_2_14, var_5("child_close_tip"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_4.Find(var_3_1, "mask")

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_3_1

	var_1_10001(var_3_0, var_3_2, var_3_3, var_3_1)

	local var_3_4 = arg_3_0.uiList

	var_1.make(var_3_4, function(arg_5_0, arg_5_1, arg_5_2)
		UIItemList = var_2_10003

		if arg_5_0 == var_2_10003.EventInit then
			pg = var_3
			arg_5_2.name = var_3.island_manage_rank[arg_3_0.rankIds[arg_5_1 + 1]].id
			LoadImageSpriteAsync = var_4

			var_4("island/islandrestaurant/" .. var_3.icon, arg_5_2:Find("icon"))

			setActive = var_4

			var_4(arg_5_2:Find("dot/silder"), arg_5_1 + 1 ~= #arg_3_0.rankIds)
		else
			UIItemList = var_3

			if arg_5_0 == var_3.EventUpdate then
				local var_5_0 = arg_3_0

				var_3.UpdataItem(var_5_0, arg_5_1, arg_5_2)
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

function var_0_1.OnShow(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0

	arg_6_0.BlurPanel(var_6_0)

	arg_6_0.callback = arg_6_2
	arg_6_0.restId = arg_6_1.restId
	arg_6_0.oldSale = arg_6_1.oldSale
	getProxy = var_3
	IslandProxy = var_6_0

	local var_6_1 = var_3(var_6_0)
	local var_6_2 = var_3.GetIsland(var_6_1)
	local var_6_3 = var_3.GetManageAgency(var_6_2)

	arg_6_0.rest = var_3.GetRestaurant(var_6_3, arg_6_0.restId)

	local var_6_4 = arg_6_0.rest

	arg_6_0.level = var_3.GetRankLevel(var_6_4)

	local var_6_5 = arg_6_0.rest

	arg_6_0.sales = var_3.GetSales(var_6_5)
	IslandRestaurant = var_3
	arg_6_0.expData = var_3.GET_RNAK_EXPS(arg_6_0.restId)
	setText = var_3

	local var_6_6 = arg_6_0.titleTF
	local var_6_7 = arg_6_0.rest

	var_3(var_6_6, var_6.getConfig(var_6_7, "name"))
	arg_6_0:UpdataSummary()

	local var_6_8 = arg_6_0.uiList

	var_3.align(var_6_8, #arg_6_0.rankIds)

	scrollTo = var_3

	var_3(arg_6_0.viewTF, (arg_6_0.level - 1) / (#arg_6_0.rankIds - 3), 0)

	return
end

function var_0_1.UpdataItem(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.rankIds[arg_7_1 + 1]
	local var_7_1 = arg_7_0.rankIds[arg_7_1]
	local var_7_2 = arg_7_0.expData[var_7_0]
	local var_7_3 = var_7_0 <= arg_7_0.level

	setActive = var_1_10007

	var_1_10007(arg_7_2:Find("dot/finished"), var_7_3)

	local var_7_4

	if not arg_7_0.expData[var_7_1] then
		var_7_4 = 0
	end

	local var_7_5 = 0

	if var_7_2 ~= var_7_4 then
		var_7_5 = (arg_7_0.sales - var_7_4) / (var_7_2 - var_7_4)
	end

	setSlider = var_9

	var_9(arg_7_2:Find("dot/silder"), 0, 1, var_7_5)

	return
end

function var_0_1.UpdataSummary(arg_8_0)
	pg = var_1_10001

	local var_8_0 = var_1_10001.island_manage_rank[arg_8_0.level]

	pg = var_2

	local var_8_1 = var_2.island_manage_rank[arg_8_0.level - 1]

	setText = var_3

	local var_8_2 = arg_8_0.shelfTF

	var_3(var_5.Find(var_8_2, "base"), var_8_1.slot_num[1])

	local var_8_3 = var_8_0.slot_num[1] - var_8_1.slot_num[1]

	setText = var_4

	local var_8_4 = arg_8_0.shelfTF
	local var_8_5 = var_6.Find(var_8_4, "add")
	local var_8_6

	if not (var_8_3 > 0) or not ("+" .. var_8_3) then
		var_8_6 = ""
	end

	var_4(var_8_5, var_8_6)

	setText = var_4

	local var_8_7 = arg_8_0.capacityTF

	var_4(var_6.Find(var_8_7, "base"), var_8_1.slot_num[2])

	local var_8_8 = var_8_0.slot_num[2] - var_8_1.slot_num[2]

	setText = var_5

	local var_8_9 = arg_8_0.capacityTF
	local var_8_10 = var_7.Find(var_8_9, "add")
	local var_8_11

	if not (var_8_8 > 0) or not ("+" .. var_8_8) then
		var_8_11 = ""
	end

	var_5(var_8_10, var_8_11)

	setText = var_5

	local var_8_12 = arg_8_0.percentTF

	var_5(var_7.Find(var_8_12, "base"), var_8_1.bonus_coefficient / 100 .. "%")

	local var_8_13 = (var_8_0.bonus_coefficient - var_8_1.bonus_coefficient) / 100

	setText = var_6

	local var_8_14 = arg_8_0.percentTF
	local var_8_15 = var_8.Find(var_8_14, "add")
	local var_8_16

	if not (var_8_13 > 0) or not ("+" .. var_8_13 .. "%") then
		var_8_16 = ""
	end

	var_6(var_8_15, var_8_16)

	setText = var_6

	local var_8_17 = arg_8_0.assistantTF

	var_6(var_8.Find(var_8_17, "base"), var_8_1.assistant_num)

	local var_8_18 = var_8_0.assistant_num - var_8_1.assistant_num

	setText = var_7

	local var_8_19 = arg_8_0.assistantTF
	local var_8_20 = var_9.Find(var_8_19, "add")
	local var_8_21

	if not (var_8_18 > 0) or not ("+" .. var_8_18) then
		var_8_21 = ""
	end

	var_7(var_8_20, var_8_21)

	return
end

function var_0_1.OnHide(arg_9_0)
	arg_9_0:UnBlurPanel()

	existCall = var_1

	var_1(arg_9_0.callback)

	arg_9_0.callback = nil

	return
end

function var_0_1.OnDestroy(arg_10_0)
	arg_10_0:UnBlurPanel()

	return
end

return var_0_1
