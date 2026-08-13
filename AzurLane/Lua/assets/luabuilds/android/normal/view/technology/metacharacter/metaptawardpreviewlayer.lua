class = var_0_10000

local var_0_0 = "MetaPTAwardPreviewLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "MetaPTAwardPreviewUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:initUITextTips()
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()
	arg_2_0:initScrollList()

	return
end

function var_0_1.didEnter(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_0, arg_3_0._tf)
	arg_3_0:updatePTInfo()
	arg_3_0:updateScrollList()

	return
end

function var_0_1.willExit(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_4_0, arg_4_0._tf)

	return
end

function var_0_1.initUITextTips(arg_5_0)
	local var_5_0 = arg_5_0._tf
	local var_5_1 = var_1.Find(var_5_0, "Panel/AwardTpl/PointLight/PointTipText")
	local var_5_2 = arg_5_0._tf
	local var_5_3 = var_2.Find(var_5_2, "Panel/AwardTpl/PointGray/PointTipText")
	local var_5_4 = arg_5_0._tf
	local var_5_5 = var_3.Find(var_5_4, "Panel/AwardTpl/GetText")
	local var_5_6 = arg_5_0._tf
	local var_5_7 = var_4.Find(var_5_6, "Panel/AwardTpl/GotText")

	setText = var_5_6

	local var_5_8 = var_5_1

	i18n = var_1_10007

	var_5_6(var_5_8, var_1_10007("meta_pt_point"))

	setText = var_5_6

	local var_5_9 = var_5_3

	i18n = var_7

	var_5_6(var_5_9, var_7("meta_pt_point"))

	setText = var_5_6

	local var_5_10 = var_5_5

	i18n = var_7

	var_5_6(var_5_10, var_7("meta_award_get"))

	setText = var_5_6

	local var_5_11 = var_5_7

	i18n = var_7

	var_5_6(var_5_11, var_7("meta_award_got"))

	return
end

function var_0_1.initData(arg_6_0)
	arg_6_0.curMetaProgressVO = arg_6_0.contextData.metaProgressVO
	arg_6_0.ptData = arg_6_0.curMetaProgressVO.metaPtData
	arg_6_0.itemNum = #arg_6_0.ptData.dropList

	return
end

function var_0_1.findUI(arg_7_0)
	local var_7_0 = arg_7_0._tf

	arg_7_0.bg = var_1.Find(var_7_0, "BG")

	local var_7_1 = arg_7_0._tf
	local var_7_2 = var_1.Find(var_7_1, "Panel")
	local var_7_3 = var_1.Find(var_7_2, "PT")

	arg_7_0.ptNumText = var_2.Find(var_7_3, "NumText")
	arg_7_0.ptIcon = var_2:Find("PTIcon")
	arg_7_0.scrollViewTF = var_1:Find("ScrollView")
	arg_7_0.awardContainerTF = var_1:Find("ScrollView/Viewport/Content")
	arg_7_0.awardTpl = var_1:Find("AwardTpl")

	local var_7_4 = arg_7_0._tf
	local var_7_5 = var_3.Find(var_7_4, "NotchAdapt")

	arg_7_0.nextArrow = var_3.Find(var_7_5, "NextBtn")
	arg_7_0.preArrow = var_3:Find("PreBtn")
	GetComponent = var_4
	arg_7_0.sizeW = var_4(arg_7_0.awardTpl, "LayoutElement").preferredWidth
	GetComponent = var_4
	arg_7_0.spaceW = var_4(arg_7_0.awardContainerTF, "HorizontalLayoutGroup").spacing
	GetComponent = var_4
	arg_7_0.leftW = var_4(arg_7_0.awardContainerTF, "HorizontalLayoutGroup").padding.left

	return
end

function var_0_1.addListener(arg_8_0)
	onButton = var_1_10001

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.bg

	local function var_8_2()
		local var_9_0 = arg_8_0

		var_0.closeView(var_9_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_0, var_8_1, var_8_2, var_1_10005)

	return
end

function var_0_1.initScrollList(arg_10_0)
	UIItemList = var_1_10001
	arg_10_0.awardUIItemList = var_1_10001.New(arg_10_0.awardContainerTF, arg_10_0.awardTpl)

	local var_10_0 = arg_10_0.awardUIItemList

	var_1.make(var_10_0, function(arg_11_0, arg_11_1, arg_11_2)
		UIItemList = var_2_10003

		if arg_11_0 == var_2_10003.EventUpdate then
			local var_11_0 = arg_10_0

			var_3.updateAwardTpl(var_11_0, arg_11_2, arg_11_1 + 1)
		end

		return
	end)

	local var_10_1 = arg_10_0.scrollViewTF

	arg_10_0.scrollRectSC = var_1.GetComponent(var_10_1, "ScrollRect")

	local var_10_2 = arg_10_0.scrollRectSC.onValueChanged

	var_1.AddListener(var_10_2, function(arg_12_0)
		setActive = var_2_10001

		var_2_10001(arg_10_0.preArrow, arg_12_0.x >= 0.01)

		setActive = var_2_10001

		var_2_10001(arg_10_0.nextArrow, arg_12_0.x <= 0.99)

		return
	end)

	return
end

