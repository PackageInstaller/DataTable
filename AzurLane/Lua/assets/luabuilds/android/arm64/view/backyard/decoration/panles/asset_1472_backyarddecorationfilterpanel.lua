class = var_0_10000

local var_0_0 = "BackYardDecorationFilterPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("....base.BaseSubView"))

var_0_1.SORT_MODE = {
	BY_FUNC = 2,
	BY_CONFIG = 3,
	BY_DEFAULT = 1
}

local var_0_2 = {}
local var_0_3 = {
	{
		1,
		"default"
	}
}

i18n = var_3
var_0_3[2] = var_3("backyard_sort_tag_default")
var_0_2[1] = var_0_3

local var_0_4 = {
	{
		2,
		"sortPriceFunc"
	}
}

i18n = var_3
var_0_4[2] = var_3("backyard_sort_tag_price")
var_0_2[2] = var_0_4

local var_0_5 = {
	{
		3,
		"comfortable"
	}
}

i18n = var_3
var_0_5[2] = var_3("backyard_sort_tag_comfortable")
var_0_2[3] = var_0_5

local var_0_6 = {
	{
		2,
		"sortSizeFunc"
	}
}

i18n = var_3
var_0_6[2] = var_3("backyard_sort_tag_size")
var_0_2[4] = var_0_6
var_0_1.SORT_TAG = var_0_2
var_0_1.ORDER_MODE_ASC = 1
var_0_1.ORDER_MODE_DASC = 2

function var_0_1.getUIName(arg_1_0)
	return "BackYardIndexUI"
end

function var_0_1.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	var_0_1.super.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)

	pg = var_4
	arg_2_0.filterConfig = var_4.backyard_theme_template
	arg_2_0.sortData = var_0_1.SORT_TAG[1][1]
	arg_2_0.sortTxt = var_0_1.SORT_TAG[1][2]
	_ = var_4
	arg_2_0.filterData = var_4.select(arg_2_0.filterConfig.all, function(arg_3_0)
		return arg_2_0.filterConfig[arg_3_0].is_view == 1
	end)
	arg_2_0.totalThemeCnt = #arg_2_0.filterData
	pg = var_4
	arg_2_0.themes = var_4.furniture_data_template.get_id_list_by_themeId

	return
end

