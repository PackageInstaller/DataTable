class = var_0_10000

local var_0_0 = "IdolMedalCollectionView2"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.GetContainerPositions(arg_1_0)
	return {
		32.4,
		132.7
	}
end

function var_0_1.GetActivityID(arg_2_0)
	ActivityConst = var_1_10001

	return var_1_10001.MUSIC_FESTIVAL_MEDALCOLLECTION_2020
end

function var_0_1.getUIName(arg_3_0)
	return "IdolMedalCollectionUI2"
end

function var_0_1.init(arg_4_0)
	arg_4_0:initData()
	arg_4_0:findUI()
	arg_4_0:addListener()

	return
end

function var_0_1.didEnter(arg_5_0)
	arg_5_0:checkAward()
	arg_5_0:UpdateView()

	pg = var_1

	local var_5_0 = var_1.UIMgr.GetInstance()

	var_1.OverlayPanel(var_5_0, arg_5_0._tf)

	return
end

function var_0_1.willExit(arg_6_0)
	pg = var_1_10001

	local var_6_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_6_0, arg_6_0._tf)

	return
end

function var_0_1.initData(arg_7_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003
	arg_7_0.activityProxy = var_1_10001(var_1_10003)

	local var_7_0 = arg_7_0.activityProxy

	arg_7_0.activityData = var_1.getActivityById(var_7_0, arg_7_0:GetActivityID())

	local var_7_1 = arg_7_0.activityData

	arg_7_0.allIDList = var_1.GetPicturePuzzleIds(var_7_1)
	arg_7_0.activatableIDList = arg_7_0.activityData.data1_list
	arg_7_0.activeIDList = arg_7_0.activityData.data2_list

	return
end

local var_0_2 = {}

function var_0_1.findUI(arg_8_0)
	local var_8_0 = arg_8_0._tf

	arg_8_0.bg = var_1.Find(var_8_0, "BG")

	local var_8_1 = arg_8_0._tf
	local var_8_2 = var_1.Find(var_8_1, "NotchAdapt")

	arg_8_0.backBtn = var_1.Find(var_8_2, "BackBtn")
	arg_8_0.progressText = var_1:Find("ProgressText")
	arg_8_0.helpBtn = var_1:Find("HelpBtn")
	arg_8_0.top = var_1

	local var_8_3 = arg_8_0._tf

	arg_8_0.medalContainer = var_2.Find(var_8_3, "MedalContainer")
	arg_8_0.buttonNext = var_2:Find("ButtonNext")
	arg_8_0.buttonNextLocked = var_2:Find("ButtonNextLocked")
	arg_8_0.buttonPrev = var_2:Find("ButtonPrev")
	arg_8_0.buttonShare = var_2:Find("ButtonShare")
	arg_8_0.buttonReset = var_2:Find("ButtonReset")
	arg_8_0.pageCollection = var_2:Find("PageCollection")
	arg_8_0.pageModified = var_2:Find("PageModified")
	arg_8_0.OverlayPanel = var_2:Find("Overlay")
	arg_8_0.pages = {
		arg_8_0.pageCollection,
		arg_8_0.pageModified
	}
	arg_8_0.pageIndex = 1
	arg_8_0.medalItemList = {}

	for iter_8_0 = 1, #arg_8_0.allIDList do
		table = var_1_10007
		var_1_10007 = var_1_10007.insert
		var_1_10009 = arg_8_0.medalItemList

		local var_8_4 = arg_8_0.pageCollection

		var_1_10007(var_1_10009, var_10.Find(var_8_4, "Images/Medal" .. iter_8_0))
	end

	arg_8_0.medalTextList = {}

	for iter_8_1 = 1, #arg_8_0.allIDList do
		table = var_1_10007
		var_1_10007 = var_1_10007.insert
		var_1_10009 = arg_8_0.medalTextList

		local var_8_5 = arg_8_0.pageCollection

		var_1_10007(var_1_10009, var_10.Find(var_8_5, "Texts/Medal" .. iter_8_1))
	end

	arg_8_0.selectPanel = var_2:Find("SelectPanel")

	local var_8_6 = arg_8_0.selectPanel

	arg_8_0.selectPanelContainer = var_3.Find(var_8_6, "Scroll/Container")
	arg_8_0.allItems = {}
	arg_8_0.selectedPositionsInPanels = {}
	arg_8_0.listStayInPanel = {}
	arg_8_0.listShowOnPanel = {}
	arg_8_0.overlayingImage = nil

	for iter_8_2 = 0, arg_8_0.selectPanelContainer.childCount - 1 do
		var_1_10009 = arg_8_0.selectPanelContainer

		local var_8_7 = var_7.GetChild(var_1_10009, iter_8_2)
		local var_8_8 = arg_8_0.selectedPositionsInPanels

		var_8_8[var_8_7] = var_8_7.anchoredPosition
		table = var_8_8

		var_8_8.insert(arg_8_0.listStayInPanel, var_8_7)

		table = var_8

		var_8.insert(arg_8_0.allItems, var_8_7)
	end

	pairs = var_3

	for iter_8_3, iter_8_4 in var_3(var_0_2) do
		local var_8_9 = arg_8_0.allItems[iter_8_3]

		setParent = var_1_10009

		var_1_10009(var_8_9, arg_8_0.pageModified)

		table = var_1_10009

		var_1_10009.removebyvalue(arg_8_0.listStayInPanel, var_8_9)

		table = var_1_10009

		var_1_10009.insert(arg_8_0.listShowOnPanel, var_8_9)

		setAnchoredPosition = var_1_10009

		var_1_10009(var_8_9, iter_8_4)
	end

	setText = var_3

	local var_8_10 = arg_8_0.pageModified
	local var_8_11 = var_5.Find(var_8_10, "TextTip")

	i18n = iter_8_3

	var_3(var_8_11, iter_8_3("collect_idol_tip"))
	arg_8_0:AddLeanTween(function()
		LeanTween = var_2_10000

		local var_9_0 = var_2_10000.alphaText

		rtf = var_2_10002

		local var_9_1 = arg_8_0.pageModified
		local var_9_2 = var_9_0(var_2_10002(var_4.Find(var_9_1, "TextTip")), 1, 2)
		local var_9_3 = var_0.setFrom(var_9_2, 0)

		return var_0.setLoopPingPong(var_9_3)
	end)

	return
end

function var_0_1.addListener(arg_10_0)
	onButton = var_1_10001

	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0.backBtn

	local function var_10_2()
		local var_11_0 = arg_10_0

		var_0.closeView(var_11_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_10_0, var_10_1, var_10_2, var_1_10006)

	onButton = var_1_10001

	local var_10_3 = arg_10_0
	local var_10_4 = arg_10_0.helpBtn

	local function var_10_5()
		pg = var_2_10000

		local var_12_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_12_1 = var_0.ShowMsgBox
		local var_12_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_12_2.type = var_2_10004
		pg = var_2_10004
		var_12_2.helps = var_2_10004.gametip.music_collection.tip

		var_12_1(var_12_0, var_12_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_10_3, var_10_4, var_10_5, var_1_10006)

	onButton = var_1_10001

	var_1_10001(arg_10_0, arg_10_0.bg, function()
		local var_13_0 = arg_10_0

		var_0.SwitchSelectedImage(var_13_0, nil)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_10_0, arg_10_0.selectPanelContainer, function()
		local var_14_0 = arg_10_0

		var_0.SwitchSelectedImage(var_14_0, nil)

		return
	end)

	onButton = var_1_10001

	local var_10_6 = arg_10_0
	local var_10_7 = arg_10_0.buttonNext

	local function var_10_8()
		local var_15_0 = arg_10_0

		var_0.SwitchPage(var_15_0, 1)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_10_6, var_10_7, var_10_8, var_1_10006)

	onButton = var_1_10001

	local var_10_9 = arg_10_0
	local var_10_10 = arg_10_0.buttonNextLocked

	local function var_10_11()
		pg = var_2_10000

		local var_16_0 = var_2_10000.TipsMgr.GetInstance()
		local var_16_1 = var_0.ShowTips

		i18n = var_2_10003

		var_16_1(var_16_0, var_2_10003("hand_account_tip"))

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_10_9, var_10_10, var_10_11, var_1_10006)

	onButton = var_1_10001

	local var_10_12 = arg_10_0
	local var_10_13 = arg_10_0.buttonPrev

	local function var_10_14()
		local var_17_0 = arg_10_0

		var_0.SwitchPage(var_17_0, -1)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_10_12, var_10_13, var_10_14, var_1_10006)

	onButton = var_1_10001

	local var_10_15 = arg_10_0
	local var_10_16 = arg_10_0.buttonReset

	local function var_10_17()
		pg = var_2_10000

		local var_18_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_18_1 = var_0.ShowMsgBox
		local var_18_2 = {}

		i18n = var_2_10004
		var_18_2.content = var_2_10004("hand_account_resetting_tip")

		function var_18_2.onYes()
			local var_19_0 = arg_10_0

			var_0.ResetPanel(var_19_0)

			return
		end

		var_18_1(var_18_0, var_18_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_10_15, var_10_16, var_10_17, var_1_10006)

	onButton = var_1_10001

	local var_10_18 = arg_10_0
	local var_10_19 = arg_10_0.buttonShare

	local function var_10_20()
		setAnchoredPosition = var_2_10000

		local var_20_0 = arg_10_0.medalContainer
		local var_20_1 = {}
		local var_20_2 = arg_10_0

		var_20_1.x = var_4.GetContainerPositions(var_20_2)[1]

		var_2_10000(var_20_0, var_20_1)

		setActive = var_2_10000

		var_2_10000(arg_10_0.selectPanel, false)

		setActive = var_2_10000

		var_2_10000(arg_10_0.buttonNext, false)

		setActive = var_2_10000

		var_2_10000(arg_10_0.buttonNextLocked, false)

		setActive = var_2_10000

		var_2_10000(arg_10_0.buttonPrev, false)

		setActive = var_2_10000

		var_2_10000(arg_10_0.buttonShare, false)

		setActive = var_2_10000

		var_2_10000(arg_10_0.buttonReset, false)

		setActive = var_2_10000

		var_2_10000(arg_10_0.top, false)

		setActive = var_2_10000

		local var_20_3 = arg_10_0.pageModified

		var_2_10000(var_2.Find(var_20_3, "TextTip"), false)

		local var_20_4 = arg_10_0.lastSelectedImage
		local var_20_5 = arg_10_0

		var_1.SwitchSelectedImage(var_20_5, nil)

		pg = var_1

		local var_20_6 = var_1.ShareMgr.GetInstance()
		local var_20_7 = var_1.Share

		pg = var_4

		var_20_7(var_20_6, var_4.ShareMgr.TypePoraisMedals)

		setActive = var_20_7

		var_20_7(arg_10_0.top, true)

		setActive = var_20_7

		local var_20_8 = arg_10_0.pageModified

		var_20_7(var_3.Find(var_20_8, "TextTip"), true)

		local var_20_9 = arg_10_0

		var_1.SwitchSelectedImage(var_20_9, var_20_4)

		local var_20_10 = arg_10_0

		var_1.UpdateView(var_20_10)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_10_18, var_10_19, var_10_20, var_1_10006)

	GameObject = var_1_10001

	local var_10_21 = var_1_10001.Find("OverlayCamera")
	local var_10_22 = var_1.GetComponent(var_10_21, "Camera")

	ipairs = var_1_10002

	for iter_10_0, iter_10_1 in var_1_10002(arg_10_0.allItems) do
		local var_10_23 = arg_10_0.selectedPositionsInPanels[iter_10_1]

		setActive = var_1_10008

		var_1_10008(iter_10_1:Find("Selected"), false)

		GetOrAddComponent = var_1_10008
		var_1_10008 = var_1_10008(iter_10_1, "EventTriggerListener")

		local function var_10_24()
			if not arg_10_0.overlayingImage then
				return
			end

			local var_21_0 = arg_10_0.overlayingImage
			local var_21_1 = arg_10_0

			var_21_1.overlayingImage = nil
			ipairs = var_21_1

			for iter_21_0, iter_21_1 in var_21_1(arg_10_0.listStayInPanel) do
				if iter_21_1 == var_21_0 then
					setParent = var_2_10006

					var_2_10006(var_21_0, arg_10_0.selectPanelContainer)

					setAnchoredPosition = var_2_10006

					var_2_10006(var_21_0, arg_10_0.selectedPositionsInPanels[var_21_0])

					return
				end
			end

			ipairs = var_1

			for iter_21_2, iter_21_3 in var_1(arg_10_0.listShowOnPanel) do
				if iter_21_3 == var_21_0 then
					setParent = var_2_10006

					var_2_10006(var_21_0, arg_10_0.pageModified)
					var_21_0:SetAsLastSibling()

					return
				end
			end

			return
		end

		local var_10_25

		var_1_10008:AddPointClickFunc(function(arg_22_0, arg_22_1)
			if var_10_25 then
				return
			end

			if arg_10_0.lastSelectedImage == iter_10_1 then
				local var_22_0 = arg_10_0

				var_2.SwitchSelectedImage(var_22_0, nil)
			else
				local var_22_1 = arg_10_0

				var_2.SwitchSelectedImage(var_22_1, iter_10_1)

				local var_22_2 = iter_10_1

				var_2.SetAsLastSibling(var_22_2)
			end

			return
		end)
		var_1_10008:AddBeginDragFunc(function(arg_23_0, arg_23_1)
			var_10_25 = arg_23_1.position

			var_10_24()

			setParent = var_2

			var_2(iter_10_1, arg_10_0.OverlayPanel)

			arg_10_0.overlayingImage = iter_10_1

			local var_23_0 = arg_10_0

			var_2.SwitchSelectedImage(var_23_0, iter_10_1)

			return
		end)
		var_1_10008:AddDragFunc(function(arg_24_0, arg_24_1)
			LuaHelper = var_2_10002

			local var_24_0 = var_2_10002.ScreenToLocal

			rtf = var_2_10004

			local var_24_1 = var_24_0(var_2_10004(arg_10_0.OverlayPanel), arg_24_1.position, var_10_22)

			setAnchoredPosition = var_2_10003

			var_2_10003(iter_10_1, var_24_1)

			return
		end)
		var_1_10008:AddDragEndFunc(function(arg_25_0, arg_25_1)
			local var_25_0 = arg_25_1.position
			local var_25_1

			if var_10_25 then
				var_2_10005 = var_10_25
				var_2_10005 = var_3.Sub(var_2_10005, var_25_0)
				var_25_1 = var_3.SqrMagnitude(var_2_10005) < 1
			end

			var_10_25 = nil

			if var_25_1 then
				var_10_24()

				return
			end

			LuaHelper = var_2_10004

			local var_25_2 = var_2_10004.ScreenToLocal

			rtf = var_2_10006

			local var_25_3 = var_25_2(var_2_10006(arg_10_0.pageModified), arg_25_1.position, var_10_22)

			rtf = var_2_10005

			local var_25_4 = var_2_10005(arg_10_0.pageModified).rect
			local var_25_5

			if not var_5.Contains(var_25_4, var_25_3) then
				setParent = var_25_5

				var_25_5(iter_10_1, arg_10_0.selectPanelContainer)

				table = var_25_5

				var_25_5.removebyvalue(arg_10_0.listStayInPanel, iter_10_1)

				table = var_25_5

				var_25_5.removebyvalue(arg_10_0.listShowOnPanel, iter_10_1)

				table = var_25_5

				var_25_5.insert(arg_10_0.listStayInPanel, iter_10_1)

				var_25_5 = var_0_2
				var_25_5[iter_10_0] = nil
				setAnchoredPosition = var_25_5

				var_25_5(iter_10_1, var_10_23)

				local var_25_6 = iter_10_1

				var_25_5.SetAsLastSibling(var_25_6)
			else
				setParent = var_25_5

				var_25_5(iter_10_1, arg_10_0.pageModified)

				table = var_25_5

				var_25_5.removebyvalue(arg_10_0.listStayInPanel, iter_10_1)

				table = var_7

				var_7.removebyvalue(arg_10_0.listShowOnPanel, iter_10_1)

				table = var_7

				var_7.insert(arg_10_0.listShowOnPanel, iter_10_1)

				local var_25_7 = var_0_2

				var_25_7[iter_10_0] = var_25_3
				setAnchoredPosition = var_25_7

				var_25_7(iter_10_1, var_25_3)

				local var_25_8 = iter_10_1

				var_7.SetAsLastSibling(var_25_8)
			end

			arg_10_0.overlayingImage = nil

			return
		end)
	end

	return
