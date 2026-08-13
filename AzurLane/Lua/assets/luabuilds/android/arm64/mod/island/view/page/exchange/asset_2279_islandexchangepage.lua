class = var_0_10000

local var_0_0 = "IslandExchangePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.IslandBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandExchangeUI"
end

function var_0_1.OnLoaded(arg_2_0)
	setText = var_1_10001

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_3.Find(var_2_0, "top/title/Text")

	i18n = var_1_10004

	var_1_10001(var_2_1, var_1_10004("island_exchange_title"))

	setText = var_1_10001

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_3.Find(var_2_2, "top/title/Text/en")

	i18n = var_4

	var_1_10001(var_2_3, var_4("island_exchange_title_en"))

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_1.Find(var_2_4, "adapt/toggles/content")

	UIItemList = var_1_10002
	arg_2_0.toggleUIList = var_1_10002.New(var_2_5, var_2_5:Find("tpl"))

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_2.Find(var_2_6, "adapt/left")

	setText = var_2_4

	local var_2_8 = var_2_7:Find("tip")

	i18n = var_6

	var_2_4(var_2_8, var_6("island_quickselect_tip"))

	arg_2_0.allBtn = var_2_7:Find("btn_all")

	local var_2_9 = arg_2_0.allBtn

	arg_2_0.allFlagTF = var_3.Find(var_2_9, "flag")
	setText = var_3

	local var_2_10 = arg_2_0.allBtn
	local var_2_11 = var_5.Find(var_2_10, "Text")

	i18n = var_6

	var_3(var_2_11, var_6("island_selectall"))

	arg_2_0.deleteBtn = var_2_7:Find("btn_delete")

	local var_2_12 = var_2_7:Find("view")

	arg_2_0.scrollRect = var_3.GetComponent(var_2_12, "LScrollRect")
	arg_2_0.emptyTF = var_2_7:Find("empty")

	local var_2_13 = arg_2_0._tf
	local var_2_14 = var_3.Find(var_2_13, "adapt/right")
	local var_2_15 = var_3.Find(var_2_14, "title/name")
	local var_2_16 = var_4.GetComponent

	typeof = var_7
	Text = var_1_10009
	arg_2_0.itemNameTxt = var_2_16(var_2_15, var_7(var_1_10009))
	arg_2_0.itemTF = var_3:Find("bg_item/item")
	setText = var_4

	local var_2_17 = var_3:Find("bg_count/Text")

	i18n = var_7

	var_4(var_2_17, var_7("island_exchange_own_count"))

	local var_2_18 = var_3:Find("bg_count/content/Text")
	local var_2_19 = var_4.GetComponent

	typeof = var_7
	Text = var_9
	arg_2_0.itemOwnTxt = var_2_19(var_2_18, var_7(var_9))

	local var_2_20 = var_3:Find("bg_count/content/add")
	local var_2_21 = var_4.GetComponent

	typeof = var_7
	Text = var_9
	arg_2_0.itemAddTxt = var_2_21(var_2_20, var_7(var_9))
	arg_2_0.exchangeBtn = var_3:Find("btn_exchange")
	setText = var_4

	local var_2_22 = arg_2_0.exchangeBtn
	local var_2_23 = var_6.Find(var_2_22, "Text")

	i18n = var_7

	var_4(var_2_23, var_7("island_exchange_btn_text"))

	local var_2_24 = arg_2_0._tf

	arg_2_0.blockTF = var_4.Find(var_2_24, "block")

	local var_2_25 = var_3:Find("bg_item")
	local var_2_26 = var_4.GetComponent

	typeof = var_7
	Animation = var_9
	arg_2_0.itemAnim = var_2_26(var_2_25, var_7(var_9))

	local var_2_27 = var_3:Find("bg_item")
	local var_2_28 = var_4.GetComponent

	typeof = var_7
	DftAniEvent = var_9
	arg_2_0.itemAnimEvent = var_2_28(var_2_27, var_7(var_9))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_4.Find(var_3_1, "top/back")

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_3_1

	var_1_10001(var_3_0, var_3_2, var_3_3, var_3_1)

	onButton = var_1_10001

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0.allBtn

	local function var_3_6(arg_5_0)
		if arg_3_0.selAllFlag or #arg_3_0.displays == 0 then
			return
		end

		local var_5_0 = arg_3_0

		var_1.SelecteAll(var_5_0)

		return
	end

	SFX_PANEL = var_3_1

	var_1_10001(var_3_4, var_3_5, var_3_6, var_3_1)

	onButton = var_1_10001

	local var_3_7 = arg_3_0
	local var_3_8 = arg_3_0.deleteBtn

	local function var_3_9()
		local var_6_0 = arg_3_0

		var_0.SetTotalCount(var_6_0)

		arg_3_0.itemAddTxt.text = ""

		return
	end

	SFX_PANEL = var_3_1

	var_1_10001(var_3_7, var_3_8, var_3_9, var_3_1)

	onButton = var_1_10001

	var_1_10001(arg_3_0, arg_3_0.itemTF, function()
		local var_7_0 = arg_3_0
		local var_7_1 = var_0.ShowMsgBox
		local var_7_2 = {}

		i18n = var_2_10004
		var_7_2.title = var_2_10004("island_word_desc")
		IslandMsgBox = var_4
		var_7_2.type = var_4.TYPE_COMMON_DROP_DESCRIBE
		var_7_2.dropData = arg_3_0.showDropData

		var_7_1(var_7_0, var_7_2)

		return
	end)

	local var_3_10 = arg_3_0.itemAnimEvent

	var_1.SetTriggerEvent(var_3_10, function()
		local var_8_0 = arg_3_0

		var_0.SendExchangeProto(var_8_0)

		return
	end)

	local var_3_11 = arg_3_0.itemAnimEvent

	var_1.SetEndEvent(var_3_11, function()
		setActive = var_2_10000

		var_2_10000(arg_3_0.blockTF, false)

		local var_9_0 = arg_3_0.itemAnim

		var_0.Play(var_9_0, "anim_IslandExchangeUI_Craft_loop")

		return
	end)

	onButton = var_1

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0.exchangeBtn

	local function var_3_14()
		getProxy = var_2_10000
		IslandProxy = var_2_10002

		local var_10_0 = var_2_10000(var_2_10002)
		local var_10_1 = var_0.GetIsland(var_10_0)
		local var_10_2 = var_0.GetInventoryAgency(var_10_1)

		if var_0.ExistAnyOverFlowItem(var_10_2) then
			pg = var_0

			local var_10_3 = var_0.TipsMgr.GetInstance()
			local var_10_4 = var_0.ShowTips

			i18n = var_2_10003

			var_10_4(var_10_3, var_2_10003("island_bag_max_tip"))

			return
		end

		local var_10_5 = arg_3_0
		local var_10_6 = arg_3_0

		var_10_5.exchangeItems = var_1.GetExchangeItems(var_10_6)

		if #arg_3_0.exchangeItems <= 0 then
			return
		end

		local var_10_7 = arg_3_0
		local var_10_8 = var_0.ShowMsgBox
		local var_10_9 = {}

		i18n = var_2_10004
		var_10_9.content = var_2_10004("island_exchange_sure_tip")

		function var_10_9.onYes()
			local var_11_0 = arg_3_0.itemAnim

			var_0.Play(var_11_0, "anim_IslandExchangeUI_Craft")

			setActive = var_0

			var_0(arg_3_0.blockTF, true)

			return
		end

		var_10_8(var_10_7, var_10_9)

		return
	end

	SFX_PANEL = var_3_1

	var_1(var_3_12, var_3_13, var_3_14, var_3_1)

	local var_3_15 = arg_3_0.toggleUIList

	var_1.make(var_3_15, function(arg_12_0, arg_12_1, arg_12_2)
		UIItemList = var_2_10003

		if arg_12_0 == var_2_10003.EventUpdate then
			local var_12_0 = arg_3_0

			var_3.UpdateToggleItem(var_12_0, arg_12_1, arg_12_2)
		end

		return
	end)

	function arg_3_0.scrollRect.onInitItem(arg_13_0)
		local var_13_0 = arg_3_0

		var_1.OnInitItem(var_13_0, arg_13_0)

		return
	end

	function arg_3_0.scrollRect.onUpdateItem(arg_14_0, arg_14_1)
		local var_14_0 = arg_3_0

		var_2.OnUpdateItem(var_14_0, arg_14_0, arg_14_1)

		return
	end

	return
