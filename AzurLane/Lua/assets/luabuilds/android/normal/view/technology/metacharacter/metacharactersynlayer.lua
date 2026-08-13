class = var_0_10000

local var_0_0 = "MetaCharacterSynLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "MetaCharacterSynUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:initUITextTips()
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0:updateShipImg()
	arg_3_0:updatePtPanel()
	arg_3_0:updateTaskList()
	arg_3_0:updateGetAwardBtn()
	arg_3_0:updateActTimePanel()
	arg_3_0:enablePartialBlur()

	if arg_3_0.contextData.isMainOpen then
		arg_3_0.contextData.isMainOpen = nil

		arg_3_0:moveShipImg(true)
	end

	arg_3_0:movePanel()
	arg_3_0:TryPlayGuide()

	return
end

function var_0_1.willExit(arg_4_0)
	arg_4_0:moveShipImg(false)
	arg_4_0:disablePartialBlur()

	return
end

function var_0_1.initUITextTips(arg_5_0)
	local var_5_0 = arg_5_0._tf
	local var_5_1

	var_5_1, setText = var_1.Find(var_5_0, "PTPanel/TipText"), var_5_0
	i18n = var_1_10004

	var_5_0(var_5_1, var_1_10004("meta_cur_pt"))

	local var_5_2 = arg_5_0._tf
	local var_5_3

	var_5_3, setText = var_2.Find(var_5_2, "TaskPanel/ActTimePanel/Tip"), var_5_2
	i18n = var_5

	var_5_2(var_5_3, var_5("meta_acttime_limit"))

	return
end

function var_0_1.initData(arg_6_0)
	arg_6_0.curMetaShipID = arg_6_0.contextData.shipID
	arg_6_0.curShipVO = nil
	arg_6_0.curMetaCharacterVO = nil
	arg_6_0.curMetaProgressVO = nil

	arg_6_0:updateData()

	return
end

function var_0_1.updateData(arg_7_0)
	getProxy = var_1_10001
	BayProxy = var_1_10002

	local var_7_0 = var_1_10001(var_1_10002)

	arg_7_0.curShipVO = var_1.getShipById(var_7_0, arg_7_0.curMetaShipID)

	local var_7_1 = arg_7_0.curShipVO

	arg_7_0.curMetaCharacterVO = var_1.getMetaCharacter(var_7_1)
	getProxy = var_1
	MetaCharacterProxy = var_7_1

	local var_7_2 = var_1(var_7_1)

	arg_7_0.curMetaProgressVO = var_1.getMetaProgressVOByID(var_7_2, arg_7_0.curMetaCharacterVO.id)

	return
end

function var_0_1.findUI(arg_8_0)
	local var_8_0 = arg_8_0._tf

	arg_8_0.shipImg = var_1.Find(var_8_0, "ShipImg")

	local var_8_1 = arg_8_0._tf

	arg_8_0.ptPanel = var_1.Find(var_8_1, "PTPanel")

	local var_8_2 = arg_8_0.ptPanel

	arg_8_0.ptSynRateText = var_1.Find(var_8_2, "ProgressText")

	local var_8_3 = arg_8_0.ptPanel

	arg_8_0.ptNumText = var_1.Find(var_8_3, "Count/NumText")

	local var_8_4 = arg_8_0.ptPanel

	arg_8_0.ptIconLeft = var_1.Find(var_8_4, "Icon")

	local var_8_5 = arg_8_0.ptPanel

	arg_8_0.showWayBtn = var_1.Find(var_8_5, "ShowWayBtn")

	local var_8_6 = arg_8_0._tf

	arg_8_0.taskPanel = var_1.Find(var_8_6, "TaskPanel")

	local var_8_7 = arg_8_0.taskPanel

	arg_8_0.taskTplContainer = var_1.Find(var_8_7, "Scroll/Viewport/Content")

	local var_8_8 = arg_8_0.taskPanel

	arg_8_0.taskTpl = var_1.Find(var_8_8, "TaskTpl")

	local var_8_9 = arg_8_0.taskPanel

	arg_8_0.getAllBtn = var_1.Find(var_8_9, "BtnGetAll")

	local var_8_10 = arg_8_0.taskPanel

	arg_8_0.getAllBtnDisable = var_1.Find(var_8_10, "BtnGetAllDisable")

	local var_8_11 = arg_8_0.taskPanel

	arg_8_0.getNextBtn = var_1.Find(var_8_11, "BtnGetMore")
	UIItemList = var_1
	arg_8_0.taskUIItemList = var_1.New(arg_8_0.taskTplContainer, arg_8_0.taskTpl)
	GetComponent = var_1
	arg_8_0.sizeH = var_1(arg_8_0.taskTpl, "LayoutElement").preferredHeight
	GetComponent = var_1
	arg_8_0.spaceH = var_1(arg_8_0.taskTplContainer, "VerticalLayoutGroup").spacing
	GetComponent = var_1
	arg_8_0.topH = var_1(arg_8_0.taskTplContainer, "VerticalLayoutGroup").padding.top
	GetComponent = var_1

	local var_8_12 = arg_8_0.taskPanel

	arg_8_0.scrollSC = var_1(var_2.Find(var_8_12, "Scroll"), "ScrollRect")

	local var_8_13 = arg_8_0._tf

	arg_8_0.actTimePanel = var_1.Find(var_8_13, "TaskPanel/ActTimePanel")

	local var_8_14 = arg_8_0._tf

	arg_8_0.actTimeText = var_1.Find(var_8_14, "TaskPanel/ActTimePanel/Text")

	return