end

function var_0_1.SwitchSelectedImage(arg_26_0, arg_26_1)
	if arg_26_0.lastSelectedImage == arg_26_1 then
		return
	end

	if arg_26_0.lastSelectedImage then
		setActive = var_2

		local var_26_0 = arg_26_0.lastSelectedImage

		var_2(var_4.Find(var_26_0, "Selected"), false)
	end

	arg_26_0.lastSelectedImage = arg_26_1

	if arg_26_1 then
		setActive = var_2

		var_2(arg_26_1:Find("Selected"), true)
	end

	return
end

function var_0_1.ResetPanel(arg_27_0)
	ipairs = var_1_10001

	for iter_27_0, iter_27_1 in var_1_10001(arg_27_0.listShowOnPanel) do
		table = var_1_10006

		var_1_10006.insert(arg_27_0.listStayInPanel, iter_27_1)

		setParent = var_1_10006

		var_1_10006(iter_27_1, arg_27_0.selectPanelContainer)

		if not arg_27_0.selectedPositionsInPanels[iter_27_1] then
			Vector2 = var_1_10006
			var_1_10006 = var_1_10006.zero
		end

		setAnchoredPosition = var_1_10007

		var_1_10007(iter_27_1, var_1_10006)
	end

	table = var_1

	var_1.clean(arg_27_0.listShowOnPanel)

	table = var_1

	var_1.clear(var_0_2)

	return
