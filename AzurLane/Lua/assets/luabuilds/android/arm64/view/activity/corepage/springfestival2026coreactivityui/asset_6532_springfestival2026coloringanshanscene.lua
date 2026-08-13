class = var_0_10000

local var_0_0 = "SpringFestival2026ColoringAnshanscene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))
local var_0_2 = 387
local var_0_3 = 467
local var_0_4 = 812.5
local var_0_5 = 1200

Vector2 = var_5

local var_0_6 = var_5(49, -436.12)

function var_0_1.getUIName(arg_1_0)
	return "SpringFestival2026ColoringAnshanUI"
end

function var_0_1.setActivity(arg_2_0, arg_2_1)
	arg_2_0.activity = arg_2_1

	return
end

function var_0_1.setColorItems(arg_3_0, arg_3_1)
	arg_3_0.colorItems = arg_3_1

	return
end

function var_0_1.setColorGroups(arg_4_0, arg_4_1)
	arg_4_0.colorGroups = arg_4_1

	return
end

function var_0_1.init(arg_5_0)
	local var_5_0 = arg_5_0._tf

	arg_5_0.rtAdapt = var_1.Find(var_5_0, "adapt")

	local var_5_1 = arg_5_0.rtAdapt

	arg_5_0.topPanel = var_1.Find(var_5_1, "top")

	local var_5_2 = arg_5_0.rtAdapt

	arg_5_0.btnBack = var_1.Find(var_5_2, "top/btnBack")

	local var_5_3 = arg_5_0.rtAdapt

	arg_5_0.title = var_1.Find(var_5_3, "center/title_bar/text")

	local var_5_4 = arg_5_0.rtAdapt

	arg_5_0.bg = var_1.Find(var_5_4, "center/board/container/bg")

	local var_5_5 = arg_5_0.rtAdapt

	arg_5_0.painting = var_1.Find(var_5_5, "center/painting")

	local var_5_6 = arg_5_0.rtAdapt

	arg_5_0.paintingCompleted = var_1.Find(var_5_6, "center/painting_completed")

	local var_5_7 = arg_5_0.bg

	arg_5_0.zoom = var_1.GetComponent(var_5_7, "Zoom")
	arg_5_0.zoom.maxZoom = 3

	local var_5_8 = arg_5_0.bg

	arg_5_0.cells = var_1.Find(var_5_8, "cells")

	local var_5_9 = arg_5_0.bg

	arg_5_0.cell = var_1.Find(var_5_9, "cell")

	local var_5_10 = arg_5_0.bg

	arg_5_0.lines = var_1.Find(var_5_10, "lines")

	local var_5_11 = arg_5_0.bg

	arg_5_0.line = var_1.Find(var_5_11, "line")

	local var_5_12 = arg_5_0.rtAdapt

	arg_5_0.btnHelp = var_1.Find(var_5_12, "top/btnHelp")

	local var_5_13 = arg_5_0.rtAdapt

	arg_5_0.btnShare = var_1.Find(var_5_13, "top/btnShare")

	local var_5_14 = arg_5_0.rtAdapt

	arg_5_0.colorgroupfront = var_1.Find(var_5_14, "center/colorgroupfront")

	local var_5_15 = arg_5_0.rtAdapt

	arg_5_0.scrollColor = var_1.Find(var_5_15, "color_bar/scroll")

	local var_5_16 = arg_5_0.rtAdapt

	arg_5_0.barExtra = var_1.Find(var_5_16, "color_bar/extra")

	local var_5_17 = arg_5_0.barExtra

	arg_5_0.toggleEraser = var_1.Find(var_5_17, "eraser")

	local var_5_18 = arg_5_0.barExtra

	arg_5_0.btnEraserAll = var_1.Find(var_5_18, "eraser_all")

	local var_5_19 = arg_5_0.barExtra

	arg_5_0.arrowDown = var_1.Find(var_5_19, "arrow")
	setActive = var_1

	var_1(arg_5_0.cell, false)

	setActive = var_1

	var_1(arg_5_0.line, false)

	setActive = var_1

	var_1(arg_5_0.barExtra, false)

	return
end

