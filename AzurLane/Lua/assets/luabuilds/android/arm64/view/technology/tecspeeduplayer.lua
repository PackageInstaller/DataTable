local var_0_0 = class("TecSpeedUpLayer", import("..base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "TecSpeedUpUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()
	arg_2_0:initTaskPanel()
	arg_2_0:initItem()
	setText(arg_2_0.useCountText, 0)

	return
end

function var_0_0.didEnter(arg_3_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_3_0._tf)
	arg_3_0:tryPlayGuide()

	return
end

function var_0_0.willExit(arg_4_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_4_0._tf)

	if arg_4_0.minusTimer then
		arg_4_0.minusTimer:Stop()
	end

	if arg_4_0.addTimer then
		arg_4_0.addTimer:Stop(0)
	end

	return
end

function var_0_0.tryPlayGuide(arg_5_0)
	pg.SystemGuideMgr.GetInstance():PlayByGuideId("NG0021")

	return
end

function var_0_0.initData(arg_6_0)
	arg_6_0.technologyProxy = getProxy(TechnologyProxy)
	arg_6_0.taskProxy = getProxy(TaskProxy)
	arg_6_0.bagProxy = getProxy(BagProxy)
	arg_6_0.shipBluePrintOnDev = nil

	for iter_6_0, iter_6_1 in pairs((arg_6_0.technologyProxy:getBluePrints())) do
		if iter_6_1:isDeving() then
			arg_6_0.shipBluePrintOnDev = iter_6_1

			break
		end
	end

	local var_6_0 = arg_6_0.shipBluePrintOnDev:getTaskIds()

	arg_6_0.expTaskID = nil

	if arg_6_0.shipBluePrintOnDev:getTaskStateById(var_6_0[1]) == ShipBluePrint.TASK_STATE_START then
		arg_6_0.expTaskID = var_6_0[1]
	elseif arg_6_0.shipBluePrintOnDev:getTaskStateById(var_6_0[4]) == ShipBluePrint.TASK_STATE_START then
		arg_6_0.expTaskID = var_6_0[4]
	end

	arg_6_0.expTaskVO = arg_6_0.taskProxy:getTaskVO(arg_6_0.expTaskID)
	arg_6_0.bluePrintVersion = arg_6_0.shipBluePrintOnDev:getConfig("blueprint_version")
	arg_6_0.itemID = pg.gameset.technology_catchup_itemid.description[arg_6_0.bluePrintVersion][1]
	arg_6_0.itemExp = pg.gameset.technology_catchup_itemid.description[arg_6_0.bluePrintVersion][2]
	arg_6_0.curUseNum = 0
	arg_6_0.maxUseNum = math.min(math.ceil((arg_6_0.expTaskVO:getConfig("target_num") - arg_6_0.expTaskVO:getProgress()) / arg_6_0.itemExp), (arg_6_0.bagProxy:getItemCountById(arg_6_0.itemID)))

	return
end

function var_0_0.findUI(arg_7_0)
	setText(arg_7_0._tf:Find("Window/top/bg/obtain/title"), i18n("tec_speedup_title"))

	local var_7_0 = arg_7_0._tf:Find("Window")

	arg_7_0.backBtn = var_7_0:Find("top/btnBack")
	arg_7_0.bg = arg_7_0._tf:Find("BG")

	local var_7_1 = var_7_0:Find("Panel")
	local var_7_2 = var_7_1:Find("Task")

	arg_7_0.taskNameText = var_7_2:Find("Name/Text")
	arg_7_0.expProgressText = var_7_2:Find("ExpProgressText")
	arg_7_0.expProgressSlider = var_7_2:Find("Slider")
	arg_7_0.taskText = var_7_2:Find("TaskText")
	arg_7_0.progressNumText = var_7_2:Find("ProgressNumText")

	local var_7_3 = var_7_1:Find("ItemPanel")

	arg_7_0.itemIcon = var_7_3:Find("Item/Icon")
	arg_7_0.itemCountText = var_7_3:Find("Item/CountText")
	arg_7_0.itemNameText = var_7_3:Find("NameText")
	arg_7_0.minusBtn = var_7_3:Find("UsePanel/MinusBtn")
	arg_7_0.addBtn = var_7_3:Find("UsePanel/AddBtn")
	arg_7_0.maxBtn = var_7_3:Find("UsePanel/MaxBtn")
	arg_7_0.useCountText = var_7_3:Find("UsePanel/UseCountText")
	arg_7_0.confirmBtn = var_7_0:Find("ConfirmBtn")
	arg_7_0.helpBtn = var_7_0:Find("HelpBtn")
	arg_7_0.helpPanel = var_7_0:Find("HelpPanel")
	arg_7_0.helpText = arg_7_0.helpPanel:Find("Text")

	setText(arg_7_0.helpText, pg.gametip.tec_speedup_help_tip.tip)

	return
end

function var_0_0.addListener(arg_8_0)
	onButton(arg_8_0, arg_8_0.backBtn, function()
		arg_8_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_8_0, arg_8_0.bg, function()
		arg_8_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_8_0, arg_8_0.confirmBtn, function()
		if arg_8_0.curUseNum == 0 then
			return
		end

		local var_11_0, var_11_1 = arg_8_0:isExpOverFlow()

		if arg_8_0:isExpOverFlow() then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("tec_speedup_overflow", var_11_1),
				onYes = function()
					pg.m02:sendNotification(GAME.USE_TEC_SPEEDUP_ITEM, {
						blueprintid = arg_8_0.shipBluePrintOnDev.id,
						itemid = arg_8_0.itemID,
						number = arg_8_0.curUseNum,
						taskID = arg_8_0.expTaskID
					})

					return
				end
			})
		else
			pg.m02:sendNotification(GAME.USE_TEC_SPEEDUP_ITEM, {
				blueprintid = arg_8_0.shipBluePrintOnDev.id,
				itemid = arg_8_0.itemID,
				number = arg_8_0.curUseNum,
				taskID = arg_8_0.expTaskID
			})
		end

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.helpBtn, function()
		if isActive(arg_8_0.helpPanel) then
			setActive(arg_8_0.helpPanel, false)
		else
			setActive(arg_8_0.helpPanel, true)
		end

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.maxBtn, function()
		if arg_8_0.curUseNum ~= arg_8_0.maxUseNum then
			arg_8_0.curUseNum = arg_8_0.maxUseNum

			setText(arg_8_0.useCountText, arg_8_0.curUseNum)
			arg_8_0:updateTaskPanel(arg_8_0.curUseNum)
		end

		return
	end, SFX_PANEL)

	local var_8_0 = 0

	onButton(arg_8_0, arg_8_0.minusBtn, function()
		if arg_8_0.curUseNum > 0 then
			arg_8_0.curUseNum = arg_8_0.curUseNum - 1

			setText(arg_8_0.useCountText, arg_8_0.curUseNum)
			arg_8_0:updateTaskPanel(arg_8_0.curUseNum)
		end

		return
	end, SFX_PANEL)

	local var_8_1 = GetOrAddComponent(arg_8_0.minusBtn, typeof(EventTriggerListener))

	var_8_1:AddPointDownFunc(function(arg_16_0, arg_16_1)
		arg_8_0.minusTimer = arg_8_0.minusTimer or Timer.New(function()
			if var_8_0 < 1 then
				var_8_0 = var_8_0 + 0.2
			else
				var_0()
			end

			return
		end, 0.2, -1, 1)

		arg_8_0.minusTimer:Start()

		return
	end)
	var_8_1:AddPointUpFunc(function(arg_18_0, arg_18_1)
		if arg_8_0.minusTimer then
			var_8_0 = 0

			arg_8_0.minusTimer:Stop()
		end

		return
	end)
	onButton(arg_8_0, arg_8_0.addBtn, function()
		if arg_8_0.curUseNum < arg_8_0.maxUseNum then
			arg_8_0.curUseNum = arg_8_0.curUseNum + 1

			setText(arg_8_0.useCountText, arg_8_0.curUseNum)
			arg_8_0:updateTaskPanel(arg_8_0.curUseNum)
		end

		return
	end, SFX_PANEL)

	local var_8_2 = GetOrAddComponent(arg_8_0.addBtn, typeof(EventTriggerListener))

	var_8_2:AddPointDownFunc(function(arg_20_0, arg_20_1)
		arg_8_0.addTimer = arg_8_0.addTimer or Timer.New(function()
			if var_8_0 < 1 then
				var_8_0 = var_8_0 + 0.2
			else
				var_0()
			end

			return
		end, 0.2, -1, 1)

		arg_8_0.addTimer:Start()

		return
	end)
	var_8_2:AddPointUpFunc(function(arg_22_0, arg_22_1)
		if arg_8_0.addTimer then
			var_8_0 = 0

			arg_8_0.addTimer:Stop()
		end

		return
	end)

	return