function var_0_1.OnLoaded(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0.sortTpl = var_1.Find(var_4_0, "bg/sort_tpl")

	local var_4_1 = arg_4_0._tf

	arg_4_0.filterTpl = var_1.Find(var_4_1, "bg/filter_tpl")

	local var_4_2 = arg_4_0._tf

	arg_4_0.sortContainer = var_1.Find(var_4_2, "bg/frame/sorts/sort_container")

	local var_4_3 = arg_4_0._tf

	arg_4_0.filterContainer = var_1.Find(var_4_3, "bg/frame/filters/rect_view/conent/theme_panel")

	local var_4_4 = arg_4_0._tf

	arg_4_0.selectedAllBtn = var_1.Find(var_4_4, "bg/frame/filters/rect_view/conent/all_panel/sort_tpl")

	local var_4_5 = arg_4_0._tf

	arg_4_0.close = var_1.Find(var_4_5, "bg/close")
	setText = var_1

	local var_4_6 = arg_4_0._tf
	local var_4_7 = var_3.Find(var_4_6, "bg/frame/title")

	i18n = var_4

	var_1(var_4_7, var_4("indexsort_sort"))

	setText = var_1

	local var_4_8 = arg_4_0._tf
	local var_4_9 = var_3.Find(var_4_8, "bg/frame/title_filter")

	i18n = var_4

	var_1(var_4_9, var_4("indexsort_index"))

	setText = var_1

	local var_4_10 = arg_4_0.selectedAllBtn
	local var_4_11 = var_3.Find(var_4_10, "Text")

	i18n = var_4

	var_1(var_4_11, var_4("index_all"))

	setText = var_1

	local var_4_12 = arg_4_0._tf
	local var_4_13 = var_3.Find(var_4_12, "bg/frame/confirm_btn/Text")

	i18n = var_4

	var_1(var_4_13, var_4("word_ok"))

	setText = var_1

	local var_4_14 = arg_4_0._tf
	local var_4_15 = var_3.Find(var_4_14, "bg/title")

	i18n = var_4

	var_1(var_4_15, var_4("courtyard_label_filter"))

	return
end

function var_0_1.setFilterData(arg_5_0, arg_5_1)
	arg_5_0.furnitures = arg_5_1 or {}

	return
end

function var_0_1.GetFilterData(arg_6_0)
	return arg_6_0.furnitures
end

function var_0_1.SetDorm(arg_7_0, arg_7_1)
	arg_7_0.dorm = arg_7_1

	return
end

function var_0_1.updateOrderMode(arg_8_0, arg_8_1)
	arg_8_0.orderMode = arg_8_1 or var_0_1.ORDER_MODE_ASC

	return
end

function var_0_1.OnInit(arg_9_0)
	onButton = var_1_10001

	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0._tf
	local var_9_2 = var_4.Find(var_9_1, "bg/frame/confirm_btn")

	local function var_9_3()
		local var_10_0 = arg_9_0

		var_0.filter(var_10_0)

		local var_10_1 = arg_9_0

		var_0.Hide(var_10_1)

		if arg_9_0.confirmFunc then
			arg_9_0.confirmFunc()
		end

		return
	end

	SFX_PANEL = var_9_1

	var_1_10001(var_9_0, var_9_2, var_9_3, var_9_1)

	onButton = var_1_10001

	local var_9_4 = arg_9_0
	local var_9_5 = arg_9_0._go

	local function var_9_6()
		local var_11_0 = arg_9_0

		var_0.Hide(var_11_0)

		return
	end

	SFX_PANEL = var_9_1

	var_1_10001(var_9_4, var_9_5, var_9_6, var_9_1)

	onButton = var_1_10001

	local var_9_7 = arg_9_0
	local var_9_8 = arg_9_0.close

	local function var_9_9()
		local var_12_0 = arg_9_0

		var_0.Hide(var_12_0)

		return
	end

	SFX_PANEL = var_9_1

	var_1_10001(var_9_7, var_9_8, var_9_9, var_9_1)
	arg_9_0:initSortPanel()
	arg_9_0:initFilterPanel()

	triggerToggle = var_1

	var_1(arg_9_0.selectedAllBtn, true)

	triggerToggle = var_1

	var_1(arg_9_0.sortBtns[1], true)

	return
end

function var_0_1.initSortPanel(arg_13_0)
	arg_13_0.sortBtns = {}
	pairs = var_1

	for iter_13_0, iter_13_1 in var_1(var_0_1.SORT_TAG) do
		cloneTplTo = var_1_10006
		var_1_10006 = var_1_10006(arg_13_0.sortTpl, arg_13_0.sortContainer)
		setText = var_1_10007

		var_1_10007(var_1_10006:Find("Text"), iter_13_1[2])

		var_1_10007 = arg_13_0.sortBtns
		var_1_10007[iter_13_0] = var_1_10006

		arg_13_0:onSwitch(var_1_10006, function(arg_14_0)
			if arg_14_0 then
				arg_13_0.sortData = iter_13_1[1]
				arg_13_0.sortTxt = iter_13_1[2]
			end

			return
		end)
	end

	return
end

function var_0_1.onSwitch(arg_15_0, arg_15_1, arg_15_2)
	onToggle = var_1_10003

	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_1

	local function var_15_2(arg_16_0)
		local var_16_0 = arg_15_1
		local var_16_1 = var_1.Find(var_16_0, "Text")
		local var_16_2 = var_1.GetComponent

		typeof = var_4
		Text = var_2_10006

		local var_16_3 = var_16_2(var_16_1, var_4(var_2_10006))

		if arg_16_0 then
			Color = var_2_10002

			if not var_2_10002.New(1, 1, 1, 1) then
				Color = var_2_10002
				var_2_10002 = var_2_10002.New(0.2235294, 0.227451, 0.2352941, 1)
			end

			var_16_3.color = var_2_10002

			arg_15_2(arg_16_0)

			return
		end
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_15_0, var_15_1, var_15_2, var_1_10008)

	return
end

