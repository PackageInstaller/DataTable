class = var_0_10000

local var_0_0 = "MetaCharacterRepairLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "MetaCharacterRepairUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:initTipText()
	arg_2_0:initData()
	arg_2_0:findUI()

	local var_2_0 = arg_2_0

	arg_2_0.addListener(var_2_0)

	ipairs = var_1
	MetaCharacterConst = var_2_0

	for iter_2_0, iter_2_1 in var_1(var_2_0.REPAIR_ATTRS) do
		local var_2_1 = arg_2_0.curMetaCharacterVO
		local var_2_2 = var_6.getAttrVO(var_2_1, iter_2_1)

		if not var_6.isLock(var_2_2) then
			triggerToggle = var_2_2

			var_2_2(arg_2_0.attrTFList[iter_2_1], true)

			break
		end
	end

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0:doRepairProgressPanelAni()
	arg_3_0:updateAttrListPanel()
	arg_3_0:updateRepairBtn()
	arg_3_0:updateDetailPanel()
	arg_3_0:TryPlayGuide()

	return
end

function var_0_1.willExit(arg_4_0)
	return
end

function var_0_1.onBackPressed(arg_5_0)
	isActive = var_1_10001

	if var_1_10001(arg_5_0.repairEffectBoxPanel) then
		arg_5_0:closeRepairEffectBoxPanel()

		return
	else
		isActive = var_1

		if var_1(arg_5_0.detailPanel) then
			arg_5_0:closeDetailPanel()

			return
		else
			arg_5_0:emit(var_0_1.ON_BACK_PRESSED)
		end
	end

	return
end

function var_0_1.initTipText(arg_6_0)
	local var_6_0 = arg_6_0._tf
	local var_6_1 = var_1.Find(var_6_0, "Repair/AttrListPanel/AttrItemContainer/AttrItemCannon/SelectedPanel/AttrRepairTipText")
	local var_6_2 = arg_6_0._tf
	local var_6_3 = var_2.Find(var_6_2, "Repair/AttrListPanel/AttrItemContainer/AttrItemTorpedo/SelectedPanel/AttrRepairTipText")
	local var_6_4 = arg_6_0._tf
	local var_6_5 = var_3.Find(var_6_4, "Repair/AttrListPanel/AttrItemContainer/AttrItemAir/SelectedPanel/AttrRepairTipText")
	local var_6_6 = arg_6_0._tf
	local var_6_7 = var_4.Find(var_6_6, "Repair/AttrListPanel/AttrItemContainer/AttrItemReload/SelectedPanel/AttrRepairTipText")

	setText = var_6_6

	local var_6_8 = var_6_1

	i18n = var_1_10007

	var_6_6(var_6_8, var_1_10007("meta_repair"))

	setText = var_6_6

	local var_6_9 = var_6_3

	i18n = var_7

	var_6_6(var_6_9, var_7("meta_repair"))

	setText = var_6_6

	local var_6_10 = var_6_5

	i18n = var_7

	var_6_6(var_6_10, var_7("meta_repair"))

	setText = var_6_6

	local var_6_11 = var_6_7

	i18n = var_7

	var_6_6(var_6_11, var_7("meta_repair"))

	return
end

function var_0_1.initData(arg_7_0)
	getProxy = var_1_10001
	MetaCharacterProxy = var_1_10002
	arg_7_0.metaCharacterProxy = var_1_10001(var_1_10002)
	getProxy = var_1
	BayProxy = var_1_10002
	arg_7_0.bayProxy = var_1(var_1_10002)
	arg_7_0.attrTFList = {}
	arg_7_0.curAttrName = nil
	arg_7_0.curMetaShipID = arg_7_0.contextData.shipID
	arg_7_0.curShipVO = nil
	arg_7_0.curMetaCharacterVO = nil

	arg_7_0:updateData()

	return
end

