class = var_0_10000

local var_0_0 = "PlayerSummaryInfoScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "PlayerSummaryUI"
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

	arg_5_0.pageFootContainer = var_1.Find(var_5_2, "bg/main/page_foot")

	return
end

function var_0_1.didEnter(arg_6_0)
	local var_6_1

	if arg_6_0.summaryInfoVO then
		arg_6_0:initSummaryInfo()
	else
		local var_6_0 = arg_6_0

		var_6_1 = arg_6_0.emit
		PlayerSummaryInfoMediator = var_1_10004

		var_6_1(var_6_0, var_1_10004.GET_PLAYER_SUMMARY_INFO)
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

		var_0.emit(var_7_1, var_0_1.ON_BACK)

		return
	end

	SFX_CANCEL = var_1_10006

	var_6_1(var_6_2, var_6_3, var_6_4, var_1_10006)

	return
end

function var_0_1.inAnim(arg_8_0)
	_ = var_1_10001

	local var_8_0 = var_1_10001.any
	local var_8_1

	if not arg_8_0.pages then
		var_8_1 = {}
	end

	if var_8_0(var_8_1, function(arg_9_0)
		return arg_9_0:inAnim()
	end) then
		return true
	end

	return false
end

function var_0_1.initSummaryInfo(arg_10_0)
	SummaryPageLoading = var_1_10001

	local var_10_0 = var_1_10001.New
	local var_10_1 = arg_10_0.pageContainer

	arg_10_0.loadingPage = var_10_0(var_3.Find(var_10_1, "loading"))

	local var_10_2 = {}

	SummaryPage1 = var_1_10002

	local var_10_3 = var_1_10002.New
	local var_10_4 = arg_10_0.pageContainer

	var_10_2[1] = var_10_3(var_4.Find(var_10_4, "page1"))
	SummaryPage2 = var_2

	local var_10_5 = var_2.New
	local var_10_6 = arg_10_0.pageContainer

	var_10_2[2] = var_10_5(var_4.Find(var_10_6, "page2"))
	SummaryPage3 = var_2

	local var_10_7 = var_2.New
	local var_10_8 = arg_10_0.pageContainer

	var_10_2[3] = var_10_7(var_4.Find(var_10_8, "page3"))
	SummaryPage4 = var_2

	local var_10_9 = var_2.New
	local var_10_10 = arg_10_0.pageContainer

	var_10_2[4] = var_10_9(var_4.Find(var_10_10, "page4"))
	SummaryPage4 = var_2

	local var_10_11 = var_2.New
	local var_10_12 = arg_10_0.pageContainer

	var_10_2[5] = var_10_11(var_4.Find(var_10_12, "page4_1"))
	SummaryPage4 = var_2

	local var_10_13 = var_2.New
	local var_10_14 = arg_10_0.pageContainer

	var_10_2[6] = var_10_13(var_4.Find(var_10_14, "page4_2"))
	SummaryPage5 = var_2

	local var_10_15 = var_2.New
	local var_10_16 = arg_10_0.pageContainer

	var_10_2[7] = var_10_15(var_4.Find(var_10_16, "page5"))
	arg_10_0.pages = var_10_2

	local var_10_17 = arg_10_0.summaryInfoVO.isProPose and 3 or 2

	table = var_2

	local var_10_18 = var_2.remove(arg_10_0.pages, var_10_17)

	var_2.Hide(var_10_18)

	local var_10_19 = {
		function(arg_11_0)
			local var_11_0 = arg_10_0.loadingPage

			var_1.Init(var_11_0, arg_10_0.summaryInfoVO)
			arg_11_0()

			return
		end,
		function(arg_12_0)
			local var_12_0 = arg_10_0.loadingPage

			var_1.Show(var_12_0, arg_12_0)

			return
		end,
		function(arg_13_0)
			local var_13_0 = arg_10_0.loadingPage

			var_1.Hide(var_13_0, arg_13_0)

			return
		end,
		function(arg_14_0)
			ipairs = var_2_10001

			for iter_14_0, iter_14_1 in var_2_10001(arg_10_0.pages) do
				iter_14_1:Init(arg_10_0.summaryInfoVO)
			end

			arg_14_0()

			return
		end,
		function(arg_15_0)
			local var_15_0 = arg_10_0

			var_1.registerFootEvent(var_15_0)
			arg_15_0()

			return
		end,
		function(arg_16_0)
			local var_16_0 = arg_10_0

			var_1.updatePageFoot(var_16_0, 1)
			arg_16_0()

			return
		end,
		function(arg_17_0)
			local var_17_0 = arg_10_0

			var_1.registerDrag(var_17_0)
			arg_17_0()

			return
		end
	}

	setActive = var_4

	var_4(arg_10_0.pageFootContainer, false)

	seriesAsync = var_4

	var_4(var_10_19, function()
		setActive = var_2_10000

		var_2_10000(arg_10_0.pageFootContainer, true)

		return
	end)

	return