function var_0_1.initFilterPanel(arg_17_0)
	arg_17_0.filterBtns = {}
	Clone = var_1

	local var_17_0 = var_1(arg_17_0.filterConfig.all)

	table = var_1_10002

	var_1_10002.sort(var_17_0, function(arg_18_0, arg_18_1)
		return arg_17_0.filterConfig[arg_18_0].order < arg_17_0.filterConfig[arg_18_1].order
	end)

	local var_17_1 = 0

	ipairs = var_3

	for iter_17_0, iter_17_1 in var_3(var_17_0) do
		if arg_17_0.filterConfig[iter_17_1].is_view == 1 then
			var_17_1 = var_17_1 + 1
			cloneTplTo = var_9

			local var_17_2 = var_9(arg_17_0.filterTpl, arg_17_0.filterContainer)

			setText = var_1_10010

			var_1_10010(var_17_2:Find("Text"), var_8.name)

			var_1_10010 = arg_17_0.filterBtns
			var_1_10010[iter_17_1] = var_17_2

			arg_17_0:onSwitch(var_17_2, function(arg_19_0)
				if arg_19_0 then
					table = var_2_10001

					var_2_10001.insert(arg_17_0.filterData, iter_17_1)

					triggerToggle = var_1

					local var_19_0 = arg_17_0.selectedAllBtn

					var_2_10006 = arg_17_0

					var_1(var_19_0, var_4.isSelectedAll(var_2_10006))
				else
					local var_19_1 = arg_17_0

					_ = var_2_10002
					var_19_1.filterData = var_2_10002.reject(arg_17_0.filterData, function(arg_20_0)
						return iter_17_1 == arg_20_0
					end)

					local var_19_2 = arg_17_0

					if var_1.isSelectedNone(var_19_2) then
						triggerToggle = var_1

						var_1(arg_17_0.selectedAllBtn, true)

						local var_19_3 = arg_17_0.selectedAllBtn
						local var_19_4 = var_1.Find(var_19_3, "Text")
						local var_19_5 = var_1.GetComponent

						typeof = var_4
						Text = var_2_10006

						local var_19_6 = var_19_5(var_19_4, var_4(var_2_10006))

						Color = var_2
						var_19_6.color = var_2.New(1, 1, 1, 1)
					end
				end

				return
			end)

			setActive = var_1_10010

			var_1_10010(var_17_2:Find("line"), var_17_1 % 4 ~= 0)
		end
	end

	cloneTplTo = var_3
	arg_17_0.otherTF = var_3(arg_17_0.filterTpl, arg_17_0.filterContainer)
	setText = var_3

	local var_17_3 = arg_17_0.otherTF
	local var_17_4 = var_5.Find(var_17_3, "Text")

	i18n = var_6

	var_3(var_17_4, var_6("backyard_filter_tag_other"))

	local var_17_5 = arg_17_0.otherTF
	local var_17_6 = var_3.GetComponent

	typeof = var_6
	Toggle = var_8
	arg_17_0.otherTFToggle = var_17_6(var_17_5, var_6(var_8))
	arg_17_0.selectedOther = false

	arg_17_0:onSwitch(arg_17_0.otherTF, function(arg_21_0)
		local var_21_0 = arg_17_0

		var_21_0.selectedOther = arg_21_0

		if arg_21_0 then
			triggerToggle = var_21_0

			local var_21_1 = arg_17_0.selectedAllBtn

			var_2_10006 = arg_17_0

			var_21_0(var_21_1, var_4.isSelectedAll(var_2_10006))
		else
			local var_21_2 = arg_17_0

			if var_1.isSelectedNone(var_21_2) then
				triggerToggle = var_1

				var_1(arg_17_0.selectedAllBtn, true)

				local var_21_3 = arg_17_0.selectedAllBtn
				local var_21_4 = var_1.Find(var_21_3, "Text")
				local var_21_5 = var_1.GetComponent

				typeof = var_4
				Text = var_2_10006

				local var_21_6 = var_21_5(var_21_4, var_4(var_2_10006))

				Color = var_2_10002
				var_21_6.color = var_2_10002.New(0.2235294, 0.227451, 0.2352941, 1)
			end
		end

		return
	end)

	onToggle = var_3

	local var_17_7 = arg_17_0
	local var_17_8 = arg_17_0.selectedAllBtn

	local function var_17_9(arg_22_0)
		local var_22_0 = arg_17_0

		if var_1.isSelectedNone(var_22_0) then
			return
		end

		if arg_22_0 then
			_ = var_1

			var_1.each(arg_17_0.filterData, function(arg_23_0)
				triggerToggle = var_3_10001

				var_3_10001(arg_17_0.filterBtns[arg_23_0], false)

				return
			end)

			local var_22_1 = arg_17_0

			var_22_1.filterData = {}
			triggerToggle = var_22_1

			var_22_1(arg_17_0.otherTF, false)

			arg_17_0.selectedOther = false
		end

		local var_22_2 = arg_17_0.selectedAllBtn
		local var_22_3 = var_1.Find(var_22_2, "Text")
		local var_22_4 = var_1.GetComponent

		typeof = var_4
		Text = var_2_10006

		local var_22_5 = var_22_4(var_22_3, var_4(var_2_10006))

		if arg_22_0 then
			Color = var_2_10002

			if not var_2_10002.New(1, 1, 1, 1) then
				Color = var_2_10002
				var_2_10002 = var_2_10002.New(0.2235294, 0.227451, 0.2352941, 1)
			end

			var_22_5.color = var_2_10002

			return
		end
	end

	SFX_PANEL = var_8

	var_3(var_17_7, var_17_8, var_17_9, var_8)

	return
