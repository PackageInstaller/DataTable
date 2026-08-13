class = var_0_10000

local var_0_0 = "WorldHelpLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "WorldHelpUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.rtTitle = var_1.Find(var_2_0, "title")

	local var_2_1 = arg_2_0.rtTitle

	arg_2_0.btnBack = var_1.Find(var_2_1, "btn_back")
	onButton = var_1

	local var_2_2 = arg_2_0
	local var_2_3 = arg_2_0.btnBack

	local function var_2_4()
		local var_3_0 = arg_2_0

		var_0.closeView(var_3_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_2_2, var_2_3, var_2_4, var_1_10006)

	UIItemList = var_1

	local var_2_5 = var_1.New
	local var_2_6 = arg_2_0.rtTitle
	local var_2_7 = var_3.Find(var_2_6, "toggles")
	local var_2_8 = arg_2_0.rtTitle

	arg_2_0.groupList = var_2_5(var_2_7, var_4.Find(var_2_8, "toggles/toggle"))

	local var_2_9 = arg_2_0.groupList

	var_1.make(var_2_9, function(arg_4_0, arg_4_1, arg_4_2)
		arg_4_1 = arg_4_1 + 1
		UIItemList = var_2_10003

		if arg_4_0 == var_2_10003.EventUpdate then
			local var_4_0 = arg_2_0.titles[arg_4_1]

			setText = var_2_10004

			local var_4_1 = arg_4_2:Find("Text")

			pg = var_2_10007

			var_2_10004(var_4_1, var_2_10007.world_help_data[var_4_0].name)

			onToggle = var_2_10004

			local var_4_2 = arg_2_0
			local var_4_3 = arg_4_2

			local function var_4_4(arg_5_0)
				if arg_5_0 then
					if arg_2_0.curGroupId ~= var_4_0 then
						local var_5_0 = arg_2_0

						var_1.toggleAnim(var_5_0, arg_4_2, true)

						local var_5_1 = arg_2_0

						var_1.setCurGroup(var_5_1, var_4_0)
					end
				else
					local var_5_2 = arg_2_0

					var_1.toggleAnim(var_5_2, arg_4_2, false)
				end

				return
			end

			SFX_PANEL = var_9

			var_2_10004(var_4_2, var_4_3, var_4_4, var_9)
		end

		return
	end)

	local var_2_10 = arg_2_0._tf

	arg_2_0.rtMain = var_1.Find(var_2_10, "main")

	local var_2_11 = arg_2_0.rtMain

	arg_2_0.rtScroll = var_1.Find(var_2_11, "Scroll")
	onButton = var_1

	local var_2_12 = arg_2_0
	local var_2_13 = arg_2_0.rtMain

	var_1(var_2_12, var_4.Find(var_2_13, "left"), function()
		LeanTween = var_2_10000

		local var_6_0 = var_2_10000.isTweening

		go = var_2_10002

		if var_6_0(var_2_10002(arg_2_0.rtScroll)) then
			return
		end

		local var_6_1 = arg_2_0.curPageIndex

		if 1 < var_6_1 then
			local var_6_2 = {}

			table = var_1

			var_1.insert(var_6_2, function(arg_7_0)
				local var_7_0 = arg_2_0

				var_1.pageAnim(var_7_0, false, arg_7_0)

				return
			end)

			table = var_1

			var_1.insert(var_6_2, function(arg_8_0)
				local var_8_0 = arg_2_0

				var_1.setCurPage(var_8_0, arg_2_0.curPageIndex - 1)
				arg_8_0()

				return
			end)

			table = var_1

			var_1.insert(var_6_2, function(arg_9_0)
				local var_9_0 = arg_2_0

				var_1.pageAnim(var_9_0, true, arg_9_0)

				return
			end)

			seriesAsync = var_1

			var_1(var_6_2, function()
				return
			end)
		end

		return
	end)

	onButton = var_1

	local var_2_14 = arg_2_0
	local var_2_15 = arg_2_0.rtMain

	var_1(var_2_14, var_4.Find(var_2_15, "right"), function()
		LeanTween = var_2_10000

		local var_11_0 = var_2_10000.isTweening

		go = var_2_10002

		if var_11_0(var_2_10002(arg_2_0.rtScroll)) then
			return
		end

		if arg_2_0.curPageIndex < #arg_2_0.pageList then
			local var_11_1 = {}

			table = var_1

			var_1.insert(var_11_1, function(arg_12_0)
				local var_12_0 = arg_2_0

				var_1.pageAnim(var_12_0, false, arg_12_0)

				return
			end)

			table = var_1

			var_1.insert(var_11_1, function(arg_13_0)
				local var_13_0 = arg_2_0

				var_1.setCurPage(var_13_0, arg_2_0.curPageIndex + 1)
				arg_13_0()

				return
			end)

			table = var_1

			var_1.insert(var_11_1, function(arg_14_0)
				local var_14_0 = arg_2_0

				var_1.pageAnim(var_14_0, true, arg_14_0)

				return
			end)

			seriesAsync = var_1

			var_1(var_11_1, function()
				return
			end)
		end

		return
	end)

	return
