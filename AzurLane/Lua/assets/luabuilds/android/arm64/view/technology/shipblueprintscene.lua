class = var_0_10000

local var_0_0 = "ShipBluePrintScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

pg = var_0_10001

local var_0_2 = var_0_10001.ship_data_blueprint

pg = var_0_0

local var_0_3 = var_0_0.ship_data_template

pg = var_3

local var_0_4 = var_3.ship_data_breakout
local var_0_5 = 3
local var_0_6 = -10
local var_0_7 = 2.3
local var_0_8 = 0.3

function var_0_1.getUIName(arg_1_0)
	return "ShipBluePrintUI"
end

function var_0_1.setVersion(arg_2_0, arg_2_1)
	arg_2_0.version = arg_2_1

	return
end

function var_0_1.setShipVOs(arg_3_0, arg_3_1)
	arg_3_0.shipVOs = arg_3_1

	return
end

function var_0_1.getShipById(arg_4_0, arg_4_1)
	return arg_4_0.shipVOs[arg_4_1]
end

function var_0_1.setTaskVOs(arg_5_0, arg_5_1)
	arg_5_0.taskVOs = arg_5_1

	return
end

function var_0_1.getTaskById(arg_6_0, arg_6_1)
	local var_6_0

	if not arg_6_0.taskVOs[arg_6_1] then
		Task = var_6_0
		var_6_0 = var_6_0.New({
			id = arg_6_1
		})
	end

	return var_6_0
end

function var_0_1.getItemById(arg_7_0, arg_7_1)
	getProxy = var_1_10002
	BagProxy = var_1_10004

	local var_7_0 = var_1_10002(var_1_10004)
	local var_7_1

	if not var_2.getItemById(var_7_0, arg_7_1) then
		Item = var_7_1
		var_7_1 = var_7_1.New({
			count = 0,
			id = arg_7_1
		})
	end

	return var_7_1
end

function var_0_1.setShipBluePrints(arg_8_0, arg_8_1)
	arg_8_0.bluePrintByIds = arg_8_1

	return
end

function var_0_1.updateShipBluePrintVO(arg_9_0, arg_9_1)
	if arg_9_1 then
		arg_9_0.bluePrintByIds[arg_9_1.id] = arg_9_1
	end

	arg_9_0:initShips()

	return
end

function var_0_1.init(arg_10_0)
	local var_10_0 = arg_10_0._tf

	arg_10_0.main = var_1.Find(var_10_0, "main")

	local var_10_1 = arg_10_0.main

	arg_10_0.centerPanel = var_1.Find(var_10_1, "center_panel")

	local var_10_2 = arg_10_0._tf

	arg_10_0.blurPanel = var_1.Find(var_10_2, "blur_panel")

	local var_10_3 = arg_10_0.blurPanel

	arg_10_0.top = var_1.Find(var_10_3, "adapt")

	local var_10_4 = arg_10_0.top

	arg_10_0.topPanel = var_1.Find(var_10_4, "top")

	local var_10_5 = arg_10_0.blurPanel

	arg_10_0.topBg = var_1.Find(var_10_5, "top_bg")

	local var_10_6 = arg_10_0.top

	arg_10_0.backBtn = var_1.Find(var_10_6, "top/back")

	local var_10_7 = arg_10_0.top

	arg_10_0.leftPanle = var_1.Find(var_10_7, "left_panel")

	local var_10_8 = arg_10_0.top

	arg_10_0.bottomPanel = var_1.Find(var_10_8, "bottom_panel")

	local var_10_9 = arg_10_0.top

	arg_10_0.rightPanel = var_1.Find(var_10_9, "right_panel")

	local var_10_10 = arg_10_0.bottomPanel

	arg_10_0.shipContainer = var_1.Find(var_10_10, "ships/bg/content")

	local var_10_11 = arg_10_0.bottomPanel

	arg_10_0.shipTpl = var_1.Find(var_10_11, "ship_tpl")

	local var_10_12 = arg_10_0.bottomPanel

	arg_10_0.versionBtn = var_1.Find(var_10_12, "ships/bg/version/version_btn")

	local var_10_13 = arg_10_0.leftPanle

	arg_10_0.eyeTF = var_1.Find(var_10_13, "eye")

	local var_10_14 = arg_10_0._tf

	arg_10_0.painting = var_1.Find(var_10_14, "main/center_panel/painting")

	local var_10_15 = arg_10_0.centerPanel

	arg_10_0.nameTF = var_1.Find(var_10_15, "name")

	local var_10_16 = arg_10_0.nameTF

	arg_10_0.shipName = var_1.Find(var_10_16, "name_mask/Text")

	local var_10_17 = arg_10_0.nameTF

	arg_10_0.shipType = var_1.Find(var_10_17, "type")

	local var_10_18 = arg_10_0.nameTF

	arg_10_0.englishName = var_1.Find(var_10_18, "english_name")

	local var_10_19 = arg_10_0.nameTF

	arg_10_0.shipInfoStarTpl = var_1.Find(var_10_19, "star_tpl")
	setActive = var_1

	var_1(arg_10_0.shipInfoStarTpl, false)

	local var_10_20 = arg_10_0.nameTF

	arg_10_0.stars = var_1.Find(var_10_20, "stars")

	local var_10_21 = arg_10_0.leftPanle

	arg_10_0.initBtn = var_1.Find(var_10_21, "property_panel/btns/init_toggle")

	local var_10_22 = arg_10_0.leftPanle

	arg_10_0.attrBtn = var_1.Find(var_10_22, "property_panel/btns/attr_toggle")

	local var_10_23 = arg_10_0.leftPanle

	arg_10_0.attrDisableBtn = var_1.Find(var_10_23, "property_panel/btns/attr_toggle/disable")

	local var_10_24 = arg_10_0.leftPanle

	arg_10_0.initPanel = var_1.Find(var_10_24, "property_panel/init_panel")
	PropertyPanel = var_1
	arg_10_0.propertyPanel = var_1.New(arg_10_0.initPanel, 32)
	setText = var_1

	local var_10_25 = arg_10_0.initPanel
	local var_10_26 = var_3.Find(var_10_25, "property_title1/Text")

	i18n = var_4

	var_1(var_10_26, var_4("blueprint_combatperformance"))

	setText = var_1

	local var_10_27 = arg_10_0.initPanel
	local var_10_28 = var_3.Find(var_10_27, "property_title2/Text")

	i18n = var_4

	var_1(var_10_28, var_4("blueprint_shipperformance"))

	local var_10_29 = arg_10_0.leftPanle

	arg_10_0.skillRect = var_1.Find(var_10_29, "property_panel/init_panel/skills_rect")

	local var_10_30 = arg_10_0.leftPanle

	arg_10_0.skillPanel = var_1.Find(var_10_30, "property_panel/init_panel/skills_rect/skills")

	local var_10_31 = arg_10_0.skillPanel

	arg_10_0.skillTpl = var_1.Find(var_10_31, "skilltpl")

	local var_10_32 = arg_10_0.leftPanle

	arg_10_0.skillArrLeft = var_1.Find(var_10_32, "property_panel/init_panel/arrow1")

	local var_10_33 = arg_10_0.leftPanle

	arg_10_0.skillArrRight = var_1.Find(var_10_33, "property_panel/init_panel/arrow2")

	local var_10_34 = arg_10_0.leftPanle

	arg_10_0.simulationBtn = var_1.Find(var_10_34, "property_panel/init_panel/property_title2/simulation")

	local var_10_35 = arg_10_0.leftPanle

	arg_10_0.attrPanel = var_1.Find(var_10_35, "property_panel/attr_panel")

	local var_10_36 = arg_10_0.leftPanle

	arg_10_0.modAdditionPanel = var_1.Find(var_10_36, "property_panel/attr_panel")

	local var_10_37 = arg_10_0.modAdditionPanel

	arg_10_0.modAdditionContainer = var_1.Find(var_10_37, "scroll_rect/content")

	local var_10_38 = arg_10_0.modAdditionContainer

	arg_10_0.modAdditionTpl = var_1.Find(var_10_38, "addition_tpl")

	local var_10_39 = arg_10_0.attrPanel

	arg_10_0.preViewBtn = var_1.Find(var_10_39, "pre_view")

	local var_10_40 = arg_10_0.centerPanel

	arg_10_0.stateInfo = var_1.Find(var_10_40, "state_info")

	local var_10_41 = arg_10_0.centerPanel

	arg_10_0.startBtn = var_1.Find(var_10_41, "state_info/start_btn")

	local var_10_42 = arg_10_0.centerPanel

	arg_10_0.lockPanel = var_1.Find(var_10_42, "state_info/lock_panel")

	local var_10_43 = arg_10_0.lockPanel

	arg_10_0.lockBtn = var_1.Find(var_10_43, "lock")

	local var_10_44 = arg_10_0.centerPanel

	arg_10_0.finishedBtn = var_1.Find(var_10_44, "state_info/finished_btn")

	local var_10_45 = arg_10_0.centerPanel

	arg_10_0.progressPanel = var_1.Find(var_10_45, "state_info/progress")
	setText = var_1

	local var_10_46 = arg_10_0.progressPanel
	local var_10_47 = var_3.Find(var_10_46, "label")

	i18n = var_4

	var_1(var_10_47, var_4("blueprint_researching"))

	local var_10_48 = arg_10_0.progressPanel

	arg_10_0.progressContainer = var_1.Find(var_10_48, "content")

	local var_10_49 = arg_10_0.progressContainer

	arg_10_0.progressTpl = var_1.Find(var_10_49, "item")

	local var_10_50 = arg_10_0.centerPanel

	arg_10_0.openCondition = var_1.Find(var_10_50, "state_info/open_condition")

	local var_10_51 = arg_10_0._tf

	arg_10_0.speedupBtn = var_1.Find(var_10_51, "main/speedup_btn")

	local var_10_52 = arg_10_0.rightPanel

	arg_10_0.taskListPanel = var_1.Find(var_10_52, "task_list")

	local var_10_53 = arg_10_0.rightPanel

	arg_10_0.taskContainer = var_1.Find(var_10_53, "task_list/scroll/content")

	local var_10_54 = arg_10_0.taskContainer

	arg_10_0.taskTpl = var_1.Find(var_10_54, "task_tpl")

	local var_10_55 = arg_10_0.rightPanel

	arg_10_0.modPanel = var_1.Find(var_10_55, "mod_panel")

	local var_10_56 = arg_10_0.modPanel

	arg_10_0.attrContainer = var_1.Find(var_10_56, "desc/atrrs")

	local var_10_57 = arg_10_0.modPanel
	local var_10_58 = var_1.Find(var_10_57, "title/slider")
	local var_10_59 = var_1.GetComponent

	typeof = var_4
	Slider = var_6
	arg_10_0.levelSlider = var_10_59(var_10_58, var_4(var_6))

	local var_10_60 = arg_10_0.modPanel

	arg_10_0.levelSliderTxt = var_1.Find(var_10_60, "title/slider/Text")

	local var_10_61 = arg_10_0.modPanel
	local var_10_62 = var_1.Find(var_10_61, "title/pre_slider")
	local var_10_63 = var_1.GetComponent

	typeof = var_4
	Slider = var_6
	arg_10_0.preLevelSlider = var_10_63(var_10_62, var_4(var_6))

	local var_10_64 = arg_10_0.modPanel
	local var_10_65 = var_1.Find(var_10_64, "title/level_bg/Text")
	local var_10_66 = var_1.GetComponent

	typeof = var_4
	Text = var_6
	arg_10_0.modLevel = var_10_66(var_10_65, var_4(var_6))

	local var_10_67 = arg_10_0.modPanel
	local var_10_68 = var_1.Find(var_10_67, "title/Text")
	local var_10_69 = var_1.GetComponent

	typeof = var_4
	Text = var_6
	arg_10_0.needLevelTxt = var_10_69(var_10_68, var_4(var_6))

	local var_10_70 = arg_10_0.rightPanel

	arg_10_0.phantomPanel = var_1.Find(var_10_70, "phantom_panel")

	local var_10_71 = arg_10_0.phantomPanel

	arg_10_0.rtPhantomQuestContainer = var_1.Find(var_10_71, "desc/content")

	local var_10_72 = arg_10_0.rtPhantomQuestContainer

	arg_10_0.questTpl = var_1.GetChild(var_10_72, 0)

	local var_10_73 = arg_10_0.top

	arg_10_0.btnPhantom = var_1.Find(var_10_73, "phantomBtn")

	local var_10_74 = arg_10_0.modPanel

	arg_10_0.calcPanel = var_1.Find(var_10_74, "desc/calc_panel")

	local var_10_75 = arg_10_0.calcPanel

	arg_10_0.calcMinusBtn = var_1.Find(var_10_75, "calc/base/minus")

	local var_10_76 = arg_10_0.calcPanel

	arg_10_0.calcPlusBtn = var_1.Find(var_10_76, "calc/base/plus")

	local var_10_77 = arg_10_0.calcPanel

	arg_10_0.calcTxt = var_1.Find(var_10_77, "calc/base/count/Text")

	local var_10_78 = arg_10_0.calcPanel

	arg_10_0.calcMaxBtn = var_1.Find(var_10_78, "calc/max")

	local var_10_79 = arg_10_0.calcPanel

	arg_10_0.itemInfo = var_1.Find(var_10_79, "item_bg")

	local var_10_80 = arg_10_0.itemInfo

	arg_10_0.itemInfoIcon = var_1.Find(var_10_80, "icon")

	local var_10_81 = arg_10_0.itemInfo

	arg_10_0.itemInfoCount = var_1.Find(var_10_81, "kc")

	local var_10_82 = arg_10_0.calcPanel

	arg_10_0.modBtn = var_1.Find(var_10_82, "confirm_btn")

	local var_10_83 = arg_10_0.modPanel

	arg_10_0.fittingBtn = var_1.Find(var_10_83, "desc/fitting_btn")

	local var_10_84 = arg_10_0.fittingBtn

	arg_10_0.fittingBtnEffect = var_1.Find(var_10_84, "anim/ShipBlue02")

	local var_10_85 = arg_10_0.rightPanel

	arg_10_0.fittingPanel = var_1.Find(var_10_85, "fitting_panel")
	setActive = var_1

	var_1(arg_10_0.fittingPanel, false)

	local var_10_86 = arg_10_0.fittingPanel

	arg_10_0.fittingAttrPanel = var_1.Find(var_10_86, "desc/middle")

	local var_10_87 = arg_10_0.fittingPanel

	arg_10_0.phasePic = var_1.Find(var_10_87, "title/phase")

	local var_10_88 = arg_10_0.fittingPanel
	local var_10_89 = var_1.Find(var_10_88, "desc/top/slider")
	local var_10_90 = var_1.GetComponent

	typeof = var_4
	Slider = var_6
	arg_10_0.phaseSlider = var_10_90(var_10_89, var_4(var_6))

	local var_10_91 = arg_10_0.fittingPanel

	arg_10_0.phaseSliderTxt = var_1.Find(var_10_91, "desc/top/precent")

	local var_10_92 = arg_10_0.fittingPanel
	local var_10_93 = var_1.Find(var_10_92, "desc/top/pre_slider")
	local var_10_94 = var_1.GetComponent

	typeof = var_4
	Slider = var_6
	arg_10_0.prePhaseSlider = var_10_94(var_10_93, var_4(var_6))

	local var_10_95 = arg_10_0.fittingPanel

	arg_10_0.fittingNeedMask = var_1.Find(var_10_95, "desc/top/mask")

	local var_10_96 = arg_10_0.fittingPanel

	arg_10_0.fittingCalcPanel = var_1.Find(var_10_96, "desc/bottom")

	local var_10_97 = arg_10_0.fittingCalcPanel

	arg_10_0.fittingCalcMinusBtn = var_1.Find(var_10_97, "calc/base/minus")

	local var_10_98 = arg_10_0.fittingCalcPanel

	arg_10_0.fittingCalcPlusBtn = var_1.Find(var_10_98, "calc/base/plus")

	local var_10_99 = arg_10_0.fittingCalcPanel

	arg_10_0.fittingCalcTxt = var_1.Find(var_10_99, "calc/base/count/Text")

	local var_10_100 = arg_10_0.fittingCalcPanel

	arg_10_0.fittingCalcMaxBtn = var_1.Find(var_10_100, "calc/max")

	local var_10_101 = arg_10_0.fittingCalcPanel

	arg_10_0.fittingItemInfo = var_1.Find(var_10_101, "item_bg")

	local var_10_102 = arg_10_0.fittingItemInfo

	arg_10_0.fittingItemInfoIcon = var_1.Find(var_10_102, "icon")

	local var_10_103 = arg_10_0.fittingItemInfo

	arg_10_0.fittingItemInfoCount = var_1.Find(var_10_103, "kc")

	local var_10_104 = arg_10_0.fittingCalcPanel

	arg_10_0.fittingConfirmBtn = var_1.Find(var_10_104, "confirm_btn")

	local var_10_105 = arg_10_0.fittingCalcPanel

	arg_10_0.fittingCancelBtn = var_1.Find(var_10_105, "cancel_btn")

	local var_10_106 = arg_10_0.blurPanel

	arg_10_0.msgPanel = var_1.Find(var_10_106, "msg_panel")
	setActive = var_1

	var_1(arg_10_0.msgPanel, false)

	local var_10_107 = arg_10_0._tf

	arg_10_0.versionPanel = var_1.Find(var_10_107, "version_panel")
	setActive = var_1

	var_1(arg_10_0.versionPanel, false)

	local var_10_108 = arg_10_0._tf

	arg_10_0.preViewer = var_1.Find(var_10_108, "preview")

	local var_10_109 = arg_10_0._tf

	arg_10_0.preViewerFrame = var_1.Find(var_10_109, "preview/frame")
	setText = var_1

	local var_10_110 = arg_10_0.preViewerFrame
	local var_10_111 = var_3.Find(var_10_110, "bg/title/Image")

	i18n = var_4

	var_1(var_10_111, var_4("word_preview"))

	setActive = var_1

	var_1(arg_10_0.preViewer, false)

	local var_10_112 = arg_10_0.preViewerFrame

	arg_10_0.sea = var_1.Find(var_10_112, "sea")

	local var_10_113 = arg_10_0.sea

	arg_10_0.rawImage = var_1.GetComponent(var_10_113, "RawImage")
	setActive = var_1

	var_1(arg_10_0.rawImage, false)

	local var_10_114 = arg_10_0.preViewerFrame

	arg_10_0.seaLoading = var_1.Find(var_10_114, "bg/loading")

	local var_10_115 = arg_10_0._tf

	arg_10_0.healTF = var_1.Find(var_10_115, "resources/heal")

	local var_10_116 = arg_10_0.healTF.transform

	Vector3 = var_1_10002
	var_10_116.localPosition = var_1_10002(-360, 50, 40)
	setActive = var_10_116

	var_10_116(arg_10_0.healTF, false)

	local var_10_117 = arg_10_0.preViewerFrame

	arg_10_0.stages = var_1.Find(var_10_117, "stageScrollRect/stages")

	local var_10_118 = arg_10_0.preViewerFrame

	arg_10_0.breakView = var_1.Find(var_10_118, "content/Text")

	local var_10_119 = arg_10_0._tf

	arg_10_0.previewAttrPanel = var_1.Find(var_10_119, "preview/attrs_panel/attr_panel")

	local var_10_120 = arg_10_0.previewAttrPanel

	arg_10_0.previewAttrContainer = var_1.Find(var_10_120, "content")
	setText = var_1

	local var_10_121 = arg_10_0._tf
	local var_10_122 = var_3.Find(var_10_121, "preview/attrs_panel/Text")

	i18n = var_4

	var_1(var_10_122, var_4("meta_energy_preview_tip"))

	setText = var_1

	local var_10_123 = arg_10_0._tf
	local var_10_124 = var_3.Find(var_10_123, "preview/attrs_panel/desc")

	i18n = var_4

	var_1(var_10_124, var_4("meta_energy_preview_title"))

	local var_10_125 = arg_10_0.top

	arg_10_0.helpBtn = var_1.Find(var_10_125, "helpBtn")

	local var_10_126 = arg_10_0.top

	arg_10_0.exchangeBtn = var_1.Find(var_10_126, "exchangeBtn")

	local var_10_127 = arg_10_0.top

	arg_10_0.itemUnlockBtn = var_1.Find(var_10_127, "itemUnlockBtn")
	arg_10_0.bottomWidth = arg_10_0.bottomPanel.rect.height
	arg_10_0.topWidth = arg_10_0.topPanel.rect.height * 2
	arg_10_0.taskTFs = {}
	arg_10_0.leanTweens = {}

	local var_10_128 = arg_10_0.blurPanel

	arg_10_0.unlockPanel = var_1.Find(var_10_128, "unlock_panel")
	setActive = var_1

	var_1(arg_10_0.unlockPanel, false)

	BlueprintQuickExchangeView = var_1
	arg_10_0.svQuickExchange = var_1.New(arg_10_0._tf, arg_10_0.event)

	return
end