function var_0_1.findUI(arg_8_0)
	local var_8_0 = arg_8_0._tf

	arg_8_0.repairPanel = var_1.Find(var_8_0, "Repair")

	local var_8_1 = arg_8_0.repairPanel

	arg_8_0.attrListPanel = var_1.Find(var_8_1, "AttrListPanel")

	local var_8_2 = arg_8_0.attrListPanel

	arg_8_0.attrItemContainer = var_1.Find(var_8_2, "AttrItemContainer")

	local var_8_3 = arg_8_0.attrItemContainer

	arg_8_0.attrCannonTF = var_1.Find(var_8_3, "AttrItemCannon")

	local var_8_4 = arg_8_0.attrItemContainer

	arg_8_0.attrTorpedoTF = var_1.Find(var_8_4, "AttrItemTorpedo")

	local var_8_5 = arg_8_0.attrItemContainer

	arg_8_0.attrAirTF = var_1.Find(var_8_5, "AttrItemAir")

	local var_8_6 = arg_8_0.attrItemContainer

	arg_8_0.attrReloadTF = var_1.Find(var_8_6, "AttrItemReload")
	arg_8_0.attrTFList.cannon = arg_8_0.attrCannonTF
	arg_8_0.attrTFList.torpedo = arg_8_0.attrTorpedoTF
	arg_8_0.attrTFList.air = arg_8_0.attrAirTF
	arg_8_0.attrTFList.reload = arg_8_0.attrReloadTF

	local var_8_7 = arg_8_0.repairPanel

	arg_8_0.repairPercentText = var_1.Find(var_8_7, "SynProgressPanel/SynRate/NumTextText")

	local var_8_8 = arg_8_0.repairPanel

	arg_8_0.repairSliderTF = var_1.Find(var_8_8, "SynProgressPanel/Slider")

	local var_8_9 = arg_8_0.repairPanel

	arg_8_0.repairBtn = var_1.Find(var_8_9, "RepairBtn")

	local var_8_10 = arg_8_0.repairPanel

	arg_8_0.repairBtnDisable = var_1.Find(var_8_10, "RepairBtnDisable")

	local var_8_11 = arg_8_0._tf

	arg_8_0.showDetailLine = var_1.Find(var_8_11, "ShowDetailLine")

	local var_8_12 = arg_8_0.showDetailLine

	arg_8_0.showDetailBtn = var_1.Find(var_8_12, "ShowDetailBtn")

	local var_8_13 = arg_8_0._tf

	arg_8_0.detailPanel = var_1.Find(var_8_13, "Detail")

	local var_8_14 = arg_8_0.detailPanel

	arg_8_0.detailBG = var_1.Find(var_8_14, "BG")

	local var_8_15 = arg_8_0.detailPanel

	arg_8_0.detailTF = var_1.Find(var_8_15, "Panel")

	local var_8_16 = arg_8_0.detailTF

	arg_8_0.detailCloseBtn = var_1.Find(var_8_16, "CloseBtn")

	local var_8_17 = arg_8_0.detailTF

	arg_8_0.detailLineTpl = var_1.Find(var_8_17, "DetailLineTpl")

	local var_8_18 = arg_8_0.detailTF

	arg_8_0.detailItemTpl = var_1.Find(var_8_18, "DetailItemTpl")

	local var_8_19 = arg_8_0.detailTF

	arg_8_0.detailItemContainer = var_1.Find(var_8_19, "ScrollView/Viewport/Content")

	local var_8_20 = arg_8_0._tf

	arg_8_0.repairEffectBoxPanel = var_1.Find(var_8_20, "RepairEffectBox")

	return
end