function var_0_1.DidMediatorRegisterDone(arg_6_0)
	local var_6_0 = arg_6_0.colorGroups[1]
	local var_6_1 = var_1.getConfig(var_6_0, "color_id_list")

	CustomIndexLayer = var_1_10002

	local var_6_2 = var_1_10002.Clone2Full
	local var_6_3 = arg_6_0.scrollColor

	arg_6_0.colorPlates = var_6_2(var_4.Find(var_6_3, "content"), #var_6_1)

	local var_6_4 = #arg_6_0.colorGroups

	arg_6_0.coloringUIGroupName = "ColoringUIGroupSize" .. var_6_4
	PoolMgr = var_3

	local var_6_5 = var_3.GetInstance()

	var_3.GetUI(var_6_5, arg_6_0.coloringUIGroupName, false, function(arg_7_0)
		setParent = var_2_10001

		local var_7_0 = arg_7_0
		local var_7_1 = arg_6_0.rtAdapt

		var_2_10001(var_7_0, var_4.Find(var_7_1, "center"))

		setAnchoredPosition = var_2_10001

		var_2_10001(arg_7_0, var_0_6)

		tf = var_2_10001

		local var_7_2 = var_2_10001(arg_7_0)

		var_1.SetSiblingIndex(var_7_2, 1)

		setActive = var_1

		var_1(arg_7_0, true)

		local var_7_3 = arg_6_0

		tf = var_2_10002
		var_7_3.colorgroupbehind = var_2_10002(arg_7_0)
		arg_6_0.paintsgroup = {}

		for iter_7_0 = arg_6_0.colorgroupbehind.childCount - 1, 0, -1 do
			local var_7_4 = arg_6_0.colorgroupbehind
			local var_7_5 = var_5.GetChild(var_7_4, iter_7_0)

			table = var_7_1

			var_7_1.insert(arg_6_0.paintsgroup, var_7_5)
		end

		return
	end)

	COLORING_ACTIVITY_CUSTOMIZED_BANNED = var_3

	local var_6_6

	if not var_3 then
		_ = var_3
		var_6_6 = var_3.any(arg_6_0.colorGroups, function(arg_8_0)
			return arg_8_0:canBeCustomised()
		end)
	else
		var_6_6 = false
	end

	if false then
		var_6_6 = true
	end

	setActive = var_4

	var_4(arg_6_0.btnShare, var_6_6)

	return
end

function var_0_1.didEnter(arg_9_0)
	onButton = var_1_10001

	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.btnBack

	local function var_9_2()
		if arg_9_0.exited then
			return
		end

		local var_10_0 = arg_9_0

		var_0.uiExitAnimating(var_10_0)

		local var_10_1 = arg_9_0

		var_0.emit(var_10_1, var_0_1.ON_BACK_PRESSED)

		return
	end

	SOUND_BACK = var_1_10006

	var_1_10001(var_9_0, var_9_1, var_9_2, var_1_10006)

	onButton = var_1_10001

	local var_9_3 = arg_9_0
	local var_9_4 = arg_9_0.btnHelp

	local function var_9_5()
		pg = var_2_10000

		local var_11_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_11_1 = var_0.ShowMsgBox
		local var_11_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_11_2.type = var_2_10004
		i18n = var_2_10004
		var_11_2.helps = var_2_10004("coloring_help_tip")

		var_11_1(var_11_0, var_11_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_9_3, var_9_4, var_9_5, var_1_10006)

	onButton = var_1_10001

	local var_9_6 = arg_9_0
	local var_9_7 = arg_9_0.btnShare

	local function var_9_8()
		pg = var_2_10000

		local var_12_0 = var_2_10000.ShareMgr.GetInstance()
		local var_12_1 = var_0.Share

		pg = var_2_10003

		var_12_1(var_12_0, var_2_10003.ShareMgr.TypeColoring)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_9_6, var_9_7, var_9_8, var_1_10006)

	onNextTick = var_1_10001

	var_1_10001(function()
		if arg_9_0.exited then
			return
		end

		local var_13_0 = arg_9_0

		var_0.uiStartAnimating(var_13_0)

		return
	end)
	arg_9_0:initColoring()
	arg_9_0:updatePage()

	return
end

function var_0_1.uiStartAnimating(arg_14_0)
	local var_14_0 = 0
	local var_14_1 = 0.3
	local var_14_2 = arg_14_0.topPanel

	Vector2 = var_1_10004
	var_14_2.anchoredPosition = var_1_10004(0, arg_14_0.topPanel.rect.height)
	shiftPanel = var_14_2

	var_14_2(arg_14_0.topPanel, nil, 0, var_14_1, var_14_0, true, true, nil)

	return
