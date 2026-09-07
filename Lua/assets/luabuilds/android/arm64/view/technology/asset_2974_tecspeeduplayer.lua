local TecSpeedUpLayer = class("TecSpeedUpLayer", import("..base.BaseUI"))

function TecSpeedUpLayer:getUIName()
	return "TecSpeedUpUI"
end

function TecSpeedUpLayer:init()
	self:initData()
	self:findUI()
	self:addListener()
	self:initTaskPanel()
	self:initItem()
	setText(self.useCountText, 0)

	return
end

function TecSpeedUpLayer:didEnter()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	self:tryPlayGuide()

	return
end

function TecSpeedUpLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	if self.minusTimer then
		self.minusTimer:Stop()
	end

	if self.addTimer then
		self.addTimer:Stop(0)
	end

	return
end

function TecSpeedUpLayer:tryPlayGuide()
	pg.SystemGuideMgr.GetInstance():PlayByGuideId("NG0021")

	return
end

function TecSpeedUpLayer:initData()
	self.technologyProxy = getProxy(TechnologyProxy)
	self.taskProxy = getProxy(TaskProxy)
	self.bagProxy = getProxy(BagProxy)
	self.shipBluePrintOnDev = nil

	for iter_6_0, iter_6_1 in pairs((self.technologyProxy:getBluePrints())) do
		if iter_6_1:isDeving() then
			self.shipBluePrintOnDev = iter_6_1

			break
		end
	end

	local var_6_0 = self.shipBluePrintOnDev:getTaskIds()

	self.expTaskID = nil

	if self.shipBluePrintOnDev:getTaskStateById(var_6_0[1]) == ShipBluePrint.TASK_STATE_START then
		self.expTaskID = var_6_0[1]
	elseif self.shipBluePrintOnDev:getTaskStateById(var_6_0[4]) == ShipBluePrint.TASK_STATE_START then
		self.expTaskID = var_6_0[4]
	end

	self.expTaskVO = self.taskProxy:getTaskVO(self.expTaskID)
	self.bluePrintVersion = self.shipBluePrintOnDev:getConfig("blueprint_version")
	self.itemID = pg.gameset.technology_catchup_itemid.description[self.bluePrintVersion][1]
	self.itemExp = pg.gameset.technology_catchup_itemid.description[self.bluePrintVersion][2]
	self.curUseNum = 0
	self.maxUseNum = math.min(math.ceil((self.expTaskVO:getConfig("target_num") - self.expTaskVO:getProgress()) / self.itemExp), (self.bagProxy:getItemCountById(self.itemID)))

	return
end

function TecSpeedUpLayer:findUI()
	setText(self._tf:Find("Window/top/bg/obtain/title"), i18n("tec_speedup_title"))

	local var_7_0 = self._tf:Find("Window")

	self.backBtn = var_7_0:Find("top/btnBack")
	self.bg = self._tf:Find("BG")

	local var_7_1 = var_7_0:Find("Panel")
	local var_7_2 = var_7_1:Find("Task")

	self.taskNameText = var_7_2:Find("Name/Text")
	self.expProgressText = var_7_2:Find("ExpProgressText")
	self.expProgressSlider = var_7_2:Find("Slider")
	self.taskText = var_7_2:Find("TaskText")
	self.progressNumText = var_7_2:Find("ProgressNumText")

	local var_7_3 = var_7_1:Find("ItemPanel")

	self.itemIcon = var_7_3:Find("Item/Icon")
	self.itemCountText = var_7_3:Find("Item/CountText")
	self.itemNameText = var_7_3:Find("NameText")
	self.minusBtn = var_7_3:Find("UsePanel/MinusBtn")
	self.addBtn = var_7_3:Find("UsePanel/AddBtn")
	self.maxBtn = var_7_3:Find("UsePanel/MaxBtn")
	self.useCountText = var_7_3:Find("UsePanel/UseCountText")
	self.confirmBtn = var_7_0:Find("ConfirmBtn")
	self.helpBtn = var_7_0:Find("HelpBtn")
	self.helpPanel = var_7_0:Find("HelpPanel")
	self.helpText = self.helpPanel:Find("Text")

	setText(self.helpText, pg.gametip.tec_speedup_help_tip.tip)

	return
end