end

function var_0_1.addListener(arg_9_0)
	onButton = var_1_10001

	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.getAllBtn

	local function var_9_2()
		local var_10_0 = arg_9_0
		local var_10_1, var_10_2 = var_0.getOneStepPTAwardLevelAndCount(var_10_0)

		pg = var_2_10002

		local var_10_3 = var_2_10002.m02
		local var_10_4 = var_2.sendNotification

		GAME = var_2_10004

		var_10_4(var_10_3, var_2_10004.GET_META_PT_AWARD, {
			groupID = arg_9_0.curMetaProgressVO.id,
			targetCount = var_10_2
		})

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_9_0, var_9_1, var_9_2, var_1_10005)

	onButton = var_1_10001

	var_1_10001(arg_9_0, arg_9_0.getAllBtnDisable, function()
		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_9_0, arg_9_0.getNextBtn, function()
		pg = var_2_10000

		local var_12_0 = var_2_10000.TipsMgr.GetInstance()
		local var_12_1 = var_0.ShowTips

		i18n = var_2_10002

		var_12_1(var_12_0, var_2_10002("meta_pt_notenough"))

		return
	end)

	onButton = var_1_10001

	local var_9_3 = arg_9_0
	local var_9_4 = arg_9_0.showWayBtn

	local function var_9_5()
		local var_13_0 = {
			count = 0
		}

		DROP_TYPE_ITEM = var_2_10001
		var_13_0.type = var_2_10001
		var_13_0.id = arg_9_0.curMetaProgressVO.metaPtData.resId
		pg = var_1

		local var_13_1 = var_1.MsgboxMgr.GetInstance()
		local var_13_2 = var_1.ShowMsgBox
		local var_13_3 = {}

		MSGBOX_TYPE_SINGLE_ITEM = var_2_10004
		var_13_3.type = var_2_10004
		var_13_3.drop = var_13_0

		var_13_2(var_13_1, var_13_3)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_9_3, var_9_4, var_9_5, var_1_10005)

	return
end

function var_0_1.TryPlayGuide(arg_14_0)
	pg = var_1_10001

	local var_14_0 = var_1_10001.SystemGuideMgr.GetInstance()

	var_1.PlayByGuideId(var_14_0, "NG0028")

	return
end