end

function var_0_1.uiExitAnimating(arg_15_0)
	local var_15_0 = 0
	local var_15_1 = 0.3

	shiftPanel = var_1_10003

	var_1_10003(arg_15_0.topPanel, nil, arg_15_0.topPanel.rect.height, var_15_1, var_15_0, true, true, nil)

	return
end

function var_0_1.initColoring(arg_16_0)
	onButton = var_1_10001

	local var_16_0 = arg_16_0
	local var_16_1 = arg_16_0.btnEraserAll

	local function var_16_2()
		pg = var_2_10000

		local var_17_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_17_1 = var_0.ShowMsgBox
		local var_17_2 = {}

		i18n = var_2_10004
		var_17_2.content = var_2_10004("coloring_erase_all_warning")

		function var_17_2.onYes()
			local var_18_0 = arg_16_0.colorGroups[arg_16_0.selectedIndex]

			if var_0.canBeCustomised(var_18_0) then
				local var_18_1 = arg_16_0
				local var_18_2 = var_1.emit

				SpringFestival2026ColoringAnshanMediator = var_3_10004

				var_18_2(var_18_1, var_3_10004.EVENT_COLORING_CLEAR, {
					activityId = arg_16_0.activity.id,
					id = var_0.id
				})
			end

			return
		end

		var_17_1(var_17_0, var_17_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_16_0, var_16_1, var_16_2, var_1_10006)

	onButton = var_1_10001

	local var_16_3 = arg_16_0
	local var_16_4 = arg_16_0.arrowDown

	local function var_16_5()
		local var_19_0 = arg_16_0.scrollColor
		local var_19_1 = var_0.GetComponent

		typeof = var_2_10003
		ScrollRect = var_2_10005
		var_19_1(var_19_0, var_2_10003(var_2_10005)).verticalNormalizedPosition = 0

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_16_3, var_16_4, var_16_5, var_1_10006)

	local var_16_6 = 1

	for iter_16_0 = 1, #arg_16_0.colorGroups do
		local var_16_7 = arg_16_0.colorGroups[iter_16_0]
		local var_16_8 = var_6.getState(var_16_7)

		ColorGroup = var_1_10007

		if var_16_8 == var_1_10007.StateColoring then
			var_16_6 = iter_16_0

			break
		end
	end

	Mathf = var_2

	local var_16_9 = var_2.Min(var_16_6, #arg_16_0.paintsgroup)

	arg_16_0:initInteractive()

	arg_16_0.selectedIndex = 0
	arg_16_0.selectedColorIndex = 0
	triggerButton = var_2

	var_2(arg_16_0.paintsgroup[var_16_9])

	return
end

function var_0_1.initInteractive(arg_20_0)
	pairs = var_1_10001

	for iter_20_0, iter_20_1 in var_1_10001(arg_20_0.paintsgroup) do
		var_1_10006 = iter_20_0

		local var_20_0 = arg_20_0.colorGroups[var_1_10006]

		onButton = var_1_10008

		local var_20_1 = arg_20_0

		var_1_10011 = iter_20_1

		local function var_20_2()
			local var_21_0 = var_20_0
			local var_21_1 = var_0.getState(var_21_0)

			if arg_20_0.selectedIndex ~= var_1_10006 then
				ColorGroup = var_1

				if var_21_1 ~= var_1.StateLock then
					if arg_20_0.paintsgroup[arg_20_0.selectedIndex] then
						var_2_10004 = var_1

						var_1.SetParent(var_2_10004, arg_20_0.colorgroupbehind)
					end

					arg_20_0.selectedIndex = var_1_10006
					var_2_10004 = iter_20_1

					var_2.SetParent(var_2_10004, arg_20_0.colorgroupfront)

					var_2_10004 = arg_20_0

					var_2.SelectColoBar(var_2_10004, 0)

					var_2_10004 = arg_20_0

					var_2.updateSelectedColoring(var_2_10004)

					goto label_21_0
				end
			end

			ColorGroup = var_1

			if var_21_1 == var_1.StateLock then
				pg = var_1

				local var_21_2 = var_1.TipsMgr.GetInstance()
				local var_21_3 = var_1.ShowTips

				i18n = var_2_10004

				var_21_3(var_21_2, var_2_10004("coloring_lock"))
			end

			::label_21_0::

			local var_21_4 = arg_20_0

			var_1.updatePage(var_21_4)

			return
		end

		SFX_PANEL = var_1_10013

		var_1_10008(var_20_1, var_1_10011, var_20_2, var_1_10013)
	end

	for iter_20_2 = 0, #arg_20_0.colorPlates - 1 do
		local var_20_3 = arg_20_0.colorPlates[iter_20_2 + 1]

		onButton = var_1_10006

		local var_20_4 = arg_20_0
		local var_20_5 = var_20_3

		local function var_20_6()
			local var_22_0 = arg_20_0

			var_0.SelectColoBar(var_22_0, iter_20_2 + 1)

			local var_22_1 = arg_20_0.colorGroups[arg_20_0.selectedIndex]
			local var_22_2 = var_0.getState(var_22_1)

			ColorGroup = var_22_0

			if var_22_2 == var_22_0.StateColoring and not var_0:canBeCustomised() then
				local var_22_3 = var_0:getConfig("color_id_list")[arg_20_0.selectedColorIndex]
				local var_22_4

				if not arg_20_0.colorItems[var_22_3] then
					var_22_4 = 0
				end

				if var_22_4 ~= 0 then
					local var_22_5 = arg_20_0

					if var_3.SearchValidDiagonalColoringCells(var_22_5, var_0, arg_20_0.selectedColorIndex, var_22_4) and #var_3 > 0 then
						local var_22_6 = arg_20_0
						local var_22_7 = var_4.emit

						SpringFestival2026ColoringAnshanMediator = var_7

						var_22_7(var_22_6, var_7.EVENT_COLORING_CELL, {
							activityId = arg_20_0.activity.id,
							id = var_0.id,
							cells = var_3
						})
					end
				elseif not var_0:isAllFill(arg_20_0.selectedColorIndex) then
					pg = var_3

					local var_22_8 = var_3.TipsMgr.GetInstance()
					local var_22_9 = var_3.ShowTips

					i18n = var_6

					var_22_9(var_22_8, var_6("coloring_color_not_enough"))
				end
			end

			return
		end

		SFX_PANEL = var_1_10011

		var_1_10006(var_20_4, var_20_5, var_20_6, var_1_10011)
	end

	onButton = var_1

	local var_20_7 = arg_20_0
	local var_20_8 = arg_20_0.toggleEraser

	local function var_20_9()
		local var_23_0 = arg_20_0

		var_0.SelectColoBar(var_23_0, 0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_20_7, var_20_8, var_20_9, var_1_10006)

	return
end

function var_0_1.SelectColoBar(arg_24_0, arg_24_1)
	if arg_24_0.selectedColorIndex ~= 0 and arg_24_0.selectedColorIndex ~= arg_24_1 then
		local var_24_0 = arg_24_0.colorPlates[arg_24_0.selectedColorIndex]
		local var_24_1 = var_2.Find(var_24_0, "icon").sizeDelta

		var_24_1.x = var_0_2
		var_3.sizeDelta = var_24_1
	end

	arg_24_0.selectedColorIndex = arg_24_1

	if arg_24_0.selectedColorIndex ~= 0 then
		local var_24_2 = arg_24_0.colorPlates[arg_24_0.selectedColorIndex]
		local var_24_3 = var_2.Find(var_24_2, "icon").sizeDelta

		var_24_3.x = var_0_3
		var_3.sizeDelta = var_24_3
	end

	return
end

function var_0_1.updatePage(arg_25_0)
	ipairs = var_1_10001

	for iter_25_0, iter_25_1 in var_1_10001(arg_25_0.paintsgroup) do
		local var_25_0 = arg_25_0.colorGroups[iter_25_0]
		local var_25_1 = var_6.getState(var_25_0)

		setActive = var_1_10008

		local var_25_2 = iter_25_1:Find("lock")

		ColorGroup = var_1_10011
		var_1_10011 = var_25_1 == var_1_10011.StateLock

		var_1_10008(var_25_2, var_1_10011)

		setActive = var_1_10008

		local var_25_3 = iter_25_1:Find("get")

		ColorGroup = var_1_10011
		var_1_10011 = var_25_1 == var_1_10011.StateAchieved

		var_1_10008(var_25_3, var_1_10011)
	end

	local var_25_4 = #arg_25_0.paintsgroup
	local var_25_5 = 0

	for iter_25_2 = var_25_4, 1, -1 do
		if iter_25_2 ~= arg_25_0.selectedIndex then
			local var_25_6 = arg_25_0.paintsgroup[iter_25_2]

			var_7.SetSiblingIndex(var_25_6, var_25_5)

			var_25_5 = var_25_5 + 1
		end
	end

	getProxy = var_3
	ColoringProxy = var_5

	local var_25_7 = var_3(var_5)

	if var_3.IsALLAchieve(var_25_7) then
		IsNil = var_4

		if not var_4(arg_25_0.paintingCompleted) then
			setActive = var_4

			var_4(arg_25_0.painting, false)

			setActive = var_4

			var_4(arg_25_0.paintingCompleted, true)
		end
	end

	arg_25_0:TryPlayStory()

	return
end

function var_0_1.updateSelectedColoring(arg_26_0)
	local var_26_0 = arg_26_0.colorGroups[arg_26_0.selectedIndex]
	local var_26_1 = var_1.getConfig(var_26_0, "color_id_list")

	for iter_26_0 = 1, #arg_26_0.colorPlates do
		local var_26_2 = arg_26_0.colorPlates[iter_26_0]

		setText = var_1_10008
		var_1_10010 = var_26_2:Find("icon/x/nums")

		local var_26_3

		if not arg_26_0.colorItems[var_26_1[iter_26_0]] then
			var_26_3 = 0
		end

		var_1_10008(var_1_10010, var_26_3)
	end

	local var_26_4 = var_1:getConfig("name")

	setText = var_4

	var_4(arg_26_0.title, var_26_4)

	setActive = var_4

	var_4(arg_26_0.title.parent, var_26_4 ~= nil)

	setActive = var_4

	var_4(arg_26_0.barExtra, var_1:canBeCustomised())

	local var_26_5 = arg_26_0.scrollColor.sizeDelta
	local var_26_6

	if not var_1:canBeCustomised() or not var_0_4 then
		var_26_6 = var_0_5
	end

	var_26_5.y = var_26_6
	arg_26_0.scrollColor.sizeDelta = var_26_5

	local var_26_7 = arg_26_0.scrollColor
	local var_26_8 = var_5.GetComponent

	typeof = var_1_10008
	ScrollRect = var_1_10010

	local var_26_9 = var_26_8(var_26_7, var_1_10008(var_1_10010))

	var_26_9.verticalNormalizedPosition = 1
	setActive = var_26_9

	var_26_9(arg_26_0.scrollColor, false)

	setActive = var_26_9

	var_26_9(arg_26_0.scrollColor, true)

	arg_26_0.cellSize = arg_26_0:calcCellSize()

	arg_26_0:updateCells()

	local var_26_10 = arg_26_0

	arg_26_0.updateLines(var_26_10)

	getProxy = var_5
	ColoringProxy = var_26_10

	local var_26_11 = var_5(var_26_10)
	local var_26_12 = var_5.SetViewedPage
	local var_26_13

	if not arg_26_0.selectedIndex then
		var_26_13 = 1
	end

	var_26_12(var_26_11, var_26_13)

	return
end

function var_0_1.updateCells(arg_27_0)
	local var_27_0 = arg_27_0.colorGroups[arg_27_0.selectedIndex]

	unpack = var_2

	local var_27_1, var_27_2 = var_2(var_27_0:getConfig("theme"))

	for iter_27_0 = 0, var_27_1 do
		for iter_27_1 = 0, var_27_2 do
			arg_27_0:updateCell(iter_27_0, iter_27_1)
		end
	end

	local var_27_3 = arg_27_0.bg
	local var_27_4 = var_4.GetComponent(var_27_3, "EventTriggerListener")

	var_4.RemovePointClickFunc(var_27_4)
	var_4:RemoveBeginDragFunc()
	var_4:RemoveDragFunc()
	var_4:RemoveDragEndFunc()

	local var_27_5 = false

	var_4:AddPointClickFunc(function(arg_28_0, arg_28_1)
		local var_28_0 = var_27_0

		if not var_2.canBeCustomised(var_28_0) then
			return
		end

		if var_27_5 then
			return
		end

		LuaHelper = var_2

		local var_28_1 = var_2.ScreenToLocal
		local var_28_2 = arg_27_0.bg
		local var_28_3 = arg_28_1.position

		GameObject = var_2_10006

		local var_28_4 = var_2_10006.Find("UICamera")
		local var_28_5 = var_6.GetComponent

		typeof = var_2_10009
		Camera = var_2_10011

		local var_28_6 = var_28_1(var_28_2, var_28_3, var_28_5(var_28_4, var_2_10009(var_2_10011)))

		math = var_2_10003

		local var_28_7 = var_2_10003.floor(-var_28_6.y / arg_27_0.cellSize.y)

		math = var_28_2

		local var_28_8 = var_28_2.floor(var_28_6.x / arg_27_0.cellSize.x)
		local var_28_9 = var_27_0
		local var_28_10 = var_5.getState(var_28_9)

		ColorGroup = var_6

		if var_28_10 == var_6.StateColoring then
			local function var_28_11()
				local var_29_0 = arg_27_0
				local var_29_1 = var_0.emit

				SpringFestival2026ColoringAnshanMediator = var_3_10003

				local var_29_2 = var_3_10003.EVENT_COLORING_CELL
				local var_29_3 = {
					activityId = arg_27_0.activity.id,
					id = var_27_0.id
				}
				local var_29_4 = arg_27_0

				var_29_3.cells = var_5.searchColoringCells(var_29_4, var_27_0, var_28_7, var_28_8, arg_27_0.selectedColorIndex)

				var_29_1(var_29_0, var_29_2, var_29_3)

				return
			end

			local var_28_12 = var_27_0

			if not var_6.canBeCustomised(var_28_12) then
				return
			elseif arg_27_0.selectedColorIndex == 0 then
				local var_28_13 = var_27_0

				if not var_6.hasFill(var_28_13, var_28_7, var_28_8) then
					return
				end
			end

			var_28_11()
		end

		return
	end)
	var_4:AddBeginDragFunc(function()
		var_27_5 = false

		return
	end)

	Vector2 = var_6

	local var_27_6 = var_6.New
	local var_27_7 = arg_27_0.bg.rect.width

	UnityEngine = var_9

	local var_27_8 = var_27_7 / var_9.Screen.width
	local var_27_9 = arg_27_0.bg.rect.height

	UnityEngine = var_1_10010

	local var_27_10 = var_27_6(var_27_8, var_27_9 / var_1_10010.Screen.height)

	var_4:AddDragFunc(function(arg_31_0, arg_31_1)
		var_27_5 = true
		IsUnityEditor = var_2_10002

		if not var_2_10002 then
			var_2_10002 = arg_27_0.zoom
			Input = var_2_10003
			var_2_10002.enabled = var_2_10003.touchCount == 2
		end

		IsUnityEditor = var_2_10002

		if var_2_10002 or not arg_27_0.zoom.enabled then
			var_2.x = arg_27_0.bg.anchoredPosition.x + arg_31_1.delta.x * var_27_10.x
			math = var_3
			var_2.x = var_3.clamp(var_2.x, -arg_27_0.bg.rect.width * (arg_27_0.bg.localScale.x - 1), 0)
			var_2.y = var_2.y + arg_31_1.delta.y * var_27_10.y
			math = var_3
			var_2.y = var_3.clamp(var_2.y, 0, arg_27_0.bg.rect.height * (arg_27_0.bg.localScale.y - 1))
			arg_27_0.bg.anchoredPosition = var_2
		end

		return
	end)
	var_4:AddDragEndFunc(function()
		var_27_5 = false

		return
	end)

	return
end

function var_0_1.updateCell(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_0.colorGroups[arg_33_0.selectedIndex]
	local var_33_1 = var_3.getCell(var_33_0, arg_33_1, arg_33_2)
	local var_33_2 = var_3
	local var_33_3 = var_3.getFill(var_33_2, arg_33_1, arg_33_2)
	local var_33_4 = var_3:getState()

	ColorGroup = var_33_2

	if var_33_4 ~= var_33_2.StateFinish then
		ColorGroup = var_7

		if var_33_4 == var_7.StateAchieved then
			var_33_3 = var_33_1
		end

		local var_33_5 = arg_33_1 .. "_" .. arg_33_2
		local var_33_6 = arg_33_0.cells
		local var_33_7 = var_8.Find(var_33_6, var_33_5)
		local var_33_9

		if var_33_1 or var_33_3 then
			if not var_33_7 then
				cloneTplTo = var_33_9
				var_33_7 = var_33_9(arg_33_0.cell, arg_33_0.cells, var_33_5)
			end

			var_33_7.sizeDelta = arg_33_0.cellSize
			Vector2 = var_33_9
			var_33_7.anchoredPosition = var_33_9((var_33_3 or var_33_1).column * arg_33_0.cellSize.x, -((var_33_3 or var_33_1).row * arg_33_0.cellSize.y))

			local var_33_8 = var_33_7

			var_33_9 = var_33_7.Find(var_33_8, "image")

			local var_33_10 = var_33_7:Find("text")

			if var_33_3 then
				setImageColor = var_33_8

				var_33_8(var_33_9, var_3.colors[var_33_3.type])
			else
				setText = var_33_8

				local var_33_11 = var_33_10

				string = var_1_10014

				local var_33_12 = var_1_10014.char

				string = var_1_10016

				var_33_8(var_33_11, var_33_12(var_1_10016.byte("A") + var_33_1.type - 1))
			end

			setActive = var_33_8

			var_33_8(var_33_9, var_33_3)

			setActive = var_33_8

			var_33_8(var_33_10, not var_33_3)

			setActive = var_33_8

			var_33_8(var_33_7, true)
		elseif var_33_7 then
			setActive = var_33_9

			var_33_9(var_33_7, false)
		end

		return
	end
end

function var_0_1.calcCellSize(arg_34_0)
	local var_34_0 = arg_34_0.colorGroups[arg_34_0.selectedIndex]

	unpack = var_2

	local var_34_1, var_34_2 = var_2(var_34_0:getConfig("theme"))
	local var_34_3 = arg_34_0.bg.rect

	Vector2 = var_1_10005

	return (var_1_10005.New(var_34_3.width / var_34_2, var_34_3.height / var_34_1))
end

function var_0_1.updateLines(arg_35_0)
	local var_35_0 = arg_35_0.colorGroups[arg_35_0.selectedIndex]

	unpack = var_2

	local var_35_1, var_35_2 = var_2(var_35_0:getConfig("theme"))

	for iter_35_0 = 1, var_35_2 - 1 do
		local var_35_3 = "column_" .. iter_35_0
		local var_35_4 = arg_35_0.lines
		local var_35_5

		if not var_9.Find(var_35_4, var_35_3) then
			cloneTplTo = var_1_10010
			var_35_5 = var_1_10010(arg_35_0.line, arg_35_0.lines, var_35_3)
		end

		Vector2 = var_1_10010
		var_35_5.sizeDelta = var_1_10010.New(1, arg_35_0.lines.rect.height)
		Vector2 = var_1_10010
		var_35_5.anchoredPosition = var_1_10010.New(iter_35_0 * arg_35_0.cellSize.x - 0.5, 0)
	end

	for iter_35_1 = 1, var_35_1 - 1 do
		local var_35_6 = "row_" .. iter_35_1
		local var_35_7 = arg_35_0.lines
		local var_35_8

		if not var_9.Find(var_35_7, var_35_6) then
			cloneTplTo = var_1_10010
			var_35_8 = var_1_10010(arg_35_0.line, arg_35_0.lines, var_35_6)
		end

		Vector2 = var_1_10010
		var_35_8.sizeDelta = var_1_10010.New(arg_35_0.lines.rect.width, 1)
		Vector2 = var_1_10010
		var_35_8.anchoredPosition = var_1_10010.New(0, -(iter_35_1 * arg_35_0.cellSize.y - 0.5))
	end

	return
end

function var_0_1.searchColoringCells(arg_36_0, arg_36_1, arg_36_2, arg_36_3, arg_36_4)
	local var_36_0 = {
		row = arg_36_2,
		column = arg_36_3,
		color = arg_36_4
	}

	if arg_36_1:canBeCustomised() then
		return {
			var_36_0
		}
	else
		local var_36_1 = arg_36_1:getConfig("color_id_list")[arg_36_4]
		local var_36_2 = arg_36_0.colorItems[var_36_1]
		local var_36_3 = {}
		local var_36_4 = {}
		local var_36_5 = {
			var_36_0
		}
		local var_36_6 = {
			{
				row = -1,
				column = 0
			},
			{
				row = 1,
				column = 0
			},
			{
				row = 0,
				column = -1
			},
			{
				row = 0,
				column = 1
			},
			{
				row = -1,
				column = -1
			},
			{
				row = -1,
				column = 1
			},
			{
				row = 1,
				column = -1
			},
			{
				row = 1,
				column = 1
			}
		}

		while #var_36_5 > 0 and 0 < var_36_2 do
			table = var_36_7

			local var_36_7 = var_36_7.remove(var_36_5, 1)

			if not arg_36_1:hasFill(var_36_7.row, var_36_7.column) and var_36_7.color == arg_36_4 then
				table = var_13

				var_13.insert(var_36_3, var_36_7)

				var_36_2 = var_36_2 - 1
				_ = var_13

				var_13.each(var_36_6, function(arg_37_0)
					local var_37_0 = arg_36_1

					if var_1.getCell(var_37_0, arg_37_0.row + var_36_7.row, arg_37_0.column + var_36_7.column) then
						_ = var_2_10002

						local var_37_1

						if not var_2_10002.any(var_36_5, function(arg_38_0)
							return arg_38_0.row == var_0.row and arg_38_0.column == var_0.column
						end) then
							_ = var_37_1
							var_37_1 = var_37_1.any(var_36_4, function(arg_39_0)
								return arg_39_0.row == var_0.row and arg_39_0.column == var_0.column
							end)
						end

						if not var_37_1 then
							table = var_37_0

							var_37_0.insert(var_36_5, {
								row = var_1.row,
								column = var_1.column,
								color = var_1.type
							})
						end
					end

					return
				end)
			end

			table = var_13

			var_13.insert(var_36_4, var_36_7)
		end

		return var_36_3
	end

	return
end

function var_0_1.SearchValidDiagonalColoringCells(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	assert = var_1_10004

	var_1_10004(arg_40_1)

	local var_40_0 = {}
	local var_40_1 = arg_40_1:getState()

	ColorGroup = var_6

	if var_40_1 ~= var_6.StateColoring or arg_40_1:canBeCustomised() or arg_40_3 == 0 then
		return var_40_0
	else
		local var_40_2, var_40_3 = arg_40_1:GetAABB()
		local var_40_4 = var_40_3.x - var_40_2.x
		local var_40_5 = var_40_3.y - var_40_2.y

		;(function()
			local var_41_0 = var_40_4 + var_40_5

			for iter_41_0 = 0, var_41_0 do
				for iter_41_1 = 0, iter_41_0 do
					local var_41_1 = iter_41_0 - iter_41_1
					local var_41_2 = iter_41_1

					if var_41_1 <= var_40_4 and var_41_2 <= var_40_5 then
						local var_41_3 = var_41_2 + var_40_2.y
						local var_41_4 = var_41_1 + var_40_2.x
						local var_41_5 = arg_40_1
						local var_41_7

						if var_13.getCell(var_41_5, var_41_3, var_41_4) then
							::label_41_0::

							if var_13.type == arg_40_2 then
								local var_41_6 = arg_40_1

								var_41_7 = not var_14.getFill(var_41_6, var_41_3, var_41_4)
							else
								var_41_7 = false
							end

							if false then
								var_41_7 = true
							end
						end

						if var_41_7 then
							table = var_41_5

							var_41_5.insert(var_40_0, {
								row = var_41_3,
								column = var_41_4,
								color = arg_40_2
							})

							if #var_40_0 >= arg_40_3 then
								return
							end
						end
					end
				end
			end

			return
		end)()

		return var_40_0
	end

	return
end

function var_0_1.TryPlayStory(arg_42_0)
	local var_42_0 = {}
	local var_42_1 = arg_42_0.selectedIndex

	table = var_1_10003

	var_1_10003.SerialIpairsAsync(var_42_0, function(arg_43_0, arg_43_1, arg_43_2)
		if arg_43_0 <= var_42_1 and arg_43_1 then
			pg = var_3

			local var_43_0 = var_3.NewStoryMgr.GetInstance()

			var_3.Play(var_43_0, arg_43_1, arg_43_2)
		else
			arg_43_2()
		end

		return
	end)

	return
end

function var_0_1.onBackPressed(arg_44_0)
	pg = var_1_10001

	local var_44_0 = var_1_10001.CriMgr.GetInstance()
	local var_44_1 = var_1.PlaySoundEffect_V3

	SFX_CANCEL = var_1_10004

	var_44_1(var_44_0, var_1_10004)

	triggerButton = var_44_1

	var_44_1(arg_44_0.btnBack)

	return
end

function var_0_1.willExit(arg_45_0)
	PoolMgr = var_1_10001

	local var_45_0 = var_1_10001.GetInstance()

	var_1.ReturnUI(var_45_0, arg_45_0.coloringUIGroupName, arg_45_0.colorgroupbehind)

	return
end

return var_0_1
