class = var_0_10000

local var_0_0 = "IslandBookItemPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.IslandBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandBookItemUI"
end

function var_0_1.GetIllustrationType(arg_2_0)
	IslandIllustration = var_1_10001

	return var_1_10001.TYPES.ITEM
end

function var_0_1.GetHelpTip(arg_3_0)
	i18n = var_1_10001

	return var_1_10001("island_guide_help_item")
end

function var_0_1.OnLoaded(arg_4_0)
	setText = var_1_10001

	local var_4_0 = arg_4_0._tf
	local var_4_1 = var_2.Find(var_4_0, "top/title/Text")

	i18n = var_4_0

	var_1_10001(var_4_1, var_4_0("island_guide"))

	setText = var_1_10001

	local var_4_2 = arg_4_0._tf
	local var_4_3 = var_2.Find(var_4_2, "top/title/Text/en")

	i18n = var_4_2

	var_1_10001(var_4_3, var_4_2("island_guide_en"))

	local var_4_4 = arg_4_0._tf

	arg_4_0.viewTF = var_1.Find(var_4_4, "view")
	setActive = var_1

	local var_4_5 = arg_4_0._tf

	var_1(var_2.Find(var_4_5, "tpl"), false)

	local var_4_6 = arg_4_0.viewTF

	arg_4_0.scrollRect = var_1.GetComponent(var_4_6, "LScrollRect")

	function arg_4_0.scrollRect.onInitItem(arg_5_0)
		local var_5_0 = arg_4_0

		var_1.OnInitItem(var_5_0, arg_5_0)

		return
	end

	function arg_4_0.scrollRect.onUpdateItem(arg_6_0, arg_6_1)
		local var_6_0 = arg_4_0

		var_2.OnUpdateItem(var_6_0, arg_6_0, arg_6_1)

		return
	end

	local var_4_7 = arg_4_0._tf

	arg_4_0.rightTF = var_1.Find(var_4_7, "right")

	local var_4_8 = arg_4_0.rightTF

	arg_4_0.rightNameTF = var_1.Find(var_4_8, "name")

	local var_4_9 = arg_4_0.rightTF

	arg_4_0.rightEnNameTF = var_1.Find(var_4_9, "zs/Text")

	local var_4_10 = arg_4_0.rightTF

	arg_4_0.rightDescTF = var_1.Find(var_4_10, "desc")

	local var_4_11 = arg_4_0.rightTF

	arg_4_0.rightProgressTF = var_1.Find(var_4_11, "progress")

	local var_4_12 = arg_4_0.rightTF

	arg_4_0.unlockBtn = var_1.Find(var_4_12, "unlock_btn")
	setText = var_1

	local var_4_13 = arg_4_0.unlockBtn
	local var_4_14 = var_2.Find(var_4_13, "Text")

	i18n = var_4_13

	var_1(var_4_14, var_4_13("island_guide_do_active"))

	local var_4_15 = arg_4_0.rightTF

	arg_4_0.getPointBtn = var_1.Find(var_4_15, "get_btn")
	setText = var_1

	local var_4_16 = arg_4_0.getPointBtn
	local var_4_17 = var_2.Find(var_4_16, "Text")

	i18n = var_4_16

	var_1(var_4_17, var_4_16("island_guide_collectionpoint"))

	local var_4_18 = arg_4_0._tf

	arg_4_0.pointPanel = var_1.Find(var_4_18, "point_panel")

	local var_4_19 = arg_4_0.pointPanel

	arg_4_0.pointLevelTF = var_1.Find(var_4_19, "Text")

	local var_4_20 = arg_4_0.pointPanel

	arg_4_0.pointAwardTF = var_1.Find(var_4_20, "award")

	local var_4_21 = arg_4_0.pointPanel

	arg_4_0.pointAwardIcon = var_1.Find(var_4_21, "award/icon")

	local var_4_22 = arg_4_0.pointPanel

	arg_4_0.getPointAwardBtn = var_1.Find(var_4_22, "award/get")

	local var_4_23 = arg_4_0.pointPanel

	arg_4_0.gotAllPointAwardTF = var_1.Find(var_4_23, "award/got")

	local var_4_24 = arg_4_0.pointPanel

	arg_4_0.openAwardWinBtn = var_1.Find(var_4_24, "award_btn")

	local var_4_25 = arg_4_0.pointPanel

	arg_4_0.pointSliderTF = var_1.Find(var_4_25, "slider")

	local var_4_26 = arg_4_0.pointPanel

	arg_4_0.pointProgressTF = var_1.Find(var_4_26, "slider/progress")
	IslandBookAwardListBox = var_1

	local var_4_27 = var_1.New
	local var_4_28 = arg_4_0._tf
	local var_4_29 = arg_4_0.event

	setmetatable = var_4
	arg_4_0.awardListBox = var_4_27(var_4_28, var_4_29, var_4({
		ShowMsgBox = function(arg_7_0, arg_7_1)
			local var_7_0 = arg_4_0

			var_2.ShowMsgBox(var_7_0, arg_7_1)

			return
		end,
		type = arg_4_0:GetIllustrationType()
	}, {
		__index = arg_4_0.contextData
	}))

	return
