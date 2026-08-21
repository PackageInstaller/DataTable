local var_0_0 = class("ShipBluePrintScene", import("..base.BaseUI"))
local var_0_2 = pg.ship_data_template
local var_0_3 = pg.ship_data_breakout
local var_0_4 = 3
local var_0_5 = -10
local var_0_6 = 2.3
local var_0_7 = 0.3

function var_0_0.getUIName(arg_1_0)
	return "ShipBluePrintUI"
end

function var_0_0.setVersion(arg_2_0, arg_2_1)
	arg_2_0.version = arg_2_1

	return
end

function var_0_0.setShipVOs(arg_3_0, arg_3_1)
	arg_3_0.shipVOs = arg_3_1

	return
end

function var_0_0.getShipById(arg_4_0, arg_4_1)
	return arg_4_0.shipVOs[arg_4_1]
end

function var_0_0.setTaskVOs(arg_5_0, arg_5_1)
	arg_5_0.taskVOs = arg_5_1

	return
end

function var_0_0.getTaskById(arg_6_0, arg_6_1)
	return arg_6_0.taskVOs[arg_6_1] or Task.New({
		id = arg_6_1
	})
end

function var_0_0.getItemById(arg_7_0, arg_7_1)
	local var_7_0 = getProxy(BagProxy):getItemById(arg_7_1)

	var_7_0 = var_7_0 or Item.New({
		count = 0,
		id = arg_7_1
	})

	return var_7_0
end

function var_0_0.setShipBluePrints(arg_8_0, arg_8_1)
	arg_8_0.bluePrintByIds = arg_8_1

	return
end

function var_0_0.updateShipBluePrintVO(arg_9_0, arg_9_1)
	if arg_9_1 then
		arg_9_0.bluePrintByIds[arg_9_1.id] = arg_9_1
	end

	arg_9_0:initShips()

	return
end

function var_0_0.init(arg_10_0)
	arg_10_0.main = arg_10_0._tf:Find("main")
	arg_10_0.centerPanel = arg_10_0.main:Find("center_panel")
	arg_10_0.blurPanel = arg_10_0._tf:Find("blur_panel")
	arg_10_0.top = arg_10_0.blurPanel:Find("adapt")
	arg_10_0.topPanel = arg_10_0.top:Find("top")
	arg_10_0.topBg = arg_10_0.blurPanel:Find("top_bg")
	arg_10_0.backBtn = arg_10_0.top:Find("top/back")
	arg_10_0.leftPanle = arg_10_0.top:Find("left_panel")
	arg_10_0.bottomPanel = arg_10_0.top:Find("bottom_panel")
	arg_10_0.rightPanel = arg_10_0.top:Find("right_panel")
	arg_10_0.shipContainer = arg_10_0.bottomPanel:Find("ships/bg/content")
	arg_10_0.shipTpl = arg_10_0.bottomPanel:Find("ship_tpl")
	arg_10_0.versionBtn = arg_10_0.bottomPanel:Find("ships/bg/version/version_btn")
	arg_10_0.eyeTF = arg_10_0.leftPanle:Find("eye")
	arg_10_0.painting = arg_10_0._tf:Find("main/center_panel/painting")
	arg_10_0.nameTF = arg_10_0.centerPanel:Find("name")
	arg_10_0.shipName = arg_10_0.nameTF:Find("name_mask/Text")
	arg_10_0.shipType = arg_10_0.nameTF:Find("type")
	arg_10_0.englishName = arg_10_0.nameTF:Find("english_name")
	arg_10_0.shipInfoStarTpl = arg_10_0.nameTF:Find("star_tpl")

	setActive(arg_10_0.shipInfoStarTpl, false)

	arg_10_0.stars = arg_10_0.nameTF:Find("stars")
	arg_10_0.initBtn = arg_10_0.leftPanle:Find("property_panel/btns/init_toggle")
	arg_10_0.attrBtn = arg_10_0.leftPanle:Find("property_panel/btns/attr_toggle")
	arg_10_0.attrDisableBtn = arg_10_0.leftPanle:Find("property_panel/btns/attr_toggle/disable")
	arg_10_0.initPanel = arg_10_0.leftPanle:Find("property_panel/init_panel")
	arg_10_0.propertyPanel = PropertyPanel.New(arg_10_0.initPanel, 32)

	setText(arg_10_0.initPanel:Find("property_title1/Text"), i18n("blueprint_combatperformance"))
	setText(arg_10_0.initPanel:Find("property_title2/Text"), i18n("blueprint_shipperformance"))

	arg_10_0.skillRect = arg_10_0.leftPanle:Find("property_panel/init_panel/skills_rect")
	arg_10_0.skillPanel = arg_10_0.leftPanle:Find("property_panel/init_panel/skills_rect/skills")
	arg_10_0.skillTpl = arg_10_0.skillPanel:Find("skilltpl")
	arg_10_0.skillArrLeft = arg_10_0.leftPanle:Find("property_panel/init_panel/arrow1")
	arg_10_0.skillArrRight = arg_10_0.leftPanle:Find("property_panel/init_panel/arrow2")
	arg_10_0.simulationBtn = arg_10_0.leftPanle:Find("property_panel/init_panel/property_title2/simulation")
	arg_10_0.attrPanel = arg_10_0.leftPanle:Find("property_panel/attr_panel")
	arg_10_0.modAdditionPanel = arg_10_0.leftPanle:Find("property_panel/attr_panel")
	arg_10_0.modAdditionContainer = arg_10_0.modAdditionPanel:Find("scroll_rect/content")
	arg_10_0.modAdditionTpl = arg_10_0.modAdditionContainer:Find("addition_tpl")
	arg_10_0.preViewBtn = arg_10_0.attrPanel:Find("pre_view")
	arg_10_0.stateInfo = arg_10_0.centerPanel:Find("state_info")
	arg_10_0.startBtn = arg_10_0.centerPanel:Find("state_info/start_btn")
	arg_10_0.lockPanel = arg_10_0.centerPanel:Find("state_info/lock_panel")
	arg_10_0.lockBtn = arg_10_0.lockPanel:Find("lock")
	arg_10_0.finishedBtn = arg_10_0.centerPanel:Find("state_info/finished_btn")
	arg_10_0.progressPanel = arg_10_0.centerPanel:Find("state_info/progress")

	setText(arg_10_0.progressPanel:Find("label"), i18n("blueprint_researching"))

	arg_10_0.progressContainer = arg_10_0.progressPanel:Find("content")
	arg_10_0.progressTpl = arg_10_0.progressContainer:Find("item")
	arg_10_0.openCondition = arg_10_0.centerPanel:Find("state_info/open_condition")
	arg_10_0.speedupBtn = arg_10_0._tf:Find("main/speedup_btn")
	arg_10_0.taskListPanel = arg_10_0.rightPanel:Find("task_list")
	arg_10_0.taskContainer = arg_10_0.rightPanel:Find("task_list/scroll/content")
	arg_10_0.taskTpl = arg_10_0.taskContainer:Find("task_tpl")
	arg_10_0.modPanel = arg_10_0.rightPanel:Find("mod_panel")
	arg_10_0.attrContainer = arg_10_0.modPanel:Find("desc/atrrs")
	arg_10_0.levelSlider = arg_10_0.modPanel:Find("title/slider"):GetComponent(typeof(Slider))
	arg_10_0.levelSliderTxt = arg_10_0.modPanel:Find("title/slider/Text")
	arg_10_0.preLevelSlider = arg_10_0.modPanel:Find("title/pre_slider"):GetComponent(typeof(Slider))
	arg_10_0.modLevel = arg_10_0.modPanel:Find("title/level_bg/Text"):GetComponent(typeof(Text))
	arg_10_0.needLevelTxt = arg_10_0.modPanel:Find("title/Text"):GetComponent(typeof(Text))
	arg_10_0.phantomPanel = arg_10_0.rightPanel:Find("phantom_panel")
	arg_10_0.rtPhantomQuestContainer = arg_10_0.phantomPanel:Find("desc/content")
	arg_10_0.questTpl = arg_10_0.rtPhantomQuestContainer:GetChild(0)
	arg_10_0.btnPhantom = arg_10_0.top:Find("phantomBtn")
	arg_10_0.calcPanel = arg_10_0.modPanel:Find("desc/calc_panel")
	arg_10_0.calcMinusBtn = arg_10_0.calcPanel:Find("calc/base/minus")
	arg_10_0.calcPlusBtn = arg_10_0.calcPanel:Find("calc/base/plus")
	arg_10_0.calcTxt = arg_10_0.calcPanel:Find("calc/base/count/Text")
	arg_10_0.calcMaxBtn = arg_10_0.calcPanel:Find("calc/max")
	arg_10_0.itemInfo = arg_10_0.calcPanel:Find("item_bg")
	arg_10_0.itemInfoIcon = arg_10_0.itemInfo:Find("icon")
	arg_10_0.itemInfoCount = arg_10_0.itemInfo:Find("kc")
	arg_10_0.modBtn = arg_10_0.calcPanel:Find("confirm_btn")
	arg_10_0.fittingBtn = arg_10_0.modPanel:Find("desc/fitting_btn")
	arg_10_0.fittingBtnEffect = arg_10_0.fittingBtn:Find("anim/ShipBlue02")
	arg_10_0.fittingPanel = arg_10_0.rightPanel:Find("fitting_panel")

	setActive(arg_10_0.fittingPanel, false)

	arg_10_0.fittingAttrPanel = arg_10_0.fittingPanel:Find("desc/middle")
	arg_10_0.phasePic = arg_10_0.fittingPanel:Find("title/phase")
	arg_10_0.phaseSlider = arg_10_0.fittingPanel:Find("desc/top/slider"):GetComponent(typeof(Slider))
	arg_10_0.phaseSliderTxt = arg_10_0.fittingPanel:Find("desc/top/precent")
	arg_10_0.prePhaseSlider = arg_10_0.fittingPanel:Find("desc/top/pre_slider"):GetComponent(typeof(Slider))
	arg_10_0.fittingNeedMask = arg_10_0.fittingPanel:Find("desc/top/mask")
	arg_10_0.fittingCalcPanel = arg_10_0.fittingPanel:Find("desc/bottom")
	arg_10_0.fittingCalcMinusBtn = arg_10_0.fittingCalcPanel:Find("calc/base/minus")
	arg_10_0.fittingCalcPlusBtn = arg_10_0.fittingCalcPanel:Find("calc/base/plus")
	arg_10_0.fittingCalcTxt = arg_10_0.fittingCalcPanel:Find("calc/base/count/Text")
	arg_10_0.fittingCalcMaxBtn = arg_10_0.fittingCalcPanel:Find("calc/max")
	arg_10_0.fittingItemInfo = arg_10_0.fittingCalcPanel:Find("item_bg")
	arg_10_0.fittingItemInfoIcon = arg_10_0.fittingItemInfo:Find("icon")
	arg_10_0.fittingItemInfoCount = arg_10_0.fittingItemInfo:Find("kc")
	arg_10_0.fittingConfirmBtn = arg_10_0.fittingCalcPanel:Find("confirm_btn")
	arg_10_0.fittingCancelBtn = arg_10_0.fittingCalcPanel:Find("cancel_btn")
	arg_10_0.msgPanel = arg_10_0.blurPanel:Find("msg_panel")

	setActive(arg_10_0.msgPanel, false)

	arg_10_0.versionPanel = arg_10_0._tf:Find("version_panel")

	setActive(arg_10_0.versionPanel, false)

	arg_10_0.preViewer = arg_10_0._tf:Find("preview")
	arg_10_0.preViewerFrame = arg_10_0._tf:Find("preview/frame")

	setText(arg_10_0.preViewerFrame:Find("bg/title/Image"), i18n("word_preview"))
	setActive(arg_10_0.preViewer, false)

	arg_10_0.sea = arg_10_0.preViewerFrame:Find("sea")
	arg_10_0.rawImage = arg_10_0.sea:GetComponent("RawImage")

	setActive(arg_10_0.rawImage, false)

	arg_10_0.seaLoading = arg_10_0.preViewerFrame:Find("bg/loading")
	arg_10_0.healTF = arg_10_0._tf:Find("resources/heal")
	arg_10_0.healTF.transform.localPosition = Vector3(-360, 50, 40)

	setActive(arg_10_0.healTF, false)

	arg_10_0.stages = arg_10_0.preViewerFrame:Find("stageScrollRect/stages")
	arg_10_0.breakView = arg_10_0.preViewerFrame:Find("content/Text")
	arg_10_0.previewAttrPanel = arg_10_0._tf:Find("preview/attrs_panel/attr_panel")
	arg_10_0.previewAttrContainer = arg_10_0.previewAttrPanel:Find("content")

	setText(arg_10_0._tf:Find("preview/attrs_panel/Text"), i18n("meta_energy_preview_tip"))
	setText(arg_10_0._tf:Find("preview/attrs_panel/desc"), i18n("meta_energy_preview_title"))

	arg_10_0.helpBtn = arg_10_0.top:Find("helpBtn")
	arg_10_0.exchangeBtn = arg_10_0.top:Find("exchangeBtn")
	arg_10_0.itemUnlockBtn = arg_10_0.top:Find("itemUnlockBtn")
	arg_10_0.bottomWidth = arg_10_0.bottomPanel.rect.height
	arg_10_0.topWidth = arg_10_0.topPanel.rect.height * 2
	arg_10_0.taskTFs = {}
	arg_10_0.leanTweens = {}
	arg_10_0.unlockPanel = arg_10_0.blurPanel:Find("unlock_panel")

	setActive(arg_10_0.unlockPanel, false)

	arg_10_0.svQuickExchange = BlueprintQuickExchangeView.New(arg_10_0._tf, arg_10_0.event)

	return
end

