class = var_0_10000

local var_0_0 = "IslandShopExchangePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "IslandShopExchangeUI"
end

function var_0_1.Ctor(arg_2_0, arg_2_1, arg_2_2)
	var_0_1.super.Ctor(arg_2_0, arg_2_1, arg_2_2.event, arg_2_2.contextData)

	arg_2_0.viewComponent = arg_2_2

	return
end

function var_0_1.OnLoaded(arg_3_0)
	local var_3_0 = arg_3_0._tf
	local var_3_1 = var_1.Find(var_3_0, "adapt/left")

	setText = var_3_0

	local var_3_2 = var_3_1
	local var_3_3 = var_3_1.Find(var_3_2, "tip")

	i18n = var_3_2

	var_3_0(var_3_3, var_3_2("island_quickselect_tip"))

	arg_3_0.allBtn = var_3_1:Find("btn_all")

	local var_3_4 = arg_3_0.allBtn

	arg_3_0.allFlagTF = var_2.Find(var_3_4, "flag")
	setText = var_2

	local var_3_5 = arg_3_0.allBtn
	local var_3_6 = var_3.Find(var_3_5, "Text")

	i18n = var_3_5

	var_2(var_3_6, var_3_5("island_selectall"))

	arg_3_0.deleteBtn = var_3_1:Find("btn_delete")

	local var_3_7 = var_3_1:Find("view")

	arg_3_0.scrollRect = var_2.GetComponent(var_3_7, "LScrollRect")
	arg_3_0.emptyTF = var_3_1:Find("empty")

	local var_3_8 = arg_3_0._tf
	local var_3_9 = var_2.Find(var_3_8, "adapt/right")
	local var_3_10 = var_2.Find(var_3_9, "title/name")
	local var_3_11 = var_3.GetComponent

	typeof = var_5
	Text = var_1_10006
	arg_3_0.itemNameTxt = var_3_11(var_3_10, var_5(var_1_10006))
	arg_3_0.itemTF = var_2:Find("bg_item/item")
	setText = var_3

	local var_3_12 = var_2
	local var_3_13 = var_2.Find(var_3_12, "bg_count/Text")

	i18n = var_3_12

	var_3(var_3_13, var_3_12("island_exchange_own_count"))

	local var_3_14 = var_2:Find("bg_count/content/Text")
	local var_3_15 = var_3.GetComponent

	typeof = var_5
	Text = var_6
	arg_3_0.itemOwnTxt = var_3_15(var_3_14, var_5(var_6))

	local var_3_16 = var_2:Find("bg_count/content/add")
	local var_3_17 = var_3.GetComponent

	typeof = var_5
	Text = var_6
	arg_3_0.itemAddTxt = var_3_17(var_3_16, var_5(var_6))
	arg_3_0.exchangeBtn = var_2:Find("btn_exchange")
	setText = var_3

	local var_3_18 = arg_3_0.exchangeBtn
	local var_3_19 = var_4.Find(var_3_18, "Text")

	i18n = var_3_18

	var_3(var_3_19, var_3_18("island_exchange_btn_text"))

	local var_3_20 = arg_3_0._tf

	arg_3_0.blockTF = var_3.Find(var_3_20, "block")

	local var_3_21 = var_2:Find("bg_item")
	local var_3_22 = var_3.GetComponent

	typeof = var_5
	Animation = var_6
	arg_3_0.itemAnim = var_3_22(var_3_21, var_5(var_6))

	local var_3_23 = var_2:Find("bg_item")
	local var_3_24 = var_3.GetComponent

	typeof = var_5
	DftAniEvent = var_6
	arg_3_0.itemAnimEvent = var_3_24(var_3_23, var_5(var_6))

	return
end