end

function var_0_0.initTaskPanel(arg_23_0)
	setText(arg_23_0.taskNameText, (arg_23_0.expTaskVO:getConfig("name")))
	setText(arg_23_0.taskText, string.split(arg_23_0.expTaskVO:getConfig("desc"), i18n("tech_catchup_sentence_pauses"))[2])

	local var_23_0 = arg_23_0.expTaskVO:getProgress()
	local var_23_1 = arg_23_0.expTaskVO:getConfig("target_num")

	setText(arg_23_0.expProgressText, i18n("tec_speedup_progress", math.floor(var_23_0 / 16), math.floor(var_23_1 / 16)))
	setSlider(arg_23_0.expProgressSlider, 0, 1, var_23_0 / var_23_1)
	setText(arg_23_0.progressNumText, math.floor(var_23_0 / var_23_1 * 100) .. "%")

	return
end

function var_0_0.updateTaskPanel(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0.expTaskVO:getConfig("target_num")
	local var_24_1 = arg_24_0.expTaskVO:getProgress() + arg_24_0.curUseNum * arg_24_0.itemExp

	setText(arg_24_0.expProgressText, i18n("tec_speedup_progress", math.floor(var_24_1 / 16), math.floor(var_24_0 / 16)))
	setSlider(arg_24_0.expProgressSlider, 0, 1, var_24_1 / var_24_0)
	setText(arg_24_0.progressNumText, math.floor(var_24_1 / var_24_0 * 100) .. "%")

	return
end

function var_0_0.initItem(arg_25_0)
	local var_25_0 = Item.getConfigData(arg_25_0.itemID)

	GetImageSpriteFromAtlasAsync(var_25_0.icon, "", arg_25_0.itemIcon)
	setText(arg_25_0.itemCountText, arg_25_0.bagProxy:getItemCountById(arg_25_0.itemID))
	setText(arg_25_0.itemNameText, var_25_0.name)

	return
end

function var_0_0.isExpOverFlow(arg_26_0)
	local var_26_0 = arg_26_0.expTaskVO:getConfig("target_num")
	local var_26_1 = arg_26_0.expTaskVO:getProgress() + arg_26_0.curUseNum * arg_26_0.itemExp

	return var_26_0 < var_26_1, var_26_1 - var_26_0
end

return var_0_0
