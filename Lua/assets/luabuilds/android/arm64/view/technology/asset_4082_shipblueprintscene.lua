local ShipBluePrintScene = class("ShipBluePrintScene", import("..base.BaseUI"))
local var_0_2 = pg.ship_data_template
local var_0_3 = pg.ship_data_breakout
local var_0_4 = 3
local var_0_5 = -10
local var_0_6 = 2.3
local var_0_7 = 0.3

function ShipBluePrintScene:getUIName()
	return "ShipBluePrintUI"
end

function ShipBluePrintScene:setVersion(arg_2_1)
	self.version = arg_2_1

	return
end

function ShipBluePrintScene:setShipVOs(arg_3_1)
	self.shipVOs = arg_3_1

	return
end

function ShipBluePrintScene:getShipById(arg_4_1)
	return self.shipVOs[arg_4_1]
end

function ShipBluePrintScene:setTaskVOs(arg_5_1)
	self.taskVOs = arg_5_1

	return
end

function ShipBluePrintScene:getTaskById(arg_6_1)
	return self.taskVOs[arg_6_1] or Task.New({
		id = arg_6_1
	})
end

function ShipBluePrintScene:getItemById(arg_7_1)
	local var_7_0 = getProxy(BagProxy):getItemById(arg_7_1)

	var_7_0 = var_7_0 or Item.New({
		count = 0,
		id = arg_7_1
	})

	return var_7_0
end

function ShipBluePrintScene:setShipBluePrints(arg_8_1)
	self.bluePrintByIds = arg_8_1

	return
end

function ShipBluePrintScene:updateShipBluePrintVO(arg_9_1)
	if arg_9_1 then
		self.bluePrintByIds[arg_9_1.id] = arg_9_1
	end

	self:initShips()

	return
end

function ShipBluePrintScene:init()
	self.main = self._tf:Find("main")
	self.centerPanel = self.main:Find("center_panel")
	self.blurPanel = self._tf:Find("blur_panel")
	self.top = self.blurPanel:Find("adapt")
	self.topPanel = self.top:Find("top")
	self.topBg = self.blurPanel:Find("top_bg")
	self.backBtn = self.top:Find("top/back")
	self.leftPanle = self.top:Find("left_panel")
	self.bottomPanel = self.top:Find("bottom_panel")
	self.rightPanel = self.top:Find("right_panel")
	self.shipContainer = self.bottomPanel:Find("ships/bg/content")
	self.shipTpl = self.bottomPanel:Find("ship_tpl")
	self.versionBtn = self.bottomPanel:Find("ships/bg/version/version_btn")
	self.eyeTF = self.leftPanle:Find("eye")
	self.painting = self._tf:Find("main/center_panel/painting")
	self.nameTF = self.centerPanel:Find("name")
	self.shipName = self.nameTF:Find("name_mask/Text")
	self.shipType = self.nameTF:Find("type")
	self.englishName = self.nameTF:Find("english_name")
	self.shipInfoStarTpl = self.nameTF:Find("star_tpl")

	setActive(self.shipInfoStarTpl, false)

	self.stars = self.nameTF:Find("stars")
	self.initBtn = self.leftPanle:Find("property_panel/btns/init_toggle")
	self.attrBtn = self.leftPanle:Find("property_panel/btns/attr_toggle")
	self.attrDisableBtn = self.leftPanle:Find("property_panel/btns/attr_toggle/disable")
	self.initPanel = self.leftPanle:Find("property_panel/init_panel")
	self.propertyPanel = PropertyPanel.New(self.initPanel, 32)

	setText(self.initPanel:Find("property_title1/Text"), i18n("blueprint_combatperformance"))
	setText(self.initPanel:Find("property_title2/Text"), i18n("blueprint_shipperformance"))

	self.skillRect = self.leftPanle:Find("property_panel/init_panel/skills_rect")
	self.skillPanel = self.leftPanle:Find("property_panel/init_panel/skills_rect/skills")
	self.skillTpl = self.skillPanel:Find("skilltpl")
	self.skillArrLeft = self.leftPanle:Find("property_panel/init_panel/arrow1")
	self.skillArrRight = self.leftPanle:Find("property_panel/init_panel/arrow2")
	self.simulationBtn = self.leftPanle:Find("property_panel/init_panel/property_title2/simulation")
	self.attrPanel = self.leftPanle:Find("property_panel/attr_panel")
	self.modAdditionPanel = self.leftPanle:Find("property_panel/attr_panel")
	self.modAdditionContainer = self.modAdditionPanel:Find("scroll_rect/content")
	self.modAdditionTpl = self.modAdditionContainer:Find("addition_tpl")
	self.preViewBtn = self.attrPanel:Find("pre_view")
	self.stateInfo = self.centerPanel:Find("state_info")
	self.startBtn = self.centerPanel:Find("state_info/start_btn")
	self.lockPanel = self.centerPanel:Find("state_info/lock_panel")
	self.lockBtn = self.lockPanel:Find("lock")
	self.finishedBtn = self.centerPanel:Find("state_info/finished_btn")
	self.progressPanel = self.centerPanel:Find("state_info/progress")

	setText(self.progressPanel:Find("label"), i18n("blueprint_researching"))

	self.progressContainer = self.progressPanel:Find("content")
	self.progressTpl = self.progressContainer:Find("item")
	self.openCondition = self.centerPanel:Find("state_info/open_condition")
	self.speedupBtn = self._tf:Find("main/speedup_btn")
	self.taskListPanel = self.rightPanel:Find("task_list")
	self.taskContainer = self.rightPanel:Find("task_list/scroll/content")
	self.taskTpl = self.taskContainer:Find("task_tpl")
	self.modPanel = self.rightPanel:Find("mod_panel")
	self.attrContainer = self.modPanel:Find("desc/atrrs")
	self.levelSlider = self.modPanel:Find("title/slider"):GetComponent(typeof(Slider))
	self.levelSliderTxt = self.modPanel:Find("title/slider/Text")
	self.preLevelSlider = self.modPanel:Find("title/pre_slider"):GetComponent(typeof(Slider))
	self.modLevel = self.modPanel:Find("title/level_bg/Text"):GetComponent(typeof(Text))
	self.needLevelTxt = self.modPanel:Find("title/Text"):GetComponent(typeof(Text))
	self.phantomPanel = self.rightPanel:Find("phantom_panel")
	self.rtPhantomQuestContainer = self.phantomPanel:Find("desc/content")
	self.questTpl = self.rtPhantomQuestContainer:GetChild(0)
	self.btnPhantom = self.top:Find("phantomBtn")
	self.calcPanel = self.modPanel:Find("desc/calc_panel")
	self.calcMinusBtn = self.calcPanel:Find("calc/base/minus")
	self.calcPlusBtn = self.calcPanel:Find("calc/base/plus")
	self.calcTxt = self.calcPanel:Find("calc/base/count/Text")
	self.calcMaxBtn = self.calcPanel:Find("calc/max")
	self.itemInfo = self.calcPanel:Find("item_bg")
	self.itemInfoIcon = self.itemInfo:Find("icon")
	self.itemInfoCount = self.itemInfo:Find("kc")
	self.modBtn = self.calcPanel:Find("confirm_btn")
	self.fittingBtn = self.modPanel:Find("desc/fitting_btn")
	self.fittingBtnEffect = self.fittingBtn:Find("anim/ShipBlue02")
	self.fittingPanel = self.rightPanel:Find("fitting_panel")

	setActive(self.fittingPanel, false)

	self.fittingAttrPanel = self.fittingPanel:Find("desc/middle")
	self.phasePic = self.fittingPanel:Find("title/phase")
	self.phaseSlider = self.fittingPanel:Find("desc/top/slider"):GetComponent(typeof(Slider))
	self.phaseSliderTxt = self.fittingPanel:Find("desc/top/precent")
	self.prePhaseSlider = self.fittingPanel:Find("desc/top/pre_slider"):GetComponent(typeof(Slider))
	self.fittingNeedMask = self.fittingPanel:Find("desc/top/mask")
	self.fittingCalcPanel = self.fittingPanel:Find("desc/bottom")
	self.fittingCalcMinusBtn = self.fittingCalcPanel:Find("calc/base/minus")
	self.fittingCalcPlusBtn = self.fittingCalcPanel:Find("calc/base/plus")
	self.fittingCalcTxt = self.fittingCalcPanel:Find("calc/base/count/Text")
	self.fittingCalcMaxBtn = self.fittingCalcPanel:Find("calc/max")
	self.fittingItemInfo = self.fittingCalcPanel:Find("item_bg")
	self.fittingItemInfoIcon = self.fittingItemInfo:Find("icon")
	self.fittingItemInfoCount = self.fittingItemInfo:Find("kc")
	self.fittingConfirmBtn = self.fittingCalcPanel:Find("confirm_btn")
	self.fittingCancelBtn = self.fittingCalcPanel:Find("cancel_btn")
	self.msgPanel = self.blurPanel:Find("msg_panel")

	setActive(self.msgPanel, false)

	self.versionPanel = self._tf:Find("version_panel")

	setActive(self.versionPanel, false)

	self.preViewer = self._tf:Find("preview")
	self.preViewerFrame = self._tf:Find("preview/frame")

	setText(self.preViewerFrame:Find("bg/title/Image"), i18n("word_preview"))
	setActive(self.preViewer, false)

	self.sea = self.preViewerFrame:Find("sea")
	self.rawImage = self.sea:GetComponent("RawImage")

	setActive(self.rawImage, false)

	self.seaLoading = self.preViewerFrame:Find("bg/loading")
	self.healTF = self._tf:Find("resources/heal")
	self.healTF.transform.localPosition = Vector3(-360, 50, 40)

	setActive(self.healTF, false)

	self.stages = self.preViewerFrame:Find("stageScrollRect/stages")
	self.breakView = self.preViewerFrame:Find("content/Text")
	self.previewAttrPanel = self._tf:Find("preview/attrs_panel/attr_panel")
	self.previewAttrContainer = self.previewAttrPanel:Find("content")

	setText(self._tf:Find("preview/attrs_panel/Text"), i18n("meta_energy_preview_tip"))
	setText(self._tf:Find("preview/attrs_panel/desc"), i18n("meta_energy_preview_title"))

	self.helpBtn = self.top:Find("helpBtn")
	self.exchangeBtn = self.top:Find("exchangeBtn")
	self.itemUnlockBtn = self.top:Find("itemUnlockBtn")
	self.bottomWidth = self.bottomPanel.rect.height
	self.topWidth = self.topPanel.rect.height * 2
	self.taskTFs = {}
	self.leanTweens = {}
	self.unlockPanel = self.blurPanel:Find("unlock_panel")

	setActive(self.unlockPanel, false)

	self.svQuickExchange = BlueprintQuickExchangeView.New(self._tf, self.event)

	return
end