function var_0_0.didEnter(arg_11_0)
	local var_11_0 = getProxy(TechnologyProxy):getConfigMaxVersion()

	if not arg_11_0.contextData.shipBluePrintVO then
		local var_11_1 = {}

		for iter_11_0 = 1, var_11_0 do
			var_11_1[iter_11_0] = 0
		end

		for iter_11_1, iter_11_2 in pairs(arg_11_0.bluePrintByIds) do
			local var_11_2 = iter_11_2:getConfig("blueprint_version")

			var_11_1[var_11_2] = var_11_1[var_11_2] + (iter_11_2.state == ShipBluePrint.STATE_UNLOCK and 1 or 0)

			if iter_11_2.state == ShipBluePrint.STATE_DEV then
				arg_11_0.contextData.shipBluePrintVO = arg_11_0.contextData.shipBluePrintVO or iter_11_2

				break
			end
		end

		if not arg_11_0.contextData.shipBluePrintVO then
			for iter_11_3 = 1, var_11_0 do
				arg_11_0.version = iter_11_3

				if var_11_1[iter_11_3] <= 4 then
					break
				end
			end

			arg_11_0:emit(ShipBluePrintMediator.SET_TECHNOLOGY_VERSION, arg_11_0.version)
		end
	end

	arg_11_0:switchHide()
	arg_11_0:initShips()
	onButton(arg_11_0, arg_11_0.speedupBtn, function()
		arg_11_0:emit(ShipBluePrintMediator.ON_CLICK_SPEEDUP_BTN)

		return
	end, SFX_PANEL)
	onButton(arg_11_0, arg_11_0.backBtn, function()
		arg_11_0:closeView()

		return
	end, SOUND_BACK)
	onButton(arg_11_0, arg_11_0.startBtn, function()
		if not arg_11_0.contextData.shipBluePrintVO then
			return
		end

		arg_11_0:emit(ShipBluePrintMediator.ON_START, arg_11_0.contextData.shipBluePrintVO.id)

		return
	end, SFX_PANEL)
	onButton(arg_11_0, arg_11_0.finishedBtn, function()
		if not arg_11_0.contextData.shipBluePrintVO then
			return
		end

		arg_11_0:emit(ShipBluePrintMediator.ON_FINISHED, arg_11_0.contextData.shipBluePrintVO.id)

		return
	end, SFX_PANEL)
	onButton(arg_11_0, arg_11_0.itemUnlockBtn, function()
		if not arg_11_0.contextData.shipBluePrintVO then
			return
		end

		arg_11_0:showUnlockPanel()

		return
	end, SFX_PANEL)
	onButton(arg_11_0, arg_11_0.preViewBtn, function()
		arg_11_0:openPreView()

		return
	end, SFX_PANEL)
	onButton(arg_11_0, arg_11_0.seaLoading, function()
		if not arg_11_0.previewer then
			arg_11_0:showBarrage()
		end

		return
	end, SFX_PANEL)
	onButton(arg_11_0, arg_11_0.preViewer, function()
		arg_11_0:closePreview()

		return
	end, SFX_PANEL)
	onButton(arg_11_0, arg_11_0.eyeTF, function()
		if arg_11_0.isSwitchAnim then
			return
		end

		arg_11_0:switchHide()
		arg_11_0:switchState(var_0_7, not arg_11_0.flag)

		return
	end, SFX_PANEL)
	onButton(arg_11_0, arg_11_0.main, function()
		if arg_11_0.isSwitchAnim then
			return
		end

		if not arg_11_0.flag then
			arg_11_0:switchHide()
			arg_11_0:switchState(var_0_7, not arg_11_0.flag)
		end

		return
	end, SFX_PANEL)
	onButton(arg_11_0, arg_11_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip[isActive(arg_11_0.fittingPanel) and "help_shipblueprintui_luck" or "help_shipblueprintui"].tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_11_0, arg_11_0.exchangeBtn, function()
		arg_11_0.svQuickExchange:Load()
		arg_11_0.svQuickExchange:ActionInvoke("Show")
		arg_11_0.svQuickExchange:ActionInvoke("UpdateBlueprint", arg_11_0.contextData.shipBluePrintVO)

		return
	end)
	setText(arg_11_0.modPanel:Find("switch/Text"), i18n("tech_shadow_change_button_1"))
	onButton(arg_11_0, arg_11_0.modPanel:Find("switch"), function()
		arg_11_0:switchState(var_0_7, true, function()
			arg_11_0.isPhantom = true

			setActive(arg_11_0.phantomPanel, arg_11_0.isPhantom)
			setActive(arg_11_0.modPanel, not arg_11_0.isPhantom)

			return
		end)

		return
	end, SFX_PANEL)
	setText(arg_11_0.phantomPanel:Find("switch/Text"), i18n("tech_shadow_change_button_2"))
	onButton(arg_11_0, arg_11_0.phantomPanel:Find("switch"), function()
		arg_11_0:switchState(var_0_7, true, function()
			arg_11_0.isPhantom = false

			setActive(arg_11_0.phantomPanel, arg_11_0.isPhantom)
			setActive(arg_11_0.modPanel, not arg_11_0.isPhantom)

			return
		end)

		return
	end, SFX_PANEL)
	onButton(arg_11_0, arg_11_0.btnPhantom, function()
		arg_11_0:emit(ShipBluePrintMediator.OPEN_PHANTOM_LAYER, arg_11_0.version)

		return
	end, SFX_PANEL)
	arg_11_0:OverlayPanel(arg_11_0.blurPanel, {
		pbList = {
			arg_11_0.rightPanel:Find("task_list"),
			arg_11_0.rightPanel:Find("mod_panel"),
			arg_11_0.leftPanle:Find("property_panel"),
			arg_11_0.bottomPanel:Find("ships/bg")
		}
	})
	setText(arg_11_0.msgPanel:Find("window/top/bg/infomation/title"), i18n("title_info"))
	onButton(arg_11_0, arg_11_0.msgPanel:Find("window/top/btnBack"), function()
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_11_0.msgPanel, arg_11_0.top)
		setActive(arg_11_0.msgPanel, false)

		return
	end, SFX_CANCEL)
	setText(arg_11_0.msgPanel:Find("window/confirm_btn/Text"), i18n("text_confirm"))
	onButton(arg_11_0, arg_11_0.msgPanel:Find("window/confirm_btn"), function()
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_11_0.msgPanel, arg_11_0.top)
		setActive(arg_11_0.msgPanel, false)

		return
	end, SFX_CANCEL)
	onButton(arg_11_0, arg_11_0.msgPanel:Find("bg"), function()
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_11_0.msgPanel, arg_11_0.top)
		setActive(arg_11_0.msgPanel, false)

		return
	end, SFX_CANCEL)
	onButton(arg_11_0, arg_11_0.unlockPanel:Find("window/top/btnBack"), function()
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_11_0.unlockPanel, arg_11_0.top)
		setActive(arg_11_0.unlockPanel, false)

		return
	end, SFX_CANCEL)
	setText(arg_11_0.unlockPanel:Find("window/confirm_btn/Text"), i18n("text_confirm"))
	setText(arg_11_0.unlockPanel:Find("window/cancel_btn/Text"), i18n("text_cancel"))
	setText(arg_11_0.unlockPanel:Find("window/top/bg/infomation/title"), i18n("title_info"))
	onButton(arg_11_0, arg_11_0.unlockPanel:Find("window/cancel_btn"), function()
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_11_0.unlockPanel, arg_11_0.top)
		setActive(arg_11_0.unlockPanel, false)

		return
	end, SFX_CANCEL)
	onButton(arg_11_0, arg_11_0.unlockPanel:Find("bg"), function()
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_11_0.unlockPanel, arg_11_0.top)
		setActive(arg_11_0.unlockPanel, false)

		return
	end, SFX_CANCEL)
	GetImageSpriteFromAtlasAsync("ui/shipblueprintui_atlas", "version_" .. arg_11_0.version, arg_11_0.versionBtn)
	arg_11_0:updateVersionBtnTip()

	if var_11_0 > 1 then
		onButton(arg_11_0, arg_11_0.versionBtn, function()
			if arg_11_0.cbTimer then
				return
			end

			setActive(arg_11_0.versionPanel, true)
			pg.UIMgr.GetInstance():BlurPanel(arg_11_0.versionPanel)

			return
		end, SFX_PANEL)
		onButton(arg_11_0, arg_11_0.versionPanel:Find("bg"), function()
			pg.UIMgr.GetInstance():UnOverlayPanel(arg_11_0.versionPanel, arg_11_0._tf)
			setActive(arg_11_0.versionPanel, false)

			return
		end, SFX_CANCEL)

		local var_11_3 = UIItemList.New(arg_11_0.versionPanel:Find("window/content"), arg_11_0.versionPanel:Find("window/content/version_1"))

		var_11_3:make(function(arg_37_0, arg_37_1, arg_37_2)
			arg_37_1 = arg_37_1 + 1

			if arg_37_0 == UIItemList.EventUpdate then
				arg_37_2.name = "version_" .. arg_37_1

				GetImageSpriteFromAtlasAsync("ui/shipblueprintui_atlas", "newVersion_" .. arg_37_1, arg_37_2:Find("image"))

				if arg_11_0.version == arg_37_1 then
					setActive(arg_37_2:Find("choose"), true)
				else
					setActive(arg_37_2:Find("choose"), false)
				end

				onButton(arg_11_0, arg_37_2, function()
					arg_11_0.version = arg_37_1

					arg_11_0:emit(ShipBluePrintMediator.SET_TECHNOLOGY_VERSION, arg_11_0.version)

					arg_11_0.contextData.shipBluePrintVO = nil

					GetImageSpriteFromAtlasAsync("ui/shipblueprintui_atlas", "version_" .. arg_11_0.version, arg_11_0.versionBtn)
					arg_11_0:initShips()
					arg_11_0:updateVersionBtnTip()
					var_11_3:align(var_11_0)
					pg.UIMgr.GetInstance():UnOverlayPanel(arg_11_0.versionPanel, arg_11_0._tf)
					setActive(arg_11_0.versionPanel, false)

					return
				end, SFX_CANCEL)
			end

			return
		end)
		var_11_3:align(var_11_0)
		arg_11_0:updateVersionPanelBtnTip()
	end

	LeanTween.alpha(rtf(arg_11_0.skillArrLeft), 0.25, 1):setEase(LeanTweenType.easeInOutSine):setLoopPingPong()
	LeanTween.alpha(rtf(arg_11_0.skillArrRight), 0.25, 1):setEase(LeanTweenType.easeInOutSine):setLoopPingPong()

	return
end

function var_0_0.updateVersionBtnTip(arg_39_0)
	local var_39_0 = getProxy(TechnologyProxy)

	for iter_39_0 = 1, var_39_0:getConfigMaxVersion() do
		if iter_39_0 ~= arg_39_0.version then
			table.insert({}, iter_39_0)
		end
	end

	setActive(arg_39_0.versionBtn:Find("tip"), var_39_0:CheckPursuingCostTip({}))

	return
end

function var_0_0.updateVersionPanelBtnTip(arg_40_0)
	local var_40_0 = getProxy(TechnologyProxy)

	for iter_40_0 = 1, var_40_0:getConfigMaxVersion() do
		setActive(arg_40_0.versionPanel:Find("window/content/version_" .. iter_40_0 .. "/tip"), var_40_0:CheckPursuingCostTip({
			iter_40_0
		}))
	end

	return
end

function var_0_0.updateAllPursuingCostTip(arg_41_0)
	arg_41_0:updateVersionBtnTip()
	arg_41_0:updateVersionPanelBtnTip()

	for iter_41_0, iter_41_1 in pairs(arg_41_0.bluePrintItems) do
		iter_41_1:updatePursuingTip()
	end

	return
end

function var_0_0.switchHide(arg_42_0)
	local var_42_0 = not arg_42_0.flag

	LeanTween.cancel(arg_42_0.bottomPanel)
	LeanTween.cancel(arg_42_0.topPanel)
	LeanTween.cancel(arg_42_0.topBg)

	if var_42_0 then
		LeanTween.moveY(arg_42_0.bottomPanel, 0, var_0_7)
		LeanTween.moveY(arg_42_0.topPanel, 0, var_0_7)
		LeanTween.moveY(arg_42_0.topBg, 0, var_0_7)
	else
		LeanTween.moveY(arg_42_0.bottomPanel, -arg_42_0.bottomWidth, var_0_7)
		LeanTween.moveY(arg_42_0.topPanel, arg_42_0.topWidth, var_0_7)
		LeanTween.moveY(arg_42_0.topBg, arg_42_0.topWidth, var_0_7)
	end

	setActive(arg_42_0.nameTF, var_42_0)
	setActive(arg_42_0.stateInfo, var_42_0)
	setActive(arg_42_0.helpBtn, var_42_0)
	setActive(arg_42_0.exchangeBtn, var_42_0)
	setActive(arg_42_0.btnPhantom, var_42_0)
	setImageAlpha(arg_42_0.itemUnlockBtn, var_42_0 and 1 or 0)
	setImageRaycastTarget(arg_42_0.itemUnlockBtn, var_42_0)
	setImageAlpha(arg_42_0.speedupBtn, var_42_0 and 1 or 0)
	setImageRaycastTarget(arg_42_0.speedupBtn, var_42_0)

	return
end

function var_0_0.switchState(arg_43_0, arg_43_1, arg_43_2, arg_43_3, arg_43_4)
	if arg_43_0.flag then
		table.insert({}, function(arg_44_0)
			arg_43_0.flag = false

			arg_43_0:switchUI(arg_43_1, {
				-arg_43_0.leftPanle.rect.width - 16,
				arg_43_0.rightPanel.rect.width + 16
			}, arg_44_0)

			return
		end)
	end

	table.insert({}, function(arg_45_0)
		existCall(arg_43_3)

		return arg_45_0()
	end)

	if arg_43_2 then
		table.insert({}, function(arg_46_0)
			arg_43_0.flag = true

			if arg_43_0.isFate or arg_43_0.isPhantom then
				arg_43_0:switchUI(arg_43_1, {
					-arg_43_0.leftPanle.rect.width - 16,
					0,
					-arg_43_0.leftPanle.rect.width / 2
				}, arg_46_0)
			else
				arg_43_0:switchUI(arg_43_1, {
					0,
					0,
					0
				}, arg_46_0)
			end

			return
		end)
	end

	seriesAsync({}, arg_43_4)

	return
end