end

function var_0_1.UpdateView(arg_28_0)
	if arg_28_0.pageIndex == 1 then
		arg_28_0:updateMedalContainerView()
	end

	for iter_28_0 = 1, #arg_28_0.pages do
		setActive = var_1_10005

		local var_28_0 = arg_28_0.pages[iter_28_0]

		var_1_10008 = iter_28_0 == arg_28_0.pageIndex

		var_1_10005(var_28_0, var_1_10008)
	end

	setAnchoredPosition = var_1

	local var_28_1 = arg_28_0.medalContainer
	local var_28_2 = {}
	local var_28_3 = arg_28_0

	var_28_2.x = arg_28_0.GetContainerPositions(var_28_3)[arg_28_0.pageIndex]

	var_1(var_28_1, var_28_2)

	setActive = var_1

	var_1(arg_28_0.selectPanel, arg_28_0.pageIndex == 2)

	local var_28_4 = #arg_28_0.activeIDList == #arg_28_0.allIDList and arg_28_0.activityData.data1 == 1

	setActive = var_2

	var_2(arg_28_0.buttonNext, var_28_4 and arg_28_0.pageIndex == 1)

	setActive = var_2

	var_2(arg_28_0.buttonNextLocked, not var_28_4 and arg_28_0.pageIndex == 1)

	setActive = var_2

	var_2(arg_28_0.buttonPrev, arg_28_0.pageIndex == 2)

	setActive = var_2

	var_2(arg_28_0.buttonShare, arg_28_0.pageIndex == 2)

	setActive = var_2

	var_2(arg_28_0.buttonReset, arg_28_0.pageIndex == 2)

	setText = var_2

	local var_28_5 = arg_28_0.progressText

	setColorStr = var_5
	tostring = var_28_3

	local var_28_6 = var_28_3(#arg_28_0.activeIDList)

	COLOR_RED = var_1_10008

	var_2(var_28_5, var_5(var_28_6, var_1_10008) .. "/" .. #arg_28_0.allIDList)

	return
end

function var_0_1.updateMedalContainerView(arg_29_0)
	ipairs = var_1_10001

	for iter_29_0, iter_29_1 in var_1_10001(arg_29_0.allIDList) do
		arg_29_0:updateMedalView(arg_29_0.allIDList, iter_29_1)
	end

	return
end

function var_0_1.updateMedalView(arg_30_0, arg_30_1, arg_30_2)
	table = var_1_10003

	local var_30_0 = var_1_10003.indexof(arg_30_1, arg_30_2, 1)

	table = var_1_10004

	local var_30_1 = var_1_10004.contains(arg_30_0.activeIDList, arg_30_2)

	table = var_5

	local var_30_2

	if var_5.contains(arg_30_0.activatableIDList, arg_30_2) then
		var_30_2 = not var_30_1
	end

	local var_30_3 = not var_30_1 and not var_30_2
	local var_30_4 = arg_30_0.medalItemList[var_30_0]
	local var_30_5 = arg_30_0.medalTextList[var_30_0]
	local var_30_6 = var_8.Find(var_30_5, "Activable")
	local var_30_7 = var_8
	local var_30_8 = var_8.Find(var_30_7, "DisActive")

	setImageAlpha = var_30_5

	var_30_5(var_30_4, var_30_1 and 1 or 0)

	setActive = var_30_5

	var_30_5(var_30_6, var_30_2)

	setActive = var_30_5

	var_30_5(var_30_8, var_30_3)

	onButton = var_30_5

	local var_30_9 = arg_30_0
	local var_30_10 = var_30_4

	local function var_30_11()
		if not var_30_2 then
			return
		end

		pg = var_0

		local var_31_0 = var_0.m02
		local var_31_1 = var_0.sendNotification

		GAME = var_2_10003

		var_31_1(var_31_0, var_2_10003.MEMORYBOOK_UNLOCK, {
			id = arg_30_2,
			actId = arg_30_0.activityData.id
		})

		return
	end

	SFX_PANEL = var_1_10016

	var_30_5(var_30_9, var_30_10, var_30_11, var_1_10016)

	local var_30_12 = ""

	setText = var_30_7

	var_30_7(var_30_8, var_30_12)

	return
end

function var_0_1.updateAfterSubmit(arg_32_0)
	return
end

function var_0_1.UpdateActivity(arg_33_0)
	arg_33_0:initData()
	arg_33_0:checkAward()
	arg_33_0:UpdateView()

	return
end

function var_0_1.SwitchPage(arg_34_0, arg_34_1)
	math = var_1_10002
	arg_34_0.pageIndex = var_1_10002.clamp(arg_34_0.pageIndex + arg_34_1, 1, #arg_34_0.pages)

	arg_34_0:UpdateView()

	return
end

function var_0_1.checkAward(arg_35_0)
	if #arg_35_0.activeIDList == #arg_35_0.allIDList and arg_35_0.activityData.data1 ~= 1 then
		pg = var_1

		local var_35_0 = var_1.m02
		local var_35_1 = var_1.sendNotification

		GAME = var_1_10004

		var_35_1(var_35_0, var_1_10004.ACTIVITY_OPERATION, {
			cmd = 1,
			activity_id = arg_35_0.activityData.id
		})
	end

	return
end

return var_0_1