function ShipBluePrintScene:didEnter()
	local var_11_0 = getProxy(TechnologyProxy):getConfigMaxVersion()

	if not self.contextData.shipBluePrintVO then
		local var_11_1 = {}

		for iter_11_0 = 1, var_11_0 do
			var_11_1[iter_11_0] = 0
		end

		for iter_11_1, iter_11_2 in pairs(self.bluePrintByIds) do
			local var_11_2 = iter_11_2:getConfig("blueprint_version")

			var_11_1[var_11_2] = var_11_1[var_11_2] + (iter_11_2.state == ShipBluePrint.STATE_UNLOCK and 1 or 0)

			if iter_11_2.state == ShipBluePrint.STATE_DEV then
				self.contextData.shipBluePrintVO = self.contextData.shipBluePrintVO or iter_11_2

				break
			end
		end

		if not self.contextData.shipBluePrintVO then
			for iter_11_3 = 1, var_11_0 do
				self.version = iter_11_3

				if var_11_1[iter_11_3] <= 4 then
					break
				end
			end

			self:emit(ShipBluePrintMediator.SET_TECHNOLOGY_VERSION, self.version)
		end
	end

	self:switchHide()
	self:initShips()
	onButton(self, self.speedupBtn, function()
		self:emit(ShipBluePrintMediator.ON_CLICK_SPEEDUP_BTN)

		return
	end, SFX_PANEL)
	onButton(self, self.backBtn, function()
		self:closeView()

		return
	end, SOUND_BACK)
	onButton(self, self.startBtn, function()
		if not self.contextData.shipBluePrintVO then
			return
		end

		self:emit(ShipBluePrintMediator.ON_START, self.contextData.shipBluePrintVO.id)

		return
	end, SFX_PANEL)
	onButton(self, self.finishedBtn, function()
		if not self.contextData.shipBluePrintVO then
			return
		end

		self:emit(ShipBluePrintMediator.ON_FINISHED, self.contextData.shipBluePrintVO.id)

		return
	end, SFX_PANEL)
	onButton(self, self.itemUnlockBtn, function()
		if not self.contextData.shipBluePrintVO then
			return
		end

		self:showUnlockPanel()

		return
	end, SFX_PANEL)
	onButton(self, self.preViewBtn, function()
		self:openPreView()

		return
	end, SFX_PANEL)
	onButton(self, self.seaLoading, function()
		if not self.previewer then
			self:showBarrage()
		end

		return
	end, SFX_PANEL)
	onButton(self, self.preViewer, function()
		self:closePreview()

		return
	end, SFX_PANEL)
	onButton(self, self.eyeTF, function()
		if self.isSwitchAnim then
			return
		end

		self:switchHide()
		self:switchState(var_0_7, not self.flag)

		return
	end, SFX_PANEL)
	onButton(self, self.main, function()
		if self.isSwitchAnim then
			return
		end

		if not self.flag then
			self:switchHide()
			self:switchState(var_0_7, not self.flag)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip[isActive(self.fittingPanel) and "help_shipblueprintui_luck" or "help_shipblueprintui"].tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.exchangeBtn, function()
		self.svQuickExchange:Load()
		self.svQuickExchange:ActionInvoke("Show")
		self.svQuickExchange:ActionInvoke("UpdateBlueprint", self.contextData.shipBluePrintVO)

		return
	end)
	setText(self.modPanel:Find("switch/Text"), i18n("tech_shadow_change_button_1"))
	onButton(self, self.modPanel:Find("switch"), function()
		self:switchState(var_0_7, true, function()
			self.isPhantom = true

			setActive(self.phantomPanel, self.isPhantom)
			setActive(self.modPanel, not self.isPhantom)

			return
		end)

		return
	end, SFX_PANEL)
	setText(self.phantomPanel:Find("switch/Text"), i18n("tech_shadow_change_button_2"))
	onButton(self, self.phantomPanel:Find("switch"), function()
		self:switchState(var_0_7, true, function()
			self.isPhantom = false

			setActive(self.phantomPanel, self.isPhantom)
			setActive(self.modPanel, not self.isPhantom)

			return
		end)

		return
	end, SFX_PANEL)
	onButton(self, self.btnPhantom, function()
		self:emit(ShipBluePrintMediator.OPEN_PHANTOM_LAYER, self.version)

		return
	end, SFX_PANEL)
	self:OverlayPanel(self.blurPanel, {
		pbList = {
			self.rightPanel:Find("task_list"),
			self.rightPanel:Find("mod_panel"),
			self.leftPanle:Find("property_panel"),
			self.bottomPanel:Find("ships/bg")
		}
	})
	setText(self.msgPanel:Find("window/top/bg/infomation/title"), i18n("title_info"))
	onButton(self, self.msgPanel:Find("window/top/btnBack"), function()
		pg.UIMgr.GetInstance():UnOverlayPanel(self.msgPanel, self.top)
		setActive(self.msgPanel, false)

		return
	end, SFX_CANCEL)
	setText(self.msgPanel:Find("window/confirm_btn/Text"), i18n("text_confirm"))
	onButton(self, self.msgPanel:Find("window/confirm_btn"), function()
		pg.UIMgr.GetInstance():UnOverlayPanel(self.msgPanel, self.top)
		setActive(self.msgPanel, false)

		return
	end, SFX_CANCEL)
	onButton(self, self.msgPanel:Find("bg"), function()
		pg.UIMgr.GetInstance():UnOverlayPanel(self.msgPanel, self.top)
		setActive(self.msgPanel, false)

		return
	end, SFX_CANCEL)
	onButton(self, self.unlockPanel:Find("window/top/btnBack"), function()
		pg.UIMgr.GetInstance():UnOverlayPanel(self.unlockPanel, self.top)
		setActive(self.unlockPanel, false)

		return
	end, SFX_CANCEL)
	setText(self.unlockPanel:Find("window/confirm_btn/Text"), i18n("text_confirm"))
	setText(self.unlockPanel:Find("window/cancel_btn/Text"), i18n("text_cancel"))
	setText(self.unlockPanel:Find("window/top/bg/infomation/title"), i18n("title_info"))
	onButton(self, self.unlockPanel:Find("window/cancel_btn"), function()
		pg.UIMgr.GetInstance():UnOverlayPanel(self.unlockPanel, self.top)
		setActive(self.unlockPanel, false)

		return
	end, SFX_CANCEL)
	onButton(self, self.unlockPanel:Find("bg"), function()
		pg.UIMgr.GetInstance():UnOverlayPanel(self.unlockPanel, self.top)
		setActive(self.unlockPanel, false)

		return
	end, SFX_CANCEL)
	GetImageSpriteFromAtlasAsync("ui/shipblueprintui_atlas", "version_" .. self.version, self.versionBtn)
	self:updateVersionBtnTip()

	if var_11_0 > 1 then
		onButton(self, self.versionBtn, function()
			if self.cbTimer then
				return
			end

			setActive(self.versionPanel, true)
			pg.UIMgr.GetInstance():BlurPanel(self.versionPanel)

			return
		end, SFX_PANEL)
		onButton(self, self.versionPanel:Find("bg"), function()
			pg.UIMgr.GetInstance():UnOverlayPanel(self.versionPanel, self._tf)
			setActive(self.versionPanel, false)

			return
		end, SFX_CANCEL)

		local var_11_3 = UIItemList.New(self.versionPanel:Find("window/content"), self.versionPanel:Find("window/content/version_1"))

		var_11_3:make(function(arg_37_0, arg_37_1, arg_37_2)
			arg_37_1 = arg_37_1 + 1

			if arg_37_0 == UIItemList.EventUpdate then
				arg_37_2.name = "version_" .. arg_37_1

				GetImageSpriteFromAtlasAsync("ui/shipblueprintui_atlas", "newVersion_" .. arg_37_1, arg_37_2:Find("image"))

				if self.version == arg_37_1 then
					setActive(arg_37_2:Find("choose"), true)
				else
					setActive(arg_37_2:Find("choose"), false)
				end

				onButton(self, arg_37_2, function()
					self.version = arg_37_1

					self:emit(ShipBluePrintMediator.SET_TECHNOLOGY_VERSION, self.version)

					self.contextData.shipBluePrintVO = nil

					GetImageSpriteFromAtlasAsync("ui/shipblueprintui_atlas", "version_" .. self.version, self.versionBtn)
					self:initShips()
					self:updateVersionBtnTip()
					var_11_3:align(var_11_0)
					pg.UIMgr.GetInstance():UnOverlayPanel(self.versionPanel, self._tf)
					setActive(self.versionPanel, false)

					return
				end, SFX_CANCEL)
			end

			return
		end)
		var_11_3:align(var_11_0)
		self:updateVersionPanelBtnTip()
	end

	LeanTween.alpha(rtf(self.skillArrLeft), 0.25, 1):setEase(LeanTweenType.easeInOutSine):setLoopPingPong()
	LeanTween.alpha(rtf(self.skillArrRight), 0.25, 1):setEase(LeanTweenType.easeInOutSine):setLoopPingPong()

	return
end

function ShipBluePrintScene:updateVersionBtnTip()
	local var_39_0 = getProxy(TechnologyProxy)
	local var_39_1 = {}

	for iter_39_0 = 1, var_39_0:getConfigMaxVersion() do
		if iter_39_0 ~= self.version then
			table.insert(var_39_1, iter_39_0)
		end
	end

	setActive(self.versionBtn:Find("tip"), var_39_0:CheckPursuingCostTip(var_39_1))

	return
end

function ShipBluePrintScene:updateVersionPanelBtnTip()
	local var_40_0 = getProxy(TechnologyProxy)

	for iter_40_0 = 1, var_40_0:getConfigMaxVersion() do
		setActive(self.versionPanel:Find("window/content/version_" .. iter_40_0 .. "/tip"), var_40_0:CheckPursuingCostTip({
			iter_40_0
		}))
	end

	return
end

function ShipBluePrintScene:updateAllPursuingCostTip()
	self:updateVersionBtnTip()
	self:updateVersionPanelBtnTip()

	for iter_41_0, iter_41_1 in pairs(self.bluePrintItems) do
		iter_41_1:updatePursuingTip()
	end

	return
end

function ShipBluePrintScene:switchHide()
	local var_42_0 = not self.flag

	LeanTween.cancel(self.bottomPanel)
	LeanTween.cancel(self.topPanel)
	LeanTween.cancel(self.topBg)

	if var_42_0 then
		LeanTween.moveY(self.bottomPanel, 0, var_0_7)
		LeanTween.moveY(self.topPanel, 0, var_0_7)
		LeanTween.moveY(self.topBg, 0, var_0_7)
	else
		LeanTween.moveY(self.bottomPanel, -self.bottomWidth, var_0_7)
		LeanTween.moveY(self.topPanel, self.topWidth, var_0_7)
		LeanTween.moveY(self.topBg, self.topWidth, var_0_7)
	end

	setActive(self.nameTF, var_42_0)
	setActive(self.stateInfo, var_42_0)
	setActive(self.helpBtn, var_42_0)
	setActive(self.exchangeBtn, var_42_0)
	setActive(self.btnPhantom, var_42_0)
	setImageAlpha(self.itemUnlockBtn, var_42_0 and 1 or 0)
	setImageRaycastTarget(self.itemUnlockBtn, var_42_0)
	setImageAlpha(self.speedupBtn, var_42_0 and 1 or 0)
	setImageRaycastTarget(self.speedupBtn, var_42_0)

	return
end

function ShipBluePrintScene:switchState(arg_43_1, arg_43_2, arg_43_3, arg_43_4)
	local var_43_0 = {}

	if self.flag then
		table.insert(var_43_0, function(arg_44_0)
			self.flag = false

			self:switchUI(arg_43_1, {
				-self.leftPanle.rect.width - 16,
				self.rightPanel.rect.width + 16
			}, arg_44_0)

			return
		end)
	end

	table.insert(var_43_0, function(arg_45_0)
		existCall(arg_43_3)

		return arg_45_0()
	end)

	if arg_43_2 then
		table.insert(var_43_0, function(arg_46_0)
			self.flag = true

			if self.isFate or self.isPhantom then
				self:switchUI(arg_43_1, {
					-self.leftPanle.rect.width - 16,
					0,
					-self.leftPanle.rect.width / 2
				}, arg_46_0)
			else
				self:switchUI(arg_43_1, {
					0,
					0,
					0
				}, arg_46_0)
			end

			return
		end)
	end

	seriesAsync(var_43_0, arg_43_4)

	return
end

function ShipBluePrintScene:switchUI(arg_47_1, arg_47_2, arg_47_3)
	LeanTween.cancel(self.leftPanle)
	LeanTween.cancel(self.rightPanel)
	LeanTween.cancel(self.centerPanel)

	self.isSwitchAnim = true

	parallelAsync({
		function(arg_48_0)
			LeanTween.moveX(self.leftPanle, arg_47_2[1], arg_47_1):setOnComplete(System.Action(arg_48_0))

			return
		end,
		function(arg_49_0)
			LeanTween.moveX(self.rightPanel, arg_47_2[2], arg_47_1):setOnComplete(System.Action(arg_49_0))

			return
		end,
		function(arg_50_0)
			if arg_47_2[3] then
				LeanTween.moveX(self.centerPanel, arg_47_2[3], arg_47_1):setOnComplete(System.Action(arg_50_0))
			else
				arg_50_0()
			end

			return
		end
	}, function()
		self.isSwitchAnim = false

		return arg_47_3()
	end)

	return
end

function ShipBluePrintScene:createShipItem(arg_52_1)
	local var_52_0 = {
		init = function(self)
			self._go = arg_52_1
			self._tf = tf(arg_52_1)
			self.icon = self._tf:Find("icon")
			self.state = self._tf:Find("state")
			self.count = self._tf:Find("count")
			self.tip = self._tf:Find("tip")

			return
		end,
		update = function(self, arg_54_1, arg_54_2)
			SetCompomentEnabled(self._tf, typeof(Toggle), arg_54_1.id > 0)

			self.shipBluePrintVO = arg_54_1

			setActive(self.state, self.shipBluePrintVO.id > 0)
			setActive(self.count, self.shipBluePrintVO.id > 0)

			if self.shipBluePrintVO.id > 0 then
				LoadSpriteAsync("shipdesignicon/" .. self.shipBluePrintVO:getShipVO():getPainting(), function(arg_55_0)
					if self.shipBluePrintVO.id > 0 then
						if string.find(arg_55_0.name, self.shipBluePrintVO:getShipVO():getPainting()) then
							setImageSprite(self.icon, arg_55_0)
						end
					end

					return
				end)

				local var_54_0 = {
					tip = false,
					pursuing = arg_54_1:isPursuing(),
					fate = arg_54_1:canFateSimulation()
				}

				switch(arg_54_1.state, {
					[ShipBluePrint.STATE_LOCK] = function()
						var_54_0.state = "lock" .. (arg_54_1:getUnlockItem() and "_item" or "")

						return
					end,
					[ShipBluePrint.STATE_DEV] = function()
						var_54_0.state = "research"

						return
					end,
					[ShipBluePrint.STATE_DEV_FINISHED] = function()
						var_54_0.state = var_54_0.fate and "fate" or "dev"
						var_54_0.tip = true

						return
					end,
					[ShipBluePrint.STATE_UNLOCK] = function()
						var_54_0.state = var_54_0.fate and "fate" or "dev"

						return
					end
				})
				setText(self.count, arg_54_2.count > 999 and "999+" or arg_54_2.count)
				setActive(self.count:Find("icon"), not var_54_0.pursuing)
				setActive(self.count:Find("icon_2"), var_54_0.pursuing)
				setText(self.state:Find("dev/Text"), self.shipBluePrintVO.level)

				if var_54_0.fate then
					GetImageSpriteFromAtlasAsync("ui/shipblueprintui_atlas", "icon_phase_" .. self.shipBluePrintVO.fateLevel, self.state:Find("fate/Image"), true)
				end

				eachChild(self.state, function(arg_60_0)
					setActive(arg_60_0, arg_60_0.name == var_54_0.state)

					return
				end)
				setActive(self.tip, var_54_0.tip)
			else
				LoadSpriteAsync("shipdesignicon/empty", function(arg_61_0)
					if self.shipBluePrintVO.id < 0 then
						setImageSprite(self.icon, arg_61_0)
					end

					return
				end)
				setActive(self.tip, false)
			end

			return
		end,
		updateSelectedStyle = function(self, arg_62_1)
			local var_62_0 = arg_62_1 and 0 or -25

			LeanTween.cancel(self.icon)
			LeanTween.moveY(self.icon, var_62_0, 0.1)

			return
		end,
		updatePursuingTip = function(self)
			setActive(self.count:Find("icon_2/tip"), self.shipBluePrintVO.id > 0 and self.shipBluePrintVO:isPursuingCostTip())

			return
		end
	}

	var_52_0:init()
	onButton(self, var_52_0.count:Find("icon_2"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("blueprint_catchup_by_gold_help")
		})

		return
	end, SFX_PANEL)

	return var_52_0
end

