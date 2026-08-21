local var_0_0 = class("BackYardDecorationFilterPanel", import("....base.BaseSubView"))

var_0_0.SORT_MODE = {
	BY_FUNC = 2,
	BY_CONFIG = 3,
	BY_DEFAULT = 1
}
var_0_0.SORT_TAG = {
	{
		{
			1,
			"default"
		},
		i18n("backyard_sort_tag_default")
	},
	{
		{
			2,
			"sortPriceFunc"
		},
		i18n("backyard_sort_tag_price")
	},
	{
		{
			3,
			"comfortable"
		},
		i18n("backyard_sort_tag_comfortable")
	},
	{
		{
			2,
			"sortSizeFunc"
		},
		i18n("backyard_sort_tag_size")
	}
}
var_0_0.ORDER_MODE_ASC = 1
var_0_0.ORDER_MODE_DASC = 2

function var_0_0.getUIName(arg_1_0)
	return "BackYardIndexUI"
end

function var_0_0.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	var_0_0.super.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)

	arg_2_0.filterConfig = pg.backyard_theme_template
	arg_2_0.sortData = var_0_0.SORT_TAG[1][1]
	arg_2_0.sortTxt = var_0_0.SORT_TAG[1][2]
	arg_2_0.filterData = _.select(arg_2_0.filterConfig.all, function(arg_3_0)
		return arg_2_0.filterConfig[arg_3_0].is_view == 1
	end)
	arg_2_0.totalThemeCnt = #arg_2_0.filterData
	arg_2_0.themes = pg.furniture_data_template.get_id_list_by_themeId

	return
end

function var_0_0.OnLoaded(arg_4_0)
	arg_4_0.sortTpl = arg_4_0._tf:Find("bg/sort_tpl")
	arg_4_0.filterTpl = arg_4_0._tf:Find("bg/filter_tpl")
	arg_4_0.sortContainer = arg_4_0._tf:Find("bg/frame/sorts/sort_container")
	arg_4_0.filterContainer = arg_4_0._tf:Find("bg/frame/filters/rect_view/conent/theme_panel")
	arg_4_0.selectedAllBtn = arg_4_0._tf:Find("bg/frame/filters/rect_view/conent/all_panel/sort_tpl")
	arg_4_0.close = arg_4_0._tf:Find("bg/close")

	setText(arg_4_0._tf:Find("bg/frame/title"), i18n("indexsort_sort"))
	setText(arg_4_0._tf:Find("bg/frame/title_filter"), i18n("indexsort_index"))
	setText(arg_4_0.selectedAllBtn:Find("Text"), i18n("index_all"))
	setText(arg_4_0._tf:Find("bg/frame/confirm_btn/Text"), i18n("word_ok"))
	setText(arg_4_0._tf:Find("bg/title"), i18n("courtyard_label_filter"))

	return
end

function var_0_0.setFilterData(arg_5_0, arg_5_1)
	arg_5_0.furnitures = arg_5_1 or {}

	return
end

function var_0_0.GetFilterData(arg_6_0)
	return arg_6_0.furnitures
end

function var_0_0.SetDorm(arg_7_0, arg_7_1)
	arg_7_0.dorm = arg_7_1

	return
end

function var_0_0.updateOrderMode(arg_8_0, arg_8_1)
	arg_8_0.orderMode = arg_8_1 or var_0_0.ORDER_MODE_ASC

	return
end

function var_0_0.OnInit(arg_9_0)
	onButton(arg_9_0, arg_9_0._tf:Find("bg/frame/confirm_btn"), function()
		arg_9_0:filter()
		arg_9_0:Hide()

		if arg_9_0.confirmFunc then
			arg_9_0.confirmFunc()
		end

		return
	end, SFX_PANEL)
	onButton(arg_9_0, arg_9_0._go, function()
		arg_9_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_9_0, arg_9_0.close, function()
		arg_9_0:Hide()

		return
	end, SFX_PANEL)
	arg_9_0:initSortPanel()
	arg_9_0:initFilterPanel()
	triggerToggle(arg_9_0.selectedAllBtn, true)
	triggerToggle(arg_9_0.sortBtns[1], true)

	return
end

function var_0_0.initSortPanel(arg_13_0)
	arg_13_0.sortBtns = {}

	for iter_13_0, iter_13_1 in pairs(var_0_0.SORT_TAG) do
		local var_13_0 = cloneTplTo(arg_13_0.sortTpl, arg_13_0.sortContainer)

		setText(var_13_0:Find("Text"), iter_13_1[2])

		arg_13_0.sortBtns[iter_13_0] = var_13_0

		arg_13_0:onSwitch(var_13_0, function(arg_14_0)
			if arg_14_0 then
				arg_13_0.sortData = iter_13_1[1]
				arg_13_0.sortTxt = iter_13_1[2]
			end

			return
		end)
	end

	return
end

