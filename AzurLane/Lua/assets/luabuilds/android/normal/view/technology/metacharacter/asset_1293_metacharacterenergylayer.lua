class = var_0_10000

local var_0_0 = "MetaCharacterEnergyLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseUI"))

pg = var_0_0

local var_0_2 = var_0_0.ship_meta_breakout

function var_0_1.getUIName(arg_1_0)
	return "MetaCharacterEnergyUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:initUITipText()
	arg_2_0:initData()
	arg_2_0:initUI()
	arg_2_0:addListener()

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0:updateShipImg()
	arg_3_0:updateNamePanel()
	arg_3_0:updateChar()
	arg_3_0:updateAttrPanel()
	arg_3_0:updateMaterialPanel()
	arg_3_0:initPreviewPanel()
	arg_3_0:enablePartialBlur()

	if arg_3_0.contextData.isMainOpen then
		arg_3_0.contextData.isMainOpen = nil

		arg_3_0:moveShipImg(true)
	end

	arg_3_0:moveRightPanel()
	arg_3_0:TryPlayGuide()

	return
end

function var_0_1.willExit(arg_4_0)
	arg_4_0:moveShipImg(false)
	arg_4_0:recycleChar()

	if arg_4_0.previewer then
		local var_4_0 = arg_4_0.previewer

		var_1.clear(var_4_0)

		arg_4_0.previewer = nil
	end

	arg_4_0:disablePartialBlur()

	return
end

function var_0_1.onBackPressed(arg_5_0)
	isActive = var_1_10001

	if var_1_10001(arg_5_0.previewTF) then
		arg_5_0:closePreviewPanel()

		return
	else
		arg_5_0:emit(var_0_1.ON_BACK_PRESSED)
	end

	return
end

function var_0_1.initUITipText(arg_6_0)
	local var_6_0 = arg_6_0._tf
	local var_6_1 = var_1.Find(var_6_0, "Preview/FinalAttrPanel/TitleText")
	local var_6_2 = arg_6_0._tf
	local var_6_3 = var_2.Find(var_6_2, "Preview/FinalAttrPanel/TipText")
	local var_6_4 = arg_6_0._tf
	local var_6_5 = var_3.Find(var_6_4, "RightPanel/MaterialPanel/StarMax/Text")
	local var_6_6 = arg_6_0._tf
	local var_6_7 = var_4.Find(var_6_6, "RightPanel/MaterialPanel/TipText")

	setText = var_6_6

	local var_6_8 = var_6_1

	i18n = var_1_10007

	var_6_6(var_6_8, var_1_10007("meta_energy_preview_title"))

	setText = var_6_6

	local var_6_9 = var_6_3

	i18n = var_7

	var_6_6(var_6_9, var_7("meta_energy_preview_tip"))

	setText = var_6_6

	local var_6_10 = var_6_5

	i18n = var_7

	var_6_6(var_6_10, var_7("word_level_upperLimit"))

	setText = var_6_6

	local var_6_11 = var_6_7

	i18n = var_7

	var_6_6(var_6_11, var_7("meta_break"))

	return
end

function var_0_1.initData(arg_7_0)
	arg_7_0.shipPrefab = nil
	arg_7_0.shipModel = nil
	getProxy = var_1
	MetaCharacterProxy = var_1_10002
	arg_7_0.metaCharacterProxy = var_1(var_1_10002)
	getProxy = var_1
	BayProxy = var_1_10002
	arg_7_0.bayProxy = var_1(var_1_10002)
	arg_7_0.curMetaShipID = arg_7_0.contextData.shipID
	arg_7_0.curShipVO = nil
	arg_7_0.curMetaCharacterVO = nil

	arg_7_0:updateData()

	return
end

