class = var_0_10000

local var_0_0 = "NewEducateTarotEntryLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.newEducate.base.NewEducateBaseUI"))

var_0_1.TYPE = {
	SHOP = 2,
	DROP = 3,
	NORMAL = 1
}

function var_0_1.getUIName(arg_1_0)
	return "NewEducateTarotEntryUI"
end

function var_0_1.init(arg_2_0)
	NewEducateTopProgress = var_1_10001

	local var_2_0 = var_1_10001.New
	local var_2_1 = arg_2_0._tf

	arg_2_0.progressPart = var_2_0(var_3.Find(var_2_1, "progress"), arg_2_0)
	NewEducateTopRes = var_1

	local var_2_2 = var_1.New
	local var_2_3 = arg_2_0._tf

	arg_2_0.resPart = var_2_2(var_3.Find(var_2_3, "res"), arg_2_0)

	local var_2_4 = arg_2_0._tf

	arg_2_0.toggleTF = var_1.Find(var_2_4, "toggle")
	setText = var_1

	local var_2_5 = arg_2_0.toggleTF
	local var_2_6 = var_3.Find(var_2_5, "Text")

	i18n = var_4

	var_1(var_2_6, var_4("child2_show_detail_desc"))

	local var_2_7 = arg_2_0._tf

	arg_2_0.tarotTF = var_1.Find(var_2_7, "tarot")
	NewEducateTarotCard = var_1
	arg_2_0.tarotCard = var_1.New(arg_2_0.tarotTF)
	setText = var_1

	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_3.Find(var_2_8, "all/Text")

	i18n = var_4

	var_1(var_2_9, var_4("child2_all_entry_title"))

	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_1.Find(var_2_10, "all/value")
	local var_2_12 = var_1.GetComponent

	typeof = var_4
	Text = var_6
	arg_2_0.allEntryCntText = var_2_12(var_2_11, var_4(var_6))

	local var_2_13 = arg_2_0._tf
	local var_2_14 = var_1.Find(var_2_13, "view/content")

	arg_2_0.scrollRect = var_1.GetComponent(var_2_14, "LScrollRect")

	local var_2_15 = arg_2_0._tf

	arg_2_0.detailTF = var_1.Find(var_2_15, "detail")
	NewEducateEntryCard = var_1

	local var_2_16 = var_1.New
	local var_2_17 = arg_2_0.detailTF

	arg_2_0.detailEntryCard = var_2_16(var_3.Find(var_2_17, "entry"))

	local var_2_18 = arg_2_0.detailTF
	local var_2_19 = var_1.Find(var_2_18, "level/Text")
	local var_2_20 = var_1.GetComponent

	typeof = var_4
	Text = var_6
	arg_2_0.detailLevelText = var_2_20(var_2_19, var_4(var_6))

	local var_2_21 = arg_2_0._tf

	arg_2_0.upgradeTF = var_1.Find(var_2_21, "upgrade")

	local var_2_22 = arg_2_0.upgradeTF

	arg_2_0.upgradeBtn = var_1.Find(var_2_22, "btn")
	setText = var_1

	local var_2_23 = arg_2_0.upgradeBtn
	local var_2_24 = var_3.Find(var_2_23, "Text")

	i18n = var_4

	var_1(var_2_24, var_4("child2_word_upgrade"))

	local var_2_25 = arg_2_0._tf

	arg_2_0.giveupBtn = var_1.Find(var_2_25, "giveup")
	setText = var_1

	local var_2_26 = arg_2_0.giveupBtn
	local var_2_27 = var_3.Find(var_2_26, "Text")

	i18n = var_4

	var_1(var_2_27, var_4("child2_word_giveup"))

	local var_2_28 = arg_2_0._tf

	arg_2_0.goBtn = var_1.Find(var_2_28, "go")
	setText = var_1

	local var_2_29 = arg_2_0.goBtn
	local var_2_30 = var_3.Find(var_2_29, "Text")

	i18n = var_4

	var_1(var_2_30, var_4("child2_go_shop"))

	local var_2_31 = arg_2_0._tf

	arg_2_0.summaryTF = var_1.Find(var_2_31, "summary")

	local var_2_32 = arg_2_0.summaryTF

	arg_2_0.summaryToggleTF = var_1.Find(var_2_32, "toggle")
	UIItemList = var_1

	local var_2_33 = var_1.New
	local var_2_34 = arg_2_0.summaryTF
	local var_2_35 = var_3.Find(var_2_34, "list")
	local var_2_36 = arg_2_0.summaryTF

	arg_2_0.pctUIList = var_2_33(var_2_35, var_4.Find(var_2_36, "list/tpl"))
	getProxy = var_1
	PlayerProxy = var_2_35

	local var_2_37 = var_1(var_2_35)

	arg_2_0.playerID = var_1.getRawData(var_2_37).id

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0:BlurPanel(arg_3_0._tf, {
		groupDelta = 3
	})

	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.progressPart._tf
	local var_3_2 = var_4.Find(var_3_1, "back")

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.onBackPressed(var_4_0)

		return
	end

	SFX_PANEL = var_3_1

	var_1(var_3_0, var_3_2, var_3_3, var_3_1)

	onToggle = var_1

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0.toggleTF

	local function var_3_6(arg_5_0)
		NewEducateHelper = var_2_10001

		var_2_10001.SetTarotDeatilDescData(arg_5_0)

		local var_5_0 = arg_3_0

		var_1.SwitchDescMode(var_5_0, arg_5_0)

		return
	end

	SFX_PANEL = var_3_1

	var_1(var_3_4, var_3_5, var_3_6, var_3_1)

	onButton = var_1

	local var_3_7 = arg_3_0
	local var_3_8 = arg_3_0.giveupBtn

	local function var_3_9()
		local var_6_0 = arg_3_0
		local var_6_1 = var_0.emit

		NewEducateTarotEntryMediator = var_2_10003

		var_6_1(var_6_0, var_2_10003.ON_GIVE_UP_ENTRY_UP)

		return
	end

	SFX_PANEL = var_3_1

	var_1(var_3_7, var_3_8, var_3_9, var_3_1)

	onButton = var_1

	local var_3_10 = arg_3_0
	local var_3_11 = arg_3_0.upgradeBtn

	local function var_3_12()
		seriesAsync = var_2_10000

		var_2_10000({
			function(arg_8_0)
				if arg_3_0.type == var_0_1.TYPE.SHOP then
					local var_8_0 = arg_3_0
					local var_8_1 = var_1.emit

					NewEducateTarotEntryMediator = var_3_10004

					var_8_1(var_8_0, var_3_10004.ON_SHOPPING, arg_3_0.contextData.goodId, arg_8_0)
				else
					arg_8_0()
				end

				return
			end
		}, function(arg_9_0)
			arg_3_0.showpDrops = arg_9_0 or {}

			local var_9_0 = arg_3_0
			local var_9_1 = var_1.emit

			NewEducateTarotEntryMediator = var_3_10004

			var_9_1(var_9_0, var_3_10004.ON_UPGRADE_ENTRY, arg_3_0.selectId)

			return
		end)

		return
	end

	SFX_PANEL = var_3_1

	var_1(var_3_10, var_3_11, var_3_12, var_3_1)

	onButton = var_1

	local var_3_13 = arg_3_0
	local var_3_14 = arg_3_0.goBtn

	local function var_3_15()
		local var_10_0 = arg_3_0.contextData.char
		local var_10_1 = var_0.GetFSM(var_10_0)

		if var_0.CheckPriorityStystem(var_10_1) then
			pg = var_0

			local var_10_2 = var_0.TipsMgr.GetInstance()
			local var_10_3 = var_0.ShowTips

			i18n = var_2_10003

			var_10_3(var_10_2, var_2_10003("child2_priority_tip"))

			return
		end

		local var_10_4 = arg_3_0
		local var_10_5 = var_0.emit
		local var_10_6 = var_0_1.GO_SCENE

		SCENE = var_2_10004

		var_10_5(var_10_4, var_10_6, var_2_10004.NEW_EDUCATE_MAP, {
			openShop = true
		})

		return
	end

	SFX_PANEL = var_3_1

	var_1(var_3_13, var_3_14, var_3_15, var_3_1)

	onButton = var_1

	local var_3_16 = arg_3_0
	local var_3_17 = arg_3_0._tf
	local var_3_18 = var_4.Find(var_3_17, "tip")

	local function var_3_19()
		pg = var_2_10000

		local var_11_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_11_1 = var_0.ShowMsgBox
		local var_11_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_11_2.type = var_2_10004
		pg = var_2_10004
		var_11_2.helps = var_2_10004.gametip.child2_choose_help.tip

		var_11_1(var_11_0, var_11_2)

		return
	end

	SFX_PANEL = var_3_17

	var_1(var_3_16, var_3_18, var_3_19, var_3_17)

	onToggle = var_1

	local var_3_20 = arg_3_0
	local var_3_21 = arg_3_0.summaryToggleTF

	local function var_3_22(arg_12_0)
		if arg_12_0 then
			i18n = var_2_10001

			if not var_2_10001("child2_benefit_summary2") then
				i18n = var_2_10001
				var_2_10001 = var_2_10001("child2_benefit_summary")
			end

			setText = var_2_10002

			local var_12_0 = arg_3_0.summaryToggleTF

			var_2_10002(var_4.Find(var_12_0, "Text"), var_2_10001)

			local var_12_1 = arg_3_0.pctUIList

			var_2.align(var_12_1, #arg_3_0.showPctList)

			PlayerPrefs = var_2

			local var_12_2 = var_2.SetInt
			local var_12_3 = arg_3_0

			var_12_2(var_4.GetBenefitShowLocalKey(var_12_3), arg_12_0 and 1 or 0)

			return
		end
	end

	SFX_PANEL = var_3_17

	var_1(var_3_20, var_3_21, var_3_22, var_3_17)

	local var_3_23 = arg_3_0.pctUIList

	var_1.make(var_3_23, function(arg_13_0, arg_13_1, arg_13_2)
		local var_13_0 = arg_3_0.showPctList[arg_13_1 + 1].drop

		NewEducateHelper = var_4

		local var_13_1 = var_4.GetDropConfig(var_13_0)

		UIItemList = var_2_10005

		if arg_13_0 == var_2_10005.EventInit then
			LoadImageSpriteAtlasAsync = var_5

			var_5("ui/neweducatecommonui_atlas", var_13_1.icon, arg_13_2:Find("Image"), true)
		else
			UIItemList = var_5

			if arg_13_0 == var_5.EventUpdate then
				local var_13_2 = arg_3_0.summaryToggleTF
				local var_13_3 = var_5.GetComponent

				typeof = var_2_10008
				Toggle = var_2_10010

				local var_13_4 = var_13_3(var_13_2, var_2_10008(var_2_10010)).isOn
				local var_13_5 = arg_3_0.showPctList[arg_13_1 + 1].a
				local var_13_6 = arg_3_0.showPctList[arg_13_1 + 1].b

				setText = var_8

				var_8(arg_13_2:Find("Text"), (var_13_4 and var_13_6 or var_13_5) .. "%")

				setText = var_8

				local var_13_7 = arg_13_2

				var_8(arg_13_2.Find(var_13_7, "info/content/name"), var_13_1.name)

				i18n = var_8

				local var_13_8 = var_8("child2_benefit_summary")
				local var_13_9 = var_13_5
				local var_13_10 = "%"
				local var_13_11 = "\n"

				i18n = var_13_7

				local var_13_12 = var_13_8 .. var_13_9 .. var_13_10 .. var_13_11 .. var_13_7("child2_benefit_summary2") .. var_13_6 .. "%"

				setText = var_13_9

				var_13_9(arg_13_2:Find("info/content/desc"), var_13_12)

				local var_13_13 = arg_3_0.contextData.char
				local var_13_14 = var_9.GetOwnCnt(var_13_13, var_13_0)
				local var_13_15 = var_13_0.type

				NewEducateConst = var_13_13

				if var_13_15 == var_13_13.DROP_TYPE.ATTR then
					NewEducateInfoPanel = var_13_15

					local var_13_16

					var_13_15, var_13_16 = var_13_15.GetArrtInfo(var_13_1.rank, var_13_14)
					setText = var_12

					var_12(arg_13_2:Find("info/content/value"), var_13_16)
				else
					setText = var_13_15

					var_13_15(arg_13_2:Find("info/content/value"), var_13_14)
				end
			end
		end

		return
	end)

	function arg_3_0.scrollRect.onInitItem(arg_14_0)
		local var_14_0 = arg_3_0

		var_1.OnInitItem(var_14_0, arg_14_0)

		return
	end

	function arg_3_0.scrollRect.onUpdateItem(arg_15_0, arg_15_1)
		local var_15_0 = arg_3_0

		var_2.OnUpdateItem(var_15_0, arg_15_0, arg_15_1)

		return
	end

	arg_3_0.cards = {}
	arg_3_0.triggerFirstCard = true
	pg = var_1
	arg_3_0.config = var_1.child2_benefit_list

	local var_3_24

	if not arg_3_0.contextData.type then
		var_3_24 = var_0_1.TYPE.NORMAL
	end

	arg_3_0.type = var_3_24

	arg_3_0:UpdateView()

	triggerToggle = var_1

	local var_3_25 = arg_3_0.toggleTF

	NewEducateHelper = var_4

	var_1(var_3_25, var_4.IsShowTarotDeatilDesc())

	return
end

function var_0_1.GetBenefitShowLocalKey(arg_16_0)
	NewEducateConst = var_1_10001

	return var_1_10001.NEW_EDUCATE_BENEFIT_SHOW_MAX .. "_" .. arg_16_0.playerID .. "_" .. arg_16_0.contextData.char.id
end

function var_0_1.UpdateView(arg_17_0)
	local var_17_0 = arg_17_0.progressPart

	var_1.Update(var_17_0, arg_17_0.contextData.char)

	local var_17_1 = arg_17_0.resPart

	var_1.Update(var_17_1, arg_17_0.contextData.char)

	local var_17_2 = arg_17_0.contextData.char

	arg_17_0.tarotId = var_1.GetTarotId(var_17_2)

	local var_17_3 = arg_17_0.contextData.char
	local var_17_4 = var_1.GetBenefitData(var_17_3)
	local var_17_5 = var_1.GetListByType

	NewEducateBuff = var_4
	arg_17_0.entries = var_17_5(var_17_4, var_4.TYPE.ENTRY)

	arg_17_0:UpdateTarotPanel()
	arg_17_0:UpdateSummary()
	arg_17_0:UpdateBtns()

	local var_17_6 = arg_17_0.scrollRect

	var_1.SetTotalCount(var_17_6, #arg_17_0.entries)

	if #arg_17_0.entries == 0 then
		setActive = var_1

		var_1(arg_17_0.detailTF, false)

		setActive = var_1

		var_1(arg_17_0.upgradeTF, false)
	end

	return
end

function var_0_1.UpdateTarotPanel(arg_18_0)
	setActive = var_1_10001

	var_1_10001(arg_18_0.tarotCard._tf, arg_18_0.tarotId)

	if arg_18_0.tarotId then
		local var_18_0 = arg_18_0.tarotCard
		local var_18_1 = var_1.Update
		local var_18_2 = arg_18_0.tarotId

		NewEducateTarotCard = var_1_10005

		var_18_1(var_18_0, var_18_2, var_1_10005.TYPE.CURRENT)
	end

	return
end

function var_0_1.UpdateRight(arg_19_0)
	local var_19_0 = arg_19_0.type ~= var_0_1.TYPE.NORMAL and arg_19_0.config[arg_19_0.selectId].next_level ~= 0

	setActive = var_2

	var_2(arg_19_0.upgradeTF, var_19_0)

	setActive = var_2

	var_2(arg_19_0.detailTF, not var_19_0)

	if var_19_0 then
		arg_19_0:UpdataUpgrade()
	else
		arg_19_0:UpdataDetail()
	end

	return
end

function var_0_1.UpdataUpgrade(arg_20_0)
	setActive = var_1_10001

	local var_20_0 = arg_20_0.upgradeBtn

	var_1_10001(var_3.Find(var_20_0, "res"), arg_20_0.type == var_0_1.TYPE.SHOP)

	if arg_20_0.type == var_0_1.TYPE.SHOP then
		setText = var_1

		local var_20_1 = arg_20_0.upgradeBtn

		var_1(var_3.Find(var_20_1, "res/Text"), "-" .. arg_20_0.contextData.cost)
	end

	local var_20_2 = arg_20_0.config[arg_20_0.selectId]

	setText = var_2

	local var_20_3 = arg_20_0.upgradeTF

	var_2(var_4.Find(var_20_3, "name"), var_20_2.name)

	setText = var_2

	local var_20_4 = arg_20_0.upgradeTF

	var_2(var_4.Find(var_20_4, "before/level/Text"), "LV." .. var_20_2.benefit_level)

	setText = var_2

	local var_20_5 = arg_20_0.upgradeTF

	var_2(var_4.Find(var_20_5, "before/desc/Text"), var_20_2.desc)

	local var_20_6 = var_20_2.next_level

	setText = var_3

	local var_20_7 = arg_20_0.upgradeTF

	var_3(var_5.Find(var_20_7, "after/level/Text"), "LV." .. arg_20_0.config[var_20_6].benefit_level)

	setText = var_3

	local var_20_8 = arg_20_0.upgradeTF

	var_3(var_5.Find(var_20_8, "after/desc/Text"), var_20_2.upgrade_desc)

	return
end

function var_0_1.UpdataDetail(arg_21_0)
	setActive = var_1_10001

	var_1_10001(arg_21_0.detailTF, arg_21_0.selectId)

	if arg_21_0.selectId then
		arg_21_0.detailLevelText.text = "Lv." .. arg_21_0.config[arg_21_0.selectId].benefit_level

		local var_21_0 = arg_21_0.detailEntryCard

		var_1.Update(var_21_0, arg_21_0.selectId)

		local var_21_1 = arg_21_0.detailEntryCard

		var_1.UpdateCountDesc(var_21_1)

		local var_21_2 = arg_21_0.detailEntryCard
		local var_21_3 = var_1.UpdateDescMode
		local var_21_4 = arg_21_0.toggleTF
		local var_21_5 = var_4.GetComponent

		typeof = var_1_10007
		Toggle = var_1_10009

		var_21_3(var_21_2, var_21_5(var_21_4, var_1_10007(var_1_10009)).isOn)
	end

	return
end

function var_0_1.UpdateSummary(arg_22_0)
	underscore = var_1_10001

	local var_22_0 = var_1_10001.select
	local var_22_1 = arg_22_0.contextData.char
	local var_22_2 = var_3.GetPermanentData(var_22_1)
	local var_22_3 = var_22_0(var_3.GetAllBuffIds(var_22_2), function(arg_23_0)
		local var_23_0 = arg_22_0.config[arg_23_0].type

		NewEducateBuff = var_2_10002

		local var_23_1

		if var_23_0 == var_2_10002.TYPE.ENTRY then
			NewEducateBuff = var_23_0
			var_23_1 = var_23_0.IsVisible(arg_23_0)
		else
			var_23_1 = false
		end

		if false then
			var_23_1 = true
		end

		return var_23_1
	end)

	arg_22_0.allEntryCntText.text = #arg_22_0.entries .. "/" .. #var_22_3

	local var_22_4 = arg_22_0.contextData.char
	local var_22_5 = var_2.GetBenefitData(var_22_4)

	arg_22_0.showPctList = {}
	ipairs = var_3
	NewEducateBenefit = var_5

	for iter_22_0, iter_22_1 in var_3(var_5.GetDisplayPctList(arg_22_0.contextData.char)) do
		local var_22_6 = var_22_5
		local var_22_7, var_22_8 = var_22_5.GetDisplayPctByDrop(var_22_6, iter_22_1)

		table = var_22_6

		var_22_6.insert(arg_22_0.showPctList, {
			drop = iter_22_1,
			a = var_22_7,
			b = var_22_8
		})
	end

	PlayerPrefs = var_3

	local var_22_9 = var_3.GetInt(arg_22_0:GetBenefitShowLocalKey())

	triggerToggle = var_4

	var_4(arg_22_0.summaryToggleTF, var_22_9 == 1)

	return
end

function var_0_1.UpdateBtns(arg_24_0)
	setActive = var_1_10001

	var_1_10001(arg_24_0.giveupBtn, arg_24_0.type == var_0_1.TYPE.DROP)

	setActive = var_1_10001

	var_1_10001(arg_24_0.goBtn, arg_24_0:GetGoBtnVisibility())

	return
end

function var_0_1.GetGoBtnVisibility(arg_25_0)
	if arg_25_0.type ~= var_0_1.TYPE.NORMAL then
		return false
	end

	local var_25_0 = arg_25_0.contextData.char

	if not var_1.IsUnlock(var_25_0, "shop") then
		return false
	end

	local var_25_1 = arg_25_0.contextData.char
	local var_25_2 = var_1.GetFSM(var_25_1)
	local var_25_3 = var_1.CheckStystem(var_25_2)

	NewEducateFSM = var_2

	if var_25_3 == var_2.SYSTEM.ENDING then
		return false
	end

	local var_25_4 = arg_25_0.contextData.char
	local var_25_5 = var_1.GetFSM(var_25_4)
	local var_25_6 = var_1.GetSystemNo(var_25_5)

	NewEducateFSM = var_2

	if var_25_6 == var_2.SYSTEM.ENDING then
		return false
	end

	if arg_25_0.contextData.inShop then
		return false
	end

	return true
end

function var_0_1.OnInitItem(arg_26_0, arg_26_1)
	NewEducateEntryCard = var_1_10002

	local var_26_0 = var_1_10002.New(arg_26_1)

	arg_26_0.cards[arg_26_1] = var_26_0

	return
end

function var_0_1.OnUpdateItem(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0

	if not arg_27_0.cards[arg_27_2] then
		arg_27_0:OnInitItem(arg_27_2)

		var_27_0 = arg_27_0.cards[arg_27_2]
	end

	local var_27_1 = arg_27_0.entries[arg_27_1 + 1].id

	var_27_0:Update(var_27_1)

	setActive = var_5

	local var_27_2 = var_27_0._tf

	var_5(var_7.Find(var_27_2, "sel"), false)

	onButton = var_5

	local var_27_3 = arg_27_0
	local var_27_4 = var_27_0._go

	local function var_27_5()
		pairs = var_2_10000

		for iter_28_0, iter_28_1 in var_2_10000(arg_27_0.cards) do
			setActive = var_2_10005

			local var_28_0 = iter_28_1._tf

			var_2_10005(var_7.Find(var_28_0, "sel"), false)
		end

		local var_28_1 = arg_27_0

		var_28_1.selectId = var_27_1
		setActive = var_28_1

		local var_28_2 = var_27_0._tf

		var_28_1(var_2.Find(var_28_2, "sel"), true)

		if not arg_27_0.triggerFirstCard then
			setActive = var_0

			local var_28_3 = var_27_0._tf

			var_0(var_2.Find(var_28_3, "sel"), true)

			local var_28_4 = var_27_0._tf
			local var_28_5 = var_0.Find(var_28_4, "sel")
			local var_28_6 = var_0.GetComponent

			typeof = var_3
			Animation = var_5

			local var_28_7 = var_28_6(var_28_5, var_3(var_5))

			var_0.Play(var_28_7, "Anim_NewEducateTarotEntryUI_tpl_sel")
		end

		local var_28_8 = arg_27_0

		var_0.UpdateRight(var_28_8)

		return
	end

	SFX_PANEL = var_10

	var_5(var_27_3, var_27_4, var_27_5, var_10)

	if arg_27_0.triggerFirstCard and arg_27_1 == 0 then
		triggerButton = var_5

		var_5(var_27_0._go)

		arg_27_0.triggerFirstCard = nil
	end

	return
end

function var_0_1.SwitchDescMode(arg_29_0, arg_29_1)
	if arg_29_0.tarotId then
		local var_29_0 = arg_29_0.tarotCard

		var_2.UpdateDescMode(var_29_0, arg_29_1)
	end

	if arg_29_0.selectId then
		local var_29_1 = arg_29_0.detailEntryCard

		var_2.UpdateDescMode(var_29_1, arg_29_1)
	end

	pairs = var_2

	for iter_29_0, iter_29_1 in var_2(arg_29_0.cards) do
		iter_29_1:UpdateDescMode(arg_29_1)
	end

	return
end

function var_0_1.OnUpgradeDone(arg_30_0, arg_30_1)
	pairs = var_1_10002

	for iter_30_0, iter_30_1 in var_1_10002(arg_30_0.cards) do
		if iter_30_1.id == arg_30_1.entryId then
			local var_30_0 = iter_30_1._tf
			local var_30_1 = var_7.Find(var_30_0, "sel")
			local var_30_2 = var_7.GetComponent

			typeof = var_10
			Animation = var_1_10012

			local var_30_3 = var_30_2(var_30_1, var_10(var_1_10012))

			var_7.Play(var_30_3, "Anim_NewEducateTarotEntryUI_tpl_sel2")
		end
	end

	seriesAsync = var_2

	var_2({
		function(arg_31_0)
			onDelayTick = var_2_10001

			var_2_10001(arg_31_0, 0.2)

			return
		end,
		function(arg_32_0)
			if #arg_30_1.drops > 0 or #arg_30_0.showpDrops > 0 then
				local var_32_0 = arg_30_0
				local var_32_1 = var_1.emit
				local var_32_2 = var_0_1.ON_DROP
				local var_32_3 = {}

				table = var_2_10006
				var_32_3.items = var_2_10006.mergeArray(arg_30_1.drops, arg_30_0.showpDrops)
				var_32_3.removeFunc = arg_32_0

				var_32_1(var_32_0, var_32_2, var_32_3)

				arg_30_0.showpDrops = {}
			else
				arg_32_0()
			end

			return
		end
	}, function()
		local var_33_0 = arg_30_0

		var_0.closeView(var_33_0)

		return
	end)

	return
end

function var_0_1.onBackPressed(arg_34_0)
	if arg_34_0.type == var_0_1.TYPE.DROP then
		return
	end

	arg_34_0:closeView()

	return
end

function var_0_1.willExit(arg_35_0)
	ClearLScrollrect = var_1_10001

	var_1_10001(arg_35_0.scrollRect)

	pairs = var_1_10001

	for iter_35_0, iter_35_1 in var_1_10001(arg_35_0.cards) do
		iter_35_1:Dispose()
	end

	arg_35_0.cards = {}

	local var_35_0 = arg_35_0.tarotCard

	var_1.Dispose(var_35_0)

	local var_35_1 = arg_35_0.detailEntryCard

	var_1.Dispose(var_35_1)

	local var_35_2 = arg_35_0.progressPart

	var_1.Dispose(var_35_2)

	local var_35_3 = arg_35_0.resPart

	var_1.Dispose(var_35_3)
	arg_35_0:UnOverlayPanel(arg_35_0._tf)

	existCall = var_1

	var_1(arg_35_0.contextData.onExit)

	return
end

return var_0_1