end

function var_0_1.setCurGroup(arg_16_0, arg_16_1)
	local var_16_0 = {}

	if arg_16_0.curGroupId then
		table = var_3

		var_3.insert(var_16_0, function(arg_17_0)
			local var_17_0 = arg_16_0

			var_1.pageAnim(var_17_0, false, arg_17_0)

			return
		end)
	end

	arg_16_0.curGroupId = arg_16_1
	table = var_3

	var_3.insert(var_16_0, function(arg_18_0)
		pg = var_2_10001

		local var_18_0 = var_2_10001.world_help_data[arg_16_0.curGroupId]
		local var_18_1 = arg_16_0

		var_18_1.pageList = {}
		nowWorld = var_18_1

		local var_18_2 = var_18_1()
		local var_18_3 = var_2.GetProgress(var_18_2)

		ipairs = var_3

		for iter_18_0, iter_18_1 in var_3(var_18_0.stage_help) do
			if iter_18_1[1] <= var_18_3 then
				table = var_8

				var_8.insert(arg_16_0.pageList, {
					id = iter_18_0,
					path = iter_18_1[2]
				})
			end
		end

		if #arg_16_0.pageList > 0 then
			local var_18_4 = arg_16_0

			var_3.setCurPage(var_18_4, 1)
		end

		arg_18_0()

		return
	end)

	seriesAsync = var_3

	var_3(var_16_0, function()
		local var_19_0 = arg_16_0

		var_0.pageAnim(var_19_0, true)

		return
	end)

	return
end