function var_0_1.didEnter(arg_11_0)
	getProxy = var_1_10001
	TechnologyProxy = var_1_10003

	local var_11_0 = var_1_10001(var_1_10003)
	local var_11_1 = var_1.getConfigMaxVersion(var_11_0)

	if not arg_11_0.contextData.shipBluePrintVO then
		local var_11_2 = {}

		for iter_11_0 = 1, var_11_1 do
			var_11_2[iter_11_0] = 0
		end

		pairs = var_3

		for iter_11_1, iter_11_2 in var_3(arg_11_0.bluePrintByIds) do
			local var_11_3 = var_11_2[iter_11_2:getConfig("blueprint_version")]
			local var_11_4 = iter_11_2.state

			ShipBluePrint = var_11
			var_11_2[var_8] = var_11_3 + (var_11_4 == var_11.STATE_UNLOCK and 1 or 0)

			local var_11_5 = iter_11_2.state

			ShipBluePrint = var_10

			if var_11_5 == var_10.STATE_DEV then
				local var_11_6 = arg_11_0.contextData
				local var_11_7

				if not arg_11_0.contextData.shipBluePrintVO then
					var_11_7 = iter_11_2
				end

				var_11_6.shipBluePrintVO = var_11_7

				break
			end
		end

		if not arg_11_0.contextData.shipBluePrintVO then
			for iter_11_3 = 1, var_11_1 do
				arg_11_0.version = iter_11_3

				if var_11_2[iter_11_3] <= 4 then
					break
				end
			end

			local var_11_8 = arg_11_0
			local var_11_9 = arg_11_0.emit

			ShipBluePrintMediator = iter_11_3

			var_11_9(var_11_8, iter_11_3.SET_TECHNOLOGY_VERSION, arg_11_0.version)
		end
	end

	arg_11_0:switchHide()
	arg_11_0:initShips()

	onButton = var_2

	local var_11_10 = arg_11_0
	local var_11_11 = arg_11_0.speedupBtn

	local function var_11_12()
		local var_12_0 = arg_11_0
		local var_12_1 = var_0.emit

		ShipBluePrintMediator = var_2_10003

		var_12_1(var_12_0, var_2_10003.ON_CLICK_SPEEDUP_BTN)

		return
	end

	SFX_PANEL = iter_11_2

	var_2(var_11_10, var_11_11, var_11_12, iter_11_2)

	onButton = var_2

	local var_11_13 = arg_11_0
	local var_11_14 = arg_11_0.backBtn

	local function var_11_15()
		local var_13_0 = arg_11_0

		var_0.closeView(var_13_0)

		return
	end

	SOUND_BACK = iter_11_2

	var_2(var_11_13, var_11_14, var_11_15, iter_11_2)

	onButton = var_2

	local var_11_16 = arg_11_0
	local var_11_17 = arg_11_0.startBtn

	local function var_11_18()
		if not arg_11_0.contextData.shipBluePrintVO then
			return
		end

		local var_14_0 = arg_11_0.contextData.shipBluePrintVO.id
		local var_14_1 = arg_11_0
		local var_14_2 = var_1.emit

		ShipBluePrintMediator = var_2_10004

		var_14_2(var_14_1, var_2_10004.ON_START, var_14_0)

		return
	end

	SFX_PANEL = iter_11_2

	var_2(var_11_16, var_11_17, var_11_18, iter_11_2)

	onButton = var_2

	local var_11_19 = arg_11_0
	local var_11_20 = arg_11_0.finishedBtn

	local function var_11_21()
		if not arg_11_0.contextData.shipBluePrintVO then
			return
		end

		local var_15_0 = arg_11_0.contextData.shipBluePrintVO.id
		local var_15_1 = arg_11_0
		local var_15_2 = var_1.emit

		ShipBluePrintMediator = var_2_10004

		var_15_2(var_15_1, var_2_10004.ON_FINISHED, var_15_0)

		return
	end

	SFX_PANEL = iter_11_2

	var_2(var_11_19, var_11_20, var_11_21, iter_11_2)

	onButton = var_2

	local var_11_22 = arg_11_0
	local var_11_23 = arg_11_0.itemUnlockBtn

	local function var_11_24()
		if not arg_11_0.contextData.shipBluePrintVO then
			return
		end

		local var_16_0 = arg_11_0

		var_0.showUnlockPanel(var_16_0)

		return
	end

	SFX_PANEL = iter_11_2

	var_2(var_11_22, var_11_23, var_11_24, iter_11_2)

	onButton = var_2

	local var_11_25 = arg_11_0
	local var_11_26 = arg_11_0.preViewBtn

	local function var_11_27()
		local var_17_0 = arg_11_0

		var_0.openPreView(var_17_0)

		return
	end

	SFX_PANEL = iter_11_2

	var_2(var_11_25, var_11_26, var_11_27, iter_11_2)

	onButton = var_2

	local var_11_28 = arg_11_0
	local var_11_29 = arg_11_0.seaLoading

	local function var_11_30()
		if not arg_11_0.previewer then
			local var_18_0 = arg_11_0

			var_0.showBarrage(var_18_0)
		end

		return
	end

	SFX_PANEL = iter_11_2

	var_2(var_11_28, var_11_29, var_11_30, iter_11_2)

	onButton = var_2

	local var_11_31 = arg_11_0
	local var_11_32 = arg_11_0.preViewer

	local function var_11_33()
		local var_19_0 = arg_11_0

		var_0.closePreview(var_19_0)

		return
	end

	SFX_PANEL = iter_11_2

	var_2(var_11_31, var_11_32, var_11_33, iter_11_2)

	onButton = var_2

	local var_11_34 = arg_11_0
	local var_11_35 = arg_11_0.eyeTF

	local function var_11_36()
		if arg_11_0.isSwitchAnim then
			return
		end

		local var_20_0 = arg_11_0

		var_0.switchHide(var_20_0)

		local var_20_1 = arg_11_0

		var_0.switchState(var_20_1, var_0_8, not arg_11_0.flag)

		return
	end

	SFX_PANEL = iter_11_2

	var_2(var_11_34, var_11_35, var_11_36, iter_11_2)

	onButton = var_2

	local var_11_37 = arg_11_0
	local var_11_38 = arg_11_0.main

	local function var_11_39()
		if arg_11_0.isSwitchAnim then
			return
		end

		if not arg_11_0.flag then
			local var_21_0 = arg_11_0

			var_0.switchHide(var_21_0)

			local var_21_1 = arg_11_0

			var_0.switchState(var_21_1, var_0_8, not arg_11_0.flag)
		end

		return
	end

	SFX_PANEL = iter_11_2

	var_2(var_11_37, var_11_38, var_11_39, iter_11_2)

	onButton = var_2

	local var_11_40 = arg_11_0
	local var_11_41 = arg_11_0.helpBtn

	local function var_11_42()
		pg = var_2_10000

		local var_22_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_22_1 = var_0.ShowMsgBox
		local var_22_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_22_2.type = var_2_10004
		pg = var_2_10004

		local var_22_3 = var_2_10004.gametip

		isActive = var_2_10005
		var_22_2.helps = var_22_3[var_2_10005(arg_11_0.fittingPanel) and "help_shipblueprintui_luck" or "help_shipblueprintui"].tip

		var_22_1(var_22_0, var_22_2)

		return
	end

	SFX_PANEL = iter_11_2

	var_2(var_11_40, var_11_41, var_11_42, iter_11_2)

	onButton = var_2

	var_2(arg_11_0, arg_11_0.exchangeBtn, function()
		local var_23_0 = arg_11_0.svQuickExchange

		var_0.Load(var_23_0)

		local var_23_1 = arg_11_0.svQuickExchange

		var_0.ActionInvoke(var_23_1, "Show")

		local var_23_2 = arg_11_0.svQuickExchange

		var_0.ActionInvoke(var_23_2, "UpdateBlueprint", arg_11_0.contextData.shipBluePrintVO)

		return
	end)

	setText = var_2

	local var_11_43 = arg_11_0.modPanel
	local var_11_44 = var_4.Find(var_11_43, "switch/Text")

	i18n = var_5

	var_2(var_11_44, var_5("tech_shadow_change_button_1"))

	onButton = var_2

	local var_11_45 = arg_11_0
	local var_11_46 = arg_11_0.modPanel
	local var_11_47 = var_5.Find(var_11_46, "switch")

	local function var_11_48()
		local var_24_0 = arg_11_0

		var_0.switchState(var_24_0, var_0_8, true, function()
			local var_25_0 = arg_11_0

			var_25_0.isPhantom = true
			setActive = var_25_0

			var_25_0(arg_11_0.phantomPanel, arg_11_0.isPhantom)

			setActive = var_25_0

			var_25_0(arg_11_0.modPanel, not arg_11_0.isPhantom)

			return
		end)

		return
	end

	SFX_PANEL = var_11_46

	var_2(var_11_45, var_11_47, var_11_48, var_11_46)

	setText = var_2

	local var_11_49 = arg_11_0.phantomPanel
	local var_11_50 = var_4.Find(var_11_49, "switch/Text")

	i18n = var_11_47

	var_2(var_11_50, var_11_47("tech_shadow_change_button_2"))

	onButton = var_2

	local var_11_51 = arg_11_0
	local var_11_52 = arg_11_0.phantomPanel
	local var_11_53 = var_5.Find(var_11_52, "switch")

	local function var_11_54()
		local var_26_0 = arg_11_0

		var_0.switchState(var_26_0, var_0_8, true, function()
			local var_27_0 = arg_11_0

			var_27_0.isPhantom = false
			setActive = var_27_0

			var_27_0(arg_11_0.phantomPanel, arg_11_0.isPhantom)

			setActive = var_27_0

			var_27_0(arg_11_0.modPanel, not arg_11_0.isPhantom)

			return
		end)

		return
	end

	SFX_PANEL = var_11_52

	var_2(var_11_51, var_11_53, var_11_54, var_11_52)

	onButton = var_2

	local var_11_55 = arg_11_0
	local var_11_56 = arg_11_0.btnPhantom

	local function var_11_57()
		local var_28_0 = arg_11_0
		local var_28_1 = var_0.emit

		ShipBluePrintMediator = var_2_10003

		var_28_1(var_28_0, var_2_10003.OPEN_PHANTOM_LAYER, arg_11_0.version)

		return
	end

	SFX_PANEL = var_11_52

	var_2(var_11_55, var_11_56, var_11_57, var_11_52)

	local var_11_58 = arg_11_0
	local var_11_59 = arg_11_0.OverlayPanel
	local var_11_60 = arg_11_0.blurPanel
	local var_11_61 = {}
	local var_11_62 = {}
	local var_11_63 = arg_11_0.rightPanel

	var_11_62[1] = var_8.Find(var_11_63, "task_list")

	local var_11_64 = arg_11_0.rightPanel

	var_11_62[2] = var_8.Find(var_11_64, "mod_panel")

	local var_11_65 = arg_11_0.leftPanle

	var_11_62[3] = var_8.Find(var_11_65, "property_panel")

	local var_11_66 = arg_11_0.bottomPanel

	var_11_62[4] = var_8.Find(var_11_66, "ships/bg")
	var_11_61.pbList = var_11_62

	var_11_59(var_11_58, var_11_60, var_11_61)

	setText = var_11_59

	local var_11_67 = arg_11_0.msgPanel
	local var_11_68 = var_4.Find(var_11_67, "window/top/bg/infomation/title")

	i18n = var_11_60

	var_11_59(var_11_68, var_11_60("title_info"))

	onButton = var_11_59

	local var_11_69 = arg_11_0
	local var_11_70 = arg_11_0.msgPanel
	local var_11_71 = var_5.Find(var_11_70, "window/top/btnBack")

	local function var_11_72()
		pg = var_2_10000

		local var_29_0 = var_2_10000.UIMgr.GetInstance()

		var_0.UnOverlayPanel(var_29_0, arg_11_0.msgPanel, arg_11_0.top)

		setActive = var_0

		var_0(arg_11_0.msgPanel, false)

		return
	end

	SFX_CANCEL = var_11_70

	var_11_59(var_11_69, var_11_71, var_11_72, var_11_70)

	setText = var_11_59

	local var_11_73 = arg_11_0.msgPanel
	local var_11_74 = var_4.Find(var_11_73, "window/confirm_btn/Text")

	i18n = var_11_71

	var_11_59(var_11_74, var_11_71("text_confirm"))

	onButton = var_11_59

	local var_11_75 = arg_11_0
	local var_11_76 = arg_11_0.msgPanel
	local var_11_77 = var_5.Find(var_11_76, "window/confirm_btn")

	local function var_11_78()
		pg = var_2_10000

		local var_30_0 = var_2_10000.UIMgr.GetInstance()

		var_0.UnOverlayPanel(var_30_0, arg_11_0.msgPanel, arg_11_0.top)

		setActive = var_0

		var_0(arg_11_0.msgPanel, false)

		return
	end

	SFX_CANCEL = var_11_76

	var_11_59(var_11_75, var_11_77, var_11_78, var_11_76)

	onButton = var_11_59

	local var_11_79 = arg_11_0
	local var_11_80 = arg_11_0.msgPanel
	local var_11_81 = var_5.Find(var_11_80, "bg")

	local function var_11_82()
		pg = var_2_10000

		local var_31_0 = var_2_10000.UIMgr.GetInstance()

		var_0.UnOverlayPanel(var_31_0, arg_11_0.msgPanel, arg_11_0.top)

		setActive = var_0

		var_0(arg_11_0.msgPanel, false)

		return
	end

	SFX_CANCEL = var_11_80

	var_11_59(var_11_79, var_11_81, var_11_82, var_11_80)

	onButton = var_11_59

	local var_11_83 = arg_11_0
	local var_11_84 = arg_11_0.unlockPanel
	local var_11_85 = var_5.Find(var_11_84, "window/top/btnBack")

	local function var_11_86()
		pg = var_2_10000

		local var_32_0 = var_2_10000.UIMgr.GetInstance()

		var_0.UnOverlayPanel(var_32_0, arg_11_0.unlockPanel, arg_11_0.top)

		setActive = var_0

		var_0(arg_11_0.unlockPanel, false)

		return
	end

	SFX_CANCEL = var_11_84

	var_11_59(var_11_83, var_11_85, var_11_86, var_11_84)

	setText = var_11_59

	local var_11_87 = arg_11_0.unlockPanel
	local var_11_88 = var_4.Find(var_11_87, "window/confirm_btn/Text")

	i18n = var_11_85

	var_11_59(var_11_88, var_11_85("text_confirm"))

	setText = var_11_59

	local var_11_89 = arg_11_0.unlockPanel
	local var_11_90 = var_4.Find(var_11_89, "window/cancel_btn/Text")

	i18n = var_5

	var_11_59(var_11_90, var_5("text_cancel"))

	setText = var_11_59

	local var_11_91 = arg_11_0.unlockPanel
	local var_11_92 = var_4.Find(var_11_91, "window/top/bg/infomation/title")

	i18n = var_5

	var_11_59(var_11_92, var_5("title_info"))

	onButton = var_11_59

	local var_11_93 = arg_11_0
	local var_11_94 = arg_11_0.unlockPanel
	local var_11_95 = var_5.Find(var_11_94, "window/cancel_btn")

	local function var_11_96()
		pg = var_2_10000

		local var_33_0 = var_2_10000.UIMgr.GetInstance()

		var_0.UnOverlayPanel(var_33_0, arg_11_0.unlockPanel, arg_11_0.top)

		setActive = var_0

		var_0(arg_11_0.unlockPanel, false)

		return
	end

	SFX_CANCEL = var_11_94

	var_11_59(var_11_93, var_11_95, var_11_96, var_11_94)

	onButton = var_11_59

	local var_11_97 = arg_11_0
	local var_11_98 = arg_11_0.unlockPanel
	local var_11_99 = var_5.Find(var_11_98, "bg")

	local function var_11_100()
		pg = var_2_10000

		local var_34_0 = var_2_10000.UIMgr.GetInstance()

		var_0.UnOverlayPanel(var_34_0, arg_11_0.unlockPanel, arg_11_0.top)

		setActive = var_0

		var_0(arg_11_0.unlockPanel, false)

		return
	end

	SFX_CANCEL = var_11_98

	var_11_59(var_11_97, var_11_99, var_11_100, var_11_98)

	GetImageSpriteFromAtlasAsync = var_11_59

	var_11_59("ui/shipblueprintui_atlas", "version_" .. arg_11_0.version, arg_11_0.versionBtn)

	local var_11_101 = arg_11_0

	arg_11_0.updateVersionBtnTip(var_11_101)

	local var_11_107

	if 1 < var_11_1 then
		onButton = var_11_107
		var_11_101 = arg_11_0

		local var_11_102 = arg_11_0.versionBtn

		local function var_11_103()
			if arg_11_0.cbTimer then
				return
			end

			setActive = var_0

			var_0(arg_11_0.versionPanel, true)

			pg = var_0

			local var_35_0 = var_0.UIMgr.GetInstance()

			var_0.BlurPanel(var_35_0, arg_11_0.versionPanel)

			return
		end

		SFX_PANEL = var_11_98

		var_11_107(var_11_101, var_11_102, var_11_103, var_11_98)

		onButton = var_11_107
		var_11_101 = arg_11_0

		local var_11_104 = arg_11_0.versionPanel
		local var_11_105 = var_5.Find(var_11_104, "bg")

		local function var_11_106()
			pg = var_2_10000

			local var_36_0 = var_2_10000.UIMgr.GetInstance()

			var_0.UnOverlayPanel(var_36_0, arg_11_0.versionPanel, arg_11_0._tf)

			setActive = var_0

			var_0(arg_11_0.versionPanel, false)

			return
		end

		SFX_CANCEL = var_11_104

		var_11_107(var_11_101, var_11_105, var_11_106, var_11_104)

		UIItemList = var_11_107
		var_11_107 = var_11_107.New

		local var_11_108 = arg_11_0.versionPanel

		var_11_101 = var_11_101.Find(var_11_108, "window/content")

		local var_11_109 = arg_11_0.versionPanel
		local var_11_110 = var_11_107(var_11_101, var_5.Find(var_11_109, "window/content/version_1"))

		var_11_107.make(var_11_110, function(arg_37_0, arg_37_1, arg_37_2)
			arg_37_1 = arg_37_1 + 1
			UIItemList = var_2_10003

			if arg_37_0 == var_2_10003.EventUpdate then
				arg_37_2.name = "version_" .. arg_37_1
				GetImageSpriteFromAtlasAsync = var_3

				var_3("ui/shipblueprintui_atlas", "newVersion_" .. arg_37_1, arg_37_2:Find("image"))

				if arg_11_0.version == arg_37_1 then
					setActive = var_3

					var_3(arg_37_2:Find("choose"), true)
				else
					setActive = var_3

					var_3(arg_37_2:Find("choose"), false)
				end

				onButton = var_3

				local var_37_0 = arg_11_0
				local var_37_1 = arg_37_2

				local function var_37_2()
					arg_11_0.version = arg_37_1

					local var_38_0 = arg_11_0
					local var_38_1 = var_0.emit

					ShipBluePrintMediator = var_3_10003

					var_38_1(var_38_0, var_3_10003.SET_TECHNOLOGY_VERSION, arg_11_0.version)

					local var_38_2 = arg_11_0.contextData

					var_38_2.shipBluePrintVO = nil
					GetImageSpriteFromAtlasAsync = var_38_2

					var_38_2("ui/shipblueprintui_atlas", "version_" .. arg_11_0.version, arg_11_0.versionBtn)

					local var_38_3 = arg_11_0

					var_0.initShips(var_38_3)

					local var_38_4 = arg_11_0

					var_0.updateVersionBtnTip(var_38_4)

					local var_38_5 = var_11_107

					var_0.align(var_38_5, var_11_1)

					pg = var_0

					local var_38_6 = var_0.UIMgr.GetInstance()

					var_0.UnOverlayPanel(var_38_6, arg_11_0.versionPanel, arg_11_0._tf)

					setActive = var_0

					var_0(arg_11_0.versionPanel, false)

					return
				end

				SFX_CANCEL = var_2_10008

				var_3(var_37_0, var_37_1, var_37_2, var_2_10008)
			end

			return
		end)
		var_11_107:align(var_11_1)
		arg_11_0:updateVersionPanelBtnTip()
	end

	LeanTween = var_11_107

	local var_11_111 = var_11_107.alpha

	rtf = var_11_101

	local var_11_112 = var_11_111(var_11_101(arg_11_0.skillArrLeft), 0.25, 1)
	local var_11_113 = var_2.setEase

	LeanTweenType = var_5

	local var_11_114 = var_11_113(var_11_112, var_5.easeInOutSine)

	var_2.setLoopPingPong(var_11_114)

	LeanTween = var_2

	local var_11_115 = var_2.alpha

	rtf = var_11_114

	local var_11_116 = var_11_115(var_11_114(arg_11_0.skillArrRight), 0.25, 1)
	local var_11_117 = var_2.setEase

	LeanTweenType = var_5

	local var_11_118 = var_11_117(var_11_116, var_5.easeInOutSine)

	var_2.setLoopPingPong(var_11_118)

	return
end

function var_0_1.updateVersionBtnTip(arg_39_0)
	getProxy = var_1_10001
	TechnologyProxy = var_1_10003

	local var_39_0 = var_1_10001(var_1_10003)
	local var_39_1 = var_1.getConfigMaxVersion(var_39_0)
	local var_39_2 = {}

	for iter_39_0 = 1, var_39_1 do
		if iter_39_0 ~= arg_39_0.version then
			table = var_8

			var_8.insert(var_39_2, iter_39_0)
		end
	end

	setActive = var_4

	local var_39_3 = arg_39_0.versionBtn

	var_4(var_6.Find(var_39_3, "tip"), var_1:CheckPursuingCostTip(var_39_2))

	return
end

function var_0_1.updateVersionPanelBtnTip(arg_40_0)
	getProxy = var_1_10001
	TechnologyProxy = var_1_10003

	local var_40_0 = var_1_10001(var_1_10003)
	local var_40_1 = var_1.getConfigMaxVersion(var_40_0)

	for iter_40_0 = 1, var_40_1 do
		setActive = var_1_10007

		local var_40_2 = arg_40_0.versionPanel

		var_1_10007(var_9.Find(var_40_2, "window/content/version_" .. iter_40_0 .. "/tip"), var_1:CheckPursuingCostTip({
			iter_40_0
		}))
	end

	return
end

function var_0_1.updateAllPursuingCostTip(arg_41_0)
	arg_41_0:updateVersionBtnTip()
	arg_41_0:updateVersionPanelBtnTip()

	pairs = var_1

	for iter_41_0, iter_41_1 in var_1(arg_41_0.bluePrintItems) do
		iter_41_1:updatePursuingTip()
	end

	return
end

function var_0_1.switchHide(arg_42_0)
	local var_42_0 = not arg_42_0.flag

	LeanTween = var_1_10002

	var_1_10002.cancel(arg_42_0.bottomPanel)

	LeanTween = var_2

	var_2.cancel(arg_42_0.topPanel)

	LeanTween = var_2

	var_2.cancel(arg_42_0.topBg)

	if var_42_0 then
		LeanTween = var_2

		var_2.moveY(arg_42_0.bottomPanel, 0, var_0_8)

		LeanTween = var_2

		var_2.moveY(arg_42_0.topPanel, 0, var_0_8)

		LeanTween = var_2

		var_2.moveY(arg_42_0.topBg, 0, var_0_8)
	else
		LeanTween = var_2

		var_2.moveY(arg_42_0.bottomPanel, -arg_42_0.bottomWidth, var_0_8)

		LeanTween = var_2

		var_2.moveY(arg_42_0.topPanel, arg_42_0.topWidth, var_0_8)

		LeanTween = var_2

		var_2.moveY(arg_42_0.topBg, arg_42_0.topWidth, var_0_8)
	end

	setActive = var_2

	var_2(arg_42_0.nameTF, var_42_0)

	setActive = var_2

	var_2(arg_42_0.stateInfo, var_42_0)

	setActive = var_2

	var_2(arg_42_0.helpBtn, var_42_0)

	setActive = var_2

	var_2(arg_42_0.exchangeBtn, var_42_0)

	setActive = var_2

	var_2(arg_42_0.btnPhantom, var_42_0)

	setImageAlpha = var_2

	var_2(arg_42_0.itemUnlockBtn, var_42_0 and 1 or 0)

	setImageRaycastTarget = var_2

	var_2(arg_42_0.itemUnlockBtn, var_42_0)

	setImageAlpha = var_2

	var_2(arg_42_0.speedupBtn, var_42_0 and 1 or 0)

	setImageRaycastTarget = var_2

	var_2(arg_42_0.speedupBtn, var_42_0)

	return
end

function var_0_1.switchState(arg_43_0, arg_43_1, arg_43_2, arg_43_3, arg_43_4)
	local var_43_0 = {}

	if arg_43_0.flag then
		table = var_6

		var_6.insert(var_43_0, function(arg_44_0)
			arg_43_0.flag = false

			local var_44_0 = arg_43_0

			var_1.switchUI(var_44_0, arg_43_1, {
				-arg_43_0.leftPanle.rect.width - 16,
				arg_43_0.rightPanel.rect.width + 16
			}, arg_44_0)

			return
		end)
	end

	table = var_6

	var_6.insert(var_43_0, function(arg_45_0)
		existCall = var_2_10001

		var_2_10001(arg_43_3)

		return arg_45_0()
	end)

	if arg_43_2 then
		table = var_6

		var_6.insert(var_43_0, function(arg_46_0)
			arg_43_0.flag = true

			if arg_43_0.isFate or arg_43_0.isPhantom then
				local var_46_0 = arg_43_0

				var_1.switchUI(var_46_0, arg_43_1, {
					-arg_43_0.leftPanle.rect.width - 16,
					0,
					-arg_43_0.leftPanle.rect.width / 2
				}, arg_46_0)
			else
				local var_46_1 = arg_43_0

				var_1.switchUI(var_46_1, arg_43_1, {
					0,
					0,
					0
				}, arg_46_0)
			end

			return
		end)
	end

	seriesAsync = var_6

	var_6(var_43_0, arg_43_4)

	return
end

