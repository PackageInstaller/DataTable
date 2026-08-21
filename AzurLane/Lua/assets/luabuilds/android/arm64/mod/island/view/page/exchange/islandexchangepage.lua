local var_0_0 = class("IslandExchangePage", import("...base.IslandBasePage"))

function var_0_0.getUIName(arg_1_0)
	return "IslandExchangeUI"
end

function var_0_0.OnLoaded(arg_2_0)
	setText(arg_2_0._tf:Find("top/title/Text"), i18n("island_exchange_title"))
	setText(arg_2_0._tf:Find("top/title/Text/en"), i18n("island_exchange_title_en"))

	local var_2_0 = arg_2_0._tf:Find("adapt/toggles/content")

	arg_2_0.toggleUIList = UIItemList.New(var_2_0, var_2_0:Find("tpl"))

	local var_2_1 = arg_2_0._tf:Find("adapt/left")

	setText(var_2_1:Find("tip"), i18n("island_quickselect_tip"))

	arg_2_0.allBtn = var_2_1:Find("btn_all")
	arg_2_0.allFlagTF = arg_2_0.allBtn:Find("flag")

	setText(arg_2_0.allBtn:Find("Text"), i18n("island_selectall"))

	arg_2_0.deleteBtn = var_2_1:Find("btn_delete")
	arg_2_0.scrollRect = var_2_1:Find("view"):GetComponent("LScrollRect")
	arg_2_0.emptyTF = var_2_1:Find("empty")

	local var_2_2 = arg_2_0._tf:Find("adapt/right")

	arg_2_0.itemNameTxt = var_2_2:Find("title/name"):GetComponent(typeof(Text))
	arg_2_0.itemTF = var_2_2:Find("bg_item/item")

	setText(var_2_2:Find("bg_count/Text"), i18n("island_exchange_own_count"))

	arg_2_0.itemOwnTxt = var_2_2:Find("bg_count/content/Text"):GetComponent(typeof(Text))
	arg_2_0.itemAddTxt = var_2_2:Find("bg_count/content/add"):GetComponent(typeof(Text))
	arg_2_0.exchangeBtn = var_2_2:Find("btn_exchange")

	setText(arg_2_0.exchangeBtn:Find("Text"), i18n("island_exchange_btn_text"))

	arg_2_0.blockTF = arg_2_0._tf:Find("block")
	arg_2_0.itemAnim = var_2_2:Find("bg_item"):GetComponent(typeof(Animation))
	arg_2_0.itemAnimEvent = var_2_2:Find("bg_item"):GetComponent(typeof(DftAniEvent))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf:Find("top/back"), function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.allBtn, function(arg_5_0)
		if arg_3_0.selAllFlag or #arg_3_0.displays == 0 then
			return
		end

		arg_3_0:SelecteAll()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.deleteBtn, function()
		arg_3_0:SetTotalCount()

		arg_3_0.itemAddTxt.text = ""

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.itemTF, function()
		arg_3_0:ShowMsgBox({
			title = i18n("island_word_desc"),
			type = IslandMsgBox.TYPE_COMMON_DROP_DESCRIBE,
			dropData = arg_3_0.showDropData
		})

		return
	end)
	arg_3_0.itemAnimEvent:SetTriggerEvent(function()
		arg_3_0:SendExchangeProto()

		return
	end)
	arg_3_0.itemAnimEvent:SetEndEvent(function()
		setActive(arg_3_0.blockTF, false)
		arg_3_0.itemAnim:Play("anim_IslandExchangeUI_Craft_loop")

		return
	end)
	onButton(arg_3_0, arg_3_0.exchangeBtn, function()
		if getProxy(IslandProxy):GetIsland():GetInventoryAgency():ExistAnyOverFlowItem() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_bag_max_tip"))

			return
		end

		arg_3_0.exchangeItems = arg_3_0:GetExchangeItems()

		if #arg_3_0.exchangeItems <= 0 then
			return
		end

		arg_3_0:ShowMsgBox({
			content = i18n("island_exchange_sure_tip"),
			onYes = function()
				arg_3_0.itemAnim:Play("anim_IslandExchangeUI_Craft")
				setActive(arg_3_0.blockTF, true)

				return
			end
		})

		return
	end, SFX_PANEL)
	arg_3_0.toggleUIList:make(function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_0 == UIItemList.EventUpdate then
			arg_3_0:UpdateToggleItem(arg_12_1, arg_12_2)
		end

		return
	end)

	function arg_3_0.scrollRect.onInitItem(arg_13_0)
		arg_3_0:OnInitItem(arg_13_0)

		return
	end

	function arg_3_0.scrollRect.onUpdateItem(arg_14_0, arg_14_1)
		arg_3_0:OnUpdateItem(arg_14_0, arg_14_1)

		return
	end

	return
end

function var_0_0.SendExchangeProto(arg_15_0)
	arg_15_0:emit(IslandMediator.EXCHANGE_ITME, arg_15_0.exchangeItems, arg_15_0.showItemId, arg_15_0.totalAddCnt)

	return
end

