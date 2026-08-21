local var_0_0 = class("TechnologyTreeSetAttrLayer", import("..base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "TechnologyTreeSetAttrUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:initUITips()
	arg_2_0:findUI()
	arg_2_0:addListener()

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0:BlurPanel(arg_3_0._tf)
	arg_3_0:updateTypeList()
	triggerToggle(arg_3_0.typeContainer:GetChild(0), true)

	return
end

function var_0_0.willExit(arg_4_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_4_0._tf)
	arg_4_0.resLoader:Clear()

	return
end

function var_0_0.onBackPressed(arg_5_0)
	triggerButton(arg_5_0.closeBtn)

	return
end

function var_0_0.initData(arg_6_0)
	arg_6_0.tecNationProxy = getProxy(TechnologyNationProxy)
	arg_6_0.cacheAdditionMap = {}
	arg_6_0.curAdditionMap = arg_6_0.tecNationProxy:getSetableAttrAddition()
	arg_6_0.maxAdditionMap = nil
	arg_6_0.typeOrderList = nil
	arg_6_0.typeAttrOrderListTable = nil
	arg_6_0.maxAdditionMap, arg_6_0.typeOrderList, arg_6_0.typeAttrOrderListTable = arg_6_0.tecNationProxy:getTecBuff()
	arg_6_0.typeOrderList = ShipType.FilterOverQuZhuType(arg_6_0.typeOrderList)
	arg_6_0.resLoader = AutoLoader.New()
	arg_6_0.curType = 0
	arg_6_0.typeToggleTable = {}
	arg_6_0.typeAttrTFTable = {}

	return
end

function var_0_0.initUITips(arg_7_0)
	setText(arg_7_0._tf:Find("Adapt/Content/ResetBtn/Text"), i18n("attrset_reset"))
	setText(arg_7_0._tf:Find("Adapt/Content/SaveBtn/Text"), i18n("attrset_save"))

	return
end

function var_0_0.findUI(arg_8_0)
	arg_8_0.typeTpl = arg_8_0._tf:Find("TypeTpl")
	arg_8_0.attrTpl = arg_8_0._tf:Find("AttrTpl")
	arg_8_0.backBGTF = arg_8_0._tf:Find("Adapt/BackBG")

	local var_8_0 = arg_8_0._tf:Find("Adapt/Content")

	arg_8_0.closeBtn = var_8_0:Find("CloseBtn")
	arg_8_0.arrowTF = var_8_0:Find("Arrow")
	arg_8_0.typeContainer = var_8_0:Find("TypeScrollView/Content")
	arg_8_0.attrContainer = var_8_0:Find("AttrPanel")
	arg_8_0.resetBtn = var_8_0:Find("ResetBtn")
	arg_8_0.saveBtn = var_8_0:Find("SaveBtn")
	arg_8_0.typeUIItemList = UIItemList.New(arg_8_0.typeContainer, arg_8_0.typeTpl)
	arg_8_0.attrUIItemList = UIItemList.New(arg_8_0.attrContainer, arg_8_0.attrTpl)

	return
end

function var_0_0.addListener(arg_9_0)
	onButton(arg_9_0, arg_9_0.closeBtn, function()
		if arg_9_0:isChanged() then
			arg_9_0:openSaveBox(function()
				arg_9_0:save(function()
					arg_9_0:closeView()

					return
				end)

				return
			end, function()
				arg_9_0:closeView()

				return
			end, function()
				return
			end)
		else
			arg_9_0:closeView()
		end

		return
	end, SFX_CANCEL)
	onButton(arg_9_0, arg_9_0.backBGTF, function()
		if arg_9_0:isChanged() then
			arg_9_0:openSaveBox(function()
				arg_9_0:save(function()
					arg_9_0:closeView()

					return
				end)

				return
			end, function()
				arg_9_0:closeView()

				return
			end, function()
				return
			end)
		else
			arg_9_0:closeView()
		end

		return
	end, SFX_CANCEL)
	arg_9_0.typeUIItemList:make(function(arg_20_0, arg_20_1, arg_20_2)
		if arg_20_0 == UIItemList.EventUpdate then
			arg_20_1 = arg_20_1 + 1

			arg_9_0:updateTypeTF(arg_20_1, arg_20_2)
		end

		return
	end)
	arg_9_0.attrUIItemList:make(function(arg_21_0, arg_21_1, arg_21_2)
		if arg_21_0 == UIItemList.EventUpdate then
			arg_21_1 = arg_21_1 + 1

			arg_9_0:updateAttrTF(arg_21_1, arg_21_2)
		end

		return
	end)
	onButton(arg_9_0, arg_9_0.resetBtn, function()
		for iter_22_0, iter_22_1 in ipairs(arg_9_0.typeAttrOrderListTable[arg_9_0.curType]) do
			arg_9_0:setAttrValue(arg_9_0.curType, iter_22_1, arg_9_0.maxAdditionMap[arg_9_0.curType][iter_22_1])
			arg_9_0:setAttrTFValue(arg_9_0.typeAttrTFTable[arg_9_0.curType][iter_22_1], arg_9_0.maxAdditionMap[arg_9_0.curType][iter_22_1])
		end

		return
	end, SFX_PANEL)
	onButton(arg_9_0, arg_9_0.saveBtn, function()
		if arg_9_0:isChanged() then
			arg_9_0:save(function()
				arg_9_0:clearCacheMap()

				arg_9_0.curAdditionMap = arg_9_0.tecNationProxy:getSetableAttrAddition()

				return
			end)
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.updateTypeTF(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_0.typeOrderList[arg_25_1]
	local var_25_1 = ShipType.Type2Name(arg_25_0.typeOrderList[arg_25_1])

	setText(arg_25_2:Find("TypeNameUnSelect"), var_25_1)
	setText(arg_25_2:Find("TypeNameSelected"), var_25_1)
	arg_25_0.resLoader:GetSprite("ShipType", "buffitem_tec_" .. arg_25_0.typeOrderList[arg_25_1], arg_25_2:Find("TypeImg"), false)
	onToggle(arg_25_0, arg_25_2, function(arg_26_0)
		if arg_26_0 and arg_25_0.curType ~= var_25_0 then
			if arg_25_0:isChanged() then
				arg_25_0:openSaveBox(function()
					arg_25_0:save(function()
						arg_25_0:clearCacheMap()

						arg_25_0.curAdditionMap = arg_25_0.tecNationProxy:getSetableAttrAddition()
						arg_25_0.curType = var_25_0

						arg_25_0:updateAttrList(arg_25_0.curType)

						return
					end)

					return
				end, function()
					arg_25_0:clearCacheMap()

					arg_25_0.curType = var_25_0

					arg_25_0:updateAttrList(arg_25_0.curType)

					return
				end, function()
					triggerToggle(arg_25_0.typeToggleTable[arg_25_0.curType], true)

					return
				end)
			else
				arg_25_0:clearCacheMap()

				arg_25_0.curType = var_25_0

				arg_25_0:updateAttrList(arg_25_0.curType)
			end
		end

		return
	end, SFX_PANEL)

	arg_25_0.typeToggleTable[arg_25_0.typeOrderList[arg_25_1]] = arg_25_2

	return
end

function var_0_0.updateTypeList(arg_31_0)
	arg_31_0.typeUIItemList:align(#arg_31_0.typeOrderList)

	return
end

function var_0_0.updateAttrTF(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_2:Find("Attr/Value/CurValue")
	local var_32_1 = arg_32_2:Find("Attr/InputField")
	local var_32_2 = arg_32_2:Find("Attr/InputField")
	local var_32_3 = arg_32_0.typeAttrOrderListTable[arg_32_0.curType][arg_32_1]
	local var_32_4 = arg_32_0.maxAdditionMap[arg_32_0.curType][arg_32_0.typeAttrOrderListTable[arg_32_0.curType][arg_32_1]]

	setText(arg_32_2:Find("AttrName"), (AttributeType.Type2Name(pg.attribute_info_by_type[arg_32_0.typeAttrOrderListTable[arg_32_0.curType][arg_32_1]].name)))
	setText(arg_32_2:Find("Attr/Value/CurValue"), (arg_32_0:getAddValueForShow(arg_32_0.curType, arg_32_0.typeAttrOrderListTable[arg_32_0.curType][arg_32_1])))
	setText(arg_32_2:Find("Attr/Value/MaxValue"), arg_32_0.maxAdditionMap[arg_32_0.curType][arg_32_0.typeAttrOrderListTable[arg_32_0.curType][arg_32_1]])
	onButton(arg_32_0, arg_32_2:Find("Buttons/MinusBtn"), function()
		local var_33_0 = arg_32_0:getAddValueForShow(arg_32_0.curType, var_32_3)

		if var_33_0 > 0 then
			arg_32_0:setAttrValue(arg_32_0.curType, var_32_3, var_33_0 - 1)
			setText(var_32_0, var_33_0 - 1)
		end

		return
	end, SFX_PANEL)
	onButton(arg_32_0, arg_32_2:Find("Buttons/AddBtn"), function()
		local var_34_0 = arg_32_0:getAddValueForShow(arg_32_0.curType, var_32_3)

		if var_34_0 < var_32_4 then
			arg_32_0:setAttrValue(arg_32_0.curType, var_32_3, var_34_0 + 1)
			setText(var_32_0, var_34_0 + 1)
		end

		return
	end, SFX_PANEL)
	onButton(arg_32_0, arg_32_2:Find("Buttons/MaxBtn"), function()
		local var_35_0 = arg_32_0:getAddValueForShow(arg_32_0.curType, var_32_3)

		arg_32_0:setAttrValue(arg_32_0.curType, var_32_3, var_32_4)
		setText(var_32_0, var_32_4)

		return
	end, SFX_PANEL)
	onInputEndEdit(arg_32_0, arg_32_2:Find("Attr/InputField"), function(arg_36_0)
		local var_36_0 = tonumber(arg_36_0)

		if var_36_0 then
			if var_36_0 < 0 then
				var_36_0 = nil
			else
				local var_36_1 = math.floor(var_36_0)

				var_36_0 = var_36_1 == var_36_0 and var_36_1 or nil
			end
		end

		if var_36_0 then
			var_36_0 = math.min(var_36_0, var_32_4)

			arg_32_0:setAttrValue(arg_32_0.curType, var_32_3, var_36_0)
			setText(var_32_0, var_36_0)
		elseif not var_36_0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("attrset_input_ill"))
		end

		setInputText(var_32_2, "")

		return
	end)

	arg_32_0.typeAttrTFTable[arg_32_0.curType][arg_32_0.typeAttrOrderListTable[arg_32_0.curType][arg_32_1]] = arg_32_2

	return
end

function var_0_0.updateAttrList(arg_37_0, arg_37_1)
	arg_37_0.typeAttrTFTable = {}
	arg_37_0.typeAttrTFTable[arg_37_1] = {}

	arg_37_0.attrUIItemList:align(#arg_37_0.typeAttrOrderListTable[arg_37_1])

	return
end

function var_0_0.setAttrTFValue(arg_38_0, arg_38_1, arg_38_2)
	setText(arg_38_1:Find("Attr/Value/CurValue"), arg_38_2)

	return
end

function var_0_0.openSaveBox(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		content = i18n("attrset_ask_save"),
		onYes = arg_39_1,
		onNo = arg_39_2,
		onClose = arg_39_3
	})

	return
end

function var_0_0.getAddValueForShow(arg_40_0, arg_40_1, arg_40_2)
	if arg_40_0.cacheAdditionMap[arg_40_1] and arg_40_0.cacheAdditionMap[arg_40_1][arg_40_2] then
		return arg_40_0.cacheAdditionMap[arg_40_1][arg_40_2]
	elseif arg_40_0.curAdditionMap[arg_40_0.curType] and arg_40_0.curAdditionMap[arg_40_0.curType][arg_40_2] then
		return arg_40_0.curAdditionMap[arg_40_1][arg_40_2]
	else
		return arg_40_0.maxAdditionMap[arg_40_1][arg_40_2]
	end

	return
end

function var_0_0.setAttrValue(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
	arg_41_0.cacheAdditionMap[arg_41_1] = arg_41_0.cacheAdditionMap[arg_41_1] or {}
	arg_41_0.cacheAdditionMap[arg_41_1][arg_41_2] = arg_41_3

	return
end

function var_0_0.clearCacheMap(arg_42_0)
	arg_42_0.cacheAdditionMap = {}

	return
end

function var_0_0.isChanged(arg_43_0)
	for iter_43_0, iter_43_1 in pairs(arg_43_0.cacheAdditionMap) do
		for iter_43_2, iter_43_3 in pairs(iter_43_1) do
			if iter_43_3 ~= arg_43_0.tecNationProxy:getSetableAttrAdditionValueByTypeAttr(iter_43_0, iter_43_2) then
				return true
			end
		end
	end

	return false
end

function var_0_0.save(arg_44_0, arg_44_1)
	for iter_44_0, iter_44_1 in pairs(arg_44_0.curAdditionMap) do
		if not ({})[iter_44_0] then
			({})[iter_44_0] = {}
		end

		for iter_44_2, iter_44_3 in pairs(iter_44_1) do
			({})[iter_44_0][iter_44_2] = iter_44_3
		end
	end

	for iter_44_4, iter_44_5 in pairs(arg_44_0.cacheAdditionMap) do
		if not ({})[iter_44_4] then
			({})[iter_44_4] = {}
		end

		for iter_44_6, iter_44_7 in pairs(iter_44_5) do
			({})[iter_44_4][iter_44_6] = iter_44_7
		end
	end

	for iter_44_8, iter_44_9 in pairs({}) do
		for iter_44_10, iter_44_11 in pairs(iter_44_9) do
			if iter_44_11 ~= arg_44_0.maxAdditionMap[iter_44_8][iter_44_10] then
				table.insert({}, {
					ship_type = iter_44_8,
					attr_type = iter_44_10,
					set_value = iter_44_11
				})
			end
		end
	end

	pg.m02:sendNotification(GAME.SET_TEC_ATTR_ADDITION, {
		sendList = {},
		onSuccess = arg_44_1
	})

	return
end

function var_0_0.reset(arg_45_0)
	for iter_45_0, iter_45_1 in pairs(arg_45_0.curAdditionMap) do
		if iter_45_0 ~= arg_45_0.curType then
			if not ({})[iter_45_0] then
				({})[iter_45_0] = {}
			end

			for iter_45_2, iter_45_3 in pairs(iter_45_1) do
				({})[iter_45_0][iter_45_2] = iter_45_3
			end
		end
	end

	for iter_45_4, iter_45_5 in pairs(arg_45_0.cacheAdditionMap) do
		if iter_45_4 ~= arg_45_0.curType then
			if not ({})[iter_45_4] then
				({})[iter_45_4] = {}
			end

			for iter_45_6, iter_45_7 in pairs(iter_45_5) do
				({})[iter_45_4][iter_45_6] = iter_45_7
			end
		end
	end

	for iter_45_8, iter_45_9 in pairs({}) do
		for iter_45_10, iter_45_11 in pairs(iter_45_9) do
			if iter_45_11 ~= arg_45_0.maxAdditionMap[iter_45_8][iter_45_10] then
				table.insert({}, {
					ship_type = iter_45_8,
					attr_type = iter_45_10,
					set_value = iter_45_11
				})
			end
		end
	end

	pg.m02:sendNotification(GAME.SET_TEC_ATTR_ADDITION, {
		sendList = {}
	})

	return
end

return var_0_0