function var_0_1.updateActTimePanel(arg_15_0)
	local var_15_0 = arg_15_0.curMetaProgressVO

	type = var_1_10002

	if var_1_10002(var_15_0.timeConfig) == "string" then
		setActive = var_2

		var_2(arg_15_0.actTimePanel, false)
	else
		type = var_2

		if var_2(var_15_0.timeConfig) == "table" then
			pg = var_2

			local var_15_1 = var_2.TimeMgr.GetInstance()
			local var_15_2 = var_2.parseTimeFromConfig(var_15_1, var_15_0.timeConfig[2])

			pg = var_15_1

			local var_15_3 = var_15_1.TimeMgr.GetInstance()
			local var_15_4 = var_3.GetServerTime(var_15_3)

			pg = var_15_3

			local var_15_5 = var_15_3.TimeMgr.GetInstance()
			local var_15_6 = var_4.DiffDay(var_15_5, var_15_4, var_15_2)

			setText = var_15_5

			local var_15_7 = arg_15_0.actTimeText

			i18n = var_7

			var_15_5(var_15_7, var_7("meta_pt_left", var_15_6))
		end
	end

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
		x = var_16_4[9],
		y = var_16_4[10]
	})

	setLocalScale = var_5

	var_5(arg_16_0.shipImg, {
		x = var_16_4[3],
		y = var_16_4[4]
	})

	return
end

function var_0_1.updatePtPanel(arg_17_0)
	setImageSprite = var_1_10001

	local var_17_0 = arg_17_0.ptIconLeft

	LoadSprite = var_1_10003

	local var_17_1 = arg_17_0.curMetaProgressVO

	var_1_10001(var_17_0, var_1_10003(var_4.getPtIconPath(var_17_1)))

	local var_17_2 = arg_17_0.curMetaProgressVO
	local var_17_3 = var_1.getSynRate(var_17_2)

	setText = var_17_2

	local var_17_4 = arg_17_0.ptSynRateText

	string = var_4

	var_17_2(var_17_4, var_4.format("%d", var_17_3 * 100) .. "%")

	local var_17_5 = arg_17_0.curMetaProgressVO.metaPtData
	local var_17_6 = var_2.GetResProgress(var_17_5)

	setText = var_17_5

	var_17_5(arg_17_0.ptNumText, var_17_6)

	return
end

function var_0_1.updateTaskList(arg_18_0)
	local var_18_0 = arg_18_0.taskUIItemList

	var_1.make(var_18_0, function(arg_19_0, arg_19_1, arg_19_2)
		UIItemList = var_2_10003

		if arg_19_0 == var_2_10003.EventUpdate then
			arg_19_1 = arg_19_1 + 1

			local var_19_0 = arg_18_0

			var_3.updateTaskTpl(var_19_0, arg_19_2, arg_19_1)
		end

		return
	end)

	local var_18_1 = arg_18_0.curMetaProgressVO.metaPtData
	local var_18_2, var_18_3, var_18_4 = var_1.GetLevelProgress(var_18_1)
	local var_18_5 = arg_18_0.taskUIItemList

	var_4.align(var_18_5, var_18_3)

	local var_18_6 = arg_18_0.topH + (var_18_2 - 1) * (arg_18_0.sizeH + arg_18_0.spaceH)

	setLocalPosition = var_5

	var_5(arg_18_0.taskTplContainer, {
		y = var_18_6
	})

	return
end

