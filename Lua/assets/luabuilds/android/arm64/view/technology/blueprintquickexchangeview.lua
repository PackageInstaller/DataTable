local var_0_0 = class("BlueprintQuickExchangeView", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "BlueprintQuickExchangeUI"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0.rtBg = arg_2_0._tf:Find("bg")

	onButton(arg_2_0, arg_2_0.rtBg, function()
		arg_2_0:Hide()

		return
	end, SFX_CANCEL)

	arg_2_0.rtPreview = arg_2_0._tf:Find("window/preview/got")
	arg_2_0.rtEmpty = arg_2_0.rtPreview:Find("empty")

	setText(arg_2_0.rtEmpty:Find("Text"), i18n("blueprint_exchange_empty_tip"))

	local var_2_0 = arg_2_0.rtPreview:Find("list")

	arg_2_0.itemList = UIItemList.New(var_2_0, var_2_0:Find("item"))

	arg_2_0.itemList:make(function(arg_4_0, arg_4_1, arg_4_2)
		arg_4_1 = arg_4_1 + 1

		if arg_4_0 == UIItemList.EventUpdate then
			local var_4_0 = arg_2_0.displayList[arg_4_1]
			local var_4_1 = arg_2_0.awardList[arg_4_1].count

			updateDrop(arg_4_2:Find("icon"), arg_2_0.displayList[arg_4_1])
			onButton(arg_2_0, arg_4_2:Find("icon"), function()
				arg_2_0:emit(BaseUI.ON_DROP, var_4_0)

				return
			end, SFX_PANEL)
			setText(arg_4_2:Find("calc/value"), arg_2_0.countList[arg_4_1])
			setScrollText(arg_4_2:Find("name/Text"), arg_2_0.displayList[arg_4_1]:getConfig("name"))
			setText(arg_4_2:Find("kc"), i18n("tec_tip_material_stock") .. ":" .. arg_2_0.displayList[arg_4_1].count)
			pressPersistTrigger(arg_4_2:Find("calc/plus"), 0.5, function()
				if var_4_0.count > arg_2_0.countList[arg_4_1] and arg_2_0.count + var_4_1 <= arg_2_0.need then
					arg_2_0.countList[arg_4_1] = arg_2_0.countList[arg_4_1] + 1

					setText(arg_4_2:Find("calc/value"), arg_2_0.countList[arg_4_1])

					arg_2_0.count = arg_2_0.count + var_4_1

					setText(arg_2_0.rtExchange:Find("bg/count"), setColorStr(arg_2_0.count, "#FFEC6E") .. "/" .. arg_2_0.need)
				end

				return
			end, nil, true, true, 0.1, SFX_PANEL)
			pressPersistTrigger(arg_4_2:Find("calc/minus"), 0.5, function()
				if arg_2_0.countList[arg_4_1] > 0 then
					arg_2_0.countList[arg_4_1] = arg_2_0.countList[arg_4_1] - 1

					setText(arg_4_2:Find("calc/value"), arg_2_0.countList[arg_4_1])

					arg_2_0.count = arg_2_0.count - var_4_1

					setText(arg_2_0.rtExchange:Find("bg/count"), setColorStr(arg_2_0.count, "#FFEC6E") .. "/" .. arg_2_0.need)
				end

				return
			end, nil, true, true, 0.1, SFX_PANEL)
			onButton(arg_2_0, arg_4_2:Find("calc/max"), function()
				if var_4_0.count > arg_2_0.countList[arg_4_1] and arg_2_0.count + var_4_1 <= arg_2_0.need then
					local var_8_0 = math.min(math.floor((arg_2_0.need - arg_2_0.count + var_4_1 - 1) / var_4_1), var_4_0.count - arg_2_0.countList[arg_4_1])

					arg_2_0.countList[arg_4_1] = arg_2_0.countList[arg_4_1] + var_8_0

					setText(arg_4_2:Find("calc/value"), arg_2_0.countList[arg_4_1])

					arg_2_0.count = arg_2_0.count + var_4_1 * var_8_0

					setText(arg_2_0.rtExchange:Find("bg/count"), setColorStr(arg_2_0.count, "#FFEC6E") .. "/" .. arg_2_0.need)
				end

				return
			end)
		end

		return
	end)
	setText(arg_2_0._tf:Find("window/cancel_button/label"), i18n("word_cancel"))
	onButton(arg_2_0, arg_2_0._tf:Find("window/cancel_button"), function()
		arg_2_0:Hide()

		return
	end, SFX_CANCEL)
	onButton(arg_2_0, arg_2_0._tf:Find("window/confirm_button"), function()
		if arg_2_0.count <= 0 then
			return
		end

		local var_10_0 = {}

		if arg_2_0.isSwitch and not arg_2_0.blueprintVO:IsFate() then
			table.insert(var_10_0, function(arg_11_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("blueprint_lab_exchange_fate_unlock"),
					onYes = arg_11_0
				})

				return
			end)
		end

		seriesAsync(var_10_0, function()
			for iter_12_0, iter_12_1 in ipairs(arg_2_0.displayList) do
				if arg_2_0.countList[iter_12_0] > 0 then
					table.insert({}, {
						id = iter_12_1.id,
						count = arg_2_0.countList[iter_12_0],
						arg = Item.getConfigData(iter_12_1.id).usage_arg[arg_2_0.awardList[iter_12_0].index]
					})
				end
			end

			arg_2_0:emit(ShipBluePrintMediator.QUICK_EXCHAGE_BLUEPRINT, {})
			arg_2_0:Hide()

			return
		end)

		return
	end, SFX_CANCEL)

	arg_2_0.rtResult = arg_2_0._tf:Find("window/result")
	arg_2_0.rtTarget = arg_2_0.rtResult:Find("target")
	arg_2_0.rtExchange = arg_2_0.rtResult:Find("exchange")
	arg_2_0.fate = arg_2_0.rtResult:Find("fate")
	arg_2_0.fateText = arg_2_0.fate:Find("Text")

	setText(arg_2_0.rtExchange:Find("bg/title"), i18n("blueprint_exchange_select_display"))

	arg_2_0.toggleSwitch = arg_2_0.rtResult:Find("switch")

	setText(arg_2_0.toggleSwitch:Find("front/Text_off"), i18n("show_fate_demand_count"))
	setText(arg_2_0.toggleSwitch:Find("front/Text_on"), i18n("show_design_demand_count"))
	onToggle(arg_2_0, arg_2_0.toggleSwitch, function(arg_13_0)
		arg_2_0.isSwitch = arg_13_0

		arg_2_0:UpdateResult()
		setActive(arg_2_0.fate, arg_2_0.isSwitch)

		return
	end)

	return