end

function var_0_1.OnInit(arg_8_0)
	onButton = var_1_10001

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0._tf
	local var_8_2 = var_3.Find(var_8_1, "top/back")

	local function var_8_3()
		local var_9_0 = arg_8_0

		var_0.Hide(var_9_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_8_0, var_8_2, var_8_3, var_5)

	onButton = var_1_10001

	local var_8_4 = arg_8_0
	local var_8_5 = arg_8_0.unlockBtn

	local function var_8_6()
		local var_10_0 = arg_8_0

		if #var_0.GetCanUnlockIds(var_10_0) > 0 then
			local var_10_1 = arg_8_0
			local var_10_2 = var_1.emit

			IslandMediator = var_2_10003

			var_10_2(var_10_1, var_2_10003.UNLOCK_ILLUSTRATION, var_0)
		end

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_8_4, var_8_5, var_8_6, var_5)

	onButton = var_1_10001

	local var_8_7 = arg_8_0
	local var_8_8 = arg_8_0.getPointBtn

	local function var_8_9()
		local var_11_0 = arg_8_0.getPointBtn
		local var_11_1 = var_0.GetComponent

		typeof = var_2_10002
		Animation = var_2_10003

		local var_11_2 = var_11_1(var_11_0, var_2_10002(var_2_10003))

		var_0.Play(var_11_2)

		local var_11_3 = arg_8_0
		local var_11_4 = var_0.emit

		IslandMediator = var_2

		var_11_4(var_11_3, var_2.GET_COLLECT_POINT, arg_8_0.canGetPointIds)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_8_7, var_8_8, var_8_9, var_5)

	onButton = var_1_10001

	local var_8_10 = arg_8_0
	local var_8_11 = arg_8_0.openAwardWinBtn

	local function var_8_12()
		local var_12_0 = arg_8_0.openAwardWinBtn
		local var_12_1 = var_0.GetComponent

		typeof = var_2_10002
		Animation = var_2_10003

		local var_12_2 = var_12_1(var_12_0, var_2_10002(var_2_10003))

		var_0.Play(var_12_2)

		local var_12_3 = arg_8_0.awardListBox

		var_0.ExecuteAction(var_12_3, "Show")

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_8_10, var_8_11, var_8_12, var_5)

	onButton = var_1_10001

	local var_8_13 = arg_8_0
	local var_8_14 = arg_8_0.getPointAwardBtn

	local function var_8_15()
		local var_13_0 = arg_8_0.pointAwardTF
		local var_13_1 = var_0.GetComponent

		typeof = var_2_10002
		Animation = var_2_10003

		local var_13_2 = var_13_1(var_13_0, var_2_10002(var_2_10003))

		var_0.Play(var_13_2)

		local var_13_3 = arg_8_0
		local var_13_4 = var_0.emit

		IslandMediator = var_2

		var_13_4(var_13_3, var_2.GET_POINT_AWARD, arg_8_0.curLevelId)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_8_13, var_8_14, var_8_15, var_5)

	onButton = var_1_10001

	local var_8_16 = arg_8_0
	local var_8_17 = arg_8_0._tf
	local var_8_18 = var_3.Find(var_8_17, "top/help")

	local function var_8_19()
		local var_14_0 = arg_8_0
		local var_14_1 = var_0.ShowMsgBox
		local var_14_2 = {}

		IslandMsgBox = var_2_10003
		var_14_2.type = var_2_10003.TYPE_WHITOUT_BTN

		local var_14_3 = arg_8_0

		var_14_2.content = var_3.GetHelpTip(var_14_3)
		i18n = var_3
		var_14_2.title = var_3("island_guide_character_help")

		var_14_1(var_14_0, var_14_2)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_8_16, var_8_18, var_8_19, var_5)

	arg_8_0.cards = {}

	return
