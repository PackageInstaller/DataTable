local var_0_0 = class("AllBuffDetailLayer", import("..base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "TechnologyTreeAllBuffUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0:BlurPanel(arg_3_0._tf)
	arg_3_0:addListener()
	arg_3_0:updateDetail()

	return
end

function var_0_0.willExit(arg_4_0)
	arg_4_0:UnOverlayPanel(arg_4_0._tf)

	return
end

function var_0_0.initData(arg_5_0)
	arg_5_0.technologyNationProxy = getProxy(TechnologyNationProxy)
	arg_5_0.tecList = arg_5_0.technologyNationProxy:GetTecList()
	arg_5_0.typeAttrTable, arg_5_0.typeOrder, arg_5_0.typeAttrOrderTable = arg_5_0.technologyNationProxy:getTecBuff()
	arg_5_0.typeOrder = ShipType.FilterOverQuZhuType(arg_5_0.typeOrder)

	return
end

function var_0_0.findUI(arg_6_0)
	arg_6_0.backBtn = arg_6_0._tf:Find("BG")
	arg_6_0.scrollView = arg_6_0._tf:Find("Scroll View")
	arg_6_0.viewport = arg_6_0.scrollView:Find("Viewport")
	arg_6_0.typeContainer = arg_6_0.viewport:Find("Content")
	arg_6_0.typeItemTpl = arg_6_0._tf:Find("TypeItemTpl")
	arg_6_0.buffItemTpl = arg_6_0._tf:Find("BuffItemTpl")
	arg_6_0.scrollViewGroupCom = GetComponent(arg_6_0.scrollView, "VerticalLayoutGroup")
	arg_6_0.scrollViewFitterCom = GetComponent(arg_6_0.scrollView, "ContentSizeFitter")
	arg_6_0.viewportGroupCom = GetComponent(arg_6_0.viewport, "VerticalLayoutGroup")
	arg_6_0.viewportFitterCom = GetComponent(arg_6_0.viewport, "ContentSizeFitter")
	arg_6_0.setValueBtn = arg_6_0._tf:Find("Scroll View/bg/SetValueBtn")

	return
end

function var_0_0.onBackPressed(arg_7_0)
	triggerButton(arg_7_0.backBtn)

	return
end

function var_0_0.addListener(arg_8_0)
	onButton(arg_8_0, arg_8_0.backBtn, function()
		arg_8_0:emit(var_0_0.ON_CLOSE)

		return
	end, SFX_CANCEL)
	onButton(arg_8_0, arg_8_0.setValueBtn, function()
		if getProxy(ChapterProxy):getActiveChapter(true) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("attrset_disable"))
		else
			arg_8_0:emit(AllBuffDetailMediator.OPEN_SET_VALUE_LAYER)
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.updateDetail(arg_11_0)
	local var_11_0 = UIItemList.New(arg_11_0.typeContainer, arg_11_0.typeItemTpl)

	var_11_0:make(function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_0 == UIItemList.EventUpdate then
			setImageSprite(arg_12_2:Find("TypeTitle/TypeTextImg"), GetSpriteFromAtlas("ShipType", "ch_title_" .. arg_11_0.typeOrder[arg_12_1 + 1]))
			setImageSprite(arg_12_2:Find("TypeTitle/TypeImg"), GetSpriteFromAtlas("ShipType", "buffitem_tec_" .. arg_11_0.typeOrder[arg_12_1 + 1]), true)
			Canvas.ForceUpdateCanvases()
			arg_11_0:updateBuffList(arg_12_2:Find("Container"), arg_11_0.typeOrder[arg_12_1 + 1])
		end

		return
	end)
	var_11_0:align(#arg_11_0.typeOrder)
	Canvas.ForceUpdateCanvases()

	if arg_11_0.scrollView.rect.height >= 850 then
		arg_11_0.viewportGroupCom.enabled = false
		arg_11_0.viewportFitterCom.enabled = false
		arg_11_0.scrollViewFitterCom.enabled = false
		arg_11_0.scrollView.sizeDelta = Vector2.New(0, 850)
		GetComponent(arg_11_0.scrollView, "ScrollRect").enabled = true
	end

	setActive(arg_11_0.scrollView, false)
	setActive(arg_11_0.scrollView, true)

	return
end

function var_0_0.updateBuffList(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = UIItemList.New(arg_13_1, arg_13_0.buffItemTpl)
	local var_13_1 = arg_13_0.typeAttrTable[arg_13_2]
	local var_13_2 = arg_13_0.typeAttrOrderTable[arg_13_2]

	var_13_0:make(function(arg_14_0, arg_14_1, arg_14_2)
		if arg_14_0 == UIItemList.EventUpdate then
			local var_14_0 = arg_14_2:Find("ValueText")
			local var_14_1 = arg_13_0.technologyNationProxy:getSetableAttrAdditionValueByTypeAttr(arg_13_2, var_13_2[arg_14_1 + 1])

			setText(arg_14_2:Find("AttrText"), AttributeType.Type2Name(pg.attribute_info_by_type[var_13_2[arg_14_1 + 1]].name))

			local var_14_2

			if var_14_1 == var_13_1[var_13_2[arg_14_1 + 1]] then
				var_14_2 = "#00FF32FF"
			elseif var_14_1 == 0 then
				var_14_2 = "#CA5B5BFF"
			elseif var_14_1 < var_13_1[var_13_2[arg_14_1 + 1]] then
				var_14_2 = "#A5BBD6FF"
			end

			setText(var_14_0, setColorStr("+" .. var_14_1, var_14_2))
		end

		return
	end)
	var_13_0:align(#arg_13_0.typeAttrOrderTable[arg_13_2])

	return
end

return var_0_0