end

function var_0_1.isSelectedAll(arg_24_0)
	_ = var_1_10001

	local var_24_0 = var_1_10001.all

	_ = var_1_10003

	return var_24_0(var_1_10003.select(arg_24_0.filterConfig.all, function(arg_25_0)
		return arg_24_0.filterConfig[arg_25_0].is_view == 1
	end), function(arg_26_0)
		table = var_2_10001

		return var_2_10001.contains(arg_24_0.filterData, arg_26_0)
	end) and arg_24_0.otherTFToggle.isOn == true or arg_24_0:isSelectedNone()
end

function var_0_1.isSelectedNone(arg_27_0)
	return #arg_27_0.filterData == 0 and arg_27_0.otherTFToggle.isOn == false
end

function var_0_1.filter(arg_28_0)
	table = var_1_10001

	if var_1_10001.getCount(arg_28_0.furnitures) == 0 then
		return
	end

	local var_28_0 = {}

	ipairs = var_1_10002

	for iter_28_0, iter_28_1 in var_1_10002(arg_28_0.filterData) do
		local var_28_1

		if not arg_28_0.themes[iter_28_1] then
			var_28_1 = {}
		end

		ipairs = var_1_10008

		for iter_28_2, iter_28_3 in var_1_10008(var_28_1) do
			table = var_1_10013

			var_1_10013.insert(var_28_0, iter_28_3)
		end
	end

	local function var_28_2(arg_29_0)
		local var_29_0 = arg_29_0.id
		local var_29_1 = arg_29_0:getConfig("themeId") == 0
		local var_29_2

		if arg_28_0.selectedOther then
			var_29_2 = var_29_1
		end

		if #arg_28_0.filterData == arg_28_0.totalThemeCnt and var_29_1 then
			return false
		end

		if var_29_2 then
			return false
		end

		table = var_4

		return not var_4.contains(var_28_0, var_29_0)
	end

	if #var_28_0 ~= 0 or not not arg_28_0.selectedOther then
		for iter_28_4 = #arg_28_0.furnitures, 1, -1 do
			local var_28_3 = arg_28_0.furnitures[iter_28_4].id

			if var_28_2(arg_28_0.furnitures[iter_28_4]) then
				table = var_8

				var_8.remove(arg_28_0.furnitures, iter_28_4)
			end
		end
	end

	arg_28_0:sort(arg_28_0.furnitures)

	return
end

function var_0_1.SORT_BY_FUNC(arg_30_0, arg_30_1, arg_30_2, arg_30_3, arg_30_4)
	if arg_30_0[arg_30_2](arg_30_0) == arg_30_1[arg_30_2](arg_30_1) then
		return arg_30_4()
	elseif arg_30_3 == var_0_1.ORDER_MODE_ASC then
		return arg_30_0[arg_30_2](arg_30_0) < arg_30_1[arg_30_2](arg_30_1)
	else
		return arg_30_0[arg_30_2](arg_30_0) > arg_30_1[arg_30_2](arg_30_1)
	end

	return
end

