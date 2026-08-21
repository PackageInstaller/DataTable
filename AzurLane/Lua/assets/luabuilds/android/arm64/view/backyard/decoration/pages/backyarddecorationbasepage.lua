local var_0_0 = class("BackYardDecorationBasePage", import("....base.BaseSubView"))

function var_0_0.OnLoaded(arg_1_0)
	arg_1_0.scrollRect = arg_1_0._tf:GetComponent("LScrollRect")

	return
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0.cards = {}

	function arg_2_0.scrollRect.onInitItem(arg_3_0)
		arg_2_0:OnInitItem(arg_3_0)

		return
	end

	function arg_2_0.scrollRect.onUpdateItem(arg_4_0, arg_4_1)
		arg_2_0:OnUpdateItem(arg_4_0, arg_4_1)

		return
	end

	return
end

function var_0_0.SetUp(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_0:Show()

	arg_5_0.pageType = arg_5_1
	arg_5_0.dorm = arg_5_2
	arg_5_0.customTheme = arg_5_3
	arg_5_0.orderMode = arg_5_4

	arg_5_0:OnDisplayList()
	arg_5_0:UpdateFliterData()

	return
end

function var_0_0.Show(arg_6_0)
	setActiveViaLayer(arg_6_0._tf, true)

	return
end

function var_0_0.Hide(arg_7_0)
	setActiveViaLayer(arg_7_0._tf, false)

	return
end

function var_0_0.DormUpdated(arg_8_0, arg_8_1)
	arg_8_0.dorm = arg_8_1

	arg_8_0:UpdateFliterData()
	arg_8_0:OnDormUpdated()

	return
end

function var_0_0.FurnitureUpdated(arg_9_0, arg_9_1)
	arg_9_0:OnFurnitureUpdated(arg_9_1)

	return
end

function var_0_0.CustomThemeAdded(arg_10_0, arg_10_1)
	arg_10_0.customTheme[arg_10_1.id] = arg_10_1

	arg_10_0:CustomThemeUpdated(arg_10_0.customTheme)

	return
end

function var_0_0.CustomThemeDeleted(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in pairs(arg_11_0.customTheme) do
		if iter_11_1.id == arg_11_1 then
			arg_11_0.customTheme[iter_11_0] = nil

			break
		end
	end

	arg_11_0:CustomThemeUpdated(arg_11_0.customTheme)

	return
end

function var_0_0.ThemeUpdated(arg_12_0)
	arg_12_0:OnThemeUpdated()

	return
end

function var_0_0.CustomThemeUpdated(arg_13_0, arg_13_1)
	arg_13_0.customTheme = arg_13_1

	arg_13_0:ThemeUpdated()

	return
end

function var_0_0.OrderModeUpdated(arg_14_0, arg_14_1)
	arg_14_0.orderMode = arg_14_1

	arg_14_0:UpdateFliterData()

	if arg_14_0.contextData.filterPanel:GetLoaded() then
		arg_14_0.contextData.filterPanel:Sort()
		arg_14_0:OnFilterDone((arg_14_0.contextData.filterPanel:GetFilterData()))
	else
		arg_14_0:OnOrderModeUpdated()
	end

	return
end

function var_0_0.UpdateFliterData(arg_15_0)
	arg_15_0.contextData.filterPanel:SetDorm(arg_15_0.dorm)
	arg_15_0.contextData.filterPanel:updateOrderMode(arg_15_0.orderMode)

	return
end

function var_0_0.ShowFilterPanel(arg_16_0, arg_16_1)
	arg_16_0.contextData.filterPanel:setFilterData(arg_16_0:GetDisplays())

	function arg_16_0.contextData.filterPanel.confirmFunc()
		if arg_16_1 then
			arg_16_1(arg_16_0.contextData.filterPanel.sortTxt)
		end

		arg_16_0:OnFilterDone((arg_16_0.contextData.filterPanel:GetFilterData()))

		return
	end

	arg_16_0.contextData.filterPanel:ExecuteAction("Show")

	return
end

function var_0_0.SearchKeyUpdated(arg_18_0, arg_18_1)
	arg_18_0.searchKey = arg_18_1

	arg_18_0:OnSearchKeyChanged()

	return
end

function var_0_0.OnInitItem(arg_19_0, arg_19_1)
	return
end

function var_0_0.OnUpdateItem(arg_20_0, arg_20_1, arg_20_2)
	return
end

function var_0_0.OnDisplayList(arg_21_0)
	return
end

function var_0_0.OnDormUpdated(arg_22_0)
	return
end

function var_0_0.OnFurnitureUpdated(arg_23_0, arg_23_1)
	return
end

function var_0_0.OnThemeUpdated(arg_24_0)
	return
end

function var_0_0.OnOrderModeUpdated(arg_25_0)
	return
end

function var_0_0.OnFilterDone(arg_26_0, arg_26_1)
	return
end

function var_0_0.GetDisplays(arg_27_0)
	return {}
end

function var_0_0.OnSearchKeyChanged(arg_28_0)
	return
end

function var_0_0.OnBackPressed(arg_29_0)
	return false
end

function var_0_0.OnApplyThemeBefore(arg_30_0)
	return
end

function var_0_0.OnApplyThemeAfter(arg_31_0, arg_31_1)
	return
end

return var_0_0
