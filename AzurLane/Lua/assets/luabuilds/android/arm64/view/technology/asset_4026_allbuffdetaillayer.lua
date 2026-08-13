class = var_0_10000

local var_0_0 = "AllBuffDetailLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "TechnologyTreeAllBuffUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0:BlurPanel(arg_3_0._tf)
	arg_3_0:addListener()
	arg_3_0:updateDetail()

	return
end

function var_0_1.willExit(arg_4_0)
	arg_4_0:UnOverlayPanel(arg_4_0._tf)

	return
end

function var_0_1.initData(arg_5_0)
	getProxy = var_1_10001
	TechnologyNationProxy = var_1_10003
	arg_5_0.technologyNationProxy = var_1_10001(var_1_10003)

	local var_5_0 = arg_5_0.technologyNationProxy

	arg_5_0.tecList = var_1.GetTecList(var_5_0)

	local var_5_1 = arg_5_0.technologyNationProxy
	local var_5_2, var_5_3, var_5_4 = var_1.getTecBuff(var_5_1)

	arg_5_0.typeAttrOrderTable = var_5_4
	arg_5_0.typeOrder = var_5_3
	arg_5_0.typeAttrTable = var_5_2
	ShipType = var_5_2
	arg_5_0.typeOrder = var_5_2.FilterOverQuZhuType(arg_5_0.typeOrder)

	return
end

function var_0_1.findUI(arg_6_0)
	local var_6_0 = arg_6_0._tf

	arg_6_0.backBtn = var_1.Find(var_6_0, "BG")

	local var_6_1 = arg_6_0._tf

	arg_6_0.scrollView = var_1.Find(var_6_1, "Scroll View")

	local var_6_2 = arg_6_0.scrollView

	arg_6_0.viewport = var_1.Find(var_6_2, "Viewport")

	local var_6_3 = arg_6_0.viewport

	arg_6_0.typeContainer = var_1.Find(var_6_3, "Content")

	local var_6_4 = arg_6_0._tf

	arg_6_0.typeItemTpl = var_1.Find(var_6_4, "TypeItemTpl")

	local var_6_5 = arg_6_0._tf

	arg_6_0.buffItemTpl = var_1.Find(var_6_5, "BuffItemTpl")
	GetComponent = var_1
	arg_6_0.scrollViewGroupCom = var_1(arg_6_0.scrollView, "VerticalLayoutGroup")
	GetComponent = var_1
	arg_6_0.scrollViewFitterCom = var_1(arg_6_0.scrollView, "ContentSizeFitter")
	GetComponent = var_1
	arg_6_0.viewportGroupCom = var_1(arg_6_0.viewport, "VerticalLayoutGroup")
	GetComponent = var_1
	arg_6_0.viewportFitterCom = var_1(arg_6_0.viewport, "ContentSizeFitter")

	local var_6_6 = arg_6_0._tf

	arg_6_0.setValueBtn = var_1.Find(var_6_6, "Scroll View/bg/SetValueBtn")

	return
end

function var_0_1.onBackPressed(arg_7_0)
	triggerButton = var_1_10001

	var_1_10001(arg_7_0.backBtn)

	return
end

function var_0_1.addListener(arg_8_0)
	onButton = var_1_10001

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.backBtn

	local function var_8_2()
		local var_9_0 = arg_8_0

		var_0.emit(var_9_0, var_0_1.ON_CLOSE)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_8_0, var_8_1, var_8_2, var_1_10006)

	onButton = var_1_10001

	local var_8_3 = arg_8_0
	local var_8_4 = arg_8_0.setValueBtn

	local function var_8_5()
		getProxy = var_2_10000
		ChapterProxy = var_2_10002

		local var_10_0 = var_2_10000(var_2_10002)

		if var_0.getActiveChapter(var_10_0, true) then
			pg = var_2_10001

			local var_10_1 = var_2_10001.TipsMgr.GetInstance()
			local var_10_2 = var_1.ShowTips

			i18n = var_2_10004

			var_10_2(var_10_1, var_2_10004("attrset_disable"))
		else
			local var_10_3 = arg_8_0
			local var_10_4 = var_1.emit

			AllBuffDetailMediator = var_2_10004

			var_10_4(var_10_3, var_2_10004.OPEN_SET_VALUE_LAYER)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_8_3, var_8_4, var_8_5, var_1_10006)

	return
