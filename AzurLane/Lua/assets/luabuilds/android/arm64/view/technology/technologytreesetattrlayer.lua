class = var_0_10000

local var_0_0 = "TechnologyTreeSetAttrLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "TechnologyTreeSetAttrUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:initUITips()
	arg_2_0:findUI()
	arg_2_0:addListener()

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0:BlurPanel(arg_3_0._tf)
	arg_3_0:updateTypeList()

	triggerToggle = var_1

	local var_3_0 = arg_3_0.typeContainer

	var_1(var_3.GetChild(var_3_0, 0), true)

	return
end

function var_0_1.willExit(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_4_0, arg_4_0._tf)

	local var_4_1 = arg_4_0.resLoader

	var_1.Clear(var_4_1)

	return
end

function var_0_1.onBackPressed(arg_5_0)
	triggerButton = var_1_10001

	var_1_10001(arg_5_0.closeBtn)

	return
end

function var_0_1.initData(arg_6_0)
	getProxy = var_1_10001
	TechnologyNationProxy = var_1_10003
	arg_6_0.tecNationProxy = var_1_10001(var_1_10003)
	arg_6_0.cacheAdditionMap = {}

	local var_6_0 = arg_6_0.tecNationProxy

	arg_6_0.curAdditionMap = var_1.getSetableAttrAddition(var_6_0)
	arg_6_0.maxAdditionMap = nil
	arg_6_0.typeOrderList = nil
	arg_6_0.typeAttrOrderListTable = nil

	local var_6_1 = arg_6_0.tecNationProxy
	local var_6_2, var_6_3, var_6_4 = var_1.getTecBuff(var_6_1)

	arg_6_0.typeAttrOrderListTable = var_6_4
	arg_6_0.typeOrderList = var_6_3
	arg_6_0.maxAdditionMap = var_6_2
	ShipType = var_6_2
	arg_6_0.typeOrderList = var_6_2.FilterOverQuZhuType(arg_6_0.typeOrderList)
	AutoLoader = var_1
	arg_6_0.resLoader = var_1.New()
	arg_6_0.curType = 0
	arg_6_0.typeToggleTable = {}
	arg_6_0.typeAttrTFTable = {}

	return
end

function var_0_1.initUITips(arg_7_0)
	local var_7_0 = arg_7_0._tf
	local var_7_1 = var_1.Find(var_7_0, "Adapt/Content/ResetBtn/Text")
	local var_7_2 = arg_7_0._tf
	local var_7_3 = var_2.Find(var_7_2, "Adapt/Content/SaveBtn/Text")

	setText = var_7_0

	local var_7_4 = var_7_1

	i18n = var_1_10006

	var_7_0(var_7_4, var_1_10006("attrset_reset"))

	setText = var_7_0

	local var_7_5 = var_7_3

	i18n = var_6

	var_7_0(var_7_5, var_6("attrset_save"))

	return
end

function var_0_1.findUI(arg_8_0)
	local var_8_0 = arg_8_0._tf

	arg_8_0.typeTpl = var_1.Find(var_8_0, "TypeTpl")

	local var_8_1 = arg_8_0._tf

	arg_8_0.attrTpl = var_1.Find(var_8_1, "AttrTpl")

	local var_8_2 = arg_8_0._tf

	arg_8_0.backBGTF = var_1.Find(var_8_2, "Adapt/BackBG")

	local var_8_3 = arg_8_0._tf
	local var_8_4 = var_1.Find(var_8_3, "Adapt/Content")

	arg_8_0.closeBtn = var_1.Find(var_8_4, "CloseBtn")
	arg_8_0.arrowTF = var_1:Find("Arrow")
	arg_8_0.typeContainer = var_1:Find("TypeScrollView/Content")
	arg_8_0.attrContainer = var_1:Find("AttrPanel")
	arg_8_0.resetBtn = var_1:Find("ResetBtn")
	arg_8_0.saveBtn = var_1:Find("SaveBtn")
	UIItemList = var_2
	arg_8_0.typeUIItemList = var_2.New(arg_8_0.typeContainer, arg_8_0.typeTpl)
	UIItemList = var_2
	arg_8_0.attrUIItemList = var_2.New(arg_8_0.attrContainer, arg_8_0.attrTpl)

	return
end