function var_0_1.initUI(arg_8_0)
	local var_8_0 = arg_8_0._tf

	arg_8_0.shipImg = var_1.Find(var_8_0, "ShipImg")

	local var_8_1 = arg_8_0._tf

	arg_8_0.nameTF = var_1.Find(var_8_1, "NamePanel")

	local var_8_2 = arg_8_0.nameTF

	arg_8_0.nameScrollText = var_1.Find(var_8_2, "NameMask/NameText")

	local var_8_3 = arg_8_0.nameTF

	arg_8_0.shipTypeImg = var_1.Find(var_8_3, "TypeImg")

	local var_8_4 = arg_8_0.nameTF

	arg_8_0.enNameText = var_1.Find(var_8_4, "NameENText")

	local var_8_5 = arg_8_0.nameTF
	local var_8_6 = var_1.Find(var_8_5, "StarTpl")
	local var_8_7 = arg_8_0.nameTF
	local var_8_8 = var_2.Find(var_8_7, "StarContainer")

	UIItemList = var_8_7
	arg_8_0.nameTFStarUIList = var_8_7.New(var_8_8, var_8_6)

	local var_8_9 = arg_8_0._tf

	arg_8_0.previewBtn = var_3.Find(var_8_9, "PreviewBtn")

	local var_8_10 = arg_8_0._tf

	arg_8_0.rightPanel = var_3.Find(var_8_10, "RightPanel")

	local var_8_11 = arg_8_0.rightPanel

	arg_8_0.qCharContain = var_3.Find(var_8_11, "DetailPanel/QChar")

	local var_8_12 = arg_8_0.rightPanel

	arg_8_0.starTpl = var_3.Find(var_8_12, "DetailPanel/RarePanel/StarTpl")
	setActive = var_3

	var_3(arg_8_0.starTpl, false)

	local var_8_13 = arg_8_0.rightPanel

	arg_8_0.starsFrom = var_3.Find(var_8_13, "DetailPanel/RarePanel/StarsFrom")

	local var_8_14 = arg_8_0.rightPanel

	arg_8_0.starsTo = var_3.Find(var_8_14, "DetailPanel/RarePanel/StarsTo")

	local var_8_15 = arg_8_0.rightPanel

	arg_8_0.starOpera = var_3.Find(var_8_15, "DetailPanel/RarePanel/OpImg")
	UIItemList = var_3
	arg_8_0.starFromList = var_3.New(arg_8_0.starsFrom, arg_8_0.starTpl)
	UIItemList = var_3
	arg_8_0.starToList = var_3.New(arg_8_0.starsTo, arg_8_0.starTpl)

	local var_8_16 = arg_8_0.rightPanel

	arg_8_0.attrTpl = var_3.Find(var_8_16, "DetailPanel/AttrTpl")
	setActive = var_3

	var_3(arg_8_0.attrTpl, false)

	local var_8_17 = arg_8_0.rightPanel

	arg_8_0.attrsContainer = var_3.Find(var_8_17, "DetailPanel/AttrsContainer")
	UIItemList = var_3
	arg_8_0.attrsList = var_3.New(arg_8_0.attrsContainer, arg_8_0.attrTpl)

	local var_8_18 = arg_8_0.rightPanel

	arg_8_0.materialPanel = var_3.Find(var_8_18, "MaterialPanel")

	local var_8_19 = arg_8_0.materialPanel

	arg_8_0.levelNumText = var_3.Find(var_8_19, "Info/LevelTipText")

	local var_8_20 = arg_8_0.materialPanel

	arg_8_0.infoTF = var_3.Find(var_8_20, "Info")

	local var_8_21 = arg_8_0.materialPanel

	arg_8_0.repairRateText = var_3.Find(var_8_21, "Info/ProgressTipText")

	local var_8_22 = arg_8_0.materialPanel

	arg_8_0.materialTF = var_3.Find(var_8_22, "Info/Material")

	local var_8_23 = arg_8_0.materialPanel

	arg_8_0.breakOutTipImg = var_3.Find(var_8_23, "TipText")

	local var_8_24 = arg_8_0.materialPanel

	arg_8_0.goldTF = var_3.Find(var_8_24, "Gold")

	local var_8_25 = arg_8_0.goldTF

	arg_8_0.goldNumText = var_3.Find(var_8_25, "NumText")

	local var_8_26 = arg_8_0.materialPanel

	arg_8_0.starMaxTF = var_3.Find(var_8_26, "StarMax")

	local var_8_27 = arg_8_0.materialPanel

	arg_8_0.activeBtn = var_3.Find(var_8_27, "ActiveBtn")

	local var_8_28 = arg_8_0.materialPanel

	arg_8_0.activeBtnDisable = var_3.Find(var_8_28, "ActiveBtnDisable")

	local var_8_29 = arg_8_0._tf

	arg_8_0.previewTF = var_3.Find(var_8_29, "Preview")

	local var_8_30 = arg_8_0.previewTF

	arg_8_0.previewBG = var_3.Find(var_8_30, "BG")

	local var_8_31 = arg_8_0.previewTF

	arg_8_0.previewPanel = var_3.Find(var_8_31, "PreviewPanel")

	local var_8_32 = arg_8_0.previewPanel

	arg_8_0.stages = var_3.Find(var_8_32, "StageScrollRect/Stages")

	local var_8_33 = arg_8_0.previewPanel
	local var_8_34 = var_3.Find(var_8_33, "StageScrollRect")

	arg_8_0.stagesSnap = var_3.GetComponent(var_8_34, "HorizontalScrollSnap")

	local var_8_35 = arg_8_0.previewPanel

	arg_8_0.breakView = var_3.Find(var_8_35, "Content/Text")

	local var_8_36 = arg_8_0.previewPanel

	arg_8_0.sea = var_3.Find(var_8_36, "Sea")

	local var_8_37 = arg_8_0.sea

	arg_8_0.rawImage = var_3.GetComponent(var_8_37, "RawImage")
	setActive = var_3

	var_3(arg_8_0.rawImage, false)

	local var_8_38 = arg_8_0._tf

	arg_8_0.healTF = var_3.Find(var_8_38, "Resources/Heal")

	local var_8_39 = arg_8_0.healTF.transform

	Vector3 = var_8_38
	var_8_39.localPosition = var_8_38(-360, 50, 40)
	setActive = var_8_39

	var_8_39(arg_8_0.healTF, false)

	local var_8_40 = arg_8_0.previewPanel

	arg_8_0.seaLoading = var_3.Find(var_8_40, "BG/Loading")

	local var_8_41 = arg_8_0.previewTF

	arg_8_0.previewAttrTpl = var_3.Find(var_8_41, "FinalAttrPanel/AttrTpl")

	local var_8_42 = arg_8_0.previewTF

	arg_8_0.previewAttrContainer = var_3.Find(var_8_42, "FinalAttrPanel/AttrsContainer")
	UIItemList = var_3
	arg_8_0.previewAttrUIItemList = var_3.New(arg_8_0.previewAttrContainer, arg_8_0.previewAttrTpl)

	return
