class = var_0_10000

local var_0_0 = "TecSpeedUpLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "TecSpeedUpUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()
	arg_2_0:initTaskPanel()
	arg_2_0:initItem()

	setText = var_1

	var_1(arg_2_0.useCountText, 0)

	return
end

function var_0_1.didEnter(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_0, arg_3_0._tf)
	arg_3_0:tryPlayGuide()

	return
end

function var_0_1.willExit(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_4_0, arg_4_0._tf)

	if arg_4_0.minusTimer then
		local var_4_1 = arg_4_0.minusTimer

		var_1.Stop(var_4_1)
	end

	if arg_4_0.addTimer then
		local var_4_2 = arg_4_0.addTimer

		var_1.Stop(var_4_2, 0)
	end

	return
end

function var_0_1.tryPlayGuide(arg_5_0)
	pg = var_1_10001

	local var_5_0 = var_1_10001.SystemGuideMgr.GetInstance()

	var_1.PlayByGuideId(var_5_0, "NG0021")

	return
end

function var_0_1.initData(arg_6_0)
	getProxy = var_1_10001
	TechnologyProxy = var_1_10002
	arg_6_0.technologyProxy = var_1_10001(var_1_10002)
	getProxy = var_1
	TaskProxy = var_1_10002
	arg_6_0.taskProxy = var_1(var_1_10002)
	getProxy = var_1
	BagProxy = var_1_10002
	arg_6_0.bagProxy = var_1(var_1_10002)
	arg_6_0.shipBluePrintOnDev = nil

	local var_6_0 = arg_6_0.technologyProxy
	local var_6_1 = var_1.getBluePrints(var_6_0)

	pairs = var_6_0

	for iter_6_0, iter_6_1 in var_6_0(var_6_1) do
		if iter_6_1:isDeving() then
			arg_6_0.shipBluePrintOnDev = iter_6_1

			break
		end
	end

	local var_6_2 = arg_6_0.shipBluePrintOnDev
	local var_6_3 = var_2.getTaskIds(var_6_2)
	local var_6_4 = arg_6_0.shipBluePrintOnDev
	local var_6_5 = var_3.getTaskStateById(var_6_4, var_6_3[1])
	local var_6_6 = arg_6_0.shipBluePrintOnDev
	local var_6_7 = var_4.getTaskStateById(var_6_6, var_6_3[4])

	arg_6_0.expTaskID = nil
	ShipBluePrint = var_5

	if var_6_5 == var_5.TASK_STATE_START then
		arg_6_0.expTaskID = var_6_3[1]
	else
		ShipBluePrint = var_5

		if var_6_7 == var_5.TASK_STATE_START then
			arg_6_0.expTaskID = var_6_3[4]
		end
	end

	local var_6_8 = arg_6_0.taskProxy

	arg_6_0.expTaskVO = var_5.getTaskVO(var_6_8, arg_6_0.expTaskID)

	local var_6_9 = arg_6_0.shipBluePrintOnDev

	arg_6_0.bluePrintVersion = var_5.getConfig(var_6_9, "blueprint_version")
	pg = var_5
	arg_6_0.itemID = var_5.gameset.technology_catchup_itemid.description[arg_6_0.bluePrintVersion][1]
	pg = var_5
	arg_6_0.itemExp = var_5.gameset.technology_catchup_itemid.description[arg_6_0.bluePrintVersion][2]
	arg_6_0.curUseNum = 0

	local var_6_10 = arg_6_0.expTaskVO
	local var_6_11 = var_5.getProgress(var_6_10)
	local var_6_12 = arg_6_0.expTaskVO
	local var_6_13 = var_6.getConfig(var_6_12, "target_num") - var_6_11

	math = var_8

	local var_6_14 = var_8.ceil(var_6_13 / arg_6_0.itemExp)
	local var_6_15 = arg_6_0.bagProxy
	local var_6_16 = var_9.getItemCountById(var_6_15, arg_6_0.itemID)

	math = var_6_15
	arg_6_0.maxUseNum = var_6_15.min(var_6_14, var_6_16)

	return
end

