local var_0_0 = class("IslandInventoryPage", import("...base.IslandBasePage"))
local var_0_1 = 101
local var_0_2 = 102
local var_0_3 = 103
local var_0_4 = false

var_0_0.INVENTORY_TYPE_OVERFLOW = 100
var_0_0.INVENTORY_TYPE_COMMON = 101
var_0_0.MODE_VIEW = 0
var_0_0.MODE_EDIT = 1

function var_0_0.getUIName(arg_1_0)
	return "IslandInventoryUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.closeBtn = arg_2_0._tf:Find("window/close_btn")
	arg_2_0.filterBtn = arg_2_0._tf:Find("window/sort_panel/index")
	arg_2_0.orderBtn = arg_2_0._tf:Find("window/sort_panel/sort")
	arg_2_0.orderTxt = arg_2_0._tf:Find("window/sort_panel/sort/Text"):GetComponent(typeof(Text))
	arg_2_0.orderArr = arg_2_0._tf:Find("window/sort_panel/sort/arr")
	arg_2_0.toggles = {
		[var_0_0.INVENTORY_TYPE_OVERFLOW] = arg_2_0._tf:Find("window/toggles/0"),
		[IslandItem.TYPE_MATERIAL] = arg_2_0._tf:Find("window/toggles/1"),
		[IslandItem.TYPE_PROP] = arg_2_0._tf:Find("window/toggles/2"),
		[IslandItem.TYPE_SPECIAL_PROP] = arg_2_0._tf:Find("window/toggles/3")
	}
	arg_2_0.indexDatas = {
		[var_0_0.INVENTORY_TYPE_OVERFLOW] = IslandInventoryIndexData.New(var_0_1),
		[IslandItem.TYPE_MATERIAL] = IslandInventoryIndexData.New(var_0_1),
		[IslandItem.TYPE_PROP] = IslandInventoryIndexData.New(var_0_2),
		[IslandItem.TYPE_SPECIAL_PROP] = IslandInventoryIndexData.New(var_0_3)
	}
	arg_2_0.capacityTxt = arg_2_0._tf:Find("window/upgrade/Text"):GetComponent(typeof(Text))
	arg_2_0.upgradeBtn = arg_2_0._tf:Find("window/upgrade")
	arg_2_0.upgradeProg = arg_2_0._tf:Find("window/upgrade/bar")
	arg_2_0.batchSellBtn = arg_2_0._tf:Find("window/batch_sell")
	arg_2_0.sellPanel = arg_2_0._tf:Find("window/sell_panel")

	setText(arg_2_0.sellPanel:Find("tip"), i18n("island_quickselect_tip"))

	arg_2_0.sortPaenl = arg_2_0._tf:Find("window/sort_panel")
	arg_2_0.sellBtn = arg_2_0._tf:Find("window/sell_panel/batch_sell_1")
	arg_2_0.sellCancelBtn = arg_2_0._tf:Find("window/sell_panel/cancel")
	arg_2_0.sellAllBtn = arg_2_0._tf:Find("window/sell_panel/all")

	setActive(arg_2_0.sellAllBtn, var_0_4)

	arg_2_0.sellAllFlagTF = arg_2_0.sellAllBtn:Find("flag")
	arg_2_0.sellPriceTxt = arg_2_0._tf:Find("window/sell_panel/price/Text"):GetComponent(typeof(Text))

	LoadImageSpriteAsync("island/" .. getIslandSeasonPtInfo().icon, arg_2_0._tf:Find("window/sell_panel/price/Text/icon"))

	arg_2_0.oneKeyPanel = arg_2_0._tf:Find("window/one_key_panel")
	arg_2_0.onekeyBtn = arg_2_0._tf:Find("window/one_key_panel/fetch_btn")
	arg_2_0.scrollRect = arg_2_0._tf:Find("window/item_scrollview"):GetComponent("LScrollRect")

	setText(arg_2_0._tf:Find("window/title/Text"), i18n("island_bag_title"))
	setText(arg_2_0._tf:Find("window/batch_sell/Text"), i18n("island_batch_covert"))
	setText(arg_2_0._tf:Find("window/sell_panel/price/label"), i18n("island_total_price"))
	setText(arg_2_0._tf:Find("window/sell_panel/cancel/Text"), i18n("word_cancel"))
	setText(arg_2_0._tf:Find("window/sell_panel/all/Text"), i18n("island_selectall"))
	setText(arg_2_0._tf:Find("window/sell_panel/batch_sell_1/Text"), i18n("island_batch_covert"))
	setText(arg_2_0._tf:Find("window/one_key_panel/fetch_btn/Text"), i18n("mail_get_oneclick"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.upgradeBtn, function()
		arg_3_0:OpenPage(IslandInventoryUpgradePage)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.batchSellBtn, function()
		arg_3_0.mode = var_0_0.MODE_EDIT

		arg_3_0:SetTotalCount()
		arg_3_0:UpdateStyle()

		arg_3_0.sellPriceTxt.text = "x 0"

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.sellCancelBtn, function()
		arg_3_0.mode = var_0_0.MODE_VIEW

		arg_3_0:SetTotalCount()
		arg_3_0:UpdateStyle()

		for iter_8_0, iter_8_1 in ipairs(arg_3_0.values) do
			arg_3_0.values[iter_8_0] = 0
		end

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.sellAllBtn, function(arg_9_0)
		if not var_0_4 then
			return
		end

		if arg_3_0.selAllFlag then
			arg_3_0:UpdataUnselAll()
		else
			arg_3_0:UpdataSelAll()
		end

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.sellBtn, function()
		if #arg_3_0:GetSellItems() <= 0 then
			return
		end

		arg_3_0:ShowMsgBox({
			content = i18n("island_season_window_transformtip"),
			onYes = function()
				if arg_3_0.tagType == var_0_0.INVENTORY_TYPE_OVERFLOW then
					arg_3_0:emit(IslandMediator.ON_CONVERT_SEASON_PT_4_OVERFLOW, var_0)
				else
					arg_3_0:emit(IslandMediator.ON_CONVERT_SEASON_PT, var_0)
				end

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.onekeyBtn, function()
		if arg_3_0.tagType ~= var_0_0.INVENTORY_TYPE_OVERFLOW then
			return
		end

		arg_3_0:emit(IslandMediator.ONE_KEY)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnShow(arg_13_0)
	arg_13_0:SetUp()

	return
end

function var_0_0.GetSellItems(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0.values) do
		local var_14_0 = ({})[arg_14_0.displays[iter_14_0].id]

		if not ({})[arg_14_0.displays[iter_14_0].id] then
			var_14_0 = 0
		end

		;({})[arg_14_0.displays[iter_14_0].id] = var_14_0 + iter_14_1
	end

	for iter_14_2, iter_14_3 in pairs({}) do
		if iter_14_3 > 0 then
			table.insert({}, {
				id = iter_14_2,
				num = iter_14_3
			})
		end
	end

	return {}
end

function var_0_0.UpdateStyle(arg_15_0)
	setActive(arg_15_0.sellPanel, arg_15_0.mode == var_0_0.MODE_EDIT)
	setActive(arg_15_0.sortPaenl, arg_15_0.mode == var_0_0.MODE_VIEW and arg_15_0.tagType ~= var_0_0.INVENTORY_TYPE_OVERFLOW)
	setActive(arg_15_0.oneKeyPanel, arg_15_0.tagType == var_0_0.INVENTORY_TYPE_OVERFLOW and arg_15_0.mode ~= var_0_0.MODE_EDIT)
	setActive(arg_15_0.batchSellBtn, arg_15_0.mode == var_0_0.MODE_VIEW)

	if arg_15_0.mode == var_0_0.MODE_EDIT then
		arg_15_0:CheckSelAllFlag()
	end

	return
end

function var_0_0.AddListeners(arg_16_0)
	arg_16_0:AddListener(IslandScene.ON_INVENTORY_FILTER, arg_16_0.OnInventoryFilter)
	arg_16_0:AddListener(GAME.ISLAND_UPGRADE_INVENTORY_DONE, arg_16_0.OnUpgrade)
	arg_16_0:AddListener(GAME.ISLAND_CONVERT_SEASON_PT_DONE, arg_16_0.OnSell)
	arg_16_0:AddListener(GAME.ISLAND_GET_OVERFLOW_ITEM_DOME, arg_16_0.OnSell)
	arg_16_0:AddListener(GAME.ISLAND_INVITE_SHIP_DONE, arg_16_0.OnUseInvitation)

	return
end

function var_0_0.RemoveListeners(arg_17_0)
	arg_17_0:RemoveListener(IslandScene.ON_INVENTORY_FILTER, arg_17_0.OnInventoryFilter)
	arg_17_0:RemoveListener(GAME.ISLAND_UPGRADE_INVENTORY_DONE, arg_17_0.OnUpgrade)
	arg_17_0:RemoveListener(GAME.ISLAND_CONVERT_SEASON_PT_DONE, arg_17_0.OnSell)
	arg_17_0:RemoveListener(GAME.ISLAND_GET_OVERFLOW_ITEM_DOME, arg_17_0.OnSell)
	arg_17_0:RemoveListener(GAME.ISLAND_INVITE_SHIP_DONE, arg_17_0.OnUseInvitation)

	return
end

function var_0_0.OnUseInvitation(arg_18_0)
	arg_18_0:SetTotalCount()

	return
end

function var_0_0.GetIndexData(arg_19_0, arg_19_1)
	assert(arg_19_0.indexDatas[arg_19_1])

	return arg_19_0.indexDatas[arg_19_1]
end

function var_0_0.UpdateIndexData(arg_20_0, arg_20_1, arg_20_2)
	assert(arg_20_0.indexDatas[arg_20_1])
	arg_20_0.indexDatas[arg_20_1]:SetData(arg_20_2)

	return
end

function var_0_0.OnInventoryFilter(arg_21_0, arg_21_1)
	arg_21_0:UpdateIndexData(arg_21_0.tagType, arg_21_1)
	arg_21_0:FlushSortBtn()
	arg_21_0:SetTotalCount()

	return
end

function var_0_0.OnUpgrade(arg_22_0)
	arg_22_0:SetTotalCount()
	arg_22_0:FlushCapacity()
	arg_22_0:ClosePage(IslandInventoryUpgradePage)

	return
end

function var_0_0.OnSell(arg_23_0)
	arg_23_0.mode = var_0_0.MODE_VIEW

	arg_23_0:SetTotalCount()
	arg_23_0:UpdateStyle()
	arg_23_0:FlushCapacity()

	arg_23_0.sellPriceTxt.text = "x 0"

	return
end

function var_0_0.SetUp(arg_24_0)
	arg_24_0.tagType = IslandItem.TYPE_MATERIAL
	arg_24_0.mode = var_0_0.MODE_VIEW
	arg_24_0.asc = true
	arg_24_0.cards = {}

	arg_24_0:FlushTags()
	arg_24_0:FlushFilterBtn()
	arg_24_0:FlushSortBtn()
	arg_24_0:FlushList()
	arg_24_0:FlushCapacity()
	arg_24_0:UpdateStyle()

	return
end

function var_0_0.FlushCapacity(arg_25_0)
	if arg_25_0.tagType == IslandItem.TYPE_MATERIAL then
		setActive(arg_25_0.upgradeBtn, true)
		setActive(arg_25_0.batchSellBtn, true)

		local var_25_0 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()
		local var_25_1 = var_25_0:GetLength()
		local var_25_2 = var_25_0:GetCapacity()

		setButtonEnabled(arg_25_0.upgradeBtn, not var_25_0:IsMaxLevel())

		local var_25_3 = var_25_1 / var_25_2

		arg_25_0:managedTween(LeanTween.value, nil, go(arg_25_0.upgradeBtn), 0, var_25_1 / var_25_2, (math.min(var_25_1 / var_25_2, 1))):setOnUpdate(System.Action_float(function(arg_26_0)
			arg_25_0.capacityTxt.text = calcFloor(var_25_2 * arg_26_0) .. "/" .. var_25_2

			setFillAmount(arg_25_0.upgradeProg, arg_26_0)

			return
		end)):setOnComplete(System.Action(function()
			arg_25_0.capacityTxt.text = var_25_1 .. "/" .. var_25_2

			setFillAmount(arg_25_0.upgradeProg, var_25_3)

			return
		end))

		arg_25_0.upgradeProg:GetComponent(typeof(Image)).color = var_25_1 / var_25_2 > 0.85 and Color.New(0.9529411764705882, 0.4235294117647059, 0.43137254901960786, 1) or Color.New(0.2235294117647059, 0.7450980392156863, 1, 1)
	elseif arg_25_0.tagType == var_0_0.INVENTORY_TYPE_OVERFLOW then
		setActive(arg_25_0.upgradeBtn, false)
		setActive(arg_25_0.batchSellBtn, true)
	else
		setActive(arg_25_0.upgradeBtn, false)
		setActive(arg_25_0.batchSellBtn, false)
	end

	return
end

function var_0_0.FlushTags(arg_28_0)
	for iter_28_0, iter_28_1 in pairs(arg_28_0.toggles) do
		onToggle(arg_28_0, iter_28_1, function(arg_29_0)
			if arg_29_0 then
				arg_28_0:CheckEditMode(iter_28_0)

				arg_28_0.tagType = iter_28_0

				arg_28_0:FlushCapacity()
				arg_28_0:FlushSortBtn()
				arg_28_0:SetTotalCount()
				arg_28_0:UpdateStyle()
			end

			return
		end, SFX_PANEL)

		if iter_28_0 == var_0_0.INVENTORY_TYPE_OVERFLOW then
			setText(iter_28_1:Find("Text"), i18n("island_word_temp"))
		else
			setText(iter_28_1:Find("Text"), IslandItemKind.Type2TagName(iter_28_0))
		end
	end

	arg_28_0:ActiveDefaultTag()

	return
end

function var_0_0.ActiveDefaultTag(arg_30_0)
	local var_30_0 = getProxy(IslandProxy):GetIsland():GetInventoryAgency():ExistAnyOverFlowItem()

	setActive(arg_30_0.toggles[var_0_0.INVENTORY_TYPE_OVERFLOW], var_30_0)

	if var_30_0 then
		triggerToggle(arg_30_0.toggles[var_0_0.INVENTORY_TYPE_OVERFLOW], true)
	else
		triggerToggle(arg_30_0.toggles[IslandItem.TYPE_MATERIAL], true)
	end

	return
end

function var_0_0.CheckEditMode(arg_31_0, arg_31_1)
	if arg_31_0.tagType ~= arg_31_1 and arg_31_0.mode == var_0_0.MODE_EDIT then
		triggerButton(arg_31_0.sellCancelBtn)
	end

	return
end

function var_0_0.FlushFilterBtn(arg_32_0)
	onButton(arg_32_0, arg_32_0.filterBtn, function()
		arg_32_0:OpenPage(IslandInventoryIndexPage, (arg_32_0:GetIndexData(arg_32_0.tagType)))

		return
	end, SFX_PANEL)

	return
end

function var_0_0.FlushSortBtn(arg_34_0)
	local function var_34_0()
		arg_34_0.orderTxt.text = arg_34_0:GetIndexData(arg_34_0.tagType):GetSortText()

		local var_35_0 = arg_34_0.orderArr

		var_35_0.localScale = arg_34_0.asc and Vector2(1, -1, 1) or Vector2(1, 1, 1)

		return
	end

	onButton(arg_34_0, arg_34_0.orderBtn, function()
		arg_34_0.asc = not arg_34_0.asc

		var_34_0()
		arg_34_0:SetTotalCount()

		return
	end, SFX_PANEL)
	;(function()
		arg_34_0.orderTxt.text = arg_34_0:GetIndexData(arg_34_0.tagType):GetSortText()

		local var_35_0 = arg_34_0.orderArr

		var_35_0.localScale = arg_34_0.asc and Vector2(1, -1, 1) or Vector2(1, 1, 1)

		return
	end)()

	return
end

function var_0_0.FlushList(arg_37_0)
	function arg_37_0.scrollRect.onInitItem(arg_38_0)
		arg_37_0:OnInitItem(arg_38_0)

		return
	end

	function arg_37_0.scrollRect.onUpdateItem(arg_39_0, arg_39_1)
		arg_37_0:OnUpdateItem(arg_39_0, arg_39_1)

		return
	end

	arg_37_0:SetTotalCount()

	return
end

function var_0_0.SetTotalCount(arg_40_0)
	arg_40_0.displays = arg_40_0:Filter()
	arg_40_0.values = {}
	arg_40_0.selAllFlag = false

	for iter_40_0, iter_40_1 in ipairs(arg_40_0.displays) do
		table.insert(arg_40_0.values, 0)
	end

	local var_40_0 = arg_40_0:GetIndexData(arg_40_0.tagType)

	table.sort(arg_40_0.displays, function(arg_41_0, arg_41_1)
		return var_40_0:Sort(arg_41_0, arg_41_1, arg_40_0.asc)
	end)
	arg_40_0.scrollRect:SetTotalCount(#arg_40_0.displays, -1)

	return
end

function var_0_0.OnInitItem(arg_42_0, arg_42_1)
	local var_42_0 = IslandItemCard.New(arg_42_1)

	onButton(arg_42_0, var_42_0._go, function()
		if arg_42_0.mode == var_0_0.MODE_VIEW then
			if arg_42_0.tagType ~= var_0_0.INVENTORY_TYPE_OVERFLOW then
				arg_42_0:OnClickItem(var_42_0)
			end
		elseif arg_42_0.mode == var_0_0.MODE_EDIT then
			arg_42_0:OnClickItemForSell(var_42_0)
		end

		return
	end, SFX_PANEL)
	onButton(arg_42_0, var_42_0.reduceBtn, function()
		if arg_42_0.mode == var_0_0.MODE_EDIT then
			arg_42_0:UpdateSellPrice(var_42_0, -1)
		end

		return
	end, SFX_PANEL)
	onInputEndEdit(arg_42_0, var_42_0.valueInput, function(arg_45_0)
		local var_45_0 = table.indexof(arg_42_0.displays, var_42_0.item)

		if not var_45_0 then
			return
		end

		if not arg_45_0 or arg_45_0 == "" or not tonumber(arg_45_0) then
			-- block empty
		end

		arg_42_0:UpdateSellPrice(var_42_0, tonumber(arg_45_0) - arg_42_0.values[var_45_0])

		return
	end)
	pressPersistTrigger(var_42_0.calcPanel, 0.5, function()
		if arg_42_0.mode == var_0_0.MODE_EDIT then
			arg_42_0:UpdateSellPrice(var_42_0, 1)
		end

		return
	end, nil, true, true, 0.1, SFX_PANEL)

	arg_42_0.cards[arg_42_1] = var_42_0

	return
end

function var_0_0.OnClickItem(arg_47_0, arg_47_1)
	if isa(arg_47_1.item, IslandInvitation) then
		local var_47_0 = arg_47_1.item:GetShipName()

		arg_47_0:ShowMsgBox({
			content = i18n("island_open_ship_tip"),
			onYes = function()
				arg_47_0:Hide()
				arg_47_0:emit(IslandBaseMediator.SWITCH_MAP, IslandConst.LABORATORY_MAP_ID, IslandConst.LETTEROFINVITATION_SP)

				return
			end
		})
	else
		arg_47_0:ShowMsgBox({
			title = i18n("island_word_desc"),
			type = IslandMsgBox.TYPE_COMMON_ITEM,
			itemId = arg_47_1.item.id
		})
	end

	return
end

function var_0_0.OnClickItemForSell(arg_49_0, arg_49_1)
	arg_49_0:UpdateSellPrice(arg_49_1, 1)

	return
end

function var_0_0._IsSelAll(arg_50_0)
	for iter_50_0, iter_50_1 in ipairs(arg_50_0.values) do
		if iter_50_1 ~= arg_50_0.displays[iter_50_0]:GetCount() then
			return false
		end
	end

	return true
end

function var_0_0.CheckSelAllFlag(arg_51_0)
	arg_51_0.selAllFlag = arg_51_0:_IsSelAll()

	setActive(arg_51_0.sellAllFlagTF, arg_51_0.selAllFlag)

	return
end

function var_0_0.UpdataSelAll(arg_52_0)
	arg_52_0.values = {}

	for iter_52_0, iter_52_1 in ipairs(arg_52_0.displays) do
		arg_52_0.values[iter_52_0] = iter_52_1:GetCount()
	end

	arg_52_0.scrollRect:SetTotalCount(#arg_52_0.displays, -1)

	local var_52_0 = 0

	for iter_52_2, iter_52_3 in ipairs(arg_52_0.values) do
		var_52_0 = arg_52_0.displays[iter_52_2]:GetConvertPt() * iter_52_3 + var_52_0
	end

	arg_52_0.sellPriceTxt.text = "x " .. var_52_0
	arg_52_0.selAllFlag = true

	setActive(arg_52_0.sellAllFlagTF, arg_52_0.selAllFlag)

	return
end

function var_0_0.UpdataUnselAll(arg_53_0)
	arg_53_0:SetTotalCount()

	arg_53_0.sellPriceTxt.text = "x 0"
	arg_53_0.selAllFlag = false

	setActive(arg_53_0.sellAllFlagTF, arg_53_0.selAllFlag)

	return
end

function var_0_0.UpdateSellPrice(arg_54_0, arg_54_1, arg_54_2)
	local var_54_0 = table.indexof(arg_54_0.displays, arg_54_1.item)

	if not var_54_0 then
		return
	end

	arg_54_0.values[var_54_0] = math.max(0, math.min(arg_54_0.values[var_54_0] + arg_54_2, arg_54_1.item:GetCount()))

	arg_54_1:UpdateValue(arg_54_0.values[var_54_0])

	local var_54_1 = 0

	for iter_54_0, iter_54_1 in ipairs(arg_54_0.values) do
		var_54_1 = arg_54_0.displays[iter_54_0]:GetConvertPt() * iter_54_1 + var_54_1
	end

	arg_54_0.sellPriceTxt.text = "x " .. var_54_1

	arg_54_0:CheckSelAllFlag()

	return
end

function var_0_0.OnUpdateItem(arg_55_0, arg_55_1, arg_55_2)
	local var_55_0 = arg_55_0.cards[arg_55_2]

	if not arg_55_0.cards[arg_55_2] then
		arg_55_0:OnInitItem(arg_55_2)

		var_55_0 = arg_55_0.cards[arg_55_2]
	end

	if arg_55_0.displays[arg_55_1 + 1] then
		var_55_0:Update(arg_55_0.displays[arg_55_1 + 1], arg_55_0.mode, arg_55_0.values[arg_55_1 + 1], arg_55_0.tagType)
	end

	return
end

function var_0_0.Filter(arg_56_0)
	local var_56_0 = {}

	if arg_56_0.tagType == var_0_0.INVENTORY_TYPE_OVERFLOW then
		arg_56_0:CollectOverFlowInventoryItems(var_56_0)
	else
		arg_56_0:CollectCommonInventoryItems(var_56_0)
	end

	if arg_56_0.mode == var_0_0.MODE_EDIT then
		var_56_0 = underscore.select(var_56_0, function(arg_57_0)
			return arg_57_0:CanConvert()
		end)
	end

	return var_56_0
end

function var_0_0.CollectOverFlowInventoryItems(arg_58_0, arg_58_1)
	for iter_58_0, iter_58_1 in pairs((getProxy(IslandProxy):GetIsland():GetInventoryAgency():GetOverflowItemList())) do
		table.insert(arg_58_1, iter_58_1)
	end

	return
end

function var_0_0.CollectCommonInventoryItems(arg_59_0, arg_59_1)
	for iter_59_0, iter_59_1 in ipairs((getProxy(IslandProxy):GetIsland():GetInventoryAgency():GetGroupedItemList())) do
		if arg_59_0.tagType == IslandItem.TYPE_MATERIAL and iter_59_1:IsMaterial() and arg_59_0.indexDatas[IslandItem.TYPE_MATERIAL]:Match(iter_59_1) then
			table.insert(arg_59_1, iter_59_1)
		elseif arg_59_0.tagType == IslandItem.TYPE_PROP and iter_59_1:IsProp() and arg_59_0.indexDatas[IslandItem.TYPE_PROP]:Match(iter_59_1) then
			table.insert(arg_59_1, iter_59_1)
		elseif arg_59_0.tagType == IslandItem.TYPE_SPECIAL_PROP and iter_59_1:IsSpecialProp() and arg_59_0.indexDatas[IslandItem.TYPE_SPECIAL_PROP]:Match(iter_59_1) then
			table.insert(arg_59_1, iter_59_1)
		end
	end

	if arg_59_0.tagType == IslandItem.TYPE_SPECIAL_PROP then
		for iter_59_2, iter_59_3 in ipairs((getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetInviteList())) do
			local var_59_0 = IslandInvitation.New(iter_59_3)

			if arg_59_0.indexDatas[IslandItem.TYPE_SPECIAL_PROP]:Match(var_59_0) then
				table.insert(arg_59_1, var_59_0)
			end
		end
	end

	return
end

function var_0_0.OnDestroy(arg_60_0)
	ClearLScrollrect(arg_60_0.scrollRect)

	for iter_60_0, iter_60_1 in pairs(arg_60_0.cards) do
		iter_60_1:Dispose()
	end

	arg_60_0.cards = {}

	return
end

return var_0_0
