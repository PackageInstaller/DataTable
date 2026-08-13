class = var_0_10000

local var_0_0 = "PlayerSecondSummaryInfoScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "PlayerSecondSummaryUI"
end

function var_0_1.setActivity(arg_2_0, arg_2_1)
	arg_2_0.activityVO = arg_2_1

	return
end

function var_0_1.setPlayer(arg_3_0, arg_3_1)
	arg_3_0.palyerVO = arg_3_1

	return
end

function var_0_1.setSummaryInfo(arg_4_0, arg_4_1)
	arg_4_0.summaryInfoVO = arg_4_1

	return
end

function var_0_1.init(arg_5_0)
	local var_5_0 = arg_5_0._tf

	arg_5_0.backBtn = var_1.Find(var_5_0, "bg/back_btn")

	local var_5_1 = arg_5_0._tf

	arg_5_0.pageContainer = var_1.Find(var_5_1, "bg/main/pages")

	local var_5_2 = arg_5_0._tf

	arg_5_0.pageFootContainer = var_1.Find(var_5_2, "bg/main/foots")
	GetOrAddComponent = var_1

	local var_5_3 = arg_5_0.pageFootContainer

	typeof = var_3
	CanvasGroup = var_1_10004

	var_1(var_5_3, var_3(var_1_10004))

	setCanvasGroupAlpha = var_1

	var_1(arg_5_0.pageFootContainer, 0)

	return
end

function var_0_1.didEnter(arg_6_0)
	local var_6_1

	if arg_6_0.summaryInfoVO then
		arg_6_0:initSummaryInfo()
	else
		local var_6_0 = arg_6_0

		var_6_1 = arg_6_0.emit
		PlayerSummaryInfoMediator = var_1_10003

		var_6_1(var_6_0, var_1_10003.GET_PLAYER_SUMMARY_INFO)
	end

	onButton = var_6_1

	local var_6_2 = arg_6_0
	local var_6_3 = arg_6_0.backBtn

	local function var_6_4()
		local var_7_0 = arg_6_0

		if var_0.inAnim(var_7_0) then
			return
		end

		local var_7_1 = arg_6_0

		var_0.closeView(var_7_1)

		return
	end

	SFX_CANCEL = var_1_10005

	var_6_1(var_6_2, var_6_3, var_6_4, var_1_10005)

	return
end

function var_0_1.inAnim(arg_8_0)
	local var_8_1

	if not arg_8_0.inAniming and arg_8_0.currPage then
		local var_8_0 = arg_8_0.pages[arg_8_0.currPage]

		var_8_1 = var_1.inAnim(var_8_0)
	end

	return var_8_1
end