function var_0_1.addListener(arg_9_0)
	pairs = var_1_10001

	for iter_9_0, iter_9_1 in var_1_10001(arg_9_0.attrTFList) do
		onToggle = var_1_10006

		local var_9_0 = arg_9_0
		local var_9_1 = iter_9_1

		local function var_9_2(arg_10_0)
			if arg_10_0 == true then
				arg_9_0.curAttrName = iter_9_0

				local var_10_0 = arg_9_0

				var_1.updateRepairBtn(var_10_0)
			else
				arg_9_0.curAttrName = nil

				local var_10_1 = arg_9_0

				var_1.updateRepairBtn(var_10_1, true)
			end

			return
		end

		SFX_PANEL = var_1_10010

		var_1_10006(var_9_0, var_9_1, var_9_2, var_1_10010)
	end

	onButton = var_1

	local var_9_3 = arg_9_0
	local var_9_4 = arg_9_0.repairBtn

	local function var_9_5()
		pg = var_2_10000

		local var_11_0 = var_2_10000.m02
		local var_11_1 = var_0.sendNotification

		GAME = var_2_10002

		var_11_1(var_11_0, var_2_10002.REPAIR_META_CHARACTER, {
			shipID = arg_9_0.curMetaShipID,
			attr = arg_9_0.curAttrName
		})

		return
	end

	SFX_PANEL = iter_9_1

	var_1(var_9_3, var_9_4, var_9_5, iter_9_1)

	onButton = var_1

	local var_9_6 = arg_9_0
	local var_9_7 = arg_9_0.showDetailBtn

	local function var_9_8()
		isActive = var_2_10000

		if not var_2_10000(arg_9_0.detailPanel) then
			local var_12_0 = arg_9_0

			var_0.openDetailPanel(var_12_0)
		end

		return
	end

	SFX_PANEL = iter_9_1

	var_1(var_9_6, var_9_7, var_9_8, iter_9_1)

	onButton = var_1

	local var_9_9 = arg_9_0
	local var_9_10 = arg_9_0.showDetailLine

	local function var_9_11()
		isActive = var_2_10000

		if not var_2_10000(arg_9_0.detailPanel) then
			local var_13_0 = arg_9_0

			var_0.openDetailPanel(var_13_0)
		end

		return
	end

	SFX_PANEL = iter_9_1

	var_1(var_9_9, var_9_10, var_9_11, iter_9_1)

	onButton = var_1

	local var_9_12 = arg_9_0
	local var_9_13 = arg_9_0.detailCloseBtn

	local function var_9_14()
		local var_14_0 = arg_9_0

		var_0.closeDetailPanel(var_14_0)

		return
	end

	SFX_CANCEL = iter_9_1

	var_1(var_9_12, var_9_13, var_9_14, iter_9_1)

	onButton = var_1

	local var_9_15 = arg_9_0
	local var_9_16 = arg_9_0.detailBG

	local function var_9_17()
		local var_15_0 = arg_9_0

		var_0.closeDetailPanel(var_15_0)

		return
	end

	SFX_CANCEL = iter_9_1

	var_1(var_9_15, var_9_16, var_9_17, iter_9_1)

	return
end

function var_0_1.TryPlayGuide(arg_16_0)
	pg = var_1_10001

	local var_16_0 = var_1_10001.SystemGuideMgr.GetInstance()

	var_1.PlayByGuideId(var_16_0, "NG0027")

	return
end

function var_0_1.doRepairProgressPanelAni(arg_17_0)
	local var_17_0 = arg_17_0.curMetaCharacterVO
	local var_17_1 = var_1.getRepairRate(var_17_0)

	GetComponent = var_17_0

	local var_17_2 = arg_17_0.repairSliderTF

	typeof = var_1_10004
	Slider = var_1_10005

	local var_17_3 = var_17_0(var_17_2, var_1_10004(var_1_10005))

	var_17_3.minValue = 0
	var_17_3.maxValue = 1

	local var_17_4 = var_17_3.value

	if var_17_1 > 0 then
		local var_17_5 = 0.5
		local var_17_6 = arg_17_0
		local var_17_7 = arg_17_0.managedTween

		LeanTween = var_1_10007

		local var_17_8 = var_1_10007.value
		local var_17_9

		go = var_1_10009

		local var_17_10 = var_17_7(var_17_6, var_17_8, var_17_9, var_1_10009(arg_17_0.repairSliderTF), var_17_4, var_17_1, var_17_5)
		local var_17_11 = var_5.setOnUpdate

		System = var_17_8

		local var_17_12 = var_17_11(var_17_10, var_17_8.Action_float(function(arg_18_0)
			local var_18_0 = arg_17_0

			var_1.updateRepairProgressPanel(var_18_0, arg_18_0)

			return
		end))
		local var_17_13 = var_5.setOnComplete

		System = var_7

		var_17_13(var_17_12, var_7.Action(function()
			local var_19_0 = arg_17_0

			var_0.updateRepairProgressPanel(var_19_0, var_17_1)

			return
		end))
	else
		arg_17_0:updateRepairProgressPanel(var_17_1)
	end

	return
