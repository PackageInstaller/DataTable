local var_0_0 = class("IslandMsgBoxSingleMaterialWindow", import(".IslandMsgBoxSingleItemWindow"))

function var_0_0.getUIName(arg_1_0)
	return "IslandCommonMsgBoxWithSingleMaterial"
end

function var_0_0.OnLoaded(arg_2_0)
	var_0_0.super.super.OnLoaded(arg_2_0)

	arg_2_0.itemTr = arg_2_0._tf:Find("IslandItemTpl")
	arg_2_0.nameTxt = arg_2_0._tf:Find("name"):GetComponent(typeof(Text))
	arg_2_0.ownTxt = arg_2_0._tf:Find("own"):GetComponent(typeof(Text))
	arg_2_0.uiItemList = UIItemList.New(arg_2_0._tf:Find("list"), arg_2_0._tf:Find("list/tpl"))

	setText(arg_2_0._tf:Find("label/Text"), i18n("island_get_way"))

	arg_2_0.valueInput = arg_2_0._tf:Find("calc/value/InputField")
	arg_2_0.addBtn = arg_2_0._tf:Find("calc/add")
	arg_2_0.reduceBtn = arg_2_0._tf:Find("calc/reduce")
	arg_2_0.sellBtn = arg_2_0._tf:Find("calc/sell_btn")
	arg_2_0.priceTxt = arg_2_0._tf:Find("calc/sell_btn/price/Text"):GetComponent(typeof(Text))

	LoadImageSpriteAsync("island/" .. getIslandSeasonPtInfo().icon, arg_2_0._tf:Find("calc/sell_btn/price/res"))
	setText(arg_2_0._tf:Find("calc/sell_btn/Text"), i18n("island_word_convert"))

	return
end

function var_0_0.OnShow(arg_3_0)
	var_0_0.super.OnShow(arg_3_0)
	setActive(arg_3_0._tf:Find("label"), false)
	onButton(arg_3_0, arg_3_0.addBtn, function()
		arg_3_0:UpdateValue(arg_3_0.value + 1)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.reduceBtn, function()
		arg_3_0:UpdateValue(arg_3_0.value - 1)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.sellBtn, function()
		arg_3_0:Hide()

		if _IslandCore then
			_IslandCore:GetView():NotifiyIsland(ISLAND_EX_EVT.SHOW_MSG, {
				content = i18n("island_season_window_transformtip"),
				onYes = function()
					arg_3_0:emit(IslandMediator.ON_CONVERT_SEASON_PT, {
						{
							id = arg_3_0.item.id,
							num = arg_3_0.value
						}
					})

					return
				end
			})
		end

		return
	end, SFX_PANEL)
	onInputEndEdit(arg_3_0, arg_3_0.valueInput, function(arg_8_0)
		if not arg_8_0 or arg_8_0 == "" or not tonumber(arg_8_0) then
			-- block empty
		end

		arg_3_0:UpdateValue((tonumber(arg_8_0)))

		return
	end)
	arg_3_0:bind(GAME.ISLAND_CONVERT_SEASON_PT_DONE, function()
		arg_3_0:FlushCalc(arg_3_0.item.id)

		return
	end)
	arg_3_0:FlushCalc(arg_3_0.settings.itemId)

	return
end

function var_0_0.FlushCalc(arg_10_0, arg_10_1)
	local var_10_0 = getProxy(IslandProxy):GetIsland():GetInventoryAgency():GetItemById(arg_10_1)

	var_10_0 = var_10_0 or IslandItem.New({
		id = arg_10_1
	})
	arg_10_0.item = var_10_0
	arg_10_0.value = 1

	arg_10_0:UpdateValue(arg_10_0.value)

	return
end

function var_0_0.UpdateValue(arg_11_0, arg_11_1)
	arg_11_0.value = math.max(1, math.min(arg_11_1, arg_11_0.item:GetCount()))
	arg_11_0.priceTxt.text = "x" .. arg_11_0.item:GetConvertPt() * arg_11_0.value

	setInputText(arg_11_0.valueInput, arg_11_0.value)

	return
end

return var_0_0