function var_0_1.OnInit(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.allBtn

	local function var_4_2(arg_5_0)
		if arg_4_0.selAllFlag or #arg_4_0.displays == 0 then
			return
		end

		local var_5_0 = arg_4_0

		var_1.SelecteAll(var_5_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_4_0, var_4_1, var_4_2, var_1_10005)

	onButton = var_1_10001

	local var_4_3 = arg_4_0
	local var_4_4 = arg_4_0.deleteBtn

	local function var_4_5()
		local var_6_0 = arg_4_0

		var_0.SetTotalCount(var_6_0)

		arg_4_0.itemAddTxt.text = ""

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_4_3, var_4_4, var_4_5, var_1_10005)

	onButton = var_1_10001

	var_1_10001(arg_4_0, arg_4_0.itemTF, function()
		local var_7_0 = arg_4_0.viewComponent
		local var_7_1 = var_0.ShowMsgBox
		local var_7_2 = {}

		i18n = var_2_10003
		var_7_2.title = var_2_10003("island_word_desc")
		IslandMsgBox = var_3
		var_7_2.type = var_3.TYPE_COMMON_DROP_DESCRIBE
		var_7_2.dropData = arg_4_0.showDropData

		var_7_1(var_7_0, var_7_2)

		return
	end)

	local var_4_6 = arg_4_0.itemAnimEvent

	var_1.SetTriggerEvent(var_4_6, function()
		local var_8_0 = arg_4_0

		var_0.SendExchangeProto(var_8_0)

		return
	end)

	local var_4_7 = arg_4_0.itemAnimEvent

	var_1.SetEndEvent(var_4_7, function()
		setActive = var_2_10000

		var_2_10000(arg_4_0.blockTF, false)

		local var_9_0 = arg_4_0.itemAnim

		var_0.Play(var_9_0, "anim_IslandExchangeUI_Craft_loop")

		return
	end)

	onButton = var_1

	local var_4_8 = arg_4_0
	local var_4_9 = arg_4_0.exchangeBtn

	local function var_4_10()
		getProxy = var_2_10000
		IslandProxy = var_2_10001

		local var_10_0 = var_2_10000(var_2_10001)
		local var_10_1 = var_0.GetIsland(var_10_0)
		local var_10_2 = var_0.GetInventoryAgency(var_10_1)

		if var_0.ExistAnyOverFlowItem(var_10_2) then
			pg = var_0

			local var_10_3 = var_0.TipsMgr.GetInstance()
			local var_10_4 = var_0.ShowTips

			i18n = var_2_10002

			var_10_4(var_10_3, var_2_10002("island_bag_max_tip"))

			return
		end

		local var_10_5 = arg_4_0
		local var_10_6 = arg_4_0

		var_10_5.exchangeItems = var_1.GetExchangeItems(var_10_6)

		if #arg_4_0.exchangeItems <= 0 then
			return
		end

		local var_10_7 = arg_4_0.viewComponent
		local var_10_8 = var_0.ShowMsgBox
		local var_10_9 = {}

		i18n = var_2_10003
		var_10_9.content = var_2_10003("island_exchange_sure_tip")

		function var_10_9.onYes()
			local var_11_0 = arg_4_0.itemAnim

			var_0.Play(var_11_0, "anim_IslandExchangeUI_Craft")

			setActive = var_0

			var_0(arg_4_0.blockTF, true)

			return
		end

		var_10_8(var_10_7, var_10_9)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_4_8, var_4_9, var_4_10, var_1_10005)

	function arg_4_0.scrollRect.onInitItem(arg_12_0)
		local var_12_0 = arg_4_0

		var_1.OnInitItem(var_12_0, arg_12_0)

		return
	end

	function arg_4_0.scrollRect.onUpdateItem(arg_13_0, arg_13_1)
		local var_13_0 = arg_4_0

		var_2.OnUpdateItem(var_13_0, arg_13_0, arg_13_1)

		return
	end

	arg_4_0.cards = {}

	return
end