end

function var_0_0.Show(arg_14_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_14_0._tf)
	setActive(arg_14_0._tf, true)

	return
end

function var_0_0.Hide(arg_15_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_15_0._tf, arg_15_0._parentTf)
	setActive(arg_15_0._tf, false)

	return
end

function var_0_0.UpdateBlueprint(arg_16_0, arg_16_1)
	arg_16_0.blueprintVO = arg_16_1

	local var_16_0 = Drop.New({
		type = DROP_TYPE_ITEM,
		id = arg_16_1:getItemId()
	})

	changeToScrollText(arg_16_0.rtResult:Find("title/Text"), var_16_0:getName())

	arg_16_0.displayList = {}
	arg_16_0.awardList = {}

	local var_16_1 = getProxy(BagProxy)

	for iter_16_0, iter_16_1 in ipairs(pg.gameset.general_blueprint_list.description) do
		local var_16_2 = var_16_1:getItemCountById(iter_16_1)

		if var_16_2 > 0 then
			local var_16_3
			local var_16_4 = Drop.New({
				type = DROP_TYPE_ITEM,
				id = iter_16_1
			})

			for iter_16_2, iter_16_3 in ipairs(var_16_4:getConfig("display_icon")) do
				if iter_16_3[1] == DROP_TYPE_ITEM and iter_16_3[2] == var_16_0.id then
					var_16_3 = {
						index = iter_16_2,
						count = iter_16_3[3]
					}
				end
			end

			if var_16_3 then
				table.insert(arg_16_0.displayList, {
					type = DROP_TYPE_ITEM,
					id = iter_16_1,
					count = var_16_2
				})
				table.insert(arg_16_0.awardList, var_16_3)
			end
		end
	end

	setActive(arg_16_0.rtEmpty, #arg_16_0.displayList == 0)
	setActive(arg_16_0.itemList.container, #arg_16_0.displayList > 0)
	updateDrop(arg_16_0.rtResult:Find("target/IconTpl"), var_16_0)
	GetImageSpriteFromAtlasAsync("ui/fragresolveui_atlas", "bg_" .. ItemRarity.Rarity2Print(var_16_0:getConfig("rarity")), arg_16_0.rtResult:Find("target/bg"))

	arg_16_0.countList = underscore.map(arg_16_0.displayList, function(arg_17_0)
		return 0
	end)
	arg_16_0.count = 0

	arg_16_0.itemList:align(#arg_16_0.displayList)
	triggerToggle(arg_16_0.toggleSwitch, arg_16_1:canFateSimulation())

	local var_16_5 = arg_16_1:IsFate() and i18n("blueprint_lab_fate_unlock") or i18n("blueprint_lab_fate_lock")

	setText(arg_16_0.fateText, var_16_5)

	return
end

function var_0_0.UpdateResult(arg_18_0)
	arg_18_0.bagProxy = arg_18_0.bagProxy or getProxy(BagProxy)

	local var_18_0 = arg_18_0.isSwitch and arg_18_0.blueprintVO:getFateMaxLeftOver() or 0

	arg_18_0.need = math.max(arg_18_0.blueprintVO:getUseageMaxItem() + var_18_0 - arg_18_0.bagProxy:getItemCountById(arg_18_0.blueprintVO:getItemId()), 0)

	local var_18_1 = #arg_18_0.displayList

	while var_18_1 > 0 and arg_18_0.count > arg_18_0.need do
		if arg_18_0.countList[var_18_1] > 0 then
			local var_18_2 = math.floor((arg_18_0.count - arg_18_0.need + arg_18_0.awardList[var_18_1].count - 1) / arg_18_0.awardList[var_18_1].count)
			local var_18_3

			if var_18_2 > arg_18_0.countList[var_18_1] then
				arg_18_0.count = arg_18_0.count - arg_18_0.awardList[var_18_1].count * arg_18_0.countList[var_18_1]
				arg_18_0.countList[var_18_1] = 0
			else
				arg_18_0.count = arg_18_0.count - arg_18_0.awardList[var_18_1].count * var_18_2
				arg_18_0.countList[var_18_1] = arg_18_0.countList[var_18_1] - var_18_2
				var_18_3 = arg_18_0.itemList.container:GetChild(var_18_1 - 1)
			end

			setText(var_18_3:Find("calc/value"), arg_18_0.countList[var_18_1])
		end

		var_18_1 = var_18_1 - 1
	end

	setText(arg_18_0.rtExchange:Find("bg/count"), setColorStr(arg_18_0.count, "#FFEC6E") .. "/" .. arg_18_0.need)

	return
end

return var_0_0