end

function var_0_1.updateRepairProgressPanel(arg_20_0, arg_20_1)
	local var_20_0

	if not arg_20_1 then
		::label_20_0::

		var_1_10003 = arg_20_0.curMetaCharacterVO
		var_20_0 = var_2.getRepairRate(var_1_10003)
	end

	setSlider = var_1_10003

	var_1_10003(arg_20_0.repairSliderTF, 0, 1, var_20_0)

	setText = var_1_10003

	local var_20_1 = arg_20_0.repairPercentText

	string = var_5

	var_1_10003(var_20_1, var_5.format("%d", var_20_0 * 100))

	return
end

function var_0_1.updateAttrListPanel(arg_21_0)
	ipairs = var_1_10001
	MetaCharacterConst = var_1_10002

	for iter_21_0, iter_21_1 in var_1_10001(var_1_10002.REPAIR_ATTRS) do
		arg_21_0:updateAttrItem(arg_21_0.attrTFList[iter_21_1], iter_21_1)
	end

	return
end

function var_0_1.updateAttrItem(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_1:Find("LockPanel")
	local var_22_1 = arg_22_1:Find("UnSelectPanel")
	local var_22_2 = arg_22_1:Find("SelectedPanel")
	local var_22_3 = var_5.Find(var_22_2, "TitleImg")

	GetComponent = var_22_2

	local var_22_4 = var_22_2(var_22_3, "Image")

	var_7.SetNativeSize(var_22_4)

	local var_22_5 = arg_22_0.curMetaCharacterVO
	local var_22_6 = var_7.getAttrVO(var_22_5, arg_22_2)

	if var_7.isLock(var_22_6) then
		setActive = var_22_6

		var_22_6(var_22_1, false)

		setActive = var_22_6

		var_22_6(var_5, false)

		setActive = var_22_6

		var_22_6(var_22_0, true)

		arg_22_1:GetComponent("Toggle").interactable = false
	else
		local var_22_7 = arg_22_1
		local var_22_8 = arg_22_1.GetComponent(var_22_7, "Toggle")

		setActive = var_22_7

		var_22_7(var_22_1, not var_22_8.isOn)

		setActive = var_22_7

		var_22_7(var_5, var_22_8.isOn)

		setActive = var_22_7

		var_22_7(var_22_0, false)

		var_22_8.interactable = true

		local var_22_9 = var_22_1:Find("ValueText")
		local var_22_10 = var_5:Find("ValueText")
		local var_22_11 = var_5:Find("AttrRepairValue/CurValueText")
		local var_22_12 = var_5:Find("AttrRepairValue/Image")
		local var_22_13 = var_5:Find("AttrRepairValue/NextValueText")
		local var_22_14 = var_5:Find("IconTpl")
		local var_22_15 = var_5:Find("ItemCount")
		local var_22_16 = var_16.Find(var_22_15, "NumText")
		local var_22_17 = var_7
		local var_22_18 = var_7.getAddition(var_22_17)

		setText = var_22_17

		var_22_17(var_22_9, "+" .. var_22_18)

		setText = var_22_17

		var_22_17(var_22_10, "+" .. var_22_18)

		setText = var_22_17

		var_22_17(var_22_11, "+" .. var_22_18)

		local var_22_19 = var_7:getLevel()
		local var_22_20 = var_7:isMaxLevel()
		local var_22_21

		if not var_22_20 then
			var_22_21 = var_7:getItem()
		else
			var_22_21 = var_7:getItemByLevel(var_22_19 - 1)
		end

		local var_22_22 = var_22_21:getItemId()
		local var_22_23 = var_22_21
		local var_22_24 = var_22_21.getTotalCnt(var_22_23)

		getProxy = var_22_23
		BagProxy = var_1_10025

		local var_22_25 = var_22_23(var_1_10025)
		local var_22_27

		if var_24.getItemCountById(var_22_25, var_22_22) < var_22_24 then
			setColorStr = var_22_25

			local var_22_26 = var_22_27

			COLOR_RED = var_1_10027
			var_22_27 = var_22_25(var_22_26, var_1_10027)
		end

		setText = var_22_25

		var_22_25(var_22_16, var_22_27 .. "/" .. var_22_24)

		local var_22_28 = {}

		DROP_TYPE_ITEM = var_22_33
		var_22_28.type = var_22_33
		var_22_28.id = var_22_22
		var_22_28.count = var_22_24
		updateDrop = var_22_33

		var_22_33(var_22_14, var_22_28, {
			hideName = true
		})

		onButton = var_22_33

		local var_22_29 = arg_22_0
		local var_22_30 = var_22_14

		local function var_22_31()
			local var_23_0 = arg_22_0
			local var_23_1 = var_0.emit

			BaseUI = var_2_10002

			var_23_1(var_23_0, var_2_10002.ON_DROP, var_22_28)

			return
		end

		SFX_PANEL = var_1_10030

		var_22_33(var_22_29, var_22_30, var_22_31, var_1_10030)

		setActive = var_22_33

		var_22_33(var_22_12, not var_22_20)

		setActive = var_22_33

		var_22_33(var_22_13, not var_22_20)

		local var_22_33

		if var_22_20 then
			setText = var_22_33

			var_22_33(var_22_13, var_22_18)
		else
			local var_22_32 = var_22_21

			var_22_33 = var_22_21.getAdditionValue(var_22_32)
			setText = var_22_32

			var_22_32(var_22_13, "+" .. var_22_18 + var_22_33)
		end

		if var_22_20 then
			setActive = var_22_33

			var_22_33(var_22_14, false)

			setActive = var_22_33

			var_22_33(var_16, false)
		else
			setActive = var_22_33

			var_22_33(var_22_14, true)

			setActive = var_22_33

			var_22_33(var_16, true)
		end
	end

	return
end

function var_0_1.updateRepairBtn(arg_24_0, arg_24_1)
	if arg_24_1 == true then
		setActive = var_1_10002

		var_1_10002(arg_24_0.repairBtn, false)

		setActive = var_1_10002

		var_1_10002(arg_24_0.repairBtnDisable, false)

		return
	end

	local var_24_0 = arg_24_0.curMetaCharacterVO
	local var_24_1 = var_2.getAttrVO(var_24_0, arg_24_0.curAttrName)
	local var_24_2 = var_2.getLevel(var_24_1)
	local var_24_3 = var_2:isMaxLevel()
	local var_24_4

	if not var_24_3 then
		var_24_4 = var_2:getItem()
	else
		var_24_4 = var_2:getItemByLevel(var_24_2 - 1)
	end

	local var_24_5 = var_24_4:getItemId()
	local var_24_6 = var_24_4
	local var_24_7 = var_24_4.getTotalCnt(var_24_6)

	getProxy = var_24_6
	BagProxy = var_1_10009

	local var_24_8 = var_24_6(var_1_10009)
	local var_24_9 = var_24_7 <= var_8.getItemCountById(var_24_8, var_24_5)

	if var_24_3 then
		setActive = var_10

		var_10(arg_24_0.repairBtn, false)

		setActive = var_10

		var_10(arg_24_0.repairBtnDisable, false)
	elseif not var_24_9 then
		setActive = var_10

		var_10(arg_24_0.repairBtn, false)

		setActive = var_10

		var_10(arg_24_0.repairBtnDisable, true)
	else
		setActive = var_10

		var_10(arg_24_0.repairBtn, true)

		setActive = var_10

		var_10(arg_24_0.repairBtnDisable, false)
	end

	return
end

function var_0_1.updateDetailItem(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_1:Find("LineContainer")
	local var_25_1 = arg_25_1:Find("LockPanel")
	local var_25_2 = var_4.Find(var_25_1, "TipText")
	local var_25_3 = arg_25_2.progress

	setText = var_7

	local var_25_4 = var_25_2

	i18n = var_1_10009

	var_7(var_25_4, var_1_10009("meta_repair_effect_unlock", var_25_3))

	local var_25_5 = arg_25_0.curMetaCharacterVO
	local var_25_6 = var_7.getRepairRate(var_25_5)

	setActive = var_25_5

	var_25_5(var_4, not (var_25_3 <= var_25_6 * 100))

	local var_25_7 = #arg_25_2:getAttrAdditionList() + #arg_25_2:getDescs() + 1

	UIItemList = var_1_10013

	local var_25_8 = var_1_10013.New(var_25_0, arg_25_0.detailLineTpl)

	var_13.make(var_25_8, function(arg_26_0, arg_26_1, arg_26_2)
		local var_26_0 = arg_26_2:Find("AttrLine")
		local var_26_1 = arg_26_2:Find("UnlockTipLine")
		local var_26_2 = arg_26_2
		local var_26_3 = arg_26_2.Find(var_26_2, "Text")

		UIItemList = var_26_2

		if arg_26_0 == var_26_2.EventUpdate then
			if arg_26_1 + 1 == 1 then
				setActive = var_6

				var_6(var_26_0, false)

				setActive = var_6

				var_6(var_26_1, false)

				setActive = var_6

				var_6(var_26_3, true)

				setText = var_6

				local var_26_4 = var_26_3

				i18n = var_8

				var_6(var_26_4, var_8("meta_repair_effect_unlock", var_25_3))

				return
			end

			local var_26_5

			if arg_26_1 <= var_0 + 1 then
				setActive = var_26_5

				var_26_5(var_26_0, true)

				setActive = var_26_5

				var_26_5(var_26_1, false)

				var_26_5 = var_26_0:Find("AttrIcon")

				local var_26_6 = var_26_0:Find("AttrNameText")
				local var_26_7 = var_26_0:Find("NumText")
				local var_26_8 = var_0[arg_26_1 - 1][1]
				local var_26_9 = var_9[2]

				setImageSprite = var_2_10012

				local var_26_10 = var_26_5

				LoadSprite = var_2_10014

				var_2_10012(var_26_10, var_2_10014("attricon", var_26_8))

				setText = var_2_10012

				local var_26_11 = var_26_6

				AttributeType = var_14

				var_2_10012(var_26_11, var_14.Type2Name(var_26_8))

				setText = var_2_10012

				var_2_10012(var_26_7, "+" .. var_26_9)
			else
				setActive = var_26_5

				var_26_5(var_26_0, false)

				setActive = var_26_5

				var_26_5(var_26_1, true)

				local var_26_12 = var_26_1:Find("Text")
				local var_26_13 = var_0[arg_26_1 - 1 - var_0]

				setScrollText = var_8

				var_8(var_26_12, var_26_13)
			end
		end

		return
	end)
	var_13:align(var_25_7)

	return
end

function var_0_1.updateDetailPanel(arg_27_0)
	setActive = var_1_10001

	var_1_10001(arg_27_0.detailPanel, false)

	local var_27_0 = arg_27_0.curMetaCharacterVO
	local var_27_1 = var_1.getEffects(var_27_0)

	UIItemList = var_27_0
	arg_27_0.detailList = var_27_0.New(arg_27_0.detailItemContainer, arg_27_0.detailItemTpl)

	local var_27_2 = arg_27_0.detailList

	var_2.make(var_27_2, function(arg_28_0, arg_28_1, arg_28_2)
		UIItemList = var_2_10003

		if arg_28_0 == var_2_10003.EventUpdate then
			local var_28_0 = var_27_1[arg_28_1 + 1]
			local var_28_1 = arg_27_0

			var_4.updateDetailItem(var_28_1, arg_28_2, var_28_0)
		end

		return
	end)

	local var_27_3 = arg_27_0.detailList

	var_2.align(var_27_3, #var_27_1)

	return
end

function var_0_1.updateData(arg_29_0)
	local var_29_0 = arg_29_0.bayProxy

	arg_29_0.curShipVO = var_1.getShipById(var_29_0, arg_29_0.curMetaShipID)

	local var_29_1 = arg_29_0.curShipVO

	arg_29_0.curMetaCharacterVO = var_1.getMetaCharacter(var_29_1)

	return
end

function var_0_1.checkSpecialEffect(arg_30_0)
	local var_30_0 = arg_30_0.bayProxy
	local var_30_1 = var_1.getShipById(var_30_0, arg_30_0.curMetaShipID)
	local var_30_2 = var_1.getMetaCharacter(var_30_1)
	local var_30_3 = var_2.getRepairRate(var_30_2) * 100
	local var_30_4 = arg_30_0.curMetaCharacterVO
	local var_30_5 = var_4.getRepairRate(var_30_4) * 100
	local var_30_6 = var_2
	local var_30_7 = var_2.getEffects(var_30_6)

	ipairs = var_30_6

	for iter_30_0, iter_30_1 in var_30_6(var_30_7) do
		if var_30_5 < iter_30_1.progress and var_11 <= var_30_3 then
			arg_30_0:openRepairEffectBoxPanel(iter_30_1)

			break
		end
	end

	return
end

function var_0_1.openRepairEffectBoxPanel(arg_31_0, arg_31_1)
	local var_31_0 = #arg_31_1:getAttrAdditionList()
	local var_31_1 = #arg_31_1:getDescs()
	local var_31_2 = 1 + var_31_0 + var_31_1
	local var_31_3 = arg_31_1.progress
	local var_31_4 = arg_31_0.repairEffectBoxPanel
	local var_31_5 = var_8.Find(var_31_4, "BG")
	local var_31_6 = arg_31_0.repairEffectBoxPanel
	local var_31_7 = var_9.Find(var_31_6, "Box/BtnContainer/ConfirmBtn")

	onButton = var_31_6

	local var_31_8 = arg_31_0
	local var_31_9 = var_31_7

	local function var_31_10()
		local var_32_0 = arg_31_0

		var_0.closeRepairEffectBoxPanel(var_32_0)

		return
	end

	SFX_CANCEL = var_1_10014

	var_31_6(var_31_8, var_31_9, var_31_10, var_1_10014)

	local var_31_11 = arg_31_0.repairEffectBoxPanel
	local var_31_12 = var_10.Find(var_31_11, "Box/Panel/TypeRepairEffect")
	local var_31_13 = var_10.Find(var_31_12, "DetailLineTpl")

	UIItemList = var_31_12

	local var_31_14 = var_31_12.New(var_10, var_31_13)

	var_12.make(var_31_14, function(arg_33_0, arg_33_1, arg_33_2)
		local var_33_0 = arg_33_2:Find("AttrLine")
		local var_33_1 = arg_33_2
		local var_33_2 = arg_33_2.Find(var_33_1, "UnlockTipLine")

		UIItemList = var_33_1

		if arg_33_0 == var_33_1.EventUpdate then
			if arg_33_1 + 1 == 1 then
				setActive = var_5

				var_5(var_33_0, false)

				setActive = var_5

				var_5(var_33_2, true)

				local var_33_3 = var_33_2
				local var_33_4

				var_33_4, setScrollText = var_33_2.Find(var_33_3, "Text"), var_33_3
				i18n = var_2_10008

				var_33_3(var_33_4, var_2_10008("meta_repair_effect_special", var_31_3))
			elseif arg_33_1 > 1 and arg_33_1 <= 1 + var_31_0 then
				setActive = var_5

				var_5(var_33_0, true)

				setActive = var_5

				var_5(var_33_2, false)

				local var_33_5 = var_33_0:Find("AttrIcon")
				local var_33_6 = var_33_0:Find("AttrNameText")
				local var_33_7 = var_33_0:Find("NumText")
				local var_33_8 = var_0[arg_33_1 - 1][1]
				local var_33_9 = var_8[2]

				setImageSprite = var_2_10011

				local var_33_10 = var_33_5

				LoadSprite = var_2_10013

				var_2_10011(var_33_10, var_2_10013("attricon", var_33_8))

				setText = var_2_10011

				local var_33_11 = var_33_6

				AttributeType = var_13

				var_2_10011(var_33_11, var_13.Type2Name(var_33_8))

				setText = var_2_10011

				var_2_10011(var_33_7, "+" .. var_33_9)
			elseif arg_33_1 > 1 + var_31_0 and arg_33_1 <= var_31_2 then
				setActive = var_5

				var_5(var_33_0, false)

				setActive = var_5

				var_5(var_33_2, true)

				local var_33_12 = var_33_2:Find("Text")
				local var_33_13 = var_0[arg_33_1 - (1 + var_31_0)]

				setScrollText = var_7

				var_7(var_33_12, var_33_13)
			end
		end

		return
	end)
	var_12:align(var_31_2)

	setActive = var_13

	var_13(arg_31_0.repairEffectBoxPanel, true)

	pg = var_13

	local var_31_15 = var_13.UIMgr.GetInstance()

	var_13.BlurPanel(var_31_15, arg_31_0.repairEffectBoxPanel)

	return
end

function var_0_1.closeRepairEffectBoxPanel(arg_34_0)
	pg = var_1_10001

	local var_34_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_34_0, arg_34_0.repairEffectBoxPanel)

	setActive = var_1

	var_1(arg_34_0.repairEffectBoxPanel, false)

	return
end

function var_0_1.openDetailPanel(arg_35_0)
	setActive = var_1_10001

	var_1_10001(arg_35_0.detailPanel, true)

	pg = var_1_10001

	local var_35_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_35_0, arg_35_0.detailPanel)

	arg_35_0.isOpening = true

	local var_35_1 = arg_35_0
	local var_35_2 = arg_35_0.managedTween

	LeanTween = var_3

	local var_35_3 = var_3.value
	local var_35_4

	go = var_1_10005

	local var_35_5 = var_35_2(var_35_1, var_35_3, var_35_4, var_1_10005(arg_35_0.detailTF), arg_35_0.detailTF.rect.width, 0, 0.3)
	local var_35_6 = var_1.setOnUpdate

	System = var_35_3

	local var_35_7 = var_35_6(var_35_5, var_35_3.Action_float(function(arg_36_0)
		setAnchoredPosition = var_2_10001

		var_2_10001(arg_35_0.detailTF, {
			x = arg_36_0
		})

		return
	end))
	local var_35_8 = var_1.setOnComplete

	System = var_3

	var_35_8(var_35_7, var_3.Action(function()
		arg_35_0.isOpening = nil

		return
	end))

	return
end

function var_0_1.closeDetailPanel(arg_38_0)
	if arg_38_0.isClosing or arg_38_0.isOpening then
		return
	end

	arg_38_0.isClosing = true

	local var_38_0 = arg_38_0
	local var_38_1 = arg_38_0.managedTween

	LeanTween = var_1_10003

	local var_38_2 = var_1_10003.value
	local var_38_3

	go = var_1_10005

	local var_38_4 = var_38_1(var_38_0, var_38_2, var_38_3, var_1_10005(arg_38_0.detailTF), 0, arg_38_0.detailTF.rect.width, 0.3)
	local var_38_5 = var_1.setOnUpdate

	System = var_38_2

	local var_38_6 = var_38_5(var_38_4, var_38_2.Action_float(function(arg_39_0)
		setAnchoredPosition = var_2_10001

		var_2_10001(arg_38_0.detailTF, {
			x = arg_39_0
		})

		return
	end))
	local var_38_7 = var_1.setOnComplete

	System = var_3

	var_38_7(var_38_6, var_3.Action(function()
		local var_40_0 = arg_38_0

		var_40_0.isClosing = nil
		setActive = var_40_0

		var_40_0(arg_38_0.detailPanel, false)

		pg = var_40_0

		local var_40_1 = var_40_0.UIMgr.GetInstance()

		var_0.UnOverlayPanel(var_40_1, arg_38_0.detailPanel)

		return
	end))

	return
end

return var_0_1