function var_0_1.SendExchangeProto(arg_14_0)
	local var_14_0 = arg_14_0
	local var_14_1 = arg_14_0.emit

	IslandMediator = var_1_10003

	var_14_1(var_14_0, var_1_10003.EXCHANGE_ITME, arg_14_0.exchangeItems, arg_14_0.showItemId, arg_14_0.totalAddCnt)

	return
end

function var_0_1.Show(arg_15_0)
	var_0_1.super.Show(arg_15_0)

	pg = var_1
	arg_15_0.groupConfig = var_1.island_exchange_group
	setActive = var_1

	var_1(arg_15_0.blockTF, false)

	local var_15_0 = arg_15_0.itemAnim

	var_1.Play(var_15_0, "anim_IslandExchangeUI_Craft_loop")

	local var_15_1 = arg_15_0
	local var_15_2 = arg_15_0.OverlayPanel
	local var_15_3 = arg_15_0._tf
	local var_15_4 = {}
	local var_15_5 = {}
	local var_15_6 = arg_15_0._tf

	var_15_5[1] = var_6.Find(var_15_6, "bg")
	var_15_4.pbList = var_15_5

	var_15_2(var_15_1, var_15_3, var_15_4)

	return
end

function var_0_1.FlushGroup(arg_16_0, arg_16_1)
	local var_16_0

	if not arg_16_1 and not arg_16_0.showGroupId then
		var_16_0 = arg_16_0.groupConfig[arg_16_0.groupConfig.all[1]].exchange_group[1][2]
	end

	arg_16_0.showGroupId = var_16_0

	if arg_16_0:isShowing() then
		arg_16_0:SetTotalCount()
	end

	pg = var_2

	local var_16_1 = var_2.island_item_data_template[arg_16_0.showItemId]

	arg_16_0.itemNameTxt.text = var_16_1.name

	local var_16_2 = arg_16_0.itemOwnTxt

	getProxy = var_4
	IslandProxy = var_1_10005

	local var_16_3 = var_4(var_1_10005)
	local var_16_4 = var_4.GetIsland(var_16_3)
	local var_16_5 = var_4.GetInventoryAgency(var_16_4)

	var_16_2.text = var_4.GetOwnCount(var_16_5, arg_16_0.showItemId)

	local var_16_6 = arg_16_0.itemAddTxt

	var_16_6.text = ""
	Drop = var_16_6

	local var_16_7 = var_16_6.New
	local var_16_8 = {
		count = 0
	}

	DROP_TYPE_ISLAND_ITEM = var_16_5
	var_16_8.type = var_16_5
	var_16_8.id = arg_16_0.showItemId
	arg_16_0.showDropData = var_16_7(var_16_8)
	updateIslandItem = var_3

	var_3(arg_16_0.itemTF, arg_16_0.showDropData)

	return
end