function var_0_1.addListener(arg_9_0)
	onButton = var_1_10001

	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.closeBtn

	local function var_9_2()
		local var_10_0 = arg_9_0

		if var_0.isChanged(var_10_0) then
			local function var_10_1()
				return
			end

			local function var_10_2()
				local var_12_0 = arg_9_0

				var_0.closeView(var_12_0)

				return
			end

			local function var_10_3()
				local var_13_0 = arg_9_0

				var_0.save(var_13_0, function()
					local var_14_0 = arg_9_0

					var_0.closeView(var_14_0)

					return
				end)

				return
			end

			local var_10_4 = arg_9_0

			var_3.openSaveBox(var_10_4, var_10_3, var_10_2, var_10_1)
		else
			local var_10_5 = arg_9_0

			var_0.closeView(var_10_5)
		end

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_9_0, var_9_1, var_9_2, var_1_10006)

	onButton = var_1_10001

	local var_9_3 = arg_9_0
	local var_9_4 = arg_9_0.backBGTF

	local function var_9_5()
		local var_15_0 = arg_9_0

		if var_0.isChanged(var_15_0) then
			local function var_15_1()
				return
			end

			local function var_15_2()
				local var_17_0 = arg_9_0

				var_0.closeView(var_17_0)

				return
			end

			local function var_15_3()
				local var_18_0 = arg_9_0

				var_0.save(var_18_0, function()
					local var_19_0 = arg_9_0

					var_0.closeView(var_19_0)

					return
				end)

				return
			end

			local var_15_4 = arg_9_0

			var_3.openSaveBox(var_15_4, var_15_3, var_15_2, var_15_1)
		else
			local var_15_5 = arg_9_0

			var_0.closeView(var_15_5)
		end

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_9_3, var_9_4, var_9_5, var_1_10006)

	local var_9_6 = arg_9_0.typeUIItemList

	var_1.make(var_9_6, function(arg_20_0, arg_20_1, arg_20_2)
		UIItemList = var_2_10003

		if arg_20_0 == var_2_10003.EventUpdate then
			arg_20_1 = arg_20_1 + 1

			local var_20_0 = arg_9_0

			var_3.updateTypeTF(var_20_0, arg_20_1, arg_20_2)
		end

		return
	end)

	local var_9_7 = arg_9_0.attrUIItemList

	var_1.make(var_9_7, function(arg_21_0, arg_21_1, arg_21_2)
		UIItemList = var_2_10003

		if arg_21_0 == var_2_10003.EventUpdate then
			arg_21_1 = arg_21_1 + 1

			local var_21_0 = arg_9_0

			var_3.updateAttrTF(var_21_0, arg_21_1, arg_21_2)
		end

		return
	end)

	onButton = var_1

	local var_9_8 = arg_9_0
	local var_9_9 = arg_9_0.resetBtn

	local function var_9_10()
		ipairs = var_2_10000

		for iter_22_0, iter_22_1 in var_2_10000(arg_9_0.typeAttrOrderListTable[arg_9_0.curType]) do
			local var_22_0 = arg_9_0.maxAdditionMap[arg_9_0.curType][iter_22_1]
			local var_22_1 = arg_9_0

			var_6.setAttrValue(var_22_1, arg_9_0.curType, iter_22_1, var_22_0)

			local var_22_2 = arg_9_0

			var_6.setAttrTFValue(var_22_2, arg_9_0.typeAttrTFTable[arg_9_0.curType][iter_22_1], var_22_0)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_9_8, var_9_9, var_9_10, var_1_10006)

	onButton = var_1

	local var_9_11 = arg_9_0
	local var_9_12 = arg_9_0.saveBtn

	local function var_9_13()
		local var_23_0 = arg_9_0

		if var_0.isChanged(var_23_0) then
			local function var_23_1()
				local var_24_0 = arg_9_0

				var_0.clearCacheMap(var_24_0)

				local var_24_1 = arg_9_0
				local var_24_2 = arg_9_0.tecNationProxy

				var_24_1.curAdditionMap = var_1.getSetableAttrAddition(var_24_2)

				return
			end

			local var_23_2 = arg_9_0

			var_1.save(var_23_2, var_23_1)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_9_11, var_9_12, var_9_13, var_1_10006)

	return
end