function var_0_1.findUI(arg_7_0)
	local var_7_0 = arg_7_0._tf
	local var_7_1

	var_7_1, setText = var_1.Find(var_7_0, "Window/top/bg/obtain/title"), var_7_0
	i18n = var_1_10004

	var_7_0(var_7_1, var_1_10004("tec_speedup_title"))

	local var_7_2 = arg_7_0._tf
	local var_7_3 = var_2.Find(var_7_2, "Window")

	arg_7_0.backBtn = var_2.Find(var_7_3, "top/btnBack")

	local var_7_4 = arg_7_0._tf

	arg_7_0.bg = var_3.Find(var_7_4, "BG")

	local var_7_5 = var_2:Find("Panel")
	local var_7_6 = var_3.Find(var_7_5, "Task")

	arg_7_0.taskNameText = var_4.Find(var_7_6, "Name/Text")
	arg_7_0.expProgressText = var_4:Find("ExpProgressText")
	arg_7_0.expProgressSlider = var_4:Find("Slider")
	arg_7_0.taskText = var_4:Find("TaskText")
	arg_7_0.progressNumText = var_4:Find("ProgressNumText")

	local var_7_7 = var_3:Find("ItemPanel")

	arg_7_0.itemIcon = var_5.Find(var_7_7, "Item/Icon")
	arg_7_0.itemCountText = var_5:Find("Item/CountText")
	arg_7_0.itemNameText = var_5:Find("NameText")
	arg_7_0.minusBtn = var_5:Find("UsePanel/MinusBtn")
	arg_7_0.addBtn = var_5:Find("UsePanel/AddBtn")
	arg_7_0.maxBtn = var_5:Find("UsePanel/MaxBtn")
	arg_7_0.useCountText = var_5:Find("UsePanel/UseCountText")
	arg_7_0.confirmBtn = var_2:Find("ConfirmBtn")
	arg_7_0.helpBtn = var_2:Find("HelpBtn")
	arg_7_0.helpPanel = var_2:Find("HelpPanel")

	local var_7_8 = arg_7_0.helpPanel

	arg_7_0.helpText = var_6.Find(var_7_8, "Text")
	setText = var_6

	local var_7_9 = arg_7_0.helpText

	pg = var_8

	var_6(var_7_9, var_8.gametip.tec_speedup_help_tip.tip)

	return
end