function var_0_0.switchUI(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
	LeanTween.cancel(arg_47_0.leftPanle)
	LeanTween.cancel(arg_47_0.rightPanel)
	LeanTween.cancel(arg_47_0.centerPanel)

	arg_47_0.isSwitchAnim = true

	parallelAsync({
		function(arg_48_0)
			LeanTween.moveX(arg_47_0.leftPanle, arg_47_2[1], arg_47_1):setOnComplete(System.Action(arg_48_0))

			return
		end,
		function(arg_49_0)
			LeanTween.moveX(arg_47_0.rightPanel, arg_47_2[2], arg_47_1):setOnComplete(System.Action(arg_49_0))

			return
		end,
		function(arg_50_0)
			if arg_47_2[3] then
				LeanTween.moveX(arg_47_0.centerPanel, arg_47_2[3], arg_47_1):setOnComplete(System.Action(arg_50_0))
			else
				arg_50_0()
			end

			return
		end
	}, function()
		arg_47_0.isSwitchAnim = false

		return arg_47_3()
	end)

	return
end

function var_0_0.createShipItem(arg_52_0, arg_52_1)
	({
		init = function(arg_53_0)
			arg_53_0._go = arg_52_1
			arg_53_0._tf = tf(arg_52_1)
			arg_53_0.icon = arg_53_0._tf:Find("icon")
			arg_53_0.state = arg_53_0._tf:Find("state")
			arg_53_0.count = arg_53_0._tf:Find("count")
			arg_53_0.tip = arg_53_0._tf:Find("tip")

			return
		end,
		update = function(arg_54_0, arg_54_1, arg_54_2)
			SetCompomentEnabled(arg_54_0._tf, typeof(Toggle), arg_54_1.id > 0)

			arg_54_0.shipBluePrintVO = arg_54_1

			setActive(arg_54_0.state, arg_54_0.shipBluePrintVO.id > 0)
			setActive(arg_54_0.count, arg_54_0.shipBluePrintVO.id > 0)

			if arg_54_0.shipBluePrintVO.id > 0 then
				LoadSpriteAsync("shipdesignicon/" .. arg_54_0.shipBluePrintVO:getShipVO():getPainting(), function(arg_55_0)
					if arg_54_0.shipBluePrintVO.id > 0 then
						if string.find(arg_55_0.name, arg_54_0.shipBluePrintVO:getShipVO():getPainting()) then
							setImageSprite(arg_54_0.icon, arg_55_0)
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
				setText(arg_54_0.count, arg_54_2.count > 999 and "999+" or arg_54_2.count)
				setActive(arg_54_0.count:Find("icon"), not var_54_0.pursuing)
				setActive(arg_54_0.count:Find("icon_2"), var_54_0.pursuing)
				setText(arg_54_0.state:Find("dev/Text"), arg_54_0.shipBluePrintVO.level)

				if var_54_0.fate then
					GetImageSpriteFromAtlasAsync("ui/shipblueprintui_atlas", "icon_phase_" .. arg_54_0.shipBluePrintVO.fateLevel, arg_54_0.state:Find("fate/Image"), true)
				end

				eachChild(arg_54_0.state, function(arg_60_0)
					setActive(arg_60_0, arg_60_0.name == var_54_0.state)

					return
				end)
				setActive(arg_54_0.tip, var_54_0.tip)
			else
				LoadSpriteAsync("shipdesignicon/empty", function(arg_61_0)
					if arg_54_0.shipBluePrintVO.id < 0 then
						setImageSprite(arg_54_0.icon, arg_61_0)
					end

					return
				end)
				setActive(arg_54_0.tip, false)
			end

			return
		end,
		updateSelectedStyle = function(arg_62_0, arg_62_1)
			local var_62_0 = arg_62_1 and 0 or -25

			LeanTween.cancel(arg_62_0.icon)
			LeanTween.moveY(arg_62_0.icon, var_62_0, 0.1)

			return
		end,
		updatePursuingTip = function(arg_63_0)
			setActive(arg_63_0.count:Find("icon_2/tip"), arg_63_0.shipBluePrintVO.id > 0 and arg_63_0.shipBluePrintVO:isPursuingCostTip())

			return
		end
	}).init({
		init = function(arg_53_0)
			arg_53_0._go = arg_52_1
			arg_53_0._tf = tf(arg_52_1)
			arg_53_0.icon = arg_53_0._tf:Find("icon")
			arg_53_0.state = arg_53_0._tf:Find("state")
			arg_53_0.count = arg_53_0._tf:Find("count")
			arg_53_0.tip = arg_53_0._tf:Find("tip")

			return
		end,
		update = function(arg_54_0, arg_54_1, arg_54_2)
			SetCompomentEnabled(arg_54_0._tf, typeof(Toggle), arg_54_1.id > 0)

			arg_54_0.shipBluePrintVO = arg_54_1

			setActive(arg_54_0.state, arg_54_0.shipBluePrintVO.id > 0)
			setActive(arg_54_0.count, arg_54_0.shipBluePrintVO.id > 0)

			if arg_54_0.shipBluePrintVO.id > 0 then
				LoadSpriteAsync("shipdesignicon/" .. arg_54_0.shipBluePrintVO:getShipVO():getPainting(), function(arg_55_0)
					if arg_54_0.shipBluePrintVO.id > 0 then
						if string.find(arg_55_0.name, arg_54_0.shipBluePrintVO:getShipVO():getPainting()) then
							setImageSprite(arg_54_0.icon, arg_55_0)
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
				setText(arg_54_0.count, arg_54_2.count > 999 and "999+" or arg_54_2.count)
				setActive(arg_54_0.count:Find("icon"), not var_54_0.pursuing)
				setActive(arg_54_0.count:Find("icon_2"), var_54_0.pursuing)
				setText(arg_54_0.state:Find("dev/Text"), arg_54_0.shipBluePrintVO.level)

				if var_54_0.fate then
					GetImageSpriteFromAtlasAsync("ui/shipblueprintui_atlas", "icon_phase_" .. arg_54_0.shipBluePrintVO.fateLevel, arg_54_0.state:Find("fate/Image"), true)
				end

				eachChild(arg_54_0.state, function(arg_60_0)
					setActive(arg_60_0, arg_60_0.name == var_54_0.state)

					return
				end)
				setActive(arg_54_0.tip, var_54_0.tip)
			else
				LoadSpriteAsync("shipdesignicon/empty", function(arg_61_0)
					if arg_54_0.shipBluePrintVO.id < 0 then
						setImageSprite(arg_54_0.icon, arg_61_0)
					end

					return
				end)
				setActive(arg_54_0.tip, false)
			end

			return
		end,
		updateSelectedStyle = function(arg_62_0, arg_62_1)
			local var_62_0 = arg_62_1 and 0 or -25

			LeanTween.cancel(arg_62_0.icon)
			LeanTween.moveY(arg_62_0.icon, var_62_0, 0.1)

			return
		end,
		updatePursuingTip = function(arg_63_0)
			setActive(arg_63_0.count:Find("icon_2/tip"), arg_63_0.shipBluePrintVO.id > 0 and arg_63_0.shipBluePrintVO:isPursuingCostTip())

			return
		end
	})
	onButton(arg_52_0, ({
		init = function(arg_53_0)
			arg_53_0._go = arg_52_1
			arg_53_0._tf = tf(arg_52_1)
			arg_53_0.icon = arg_53_0._tf:Find("icon")
			arg_53_0.state = arg_53_0._tf:Find("state")
			arg_53_0.count = arg_53_0._tf:Find("count")
			arg_53_0.tip = arg_53_0._tf:Find("tip")

			return
		end,
		update = function(arg_54_0, arg_54_1, arg_54_2)
			SetCompomentEnabled(arg_54_0._tf, typeof(Toggle), arg_54_1.id > 0)

			arg_54_0.shipBluePrintVO = arg_54_1

			setActive(arg_54_0.state, arg_54_0.shipBluePrintVO.id > 0)
			setActive(arg_54_0.count, arg_54_0.shipBluePrintVO.id > 0)

			if arg_54_0.shipBluePrintVO.id > 0 then
				LoadSpriteAsync("shipdesignicon/" .. arg_54_0.shipBluePrintVO:getShipVO():getPainting(), function(arg_55_0)
					if arg_54_0.shipBluePrintVO.id > 0 then
						if string.find(arg_55_0.name, arg_54_0.shipBluePrintVO:getShipVO():getPainting()) then
							setImageSprite(arg_54_0.icon, arg_55_0)
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
				setText(arg_54_0.count, arg_54_2.count > 999 and "999+" or arg_54_2.count)
				setActive(arg_54_0.count:Find("icon"), not var_54_0.pursuing)
				setActive(arg_54_0.count:Find("icon_2"), var_54_0.pursuing)
				setText(arg_54_0.state:Find("dev/Text"), arg_54_0.shipBluePrintVO.level)

				if var_54_0.fate then
					GetImageSpriteFromAtlasAsync("ui/shipblueprintui_atlas", "icon_phase_" .. arg_54_0.shipBluePrintVO.fateLevel, arg_54_0.state:Find("fate/Image"), true)
				end

				eachChild(arg_54_0.state, function(arg_60_0)
					setActive(arg_60_0, arg_60_0.name == var_54_0.state)

					return
				end)
				setActive(arg_54_0.tip, var_54_0.tip)
			else
				LoadSpriteAsync("shipdesignicon/empty", function(arg_61_0)
					if arg_54_0.shipBluePrintVO.id < 0 then
						setImageSprite(arg_54_0.icon, arg_61_0)
					end

					return
				end)
				setActive(arg_54_0.tip, false)
			end

			return
		end,
		updateSelectedStyle = function(arg_62_0, arg_62_1)
			local var_62_0 = arg_62_1 and 0 or -25

			LeanTween.cancel(arg_62_0.icon)
			LeanTween.moveY(arg_62_0.icon, var_62_0, 0.1)

			return
		end,
		updatePursuingTip = function(arg_63_0)
			setActive(arg_63_0.count:Find("icon_2/tip"), arg_63_0.shipBluePrintVO.id > 0 and arg_63_0.shipBluePrintVO:isPursuingCostTip())

			return
		end
	}).count:Find("icon_2"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("blueprint_catchup_by_gold_help")
		})

		return
	end, SFX_PANEL)

	return {
		init = function(arg_53_0)
			arg_53_0._go = arg_52_1
			arg_53_0._tf = tf(arg_52_1)
			arg_53_0.icon = arg_53_0._tf:Find("icon")
			arg_53_0.state = arg_53_0._tf:Find("state")
			arg_53_0.count = arg_53_0._tf:Find("count")
			arg_53_0.tip = arg_53_0._tf:Find("tip")

			return
		end,
		update = function(arg_54_0, arg_54_1, arg_54_2)
			SetCompomentEnabled(arg_54_0._tf, typeof(Toggle), arg_54_1.id > 0)

			arg_54_0.shipBluePrintVO = arg_54_1

			setActive(arg_54_0.state, arg_54_0.shipBluePrintVO.id > 0)
			setActive(arg_54_0.count, arg_54_0.shipBluePrintVO.id > 0)

			if arg_54_0.shipBluePrintVO.id > 0 then
				LoadSpriteAsync("shipdesignicon/" .. arg_54_0.shipBluePrintVO:getShipVO():getPainting(), function(arg_55_0)
					if arg_54_0.shipBluePrintVO.id > 0 then
						if string.find(arg_55_0.name, arg_54_0.shipBluePrintVO:getShipVO():getPainting()) then
							setImageSprite(arg_54_0.icon, arg_55_0)
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
				setText(arg_54_0.count, arg_54_2.count > 999 and "999+" or arg_54_2.count)
				setActive(arg_54_0.count:Find("icon"), not var_54_0.pursuing)
				setActive(arg_54_0.count:Find("icon_2"), var_54_0.pursuing)
				setText(arg_54_0.state:Find("dev/Text"), arg_54_0.shipBluePrintVO.level)

				if var_54_0.fate then
					GetImageSpriteFromAtlasAsync("ui/shipblueprintui_atlas", "icon_phase_" .. arg_54_0.shipBluePrintVO.fateLevel, arg_54_0.state:Find("fate/Image"), true)
				end

				eachChild(arg_54_0.state, function(arg_60_0)
					setActive(arg_60_0, arg_60_0.name == var_54_0.state)

					return
				end)
				setActive(arg_54_0.tip, var_54_0.tip)
			else
				LoadSpriteAsync("shipdesignicon/empty", function(arg_61_0)
					if arg_54_0.shipBluePrintVO.id < 0 then
						setImageSprite(arg_54_0.icon, arg_61_0)
					end

					return
				end)
				setActive(arg_54_0.tip, false)
			end

			return
		end,
		updateSelectedStyle = function(arg_62_0, arg_62_1)
			local var_62_0 = arg_62_1 and 0 or -25

			LeanTween.cancel(arg_62_0.icon)
			LeanTween.moveY(arg_62_0.icon, var_62_0, 0.1)

			return
		end,
		updatePursuingTip = function(arg_63_0)
			setActive(arg_63_0.count:Find("icon_2/tip"), arg_63_0.shipBluePrintVO.id > 0 and arg_63_0.shipBluePrintVO:isPursuingCostTip())

			return
		end
	}
end

function var_0_0.initShips(arg_65_0)
	arg_65_0:checkStory()
	arg_65_0:filterBlueprints()

	if not arg_65_0.itemList then
		arg_65_0.bluePrintItems = {}
		arg_65_0.itemList = UIItemList.New(arg_65_0.shipContainer, arg_65_0.shipContainer:Find("ship_tpl"))

		arg_65_0.itemList:make(function(arg_66_0, arg_66_1, arg_66_2)
			if arg_66_0 == UIItemList.EventUpdate then
				onToggle(arg_65_0, arg_66_2, function(arg_67_0)
					if arg_67_0 then
						if arg_65_0.cbTimer then
							arg_65_0.cbTimer:Stop()

							arg_65_0.cbTimer = nil
						end

						arg_65_0:clearLeanTween()

						arg_65_0.contextData.shipBluePrintVO = arg_65_0.bluePrintItems[arg_66_2].shipBluePrintVO

						if arg_65_0.nowShipId ~= arg_65_0.contextData.shipBluePrintVO.id then
							arg_65_0.nowShipId = arg_65_0.contextData.shipBluePrintVO.id

							arg_65_0:switchState(var_0_7, true, function()
								arg_65_0:setSelectedBluePrint()

								return
							end)
						else
							arg_65_0:setSelectedBluePrint()
						end
					end

					arg_65_0.bluePrintItems[arg_66_2]:updateSelectedStyle(arg_67_0)

					return
				end, SFX_PANEL)

				arg_65_0.bluePrintItems[arg_66_2] = arg_65_0.bluePrintItems[arg_66_2] or arg_65_0:createShipItem(arg_66_2)

				if arg_65_0.filterBlueprintVOs[arg_66_1 + 1].id > 0 then
					arg_65_0.bluePrintItems[arg_66_2]:update(arg_65_0.filterBlueprintVOs[arg_66_1 + 1], (arg_65_0:getItemById((arg_65_0.filterBlueprintVOs[arg_66_1 + 1]:getItemId()))))
					arg_65_0.bluePrintItems[arg_66_2]:updatePursuingTip()
				else
					arg_65_0.bluePrintItems[arg_66_2]:update(arg_65_0.filterBlueprintVOs[arg_66_1 + 1], nil)
				end

				triggerToggle(arg_66_2, false)
			end

			return
		end)
	end

	setActive(arg_65_0.shipContainer, false)
	arg_65_0.itemList:align(#arg_65_0.filterBlueprintVOs)
	setActive(arg_65_0.shipContainer, true)

	if not arg_65_0.contextData.shipBluePrintVO or underscore.all(arg_65_0.filterBlueprintVOs, function(arg_69_0)
		return arg_65_0.contextData.shipBluePrintVO.id ~= arg_69_0.id
	end) then
		arg_65_0.contextData.shipBluePrintVO = arg_65_0.filterBlueprintVOs[1]
	end

	eachChild(arg_65_0.shipContainer, function(arg_70_0)
		if arg_65_0.contextData.shipBluePrintVO.id == arg_65_0.bluePrintItems[arg_70_0].shipBluePrintVO.id then
			triggerToggle(arg_70_0, true)
		end

		return
	end)

	return
end

function var_0_0.filterBlueprints(arg_71_0)
	if arg_71_0.contextData.shipBluePrintVO then
		arg_71_0.version = arg_71_0.contextData.shipBluePrintVO:getConfig("blueprint_version")

		arg_71_0:emit(ShipBluePrintMediator.SET_TECHNOLOGY_VERSION, arg_71_0.version)
	end

	arg_71_0.filterBlueprintVOs = {}

	local var_71_0 = 0

	for iter_71_0, iter_71_1 in pairs(arg_71_0.bluePrintByIds) do
		if iter_71_1:getConfig("blueprint_version") == arg_71_0.version then
			table.insert(arg_71_0.filterBlueprintVOs, iter_71_1)

			var_71_0 = var_71_0 + 1
		end
	end

	for iter_71_2 = var_71_0, 5 do
		table.insert(arg_71_0.filterBlueprintVOs, {
			id = -1,
			state = -1
		})
	end

	table.sort(arg_71_0.filterBlueprintVOs, CompareFuncs({
		function(arg_72_0)
			return -arg_72_0.state
		end,
		function(arg_73_0)
			return arg_73_0.id
		end
	}))

	return
end

function var_0_0.setSelectedBluePrint(arg_74_0)
	assert(arg_74_0.contextData.shipBluePrintVO, "should exist blue print")

	local var_74_0 = arg_74_0.contextData.shipBluePrintVO

	arg_74_0:updateInfo()
	arg_74_0:updatePainting()
	arg_74_0:updateProperty()

	local var_74_1 = var_74_0:isUnlock()

	setActive(arg_74_0.taskListPanel, not var_74_1)
	setActive(arg_74_0.attrDisableBtn, not var_74_1)

	if var_74_1 then
		if var_74_0:canFateSimulation() then
			if not pg.NewStoryMgr.GetInstance():IsPlayed(var_74_0:getConfig("luck_story")) then
				arg_74_0.isFate = false
			end

			arg_74_0:updateMod()
			arg_74_0:updatePhantomQuest()

			if false then
				arg_74_0.isFate = false

				arg_74_0:updateTaskList()
				triggerToggle(arg_74_0.initBtn, true)
			end

			setActive(arg_74_0.phantomPanel, var_74_1 and arg_74_0.isPhantom)
			setActive(arg_74_0.fittingPanel, var_74_1 and arg_74_0.isFate)
			setActive(arg_74_0.modPanel, var_74_1 and not arg_74_0.isFate and not arg_74_0.isPhantom)
			setActive(arg_74_0.itemUnlockBtn, not var_74_1 and var_74_0:getUnlockItem())

			if var_74_0:isDeving() then
				arg_74_0:emit(ShipBluePrintMediator.ON_CHECK_TAKES, var_74_0.id)
			end

			return
		end
	end
end

function var_0_0.updateMod(arg_75_0)
	if arg_75_0.noUpdateMod then
		return
	end

	if not arg_75_0.contextData.shipBluePrintVO or not var_75_0:isUnlock() or not var_75_0:isFetched() then
		return
	end

	arg_75_0:updateModPanel()
	arg_75_0:updateModAdditionPanel()

	return
end

function var_0_0.updateModInfo(arg_76_0, arg_76_1)
	local var_76_0 = arg_76_0:getShipById(arg_76_1.shipId)
	local var_76_1 = arg_76_0.contextData.shipBluePrintVO
	local var_76_2 = intProperties(arg_76_0.contextData.shipBluePrintVO:getShipProperties(var_76_0))
	local var_76_3 = Clone(arg_76_1)

	var_76_3.level = var_76_3:getMaxLevel()

	local var_76_4 = intProperties(var_76_3:getShipProperties(var_76_0))

	for iter_76_0, iter_76_1 in pairs((intProperties(arg_76_1:getShipProperties(var_76_0)))) do
		if table.contains(ShipModAttr.BLUEPRINT_ATTRS, iter_76_0) then
			local var_76_5 = arg_76_0.attrContainer:Find(iter_76_0)
			local var_76_8 = var_76_4[iter_76_0] or 0

			;(function(arg_77_0, arg_77_1, arg_77_2, arg_77_3)
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
			end)(var_76_5, iter_76_0, iter_76_1, var_76_8)
		end
	end

	arg_76_0.modLevel.text = arg_76_0:formatModLvTxt(arg_76_1.level, arg_76_1:getMaxLevel())

	local var_76_9 = var_76_1:getNextLevelExp()

	arg_76_0.levelSlider.value = var_76_9 == -1 and 1 or var_76_1.exp / var_76_9

	local var_76_10 = arg_76_1:getNextLevelExp()

	if var_76_10 == -1 then
		setText(arg_76_0.levelSliderTxt, "MAX")

		arg_76_0.preLevelSlider.value = 1
	else
		setText(arg_76_0.levelSliderTxt, arg_76_1.exp .. "/" .. arg_76_1:getNextLevelExp())

		arg_76_0.preLevelSlider.value = arg_76_1.level > var_76_1.level and 1 or arg_76_1.exp / var_76_10
	end

	local var_76_11, var_76_12 = arg_76_1:isShipModMaxLevel(var_76_0)

	setActive(arg_76_0.needLevelTxt, var_76_11)
	setActive(arg_76_0.levelSliderTxt, not var_76_11)

	if var_76_11 then
		setText(arg_76_0.needLevelTxt, i18n("buleprint_need_level_tip", var_76_12))

		arg_76_0.levelSlider.value = 1
	end

	return
end

function var_0_0.inModAnim(arg_78_0)
	return arg_78_0.inAnim
end

function var_0_0.formatModLvTxt(arg_79_0, arg_79_1, arg_79_2)
	return "<size=45>" .. arg_79_1 .. "</size>/<size=27>" .. arg_79_2 .. "</size>"
end

local var_0_8 = 0.2

function var_0_0.doModAnim(arg_80_0, arg_80_1, arg_80_2)
	arg_80_0:clearLeanTween()

	arg_80_0.inAnim = true

	local var_80_0 = {}
	local var_80_1 = arg_80_2:getMaxLevel()

	if arg_80_1.level ~= var_80_1 then
		local function var_80_2(arg_81_0, arg_81_1, arg_81_2)
			arg_81_0 = Clone(arg_81_0)
			arg_81_0.level = arg_81_1
			arg_81_0.exp = arg_81_2

			return arg_81_0
		end

		arg_80_0.preLevelSlider.value = 0

		for iter_80_0 = arg_80_1.level, arg_80_2.level do
			local var_80_3 = iter_80_0 == arg_80_1.level and arg_80_1.exp / arg_80_1:getNextLevelExp() or 0
			local var_80_4 = iter_80_0 == arg_80_2.level and arg_80_2.level ~= var_80_1 and arg_80_2.exp / arg_80_2:getNextLevelExp() or 1

			table.insert(var_80_0, function(arg_82_0)
				TweenValue(go(arg_80_0.levelSlider), var_80_3, var_80_4, var_0_8, nil, function(arg_83_0)
					arg_80_0.levelSlider.value = arg_83_0

					return
				end, function()
					if iter_80_0 == arg_80_1.level then
						local var_84_0 = arg_80_1 or var_80_2(arg_80_1, iter_80_0, 0)

						if iter_80_0 == arg_80_2.level then
							local var_84_1 = arg_80_2 or var_80_2(arg_80_1, iter_80_0 + 1, 0)

							arg_80_0:doAttrsAinm(var_84_0, var_84_1, arg_82_0)

							arg_80_0.modLevel.text = arg_80_0:formatModLvTxt(var_84_1.level, var_80_1)

							return
						end
					end
				end)

				return
			end)
		end

		table.insert(arg_80_0.leanTweens, arg_80_0.levelSlider)
	else
		var_80_1 = arg_80_2:getMaxFateLevel()

		local function var_80_5(arg_85_0, arg_85_1, arg_85_2)
			arg_85_0 = Clone(arg_85_0)
			arg_85_0.fateLevel = arg_85_1
			arg_85_0.exp = arg_85_2

			return arg_85_0
		end

		arg_80_0.prePhaseSlider.value = 0

		for iter_80_1 = arg_80_1.fateLevel, arg_80_2.fateLevel do
			local var_80_6 = iter_80_1 == arg_80_1.fateLevel and arg_80_1.exp / arg_80_1:getNextFateLevelExp() or 0
			local var_80_7 = iter_80_1 == arg_80_2.fateLevel and arg_80_2.fateLevel ~= var_80_1 and arg_80_2.exp / arg_80_2:getNextFateLevelExp() or 1

			table.insert(var_80_0, function(arg_86_0)
				TweenValue(go(arg_80_0.phaseSlider), var_80_6, var_80_7, var_0_8, nil, function(arg_87_0)
					arg_80_0.phaseSlider.value = arg_87_0

					return
				end, function()
					if iter_80_1 ~= arg_80_1.fateLevel or not arg_80_1 then
						local var_88_0 = var_80_5(arg_80_1, iter_80_1, 0)
					end

					if iter_80_1 == arg_80_2.fateLevel then
						local var_88_1 = arg_80_2 or var_80_5(arg_80_1, iter_80_1 + 1, 0)

						arg_80_0:updateFittingAttrPanel(var_88_1)
						GetImageSpriteFromAtlasAsync("ui/shipblueprintui_atlas", "phase_" .. math.min(var_88_1.fateLevel + 1, var_88_1:getMaxFateLevel()), arg_80_0.phasePic, true)
						arg_86_0()

						return
					end
				end)

				return
			end)
		end

		table.insert(arg_80_0.leanTweens, arg_80_0.phaseSlider)
	end

	seriesAsync(var_80_0, function()
		arg_80_0.noUpdateMod = false

		arg_80_0:updateMod()

		arg_80_0.inAnim = false

		return
	end)

	return
end

function var_0_0.doAttrsAinm(arg_90_0, arg_90_1, arg_90_2, arg_90_3)
	local var_90_9000
	local var_90_0 = arg_90_0:getShipById(arg_90_1.shipId)
	local var_90_1 = intProperties(arg_90_1:getShipProperties(var_90_0))
	local var_90_2 = intProperties(arg_90_2:getShipProperties(var_90_0))

	for iter_90_0, iter_90_1 in ipairs(ShipModAttr.BLUEPRINT_ATTRS) do
		if iter_90_1 ~= AttributeType.AntiAircraft then
			local var_90_3 = arg_90_0.attrContainer:Find(iter_90_1)
			local var_90_4 = var_90_3:Find("attr_bg/value")
			local var_90_5 = var_90_4.GetComponent(var_90_9000, typeof(Text))
			local var_90_6 = var_90_3:Find("slider"):GetComponent(typeof(Slider))
			local var_90_7 = var_90_3:Find("pre_slider").GetComponent(var_90_4, typeof(Slider))
			local var_90_8 = arg_90_1:getExpRetio((table.indexof(ShipModAttr.BLUEPRINT_ATTRS, iter_90_1)))
			local var_90_9 = var_90_1[iter_90_1]
			local var_90_10 = var_90_2[iter_90_1]
			local var_90_11, var_90_12 = arg_90_1:getBluePrintAddition(iter_90_1)
			local var_90_13, var_90_14 = arg_90_2:getBluePrintAddition(iter_90_1)
			local var_90_15 = var_90_12 / var_90_8
			local var_90_16 = var_90_14 / var_90_8

			var_90_7.value = 0

			table.insert({}, function(arg_91_0)
				arg_90_0:doAttrAnim(var_90_6, var_90_5, var_90_15, var_90_16, math.floor(var_90_11), math.floor(var_90_13), var_90_9, var_90_10, arg_91_0)

				return
			end)
		end
	end

	parallelAsync({}, arg_90_3)

	return
end

local var_0_9 = 0.1

function var_0_0.doAttrAnim(arg_92_0, arg_92_1, arg_92_2, arg_92_3, arg_92_4, arg_92_5, arg_92_6, arg_92_7, arg_92_8, arg_92_9)
	table.insert(arg_92_0.leanTweens, arg_92_1)

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

function var_0_0.clearLeanTween(arg_97_0, arg_97_1)
	for iter_97_0, iter_97_1 in pairs(arg_97_0.leanTweens) do
		if LeanTween.isTweening(go(iter_97_1)) then
			LeanTween.cancel(go(iter_97_1))
		end
	end

	if arg_97_0.inAnim then
		arg_97_0.inAnim = nil

		if not arg_97_1 then
			arg_97_0.noUpdateMod = false
		end
	end

	arg_97_0.leanTweens = {}

	return
end

function var_0_0.updateModPanel(arg_98_0)
	local var_98_0 = arg_98_0.contextData.shipBluePrintVO
	local var_98_1 = arg_98_0:getShipById(arg_98_0.contextData.shipBluePrintVO.shipId)
	local var_98_2 = arg_98_0:getItemById((arg_98_0.contextData.shipBluePrintVO:getConfig("strengthen_item")))
	local var_98_3 = var_98_2.count == 0 and var_98_0:isPursuing()
	local var_98_4 = 0
	local var_98_5
	local var_98_6

	if var_98_3 then
		local var_98_7 = getProxy(TechnologyProxy)

		var_98_5 = math.min(getProxy(TechnologyProxy):calcMaxPursuingCount(var_98_0), var_98_0:getUseageMaxItem())

		function var_98_6(arg_99_0)
			local var_99_0 = Clone(var_98_0)

			var_99_0:addExp(arg_99_0 * var_98_0:getItemExp())
			arg_98_0:updateModInfo(var_99_0)
			setText(arg_98_0.calcTxt, arg_99_0)

			local var_99_1 = var_98_0:isRarityUR()
			local var_99_2 = TechnologyProxy.getPursuingDiscount(var_98_7:getPursuingTimes(var_99_1) + var_98_4 + 1, var_99_1)

			setText(arg_98_0.itemInfoIcon:Find("icon_bg/count"), var_98_0:getPursuingPrice(var_99_2))
			setActive(arg_98_0.itemInfo:Find("no_cost"), var_99_2 == 0)
			setActive(arg_98_0.itemInfo:Find("discount"), var_99_2 > 0 and var_99_2 < 100)

			if var_99_2 > 0 and var_99_2 < 100 then
				setText(arg_98_0.itemInfo:Find("discount/Text"), 100 - var_99_2 .. "%OFF")
			end

			setActive(arg_98_0.modBtn:Find("pursuing_cost"), var_98_4 > 0)
			setText(arg_98_0.modBtn:Find("pursuing_cost/Text"), var_98_7:calcPursuingCost(var_98_0, arg_99_0))

			return
		end

		local var_98_8 = {
			type = DROP_TYPE_RESOURCE,
			id = PlayerConst.ResGold
		}

		updateDrop(arg_98_0.itemInfoIcon, {
			type = DROP_TYPE_RESOURCE,
			id = PlayerConst.ResGold
		})
		onButton(arg_98_0, arg_98_0.itemInfoIcon, function()
			if LOCK_TECHNOLOGY_PURSUING_TIP then
				arg_98_0:emit(BaseUI.ON_DROP, var_98_8)
			else
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_HELP,
					helps = i18n("blueprint_catchup_by_gold_help")
				})
			end

			return
		end, SFX_PANEL)
		setScrollText(findTF(arg_98_0.itemInfo, "name/Text"), ({
			type = DROP_TYPE_RESOURCE,
			id = PlayerConst.ResGold
		}):getConfig("name"))
		setText(arg_98_0.itemInfoCount, i18n("tec_tip_material_stock") .. ":" .. getProxy(PlayerProxy):getRawData():getResource(PlayerConst.ResGold))
		setText(arg_98_0.itemInfo:Find("no_cost/Text"), i18n("tec_tip_no_consumption"))
		setText(arg_98_0.modBtn:Find("pursuing_cost/word"), i18n("tec_tip_to_consumption"))
		onButton(arg_98_0, arg_98_0.modBtn, function()
			if arg_98_0:inModAnim() then
				return
			end

			if var_98_4 == 0 then
				return
			end

			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("blueprint_catchup_by_gold_confirm", var_98_7:calcPursuingCost(var_98_0, var_98_4)),
				onYes = function()
					arg_98_0:emit(ShipBluePrintMediator.ON_PURSUING, var_98_0.id, var_98_4)

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
			arg_98_0:updateModInfo(var_103_0)
			setText(arg_98_0.calcTxt, arg_103_0)

			return
		end

		updateDrop(arg_98_0.itemInfoIcon, {
			type = DROP_TYPE_ITEM,
			id = var_98_2.id
		})
		onButton(arg_98_0, arg_98_0.itemInfoIcon, function()
			ItemTipPanel.ShowItemTipbyID(var_98_2.id, i18n("title_item_ways", var_98_2:getConfig("name")))

			return
		end, SFX_PANEL)
		setScrollText(findTF(arg_98_0.itemInfo, "name/Text"), var_98_2:getConfig("name"))
		setText(arg_98_0.itemInfoCount, i18n("tec_tip_material_stock") .. ":" .. var_98_2.count)
		setActive(arg_98_0.itemInfo:Find("no_cost"), false)
		setActive(arg_98_0.itemInfo:Find("discount"), false)
		setActive(arg_98_0.modBtn:Find("pursuing_cost"), false)
		onButton(arg_98_0, arg_98_0.modBtn, function()
			if arg_98_0:inModAnim() then
				return
			end

			if var_98_4 == 0 then
				return
			end

			arg_98_0:emit(ShipBluePrintMediator.ON_MOD, var_98_0.id, var_98_4)

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

	pressPersistTrigger(arg_98_0.calcMinusBtn, 0.5, function(arg_106_0)
		if arg_98_0:inModAnim() or var_98_0:isMaxLevel() or var_98_4 == 0 then
			arg_106_0()

			return
		end

		var_98_4 = var_98_4 - 1

		var_98_6(var_98_4)

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	pressPersistTrigger(arg_98_0.calcPlusBtn, 0.5, function(arg_107_0)
		if arg_98_0:inModAnim() or var_98_0:isMaxLevel() or var_98_4 == var_98_12 then
			arg_107_0()

			return
		end

		var_98_4 = var_98_4 + 1

		var_98_6(var_98_4)

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	onButton(arg_98_0, arg_98_0.calcMaxBtn, function()
		if arg_98_0:inModAnim() or var_98_0:isMaxLevel() or var_98_4 == var_98_12 then
			return
		end

		var_98_4 = var_98_12

		var_98_6(var_98_4)

		return
	end, SFX_PANEL)
	setActive(arg_98_0.calcMaxBtn, not var_98_3)

	local var_98_13 = var_98_0:canFateSimulation()

	if var_98_13 then
		onButton(arg_98_0, arg_98_0.fittingBtn, function()
			if arg_98_0.isSwitchAnim then
				return
			end

			setActive(arg_98_0.fittingBtnEffect, true)

			arg_98_0.cbTimer = Timer.New(function()
				arg_98_0.cbTimer = nil

				setActive(arg_98_0.fittingBtnEffect, false)
				arg_98_0:switchState(var_0_7, true, function()
					arg_98_0.isFate = true

					setActive(arg_98_0.fittingPanel, arg_98_0.isFate)
					setActive(arg_98_0.modPanel, not arg_98_0.isFate)

					if not PlayerPrefs.HasKey("first_fate") then
						triggerButton(arg_98_0.helpBtn)
						PlayerPrefs.SetInt("first_fate", 1)
						PlayerPrefs.Save()
					end

					return
				end)

				return
			end, 0.6)

			arg_98_0.cbTimer:Start()

			return
		end, SFX_PANEL)
		arg_98_0:updateFittingPanel()

		if not inGuide then
			pg.NewStoryMgr.GetInstance():Play(var_98_0:getConfig("luck_story"), function(arg_112_0)
				if arg_112_0 then
					arg_98_0:buildStartAni("fateStartWindow", function()
						triggerButton(arg_98_0.fittingBtn)

						return
					end)
				end

				return
			end)
		end
	end

	setActive(arg_98_0.calcPanel, not var_98_13)
	setActive(arg_98_0.fittingBtn, var_98_13)
	setActive(arg_98_0.fittingBtnEffect, false)

	return
end

function var_0_0.updateFittingPanel(arg_114_0)
	local var_114_0 = arg_114_0.contextData.shipBluePrintVO
	local var_114_1 = arg_114_0:getShipById(arg_114_0.contextData.shipBluePrintVO.shipId)
	local var_114_2 = arg_114_0:getItemById((arg_114_0.contextData.shipBluePrintVO:getConfig("strengthen_item")))
	local var_114_3 = var_114_2.count == 0 and var_114_0:isPursuing()
	local var_114_4 = 0
	local var_114_5
	local var_114_6

	if var_114_3 then
		local var_114_7 = getProxy(TechnologyProxy)

		var_114_5 = math.min(getProxy(TechnologyProxy):calcMaxPursuingCount(var_114_0), var_114_0:getFateUseageMaxItem())

		function var_114_6(arg_115_0)
			local var_115_0 = Clone(var_114_0)

			var_115_0:addExp(arg_115_0 * var_114_0:getItemExp())
			arg_114_0:updateFittingInfo(var_115_0)
			setText(arg_114_0.fittingCalcTxt, arg_115_0)

			local var_115_1 = var_114_0:isRarityUR()
			local var_115_2 = TechnologyProxy.getPursuingDiscount(var_114_7:getPursuingTimes(var_115_1) + var_114_4 + 1, var_115_1)

			setText(arg_114_0.fittingItemInfoIcon:Find("icon_bg/count"), var_114_0:getPursuingPrice(var_115_2))
			setActive(arg_114_0.fittingItemInfo:Find("no_cost"), var_115_2 == 0)
			setActive(arg_114_0.fittingItemInfo:Find("discount"), var_115_2 > 0 and var_115_2 < 100)

			if var_115_2 > 0 and var_115_2 < 100 then
				setText(arg_114_0.fittingItemInfo:Find("discount/Text"), 100 - var_115_2 .. "%OFF")
			end

			setActive(arg_114_0.fittingConfirmBtn:Find("pursuing_cost"), arg_115_0 > 0)
			setText(arg_114_0.fittingConfirmBtn:Find("pursuing_cost/Text"), var_114_7:calcPursuingCost(var_114_0, arg_115_0))

			return
		end

		local var_114_8 = {
			type = DROP_TYPE_RESOURCE,
			id = PlayerConst.ResGold
		}

		updateDrop(arg_114_0.fittingItemInfoIcon, {
			type = DROP_TYPE_RESOURCE,
			id = PlayerConst.ResGold
		})
		onButton(arg_114_0, arg_114_0.fittingItemInfoIcon, function()
			if LOCK_TECHNOLOGY_PURSUING_TIP then
				arg_114_0:emit(BaseUI.ON_DROP, var_114_8)
			else
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_HELP,
					helps = i18n("blueprint_catchup_by_gold_help")
				})
			end

			return
		end, SFX_PANEL)
		setScrollText(findTF(arg_114_0.fittingItemInfo, "name/Text"), ({
			type = DROP_TYPE_RESOURCE,
			id = PlayerConst.ResGold
		}):getConfig("name"))
		setText(arg_114_0.fittingItemInfoCount, i18n("tec_tip_material_stock") .. ":" .. getProxy(PlayerProxy):getRawData():getResource(PlayerConst.ResGold))
		setText(arg_114_0.fittingItemInfo:Find("no_cost/Text"), i18n("tec_tip_no_consumption"))
		setText(arg_114_0.fittingConfirmBtn:Find("pursuing_cost/word"), i18n("tec_tip_to_consumption"))
		onButton(arg_114_0, arg_114_0.fittingConfirmBtn, function()
			if arg_114_0:inModAnim() then
				return
			end

			if var_114_4 == 0 then
				return
			end

			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("blueprint_catchup_by_gold_confirm", var_114_7:calcPursuingCost(var_114_0, var_114_4)),
				onYes = function()
					arg_114_0:emit(ShipBluePrintMediator.ON_PURSUING, var_114_0.id, var_114_4)

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
			arg_114_0:updateFittingInfo(var_119_0)
			setText(arg_114_0.fittingCalcTxt, arg_119_0)

			return
		end

		updateDrop(arg_114_0.fittingItemInfoIcon, {
			type = DROP_TYPE_ITEM,
			id = var_114_2.id
		})
		onButton(arg_114_0, arg_114_0.fittingItemInfoIcon, function()
			ItemTipPanel.ShowItemTipbyID(var_114_2.id, i18n("title_item_ways", var_114_2:getConfig("name")))

			return
		end, SFX_PANEL)
		setScrollText(arg_114_0.fittingItemInfo:Find("name/Text"), var_114_2:getConfig("name"))
		setText(arg_114_0.fittingItemInfoCount, i18n("tec_tip_material_stock") .. ":" .. var_114_2.count)
		setActive(arg_114_0.fittingItemInfo:Find("no_cost"), false)
		setActive(arg_114_0.fittingItemInfo:Find("discount"), false)
		setActive(arg_114_0.fittingConfirmBtn:Find("pursuing_cost"), false)
		onButton(arg_114_0, arg_114_0.fittingConfirmBtn, function()
			if arg_114_0:inModAnim() then
				return
			end

			if var_114_4 == 0 then
				return
			end

			arg_114_0:emit(ShipBluePrintMediator.ON_MOD, var_114_0.id, var_114_4)

			return
		end, SFX_PANEL)
	end

	setText(arg_114_0.fittingAttrPanel:Find("attr/name"), AttributeType.Type2Name(AttributeType.Luck))
	setText(arg_114_0.fittingPanel:Find("desc/top/text/Text"), i18n("fate_phase_word"))
	onButton(arg_114_0, arg_114_0.fittingCancelBtn, function()
		arg_114_0:switchState(var_0_7, true, function()
			arg_114_0.isFate = false

			setActive(arg_114_0.fittingPanel, arg_114_0.isFate)
			setActive(arg_114_0.modPanel, not arg_114_0.isFate)

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

	pressPersistTrigger(arg_114_0.fittingCalcMinusBtn, 0.5, function(arg_124_0)
		if arg_114_0:inModAnim() or var_114_0:isMaxFateLevel() or var_114_4 == 0 then
			arg_124_0()

			return
		end

		var_114_4 = math.max(var_114_4 - 1, 0)

		var_114_6(var_114_4)

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	pressPersistTrigger(arg_114_0.fittingCalcPlusBtn, 0.5, function(arg_125_0)
		if arg_114_0:inModAnim() or var_114_0:isMaxFateLevel() or var_114_4 == var_114_12 then
			arg_125_0()

			return
		end

		var_114_4 = math.max(math.min(var_114_4 + 1, var_114_12), 0)

		var_114_6(var_114_4)

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	onButton(arg_114_0, arg_114_0.fittingCalcMaxBtn, function()
		if arg_114_0:inModAnim() or var_114_0:isMaxFateLevel() or var_114_4 == var_114_12 then
			return
		end

		var_114_4 = var_114_12

		var_114_6(var_114_4)

		return
	end, SFX_PANEL)
	setActive(arg_114_0.fittingCalcMaxBtn, not var_114_3)

	local var_114_13 = arg_114_0.fittingAttrPanel:Find("phase_panel")
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

		onButton(arg_114_0, var_114_17, function()
			arg_114_0:showFittingMsgPanel(iter_114_0)

			return
		end, SFX_PANEL)
	end

	for iter_114_5 = 1, var_114_0:getMaxFateLevel() do
		setAnchoredPosition(var_114_13:Find("phase_" .. iter_114_5), Vector2.zero)

		Vector2.zero.x = math.min(Vector2.zero.x, Vector2.zero.x)
		Vector2.zero.y = math.min(Vector2.zero.y, Vector2.zero.y)
		Vector2.zero.x = math.max(Vector2.zero.x, Vector2.zero.x)
		Vector2.zero.y = math.max(Vector2.zero.y, Vector2.zero.y)

		local var_114_20

		if var_114_15[iter_114_5] then
			var_114_20 = Vector2.zero + (var_114_16[iter_114_5] + var_114_16[iter_114_5 + 1]) * Vector2(math.cos(math.pi * var_114_15[iter_114_5] / 180), math.sin(math.pi * var_114_15[iter_114_5] / 180))
		end
	end

	setSizeDelta(var_114_13, Vector2.zero - Vector2.zero)
	setAnchoredPosition(var_114_13, {
		y = -Vector2.zero.y
	})
	var_114_6(var_114_4)

	return
end

function var_0_0.updateFittingInfo(arg_128_0, arg_128_1)
	local var_128_0 = arg_128_0:getShipById(arg_128_1.shipId)
	local var_128_1 = arg_128_0.contextData.shipBluePrintVO

	arg_128_0:updateFittingAttrPanel(arg_128_0.contextData.shipBluePrintVO, arg_128_1)
	GetImageSpriteFromAtlasAsync("ui/shipblueprintui_atlas", "phase_" .. math.max(arg_128_1.fateLevel, 1), arg_128_0.phasePic, true)

	local var_128_2 = var_128_1:getNextFateLevelExp()

	arg_128_0.phaseSlider.value = var_128_2 == -1 and 1 or var_128_1.exp / var_128_2

	local var_128_3 = arg_128_1:getNextFateLevelExp()

	if var_128_3 == -1 then
		setText(arg_128_0.phaseSliderTxt, "MAX")

		arg_128_0.prePhaseSlider.value = 1
	else
		setText(arg_128_0.phaseSliderTxt, tostring((math.floor(arg_128_1.exp / arg_128_1:getNextFateLevelExp() * 100))) .. "%")

		arg_128_0.prePhaseSlider.value = arg_128_1.fateLevel > var_128_1.fateLevel and 1 or arg_128_1.exp / var_128_3
	end

	local var_128_4, var_128_5 = arg_128_1:isShipModMaxFateLevel(var_128_0)

	setActive(arg_128_0.fittingNeedMask, var_128_4)

	if var_128_4 then
		setText(arg_128_0.fittingNeedMask:Find("limit"), i18n("buleprint_need_level_tip", var_128_5))

		arg_128_0.phaseSlider.value = 1
	end

	return
end

function var_0_0.updateFittingAttrPanel(arg_129_0, arg_129_1, arg_129_2)
	setText(arg_129_0.fittingAttrPanel:Find("attr/name/Text"), " + " .. defaultValue((arg_129_2 or arg_129_1):attrSpecialAddition()[AttributeType.Luck], 0))

	arg_129_0.blinkTarget = arg_129_0.blinkTarget or {
		{},
		{}
	}

	for iter_129_0 = 1, arg_129_1:getMaxFateLevel() do
		local var_129_0 = arg_129_0.fittingAttrPanel:Find("phase_panel/phase_" .. iter_129_0)
		local var_129_1 = var_129_0:Find("off")
		local var_129_2 = var_129_0:Find("on")

		if arg_129_2 and iter_129_0 > arg_129_1.fateLevel and iter_129_0 <= arg_129_2.fateLevel then
			setActive(var_129_1, true)
			setActive(var_129_2, true)

			if not table.contains(arg_129_0.blinkTarget[1], var_129_1) then
				table.insert(arg_129_0.blinkTarget[1], var_129_1)
				table.insert(arg_129_0.blinkTarget[2], var_129_2)
			end
		else
			local var_129_3 = table.indexof(arg_129_0.blinkTarget[1], var_129_1)

			if var_129_3 then
				table.remove(arg_129_0.blinkTarget[1], var_129_3)
				table.remove(arg_129_0.blinkTarget[2], var_129_3)
			end

			setActive(var_129_1, iter_129_0 > arg_129_1.fateLevel)
			setActive(var_129_2, iter_129_0 <= arg_129_1.fateLevel)

			var_129_1:GetComponent(typeof(CanvasGroup)).alpha = 1
			var_129_2:GetComponent(typeof(CanvasGroup)).alpha = 1
		end
	end

	if #arg_129_0.blinkTarget[1] == 0 then
		LeanTween.cancel(go(arg_129_0.fittingAttrPanel))
	elseif not LeanTween.isTweening(go(arg_129_0.fittingAttrPanel)) then
		LeanTween.value(go(arg_129_0.fittingAttrPanel), 1, 0, 0.8):setOnUpdate(System.Action_float(function(arg_130_0)
			for iter_130_0, iter_130_1 in ipairs(arg_129_0.blinkTarget[1]) do
				iter_130_1:GetComponent(typeof(CanvasGroup)).alpha = arg_130_0
			end

			for iter_130_2, iter_130_3 in ipairs(arg_129_0.blinkTarget[2]) do
				iter_130_3:GetComponent(typeof(CanvasGroup)).alpha = 1 - arg_130_0
			end

			return
		end)):setEase(LeanTweenType.easeInOutSine):setLoopPingPong(0)
	end

	return
end

function var_0_0.updateModAdditionPanel(arg_131_0)
	local var_131_0 = arg_131_0.contextData.shipBluePrintVO
	local var_131_1 = arg_131_0.contextData.shipBluePrintVO:specialStrengthens()

	for iter_131_0 = arg_131_0.modAdditionContainer.childCount - 1, #var_131_1 do
		arg_131_0:cloneTplTo(arg_131_0.modAdditionTpl, arg_131_0.modAdditionContainer)
	end

	for iter_131_1 = 1, arg_131_0.modAdditionContainer.childCount do
		local var_131_2 = iter_131_1 <= #var_131_1
		local var_131_3 = arg_131_0.modAdditionContainer:GetChild(iter_131_1 - 1)

		setActive(var_131_3, iter_131_1 <= #var_131_1)

		if var_131_2 then
			arg_131_0:updateAdvanceTF(var_131_0, var_131_3, var_131_1[iter_131_1])
		end
	end

	return
end

function var_0_0.updateAdvanceTF(arg_132_0, arg_132_1, arg_132_2, arg_132_3)
	local var_132_0 = arg_132_1.level < arg_132_3.level

	setActive(arg_132_2:Find("mask"), arg_132_1.level < arg_132_3.level)

	if var_132_0 then
		setText(arg_132_2:Find("mask/content/Text"), i18n("blueprint_mod_addition_lock", arg_132_3.level))
	end

	local var_132_1 = arg_132_3.des
	local var_132_2 = arg_132_3.extraDes or {}
	local var_132_3 = arg_132_2:Find("additions")

	removeAllChildren(var_132_3)

	local var_132_4 = arg_132_0.modAdditionPanel:Find("scroll_rect/info")

	for iter_132_0 = 1, #var_132_1 do
		local var_132_5 = cloneTplTo(var_132_4, var_132_3)
		local var_132_6 = var_132_5:Find("text_tpl")
		local var_132_7 = var_132_5:Find("breakout_tpl")

		setActive(var_132_6, false)
		setActive(var_132_5:Find("attr_tpl"), false)
		setActive(var_132_7, false)
		setActive(var_132_5:Find("empty_tpl"), false)

		if var_132_1[iter_132_0] then
			if var_132_1[iter_132_0][1] == ShipBluePrint.STRENGTHEN_TYPE_BREAKOUT then
				setActive(var_132_7, true)
				;(function(arg_133_0, arg_133_1)
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
				end)(var_132_7, var_132_1[iter_132_0])
			else
				setActive(var_132_6, true)
				setText(var_132_6:Find("Text"), var_132_1[iter_132_0][3])
			end
		end
	end

	for iter_132_1 = 1, #var_132_2 do
		local var_132_8 = cloneTplTo(var_132_4, var_132_3)
		local var_132_9 = var_132_8:Find("text_tpl")

		setActive(var_132_9, true)
		setActive(var_132_8:Find("attr_tpl"), false)
		setActive(var_132_8:Find("breakout_tpl"), false)
		setActive(var_132_8:Find("empty_tpl"), false)
		setText(var_132_9:Find("Text"), var_132_2[iter_132_1])
	end

	return
end

function var_0_0.updateInfo(arg_134_0)
	local var_134_0

	if arg_134_0.contextData.shipBluePrintVO:isFetched() then
		var_134_0 = arg_134_0.shipVOs[arg_134_0.contextData.shipBluePrintVO.shipId]
	end

	var_134_0 = var_134_0 or arg_134_0.contextData.shipBluePrintVO:getShipVO()

	local var_134_1 = var_134_0:getConfigTable()

	setText(arg_134_0.shipName, (var_134_0:getName()))
	setText(arg_134_0.englishName, var_134_1.english_name)
	removeAllChildren(arg_134_0.stars)

	local var_134_2 = var_134_0:getMaxStar()

	for iter_134_0 = 1, var_134_2 do
		cloneTplTo(arg_134_0.shipInfoStarTpl, arg_134_0.stars, "star_" .. iter_134_0)
	end

	for iter_134_1 = 1, var_134_2 - var_134_0:getStar() do
		local var_134_3 = arg_134_0.stars:GetChild(var_134_2 - iter_134_1)

		setActive(var_134_3:Find("star_tpl"), false)
		setActive(var_134_3:Find("empty_star_tpl"), true)
	end

	local var_134_4 = GetSpriteFromAtlas("shiptype", var_134_0:getShipType())

	if not var_134_4 then
		warning("找不到船形, shipConfigId: " .. var_134_0.configId)
	end

	setImageSprite(arg_134_0.shipType, var_134_4, true)

	local var_134_5 = arg_134_0.contextData.shipBluePrintVO:isLock()

	setActive(arg_134_0.finishedBtn, arg_134_0.contextData.shipBluePrintVO:isFinished())

	local var_134_6 = arg_134_0.contextData.shipBluePrintVO:isDeving()

	setActive(arg_134_0.progressPanel, var_134_6)

	if not var_134_6 then
		setActive(arg_134_0.speedupBtn, false)
	end

	if var_134_6 then
		arg_134_0:updateTasksProgress()
	end

	local var_134_7, var_134_8 = arg_134_0.contextData.shipBluePrintVO:isFinishPrevTask()

	if var_134_5 and not var_134_8 then
		if var_134_7 then
			for iter_134_2, iter_134_3 in ipairs(arg_134_0.contextData.shipBluePrintVO:getOpenTaskList()) do
				arg_134_0:emit(ShipBluePrintMediator.ON_FINISH_TASK, iter_134_3)
			end

			var_134_8 = true
		else
			local var_134_9 = getProxy(TaskProxy)
			local var_134_10 = arg_134_0.contextData.shipBluePrintVO:getOpenTaskList()

			for iter_134_4, iter_134_5 in ipairs(var_134_10) do
				local var_134_11 = var_134_9:getTaskVO(iter_134_5)

				if iter_134_4 > arg_134_0.lockPanel.childCount then
					local var_134_12 = cloneTplTo(arg_134_0.lockBtn, arg_134_0.lockPanel) or arg_134_0.lockPanel:GetChild(iter_134_4 - 1)

					setActive(var_134_12, true)

					local var_134_13 = var_134_11:getProgress()
					local var_134_14 = var_134_11:getConfig("target_num")
					local var_134_15 = var_134_14 <= var_134_13 and setColorStr(var_134_13, COLOR_GREEN) or var_134_13

					setText(var_134_12:Find("Text"), var_134_15 .. "/" .. var_134_14)
				end
			end

			for iter_134_6 = #var_134_10 + 1, arg_134_0.lockPanel.childCount do
				setActive(arg_134_0.lockPanel:GetChild(iter_134_6 - 1), false)
			end
		end
	end

	setText(arg_134_0.openCondition:Find("Text"), arg_134_0.contextData.shipBluePrintVO:getConfig("unlock_word"))
	setActive(arg_134_0.openCondition, var_134_5)
	setActive(arg_134_0.startBtn, var_134_5 and var_134_8)
	setActive(arg_134_0.lockPanel, var_134_5 and not var_134_8)

	return
end

function var_0_0.updateTasksProgress(arg_135_0)
	if not arg_135_0.contextData.shipBluePrintVO:isDeving() then
		return
	end

	local var_135_1 = var_135_0:getTaskIds()

	for iter_135_0 = arg_135_0.progressContainer.childCount, #var_135_1 do
		cloneTplTo(arg_135_0.progressTpl, arg_135_0.progressContainer)
	end

	for iter_135_1 = 1, arg_135_0.progressContainer.childCount do
		local var_135_2 = arg_135_0.progressContainer:GetChild(iter_135_1 - 1)
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
		local var_135_6 = var_135_0:getTaskStateById(var_135_1[4])
		local var_135_7 = getProxy(BagProxy):getItemCountById(var_135_5[1])

		setActive(arg_135_0.speedupBtn, (var_135_0:getTaskStateById(var_135_1[1]) == ShipBluePrint.TASK_STATE_START or var_135_6 == ShipBluePrint.TASK_STATE_START) and var_135_7 > 0)
	else
		setActive(arg_135_0.speedupBtn, false)
	end

	return
end

function var_0_0.updatePainting(arg_136_0)
	local var_136_0 = arg_136_0.contextData.shipBluePrintVO:getShipVO():getPainting()

	if PLATFORM_CODE == PLATFORM_CH and checkABExist("painting/" .. var_136_0 .. "_blueprint") then
		var_136_0 = var_136_0 .. "_blueprint"
	end

	if arg_136_0.lastPaintingName and arg_136_0.lastPaintingName ~= var_136_0 then
		retPaintingPrefab(arg_136_0.painting, arg_136_0.lastPaintingName)
	end

	arg_136_0.lastPaintingName = var_136_0

	setPaintingPrefab(arg_136_0.painting, var_136_0, "tuzhi")
	arg_136_0:paintBreath()

	return
end

function var_0_0.updateProperty(arg_137_0)
	local var_137_0 = arg_137_0.contextData.shipBluePrintVO
	local var_137_1 = arg_137_0.contextData.shipBluePrintVO:getShipVO()

	arg_137_0.propertyPanel:initProperty(var_137_1.configId, PropertyPanel.TypeFlat)

	local var_137_2 = var_0_2[var_137_1.configId].buff_list_display

	for iter_137_0 = arg_137_0.skillPanel.childCount, #var_0_2[var_137_1.configId].buff_list_display - 1 do
		cloneTplTo(arg_137_0.skillTpl, arg_137_0.skillPanel)
	end

	for iter_137_1 = 1, arg_137_0.skillPanel.childCount do
		local var_137_3 = arg_137_0.skillPanel:GetChild(iter_137_1 - 1)
		local var_137_4 = iter_137_1 <= #var_137_2
		local var_137_5 = findTF(var_137_3, "icon")

		if iter_137_1 <= #var_137_2 then
			LoadImageSpriteAsync("skillicon/" .. getSkillConfig(var_137_2[iter_137_1]).icon, var_137_5)
			onButton(arg_137_0, var_137_3, function()
				arg_137_0:emit(ShipBluePrintMediator.SHOW_SKILL_INFO, var_0.id, {
					id = var_0.id,
					level = pg.skill_data_template[var_0.id].max_level
				}, function()
					return
				end)

				return
			end, SFX_PANEL)
		end

		setActive(var_137_3, var_137_4)
	end

	setActive(arg_137_0.skillArrLeft, #var_137_2 > 3)
	setActive(arg_137_0.skillArrRight, #var_137_2 > 3)

	if #var_137_2 > 3 then
		onScroll(arg_137_0, arg_137_0.skillRect, function(arg_140_0)
			setActive(arg_137_0.skillArrLeft, arg_140_0.x > 0.01)
			setActive(arg_137_0.skillArrRight, arg_140_0.x < 0.99)

			return
		end)
	else
		GetComponent(arg_137_0.skillRect, typeof(ScrollRect)).onValueChanged:RemoveAllListeners()
	end

	setAnchoredPosition(arg_137_0.skillPanel, {
		x = 0
	})
	setActive(arg_137_0.simulationBtn, var_137_0:getConfig("simulate_dungeon") ~= 0)
	onButton(arg_137_0, arg_137_0.simulationBtn, function()
		if var_0 == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("tech_simulate_closed"))
		else
			({}).content = i18n("blueprint_simulation_confirm_" .. var_137_0.id)
			;({}).onYes = function()
				arg_137_0:emit(ShipBluePrintMediator.SIMULATION_BATTLE, var_0)

				return
			end

			pg.MsgboxMgr.GetInstance():ShowMsgBox({})
		end

		return
	end, SFX_CONFIRM)

	return
end

function var_0_0.updateTaskList(arg_143_0)
	UIItemList.StaticAlign(arg_143_0.taskContainer, arg_143_0.taskTpl, #arg_143_0.contextData.shipBluePrintVO:getTaskIds(), function(arg_144_0, arg_144_1, arg_144_2)
		arg_144_1 = arg_144_1 + 1

		if arg_144_0 == UIItemList.EventUpdate then
			if arg_143_0.taskTFs[arg_144_1] then
				arg_143_0.taskTFs[arg_144_1]:clear()
			end

			if arg_144_1 <= #var_0 then
				arg_143_0.taskTFs[arg_144_1] = arg_143_0.taskTFs[arg_144_1] or arg_143_0:createTask(arg_144_2)

				local var_144_0 = var_0[arg_144_1]
				local var_144_1 = arg_143_0:getTaskById(var_0[arg_144_1])

				if var_0.duration > 0 then
					var_144_1.leftTime = var_0:getTaskOpenTimeStamp(var_144_0) - var_0.duration
				end

				var_144_1.taskState = var_0:getTaskStateById(var_144_0)
				var_144_1.dueTime = var_0:getTaskOpenTimeStamp(var_144_0)
				var_144_1.index = arg_144_1

				arg_143_0.taskTFs[arg_144_1]:update(var_144_1)
			end
		end

		return
	end)

	return
end

function var_0_0.updatePhantomQuest(arg_145_0)
	local var_145_0 = arg_145_0.contextData.shipBluePrintVO
	local var_145_1 = arg_145_0.contextData.shipBluePrintVO:isUnlockShipPhantom()

	setActive(arg_145_0.phantomPanel:Find("title/bg"), var_145_1)
	setActive(arg_145_0.phantomPanel:Find("title/bg_lock"), not var_145_1)
	setActive(arg_145_0.phantomPanel:Find("desc/content"), var_145_1)
	setActive(arg_145_0.phantomPanel:Find("desc/lock_mask"), not var_145_1)
	setText(arg_145_0.phantomPanel:Find("desc/lock_mask/Text"), i18n("tech_shadow_limit_text", getGameset("technology_shadow_unlock_lv")[1]))

	if not var_145_1 then
		return
	end

	local var_145_2 = arg_145_0.contextData.shipBluePrintVO:getAllPhantomQuestInfo()

	setText(arg_145_0.phantomPanel:Find("title/bg/Text"), string.format("%d/%d", #underscore.filter(var_145_2, function(arg_146_0)
		return arg_146_0.unlocked
	end), #var_145_2))
	UIItemList.StaticAlign(arg_145_0.rtPhantomQuestContainer, arg_145_0.questTpl, #var_145_2, function(arg_147_0, arg_147_1, arg_147_2)
		arg_147_1 = arg_147_1 + 1

		if arg_147_0 == UIItemList.EventUpdate then
			local var_147_0 = var_145_2[arg_147_1]

			setActive(arg_147_2:Find("title/bg"), var_145_2[arg_147_1].config.type ~= 5)
			setActive(arg_147_2:Find("title/bg_1"), var_147_0.config.type == 5)
			setActive(arg_147_2:Find("title/complete"), var_147_0.unlocked)
			setActive(arg_147_2:Find("title/working"), not var_147_0.unlocked)
			setText(arg_147_2:Find("title/name"), var_147_0.config.name)
			setText(arg_147_2:Find("title/number"), arg_147_1)

			local var_147_2 = arg_147_2:Find("title/slider")
			local var_147_3 = 0
			local var_147_4 = var_147_0.config.target_num

			if var_147_0.unlocked then
				local var_147_5 = var_147_0.config.target_num or var_147_0.progress

				var_147_1(var_147_2, var_147_3, var_147_4, var_147_5)
				setActive(arg_147_2:Find("title/slider/complete"), var_147_0.unlocked)
				setActive(arg_147_2:Find("title/tip"), not var_147_0.unlocked and var_147_0.progress >= var_147_0.config.target_num)

				if var_147_0.config.type == 5 then
					setText(arg_147_2:Find("desc/info/Text"), stringInset(var_147_0.config.desc, var_147_0.config.target_num))
				else
					setText(arg_147_2:Find("desc/info/Text"), var_147_0.config.desc)
				end

				local var_147_7 = "%d"

				if var_147_0.unlocked then
					local var_147_9 = var_147_0.config.target_num or var_147_0.progress
					local var_147_10 = var_147_6(var_147_7, var_147_8(var_147_9, 0, var_147_0.config.target_num) * 100 / var_147_0.config.target_num)

					setText(arg_147_2:Find("desc/info/progress"), var_147_10 .. "%")
					setText(arg_147_2:Find("desc/info/progress/shadow"), var_147_10 .. "%")

					local var_147_11 = ShipBluePrint.getPhantomQuestCostDrop(var_147_0)

					setActive(arg_147_2:Find("desc/item_info/items"), var_147_11)

					if var_147_11 then
						updateDrop(arg_147_2:Find("desc/item_info/items/item_tpl/award"), var_147_11)
					end

					local var_147_12 = var_147_0.unlocked or var_147_0.progress < var_147_0.config.target_num

					setActive(arg_147_2:Find("desc/commit_panel/commit_btn"), not canCommit)
					setActive(arg_147_2:Find("desc/commit_panel/lock_btn"), var_147_12)
					onButton(arg_145_0, arg_147_2:Find("desc/commit_panel/commit_btn"), function()
						if var_147_11 then
							table.insert({}, function(arg_149_0)
								pg.MsgboxMgr.GetInstance():ShowMsgBox({
									content = i18n("tech_shadow_commit_tip", var_147_11:getName() .. "x" .. var_147_11.count),
									onYes = arg_149_0
								})

								return
							end)
						end

						seriesAsync({}, function()
							arg_145_0:emit(ShipBluePrintMediator.FINISH_PHANTOM_QUEST, var_145_0.id, arg_147_1)

							return
						end)

						return
					end, SFX_CONFIRM)
					onToggle(arg_145_0, arg_147_2, function(arg_151_0)
						if arg_151_0 then
							Canvas.ForceUpdateCanvases()

							local var_151_0 = arg_145_0.rtPhantomQuestContainer.parent.transform:InverseTransformPoint(arg_147_2.position).y
							local var_151_1 = 0

							if var_151_0 - arg_147_2.rect.height < arg_145_0.rtPhantomQuestContainer.parent.transform.rect.yMin then
								var_151_1 = arg_145_0.rtPhantomQuestContainer.parent.transform.rect.yMin - (var_151_0 - arg_147_2.rect.height)
							end

							if var_151_0 > arg_145_0.rtPhantomQuestContainer.parent.transform.rect.yMax then
								var_151_1 = arg_145_0.rtPhantomQuestContainer.parent.transform.rect.yMax - var_151_0
							end

							local var_151_2 = arg_145_0.rtPhantomQuestContainer.localPosition

							var_151_2.y = arg_145_0.rtPhantomQuestContainer.localPosition.y + var_151_1
							arg_145_0.rtPhantomQuestContainer.localPosition = var_151_2
						end

						return
					end, SFX_PANEL)

					return
				end
			end
		end
	end)

	return
end

function var_0_0.createTask(arg_152_0, arg_152_1)
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
	var_152_0.view = arg_152_0

	onToggle(arg_152_0, arg_152_1, function(arg_153_0)
		setActive(var_152_0.desc, arg_153_0)
		setActive(var_152_0.progreshadow, arg_153_0)

		if arg_153_0 then
			Canvas.ForceUpdateCanvases()

			local var_153_0 = arg_152_0.taskContainer.parent.transform:InverseTransformPoint(arg_152_1.position).y
			local var_153_1 = 0

			if var_153_0 - arg_152_1.rect.height < arg_152_0.taskContainer.parent.transform.rect.yMin then
				var_153_1 = arg_152_0.taskContainer.parent.transform.rect.yMin - (var_153_0 - arg_152_1.rect.height)
			end

			if var_153_0 > arg_152_0.taskContainer.parent.transform.rect.yMax then
				var_153_1 = arg_152_0.taskContainer.parent.transform.rect.yMax - var_153_0
			end

			local var_153_2 = arg_152_0.taskContainer.localPosition

			var_153_2.y = arg_152_0.taskContainer.localPosition.y + var_153_1
			arg_152_0.taskContainer.localPosition = var_153_2
		end

		return
	end, SFX_PANEL)

	function var_152_0.update(arg_154_0, arg_154_1)
		arg_154_0:clearTimer()

		arg_154_0.autoCommit = true
		arg_154_0.isExpTask = false

		removeOnButton(arg_154_0.commitBtn)
		arg_154_0:updateItemInfo(arg_154_1)
		arg_154_0:updateView(arg_154_1)
		arg_154_0:updateProgress(arg_154_1)

		return
	end

	function var_152_0.updateItemInfo(arg_155_0, arg_155_1)
		arg_155_0.taskVO = arg_155_1

		changeToScrollText(arg_155_0.title, arg_155_1:getConfig("name"))
		setText(arg_155_0.desc, arg_155_1:getConfig("desc") .. "\n\n")

		local var_155_0
		local var_155_1 = arg_155_1:getConfig("target_num")
		local var_155_2 = arg_155_1:getConfig("sub_type")

		if var_155_2 == TASK_SUB_TYPE_GIVE_ITEM then
			arg_155_0.autoCommit = false
			var_155_0 = tonumber(arg_155_1:getConfig("target_id"))
		elseif var_155_2 == TASK_SUB_TYPE_PLAYER_RES then
			arg_155_0.autoCommit = false
			var_155_0 = id2ItemId(tonumber(arg_155_1:getConfig("target_id")))
		elseif var_155_2 == TASK_SUB_TYPE_BATTLE_EXP then
			arg_155_0.isExpTask = true
			var_155_0 = 59000
		end

		setActive(arg_155_0.itemContainer, not arg_155_0.autoCommit or arg_155_0.isExpTask)

		if var_155_0 then
			updateDrop(arg_155_0.itemTpl:Find("award"), {
				type = 2,
				id = var_155_0,
				count = var_155_1
			})

			local var_155_3 = var_155_1 > 1000 and math.floor(var_155_1 / 1000) .. "K" or var_155_1

			setText(arg_155_0.itemCount, var_155_3)
		end

		setText(arg_155_0.numberTF, arg_155_1.index)

		return
	end

	function var_152_0.updateView(arg_156_0, arg_156_1)
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

		setActive(arg_156_0.pause, ShipBluePrint.TASK_STATE_PAUSE == arg_156_1.taskState and not var_156_0 and not var_156_2 or ShipBluePrint.TASK_STATE_PAUSE == arg_156_1.taskState and not var_156_2 and var_156_0 and not arg_156_0.autoCommit)
		setActive(arg_156_0.pauseLock, ShipBluePrint.TASK_STATE_PAUSE == arg_156_1.taskState and not var_156_0 and var_156_2)
		setActive(arg_156_0.lockBtn, arg_156_1.taskState ~= ShipBluePrint.TASK_STATE_ACHIEVED and (arg_156_1.taskState ~= ShipBluePrint.TASK_STATE_START or not not arg_156_0.autoCommit))
		setActive(arg_156_0.commitBtn, arg_156_1.taskState == ShipBluePrint.TASK_STATE_ACHIEVED or arg_156_1.taskState == ShipBluePrint.TASK_STATE_START and not arg_156_0.autoCommit)
		setActive(arg_156_0.progressTF, arg_156_1.taskState == ShipBluePrint.TASK_STATE_ACHIEVED or arg_156_1.taskState == ShipBluePrint.TASK_STATE_START or arg_156_1.taskState == ShipBluePrint.TASK_STATE_FINISHED or arg_156_1.taskState == ShipBluePrint.TASK_STATE_PAUSE and not var_156_2)
		setActive(arg_156_0.lock, arg_156_1.taskState == ShipBluePrint.TASK_STATE_LOCK or arg_156_1.taskState == ShipBluePrint.TASK_STATE_WAIT)
		setActive(arg_156_0.working, arg_156_1.taskState == ShipBluePrint.TASK_STATE_OPENING or arg_156_1.taskState == ShipBluePrint.TASK_STATE_START or arg_156_1.taskState == ShipBluePrint.TASK_STATE_ACHIEVED)
		setActive(arg_156_0.maskAchieved, arg_156_1.taskState == ShipBluePrint.TASK_STATE_FINISHED or arg_156_1.taskState == ShipBluePrint.TASK_STATE_PAUSE and var_156_1)

		local var_156_5 = arg_156_0.timerTF

		if arg_156_1.taskState ~= ShipBluePrint.TASK_STATE_WAIT then
			if arg_156_1.taskState == ShipBluePrint.TASK_STATE_PAUSE then
				local var_156_6 = arg_156_1.leftTime

				if arg_156_1.leftTime then
					if arg_156_1.leftTime <= 0 then
						var_156_6 = false

						goto label_156_0
					end

					var_156_6 = true
				end

				::label_156_0::

				var_156_4(var_156_5, var_156_6)
				setActive(arg_156_0.check, arg_156_0.autoCommit and arg_156_1.taskState == ShipBluePrint.TASK_STATE_ACHIEVED or arg_156_1.taskState == ShipBluePrint.TASK_STATE_FINISHED or arg_156_1.taskState == ShipBluePrint.TASK_STATE_PAUSE and var_156_1)
				setActive(arg_156_0.tip, arg_156_1.taskState == ShipBluePrint.TASK_STATE_ACHIEVED)
				setActive(arg_156_0.timerOpen, arg_156_1.taskState == ShipBluePrint.TASK_STATE_WAIT)

				local var_156_8 = arg_156_0.timerClose

				if arg_156_1.taskState == ShipBluePrint.TASK_STATE_PAUSE then
					local var_156_9 = arg_156_1.leftTime and arg_156_1.leftTime > 0

					var_156_7(var_156_8, var_156_9)

					return
				end
			end
		end
	end

	function var_152_0.updateProgress(arg_157_0, arg_157_1)
		local var_157_0 = arg_157_1:getProgress() / arg_157_1:getConfig("target_num")

		if arg_157_1.taskState == ShipBluePrint.TASK_STATE_WAIT then
			arg_157_0:addTimer(arg_157_1, arg_157_1.dueTime)

			var_157_0 = 0
		elseif arg_157_1.taskState == ShipBluePrint.TASK_STATE_OPENING then
			var_157_0 = 0

			arg_157_0.view:emit(ShipBluePrintMediator.ON_TASK_OPEN, arg_157_1.id)
		elseif arg_157_1.taskState == ShipBluePrint.TASK_STATE_PAUSE then
			if arg_157_1:isReceive() then
				var_157_0 = 1
			end
		elseif arg_157_1.taskState == ShipBluePrint.TASK_STATE_LOCK then
			var_157_0 = 0
		elseif arg_157_1.taskState == ShipBluePrint.TASK_STATE_ACHIEVED then
			onButton(arg_157_0.view, arg_157_0.commitBtn, function()
				arg_157_0.view:emit(ShipBluePrintMediator.ON_FINISH_TASK, arg_157_1.id)

				return
			end, SFX_PANEL)

			var_157_0 = 1
		elseif arg_157_1.taskState == ShipBluePrint.TASK_STATE_FINISHED then
			var_157_0 = 1
		elseif arg_157_1.taskState == ShipBluePrint.TASK_STATE_START and not arg_157_0.autoCommit then
			onButton(arg_157_0.view, arg_157_0.commitBtn, function()
				arg_157_0.view:emit(ShipBluePrintMediator.ON_FINISH_TASK, arg_157_1.id)

				return
			end, SFX_PANEL)

			var_157_0 = 0
		end

		if var_157_0 > 0 then
			arg_157_0.itemSliderLT = LeanTween.value(go(arg_157_0.progressTF), 0, math.min(var_157_0, 1), 0.5 * math.min(var_157_0, 1)):setOnUpdate(System.Action_float(function(arg_160_0)
				arg_157_0.progessSlider.value = arg_160_0

				return
			end)).uniqueId
		else
			arg_157_0.progessSlider.value = var_157_0
		end

		local var_157_1 = math.floor(var_157_0 * 100)

		setText(arg_157_0.progres, math.ceil(math.min(var_157_1, 100)) .. "%")
		setText(arg_157_0.progreshadow, math.min(var_157_1, 100) .. "%")

		return
	end

	function var_152_0.addTimer(arg_161_0, arg_161_1, arg_161_2)
		arg_161_0:clearTimer()

		arg_161_0.taskTimer = Timer.New(function()
			local var_162_0 = arg_161_2 - pg.TimeMgr.GetInstance():GetServerTime()

			if var_162_0 > 0 then
				setText(arg_161_0.timerTFTxt, pg.TimeMgr.GetInstance():DescCDTime(var_162_0))
			else
				arg_161_0:clearTimer()
				setText(arg_161_0.timerTFTxt, "00:00:00")
				arg_161_0.view:emit(ShipBluePrintMediator.ON_TASK_OPEN, arg_161_1.id)
			end

			return
		end, 1, -1)

		arg_161_0.taskTimer:Start()
		arg_161_0.taskTimer.func()

		return
	end

	function var_152_0.clearTimer(arg_163_0)
		if arg_163_0.taskTimer then
			arg_163_0.taskTimer:Stop()

			arg_163_0.taskTimer = nil
		end

		return
	end

	function var_152_0.clear(arg_164_0)
		arg_164_0:clearTimer()

		if arg_164_0.itemSliderLT then
			LeanTween.cancel(arg_164_0.itemSliderLT)

			arg_164_0.itemSliderLT = nil
		end

		return
	end

	return var_152_0
end

function var_0_0.openPreView(arg_165_0)
	if arg_165_0.contextData.shipBluePrintVO then
		setActive(arg_165_0.preViewer, true)
		pg.UIMgr.GetInstance():BlurPanel(arg_165_0.preViewer)
		arg_165_0:playLoadingAni()

		arg_165_0.viewShipVO = arg_165_0.contextData.shipBluePrintVO:getShipVO()
		arg_165_0.breakIds = arg_165_0:getStages(arg_165_0.viewShipVO)

		for iter_165_0 = 1, var_0_4 do
			local var_165_1 = arg_165_0.stages:Find("stage" .. iter_165_0)

			onToggle(arg_165_0, var_165_1, function(arg_166_0)
				if arg_166_0 then
					if PLATFORM_CODE == PLATFORM_US then
						changeToScrollText(arg_165_0.breakView, var_0_3[var_0].breakout_view)
					else
						setText(arg_165_0.breakView, var_0_3[var_0].breakout_view)
					end

					arg_165_0:switchStage(var_0)
				end

				return
			end, SFX_PANEL)

			if iter_165_0 == 1 then
				triggerToggle(var_165_1, true)
			end
		end

		arg_165_0.isShowPreview = true

		arg_165_0:updateMaxLevelAttrs(arg_165_0.contextData.shipBluePrintVO)
	end

	return
end

var_0_0.MAX_LEVEL_ATTRS = {
	AttributeType.Durability,
	AttributeType.Cannon,
	AttributeType.Torpedo,
	AttributeType.AntiAircraft,
	AttributeType.Air,
	AttributeType.Reload,
	AttributeType.ArmorType,
	AttributeType.Dodge
}

function var_0_0.updateMaxLevelAttrs(arg_167_0, arg_167_1)
	if not arg_167_1:isFetched() then
		return
	end

	local var_167_1 = Clone(arg_167_0.shipVOs[arg_167_1.shipId])

	var_167_1.level = 125

	local var_167_2 = Clone(arg_167_1)

	var_167_2.level = arg_167_1:getMaxLevel()

	local var_167_3 = intProperties(var_167_2:getShipProperties(var_167_1, false))

	for iter_167_0, iter_167_1 in ipairs(var_0_0.MAX_LEVEL_ATTRS) do
		local var_167_4 = arg_167_0.previewAttrContainer:Find(iter_167_1)

		if iter_167_1 == AttributeType.ArmorType then
			setText(var_167_4:Find("bg/value"), var_167_0:getShipArmorName())
		else
			local var_167_6 = var_167_4:Find("bg/value")
			local var_167_7 = var_167_3[iter_167_1] or 0

			var_167_5(var_167_6, var_167_7)
		end

		setText(var_167_4:Find("bg/name"), AttributeType.Type2Name(iter_167_1))
	end

	return
end

function var_0_0.closePreview(arg_168_0, arg_168_1)
	if arg_168_0.previewer then
		arg_168_0.previewer:clear()

		arg_168_0.previewer = nil
	end

	setActive(arg_168_0.preViewer, false)
	setActive(arg_168_0.rawImage, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_168_0.preViewer, arg_168_0._tf)

	arg_168_0.isShowPreview = nil

	return
end

function var_0_0.playLoadingAni(arg_169_0)
	setActive(arg_169_0.seaLoading, true)

	return
end

function var_0_0.stopLoadingAni(arg_170_0)
	setActive(arg_170_0.seaLoading, false)

	return
end

function var_0_0.showBarrage(arg_171_0)
	arg_171_0.previewer = WeaponPreviewer.New(arg_171_0.rawImage)

	arg_171_0.previewer:configUI(arg_171_0.healTF)
	arg_171_0.previewer:setDisplayWeapon(arg_171_0:getWaponIdsById(arg_171_0.breakOutId))
	arg_171_0.previewer:load(40000, arg_171_0.viewShipVO, arg_171_0:getAllWeaponIds(), function()
		arg_171_0:stopLoadingAni()

		return
	end)

	return
end

function var_0_0.getWaponIdsById(arg_173_0, arg_173_1)
	return var_0_3[arg_173_1].weapon_ids
end

function var_0_0.getAllWeaponIds(arg_174_0)
	local var_174_0 = {}

	for iter_174_0, iter_174_1 in ipairs(arg_174_0.breakIds) do
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

function var_0_0.getStages(arg_176_0, arg_176_1)
	local var_176_0 = math.floor(arg_176_1.configId / 10)

	for iter_176_0 = 1, 4 do
		local var_176_1 = tonumber(var_176_0 .. iter_176_0)

		assert(var_0_3[var_176_1], "必须存在配置" .. var_176_1)
		table.insert({}, var_176_1)
	end

	return {}
end

function var_0_0.switchStage(arg_177_0, arg_177_1)
	if arg_177_0.breakOutId == arg_177_1 then
		return
	end

	arg_177_0.breakOutId = arg_177_1

	if arg_177_0.previewer then
		arg_177_0.previewer:setDisplayWeapon(arg_177_0:getWaponIdsById(arg_177_0.breakOutId))
	end

	return
end

function var_0_0.clearTimers(arg_178_0)
	local var_178_0 = arg_178_0.taskTFs or {}

	for iter_178_0, iter_178_1 in pairs(var_178_0) do
		iter_178_1:clear()
	end

	return
end

function var_0_0.cloneTplTo(arg_179_0, arg_179_1, arg_179_2)
	local var_179_0 = tf(Instantiate(arg_179_1))

	SetActive(var_179_0, true)
	var_179_0:SetParent(tf(arg_179_2), false)

	return var_179_0
end

function var_0_0.onBackPressed(arg_180_0)
	if isActive(arg_180_0.msgPanel) then
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_180_0.msgPanel, arg_180_0.top)
		setActive(arg_180_0.msgPanel, false)
	elseif isActive(arg_180_0.unlockPanel) then
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_180_0.unlockPanel, arg_180_0.top)
		setActive(arg_180_0.unlockPanel, false)
	elseif isActive(arg_180_0.versionPanel) then
		triggerButton(arg_180_0.versionPanel:Find("bg"))
	elseif arg_180_0.isShowPreview then
		arg_180_0:closePreview(true)
	elseif arg_180_0.svQuickExchange:isShowing() then
		arg_180_0.svQuickExchange:Hide()
	elseif arg_180_0.awakenPlay or arg_180_0:inModAnim() then
		-- block empty
	else
		arg_180_0:emit(var_0_0.ON_BACK_PRESSED)
	end

	return
end

function var_0_0.willExit(arg_181_0)
	if isActive(arg_181_0.msgPanel) then
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_181_0.msgPanel, arg_181_0.top)
		setActive(arg_181_0.msgPanel, false)
	end

	if isActive(arg_181_0.unlockPanel) then
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_181_0.unlockPanel, arg_181_0.top)
		setActive(arg_181_0.unlockPanel, false)
	end

	arg_181_0:UnOverlayPanel(arg_181_0.blurPanel, arg_181_0._tf)
	LeanTween.cancel(go(arg_181_0.fittingAttrPanel))

	if arg_181_0.lastPaintingName then
		retPaintingPrefab(arg_181_0.painting, arg_181_0.lastPaintingName)
	end

	local var_181_1 = arg_181_0.taskTFs or {}

	for iter_181_0, iter_181_1 in var_181_0(var_181_1) do
		iter_181_1:clear()
	end

	arg_181_0:closePreview(true)
	arg_181_0:clearLeanTween(true)

	if arg_181_0.previewer then
		arg_181_0.previewer:clear()

		arg_181_0.previewer = nil
	end

	if arg_181_0.cbTimer then
		arg_181_0.cbTimer:Stop()

		arg_181_0.cbTimer = nil
	end

	if arg_181_0.svQuickExchange:isShowing() then
		arg_181_0.svQuickExchange:Hide()
	end

	arg_181_0.svQuickExchange:Destroy()

	return
end

function var_0_0.paintBreath(arg_182_0)
	LeanTween.cancel(go(arg_182_0.painting))
	LeanTween.moveY(rtf(arg_182_0.painting), var_0_5, var_0_6):setLoopPingPong():setEase(LeanTweenType.easeInOutCubic):setFrom(0)

	return
end

function var_0_0.buildStartAni(arg_183_0, arg_183_1, arg_183_2)
	if arg_183_1 == "researchStartWindow" then
		arg_183_0.progressPanel.localScale = Vector3(0, 1, 1)

		LeanTween.scale(arg_183_0.progressPanel, Vector3(1, 1, 1), 0.2):setDelay(2)
	end

	local function var_183_0()
		arg_183_0.awakenAni:SetActive(true)

		arg_183_0.awakenPlay = true

		local var_184_0 = tf(arg_183_0.awakenAni)

		pg.UIMgr.GetInstance():BlurPanel(var_184_0)
		var_184_0:SetAsLastSibling()
		var_184_0:GetComponent("DftAniEvent"):SetEndEvent(function(arg_185_0)
			if not IsNil(arg_183_0.awakenAni) then
				pg.UIMgr.GetInstance():UnOverlayPanel(var_184_0, arg_183_0.blurPanel)
				arg_183_0.awakenAni:SetActive(false)

				arg_183_0.awakenPlay = false

				if arg_183_2 then
					arg_183_2()
				end
			end

			return
		end)

		return
	end

	local var_183_1 = arg_183_0._tf:Find(arg_183_1 .. "(Clone)")

	arg_183_0.awakenAni = var_183_1 and go(var_183_1)

	if not arg_183_0.awakenAni then
		PoolMgr.GetInstance():GetUI(arg_183_1, true, function(arg_186_0)
			arg_186_0:SetActive(true)

			arg_183_0.awakenAni = arg_186_0

			var_183_0()

			return
		end)
	else
		var_183_0()
	end

	return
end

function var_0_0.showFittingMsgPanel(arg_187_0, arg_187_1)
	pg.UIMgr.GetInstance():BlurPanel(arg_187_0.msgPanel)
	setActive(arg_187_0.msgPanel, true)

	local var_187_0 = arg_187_0.contextData.shipBluePrintVO:getMaxFateLevel()
	local var_187_1 = arg_187_0.msgPanel:Find("window/content")
	local var_187_2 = var_187_1:Find("next_btn")
	local var_187_3 = var_187_1:Find("attrl_panel")
	local var_187_4 = var_187_1:Find("skill_panel")
	local var_187_5 = var_187_1:Find("phase")
	local var_187_6 = {
		"I",
		"II",
		"III",
		"IV",
		"V"
	}

	local function var_187_7()
		setActive(var_0, arg_187_1 > 1)
		setActive(var_187_2, arg_187_1 < var_187_0)
		setText(var_187_5, "PHASE." .. var_187_6[arg_187_1])

		local var_188_0 = var_0:getFateStrengthenConfig(arg_187_1)

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

		setActive(var_187_3, #var_188_2 > 0)
		setActive(var_187_4, var_188_1)

		if var_188_1 then
			GetImageSpriteFromAtlasAsync("skillicon/" .. getSkillConfig(var_188_1).icon, "", var_187_4:Find("skill_icon"))
			setText(var_187_4:Find("skill_name"), getSkillName(var_188_1))
			setText(var_187_4:Find("skill_lv"), "Lv." .. 1)
			setText(var_187_4:Find("help_panel/skill_intro"), getSkillDescGet(var_188_1))
		end

		if #var_188_2 > 0 then
			for iter_188_2, iter_188_3 in ipairs(var_188_2) do
				local var_188_3 = iter_188_2 < var_187_3.childCount and var_187_3:GetChild(iter_188_2) or cloneTplTo(var_187_3:GetChild(iter_188_2 - 1), var_187_3)

				setText(var_188_3:Find("name"), AttributeType.Type2Name(iter_188_3[1]))
				setText(var_188_3:Find("number"), " + " .. iter_188_3[2])
			end

			for iter_188_4 = #var_188_2 + 1, var_187_3.childCount - 1 do
				setActive(var_187_3:GetChild(iter_188_4), false)
			end
		end

		return
	end

	onButton(arg_187_0, var_187_1:Find("pre_btn"), function()
		arg_187_1 = arg_187_1 - 1

		var_187_7()

		return
	end)
	onButton(arg_187_0, var_187_1:Find("next_btn"), function()
		arg_187_1 = arg_187_1 + 1

		var_187_7()

		return
	end)
	setText(var_187_1:Find("attrl_panel"):Find("desc"), i18n("fate_attr_word"))
	;(function()
		setActive(var_0, arg_187_1 > 1)
		setActive(var_187_2, arg_187_1 < var_187_0)
		setText(var_187_5, "PHASE." .. var_187_6[arg_187_1])

		local var_188_0 = var_0:getFateStrengthenConfig(arg_187_1)

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

		setActive(var_187_3, #var_188_2 > 0)
		setActive(var_187_4, var_188_1)

		if var_188_1 then
			GetImageSpriteFromAtlasAsync("skillicon/" .. getSkillConfig(var_188_1).icon, "", var_187_4:Find("skill_icon"))
			setText(var_187_4:Find("skill_name"), getSkillName(var_188_1))
			setText(var_187_4:Find("skill_lv"), "Lv." .. 1)
			setText(var_187_4:Find("help_panel/skill_intro"), getSkillDescGet(var_188_1))
		end

		if #var_188_2 > 0 then
			for iter_188_2, iter_188_3 in ipairs(var_188_2) do
				local var_188_3 = iter_188_2 < var_187_3.childCount and var_187_3:GetChild(iter_188_2) or cloneTplTo(var_187_3:GetChild(iter_188_2 - 1), var_187_3)

				setText(var_188_3:Find("name"), AttributeType.Type2Name(iter_188_3[1]))
				setText(var_188_3:Find("number"), " + " .. iter_188_3[2])
			end

			for iter_188_4 = #var_188_2 + 1, var_187_3.childCount - 1 do
				setActive(var_187_3:GetChild(iter_188_4), false)
			end
		end

		return
	end)()

	return
end

function var_0_0.showUnlockPanel(arg_191_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_191_0.unlockPanel)
	setActive(arg_191_0.unlockPanel, true)

	local var_191_0 = arg_191_0.contextData.shipBluePrintVO.id
	local var_191_1 = Drop.New({
		type = DROP_TYPE_ITEM,
		id = arg_191_0.contextData.shipBluePrintVO:getUnlockItem()
	})
	local var_191_2 = arg_191_0.contextData.shipBluePrintVO:getShipVO()
	local var_191_3 = var_191_2:getPainting()
	local var_191_4 = arg_191_0.unlockPanel:Find("window/content")

	GetImageSpriteFromAtlasAsync("shipYardIcon/" .. var_191_3, var_191_3, var_191_4:Find("Image/mask/icon"), true)
	setText(var_191_4:Find("words/Text"), i18n("techpackage_item_use_1", var_191_2:getName()))
	setText(var_191_4:Find("words/Text_2"), i18n("techpackage_item_use_2", var_191_1:getName()))
	GetImageSpriteFromAtlasAsync(var_191_1:getIcon(), "", arg_191_0.unlockPanel:Find("window/confirm_btn/Image/Image"))
	setText(arg_191_0.unlockPanel:Find("window/confirm_btn/Image/Text"), i18n("event_ui_consume"))
	onButton(arg_191_0, arg_191_0.unlockPanel:Find("window/confirm_btn"), function()
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_191_0.unlockPanel, arg_191_0.top)
		setActive(arg_191_0.unlockPanel, false)
		arg_191_0:emit(ShipBluePrintMediator.ON_ITEM_UNLOCK, var_191_0, var_0)

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.checkStory(arg_193_0)
	arg_193_0.storyMgr = arg_193_0.storyMgr or pg.NewStoryMgr.GetInstance()

	if ({
		nil,
		"FANGAN3"
	})[arg_193_0.version] and not arg_193_0.storyMgr:IsPlayed(({
		nil,
		"FANGAN3"
	})[arg_193_0.version]) then
		arg_193_0.storyMgr:Play(({
			nil,
			"FANGAN3"
		})[arg_193_0.version])
	end

	return
end

function var_0_0.changeEffectVisible(arg_194_0, arg_194_1)
	setActive(arg_194_0.fittingBtn, arg_194_1)
	setActive(arg_194_0.initPanel, arg_194_1)

	return
end

return var_0_0
