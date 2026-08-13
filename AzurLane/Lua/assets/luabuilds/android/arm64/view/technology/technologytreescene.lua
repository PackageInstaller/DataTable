class = var_0_10000

local var_0_0 = "TechnologyTreeScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

var_0_1.NationTrige = {
	All = 0,
	Mot = 3,
	Meta = 2,
	Other = 1
}
var_0_1.TypeTrige = {
	All = 0,
	Other = 1
}

function var_0_1.getUIName(arg_1_0)
	return "TechnologyTreeUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:initNationToggleUIList()
	arg_2_0:initTecClassUIList()

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0:initTypeToggleUIList()
	arg_3_0:updateTecItemList()
	arg_3_0:addBtnListener()

	setText = var_1

	var_1(arg_3_0.pointNumText, arg_3_0.point)

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.updateRedPoint

	getProxy = var_4
	TechnologyNationProxy = var_1_10006

	local var_3_2 = var_4(var_1_10006)

	var_3_1(var_3_0, var_4.getShowRedPointTag(var_3_2))

	PlayerPrefs = var_3_1

	if not var_3_1.HasKey("first_comein_technologytree") then
		triggerButton = var_1

		var_1(arg_3_0.helpBtn)

		PlayerPrefs = var_1

		var_1.SetInt("first_comein_technologytree", 1)

		PlayerPrefs = var_1

		var_1.Save()
	end

	return
end

function var_0_1.updateRedPoint(arg_4_0, arg_4_1)
	setActive = var_1_10002

	var_1_10002(arg_4_0.redPointImg, arg_4_1)

	return
end

function var_0_1.willExit(arg_5_0)
	arg_5_0:UnOverlayPanel(arg_5_0.blurPanel, arg_5_0._tf)

	arg_5_0.rightLSC.onReturnItem = nil

	if arg_5_0.emptyPage then
		local var_5_0 = arg_5_0.emptyPage

		var_1.Destroy(var_5_0)

		arg_5_0.emptyPage = nil
	end

	return
end

function var_0_1.initData(arg_6_0)
	TechnologyConst = var_1_10001

	var_1_10001.CreateMetaClassConfig()

	arg_6_0.nationToggleList = {}
	arg_6_0.typeToggleList = {}
	arg_6_0.nationSelectedList = {}
	arg_6_0.typeSelectedList = {}
	arg_6_0.nationSelectedCount = 0
	arg_6_0.typeSelectedCount = 0
	arg_6_0.lastNationTrige = nil
	arg_6_0.lastTypeTrige = nil
	arg_6_0.countInEveryRow = 5
	getProxy = var_1
	CollectionProxy = var_1_10003
	arg_6_0.collectionProxy = var_1(var_1_10003)
	getProxy = var_1
	TechnologyNationProxy = var_1_10003
	arg_6_0.nationProxy = var_1(var_1_10003)
	arg_6_0.curClassIDList = nil
	arg_6_0.groupIDGotList = {}

	local var_6_0 = arg_6_0.collectionProxy.shipGroups

	pairs = var_1_10002

	for iter_6_0, iter_6_1 in var_1_10002(var_6_0) do
		arg_6_0.groupIDGotList[#arg_6_0.groupIDGotList + 1] = iter_6_1.id
	end

	local var_6_1 = arg_6_0.nationProxy

	arg_6_0.point = var_2.getPoint(var_6_1)
	arg_6_0.expanded = {}

	return
end

function var_0_1.findUI(arg_7_0)
	arg_7_0.nationAllToggle = nil
	arg_7_0.nationAllToggleCom = nil

	local var_7_0 = arg_7_0._tf

	arg_7_0.nationMetaToggle = var_1.Find(var_7_0, "Adapt/Left/MetaToggle")
	GetComponent = var_1
	arg_7_0.nationMetaToggleCom = var_1(arg_7_0.nationMetaToggle, "Toggle")

	local var_7_1 = arg_7_0._tf

	arg_7_0.nationMotToggle = var_1.Find(var_7_1, "Adapt/Left/MotToggle")
	GetComponent = var_1
	arg_7_0.nationMotToggleCom = var_1(arg_7_0.nationMotToggle, "Toggle")
	arg_7_0.typeAllToggle = nil
	arg_7_0.typeAllToggleCom = nil

	local var_7_2 = arg_7_0._tf

	arg_7_0.blurPanel = var_1.Find(var_7_2, "blur_panel")

	local var_7_3 = arg_7_0.blurPanel

	arg_7_0.adapt = var_1.Find(var_7_3, "adapt")

	local var_7_4 = arg_7_0.adapt

	arg_7_0.backBtn = var_1.Find(var_7_4, "top/back")

	local var_7_5 = arg_7_0.adapt

	arg_7_0.homeBtn = var_1.Find(var_7_5, "top/option")

	local var_7_6 = arg_7_0.adapt

	arg_7_0.additionDetailBtn = var_1.Find(var_7_6, "AdditionDetailBtn")

	local var_7_7 = arg_7_0.adapt

	arg_7_0.switchBtn = var_1.Find(var_7_7, "SwitchToggle")

	local var_7_8 = arg_7_0.adapt

	arg_7_0.pointTF = var_1.Find(var_7_8, "PointCount")

	local var_7_9 = arg_7_0.adapt

	arg_7_0.pointNumText = var_1.Find(var_7_9, "PointCount/PointNumText")

	local var_7_10 = arg_7_0.switchBtn

	arg_7_0.redPointImg = var_1.Find(var_7_10, "RedPoint")

	local var_7_11 = arg_7_0.adapt

	arg_7_0.helpBtn = var_1.Find(var_7_11, "help_btn")

	local var_7_12 = arg_7_0._tf

	arg_7_0.leftContainer = var_1.Find(var_7_12, "Adapt/Left/Scroll View/Content")

	local var_7_13 = arg_7_0._tf

	arg_7_0.selectNationItem = var_1.Find(var_7_13, "SelectCampItem")

	local var_7_14 = arg_7_0._tf

	arg_7_0.bottomContainer = var_1.Find(var_7_14, "Adapt/Bottom/Content")

	local var_7_15 = arg_7_0._tf

	arg_7_0.selectTypeItem = var_1.Find(var_7_15, "SelectTypeItem")

	local var_7_16 = arg_7_0._tf

	arg_7_0.rightContainer = var_1.Find(var_7_16, "Adapt/Right/Container")

	local var_7_17 = arg_7_0.rightContainer

	arg_7_0.rightLSC = var_1.GetComponent(var_7_17, "LScrollRect")

	local var_7_18 = arg_7_0.rightContainer

	arg_7_0.rightLayoutGroup = var_1.GetComponent(var_7_18, "VerticalLayoutGroup")

	local var_7_19 = arg_7_0._tf

	arg_7_0.headItem = var_1.Find(var_7_19, "HeadItem")
	arg_7_0.rowHeight = arg_7_0.headItem.rect.height
	arg_7_0.maxRowHeight = 853.5
	BaseEmptyListPage = var_1

	local var_7_20 = var_1.New
	local var_7_21 = arg_7_0._tf

	arg_7_0.emptyPage = var_7_20(var_3.Find(var_7_21, "Adapt/Right/ViewPort"), arg_7_0.event)

	return
end

function var_0_1.onBackPressed(arg_8_0)
	triggerButton = var_1_10001

	var_1_10001(arg_8_0.backBtn)

	return
end

function var_0_1.addBtnListener(arg_9_0)
	onButton = var_1_10001

	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.backBtn

	local function var_9_2()
		local var_10_0 = arg_9_0

		var_0.closeView(var_10_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_9_0, var_9_1, var_9_2, var_1_10006)

	onButton = var_1_10001

	var_1_10001(arg_9_0, arg_9_0.additionDetailBtn, function()
		local var_11_0 = arg_9_0
		local var_11_1 = var_0.emit

		TechnologyConst = var_2_10003

		var_11_1(var_11_0, var_2_10003.OPEN_ALL_BUFF_DETAIL)

		return
	end)

	onToggle = var_1_10001

	local var_9_3 = arg_9_0
	local var_9_4 = arg_9_0.switchBtn

	local function var_9_5(arg_12_0)
		if arg_12_0 then
			setActive = var_2_10001

			var_2_10001(arg_9_0.pointTF, false)

			local var_12_0 = arg_9_0

			var_2_10001.OverlayPanel(var_12_0, arg_9_0.blurPanel)

			local var_12_1 = arg_9_0

			var_2_10001 = var_2_10001.emit
			TechnologyConst = var_4

			var_2_10001(var_12_1, var_4.OPEN_TECHNOLOGY_NATION_LAYER)
		else
			setActive = var_2_10001

			var_2_10001(arg_9_0.pointTF, true)

			local var_12_2 = arg_9_0

			var_1.UnOverlayPanel(var_12_2, arg_9_0.blurPanel, arg_9_0._tf)

			local var_12_3 = arg_9_0
			local var_12_4 = var_1.emit

			TechnologyConst = var_4

			var_12_4(var_12_3, var_4.CLOSE_TECHNOLOGY_NATION_LAYER)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_9_3, var_9_4, var_9_5, var_1_10006)

	onButton = var_1_10001

	local var_9_6 = arg_9_0
	local var_9_7 = arg_9_0.helpBtn

	local function var_9_8()
		pg = var_2_10000

		if var_2_10000.gametip.help_technologytree then
			pg = var_0

			local var_13_0 = var_0.MsgboxMgr.GetInstance()
			local var_13_1 = var_0.ShowMsgBox
			local var_13_2 = {}

			MSGBOX_TYPE_HELP = var_2_10004
			var_13_2.type = var_2_10004
			pg = var_2_10004
			var_13_2.helps = var_2_10004.gametip.help_technologytree.tip

			var_13_1(var_13_0, var_13_2)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_9_6, var_9_7, var_9_8, var_1_10006)

	return