end

function var_0_1.AddListeners(arg_15_0)
	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.AddListener

	GAME = var_1_10003

	var_15_1(var_15_0, var_1_10003.ISLAND_UNLOCK_ILLUSTRATION_DONE, arg_15_0.OnUnlockDone)

	local var_15_2 = arg_15_0
	local var_15_3 = arg_15_0.AddListener

	GAME = var_3

	var_15_3(var_15_2, var_3.ISLAND_GET_COLLECT_POINT_DONE, arg_15_0.Flush)

	local var_15_4 = arg_15_0
	local var_15_5 = arg_15_0.AddListener

	GAME = var_3

	var_15_5(var_15_4, var_3.ISLAND_GET_POINT_AWARD_DONE, arg_15_0.OnGetPointAwardDone)

	return
end

function var_0_1.RemoveListeners(arg_16_0)
	local var_16_0 = arg_16_0
	local var_16_1 = arg_16_0.RemoveListener

	GAME = var_1_10003

	var_16_1(var_16_0, var_1_10003.ISLAND_UNLOCK_ILLUSTRATION_DONE, arg_16_0.OnUnlockDone)

	local var_16_2 = arg_16_0
	local var_16_3 = arg_16_0.RemoveListener

	GAME = var_3

	var_16_3(var_16_2, var_3.ISLAND_GET_COLLECT_POINT_DONE, arg_16_0.Flush)

	local var_16_4 = arg_16_0
	local var_16_5 = arg_16_0.RemoveListener

	GAME = var_3

	var_16_5(var_16_4, var_3.ISLAND_GET_POINT_AWARD_DONE, arg_16_0.OnGetPointAwardDone)

	return
end

function var_0_1.OnInitItem(arg_17_0, arg_17_1)
	IslandIllustrationCard = var_1_10002

	local var_17_0 = var_1_10002.New(arg_17_1)
	local var_17_1 = arg_17_0.cards

	var_17_1[arg_17_1] = var_17_0
	onButton = var_17_1

	local var_17_2 = arg_17_0
	local var_17_3 = var_17_0._go

	local function var_17_4()
		pairs = var_2_10000

		for iter_18_0, iter_18_1 in var_2_10000(arg_17_0.cards) do
			iter_18_1:UpdateSelected(nil)
		end

		arg_17_0.showIllustration = var_17_0.illustration

		local var_18_0 = var_17_0

		var_0.UpdateSelected(var_18_0, arg_17_0.showIllustration.id)

		local var_18_1 = arg_17_0

		var_0.FlushRightPanel(var_18_1)

		return
	end

	SFX_PANEL = var_1_10007

	var_17_1(var_17_2, var_17_3, var_17_4, var_1_10007)

	return
end