function var_0_1.updateTaskTpl(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_1:Find("Target/IndexText")
	local var_20_1 = arg_20_1:Find("PT/Count/NumText")
	local var_20_2 = arg_20_1:Find("PT/Icon")
	local var_20_3 = arg_20_1:Find("Info/AwardInfo/NameMask/NameText")
	local var_20_4 = arg_20_1:Find("Info/AwardInfo/SynProgressText")
	local var_20_5 = arg_20_1:Find("Info/AwardInfo/Award/Item")
	local var_20_6 = arg_20_1:Find("Info/AwardInfo/Award/Tag/Get")
	local var_20_7 = arg_20_1:Find("Info/AwardInfo/Award/Tag/Got")
	local var_20_8 = arg_20_1
	local var_20_9 = arg_20_1.Find(var_20_8, "GotMask")

	setText = var_20_8

	var_20_8(var_20_0, arg_20_2)

	local var_20_10 = arg_20_0.curMetaProgressVO.metaPtData.targets[arg_20_2]

	setText = var_13

	var_13(var_20_1, var_20_10)

	setImageSprite = var_13

	local var_20_11 = var_20_2

	LoadSprite = var_15

	local var_20_12 = arg_20_0.curMetaProgressVO

	var_13(var_20_11, var_15(var_16.getPtIconPath(var_20_12)))

	Drop = var_13

	local var_20_13 = var_13.Create(arg_20_0.curMetaProgressVO.metaPtData.dropList[arg_20_2])

	updateDrop = var_14

	var_14(var_20_5, var_20_13, {
		hideName = true
	})

	onButton = var_14

	local var_20_14 = arg_20_0
	local var_20_15 = arg_20_1:Find("Info/AwardInfo/Award")

	local function var_20_16()
		local var_21_0 = arg_20_0
		local var_21_1 = var_0.emit

		BaseUI = var_2_10002

		var_21_1(var_21_0, var_2_10002.ON_DROP, var_20_13)

		return
	end

	SFX_PANEL = var_18

	var_14(var_20_14, var_20_15, var_20_16, var_18)

	setText = var_14

	local var_20_17 = var_20_3

	shortenString = var_20_15

	var_14(var_20_17, var_20_15(var_20_13:getConfig("name"), 6))

	local var_20_18 = arg_20_0.curMetaProgressVO.unlockPTNum

	setText = var_20_17

	local var_20_19 = var_20_4

	math = var_17

	var_20_17(var_20_19, var_17.round(var_20_10 / var_20_18 * 100) .. "%")

	if arg_20_2 < arg_20_0.curMetaProgressVO.metaPtData.level + 1 then
		setActive = var_20_19

		var_20_19(var_20_7, true)

		setActive = var_20_19

		var_20_19(var_20_6, false)

		setActive = var_20_19

		var_20_19(var_20_9, true)

		setGray = var_20_19

		var_20_19(arg_20_1, true, true)
	else
		if arg_20_0.curMetaProgressVO.metaPtData.count < var_20_10 then
			setActive = var_16

			var_16(var_20_7, false)

			setActive = var_16

			var_16(var_20_6, false)
		else
			setActive = var_16

			var_16(var_20_7, false)

			setActive = var_16

			var_16(var_20_6, true)
		end

		setActive = var_16

		var_16(var_20_9, false)

		setGray = var_16

		var_16(arg_20_1, false, true)
	end

	return
end

function var_0_1.updateGetAwardBtn(arg_22_0)
	local var_22_0 = arg_22_0.curMetaProgressVO.metaPtData
	local var_22_1 = var_1.CanGetAward(var_22_0)
	local var_22_2 = arg_22_0.curMetaProgressVO.metaPtData
	local var_22_3 = var_2.CanGetNextAward(var_22_2)

	if var_22_1 then
		setActive = var_22_2

		var_22_2(arg_22_0.getAllBtn, true)

		setActive = var_22_2

		var_22_2(arg_22_0.getAllBtnDisable, false)

		setActive = var_22_2

		var_22_2(arg_22_0.getNextBtn, false)
	elseif var_22_3 then
		setActive = var_22_2

		var_22_2(arg_22_0.getAllBtn, false)

		setActive = var_22_2

		var_22_2(arg_22_0.getAllBtnDisable, false)

		setActive = var_22_2

		var_22_2(arg_22_0.getNextBtn, true)
	else
		setActive = var_22_2

		var_22_2(arg_22_0.getAllBtn, false)

		setActive = var_22_2

		var_22_2(arg_22_0.getAllBtnDisable, true)

		setActive = var_22_2

		var_22_2(arg_22_0.getNextBtn, false)
	end

	return
end

function var_0_1.moveShipImg(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0.curMetaCharacterVO.id

	MetaCharacterConst = var_1_10003

	local var_23_1 = var_1_10003.UIConfig[var_23_0]
	local var_23_2 = arg_23_1 and -2000 or var_23_1[9]
	local var_23_3

	if not arg_23_1 or not var_23_1[9] then
		var_23_3 = -2000
	end

	local var_23_4 = arg_23_0
	local var_23_5 = arg_23_0.managedTween

	LeanTween = var_1_10008

	local var_23_6 = var_1_10008.moveX
	local var_23_7

	rtf = var_1_10010

	local var_23_8 = var_23_5(var_23_4, var_23_6, var_23_7, var_1_10010(arg_23_0.shipImg), var_23_3, 0.3)

	var_6.setFrom(var_23_8, var_23_2)

	return
end

function var_0_1.movePanel(arg_24_0)
	local var_24_0 = 2000
	local var_24_1 = 500
	local var_24_2 = arg_24_0
	local var_24_3 = arg_24_0.managedTween

	LeanTween = var_1_10005

	local var_24_4 = var_1_10005.moveX
	local var_24_5

	rtf = var_1_10007

	local var_24_6 = var_24_3(var_24_2, var_24_4, var_24_5, var_1_10007(arg_24_0.taskPanel), var_24_1, 0.3)

	var_3.setFrom(var_24_6, var_24_0)

	local var_24_7 = -2000
	local var_24_8 = -516
	local var_24_9 = arg_24_0
	local var_24_10 = arg_24_0.managedTween

	LeanTween = var_7

	local var_24_11 = var_7.moveX
	local var_24_12

	rtf = var_9

	local var_24_13 = var_24_10(var_24_9, var_24_11, var_24_12, var_9(arg_24_0.ptPanel), var_24_8, 0.3)

	var_5.setFrom(var_24_13, var_24_7)

	return
end

function var_0_1.enablePartialBlur(arg_25_0)
	if arg_25_0._tf then
		local var_25_0 = {}

		table = var_1_10002

		var_1_10002.insert(var_25_0, arg_25_0.taskPanel)
		arg_25_0:OverlayPanel(arg_25_0._tf, {
			groupDelta = -1,
			pbList = var_25_0
		})
	end

	return
end

function var_0_1.disablePartialBlur(arg_26_0)
	if arg_26_0._tf then
		arg_26_0:UnOverlayPanel(arg_26_0._tf)
	end

	return
end

function var_0_1.getOneStepPTAwardLevelAndCount(arg_27_0)
	local var_27_0 = arg_27_0.curMetaProgressVO.metaPtData
	local var_27_1 = var_2.GetResProgress(var_27_0)
	local var_27_2 = var_1.metaPtData.targets
	local var_27_3 = var_1:getStoryIndexList()
	local var_27_4 = var_1.unlockPTLevel
	local var_27_5 = 0

	for iter_27_0 = 1, #var_27_2 do
		local var_27_6 = false
		local var_27_7 = false

		if var_27_1 >= var_27_2[iter_27_0] then
			var_27_6 = true
		end

		if var_27_3[iter_27_0] == 0 then
			var_27_7 = true
		else
			pg = var_1_10015

			local var_27_8 = var_1_10015.NewStoryMgr.GetInstance()

			if var_1_10015.IsPlayed(var_27_8, var_14) then
				var_27_7 = true
			end
		end

		if var_27_6 and var_27_7 then
			var_27_5 = iter_27_0
		else
			break
		end
	end

	print = var_7

	var_7("calc max level", var_27_5, var_27_2[var_27_5])

	return var_27_5, var_27_2[var_27_5]
end

function var_0_1.goWorldFunc(arg_28_0)
	getProxy = var_1_10001
	ContextProxy = var_1_10002

	local var_28_0 = var_1_10001(var_1_10002)
	local var_28_1 = var_1.getContextByMediator

	MetaCharacterMediator = var_1_10003

	local var_28_2 = var_28_1(var_28_0, var_1_10003)

	pg = var_28_0

	local var_28_3 = var_28_0.m02
	local var_28_4 = var_2.retrieveMediator(var_28_3, "MetaCharacterMediator")

	var_28_2.data.lastPageIndex = var_28_4.viewComponent.curPageIndex

	arg_28_0:closeView()

	local var_28_5 = arg_28_0
	local var_28_6 = arg_28_0.sendNotification

	GAME = var_1_10005

	local var_28_7 = var_1_10005.GO_SCENE

	SCENE = var_1_10006

	var_28_6(var_28_5, var_28_7, var_1_10006.WORLDBOSS)

	return
end

return var_0_1