function var_0_1.SetTotalCount(arg_17_0)
	arg_17_0.displays = arg_17_0:CollectDisplayItems()
	arg_17_0.values = {}
	ipairs = var_1

	for iter_17_0, iter_17_1 in var_1(arg_17_0.displays) do
		table = var_1_10006

		var_1_10006.insert(arg_17_0.values, 0)
	end

	local var_17_0 = arg_17_0.scrollRect

	var_1.SetTotalCount(var_17_0, #arg_17_0.displays, -1)

	setActive = var_1

	var_1(arg_17_0.emptyTF, #arg_17_0.displays == 0)

	arg_17_0.selAllFlag = false
	setActive = var_1

	var_1(arg_17_0.allFlagTF, arg_17_0.selAllFlag)

	return
end

function var_0_1.UpdateCount(arg_18_0)
	arg_18_0.totalAddCnt = 0
	ipairs = var_1

	for iter_18_0, iter_18_1 in var_1(arg_18_0.values) do
		local var_18_0 = arg_18_0.displays[iter_18_0]

		arg_18_0.totalAddCnt = arg_18_0.totalAddCnt + var_18_0.targetNum * iter_18_1
	end

	local var_18_1 = arg_18_0.itemAddTxt
	local var_18_2

	if not (arg_18_0.totalAddCnt > 0) or not ("+" .. arg_18_0.totalAddCnt) then
		var_18_2 = ""
	end

	var_18_1.text = var_18_2

	return
end

function var_0_1.OnInitItem(arg_19_0, arg_19_1)
	IslandExchangeItemCard = var_1_10002

	local var_19_0 = var_1_10002.New(arg_19_1)

	onButton = var_3

	local var_19_1 = arg_19_0
	local var_19_2 = var_19_0._go

	local function var_19_3()
		local var_20_0 = arg_19_0

		var_0.UpdateCardSel(var_20_0, var_19_0, 1)

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_19_1, var_19_2, var_19_3, var_1_10007)

	onButton = var_3

	local var_19_4 = arg_19_0
	local var_19_5 = var_19_0.reduceBtn

	local function var_19_6()
		local var_21_0 = arg_19_0

		var_0.UpdateCardSel(var_21_0, var_19_0, -1)

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_19_4, var_19_5, var_19_6, var_1_10007)

	onInputEndEdit = var_3

	var_3(arg_19_0, var_19_0.valueInput, function(arg_22_0)
		table = var_2_10001

		if not var_2_10001.indexof(arg_19_0.displays, var_19_0.item) then
			return
		end

		local var_22_0 = 0

		if arg_22_0 and arg_22_0 ~= "" then
			tonumber = var_3

			if not var_3(arg_22_0) then
				local var_22_1 = 1
			end

			tonumber = var_3

			local var_22_2 = var_3(arg_22_0) - arg_19_0.values[var_1]
			local var_22_3 = arg_19_0

			var_5.UpdateCardSel(var_22_3, var_19_0, var_22_2)

			return
		end
	end)

	pressPersistTrigger = var_3

	local var_19_7 = var_19_0.calcPanel
	local var_19_8 = 0.5

	local function var_19_9()
		local var_23_0 = arg_19_0

		var_0.UpdateCardSel(var_23_0, var_19_0, 1)

		return
	end

	local var_19_10
	local var_19_11 = true
	local var_19_12 = true
	local var_19_13 = 0.1

	SFX_PANEL = var_1_10011

	var_3(var_19_7, var_19_8, var_19_9, var_19_10, var_19_11, var_19_12, var_19_13, var_1_10011)

	arg_19_0.cards[arg_19_1] = var_19_0

	return
end