function var_0_1.initSummaryInfo(arg_9_0)
	SecondSummaryPage1 = var_1_10001

	local var_9_0 = var_1_10001.New
	local var_9_1 = arg_9_0.pageContainer

	arg_9_0.loadingPage = var_9_0(var_2.Find(var_9_1, "page1"))

	local var_9_2 = arg_9_0.loadingPage

	var_1.Init(var_9_2, arg_9_0.summaryInfoVO)

	arg_9_0.pages = {}

	local function var_9_3(arg_10_0, arg_10_1, arg_10_2)
		setActive = var_2_10003

		var_2_10003(arg_10_0, false)

		local var_10_0 = arg_10_1.New(arg_10_0)

		table = var_4

		var_4.insert(arg_9_0.pages, var_10_0)
		var_10_0:Init(arg_10_2)

		return
	end

	local var_9_4 = arg_9_0.pageContainer
	local var_9_5 = var_3.Find(var_9_4, "page2")

	SecondSummaryPage2 = var_9_4

	var_9_3(var_9_5, var_9_4, arg_9_0.summaryInfoVO)

	local var_9_6 = var_1
	local var_9_7 = arg_9_0.pageContainer
	local var_9_8 = var_3.Find(var_9_7, "page3")

	SecondSummaryPage3 = var_9_7

	var_9_6(var_9_8, var_9_7, arg_9_0.summaryInfoVO)

	local var_9_9 = var_1
	local var_9_10 = arg_9_0.pageContainer
	local var_9_11 = var_3.Find(var_9_10, "page6")

	SecondSummaryPage6 = var_9_10

	var_9_9(var_9_11, var_9_10, arg_9_0.summaryInfoVO)

	local var_9_12 = arg_9_0.pageContainer
	local var_9_13 = var_2.Find(var_9_12, "page4")

	setActive = var_9_12

	var_9_12(var_9_13, false)

	local var_9_14 = 0

	if #arg_9_0.summaryInfoVO.medalList > 0 then
		math = var_4

		local var_9_15 = var_4.floor
		local var_9_16 = #arg_9_0.summaryInfoVO.medalList - 1

		SecondSummaryPage4 = var_1_10006
		var_9_14 = var_9_15(var_9_16 / var_1_10006.PerPageCount) + 1
	end

	for iter_9_0 = 1, var_9_14 do
		local var_9_17 = var_1

		cloneTplTo = var_1_10009
		var_1_10009 = var_1_10009(var_9_13, arg_9_0.pageContainer, "page4_1_" .. iter_9_0)
		SecondSummaryPage4 = var_10
		setmetatable = var_11

		local var_9_18 = {}

		SecondSummaryPage4 = var_13
		var_9_18.pageType = var_13.PageTypeFurniture
		var_9_18.samePage = iter_9_0
		var_9_18.activityVO = arg_9_0.activityVO

		var_9_17(var_1_10009, var_10, var_11(var_9_18, {
			__index = arg_9_0.summaryInfoVO
		}))
	end

	local var_9_19 = 0

	if #arg_9_0.summaryInfoVO.iconFrameList > 0 then
		math = var_4

		local var_9_20 = var_4.floor
		local var_9_21 = #arg_9_0.summaryInfoVO.iconFrameList - 1

		SecondSummaryPage4 = var_6
		var_9_19 = var_9_20(var_9_21 / var_6.PerPageCount) + 1
	end

	for iter_9_1 = 1, var_9_19 do
		local var_9_22 = var_1

		cloneTplTo = var_1_10009
		var_1_10009 = var_1_10009(var_9_13, arg_9_0.pageContainer, "page4_2_" .. iter_9_1)
		SecondSummaryPage4 = var_10
		setmetatable = var_11

		local var_9_23 = {}

		SecondSummaryPage4 = var_13
		var_9_23.pageType = var_13.PageTypeIconFrame
		var_9_23.samePage = iter_9_1
		var_9_23.activityVO = arg_9_0.activityVO

		var_9_22(var_1_10009, var_10, var_11(var_9_23, {
			__index = arg_9_0.summaryInfoVO
		}))
	end

	local var_9_24 = var_1
	local var_9_25 = arg_9_0.pageContainer
	local var_9_26 = var_5.Find(var_9_25, "page5")

	SecondSummaryPage5 = var_9_25

	var_9_24(var_9_26, var_9_25, arg_9_0.summaryInfoVO)

	onButton = var_9_24

	local var_9_27 = arg_9_0
	local var_9_28 = arg_9_0.pageContainer
	local var_9_29 = var_6.Find(var_9_28, "page5/share")

	local function var_9_30()
		pg = var_2_10000

		local var_11_0 = var_2_10000.ShareMgr.GetInstance()
		local var_11_1 = var_0.Share

		pg = var_2_10002

		var_11_1(var_11_0, var_2_10002.ShareMgr.TypeSecondSummary)

		return
	end

	SFX_CONFIRM = var_8

	var_9_24(var_9_27, var_9_29, var_9_30, var_8)

	seriesAsync = var_9_24

	var_9_24({
		function(arg_12_0)
			arg_9_0.inAniming = true

			local var_12_0 = arg_9_0.loadingPage

			var_1.Show(var_12_0, arg_12_0)

			return
		end,
		function(arg_13_0)
			arg_9_0.inAniming = false

			local var_13_0 = arg_9_0.loadingPage

			var_1.Hide(var_13_0)
			arg_13_0()

			return
		end
	}, function()
		local var_14_0 = arg_9_0

		var_0.registerDrag(var_14_0)

		local var_14_1 = arg_9_0

		var_0.registerFootEvent(var_14_1, 1)

		return
	end)

	return