end

function var_0_1.addListener(arg_9_0)
	onButton = var_1_10001

	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.previewBtn

	local function var_9_2()
		local var_10_0 = arg_9_0

		var_0.openPreviewPanel(var_10_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_9_0, var_9_1, var_9_2, var_1_10005)

	onButton = var_1_10001

	local var_9_3 = arg_9_0
	local var_9_4 = arg_9_0.previewBG

	local function var_9_5()
		local var_11_0 = arg_9_0

		var_0.closePreviewPanel(var_11_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_9_3, var_9_4, var_9_5, var_1_10005)

	onButton = var_1_10001

	local var_9_6 = arg_9_0
	local var_9_7 = arg_9_0.activeBtn

	local function var_9_8()
		pg = var_2_10000

		local var_12_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_12_1 = var_0.ShowMsgBox
		local var_12_2 = {}

		i18n = var_2_10003
		var_12_2.content = var_2_10003("meta_energy_active_box_tip")

		function var_12_2.onYes()
			pg = var_3_10000

			local var_13_0 = var_3_10000.m02
			local var_13_1 = var_0.sendNotification

			GAME = var_3_10002

			var_13_1(var_13_0, var_3_10002.ENERGY_META_ACTIVATION, {
				shipId = arg_9_0.curMetaShipID
			})

			return
		end

		var_12_1(var_12_0, var_12_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_9_6, var_9_7, var_9_8, var_1_10005)

	return
end

function var_0_1.updateData(arg_14_0)
	local var_14_0 = arg_14_0.bayProxy

	arg_14_0.curShipVO = var_1.getShipById(var_14_0, arg_14_0.curMetaShipID)

	local var_14_1 = arg_14_0.curShipVO

	arg_14_0.curMetaCharacterVO = var_1.getMetaCharacter(var_14_1)

	return
end

function var_0_1.TryPlayGuide(arg_15_0)
	pg = var_1_10001

	local var_15_0 = var_1_10001.SystemGuideMgr.GetInstance()

	var_1.PlayByGuideId(var_15_0, "NG0026")

	return
end

function var_0_1.updateShipImg(arg_16_0)
	MetaCharacterConst = var_1_10001

	local var_16_0, var_16_1 = var_1_10001.GetMetaCharacterPaintPath(arg_16_0.curMetaCharacterVO.id, true)

	setImageSprite = var_3

	local var_16_2 = arg_16_0.shipImg

	LoadSprite = var_1_10005

	var_3(var_16_2, var_1_10005(var_16_0, var_16_1), true)

	local var_16_3 = arg_16_0.curMetaCharacterVO.id

	MetaCharacterConst = var_16_2

	local var_16_4 = var_16_2.UIConfig[var_16_3]

	setLocalPosition = var_5

	var_5(arg_16_0.shipImg, {
		x = var_16_4[5],
		y = var_16_4[6]
	})

	setLocalScale = var_5

	var_5(arg_16_0.shipImg, {
		x = var_16_4[3],
		y = var_16_4[4]
	})

	return
end

function var_0_1.updateNamePanel(arg_17_0)
	local var_17_0 = arg_17_0.curShipVO
	local var_17_1 = arg_17_0.curMetaCharacterVO
	local var_17_2 = var_17_0
	local var_17_3 = var_17_0.getName(var_17_2)

	setScrollText = var_17_2

	var_17_2(arg_17_0.nameScrollText, var_17_3)

	local var_17_4 = var_17_0
	local var_17_5 = var_17_0.getShipType(var_17_4)

	setImageSprite = var_17_4

	local var_17_6 = arg_17_0.shipTypeImg

	LoadSprite = var_1_10007

	var_17_4(var_17_6, var_1_10007("shiptype", var_17_5))

	local var_17_7 = var_17_0
	local var_17_8 = var_17_0.getConfig(var_17_7, "english_name")

	setText = var_17_7

	var_17_7(arg_17_0.enNameText, var_17_8)

	local var_17_9 = var_17_0:getMaxStar()
	local var_17_10 = var_17_0:getStar()
	local var_17_11 = arg_17_0.nameTFStarUIList

	var_8.make(var_17_11, function(arg_18_0, arg_18_1, arg_18_2)
		UIItemList = var_2_10003

		if arg_18_0 == var_2_10003.EventUpdate then
			local var_18_0 = arg_18_2:Find("empty")
			local var_18_1 = arg_18_2
			local var_18_2 = arg_18_2.Find(var_18_1, "on")

			arg_18_1 = arg_18_1 + 1
			setActive = var_18_1

			var_18_1(var_18_2, arg_18_1 <= var_17_10)
		end

		return
	end)

	local var_17_12 = arg_17_0.nameTFStarUIList

	var_8.align(var_17_12, var_17_9)

	return