end

function var_0_1.initNationToggleUIList(arg_14_0)
	arg_14_0.nationAllToggle = nil
	arg_14_0.nationAllToggleCom = nil

	local var_14_0 = arg_14_0._tf

	arg_14_0.nationMetaToggle = var_1.Find(var_14_0, "Adapt/Left/MetaToggle")
	GetComponent = var_1
	arg_14_0.nationMetaToggleCom = var_1(arg_14_0.nationMetaToggle, "Toggle")

	local var_14_1 = arg_14_0._tf

	arg_14_0.nationMotToggle = var_1.Find(var_14_1, "Adapt/Left/MotToggle")
	GetComponent = var_1
	arg_14_0.nationMotToggleCom = var_1(arg_14_0.nationMotToggle, "Toggle")
	setActive = var_14_4

	local var_14_2 = arg_14_0.nationMetaToggle

	LOCK_TEC_META = var_4

	var_14_4(var_14_2, not var_4)

	LOCK_TEC_META = var_14_4

	local var_14_4

	if var_14_4 then
		local var_14_3 = arg_14_0._tf

		var_14_4 = var_14_4.Find(var_14_3, "Adapt/Left/Scroll View")
		Vector2 = var_1_10002
		var_14_4.offsetMin = var_1_10002.New(var_14_4.offsetMin.x, 0)
	end

	UIItemList = var_14_4

	local var_14_5 = var_14_4.New(arg_14_0.leftContainer, arg_14_0.selectNationItem)

	var_1.make(var_14_5, function(arg_15_0, arg_15_1, arg_15_2)
		UIItemList = var_2_10003

		if arg_15_0 == var_2_10003.EventUpdate then
			local var_15_0 = arg_15_2:Find("UnSelectedImg")
			local var_15_1 = var_3.GetComponent(var_15_0, "Image")
			local var_15_2 = arg_15_2:Find("SelectedImg")
			local var_15_3 = var_4.GetComponent(var_15_2, "Image")

			TechnologyConst = var_15_0

			local var_15_4, var_15_5 = var_15_0.GetNationSpriteByIndex(arg_15_1 + 1)

			var_15_3.sprite = var_15_5
			var_15_1.sprite = var_15_4

			if arg_15_1 == 0 then
				var_15_4 = arg_14_0
				var_15_4.nationAllToggle = arg_15_2
				var_15_4 = arg_14_0
				GetComponent = var_15_5
				var_15_4.nationAllToggleCom = var_15_5(arg_15_2, "Toggle")
				var_15_4 = arg_14_0.nationAllToggleCom
				var_15_4.interactable = false
				triggerToggle = var_15_4

				var_15_4(arg_15_2, true)
			else
				var_15_4 = arg_14_0.nationToggleList
				var_15_4[arg_15_1] = arg_15_2
				triggerToggle = var_15_4

				var_15_4(arg_15_2, false)
			end

			setActive = var_15_4

			var_15_4(arg_15_2, true)
		end

		return
	end)

	local var_14_6 = var_1
	local var_14_7 = var_1.align

	TechnologyConst = var_5

	var_14_7(var_14_6, #var_5.NationResName)

	setActive = var_14_7

	local var_14_8 = arg_14_0.nationMotToggle

	LOCK_TEC_MOT = var_5

	var_14_7(var_14_8, not var_5)

	LOCK_TEC_MOT = var_14_7

	if not var_14_7 then
		setParent = var_14_7

		var_14_7(arg_14_0.nationMotToggle, arg_14_0.leftContainer)
	end

	onToggle = var_14_7

	local var_14_9 = arg_14_0
	local var_14_10 = arg_14_0.nationAllToggle

	local function var_14_11(arg_16_0)
		if arg_16_0 == true then
			arg_14_0.lastNationTrige = var_0_1.NationTrige.All
			arg_14_0.nationAllToggleCom.interactable = false
			arg_14_0.nationSelectedCount = 0
			arg_14_0.nationSelectedList = {}

			local var_16_0 = arg_14_0

			var_1.updateTecItemList(var_16_0)

			local var_16_1 = arg_14_0

			var_1.updateNationToggleUIList(var_16_1)
		else
			arg_14_0.nationAllToggleCom.interactable = true
		end

		return
	end

	SFX_PANEL = var_1_10007

	var_14_7(var_14_9, var_14_10, var_14_11, var_1_10007)

	onToggle = var_14_7

	local var_14_12 = arg_14_0
	local var_14_13 = arg_14_0.nationMetaToggle

	local function var_14_14(arg_17_0)
		if arg_17_0 == true then
			arg_14_0.lastNationTrige = var_0_1.NationTrige.Meta
			arg_14_0.nationMetaToggleCom.interactable = false
			arg_14_0.nationSelectedCount = 0
			arg_14_0.nationSelectedList = {}

			local var_17_0 = arg_14_0

			var_1.updateTecItemList(var_17_0)

			local var_17_1 = arg_14_0

			var_1.updateNationToggleUIList(var_17_1)
		else
			arg_14_0.nationMetaToggleCom.interactable = true
		end

		return
	end

	SFX_PANEL = var_1_10007

	var_14_7(var_14_12, var_14_13, var_14_14, var_1_10007)

	onToggle = var_14_7

	local var_14_15 = arg_14_0
	local var_14_16 = arg_14_0.nationMotToggle

	local function var_14_17(arg_18_0)
		if arg_18_0 == true then
			arg_14_0.lastNationTrige = var_0_1.NationTrige.Mot
			arg_14_0.nationMotToggleCom.interactable = false
			arg_14_0.nationSelectedCount = 0
			arg_14_0.nationSelectedList = {}

			local var_18_0 = arg_14_0

			var_1.updateTecItemList(var_18_0)

			local var_18_1 = arg_14_0

			var_1.updateNationToggleUIList(var_18_1)
		else
			arg_14_0.nationMotToggleCom.interactable = true
		end

		return
	end

	SFX_PANEL = var_1_10007

	var_14_7(var_14_15, var_14_16, var_14_17, var_1_10007)

	ipairs = var_14_7

	for iter_14_0, iter_14_1 in var_14_7(arg_14_0.nationToggleList) do
		onToggle = var_1_10007

		local var_14_18 = arg_14_0
		local var_14_19 = iter_14_1

		local function var_14_20(arg_19_0)
			if arg_19_0 == true then
				arg_14_0.lastNationTrige = var_0_1.NationTrige.Other

				local var_19_0 = arg_14_0

				var_19_0.nationSelectedCount = arg_14_0.nationSelectedCount + 1
				table = var_19_0

				local var_19_1 = var_19_0.insert
				local var_19_2 = arg_14_0.nationSelectedList

				TechnologyConst = var_2_10004

				var_19_1(var_19_2, var_2_10004.NationOrder[iter_14_0])

				if arg_14_0.nationSelectedCount < #arg_14_0.nationToggleList then
					local var_19_3 = arg_14_0

					var_1.updateNationToggleUIList(var_19_3)

					local var_19_4 = arg_14_0

					var_1.updateTecItemList(var_19_4)
				elseif arg_14_0.nationSelectedCount == #arg_14_0.nationToggleList then
					local var_19_5 = arg_14_0

					var_1.updateNationToggleUIList(var_19_5)
				end
			elseif arg_14_0.nationSelectedCount > 0 then
				local var_19_6 = arg_14_0

				var_19_6.nationSelectedCount = arg_14_0.nationSelectedCount - 1
				table = var_19_6

				local var_19_7 = var_19_6.indexof
				local var_19_8 = arg_14_0.nationSelectedList

				TechnologyConst = var_2_10004

				if var_19_7(var_19_8, var_2_10004.NationOrder[iter_14_0], 1) then
					table = var_2

					var_2.remove(arg_14_0.nationSelectedList, var_1)
				end

				if arg_14_0.nationSelectedCount > 0 then
					local var_19_9 = arg_14_0

					var_2.updateNationToggleUIList(var_19_9)

					local var_19_10 = arg_14_0

					var_2.updateTecItemList(var_19_10)
				elseif arg_14_0.nationSelectedCount == 0 then
					local var_19_11 = arg_14_0

					var_2.updateNationToggleUIList(var_19_11)
				end
			end

			return
		end

		SFX_PANEL = var_1_10012

		var_1_10007(var_14_18, var_14_19, var_14_20, var_1_10012)
	end

	return
end

function var_0_1.updateNationToggleUIList(arg_20_0)
	if arg_20_0.lastNationTrige == var_0_1.NationTrige.All then
		_ = var_1

		var_1.each(arg_20_0.nationToggleList, function(arg_21_0)
			triggerToggle = var_2_10001

			var_2_10001(arg_21_0, false)

			onNextTick = var_2_10001

			var_2_10001(function()
				local var_22_0 = arg_21_0
				local var_22_1 = var_0.Find(var_22_0, "UnSelectedImg")

				setActive = var_3_10001

				var_3_10001(var_22_1, true)

				return
			end)

			return
		end)

		triggerToggle = var_1

		var_1(arg_20_0.nationMetaToggle, false)

		triggerToggle = var_1

		var_1(arg_20_0.nationMotToggle, false)
	elseif arg_20_0.lastNationTrige == var_0_1.NationTrige.Meta then
		triggerToggle = var_1

		var_1(arg_20_0.nationAllToggle, false)

		_ = var_1

		var_1.each(arg_20_0.nationToggleList, function(arg_23_0)
			triggerToggle = var_2_10001

			var_2_10001(arg_23_0, false)

			return
		end)

		triggerToggle = var_1

		var_1(arg_20_0.nationMotToggle, false)
	elseif arg_20_0.lastNationTrige == var_0_1.NationTrige.Mot then
		triggerToggle = var_1

		var_1(arg_20_0.nationAllToggle, false)

		_ = var_1

		var_1.each(arg_20_0.nationToggleList, function(arg_24_0)
			triggerToggle = var_2_10001

			var_2_10001(arg_24_0, false)

			return
		end)

		triggerToggle = var_1

		var_1(arg_20_0.nationMetaToggle, false)
	elseif arg_20_0.lastNationTrige == var_0_1.NationTrige.Other then
		if arg_20_0.nationSelectedCount <= 0 or arg_20_0.nationSelectedCount >= #arg_20_0.nationToggleList then
			triggerToggle = var_1

			var_1(arg_20_0.nationAllToggle, true)
		else
			triggerToggle = var_1

			var_1(arg_20_0.nationAllToggle, false)

			triggerToggle = var_1

			var_1(arg_20_0.nationMetaToggle, false)

			triggerToggle = var_1

			var_1(arg_20_0.nationMotToggle, false)
		end
	end

	return
end

function var_0_1.initTypeToggleUIList(arg_25_0)
	arg_25_0.typeAllToggle = nil
	arg_25_0.typeAllToggleCom = nil
	UIItemList = var_1

	local var_25_0 = var_1.New(arg_25_0.bottomContainer, arg_25_0.selectTypeItem)

	var_1.make(var_25_0, function(arg_26_0, arg_26_1, arg_26_2)
		UIItemList = var_2_10003

		if arg_26_0 == var_2_10003.EventUpdate then
			local var_26_0 = arg_26_2:Find("UnSelectedImg")
			local var_26_1 = var_3.GetComponent(var_26_0, "Image")
			local var_26_2 = arg_26_2:Find("SelectedImg")
			local var_26_3 = var_4.GetComponent(var_26_2, "Image")

			TechnologyConst = var_26_0

			local var_26_4, var_26_5 = var_26_0.GetTypeSpriteByIndex(arg_26_1 + 1)

			var_26_3.sprite = var_26_5
			var_26_1.sprite = var_26_4
			arg_26_1 = arg_26_1 + 1
			TechnologyConst = var_26_4

			local var_26_6

			if arg_26_1 == #var_26_4.TypeResName then
				var_26_6 = arg_25_0
				var_26_6.typeAllToggle = arg_26_2
				var_26_6 = arg_25_0
				GetComponent = var_26_5
				var_26_6.typeAllToggleCom = var_26_5(arg_26_2, "Toggle")
				var_26_6 = arg_25_0.typeAllToggleCom
				var_26_6.interactable = false
				triggerToggle = var_26_6

				var_26_6(arg_26_2, true)
			else
				var_26_6 = arg_25_0.typeToggleList
				var_26_6[arg_26_1] = arg_26_2
				triggerToggle = var_26_6

				var_26_6(arg_26_2, false)
			end

			setActive = var_26_6

			var_26_6(arg_26_2, true)
		end

		return
	end)

	local var_25_1 = var_1
	local var_25_2 = var_1.align

	TechnologyConst = var_5

	var_25_2(var_25_1, #var_5.TypeResName)

	onToggle = var_25_2

	var_25_2(arg_25_0, arg_25_0.typeAllToggle, function(arg_27_0)
		arg_25_0.lastTypeTrige = var_0_1.TypeTrige.All

		if arg_27_0 == true then
			arg_25_0.typeAllToggleCom.interactable = false
			arg_25_0.typeSelectedCount = 0
			arg_25_0.typeSelectedList = {}

			local var_27_0 = arg_25_0

			var_1.updateTecItemList(var_27_0)

			local var_27_1 = arg_25_0

			var_1.updateTypeToggleUIList(var_27_1)
		else
			arg_25_0.typeAllToggleCom.interactable = true
		end

		return
	end)

	ipairs = var_25_2

	for iter_25_0, iter_25_1 in var_25_2(arg_25_0.typeToggleList) do
		onToggle = var_1_10007

		local var_25_3 = arg_25_0
		local var_25_4 = iter_25_1

		local function var_25_5(arg_28_0)
			arg_25_0.lastTypeTrige = var_0_1.TypeTrige.Other

			if arg_28_0 == true then
				local var_28_0 = arg_25_0

				var_28_0.typeSelectedCount = arg_25_0.typeSelectedCount + 1
				ipairs = var_28_0
				TechnologyConst = var_2_10003

				for iter_28_0, iter_28_1 in var_28_0(var_2_10003.TypeOrder[iter_25_0]) do
					table = var_2_10006

					var_2_10006.insert(arg_25_0.typeSelectedList, iter_28_1)
				end

				if arg_25_0.typeSelectedCount < #arg_25_0.typeToggleList then
					var_2_10003 = arg_25_0

					var_1.updateTypeToggleUIList(var_2_10003)

					var_2_10003 = arg_25_0

					var_1.updateTecItemList(var_2_10003)
				elseif arg_25_0.typeSelectedCount == #arg_25_0.typeToggleList then
					var_2_10003 = arg_25_0

					var_1.updateTypeToggleUIList(var_2_10003)
				end
			elseif arg_25_0.typeSelectedCount > 0 then
				local var_28_1 = arg_25_0

				var_28_1.typeSelectedCount = arg_25_0.typeSelectedCount - 1
				ipairs = var_28_1
				TechnologyConst = var_2_10003

				for iter_28_2, iter_28_3 in var_28_1(var_2_10003.TypeOrder[iter_25_0]) do
					table = var_2_10006

					if var_2_10006.indexof(arg_25_0.typeSelectedList, iter_28_3, 1) then
						table = var_2_10007

						var_2_10007.remove(arg_25_0.typeSelectedList, var_2_10006)
					end
				end

				if arg_25_0.typeSelectedCount > 0 then
					local var_28_2 = arg_25_0

					var_1.updateTypeToggleUIList(var_28_2)

					local var_28_3 = arg_25_0

					var_1.updateTecItemList(var_28_3)
				elseif arg_25_0.typeSelectedCount == 0 then
					local var_28_4 = arg_25_0

					var_1.updateTypeToggleUIList(var_28_4)
				end
			end

			return
		end

		SFX_PANEL = var_1_10012

		var_1_10007(var_25_3, var_25_4, var_25_5, var_1_10012)
	end

	return
end

function var_0_1.updateTypeToggleUIList(arg_29_0)
	if arg_29_0.lastTypeTrige == var_0_1.TypeTrige.All then
		_ = var_1

		var_1.each(arg_29_0.typeToggleList, function(arg_30_0)
			triggerToggle = var_2_10001

			var_2_10001(arg_30_0, false)

			onNextTick = var_2_10001

			var_2_10001(function()
				local var_31_0 = arg_30_0
				local var_31_1 = var_0.Find(var_31_0, "UnSelectedImg")

				setActive = var_3_10001

				var_3_10001(var_31_1, true)

				return
			end)

			return
		end)
	elseif arg_29_0.lastTypeTrige == var_0_1.TypeTrige.Other then
		if arg_29_0.typeSelectedCount <= 0 or arg_29_0.typeSelectedCount >= #arg_29_0.typeToggleList then
			triggerToggle = var_1

			var_1(arg_29_0.typeAllToggle, true)
		else
			triggerToggle = var_1

			var_1(arg_29_0.typeAllToggle, false)
		end
	end

	return
end

function var_0_1.updatePreferredHeight(arg_32_0, arg_32_1, arg_32_2)
	tf = var_1_10003

	local var_32_0 = var_1_10003(arg_32_1)
	local var_32_1 = var_3.Find(var_32_0, "ShipScrollView/ShipContainer")
	local var_32_2 = arg_32_2 + arg_32_0.rowHeight
	local var_32_3 = arg_32_0.rightLayoutGroup.padding
	local var_32_4 = arg_32_0.rightLayoutGroup.padding.bottom + var_32_2

	GetComponent = var_1_10007
	var_32_3.bottom = var_32_4 - var_1_10007(arg_32_1, "LayoutElement").preferredHeight
	GetComponent = var_32_3

	local var_32_5 = var_32_3(arg_32_1, "LayoutElement")

	var_32_5.preferredHeight = var_32_2
	tf = var_32_5

	local var_32_6 = var_32_5(arg_32_1)
	local var_32_7 = var_5.Find(var_32_6, "ClickBtn/ArrowBtn")

	setLocalRotation = var_6

	var_6(var_32_7, {
		z = arg_32_2 > 0 and 0 or 180
	})

	return
end

function var_0_1.onClassItemUpdate(arg_33_0, arg_33_1, arg_33_2)
	tf = var_1_10003

	local var_33_0 = var_1_10003(arg_33_2)
	local var_33_1 = var_3.Find(var_33_0, "Name/NameText")

	tf = var_1_10004

	local var_33_2 = var_1_10004(arg_33_2)
	local var_33_3 = var_4.Find(var_33_2, "CampBG")

	tf = var_33_0

	local var_33_4 = var_33_0(arg_33_2)
	local var_33_5 = var_5.Find(var_33_4, "Level/LevelImg")

	tf = var_33_2

	local var_33_6 = var_33_2(arg_33_2)
	local var_33_7 = var_6.Find(var_33_6, "Level/TypeTextImg")

	tf = var_33_4

	local var_33_8 = var_33_4(arg_33_2)
	local var_33_9 = var_7.Find(var_33_8, "ClickBtn")
	local var_33_10 = var_7.Find(var_33_9, "ArrowBtn")
	local var_33_11 = arg_33_0:getClassConfigForShow(arg_33_1 + 1).name
	local var_33_12 = var_9.nation
	local var_33_13 = var_9.shiptype
	local var_33_14 = var_9.t_level
	local var_33_15 = var_9.ships
	local var_33_16 = arg_33_0
	local var_33_17 = arg_33_0.isMetaOn(var_33_16)
	local var_33_18 = arg_33_0
	local var_33_19 = arg_33_0.isMotOn(var_33_18)

	setText = var_33_16

	var_33_16(var_33_1, var_33_11)

	local var_33_20

	if var_33_17 or var_33_19 then
		setActive = var_33_18

		var_33_18(var_33_5, false)

		setActive = var_33_18

		var_33_18(var_33_7, false)

		if var_33_17 then
			GetSpriteFromAtlas = var_33_18
			var_33_20 = var_33_18("TecNation", "bg_nation_meta")
		elseif var_33_19 then
			GetSpriteFromAtlas = var_33_18
			var_33_20 = var_33_18("TecNation", "bg_nation_mot")
		end
	else
		setImageSprite = var_33_18

		local var_33_21 = var_33_5

		GetSpriteFromAtlas = var_1_10021

		var_33_18(var_33_21, var_1_10021("TecClassLevelIcon", "T" .. var_33_14), true)

		setImageSprite = var_33_18

		local var_33_22 = var_33_7

		GetSpriteFromAtlas = var_21

		var_33_18(var_33_22, var_21("ShipType", "ch_title_" .. var_33_13), true)

		setActive = var_33_18

		var_33_18(var_33_5, true)

		setActive = var_33_18

		var_33_18(var_33_7, true)

		GetSpriteFromAtlas = var_33_18
		var_33_20 = var_33_18("TecNation", "bg_nation_" .. var_33_12)
	end

	setImageSprite = var_33_18

	var_33_18(var_33_3, var_33_20)

	tf = var_33_18

	local var_33_23 = var_33_18(arg_33_2)
	local var_33_24 = var_18.Find(var_33_23, "ClickBtn/ArrowBtn")

	setLocalRotation = var_19

	var_19(var_33_24, {
		z = 180
	})

	tf = var_19

	local var_33_25 = var_19(arg_33_2)
	local var_33_26 = var_19.Find(var_33_25, "ShipScrollView/ShipContainer")

	arg_33_0:updateShipItemList(var_33_15, var_33_26)

	arg_33_0.expanded[arg_33_1] = 0

	arg_33_0:updatePreferredHeight(arg_33_2, arg_33_0.expanded[arg_33_1])

	setActive = var_20

	var_20(var_7, #var_33_15 > 5)

	onButton = var_20

	local var_33_27 = arg_33_0
	local var_33_28 = var_7

	local function var_33_29()
		defaultValue = var_2_10000

		if var_2_10000(arg_33_0.expanded[arg_33_1], 0) > 0 then
			arg_33_0.expanded[arg_33_1] = 0
		else
			arg_33_0.expanded[arg_33_1] = var_33_26.rect.height - arg_33_0.rowHeight
		end

		local var_34_0 = arg_33_0

		var_0.updatePreferredHeight(var_34_0, arg_33_2, arg_33_0.expanded[arg_33_1])

		return
	end

	SFX_PANEL = var_1_10025

	var_20(var_33_27, var_33_28, var_33_29, var_1_10025)

	return
end

function var_0_1.onClassItemReturn(arg_35_0, arg_35_1, arg_35_2)
	defaultValue = var_1_10003

	if var_1_10003(arg_35_0.expanded[arg_35_1], 0) > 0 then
		arg_35_0.expanded[arg_35_1] = 0

		arg_35_0:updatePreferredHeight(arg_35_2, arg_35_0.expanded[arg_35_1])
	end

	return
end

function var_0_1.initTecClassUIList(arg_36_0)
	function arg_36_0.rightLSC.onUpdateItem(arg_37_0, arg_37_1)
		local var_37_0 = arg_36_0

		var_2.onClassItemUpdate(var_37_0, arg_37_0, arg_37_1)

		return
	end

	function arg_36_0.rightLSC.onReturnItem(arg_38_0, arg_38_1)
		local var_38_0 = arg_36_0

		var_2.onClassItemReturn(var_38_0, arg_38_0, arg_38_1)

		return
	end

	return
end

function var_0_1.updateTecItemList(arg_39_0)
	arg_39_0.expanded = {}

	local var_39_0 = arg_39_0:getClassIDListForShow()

	if arg_39_0.rightLSC.totalCount ~= 0 then
		local var_39_1 = arg_39_0.rightLSC

		var_2.SetTotalCount(var_39_1, 0)
	end

	local var_39_2 = arg_39_0.rightLSC

	var_2.SetTotalCount(var_39_2, #var_39_0)

	local var_39_3 = arg_39_0.rightLSC

	var_2.BeginLayout(var_39_3)

	local var_39_4 = arg_39_0.rightLSC

	var_2.EndLayout(var_39_4)

	if #var_39_0 <= 0 then
		local var_39_5 = arg_39_0.emptyPage

		var_3.ExecuteAction(var_39_5, "ShowOrHide", true)

		local var_39_6 = arg_39_0.emptyPage
		local var_39_7 = var_3.ExecuteAction
		local var_39_8 = "SetEmptyText"

		i18n = var_7

		var_39_7(var_39_6, var_39_8, var_7("technology_filter_placeholder"))
	elseif var_2 > 0 then
		local var_39_9 = arg_39_0.emptyPage

		if var_3.GetLoaded(var_39_9) then
			local var_39_10 = arg_39_0.emptyPage

			var_3.ExecuteAction(var_39_10, "ShowOrHide", false)
		end
	end

	return
end

function var_0_1.updateShipItemList(arg_40_0, arg_40_1, arg_40_2)
	UIItemList = var_1_10003

	local var_40_0 = var_1_10003.New(arg_40_2, arg_40_0.headItem)

	var_3.make(var_40_0, function(arg_41_0, arg_41_1, arg_41_2)
		UIItemList = var_2_10003

		if arg_41_0 == var_2_10003.EventUpdate then
			local var_41_0 = arg_41_2:Find("BaseImg")
			local var_41_1 = arg_41_2:Find("BaseImg/CharImg")
			local var_41_2 = arg_41_2:Find("NameBG")
			local var_41_3 = var_5.Find(var_41_2, "NameText")
			local var_41_4 = arg_41_2:Find("Frame")
			local var_41_5 = arg_41_2:Find("Star")
			local var_41_6 = arg_41_2:Find("Star/StarImg")
			local var_41_7 = arg_41_2:Find("Info")
			local var_41_8 = var_10.Find(var_41_7, "PointText")
			local var_41_9 = var_10:Find("BuffGet")
			local var_41_10 = var_12.Find(var_41_9, "TypeIcon")
			local var_41_11 = var_13.Find(var_41_10, "AttrIcon")
			local var_41_12 = var_13:Find("NumText")
			local var_41_13 = var_10:Find("Lock")
			local var_41_14 = var_10:Find("BuffComplete")
			local var_41_15 = var_17.Find(var_41_14, "TypeIcon")
			local var_41_16 = var_18.Find(var_41_15, "AttrIcon")
			local var_41_17 = var_18:Find("NumText")
			local var_41_18 = arg_41_2:Find("BottomBG")
			local var_41_19 = arg_41_2:Find("BottomBG/StatusUnknow")
			local var_41_20 = arg_41_2:Find("BottomBG/StatusResearching")
			local var_41_21 = arg_41_2:Find("ViewIcon")
			local var_41_22 = arg_41_2:Find("keyansaohguang")
			local var_41_23 = arg_40_1[arg_41_1 + 1]

			setText = var_27

			local var_41_24 = var_41_3

			shortenString = var_2_10030
			ShipGroup = var_2_10032

			var_27(var_41_24, var_2_10030(var_2_10032.getDefaultShipNameByGroupID(var_41_23), 6))

			local var_41_25 = var_41_23 * 10 + 1

			setImageSprite = var_28

			local var_41_26 = var_41_0

			GetSpriteFromAtlas = var_2_10031

			local var_41_27 = "shipraritybaseicon"
			local var_41_28 = "base_"

			pg = var_2_10035

			var_28(var_41_26, var_2_10031(var_41_27, var_41_28 .. var_2_10035.ship_data_statistics[var_41_25].rarity))

			LoadSpriteAsync = var_28

			local var_41_29 = "shipmodels/"

			Ship = var_31

			var_28(var_41_29 .. var_31.getPaintingName(var_41_25), function(arg_42_0)
				if arg_42_0 and not arg_40_0.exited then
					setImageSprite = var_1

					var_1(var_41_1, arg_42_0, true)

					rtf = var_1

					local var_42_0 = var_1(var_41_1)

					getSpritePivot = var_3_10002
					var_42_0.pivot = var_3_10002(arg_42_0)
				end

				return
			end)

			table = var_28

			local var_41_30

			if var_28.indexof(arg_40_0.groupIDGotList, var_41_23, 1) then
				pg = var_41_30
				var_41_30 = var_41_30.fleet_tech_ship_template[var_41_23].add_get_shiptype[1]
				pg = var_41_24

				local var_41_31 = var_41_24.fleet_tech_ship_template[var_41_23].add_get_attr

				pg = var_30

				local var_41_32 = var_30.fleet_tech_ship_template[var_41_23].add_get_value

				setImageSprite = var_31

				local var_41_33 = var_13

				GetSpriteFromAtlas = var_34

				var_31(var_41_33, var_34("ui/technologytreeui_atlas", "label_" .. var_41_30))

				setImageSprite = var_31

				local var_41_34 = var_41_11

				GetSpriteFromAtlas = var_34

				local var_41_35 = "attricon"

				pg = var_37

				var_31(var_41_34, var_34(var_41_35, var_37.attribute_info_by_type[var_41_31].name))

				setText = var_31

				var_31(var_41_12, "+" .. var_41_32)

				setActive = var_31

				var_31(var_12, true)

				local var_41_36 = arg_40_0.collectionProxy
				local var_41_37 = var_31.getShipGroup(var_41_36, var_41_23).maxLV

				TechnologyConst = var_41_36

				local var_41_38, var_41_39, var_41_40

				if var_41_37 < var_41_36.SHIP_LEVEL_FOR_BUFF then
					setActive = var_41_37

					var_41_37(var_41_20, true)

					setActive = var_41_37

					var_41_37(var_41_19, false)

					setActive = var_41_37

					var_41_37(var_17, false)

					setImageSprite = var_41_37
					var_41_38 = var_41_4
					GetSpriteFromAtlas = var_41_39

					var_41_37(var_41_38, var_41_39("ui/technologytreeui_atlas", "card_bg_normal"))

					setActive = var_41_37

					var_41_37(var_41_18, true)

					setActive = var_41_37

					var_41_37(var_41_21, true)

					setActive = var_41_37

					var_41_37(var_41_13, true)

					setActive = var_41_37

					var_41_37(var_41_22, false)

					var_41_37 = var_31.star
					pg = var_41_40

					if var_41_37 == var_41_40.fleet_tech_ship_template[var_41_23].max_star then
						setText = var_41_37
						var_41_38 = var_41_8
						var_41_39 = "+"
						pg = var_41_35
						var_41_35 = var_41_35.fleet_tech_ship_template[var_41_23].pt_get
						pg = var_37

						var_41_37(var_41_38, var_41_39 .. var_41_35 + var_37.fleet_tech_ship_template[var_41_23].pt_upgrage)
					else
						setText = var_41_37
						var_41_38 = var_41_8
						var_41_39 = "+"
						pg = var_41_35

						var_41_37(var_41_38, var_41_39 .. var_41_35.fleet_tech_ship_template[var_41_23].pt_get)
					end
				else
					pg = var_41_37
					var_41_37 = var_41_37.fleet_tech_ship_template[var_41_23].add_level_shiptype[1]
					pg = var_41_40
					var_41_40 = var_41_40.fleet_tech_ship_template[var_41_23].add_level_attr
					pg = var_41_38

					local var_41_41 = var_41_38.fleet_tech_ship_template[var_41_23].add_level_value

					setImageSprite = var_41_39

					local var_41_42 = var_18

					GetSpriteFromAtlas = var_38

					var_41_39(var_41_42, var_38("ui/technologytreeui_atlas", "label_" .. var_41_37))

					setImageSprite = var_41_39

					local var_41_43 = var_41_16

					GetSpriteFromAtlas = var_38

					local var_41_44 = "attricon"

					pg = var_41

					var_41_39(var_41_43, var_38(var_41_44, var_41.attribute_info_by_type[var_41_40].name))

					setText = var_41_39

					var_41_39(var_41_17, "+" .. var_41_41)

					setActive = var_41_39

					var_41_39(var_17, true)

					var_41_39 = var_31.star
					pg = var_41_35

					local var_41_47

					if var_41_39 == var_41_35.fleet_tech_ship_template[var_41_23].max_star then
						setText = var_41_39

						local var_41_45 = var_41_8
						local var_41_46 = "+"

						pg = var_41_47
						var_41_47 = var_41_47.fleet_tech_ship_template[var_41_23].pt_get
						pg = var_41_44
						var_41_47 = var_41_47 + var_41_44.fleet_tech_ship_template[var_41_23].pt_level
						pg = var_41_44

						var_41_39(var_41_45, var_41_46 .. var_41_47 + var_41_44.fleet_tech_ship_template[var_41_23].pt_upgrage)

						setImageSprite = var_41_39

						local var_41_48 = var_41_4

						GetSpriteFromAtlas = var_38

						var_41_39(var_41_48, var_38("ui/technologytreeui_atlas", "card_bg_finished"))

						setActive = var_41_39

						var_41_39(var_41_18, false)

						setActive = var_41_39

						var_41_39(var_41_21, false)

						setActive = var_41_39

						var_41_39(var_41_20, false)

						setActive = var_41_39

						var_41_39(var_41_19, false)

						setActive = var_41_39

						var_41_39(var_41_22, true)
					else
						setText = var_41_39

						local var_41_49 = var_41_8
						local var_41_50 = "+"

						pg = var_41_47

						local var_41_51 = var_41_47.fleet_tech_ship_template[var_41_23].pt_get

						pg = var_41_44

						var_41_39(var_41_49, var_41_50 .. var_41_51 + var_41_44.fleet_tech_ship_template[var_41_23].pt_level)

						setImageSprite = var_41_39

						local var_41_52 = var_41_4

						GetSpriteFromAtlas = var_38

						var_41_39(var_41_52, var_38("ui/technologytreeui_atlas", "card_bg_normal"))

						setActive = var_41_39

						var_41_39(var_41_18, true)

						setActive = var_41_39

						var_41_39(var_41_21, true)

						setActive = var_41_39

						var_41_39(var_41_20, true)

						setActive = var_41_39

						var_41_39(var_41_19, false)

						setActive = var_41_39

						var_41_39(var_41_22, false)
					end

					setActive = var_41_39

					var_41_39(var_41_13, false)
				end

				setImageColor = var_41_37

				local var_41_53 = var_41_1

				Color = var_41_39

				var_41_37(var_41_53, var_41_39.New(1, 1, 1, 1))

				setActive = var_41_37

				var_41_37(var_5, true)

				setActive = var_41_37

				var_41_37(var_10, true)

				setActive = var_41_37

				var_41_37(var_41_5, true)

				local var_41_54 = var_31.star

				pg = var_41_40

				if var_41_54 == var_41_40.fleet_tech_ship_template[var_41_23].max_star then
					setActive = var_41_54

					var_41_54(var_41_6, true)
				else
					setActive = var_41_54

					var_41_54(var_41_6, false)
				end

				onButton = var_41_54

				var_41_54(arg_40_0, arg_41_2, function()
					local var_43_0 = arg_40_0
					local var_43_1 = var_0.emit

					TechnologyConst = var_3_10003

					var_43_1(var_43_0, var_3_10003.OPEN_SHIP_BUFF_DETAIL, var_41_23, var_0.maxLV, var_0.star)

					return
				end)
			else
				setImageSprite = var_41_30

				local var_41_55 = var_41_4

				GetSpriteFromAtlas = var_31

				var_41_30(var_41_55, var_31("ui/technologytreeui_atlas", "card_bg_normal"))

				setImageColor = var_41_30

				local var_41_56 = var_41_1

				Color = var_31

				var_41_30(var_41_56, var_31.New(0, 0, 0, 0.4))

				setActive = var_41_30

				var_41_30(var_41_21, false)

				setActive = var_41_30

				var_41_30(var_5, false)

				setActive = var_41_30

				var_41_30(var_10, false)

				setActive = var_41_30

				var_41_30(var_41_20, false)

				setActive = var_41_30

				var_41_30(var_41_19, true)

				setActive = var_41_30

				var_41_30(var_41_5, false)

				setActive = var_41_30

				var_41_30(var_41_13, false)

				setActive = var_41_30

				var_41_30(var_41_22, false)

				removeOnButton = var_41_30

				var_41_30(arg_41_2)
			end

			setActive = var_41_30

			var_41_30(arg_41_2, true)
		end

		return
	end)
	var_3:align(#arg_40_1)

	return
end

function var_0_1.getClassIDListForShow(arg_44_0, arg_44_1, arg_44_2)
	arg_44_1 = arg_44_1 or arg_44_0.nationSelectedList
	arg_44_2 = arg_44_2 or arg_44_0.typeSelectedList

	local var_44_0 = arg_44_0
	local var_44_1 = arg_44_0.isMetaOn(var_44_0)
	local var_44_2 = arg_44_0:isMotOn()

	if not var_44_1 and not var_44_2 then
		TechnologyConst = var_44_0
		var_44_0 = var_44_0.GetOrderClassList()

		local var_44_3

		if #arg_44_1 == 0 and #arg_44_2 == 0 then
			var_44_3 = var_44_0

			goto label_44_0
		end

		if #arg_44_1 == 0 then
			TechnologyConst = var_7

			do
				local var_44_4

				if not var_7.NationOrder then
					var_44_4 = arg_44_1
				end

				_ = var_1_10008
				var_44_3 = var_1_10008.select(var_44_0, function(arg_45_0)
					pg = var_2_10001

					local var_45_0 = var_2_10001.fleet_tech_ship_class[arg_45_0].nation

					table = var_2_10002

					if var_2_10002.contains(var_44_4, var_45_0) then
						if #arg_44_0.typeSelectedList == 0 then
							return true
						else
							pg = var_2

							local var_45_1 = var_2.fleet_tech_ship_class[arg_45_0].shiptype

							table = var_2_10003

							return var_2_10003.contains(arg_44_0.typeSelectedList, var_45_1)
						end
					else
						return false
					end

					return
				end)
			end

			::label_44_0::

			arg_44_0.curClassIDList = var_44_3

			do return var_44_3 end

			if false then
				if var_44_1 then
					TechnologyConst = var_44_0
					arg_44_0.curMetaClassIDList = var_44_0.GetOrderMetaClassList(arg_44_2)

					return arg_44_0.curMetaClassIDList
				elseif var_44_2 then
					TechnologyConst = var_44_0
					arg_44_0.curMotClassIDList = var_44_0.GetOrderMotClassList(arg_44_2)

					return arg_44_0.curMotClassIDList
				end
			end

			return
		end
	end
end

function var_0_1.getClassConfigForShow(arg_46_0, arg_46_1)
	local var_46_0 = arg_46_0:isMetaOn()
	local var_46_1 = arg_46_0
	local var_46_2 = arg_46_0.isMotOn(var_46_1)

	if not var_46_0 and not var_46_2 then
		local var_46_3 = arg_46_0.curClassIDList[arg_46_1]

		pg = var_46_1

		return var_46_1.fleet_tech_ship_class[var_46_3]
	elseif var_46_0 then
		local var_46_4 = arg_46_0.curMetaClassIDList[arg_46_1]

		TechnologyConst = var_46_1

		return var_46_1.GetMetaClassConfig(var_46_4, arg_46_0.typeSelectedList)
	elseif var_46_2 then
		local var_46_5 = arg_46_0.curMotClassIDList[arg_46_1]

		TechnologyConst = var_46_1

		return var_46_1.GetMotClassConfig(var_46_5, arg_46_0.typeSelectedList)
	end

	return
end

function var_0_1.isMetaOn(arg_47_0)
	if arg_47_0.lastNationTrige == var_0_1.NationTrige.All then
		return false
	elseif arg_47_0.lastNationTrige == var_0_1.NationTrige.Mot then
		return false
	end

	return arg_47_0.nationMetaToggleCom.isOn
end

function var_0_1.isMotOn(arg_48_0)
	if arg_48_0.lastNationTrige == var_0_1.NationTrige.All then
		return false
	elseif arg_48_0.lastNationTrige == var_0_1.NationTrige.Meta then
		return false
	end

	return arg_48_0.nationMotToggleCom.isOn
end

return var_0_1