function var_0_0.OnShow(arg_16_0, arg_16_1)
	arg_16_0.firstFlush = true
	arg_16_0.cards = {}
	arg_16_0.showIds = arg_16_1 or pg.island_exchange_group.all

	arg_16_0.toggleUIList:align(#arg_16_0.showIds)
	triggerToggle(arg_16_0.toggleUIList.container:GetChild(0):Find("title"), true)
	setActive(arg_16_0.blockTF, false)
	arg_16_0.itemAnim:Play("anim_IslandExchangeUI_Craft_loop")
	arg_16_0:BlurPanel()

	return
end

function var_0_0.AddListeners(arg_17_0)
	arg_17_0:AddListener(GAME.ISLAND_EXCHANGE_ITEM_DONE, arg_17_0.OnExchangeDone)

	return
end

function var_0_0.RemoveListeners(arg_18_0)
	arg_18_0:RemoveListener(GAME.ISLAND_EXCHANGE_ITEM_DONE, arg_18_0.OnExchangeDone)

	return
end

function var_0_0.OnExchangeDone(arg_19_0)
	arg_19_0:FlushGroup()

	return
end

function var_0_0.UpdateToggleItem(arg_20_0, arg_20_1, arg_20_2)
	setText(arg_20_2:Find("title/name"), pg.island_exchange_group[arg_20_0.showIds[arg_20_1 + 1]].text[1])
	setText(arg_20_2:Find("title/name/en"), pg.island_exchange_group[arg_20_0.showIds[arg_20_1 + 1]].text[2])
	GetImageSpriteFromAtlasAsync("island/islandshopicon", pg.island_exchange_group[arg_20_0.showIds[arg_20_1 + 1]].text[3], arg_20_2:Find("title/sel/icon"))
	onToggle(arg_20_0, arg_20_2:Find("title"), function(arg_21_0)
		if arg_21_0 then
			triggerToggle(arg_20_2:Find("list"):GetChild(0), true)
		end

		return
	end, SFX_PANEL)
	UIItemList.StaticAlign(arg_20_2:Find("list"), arg_20_2:Find("list/tpl"), #pg.island_exchange_group[arg_20_0.showIds[arg_20_1 + 1]].exchange_group, function(arg_22_0, arg_22_1, arg_22_2)
		if arg_22_0 == UIItemList.EventUpdate then
			local var_22_0 = arg_22_1 + 1
			local var_22_1 = var_0[arg_22_1 + 1][2]

			setText(arg_22_2:Find("name"), var_0[arg_22_1 + 1][1])
			setText(arg_22_2:Find("sel/name"), var_0[arg_22_1 + 1][1])
			setActive(arg_22_2:Find("line2"), var_22_0 ~= #var_0)
			onToggle(arg_20_0, arg_22_2, function(arg_23_0)
				if arg_23_0 then
					if not arg_20_0.firstFlush and arg_20_0.showGroupId and arg_20_0.showGroupId == var_22_1 then
						return
					end

					arg_20_0.firstFlush = false
					arg_20_0.showGroupId = var_22_1

					arg_20_0:FlushGroup()
				end

				return
			end, SFX_PANEL)
		end

		return
	end)

	return
end

function var_0_0.FlushGroup(arg_24_0)
	arg_24_0:SetTotalCount()

	arg_24_0.itemNameTxt.text = pg.island_item_data_template[arg_24_0.showItemId].name
	arg_24_0.itemOwnTxt.text = getProxy(IslandProxy):GetIsland():GetInventoryAgency():GetOwnCount(arg_24_0.showItemId)
	arg_24_0.itemAddTxt.text = ""
	arg_24_0.showDropData = Drop.New({
		count = 0,
		type = DROP_TYPE_ISLAND_ITEM,
		id = arg_24_0.showItemId
	})

	updateIslandItem(arg_24_0.itemTF, arg_24_0.showDropData)

	return
end

function var_0_0.SetTotalCount(arg_25_0)
	arg_25_0.displays = arg_25_0:CollectDisplayItems()
	arg_25_0.values = {}

	for iter_25_0, iter_25_1 in ipairs(arg_25_0.displays) do
		table.insert(arg_25_0.values, 0)
	end

	arg_25_0.scrollRect:SetTotalCount(#arg_25_0.displays, -1)
	setActive(arg_25_0.emptyTF, #arg_25_0.displays == 0)

	arg_25_0.selAllFlag = false

	setActive(arg_25_0.allFlagTF, arg_25_0.selAllFlag)

	return
end

function var_0_0.UpdateCount(arg_26_0)
	arg_26_0.totalAddCnt = 0

	for iter_26_0, iter_26_1 in ipairs(arg_26_0.values) do
		arg_26_0.totalAddCnt = arg_26_0.totalAddCnt + arg_26_0.displays[iter_26_0].targetNum * iter_26_1
	end

	local var_26_0 = arg_26_0.itemAddTxt

	if arg_26_0.totalAddCnt > 0 then
		var_26_0.text = "+" .. arg_26_0.totalAddCnt or ""

		return
	end
end

function var_0_0.OnInitItem(arg_27_0, arg_27_1)
	local var_27_0 = IslandExchangeItemCard.New(arg_27_1)

	onButton(arg_27_0, var_27_0._go, function()
		arg_27_0:UpdateCardSel(var_27_0, 1)

		return
	end, SFX_PANEL)
	onButton(arg_27_0, var_27_0.reduceBtn, function()
		arg_27_0:UpdateCardSel(var_27_0, -1)

		return
	end, SFX_PANEL)
	onInputEndEdit(arg_27_0, var_27_0.valueInput, function(arg_30_0)
		local var_30_0 = table.indexof(arg_27_0.displays, var_27_0.item)

		if not var_30_0 then
			return
		end

		if not arg_30_0 or arg_30_0 == "" or not tonumber(arg_30_0) then
			-- block empty
		end

		arg_27_0:UpdateCardSel(var_27_0, tonumber(arg_30_0) - arg_27_0.values[var_30_0])

		return
	end)
	pressPersistTrigger(var_27_0.calcPanel, 0.5, function()
		arg_27_0:UpdateCardSel(var_27_0, 1)

		return
	end, nil, true, true, 0.1, SFX_PANEL)

	arg_27_0.cards[arg_27_1] = var_27_0

	return
end

function var_0_0.OnUpdateItem(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_0.cards[arg_32_2]

	if not arg_32_0.cards[arg_32_2] then
		arg_32_0:OnInitItem(arg_32_2)

		var_32_0 = arg_32_0.cards[arg_32_2]
	end

	if arg_32_0.displays[arg_32_1 + 1] then
		var_32_0:Update(arg_32_0.displays[arg_32_1 + 1], arg_32_0.values[arg_32_1 + 1])
	end

	return
end

function var_0_0.UpdateCardSel(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = table.indexof(arg_33_0.displays, arg_33_1.item)

	if not var_33_0 then
		return
	end

	arg_33_0.values[var_33_0] = math.max(0, math.min(arg_33_0.values[var_33_0] + arg_33_2, arg_33_1.item:GetCount()))

	arg_33_1:UpdateValue(arg_33_0.values[var_33_0])
	arg_33_0:UpdateCount()
	arg_33_0:CheckSelAllFlag()

	return
end

function var_0_0._IsSelAll(arg_34_0)
	for iter_34_0, iter_34_1 in ipairs(arg_34_0.values) do
		if iter_34_1 ~= arg_34_0.displays[iter_34_0]:GetCount() then
			return false
		end
	end

	return true
end

function var_0_0.CheckSelAllFlag(arg_35_0)
	arg_35_0.selAllFlag = arg_35_0:_IsSelAll()

	setActive(arg_35_0.allFlagTF, arg_35_0.selAllFlag)

	return
end

function var_0_0.SelecteAll(arg_36_0)
	arg_36_0.values = {}

	for iter_36_0, iter_36_1 in ipairs(arg_36_0.displays) do
		arg_36_0.values[iter_36_0] = iter_36_1:GetCount()
	end

	arg_36_0.scrollRect:SetTotalCount(#arg_36_0.displays, -1)
	arg_36_0:UpdateCount()

	arg_36_0.selAllFlag = true

	setActive(arg_36_0.allFlagTF, arg_36_0.selAllFlag)

	return
end

function var_0_0.CollectDisplayItems(arg_37_0)
	local var_37_0 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()

	arg_37_0.showExchangeIds = pg.island_exchange_template.get_id_list_by_group[arg_37_0.showGroupId]
	arg_37_0.showItemId = pg.island_exchange_template[arg_37_0.showExchangeIds[1]].target_item

	for iter_37_0, iter_37_1 in ipairs(arg_37_0.showExchangeIds) do
		local var_37_1 = var_37_0:GetItemById(pg.island_exchange_template[iter_37_1].origin_item)

		if var_37_1 then
			local var_37_2 = Clone(var_37_1)

			var_37_2.exchangeId = iter_37_1
			var_37_2.targetNum = pg.island_exchange_template[iter_37_1].target_num

			table.insert({}, var_37_2)
		end
	end

	return {}
end

function var_0_0.GetExchangeItems(arg_38_0)
	for iter_38_0, iter_38_1 in ipairs(arg_38_0.values) do
		if iter_38_1 > 0 then
			table.insert({}, {
				exchangeId = arg_38_0.displays[iter_38_0].exchangeId,
				itemId = arg_38_0.displays[iter_38_0].id,
				num = iter_38_1
			})
		end
	end

	return {}
end

function var_0_0.OnHide(arg_39_0)
	arg_39_0.itemAnim:Stop()
	arg_39_0:UnBlurPanel()

	return
end

function var_0_0.OnDisable(arg_40_0)
	arg_40_0:OnHide()

	return
end

function var_0_0.OnDestroy(arg_41_0)
	arg_41_0:OnHide()
	ClearLScrollrect(arg_41_0.scrollRect)

	for iter_41_0, iter_41_1 in pairs(arg_41_0.cards) do
		iter_41_1:Dispose()
	end

	arg_41_0.cards = {}

	arg_41_0.itemAnimEvent:SetTriggerEvent(nil)
	arg_41_0.itemAnimEvent:SetEndEvent(nil)

	return
end

return var_0_0