end

function var_0_1.registerFootEvent(arg_15_0, arg_15_1)
	UIItemList = var_1_10002

	local var_15_0 = var_1_10002.New
	local var_15_1 = arg_15_0.pageFootContainer
	local var_15_2 = arg_15_0.pageFootContainer
	local var_15_3 = var_15_0(var_15_1, var_4.Find(var_15_2, "dot"))

	var_2.make(var_15_3, function(arg_16_0, arg_16_1, arg_16_2)
		local var_16_0 = arg_16_1 + 1

		UIItemList = var_2_10004

		if arg_16_0 == var_2_10004.EventUpdate then
			onToggle = var_4

			var_4(arg_15_0, arg_16_2, function(arg_17_0)
				if arg_17_0 then
					local var_17_0 = arg_15_0.pages[var_16_0]

					var_1.Show(var_17_0)

					arg_15_0.currPage = var_16_0
				else
					local var_17_1 = arg_15_0.pages[var_16_0]

					var_1.Hide(var_17_1)
				end

				return
			end)
		end

		return
	end)
	var_2:align(#arg_15_0.pages)

	setCanvasGroupAlpha = var_3

	var_3(arg_15_0.pageFootContainer, 1)

	triggerToggle = var_3

	local var_15_4 = arg_15_0.pageFootContainer

	var_3(var_4.GetChild(var_15_4, arg_15_1 - 1), true)

	return
end

function var_0_1.registerDrag(arg_18_0)
	local var_18_0 = arg_18_0
	local var_18_1 = arg_18_0.addVerticalDrag
	local var_18_2 = arg_18_0._tf

	var_18_1(var_18_0, var_3.Find(var_18_2, "bg"), function()
		local var_19_0 = arg_18_0

		var_0.updatePageFoot(var_19_0, arg_18_0.currPage - 1)

		return
	end, function()
		local var_20_0 = arg_18_0

		var_0.updatePageFoot(var_20_0, arg_18_0.currPage + 1)

		return
	end)

	return
end

function var_0_1.updatePageFoot(arg_21_0, arg_21_1)
	if arg_21_0:inAnim() or not arg_21_0.pages[arg_21_1] then
		return
	end

	triggerToggle = var_2

	local var_21_0 = arg_21_0.pageFootContainer

	var_2(var_3.GetChild(var_21_0, arg_21_1 - 1), true)

	return
end

function var_0_1.addVerticalDrag(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	GetOrAddComponent = var_1_10004

	local var_22_0 = var_1_10004(arg_22_1, "EventTriggerListener")
	local var_22_1
	local var_22_2 = 0
	local var_22_3 = 50

	var_22_0:AddBeginDragFunc(function(arg_23_0, arg_23_1)
		var_22_2 = 0
		var_22_1 = arg_23_1.position

		return
	end)
	var_22_0:AddDragFunc(function(arg_24_0, arg_24_1)
		var_22_2 = arg_24_1.position.x - var_22_1.x

		return
	end)
	var_22_0:AddDragEndFunc(function(arg_25_0, arg_25_1)
		if var_22_2 < -var_22_3 then
			if arg_22_3 then
				arg_22_3()
			end
		elseif var_22_2 > var_22_3 and arg_22_2 then
			arg_22_2()
		end

		return
	end)

	return
end

function var_0_1.willExit(arg_26_0)
	pairs = var_1_10001

	for iter_26_0, iter_26_1 in var_1_10001(arg_26_0.pages) do
		iter_26_1:Dispose()
	end

	arg_26_0.pages = nil
	arg_26_0.currPage = nil

	return
end

return var_0_1