function var_0_1.updateTypeTF(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_2:Find("TypeNameUnSelect")
	local var_25_1 = arg_25_2:Find("TypeNameSelected")
	local var_25_2 = arg_25_2
	local var_25_3 = arg_25_2.Find(var_25_2, "TypeImg")
	local var_25_4 = arg_25_0.typeOrderList[arg_25_1]

	ShipType = var_25_2

	local var_25_5 = var_25_2.Type2Name(var_25_4)

	setText = var_8

	var_8(var_25_0, var_25_5)

	setText = var_8

	var_8(var_25_1, var_25_5)

	local var_25_6 = arg_25_0.resLoader

	var_8.GetSprite(var_25_6, "ShipType", "buffitem_tec_" .. var_25_4, var_25_3, false)

	onToggle = var_8

	local var_25_7 = arg_25_0
	local var_25_8 = arg_25_2

	local function var_25_9(arg_26_0)
		if arg_26_0 and arg_25_0.curType ~= var_25_4 then
			local var_26_0 = arg_25_0

			if var_1.isChanged(var_26_0) then
				local function var_26_1()
					triggerToggle = var_3_10000

					var_3_10000(arg_25_0.typeToggleTable[arg_25_0.curType], true)

					return
				end

				local function var_26_2()
					local var_28_0 = arg_25_0

					var_0.clearCacheMap(var_28_0)

					arg_25_0.curType = var_25_4

					local var_28_1 = arg_25_0

					var_0.updateAttrList(var_28_1, arg_25_0.curType)

					return
				end

				local function var_26_3()
					local var_29_0 = arg_25_0

					var_0.save(var_29_0, function()
						local var_30_0 = arg_25_0

						var_0.clearCacheMap(var_30_0)

						local var_30_1 = arg_25_0
						local var_30_2 = arg_25_0.tecNationProxy

						var_30_1.curAdditionMap = var_1.getSetableAttrAddition(var_30_2)
						arg_25_0.curType = var_25_4

						local var_30_3 = arg_25_0

						var_0.updateAttrList(var_30_3, arg_25_0.curType)

						return
					end)

					return
				end

				local var_26_4 = arg_25_0

				var_4.openSaveBox(var_26_4, var_26_3, var_26_2, var_26_1)
			else
				local var_26_5 = arg_25_0

				var_1.clearCacheMap(var_26_5)

				arg_25_0.curType = var_25_4

				local var_26_6 = arg_25_0

				var_1.updateAttrList(var_26_6, arg_25_0.curType)
			end
		end

		return
	end

	SFX_PANEL = var_13

	var_8(var_25_7, var_25_8, var_25_9, var_13)

	arg_25_0.typeToggleTable[var_25_4] = arg_25_2

	return
end

function var_0_1.updateTypeList(arg_31_0)
	local var_31_0 = arg_31_0.typeUIItemList

	var_1.align(var_31_0, #arg_31_0.typeOrderList)

	return
end

function var_0_1.updateAttrTF(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_2:Find("AttrName")
	local var_32_1 = arg_32_2:Find("Attr/Value/CurValue")
	local var_32_2 = arg_32_2:Find("Attr/Value/MaxValue")
	local var_32_3 = arg_32_2:Find("Attr/InputField")
	local var_32_4 = arg_32_2:Find("Buttons/MinusBtn")
	local var_32_5 = arg_32_2:Find("Buttons/MaxBtn")
	local var_32_6 = arg_32_2:Find("Buttons/AddBtn")
	local var_32_7 = arg_32_2:Find("Attr/InputField")
	local var_32_8 = arg_32_0.typeAttrOrderListTable[arg_32_0.curType][arg_32_1]

	AttributeType = var_13

	local var_32_9 = var_13.Type2Name

	pg = var_1_10015

	local var_32_10 = var_32_9(var_1_10015.attribute_info_by_type[var_32_8].name)
	local var_32_11 = arg_32_0.maxAdditionMap[arg_32_0.curType][var_32_8]
	local var_32_12 = arg_32_0:getAddValueForShow(arg_32_0.curType, var_32_8)

	setText = var_1_10016

	var_1_10016(var_32_0, var_32_10)

	setText = var_1_10016

	var_1_10016(var_32_1, var_32_12)

	setText = var_1_10016

	var_1_10016(var_32_2, var_32_11)

	onButton = var_1_10016

	local var_32_13 = arg_32_0
	local var_32_14 = var_32_4

	local function var_32_15()
		local var_33_0 = arg_32_0

		if var_0.getAddValueForShow(var_33_0, arg_32_0.curType, var_32_8) > 0 then
			local var_33_1 = var_0 - 1
			local var_33_2 = arg_32_0

			var_1.setAttrValue(var_33_2, arg_32_0.curType, var_32_8, var_33_1)

			setText = var_1

			var_1(var_32_1, var_33_1)
		end

		return
	end

	SFX_PANEL = var_1_10021

	var_1_10016(var_32_13, var_32_14, var_32_15, var_1_10021)

	onButton = var_1_10016

	local var_32_16 = arg_32_0
	local var_32_17 = var_32_6

	local function var_32_18()
		local var_34_0 = arg_32_0

		if var_0.getAddValueForShow(var_34_0, arg_32_0.curType, var_32_8) < var_32_11 then
			local var_34_1 = var_0 + 1
			local var_34_2 = arg_32_0

			var_1.setAttrValue(var_34_2, arg_32_0.curType, var_32_8, var_34_1)

			setText = var_1

			var_1(var_32_1, var_34_1)
		end

		return
	end

	SFX_PANEL = var_1_10021

	var_1_10016(var_32_16, var_32_17, var_32_18, var_1_10021)

	onButton = var_1_10016

	local var_32_19 = arg_32_0
	local var_32_20 = var_32_5

	local function var_32_21()
		local var_35_0 = arg_32_0
		local var_35_1 = var_0.getAddValueForShow(var_35_0, arg_32_0.curType, var_32_8)
		local var_35_2 = var_32_11
		local var_35_3 = arg_32_0

		var_1.setAttrValue(var_35_3, arg_32_0.curType, var_32_8, var_35_2)

		setText = var_1

		var_1(var_32_1, var_35_2)

		return
	end

	SFX_PANEL = var_1_10021

	var_1_10016(var_32_19, var_32_20, var_32_21, var_1_10021)

	onInputEndEdit = var_1_10016

	var_1_10016(arg_32_0, var_32_7, function(arg_36_0)
		tonumber = var_2_10001

		local var_36_0

		if var_2_10001(arg_36_0) then
			if var_36_0 < 0 then
				var_36_0 = nil
			else
				math = var_2_10002

				if var_2_10002.floor(var_36_0) == var_36_0 then
					var_36_0 = var_2_10002
				else
					var_36_0 = nil
				end
			end
		end

		if var_36_0 then
			math = var_2_10002
			var_36_0 = var_2_10002.min(var_36_0, var_32_11)

			local var_36_1 = arg_32_0

			var_2_10002.setAttrValue(var_36_1, arg_32_0.curType, var_32_8, var_36_0)

			setText = var_2_10002

			var_2_10002(var_32_1, var_36_0)
		elseif not var_36_0 then
			pg = var_2_10002

			local var_36_2 = var_2_10002.TipsMgr.GetInstance()

			var_2_10002 = var_2_10002.ShowTips
			i18n = var_2_10005

			var_2_10002(var_36_2, var_2_10005("attrset_input_ill"))
		end

		setInputText = var_2_10002

		var_2_10002(var_32_7, "")

		return
	end)

	arg_32_0.typeAttrTFTable[arg_32_0.curType][var_32_8] = arg_32_2

	return
end

function var_0_1.updateAttrList(arg_37_0, arg_37_1)
	arg_37_0.typeAttrTFTable = {}
	arg_37_0.typeAttrTFTable[arg_37_1] = {}

	local var_37_0 = arg_37_0.attrUIItemList

	var_2.align(var_37_0, #arg_37_0.typeAttrOrderListTable[arg_37_1])

	return
end

function var_0_1.setAttrTFValue(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = arg_38_1:Find("Attr/Value/CurValue")

	setText = var_1_10004

	var_1_10004(var_38_0, arg_38_2)

	return
end

function var_0_1.openSaveBox(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	pg = var_1_10004

	local var_39_0 = var_1_10004.MsgboxMgr.GetInstance()
	local var_39_1 = var_4.ShowMsgBox
	local var_39_2 = {}

	i18n = var_1_10008
	var_39_2.content = var_1_10008("attrset_ask_save")
	var_39_2.onYes = arg_39_1
	var_39_2.onNo = arg_39_2
	var_39_2.onClose = arg_39_3

	var_39_1(var_39_0, var_39_2)

	return
end

function var_0_1.getAddValueForShow(arg_40_0, arg_40_1, arg_40_2)
	if arg_40_0.cacheAdditionMap[arg_40_1] and arg_40_0.cacheAdditionMap[arg_40_1][arg_40_2] then
		return arg_40_0.cacheAdditionMap[arg_40_1][arg_40_2]
	elseif arg_40_0.curAdditionMap[arg_40_0.curType] and arg_40_0.curAdditionMap[arg_40_0.curType][arg_40_2] then
		return arg_40_0.curAdditionMap[arg_40_1][arg_40_2]
	else
		return arg_40_0.maxAdditionMap[arg_40_1][arg_40_2]
	end

	return
end

function var_0_1.setAttrValue(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
	if not arg_41_0.cacheAdditionMap[arg_41_1] then
		arg_41_0.cacheAdditionMap[arg_41_1] = {}
	end

	arg_41_0.cacheAdditionMap[arg_41_1][arg_41_2] = arg_41_3

	return
end

function var_0_1.clearCacheMap(arg_42_0)
	arg_42_0.cacheAdditionMap = {}

	return
end

function var_0_1.isChanged(arg_43_0)
	pairs = var_1_10001

	for iter_43_0, iter_43_1 in var_1_10001(arg_43_0.cacheAdditionMap) do
		pairs = var_1_10006

		for iter_43_2, iter_43_3 in var_1_10006(iter_43_1) do
			local var_43_0 = iter_43_3
			local var_43_1 = arg_43_0.tecNationProxy

			if var_43_0 ~= var_12.getSetableAttrAdditionValueByTypeAttr(var_43_1, iter_43_0, iter_43_2) then
				return true
			end
		end
	end

	return false
end

function var_0_1.save(arg_44_0, arg_44_1)
	local var_44_0 = {}

	pairs = var_1_10003

	for iter_44_0, iter_44_1 in var_1_10003(arg_44_0.curAdditionMap) do
		if not var_44_0[iter_44_0] then
			var_44_0[iter_44_0] = {}
		end

		pairs = var_8

		for iter_44_2, iter_44_3 in var_8(iter_44_1) do
			var_44_0[iter_44_0][iter_44_2] = iter_44_3
		end
	end

	pairs = var_3

	for iter_44_4, iter_44_5 in var_3(arg_44_0.cacheAdditionMap) do
		if not var_44_0[iter_44_4] then
			var_44_0[iter_44_4] = {}
		end

		pairs = var_8

		for iter_44_6, iter_44_7 in var_8(iter_44_5) do
			var_44_0[iter_44_4][iter_44_6] = iter_44_7
		end
	end

	local var_44_1 = {}

	pairs = var_4

	for iter_44_8, iter_44_9 in var_4(var_44_0) do
		pairs = var_1_10009

		for iter_44_10, iter_44_11 in var_1_10009(iter_44_9) do
			if iter_44_11 ~= arg_44_0.maxAdditionMap[iter_44_8][iter_44_10] then
				local var_44_2 = {
					ship_type = iter_44_8,
					attr_type = iter_44_10,
					set_value = iter_44_11
				}

				table = var_1_10016

				var_1_10016.insert(var_44_1, var_44_2)
			end
		end
	end

	pg = var_4

	local var_44_3 = var_4.m02
	local var_44_4 = var_4.sendNotification

	GAME = iter_44_8

	var_44_4(var_44_3, iter_44_8.SET_TEC_ATTR_ADDITION, {
		sendList = var_44_1,
		onSuccess = arg_44_1
	})

	return
end

function var_0_1.reset(arg_45_0)
	local var_45_0 = {}

	pairs = var_1_10002

	for iter_45_0, iter_45_1 in var_1_10002(arg_45_0.curAdditionMap) do
		if iter_45_0 ~= arg_45_0.curType then
			if not var_45_0[iter_45_0] then
				var_45_0[iter_45_0] = {}
			end

			pairs = var_7

			for iter_45_2, iter_45_3 in var_7(iter_45_1) do
				var_45_0[iter_45_0][iter_45_2] = iter_45_3
			end
		end
	end

	pairs = var_2

	for iter_45_4, iter_45_5 in var_2(arg_45_0.cacheAdditionMap) do
		if iter_45_4 ~= arg_45_0.curType then
			if not var_45_0[iter_45_4] then
				var_45_0[iter_45_4] = {}
			end

			pairs = var_7

			for iter_45_6, iter_45_7 in var_7(iter_45_5) do
				var_45_0[iter_45_4][iter_45_6] = iter_45_7
			end
		end
	end

	local var_45_1 = {}

	pairs = var_3

	for iter_45_8, iter_45_9 in var_3(var_45_0) do
		pairs = var_1_10008

		for iter_45_10, iter_45_11 in var_1_10008(iter_45_9) do
			if iter_45_11 ~= arg_45_0.maxAdditionMap[iter_45_8][iter_45_10] then
				local var_45_2 = {
					ship_type = iter_45_8,
					attr_type = iter_45_10,
					set_value = iter_45_11
				}

				table = var_1_10015

				var_1_10015.insert(var_45_1, var_45_2)
			end
		end
	end

	pg = var_3

	local var_45_3 = var_3.m02
	local var_45_4 = var_3.sendNotification

	GAME = iter_45_8

	var_45_4(var_45_3, iter_45_8.SET_TEC_ATTR_ADDITION, {
		sendList = var_45_1
	})

	return
end

return var_0_1