function var_0_1.addListener(arg_8_0)
	onButton = var_1_10001

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.backBtn

	local function var_8_2()
		local var_9_0 = arg_8_0

		var_0.closeView(var_9_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_8_0, var_8_1, var_8_2, var_1_10005)

	onButton = var_1_10001

	local var_8_3 = arg_8_0
	local var_8_4 = arg_8_0.bg

	local function var_8_5()
		local var_10_0 = arg_8_0

		var_0.closeView(var_10_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_8_3, var_8_4, var_8_5, var_1_10005)

	onButton = var_1_10001

	local var_8_6 = arg_8_0
	local var_8_7 = arg_8_0.confirmBtn

	local function var_8_8()
		if arg_8_0.curUseNum == 0 then
			return
		end

		local var_11_0 = arg_8_0
		local var_11_1, var_11_2 = var_0.isExpOverFlow(var_11_0)
		local var_11_3 = arg_8_0
		local var_11_5

		if var_2.isExpOverFlow(var_11_3) then
			pg = var_11_5

			local var_11_4 = var_11_5.MsgboxMgr.GetInstance()

			var_11_5 = var_11_5.ShowMsgBox
			var_2_10004 = {}
			i18n = var_2_10005
			var_2_10004.content = var_2_10005("tec_speedup_overflow", var_11_2)

			function var_2_10004.onYes()
				pg = var_3_10000

				local var_12_0 = var_3_10000.m02
				local var_12_1 = var_0.sendNotification

				GAME = var_3_10002

				var_12_1(var_12_0, var_3_10002.USE_TEC_SPEEDUP_ITEM, {
					blueprintid = arg_8_0.shipBluePrintOnDev.id,
					itemid = arg_8_0.itemID,
					number = arg_8_0.curUseNum,
					taskID = arg_8_0.expTaskID
				})

				return
			end

			var_11_5(var_11_4, var_2_10004)
		else
			pg = var_11_5

			local var_11_6 = var_11_5.m02
			local var_11_7 = var_2.sendNotification

			GAME = var_2_10004

			var_11_7(var_11_6, var_2_10004.USE_TEC_SPEEDUP_ITEM, {
				blueprintid = arg_8_0.shipBluePrintOnDev.id,
				itemid = arg_8_0.itemID,
				number = arg_8_0.curUseNum,
				taskID = arg_8_0.expTaskID
			})
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_6, var_8_7, var_8_8, var_1_10005)

	onButton = var_1_10001

	local var_8_9 = arg_8_0
	local var_8_10 = arg_8_0.helpBtn

	local function var_8_11()
		isActive = var_2_10000

		if var_2_10000(arg_8_0.helpPanel) then
			setActive = var_0

			var_0(arg_8_0.helpPanel, false)
		else
			setActive = var_0

			var_0(arg_8_0.helpPanel, true)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_9, var_8_10, var_8_11, var_1_10005)

	onButton = var_1_10001

	local var_8_12 = arg_8_0
	local var_8_13 = arg_8_0.maxBtn

	local function var_8_14()
		if arg_8_0.curUseNum ~= arg_8_0.maxUseNum then
			local var_14_0 = arg_8_0

			var_14_0.curUseNum = arg_8_0.maxUseNum
			setText = var_14_0

			var_14_0(arg_8_0.useCountText, arg_8_0.curUseNum)

			local var_14_1 = arg_8_0

			var_0.updateTaskPanel(var_14_1, arg_8_0.curUseNum)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_12, var_8_13, var_8_14, var_1_10005)

	local var_8_15 = 0

	local function var_8_16()
		if arg_8_0.curUseNum > 0 then
			local var_15_0 = arg_8_0

			var_15_0.curUseNum = arg_8_0.curUseNum - 1
			setText = var_15_0

			var_15_0(arg_8_0.useCountText, arg_8_0.curUseNum)

			local var_15_1 = arg_8_0

			var_0.updateTaskPanel(var_15_1, arg_8_0.curUseNum)
		end

		return
	end

	onButton = var_8_13

	local var_8_17 = arg_8_0
	local var_8_18 = arg_8_0.minusBtn
	local var_8_19 = var_8_16

	SFX_PANEL = var_1_10007

	var_8_13(var_8_17, var_8_18, var_8_19, var_1_10007)

	GetOrAddComponent = var_8_13

	local var_8_20 = arg_8_0.minusBtn

	typeof = var_8_18
	EventTriggerListener = var_8_19

	local var_8_21 = var_8_13(var_8_20, var_8_18(var_8_19))

	var_3.AddPointDownFunc(var_8_21, function(arg_16_0, arg_16_1)
		if not arg_8_0.minusTimer then
			local var_16_0 = arg_8_0

			Timer = var_2_10003
			var_16_0.minusTimer = var_2_10003.New(function()
				if var_8_15 < 1 then
					var_8_15 = var_8_15 + 0.2
				else
					var_8_16()
				end

				return
			end, 0.2, -1, 1)
		end

		local var_16_1 = arg_8_0.minusTimer

		var_2.Start(var_16_1)

		return
	end)

	local var_8_22 = var_3

	var_3.AddPointUpFunc(var_8_22, function(arg_18_0, arg_18_1)
		if arg_8_0.minusTimer then
			var_8_15 = 0

			local var_18_0 = arg_8_0.minusTimer

			var_2.Stop(var_18_0)
		end

		return
	end)

	local function var_8_23()
		if arg_8_0.curUseNum < arg_8_0.maxUseNum then
			local var_19_0 = arg_8_0

			var_19_0.curUseNum = arg_8_0.curUseNum + 1
			setText = var_19_0

			var_19_0(arg_8_0.useCountText, arg_8_0.curUseNum)

			local var_19_1 = arg_8_0

			var_0.updateTaskPanel(var_19_1, arg_8_0.curUseNum)
		end

		return
	end

	onButton = var_8_22

	local var_8_24 = arg_8_0
	local var_8_25 = arg_8_0.addBtn
	local var_8_26 = var_8_23

	SFX_PANEL = var_1_10009

	var_8_22(var_8_24, var_8_25, var_8_26, var_1_10009)

	GetOrAddComponent = var_8_22

	local var_8_27 = arg_8_0.addBtn

	typeof = var_8_25
	EventTriggerListener = var_8_26

	local var_8_28 = var_8_22(var_8_27, var_8_25(var_8_26))

	var_5.AddPointDownFunc(var_8_28, function(arg_20_0, arg_20_1)
		if not arg_8_0.addTimer then
			local var_20_0 = arg_8_0

			Timer = var_2_10003
			var_20_0.addTimer = var_2_10003.New(function()
				if var_8_15 < 1 then
					var_8_15 = var_8_15 + 0.2
				else
					var_8_23()
				end

				return
			end, 0.2, -1, 1)
		end

		local var_20_1 = arg_8_0.addTimer

		var_2.Start(var_20_1)

		return
	end)
	var_5:AddPointUpFunc(function(arg_22_0, arg_22_1)
		if arg_8_0.addTimer then
			var_8_15 = 0

			local var_22_0 = arg_8_0.addTimer

			var_2.Stop(var_22_0)
		end

		return
	end)

	return