function var_0_1.updateScrollList(arg_13_0)
	local var_13_0 = arg_13_0.curMetaProgressVO.metaPtData
	local var_13_1, var_13_2, var_13_3 = var_1.GetLevelProgress(var_13_0)
	local var_13_4 = arg_13_0.awardUIItemList

	var_4.align(var_13_4, var_13_2)

	local var_13_5 = (var_13_1 - 1) * (arg_13_0.sizeW + arg_13_0.spaceW)

	setLocalPosition = var_5

	var_5(arg_13_0.awardContainerTF, {
		x = -var_13_5
	})

	if 1 < var_13_1 then
		setActive = var_5

		var_5(arg_13_0.preArrow, true)
	end

	return
end

function var_0_1.updateAwardTpl(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_1:Find("Item")
	local var_14_1 = var_3.Find(var_14_0, "mask")
	local var_14_2 = var_4.Find(var_14_1, "Got")
	local var_14_3 = var_4:Find("Lock")
	local var_14_4 = arg_14_1:Find("PointLight")
	local var_14_5 = var_7.Find(var_14_4, "NumText")
	local var_14_6 = arg_14_1:Find("PointGray")
	local var_14_7 = var_9.Find(var_14_6, "NumText")
	local var_14_8 = arg_14_1:Find("GetText")
	local var_14_9 = arg_14_1:Find("GotText")
	local var_14_10 = arg_14_1:Find("LockText")
	local var_14_11 = arg_14_1:Find("LineTpl")
	local var_14_12 = arg_14_1:Find("LineTpl/Light")
	local var_14_13 = arg_14_1:Find("LineTpl/Dark")
	local var_14_14 = arg_14_0.ptData.dropList[arg_14_2]
	local var_14_15 = arg_14_0.ptData.targets[arg_14_2]
	local var_14_16 = {
		type = var_14_14[1],
		id = var_14_14[2],
		count = var_14_14[3]
	}

	updateDrop = var_20

	var_20(var_3, var_14_16, {
		hideName = true
	})

	onButton = var_20

	local var_14_17 = arg_14_0
	local var_14_18 = var_3

	local function var_14_19()
		local var_15_0 = arg_14_0
		local var_15_1 = var_0.emit

		BaseUI = var_2_10002

		var_15_1(var_15_0, var_2_10002.ON_DROP, var_14_16)

		return
	end

	SFX_PANEL = var_1_10024

	var_20(var_14_17, var_14_18, var_14_19, var_1_10024)

	setText = var_20

	var_20(var_14_5, var_14_15)

	setText = var_20

	var_20(var_14_7, var_14_15)

	setText = var_20

	local var_14_20 = var_14_10
	local var_14_21 = "PHASE "

	calcFloor = var_14_19

	var_20(var_14_20, var_14_21 .. var_14_19(var_14_15 / arg_14_0.curMetaProgressVO.unlockPTNum * 100) .. "%")

	if arg_14_2 < arg_14_0.ptData.level + 1 then
		setActive = var_14_20

		var_14_20(var_4, true)

		setActive = var_14_20

		var_14_20(var_14_2, true)

		setActive = var_14_20

		var_14_20(var_14_3, false)

		setActive = var_14_20

		var_14_20(var_7, false)

		setActive = var_14_20

		var_14_20(var_9, true)

		setActive = var_14_20

		var_14_20(var_14_12, false)

		setActive = var_14_20

		var_14_20(var_14_13, true)

		setActive = var_14_20

		var_14_20(var_14_8, false)

		setActive = var_14_20

		var_14_20(var_14_9, true)

		setActive = var_14_20

		var_14_20(var_14_10, false)
	elseif arg_14_0.ptData.count < var_14_15 then
		setActive = var_14_20

		var_14_20(var_4, true)

		setActive = var_14_20

		var_14_20(var_14_2, false)

		setActive = var_14_20

		var_14_20(var_14_3, true)

		setActive = var_14_20

		var_14_20(var_7, false)

		setActive = var_14_20

		var_14_20(var_9, true)

		setActive = var_14_20

		var_14_20(var_14_12, false)

		setActive = var_14_20

		var_14_20(var_14_13, true)

		setActive = var_14_20

		var_14_20(var_14_8, false)

		setActive = var_14_20

		var_14_20(var_14_9, false)

		setActive = var_14_20

		var_14_20(var_14_10, true)
	else
		setActive = var_14_20

		var_14_20(var_4, false)

		setActive = var_14_20

		var_14_20(var_14_2, false)

		setActive = var_14_20

		var_14_20(var_14_3, false)

		setActive = var_14_20

		var_14_20(var_7, true)

		setActive = var_14_20

		var_14_20(var_9, false)

		setActive = var_14_20

		var_14_20(var_14_12, true)

		setActive = var_14_20

		var_14_20(var_14_13, false)

		setActive = var_14_20

		var_14_20(var_14_8, true)

		setActive = var_14_20

		var_14_20(var_14_9, false)

		setActive = var_14_20

		var_14_20(var_14_10, false)
	end

	if arg_14_2 == 1 then
		setActive = var_14_20

		var_14_20(var_14_11, false)
	end

	return
end

function var_0_1.updatePTInfo(arg_16_0)
	setImageSprite = var_1_10001

	local var_16_0 = arg_16_0.ptIcon

	LoadSprite = var_1_10003

	local var_16_1 = arg_16_0.curMetaProgressVO

	var_1_10001(var_16_0, var_1_10003(var_4.getPtIconPath(var_16_1)))

	setText = var_1_10001

	var_1_10001(arg_16_0.ptNumText, arg_16_0.ptData.count)

	return
end

return var_0_1