function ShipBluePrintScene:initShips()
	self:checkStory()
	self:filterBlueprints()

	if not self.itemList then
		self.bluePrintItems = {}
		self.itemList = UIItemList.New(self.shipContainer, self.shipContainer:Find("ship_tpl"))

		self.itemList:make(function(arg_66_0, arg_66_1, arg_66_2)
			if arg_66_0 == UIItemList.EventUpdate then
				onToggle(self, arg_66_2, function(arg_67_0)
					if arg_67_0 then
						if self.cbTimer then
							self.cbTimer:Stop()

							self.cbTimer = nil
						end

						self:clearLeanTween()

						self.contextData.shipBluePrintVO = self.bluePrintItems[arg_66_2].shipBluePrintVO

						if self.nowShipId ~= self.contextData.shipBluePrintVO.id then
							self.nowShipId = self.contextData.shipBluePrintVO.id

							self:switchState(var_0_7, true, function()
								self:setSelectedBluePrint()

								return
							end)
						else
							self:setSelectedBluePrint()
						end
					end

					self.bluePrintItems[arg_66_2]:updateSelectedStyle(arg_67_0)

					return
				end, SFX_PANEL)

				self.bluePrintItems[arg_66_2] = self.bluePrintItems[arg_66_2] or self:createShipItem(arg_66_2)

				if self.filterBlueprintVOs[arg_66_1 + 1].id > 0 then
					self.bluePrintItems[arg_66_2]:update(self.filterBlueprintVOs[arg_66_1 + 1], (self:getItemById((self.filterBlueprintVOs[arg_66_1 + 1]:getItemId()))))
					self.bluePrintItems[arg_66_2]:updatePursuingTip()
				else
					self.bluePrintItems[arg_66_2]:update(self.filterBlueprintVOs[arg_66_1 + 1], nil)
				end

				triggerToggle(arg_66_2, false)
			end

			return
		end)
	end

	setActive(self.shipContainer, false)
	self.itemList:align(#self.filterBlueprintVOs)
	setActive(self.shipContainer, true)

	if not self.contextData.shipBluePrintVO or underscore.all(self.filterBlueprintVOs, function(arg_69_0)
		return self.contextData.shipBluePrintVO.id ~= arg_69_0.id
	end) then
		self.contextData.shipBluePrintVO = self.filterBlueprintVOs[1]
	end

	eachChild(self.shipContainer, function(arg_70_0)
		if self.contextData.shipBluePrintVO.id == self.bluePrintItems[arg_70_0].shipBluePrintVO.id then
			triggerToggle(arg_70_0, true)
		end

		return
	end)

	return
end

function ShipBluePrintScene:filterBlueprints()
	if self.contextData.shipBluePrintVO then
		self.version = self.contextData.shipBluePrintVO:getConfig("blueprint_version")

		self:emit(ShipBluePrintMediator.SET_TECHNOLOGY_VERSION, self.version)
	end

	self.filterBlueprintVOs = {}

	local var_71_0 = 0

	for iter_71_0, iter_71_1 in pairs(self.bluePrintByIds) do
		if iter_71_1:getConfig("blueprint_version") == self.version then
			table.insert(self.filterBlueprintVOs, iter_71_1)

			var_71_0 = var_71_0 + 1
		end
	end

	for iter_71_2 = var_71_0, 5 do
		table.insert(self.filterBlueprintVOs, {
			id = -1,
			state = -1
		})
	end

	table.sort(self.filterBlueprintVOs, CompareFuncs({
		function(arg_72_0)
			return -arg_72_0.state
		end,
		function(arg_73_0)
			return arg_73_0.id
		end
	}))

	return
end

function ShipBluePrintScene:setSelectedBluePrint()
	assert(self.contextData.shipBluePrintVO, "should exist blue print")

	local var_74_0 = self.contextData.shipBluePrintVO

	self:updateInfo()
	self:updatePainting()
	self:updateProperty()

	local var_74_1 = var_74_0:isUnlock()

	setActive(self.taskListPanel, not var_74_1)
	setActive(self.attrDisableBtn, not var_74_1)

	if var_74_1 then
		if var_74_0:canFateSimulation() then
			if not pg.NewStoryMgr.GetInstance():IsPlayed(var_74_0:getConfig("luck_story")) then
				self.isFate = false
			end
		end

		self:updateMod()
		self:updatePhantomQuest()
	else
		self.isFate = false

		self:updateTaskList()
		triggerToggle(self.initBtn, true)
	end

	setActive(self.phantomPanel, var_74_1 and self.isPhantom)
	setActive(self.fittingPanel, var_74_1 and self.isFate)
	setActive(self.modPanel, var_74_1 and not self.isFate and not self.isPhantom)
	setActive(self.itemUnlockBtn, not var_74_1 and var_74_0:getUnlockItem())

	if var_74_0:isDeving() then
		self:emit(ShipBluePrintMediator.ON_CHECK_TAKES, var_74_0.id)
	end

	return
end

function ShipBluePrintScene:updateMod()
	if self.noUpdateMod then
		return
	end

	local var_75_0 = self.contextData.shipBluePrintVO

	if not self.contextData.shipBluePrintVO or not var_75_0:isUnlock() or not var_75_0:isFetched() then
		return
	end

	self:updateModPanel()
	self:updateModAdditionPanel()

	return
end

function ShipBluePrintScene:updateModInfo(arg_76_1)
	local var_76_0 = self:getShipById(arg_76_1.shipId)
	local var_76_1 = self.contextData.shipBluePrintVO
	local var_76_2 = intProperties(self.contextData.shipBluePrintVO:getShipProperties(var_76_0))
	local var_76_3 = Clone(arg_76_1)

	var_76_3.level = var_76_3:getMaxLevel()

	local var_76_4 = intProperties(var_76_3:getShipProperties(var_76_0))

	local function var_76_5(arg_77_0, arg_77_1, arg_77_2, arg_77_3)
		local var_77_0 = arg_77_0:Find("pre_slider"):GetComponent(typeof(Slider))

		if arg_76_1:isMaxLevel() then
			arg_77_3 = arg_77_2
		end

		setText(arg_77_0:Find("attr_bg/max"), arg_77_3)
		setText(arg_77_0:Find("attr_bg/name"), AttributeType.Type2Name(arg_77_1))
		setText(arg_77_0:Find("attr_bg/value"), arg_77_2)

		local var_77_1, var_77_2 = var_76_1:getBluePrintAddition(arg_77_1)
		local var_77_3 = table.indexof(ShipModAttr.BLUEPRINT_ATTRS, arg_77_1)
		local var_77_4 = var_76_1:getExpRetio(var_77_3)

		arg_77_0:Find("slider"):GetComponent(typeof(Slider)).value = var_77_2 / var_77_4

		local var_77_5, var_77_6 = arg_76_1:getBluePrintAddition(arg_77_1)
		local var_77_7 = arg_76_1:getExpRetio(var_77_3)

		setText(arg_77_0:Find("exp"), math.floor(var_77_6) .. "/" .. var_77_4)

		var_77_0.value = math.floor(var_77_5) > math.floor(var_77_1) and 1 or var_77_6 / var_77_7

		return
	end

	for iter_76_0, iter_76_1 in pairs((intProperties(arg_76_1:getShipProperties(var_76_0)))) do
		if table.contains(ShipModAttr.BLUEPRINT_ATTRS, iter_76_0) then
			var_76_5(self.attrContainer:Find(iter_76_0), iter_76_0, iter_76_1, var_76_4[iter_76_0] or 0)
		end
	end

	self.modLevel.text = self:formatModLvTxt(arg_76_1.level, arg_76_1:getMaxLevel())

	local var_76_9 = var_76_1:getNextLevelExp()

	self.levelSlider.value = var_76_9 == -1 and 1 or var_76_1.exp / var_76_9

	local var_76_10 = arg_76_1:getNextLevelExp()

	if var_76_10 == -1 then
		setText(self.levelSliderTxt, "MAX")

		self.preLevelSlider.value = 1
	else
		setText(self.levelSliderTxt, arg_76_1.exp .. "/" .. arg_76_1:getNextLevelExp())

		self.preLevelSlider.value = arg_76_1.level > var_76_1.level and 1 or arg_76_1.exp / var_76_10
	end

	local var_76_11, var_76_12 = arg_76_1:isShipModMaxLevel(var_76_0)

	setActive(self.needLevelTxt, var_76_11)
	setActive(self.levelSliderTxt, not var_76_11)

	if var_76_11 then
		setText(self.needLevelTxt, i18n("buleprint_need_level_tip", var_76_12))

		self.levelSlider.value = 1
	end

	return
end

function ShipBluePrintScene:inModAnim()
	return self.inAnim
end

function ShipBluePrintScene:formatModLvTxt(arg_79_1, arg_79_2)
	return "<size=45>" .. arg_79_1 .. "</size>/<size=27>" .. arg_79_2 .. "</size>"
end

local var_0_8 = 0.2

function ShipBluePrintScene:doModAnim(arg_80_1, arg_80_2)
	self:clearLeanTween()

	self.inAnim = true

	local var_80_0 = {}
	local var_80_1 = arg_80_2:getMaxLevel()

	if arg_80_1.level ~= var_80_1 then
		local function var_80_2(arg_81_0, arg_81_1, arg_81_2)
			arg_81_0 = Clone(arg_81_0)
			arg_81_0.level = arg_81_1
			arg_81_0.exp = arg_81_2

			return arg_81_0
		end

		self.preLevelSlider.value = 0

		for iter_80_0 = arg_80_1.level, arg_80_2.level do
			local var_80_3 = iter_80_0 == arg_80_1.level and arg_80_1.exp / arg_80_1:getNextLevelExp() or 0
			local var_80_4 = iter_80_0 == arg_80_2.level and arg_80_2.level ~= var_80_1 and arg_80_2.exp / arg_80_2:getNextLevelExp() or 1

			table.insert(var_80_0, function(arg_82_0)
				TweenValue(go(self.levelSlider), var_80_3, var_80_4, var_0_8, nil, function(arg_83_0)
					self.levelSlider.value = arg_83_0

					return
				end, function()
					local var_84_0

					if iter_80_0 == arg_80_1.level then
						var_84_0 = arg_80_1 or var_80_2(arg_80_1, iter_80_0, 0)

						local var_84_1

						if iter_80_0 == arg_80_2.level then
							var_84_1 = arg_80_2 or var_80_2(arg_80_1, iter_80_0 + 1, 0)
						end
					end

					self:doAttrsAinm(var_84_0, var_84_1, arg_82_0)

					self.modLevel.text = self:formatModLvTxt(var_84_1.level, var_80_1)

					return
				end)

				return
			end)
		end

		table.insert(self.leanTweens, self.levelSlider)
	else
		var_80_1 = arg_80_2:getMaxFateLevel()

		local function var_80_5(arg_85_0, arg_85_1, arg_85_2)
			arg_85_0 = Clone(arg_85_0)
			arg_85_0.fateLevel = arg_85_1
			arg_85_0.exp = arg_85_2

			return arg_85_0
		end

		self.prePhaseSlider.value = 0

		for iter_80_1 = arg_80_1.fateLevel, arg_80_2.fateLevel do
			local var_80_6 = iter_80_1 == arg_80_1.fateLevel and arg_80_1.exp / arg_80_1:getNextFateLevelExp() or 0
			local var_80_7 = iter_80_1 == arg_80_2.fateLevel and arg_80_2.fateLevel ~= var_80_1 and arg_80_2.exp / arg_80_2:getNextFateLevelExp() or 1

			table.insert(var_80_0, function(arg_86_0)
				TweenValue(go(self.phaseSlider), var_80_6, var_80_7, var_0_8, nil, function(arg_87_0)
					self.phaseSlider.value = arg_87_0

					return
				end, function()
					if iter_80_1 ~= arg_80_1.fateLevel or not arg_80_1 then
						local var_88_0 = var_80_5(arg_80_1, iter_80_1, 0)
					end

					local var_88_1

					if iter_80_1 == arg_80_2.fateLevel then
						var_88_1 = arg_80_2 or var_80_5(arg_80_1, iter_80_1 + 1, 0)
					end

					self:updateFittingAttrPanel(var_88_1)
					GetImageSpriteFromAtlasAsync("ui/shipblueprintui_atlas", "phase_" .. math.min(var_88_1.fateLevel + 1, var_88_1:getMaxFateLevel()), self.phasePic, true)
					arg_86_0()

					return
				end)

				return
			end)
		end

		table.insert(self.leanTweens, self.phaseSlider)
	end

	seriesAsync(var_80_0, function()
		self.noUpdateMod = false

		self:updateMod()

		self.inAnim = false

		return
	end)

	return
end

function ShipBluePrintScene:doAttrsAinm(arg_90_1, arg_90_2, arg_90_3)
	local var_90_0 = {}
	local var_90_1 = self:getShipById(arg_90_1.shipId)
	local var_90_2 = intProperties(arg_90_1:getShipProperties(var_90_1))
	local var_90_3 = intProperties(arg_90_2:getShipProperties(var_90_1))

	for iter_90_0, iter_90_1 in ipairs(ShipModAttr.BLUEPRINT_ATTRS) do
		if iter_90_1 ~= AttributeType.AntiAircraft then
			local var_90_4 = self.attrContainer:Find(iter_90_1)
			local var_90_5 = var_90_4:Find("attr_bg/value")
			local var_90_6 = var_90_5:GetComponent(typeof(Text))
			local var_90_7 = var_90_4:Find("slider"):GetComponent(typeof(Slider))
			local var_90_8 = var_90_4:Find("pre_slider").GetComponent(var_90_5, typeof(Slider))
			local var_90_9 = arg_90_1:getExpRetio((table.indexof(ShipModAttr.BLUEPRINT_ATTRS, iter_90_1)))
			local var_90_10 = var_90_2[iter_90_1]
			local var_90_11 = var_90_3[iter_90_1]
			local var_90_12, var_90_13 = arg_90_1:getBluePrintAddition(iter_90_1)
			local var_90_14, var_90_15 = arg_90_2:getBluePrintAddition(iter_90_1)
			local var_90_16 = var_90_13 / var_90_9
			local var_90_17 = var_90_15 / var_90_9

			var_90_8.value = 0

			table.insert(var_90_0, function(arg_91_0)
				self:doAttrAnim(var_90_7, var_90_6, var_90_16, var_90_17, math.floor(var_90_12), math.floor(var_90_14), var_90_10, var_90_11, arg_91_0)

				return
			end)
		end
	end

	parallelAsync(var_90_0, arg_90_3)

	return
end

local var_0_9 = 0.1

function ShipBluePrintScene:doAttrAnim(arg_92_1, arg_92_2, arg_92_3, arg_92_4, arg_92_5, arg_92_6, arg_92_7, arg_92_8, arg_92_9)
	table.insert(self.leanTweens, arg_92_1)

	local var_92_0 = {}

	for iter_92_0 = arg_92_5, arg_92_6 do
		local var_92_1 = iter_92_0 == arg_92_5 and arg_92_3 or 0
		local var_92_2 = iter_92_0 == arg_92_6 and arg_92_4 or 1

		table.insert(var_92_0, function(arg_93_0)
			TweenValue(go(arg_92_1), var_92_1, var_92_2, var_0_9, nil, function(arg_94_0)
				arg_92_1.value = arg_94_0

				return
			end, function()
				arg_92_2.text = arg_92_8 - math.min(arg_92_6 - iter_92_0, arg_92_8 - arg_92_7)

				arg_93_0()

				return
			end)

			return
		end)
	end

	seriesAsync(var_92_0, function()
		arg_92_9()

		return
	end)

	return
end

function ShipBluePrintScene:clearLeanTween(arg_97_1)
	for iter_97_0, iter_97_1 in pairs(self.leanTweens) do
		if LeanTween.isTweening(go(iter_97_1)) then
			LeanTween.cancel(go(iter_97_1))
		end
	end

	if self.inAnim then
		self.inAnim = nil

		if not arg_97_1 then
			self.noUpdateMod = false
		end
	end

	self.leanTweens = {}

	return
end

function ShipBluePrintScene:updateModPanel()
	local var_98_0 = self.contextData.shipBluePrintVO
	local var_98_1 = self:getShipById(self.contextData.shipBluePrintVO.shipId)
	local var_98_2 = self:getItemById((self.contextData.shipBluePrintVO:getConfig("strengthen_item")))
	local var_98_3 = var_98_2.count == 0 and var_98_0:isPursuing()
	local var_98_4 = 0
	local var_98_5
	local var_98_6

	if var_98_3 then
		local var_98_7 = getProxy(TechnologyProxy)

		var_98_5 = math.min(var_98_7:calcMaxPursuingCount(var_98_0), var_98_0:getUseageMaxItem())

		function var_98_6(arg_99_0)
			local var_99_0 = Clone(var_98_0)

			var_99_0:addExp(arg_99_0 * var_98_0:getItemExp())
			self:updateModInfo(var_99_0)
			setText(self.calcTxt, arg_99_0)

			local var_99_1 = var_98_0:isRarityUR()
			local var_99_2 = TechnologyProxy.getPursuingDiscount(var_98_7:getPursuingTimes(var_99_1) + var_98_4 + 1, var_99_1)

			setText(self.itemInfoIcon:Find("icon_bg/count"), var_98_0:getPursuingPrice(var_99_2))
			setActive(self.itemInfo:Find("no_cost"), var_99_2 == 0)
			setActive(self.itemInfo:Find("discount"), var_99_2 > 0 and var_99_2 < 100)

			if var_99_2 > 0 and var_99_2 < 100 then
				setText(self.itemInfo:Find("discount/Text"), 100 - var_99_2 .. "%OFF")
			end

			setActive(self.modBtn:Find("pursuing_cost"), var_98_4 > 0)
			setText(self.modBtn:Find("pursuing_cost/Text"), var_98_7:calcPursuingCost(var_98_0, arg_99_0))

			return
		end

		local var_98_8 = {
			type = DROP_TYPE_RESOURCE,
			id = PlayerConst.ResGold
		}

		updateDrop(self.itemInfoIcon, var_98_8)
		onButton(self, self.itemInfoIcon, function()
			if LOCK_TECHNOLOGY_PURSUING_TIP then
				self:emit(BaseUI.ON_DROP, var_98_8)
			else
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_HELP,
					helps = i18n("blueprint_catchup_by_gold_help")
				})
			end

			return
		end, SFX_PANEL)
		setScrollText(findTF(self.itemInfo, "name/Text"), var_98_8:getConfig("name"))
		setText(self.itemInfoCount, i18n("tec_tip_material_stock") .. ":" .. getProxy(PlayerProxy):getRawData():getResource(PlayerConst.ResGold))
		setText(self.itemInfo:Find("no_cost/Text"), i18n("tec_tip_no_consumption"))
		setText(self.modBtn:Find("pursuing_cost/word"), i18n("tec_tip_to_consumption"))
		onButton(self, self.modBtn, function()
			if self:inModAnim() then
				return
			end

			if var_98_4 == 0 then
				return
			end

			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("blueprint_catchup_by_gold_confirm", var_98_7:calcPursuingCost(var_98_0, var_98_4)),
				onYes = function()
					self:emit(ShipBluePrintMediator.ON_PURSUING, var_98_0.id, var_98_4)

					return
				end
			})

			return
		end, SFX_PANEL)
	else
		var_98_5 = math.min(var_98_2.count, var_98_0:getUseageMaxItem())

		function var_98_6(arg_103_0)
			local var_103_0 = Clone(var_98_0)

			var_103_0:addExp(arg_103_0 * var_98_0:getItemExp())
			self:updateModInfo(var_103_0)
			setText(self.calcTxt, arg_103_0)

			return
		end

		updateDrop(self.itemInfoIcon, {
			type = DROP_TYPE_ITEM,
			id = var_98_2.id
		})
		onButton(self, self.itemInfoIcon, function()
			ItemTipPanel.ShowItemTipbyID(var_98_2.id, i18n("title_item_ways", var_98_2:getConfig("name")))

			return
		end, SFX_PANEL)
		setScrollText(findTF(self.itemInfo, "name/Text"), var_98_2:getConfig("name"))
		setText(self.itemInfoCount, i18n("tec_tip_material_stock") .. ":" .. var_98_2.count)
		setActive(self.itemInfo:Find("no_cost"), false)
		setActive(self.itemInfo:Find("discount"), false)
		setActive(self.modBtn:Find("pursuing_cost"), false)
		onButton(self, self.modBtn, function()
			if self:inModAnim() then
				return
			end

			if var_98_4 == 0 then
				return
			end

			self:emit(ShipBluePrintMediator.ON_MOD, var_98_0.id, var_98_4)

			return
		end, SFX_PANEL)
	end

	var_98_6(var_98_4)

	local var_98_9 = 0
	local var_98_10 = Clone(var_98_0)
	local var_98_11 = var_98_0:getItemExp()

	while var_98_10.level < var_98_10:getMaxLevel() and var_98_1.level >= var_98_10:getStrengthenConfig(math.min(var_98_10.level + 1, var_98_10:getMaxLevel())).need_lv do
		var_98_9 = var_98_9 + 1

		var_98_10:addExp(var_98_11)
	end

	local var_98_12 = math.min(var_98_5, var_98_9)

	pressPersistTrigger(self.calcMinusBtn, 0.5, function(arg_106_0)
		if self:inModAnim() or var_98_0:isMaxLevel() or var_98_4 == 0 then
			arg_106_0()

			return
		end

		var_98_4 = var_98_4 - 1

		var_98_6(var_98_4)

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	pressPersistTrigger(self.calcPlusBtn, 0.5, function(arg_107_0)
		if self:inModAnim() or var_98_0:isMaxLevel() or var_98_4 == var_98_12 then
			arg_107_0()

			return
		end

		var_98_4 = var_98_4 + 1

		var_98_6(var_98_4)

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	onButton(self, self.calcMaxBtn, function()
		if self:inModAnim() or var_98_0:isMaxLevel() or var_98_4 == var_98_12 then
			return
		end

		var_98_4 = var_98_12

		var_98_6(var_98_4)

		return
	end, SFX_PANEL)
	setActive(self.calcMaxBtn, not var_98_3)

	local var_98_13 = var_98_0:canFateSimulation()

	if var_98_13 then
		onButton(self, self.fittingBtn, function()
			if self.isSwitchAnim then
				return
			end

			setActive(self.fittingBtnEffect, true)

			self.cbTimer = Timer.New(function()
				self.cbTimer = nil

				setActive(self.fittingBtnEffect, false)
				self:switchState(var_0_7, true, function()
					self.isFate = true

					setActive(self.fittingPanel, self.isFate)
					setActive(self.modPanel, not self.isFate)

					if not PlayerPrefs.HasKey("first_fate") then
						triggerButton(self.helpBtn)
						PlayerPrefs.SetInt("first_fate", 1)
						PlayerPrefs.Save()
					end

					return
				end)

				return
			end, 0.6)

			self.cbTimer:Start()

			return
		end, SFX_PANEL)
		self:updateFittingPanel()

		if not inGuide then
			pg.NewStoryMgr.GetInstance():Play(var_98_0:getConfig("luck_story"), function(arg_112_0)
				if arg_112_0 then
					self:buildStartAni("fateStartWindow", function()
						triggerButton(self.fittingBtn)

						return
					end)
				end

				return
			end)
		end
	end

	setActive(self.calcPanel, not var_98_13)
	setActive(self.fittingBtn, var_98_13)
	setActive(self.fittingBtnEffect, false)

	return
end

function ShipBluePrintScene:updateFittingPanel()
	local var_114_0 = self.contextData.shipBluePrintVO
	local var_114_1 = self:getShipById(self.contextData.shipBluePrintVO.shipId)
	local var_114_2 = self:getItemById((self.contextData.shipBluePrintVO:getConfig("strengthen_item")))
	local var_114_3 = var_114_2.count == 0 and var_114_0:isPursuing()
	local var_114_4 = 0
	local var_114_5
	local var_114_6

	if var_114_3 then
		local var_114_7 = getProxy(TechnologyProxy)

		var_114_5 = math.min(var_114_7:calcMaxPursuingCount(var_114_0), var_114_0:getFateUseageMaxItem())

		function var_114_6(arg_115_0)
			local var_115_0 = Clone(var_114_0)

			var_115_0:addExp(arg_115_0 * var_114_0:getItemExp())
			self:updateFittingInfo(var_115_0)
			setText(self.fittingCalcTxt, arg_115_0)

			local var_115_1 = var_114_0:isRarityUR()
			local var_115_2 = TechnologyProxy.getPursuingDiscount(var_114_7:getPursuingTimes(var_115_1) + var_114_4 + 1, var_115_1)

			setText(self.fittingItemInfoIcon:Find("icon_bg/count"), var_114_0:getPursuingPrice(var_115_2))
			setActive(self.fittingItemInfo:Find("no_cost"), var_115_2 == 0)
			setActive(self.fittingItemInfo:Find("discount"), var_115_2 > 0 and var_115_2 < 100)

			if var_115_2 > 0 and var_115_2 < 100 then
				setText(self.fittingItemInfo:Find("discount/Text"), 100 - var_115_2 .. "%OFF")
			end

			setActive(self.fittingConfirmBtn:Find("pursuing_cost"), arg_115_0 > 0)
			setText(self.fittingConfirmBtn:Find("pursuing_cost/Text"), var_114_7:calcPursuingCost(var_114_0, arg_115_0))

			return
		end

		local var_114_8 = {
			type = DROP_TYPE_RESOURCE,
			id = PlayerConst.ResGold
		}

		updateDrop(self.fittingItemInfoIcon, var_114_8)
		onButton(self, self.fittingItemInfoIcon, function()
			if LOCK_TECHNOLOGY_PURSUING_TIP then
				self:emit(BaseUI.ON_DROP, var_114_8)
			else
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_HELP,
					helps = i18n("blueprint_catchup_by_gold_help")
				})
			end

			return
		end, SFX_PANEL)
		setScrollText(findTF(self.fittingItemInfo, "name/Text"), var_114_8:getConfig("name"))
		setText(self.fittingItemInfoCount, i18n("tec_tip_material_stock") .. ":" .. getProxy(PlayerProxy):getRawData():getResource(PlayerConst.ResGold))
		setText(self.fittingItemInfo:Find("no_cost/Text"), i18n("tec_tip_no_consumption"))
		setText(self.fittingConfirmBtn:Find("pursuing_cost/word"), i18n("tec_tip_to_consumption"))
		onButton(self, self.fittingConfirmBtn, function()
			if self:inModAnim() then
				return
			end

			if var_114_4 == 0 then
				return
			end

			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("blueprint_catchup_by_gold_confirm", var_114_7:calcPursuingCost(var_114_0, var_114_4)),
				onYes = function()
					self:emit(ShipBluePrintMediator.ON_PURSUING, var_114_0.id, var_114_4)

					return
				end
			})

			return
		end, SFX_PANEL)
	else
		var_114_5 = math.min(var_114_2.count, var_114_0:getFateUseageMaxItem())

		function var_114_6(arg_119_0)
			local var_119_0 = Clone(var_114_0)

			var_119_0:addExp(arg_119_0 * var_114_0:getItemExp())
			self:updateFittingInfo(var_119_0)
			setText(self.fittingCalcTxt, arg_119_0)

			return
		end

		updateDrop(self.fittingItemInfoIcon, {
			type = DROP_TYPE_ITEM,
			id = var_114_2.id
		})
		onButton(self, self.fittingItemInfoIcon, function()
			ItemTipPanel.ShowItemTipbyID(var_114_2.id, i18n("title_item_ways", var_114_2:getConfig("name")))

			return
		end, SFX_PANEL)
		setScrollText(self.fittingItemInfo:Find("name/Text"), var_114_2:getConfig("name"))
		setText(self.fittingItemInfoCount, i18n("tec_tip_material_stock") .. ":" .. var_114_2.count)
		setActive(self.fittingItemInfo:Find("no_cost"), false)
		setActive(self.fittingItemInfo:Find("discount"), false)
		setActive(self.fittingConfirmBtn:Find("pursuing_cost"), false)
		onButton(self, self.fittingConfirmBtn, function()
			if self:inModAnim() then
				return
			end

			if var_114_4 == 0 then
				return
			end

			self:emit(ShipBluePrintMediator.ON_MOD, var_114_0.id, var_114_4)

			return
		end, SFX_PANEL)
	end

	setText(self.fittingAttrPanel:Find("attr/name"), AttributeType.Type2Name(AttributeType.Luck))
	setText(self.fittingPanel:Find("desc/top/text/Text"), i18n("fate_phase_word"))
	onButton(self, self.fittingCancelBtn, function()
		self:switchState(var_0_7, true, function()
			self.isFate = false

			setActive(self.fittingPanel, self.isFate)
			setActive(self.modPanel, not self.isFate)

			return
		end)

		return
	end, SFX_PANEL)

	local var_114_9 = 0
	local var_114_10 = Clone(var_114_0)
	local var_114_11 = var_114_0:getItemExp()

	while var_114_10.fateLevel < var_114_10:getMaxFateLevel() and var_114_1.level >= var_114_10:getFateStrengthenConfig(math.min(var_114_10.fateLevel + 1, var_114_10:getMaxFateLevel())).need_lv do
		var_114_9 = var_114_9 + 1

		var_114_10:addExp(var_114_11)
	end

	local var_114_12 = math.min(var_114_5, var_114_9)

	pressPersistTrigger(self.fittingCalcMinusBtn, 0.5, function(arg_124_0)
		if self:inModAnim() or var_114_0:isMaxFateLevel() or var_114_4 == 0 then
			arg_124_0()

			return
		end

		var_114_4 = math.max(var_114_4 - 1, 0)

		var_114_6(var_114_4)

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	pressPersistTrigger(self.fittingCalcPlusBtn, 0.5, function(arg_125_0)
		if self:inModAnim() or var_114_0:isMaxFateLevel() or var_114_4 == var_114_12 then
			arg_125_0()

			return
		end

		var_114_4 = math.max(math.min(var_114_4 + 1, var_114_12), 0)

		var_114_6(var_114_4)

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	onButton(self, self.fittingCalcMaxBtn, function()
		if self:inModAnim() or var_114_0:isMaxFateLevel() or var_114_4 == var_114_12 then
			return
		end

		var_114_4 = var_114_12

		var_114_6(var_114_4)

		return
	end, SFX_PANEL)
	setActive(self.fittingCalcMaxBtn, not var_114_3)

	local var_114_13 = self.fittingAttrPanel:Find("phase_panel")
	local var_114_14 = var_114_13:Find("phase_tpl")

	setActive(var_114_14, false)

	local var_114_15 = {
		0,
		-60,
		0,
		60
	}
	local var_114_16 = {}

	for iter_114_0 = 1, var_114_0:getMaxFateLevel() do
		local var_114_17 = var_114_13:Find("phase_" .. iter_114_0) or cloneTplTo(var_114_14, var_114_13, "phase_" .. iter_114_0)
		local var_114_18 = var_114_0:getFateStrengthenConfig(iter_114_0)

		assert(var_114_18.special == 1 and type(var_114_18.special_effect) == "table", "without fate config")

		local var_114_19

		for iter_114_1, iter_114_2 in ipairs(var_114_18.special_effect) do
			if iter_114_2[1] == ShipBluePrint.STRENGTHEN_TYPE_CHANGE_SKILL then
				var_114_19 = iter_114_2[2][2]

				break
			end
		end

		for iter_114_3, iter_114_4 in ipairs({
			"off",
			"on"
		}) do
			setActive(var_114_17:Find(iter_114_4 .. "/icon"), not var_114_19)
			setActive(var_114_17:Find(iter_114_4 .. "/skill"), var_114_19)
			setActive(var_114_17:Find(iter_114_4 .. "/icon/line"), var_114_15[iter_114_0])
			setActive(var_114_17:Find(iter_114_4 .. "/skill/line"), var_114_15[iter_114_0])

			if var_114_15[iter_114_0] then
				var_114_17:Find(iter_114_4 .. "/icon/line").localEulerAngles = Vector3(0, 0, var_114_15[iter_114_0])
				var_114_17:Find(iter_114_4 .. "/skill/line").localEulerAngles = Vector3(0, 0, var_114_15[iter_114_0])

				GetImageSpriteFromAtlasAsync("ui/shipblueprintui_atlas", iter_114_0 .. "_" .. iter_114_4, var_114_17:Find(iter_114_4 .. "/icon/icon"), true)
			end
		end

		if var_114_19 then
			GetImageSpriteFromAtlasAsync("tecfateskillicon/skill_" .. var_114_19, "", var_114_17:Find("off/skill/icon"), true)
			GetImageSpriteFromAtlasAsync("tecfateskillicon/skill_on_" .. var_114_19, "", var_114_17:Find("on/skill/icon"), true)

			var_114_16[iter_114_0] = 55
		else
			var_114_16[iter_114_0] = 40
		end

		onButton(self, var_114_17, function()
			self:showFittingMsgPanel(iter_114_0)

			return
		end, SFX_PANEL)
	end

	for iter_114_5 = 1, var_114_0:getMaxFateLevel() do
		setAnchoredPosition(var_114_13:Find("phase_" .. iter_114_5), Vector2.zero)

		Vector2.zero.x = math.min(Vector2.zero.x, Vector2.zero.x)
		Vector2.zero.y = math.min(Vector2.zero.y, Vector2.zero.y)
		Vector2.zero.x = math.max(Vector2.zero.x, Vector2.zero.x)
		Vector2.zero.y = math.max(Vector2.zero.y, Vector2.zero.y)

		if var_114_15[iter_114_5] then
			local var_114_20 = Vector2.zero + (var_114_16[iter_114_5] + var_114_16[iter_114_5 + 1]) * Vector2(math.cos(math.pi * var_114_15[iter_114_5] / 180), math.sin(math.pi * var_114_15[iter_114_5] / 180))
		end
	end

	setSizeDelta(var_114_13, Vector2.zero - Vector2.zero)
	setAnchoredPosition(var_114_13, {
		y = -Vector2.zero.y
	})
	var_114_6(var_114_4)

	return
end

function ShipBluePrintScene:updateFittingInfo(arg_128_1)
	local var_128_0 = self:getShipById(arg_128_1.shipId)
	local var_128_1 = self.contextData.shipBluePrintVO

	self:updateFittingAttrPanel(self.contextData.shipBluePrintVO, arg_128_1)
	GetImageSpriteFromAtlasAsync("ui/shipblueprintui_atlas", "phase_" .. math.max(arg_128_1.fateLevel, 1), self.phasePic, true)

	local var_128_2 = var_128_1:getNextFateLevelExp()

	self.phaseSlider.value = var_128_2 == -1 and 1 or var_128_1.exp / var_128_2

	local var_128_3 = arg_128_1:getNextFateLevelExp()

	if var_128_3 == -1 then
		setText(self.phaseSliderTxt, "MAX")

		self.prePhaseSlider.value = 1
	else
		setText(self.phaseSliderTxt, tostring((math.floor(arg_128_1.exp / arg_128_1:getNextFateLevelExp() * 100))) .. "%")

		self.prePhaseSlider.value = arg_128_1.fateLevel > var_128_1.fateLevel and 1 or arg_128_1.exp / var_128_3
	end

	local var_128_4, var_128_5 = arg_128_1:isShipModMaxFateLevel(var_128_0)

	setActive(self.fittingNeedMask, var_128_4)

	if var_128_4 then
		setText(self.fittingNeedMask:Find("limit"), i18n("buleprint_need_level_tip", var_128_5))

		self.phaseSlider.value = 1
	end

	return
end

function ShipBluePrintScene:updateFittingAttrPanel(arg_129_1, arg_129_2)
	setText(self.fittingAttrPanel:Find("attr/name/Text"), " + " .. defaultValue((arg_129_2 or arg_129_1):attrSpecialAddition()[AttributeType.Luck], 0))

	self.blinkTarget = self.blinkTarget or {
		{},
		{}
	}

	for iter_129_0 = 1, arg_129_1:getMaxFateLevel() do
		local var_129_0 = self.fittingAttrPanel:Find("phase_panel/phase_" .. iter_129_0)
		local var_129_1 = var_129_0:Find("off")
		local var_129_2 = var_129_0:Find("on")

		if arg_129_2 and iter_129_0 > arg_129_1.fateLevel and iter_129_0 <= arg_129_2.fateLevel then
			setActive(var_129_1, true)
			setActive(var_129_2, true)

			if not table.contains(self.blinkTarget[1], var_129_1) then
				table.insert(self.blinkTarget[1], var_129_1)
				table.insert(self.blinkTarget[2], var_129_2)
			end
		else
			local var_129_3 = table.indexof(self.blinkTarget[1], var_129_1)

			if var_129_3 then
				table.remove(self.blinkTarget[1], var_129_3)
				table.remove(self.blinkTarget[2], var_129_3)
			end

			setActive(var_129_1, iter_129_0 > arg_129_1.fateLevel)
			setActive(var_129_2, iter_129_0 <= arg_129_1.fateLevel)

			var_129_1:GetComponent(typeof(CanvasGroup)).alpha = 1
			var_129_2:GetComponent(typeof(CanvasGroup)).alpha = 1
		end
	end

	if #self.blinkTarget[1] == 0 then
		LeanTween.cancel(go(self.fittingAttrPanel))
	elseif not LeanTween.isTweening(go(self.fittingAttrPanel)) then
		LeanTween.value(go(self.fittingAttrPanel), 1, 0, 0.8):setOnUpdate(System.Action_float(function(arg_130_0)
			for iter_130_0, iter_130_1 in ipairs(self.blinkTarget[1]) do
				iter_130_1:GetComponent(typeof(CanvasGroup)).alpha = arg_130_0
			end

			for iter_130_2, iter_130_3 in ipairs(self.blinkTarget[2]) do
				iter_130_3:GetComponent(typeof(CanvasGroup)).alpha = 1 - arg_130_0
			end

			return
		end)):setEase(LeanTweenType.easeInOutSine):setLoopPingPong(0)
	end

	return
end

function ShipBluePrintScene:updateModAdditionPanel()
	local var_131_0 = self.contextData.shipBluePrintVO
	local var_131_1 = self.contextData.shipBluePrintVO:specialStrengthens()

	for iter_131_0 = self.modAdditionContainer.childCount - 1, #var_131_1 do
		self:cloneTplTo(self.modAdditionTpl, self.modAdditionContainer)
	end

	for iter_131_1 = 1, self.modAdditionContainer.childCount do
		local var_131_2 = iter_131_1 <= #var_131_1
		local var_131_3 = self.modAdditionContainer:GetChild(iter_131_1 - 1)

		setActive(var_131_3, iter_131_1 <= #var_131_1)

		if var_131_2 then
			self:updateAdvanceTF(var_131_0, var_131_3, var_131_1[iter_131_1])
		end
	end

	return
end

function ShipBluePrintScene:updateAdvanceTF(arg_132_1, arg_132_2, arg_132_3)
	local var_132_0 = arg_132_1.level < arg_132_3.level

	setActive(arg_132_2:Find("mask"), arg_132_1.level < arg_132_3.level)

	if var_132_0 then
		setText(arg_132_2:Find("mask/content/Text"), i18n("blueprint_mod_addition_lock", arg_132_3.level))
	end

	local var_132_1 = arg_132_3.des
	local var_132_2 = arg_132_3.extraDes or {}
	local var_132_3 = arg_132_2:Find("additions")

	removeAllChildren(var_132_3)

	local var_132_4 = self.modAdditionPanel:Find("scroll_rect/info")

	local function var_132_5(arg_133_0, arg_133_1)
		local var_133_0 = arg_133_0:Find("star_tpl")
		local var_133_1 = arg_133_0:Find("stars")
		local var_133_2 = arg_133_0:Find("pre_stars")

		removeAllChildren(var_133_1)
		removeAllChildren(var_133_2)

		for iter_133_0 = 1, Ship.New({
			configId = pg.ship_data_breakout[arg_133_1[2]].pre_id
		}):getStar() do
			cloneTplTo(var_133_0, var_133_1)
		end

		for iter_133_1 = 1, Ship.New({
			configId = arg_133_1[2]
		}):getStar() do
			cloneTplTo(var_133_0, var_133_2)
		end

		return
	end

	for iter_132_0 = 1, #var_132_1 do
		local var_132_6 = cloneTplTo(var_132_4, var_132_3)
		local var_132_7 = var_132_6:Find("text_tpl")
		local var_132_8 = var_132_6:Find("breakout_tpl")

		setActive(var_132_7, false)
		setActive(var_132_6:Find("attr_tpl"), false)
		setActive(var_132_8, false)
		setActive(var_132_6:Find("empty_tpl"), false)

		if var_132_1[iter_132_0] then
			if var_132_1[iter_132_0][1] == ShipBluePrint.STRENGTHEN_TYPE_BREAKOUT then
				setActive(var_132_8, true)
				var_132_5(var_132_8, var_132_1[iter_132_0])
			else
				setActive(var_132_7, true)
				setText(var_132_7:Find("Text"), var_132_1[iter_132_0][3])
			end
		end
	end

	for iter_132_1 = 1, #var_132_2 do
		local var_132_9 = cloneTplTo(var_132_4, var_132_3)
		local var_132_10 = var_132_9:Find("text_tpl")

		setActive(var_132_10, true)
		setActive(var_132_9:Find("attr_tpl"), false)
		setActive(var_132_9:Find("breakout_tpl"), false)
		setActive(var_132_9:Find("empty_tpl"), false)
		setText(var_132_10:Find("Text"), var_132_2[iter_132_1])
	end

	return
end

function ShipBluePrintScene:updateInfo()
	local var_134_0

	if self.contextData.shipBluePrintVO:isFetched() then
		var_134_0 = self.shipVOs[self.contextData.shipBluePrintVO.shipId]
	end

	var_134_0 = var_134_0 or self.contextData.shipBluePrintVO:getShipVO()

	local var_134_1 = var_134_0:getConfigTable()

	setText(self.shipName, (var_134_0:getName()))
	setText(self.englishName, var_134_1.english_name)
	removeAllChildren(self.stars)

	local var_134_2 = var_134_0:getMaxStar()

	for iter_134_0 = 1, var_134_2 do
		cloneTplTo(self.shipInfoStarTpl, self.stars, "star_" .. iter_134_0)
	end

	for iter_134_1 = 1, var_134_2 - var_134_0:getStar() do
		local var_134_3 = self.stars:GetChild(var_134_2 - iter_134_1)

		setActive(var_134_3:Find("star_tpl"), false)
		setActive(var_134_3:Find("empty_star_tpl"), true)
	end

	local var_134_4 = GetSpriteFromAtlas("shiptype", var_134_0:getShipType())

	if not var_134_4 then
		warning("找不到船形, shipConfigId: " .. var_134_0.configId)
	end

	setImageSprite(self.shipType, var_134_4, true)

	local var_134_5 = self.contextData.shipBluePrintVO:isLock()

	setActive(self.finishedBtn, self.contextData.shipBluePrintVO:isFinished())

	local var_134_6 = self.contextData.shipBluePrintVO:isDeving()

	setActive(self.progressPanel, var_134_6)

	if not var_134_6 then
		setActive(self.speedupBtn, false)
	end

	if var_134_6 then
		self:updateTasksProgress()
	end

	local var_134_7, var_134_8 = self.contextData.shipBluePrintVO:isFinishPrevTask()

	if var_134_5 and not var_134_8 then
		if var_134_7 then
			for iter_134_2, iter_134_3 in ipairs(self.contextData.shipBluePrintVO:getOpenTaskList()) do
				self:emit(ShipBluePrintMediator.ON_FINISH_TASK, iter_134_3)
			end

			var_134_8 = true
		else
			local var_134_9 = getProxy(TaskProxy)
			local var_134_10 = self.contextData.shipBluePrintVO:getOpenTaskList()

			for iter_134_4, iter_134_5 in ipairs(var_134_10) do
				local var_134_11 = var_134_9:getTaskVO(iter_134_5)
				local var_134_12

				if iter_134_4 > self.lockPanel.childCount then
					var_134_12 = cloneTplTo(self.lockBtn, self.lockPanel) or self.lockPanel:GetChild(iter_134_4 - 1)
				end

				setActive(var_134_12, true)

				local var_134_13 = var_134_11:getProgress()
				local var_134_14 = var_134_11:getConfig("target_num")

				setText(var_134_12:Find("Text"), (var_134_14 <= var_134_13 and setColorStr(var_134_13, COLOR_GREEN) or var_134_13) .. "/" .. var_134_14)
			end

			for iter_134_6 = #var_134_10 + 1, self.lockPanel.childCount do
				setActive(self.lockPanel:GetChild(iter_134_6 - 1), false)
			end
		end
	end

	setText(self.openCondition:Find("Text"), self.contextData.shipBluePrintVO:getConfig("unlock_word"))
	setActive(self.openCondition, var_134_5)
	setActive(self.startBtn, var_134_5 and var_134_8)
	setActive(self.lockPanel, var_134_5 and not var_134_8)

	return
end

function ShipBluePrintScene:updateTasksProgress()
	local var_135_0 = self.contextData.shipBluePrintVO

	if not self.contextData.shipBluePrintVO:isDeving() then
		return
	end

	local var_135_1 = var_135_0:getTaskIds()

	for iter_135_0 = self.progressContainer.childCount, #var_135_1 do
		cloneTplTo(self.progressTpl, self.progressContainer)
	end

	for iter_135_1 = 1, self.progressContainer.childCount do
		local var_135_2 = self.progressContainer:GetChild(iter_135_1 - 1)
		local var_135_3 = iter_135_1 <= #var_135_1

		setActive(var_135_2, iter_135_1 <= #var_135_1)

		if var_135_3 then
			local var_135_4 = var_135_0:getTaskStateById(var_135_1[iter_135_1])

			setActive(findTF(var_135_2, "complete"), var_135_4 == ShipBluePrint.TASK_STATE_FINISHED)
			setActive(findTF(var_135_2, "lock"), var_135_4 == ShipBluePrint.TASK_STATE_LOCK or var_135_4 == ShipBluePrint.TASK_STATE_WAIT)
			setActive(findTF(var_135_2, "working"), var_135_4 == ShipBluePrint.TASK_STATE_ACHIEVED or var_135_4 == ShipBluePrint.TASK_STATE_OPENING or var_135_4 == ShipBluePrint.TASK_STATE_START)
		end
	end

	local var_135_5 = pg.gameset.technology_catchup_itemid.description[var_135_0:getConfig("blueprint_version")]

	if var_135_5 then
		setActive(self.speedupBtn, (var_135_0:getTaskStateById(var_135_1[1]) == ShipBluePrint.TASK_STATE_START or var_135_0:getTaskStateById(var_135_1[4]) == ShipBluePrint.TASK_STATE_START) and getProxy(BagProxy):getItemCountById(var_135_5[1]) > 0)
	else
		setActive(self.speedupBtn, false)
	end

	return
end

function ShipBluePrintScene:updatePainting()
	local var_136_0 = self.contextData.shipBluePrintVO:getShipVO():getPainting()

	if PLATFORM_CODE == PLATFORM_CH and checkABExist("painting/" .. var_136_0 .. "_blueprint") then
		var_136_0 = var_136_0 .. "_blueprint"
	end

	if self.lastPaintingName and self.lastPaintingName ~= var_136_0 then
		retPaintingPrefab(self.painting, self.lastPaintingName)
	end

	self.lastPaintingName = var_136_0

	setPaintingPrefab(self.painting, var_136_0, "tuzhi")
	self:paintBreath()

	return
end

function ShipBluePrintScene:updateProperty()
	local var_137_0 = self.contextData.shipBluePrintVO
	local var_137_1 = self.contextData.shipBluePrintVO:getShipVO()

	self.propertyPanel:initProperty(var_137_1.configId, PropertyPanel.TypeFlat)

	local var_137_2 = var_0_2[var_137_1.configId].buff_list_display

	for iter_137_0 = self.skillPanel.childCount, #var_0_2[var_137_1.configId].buff_list_display - 1 do
		cloneTplTo(self.skillTpl, self.skillPanel)
	end

	for iter_137_1 = 1, self.skillPanel.childCount do
		local var_137_3 = self.skillPanel:GetChild(iter_137_1 - 1)
		local var_137_4 = iter_137_1 <= #var_137_2

		if iter_137_1 <= #var_137_2 then
			local var_137_5 = getSkillConfig(var_137_2[iter_137_1])

			LoadImageSpriteAsync("skillicon/" .. var_137_5.icon, (findTF(var_137_3, "icon")))
			onButton(self, var_137_3, function()
				self:emit(ShipBluePrintMediator.SHOW_SKILL_INFO, var_137_5.id, {
					id = var_137_5.id,
					level = pg.skill_data_template[var_137_5.id].max_level
				}, function()
					return
				end)

				return
			end, SFX_PANEL)
		end

		setActive(var_137_3, var_137_4)
	end

	setActive(self.skillArrLeft, #var_137_2 > 3)
	setActive(self.skillArrRight, #var_137_2 > 3)

	if #var_137_2 > 3 then
		onScroll(self, self.skillRect, function(arg_140_0)
			setActive(self.skillArrLeft, arg_140_0.x > 0.01)
			setActive(self.skillArrRight, arg_140_0.x < 0.99)

			return
		end)
	else
		GetComponent(self.skillRect, typeof(ScrollRect)).onValueChanged:RemoveAllListeners()
	end

	setAnchoredPosition(self.skillPanel, {
		x = 0
	})

	local var_137_6 = var_137_0:getConfig("simulate_dungeon")

	setActive(self.simulationBtn, var_137_6 ~= 0)
	onButton(self, self.simulationBtn, function()
		if var_137_6 == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("tech_simulate_closed"))
		else
			local var_141_0 = {}

			var_141_0.content = i18n("blueprint_simulation_confirm_" .. var_137_0.id)

			function var_141_0.onYes()
				self:emit(ShipBluePrintMediator.SIMULATION_BATTLE, var_137_6)

				return
			end

			pg.MsgboxMgr.GetInstance():ShowMsgBox(var_141_0)
		end

		return
	end, SFX_CONFIRM)

	return
end

function ShipBluePrintScene:updateTaskList()
	local var_143_0 = self.contextData.shipBluePrintVO
	local var_143_1 = self.contextData.shipBluePrintVO:getTaskIds()

	UIItemList.StaticAlign(self.taskContainer, self.taskTpl, #var_143_1, function(arg_144_0, arg_144_1, arg_144_2)
		arg_144_1 = arg_144_1 + 1

		if arg_144_0 == UIItemList.EventUpdate then
			if self.taskTFs[arg_144_1] then
				self.taskTFs[arg_144_1]:clear()
			end

			if arg_144_1 <= #var_143_1 then
				self.taskTFs[arg_144_1] = self.taskTFs[arg_144_1] or self:createTask(arg_144_2)

				local var_144_0 = var_143_1[arg_144_1]
				local var_144_1 = self:getTaskById(var_143_1[arg_144_1])

				if var_143_0.duration > 0 then
					var_144_1.leftTime = var_143_0:getTaskOpenTimeStamp(var_144_0) - var_143_0.duration
				end

				var_144_1.taskState = var_143_0:getTaskStateById(var_144_0)
				var_144_1.dueTime = var_143_0:getTaskOpenTimeStamp(var_144_0)
				var_144_1.index = arg_144_1

				self.taskTFs[arg_144_1]:update(var_144_1)
			end
		end

		return
	end)

	return
end

function ShipBluePrintScene:updatePhantomQuest()
	local var_145_0 = self.contextData.shipBluePrintVO
	local var_145_1 = self.contextData.shipBluePrintVO:isUnlockShipPhantom()

	setActive(self.phantomPanel:Find("title/bg"), var_145_1)
	setActive(self.phantomPanel:Find("title/bg_lock"), not var_145_1)
	setActive(self.phantomPanel:Find("desc/content"), var_145_1)
	setActive(self.phantomPanel:Find("desc/lock_mask"), not var_145_1)
	setText(self.phantomPanel:Find("desc/lock_mask/Text"), i18n("tech_shadow_limit_text", getGameset("technology_shadow_unlock_lv")[1]))

	if not var_145_1 then
		return
	end

	local var_145_2 = self.contextData.shipBluePrintVO:getAllPhantomQuestInfo()

	setText(self.phantomPanel:Find("title/bg/Text"), string.format("%d/%d", #underscore.filter(var_145_2, function(arg_146_0)
		return arg_146_0.unlocked
	end), #var_145_2))
	UIItemList.StaticAlign(self.rtPhantomQuestContainer, self.questTpl, #var_145_2, function(arg_147_0, arg_147_1, arg_147_2)
		arg_147_1 = arg_147_1 + 1

		if arg_147_0 == UIItemList.EventUpdate then
			local var_147_0 = var_145_2[arg_147_1]

			setActive(arg_147_2:Find("title/bg"), var_145_2[arg_147_1].config.type ~= 5)
			setActive(arg_147_2:Find("title/bg_1"), var_147_0.config.type == 5)
			setActive(arg_147_2:Find("title/complete"), var_147_0.unlocked)
			setActive(arg_147_2:Find("title/working"), not var_147_0.unlocked)
			setText(arg_147_2:Find("title/name"), var_147_0.config.name)
			setText(arg_147_2:Find("title/number"), arg_147_1)
			setSlider(arg_147_2:Find("title/slider"), 0, var_147_0.config.target_num, (var_147_0.unlocked or nil) and (var_147_0.config.target_num or var_147_0.progress))
			setActive(arg_147_2:Find("title/slider/complete"), var_147_0.unlocked)
			setActive(arg_147_2:Find("title/tip"), not var_147_0.unlocked and var_147_0.progress >= var_147_0.config.target_num)

			if var_147_0.config.type == 5 then
				setText(arg_147_2:Find("desc/info/Text"), stringInset(var_147_0.config.desc, var_147_0.config.target_num))
			else
				setText(arg_147_2:Find("desc/info/Text"), var_147_0.config.desc)
			end

			local var_147_2 = string.format("%d", math.clamp((var_147_0.unlocked or nil) and (var_147_0.config.target_num or var_147_0.progress), 0, var_147_0.config.target_num) * 100 / var_147_0.config.target_num)

			setText(arg_147_2:Find("desc/info/progress"), var_147_2 .. "%")
			setText(arg_147_2:Find("desc/info/progress/shadow"), var_147_2 .. "%")

			local var_147_3 = ShipBluePrint.getPhantomQuestCostDrop(var_147_0)

			setActive(arg_147_2:Find("desc/item_info/items"), var_147_3)

			if var_147_3 then
				updateDrop(arg_147_2:Find("desc/item_info/items/item_tpl/award"), var_147_3)
			end

			local var_147_4 = var_147_0.unlocked or var_147_0.progress < var_147_0.config.target_num

			setActive(arg_147_2:Find("desc/commit_panel/commit_btn"), not canCommit)
			setActive(arg_147_2:Find("desc/commit_panel/lock_btn"), var_147_4)
			onButton(self, arg_147_2:Find("desc/commit_panel/commit_btn"), function()
				local var_148_0 = {}

				if var_147_3 then
					table.insert(var_148_0, function(arg_149_0)
						pg.MsgboxMgr.GetInstance():ShowMsgBox({
							content = i18n("tech_shadow_commit_tip", var_147_3:getName() .. "x" .. var_147_3.count),
							onYes = arg_149_0
						})

						return
					end)
				end

				seriesAsync(var_148_0, function()
					self:emit(ShipBluePrintMediator.FINISH_PHANTOM_QUEST, var_145_0.id, arg_147_1)

					return
				end)

				return
			end, SFX_CONFIRM)
			onToggle(self, arg_147_2, function(arg_151_0)
				if arg_151_0 then
					Canvas.ForceUpdateCanvases()

					local var_151_0 = self.rtPhantomQuestContainer.parent.transform:InverseTransformPoint(arg_147_2.position).y
					local var_151_1 = 0

					if var_151_0 - arg_147_2.rect.height < self.rtPhantomQuestContainer.parent.transform.rect.yMin then
						var_151_1 = self.rtPhantomQuestContainer.parent.transform.rect.yMin - (var_151_0 - arg_147_2.rect.height)
					end

					if var_151_0 > self.rtPhantomQuestContainer.parent.transform.rect.yMax then
						var_151_1 = self.rtPhantomQuestContainer.parent.transform.rect.yMax - var_151_0
					end

					local var_151_2 = self.rtPhantomQuestContainer.localPosition

					var_151_2.y = self.rtPhantomQuestContainer.localPosition.y + var_151_1
					self.rtPhantomQuestContainer.localPosition = var_151_2
				end

				return
			end, SFX_PANEL)
		end

		return
	end)

	return
end

function ShipBluePrintScene:createTask(arg_152_1)
	local var_152_0 = {
		title = arg_152_1:Find("title/name"),
		desc = arg_152_1:Find("desc/info/Text"),
		timerTF = arg_152_1:Find("title/timer"),
		timerTFTxt = arg_152_1:Find("title/timer/Text"),
		timerOpen = arg_152_1:Find("title/timer/open"),
		timerClose = arg_152_1:Find("title/timer/close"),
		maskAchieved = arg_152_1:Find("title/slider/complete"),
		tip = arg_152_1:Find("title/tip"),
		commitBtn = arg_152_1:Find("desc/commit_panel/commit_btn"),
		itemInfo = arg_152_1:Find("desc/item_info")
	}

	var_152_0.itemContainer = var_152_0.itemInfo:Find("items")
	var_152_0.itemTpl = var_152_0.itemContainer:Find("item_tpl")
	var_152_0.numberTF = arg_152_1:Find("title/number")
	var_152_0.progressTF = arg_152_1:Find("title/slider")
	var_152_0.progessSlider = var_152_0.progressTF:GetComponent(typeof(Slider))
	var_152_0.lockBtn = arg_152_1:Find("desc/commit_panel/lock_btn")
	var_152_0.itemCount = var_152_0.itemTpl:Find("award/icon_bg/count")
	var_152_0.progres = arg_152_1:Find("desc/info/progress")
	var_152_0.progreshadow = arg_152_1:Find("desc/info/progress/shadow")
	var_152_0.check = findTF(arg_152_1, "title/complete")
	var_152_0.lock = findTF(arg_152_1, "title/lock")
	var_152_0.working = findTF(arg_152_1, "title/working")
	var_152_0.pause = findTF(arg_152_1, "title/pause")
	var_152_0.pauseLock = findTF(arg_152_1, "title/pause_lock")
	var_152_0.view = self

	onToggle(self, arg_152_1, function(arg_153_0)
		setActive(var_152_0.desc, arg_153_0)
		setActive(var_152_0.progreshadow, arg_153_0)

		if arg_153_0 then
			Canvas.ForceUpdateCanvases()

			local var_153_0 = self.taskContainer.parent.transform:InverseTransformPoint(arg_152_1.position).y
			local var_153_1 = 0

			if var_153_0 - arg_152_1.rect.height < self.taskContainer.parent.transform.rect.yMin then
				var_153_1 = self.taskContainer.parent.transform.rect.yMin - (var_153_0 - arg_152_1.rect.height)
			end

			if var_153_0 > self.taskContainer.parent.transform.rect.yMax then
				var_153_1 = self.taskContainer.parent.transform.rect.yMax - var_153_0
			end

			local var_153_2 = self.taskContainer.localPosition

			var_153_2.y = self.taskContainer.localPosition.y + var_153_1
			self.taskContainer.localPosition = var_153_2
		end

		return
	end, SFX_PANEL)

	function var_152_0:update(arg_154_1)
		self:clearTimer()

		self.autoCommit = true
		self.isExpTask = false

		removeOnButton(self.commitBtn)
		self:updateItemInfo(arg_154_1)
		self:updateView(arg_154_1)
		self:updateProgress(arg_154_1)

		return
	end

	function var_152_0:updateItemInfo(arg_155_1)
		self.taskVO = arg_155_1

		changeToScrollText(self.title, arg_155_1:getConfig("name"))
		setText(self.desc, arg_155_1:getConfig("desc") .. "\n\n")

		local var_155_0
		local var_155_1 = arg_155_1:getConfig("target_num")
		local var_155_2 = arg_155_1:getConfig("sub_type")

		if var_155_2 == TASK_SUB_TYPE_GIVE_ITEM then
			self.autoCommit = false
			var_155_0 = tonumber(arg_155_1:getConfig("target_id"))
		elseif var_155_2 == TASK_SUB_TYPE_PLAYER_RES then
			self.autoCommit = false
			var_155_0 = id2ItemId(tonumber(arg_155_1:getConfig("target_id")))
		elseif var_155_2 == TASK_SUB_TYPE_BATTLE_EXP then
			self.isExpTask = true
			var_155_0 = 59000
		end

		setActive(self.itemContainer, not self.autoCommit or self.isExpTask)

		if var_155_0 then
			updateDrop(self.itemTpl:Find("award"), {
				type = 2,
				id = var_155_0,
				count = var_155_1
			})
			setText(self.itemCount, var_155_1 > 1000 and math.floor(var_155_1 / 1000) .. "K" or var_155_1)
		end

		setText(self.numberTF, arg_155_1.index)

		return
	end

	function var_152_0:updateView(arg_156_1)
		local var_156_0 = false
		local var_156_1 = false
		local var_156_2 = false

		if arg_156_1.taskState == ShipBluePrint.TASK_STATE_PAUSE and arg_156_1.leftTime then
			local var_156_3 = getProxy(TaskProxy):getTaskVO(arg_156_1.id)

			var_156_0 = var_156_3 and var_156_3:isFinish()
			var_156_2 = arg_156_1.leftTime > 0
			var_156_1 = var_156_3 and var_156_3:isReceive()

			if arg_156_1.leftTime > 0 then
				setText(var_152_0.timerTFTxt, pg.TimeMgr.GetInstance():DescCDTime(arg_156_1.leftTime))
			end
		end

		setActive(self.pause, ShipBluePrint.TASK_STATE_PAUSE == arg_156_1.taskState and not var_156_0 and not var_156_2 or ShipBluePrint.TASK_STATE_PAUSE == arg_156_1.taskState and not var_156_2 and var_156_0 and not self.autoCommit)
		setActive(self.pauseLock, ShipBluePrint.TASK_STATE_PAUSE == arg_156_1.taskState and not var_156_0 and var_156_2)
		setActive(self.lockBtn, arg_156_1.taskState ~= ShipBluePrint.TASK_STATE_ACHIEVED and (arg_156_1.taskState ~= ShipBluePrint.TASK_STATE_START or not not self.autoCommit))
		setActive(self.commitBtn, arg_156_1.taskState == ShipBluePrint.TASK_STATE_ACHIEVED or arg_156_1.taskState == ShipBluePrint.TASK_STATE_START and not self.autoCommit)
		setActive(self.progressTF, arg_156_1.taskState == ShipBluePrint.TASK_STATE_ACHIEVED or arg_156_1.taskState == ShipBluePrint.TASK_STATE_START or arg_156_1.taskState == ShipBluePrint.TASK_STATE_FINISHED or arg_156_1.taskState == ShipBluePrint.TASK_STATE_PAUSE and not var_156_2)
		setActive(self.lock, arg_156_1.taskState == ShipBluePrint.TASK_STATE_LOCK or arg_156_1.taskState == ShipBluePrint.TASK_STATE_WAIT)
		setActive(self.working, arg_156_1.taskState == ShipBluePrint.TASK_STATE_OPENING or arg_156_1.taskState == ShipBluePrint.TASK_STATE_START or arg_156_1.taskState == ShipBluePrint.TASK_STATE_ACHIEVED)
		setActive(self.maskAchieved, arg_156_1.taskState == ShipBluePrint.TASK_STATE_FINISHED or arg_156_1.taskState == ShipBluePrint.TASK_STATE_PAUSE and var_156_1)

		if arg_156_1.taskState ~= ShipBluePrint.TASK_STATE_WAIT then
			local var_156_4

			if arg_156_1.taskState == ShipBluePrint.TASK_STATE_PAUSE then
				var_156_4 = arg_156_1.leftTime and arg_156_1.leftTime > 0
			end
		end

		setActive(self.timerTF, var_156_4)
		setActive(self.check, self.autoCommit and arg_156_1.taskState == ShipBluePrint.TASK_STATE_ACHIEVED or arg_156_1.taskState == ShipBluePrint.TASK_STATE_FINISHED or arg_156_1.taskState == ShipBluePrint.TASK_STATE_PAUSE and var_156_1)
		setActive(self.tip, arg_156_1.taskState == ShipBluePrint.TASK_STATE_ACHIEVED)
		setActive(self.timerOpen, arg_156_1.taskState == ShipBluePrint.TASK_STATE_WAIT)
		setActive(self.timerClose, (arg_156_1.taskState == ShipBluePrint.TASK_STATE_PAUSE or nil) and arg_156_1.leftTime and arg_156_1.leftTime > 0)

		return
	end

	function var_152_0:updateProgress(arg_157_1)
		local var_157_0 = arg_157_1:getProgress() / arg_157_1:getConfig("target_num")

		if arg_157_1.taskState == ShipBluePrint.TASK_STATE_WAIT then
			self:addTimer(arg_157_1, arg_157_1.dueTime)

			var_157_0 = 0
		elseif arg_157_1.taskState == ShipBluePrint.TASK_STATE_OPENING then
			var_157_0 = 0

			self.view:emit(ShipBluePrintMediator.ON_TASK_OPEN, arg_157_1.id)
		elseif arg_157_1.taskState == ShipBluePrint.TASK_STATE_PAUSE then
			if arg_157_1:isReceive() then
				var_157_0 = 1
			end
		elseif arg_157_1.taskState == ShipBluePrint.TASK_STATE_LOCK then
			var_157_0 = 0
		elseif arg_157_1.taskState == ShipBluePrint.TASK_STATE_ACHIEVED then
			onButton(self.view, self.commitBtn, function()
				self.view:emit(ShipBluePrintMediator.ON_FINISH_TASK, arg_157_1.id)

				return
			end, SFX_PANEL)

			var_157_0 = 1
		elseif arg_157_1.taskState == ShipBluePrint.TASK_STATE_FINISHED then
			var_157_0 = 1
		elseif arg_157_1.taskState == ShipBluePrint.TASK_STATE_START and not self.autoCommit then
			onButton(self.view, self.commitBtn, function()
				self.view:emit(ShipBluePrintMediator.ON_FINISH_TASK, arg_157_1.id)

				return
			end, SFX_PANEL)

			var_157_0 = 0
		end

		if var_157_0 > 0 then
			self.itemSliderLT = LeanTween.value(go(self.progressTF), 0, math.min(var_157_0, 1), 0.5 * math.min(var_157_0, 1)):setOnUpdate(System.Action_float(function(arg_160_0)
				self.progessSlider.value = arg_160_0

				return
			end)).uniqueId
		else
			self.progessSlider.value = var_157_0
		end

		local var_157_1 = math.floor(var_157_0 * 100)

		setText(self.progres, math.ceil(math.min(var_157_1, 100)) .. "%")
		setText(self.progreshadow, math.min(var_157_1, 100) .. "%")

		return
	end

	function var_152_0:addTimer(arg_161_1, arg_161_2)
		self:clearTimer()

		self.taskTimer = Timer.New(function()
			local var_162_0 = arg_161_2 - pg.TimeMgr.GetInstance():GetServerTime()

			if var_162_0 > 0 then
				setText(self.timerTFTxt, pg.TimeMgr.GetInstance():DescCDTime(var_162_0))
			else
				self:clearTimer()
				setText(self.timerTFTxt, "00:00:00")
				self.view:emit(ShipBluePrintMediator.ON_TASK_OPEN, arg_161_1.id)
			end

			return
		end, 1, -1)

		self.taskTimer:Start()
		self.taskTimer.func()

		return
	end

	function var_152_0:clearTimer()
		if self.taskTimer then
			self.taskTimer:Stop()

			self.taskTimer = nil
		end

		return
	end

	function var_152_0:clear()
		self:clearTimer()

		if self.itemSliderLT then
			LeanTween.cancel(self.itemSliderLT)

			self.itemSliderLT = nil
		end

		return
	end

	return var_152_0
end

function ShipBluePrintScene:openPreView()
	if self.contextData.shipBluePrintVO then
		setActive(self.preViewer, true)
		pg.UIMgr.GetInstance():BlurPanel(self.preViewer)
		self:playLoadingAni()

		self.viewShipVO = self.contextData.shipBluePrintVO:getShipVO()
		self.breakIds = self:getStages(self.viewShipVO)

		for iter_165_0 = 1, var_0_4 do
			local var_165_0 = self.breakIds[iter_165_0]
			local var_165_2 = self.stages:Find("stage" .. iter_165_0)

			onToggle(self, var_165_2, function(arg_166_0)
				if arg_166_0 then
					if PLATFORM_CODE == PLATFORM_US then
						changeToScrollText(self.breakView, var_0_3[var_165_0].breakout_view)
					else
						setText(self.breakView, var_0_3[var_165_0].breakout_view)
					end

					self:switchStage(var_165_0)
				end

				return
			end, SFX_PANEL)

			if iter_165_0 == 1 then
				triggerToggle(var_165_2, true)
			end
		end

		self.isShowPreview = true

		self:updateMaxLevelAttrs(self.contextData.shipBluePrintVO)
	end

	return
end

ShipBluePrintScene.MAX_LEVEL_ATTRS = {
	AttributeType.Durability,
	AttributeType.Cannon,
	AttributeType.Torpedo,
	AttributeType.AntiAircraft,
	AttributeType.Air,
	AttributeType.Reload,
	AttributeType.ArmorType,
	AttributeType.Dodge
}

function ShipBluePrintScene:updateMaxLevelAttrs(arg_167_1)
	if not arg_167_1:isFetched() then
		return
	end

	local var_167_0 = self.shipVOs[arg_167_1.shipId]
	local var_167_1 = Clone(self.shipVOs[arg_167_1.shipId])

	var_167_1.level = 125

	local var_167_2 = Clone(arg_167_1)

	var_167_2.level = arg_167_1:getMaxLevel()

	local var_167_3 = intProperties(var_167_2:getShipProperties(var_167_1, false))

	for iter_167_0, iter_167_1 in ipairs(ShipBluePrintScene.MAX_LEVEL_ATTRS) do
		local var_167_4 = self.previewAttrContainer:Find(iter_167_1)

		if iter_167_1 == AttributeType.ArmorType then
			setText(var_167_4:Find("bg/value"), var_167_0:getShipArmorName())
		else
			setText(var_167_4:Find("bg/value"), var_167_3[iter_167_1] or 0)
		end

		setText(var_167_4:Find("bg/name"), AttributeType.Type2Name(iter_167_1))
	end

	return
end

function ShipBluePrintScene:closePreview(arg_168_1)
	if self.previewer then
		self.previewer:clear()

		self.previewer = nil
	end

	setActive(self.preViewer, false)
	setActive(self.rawImage, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(self.preViewer, self._tf)

	self.isShowPreview = nil

	return
end

function ShipBluePrintScene:playLoadingAni()
	setActive(self.seaLoading, true)

	return
end

function ShipBluePrintScene:stopLoadingAni()
	setActive(self.seaLoading, false)

	return
end

function ShipBluePrintScene:showBarrage()
	self.previewer = WeaponPreviewer.New(self.rawImage)

	self.previewer:configUI(self.healTF)
	self.previewer:setDisplayWeapon(self:getWaponIdsById(self.breakOutId))
	self.previewer:load(40000, self.viewShipVO, self:getAllWeaponIds(), function()
		self:stopLoadingAni()

		return
	end)

	return
end

function ShipBluePrintScene:getWaponIdsById(arg_173_1)
	return var_0_3[arg_173_1].weapon_ids
end

function ShipBluePrintScene:getAllWeaponIds()
	local var_174_0 = {}

	for iter_174_0, iter_174_1 in ipairs(self.breakIds) do
		local var_174_1 = Clone(var_0_3[iter_174_1].weapon_ids)

		setmetatable(var_174_0, {
			__add = function(arg_175_0, arg_175_1)
				for iter_175_0, iter_175_1 in ipairs(arg_175_0) do
					if not table.contains(arg_175_1, iter_175_1) then
						table.insert(arg_175_1, iter_175_1)
					end
				end

				return arg_175_1
			end
		})

		var_174_0 = var_174_0 + var_174_1
	end

	return var_174_0
end

function ShipBluePrintScene:getStages(arg_176_1)
	local var_176_0 = {}
	local var_176_1 = math.floor(arg_176_1.configId / 10)

	for iter_176_0 = 1, 4 do
		local var_176_2 = tonumber(var_176_1 .. iter_176_0)

		assert(var_0_3[var_176_2], "必须存在配置" .. var_176_2)
		table.insert(var_176_0, var_176_2)
	end

	return var_176_0
end

function ShipBluePrintScene:switchStage(arg_177_1)
	if self.breakOutId == arg_177_1 then
		return
	end

	self.breakOutId = arg_177_1

	if self.previewer then
		self.previewer:setDisplayWeapon(self:getWaponIdsById(self.breakOutId))
	end

	return
end

function ShipBluePrintScene:clearTimers()
	for iter_178_0, iter_178_1 in pairs(self.taskTFs or {}) do
		iter_178_1:clear()
	end

	return
end

function ShipBluePrintScene:cloneTplTo(arg_179_1, arg_179_2)
	local var_179_0 = tf(Instantiate(arg_179_1))

	SetActive(var_179_0, true)
	var_179_0:SetParent(tf(arg_179_2), false)

	return var_179_0
end

function ShipBluePrintScene:onBackPressed()
	if isActive(self.msgPanel) then
		pg.UIMgr.GetInstance():UnOverlayPanel(self.msgPanel, self.top)
		setActive(self.msgPanel, false)
	elseif isActive(self.unlockPanel) then
		pg.UIMgr.GetInstance():UnOverlayPanel(self.unlockPanel, self.top)
		setActive(self.unlockPanel, false)
	elseif isActive(self.versionPanel) then
		triggerButton(self.versionPanel:Find("bg"))
	elseif self.isShowPreview then
		self:closePreview(true)
	elseif self.svQuickExchange:isShowing() then
		self.svQuickExchange:Hide()
	elseif self.awakenPlay or self:inModAnim() then
		-- block empty
	else
		self:emit(ShipBluePrintScene.ON_BACK_PRESSED)
	end

	return
end

function ShipBluePrintScene:willExit()
	if isActive(self.msgPanel) then
		pg.UIMgr.GetInstance():UnOverlayPanel(self.msgPanel, self.top)
		setActive(self.msgPanel, false)
	end

	if isActive(self.unlockPanel) then
		pg.UIMgr.GetInstance():UnOverlayPanel(self.unlockPanel, self.top)
		setActive(self.unlockPanel, false)
	end

	self:UnOverlayPanel(self.blurPanel, self._tf)
	LeanTween.cancel(go(self.fittingAttrPanel))

	if self.lastPaintingName then
		retPaintingPrefab(self.painting, self.lastPaintingName)
	end

	for iter_181_0, iter_181_1 in pairs(self.taskTFs or {}) do
		iter_181_1:clear()
	end

	self:closePreview(true)
	self:clearLeanTween(true)

	if self.previewer then
		self.previewer:clear()

		self.previewer = nil
	end

	if self.cbTimer then
		self.cbTimer:Stop()

		self.cbTimer = nil
	end

	if self.svQuickExchange:isShowing() then
		self.svQuickExchange:Hide()
	end

	self.svQuickExchange:Destroy()

	return
end

function ShipBluePrintScene:paintBreath()
	LeanTween.cancel(go(self.painting))
	LeanTween.moveY(rtf(self.painting), var_0_5, var_0_6):setLoopPingPong():setEase(LeanTweenType.easeInOutCubic):setFrom(0)

	return
end

function ShipBluePrintScene:buildStartAni(arg_183_1, arg_183_2)
	if arg_183_1 == "researchStartWindow" then
		self.progressPanel.localScale = Vector3(0, 1, 1)

		LeanTween.scale(self.progressPanel, Vector3(1, 1, 1), 0.2):setDelay(2)
	end

	local function var_183_0()
		self.awakenAni:SetActive(true)

		self.awakenPlay = true

		local var_184_0 = tf(self.awakenAni)

		pg.UIMgr.GetInstance():BlurPanel(var_184_0)
		var_184_0:SetAsLastSibling()
		var_184_0:GetComponent("DftAniEvent"):SetEndEvent(function(arg_185_0)
			if not IsNil(self.awakenAni) then
				pg.UIMgr.GetInstance():UnOverlayPanel(var_184_0, self.blurPanel)
				self.awakenAni:SetActive(false)

				self.awakenPlay = false

				if arg_183_2 then
					arg_183_2()
				end
			end

			return
		end)

		return
	end

	local var_183_1 = self._tf:Find(arg_183_1 .. "(Clone)")

	self.awakenAni = var_183_1 and go(var_183_1)

	if not self.awakenAni then
		PoolMgr.GetInstance():GetUI(arg_183_1, true, function(arg_186_0)
			arg_186_0:SetActive(true)

			self.awakenAni = arg_186_0

			var_183_0()

			return
		end)
	else
		var_183_0()
	end

	return
end

function ShipBluePrintScene:showFittingMsgPanel(arg_187_1)
	pg.UIMgr.GetInstance():BlurPanel(self.msgPanel)
	setActive(self.msgPanel, true)

	local var_187_0 = self.contextData.shipBluePrintVO
	local var_187_1 = self.contextData.shipBluePrintVO:getMaxFateLevel()
	local var_187_2 = self.msgPanel:Find("window/content")
	local var_187_3 = var_187_2:Find("pre_btn")
	local var_187_4 = var_187_2:Find("next_btn")
	local var_187_5 = var_187_2:Find("attrl_panel")
	local var_187_6 = var_187_2:Find("skill_panel")
	local var_187_7 = var_187_2:Find("phase")
	local var_187_8 = {
		"I",
		"II",
		"III",
		"IV",
		"V"
	}

	local function var_187_9()
		setActive(var_187_3, arg_187_1 > 1)
		setActive(var_187_4, arg_187_1 < var_187_1)
		setText(var_187_7, "PHASE." .. var_187_8[arg_187_1])

		local var_188_0 = var_187_0:getFateStrengthenConfig(arg_187_1)

		assert(var_188_0.special == 1 and type(var_188_0.special_effect) == "table", "without fate config")

		local var_188_1
		local var_188_2 = {}

		for iter_188_0, iter_188_1 in ipairs(var_188_0.special_effect) do
			if iter_188_1[1] == ShipBluePrint.STRENGTHEN_TYPE_CHANGE_SKILL then
				var_188_1 = iter_188_1[2][2]
			elseif iter_188_1[1] == ShipBluePrint.STRENGTHEN_TYPE_ATTR then
				table.insert(var_188_2, iter_188_1[2])
			end
		end

		setActive(var_187_5, #var_188_2 > 0)
		setActive(var_187_6, var_188_1)

		if var_188_1 then
			GetImageSpriteFromAtlasAsync("skillicon/" .. getSkillConfig(var_188_1).icon, "", var_187_6:Find("skill_icon"))
			setText(var_187_6:Find("skill_name"), getSkillName(var_188_1))
			setText(var_187_6:Find("skill_lv"), "Lv." .. 1)
			setText(var_187_6:Find("help_panel/skill_intro"), getSkillDescGet(var_188_1))
		end

		if #var_188_2 > 0 then
			for iter_188_2, iter_188_3 in ipairs(var_188_2) do
				local var_188_3 = iter_188_2 < var_187_5.childCount and var_187_5:GetChild(iter_188_2) or cloneTplTo(var_187_5:GetChild(iter_188_2 - 1), var_187_5)

				setText(var_188_3:Find("name"), AttributeType.Type2Name(iter_188_3[1]))
				setText(var_188_3:Find("number"), " + " .. iter_188_3[2])
			end

			for iter_188_4 = #var_188_2 + 1, var_187_5.childCount - 1 do
				setActive(var_187_5:GetChild(iter_188_4), false)
			end
		end

		return
	end

	onButton(self, var_187_3, function()
		arg_187_1 = arg_187_1 - 1

		var_187_9()

		return
	end)
	onButton(self, var_187_4, function()
		arg_187_1 = arg_187_1 + 1

		var_187_9()

		return
	end)
	setText(var_187_5:Find("desc"), i18n("fate_attr_word"))
	var_187_9()

	return
end

function ShipBluePrintScene:showUnlockPanel()
	pg.UIMgr.GetInstance():BlurPanel(self.unlockPanel)
	setActive(self.unlockPanel, true)

	local var_191_0 = self.contextData.shipBluePrintVO.id
	local var_191_1 = self.contextData.shipBluePrintVO:getUnlockItem()
	local var_191_2 = Drop.New({
		type = DROP_TYPE_ITEM,
		id = var_191_1
	})
	local var_191_3 = self.contextData.shipBluePrintVO:getShipVO()
	local var_191_4 = var_191_3:getPainting()
	local var_191_5 = self.unlockPanel:Find("window/content")

	GetImageSpriteFromAtlasAsync("shipYardIcon/" .. var_191_4, var_191_4, var_191_5:Find("Image/mask/icon"), true)
	setText(var_191_5:Find("words/Text"), i18n("techpackage_item_use_1", var_191_3:getName()))
	setText(var_191_5:Find("words/Text_2"), i18n("techpackage_item_use_2", var_191_2:getName()))
	GetImageSpriteFromAtlasAsync(var_191_2:getIcon(), "", self.unlockPanel:Find("window/confirm_btn/Image/Image"))
	setText(self.unlockPanel:Find("window/confirm_btn/Image/Text"), i18n("event_ui_consume"))
	onButton(self, self.unlockPanel:Find("window/confirm_btn"), function()
		pg.UIMgr.GetInstance():UnOverlayPanel(self.unlockPanel, self.top)
		setActive(self.unlockPanel, false)
		self:emit(ShipBluePrintMediator.ON_ITEM_UNLOCK, var_191_0, var_191_1)

		return
	end, SFX_CANCEL)

	return
end

function ShipBluePrintScene:checkStory()
	local var_193_0 = {
		nil,
		"FANGAN3"
	}

	self.storyMgr = self.storyMgr or pg.NewStoryMgr.GetInstance()

	if var_193_0[self.version] and not self.storyMgr:IsPlayed(var_193_0[self.version]) then
		self.storyMgr:Play(var_193_0[self.version])
	end

	return
end

function ShipBluePrintScene:changeEffectVisible(arg_194_1)
	setActive(self.fittingBtn, arg_194_1)
	setActive(self.initPanel, arg_194_1)

	return
end

return ShipBluePrintScene
