local var_0_0 = class("FragResolvePanel", BaseSubPanel)

function var_0_0.getUIName(arg_1_0)
	return "FragResolveUI"
end

local var_0_1 = {
	"control",
	"resolve"
}

function var_0_0.OnInit(arg_2_0)
	arg_2_0.bagProxy = getProxy(BagProxy)
	arg_2_0.technologyProxy = getProxy(TechnologyProxy)
	arg_2_0.toggles = {}

	for iter_2_0, iter_2_1 in ipairs(var_0_1) do
		arg_2_0[iter_2_1 .. "Panel"] = arg_2_0._tf:Find(iter_2_1)

		local var_2_0 = arg_2_0._tf:Find("toggle_controll/" .. iter_2_1)

		arg_2_0.toggles[iter_2_1] = var_2_0

		onToggle(arg_2_0, var_2_0, function(arg_3_0)
			arg_2_0["Reset" .. iter_2_1](arg_2_0)

			return
		end, SFX_PANEL)
	end

	onButton(arg_2_0, arg_2_0._tf:Find("bg"), function()
		arg_2_0:Back()

		return
	end, SFX_PANEL)

	local var_2_1 = arg_2_0.controlPanel:Find("got/empty/Text")

	setText(arg_2_0.controlPanel:Find("allMax/txt"), i18n("onebutton_max_tip"))

	local var_2_2 = arg_2_0._tf:Find("control/condition/text")
	local var_2_3 = arg_2_0.resolvePanel:Find("cancel_button/label")

	if PLATFORM_CODE == PLATFORM_US then
		setTextEN(var_2_2, i18n("fenjie_lantu_tip"))
		setTextEN(var_2_1, i18n("fragresolve_empty_tip"))
	else
		setText(var_2_2, i18n("fenjie_lantu_tip"))
		setText(var_2_1, i18n("fragresolve_empty_tip"))
	end

	setText(var_2_3, i18n("msgbox_text_cancel"))

	var_0_0.keepFateTog = arg_2_0._tf:Find("control/condition/keep_tog")

	setText(arg_2_0.keepFateTog:Find("label"), i18n("keep_fate_tip"))

	var_0_0.keepFateState = not getProxy(PlayerProxy):getData():GetCommonFlag(SHOW_DONT_KEEP_FATE_ITEM)
	GetComponent(arg_2_0.keepFateTog, typeof(Toggle)).isOn = var_0_0.keepFateState

	onToggle(arg_2_0, arg_2_0.keepFateTog, function(arg_5_0)
		var_0_0.keepFateState = arg_5_0

		arg_2_0:emit(NewShopMainMediator.SET_PLAYER_FLAG, SHOW_DONT_KEEP_FATE_ITEM, not arg_5_0)
		arg_2_0:Trigger("control")

		return
	end)
	arg_2_0:Trigger("control")

	return
end

function var_0_0.OnShow(arg_6_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_6_0._tf)

	return
end

function var_0_0.OnHide(arg_7_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_7_0._tf)

	return
end

function var_0_0.Reset(arg_8_0)
	if arg_8_0.resolveItems then
		table.clear(arg_8_0.resolveItems)
	end

	return
end