function var_0_1.OnUpdateItem(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0

	if not arg_24_0.cards[arg_24_2] then
		arg_24_0:OnInitItem(arg_24_2)

		var_24_0 = arg_24_0.cards[arg_24_2]
	end

	if arg_24_0.displays[arg_24_1 + 1] then
		var_24_0:Update(arg_24_0.displays[arg_24_1 + 1], arg_24_0.values[arg_24_1 + 1])
	end

	return
end

function var_0_1.UpdateCardSel(arg_25_0, arg_25_1, arg_25_2)
	table = var_1_10003

	if not var_1_10003.indexof(arg_25_0.displays, arg_25_1.item) then
		return
	end

	local var_25_0 = arg_25_0.values[var_3] + arg_25_2
	local var_25_1 = arg_25_0.values

	math = var_1_10006

	local var_25_2 = var_1_10006.max
	local var_25_3 = 0

	math = var_1_10008

	local var_25_4 = var_1_10008.min
	local var_25_5 = var_25_0
	local var_25_6 = arg_25_1.item

	var_25_1[var_3] = var_25_2(var_25_3, var_25_4(var_25_5, var_10.GetCount(var_25_6)))

	arg_25_1:UpdateValue(arg_25_0.values[var_3])
	arg_25_0:UpdateCount()
	arg_25_0:CheckSelAllFlag()

	return
end

function var_0_1._IsSelAll(arg_26_0)
	ipairs = var_1_10001

	for iter_26_0, iter_26_1 in var_1_10001(arg_26_0.values) do
		local var_26_0 = arg_26_0.displays[iter_26_0]

		if iter_26_1 ~= var_6.GetCount(var_26_0) then
			return false
		end
	end

	return true
end

function var_0_1.CheckSelAllFlag(arg_27_0)
	arg_27_0.selAllFlag = arg_27_0:_IsSelAll()
	setActive = var_1

	var_1(arg_27_0.allFlagTF, arg_27_0.selAllFlag)

	return
end

function var_0_1.SelecteAll(arg_28_0)
	arg_28_0.values = {}
	ipairs = var_1

	for iter_28_0, iter_28_1 in var_1(arg_28_0.displays) do
		arg_28_0.values[iter_28_0] = iter_28_1:GetCount()
	end

	local var_28_0 = arg_28_0.scrollRect

	var_1.SetTotalCount(var_28_0, #arg_28_0.displays, -1)
	arg_28_0:UpdateCount()

	arg_28_0.selAllFlag = true
	setActive = var_1

	var_1(arg_28_0.allFlagTF, arg_28_0.selAllFlag)

	return
end

function var_0_1.CollectDisplayItems(arg_29_0)
	local var_29_0 = {}

	getProxy = var_1_10002
	IslandProxy = var_1_10003

	local var_29_1 = var_1_10002(var_1_10003)
	local var_29_2 = var_2.GetIsland(var_29_1)
	local var_29_3 = var_2.GetInventoryAgency(var_29_2)

	pg = var_29_2
	arg_29_0.showExchangeIds = var_29_2.island_exchange_template.get_id_list_by_group[arg_29_0.showGroupId]
	arg_29_0.showItemId = var_3[arg_29_0.showExchangeIds[1]].target_item
	ipairs = var_4

	for iter_29_0, iter_29_1 in var_4(arg_29_0.showExchangeIds) do
		local var_29_4 = var_3[iter_29_1].origin_item
		local var_29_5 = var_29_3

		if var_29_3.GetItemById(var_29_5, var_29_4) then
			Clone = var_29_5

			local var_29_6 = var_29_5(var_10)

			var_29_6.exchangeId = iter_29_1
			var_29_6.targetNum = var_3[iter_29_1].target_num
			table = var_12

			var_12.insert(var_29_0, var_29_6)
		end
	end

	return var_29_0
end

function var_0_1.GetExchangeItems(arg_30_0)
	local var_30_0 = {}

	ipairs = var_1_10002

	for iter_30_0, iter_30_1 in var_1_10002(arg_30_0.values) do
		local var_30_1 = arg_30_0.displays[iter_30_0]

		if 0 < iter_30_1 then
			table = var_8

			var_8.insert(var_30_0, {
				exchangeId = var_30_1.exchangeId,
				itemId = var_30_1.id,
				num = iter_30_1
			})
		end
	end

	return var_30_0
end

function var_0_1.OnHide(arg_31_0)
	local var_31_0 = arg_31_0.itemAnim

	var_1.Stop(var_31_0)

	setActive = var_1

	var_1(arg_31_0.blockTF, false)
	arg_31_0:UnOverlayPanel(arg_31_0._tf, arg_31_0._parentTf)

	return
end

function var_0_1.OnDestroy(arg_32_0)
	arg_32_0:OnHide()

	ClearLScrollrect = var_1

	var_1(arg_32_0.scrollRect)

	pairs = var_1

	for iter_32_0, iter_32_1 in var_1(arg_32_0.cards) do
		iter_32_1:Dispose()
	end

	arg_32_0.cards = {}

	local var_32_0 = arg_32_0.itemAnimEvent

	var_1.SetTriggerEvent(var_32_0, nil)

	local var_32_1 = arg_32_0.itemAnimEvent

	var_1.SetEndEvent(var_32_1, nil)

	return
end

return var_0_1
