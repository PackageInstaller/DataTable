class = var_0_10000

local var_0_0 = "EducateSelEndingLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".base.EducateBaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "EducateSelEndingUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.rootTF = var_1.Find(var_2_0, "root")

	local var_2_1 = arg_2_0.rootTF

	arg_2_0.blurPanel = var_1.Find(var_2_1, "bg")

	local var_2_2 = arg_2_0.blurPanel

	arg_2_0.scrollrect = var_1.Find(var_2_2, "window/view")

	local var_2_3 = arg_2_0.blurPanel
	local var_2_4 = var_1.Find(var_2_3, "window/view/content")

	UIItemList = var_2_3
	arg_2_0.uiList = var_2_3.New(var_2_4, var_2_4:Find("tpl"))

	local var_2_5 = arg_2_0.uiList

	var_2.make(var_2_5, function(arg_3_0, arg_3_1, arg_3_2)
		UIItemList = var_2_10003

		if arg_3_0 == var_2_10003.EventInit then
			local var_3_0 = arg_2_0

			var_3.InitItem(var_3_0, arg_3_1, arg_3_2)
		else
			UIItemList = var_3

			if arg_3_0 == var_3.EventUpdate then
				setActive = var_3

				var_3(arg_3_2:Find("selected"), arg_2_0.selectedIdx == arg_3_1 + 1)
			end
		end

		return
	end)

	local var_2_6 = arg_2_0.blurPanel

	arg_2_0.sureBtn = var_2.Find(var_2_6, "window/sure_btn")
	setText = var_2

	local var_2_7 = arg_2_0.sureBtn
	local var_2_8 = var_3.Find(var_2_7, "Image")

	i18n = var_2_7

	var_2(var_2_8, var_2_7("word_ok"))

	return
end

function var_0_1.didEnter(arg_4_0)
	arg_4_0:OverlayPanel(arg_4_0.blurPanel, {
		groupDelta = 1,
		pbList = {
			arg_4_0.blurPanel
		}
	})

	onButton = var_1

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.sureBtn

	local function var_4_2()
		local var_5_0 = arg_4_0
		local var_5_1 = var_0.emit

		EducateSelEndingMediator = var_2_10002

		var_5_1(var_5_0, var_2_10002.ON_SELECT_ENDING, arg_4_0.endingList[arg_4_0.selectedIdx], arg_4_0.endingList)

		return
	end

	SFX_PANEL = var_5

	var_1(var_4_0, var_4_1, var_4_2, var_5)

	arg_4_0.selectedIdx = 1

	arg_4_0:RefreshView()

	return
end

function var_0_1.InitItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_1 + 1
	local var_6_1 = arg_6_0.endingList[var_6_0]

	pg = var_1_10005

	local var_6_2 = var_1_10005.child_ending[var_6_1]

	setScrollText = var_1_10006

	var_1_10006(arg_6_2:Find("name_mask/name"), var_6_2.name)

	LoadImageSpriteAsync = var_1_10006

	var_1_10006("educatepicture/" .. var_6_2.pic_preview, arg_6_2:Find("Image"))

	setActive = var_1_10006

	local var_6_3 = arg_6_2
	local var_6_4 = arg_6_2.Find(var_6_3, "complete")

	table = var_6_3

	var_1_10006(var_6_4, var_6_3.contains(arg_6_0.completeList, var_6_1))

	onButton = var_1_10006

	local var_6_5 = arg_6_0
	local var_6_6 = arg_6_2

	local function var_6_7()
		arg_6_0.selectedIdx = var_6_0

		local var_7_0 = arg_6_0.uiList

		var_0.align(var_7_0, #arg_6_0.endingList)

		return
	end

	SFX_PANEL = var_10

	var_1_10006(var_6_5, var_6_6, var_6_7, var_10)

	return
end

function var_0_1.RefreshView(arg_8_0)
	getProxy = var_1_10001
	EducateProxy = var_1_10002

	local var_8_0 = var_1_10001(var_1_10002)

	arg_8_0.endingList = var_1.GetEndingResult(var_8_0)
	getProxy = var_1
	EducateProxy = var_8_0

	local var_8_1 = var_1(var_8_0)

	arg_8_0.completeList = var_1.GetCompleteEndings(var_8_1)
	table = var_1

	local var_8_2 = var_1.sort
	local var_8_3 = arg_8_0.endingList

	CompareFuncs = var_1_10003

	var_8_2(var_8_3, var_1_10003({
		function(arg_9_0)
			table = var_2_10001

			return var_2_10001.contains(arg_8_0.completeList, arg_9_0) and 1 or 0
		end,
		function(arg_10_0)
			return -arg_10_0
		end
	}))

	local var_8_4 = arg_8_0.uiList

	var_1.align(var_8_4, #arg_8_0.endingList)

	scrollTo = var_1

	var_1(arg_8_0.scrollrect, arg_8_0.uiList.container.rect.width / 2, 0)

	return
end

function var_0_1.onBackPressed(arg_11_0)
	return
end

function var_0_1.willExit(arg_12_0)
	existCall = var_1_10001

	var_1_10001(arg_12_0.contextData.onExit)
	arg_12_0:UnOverlayPanel(arg_12_0.blurPanel, arg_12_0._tf)

	return
end

return var_0_1