function var_0_1.switchUI(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
	LeanTween = var_1_10004

	var_1_10004.cancel(arg_47_0.leftPanle)

	LeanTween = var_4

	var_4.cancel(arg_47_0.rightPanel)

	LeanTween = var_4

	var_4.cancel(arg_47_0.centerPanel)

	arg_47_0.isSwitchAnim = true
	parallelAsync = var_4

	var_4({
		function(arg_48_0)
			LeanTween = var_2_10001

			local var_48_0 = var_2_10001.moveX(arg_47_0.leftPanle, arg_47_2[1], arg_47_1)
			local var_48_1 = var_1.setOnComplete

			System = var_4

			var_48_1(var_48_0, var_4.Action(arg_48_0))

			return
		end,
		function(arg_49_0)
			LeanTween = var_2_10001

			local var_49_0 = var_2_10001.moveX(arg_47_0.rightPanel, arg_47_2[2], arg_47_1)
			local var_49_1 = var_1.setOnComplete

			System = var_4

			var_49_1(var_49_0, var_4.Action(arg_49_0))

			return
		end,
		function(arg_50_0)
			if arg_47_2[3] then
				LeanTween = var_1

				local var_50_0 = var_1.moveX(arg_47_0.centerPanel, arg_47_2[3], arg_47_1)
				local var_50_1 = var_1.setOnComplete

				System = var_4

				var_50_1(var_50_0, var_4.Action(arg_50_0))
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

function var_0_1.createShipItem(arg_52_0, arg_52_1)
	local var_52_0 = {
		init = function(arg_53_0)
			arg_53_0._go = arg_52_1
			tf = var_1
			arg_53_0._tf = var_1(arg_52_1)

			local var_53_0 = arg_53_0._tf

			arg_53_0.icon = var_1.Find(var_53_0, "icon")

			local var_53_1 = arg_53_0._tf

			arg_53_0.state = var_1.Find(var_53_1, "state")

			local var_53_2 = arg_53_0._tf

			arg_53_0.count = var_1.Find(var_53_2, "count")

			local var_53_3 = arg_53_0._tf

			arg_53_0.tip = var_1.Find(var_53_3, "tip")

			return
		end,
		update = function(arg_54_0, arg_54_1, arg_54_2)
			SetCompomentEnabled = var_2_10003

			local var_54_0 = arg_54_0._tf

			typeof = var_2_10006
			Toggle = var_2_10008

			var_2_10003(var_54_0, var_2_10006(var_2_10008), arg_54_1.id > 0)

			arg_54_0.shipBluePrintVO = arg_54_1
			setActive = var_2_10003

			var_2_10003(arg_54_0.state, arg_54_0.shipBluePrintVO.id > 0)

			setActive = var_2_10003

			var_2_10003(arg_54_0.count, arg_54_0.shipBluePrintVO.id > 0)

			local var_54_4

			if arg_54_0.shipBluePrintVO.id > 0 then
				LoadSpriteAsync = var_54_4

				local var_54_1 = "shipdesignicon/"
				local var_54_2 = arg_54_0.shipBluePrintVO
				local var_54_3 = var_6.getShipVO(var_54_2)

				var_54_4(var_54_1 .. var_6.getPainting(var_54_3), function(arg_55_0)
					if arg_54_0.shipBluePrintVO.id > 0 then
						string = var_1

						local var_55_0 = var_1.find
						local var_55_1 = arg_55_0.name
						local var_55_2 = arg_54_0.shipBluePrintVO
						local var_55_3 = var_4.getShipVO(var_55_2)

						if var_55_0(var_55_1, var_4.getPainting(var_55_3)) then
							setImageSprite = var_1

							var_1(arg_54_0.icon, arg_55_0)
						end
					end

					return
				end)

				var_54_4 = {
					tip = false,
					pursuing = arg_54_1:isPursuing(),
					fate = arg_54_1:canFateSimulation()
				}
				switch = var_4

				local var_54_5 = arg_54_1.state
				local var_54_6 = {}

				ShipBluePrint = var_54_3
				var_54_6[var_54_3.STATE_LOCK] = function()
					local var_56_0 = var_54_4
					local var_56_1 = "lock"
					local var_56_2 = arg_54_1

					var_56_0.state = var_56_1 .. (var_2.getUnlockItem(var_56_2) and "_item" or "")

					return
				end
				ShipBluePrint = var_8
				var_54_6[var_8.STATE_DEV] = function()
					var_54_4.state = "research"

					return
				end
				ShipBluePrint = var_8
				var_54_6[var_8.STATE_DEV_FINISHED] = function()
					var_54_4.state = var_54_4.fate and "fate" or "dev"
					var_54_4.tip = true

					return
				end
				ShipBluePrint = var_8
				var_54_6[var_8.STATE_UNLOCK] = function()
					var_54_4.state = var_54_4.fate and "fate" or "dev"

					return
				end

				var_4(var_54_5, var_54_6)

				setText = var_4

				var_4(arg_54_0.count, arg_54_2.count > 999 and "999+" or arg_54_2.count)

				setActive = var_4

				local var_54_7 = arg_54_0.count

				var_4(var_6.Find(var_54_7, "icon"), not var_54_4.pursuing)

				setActive = var_4

				local var_54_8 = arg_54_0.count

				var_4(var_6.Find(var_54_8, "icon_2"), var_54_4.pursuing)

				setText = var_4

				local var_54_9 = arg_54_0.state

				var_4(var_6.Find(var_54_9, "dev/Text"), arg_54_0.shipBluePrintVO.level)

				if var_54_4.fate then
					GetImageSpriteFromAtlasAsync = var_4

					local var_54_10 = "ui/shipblueprintui_atlas"
					local var_54_11 = "icon_phase_" .. arg_54_0.shipBluePrintVO.fateLevel
					local var_54_12 = arg_54_0.state

					var_4(var_54_10, var_54_11, var_8.Find(var_54_12, "fate/Image"), true)
				end

				eachChild = var_4

				var_4(arg_54_0.state, function(arg_60_0)
					setActive = var_3_10001

					var_3_10001(arg_60_0, arg_60_0.name == var_54_4.state)

					return
				end)

				setActive = var_4

				var_4(arg_54_0.tip, var_54_4.tip)
			else
				LoadSpriteAsync = var_54_4

				var_54_4("shipdesignicon/empty", function(arg_61_0)
					if arg_54_0.shipBluePrintVO.id < 0 then
						setImageSprite = var_1

						var_1(arg_54_0.icon, arg_61_0)
					end

					return
				end)

				setActive = var_54_4

				var_54_4(arg_54_0.tip, false)
			end

			return
		end,
		updateSelectedStyle = function(arg_62_0, arg_62_1)
			local var_62_0 = arg_62_1 and 0 or -25

			LeanTween = var_2_10003

			var_2_10003.cancel(arg_62_0.icon)

			LeanTween = var_3

			var_3.moveY(arg_62_0.icon, var_62_0, 0.1)

			return
		end,
		updatePursuingTip = function(arg_63_0)
			setActive = var_2_10001

			local var_63_0 = arg_63_0.count
			local var_63_1 = var_3.Find(var_63_0, "icon_2/tip")
			local var_63_3

			if arg_63_0.shipBluePrintVO.id > 0 then
				local var_63_2 = arg_63_0.shipBluePrintVO

				var_63_3 = var_4.isPursuingCostTip(var_63_2)
			else
				var_63_3 = false
			end

			if false then
				var_63_3 = true
			end

			var_2_10001(var_63_1, var_63_3)

			return
		end
	}

	var_2.init(var_52_0)

	onButton = var_3

	local var_52_1 = arg_52_0
	local var_52_2 = var_2.count
	local var_52_3 = var_6.Find(var_52_2, "icon_2")

	local function var_52_4()
		pg = var_2_10000

		local var_64_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_64_1 = var_0.ShowMsgBox
		local var_64_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_64_2.type = var_2_10004
		i18n = var_2_10004
		var_64_2.helps = var_2_10004("blueprint_catchup_by_gold_help")

		var_64_1(var_64_0, var_64_2)

		return
	end

	SFX_PANEL = var_52_2

	var_3(var_52_1, var_52_3, var_52_4, var_52_2)

	return var_2
end

function var_0_1.initShips(arg_65_0)
	arg_65_0:checkStory()
	arg_65_0:filterBlueprints()

	local var_65_0

	if not arg_65_0.itemList then
		arg_65_0.bluePrintItems = {}
		UIItemList = var_65_0
		var_65_0 = var_65_0.New

		local var_65_1 = arg_65_0.shipContainer
		local var_65_2 = arg_65_0.shipContainer

		arg_65_0.itemList = var_65_0(var_65_1, var_4.Find(var_65_2, "ship_tpl"))

		local var_65_3 = arg_65_0.itemList

		var_65_0.make(var_65_3, function(arg_66_0, arg_66_1, arg_66_2)
			UIItemList = var_2_10003

			if arg_66_0 == var_2_10003.EventUpdate then
				onToggle = var_3

				local var_66_0 = arg_65_0
				local var_66_1 = arg_66_2

				local function var_66_2(arg_67_0)
					if arg_67_0 then
						if arg_65_0.cbTimer then
							local var_67_0 = arg_65_0.cbTimer

							var_1.Stop(var_67_0)

							arg_65_0.cbTimer = nil
						end

						local var_67_1 = arg_65_0

						var_1.clearLeanTween(var_67_1)

						arg_65_0.contextData.shipBluePrintVO = arg_65_0.bluePrintItems[arg_66_2].shipBluePrintVO

						if arg_65_0.nowShipId ~= arg_65_0.contextData.shipBluePrintVO.id then
							arg_65_0.nowShipId = arg_65_0.contextData.shipBluePrintVO.id

							local var_67_2 = arg_65_0

							var_1.switchState(var_67_2, var_0_8, true, function()
								local var_68_0 = arg_65_0

								var_0.setSelectedBluePrint(var_68_0)

								return
							end)
						else
							local var_67_3 = arg_65_0

							var_1.setSelectedBluePrint(var_67_3)
						end
					end

					local var_67_4 = arg_65_0.bluePrintItems[arg_66_2]

					var_1.updateSelectedStyle(var_67_4, arg_67_0)

					return
				end

				SFX_PANEL = var_2_10008

				var_3(var_66_0, var_66_1, var_66_2, var_2_10008)

				local var_66_3 = arg_65_0.bluePrintItems
				local var_66_5

				if not arg_65_0.bluePrintItems[arg_66_2] then
					local var_66_4 = arg_65_0

					var_66_5 = var_4.createShipItem(var_66_4, arg_66_2)
				end

				var_66_3[arg_66_2] = var_66_5

				local var_66_6

				if arg_65_0.filterBlueprintVOs[arg_66_1 + 1].id > 0 then
					var_66_6 = var_3:getItemId()

					local var_66_7 = arg_65_0
					local var_66_8 = var_5.getItemById(var_66_7, var_66_6)
					local var_66_9 = arg_65_0.bluePrintItems[arg_66_2]

					var_6.update(var_66_9, var_3, var_66_8)

					local var_66_10 = arg_65_0.bluePrintItems[arg_66_2]

					var_6.updatePursuingTip(var_66_10)
				else
					local var_66_11 = arg_65_0.bluePrintItems[arg_66_2]

					var_66_6.update(var_66_11, var_3, nil)
				end

				triggerToggle = var_66_6

				var_66_6(arg_66_2, false)
			end

			return
		end)
	end

	setActive = var_65_0

	var_65_0(arg_65_0.shipContainer, false)

	local var_65_4 = arg_65_0.itemList

	var_1.align(var_65_4, #arg_65_0.filterBlueprintVOs)

	setActive = var_1

	var_1(arg_65_0.shipContainer, true)

	if arg_65_0.contextData.shipBluePrintVO then
		underscore = var_65_5

		local var_65_5

		if var_65_5.all(arg_65_0.filterBlueprintVOs, function(arg_69_0)
			return arg_65_0.contextData.shipBluePrintVO.id ~= arg_69_0.id
		end) then
			var_65_5 = arg_65_0.contextData
			var_65_5.shipBluePrintVO = arg_65_0.filterBlueprintVOs[1]
		end

		eachChild = var_65_5

		var_65_5(arg_65_0.shipContainer, function(arg_70_0)
			if arg_65_0.contextData.shipBluePrintVO.id == arg_65_0.bluePrintItems[arg_70_0].shipBluePrintVO.id then
				triggerToggle = var_1

				var_1(arg_70_0, true)
			end

			return
		end)

		return
	end
end

function var_0_1.filterBlueprints(arg_71_0)
	if arg_71_0.contextData.shipBluePrintVO then
		local var_71_0 = arg_71_0.contextData.shipBluePrintVO

		arg_71_0.version = var_1.getConfig(var_71_0, "blueprint_version")

		local var_71_1 = arg_71_0
		local var_71_2 = arg_71_0.emit

		ShipBluePrintMediator = var_4

		var_71_2(var_71_1, var_4.SET_TECHNOLOGY_VERSION, arg_71_0.version)
	end

	arg_71_0.filterBlueprintVOs = {}

	local var_71_3 = 0

	pairs = var_1_10002

	for iter_71_0, iter_71_1 in var_1_10002(arg_71_0.bluePrintByIds) do
		if iter_71_1:getConfig("blueprint_version") == arg_71_0.version then
			table = var_7

			var_7.insert(arg_71_0.filterBlueprintVOs, iter_71_1)

			var_71_3 = var_71_3 + 1
		end
	end

	for iter_71_2 = var_71_3, 5 do
		table = iter_71_1

		iter_71_1.insert(arg_71_0.filterBlueprintVOs, {
			id = -1,
			state = -1
		})
	end

	table = var_2

	local var_71_4 = var_2.sort
	local var_71_5 = arg_71_0.filterBlueprintVOs

	CompareFuncs = iter_71_2

	var_71_4(var_71_5, iter_71_2({
		function(arg_72_0)
			return -arg_72_0.state
		end,
		function(arg_73_0)
			return arg_73_0.id
		end
	}))

	return
end

function var_0_1.setSelectedBluePrint(arg_74_0)
	assert = var_1_10001

	var_1_10001(arg_74_0.contextData.shipBluePrintVO, "should exist blue print")

	local var_74_0 = arg_74_0.contextData.shipBluePrintVO

	arg_74_0:updateInfo()
	arg_74_0:updatePainting()
	arg_74_0:updateProperty()

	local var_74_1 = var_74_0:isUnlock()

	setActive = var_3

	var_3(arg_74_0.taskListPanel, not var_74_1)

	setActive = var_3

	var_3(arg_74_0.attrDisableBtn, not var_74_1)

	if var_74_1 then
		if var_74_0:canFateSimulation() then
			pg = var_3

			local var_74_2 = var_3.NewStoryMgr.GetInstance()

			if not var_3.IsPlayed(var_74_2, var_74_0:getConfig("luck_story")) then
				arg_74_0.isFate = false
			end

			arg_74_0:updateMod()
			arg_74_0:updatePhantomQuest()

			if false then
				arg_74_0.isFate = false

				arg_74_0:updateTaskList()

				triggerToggle = var_3

				var_3(arg_74_0.initBtn, true)
			end

			setActive = var_3

			var_3(arg_74_0.phantomPanel, var_74_1 and arg_74_0.isPhantom)

			setActive = var_3

			var_3(arg_74_0.fittingPanel, var_74_1 and arg_74_0.isFate)

			setActive = var_3

			var_3(arg_74_0.modPanel, var_74_1 and not arg_74_0.isFate and not arg_74_0.isPhantom)

			setActive = var_3

			var_3(arg_74_0.itemUnlockBtn, not var_74_1 and var_74_0:getUnlockItem())

			if var_74_0:isDeving() then
				local var_74_3 = arg_74_0
				local var_74_4 = arg_74_0.emit

				ShipBluePrintMediator = var_6

				var_74_4(var_74_3, var_6.ON_CHECK_TAKES, var_74_0.id)
			end

			return
		end
	end
end

function var_0_1.updateMod(arg_75_0)
	if arg_75_0.noUpdateMod then
		return
	end

	if not arg_75_0.contextData.shipBluePrintVO or not var_1:isUnlock() or not var_1:isFetched() then
		return
	end

	arg_75_0:updateModPanel()
	arg_75_0:updateModAdditionPanel()

	return
end

function var_0_1.updateModInfo(arg_76_0, arg_76_1)
	local var_76_0 = arg_76_0
	local var_76_1 = arg_76_0.getShipById(var_76_0, arg_76_1.shipId)
	local var_76_2 = arg_76_0.contextData.shipBluePrintVO

	intProperties = var_76_0

	local var_76_3 = var_76_0(var_76_2:getShipProperties(var_76_1))

	intProperties = var_5

	local var_76_4 = var_5(arg_76_1:getShipProperties(var_76_1))

	Clone = var_6

	local var_76_5 = var_6(arg_76_1)

	var_6.level = var_6.getMaxLevel(var_76_5)
	intProperties = var_7

	local var_76_6 = var_7(var_6:getShipProperties(var_76_1))

	local function var_76_7(arg_77_0, arg_77_1, arg_77_2, arg_77_3)
		local var_77_0 = arg_77_0:Find("attr_bg/name")
		local var_77_1 = arg_77_0:Find("attr_bg/value")
		local var_77_2 = arg_77_0:Find("attr_bg/max")
		local var_77_3 = arg_77_0:Find("slider")
		local var_77_4 = var_7.GetComponent

		typeof = var_10
		Slider = var_2_10012

		local var_77_5 = var_77_4(var_77_3, var_10(var_2_10012))
		local var_77_6 = arg_77_0:Find("pre_slider")
		local var_77_7 = var_8.GetComponent

		typeof = var_11
		Slider = var_2_10013

		local var_77_8 = var_77_7(var_77_6, var_11(var_2_10013))
		local var_77_9 = arg_77_0:Find("exp")
		local var_77_10 = arg_76_1

		if var_10.isMaxLevel(var_77_10) then
			arg_77_3 = arg_77_2
		end

		setText = var_10

		var_10(var_77_2, arg_77_3)

		setText = var_10

		local var_77_11 = var_77_0

		AttributeType = var_13

		var_10(var_77_11, var_13.Type2Name(arg_77_1))

		setText = var_10

		var_10(var_77_1, arg_77_2)

		local var_77_12 = var_76_2
		local var_77_13, var_77_14 = var_10.getBluePrintAddition(var_77_12, arg_77_1)

		table = var_77_12

		local var_77_15 = var_77_12.indexof

		ShipModAttr = var_2_10014

		local var_77_16 = var_77_15(var_2_10014.BLUEPRINT_ATTRS, arg_77_1)
		local var_77_17 = var_76_2

		var_77_5.value = var_77_14 / var_13.getExpRetio(var_77_17, var_77_16)

		local var_77_18 = arg_76_1
		local var_77_19, var_77_20 = var_14.getBluePrintAddition(var_77_18, arg_77_1)
		local var_77_21 = arg_76_1
		local var_77_22 = var_16.getExpRetio(var_77_21, var_77_16)

		setText = var_17

		local var_77_23 = var_77_9

		math = var_2_10020

		var_17(var_77_23, var_2_10020.floor(var_77_20) .. "/" .. var_13)

		math = var_17

		local var_77_24 = var_17.floor(var_77_19)

		math = var_77_21
		var_77_8.value = var_77_24 > var_77_21.floor(var_77_13) and 1 or var_77_20 / var_77_22

		return
	end

	local var_76_8 = 0

	pairs = var_10

	for iter_76_0, iter_76_1 in var_10(var_76_4) do
		table = var_1_10015
		var_1_10015 = var_1_10015.contains
		ShipModAttr = var_1_10017

		if var_1_10015(var_1_10017.BLUEPRINT_ATTRS, iter_76_0) then
			var_1_10017 = arg_76_0.attrContainer
			var_1_10015 = var_1_10015.Find(var_1_10017, iter_76_0)
			var_76_8 = var_76_8 + 1

			local var_76_9 = var_76_7
			local var_76_10 = var_1_10015
			local var_76_11 = iter_76_0
			local var_76_12 = iter_76_1
			local var_76_13

			if not var_76_6[iter_76_0] then
				var_76_13 = 0
			end

			var_76_9(var_76_10, var_76_11, var_76_12, var_76_13)
		end
	end

	arg_76_0.modLevel.text = arg_76_0:formatModLvTxt(arg_76_1.level, arg_76_1:getMaxLevel())

	if var_76_2:getNextLevelExp() == -1 then
		arg_76_0.levelSlider.value = 1
	else
		arg_76_0.levelSlider.value = var_76_2.exp / var_10
	end

	local var_76_14

	if arg_76_1:getNextLevelExp() == -1 then
		setText = var_76_14

		var_76_14(arg_76_0.levelSliderTxt, "MAX")

		var_76_14 = arg_76_0.preLevelSlider
		var_76_14.value = 1
	else
		setText = var_76_14

		var_76_14(arg_76_0.levelSliderTxt, arg_76_1.exp .. "/" .. arg_76_1:getNextLevelExp())

		arg_76_0.preLevelSlider.value = arg_76_1.level > var_76_2.level and 1 or arg_76_1.exp / var_10
	end

	local var_76_15 = arg_76_1
	local var_76_16, var_76_17 = arg_76_1.isShipModMaxLevel(var_76_15, var_76_1)

	setActive = var_76_15

	var_76_15(arg_76_0.needLevelTxt, var_76_16)

	setActive = var_76_15

	var_76_15(arg_76_0.levelSliderTxt, not var_76_16)

	if var_76_16 then
		setText = var_76_15

		local var_76_18 = arg_76_0.needLevelTxt

		i18n = var_16

		var_76_15(var_76_18, var_16("buleprint_need_level_tip", var_76_17))

		arg_76_0.levelSlider.value = 1
	end

	return
end

function var_0_1.inModAnim(arg_78_0)
	return arg_78_0.inAnim
end

function var_0_1.formatModLvTxt(arg_79_0, arg_79_1, arg_79_2)
	return "<size=45>" .. arg_79_1 .. "</size>/<size=27>" .. arg_79_2 .. "</size>"
end

local var_0_9 = 0.2

function var_0_1.doModAnim(arg_80_0, arg_80_1, arg_80_2)
	arg_80_0:clearLeanTween()

	arg_80_0.inAnim = true

	local var_80_0 = {}
	local var_80_1 = arg_80_2:getMaxLevel()
	local var_80_2

	if arg_80_1.level ~= var_80_1 then
		function var_80_2(arg_81_0, arg_81_1, arg_81_2)
			Clone = var_2_10003
			arg_81_0 = var_2_10003(arg_81_0)
			arg_81_0.level = arg_81_1
			arg_81_0.exp = arg_81_2

			return arg_81_0
		end

		arg_80_0.preLevelSlider.value = 0

		for iter_80_0 = arg_80_1.level, arg_80_2.level do
			local var_80_3

			if iter_80_0 ~= arg_80_1.level or not (arg_80_1.exp / arg_80_1:getNextLevelExp()) then
				var_80_3 = 0
			end

			local var_80_4

			if iter_80_0 ~= arg_80_2.level or arg_80_2.level == var_80_1 or not (arg_80_2.exp / arg_80_2:getNextLevelExp()) then
				var_80_4 = 1
			end

			table = var_1_10012

			var_1_10012.insert(var_80_0, function(arg_82_0)
				TweenValue = var_2_10001
				go = var_2_10003

				var_2_10001(var_2_10003(arg_80_0.levelSlider), var_80_3, var_80_4, var_0_9, nil, function(arg_83_0)
					arg_80_0.levelSlider.value = arg_83_0

					return
				end, function()
					local var_84_0

					if iter_80_0 ~= arg_80_1.level or not arg_80_1 then
						var_84_0 = var_80_2(arg_80_1, iter_80_0, 0)
					end

					local var_84_1

					if iter_80_0 ~= arg_80_2.level or not arg_80_2 then
						var_84_1 = var_80_2(arg_80_1, iter_80_0 + 1, 0)
					end

					local var_84_2 = arg_80_0

					var_2.doAttrsAinm(var_84_2, var_84_0, var_84_1, arg_82_0)

					local var_84_3 = arg_80_0.modLevel
					local var_84_4 = arg_80_0

					var_84_3.text = var_3.formatModLvTxt(var_84_4, var_84_1.level, var_80_1)

					return
				end)

				return
			end)
		end

		table = var_6

		var_6.insert(arg_80_0.leanTweens, arg_80_0.levelSlider)
	else
		var_80_1 = arg_80_2:getMaxFateLevel()

		function var_80_2(arg_85_0, arg_85_1, arg_85_2)
			Clone = var_2_10003
			arg_85_0 = var_2_10003(arg_85_0)
			arg_85_0.fateLevel = arg_85_1
			arg_85_0.exp = arg_85_2

			return arg_85_0
		end

		arg_80_0.prePhaseSlider.value = 0

		for iter_80_1 = arg_80_1.fateLevel, arg_80_2.fateLevel do
			local var_80_5

			if iter_80_1 ~= arg_80_1.fateLevel or not (arg_80_1.exp / arg_80_1:getNextFateLevelExp()) then
				var_80_5 = 0
			end

			local var_80_6

			if iter_80_1 ~= arg_80_2.fateLevel or arg_80_2.fateLevel == var_80_1 or not (arg_80_2.exp / arg_80_2:getNextFateLevelExp()) then
				var_80_6 = 1
			end

			table = var_1_10012

			var_1_10012.insert(var_80_0, function(arg_86_0)
				TweenValue = var_2_10001
				go = var_2_10003

				var_2_10001(var_2_10003(arg_80_0.phaseSlider), var_80_5, var_80_6, var_0_9, nil, function(arg_87_0)
					arg_80_0.phaseSlider.value = arg_87_0

					return
				end, function()
					if iter_80_1 ~= arg_80_1.fateLevel or not arg_80_1 then
						local var_88_0 = var_80_2(arg_80_1, iter_80_1, 0)
					end

					local var_88_1

					if iter_80_1 ~= arg_80_2.fateLevel or not arg_80_2 then
						var_88_1 = var_80_2(arg_80_1, iter_80_1 + 1, 0)
					end

					local var_88_2 = arg_80_0

					var_2.updateFittingAttrPanel(var_88_2, var_88_1)

					GetImageSpriteFromAtlasAsync = var_2

					local var_88_3 = "ui/shipblueprintui_atlas"
					local var_88_4 = "phase_"

					math = var_3_10006

					var_2(var_88_3, var_88_4 .. var_3_10006.min(var_88_1.fateLevel + 1, var_88_1:getMaxFateLevel()), arg_80_0.phasePic, true)
					arg_86_0()

					return
				end)

				return
			end)
		end

		table = var_6

		var_6.insert(arg_80_0.leanTweens, arg_80_0.phaseSlider)
	end

	seriesAsync = var_80_2

	var_80_2(var_80_0, function()
		arg_80_0.noUpdateMod = false

		local var_89_0 = arg_80_0

		var_0.updateMod(var_89_0)

		arg_80_0.inAnim = false

		return
	end)

	return
end

function var_0_1.doAttrsAinm(arg_90_0, arg_90_1, arg_90_2, arg_90_3)
	local var_90_0 = {}
	local var_90_1 = arg_90_0
	local var_90_2 = arg_90_0.getShipById(var_90_1, arg_90_1.shipId)

	intProperties = var_1_10006

	local var_90_3 = arg_90_1
	local var_90_4 = var_1_10006(arg_90_1.getShipProperties(var_90_3, var_90_2))

	intProperties = var_90_1

	local var_90_5 = var_90_1(arg_90_2:getShipProperties(var_90_2))

	ipairs = var_8
	ShipModAttr = var_90_3

	for iter_90_0, iter_90_1 in var_8(var_90_3.BLUEPRINT_ATTRS) do
		AttributeType = var_1_10013

		if iter_90_1 ~= var_1_10013.AntiAircraft then
			local var_90_6 = arg_90_0.attrContainer
			local var_90_7 = var_1_10013.Find(var_90_6, iter_90_1)
			local var_90_8 = var_1_10013.Find(var_90_7, "attr_bg/value")
			local var_90_9 = var_14.GetComponent

			typeof = var_17
			Text = var_1_10019

			local var_90_10 = var_90_9(var_90_8, var_17(var_1_10019))
			local var_90_11 = var_1_10013:Find("slider")
			local var_90_12 = var_15.GetComponent

			typeof = var_18
			Slider = var_1_10020

			local var_90_13 = var_90_12(var_90_11, var_18(var_1_10020))
			local var_90_14 = var_1_10013:Find("pre_slider")
			local var_90_15 = var_16.GetComponent

			typeof = var_1_10019
			Slider = var_1_10021

			local var_90_16 = var_90_15(var_90_14, var_1_10019(var_1_10021))

			table = var_90_11

			local var_90_17 = var_90_11.indexof

			ShipModAttr = var_1_10019

			local var_90_18 = var_90_17(var_1_10019.BLUEPRINT_ATTRS, iter_90_1)

			var_1_10020 = arg_90_1

			local var_90_19 = arg_90_1.getExpRetio(var_1_10020, var_90_18)

			var_1_10019 = var_90_4[iter_90_1]
			var_1_10020 = var_90_5[iter_90_1]

			local var_90_20

			var_1_10021, var_90_20 = arg_90_1:getBluePrintAddition(iter_90_1)

			local var_90_21, var_90_22 = arg_90_2:getBluePrintAddition(iter_90_1)
			local var_90_23 = var_90_20 / var_90_19
			local var_90_24 = var_90_22 / var_90_19

			var_90_16.value = 0
			table = var_27

			var_27.insert(var_90_0, function(arg_91_0)
				local var_91_0 = arg_90_0
				local var_91_1 = var_1.doAttrAnim
				local var_91_2 = var_90_13
				local var_91_3 = var_90_10
				local var_91_4 = var_90_23
				local var_91_5 = var_90_24

				math = var_2_10008

				local var_91_6 = var_2_10008.floor(var_1_10021)

				math = var_2_10009

				var_91_1(var_91_0, var_91_2, var_91_3, var_91_4, var_91_5, var_91_6, var_2_10009.floor(var_90_21), var_1_10019, var_1_10020, arg_91_0)

				return
			end)
		end
	end

	parallelAsync = var_8

	var_8(var_90_0, arg_90_3)

	return
end

local var_0_10 = 0.1

function var_0_1.doAttrAnim(arg_92_0, arg_92_1, arg_92_2, arg_92_3, arg_92_4, arg_92_5, arg_92_6, arg_92_7, arg_92_8, arg_92_9)
	table = var_1_10010

	var_1_10010.insert(arg_92_0.leanTweens, arg_92_1)

	local var_92_0 = {}

	for iter_92_0 = arg_92_5, arg_92_6 do
		local var_92_1 = iter_92_0 == arg_92_5 and arg_92_3 or 0
		local var_92_2 = iter_92_0 == arg_92_6 and arg_92_4 or 1

		table = var_1_10017

		var_1_10017.insert(var_92_0, function(arg_93_0)
			TweenValue = var_2_10001
			go = var_2_10003

			var_2_10001(var_2_10003(arg_92_1), var_92_1, var_92_2, var_0_10, nil, function(arg_94_0)
				arg_92_1.value = arg_94_0

				return
			end, function()
				local var_95_0 = arg_92_2
				local var_95_1 = arg_92_8

				math = var_3_10002
				var_95_0.text = var_95_1 - var_3_10002.min(arg_92_6 - iter_92_0, arg_92_8 - arg_92_7)

				arg_93_0()

				return
			end)

			return
		end)
	end

	seriesAsync = var_11

	var_11(var_92_0, function()
		arg_92_9()

		return
	end)

	return
end

function var_0_1.clearLeanTween(arg_97_0, arg_97_1)
	pairs = var_1_10002

	for iter_97_0, iter_97_1 in var_1_10002(arg_97_0.leanTweens) do
		LeanTween = var_1_10007
		var_1_10007 = var_1_10007.isTweening
		go = var_1_10009

		if var_1_10007(var_1_10009(iter_97_1)) then
			LeanTween = var_1_10007
			var_1_10007 = var_1_10007.cancel
			go = var_1_10009

			var_1_10007(var_1_10009(iter_97_1))
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

function var_0_1.updateModPanel(arg_98_0)
	local var_98_0 = arg_98_0.contextData.shipBluePrintVO
	local var_98_1 = arg_98_0:getShipById(var_98_0.shipId)
	local var_98_2 = var_98_0:getConfig("strengthen_item")
	local var_98_3 = arg_98_0:getItemById(var_98_2).count == 0 and var_98_0:isPursuing()
	local var_98_4 = 0
	local var_98_5
	local var_98_6

	if var_98_3 then
		getProxy = var_1_10009
		TechnologyProxy = var_1_10011
		var_1_10009 = var_1_10009(var_1_10011)
		math = var_1_10010
		var_98_5 = var_1_10010.min(var_1_10009:calcMaxPursuingCount(var_98_0), var_98_0:getUseageMaxItem())

		function var_98_6(arg_99_0)
			local var_99_0 = var_98_0
			local var_99_1 = arg_99_0 * var_1.getItemExp(var_99_0)

			Clone = var_99_0

			local var_99_2 = var_99_0(var_98_0)

			var_3.addExp(var_99_2, var_99_1)

			local var_99_3 = arg_98_0

			var_4.updateModInfo(var_99_3, var_3)

			setText = var_4

			var_4(arg_98_0.calcTxt, arg_99_0)

			local var_99_4 = var_98_0
			local var_99_5 = var_4.isRarityUR(var_99_4)

			TechnologyProxy = var_5

			local var_99_6 = var_5.getPursuingDiscount
			local var_99_7 = var_1_10009
			local var_99_8 = var_99_6(var_7.getPursuingTimes(var_99_7, var_99_5) + var_98_4 + 1, var_99_5)

			setText = var_99_4

			local var_99_9 = arg_98_0.itemInfoIcon
			local var_99_10 = var_8.Find(var_99_9, "icon_bg/count")
			local var_99_11 = var_98_0

			var_99_4(var_99_10, var_9.getPursuingPrice(var_99_11, var_99_8))

			setActive = var_99_4

			local var_99_12 = arg_98_0.itemInfo

			var_99_4(var_8.Find(var_99_12, "no_cost"), var_99_8 == 0)

			setActive = var_99_4

			local var_99_13 = arg_98_0.itemInfo

			var_99_4(var_8.Find(var_99_13, "discount"), var_99_8 > 0 and var_99_8 < 100)

			if 0 < var_99_8 and var_99_8 < 100 then
				setText = var_6

				local var_99_14 = arg_98_0.itemInfo

				var_6(var_8.Find(var_99_14, "discount/Text"), 100 - var_99_8 .. "%OFF")
			end

			setActive = var_6

			local var_99_15 = arg_98_0.modBtn

			var_6(var_8.Find(var_99_15, "pursuing_cost"), var_98_4 > 0)

			setText = var_6

			local var_99_16 = arg_98_0.modBtn
			local var_99_17 = var_8.Find(var_99_16, "pursuing_cost/Text")
			local var_99_18 = var_1_10009

			var_6(var_99_17, var_9.calcPursuingCost(var_99_18, var_98_0, arg_99_0))

			return
		end

		var_1_10010 = {}
		DROP_TYPE_RESOURCE = var_1_10011
		var_1_10010.type = var_1_10011
		PlayerConst = var_1_10011
		var_1_10010.id = var_1_10011.ResGold
		updateDrop = var_11

		var_11(arg_98_0.itemInfoIcon, var_1_10010)

		onButton = var_11
		var_1_10013 = arg_98_0

		local var_98_7 = arg_98_0.itemInfoIcon

		local function var_98_8()
			LOCK_TECHNOLOGY_PURSUING_TIP = var_2_10000

			if var_2_10000 then
				local var_100_0 = arg_98_0

				var_2_10000 = var_2_10000.emit
				BaseUI = var_2_10003

				var_2_10000(var_100_0, var_2_10003.ON_DROP, var_1_10010)
			else
				pg = var_2_10000

				local var_100_1 = var_2_10000.MsgboxMgr.GetInstance()
				local var_100_2 = var_0.ShowMsgBox
				local var_100_3 = {}

				MSGBOX_TYPE_HELP = var_2_10004
				var_100_3.type = var_2_10004
				i18n = var_2_10004
				var_100_3.helps = var_2_10004("blueprint_catchup_by_gold_help")

				var_100_2(var_100_1, var_100_3)
			end

			return
		end

		SFX_PANEL = var_1_10016

		var_11(var_1_10013, var_98_7, var_98_8, var_1_10016)

		setScrollText = var_11
		findTF = var_1_10013
		var_1_10013 = var_1_10013(arg_98_0.itemInfo, "name/Text")
		var_1_10016 = var_1_10010

		var_11(var_1_10013, var_1_10010.getConfig(var_1_10016, "name"))

		setText = var_11
		var_1_10013 = arg_98_0.itemInfoCount
		i18n = var_14

		local var_98_9 = var_14("tec_tip_material_stock")
		local var_98_10 = ":"

		getProxy = var_1_10016
		PlayerProxy = var_1_10018

		local var_98_11 = var_1_10016(var_1_10018)
		local var_98_12 = var_1_10016.getRawData(var_98_11)

		var_1_10016 = var_1_10016.getResource
		PlayerConst = var_1_10019

		var_11(var_1_10013, var_98_9 .. var_98_10 .. var_1_10016(var_98_12, var_1_10019.ResGold))

		setText = var_11

		local var_98_13 = arg_98_0.itemInfo

		var_1_10013 = var_1_10013.Find(var_98_13, "no_cost/Text")
		i18n = var_14

		var_11(var_1_10013, var_14("tec_tip_no_consumption"))

		setText = var_11

		local var_98_14 = arg_98_0.modBtn

		var_1_10013 = var_1_10013.Find(var_98_14, "pursuing_cost/word")
		i18n = var_14

		var_11(var_1_10013, var_14("tec_tip_to_consumption"))

		onButton = var_11
		var_1_10013 = arg_98_0

		local var_98_15 = arg_98_0.modBtn

		local function var_98_16()
			local var_101_0 = arg_98_0

			if var_0.inModAnim(var_101_0) then
				return
			end

			if var_98_4 == 0 then
				return
			end

			pg = var_0

			local var_101_1 = var_0.MsgboxMgr.GetInstance()
			local var_101_2 = var_0.ShowMsgBox
			local var_101_3 = {}

			i18n = var_2_10004

			local var_101_4 = "blueprint_catchup_by_gold_confirm"
			local var_101_5 = var_1_10009

			var_101_3.content = var_2_10004(var_101_4, var_7.calcPursuingCost(var_101_5, var_98_0, var_98_4))

			function var_101_3.onYes()
				local var_102_0 = arg_98_0
				local var_102_1 = var_0.emit

				ShipBluePrintMediator = var_3_10003

				var_102_1(var_102_0, var_3_10003.ON_PURSUING, var_98_0.id, var_98_4)

				return
			end

			var_101_2(var_101_1, var_101_3)

			return
		end

		SFX_PANEL = var_1_10016

		var_11(var_1_10013, var_98_15, var_98_16, var_1_10016)
	else
		math = var_1_10009

		local var_98_17 = var_1_10009.min
		local var_98_18 = var_4.count
		local var_98_19 = var_98_0

		var_98_5 = var_98_17(var_98_18, var_98_0.getUseageMaxItem(var_98_19))

		function var_98_6(arg_103_0)
			local var_103_0 = var_98_0
			local var_103_1 = arg_103_0 * var_1.getItemExp(var_103_0)

			Clone = var_103_0

			local var_103_2 = var_103_0(var_98_0)

			var_3.addExp(var_103_2, var_103_1)

			local var_103_3 = arg_98_0

			var_4.updateModInfo(var_103_3, var_3)

			setText = var_4

			var_4(arg_98_0.calcTxt, arg_103_0)

			return
		end

		updateDrop = var_9

		local var_98_20 = arg_98_0.itemInfoIcon
		local var_98_21 = {}

		DROP_TYPE_ITEM = var_1_10013
		var_98_21.type = var_1_10013
		var_98_21.id = var_4.id

		var_9(var_98_20, var_98_21)

		onButton = var_9

		local var_98_22 = arg_98_0
		local var_98_23 = arg_98_0.itemInfoIcon

		local function var_98_24()
			ItemTipPanel = var_2_10000

			local var_104_0 = var_2_10000.ShowItemTipbyID
			local var_104_1 = var_0.id

			i18n = var_2_10003

			local var_104_2 = "title_item_ways"
			local var_104_3 = var_0

			var_104_0(var_104_1, var_2_10003(var_104_2, var_6.getConfig(var_104_3, "name")))

			return
		end

		SFX_PANEL = var_98_19

		var_9(var_98_22, var_98_23, var_98_24, var_98_19)

		setScrollText = var_9
		findTF = var_98_22

		var_9(var_98_22(arg_98_0.itemInfo, "name/Text"), var_4:getConfig("name"))

		setText = var_9

		local var_98_25 = arg_98_0.itemInfoCount

		i18n = var_12

		var_9(var_98_25, var_12("tec_tip_material_stock") .. ":" .. var_4.count)

		setActive = var_9

		local var_98_26 = arg_98_0.itemInfo

		var_9(var_11.Find(var_98_26, "no_cost"), false)

		setActive = var_9

		local var_98_27 = arg_98_0.itemInfo

		var_9(var_11.Find(var_98_27, "discount"), false)

		setActive = var_9

		local var_98_28 = arg_98_0.modBtn

		var_9(var_11.Find(var_98_28, "pursuing_cost"), false)

		onButton = var_9

		local var_98_29 = arg_98_0
		local var_98_30 = arg_98_0.modBtn

		local function var_98_31()
			local var_105_0 = arg_98_0

			if var_0.inModAnim(var_105_0) then
				return
			end

			if var_98_4 == 0 then
				return
			end

			local var_105_1 = arg_98_0
			local var_105_2 = var_0.emit

			ShipBluePrintMediator = var_2_10003

			var_105_2(var_105_1, var_2_10003.ON_MOD, var_98_0.id, var_98_4)

			return
		end

		SFX_PANEL = var_14

		var_9(var_98_29, var_98_30, var_98_31, var_14)
	end

	var_98_6(var_98_4)

	local var_98_32 = 0

	Clone = var_1_10010

	local var_98_33 = var_1_10010(var_98_0)
	local var_98_34 = var_98_0:getItemExp()
	local var_98_35, var_98_37

	::label_98_0::

	if var_98_33.level < var_98_33:getMaxLevel() then
		var_98_35 = var_98_1.level

		local var_98_36 = var_98_33

		var_98_37 = var_98_33.getStrengthenConfig
		math = var_1_10016
		var_1_10016 = var_1_10016.min

		local var_98_38 = var_98_33.level + 1

		var_1_10021 = var_98_33

		if var_98_37(var_98_36, var_1_10016(var_98_38, var_98_33.getMaxLevel(var_1_10021))).need_lv <= var_98_35 then
			repeat
				var_98_32 = var_98_32 + 1

				var_98_33:addExp(var_98_34)

				goto label_98_0
			until true
		end
	end

	math = var_98_35

	local var_98_39 = var_98_35.min(var_98_5, var_98_32)

	pressPersistTrigger = var_12

	local var_98_40 = arg_98_0.calcMinusBtn
	local var_98_41 = 0.5

	local function var_98_42(arg_106_0)
		local var_106_0 = arg_98_0

		if not var_1.inModAnim(var_106_0) then
			local var_106_1 = var_98_0

			if var_1.isMaxLevel(var_106_1) or var_98_4 == 0 then
				arg_106_0()

				return
			end

			var_98_4 = var_98_4 - 1

			var_98_6(var_98_4)

			return
		end
	end

	local var_98_43
	local var_98_44 = true
	local var_98_45 = true
	local var_98_46 = 0.1

	SFX_PANEL = var_1_10021

	var_12(var_98_40, var_98_41, var_98_42, var_98_43, var_98_44, var_98_45, var_98_46, var_1_10021)

	pressPersistTrigger = var_12

	local var_98_47 = arg_98_0.calcPlusBtn
	local var_98_48 = 0.5

	local function var_98_49(arg_107_0)
		local var_107_0 = arg_98_0

		if not var_1.inModAnim(var_107_0) then
			local var_107_1 = var_98_0

			if var_1.isMaxLevel(var_107_1) or var_98_4 == var_98_39 then
				arg_107_0()

				return
			end

			var_98_4 = var_98_4 + 1

			var_98_6(var_98_4)

			return
		end
	end

	local var_98_50
	local var_98_51 = true
	local var_98_52 = true
	local var_98_53 = 0.1

	SFX_PANEL = var_1_10021

	var_12(var_98_47, var_98_48, var_98_49, var_98_50, var_98_51, var_98_52, var_98_53, var_1_10021)

	onButton = var_12

	local var_98_54 = arg_98_0
	local var_98_55 = arg_98_0.calcMaxBtn

	local function var_98_56()
		local var_108_0 = arg_98_0

		if not var_0.inModAnim(var_108_0) then
			local var_108_1 = var_98_0

			if var_0.isMaxLevel(var_108_1) or var_98_4 == var_98_39 then
				return
			end

			var_98_4 = var_98_39

			var_98_6(var_98_4)

			return
		end
	end

	SFX_PANEL = var_98_50

	var_12(var_98_54, var_98_55, var_98_56, var_98_50)

	setActive = var_12

	var_12(arg_98_0.calcMaxBtn, not var_98_3)

	if var_98_0:canFateSimulation() then
		onButton = var_98_37

		local var_98_57 = arg_98_0
		local var_98_58 = arg_98_0.fittingBtn

		local function var_98_59()
			if arg_98_0.isSwitchAnim then
				return
			end

			setActive = var_0

			var_0(arg_98_0.fittingBtnEffect, true)

			local var_109_0 = arg_98_0

			Timer = var_2_10001
			var_109_0.cbTimer = var_2_10001.New(function()
				local var_110_0 = arg_98_0

				var_110_0.cbTimer = nil
				setActive = var_110_0

				var_110_0(arg_98_0.fittingBtnEffect, false)

				local var_110_1 = arg_98_0

				var_0.switchState(var_110_1, var_0_8, true, function()
					local var_111_0 = arg_98_0

					var_111_0.isFate = true
					setActive = var_111_0

					var_111_0(arg_98_0.fittingPanel, arg_98_0.isFate)

					setActive = var_111_0

					var_111_0(arg_98_0.modPanel, not arg_98_0.isFate)

					PlayerPrefs = var_111_0

					if not var_111_0.HasKey("first_fate") then
						triggerButton = var_0

						var_0(arg_98_0.helpBtn)

						PlayerPrefs = var_0

						var_0.SetInt("first_fate", 1)

						PlayerPrefs = var_0

						var_0.Save()
					end

					return
				end)

				return
			end, 0.6)

			local var_109_1 = arg_98_0.cbTimer

			var_0.Start(var_109_1)

			return
		end

		SFX_PANEL = var_98_51

		var_98_37(var_98_57, var_98_58, var_98_59, var_98_51)
		arg_98_0:updateFittingPanel()

		inGuide = var_98_37

		if not var_98_37 then
			pg = var_98_37

			local var_98_60 = var_98_37.NewStoryMgr.GetInstance()

			var_98_37.Play(var_98_60, var_98_0:getConfig("luck_story"), function(arg_112_0)
				if arg_112_0 then
					local var_112_0 = arg_98_0

					var_1.buildStartAni(var_112_0, "fateStartWindow", function()
						triggerButton = var_3_10000

						var_3_10000(arg_98_0.fittingBtn)

						return
					end)
				end

				return
			end)
		end
	end

	setActive = var_98_37

	var_98_37(arg_98_0.calcPanel, not var_12)

	setActive = var_98_37

	var_98_37(arg_98_0.fittingBtn, var_12)

	setActive = var_98_37

	var_98_37(arg_98_0.fittingBtnEffect, false)

	return
end

function var_0_1.updateFittingPanel(arg_114_0)
	local var_114_0 = arg_114_0.contextData.shipBluePrintVO
	local var_114_1 = arg_114_0:getShipById(var_114_0.shipId)
	local var_114_2 = var_114_0:getConfig("strengthen_item")
	local var_114_3 = arg_114_0:getItemById(var_114_2).count == 0 and var_114_0:isPursuing()
	local var_114_4 = 0
	local var_114_5
	local var_114_6

	if var_114_3 then
		getProxy = var_1_10009
		TechnologyProxy = var_1_10011
		var_1_10009 = var_1_10009(var_1_10011)
		math = var_1_10010
		var_114_5 = var_1_10010.min(var_1_10009:calcMaxPursuingCount(var_114_0), var_114_0:getFateUseageMaxItem())

		function var_114_6(arg_115_0)
			local var_115_0 = var_114_0
			local var_115_1 = arg_115_0 * var_1.getItemExp(var_115_0)

			Clone = var_115_0

			local var_115_2 = var_115_0(var_114_0)

			var_3.addExp(var_115_2, var_115_1)

			local var_115_3 = arg_114_0

			var_4.updateFittingInfo(var_115_3, var_3)

			setText = var_4

			var_4(arg_114_0.fittingCalcTxt, arg_115_0)

			local var_115_4 = var_114_0
			local var_115_5 = var_4.isRarityUR(var_115_4)

			TechnologyProxy = var_5

			local var_115_6 = var_5.getPursuingDiscount
			local var_115_7 = var_1_10009
			local var_115_8 = var_115_6(var_7.getPursuingTimes(var_115_7, var_115_5) + var_114_4 + 1, var_115_5)

			setText = var_115_4

			local var_115_9 = arg_114_0.fittingItemInfoIcon
			local var_115_10 = var_8.Find(var_115_9, "icon_bg/count")
			local var_115_11 = var_114_0

			var_115_4(var_115_10, var_9.getPursuingPrice(var_115_11, var_115_8))

			setActive = var_115_4

			local var_115_12 = arg_114_0.fittingItemInfo

			var_115_4(var_8.Find(var_115_12, "no_cost"), var_115_8 == 0)

			setActive = var_115_4

			local var_115_13 = arg_114_0.fittingItemInfo

			var_115_4(var_8.Find(var_115_13, "discount"), var_115_8 > 0 and var_115_8 < 100)

			if 0 < var_115_8 and var_115_8 < 100 then
				setText = var_6

				local var_115_14 = arg_114_0.fittingItemInfo

				var_6(var_8.Find(var_115_14, "discount/Text"), 100 - var_115_8 .. "%OFF")
			end

			setActive = var_6

			local var_115_15 = arg_114_0.fittingConfirmBtn

			var_6(var_8.Find(var_115_15, "pursuing_cost"), arg_115_0 > 0)

			setText = var_6

			local var_115_16 = arg_114_0.fittingConfirmBtn
			local var_115_17 = var_8.Find(var_115_16, "pursuing_cost/Text")
			local var_115_18 = var_1_10009

			var_6(var_115_17, var_9.calcPursuingCost(var_115_18, var_114_0, arg_115_0))

			return
		end

		var_1_10010 = {}
		DROP_TYPE_RESOURCE = var_1_10011
		var_1_10010.type = var_1_10011
		PlayerConst = var_1_10011
		var_1_10010.id = var_1_10011.ResGold
		updateDrop = var_11

		var_11(arg_114_0.fittingItemInfoIcon, var_1_10010)

		onButton = var_11
		var_1_10013 = arg_114_0

		local var_114_7 = arg_114_0.fittingItemInfoIcon

		local function var_114_8()
			LOCK_TECHNOLOGY_PURSUING_TIP = var_2_10000

			if var_2_10000 then
				local var_116_0 = arg_114_0

				var_2_10000 = var_2_10000.emit
				BaseUI = var_2_10003

				var_2_10000(var_116_0, var_2_10003.ON_DROP, var_1_10010)
			else
				pg = var_2_10000

				local var_116_1 = var_2_10000.MsgboxMgr.GetInstance()
				local var_116_2 = var_0.ShowMsgBox
				local var_116_3 = {}

				MSGBOX_TYPE_HELP = var_2_10004
				var_116_3.type = var_2_10004
				i18n = var_2_10004
				var_116_3.helps = var_2_10004("blueprint_catchup_by_gold_help")

				var_116_2(var_116_1, var_116_3)
			end

			return
		end

		SFX_PANEL = var_1_10016

		var_11(var_1_10013, var_114_7, var_114_8, var_1_10016)

		setScrollText = var_11
		findTF = var_1_10013
		var_1_10013 = var_1_10013(arg_114_0.fittingItemInfo, "name/Text")
		var_1_10016 = var_1_10010

		var_11(var_1_10013, var_1_10010.getConfig(var_1_10016, "name"))

		setText = var_11
		var_1_10013 = arg_114_0.fittingItemInfoCount
		i18n = var_14

		local var_114_9 = var_14("tec_tip_material_stock")
		local var_114_10 = ":"

		getProxy = var_1_10016
		PlayerProxy = var_1_10018

		local var_114_11 = var_1_10016(var_1_10018)
		local var_114_12 = var_1_10016.getRawData(var_114_11)

		var_1_10016 = var_1_10016.getResource
		PlayerConst = var_1_10019

		var_11(var_1_10013, var_114_9 .. var_114_10 .. var_1_10016(var_114_12, var_1_10019.ResGold))

		setText = var_11

		local var_114_13 = arg_114_0.fittingItemInfo

		var_1_10013 = var_1_10013.Find(var_114_13, "no_cost/Text")
		i18n = var_14

		var_11(var_1_10013, var_14("tec_tip_no_consumption"))

		setText = var_11

		local var_114_14 = arg_114_0.fittingConfirmBtn

		var_1_10013 = var_1_10013.Find(var_114_14, "pursuing_cost/word")
		i18n = var_14

		var_11(var_1_10013, var_14("tec_tip_to_consumption"))

		onButton = var_11
		var_1_10013 = arg_114_0

		local var_114_15 = arg_114_0.fittingConfirmBtn

		local function var_114_16()
			local var_117_0 = arg_114_0

			if var_0.inModAnim(var_117_0) then
				return
			end

			if var_114_4 == 0 then
				return
			end

			pg = var_0

			local var_117_1 = var_0.MsgboxMgr.GetInstance()
			local var_117_2 = var_0.ShowMsgBox
			local var_117_3 = {}

			i18n = var_2_10004

			local var_117_4 = "blueprint_catchup_by_gold_confirm"
			local var_117_5 = var_1_10009

			var_117_3.content = var_2_10004(var_117_4, var_7.calcPursuingCost(var_117_5, var_114_0, var_114_4))

			function var_117_3.onYes()
				local var_118_0 = arg_114_0
				local var_118_1 = var_0.emit

				ShipBluePrintMediator = var_3_10003

				var_118_1(var_118_0, var_3_10003.ON_PURSUING, var_114_0.id, var_114_4)

				return
			end

			var_117_2(var_117_1, var_117_3)

			return
		end

		SFX_PANEL = var_1_10016

		var_11(var_1_10013, var_114_15, var_114_16, var_1_10016)
	else
		math = var_1_10009
		var_1_10009 = var_1_10009.min

		local var_114_17 = var_4.count
		local var_114_18 = var_114_0

		var_114_5 = var_1_10009(var_114_17, var_114_0.getFateUseageMaxItem(var_114_18))

		function var_114_6(arg_119_0)
			local var_119_0 = var_114_0
			local var_119_1 = arg_119_0 * var_1.getItemExp(var_119_0)

			Clone = var_119_0

			local var_119_2 = var_119_0(var_114_0)

			var_3.addExp(var_119_2, var_119_1)

			local var_119_3 = arg_114_0

			var_4.updateFittingInfo(var_119_3, var_3)

			setText = var_4

			var_4(arg_114_0.fittingCalcTxt, arg_119_0)

			return
		end

		updateDrop = var_1_10009

		local var_114_19 = arg_114_0.fittingItemInfoIcon

		var_1_10012 = {}
		DROP_TYPE_ITEM = var_1_10013
		var_1_10012.type = var_1_10013
		var_1_10012.id = var_4.id

		var_1_10009(var_114_19, var_1_10012)

		onButton = var_1_10009

		local var_114_20 = arg_114_0

		var_1_10012 = arg_114_0.fittingItemInfoIcon

		local function var_114_21()
			ItemTipPanel = var_2_10000

			local var_120_0 = var_2_10000.ShowItemTipbyID
			local var_120_1 = var_0.id

			i18n = var_2_10003

			local var_120_2 = "title_item_ways"
			local var_120_3 = var_0

			var_120_0(var_120_1, var_2_10003(var_120_2, var_6.getConfig(var_120_3, "name")))

			return
		end

		SFX_PANEL = var_114_18

		var_1_10009(var_114_20, var_1_10012, var_114_21, var_114_18)

		setScrollText = var_1_10009

		local var_114_22 = arg_114_0.fittingItemInfo

		var_1_10009(var_11.Find(var_114_22, "name/Text"), var_4:getConfig("name"))

		setText = var_1_10009

		local var_114_23 = arg_114_0.fittingItemInfoCount

		i18n = var_1_10012

		var_1_10009(var_114_23, var_1_10012("tec_tip_material_stock") .. ":" .. var_4.count)

		setActive = var_1_10009

		local var_114_24 = arg_114_0.fittingItemInfo

		var_1_10009(var_11.Find(var_114_24, "no_cost"), false)

		setActive = var_1_10009

		local var_114_25 = arg_114_0.fittingItemInfo

		var_1_10009(var_11.Find(var_114_25, "discount"), false)

		setActive = var_1_10009

		local var_114_26 = arg_114_0.fittingConfirmBtn

		var_1_10009(var_11.Find(var_114_26, "pursuing_cost"), false)

		onButton = var_1_10009

		local var_114_27 = arg_114_0

		var_1_10012 = arg_114_0.fittingConfirmBtn

		local function var_114_28()
			local var_121_0 = arg_114_0

			if var_0.inModAnim(var_121_0) then
				return
			end

			if var_114_4 == 0 then
				return
			end

			local var_121_1 = arg_114_0
			local var_121_2 = var_0.emit

			ShipBluePrintMediator = var_2_10003

			var_121_2(var_121_1, var_2_10003.ON_MOD, var_114_0.id, var_114_4)

			return
		end

		SFX_PANEL = var_14

		var_1_10009(var_114_27, var_1_10012, var_114_28, var_14)
	end

	setText = var_1_10009

	local var_114_29 = arg_114_0.fittingAttrPanel
	local var_114_30 = var_11.Find(var_114_29, "attr/name")

	AttributeType = var_1_10012

	local var_114_31 = var_1_10012.Type2Name

	AttributeType = var_14

	var_1_10009(var_114_30, var_114_31(var_14.Luck))

	setText = var_1_10009

	local var_114_32 = arg_114_0.fittingPanel
	local var_114_33 = var_11.Find(var_114_32, "desc/top/text/Text")

	i18n = var_12

	var_1_10009(var_114_33, var_12("fate_phase_word"))

	onButton = var_1_10009

	local var_114_34 = arg_114_0
	local var_114_35 = arg_114_0.fittingCancelBtn

	local function var_114_36()
		local var_122_0 = arg_114_0

		var_0.switchState(var_122_0, var_0_8, true, function()
			local var_123_0 = arg_114_0

			var_123_0.isFate = false
			setActive = var_123_0

			var_123_0(arg_114_0.fittingPanel, arg_114_0.isFate)

			setActive = var_123_0

			var_123_0(arg_114_0.modPanel, not arg_114_0.isFate)

			return
		end)

		return
	end

	SFX_PANEL = var_14

	var_1_10009(var_114_34, var_114_35, var_114_36, var_14)

	local var_114_37 = 0

	Clone = var_1_10010

	local var_114_38 = var_1_10010(var_114_0)
	local var_114_39 = var_114_0:getItemExp()
	local var_114_40

	::label_114_0::

	if var_114_38.fateLevel < var_114_38:getMaxFateLevel() then
		var_114_40 = var_114_1.level

		local var_114_41 = var_114_38
		local var_114_42 = var_114_38.getFateStrengthenConfig

		math = var_1_10016
		var_1_10016 = var_1_10016.min

		local var_114_43 = var_114_38.fateLevel + 1

		var_1_10021 = var_114_38

		if var_114_40 >= var_114_42(var_114_41, var_1_10016(var_114_43, var_114_38.getMaxFateLevel(var_1_10021))).need_lv then
			repeat
				var_114_37 = var_114_37 + 1

				var_114_38:addExp(var_114_39)

				goto label_114_0
			until true
		end
	end

	math = var_114_40

	local var_114_44 = var_114_40.min(var_114_5, var_114_37)

	pressPersistTrigger = var_12

	local var_114_45 = arg_114_0.fittingCalcMinusBtn
	local var_114_46 = 0.5

	local function var_114_47(arg_124_0)
		local var_124_0 = arg_114_0

		if not var_1.inModAnim(var_124_0) then
			local var_124_1 = var_114_0

			if var_1.isMaxFateLevel(var_124_1) or var_114_4 == 0 then
				arg_124_0()

				return
			end

			math = var_1
			var_114_4 = var_1.max(var_114_4 - 1, 0)

			var_114_6(var_114_4)

			return
		end
	end

	local var_114_48
	local var_114_49 = true
	local var_114_50 = true
	local var_114_51 = 0.1

	SFX_PANEL = var_1_10021

	var_12(var_114_45, var_114_46, var_114_47, var_114_48, var_114_49, var_114_50, var_114_51, var_1_10021)

	pressPersistTrigger = var_12

	local var_114_52 = arg_114_0.fittingCalcPlusBtn
	local var_114_53 = 0.5

	local function var_114_54(arg_125_0)
		local var_125_0 = arg_114_0

		if not var_1.inModAnim(var_125_0) then
			var_125_0 = var_114_0

			if var_1.isMaxFateLevel(var_125_0) or var_114_4 == var_114_44 then
				arg_125_0()

				return
			end

			math = var_1

			local var_125_1 = var_1.max

			math = var_125_0
			var_114_4 = var_125_1(var_125_0.min(var_114_4 + 1, var_114_44), 0)

			var_114_6(var_114_4)

			return
		end
	end

	local var_114_55
	local var_114_56 = true
	local var_114_57 = true
	local var_114_58 = 0.1

	SFX_PANEL = var_1_10021

	var_12(var_114_52, var_114_53, var_114_54, var_114_55, var_114_56, var_114_57, var_114_58, var_1_10021)

	onButton = var_12

	local var_114_59 = arg_114_0
	local var_114_60 = arg_114_0.fittingCalcMaxBtn

	local function var_114_61()
		local var_126_0 = arg_114_0

		if not var_0.inModAnim(var_126_0) then
			local var_126_1 = var_114_0

			if var_0.isMaxFateLevel(var_126_1) or var_114_4 == var_114_44 then
				return
			end

			var_114_4 = var_114_44

			var_114_6(var_114_4)

			return
		end
	end

	SFX_PANEL = var_114_55

	var_12(var_114_59, var_114_60, var_114_61, var_114_55)

	setActive = var_12

	var_12(arg_114_0.fittingCalcMaxBtn, not var_114_3)

	local var_114_62 = arg_114_0.fittingAttrPanel
	local var_114_63 = var_12.Find(var_114_62, "phase_panel")
	local var_114_64 = var_12.Find(var_114_63, "phase_tpl")

	setActive = var_114_62

	var_114_62(var_114_64, false)

	local var_114_65 = {
		0,
		-60,
		0,
		60
	}
	local var_114_66 = {}

	for iter_114_0 = 1, var_114_0:getMaxFateLevel() do
		local var_114_67 = var_12
		local var_114_68

		if not var_12.Find(var_114_67, "phase_" .. iter_114_0) then
			cloneTplTo = var_114_68
			var_114_68 = var_114_68(var_114_64, var_12, "phase_" .. iter_114_0)
		end

		local var_114_69 = var_114_0:getFateStrengthenConfig(iter_114_0)

		assert = var_114_67

		if var_114_69.special == 1 then
			type = var_1_10024

			if var_1_10024(var_114_69.special_effect) ~= "table" then
				var_1_10024 = false
			else
				var_1_10024 = true
			end

			var_114_67(var_1_10024, "without fate config")

			local var_114_70 = var_114_69.special_effect
			local var_114_71

			ipairs = var_1_10024

			for iter_114_1, iter_114_4 in var_1_10024(var_114_70) do
				var_1_10029 = iter_114_4[1]
				ShipBluePrint = var_1_10030

				if var_1_10029 == var_1_10030.STRENGTHEN_TYPE_CHANGE_SKILL then
					var_114_71 = iter_114_4[2][2]

					break
				end
			end

			ipairs = var_1_10024

			for iter_114_3, iter_114_4 in var_1_10024({
				"off",
				"on"
			}) do
				setActive = var_1_10029

				var_1_10029(var_114_68:Find(iter_114_4 .. "/icon"), not var_114_71)

				setActive = var_1_10029

				var_1_10029(var_114_68:Find(iter_114_4 .. "/skill"), var_114_71)

				setActive = var_1_10029

				var_1_10029(var_114_68:Find(iter_114_4 .. "/icon/line"), var_114_65[iter_114_0])

				setActive = var_1_10029

				var_1_10029(var_114_68:Find(iter_114_4 .. "/skill/line"), var_114_65[iter_114_0])

				if var_114_65[iter_114_0] then
					var_1_10029 = var_114_68:Find(iter_114_4 .. "/icon/line")
					Vector3 = var_1_10030
					var_1_10029.localEulerAngles = var_1_10030(0, 0, var_114_65[iter_114_0])
					var_1_10029 = var_114_68:Find(iter_114_4 .. "/skill/line")
					Vector3 = var_1_10030
					var_1_10029.localEulerAngles = var_1_10030(0, 0, var_114_65[iter_114_0])
					GetImageSpriteFromAtlasAsync = var_1_10029

					var_1_10029("ui/shipblueprintui_atlas", iter_114_0 .. "_" .. iter_114_4, var_114_68:Find(iter_114_4 .. "/icon/icon"), true)
				end
			end

			if var_114_71 then
				GetImageSpriteFromAtlasAsync = var_1_10024

				local var_114_72 = "tecfateskillicon/skill_" .. var_114_71
				local var_114_73 = ""

				var_1_10030 = var_114_68

				var_1_10024(var_114_72, var_114_73, var_114_68.Find(var_1_10030, "off/skill/icon"), true)

				GetImageSpriteFromAtlasAsync = var_1_10024

				local var_114_74 = "tecfateskillicon/skill_on_" .. var_114_71
				local var_114_75 = ""

				var_1_10030 = var_114_68

				var_1_10024(var_114_74, var_114_75, var_114_68.Find(var_1_10030, "on/skill/icon"), true)

				var_114_66[iter_114_0] = 55
			else
				var_114_66[iter_114_0] = 40
			end

			onButton = var_1_10024

			local var_114_76 = arg_114_0
			local var_114_77 = var_114_68

			function iter_114_4()
				local var_127_0 = arg_114_0

				var_0.showFittingMsgPanel(var_127_0, iter_114_0)

				return
			end

			SFX_PANEL = var_1_10029

			var_1_10024(var_114_76, var_114_77, iter_114_4, var_1_10029)
		end
	end

	Vector2 = var_16

	local var_114_78 = var_16.zero

	Vector2 = var_17

	local var_114_79 = var_17.zero

	Vector2 = var_18

	local var_114_80 = var_18.zero

	for iter_114_5 = 1, var_114_0:getMaxFateLevel() do
		local var_114_81 = var_12:Find("phase_" .. iter_114_5)

		setAnchoredPosition = var_1_10024

		var_1_10024(var_114_81, var_114_78)

		math = var_1_10024
		var_114_79.x = var_1_10024.min(var_114_79.x, var_114_78.x)
		math = var_1_10024
		var_114_79.y = var_1_10024.min(var_114_79.y, var_114_78.y)
		math = var_1_10024
		var_114_80.x = var_1_10024.max(var_114_80.x, var_114_78.x)
		math = var_1_10024
		var_114_80.y = var_1_10024.max(var_114_80.y, var_114_78.y)

		if var_114_65[iter_114_5] then
			var_1_10024 = var_114_66[iter_114_5] + var_114_66[iter_114_5 + 1]
			Vector2 = var_25
			math = var_27

			local var_114_82 = var_27.cos

			math = var_1_10029

			local var_114_83 = var_114_82(var_1_10029.pi * var_114_65[iter_114_5] / 180)

			math = iter_114_4
			iter_114_4 = iter_114_4.sin
			math = var_30
			var_114_78 = var_114_78 + var_1_10024 * var_25(var_114_83, iter_114_4(var_30.pi * var_114_65[iter_114_5] / 180))
		end
	end

	setSizeDelta = var_19

	var_19(var_12, var_114_80 - var_114_79)

	setAnchoredPosition = var_19

	var_19(var_12, {
		y = -var_114_80.y
	})
	var_114_6(var_114_4)

	return
end

function var_0_1.updateFittingInfo(arg_128_0, arg_128_1)
	local var_128_0 = arg_128_0:getShipById(arg_128_1.shipId)
	local var_128_1 = arg_128_0.contextData.shipBluePrintVO

	arg_128_0:updateFittingAttrPanel(var_128_1, arg_128_1)

	GetImageSpriteFromAtlasAsync = var_4

	local var_128_2 = "ui/shipblueprintui_atlas"
	local var_128_3 = "phase_"

	math = var_8

	var_4(var_128_2, var_128_3 .. var_8.max(arg_128_1.fateLevel, 1), arg_128_0.phasePic, true)

	local var_128_4 = var_128_1

	if var_128_1.getNextFateLevelExp(var_128_4) == -1 then
		arg_128_0.phaseSlider.value = 1
	else
		arg_128_0.phaseSlider.value = var_128_1.exp / var_4
	end

	local var_128_5

	if arg_128_1:getNextFateLevelExp() == -1 then
		setText = var_128_5

		var_128_5(arg_128_0.phaseSliderTxt, "MAX")

		var_128_5 = arg_128_0.prePhaseSlider
		var_128_5.value = 1
	else
		math = var_128_5

		local var_128_6 = var_128_5.floor(arg_128_1.exp / arg_128_1:getNextFateLevelExp() * 100)

		setText = var_128_4

		local var_128_7 = arg_128_0.phaseSliderTxt

		tostring = var_9

		var_128_4(var_128_7, var_9(var_128_6) .. "%")

		arg_128_0.prePhaseSlider.value = arg_128_1.fateLevel > var_128_1.fateLevel and 1 or arg_128_1.exp / var_4
	end

	local var_128_8 = arg_128_1
	local var_128_9, var_128_10 = arg_128_1.isShipModMaxFateLevel(var_128_8, var_128_0)

	setActive = var_128_8

	var_128_8(arg_128_0.fittingNeedMask, var_128_9)

	if var_128_9 then
		setText = var_128_8

		local var_128_11 = arg_128_0.fittingNeedMask
		local var_128_12 = var_9.Find(var_128_11, "limit")

		i18n = var_10

		var_128_8(var_128_12, var_10("buleprint_need_level_tip", var_128_10))

		arg_128_0.phaseSlider.value = 1
	end

	return
end

function var_0_1.updateFittingAttrPanel(arg_129_0, arg_129_1, arg_129_2)
	setText = var_1_10003

	local var_129_0 = arg_129_0.fittingAttrPanel
	local var_129_1 = var_5.Find(var_129_0, "attr/name/Text")
	local var_129_2 = " + "

	defaultValue = var_129_0

	local var_129_3 = arg_129_2 or arg_129_1
	local var_129_4 = var_9.attrSpecialAddition(var_129_3)

	AttributeType = var_1_10010

	var_1_10003(var_129_1, var_129_2 .. var_129_0(var_129_4[var_1_10010.Luck], 0))

	local var_129_5

	if not arg_129_0.blinkTarget then
		var_129_5 = {
			{},
			{}
		}
	end

	arg_129_0.blinkTarget = var_129_5

	for iter_129_0 = 1, arg_129_1:getMaxFateLevel() do
		local var_129_6 = arg_129_0.fittingAttrPanel
		local var_129_7 = var_7.Find(var_129_6, "phase_panel/phase_" .. iter_129_0)
		local var_129_8 = var_7.Find(var_129_7, "off")
		local var_129_9 = var_7
		local var_129_10 = var_7.Find(var_129_9, "on")

		if arg_129_2 and arg_129_1.fateLevel < iter_129_0 and iter_129_0 <= arg_129_2.fateLevel then
			setActive = var_129_7

			var_129_7(var_129_8, true)

			setActive = var_129_7

			var_129_7(var_129_10, true)

			table = var_129_7

			if not var_129_7.contains(arg_129_0.blinkTarget[1], var_129_8) then
				table = var_129_7

				var_129_7.insert(arg_129_0.blinkTarget[1], var_129_8)

				table = var_129_7

				var_129_7.insert(arg_129_0.blinkTarget[2], var_129_10)
			end
		else
			table = var_129_7

			if var_129_7.indexof(arg_129_0.blinkTarget[1], var_129_8) then
				table = var_129_9

				var_129_9.remove(arg_129_0.blinkTarget[1], var_10)

				table = var_129_9

				var_129_9.remove(arg_129_0.blinkTarget[2], var_10)
			end

			setActive = var_129_9

			var_129_9(var_129_8, iter_129_0 > arg_129_1.fateLevel)

			setActive = var_129_9

			var_129_9(var_129_10, iter_129_0 <= arg_129_1.fateLevel)

			local var_129_11 = var_129_8
			local var_129_12 = var_129_8.GetComponent

			typeof = var_14
			CanvasGroup = var_1_10016
			var_129_12(var_129_11, var_14(var_1_10016)).alpha = 1

			local var_129_13 = var_129_10
			local var_129_14 = var_129_10.GetComponent

			typeof = var_14
			CanvasGroup = var_1_10016
			var_129_14(var_129_13, var_14(var_1_10016)).alpha = 1
		end
	end

	local var_129_15

	if #arg_129_0.blinkTarget[1] == 0 then
		LeanTween = var_129_15
		var_129_15 = var_129_15.cancel
		go = var_5

		var_129_15(var_5(arg_129_0.fittingAttrPanel))
	else
		LeanTween = var_129_15

		local var_129_16 = var_129_15.isTweening

		go = var_5

		if not var_129_16(var_5(arg_129_0.fittingAttrPanel)) then
			LeanTween = var_3

			local var_129_17 = var_3.value

			go = var_5

			local var_129_18 = var_129_17(var_5(arg_129_0.fittingAttrPanel), 1, 0, 0.8)
			local var_129_19 = var_3.setOnUpdate

			System = var_6

			local var_129_20 = var_129_19(var_129_18, var_6.Action_float(function(arg_130_0)
				ipairs = var_2_10001

				for iter_130_0, iter_130_1 in var_2_10001(arg_129_0.blinkTarget[1]) do
					local var_130_0 = iter_130_1
					local var_130_1 = iter_130_1.GetComponent

					typeof = var_2_10009
					CanvasGroup = var_2_10011
					var_130_1(var_130_0, var_2_10009(var_2_10011)).alpha = arg_130_0
				end

				ipairs = var_1

				for iter_130_2, iter_130_3 in var_1(arg_129_0.blinkTarget[2]) do
					local var_130_2 = iter_130_3
					local var_130_3 = iter_130_3.GetComponent

					typeof = var_2_10009
					CanvasGroup = var_2_10011
					var_130_3(var_130_2, var_2_10009(var_2_10011)).alpha = 1 - arg_130_0
				end

				return
			end))
			local var_129_21 = var_3.setEase

			LeanTweenType = var_6

			local var_129_22 = var_129_21(var_129_20, var_6.easeInOutSine)

			var_3.setLoopPingPong(var_129_22, 0)
		end
	end

	return
end

function var_0_1.updateModAdditionPanel(arg_131_0)
	local var_131_0 = arg_131_0.contextData.shipBluePrintVO
	local var_131_1 = var_1.specialStrengthens(var_131_0)

	for iter_131_0 = arg_131_0.modAdditionContainer.childCount - 1, #var_131_1 do
		var_1_10010 = arg_131_0

		arg_131_0.cloneTplTo(var_1_10010, arg_131_0.modAdditionTpl, arg_131_0.modAdditionContainer)
	end

	local var_131_2 = arg_131_0.modAdditionContainer.childCount

	for iter_131_1 = 1, var_131_2 do
		local var_131_3 = iter_131_1 <= #var_131_1
		local var_131_4 = arg_131_0.modAdditionContainer
		local var_131_5 = var_9.GetChild(var_131_4, iter_131_1 - 1)

		setActive = var_1_10010

		var_1_10010(var_131_5, var_131_3)

		if var_131_3 then
			arg_131_0:updateAdvanceTF(var_1, var_131_5, var_131_1[iter_131_1])
		end
	end

	return
end

function var_0_1.updateAdvanceTF(arg_132_0, arg_132_1, arg_132_2, arg_132_3)
	local var_132_0 = arg_132_1.level < arg_132_3.level

	setActive = var_5

	var_5(arg_132_2:Find("mask"), var_132_0)

	if var_132_0 then
		setText = var_5

		local var_132_1 = arg_132_2:Find("mask/content/Text")

		i18n = var_8

		var_5(var_132_1, var_8("blueprint_mod_addition_lock", arg_132_3.level))
	end

	local var_132_2 = arg_132_3.des
	local var_132_3

	if not arg_132_3.extraDes then
		var_132_3 = {}
	end

	local var_132_4 = arg_132_2:Find("additions")

	removeAllChildren = var_8

	var_8(var_132_4)

	local var_132_5 = arg_132_0.modAdditionPanel
	local var_132_6 = var_8.Find(var_132_5, "scroll_rect/info")

	local function var_132_7(arg_133_0, arg_133_1)
		local var_133_0 = arg_133_1[2]

		pg = var_2_10003

		local var_133_1 = var_2_10003.ship_data_breakout[var_133_0].pre_id

		Ship = var_2_10004

		local var_133_2 = var_2_10004.New({
			configId = var_133_0
		})

		Ship = var_2_10005

		local var_133_3 = var_2_10005.New({
			configId = var_133_1
		})
		local var_133_4 = var_5.getStar(var_133_3)
		local var_133_5 = var_133_2:getStar()
		local var_133_6 = arg_133_0:Find("star_tpl")
		local var_133_7 = arg_133_0
		local var_133_8 = arg_133_0.Find(var_133_7, "stars")
		local var_133_9 = arg_133_0:Find("pre_stars")

		removeAllChildren = var_133_7

		var_133_7(var_133_8)

		removeAllChildren = var_133_7

		var_133_7(var_133_9)

		for iter_133_0 = 1, var_133_4 do
			cloneTplTo = var_2_10015

			var_2_10015(var_133_6, var_133_8)
		end

		for iter_133_1 = 1, var_133_5 do
			cloneTplTo = var_2_10015

			var_2_10015(var_133_6, var_133_9)
		end

		return
	end

	for iter_132_0 = 1, #var_132_2 do
		cloneTplTo = var_1_10014

		local var_132_8 = var_1_10014(var_132_6, var_132_4)
		local var_132_9 = var_1_10014.Find(var_132_8, "text_tpl")
		local var_132_10 = var_1_10014
		local var_132_11 = var_1_10014.Find(var_132_10, "breakout_tpl")

		setActive = var_132_8

		var_132_8(var_132_9, false)

		setActive = var_132_8

		var_132_8(var_1_10014:Find("attr_tpl"), false)

		setActive = var_132_8

		var_132_8(var_132_11, false)

		setActive = var_132_8

		var_132_8(var_1_10014:Find("empty_tpl"), false)

		if var_132_2[iter_132_0] then
			local var_132_12 = var_132_2[iter_132_0][1]

			ShipBluePrint = var_132_10

			if var_132_12 == var_132_10.STRENGTHEN_TYPE_BREAKOUT then
				setActive = var_18

				var_18(var_132_11, true)
				var_132_7(var_132_11, var_132_2[iter_132_0])
			else
				setActive = var_18

				var_18(var_132_9, true)

				setText = var_18

				var_18(var_132_9:Find("Text"), var_132_2[iter_132_0][3])
			end
		end
	end

	for iter_132_1 = 1, #var_132_3 do
		cloneTplTo = var_1_10014

		local var_132_13 = var_1_10014(var_132_6, var_132_4)
		local var_132_14 = var_1_10014.Find(var_132_13, "text_tpl")

		setActive = var_16

		var_16(var_132_14, true)

		setActive = var_16

		var_16(var_1_10014:Find("attr_tpl"), false)

		setActive = var_16

		var_16(var_1_10014:Find("breakout_tpl"), false)

		setActive = var_16

		var_16(var_1_10014:Find("empty_tpl"), false)

		setText = var_16

		var_16(var_132_14:Find("Text"), var_132_3[iter_132_1])
	end

	return
end

function var_0_1.updateInfo(arg_134_0)
	local var_134_0 = arg_134_0.contextData.shipBluePrintVO
	local var_134_1

	if var_134_0:isFetched() then
		var_134_1 = arg_134_0.shipVOs[var_134_0.shipId]
	end

	var_134_1 = var_134_1 or var_134_0:getShipVO()

	local var_134_2 = var_134_1
	local var_134_3 = var_134_1.getConfigTable(var_134_2)
	local var_134_4 = var_134_1:getName()

	setText = var_134_2

	var_134_2(arg_134_0.shipName, var_134_4)

	setText = var_134_2

	var_134_2(arg_134_0.englishName, var_134_3.english_name)

	removeAllChildren = var_134_2

	var_134_2(arg_134_0.stars)

	local var_134_5 = var_134_1:getStar()
	local var_134_6 = var_134_1:getMaxStar()

	for iter_134_0 = 1, var_134_6 do
		cloneTplTo = var_1_10011

		var_1_10011(arg_134_0.shipInfoStarTpl, arg_134_0.stars, "star_" .. iter_134_0)
	end

	local var_134_7 = var_134_6 - var_134_5

	for iter_134_1 = 1, var_134_7 do
		local var_134_8 = arg_134_0.stars
		local var_134_9 = var_12.GetChild(var_134_8, var_134_6 - iter_134_1)

		setActive = var_1_10013

		var_1_10013(var_134_9:Find("star_tpl"), false)

		setActive = var_1_10013

		var_1_10013(var_134_9:Find("empty_star_tpl"), true)
	end

	GetSpriteFromAtlas = var_8

	if not var_8("shiptype", var_134_1:getShipType()) then
		warning = var_9

		var_9("找不到船形, shipConfigId: " .. var_134_1.configId)
	end

	setImageSprite = var_9

	var_9(arg_134_0.shipType, var_8, true)

	local var_134_10 = var_134_0
	local var_134_11 = var_134_0.isLock(var_134_10)

	setActive = var_10

	local var_134_12 = arg_134_0.finishedBtn
	local var_134_13 = var_134_0

	var_10(var_134_12, var_134_0.isFinished(var_134_13))

	local var_134_14 = var_134_0:isDeving()

	setActive = var_134_10

	var_134_10(arg_134_0.progressPanel, var_134_14)

	if not var_134_14 then
		setActive = var_134_10

		var_134_10(arg_134_0.speedupBtn, false)
	end

	if var_134_14 then
		arg_134_0:updateTasksProgress()
	end

	local var_134_15 = var_134_0
	local var_134_16, var_134_17 = var_134_0.isFinishPrevTask(var_134_15)

	if var_134_11 and not var_134_17 then
		if var_134_16 then
			ipairs = var_134_15

			for iter_134_2, iter_134_3 in var_134_15(var_134_0:getOpenTaskList()) do
				local var_134_18 = arg_134_0
				local var_134_19 = arg_134_0.emit

				ShipBluePrintMediator = var_1_10021

				var_134_19(var_134_18, var_1_10021.ON_FINISH_TASK, iter_134_3)
			end

			var_134_17 = true
		else
			getProxy = var_134_15
			TaskProxy = var_134_13
			var_134_15 = var_134_15(var_134_13)

			local var_134_20 = var_134_0:getOpenTaskList()

			ipairs = var_134_13

			for iter_134_4, iter_134_5 in var_134_13(var_134_20) do
				local var_134_21 = var_134_15
				local var_134_22 = var_134_15.getTaskVO(var_134_21, iter_134_5)

				if arg_134_0.lockPanel.childCount < iter_134_4 then
					cloneTplTo = var_21

					local var_134_24

					if not var_21(arg_134_0.lockBtn, arg_134_0.lockPanel) then
						local var_134_23 = arg_134_0.lockPanel

						var_134_24 = var_21.GetChild(var_134_23, iter_134_4 - 1)
					end

					setActive = var_134_21

					var_134_21(var_134_24, true)

					local var_134_25 = var_134_22
					local var_134_26 = var_134_22.getProgress(var_134_25)
					local var_134_27 = var_134_22:getConfig("target_num")

					setText = var_134_25

					local var_134_28 = var_134_24:Find("Text")

					if var_134_27 <= var_134_26 then
						setColorStr = var_1_10027

						local var_134_29 = var_134_26

						COLOR_GREEN = var_1_10030

						if not var_1_10027(var_134_29, var_1_10030) then
							var_1_10027 = var_134_26
						end

						var_134_25(var_134_28, var_1_10027 .. "/" .. var_134_27)
					end
				end
			end

			for iter_134_6 = #var_134_20 + 1, arg_134_0.lockPanel.childCount do
				setActive = iter_134_5

				local var_134_30 = arg_134_0.lockPanel

				iter_134_5(var_21.GetChild(var_134_30, iter_134_6 - 1), false)
			end
		end
	end

	setText = var_134_15

	local var_134_31 = arg_134_0.openCondition

	var_134_15(var_15.Find(var_134_31, "Text"), var_134_0:getConfig("unlock_word"))

	setActive = var_134_15

	var_134_15(arg_134_0.openCondition, var_134_11)

	setActive = var_134_15

	var_134_15(arg_134_0.startBtn, var_134_11 and var_134_17)

	setActive = var_134_15

	var_134_15(arg_134_0.lockPanel, var_134_11 and not var_134_17)

	return
end

function var_0_1.updateTasksProgress(arg_135_0)
	local var_135_0 = arg_135_0.contextData.shipBluePrintVO

	if not var_1.isDeving(var_135_0) then
		return
	end

	local var_135_1 = var_1:getTaskIds()

	for iter_135_0 = arg_135_0.progressContainer.childCount, #var_135_1 do
		cloneTplTo = var_1_10008

		var_1_10008(arg_135_0.progressTpl, arg_135_0.progressContainer)
	end

	local var_135_2 = arg_135_0.progressContainer.childCount

	for iter_135_1 = 1, var_135_2 do
		local var_135_3 = arg_135_0.progressContainer
		local var_135_4 = var_8.GetChild(var_135_3, iter_135_1 - 1)
		local var_135_5 = iter_135_1 <= #var_135_1

		setActive = var_135_3

		var_135_3(var_135_4, var_135_5)

		if var_135_5 then
			local var_135_6 = var_1:getTaskStateById(var_135_1[iter_135_1])

			setActive = var_1_10011
			findTF = var_1_10013
			var_1_10013 = var_1_10013(var_135_4, "complete")
			ShipBluePrint = var_1_10014
			var_1_10014 = var_135_6 == var_1_10014.TASK_STATE_FINISHED

			var_1_10011(var_1_10013, var_1_10014)

			setActive = var_1_10011
			findTF = var_1_10013
			var_1_10013 = var_1_10013(var_135_4, "lock")
			ShipBluePrint = var_1_10014

			if var_135_6 ~= var_1_10014.TASK_STATE_LOCK then
				ShipBluePrint = var_1_10014

				if var_135_6 ~= var_1_10014.TASK_STATE_WAIT then
					var_1_10014 = false

					goto label_135_0
				end
			end

			var_1_10014 = true

			::label_135_0::

			var_1_10011(var_1_10013, var_1_10014)

			setActive = var_1_10011
			findTF = var_1_10013
			var_1_10013 = var_1_10013(var_135_4, "working")
			ShipBluePrint = var_1_10014

			if var_135_6 ~= var_1_10014.TASK_STATE_ACHIEVED then
				ShipBluePrint = var_1_10014

				if var_135_6 ~= var_1_10014.TASK_STATE_OPENING then
					ShipBluePrint = var_1_10014

					if var_135_6 ~= var_1_10014.TASK_STATE_START then
						var_1_10014 = false

						goto label_135_1
					end
				end
			end

			var_1_10014 = true

			::label_135_1::

			var_1_10011(var_1_10013, var_1_10014)
		end
	end

	local var_135_7 = var_1
	local var_135_8 = var_1.getConfig(var_135_7, "blueprint_version")

	pg = var_5

	if var_5.gameset.technology_catchup_itemid.description[var_135_8] then
		var_135_7 = var_1:getTaskStateById(var_135_1[1])

		local var_135_9 = var_1
		local var_135_10 = var_1.getTaskStateById(var_135_9, var_135_1[4])
		local var_135_11 = var_5[1]

		getProxy = var_135_9
		BagProxy = var_1_10011

		local var_135_12 = var_135_9(var_1_10011)
		local var_135_13 = var_9.getItemCountById(var_135_12, var_135_11)

		setActive = var_10

		local var_135_14 = arg_135_0.speedupBtn

		ShipBluePrint = var_1_10013

		if var_135_7 ~= var_1_10013.TASK_STATE_START then
			ShipBluePrint = var_13

			if var_135_10 == var_13.TASK_STATE_START then
				local var_135_15

				if not (var_135_13 > 0) then
					var_135_15 = false
				else
					var_135_15 = true
				end

				var_10(var_135_14, var_135_15)

				goto label_135_2

				setActive = var_135_7

				var_135_7(arg_135_0.speedupBtn, false)

				::label_135_2::

				return
			end
		end
	end
end

function var_0_1.updatePainting(arg_136_0)
	local var_136_0 = arg_136_0.contextData.shipBluePrintVO
	local var_136_1 = var_1.getShipVO(var_136_0)
	local var_136_2 = var_2.getPainting(var_136_1)

	PLATFORM_CODE = var_136_0
	PLATFORM_CH = var_136_1

	if var_136_0 == var_136_1 then
		checkABExist = var_136_0

		if var_136_0("painting/" .. var_136_2 .. "_blueprint") then
			var_136_2 = var_136_2 .. "_blueprint"
		end
	end

	if arg_136_0.lastPaintingName and arg_136_0.lastPaintingName ~= var_136_2 then
		retPaintingPrefab = var_4

		var_4(arg_136_0.painting, arg_136_0.lastPaintingName)
	end

	arg_136_0.lastPaintingName = var_136_2
	setPaintingPrefab = var_4

	var_4(arg_136_0.painting, var_136_2, "tuzhi")
	arg_136_0:paintBreath()

	return
end

function var_0_1.updateProperty(arg_137_0)
	local var_137_0 = arg_137_0.contextData.shipBluePrintVO
	local var_137_1 = var_1.getShipVO(var_137_0)
	local var_137_2 = arg_137_0.propertyPanel
	local var_137_3 = var_3.initProperty
	local var_137_4 = var_137_1.configId

	PropertyPanel = var_1_10007

	var_137_3(var_137_2, var_137_4, var_1_10007.TypeFlat)

	local var_137_5 = var_0_3[var_137_1.configId].buff_list_display

	for iter_137_0 = arg_137_0.skillPanel.childCount, #var_137_5 - 1 do
		cloneTplTo = var_1_10010

		var_1_10010(arg_137_0.skillTpl, arg_137_0.skillPanel)
	end

	local var_137_6 = arg_137_0.skillPanel.childCount

	for iter_137_1 = 1, var_137_6 do
		var_1_10012 = arg_137_0.skillPanel

		local var_137_7 = var_10.GetChild(var_1_10012, iter_137_1 - 1)

		var_1_10011 = iter_137_1 <= #var_137_5
		findTF = var_1_10012
		var_1_10012 = var_1_10012(var_137_7, "icon")

		local var_137_8

		if var_1_10011 then
			var_137_8 = var_137_5[iter_137_1]
			getSkillConfig = var_14

			local var_137_9 = var_14(var_137_8)

			LoadImageSpriteAsync = var_15

			var_15("skillicon/" .. var_137_9.icon, var_1_10012)

			onButton = var_15

			local var_137_10 = arg_137_0
			local var_137_11 = var_137_7

			local function var_137_12()
				local var_138_0 = arg_137_0
				local var_138_1 = var_0.emit

				ShipBluePrintMediator = var_2_10003

				local var_138_2 = var_2_10003.SHOW_SKILL_INFO
				local var_138_3 = var_137_9.id
				local var_138_4 = {
					id = var_137_9.id
				}

				pg = var_6
				var_138_4.level = var_6.skill_data_template[var_137_9.id].max_level

				var_138_1(var_138_0, var_138_2, var_138_3, var_138_4, function()
					return
				end)

				return
			end

			SFX_PANEL = var_1_10020

			var_15(var_137_10, var_137_11, var_137_12, var_1_10020)
		end

		setActive = var_137_8

		var_137_8(var_137_7, var_1_10011)
	end

	setActive = var_6

	var_6(arg_137_0.skillArrLeft, #var_137_5 > 3)

	setActive = var_6

	var_6(arg_137_0.skillArrRight, #var_137_5 > 3)

	local var_137_13 = #var_137_5

	if 3 < var_137_13 then
		onScroll = var_137_13

		var_137_13(arg_137_0, arg_137_0.skillRect, function(arg_140_0)
			setActive = var_2_10001

			var_2_10001(arg_137_0.skillArrLeft, arg_140_0.x > 0.01)

			setActive = var_2_10001

			var_2_10001(arg_137_0.skillArrRight, arg_140_0.x < 0.99)

			return
		end)
	else
		GetComponent = var_137_13

		local var_137_14 = arg_137_0.skillRect

		typeof = var_9
		ScrollRect = var_1_10011

		local var_137_15 = var_137_13(var_137_14, var_9(var_1_10011)).onValueChanged

		var_137_13.RemoveAllListeners(var_137_15)
	end

	setAnchoredPosition = var_137_13

	var_137_13(arg_137_0.skillPanel, {
		x = 0
	})

	local var_137_16 = var_1:getConfig("simulate_dungeon")

	setActive = var_7

	var_7(arg_137_0.simulationBtn, var_137_16 ~= 0)

	onButton = var_7

	local var_137_17 = arg_137_0
	local var_137_18 = arg_137_0.simulationBtn

	local function var_137_19()
		local var_141_1

		if var_137_16 == 0 then
			pg = var_141_1

			local var_141_0 = var_141_1.TipsMgr.GetInstance()

			var_141_1 = var_141_1.ShowTips
			i18n = var_2_10003

			var_141_1(var_141_0, var_2_10003("tech_simulate_closed"))
		else
			i18n = var_141_1

			local var_141_2 = var_141_1("blueprint_simulation_confirm_" .. var_0.id)

			pg = var_2_10001

			local var_141_3 = var_2_10001.MsgboxMgr.GetInstance()

			var_1.ShowMsgBox(var_141_3, {
				content = var_141_2,
				onYes = function()
					local var_142_0 = arg_137_0
					local var_142_1 = var_0.emit

					ShipBluePrintMediator = var_3_10003

					var_142_1(var_142_0, var_3_10003.SIMULATION_BATTLE, var_137_16)

					return
				end
			})
		end

		return
	end

	SFX_CONFIRM = var_1_10012

	var_7(var_137_17, var_137_18, var_137_19, var_1_10012)

	return
end

function var_0_1.updateTaskList(arg_143_0)
	local var_143_0 = arg_143_0.contextData.shipBluePrintVO
	local var_143_1 = var_1.getTaskIds(var_143_0)

	UIItemList = var_1_10003

	var_1_10003.StaticAlign(arg_143_0.taskContainer, arg_143_0.taskTpl, #var_143_1, function(arg_144_0, arg_144_1, arg_144_2)
		arg_144_1 = arg_144_1 + 1
		UIItemList = var_2_10003

		if arg_144_0 == var_2_10003.EventUpdate then
			if arg_143_0.taskTFs[arg_144_1] then
				local var_144_0 = arg_143_0.taskTFs[arg_144_1]

				var_3.clear(var_144_0)
			end

			if arg_144_1 <= #var_143_1 then
				if not arg_143_0.taskTFs[arg_144_1] then
					local var_144_1 = arg_143_0.taskTFs
					local var_144_2 = arg_143_0

					var_144_1[arg_144_1] = var_4.createTask(var_144_2, arg_144_2)
				end

				local var_144_3 = var_143_1[arg_144_1]
				local var_144_4 = arg_143_0
				local var_144_5 = var_4.getTaskById(var_144_4, var_144_3)

				if var_0.duration > 0 then
					local var_144_6 = var_0

					var_144_5.leftTime = var_5.getTaskOpenTimeStamp(var_144_6, var_144_3) - var_0.duration
				end

				local var_144_7 = var_0

				var_144_5.taskState = var_5.getTaskStateById(var_144_7, var_144_3)

				local var_144_8 = var_0

				var_144_5.dueTime = var_5.getTaskOpenTimeStamp(var_144_8, var_144_3)
				var_144_5.index = arg_144_1

				local var_144_9 = arg_143_0.taskTFs[arg_144_1]

				var_5.update(var_144_9, var_144_5)
			end
		end

		return
	end)

	return
end

function var_0_1.updatePhantomQuest(arg_145_0)
	local var_145_0 = arg_145_0.contextData.shipBluePrintVO
	local var_145_1 = var_1.isUnlockShipPhantom(var_145_0)

	setActive = var_1_10003

	local var_145_2 = arg_145_0.phantomPanel

	var_1_10003(var_5.Find(var_145_2, "title/bg"), var_145_1)

	setActive = var_1_10003

	local var_145_3 = arg_145_0.phantomPanel

	var_1_10003(var_5.Find(var_145_3, "title/bg_lock"), not var_145_1)

	setActive = var_1_10003

	local var_145_4 = arg_145_0.phantomPanel

	var_1_10003(var_5.Find(var_145_4, "desc/content"), var_145_1)

	setActive = var_1_10003

	local var_145_5 = arg_145_0.phantomPanel

	var_1_10003(var_5.Find(var_145_5, "desc/lock_mask"), not var_145_1)

	setText = var_1_10003

	local var_145_6 = arg_145_0.phantomPanel
	local var_145_7 = var_5.Find(var_145_6, "desc/lock_mask/Text")

	i18n = var_6

	local var_145_8 = "tech_shadow_limit_text"

	getGameset = var_1_10009

	var_1_10003(var_145_7, var_6(var_145_8, var_1_10009("technology_shadow_unlock_lv")[1]))

	if not var_145_1 then
		return
	end

	local var_145_9 = var_1:getAllPhantomQuestInfo()

	setText = var_145_0

	local var_145_10 = arg_145_0.phantomPanel
	local var_145_11 = var_6.Find(var_145_10, "title/bg/Text")

	string = var_145_6

	local var_145_12 = var_145_6.format
	local var_145_13 = "%d/%d"

	underscore = var_1_10010

	var_145_0(var_145_11, var_145_12(var_145_13, #var_1_10010.filter(var_145_9, function(arg_146_0)
		return arg_146_0.unlocked
	end), #var_145_9))

	UIItemList = var_145_0

	var_145_0.StaticAlign(arg_145_0.rtPhantomQuestContainer, arg_145_0.questTpl, #var_145_9, function(arg_147_0, arg_147_1, arg_147_2)
		arg_147_1 = arg_147_1 + 1
		UIItemList = var_2_10003

		if arg_147_0 == var_2_10003.EventUpdate then
			local var_147_0 = var_145_9[arg_147_1]

			setActive = var_2_10004

			var_2_10004(arg_147_2:Find("title/bg"), var_147_0.config.type ~= 5)

			setActive = var_2_10004

			var_2_10004(arg_147_2:Find("title/bg_1"), var_147_0.config.type == 5)

			setActive = var_2_10004

			var_2_10004(arg_147_2:Find("title/complete"), var_147_0.unlocked)

			setActive = var_2_10004

			var_2_10004(arg_147_2:Find("title/working"), not var_147_0.unlocked)

			setText = var_2_10004

			var_2_10004(arg_147_2:Find("title/name"), var_147_0.config.name)

			setText = var_2_10004

			var_2_10004(arg_147_2:Find("title/number"), arg_147_1)

			setSlider = var_2_10004

			local var_147_1 = arg_147_2:Find("title/slider")
			local var_147_2 = 0
			local var_147_3 = var_147_0.config.target_num
			local var_147_4

			if not var_147_0.unlocked or not var_147_0.config.target_num then
				var_147_4 = var_147_0.progress
			end

			var_2_10004(var_147_1, var_147_2, var_147_3, var_147_4)

			setActive = var_2_10004

			var_2_10004(arg_147_2:Find("title/slider/complete"), var_147_0.unlocked)

			setActive = var_2_10004

			var_2_10004(arg_147_2:Find("title/tip"), not var_147_0.unlocked and var_147_0.progress >= var_147_0.config.target_num)

			if var_147_0.config.type == 5 then
				setText = var_4

				local var_147_5 = arg_147_2:Find("desc/info/Text")

				stringInset = var_7

				var_4(var_147_5, var_7(var_147_0.config.desc, var_147_0.config.target_num))
			else
				setText = var_4

				var_4(arg_147_2:Find("desc/info/Text"), var_147_0.config.desc)
			end

			string = var_4

			local var_147_6 = var_4.format
			local var_147_7 = "%d"

			math = var_7

			local var_147_8 = var_7.clamp
			local var_147_9

			if not var_147_0.unlocked or not var_147_0.config.target_num then
				var_147_9 = var_147_0.progress
			end

			local var_147_10 = var_147_6(var_147_7, var_147_8(var_147_9, 0, var_147_0.config.target_num) * 100 / var_147_0.config.target_num)

			setText = var_2_10005

			var_2_10005(arg_147_2:Find("desc/info/progress"), var_147_10 .. "%")

			setText = var_2_10005

			var_2_10005(arg_147_2:Find("desc/info/progress/shadow"), var_147_10 .. "%")

			ShipBluePrint = var_2_10005

			local var_147_11 = var_2_10005.getPhantomQuestCostDrop(var_147_0)

			setActive = var_147_7

			local var_147_12 = arg_147_2

			var_147_7(arg_147_2.Find(var_147_12, "desc/item_info/items"), var_147_11)

			if var_147_11 then
				updateDrop = var_147_7
				var_147_12 = arg_147_2

				var_147_7(arg_147_2.Find(var_147_12, "desc/item_info/items/item_tpl/award"), var_147_11)
			end

			local var_147_13

			if not var_147_0.unlocked then
				var_147_13 = var_147_0.progress < var_147_0.config.target_num
			end

			setActive = var_7

			local var_147_14 = arg_147_2:Find("desc/commit_panel/commit_btn")

			canCommit = var_147_12

			var_7(var_147_14, not var_147_12)

			setActive = var_7

			var_7(arg_147_2:Find("desc/commit_panel/lock_btn"), var_147_13)

			onButton = var_7

			local var_147_15 = arg_145_0
			local var_147_16 = arg_147_2
			local var_147_17 = arg_147_2.Find(var_147_16, "desc/commit_panel/commit_btn")

			local function var_147_18()
				local var_148_0 = {}

				if var_147_11 then
					table = var_1

					var_1.insert(var_148_0, function(arg_149_0)
						pg = var_4_10001

						local var_149_0 = var_4_10001.MsgboxMgr.GetInstance()
						local var_149_1 = var_1.ShowMsgBox
						local var_149_2 = {}

						i18n = var_4_10005

						local var_149_3 = "tech_shadow_commit_tip"
						local var_149_4 = var_147_11

						var_149_2.content = var_4_10005(var_149_3, var_8.getName(var_149_4) .. "x" .. var_147_11.count)
						var_149_2.onYes = arg_149_0

						var_149_1(var_149_0, var_149_2)

						return
					end)
				end

				seriesAsync = var_1

				var_1(var_148_0, function()
					local var_150_0 = arg_145_0
					local var_150_1 = var_0.emit

					ShipBluePrintMediator = var_4_10003

					var_150_1(var_150_0, var_4_10003.FINISH_PHANTOM_QUEST, var_0.id, arg_147_1)

					return
				end)

				return
			end

			SFX_CONFIRM = var_147_16

			var_7(var_147_15, var_147_17, var_147_18, var_147_16)

			onToggle = var_7

			local var_147_19 = arg_145_0
			local var_147_20 = arg_147_2

			local function var_147_21(arg_151_0)
				if arg_151_0 then
					Canvas = var_3_10001

					var_3_10001.ForceUpdateCanvases()

					local var_151_0 = arg_145_0.rtPhantomQuestContainer.parent.transform
					local var_151_1 = var_1.InverseTransformPoint(var_151_0, arg_147_2.position).y - arg_147_2.rect.height
					local var_151_2 = arg_145_0.rtPhantomQuestContainer.parent.transform.rect
					local var_151_3 = 0

					if var_151_1 < var_151_2.yMin then
						var_151_3 = var_151_2.yMin - var_151_1
					end

					if var_1 > var_151_2.yMax then
						var_151_3 = var_151_2.yMax - var_1
					end

					var_5.y = arg_145_0.rtPhantomQuestContainer.localPosition.y + var_151_3
					arg_145_0.rtPhantomQuestContainer.localPosition = var_5
				end

				return
			end

			SFX_PANEL = var_147_16

			var_7(var_147_19, var_147_20, var_147_21, var_147_16)
		end

		return
	end)

	return
end

function var_0_1.createTask(arg_152_0, arg_152_1)
	local var_152_0 = ({
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
	}).itemInfo

	var_2.itemContainer = var_3.Find(var_152_0, "items")

	local var_152_1 = var_2.itemContainer

	var_2.itemTpl = var_3.Find(var_152_1, "item_tpl")
	var_2.numberTF = arg_152_1:Find("title/number")
	var_2.progressTF = arg_152_1:Find("title/slider")

	local var_152_2 = var_2.progressTF
	local var_152_3 = var_3.GetComponent

	typeof = var_6
	Slider = var_1_10008
	var_2.progessSlider = var_152_3(var_152_2, var_6(var_1_10008))
	var_2.lockBtn = arg_152_1:Find("desc/commit_panel/lock_btn")

	local var_152_4 = var_2.itemTpl

	var_2.itemCount = var_3.Find(var_152_4, "award/icon_bg/count")
	var_2.progres = arg_152_1:Find("desc/info/progress")
	var_2.progreshadow = arg_152_1:Find("desc/info/progress/shadow")
	findTF = var_3
	var_2.check = var_3(arg_152_1, "title/complete")
	findTF = var_3
	var_2.lock = var_3(arg_152_1, "title/lock")
	findTF = var_3
	var_2.working = var_3(arg_152_1, "title/working")
	findTF = var_3
	var_2.pause = var_3(arg_152_1, "title/pause")
	findTF = var_3
	var_2.pauseLock = var_3(arg_152_1, "title/pause_lock")
	var_2.view = arg_152_0
	onToggle = var_3

	local var_152_5 = arg_152_0
	local var_152_6 = arg_152_1

	local function var_152_7(arg_153_0)
		setActive = var_2_10001

		var_2_10001(var_0.desc, arg_153_0)

		setActive = var_2_10001

		var_2_10001(var_0.progreshadow, arg_153_0)

		if arg_153_0 then
			Canvas = var_2_10001

			var_2_10001.ForceUpdateCanvases()

			local var_153_0 = arg_152_0.taskContainer.parent.transform
			local var_153_1 = var_1.InverseTransformPoint(var_153_0, arg_152_1.position).y - arg_152_1.rect.height
			local var_153_2 = arg_152_0.taskContainer.parent.transform.rect
			local var_153_3 = 0

			if var_153_1 < var_153_2.yMin then
				var_153_3 = var_153_2.yMin - var_153_1
			end

			if var_1 > var_153_2.yMax then
				var_153_3 = var_153_2.yMax - var_1
			end

			var_5.y = arg_152_0.taskContainer.localPosition.y + var_153_3
			arg_152_0.taskContainer.localPosition = var_5
		end

		return
	end

	SFX_PANEL = var_1_10008

	var_3(var_152_5, var_152_6, var_152_7, var_1_10008)

	function var_2.update(arg_154_0, arg_154_1)
		arg_154_0:clearTimer()

		arg_154_0.autoCommit = true
		arg_154_0.isExpTask = false
		removeOnButton = var_2

		var_2(arg_154_0.commitBtn)
		arg_154_0:updateItemInfo(arg_154_1)
		arg_154_0:updateView(arg_154_1)
		arg_154_0:updateProgress(arg_154_1)

		return
	end

	function var_2.updateItemInfo(arg_155_0, arg_155_1)
		arg_155_0.taskVO = arg_155_1
		changeToScrollText = var_2_10002

		var_2_10002(arg_155_0.title, arg_155_1:getConfig("name"))

		setText = var_2_10002

		var_2_10002(arg_155_0.desc, arg_155_1:getConfig("desc") .. "\n\n")

		local var_155_0
		local var_155_1 = arg_155_1
		local var_155_2 = arg_155_1.getConfig(var_155_1, "target_num")
		local var_155_3 = arg_155_1:getConfig("sub_type")

		TASK_SUB_TYPE_GIVE_ITEM = var_155_1

		if var_155_3 == var_155_1 then
			arg_155_0.autoCommit = false
			tonumber = var_155_1
			var_155_0 = var_155_1(arg_155_1:getConfig("target_id"))
		else
			TASK_SUB_TYPE_PLAYER_RES = var_155_1

			if var_155_3 == var_155_1 then
				arg_155_0.autoCommit = false
				id2ItemId = var_155_1
				tonumber = var_7
				var_155_0 = var_155_1(var_7(arg_155_1:getConfig("target_id")))
			else
				TASK_SUB_TYPE_BATTLE_EXP = var_155_1

				if var_155_3 == var_155_1 then
					arg_155_0.isExpTask = true
					var_155_0 = 59000
				end
			end
		end

		setActive = var_155_1

		var_155_1(arg_155_0.itemContainer, not arg_155_0.autoCommit or arg_155_0.isExpTask)

		if var_155_0 then
			updateDrop = var_155_1

			local var_155_4 = arg_155_0.itemTpl

			var_155_1(var_7.Find(var_155_4, "award"), {
				type = 2,
				id = var_155_0,
				count = var_155_2
			})

			setText = var_155_1

			local var_155_5 = arg_155_0.itemCount

			if 1000 < var_155_2 then
				math = var_8

				local var_155_6

				if not (var_8.floor(var_155_2 / 1000) .. "K") then
					var_155_6 = var_155_2
				end

				var_155_1(var_155_5, var_155_6)

				setText = var_155_1

				var_155_1(arg_155_0.numberTF, arg_155_1.index)

				return
			end
		end
	end

	function var_2.updateView(arg_156_0, arg_156_1)
		local var_156_0 = arg_156_1.taskState
		local var_156_1 = false
		local var_156_2 = false
		local var_156_3 = false

		ShipBluePrint = var_2_10006

		if var_156_0 == var_2_10006.TASK_STATE_PAUSE and arg_156_1.leftTime then
			getProxy = var_6
			TaskProxy = var_2_10008

			local var_156_4 = var_6(var_2_10008)

			if var_6.getTaskVO(var_156_4, arg_156_1.id) then
				::label_156_0::

				var_2_10009 = var_6
				var_156_1 = var_6.isFinish(var_2_10009)
			end

			var_156_3 = arg_156_1.leftTime > 0

			if var_6 then
				::label_156_1::

				var_2_10009 = var_6
				var_156_2 = var_6.isReceive(var_2_10009)
			end

			if arg_156_1.leftTime > 0 then
				setText = var_7
				var_2_10009 = var_0.timerTFTxt
				pg = var_2_10010

				local var_156_5 = var_2_10010.TimeMgr.GetInstance()

				var_7(var_2_10009, var_10.DescCDTime(var_156_5, arg_156_1.leftTime))
			end
		end

		setActive = var_6

		local var_156_6 = arg_156_0.pause

		ShipBluePrint = var_2_10009

		if var_2_10009.TASK_STATE_PAUSE ~= var_156_0 or var_156_1 or var_156_3 then
			ShipBluePrint = var_9

			if var_9.TASK_STATE_PAUSE == var_156_0 and not var_156_3 then
				local var_156_7

				if var_156_1 then
					::label_156_2::

					var_156_7 = not arg_156_0.autoCommit

					if false then
						var_156_7 = false
					end

					goto label_156_3

					var_156_7 = true
				end

				::label_156_3::

				var_6(var_156_6, var_156_7)

				setActive = var_6

				local var_156_8 = arg_156_0.pauseLock

				ShipBluePrint = var_156_7

				var_6(var_156_8, var_156_7.TASK_STATE_PAUSE == var_156_0 and not var_156_1 and var_156_3)

				setActive = var_6

				local var_156_9 = arg_156_0.lockBtn

				ShipBluePrint = var_9

				if var_156_0 ~= var_9.TASK_STATE_ACHIEVED then
					ShipBluePrint = var_9

					local var_156_10

					if var_156_0 == var_9.TASK_STATE_START then
						var_156_10 = not not arg_156_0.autoCommit

						if false then
							var_156_10 = false
						end
					else
						var_156_10 = true
					end

					var_6(var_156_9, var_156_10)

					setActive = var_6

					local var_156_11 = arg_156_0.commitBtn

					ShipBluePrint = var_156_10

					local var_156_12

					if var_156_0 ~= var_156_10.TASK_STATE_ACHIEVED then
						ShipBluePrint = var_9

						if var_156_0 == var_9.TASK_STATE_START then
							var_156_12 = not arg_156_0.autoCommit
						else
							var_156_12 = false
						end
					else
						var_156_12 = true
					end

					var_6(var_156_11, var_156_12)

					setActive = var_6

					local var_156_13 = arg_156_0.progressTF

					ShipBluePrint = var_156_12

					local var_156_14

					if var_156_0 ~= var_156_12.TASK_STATE_ACHIEVED then
						ShipBluePrint = var_9

						if var_156_0 ~= var_9.TASK_STATE_START then
							ShipBluePrint = var_9

							if var_156_0 ~= var_9.TASK_STATE_FINISHED then
								ShipBluePrint = var_9

								if var_156_0 == var_9.TASK_STATE_PAUSE then
									var_156_14 = not var_156_3
								else
									var_156_14 = false
								end

								goto label_156_4
							end
						end
					end

					var_156_14 = true

					::label_156_4::

					var_6(var_156_13, var_156_14)

					setActive = var_6

					local var_156_15 = arg_156_0.lock

					ShipBluePrint = var_156_14

					local var_156_16

					if var_156_0 ~= var_156_14.TASK_STATE_LOCK then
						ShipBluePrint = var_9

						if var_156_0 ~= var_9.TASK_STATE_WAIT then
							var_156_16 = false

							goto label_156_5
						end
					end

					var_156_16 = true

					::label_156_5::

					var_6(var_156_15, var_156_16)

					setActive = var_6

					local var_156_17 = arg_156_0.working

					ShipBluePrint = var_156_16

					local var_156_18

					if var_156_0 ~= var_156_16.TASK_STATE_OPENING then
						ShipBluePrint = var_9

						if var_156_0 ~= var_9.TASK_STATE_START then
							ShipBluePrint = var_9

							if var_156_0 ~= var_9.TASK_STATE_ACHIEVED then
								var_156_18 = false

								goto label_156_6
							end
						end
					end

					var_156_18 = true

					::label_156_6::

					var_6(var_156_17, var_156_18)

					setActive = var_6

					local var_156_19 = arg_156_0.maskAchieved

					ShipBluePrint = var_156_18

					local var_156_20

					if var_156_0 ~= var_156_18.TASK_STATE_FINISHED then
						ShipBluePrint = var_9

						if var_156_0 == var_9.TASK_STATE_PAUSE then
							var_156_20 = var_156_2
						else
							var_156_20 = false
						end
					else
						var_156_20 = true
					end

					var_6(var_156_19, var_156_20)

					setActive = var_6

					local var_156_21 = arg_156_0.timerTF

					ShipBluePrint = var_156_20

					if var_156_0 ~= var_156_20.TASK_STATE_WAIT then
						ShipBluePrint = var_9

						if var_156_0 == var_9.TASK_STATE_PAUSE then
							local var_156_22

							if arg_156_1.leftTime then
								if not (arg_156_1.leftTime > 0) then
									var_156_22 = false

									goto label_156_7
								end

								var_156_22 = true
							end

							::label_156_7::

							var_6(var_156_21, var_156_22)

							setActive = var_6

							local var_156_23 = arg_156_0.check

							if arg_156_0.autoCommit then
								ShipBluePrint = var_9

								local var_156_24

								if var_156_0 ~= var_9.TASK_STATE_ACHIEVED then
									ShipBluePrint = var_9

									if var_156_0 ~= var_9.TASK_STATE_FINISHED then
										ShipBluePrint = var_9

										if var_156_0 == var_9.TASK_STATE_PAUSE then
											var_156_24 = var_156_2
										else
											var_156_24 = false
										end

										goto label_156_8
									end
								end

								var_156_24 = true

								::label_156_8::

								var_6(var_156_23, var_156_24)

								setActive = var_6

								local var_156_25 = arg_156_0.tip

								ShipBluePrint = var_156_24

								var_6(var_156_25, var_156_0 == var_156_24.TASK_STATE_ACHIEVED)

								setActive = var_6

								local var_156_26 = arg_156_0.timerOpen

								ShipBluePrint = var_9

								var_6(var_156_26, var_156_0 == var_9.TASK_STATE_WAIT)

								setActive = var_6

								local var_156_27 = arg_156_0.timerClose

								ShipBluePrint = var_9

								if var_156_0 == var_9.TASK_STATE_PAUSE then
									local var_156_28

									if arg_156_1.leftTime then
										if not (arg_156_1.leftTime > 0) then
											var_156_28 = false
										else
											var_156_28 = true
										end
									end

									var_6(var_156_27, var_156_28)

									return
								end
							end
						end
					end
				end
			end
		end
	end

	function var_2.updateProgress(arg_157_0, arg_157_1)
		local var_157_0 = arg_157_1.taskState
		local var_157_1 = arg_157_1
		local var_157_2 = arg_157_1.getProgress(var_157_1)
		local var_157_3 = arg_157_1
		local var_157_4 = var_157_2 / arg_157_1.getConfig(var_157_3, "target_num")

		ShipBluePrint = var_4

		if var_157_0 == var_4.TASK_STATE_WAIT then
			var_157_3 = arg_157_0

			arg_157_0.addTimer(var_157_3, arg_157_1, arg_157_1.dueTime)

			var_157_4 = 0
		else
			ShipBluePrint = var_4

			local var_157_5

			if var_157_0 == var_4.TASK_STATE_OPENING then
				var_157_4 = 0
				var_157_3 = arg_157_0.view
				var_157_5 = var_157_5.emit
				ShipBluePrintMediator = var_7

				var_157_5(var_157_3, var_7.ON_TASK_OPEN, arg_157_1.id)
			else
				ShipBluePrint = var_157_5

				if var_157_0 == var_157_5.TASK_STATE_PAUSE then
					var_157_3 = arg_157_1

					if arg_157_1.isReceive(var_157_3) then
						var_157_4 = 1
					end
				else
					ShipBluePrint = var_4

					if var_157_0 == var_4.TASK_STATE_LOCK then
						var_157_4 = 0
					else
						ShipBluePrint = var_4

						if var_157_0 == var_4.TASK_STATE_ACHIEVED then
							onButton = var_4
							var_157_3 = arg_157_0.view

							local var_157_6 = arg_157_0.commitBtn

							function var_2_10008()
								local var_158_0 = arg_157_0.view
								local var_158_1 = var_0.emit

								ShipBluePrintMediator = var_3_10003

								var_158_1(var_158_0, var_3_10003.ON_FINISH_TASK, arg_157_1.id)

								return
							end

							SFX_PANEL = var_2_10009

							var_4(var_157_3, var_157_6, var_2_10008, var_2_10009)

							var_157_4 = 1
						else
							ShipBluePrint = var_4

							if var_157_0 == var_4.TASK_STATE_FINISHED then
								var_157_4 = 1
							else
								ShipBluePrint = var_4

								if var_157_0 == var_4.TASK_STATE_START and not arg_157_0.autoCommit then
									onButton = var_4
									var_157_3 = arg_157_0.view

									local var_157_7 = arg_157_0.commitBtn

									function var_2_10008()
										local var_159_0 = arg_157_0.view
										local var_159_1 = var_0.emit

										ShipBluePrintMediator = var_3_10003

										var_159_1(var_159_0, var_3_10003.ON_FINISH_TASK, arg_157_1.id)

										return
									end

									SFX_PANEL = var_2_10009

									var_4(var_157_3, var_157_7, var_2_10008, var_2_10009)

									var_157_4 = 0
								end
							end
						end
					end
				end
			end
		end

		local var_157_8

		if 0 < var_157_4 then
			LeanTween = var_157_8
			var_157_8 = var_157_8.value
			go = var_157_3

			local var_157_9 = var_157_3(arg_157_0.progressTF)
			local var_157_10 = 0

			math = var_2_10008
			var_2_10008 = var_2_10008.min(var_157_4, 1)
			math = var_2_10009

			local var_157_11 = var_157_8(var_157_9, var_157_10, var_2_10008, 0.5 * var_2_10009.min(var_157_4, 1))

			var_157_8 = var_157_8.setOnUpdate
			System = var_157_10
			arg_157_0.itemSliderLT = var_157_8(var_157_11, var_157_10.Action_float(function(arg_160_0)
				arg_157_0.progessSlider.value = arg_160_0

				return
			end)).uniqueId
		else
			var_157_8 = arg_157_0.progessSlider
			var_157_8.value = var_157_4
		end

		math = var_157_8

		local var_157_12 = var_157_8.floor(var_157_4 * 100)

		setText = var_157_1

		local var_157_13 = arg_157_0.progres

		math = var_2_10008

		local var_157_14 = var_2_10008.ceil

		math = var_2_10010

		var_157_1(var_157_13, var_157_14(var_2_10010.min(var_157_12, 100)) .. "%")

		setText = var_157_1

		local var_157_15 = arg_157_0.progreshadow

		math = var_8

		var_157_1(var_157_15, var_8.min(var_157_12, 100) .. "%")

		return
	end

	function var_2.addTimer(arg_161_0, arg_161_1, arg_161_2)
		arg_161_0:clearTimer()

		Timer = var_3
		arg_161_0.taskTimer = var_3.New(function()
			pg = var_3_10000

			local var_162_0 = var_3_10000.TimeMgr.GetInstance()
			local var_162_1 = var_0.GetServerTime(var_162_0)
			local var_162_2 = arg_161_2 - var_162_1

			if 0 < var_162_2 then
				setText = var_2

				local var_162_3 = arg_161_0.timerTFTxt

				pg = var_3_10005

				local var_162_4 = var_3_10005.TimeMgr.GetInstance()

				var_2(var_162_3, var_5.DescCDTime(var_162_4, var_162_2))
			else
				local var_162_5 = arg_161_0

				var_2.clearTimer(var_162_5)

				setText = var_2

				var_2(arg_161_0.timerTFTxt, "00:00:00")

				local var_162_6 = arg_161_0.view
				local var_162_7 = var_2.emit

				ShipBluePrintMediator = var_5

				var_162_7(var_162_6, var_5.ON_TASK_OPEN, arg_161_1.id)
			end

			return
		end, 1, -1)

		local var_161_0 = arg_161_0.taskTimer

		var_3.Start(var_161_0)
		arg_161_0.taskTimer.func()

		return
	end

	function var_2.clearTimer(arg_163_0)
		if arg_163_0.taskTimer then
			local var_163_0 = arg_163_0.taskTimer

			var_1.Stop(var_163_0)

			arg_163_0.taskTimer = nil
		end

		return
	end

	function var_2.clear(arg_164_0)
		arg_164_0:clearTimer()

		if arg_164_0.itemSliderLT then
			LeanTween = var_1

			var_1.cancel(arg_164_0.itemSliderLT)

			arg_164_0.itemSliderLT = nil
		end

		return
	end

	return var_2
end

function var_0_1.openPreView(arg_165_0)
	if arg_165_0.contextData.shipBluePrintVO then
		setActive = var_1_10002

		var_1_10002(arg_165_0.preViewer, true)

		pg = var_1_10002

		local var_165_0 = var_1_10002.UIMgr.GetInstance()

		var_2.BlurPanel(var_165_0, arg_165_0.preViewer)
		arg_165_0:playLoadingAni()

		arg_165_0.viewShipVO = var_1:getShipVO()
		arg_165_0.breakIds = arg_165_0:getStages(arg_165_0.viewShipVO)

		for iter_165_0 = 1, var_0_5 do
			local var_165_1 = arg_165_0.breakIds[iter_165_0]
			local var_165_2 = var_0_4[var_165_1]
			local var_165_3 = arg_165_0.stages
			local var_165_4 = var_8.Find(var_165_3, "stage" .. iter_165_0)

			onToggle = var_1_10009

			local var_165_5 = arg_165_0
			local var_165_6 = var_165_4

			local function var_165_7(arg_166_0)
				if arg_166_0 then
					PLATFORM_CODE = var_2_10001
					PLATFORM_US = var_2_10002

					if var_2_10001 == var_2_10002 then
						changeToScrollText = var_2_10001

						var_2_10001(arg_165_0.breakView, var_0_4[var_165_1].breakout_view)
					else
						setText = var_2_10001

						var_2_10001(arg_165_0.breakView, var_0_4[var_165_1].breakout_view)
					end

					local var_166_0 = arg_165_0

					var_1.switchStage(var_166_0, var_165_1)
				end

				return
			end

			SFX_PANEL = var_1_10014

			var_1_10009(var_165_5, var_165_6, var_165_7, var_1_10014)

			if iter_165_0 == 1 then
				triggerToggle = var_1_10009

				var_1_10009(var_165_4, true)
			end
		end

		arg_165_0.isShowPreview = true

		arg_165_0:updateMaxLevelAttrs(var_1)
	end

	return
end

local var_0_11 = {}

AttributeType = var_0_10011
var_0_11[1] = var_0_10011.Durability
AttributeType = var_11
var_0_11[2] = var_11.Cannon
AttributeType = var_11
var_0_11[3] = var_11.Torpedo
AttributeType = var_11
var_0_11[4] = var_11.AntiAircraft
AttributeType = var_11
var_0_11[5] = var_11.Air
AttributeType = var_11
var_0_11[6] = var_11.Reload
AttributeType = var_11
var_0_11[7] = var_11.ArmorType
AttributeType = var_11
var_0_11[8] = var_11.Dodge
var_0_1.MAX_LEVEL_ATTRS = var_0_11

function var_0_1.updateMaxLevelAttrs(arg_167_0, arg_167_1)
	if not arg_167_1:isFetched() then
		return
	end

	local var_167_0 = arg_167_0.shipVOs[arg_167_1.shipId]

	Clone = var_3

	local var_167_1 = var_3(var_167_0)

	var_167_1.level = 125
	Clone = var_4

	local var_167_2 = var_4(arg_167_1)

	var_167_2.level = arg_167_1:getMaxLevel()
	intProperties = var_5

	local var_167_3 = var_5(var_167_2:getShipProperties(var_167_1, false))

	ipairs = var_6

	for iter_167_0, iter_167_1 in var_6(var_0_1.MAX_LEVEL_ATTRS) do
		local var_167_4 = arg_167_0.previewAttrContainer
		local var_167_5 = var_11.Find(var_167_4, iter_167_1)

		AttributeType = var_1_10012

		if iter_167_1 == var_1_10012.ArmorType then
			setText = var_1_10012

			var_1_10012(var_167_5:Find("bg/value"), var_167_0:getShipArmorName())
		else
			setText = var_1_10012

			local var_167_6 = var_167_5:Find("bg/value")

			if not var_167_3[iter_167_1] then
				var_1_10015 = 0
			end

			var_1_10012(var_167_6, var_1_10015)
		end

		setText = var_1_10012

		local var_167_7 = var_167_5:Find("bg/name")

		AttributeType = var_1_10015

		var_1_10012(var_167_7, var_1_10015.Type2Name(iter_167_1))
	end

	return
end

function var_0_1.closePreview(arg_168_0, arg_168_1)
	if arg_168_0.previewer then
		local var_168_0 = arg_168_0.previewer

		var_2.clear(var_168_0)

		arg_168_0.previewer = nil
	end

	setActive = var_2

	var_2(arg_168_0.preViewer, false)

	setActive = var_2

	var_2(arg_168_0.rawImage, false)

	pg = var_2

	local var_168_1 = var_2.UIMgr.GetInstance()

	var_2.UnOverlayPanel(var_168_1, arg_168_0.preViewer, arg_168_0._tf)

	arg_168_0.isShowPreview = nil

	return
end

function var_0_1.playLoadingAni(arg_169_0)
	setActive = var_1_10001

	var_1_10001(arg_169_0.seaLoading, true)

	return
end

function var_0_1.stopLoadingAni(arg_170_0)
	setActive = var_1_10001

	var_1_10001(arg_170_0.seaLoading, false)

	return
end

function var_0_1.showBarrage(arg_171_0)
	WeaponPreviewer = var_1_10001
	arg_171_0.previewer = var_1_10001.New(arg_171_0.rawImage)

	local var_171_0 = arg_171_0.previewer

	var_1.configUI(var_171_0, arg_171_0.healTF)

	local var_171_1 = arg_171_0.previewer

	var_1.setDisplayWeapon(var_171_1, arg_171_0:getWaponIdsById(arg_171_0.breakOutId))

	local var_171_2 = arg_171_0.previewer

	var_1.load(var_171_2, 40000, arg_171_0.viewShipVO, arg_171_0:getAllWeaponIds(), function()
		local var_172_0 = arg_171_0

		var_0.stopLoadingAni(var_172_0)

		return
	end)

	return
end

function var_0_1.getWaponIdsById(arg_173_0, arg_173_1)
	return var_0_4[arg_173_1].weapon_ids
end

function var_0_1.getAllWeaponIds(arg_174_0)
	local var_174_0 = {}

	ipairs = var_1_10002

	for iter_174_0, iter_174_1 in var_1_10002(arg_174_0.breakIds) do
		Clone = var_1_10007
		var_1_10007 = var_1_10007(var_0_4[iter_174_1].weapon_ids)

		local var_174_1 = {
			__add = function(arg_175_0, arg_175_1)
				ipairs = var_2_10002

				for iter_175_0, iter_175_1 in var_2_10002(arg_175_0) do
					table = var_2_10007

					if not var_2_10007.contains(arg_175_1, iter_175_1) then
						table = var_2_10007

						var_2_10007.insert(arg_175_1, iter_175_1)
					end
				end

				return arg_175_1
			end
		}

		setmetatable = var_9

		var_9(var_174_0, var_174_1)

		var_174_0 = var_174_0 + var_1_10007
	end

	return var_174_0
end

function var_0_1.getStages(arg_176_0, arg_176_1)
	local var_176_0 = {}

	math = var_1_10003

	local var_176_1 = var_1_10003.floor(arg_176_1.configId / 10)

	for iter_176_0 = 1, 4 do
		tonumber = var_1_10008
		var_1_10008 = var_1_10008(var_176_1 .. iter_176_0)
		assert = var_1_10009

		var_1_10009(var_0_4[var_1_10008], "必须存在配置" .. var_1_10008)

		table = var_1_10009

		var_1_10009.insert(var_176_0, var_1_10008)
	end

	return var_176_0
end

function var_0_1.switchStage(arg_177_0, arg_177_1)
	if arg_177_0.breakOutId == arg_177_1 then
		return
	end

	arg_177_0.breakOutId = arg_177_1

	if arg_177_0.previewer then
		local var_177_0 = arg_177_0.previewer

		var_2.setDisplayWeapon(var_177_0, arg_177_0:getWaponIdsById(arg_177_0.breakOutId))
	end

	return
end

function var_0_1.clearTimers(arg_178_0)
	pairs = var_1_10001

	local var_178_0

	if not arg_178_0.taskTFs then
		var_178_0 = {}
	end

	for iter_178_0, iter_178_1 in var_1_10001(var_178_0) do
		iter_178_1:clear()
	end

	return
end

function var_0_1.cloneTplTo(arg_179_0, arg_179_1, arg_179_2)
	tf = var_1_10003
	Instantiate = var_1_10005

	local var_179_0 = var_1_10003(var_1_10005(arg_179_1))

	SetActive = var_1_10004

	var_1_10004(var_179_0, true)

	local var_179_1 = var_179_0
	local var_179_2 = var_179_0.SetParent

	tf = var_7

	var_179_2(var_179_1, var_7(arg_179_2), false)

	return var_179_0
end

function var_0_1.onBackPressed(arg_180_0)
	isActive = var_1_10001

	if var_1_10001(arg_180_0.msgPanel) then
		pg = var_1

		local var_180_0 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_180_0, arg_180_0.msgPanel, arg_180_0.top)

		setActive = var_1

		var_1(arg_180_0.msgPanel, false)
	else
		isActive = var_1

		if var_1(arg_180_0.unlockPanel) then
			pg = var_1

			local var_180_1 = var_1.UIMgr.GetInstance()

			var_1.UnOverlayPanel(var_180_1, arg_180_0.unlockPanel, arg_180_0.top)

			setActive = var_1

			var_1(arg_180_0.unlockPanel, false)
		else
			isActive = var_1

			if var_1(arg_180_0.versionPanel) then
				triggerButton = var_1

				local var_180_2 = arg_180_0.versionPanel

				var_1(var_3.Find(var_180_2, "bg"))
			elseif arg_180_0.isShowPreview then
				arg_180_0:closePreview(true)
			else
				local var_180_3 = arg_180_0.svQuickExchange

				if var_1.isShowing(var_180_3) then
					local var_180_4 = arg_180_0.svQuickExchange

					var_1.Hide(var_180_4)
				elseif arg_180_0.awakenPlay or arg_180_0:inModAnim() then
					-- block empty
				else
					arg_180_0:emit(var_0_1.ON_BACK_PRESSED)
				end
			end
		end
	end

	return
end

function var_0_1.willExit(arg_181_0)
	isActive = var_1_10001

	if var_1_10001(arg_181_0.msgPanel) then
		pg = var_1

		local var_181_0 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_181_0, arg_181_0.msgPanel, arg_181_0.top)

		setActive = var_1

		var_1(arg_181_0.msgPanel, false)
	end

	isActive = var_1

	if var_1(arg_181_0.unlockPanel) then
		pg = var_1

		local var_181_1 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_181_1, arg_181_0.unlockPanel, arg_181_0.top)

		setActive = var_1

		var_1(arg_181_0.unlockPanel, false)
	end

	local var_181_2 = arg_181_0

	arg_181_0.UnOverlayPanel(var_181_2, arg_181_0.blurPanel, arg_181_0._tf)

	LeanTween = var_1

	local var_181_3 = var_1.cancel

	go = var_181_2

	var_181_3(var_181_2(arg_181_0.fittingAttrPanel))

	if arg_181_0.lastPaintingName then
		retPaintingPrefab = var_1

		var_1(arg_181_0.painting, arg_181_0.lastPaintingName)
	end

	pairs = var_1

	local var_181_4

	if not arg_181_0.taskTFs then
		var_181_4 = {}
	end

	for iter_181_0, iter_181_1 in var_1(var_181_4) do
		iter_181_1:clear()
	end

	arg_181_0:closePreview(true)
	arg_181_0:clearLeanTween(true)

	if arg_181_0.previewer then
		local var_181_5 = arg_181_0.previewer

		var_1.clear(var_181_5)

		arg_181_0.previewer = nil
	end

	if arg_181_0.cbTimer then
		local var_181_6 = arg_181_0.cbTimer

		var_1.Stop(var_181_6)

		arg_181_0.cbTimer = nil
	end

	local var_181_7 = arg_181_0.svQuickExchange

	if var_1.isShowing(var_181_7) then
		local var_181_8 = arg_181_0.svQuickExchange

		var_1.Hide(var_181_8)
	end

	local var_181_9 = arg_181_0.svQuickExchange

	var_1.Destroy(var_181_9)

	return
end

function var_0_1.paintBreath(arg_182_0)
	LeanTween = var_1_10001

	local var_182_0 = var_1_10001.cancel

	go = var_1_10003

	var_182_0(var_1_10003(arg_182_0.painting))

	LeanTween = var_182_0

	local var_182_1 = var_182_0.moveY

	rtf = var_3

	local var_182_2 = var_182_1(var_3(arg_182_0.painting), var_0_6, var_0_7)
	local var_182_3 = var_1.setLoopPingPong(var_182_2)
	local var_182_4 = var_1.setEase

	LeanTweenType = var_4

	local var_182_5 = var_182_4(var_182_3, var_4.easeInOutCubic)

	var_1.setFrom(var_182_5, 0)

	return
end

function var_0_1.buildStartAni(arg_183_0, arg_183_1, arg_183_2)
	if arg_183_1 == "researchStartWindow" then
		local var_183_0 = arg_183_0.progressPanel

		Vector3 = var_1_10004
		var_183_0.localScale = var_1_10004(0, 1, 1)
		LeanTween = var_183_0

		local var_183_1 = var_183_0.scale

		var_1_10005 = arg_183_0.progressPanel
		Vector3 = var_6
		var_1_10005 = var_183_1(var_1_10005, var_6(1, 1, 1), 0.2)

		var_3.setDelay(var_1_10005, 2)
	end

	local function var_183_2()
		local var_184_0 = arg_183_0.awakenAni

		var_0.SetActive(var_184_0, true)

		local var_184_1 = arg_183_0

		var_184_1.awakenPlay = true
		tf = var_184_1

		local var_184_2 = var_184_1(arg_183_0.awakenAni)

		pg = var_1

		local var_184_3 = var_1.UIMgr.GetInstance()

		var_1.BlurPanel(var_184_3, var_184_2)
		var_184_2:SetAsLastSibling()

		local var_184_4 = var_184_2:GetComponent("DftAniEvent")

		var_1.SetEndEvent(var_184_4, function(arg_185_0)
			IsNil = var_3_10001

			if not var_3_10001(arg_183_0.awakenAni) then
				pg = var_1

				local var_185_0 = var_1.UIMgr.GetInstance()

				var_1.UnOverlayPanel(var_185_0, var_184_2, arg_183_0.blurPanel)

				local var_185_1 = arg_183_0.awakenAni

				var_1.SetActive(var_185_1, false)

				arg_183_0.awakenPlay = false

				if arg_183_2 then
					arg_183_2()
				end
			end

			return
		end)

		return
	end

	local var_183_3 = arg_183_0._tf

	if var_4.Find(var_183_3, arg_183_1 .. "(Clone)") then
		::label_183_0::

		go = var_1_10005
		var_1_10005 = var_1_10005(var_4)
	end

	arg_183_0.awakenAni = var_1_10005

	if not arg_183_0.awakenAni then
		PoolMgr = var_5

		local var_183_4 = var_5.GetInstance()

		var_5.GetUI(var_183_4, arg_183_1, true, function(arg_186_0)
			arg_186_0:SetActive(true)

			arg_183_0.awakenAni = arg_186_0

			var_183_2()

			return
		end)
	else
		var_183_2()
	end

	return
end

function var_0_1.showFittingMsgPanel(arg_187_0, arg_187_1)
	pg = var_1_10002

	local var_187_0 = var_1_10002.UIMgr.GetInstance()

	var_2.BlurPanel(var_187_0, arg_187_0.msgPanel)

	setActive = var_2

	var_2(arg_187_0.msgPanel, true)

	local var_187_1 = arg_187_0.contextData.shipBluePrintVO
	local var_187_2 = var_2.getMaxFateLevel(var_187_1)
	local var_187_3 = arg_187_0.msgPanel
	local var_187_4 = var_4.Find(var_187_3, "window/content")
	local var_187_5 = var_4.Find(var_187_4, "pre_btn")
	local var_187_6 = var_4:Find("next_btn")
	local var_187_7 = var_4:Find("attrl_panel")
	local var_187_8 = var_4:Find("skill_panel")
	local var_187_9 = var_4:Find("phase")
	local var_187_10 = {
		"I",
		"II",
		"III",
		"IV",
		"V"
	}

	local function var_187_11()
		setActive = var_2_10000

		var_2_10000(var_187_5, arg_187_1 > 1)

		setActive = var_2_10000

		var_2_10000(var_187_6, arg_187_1 < var_187_2)

		setText = var_2_10000

		var_2_10000(var_187_9, "PHASE." .. var_187_10[arg_187_1])

		local var_188_0 = var_0
		local var_188_1 = var_0.getFateStrengthenConfig(var_188_0, arg_187_1)

		assert = var_2_10001

		if var_188_1.special == 1 then
			type = var_3

			local var_188_2

			if var_3(var_188_1.special_effect) ~= "table" then
				var_188_2 = false
			else
				var_188_2 = true
			end

			var_2_10001(var_188_2, "without fate config")

			local var_188_3 = var_188_1.special_effect
			local var_188_4
			local var_188_5 = {}

			ipairs = var_4

			for iter_188_0, iter_188_1 in var_4(var_188_3) do
				local var_188_6 = iter_188_1[1]

				ShipBluePrint = var_2_10010

				if var_188_6 == var_2_10010.STRENGTHEN_TYPE_CHANGE_SKILL then
					var_188_4 = iter_188_1[2][2]
				else
					ShipBluePrint = var_2_10010

					if var_188_6 == var_2_10010.STRENGTHEN_TYPE_ATTR then
						table = var_2_10010

						var_2_10010.insert(var_188_5, iter_188_1[2])
					end
				end
			end

			setActive = var_4

			var_4(var_187_7, #var_188_5 > 0)

			setActive = var_4

			var_4(var_187_8, var_188_4)

			if var_188_4 then
				getSkillConfig = var_4

				local var_188_7 = var_4(var_188_4)

				GetImageSpriteFromAtlasAsync = var_5

				local var_188_8 = "skillicon/" .. var_188_7.icon
				local var_188_9 = ""
				local var_188_10 = var_187_8

				var_5(var_188_8, var_188_9, var_9.Find(var_188_10, "skill_icon"))

				setText = var_5

				local var_188_11 = var_187_8
				local var_188_12 = var_7.Find(var_188_11, "skill_name")

				getSkillName = var_188_9

				var_5(var_188_12, var_188_9(var_188_4))

				local var_188_13 = 1

				setText = var_6
				var_2_10010 = var_187_8

				var_6(var_8.Find(var_2_10010, "skill_lv"), "Lv." .. var_188_13)

				setText = var_6
				var_2_10010 = var_187_8

				local var_188_14 = var_8.Find(var_2_10010, "help_panel/skill_intro")

				getSkillDescGet = var_9

				var_6(var_188_14, var_9(var_188_4))
			end

			if #var_188_5 > 0 then
				ipairs = var_4

				for iter_188_2, iter_188_3 in var_4(var_188_5) do
					if iter_188_2 < var_187_7.childCount then
						local var_188_15 = var_187_7
						local var_188_16

						if not var_188_16.GetChild(var_188_15, iter_188_2) then
							cloneTplTo = var_188_16
							var_2_10013 = var_187_7
							var_188_16 = var_188_16(var_11.GetChild(var_2_10013, iter_188_2 - 1), var_187_7)
						end

						setText = var_2_10010

						local var_188_17 = var_188_16:Find("name")

						AttributeType = var_2_10013

						var_2_10010(var_188_17, var_2_10013.Type2Name(iter_188_3[1]))

						setText = var_2_10010

						var_2_10010(var_188_16:Find("number"), " + " .. iter_188_3[2])
					end
				end

				for iter_188_4 = #var_188_5 + 1, var_187_7.childCount - 1 do
					setActive = iter_188_3

					local var_188_18 = var_187_7

					iter_188_3(var_10.GetChild(var_188_18, iter_188_4), false)
				end
			end

			return
		end
	end

	onButton = var_12

	var_12(arg_187_0, var_187_5, function()
		arg_187_1 = arg_187_1 - 1

		var_187_11()

		return
	end)

	onButton = var_12

	var_12(arg_187_0, var_187_6, function()
		arg_187_1 = arg_187_1 + 1

		var_187_11()

		return
	end)

	setText = var_12

	local var_187_12 = var_187_7:Find("desc")

	i18n = var_15

	var_12(var_187_12, var_15("fate_attr_word"))
	var_187_11()

	return
end

function var_0_1.showUnlockPanel(arg_191_0)
	pg = var_1_10001

	local var_191_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_191_0, arg_191_0.unlockPanel)

	setActive = var_1

	var_1(arg_191_0.unlockPanel, true)

	local var_191_1 = arg_191_0.contextData.shipBluePrintVO.id
	local var_191_2 = arg_191_0.contextData.shipBluePrintVO
	local var_191_3 = var_2.getUnlockItem(var_191_2)

	Drop = var_3

	local var_191_4 = var_3.New
	local var_191_5 = {}

	DROP_TYPE_ITEM = var_1_10006
	var_191_5.type = var_1_10006
	var_191_5.id = var_191_3

	local var_191_6 = var_191_4(var_191_5)
	local var_191_7 = arg_191_0.contextData.shipBluePrintVO
	local var_191_8 = var_4.getShipVO(var_191_7)
	local var_191_9 = var_4.getPainting(var_191_8)
	local var_191_10 = arg_191_0.unlockPanel
	local var_191_11 = var_6.Find(var_191_10, "window/content")

	GetImageSpriteFromAtlasAsync = var_191_8

	var_191_8("shipYardIcon/" .. var_191_9, var_191_9, var_191_11:Find("Image/mask/icon"), true)

	setText = var_191_8

	local var_191_12 = var_191_11:Find("words/Text")

	i18n = var_10

	var_191_8(var_191_12, var_10("techpackage_item_use_1", var_4:getName()))

	setText = var_191_8

	local var_191_13 = var_191_11:Find("words/Text_2")

	i18n = var_10

	var_191_8(var_191_13, var_10("techpackage_item_use_2", var_191_6:getName()))

	GetImageSpriteFromAtlasAsync = var_191_8

	local var_191_14 = var_191_6:getIcon()
	local var_191_15 = ""
	local var_191_16 = arg_191_0.unlockPanel

	var_191_8(var_191_14, var_191_15, var_11.Find(var_191_16, "window/confirm_btn/Image/Image"))

	setText = var_191_8

	local var_191_17 = arg_191_0.unlockPanel
	local var_191_18 = var_9.Find(var_191_17, "window/confirm_btn/Image/Text")

	i18n = var_191_15

	var_191_8(var_191_18, var_191_15("event_ui_consume"))

	onButton = var_191_8

	local var_191_19 = arg_191_0
	local var_191_20 = arg_191_0.unlockPanel
	local var_191_21 = var_10.Find(var_191_20, "window/confirm_btn")

	local function var_191_22()
		pg = var_2_10000

		local var_192_0 = var_2_10000.UIMgr.GetInstance()

		var_0.UnOverlayPanel(var_192_0, arg_191_0.unlockPanel, arg_191_0.top)

		setActive = var_0

		var_0(arg_191_0.unlockPanel, false)

		local var_192_1 = arg_191_0
		local var_192_2 = var_0.emit

		ShipBluePrintMediator = var_3

		var_192_2(var_192_1, var_3.ON_ITEM_UNLOCK, var_191_1, var_191_3)

		return
	end

	SFX_CANCEL = var_191_20

	var_191_8(var_191_19, var_191_21, var_191_22, var_191_20)

	return
end

function var_0_1.checkStory(arg_193_0)
	local var_193_0 = {
		nil,
		"FANGAN3"
	}
	local var_193_1

	if not arg_193_0.storyMgr then
		pg = var_193_1
		var_193_1 = var_193_1.NewStoryMgr.GetInstance()
	end

	arg_193_0.storyMgr = var_193_1

	if var_193_0[arg_193_0.version] then
		local var_193_2 = arg_193_0.storyMgr

		if not var_2.IsPlayed(var_193_2, var_193_0[arg_193_0.version]) then
			local var_193_3 = arg_193_0.storyMgr

			var_2.Play(var_193_3, var_193_0[arg_193_0.version])
		end
	end

	return
end

function var_0_1.changeEffectVisible(arg_194_0, arg_194_1)
	setActive = var_1_10002

	var_1_10002(arg_194_0.fittingBtn, arg_194_1)

	setActive = var_1_10002

	var_1_10002(arg_194_0.initPanel, arg_194_1)

	return
end

return var_0_1