function var_0_1.OnUpdateItem(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0

	if not arg_19_0.cards[arg_19_2] then
		arg_19_0:OnInitItem(arg_19_2)

		var_19_0 = arg_19_0.cards[arg_19_2]
	end

	if arg_19_0.showList[arg_19_1 + 1] then
		local var_19_1 = var_19_0
		local var_19_2 = var_19_0.Update
		local var_19_3 = var_4
		local var_19_4

		if arg_19_0.showIllustration then
			var_19_4 = arg_19_0.showIllustration.id
		end

		var_19_2(var_19_1, var_19_3, var_19_4)
	end

	if arg_19_0.triggerFirstCard and arg_19_1 == 0 then
		arg_19_0.triggerFirstCard = nil
		triggerButton = var_5

		var_5(var_19_0._go)
	end

	return
end

function var_0_1.OnShow(arg_20_0)
	arg_20_0.triggerFirstCard = true

	arg_20_0:Flush()

	return
end

function var_0_1.GetCanUnlockIds(arg_21_0)
	local var_21_0 = {}

	ipairs = var_1_10002

	for iter_21_0, iter_21_1 in var_1_10002(arg_21_0.showList) do
		local var_21_1 = iter_21_1
		local var_21_2 = iter_21_1.GetStatus(var_21_1)

		IslandIllustration = var_21_1

		if var_21_2 == var_21_1.STATUS.CAN_UNLOCK then
			table = var_21_2

			var_21_2.insert(var_21_0, iter_21_1.id)
		end
	end

	return var_21_0
end

function var_0_1.OnUnlockDone(arg_22_0, arg_22_1)
	pairs = var_1_10002

	for iter_22_0, iter_22_1 in var_1_10002(arg_22_0.cards) do
		iter_22_1:PlayUnlockAnim(arg_22_1.ids)
	end

	arg_22_0:Flush()

	return
end

function var_0_1.OnGetPointAwardDone(arg_23_0, arg_23_1)
	local var_23_0

	if not arg_23_1.dropData.abilitys then
		var_23_0 = {}
	end

	ipairs = var_1_10003

	for iter_23_0, iter_23_1 in var_1_10003(var_23_0) do
		pg = var_1_10008
		var_1_10008 = var_1_10008.island_ability_template[iter_23_1.id].unlock_text
		pg = var_9

		local var_23_1 = var_9.TipsMgr.GetInstance()

		var_9.ShowTips(var_23_1, var_1_10008)
	end

	arg_23_0:Flush()

	return
end

function var_0_1.Flush(arg_24_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10002

	local var_24_0 = var_1_10001(var_1_10002)
	local var_24_1 = var_1.GetIsland(var_24_0)

	arg_24_0.bookAgency = var_1.GetBookAgency(var_24_1)

	local var_24_2 = arg_24_0.bookAgency

	arg_24_0.showList = var_1.GetListByType(var_24_2, arg_24_0:GetIllustrationType())
	table = var_1

	local var_24_3 = var_1.sort
	local var_24_4 = arg_24_0.showList

	CompareFuncs = var_3

	var_24_3(var_24_4, var_3({
		function(arg_25_0)
			local var_25_0 = arg_25_0
			local var_25_1 = arg_25_0.GetStatus(var_25_0)

			IslandIllustration = var_25_0

			return var_25_1 == var_25_0.STATUS.CAN_UNLOCK and 0 or 1
		end,
		function(arg_26_0)
			pg = var_2_10001

			return var_2_10001.island_illustrated_guide[arg_26_0.id].order
		end,
		function(arg_27_0)
			return arg_27_0.id
		end
	}))

	local var_24_5 = arg_24_0.scrollRect

	var_1.SetTotalCount(var_24_5, #arg_24_0.showList, -1)
	arg_24_0:FlushRightPanel()
	arg_24_0:FlushPointAwardInfos()
	arg_24_0:FlushPointInfos()

	return
end

function var_0_1.FlushRightPanel(arg_28_0)
	if not arg_28_0.showIllustration then
		return
	end

	local var_28_0 = arg_28_0.showIllustration
	local var_28_1 = var_1.GetStatus(var_28_0)

	setText = var_28_0

	local var_28_2 = arg_28_0.rightNameTF
	local var_28_3 = arg_28_0.showIllustration

	var_28_0(var_28_2, var_4.GetName(var_28_3))

	setText = var_28_0

	local var_28_4 = arg_28_0.rightEnNameTF
	local var_28_5 = arg_28_0.showIllustration

	var_28_0(var_28_4, var_4.GetEnName(var_28_5))

	IslandIllustration = var_28_0

	if var_28_1 == var_28_0.STATUS.UNLOCK then
		local var_28_6 = arg_28_0.showIllustration

		if not var_28_4.GetDesc(var_28_6) then
			i18n = var_28_4
			var_28_4 = var_28_4("island_guide_lock_desc")
		end

		setText = var_28_6

		var_28_6(arg_28_0.rightDescTF, var_28_4)

		setActive = var_28_6

		local var_28_7 = arg_28_0.unlockBtn

		IslandIllustration = var_6

		var_28_6(var_28_7, var_28_1 == var_6.STATUS.CAN_UNLOCK)
		arg_28_0:FlushOnlyItem()

		return
	end
end

function var_0_1.FlushOnlyItem(arg_29_0)
	local var_29_0 = arg_29_0
	local var_29_1 = arg_29_0.GetIllustrationType(var_29_0)

	IslandIllustration = var_29_0

	local var_29_2 = var_29_1 == var_29_0.TYPES.ITEM

	setActive = var_2

	var_2(arg_29_0.rightProgressTF, var_29_2)

	if var_29_2 then
		local var_29_3 = arg_29_0.showIllustration
		local var_29_4 = var_2.GetHistoryCnt(var_29_3)
		local var_29_5 = arg_29_0.showIllustration
		local var_29_6 = var_3.GetCurTarget(var_29_5)

		setText = var_29_5

		local var_29_7 = arg_29_0.rightProgressTF
		local var_29_8

		if not var_29_6 or not (var_29_4 .. "/" .. var_29_6) then
			var_29_8 = var_29_4
		end

		var_29_5(var_29_7, var_29_8)
	end

	return
end

function var_0_1.FlushPointAwardInfos(arg_30_0)
	local var_30_0 = arg_30_0:GetIllustrationType()
	local var_30_1 = arg_30_0.bookAgency

	arg_30_0.pointAwardGotIds = var_2.GetPointAwardGotIds(var_30_1, var_30_0)

	local var_30_2 = arg_30_0.bookAgency

	arg_30_0.curLevelId = var_2.GetCurLevelPointAwardId(var_30_2, var_30_0)
	pg = var_2
	arg_30_0.awardConfig = var_2.island_collection_reward[arg_30_0.curLevelId]
	setText = var_2

	local var_30_3 = arg_30_0.pointLevelTF

	i18n = var_4

	var_2(var_30_3, var_4("island_book_collection_award_title", arg_30_0.awardConfig.level))

	local var_30_4 = arg_30_0.bookAgency
	local var_30_5, var_30_6 = var_2.GetCurPointInfos(var_30_4, var_30_0)

	arg_30_0.targetPoint = var_30_6
	arg_30_0.curPoint = var_30_5
	setText = var_30_5

	var_30_5(arg_30_0.pointProgressTF, arg_30_0.curPoint .. "/" .. arg_30_0.targetPoint)

	setSlider = var_30_5

	var_30_5(arg_30_0.pointSliderTF, 0, 1, arg_30_0.curPoint / arg_30_0.targetPoint)

	local var_30_7 = arg_30_0.bookAgency
	local var_30_8 = var_2.IsGotAllPointAward(var_30_7, var_30_0)

	setActive = var_30_7

	var_30_7(arg_30_0.gotAllPointAwardTF, var_30_8)

	setActive = var_30_7

	var_30_7(arg_30_0.getPointAwardBtn, not var_30_8 and arg_30_0.curPoint >= arg_30_0.targetPoint)

	Drop = var_30_7

	local var_30_9 = var_30_7.Create(arg_30_0.awardConfig.award_display)

	GetImageSpriteFromAtlasAsync = var_4

	var_4(var_30_9:getIcon(), "", arg_30_0.pointAwardIcon)

	return
end

function var_0_1.FlushPointInfos(arg_31_0)
	arg_31_0.canGetPointIds = {}
	ipairs = var_1

	for iter_31_0, iter_31_1 in var_1(arg_31_0.showList) do
		local var_31_0 = iter_31_1
		local var_31_1 = iter_31_1.GetStatus(var_31_0)

		IslandIllustration = var_31_0

		if var_31_1 == var_31_0.STATUS.UNLOCK and iter_31_1:IsTip() then
			table = var_6

			var_6.insert(arg_31_0.canGetPointIds, iter_31_1.id)
		end
	end

	setActive = var_1

	var_1(arg_31_0.getPointBtn, #arg_31_0.canGetPointIds > 0)

	return
end

function var_0_1.OnDestroy(arg_32_0)
	ClearLScrollrect = var_1_10001

	var_1_10001(arg_32_0.scrollRect)

	pairs = var_1_10001

	for iter_32_0, iter_32_1 in var_1_10001(arg_32_0.cards) do
		iter_32_1:Dispose()
	end

	arg_32_0.cards = {}

	if arg_32_0.awardListBox then
		local var_32_0 = arg_32_0.awardListBox

		var_1.Destroy(var_32_0)

		arg_32_0.awardListBox = nil
	end

	return
end

return var_0_1
