local var_0_0 = class("MetaPTAwardPreviewLayer", import("...base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "MetaPTAwardPreviewUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0:initUITextTips()
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()
	arg_2_0:initScrollList()

	return
end

function var_0_0.didEnter(arg_3_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_3_0._tf)
	arg_3_0:updatePTInfo()
	arg_3_0:updateScrollList()

	return
end

function var_0_0.willExit(arg_4_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_4_0._tf)

	return
end

function var_0_0.initUITextTips(arg_5_0)
	setText(arg_5_0._tf:Find("Panel/AwardTpl/PointLight/PointTipText"), i18n("meta_pt_point"))
	setText(arg_5_0._tf:Find("Panel/AwardTpl/PointGray/PointTipText"), i18n("meta_pt_point"))
	setText(arg_5_0._tf:Find("Panel/AwardTpl/GetText"), i18n("meta_award_get"))
	setText(arg_5_0._tf:Find("Panel/AwardTpl/GotText"), i18n("meta_award_got"))

	return
end

function var_0_0.initData(arg_6_0)
	arg_6_0.curMetaProgressVO = arg_6_0.contextData.metaProgressVO
	arg_6_0.ptData = arg_6_0.curMetaProgressVO.metaPtData
	arg_6_0.itemNum = #arg_6_0.ptData.dropList

	return
end

function var_0_0.findUI(arg_7_0)
	arg_7_0.bg = arg_7_0._tf:Find("BG")

	local var_7_0 = arg_7_0._tf:Find("Panel")
	local var_7_1 = var_7_0:Find("PT")

	arg_7_0.ptNumText = var_7_1:Find("NumText")
	arg_7_0.ptIcon = var_7_1:Find("PTIcon")
	arg_7_0.scrollViewTF = var_7_0:Find("ScrollView")
	arg_7_0.awardContainerTF = var_7_0:Find("ScrollView/Viewport/Content")
	arg_7_0.awardTpl = var_7_0:Find("AwardTpl")

	local var_7_2 = arg_7_0._tf:Find("NotchAdapt")

	arg_7_0.nextArrow = var_7_2:Find("NextBtn")
	arg_7_0.preArrow = var_7_2:Find("PreBtn")
	arg_7_0.sizeW = GetComponent(arg_7_0.awardTpl, "LayoutElement").preferredWidth
	arg_7_0.spaceW = GetComponent(arg_7_0.awardContainerTF, "HorizontalLayoutGroup").spacing
	arg_7_0.leftW = GetComponent(arg_7_0.awardContainerTF, "HorizontalLayoutGroup").padding.left

	return
end

function var_0_0.addListener(arg_8_0)
	onButton(arg_8_0, arg_8_0.bg, function()
		arg_8_0:closeView()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.initScrollList(arg_10_0)
	arg_10_0.awardUIItemList = UIItemList.New(arg_10_0.awardContainerTF, arg_10_0.awardTpl)

	arg_10_0.awardUIItemList:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventUpdate then
			arg_10_0:updateAwardTpl(arg_11_2, arg_11_1 + 1)
		end

		return
	end)

	arg_10_0.scrollRectSC = arg_10_0.scrollViewTF:GetComponent("ScrollRect")

	arg_10_0.scrollRectSC.onValueChanged:AddListener(function(arg_12_0)
		setActive(arg_10_0.preArrow, arg_12_0.x >= 0.01)
		setActive(arg_10_0.nextArrow, arg_12_0.x <= 0.99)

		return
	end)

	return
end

function var_0_0.updateScrollList(arg_13_0)
	local var_13_0, var_13_1, var_13_2 = arg_13_0.curMetaProgressVO.metaPtData:GetLevelProgress()

	arg_13_0.awardUIItemList:align(var_13_1)
	setLocalPosition(arg_13_0.awardContainerTF, {
		x = -((var_13_0 - 1) * (arg_13_0.sizeW + arg_13_0.spaceW))
	})

	if var_13_0 > 1 then
		setActive(arg_13_0.preArrow, true)
	end

	return
end

function var_0_0.updateAwardTpl(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_1:Find("Item")
	local var_14_1 = var_14_0:Find("mask")
	local var_14_2 = var_14_1:Find("Got")
	local var_14_3 = var_14_1:Find("Lock")
	local var_14_4 = arg_14_1:Find("PointLight")
	local var_14_5 = arg_14_1:Find("PointGray")
	local var_14_6 = arg_14_1:Find("GetText")
	local var_14_7 = arg_14_1:Find("GotText")
	local var_14_8 = arg_14_1:Find("LockText")
	local var_14_9 = arg_14_1:Find("LineTpl")
	local var_14_10 = arg_14_1:Find("LineTpl/Light")
	local var_14_11 = arg_14_1:Find("LineTpl/Dark")

	updateDrop(var_14_0, {
		type = arg_14_0.ptData.dropList[arg_14_2][1],
		id = arg_14_0.ptData.dropList[arg_14_2][2],
		count = arg_14_0.ptData.dropList[arg_14_2][3]
	}, {
		hideName = true
	})
	onButton(arg_14_0, var_14_0, function()
		arg_14_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)
	setText(var_14_4:Find("NumText"), arg_14_0.ptData.targets[arg_14_2])
	setText(var_14_5:Find("NumText"), arg_14_0.ptData.targets[arg_14_2])
	setText(var_14_8, "PHASE " .. calcFloor(arg_14_0.ptData.targets[arg_14_2] / arg_14_0.curMetaProgressVO.unlockPTNum * 100) .. "%")

	if arg_14_2 < arg_14_0.ptData.level + 1 then
		setActive(var_14_1, true)
		setActive(var_14_2, true)
		setActive(var_14_3, false)
		setActive(var_14_4, false)
		setActive(var_14_5, true)
		setActive(var_14_10, false)
		setActive(var_14_11, true)
		setActive(var_14_6, false)
		setActive(var_14_7, true)
		setActive(var_14_8, false)
	elseif arg_14_0.ptData.targets[arg_14_2] > arg_14_0.ptData.count then
		setActive(var_14_1, true)
		setActive(var_14_2, false)
		setActive(var_14_3, true)
		setActive(var_14_4, false)
		setActive(var_14_5, true)
		setActive(var_14_10, false)
		setActive(var_14_11, true)
		setActive(var_14_6, false)
		setActive(var_14_7, false)
		setActive(var_14_8, true)
	else
		setActive(var_14_1, false)
		setActive(var_14_2, false)
		setActive(var_14_3, false)
		setActive(var_14_4, true)
		setActive(var_14_5, false)
		setActive(var_14_10, true)
		setActive(var_14_11, false)
		setActive(var_14_6, true)
		setActive(var_14_7, false)
		setActive(var_14_8, false)
	end

	if arg_14_2 == 1 then
		setActive(var_14_9, false)
	end

	return
end

function var_0_0.updatePTInfo(arg_16_0)
	setImageSprite(arg_16_0.ptIcon, LoadSprite(arg_16_0.curMetaProgressVO:getPtIconPath()))
	setText(arg_16_0.ptNumText, arg_16_0.ptData.count)

	return
end

return var_0_0