end

function var_0_1.registerFootEvent(arg_19_0)
	arg_19_0.footTFs = {}

	for iter_19_0 = 1, #arg_19_0.pages do
		local var_19_0 = arg_19_0.pageFootContainer
		local var_19_1 = var_5.Find(var_19_0, "dot_" .. iter_19_0)

		table = var_1_10006

		var_1_10006.insert(arg_19_0.footTFs, var_19_1)

		function var_1_10006(arg_20_0)
			if arg_20_0 then
				local var_20_0 = arg_19_0.pages[iter_19_0]

				var_1.Show(var_20_0)

				arg_19_0.currPage = iter_19_0
			else
				local var_20_1 = arg_19_0.pages[arg_19_0.currPage]

				var_1.Hide(var_20_1)
			end

			return
		end

		onToggle = var_19_0

		var_19_0(arg_19_0, var_19_1, var_1_10006)
	end

	return
end

function var_0_1.registerDrag(arg_21_0)
	local var_21_0 = arg_21_0
	local var_21_1 = arg_21_0.addVerticalDrag
	local var_21_2 = arg_21_0._tf

	var_21_1(var_21_0, var_4.Find(var_21_2, "bg"), function()
		local var_22_0 = arg_21_0

		var_0.updatePageFoot(var_22_0, arg_21_0.currPage + 1)

		return
	end, function()
		local var_23_0 = arg_21_0

		var_0.updatePageFoot(var_23_0, arg_21_0.currPage - 1)

		return
	end)

	return
end

function var_0_1.updatePageFoot(arg_24_0, arg_24_1)
	if arg_24_0:inAnim() then
		return
	end

	if not arg_24_0.footTFs[arg_24_1] then
		return
	end

	triggerToggle = var_2

	var_2(arg_24_0.footTFs[arg_24_1], true)

	return
end

function var_0_1.addVerticalDrag(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	GetOrAddComponent = var_1_10004

	local var_25_0 = var_1_10004(arg_25_1, "EventTriggerListener")
	local var_25_1
	local var_25_2 = 0
	local var_25_3 = 50

	var_25_0:AddBeginDragFunc(function()
		var_25_2 = 0
		var_25_1 = nil

		return
	end)
	var_25_0:AddDragFunc(function(arg_27_0, arg_27_1)
		local var_27_0 = arg_27_1.position

		if not var_25_1 then
			var_25_1 = var_27_0
		end

		var_25_2 = var_27_0.y - var_25_1.y

		return
	end)
	var_25_0:AddDragEndFunc(function(arg_28_0, arg_28_1)
		if var_25_2 < -var_25_3 then
			if arg_25_3 then
				arg_25_3()
			end
		elseif var_25_2 > var_25_3 and arg_25_2 then
			arg_25_2()
		end

		return
	end)

	return
end

function var_0_1.willExit(arg_29_0)
	pairs = var_1_10001

	for iter_29_0, iter_29_1 in var_1_10001(arg_29_0.pages) do
		iter_29_1:Dispose()
	end

	arg_29_0.pages = nil

	local var_29_0 = arg_29_0.loadingPage

	var_1.Dispose(var_29_0)

	arg_29_0.loadingPage = nil

	return
end

return var_0_1
