local var_0_0 = class("IslandShopExchangePage", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "IslandShopExchangeUI"
end

function var_0_0.Ctor(arg_2_0, arg_2_1, arg_2_2)
	var_0_0.super.Ctor(arg_2_0, arg_2_1, arg_2_2.event, arg_2_2.contextData)

	arg_2_0.viewComponent = arg_2_2

	return
end

function var_0_0.OnLoaded(arg_3_0)
	local var_3_0 = arg_3_0._tf:Find("adapt/left")

	setText(var_3_0:Find("tip"), i18n("island_quickselect_tip"))

	arg_3_0.allBtn = var_3_0:Find("btn_all")
	arg_3_0.allFlagTF = arg_3_0.allBtn:Find("flag")

	setText(arg_3_0.allBtn:Find("Text"), i18n("island_selectall"))

	arg_3_0.deleteBtn = var_3_0:Find("btn_delete")
	arg_3_0.scrollRect = var_3_0:Find("view"):GetComponent("LScrollRect")
	arg_3_0.emptyTF = var_3_0:Find("empty")

	local var_3_1 = arg_3_0._tf:Find("adapt/right")

	arg_3_0.itemNameTxt = var_3_1:Find("title/name"):GetComponent(typeof(Text))
	arg_3_0.itemTF = var_3_1:Find("bg_item/item")

	setText(var_3_1:Find("bg_count/Text"), i18n("island_exchange_own_count"))

	arg_3_0.itemOwnTxt = var_3_1:Find("bg_count/content/Text"):GetComponent(typeof(Text))
	arg_3_0.itemAddTxt = var_3_1:Find("bg_count/content/add"):GetComponent(typeof(Text))
	arg_3_0.exchangeBtn = var_3_1:Find("btn_exchange")

	setText(arg_3_0.exchangeBtn:Find("Text"), i18n("island_exchange_btn_text"))

	arg_3_0.blockTF = arg_3_0._tf:Find("block")
	arg_3_0.itemAnim = var_3_1:Find("bg_item"):GetComponent(typeof(Animation))
	arg_3_0.itemAnimEvent = var_3_1:Find("bg_item"):GetComponent(typeof(DftAniEvent))

	return
end

function var_0_0.OnInit(arg_4_0)
	onButton(arg_4_0, arg_4_0.allBtn, function(arg_5_0)
		if arg_4_0.selAllFlag or #arg_4_0.displays == 0 then
			return
		end

		arg_4_0:SelecteAll()

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.deleteBtn, function()
		arg_4_0:SetTotalCount()

		arg_4_0.itemAddTxt.text = ""

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.itemTF, function()
		arg_4_0.viewComponent:ShowMsgBox({
			title = i18n("island_word_desc"),
			type = IslandMsgBox.TYPE_COMMON_DROP_DESCRIBE,
			dropData = arg_4_0.showDropData
		})

		return
	end)
	arg_4_0.itemAnimEvent:SetTriggerEvent(function()
		arg_4_0:SendExchangeProto()

		return
	end)
	arg_4_0.itemAnimEvent:SetEndEvent(function()
		setActive(arg_4_0.blockTF, false)
		arg_4_0.itemAnim:Play("anim_IslandExchangeUI_Craft_loop")

		return
	end)
	onButton(arg_4_0, arg_4_0.exchangeBtn, function()
		if getProxy(IslandProxy):GetIsland():GetInventoryAgency():ExistAnyOverFlowItem() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_bag_max_tip"))

			return
		end

		arg_4_0.exchangeItems = arg_4_0:GetExchangeItems()

		if #arg_4_0.exchangeItems <= 0 then
			return
		end

		arg_4_0.viewComponent:ShowMsgBox({
			content = i18n("island_exchange_sure_tip"),
			onYes = function()
				arg_4_0.itemAnim:Play("anim_IslandExchangeUI_Craft")
				setActive(arg_4_0.blockTF, true)

				return
			end
		})

		return
	end, SFX_PANEL)

	function arg_4_0.scrollRect.onInitItem(arg_12_0)
		arg_4_0:OnInitItem(arg_12_0)

		return
	end

	function arg_4_0.scrollRect.onUpdateItem(arg_13_0, arg_13_1)
		arg_4_0:OnUpdateItem(arg_13_0, arg_13_1)

		return
	end

	arg_4_0.cards = {}

	return
end

function var_0_0.SendExchangeProto(arg_14_0)
	arg_14_0:emit(IslandMediator.EXCHANGE_ITME, arg_14_0.exchangeItems, arg_14_0.showItemId, arg_14_0.totalAddCnt)

	return
end

function var_0_0.Show(arg_15_0)
	var_0_0.super.Show(arg_15_0)

	arg_15_0.groupConfig = pg.island_exchange_group

	setActive(arg_15_0.blockTF, false)
	arg_15_0.itemAnim:Play("anim_IslandExchangeUI_Craft_loop")
	arg_15_0:OverlayPanel(arg_15_0._tf, {
		pbList = {
			arg_15_0._tf:Find("bg")
		}
	})

	return
end

function var_0_0.FlushGroup(arg_16_0, arg_16_1)
	local var_16_0

	if not arg_16_1 then
		::label_16_0::

		var_16_0 = arg_16_0.showGroupId or arg_16_0.groupConfig[arg_16_0.groupConfig.all[1]].exchange_group[1][2]
	end

	arg_16_0.showGroupId = var_16_0

	if arg_16_0:isShowing() then
		arg_16_0:SetTotalCount()
	end

	arg_16_0.itemNameTxt.text = pg.island_item_data_template[arg_16_0.showItemId].name
	arg_16_0.itemOwnTxt.text = getProxy(IslandProxy):GetIsland():GetInventoryAgency():GetOwnCount(arg_16_0.showItemId)
	arg_16_0.itemAddTxt.text = ""
	arg_16_0.showDropData = Drop.New({
		count = 0,
		type = DROP_TYPE_ISLAND_ITEM,
		id = arg_16_0.showItemId
	})

	updateIslandItem(arg_16_0.itemTF, arg_16_0.showDropData)

	return
end

function var_0_0.SetTotalCount(arg_17_0)
	arg_17_0.displays = arg_17_0:CollectDisplayItems()
	arg_17_0.values = {}

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.displays) do
		table.insert(arg_17_0.values, 0)
	end

	arg_17_0.scrollRect:SetTotalCount(#arg_17_0.displays, -1)
	setActive(arg_17_0.emptyTF, #arg_17_0.displays == 0)

	arg_17_0.selAllFlag = false

	setActive(arg_17_0.allFlagTF, arg_17_0.selAllFlag)

	return
end

function var_0_0.UpdateCount(arg_18_0)
	arg_18_0.totalAddCnt = 0

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.values) do
		arg_18_0.totalAddCnt = arg_18_0.totalAddCnt + arg_18_0.displays[iter_18_0].targetNum * iter_18_1
	end

	local var_18_0 = arg_18_0.itemAddTxt

	if arg_18_0.totalAddCnt > 0 then
		var_18_0.text = "+" .. arg_18_0.totalAddCnt or ""

		return
	end
end

function var_0_0.OnInitItem(arg_19_0, arg_19_1)
	local var_19_0 = IslandExchangeItemCard.New(arg_19_1)

	onButton(arg_19_0, var_19_0._go, function()
		arg_19_0:UpdateCardSel(var_19_0, 1)

		return
	end, SFX_PANEL)
	onButton(arg_19_0, var_19_0.reduceBtn, function()
		arg_19_0:UpdateCardSel(var_19_0, -1)

		return
	end, SFX_PANEL)
	onInputEndEdit(arg_19_0, var_19_0.valueInput, function(arg_22_0)
		local var_22_0 = table.indexof(arg_19_0.displays, var_19_0.item)

		if not var_22_0 then
			return
		end

		if not arg_22_0 or arg_22_0 == "" or not tonumber(arg_22_0) then
			-- block empty
		end

		arg_19_0:UpdateCardSel(var_19_0, tonumber(arg_22_0) - arg_19_0.values[var_22_0])

		return
	end)
	pressPersistTrigger(var_19_0.calcPanel, 0.5, function()
		arg_19_0:UpdateCardSel(var_19_0, 1)

		return
	end, nil, true, true, 0.1, SFX_PANEL)

	arg_19_0.cards[arg_19_1] = var_19_0

	return
end

function var_0_0.OnUpdateItem(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_0.cards[arg_24_2]

	if not arg_24_0.cards[arg_24_2] then
		arg_24_0:OnInitItem(arg_24_2)

		var_24_0 = arg_24_0.cards[arg_24_2]
	end

	if arg_24_0.displays[arg_24_1 + 1] then
		var_24_0:Update(arg_24_0.displays[arg_24_1 + 1], arg_24_0.values[arg_24_1 + 1])
	end

	return
end

function var_0_0.UpdateCardSel(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = table.indexof(arg_25_0.displays, arg_25_1.item)

	if not var_25_0 then
		return
	end

	arg_25_0.values[var_25_0] = math.max(0, math.min(arg_25_0.values[var_25_0] + arg_25_2, arg_25_1.item:GetCount()))

	arg_25_1:UpdateValue(arg_25_0.values[var_25_0])
	arg_25_0:UpdateCount()
	arg_25_0:CheckSelAllFlag()

	return
end

function var_0_0._IsSelAll(arg_26_0)
	for iter_26_0, iter_26_1 in ipairs(arg_26_0.values) do
		if iter_26_1 ~= arg_26_0.displays[iter_26_0]:GetCount() then
			return false
		end
	end

	return true
end

function var_0_0.CheckSelAllFlag(arg_27_0)
	arg_27_0.selAllFlag = arg_27_0:_IsSelAll()

	setActive(arg_27_0.allFlagTF, arg_27_0.selAllFlag)

	return
end

function var_0_0.SelecteAll(arg_28_0)
	arg_28_0.values = {}

	for iter_28_0, iter_28_1 in ipairs(arg_28_0.displays) do
		arg_28_0.values[iter_28_0] = iter_28_1:GetCount()
	end

	arg_28_0.scrollRect:SetTotalCount(#arg_28_0.displays, -1)
	arg_28_0:UpdateCount()

	arg_28_0.selAllFlag = true

	setActive(arg_28_0.allFlagTF, arg_28_0.selAllFlag)

	return
end

function var_0_0.CollectDisplayItems(arg_29_0)
	local var_29_0 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()

	arg_29_0.showExchangeIds = pg.island_exchange_template.get_id_list_by_group[arg_29_0.showGroupId]
	arg_29_0.showItemId = pg.island_exchange_template[arg_29_0.showExchangeIds[1]].target_item

	for iter_29_0, iter_29_1 in ipairs(arg_29_0.showExchangeIds) do
		local var_29_1 = var_29_0:GetItemById(pg.island_exchange_template[iter_29_1].origin_item)

		if var_29_1 then
			local var_29_2 = Clone(var_29_1)

			var_29_2.exchangeId = iter_29_1
			var_29_2.targetNum = pg.island_exchange_template[iter_29_1].target_num

			table.insert({}, var_29_2)
		end
	end

	return {}
end

function var_0_0.GetExchangeItems(arg_30_0)
	for iter_30_0, iter_30_1 in ipairs(arg_30_0.values) do
		if iter_30_1 > 0 then
			table.insert({}, {
				exchangeId = arg_30_0.displays[iter_30_0].exchangeId,
				itemId = arg_30_0.displays[iter_30_0].id,
				num = iter_30_1
			})
		end
	end

	return {}
end

function var_0_0.OnHide(arg_31_0)
	arg_31_0.itemAnim:Stop()
	setActive(arg_31_0.blockTF, false)
	arg_31_0:UnOverlayPanel(arg_31_0._tf, arg_31_0._parentTf)

	return
end

function var_0_0.OnDestroy(arg_32_0)
	arg_32_0:OnHide()
	ClearLScrollrect(arg_32_0.scrollRect)

	for iter_32_0, iter_32_1 in pairs(arg_32_0.cards) do
		iter_32_1:Dispose()
	end

	arg_32_0.cards = {}

	arg_32_0.itemAnimEvent:SetTriggerEvent(nil)
	arg_32_0.itemAnimEvent:SetEndEvent(nil)

	return
end

return var_0_0