function var_0_0.onSwitch(arg_15_0, arg_15_1, arg_15_2)
	onToggle(arg_15_0, arg_15_1, function(arg_16_0)
		local var_16_0 = arg_15_1:Find("Text"):GetComponent(typeof(Text))

		var_16_0.color = arg_16_0 and Color.New(1, 1, 1, 1) or Color.New(0.2235294, 0.227451, 0.2352941, 1)

		arg_15_2(arg_16_0)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.initFilterPanel(arg_17_0)
	arg_17_0.filterBtns = {}

	local var_17_0 = Clone(arg_17_0.filterConfig.all)

	table.sort(var_17_0, function(arg_18_0, arg_18_1)
		return arg_17_0.filterConfig[arg_18_0].order < arg_17_0.filterConfig[arg_18_1].order
	end)

	local var_17_1 = 0

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		if arg_17_0.filterConfig[iter_17_1].is_view == 1 then
			var_17_1 = var_17_1 + 1

			local var_17_2 = cloneTplTo(arg_17_0.filterTpl, arg_17_0.filterContainer)

			setText(var_17_2:Find("Text"), arg_17_0.filterConfig[iter_17_1].name)

			arg_17_0.filterBtns[iter_17_1] = var_17_2

			arg_17_0:onSwitch(var_17_2, function(arg_19_0)
				if arg_19_0 then
					table.insert(arg_17_0.filterData, iter_17_1)
					triggerToggle(arg_17_0.selectedAllBtn, arg_17_0:isSelectedAll())
				else
					arg_17_0.filterData = _.reject(arg_17_0.filterData, function(arg_20_0)
						return iter_17_1 == arg_20_0
					end)

					if arg_17_0:isSelectedNone() then
						triggerToggle(arg_17_0.selectedAllBtn, true)

						arg_17_0.selectedAllBtn:Find("Text"):GetComponent(typeof(Text)).color = Color.New(1, 1, 1, 1)
					end
				end

				return
			end)
			setActive(var_17_2:Find("line"), var_17_1 % 4 ~= 0)
		end
	end

	arg_17_0.otherTF = cloneTplTo(arg_17_0.filterTpl, arg_17_0.filterContainer)

	setText(arg_17_0.otherTF:Find("Text"), i18n("backyard_filter_tag_other"))

	arg_17_0.otherTFToggle = arg_17_0.otherTF:GetComponent(typeof(Toggle))
	arg_17_0.selectedOther = false

	arg_17_0:onSwitch(arg_17_0.otherTF, function(arg_21_0)
		arg_17_0.selectedOther = arg_21_0

		if arg_21_0 then
			triggerToggle(arg_17_0.selectedAllBtn, arg_17_0:isSelectedAll())
		elseif arg_17_0:isSelectedNone() then
			triggerToggle(arg_17_0.selectedAllBtn, true)

			arg_17_0.selectedAllBtn:Find("Text"):GetComponent(typeof(Text)).color = Color.New(0.2235294, 0.227451, 0.2352941, 1)
		end

		return
	end)
	onToggle(arg_17_0, arg_17_0.selectedAllBtn, function(arg_22_0)
		if arg_17_0:isSelectedNone() then
			return
		end

		if arg_22_0 then
			_.each(arg_17_0.filterData, function(arg_23_0)
				triggerToggle(arg_17_0.filterBtns[arg_23_0], false)

				return
			end)

			arg_17_0.filterData = {}

			triggerToggle(arg_17_0.otherTF, false)

			arg_17_0.selectedOther = false
		end

		local var_22_0 = arg_17_0.selectedAllBtn:Find("Text"):GetComponent(typeof(Text))

		var_22_0.color = arg_22_0 and Color.New(1, 1, 1, 1) or Color.New(0.2235294, 0.227451, 0.2352941, 1)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.isSelectedAll(arg_24_0)
	return _.all(_.select(arg_24_0.filterConfig.all, function(arg_25_0)
		return arg_24_0.filterConfig[arg_25_0].is_view == 1
	end), function(arg_26_0)
		return table.contains(arg_24_0.filterData, arg_26_0)
	end) and arg_24_0.otherTFToggle.isOn == true or arg_24_0:isSelectedNone()
end

function var_0_0.isSelectedNone(arg_27_0)
	return #arg_27_0.filterData == 0 and arg_27_0.otherTFToggle.isOn == false
end

function var_0_0.filter(arg_28_0)
	if table.getCount(arg_28_0.furnitures) == 0 then
		return
	end

	local var_28_0 = {}

	for iter_28_0, iter_28_1 in ipairs(arg_28_0.filterData) do
		local var_28_1 = arg_28_0.themes[iter_28_1] or {}

		for iter_28_2, iter_28_3 in ipairs(var_28_1) do
			table.insert(var_28_0, iter_28_3)
		end
	end

	if #var_28_0 ~= 0 or not not arg_28_0.selectedOther then
		for iter_28_4 = #arg_28_0.furnitures, 1, -1 do
			if (function(arg_29_0)
				local var_29_0 = arg_29_0:getConfig("themeId") == 0
				local var_29_1 = arg_28_0.selectedOther and var_29_0

				if #arg_28_0.filterData == arg_28_0.totalThemeCnt and var_29_0 then
					return false
				end

				if var_29_1 then
					return false
				end

				return not table.contains(var_28_0, arg_29_0.id)
			end)(arg_28_0.furnitures[iter_28_4]) then
				table.remove(arg_28_0.furnitures, iter_28_4)
			end
		end
	end

	arg_28_0:sort(arg_28_0.furnitures)

	return
end

function var_0_0.SORT_BY_FUNC(arg_30_0, arg_30_1, arg_30_2, arg_30_3, arg_30_4)
	if arg_30_0[arg_30_2](arg_30_0) == arg_30_1[arg_30_2](arg_30_1) then
		return arg_30_4()
	elseif arg_30_3 == var_0_0.ORDER_MODE_ASC then
		return arg_30_0[arg_30_2](arg_30_0) < arg_30_1[arg_30_2](arg_30_1)
	else
		return arg_30_0[arg_30_2](arg_30_0) > arg_30_1[arg_30_2](arg_30_1)
	end

	return
end

function var_0_0.SORT_BY_CONFIG(arg_31_0, arg_31_1, arg_31_2, arg_31_3, arg_31_4)
	if arg_31_0:getConfig(arg_31_2) == arg_31_1:getConfig(arg_31_2) then
		return arg_31_4()
	elseif arg_31_3 == var_0_0.ORDER_MODE_ASC then
		return arg_31_0:getConfig(arg_31_2) < arg_31_1:getConfig(arg_31_2)
	else
		return arg_31_0:getConfig(arg_31_2) > arg_31_1:getConfig(arg_31_2)
	end

	return
end

function var_0_0.SortForDecorate(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_2[2]
	local var_32_2 = arg_32_2[4]
	local var_32_4 = arg_32_2[6]

	function var_0_0.SortByDefault1(arg_33_0, arg_33_1)
		return arg_33_0.id < arg_33_1.id
	end

	function var_0_0.SortByDefault2(arg_34_0, arg_34_1)
		return arg_34_0.id > arg_34_1.id
	end

	local var_32_5 = var_32_4[arg_32_0.configId] or 0
	local var_32_6 = var_32_5 == arg_32_0.count and 1 or 0
	local var_32_7 = var_32_4[arg_32_1.configId] or 0
	local var_32_8 = var_32_7 == arg_32_1.count and 1 or 0

	if var_32_6 == (var_32_7 == arg_32_1.count and 1 or 0) then
		if arg_32_2[1] == var_0_0.SORT_MODE.BY_DEFAULT then
			return var_0_0["SortByDefault" .. var_32_2](arg_32_0, arg_32_1)
		elseif arg_32_2[1] == var_0_0.SORT_MODE.BY_FUNC then
			return var_0_0.SORT_BY_FUNC(arg_32_0, arg_32_1, var_32_0, var_32_2, function()
				return var_0_0["SortByDefault" .. var_32_2](arg_32_0, arg_32_1)
			end)
		elseif arg_32_2[1] == var_0_0.SORT_MODE.BY_CONFIG then
			return var_0_0.SORT_BY_CONFIG(arg_32_0, arg_32_1, var_32_0, var_32_2, function()
				return var_0_0["SortByDefault" .. var_32_2](arg_32_0, arg_32_1)
			end)
		end
	else
		return var_32_8 < var_32_6
	end

	return
end

function var_0_0.sort(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0:GetConfigIdAndCntMapInAllFloor(arg_37_0.dorm)

	table.sort(arg_37_1, function(arg_38_0, arg_38_1)
		return var_0_0.SortForDecorate(arg_38_0, arg_38_1, {
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

function var_0_0.GetConfigIdAndCntMapInAllFloor(arg_39_0, arg_39_1)
	for iter_39_0, iter_39_1 in pairs(arg_39_1:GetThemeList()) do
		for iter_39_2, iter_39_3 in pairs(iter_39_1:GetAllFurniture()) do
			({})[iter_39_2] = iter_39_3
		end
	end

	for iter_39_4, iter_39_5 in pairs({}) do
		if not ({})[iter_39_5.configId] then
			({})[iter_39_5.configId] = 0
		end

		;({})[iter_39_5.configId] = ({})[iter_39_5.configId] + 1
	end

	return {}
end

function var_0_0.Sort(arg_40_0)
	arg_40_0:sort(arg_40_0.furnitures)

	return
end

function var_0_0.Show(arg_41_0)
	setActive(arg_41_0._go, true)

	return
end

function var_0_0.Hide(arg_42_0)
	setActive(arg_42_0._go, false)

	if arg_42_0.onHideFunc then
		arg_42_0.onHideFunc()
	end

	return
end

function var_0_0.OnDestroy(arg_43_0)
	return
end

return var_0_0