end

function var_0_1.SendExchangeProto(arg_15_0)
	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.emit

	IslandMediator = var_1_10004

	var_15_1(var_15_0, var_1_10004.EXCHANGE_ITME, arg_15_0.exchangeItems, arg_15_0.showItemId, arg_15_0.totalAddCnt)

	return
end

function var_0_1.OnShow(arg_16_0, arg_16_1)
	arg_16_0.firstFlush = true
	arg_16_0.cards = {}

	local var_16_0

	if not arg_16_1 then
		::label_16_0::

		pg = var_16_0
		var_16_0 = var_16_0.island_exchange_group.all
	end

	arg_16_0.showIds = var_16_0

	local var_16_1 = arg_16_0.toggleUIList

	var_2.align(var_16_1, #arg_16_0.showIds)

	triggerToggle = var_2

	local var_16_2 = arg_16_0.toggleUIList.container
	local var_16_3 = var_4.GetChild(var_16_2, 0)

	var_2(var_4.Find(var_16_3, "title"), true)

	setActive = var_2

	var_2(arg_16_0.blockTF, false)

	local var_16_4 = arg_16_0.itemAnim

	var_2.Play(var_16_4, "anim_IslandExchangeUI_Craft_loop")
	arg_16_0:BlurPanel()

	return
end

function var_0_1.AddListeners(arg_17_0)
	local var_17_0 = arg_17_0
	local var_17_1 = arg_17_0.AddListener

	GAME = var_1_10004

	var_17_1(var_17_0, var_1_10004.ISLAND_EXCHANGE_ITEM_DONE, arg_17_0.OnExchangeDone)

	return
end

function var_0_1.RemoveListeners(arg_18_0)
	local var_18_0 = arg_18_0
	local var_18_1 = arg_18_0.RemoveListener

	GAME = var_1_10004

	var_18_1(var_18_0, var_1_10004.ISLAND_EXCHANGE_ITEM_DONE, arg_18_0.OnExchangeDone)

	return
end

function var_0_1.OnExchangeDone(arg_19_0)
	arg_19_0:FlushGroup()

	return
end

function var_0_1.UpdateToggleItem(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0.showIds[arg_20_1 + 1]

	pg = var_4

	local var_20_1 = var_4.island_exchange_group[var_20_0]

	setText = var_1_10005

	var_1_10005(arg_20_2:Find("title/name"), var_20_1.text[1])

	setText = var_1_10005

	var_1_10005(arg_20_2:Find("title/name/en"), var_20_1.text[2])

	GetImageSpriteFromAtlasAsync = var_1_10005

	var_1_10005("island/islandshopicon", var_20_1.text[3], arg_20_2:Find("title/sel/icon"))

	onToggle = var_1_10005

	local var_20_2 = arg_20_0
	local var_20_3 = arg_20_2
	local var_20_4 = arg_20_2.Find(var_20_3, "title")

	local function var_20_5(arg_21_0)
		if arg_21_0 then
			triggerToggle = var_2_10001

			local var_21_0 = arg_20_2
			local var_21_1 = var_3.Find(var_21_0, "list")

			var_2_10001(var_3.GetChild(var_21_1, 0), true)
		end

		return
	end

	SFX_PANEL = var_20_3

	var_1_10005(var_20_2, var_20_4, var_20_5, var_20_3)

	local var_20_6 = var_20_1.exchange_group

	UIItemList = var_1_10006

	var_1_10006.StaticAlign(arg_20_2:Find("list"), arg_20_2:Find("list/tpl"), #var_20_6, function(arg_22_0, arg_22_1, arg_22_2)
		UIItemList = var_2_10003

		if arg_22_0 == var_2_10003.EventUpdate then
			local var_22_0 = arg_22_1 + 1
			local var_22_1 = var_20_6[var_22_0][1]
			local var_22_2 = var_20_6[var_22_0][2]

			setText = var_2_10006

			var_2_10006(arg_22_2:Find("name"), var_22_1)

			setText = var_2_10006

			var_2_10006(arg_22_2:Find("sel/name"), var_22_1)

			setActive = var_2_10006

			var_2_10006(arg_22_2:Find("line2"), var_22_0 ~= #var_20_6)

			onToggle = var_2_10006

			local var_22_3 = arg_20_0
			local var_22_4 = arg_22_2

			local function var_22_5(arg_23_0)
				if arg_23_0 then
					if not arg_20_0.firstFlush and arg_20_0.showGroupId and arg_20_0.showGroupId == var_22_2 then
						return
					end

					arg_20_0.firstFlush = false
					arg_20_0.showGroupId = var_22_2

					local var_23_0 = arg_20_0

					var_1.FlushGroup(var_23_0)
				end

				return
			end

			SFX_PANEL = var_11

			var_2_10006(var_22_3, var_22_4, var_22_5, var_11)
		end

		return
	end)

	return
end

function var_0_1.FlushGroup(arg_24_0)
	arg_24_0:SetTotalCount()

	pg = var_1

	local var_24_0 = var_1.island_item_data_template[arg_24_0.showItemId]

	arg_24_0.itemNameTxt.text = var_24_0.name

	local var_24_1 = arg_24_0.itemOwnTxt

	getProxy = var_3
	IslandProxy = var_1_10005

	local var_24_2 = var_3(var_1_10005)
	local var_24_3 = var_3.GetIsland(var_24_2)
	local var_24_4 = var_3.GetInventoryAgency(var_24_3)

	var_24_1.text = var_3.GetOwnCount(var_24_4, arg_24_0.showItemId)

	local var_24_5 = arg_24_0.itemAddTxt

	var_24_5.text = ""
	Drop = var_24_5

	local var_24_6 = var_24_5.New
	local var_24_7 = {
		count = 0
	}

	DROP_TYPE_ISLAND_ITEM = var_24_4
	var_24_7.type = var_24_4
	var_24_7.id = arg_24_0.showItemId
	arg_24_0.showDropData = var_24_6(var_24_7)
	updateIslandItem = var_2

	var_2(arg_24_0.itemTF, arg_24_0.showDropData)

	return
end

function var_0_1.SetTotalCount(arg_25_0)
	arg_25_0.displays = arg_25_0:CollectDisplayItems()
	arg_25_0.values = {}
	ipairs = var_1

	for iter_25_0, iter_25_1 in var_1(arg_25_0.displays) do
		table = var_1_10006

		var_1_10006.insert(arg_25_0.values, 0)
	end

	local var_25_0 = arg_25_0.scrollRect

	var_1.SetTotalCount(var_25_0, #arg_25_0.displays, -1)

	setActive = var_1

	var_1(arg_25_0.emptyTF, #arg_25_0.displays == 0)

	arg_25_0.selAllFlag = false
	setActive = var_1

	var_1(arg_25_0.allFlagTF, arg_25_0.selAllFlag)

	return
end

function var_0_1.UpdateCount(arg_26_0)
	arg_26_0.totalAddCnt = 0
	ipairs = var_1

	for iter_26_0, iter_26_1 in var_1(arg_26_0.values) do
		local var_26_0 = arg_26_0.displays[iter_26_0]

		arg_26_0.totalAddCnt = arg_26_0.totalAddCnt + var_26_0.targetNum * iter_26_1
	end

	local var_26_1 = arg_26_0.itemAddTxt
	local var_26_2

	if not (arg_26_0.totalAddCnt > 0) or not ("+" .. arg_26_0.totalAddCnt) then
		var_26_2 = ""
	end

	var_26_1.text = var_26_2

	return
end

function var_0_1.OnInitItem(arg_27_0, arg_27_1)
	IslandExchangeItemCard = var_1_10002

	local var_27_0 = var_1_10002.New(arg_27_1)

	onButton = var_1_10003

	local var_27_1 = arg_27_0
	local var_27_2 = var_27_0._go

	local function var_27_3()
		local var_28_0 = arg_27_0

		var_0.UpdateCardSel(var_28_0, var_27_0, 1)

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_27_1, var_27_2, var_27_3, var_1_10008)

	onButton = var_1_10003

	local var_27_4 = arg_27_0
	local var_27_5 = var_27_0.reduceBtn

	local function var_27_6()
		local var_29_0 = arg_27_0

		var_0.UpdateCardSel(var_29_0, var_27_0, -1)

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_27_4, var_27_5, var_27_6, var_1_10008)

	onInputEndEdit = var_1_10003

	var_1_10003(arg_27_0, var_27_0.valueInput, function(arg_30_0)
		table = var_2_10001

		if not var_2_10001.indexof(arg_27_0.displays, var_27_0.item) then
			return
		end

		local var_30_0 = 0

		if arg_30_0 and arg_30_0 ~= "" then
			tonumber = var_3

			if not var_3(arg_30_0) then
				local var_30_1 = 1
			end

			tonumber = var_3

			local var_30_2 = var_3(arg_30_0) - arg_27_0.values[var_1]
			local var_30_3 = arg_27_0

			var_5.UpdateCardSel(var_30_3, var_27_0, var_30_2)

			return
		end
	end)

	pressPersistTrigger = var_1_10003

	local var_27_7 = var_27_0.calcPanel
	local var_27_8 = 0.5

	local function var_27_9()
		local var_31_0 = arg_27_0

		var_0.UpdateCardSel(var_31_0, var_27_0, 1)

		return
	end

	local var_27_10
	local var_27_11 = true
	local var_27_12 = true
	local var_27_13 = 0.1

	SFX_PANEL = var_1_10012

	var_1_10003(var_27_7, var_27_8, var_27_9, var_27_10, var_27_11, var_27_12, var_27_13, var_1_10012)

	arg_27_0.cards[arg_27_1] = var_27_0

	return
end

function var_0_1.OnUpdateItem(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0

	if not arg_32_0.cards[arg_32_2] then
		arg_32_0:OnInitItem(arg_32_2)

		var_32_0 = arg_32_0.cards[arg_32_2]
	end

	if arg_32_0.displays[arg_32_1 + 1] then
		var_32_0:Update(arg_32_0.displays[arg_32_1 + 1], arg_32_0.values[arg_32_1 + 1])
	end

	return
end

function var_0_1.UpdateCardSel(arg_33_0, arg_33_1, arg_33_2)
	table = var_1_10003

	if not var_1_10003.indexof(arg_33_0.displays, arg_33_1.item) then
		return
	end

	local var_33_0 = arg_33_0.values[var_3] + arg_33_2
	local var_33_1 = arg_33_0.values

	math = var_6

	local var_33_2 = var_6.max
	local var_33_3 = 0

	math = var_1_10009

	local var_33_4 = var_1_10009.min
	local var_33_5 = var_33_0
	local var_33_6 = arg_33_1.item

	var_33_1[var_3] = var_33_2(var_33_3, var_33_4(var_33_5, var_12.GetCount(var_33_6)))

	arg_33_1:UpdateValue(arg_33_0.values[var_3])
	arg_33_0:UpdateCount()
	arg_33_0:CheckSelAllFlag()

	return
end

function var_0_1._IsSelAll(arg_34_0)
	ipairs = var_1_10001

	for iter_34_0, iter_34_1 in var_1_10001(arg_34_0.values) do
		local var_34_0 = arg_34_0.displays[iter_34_0]

		if iter_34_1 ~= var_6.GetCount(var_34_0) then
			return false
		end
	end

	return true
end

function var_0_1.CheckSelAllFlag(arg_35_0)
	arg_35_0.selAllFlag = arg_35_0:_IsSelAll()
	setActive = var_1

	var_1(arg_35_0.allFlagTF, arg_35_0.selAllFlag)

	return
end

function var_0_1.SelecteAll(arg_36_0)
	arg_36_0.values = {}
	ipairs = var_1

	for iter_36_0, iter_36_1 in var_1(arg_36_0.displays) do
		arg_36_0.values[iter_36_0] = iter_36_1:GetCount()
	end

	local var_36_0 = arg_36_0.scrollRect

	var_1.SetTotalCount(var_36_0, #arg_36_0.displays, -1)
	arg_36_0:UpdateCount()

	arg_36_0.selAllFlag = true
	setActive = var_1

	var_1(arg_36_0.allFlagTF, arg_36_0.selAllFlag)

	return
end

function var_0_1.CollectDisplayItems(arg_37_0)
	local var_37_0 = {}

	getProxy = var_1_10002
	IslandProxy = var_1_10004

	local var_37_1 = var_1_10002(var_1_10004)
	local var_37_2 = var_2.GetIsland(var_37_1)
	local var_37_3 = var_2.GetInventoryAgency(var_37_2)

	pg = var_1_10003
	arg_37_0.showExchangeIds = var_1_10003.island_exchange_template.get_id_list_by_group[arg_37_0.showGroupId]
	arg_37_0.showItemId = var_3[arg_37_0.showExchangeIds[1]].target_item
	ipairs = var_4

	for iter_37_0, iter_37_1 in var_4(arg_37_0.showExchangeIds) do
		local var_37_4 = var_3[iter_37_1].origin_item

		if var_37_3:GetItemById(var_37_4) then
			Clone = var_1_10011
			var_1_10011 = var_1_10011(var_10)
			var_1_10011.exchangeId = iter_37_1
			var_1_10011.targetNum = var_3[iter_37_1].target_num
			table = var_12

			var_12.insert(var_37_0, var_1_10011)
		end
	end

	return var_37_0
end

function var_0_1.GetExchangeItems(arg_38_0)
	local var_38_0 = {}

	ipairs = var_1_10002

	for iter_38_0, iter_38_1 in var_1_10002(arg_38_0.values) do
		local var_38_1 = arg_38_0.displays[iter_38_0]

		if 0 < iter_38_1 then
			table = var_8

			var_8.insert(var_38_0, {
				exchangeId = var_38_1.exchangeId,
				itemId = var_38_1.id,
				num = iter_38_1
			})
		end
	end

	return var_38_0
end

function var_0_1.OnHide(arg_39_0)
	local var_39_0 = arg_39_0.itemAnim

	var_1.Stop(var_39_0)
	arg_39_0:UnBlurPanel()

	return
end

function var_0_1.OnDisable(arg_40_0)
	arg_40_0:OnHide()

	return
end

function var_0_1.OnDestroy(arg_41_0)
	arg_41_0:OnHide()

	ClearLScrollrect = var_1

	var_1(arg_41_0.scrollRect)

	pairs = var_1

	for iter_41_0, iter_41_1 in var_1(arg_41_0.cards) do
		iter_41_1:Dispose()
	end

	arg_41_0.cards = {}

	local var_41_0 = arg_41_0.itemAnimEvent

	var_1.SetTriggerEvent(var_41_0, nil)

	local var_41_1 = arg_41_0.itemAnimEvent

	var_1.SetEndEvent(var_41_1, nil)

	return
end

return var_0_1