end

function var_0_1.initTaskPanel(arg_23_0)
	local var_23_0 = arg_23_0.expTaskVO
	local var_23_1 = var_1.getConfig(var_23_0, "name")

	setText = var_23_0

	var_23_0(arg_23_0.taskNameText, var_23_1)

	local var_23_2 = arg_23_0.expTaskVO
	local var_23_3 = var_2.getConfig(var_23_2, "desc")

	setText = var_23_2

	local var_23_4 = arg_23_0.taskText

	string = var_1_10005

	local var_23_5 = var_1_10005.split
	local var_23_6 = var_23_3

	i18n = var_1_10007

	var_23_2(var_23_4, var_23_5(var_23_6, var_1_10007("tech_catchup_sentence_pauses"))[2])

	local var_23_7 = arg_23_0.expTaskVO
	local var_23_8 = var_3.getProgress(var_23_7)
	local var_23_9 = arg_23_0.expTaskVO
	local var_23_10 = var_4.getConfig(var_23_9, "target_num")

	setText = var_23_9

	local var_23_11 = arg_23_0.expProgressText

	i18n = var_7

	local var_23_12 = "tec_speedup_progress"

	math = var_1_10009

	local var_23_13 = var_1_10009.floor(var_23_8 / 16)

	math = var_10

	var_23_9(var_23_11, var_7(var_23_12, var_23_13, var_10.floor(var_23_10 / 16)))

	local var_23_14 = var_23_8 / var_23_10

	setSlider = var_23_11

	var_23_11(arg_23_0.expProgressSlider, 0, 1, var_23_14)

	setText = var_23_11

	local var_23_15 = arg_23_0.progressNumText

	math = var_8

	var_23_11(var_23_15, var_8.floor(var_23_14 * 100) .. "%")

	return
end

function var_0_1.updateTaskPanel(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0.curUseNum * arg_24_0.itemExp
	local var_24_1 = arg_24_0.expTaskVO
	local var_24_2 = var_3.getProgress(var_24_1)
	local var_24_3 = arg_24_0.expTaskVO
	local var_24_4 = var_4.getConfig(var_24_3, "target_num")
	local var_24_5 = var_24_2 + var_24_0

	setText = var_6

	local var_24_6 = arg_24_0.expProgressText

	i18n = var_1_10008

	local var_24_7 = "tec_speedup_progress"

	math = var_1_10010

	local var_24_8 = var_1_10010.floor(var_24_5 / 16)

	math = var_11

	var_6(var_24_6, var_1_10008(var_24_7, var_24_8, var_11.floor(var_24_4 / 16)))

	local var_24_9 = var_24_5 / var_24_4

	setSlider = var_24_6

	var_24_6(arg_24_0.expProgressSlider, 0, 1, var_24_9)

	setText = var_24_6

	local var_24_10 = arg_24_0.progressNumText

	math = var_9

	var_24_6(var_24_10, var_9.floor(var_24_9 * 100) .. "%")

	return
end

function var_0_1.initItem(arg_25_0)
	Item = var_1_10001

	local var_25_0 = var_1_10001.getConfigData(arg_25_0.itemID)

	GetImageSpriteFromAtlasAsync = var_2

	var_2(var_25_0.icon, "", arg_25_0.itemIcon)

	setText = var_2

	local var_25_1 = arg_25_0.itemCountText
	local var_25_2 = arg_25_0.bagProxy

	var_2(var_25_1, var_4.getItemCountById(var_25_2, arg_25_0.itemID))

	setText = var_2

	var_2(arg_25_0.itemNameText, var_25_0.name)

	return
end

function var_0_1.isExpOverFlow(arg_26_0)
	local var_26_0 = arg_26_0.curUseNum * arg_26_0.itemExp
	local var_26_1 = arg_26_0.expTaskVO
	local var_26_2 = var_2.getProgress(var_26_1)
	local var_26_3 = arg_26_0.expTaskVO
	local var_26_4 = var_3.getConfig(var_26_3, "target_num") < var_26_2 + var_26_0
	local var_26_5 = var_4 - var_3

	return var_26_4, var_26_5
end

return var_0_1