function var_0_1.setCurPage(arg_20_0, arg_20_1)
	arg_20_0.curPageIndex = arg_20_1
	setText = var_1_10002

	local var_20_0 = arg_20_0.rtMain

	var_1_10002(var_4.Find(var_20_0, "page/Text"), arg_20_0.curPageIndex .. "/" .. #arg_20_0.pageList)

	local var_20_1 = arg_20_0.rtScroll
	local var_20_2 = var_2.Find(var_20_1, "Card")

	setImageAlpha = var_1_10003

	var_1_10003(var_20_2:Find("Image"), 0)

	GetSpriteFromAtlasAsync = var_1_10003

	var_1_10003(arg_20_0.pageList[arg_20_1].path, "", function(arg_21_0)
		if arg_20_0.curPageIndex == arg_20_1 then
			setImageSprite = var_1

			local var_21_0 = var_20_2

			var_1(var_3.Find(var_21_0, "Image"), arg_21_0)

			setImageAlpha = var_1

			local var_21_1 = var_20_2

			var_1(var_3.Find(var_21_1, "Image"), 1)
		end

		return
	end)

	return
end

function var_0_1.getPageIndex(arg_22_0, arg_22_1)
	ipairs = var_1_10002

	for iter_22_0, iter_22_1 in var_1_10002(arg_22_0.pageList) do
		if iter_22_1.id == arg_22_1 then
			return iter_22_0
		end
	end

	return 1
end

function var_0_1.pageAnim(arg_23_0, arg_23_1, arg_23_2)
	LeanTween = var_1_10003

	local var_23_0 = var_1_10003.cancel

	go = var_1_10005

	var_23_0(var_1_10005(arg_23_0.rtScroll))

	GetOrAddComponent = var_23_0

	local var_23_1 = var_23_0(arg_23_0.rtScroll, "CanvasGroup")

	var_23_1.alpha = arg_23_1 and 0 or 1
	LeanTween = var_4

	local var_23_2 = var_4.alphaCanvas(var_23_1, arg_23_1 and 1 or 0, 0.3)
	local var_23_3 = var_4.setOnComplete

	System = var_7

	var_23_3(var_23_2, var_7.Action(function()
		existCall = var_2_10000

		return var_2_10000(arg_23_2)
	end))

	return
end

function var_0_1.toggleAnim(arg_25_0, arg_25_1, arg_25_2)
	LeanTween = var_1_10003

	var_1_10003.cancel(arg_25_1.gameObject)

	GetComponent = var_3

	local var_25_0 = arg_25_1

	typeof = var_1_10006
	LayoutElement = var_1_10008

	local var_25_1 = var_3(var_25_0, var_1_10006(var_1_10008))

	if arg_25_2 then
		LeanTween = var_1_10004

		local var_25_2 = var_1_10004.value(arg_25_1.gameObject, var_25_1.preferredWidth, 238, 0.15)

		var_1_10004 = var_1_10004.setOnUpdate
		System = var_7

		local var_25_3 = var_1_10004(var_25_2, var_7.Action_float(function(arg_26_0)
			var_25_1.preferredWidth = arg_26_0

			return
		end))

		var_1_10004 = var_1_10004.setOnComplete
		System = var_7

		var_1_10004(var_25_3, var_7.Action(function()
			setActive = var_2_10000

			local var_27_0 = arg_25_1

			var_2_10000(var_2.Find(var_27_0, "selected"), arg_25_2)

			return
		end))
	else
		setActive = var_1_10004

		var_1_10004(arg_25_1:Find("selected"), arg_25_2)

		LeanTween = var_1_10004

		local var_25_4 = var_1_10004.value(arg_25_1.gameObject, var_25_1.preferredWidth, 176, 0.15)
		local var_25_5 = var_4.setOnUpdate

		System = var_7

		var_25_5(var_25_4, var_7.Action_float(function(arg_28_0)
			var_25_1.preferredWidth = arg_28_0

			return
		end))
	end

	return
end

function var_0_1.didEnter(arg_29_0)
	pg = var_1_10001

	local var_29_0 = var_1_10001.UIMgr.GetInstance()

	var_1.OverlayPanel(var_29_0, arg_29_0._tf)

	local var_29_1

	arg_29_0.titles = {}
	nowWorld = var_2

	local var_29_2 = var_2()
	local var_29_3 = var_2.GetProgress(var_29_2)

	ipairs = var_29_0
	pg = var_1_10005

	for iter_29_0, iter_29_1 in var_29_0(var_1_10005.world_help_data.all) do
		pg = var_1_10008

		if var_1_10008.world_help_data[iter_29_1].stage <= var_29_3 then
			table = var_1_10008

			var_1_10008.insert(arg_29_0.titles, iter_29_1)

			if arg_29_0.contextData.titleId == iter_29_1 then
				var_29_1 = #arg_29_0.titles
			end
		end
	end

	local var_29_4 = arg_29_0.groupList

	var_3.align(var_29_4, #arg_29_0.titles)

	setActive = var_3

	var_3(arg_29_0.rtScroll, #arg_29_0.titles > 0)

	if #arg_29_0.titles > 0 then
		if var_29_1 then
			triggerToggle = var_3

			local var_29_5 = arg_29_0.groupList.container

			var_3(var_5.GetChild(var_29_5, var_29_1 - 1), true)
			arg_29_0:setCurPage(arg_29_0:getPageIndex(arg_29_0.contextData.pageId))
		else
			triggerToggle = var_3

			local var_29_6 = arg_29_0.groupList.container

			var_3(var_5.GetChild(var_29_6, 0), true)
		end
	end

	return
end

function var_0_1.willExit(arg_30_0)
	LeanTween = var_1_10001

	local var_30_0 = var_1_10001.cancel

	go = var_1_10003

	var_30_0(var_1_10003(arg_30_0.rtScroll))

	pg = var_30_0

	local var_30_1 = var_30_0.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_30_1, arg_30_0._tf)

	return
end

return var_0_1