function TecSpeedUpLayer:addListener()
	onButton(self, self.backBtn, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.bg, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.confirmBtn, function()
		if self.curUseNum == 0 then
			return
		end

		local var_11_0, var_11_1 = self:isExpOverFlow()

		if self:isExpOverFlow() then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("tec_speedup_overflow", var_11_1),
				onYes = function()
					pg.m02:sendNotification(GAME.USE_TEC_SPEEDUP_ITEM, {
						blueprintid = self.shipBluePrintOnDev.id,
						itemid = self.itemID,
						number = self.curUseNum,
						taskID = self.expTaskID
					})

					return
				end
			})
		else
			pg.m02:sendNotification(GAME.USE_TEC_SPEEDUP_ITEM, {
				blueprintid = self.shipBluePrintOnDev.id,
				itemid = self.itemID,
				number = self.curUseNum,
				taskID = self.expTaskID
			})
		end

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn, function()
		if isActive(self.helpPanel) then
			setActive(self.helpPanel, false)
		else
			setActive(self.helpPanel, true)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.maxBtn, function()
		if self.curUseNum ~= self.maxUseNum then
			self.curUseNum = self.maxUseNum

			setText(self.useCountText, self.curUseNum)
			self:updateTaskPanel(self.curUseNum)
		end

		return
	end, SFX_PANEL)

	local var_8_0 = 0

	local function var_8_1()
		if self.curUseNum > 0 then
			self.curUseNum = self.curUseNum - 1

			setText(self.useCountText, self.curUseNum)
			self:updateTaskPanel(self.curUseNum)
		end

		return
	end

	onButton(self, self.minusBtn, var_8_1, SFX_PANEL)

	local var_8_2 = GetOrAddComponent(self.minusBtn, typeof(EventTriggerListener))

	var_8_2:AddPointDownFunc(function(arg_16_0, arg_16_1)
		self.minusTimer = self.minusTimer or Timer.New(function()
			if var_8_0 < 1 then
				var_8_0 = var_8_0 + 0.2
			else
				var_8_1()
			end

			return
		end, 0.2, -1, 1)

		self.minusTimer:Start()

		return
	end)
	var_8_2:AddPointUpFunc(function(arg_18_0, arg_18_1)
		if self.minusTimer then
			var_8_0 = 0

			self.minusTimer:Stop()
		end

		return
	end)

	local function var_8_3()
		if self.curUseNum < self.maxUseNum then
			self.curUseNum = self.curUseNum + 1

			setText(self.useCountText, self.curUseNum)
			self:updateTaskPanel(self.curUseNum)
		end

		return
	end

	onButton(self, self.addBtn, var_8_3, SFX_PANEL)

	local var_8_4 = GetOrAddComponent(self.addBtn, typeof(EventTriggerListener))

	var_8_4:AddPointDownFunc(function(arg_20_0, arg_20_1)
		self.addTimer = self.addTimer or Timer.New(function()
			if var_8_0 < 1 then
				var_8_0 = var_8_0 + 0.2
			else
				var_8_3()
			end

			return
		end, 0.2, -1, 1)

		self.addTimer:Start()

		return
	end)
	var_8_4:AddPointUpFunc(function(arg_22_0, arg_22_1)
		if self.addTimer then
			var_8_0 = 0

			self.addTimer:Stop()
		end

		return
	end)

	return
end

function TecSpeedUpLayer:initTaskPanel()
	setText(self.taskNameText, (self.expTaskVO:getConfig("name")))
	setText(self.taskText, string.split(self.expTaskVO:getConfig("desc"), i18n("tech_catchup_sentence_pauses"))[2])

	local var_23_0 = self.expTaskVO:getProgress()
	local var_23_1 = self.expTaskVO:getConfig("target_num")

	setText(self.expProgressText, i18n("tec_speedup_progress", math.floor(var_23_0 / 16), math.floor(var_23_1 / 16)))
	setSlider(self.expProgressSlider, 0, 1, var_23_0 / var_23_1)
	setText(self.progressNumText, math.floor(var_23_0 / var_23_1 * 100) .. "%")

	return
end

function TecSpeedUpLayer:updateTaskPanel(arg_24_1)
	local var_24_0 = self.expTaskVO:getConfig("target_num")
	local var_24_1 = self.expTaskVO:getProgress() + self.curUseNum * self.itemExp

	setText(self.expProgressText, i18n("tec_speedup_progress", math.floor(var_24_1 / 16), math.floor(var_24_0 / 16)))
	setSlider(self.expProgressSlider, 0, 1, var_24_1 / var_24_0)
	setText(self.progressNumText, math.floor(var_24_1 / var_24_0 * 100) .. "%")

	return
end

function TecSpeedUpLayer:initItem()
	local var_25_0 = Item.getConfigData(self.itemID)

	GetImageSpriteFromAtlasAsync(var_25_0.icon, "", self.itemIcon)
	setText(self.itemCountText, self.bagProxy:getItemCountById(self.itemID))
	setText(self.itemNameText, var_25_0.name)

	return
end

function TecSpeedUpLayer:isExpOverFlow()
	local var_26_0 = self.expTaskVO:getConfig("target_num")
	local var_26_1 = self.expTaskVO:getProgress() + self.curUseNum * self.itemExp

	return var_26_0 < var_26_1, var_26_1 - var_26_0
end

return TecSpeedUpLayer