function var_0_1.SORT_BY_CONFIG(arg_31_0, arg_31_1, arg_31_2, arg_31_3, arg_31_4)
	if arg_31_0:getConfig(arg_31_2) == arg_31_1:getConfig(arg_31_2) then
		return arg_31_4()
	elseif arg_31_3 == var_0_1.ORDER_MODE_ASC then
		return arg_31_0:getConfig(arg_31_2) < arg_31_1:getConfig(arg_31_2)
	else
		return arg_31_0:getConfig(arg_31_2) > arg_31_1:getConfig(arg_31_2)
	end

	return
end

function var_0_1.SortForDecorate(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_2[1]
	local var_32_1 = arg_32_2[2]
	local var_32_2 = arg_32_2[3]
	local var_32_3 = arg_32_2[4]
	local var_32_4 = arg_32_2[5]
	local var_32_5 = arg_32_2[6]

	function var_0_1.SortByDefault1(arg_33_0, arg_33_1)
		return arg_33_0.id < arg_33_1.id
	end

	function var_0_1.SortByDefault2(arg_34_0, arg_34_1)
		return arg_34_0.id > arg_34_1.id
	end

	local var_32_6

	if not var_32_5[arg_32_0.configId] then
		var_32_6 = 0
	end

	local var_32_7 = var_32_6 == arg_32_0.count and 1 or 0
	local var_32_8

	if not var_32_5[arg_32_1.configId] then
		var_32_8 = 0
	end

	if var_32_7 == (var_32_8 == arg_32_1.count and 1 or 0) then
		if var_32_0 == var_0_1.SORT_MODE.BY_DEFAULT then
			return var_0_1["SortByDefault" .. var_32_3](arg_32_0, arg_32_1)
		elseif var_32_0 == var_0_1.SORT_MODE.BY_FUNC then
			return var_0_1.SORT_BY_FUNC(arg_32_0, arg_32_1, var_32_1, var_32_3, function()
				return var_0_1["SortByDefault" .. var_32_3](arg_32_0, arg_32_1)
			end)
		elseif var_32_0 == var_0_1.SORT_MODE.BY_CONFIG then
			return var_0_1.SORT_BY_CONFIG(arg_32_0, arg_32_1, var_32_1, var_32_3, function()
				return var_0_1["SortByDefault" .. var_32_3](arg_32_0, arg_32_1)
			end)
		end
	else
		return var_10 < var_32_7
	end

	return
end

function var_0_1.sort(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0:GetConfigIdAndCntMapInAllFloor(arg_37_0.dorm)

	table = var_1_10003

	var_1_10003.sort(arg_37_1, function(arg_38_0, arg_38_1)
		return var_0_1.SortForDecorate(arg_38_0, arg_38_1, {
			arg_37_0.sortData[1],
			arg_37_0.sortData[2],
			arg_37_0.dorm,
			arg_37_0.orderMode,
			{},
			var_37_0
		})
	end)

	arg_37_0.furnitures = arg_37_1

	return
end

function var_0_1.GetConfigIdAndCntMapInAllFloor(arg_39_0, arg_39_1)
	local var_39_0 = {}

	pairs = var_1_10003

	for iter_39_0, iter_39_1 in var_1_10003(arg_39_1:GetThemeList()) do
		pairs = var_1_10008

		for iter_39_2, iter_39_3 in var_1_10008(iter_39_1:GetAllFurniture()) do
			var_39_0[iter_39_2] = iter_39_3
		end
	end

	local var_39_1 = {}

	pairs = var_4

	for iter_39_4, iter_39_5 in var_4(var_39_0) do
		if not var_39_1[iter_39_5.configId] then
			var_39_1[var_9] = 0
		end

		var_39_1[var_9] = var_39_1[var_9] + 1
	end

	return var_39_1
end

function var_0_1.Sort(arg_40_0)
	arg_40_0:sort(arg_40_0.furnitures)

	return
end

function var_0_1.Show(arg_41_0)
	setActive = var_1_10001

	var_1_10001(arg_41_0._go, true)

	return
end

function var_0_1.Hide(arg_42_0)
	setActive = var_1_10001

	var_1_10001(arg_42_0._go, false)

	if arg_42_0.onHideFunc then
		arg_42_0.onHideFunc()
	end

	return
end

function var_0_1.OnDestroy(arg_43_0)
	return
end

return var_0_1