function var_0_0.Resetcontrol(arg_9_0)
	arg_9_0.blueprintItems = arg_9_0.GetAllBluePrintStrengthenItems()

	local var_9_0 = arg_9_0.blueprintItems
	local var_9_2 = arg_9_0.controlPanel:Find("got/list")

	setActive(arg_9_0.controlPanel:Find("got/empty"), #arg_9_0.blueprintItems <= 0)
	setActive(var_9_2, #var_9_0 > 0)

	if #var_9_0 <= 0 then
		arg_9_0:Updatecontrol()

		return
	end

	local var_9_3 = {}
	local var_9_4 = arg_9_0.resolveItems or {}

	for iter_9_0, iter_9_1 in ipairs(var_9_4) do
		var_9_3[iter_9_1.id] = iter_9_1
	end

	UIItemList.StaticAlign(var_9_2, var_9_2:Find("item"), #var_9_0, function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventUpdate then
			local var_10_0 = var_9_0[arg_10_1 + 1]

			updateDrop(arg_10_2:Find("icon"), var_9_0[arg_10_1 + 1])

			if var_9_3[var_10_0.id] then
				local var_10_2 = var_9_3[var_10_0.id].curCount or 0

				var_10_0.curCount = var_10_1(var_10_2, 0, var_10_0.maxCount)

				onButton(arg_9_0, arg_10_2:Find("icon/icon_bg"), function()
					arg_9_0:emit(BaseUI.ON_DROP, var_10_0)

					return
				end, SFX_PANEL)

				local var_10_3 = arg_10_2:Find("count")

				onButton(arg_9_0, var_10_3:Find("max"), function()
					if var_10_0.curCount ~= var_10_0.maxCount then
						var_10_0.curCount = var_10_0.maxCount

						arg_9_0:Updatecontrol()
					end

					return
				end)
				pressPersistTrigger(var_10_3:Find("number_panel/left"), 0.5, function(arg_13_0)
					if var_10_0.curCount <= 0 then
						arg_13_0()

						return
					end

					var_10_0.curCount = var_10_0.curCount - 1

					arg_9_0:Updatecontrol()

					return
				end, nil, true, true, 0.1, SFX_PANEL)
				pressPersistTrigger(var_10_3:Find("number_panel/right"), 0.5, function(arg_14_0)
					if var_10_0.curCount >= var_10_0.maxCount then
						arg_14_0()

						return
					end

					var_10_0.curCount = var_10_0.curCount + 1

					arg_9_0:Updatecontrol()

					return
				end, nil, true, true, 0.1, SFX_PANEL)

				return
			end
		end
	end)
	onButton(arg_9_0, var_9_1:Find("button_1"), function()
		for iter_15_0, iter_15_1 in ipairs(arg_9_0.blueprintItems) do
			if iter_15_1.curCount > 0 then
				local var_15_0 = Clone(iter_15_1)

				var_15_0.count = iter_15_1.curCount

				table.insert({}, var_15_0)
			end
		end

		if #{} > 0 then
			arg_9_0.resolveItems = {}

			triggerToggle(arg_9_0.toggles.resolve, true)
		end

		return
	end, SFX_PANEL)
	onButton(arg_9_0, var_9_1:Find("allMax"), function()
		for iter_16_0 = 1, #var_9_0 do
			if var_9_0[iter_16_0].curCount ~= var_9_0[iter_16_0].maxCount then
				var_9_0[iter_16_0].curCount = var_9_0[iter_16_0].maxCount
			end

			arg_9_0:Updatecontrol()
		end

		return
	end, SFX_PANEL)
	arg_9_0:Updatecontrol()

	return
end

function var_0_0.Updatecontrol(arg_17_0)
	local var_17_0 = arg_17_0.controlPanel:Find("got/list")
	local var_17_1 = arg_17_0.blueprintItems
	local var_17_2 = 0

	UIItemList.StaticAlign(var_17_0, var_17_0:Find("item"), #arg_17_0.blueprintItems, function(arg_18_0, arg_18_1, arg_18_2)
		if arg_18_0 == UIItemList.EventUpdate then
			setText(arg_18_2:Find("count"):Find("number_panel/value"), var_17_1[arg_18_1 + 1].curCount)

			var_17_2 = var_17_2 + var_17_1[arg_18_1 + 1].curCount
		end

		return
	end)

	local var_17_3 = arg_17_0.controlPanel:Find("button_1")

	setButtonEnabled(var_17_3, var_17_2 > 0)
	setGray(var_17_3, var_17_2 <= 0)

	local var_17_4 = arg_17_0.controlPanel:Find("allMax")

	setGray(var_17_4, not var_17_1 or #var_17_1 == 0)
	setButtonEnabled(var_17_4, var_17_1 and #var_17_1 > 0)

	return
end

function var_0_0.Resetresolve(arg_19_0)
	local var_19_0 = arg_19_0.resolvePanel:Find("preview/got/list")
	local var_19_1 = arg_19_0.resolvePanel:Find("result/got/list")
	local var_19_2 = arg_19_0.resolveItems

	UIItemList.StaticAlign(var_19_0, var_19_0:Find("item"), #arg_19_0.resolveItems, function(arg_20_0, arg_20_1, arg_20_2)
		if arg_20_0 == UIItemList.EventUpdate then
			local var_20_0 = var_19_2[arg_20_1 + 1]

			updateDrop(arg_20_2:Find("icon"), var_19_2[arg_20_1 + 1])
			onButton(arg_19_0, arg_20_2:Find("icon/icon_bg"), function()
				arg_19_0:emit(BaseUI.ON_DROP, var_20_0)

				return
			end, SFX_PANEL)
			setText(arg_20_2:Find("name_panel/name"), var_19_2[arg_20_1 + 1]:getConfig("name"))
			setText(arg_20_2:Find("name_panel/number"), "x " .. var_19_2[arg_20_1 + 1].curCount)
		end

		return
	end)

	local var_19_3 = {}

	for iter_19_0, iter_19_1 in pairs(arg_19_0.resolveItems) do
		local var_19_5 = Item.getConfigData(iter_19_1.id)

		assert(var_19_5, "Can't find the price " .. iter_19_1.id)

		local var_19_6 = ({})[var_19_5.price[1]]

		if not ({})[var_19_5.price[1]] then
			var_19_6 = 0
		end

		;({})[var_19_5.price[1]] = var_19_6 + var_19_5.price[2] * iter_19_1.count
	end

	for iter_19_2, iter_19_3 in pairs({}) do
		table.insert({}, {
			type = DROP_TYPE_RESOURCE,
			id = iter_19_2,
			count = iter_19_3
		})
	end

	UIItemList.StaticAlign(var_19_1, var_19_1:Find("item"), #{}, function(arg_22_0, arg_22_1, arg_22_2)
		if arg_22_0 == UIItemList.EventUpdate then
			local var_22_0 = var_19_3[arg_22_1 + 1]

			updateDrop(arg_22_2:Find("icon"), var_19_3[arg_22_1 + 1])
			onButton(arg_19_0, arg_22_2:Find("icon/icon_bg"), function()
				arg_19_0:emit(BaseUI.ON_DROP, var_22_0)

				return
			end, SFX_PANEL)
			setText(arg_22_2:Find("name_panel/name"), var_19_3[arg_22_1 + 1]:getConfig("name"))
			setText(arg_22_2:Find("name_panel/number"), "x " .. var_19_3[arg_22_1 + 1].count)
		end

		return
	end)
	onButton(arg_19_0, arg_19_0.resolvePanel:Find("cancel_button"), function()
		arg_19_0:Back()

		return
	end)
	onButton(arg_19_0, arg_19_0.resolvePanel:Find("destroy_button"), function()
		arg_19_0:emit(NewShopMainMediator.SELL_BLUEPRINT, arg_19_0.resolveItems)

		return
	end)

	return
end

function var_0_0.GetAllBluePrintStrengthenItems()
	local var_26_0 = getProxy(TechnologyProxy)
	local var_26_1 = getProxy(BagProxy)

	for iter_26_0, iter_26_1 in ipairs(pg.ship_data_blueprint.all) do
		local var_26_2 = var_26_0:getBluePrintById(iter_26_1)

		if var_26_2:isMaxLevel() then
			local var_26_3 = var_26_1:getItemById(pg.ship_data_blueprint[iter_26_1].strengthen_item)

			if var_26_3 then
				local var_26_4 = var_26_0:getBluePrintById(var_26_0:GetBlueprint4Item(pg.ship_data_blueprint[iter_26_1].strengthen_item))
				local var_26_5 = var_26_3.count

				if var_26_3 and var_26_3.count > 0 and var_0_0.keepFateState then
					var_26_5 = var_26_3.count - var_26_4:getFateMaxLeftOver()
					var_26_5 = var_26_5 < 0 and 0 or var_26_5
				end

				table.insert({}, Drop.New({
					id = var_26_3.id,
					type = DROP_TYPE_ITEM,
					count = var_26_3.count,
					maxCount = var_26_5
				}))
			end
		end
	end

	return {}
end

function var_0_0.Trigger(arg_27_0, arg_27_1)
	if arg_27_0.toggles[arg_27_1] then
		arg_27_0.buffer:Show()
		triggerToggle(arg_27_0.toggles[arg_27_1], true)
	end

	return
end

function var_0_0.Back(arg_28_0)
	if getToggleState(arg_28_0.toggles.resolve) then
		triggerToggle(arg_28_0.toggles.control, true)
	elseif getToggleState(arg_28_0.toggles.control) then
		arg_28_0:Hide()
	end

	return
end

return var_0_0