end

function var_0_1.updateChar(arg_19_0)
	return
end

function var_0_1.recycleChar(arg_20_0)
	if arg_20_0.shipPrefab and arg_20_0.shipModel then
		PoolMgr = var_1

		local var_20_0 = var_1.GetInstance()

		var_1.ReturnSpineChar(var_20_0, arg_20_0.shipPrefab, arg_20_0.shipModel)

		arg_20_0.shipPrefab = nil
		arg_20_0.shipModel = nil
	end

	return
end

function var_0_1.updateAttrPanel(arg_21_0)
	local var_21_0 = arg_21_0.curShipVO
	local var_21_1 = arg_21_0.curMetaCharacterVO
	local var_21_2 = var_2.getBreakOutInfo(var_21_1)

	local function var_21_3(arg_22_0, arg_22_1)
		local var_22_0 = var_21_2
		local var_22_1 = var_2.getNextInfo(var_22_0)

		Clone = var_22_0

		local var_22_2 = var_22_0(var_21_0)

		var_22_2.configId = var_22_1.id
		MetaCharacterConst = var_4

		local var_22_3 = var_4.ENERGY_ATTRS[arg_22_0 + 1]
		local var_22_4 = 0
		local var_22_5 = 0

		AttributeType = var_2_10007

		local var_22_7

		if var_2_10007.Expend ~= var_22_3 then
			local var_22_6 = var_21_0

			var_22_7 = var_22_7.getShipProperties(var_22_6)

			local var_22_8 = var_22_2
			local var_22_9 = var_22_2.getShipProperties(var_22_8)

			math = var_22_8
			var_22_4 = var_22_8.floor(var_22_7[var_22_3])
			math = var_9
			var_22_5 = var_9.floor(var_22_9[var_22_3])
		else
			math = var_22_7
			var_22_7 = var_22_7.floor

			local var_22_10 = var_21_0

			var_22_4 = var_22_7(var_8.getBattleTotalExpend(var_22_10))
			math = var_22_7
			var_22_5 = var_22_7.floor(var_22_2:getBattleTotalExpend())
		end

		setText = var_22_7

		local var_22_11 = arg_22_1
		local var_22_12 = arg_22_1.Find(var_22_11, "NameText")

		AttributeType = var_22_11

		var_22_7(var_22_12, var_22_11.Type2Name(var_22_3))

		setText = var_22_7

		var_22_7(arg_22_1:Find("CurValueText"), var_22_4)

		setActive = var_22_7

		var_22_7(arg_22_1:Find("AddValueText"), true)

		setText = var_22_7

		var_22_7(arg_22_1:Find("AddValueText"), "+" .. var_22_5 - var_22_4)

		setText = var_22_7

		var_22_7(arg_22_1:Find("NextValueText"), var_22_5)

		local var_22_13 = arg_21_0.starFromList
		local var_22_14 = var_7.align
		local var_22_15 = var_21_0

		var_22_14(var_22_13, var_9.getStar(var_22_15))

		local var_22_16 = arg_21_0.starToList

		var_7.align(var_22_16, var_22_2:getStar())

		return
	end

	local function var_21_4(arg_23_0, arg_23_1)
		local var_23_0 = var_21_0
		local var_23_1 = var_2.getShipProperties(var_23_0)

		MetaCharacterConst = var_23_0

		local var_23_2 = var_23_0.ENERGY_ATTRS[arg_23_0 + 1]
		local var_23_3 = 0

		AttributeType = var_2_10005

		local var_23_5

		if var_2_10005.Expend ~= var_23_2 then
			local var_23_4 = var_21_0

			var_23_5 = var_23_5.getShipProperties(var_23_4)
			math = var_23_4
			var_23_3 = var_23_4.floor(var_23_5[var_23_2])
		else
			math = var_23_5
			var_23_5 = var_23_5.floor

			local var_23_6 = var_21_0

			var_23_3 = var_23_5(var_6.getBattleTotalExpend(var_23_6))
		end

		setText = var_23_5

		local var_23_7 = arg_23_1
		local var_23_8 = arg_23_1.Find(var_23_7, "NameText")

		AttributeType = var_23_7

		var_23_5(var_23_8, var_23_7.Type2Name(var_23_2))

		setText = var_23_5

		var_23_5(arg_23_1:Find("CurValueText"), var_23_3)

		setText = var_23_5

		local var_23_9 = arg_23_1
		local var_23_10 = arg_23_1.Find(var_23_9, "NextValueText")

		setColorStr = var_23_9

		local var_23_11 = var_23_3

		COLOR_GREEN = var_2_10009

		var_23_5(var_23_10, var_23_9(var_23_11, var_2_10009))

		setText = var_23_5

		var_23_5(arg_23_1:Find("AddValueText"), "+0")

		setActive = var_23_5

		var_23_5(arg_23_1:Find("AddValueText"), false)

		local var_23_12 = arg_21_0.starFromList
		local var_23_13 = var_5.align
		local var_23_14 = var_21_0

		var_23_13(var_23_12, var_7.getStar(var_23_14))

		local var_23_15 = arg_21_0.starToList

		var_5.align(var_23_15, 0)

		return
	end

	local var_21_5 = arg_21_0.attrsList

	var_6.make(var_21_5, function(arg_24_0, arg_24_1, arg_24_2)
		UIItemList = var_2_10003

		if arg_24_0 == var_2_10003.EventUpdate then
			local var_24_0 = var_21_2

			if var_3.hasNextInfo(var_24_0) then
				var_21_3(arg_24_1, arg_24_2)

				setActive = var_3

				var_3(arg_21_0.starOpera, true)
			else
				var_21_4(arg_24_1, arg_24_2)

				setActive = var_3

				var_3(arg_21_0.starOpera, false)
			end
		end

		return
	end)

	local var_21_6 = arg_21_0.attrsList
	local var_21_7 = var_6.align

	MetaCharacterConst = var_8

	var_21_7(var_21_6, #var_8.ENERGY_ATTRS)

	return
end

function var_0_1.updateMaterialPanel(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0.curShipVO
	local var_25_1 = arg_25_0.curMetaCharacterVO
	local var_25_2 = var_3.getBreakOutInfo(var_25_1)

	getProxy = var_25_1
	BagProxy = var_1_10006

	local var_25_3 = var_25_1(var_1_10006)

	if not var_25_2:hasNextInfo() then
		setActive = var_6

		var_6(arg_25_0.infoTF, false)

		setActive = var_6

		var_6(arg_25_0.breakOutTipImg, false)

		setActive = var_6

		var_6(arg_25_0.goldTF, false)

		setActive = var_6

		var_6(arg_25_0.starMaxTF, true)

		setActive = var_6

		var_6(arg_25_0.activeBtn, false)

		setActive = var_6

		var_6(arg_25_0.activeBtnDisable, true)

		return
	else
		setActive = var_6

		var_6(arg_25_0.infoTF, true)

		setActive = var_6

		var_6(arg_25_0.breakOutTipImg, true)

		setActive = var_6

		var_6(arg_25_0.goldTF, true)

		setActive = var_6

		var_6(arg_25_0.starMaxTF, false)

		setActive = var_6

		var_6(arg_25_0.activeBtn, true)

		setActive = var_6

		var_6(arg_25_0.activeBtnDisable, false)
	end

	local var_25_4 = true
	local var_25_5
	local var_25_6
	local var_25_7, var_25_8 = var_25_2:getConsume()
	local var_25_9
	local var_25_10
	local var_25_11
	local var_25_12 = var_25_8[1].itemId
	local var_25_13 = var_25_8[1].count
	local var_25_14 = var_25_3:getItemCountById(var_25_12)
	local var_25_15 = arg_25_0.materialTF
	local var_25_16 = var_12.Find(var_25_15, "Item")
	local var_25_17 = var_12.Find(var_25_16, "icon_bg/count")
	local var_25_18 = {}

	DROP_TYPE_ITEM = var_15
	var_25_18.type = var_15
	var_25_18.id = var_25_12
	var_25_18.count = var_25_14
	updateDrop = var_15

	var_15(var_12, var_25_18, {
		hideName = true
	})

	onButton = var_15

	local var_25_19 = arg_25_0
	local var_25_20 = var_12

	local function var_25_21()
		local var_26_0 = arg_25_0
		local var_26_1 = var_0.emit

		BaseUI = var_2_10002

		var_26_1(var_26_0, var_2_10002.ON_DROP, var_25_18)

		return
	end

	SFX_PANEL = var_1_10019

	var_15(var_25_19, var_25_20, var_25_21, var_1_10019)

	setText = var_15

	local var_25_22 = var_25_17

	setColorStr = var_25_20

	local var_25_23 = var_25_14

	if var_25_14 < var_25_13 then
		COLOR_RED = var_1_10019

		if not var_1_10019 then
			COLOR_GREEN = var_1_10019
		end

		var_15(var_25_22, var_25_20(var_25_23, var_1_10019) .. "/" .. var_25_13)

		if var_25_14 < var_25_13 then
			var_25_4 = false
		end

		getProxy = var_15
		PlayerProxy = var_25_22

		local var_25_24 = var_15(var_25_22)
		local var_25_25 = var_15.getData(var_25_24).gold

		setText = var_25_24

		local var_25_26 = arg_25_0.goldNumText

		if var_25_25 < var_25_7 then
			setColorStr = var_18

			local var_25_27 = var_25_7

			COLOR_RED = var_1_10020

			local var_25_28

			if not var_18(var_25_27, var_1_10020) then
				var_25_28 = var_25_7
			end

			var_25_24(var_25_26, var_25_28)

			if var_25_25 < var_25_7 then
				var_25_4 = false
				onButton = var_25_24

				local var_25_29 = arg_25_0
				local var_25_30 = arg_25_0.activeBtnDisable

				local function var_25_31()
					Item = var_2_10000

					local var_27_0 = var_2_10000.getConfigData(59001).name

					i18n = var_1

					local var_27_1 = "switch_to_shop_tip_2"

					i18n = var_2_10003

					local var_27_2 = var_1(var_27_1, var_2_10003("word_gold"))

					i18n = var_27_1

					local var_27_3 = var_27_1("text_noRes_info_tip", var_27_0, var_25_7 - var_25_25)
					local var_27_4 = var_27_2
					local var_27_5 = "\n"

					i18n = var_5

					local var_27_6 = var_27_4 .. var_27_5 .. var_5("text_noRes_tip", var_27_3)

					pg = var_27_4

					local var_27_7 = var_27_4.MsgboxMgr.GetInstance()

					var_3.ShowMsgBox(var_27_7, {
						content = var_27_6,
						onYes = function()
							getProxy = var_3_10000
							ContextProxy = var_3_10001

							local var_28_0 = var_3_10000(var_3_10001)
							local var_28_1 = var_0.getCurrentContext(var_28_0)
							local var_28_2 = var_1.getContextByMediator

							MetaCharacterMediator = var_3_10004

							if var_28_2(var_28_1, var_3_10004) then
								var_2.data.autoOpenShipConfigID = arg_25_0.curShipVO.configId
								var_2.data.autoOpenEnergy = true
							end

							local var_28_3 = arg_25_0

							var_3.closeView(var_28_3)

							gotoChargeScene = var_3
							ChargeScene = var_28_3

							var_3(var_28_3.TYPE_ITEM)

							return
						end
					})

					return
				end

				SFX_PANEL = var_1_10020

				var_25_24(var_25_29, var_25_30, var_25_31, var_1_10020)
			end

			local var_25_32 = arg_25_0.levelNumText
			local var_25_33 = arg_25_0.repairRateText
			local var_25_34
			local var_25_35
			local var_25_36, var_25_37 = var_25_2:getLimited()
			local var_25_38 = var_25_0.level

			if var_25_0.level < var_25_36 then
				setColorStr = var_21

				local var_25_39 = var_25_38

				COLOR_RED = var_1_10023

				if not var_21(var_25_39, var_1_10023) then
					::label_25_0::

					setColorStr = var_21

					local var_25_40 = var_25_38

					COLOR_GREEN = var_1_10023
					var_25_38 = var_21(var_25_40, var_1_10023)
				end

				setText = var_21

				local var_25_41 = var_25_32

				i18n = var_1_10023

				var_21(var_25_41, var_1_10023("meta_energy_ship_level_need", var_25_38, var_25_36))

				local var_25_42 = var_3:getRepairRate() * 100 .. "%%"

				if var_3:getRepairRate() < var_25_37 / 100 then
					setColorStr = var_22

					local var_25_43 = var_25_42

					COLOR_RED = var_24

					if not var_22(var_25_43, var_24) then
						::label_25_1::

						setColorStr = var_22

						local var_25_44 = var_25_42

						COLOR_GREEN = var_24
						var_25_42 = var_22(var_25_44, var_24)
					end

					setText = var_22

					local var_25_45 = var_25_33

					i18n = var_24

					var_22(var_25_45, var_24("meta_energy_ship_repairrate_need", var_25_42, var_25_37 .. "%%"))

					if var_25_36 > var_25_0.level then
						var_25_4 = false
					end

					if var_3:getRepairRate() < var_25_37 / 100 then
						var_25_4 = false
					end

					setActive = var_22

					var_22(arg_25_0.activeBtn, var_25_4)

					setActive = var_22

					var_22(arg_25_0.activeBtnDisable, not var_25_4)

					return
				end
			end
		end
	end
end

function var_0_1.moveShipImg(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0.curMetaCharacterVO.id

	MetaCharacterConst = var_1_10003

	local var_29_1 = var_1_10003.UIConfig[var_29_0]
	local var_29_2 = arg_29_1 and -2000 or var_29_1[5]
	local var_29_3

	if not arg_29_1 or not var_29_1[5] then
		var_29_3 = -2000
	end

	local var_29_4 = arg_29_0
	local var_29_5 = arg_29_0.managedTween

	LeanTween = var_1_10008

	local var_29_6 = var_1_10008.moveX
	local var_29_7

	rtf = var_1_10010

	local var_29_8 = var_29_5(var_29_4, var_29_6, var_29_7, var_1_10010(arg_29_0.shipImg), var_29_3, 0.2)

	var_6.setFrom(var_29_8, var_29_2)

	return
end

function var_0_1.moveRightPanel(arg_30_0)
	local var_30_0 = 2000
	local var_30_1 = 577.64
	local var_30_2 = arg_30_0
	local var_30_3 = arg_30_0.managedTween

	LeanTween = var_1_10005

	local var_30_4 = var_1_10005.moveX
	local var_30_5

	rtf = var_1_10007

	local var_30_6 = var_30_3(var_30_2, var_30_4, var_30_5, var_1_10007(arg_30_0.rightPanel), var_30_1, 0.2)

	var_3.setFrom(var_30_6, var_30_0)

	return
end

function var_0_1.updatePreviewAttrListPanel(arg_31_0)
	local var_31_0 = arg_31_0.curShipVO
	local var_31_1 = arg_31_0.curMetaCharacterVO
	local var_31_2 = {}

	AttributeType = var_1_10004
	var_31_2[1] = var_1_10004.Durability
	AttributeType = var_4
	var_31_2[2] = var_4.Cannon
	AttributeType = var_4
	var_31_2[3] = var_4.Torpedo
	AttributeType = var_4
	var_31_2[4] = var_4.AntiAircraft
	AttributeType = var_4
	var_31_2[5] = var_4.Air
	AttributeType = var_4
	var_31_2[6] = var_4.Reload
	AttributeType = var_4
	var_31_2[7] = var_4.ArmorType
	AttributeType = var_4
	var_31_2[8] = var_4.Dodge
	Clone = var_4

	local var_31_3 = var_4(var_31_0)

	var_31_3.level = 125

	local var_31_4 = var_31_3
	local var_31_5 = var_31_3.getMetaCharacter(var_31_4)

	intProperties = var_31_4

	local var_31_6 = var_31_4(var_31_5:getFinalAddition(var_31_3))
	local var_31_7 = arg_31_0.previewAttrUIItemList

	var_7.make(var_31_7, function(arg_32_0, arg_32_1, arg_32_2)
		UIItemList = var_2_10003

		if arg_32_0 == var_2_10003.EventUpdate then
			local var_32_0 = arg_32_2:Find("AttrIcon")
			local var_32_1 = arg_32_2:Find("NameText")
			local var_32_2 = arg_32_2:Find("AddValueText")
			local var_32_3 = var_31_2[arg_32_1 + 1]

			setImageSprite = var_7

			local var_32_4 = var_32_0

			LoadSprite = var_2_10009

			var_7(var_32_4, var_2_10009("attricon", var_32_3))

			setText = var_7

			local var_32_5 = var_32_1

			AttributeType = var_9

			var_7(var_32_5, var_9.Type2Name(var_32_3))

			AttributeType = var_7

			if var_32_3 == var_7.ArmorType then
				setText = var_7

				local var_32_6 = var_32_2
				local var_32_7 = var_31_3

				var_7(var_32_6, var_9.getShipArmorName(var_32_7))
			else
				setText = var_7

				local var_32_8 = var_32_2
				local var_32_9

				if not var_31_6[var_32_3] then
					var_32_9 = 0
				end

				var_7(var_32_8, var_32_9)
			end
		end

		return
	end)

	local var_31_8 = arg_31_0.previewAttrUIItemList

	var_7.align(var_31_8, #var_31_2)

	return
end

function var_0_1.initPreviewPanel(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0.curShipVO
	local var_33_1 = arg_33_0.curMetaCharacterVO

	arg_33_0.breakIds = arg_33_0:getAllBreakIDs(var_33_1.id)

	for iter_33_0 = 1, 3 do
		local var_33_2 = arg_33_0.breakIds[iter_33_0]
		local var_33_3 = var_0_2[var_33_2]
		local var_33_4 = arg_33_0.stages
		local var_33_5 = var_10.Find(var_33_4, "Stage" .. iter_33_0)

		onToggle = var_33_4

		local var_33_6 = arg_33_0
		local var_33_7 = var_33_5

		local function var_33_8(arg_34_0)
			if arg_34_0 then
				local var_34_0 = var_33_3.breakout_view

				checkExist = var_2_10002
				pg = var_2_10003

				local var_34_1

				if not var_2_10002(var_2_10003.ship_data_template[var_33_3.breakout_id], {
					"specific_type"
				}) then
					var_34_1 = {}
				end

				ipairs = var_3

				for iter_34_0, iter_34_1 in var_3(var_34_1) do
					local var_34_2 = var_34_0
					local var_34_3 = "/"

					i18n = var_2_10010
					ShipType = var_2_10011
					var_34_0 = var_34_2 .. var_34_3 .. var_2_10010(var_2_10011.SpecificTableTips[iter_34_1])
				end

				changeToScrollText = var_3

				var_3(arg_33_0.breakView, var_34_0)

				local var_34_4 = arg_33_0

				var_3.switchStage(var_34_4, var_33_2)
			end

			return
		end

		SFX_PANEL = var_1_10015

		var_33_4(var_33_6, var_33_7, var_33_8, var_1_10015)

		if iter_33_0 == 1 then
			triggerToggle = var_33_4

			var_33_4(var_33_5, true)
		end
	end

	onButton = var_4

	var_4(arg_33_0, arg_33_0.seaLoading, function()
		if not arg_33_0.previewer then
			local var_35_0 = arg_33_0

			var_0.showBarrage(var_35_0)
		end

		return
	end)
	arg_33_0:updatePreviewAttrListPanel()

	return
end

function var_0_1.closePreviewPanel(arg_36_0)
	if arg_36_0.previewer then
		local var_36_0 = arg_36_0.previewer

		var_1.clear(var_36_0)

		arg_36_0.previewer = nil
	end

	setActive = var_1

	var_1(arg_36_0.previewTF, false)

	setActive = var_1

	var_1(arg_36_0.rawImage, false)

	pg = var_1

	local var_36_1 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_36_1, arg_36_0.previewTF, arg_36_0._tf)

	return
end

function var_0_1.openPreviewPanel(arg_37_0)
	setActive = var_1_10001

	var_1_10001(arg_37_0.previewTF, true)

	pg = var_1_10001

	local var_37_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_37_0, arg_37_0.previewTF)
	arg_37_0:playLoadingAni()

	return
end

function var_0_1.playLoadingAni(arg_38_0)
	setActive = var_1_10001

	var_1_10001(arg_38_0.seaLoading, true)

	return
end

function var_0_1.stopLoadingAni(arg_39_0)
	setActive = var_1_10001

	var_1_10001(arg_39_0.seaLoading, false)

	return
end

function var_0_1.getAllBreakIDs(arg_40_0, arg_40_1)
	local var_40_0 = {}

	ipairs = var_1_10003

	for iter_40_0, iter_40_1 in var_1_10003(var_0_2.all) do
		math = var_1_10008

		if var_1_10008.floor(iter_40_1 / 10) == arg_40_1 then
			table = var_1_10008

			var_1_10008.insert(var_40_0, iter_40_1)
		end
	end

	return var_40_0
end

function var_0_1.getWaponIdsById(arg_41_0, arg_41_1)
	return var_0_2[arg_41_1].weapon_ids
end

function var_0_1.getAllWeaponIds(arg_42_0)
	local var_42_0 = {}

	ipairs = var_1_10002

	for iter_42_0, iter_42_1 in var_1_10002(arg_42_0.breakIds) do
		Clone = var_1_10007
		var_1_10007 = var_1_10007(var_0_2[iter_42_1].weapon_ids)

		local var_42_1 = {
			__add = function(arg_43_0, arg_43_1)
				ipairs = var_2_10002

				for iter_43_0, iter_43_1 in var_2_10002(arg_43_0) do
					table = var_2_10007

					if not var_2_10007.contains(arg_43_1, iter_43_1) then
						table = var_2_10007

						var_2_10007.insert(arg_43_1, iter_43_1)
					end
				end

				return arg_43_1
			end
		}

		setmetatable = var_9

		var_9(var_42_0, var_42_1)

		var_42_0 = var_42_0 + var_1_10007
	end

	return var_42_0
end

function var_0_1.showBarrage(arg_44_0)
	local var_44_0 = arg_44_0.bayProxy
	local var_44_1 = var_1.getShipById(var_44_0, arg_44_0.curMetaShipID)
	local var_44_2 = var_1.getMetaCharacter(var_44_1)

	WeaponPreviewer = var_44_1
	arg_44_0.previewer = var_44_1.New(arg_44_0.rawImage)

	local var_44_3 = arg_44_0.previewer

	var_3.configUI(var_44_3, arg_44_0.healTF)

	local var_44_4 = arg_44_0.previewer

	var_3.setDisplayWeapon(var_44_4, arg_44_0:getWaponIdsById(arg_44_0.breakOutId))

	local var_44_5 = arg_44_0.previewer

	var_3.load(var_44_5, 40000, var_1, arg_44_0:getAllWeaponIds(), function()
		local var_45_0 = arg_44_0

		var_0.stopLoadingAni(var_45_0)

		return
	end)

	return
end

function var_0_1.switchStage(arg_46_0, arg_46_1)
	if arg_46_0.breakOutId == arg_46_1 then
		return
	end

	arg_46_0.breakOutId = arg_46_1

	if arg_46_0.previewer then
		local var_46_0 = arg_46_0.previewer

		var_2.setDisplayWeapon(var_46_0, arg_46_0:getWaponIdsById(arg_46_0.breakOutId))
	end

	return
end

function var_0_1.enablePartialBlur(arg_47_0)
	if arg_47_0._tf then
		local var_47_0 = {}

		table = var_1_10002

		var_1_10002.insert(var_47_0, arg_47_0.previewBtn)

		table = var_2

		var_2.insert(var_47_0, arg_47_0.rightPanel)
		arg_47_0:OverlayPanel(arg_47_0._tf, {
			groupDelta = -1,
			pbList = var_47_0
		})
	end

	return
end

function var_0_1.disablePartialBlur(arg_48_0)
	if arg_48_0._tf then
		arg_48_0:UnOverlayPanel(arg_48_0._tf)
	end

	return
end

return var_0_1