end

function var_0_1.updateDetail(arg_11_0)
	UIItemList = var_1_10001

	local var_11_0 = var_1_10001.New(arg_11_0.typeContainer, arg_11_0.typeItemTpl)

	var_1.make(var_11_0, function(arg_12_0, arg_12_1, arg_12_2)
		UIItemList = var_2_10003

		if arg_12_0 == var_2_10003.EventUpdate then
			local var_12_0 = arg_12_2:Find("TypeTitle/TypeImg")
			local var_12_1 = arg_12_2:Find("TypeTitle/TypeTextImg")
			local var_12_2 = arg_12_2:Find("Container")
			local var_12_3 = arg_11_0.typeOrder[arg_12_1 + 1]

			setImageSprite = var_7

			local var_12_4 = var_12_1

			GetSpriteFromAtlas = var_2_10010

			var_7(var_12_4, var_2_10010("ShipType", "ch_title_" .. var_12_3))

			setImageSprite = var_7

			local var_12_5 = var_12_0

			GetSpriteFromAtlas = var_10

			var_7(var_12_5, var_10("ShipType", "buffitem_tec_" .. var_12_3), true)

			Canvas = var_7

			var_7.ForceUpdateCanvases()

			local var_12_6 = arg_11_0

			var_7.updateBuffList(var_12_6, var_12_2, var_12_3)
		end

		return
	end)
	var_1:align(#arg_11_0.typeOrder)

	Canvas = var_2

	var_2.ForceUpdateCanvases()

	local var_11_1

	if arg_11_0.scrollView.rect.height >= 850 then
		var_11_1 = arg_11_0.viewportGroupCom
		var_11_1.enabled = false
		var_11_1 = arg_11_0.viewportFitterCom
		var_11_1.enabled = false
		var_11_1 = arg_11_0.scrollViewFitterCom
		var_11_1.enabled = false
		var_11_1 = arg_11_0.scrollView
		Vector2 = var_3
		var_11_1.sizeDelta = var_3.New(0, 850)
		GetComponent = var_11_1
		var_11_1 = var_11_1(arg_11_0.scrollView, "ScrollRect")
		var_11_1.enabled = true
	end

	setActive = var_11_1

	var_11_1(arg_11_0.scrollView, false)

	setActive = var_11_1

	var_11_1(arg_11_0.scrollView, true)

	return
end

function var_0_1.updateBuffList(arg_13_0, arg_13_1, arg_13_2)
	UIItemList = var_1_10003

	local var_13_0 = var_1_10003.New(arg_13_1, arg_13_0.buffItemTpl)
	local var_13_1 = arg_13_0.typeAttrTable[arg_13_2]
	local var_13_2 = arg_13_0.typeAttrOrderTable[arg_13_2]

	var_13_0:make(function(arg_14_0, arg_14_1, arg_14_2)
		UIItemList = var_2_10003

		if arg_14_0 == var_2_10003.EventUpdate then
			local var_14_0 = arg_14_2:Find("AttrText")
			local var_14_1 = arg_14_2:Find("ValueText")
			local var_14_2 = var_13_2[arg_14_1 + 1]
			local var_14_3 = var_13_1[var_14_2]
			local var_14_4 = arg_13_0.technologyNationProxy
			local var_14_5 = var_7.getSetableAttrAdditionValueByTypeAttr(var_14_4, arg_13_2, var_14_2)

			setText = var_2_10008

			local var_14_6 = var_14_0

			AttributeType = var_11

			local var_14_7 = var_11.Type2Name

			pg = var_2_10013

			var_2_10008(var_14_6, var_14_7(var_2_10013.attribute_info_by_type[var_14_2].name))

			local var_14_8

			if var_14_5 == var_14_3 then
				var_14_8 = "#00FF32FF"
			elseif var_14_5 == 0 then
				var_14_8 = "#CA5B5BFF"
			elseif var_14_5 < var_14_3 then
				var_14_8 = "#A5BBD6FF"
			end

			setText = var_14_4

			local var_14_9 = var_14_1

			setColorStr = var_2_10012

			var_14_4(var_14_9, var_2_10012("+" .. var_14_5, var_14_8))
		end

		return
	end)
	var_13_0:align(#var_13_2)

	return
end

return var_0_1
