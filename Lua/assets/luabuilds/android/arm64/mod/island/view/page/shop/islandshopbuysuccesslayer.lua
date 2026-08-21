local var_0_0 = class("IslandShopBuySuccessLayer", import("...base.IslandBasePage"))

function var_0_0.getUIName(arg_1_0)
	return "IslandShopBuySuccessUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.awardList = UIItemList.New(arg_2_0._tf:Find("awards"), arg_2_0._tf:Find("awards/item"))

	setText(arg_2_0._tf:Find("tip/text"), i18n("island_3Dshop_close"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf:Find("award_window"), function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf:Find("tip"), function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.SetUp(arg_6_0, arg_6_1)
	arg_6_0.awardList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			local var_7_0 = arg_6_1[arg_7_1 + 1]

			updateCustomDrop(arg_7_2:Find("IslandItemTpl"), arg_6_1[arg_7_1 + 1], {
				style = "island"
			})
			setActive(arg_7_2:Find("split"), var_7_0.type == VIRTUAL_DROP_TYPE_ISLAND_SEASON_PT)
		end

		return
	end)
	arg_6_0.awardList:align(#arg_6_1)

	return
end

function var_0_0.OnShow(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0:BlurPanel(arg_8_0._tf)

	local var_8_0 = arg_8_1.awards or {}
	local var_8_1 = arg_8_1.drops or {}
	local var_8_2 = table.mergeArray(var_8_0, var_8_1)

	table.sort(var_8_2, CompareFuncs({
		function(arg_9_0)
			return arg_9_0.type == VIRTUAL_DROP_TYPE_ISLAND_SEASON_PT and 0 or 1
		end
	}))
	arg_8_0:SetUp(var_8_2)

	arg_8_0.callback = arg_8_2
	arg_8_0.active = true

	return
end

function var_0_0.OnHide(arg_10_0)
	arg_10_0:UnOverlayPanel(arg_10_0._tf, arg_10_0._parentTf)

	if arg_10_0.active then
		arg_10_0.active = false

		if arg_10_0.callback then
			arg_10_0.callback()
		end
	end

	return
end

function var_0_0.OnDestroy(arg_11_0)
	return
end

return var_0_0
