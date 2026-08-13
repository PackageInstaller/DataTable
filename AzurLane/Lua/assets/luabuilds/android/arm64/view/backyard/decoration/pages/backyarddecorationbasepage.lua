class = var_0_10000

local var_0_0 = "BackYardDecorationBasePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("....base.BaseSubView"))

function var_0_1.OnLoaded(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.scrollRect = var_1.GetComponent(var_1_0, "LScrollRect")

	return
end

function var_0_1.OnInit(arg_2_0)
	arg_2_0.cards = {}

	function arg_2_0.scrollRect.onInitItem(arg_3_0)
		local var_3_0 = arg_2_0

		var_1.OnInitItem(var_3_0, arg_3_0)

		return
	end

	function arg_2_0.scrollRect.onUpdateItem(arg_4_0, arg_4_1)
		local var_4_0 = arg_2_0

		var_2.OnUpdateItem(var_4_0, arg_4_0, arg_4_1)

		return
	end

	return
end

function var_0_1.SetUp(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_0:Show()

	arg_5_0.pageType = arg_5_1
	arg_5_0.dorm = arg_5_2
	arg_5_0.customTheme = arg_5_3
	arg_5_0.orderMode = arg_5_4

	arg_5_0:OnDisplayList()
	arg_5_0:UpdateFliterData()

	return
end

function var_0_1.Show(arg_6_0)
	setActiveViaLayer = var_1_10001

	var_1_10001(arg_6_0._tf, true)

	return
end

function var_0_1.Hide(arg_7_0)
	setActiveViaLayer = var_1_10001

	var_1_10001(arg_7_0._tf, false)

	return
end

function var_0_1.DormUpdated(arg_8_0, arg_8_1)
	arg_8_0.dorm = arg_8_1

	arg_8_0:UpdateFliterData()
	arg_8_0:OnDormUpdated()

	return
end

function var_0_1.FurnitureUpdated(arg_9_0, arg_9_1)
	arg_9_0:OnFurnitureUpdated(arg_9_1)

	return
end

function var_0_1.CustomThemeAdded(arg_10_0, arg_10_1)
	arg_10_0.customTheme[arg_10_1.id] = arg_10_1

	arg_10_0:CustomThemeUpdated(arg_10_0.customTheme)

	return
end

function var_0_1.CustomThemeDeleted(arg_11_0, arg_11_1)
	pairs = var_1_10002

	for iter_11_0, iter_11_1 in var_1_10002(arg_11_0.customTheme) do
		if iter_11_1.id == arg_11_1 then
			arg_11_0.customTheme[iter_11_0] = nil

			break
		end
	end

	arg_11_0:CustomThemeUpdated(arg_11_0.customTheme)

	return
end

function var_0_1.ThemeUpdated(arg_12_0)
	arg_12_0:OnThemeUpdated()

	return
end

function var_0_1.CustomThemeUpdated(arg_13_0, arg_13_1)
	arg_13_0.customTheme = arg_13_1

	arg_13_0:ThemeUpdated()

	return
end

function var_0_1.OrderModeUpdated(arg_14_0, arg_14_1)
	arg_14_0.orderMode = arg_14_1

	arg_14_0:UpdateFliterData()

	local var_14_0 = arg_14_0.contextData.filterPanel

	if var_2.GetLoaded(var_14_0) then
		local var_14_1 = arg_14_0.contextData.filterPanel

		var_2.Sort(var_14_1)

		local var_14_2 = arg_14_0.contextData.filterPanel
		local var_14_3 = var_2.GetFilterData(var_14_2)

		arg_14_0:OnFilterDone(var_14_3)
	else
		arg_14_0:OnOrderModeUpdated()
	end

	return
end

function var_0_1.UpdateFliterData(arg_15_0)
	local var_15_0 = arg_15_0.contextData.filterPanel

	var_1.SetDorm(var_15_0, arg_15_0.dorm)

	local var_15_1 = arg_15_0.contextData.filterPanel

	var_1.updateOrderMode(var_15_1, arg_15_0.orderMode)

	return
end

function var_0_1.ShowFilterPanel(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.contextData.filterPanel

	var_2.setFilterData(var_16_0, arg_16_0:GetDisplays())

	function arg_16_0.contextData.filterPanel.confirmFunc()
		local var_17_0 = arg_16_0.contextData.filterPanel.sortTxt

		if arg_16_1 then
			arg_16_1(var_17_0)
		end

		local var_17_1 = arg_16_0.contextData.filterPanel
		local var_17_2 = var_1.GetFilterData(var_17_1)
		local var_17_3 = arg_16_0

		var_2.OnFilterDone(var_17_3, var_17_2)

		return
	end

	local var_16_1 = arg_16_0.contextData.filterPanel

	var_2.ExecuteAction(var_16_1, "Show")

	return
end

function var_0_1.SearchKeyUpdated(arg_18_0, arg_18_1)
	arg_18_0.searchKey = arg_18_1

	arg_18_0:OnSearchKeyChanged()

	return
end

function var_0_1.OnInitItem(arg_19_0, arg_19_1)
	return
end

function var_0_1.OnUpdateItem(arg_20_0, arg_20_1, arg_20_2)
	return
end

function var_0_1.OnDisplayList(arg_21_0)
	return
end

function var_0_1.OnDormUpdated(arg_22_0)
	return
end

function var_0_1.OnFurnitureUpdated(arg_23_0, arg_23_1)
	return
end

function var_0_1.OnThemeUpdated(arg_24_0)
	return
end

function var_0_1.OnOrderModeUpdated(arg_25_0)
	return
end

function var_0_1.OnFilterDone(arg_26_0, arg_26_1)
	return
end

function var_0_1.GetDisplays(arg_27_0)
	return {}
end

function var_0_1.OnSearchKeyChanged(arg_28_0)
	return
end

function var_0_1.OnBackPressed(arg_29_0)
	return false
end

function var_0_1.OnApplyThemeBefore(arg_30_0)
	return
end

function var_0_1.OnApplyThemeAfter(arg_31_0, arg_31_1)
	return
end

return var_0_1
