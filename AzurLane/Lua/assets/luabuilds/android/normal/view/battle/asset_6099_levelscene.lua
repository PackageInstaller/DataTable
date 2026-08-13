class = var_0_10000

local var_0_0 = "LevelScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))
local var_0_2 = 0.5
local var_0_3 = 1
local var_0_4 = 2
local var_0_5 = 3

function var_0_1.forceGC(arg_1_0)
	return true
end

function var_0_1.getUIName(arg_2_0)
	return "LevelMainScene"
end

function var_0_1.ResUISettings(arg_3_0)
	local var_3_0 = {
		groupDelta = 1
	}

	PlayerResUI = var_1_10002
	var_3_0.showType = var_1_10002.TYPE_ALL

	return var_3_0
end

function var_0_1.getBGM(arg_4_0)
	local function var_4_0()
		checkExist = var_2_10000

		local var_5_0

		if not var_2_10000(arg_4_0.contextData.chapterVO, {
			"getConfig",
			{
				"bgm"
			}
		}) then
			var_5_0 = ""
		end

		return var_5_0
	end

	local function var_4_1()
		if not arg_4_0.contextData.map then
			return
		end

		local var_6_0 = arg_4_0.contextData.map
		local var_6_1 = var_0.getConfig(var_6_0, "ani_controller")

		getProxy = var_6_0
		ChapterProxy = var_3

		local var_6_2 = var_6_0(var_3)

		if var_6_1 and #var_6_1 > 0 then
			ipairs = var_3

			for iter_6_0, iter_6_1 in var_3(var_6_1) do
				_ = var_2_10008
				var_2_10008 = var_2_10008.rest(iter_6_1[2], 2)
				ipairs = var_9

				for iter_6_2, iter_6_3 in var_9(var_2_10008) do
					string = var_2_10014

					if var_2_10014.find(iter_6_3, "^bgm_") and iter_6_1[1] == var_0_4 then
						var_2_10014 = iter_6_1[2][1]

						local var_6_3 = false

						ipairs = var_16

						for iter_6_4, iter_6_5 in var_16(var_2_10014) do
							if var_6_2:GetChapterItemById(iter_6_5) and var_21:isClear() then
								var_6_3 = true

								break
							end
						end

						if not var_6_3 then
							string = var_16

							return var_16.sub(iter_6_3, 5)
						end
					end
				end
			end
		end

		checkExist = var_3

		local var_6_4

		if not var_3(arg_4_0.contextData.map, {
			"getConfig",
			{
				"bgm"
			}
		}) then
			var_6_4 = ""
		end

		return var_6_4
	end

	ipairs = var_1_10003

	for iter_4_0, iter_4_1 in var_1_10003({
		var_4_0(),
		var_4_1()
	}) do
		if iter_4_1 ~= "" then
			return iter_4_1
		end
	end

	return var_0_1.super.getBGM(arg_4_0)
end

var_0_1.optionsPath = {
	"top/top_chapter/option"
}

function var_0_1.preload(arg_7_0, arg_7_1)
	getProxy = var_1_10002
	ChapterProxy = var_1_10003

	local var_7_0 = var_1_10002(var_1_10003)

	if arg_7_0.contextData.mapIdx and arg_7_0.contextData.chapterId then
		local var_7_1 = var_7_0:getChapterById(arg_7_0.contextData.chapterId)

		if var_3.getConfig(var_7_1, "map") == arg_7_0.contextData.mapIdx then
			arg_7_0.contextData.chapterVO = var_3

			if var_3.active then
				assert = var_4

				var_4(not arg_7_0.contextData.openChapterId or arg_7_0.contextData.openChapterId == arg_7_0.contextData.chapterId)

				arg_7_0.contextData.openChapterId = nil
			end
		end
	end

	local var_7_2, var_7_3 = arg_7_0:GetInitializeMap()

	if arg_7_0.contextData.entranceStatus == nil then
		arg_7_0.contextData.entranceStatus = not var_7_3
	end

	if not arg_7_0.contextData.entranceStatus then
		arg_7_0:PreloadLevelMainUI(var_7_2, arg_7_1)
	else
		arg_7_1()
	end

	return
end

function var_0_1.GetInitializeMap(arg_8_0)
	if (function()
		if arg_8_0.contextData.chapterVO and var_0.active then
			return var_0:getConfig("map")
		end

		if arg_8_0.contextData.mapIdx then
			return var_1
		end

		local var_9_0

		if arg_8_0.contextData.targetChapter and arg_8_0.contextData.targetMap then
			arg_8_0.contextData.openChapterId = arg_8_0.contextData.targetChapter
			var_9_0 = arg_8_0.contextData.targetMap.id
			arg_8_0.contextData.targetChapter = nil
			arg_8_0.contextData.targetMap = nil
		elseif arg_8_0.contextData.eliteDefault then
			getProxy = var_3
			ChapterProxy = var_2_10004

			local var_9_1 = var_3(var_2_10004)

			var_9_0 = var_3.getUseableMaxEliteMap(var_9_1) and var_3.id or nil
			arg_8_0.contextData.eliteDefault = nil
		end

		return var_9_0
	end)() then
		::label_8_0::

		getProxy = var_1_10003
		ChapterProxy = var_1_10004
		var_1_10004 = var_1_10003(var_1_10004)
		var_1_10003 = var_1_10003.getMapById(var_1_10004, var_8_2)
	end

	local var_8_2

	if var_1_10003 then
		var_1_10005 = var_1_10003
		var_1_10004, var_1_10005 = var_1_10003.isUnlock(var_1_10005)

		if not var_1_10004 then
			pg = var_1_10006

			local var_8_0 = var_1_10006.TipsMgr.GetInstance()

			var_6.ShowTips(var_8_0, var_1_10005)

			getProxy = var_6
			ChapterProxy = var_8_0

			local var_8_1 = var_6(var_8_0)

			var_8_2 = var_6.getLastUnlockMap(var_8_1).id
			arg_8_0.contextData.mapIdx = var_8_2
		end
	else
		var_8_2 = nil
	end

	if not var_8_2 then
		::label_8_1::

		getProxy = var_1_10004
		ChapterProxy = var_1_10005
		var_1_10005 = var_1_10004(var_1_10005)

		local var_8_3 = var_4.GetLastNormalMap(var_1_10005)
	end

	tobool = var_1_10005

	local var_8_4 = var_1_10005(var_8_2)
end

function var_0_1.init(arg_10_0)
	arg_10_0:initData()
	arg_10_0:initUI()
	arg_10_0:initEvents()
	arg_10_0:updateClouds()

	return
end

function var_0_1.initData(arg_11_0)
	arg_11_0.tweens = {}
	arg_11_0.mapWidth, arg_11_0.mapHeight = arg_11_0._tf.rect.size.x, var_1.y
	arg_11_0.levelCamIndices = 1
	arg_11_0.frozenCount = 0
	arg_11_0.currentBG = nil
	arg_11_0.mbDict = {}
	arg_11_0.mapGroup = {}

	if not arg_11_0.contextData.huntingRangeVisibility then
		arg_11_0.contextData.huntingRangeVisibility = 2
	end

	return
end

function var_0_1.initUI(arg_12_0)
	local var_12_0 = arg_12_0._tf

	arg_12_0.topPanel = var_1.Find(var_12_0, "top")

	local var_12_1 = arg_12_0.topPanel

	arg_12_0.canvasGroup = var_1.GetComponent(var_12_1, "CanvasGroup")
	arg_12_0.canvasGroup.blocksRaycasts = not arg_12_0.canvasGroup.blocksRaycasts
	arg_12_0.canvasGroup.blocksRaycasts = not arg_12_0.canvasGroup.blocksRaycasts

	local var_12_2 = arg_12_0._tf

	arg_12_0.entranceLayer = var_1.Find(var_12_2, "entrance")
	EventPtBonus = var_1

	local var_12_3 = var_1.New
	local var_12_4 = arg_12_0.entranceLayer

	arg_12_0.ptBonus = var_12_3(var_2.Find(var_12_4, "btns/btn_task/bonusPt"))

	local var_12_5 = arg_12_0._tf

	arg_12_0.entranceBg = var_1.Find(var_12_5, "entrance_bg")

	local var_12_6 = arg_12_0.topPanel

	arg_12_0.topChapter = var_1.Find(var_12_6, "top_chapter")
	setActive = var_1

	local var_12_7 = arg_12_0.topChapter

	var_1(var_2.Find(var_12_7, "title_chapter"), false)

	setActive = var_1

	local var_12_8 = arg_12_0.topChapter

	var_1(var_2.Find(var_12_8, "type_chapter"), false)

	setActive = var_1

	local var_12_9 = arg_12_0.topChapter

	var_1(var_2.Find(var_12_9, "type_escort"), false)

	setActive = var_1

	local var_12_10 = arg_12_0.topChapter

	var_1(var_2.Find(var_12_10, "type_skirmish"), false)

	local var_12_11 = arg_12_0.topChapter

	arg_12_0.chapterName = var_1.Find(var_12_11, "title_chapter/name")

	local var_12_12 = arg_12_0.topChapter

	arg_12_0.chapterNoTitle = var_1.Find(var_12_12, "title_chapter/chapter")

	local var_12_13 = arg_12_0.topChapter

	arg_12_0.resChapter = var_1.Find(var_12_13, "resources")
	setActive = var_1

	var_1(arg_12_0.topChapter, true)

	local var_12_14 = arg_12_0.topChapter

	arg_12_0._voteBookBtn = var_1.Find(var_12_14, "vote_book")

	local var_12_15 = arg_12_0._tf

	arg_12_0.leftChapter = var_1.Find(var_12_15, "main/left_chapter")
	setActive = var_1

	var_1(arg_12_0.leftChapter, true)

	local var_12_16 = arg_12_0.leftChapter
	local var_12_17 = var_1.GetComponent

	typeof = var_3
	CanvasGroup = var_4
	arg_12_0.leftCanvasGroup = var_12_17(var_12_16, var_3(var_4))

	local var_12_18 = arg_12_0.leftChapter

	arg_12_0.btnPrev = var_1.Find(var_12_18, "btn_prev")

	local var_12_19 = arg_12_0.leftChapter

	arg_12_0.btnPrevCol = var_1.Find(var_12_19, "btn_prev/prev_image")

	local var_12_20 = arg_12_0.leftChapter

	arg_12_0.eliteBtn = var_1.Find(var_12_20, "buttons/btn_elite")

	local var_12_21 = arg_12_0.leftChapter

	arg_12_0.normalBtn = var_1.Find(var_12_21, "buttons/btn_normal")

	local var_12_22 = arg_12_0.leftChapter

	arg_12_0.actNormalBtn = var_1.Find(var_12_22, "buttons/btn_act_normal")

	local var_12_23 = arg_12_0.leftChapter

	arg_12_0.actEliteBtn = var_1.Find(var_12_23, "buttons/btn_act_elite")

	local var_12_24 = arg_12_0.leftChapter

	arg_12_0.actExtraBtn = var_1.Find(var_12_24, "buttons/btn_act_extra")

	local var_12_25 = arg_12_0.actExtraBtn

	arg_12_0.actExtraBtnAnim = var_1.Find(var_12_25, "usm")

	local var_12_26 = arg_12_0.leftChapter

	arg_12_0.remasterBtn = var_1.Find(var_12_26, "buttons/btn_remaster")

	local var_12_27 = arg_12_0.leftChapter

	arg_12_0.escortBar = var_1.Find(var_12_27, "escort_bar")

	local var_12_28 = arg_12_0.leftChapter

	arg_12_0.eliteQuota = var_1.Find(var_12_28, "elite_quota")

	local var_12_29 = arg_12_0.leftChapter

	arg_12_0.skirmishBar = var_1.Find(var_12_29, "left_times")

	local var_12_30 = arg_12_0._tf

	arg_12_0.mainLayer = var_1.Find(var_12_30, "main")
	setActive = var_1

	local var_12_31 = arg_12_0.mainLayer

	var_1(var_2.Find(var_12_31, "title_chapter_lines"), false)

	local var_12_32 = arg_12_0._tf

	arg_12_0.rightChapter = var_1.Find(var_12_32, "main/right_chapter")

	local var_12_33 = arg_12_0.rightChapter
	local var_12_34 = var_1.GetComponent

	typeof = var_3
	CanvasGroup = var_4
	arg_12_0.rightCanvasGroup = var_12_34(var_12_33, var_3(var_4))

	local var_12_35 = arg_12_0.rightChapter

	arg_12_0.eventContainer = var_1.Find(var_12_35, "event_btns/event_container")

	local var_12_36 = arg_12_0.eventContainer

	arg_12_0.btnSpecial = var_1.Find(var_12_36, "btn_task")

	local var_12_37 = arg_12_0.eventContainer

	arg_12_0.challengeBtn = var_1.Find(var_12_37, "btn_challenge")

	local var_12_38 = arg_12_0.eventContainer

	arg_12_0.dailyBtn = var_1.Find(var_12_38, "btn_daily")

	local var_12_39 = arg_12_0.eventContainer

	arg_12_0.militaryExerciseBtn = var_1.Find(var_12_39, "btn_pvp")

	local var_12_40 = arg_12_0.rightChapter

	arg_12_0.activityBtn = var_1.Find(var_12_40, "event_btns/activity_btn")

	local var_12_41 = arg_12_0.rightChapter

	arg_12_0.ptTotal = var_1.Find(var_12_41, "event_btns/pt_text")

	local var_12_42 = arg_12_0.rightChapter

	arg_12_0.ticketTxt = var_1.Find(var_12_42, "event_btns/tickets/Text")

	local var_12_43 = arg_12_0.rightChapter

	arg_12_0.remasterAwardBtn = var_1.Find(var_12_43, "btn_remaster_award")

	local var_12_44 = arg_12_0.rightChapter

	arg_12_0.btnNext = var_1.Find(var_12_44, "btn_next")

	local var_12_45 = arg_12_0.rightChapter

	arg_12_0.btnNextCol = var_1.Find(var_12_45, "btn_next/next_image")

	local var_12_46 = arg_12_0.rightChapter

	arg_12_0.countDown = var_1.Find(var_12_46, "event_btns/count_down")
	setActive = var_1

	local var_12_47 = arg_12_0.rightChapter

	var_1(var_2.Find(var_12_47, "event_btns/BottomList"), true)

	local var_12_48 = arg_12_0.rightChapter

	arg_12_0.actExchangeShopBtn = var_1.Find(var_12_48, "event_btns/BottomList/btn_exchange")

	local var_12_49 = arg_12_0.rightChapter

	arg_12_0.actAtelierBuffBtn = var_1.Find(var_12_49, "event_btns/BottomList/btn_control_center")

	local var_12_50 = arg_12_0.rightChapter

	arg_12_0.actAtelierYumiaBuffBtn = var_1.Find(var_12_50, "event_btns/BottomList/btn_yumia_buff")

	local var_12_51 = arg_12_0.rightChapter

	arg_12_0.actExtraRank = var_1.Find(var_12_51, "event_btns/BottomList/act_extra_rank")
	setActive = var_1

	var_1(arg_12_0.rightChapter, true)

	go = var_1

	local var_12_52 = arg_12_0.topPanel

	arg_12_0.damageTextTemplate = var_1(var_2.Find(var_12_52, "damage"))
	setActive = var_1

	var_1(arg_12_0.damageTextTemplate, false)

	arg_12_0.damageTextPool = {
		arg_12_0.damageTextTemplate
	}
	arg_12_0.damageTextActive = {}

	local var_12_53 = arg_12_0.topPanel

	arg_12_0.mapHelpBtn = var_1.Find(var_12_53, "help_button")

	local var_12_54 = arg_12_0.topPanel

	arg_12_0.avoidText = var_1.Find(var_12_54, "text_avoid")

	local var_12_55 = arg_12_0.topPanel

	arg_12_0.commanderTinkle = var_1.Find(var_12_55, "neko_tinkle")
	setActive = var_1

	var_1(arg_12_0.commanderTinkle, false)

	local var_12_56 = arg_12_0.topPanel

	arg_12_0.spResult = var_1.Find(var_12_56, "sp_result")
	setActive = var_1

	var_1(arg_12_0.spResult, false)

	local var_12_57 = arg_12_0.topPanel

	arg_12_0.helpPage = var_1.Find(var_12_57, "help_page")

	local var_12_58 = arg_12_0.helpPage

	arg_12_0.helpImage = var_1.Find(var_12_58, "icon")
	setActive = var_1

	var_1(arg_12_0.helpPage, false)

	local var_12_59 = arg_12_0.topPanel

	arg_12_0.curtain = var_1.Find(var_12_59, "curtain")
	setActive = var_1

	var_1(arg_12_0.curtain, false)

	local var_12_60 = arg_12_0._tf

	arg_12_0.map = var_1.Find(var_12_60, "maps")

	local var_12_61 = {}
	local var_12_62 = arg_12_0._tf

	var_12_61[1] = var_2.Find(var_12_62, "maps/map1")

	local var_12_63 = arg_12_0._tf

	var_12_61[2] = var_2.Find(var_12_63, "maps/map2")
	arg_12_0.mapTFs = var_12_61
	ipairs = var_12_61

	for iter_12_0, iter_12_1 in var_12_61(arg_12_0.mapTFs) do
		local var_12_64 = iter_12_1
		local var_12_65 = iter_12_1.GetComponent

		typeof = var_1_10008
		Image = var_1_10009
		var_12_65(var_12_64, var_1_10008(var_1_10009)).enabled = false
	end

	local var_12_66 = arg_12_0._tf

	arg_12_0.UIFXList = var_1.Find(var_12_66, "maps/UI_FX_list")

	local var_12_67 = arg_12_0.UIFXList
	local var_12_68 = var_1.GetComponentsInChildren

	typeof = var_3
	Renderer = iter_12_0

	local var_12_69 = var_12_68(var_12_67, var_3(iter_12_0))
	local var_12_70 = var_1.ToTable(var_12_69)

	ipairs = var_12_69

	for iter_12_2, iter_12_3 in var_12_69(var_12_70) do
		iter_12_3.sortingOrder = -1
	end

	local var_12_71 = arg_12_0._tf

	arg_12_0.rtRightPanel = var_2.Find(var_12_71, "entrance/enters/right_panel")

	local var_12_72 = arg_12_0.rtRightPanel

	arg_12_0.actBtnTpl = var_2.Find(var_12_72, "content/tpl")
	pg = var_2

	local var_12_73 = var_2.UIMgr.GetInstance().levelCamera
	local var_12_74 = var_3.GetComponent

	typeof = iter_12_2
	Camera = iter_12_3
	arg_12_0.levelCam = var_12_74(var_12_73, iter_12_2(iter_12_3))
	arg_12_0.uiMain = var_2.LevelMain
	setActive = var_3

	var_3(arg_12_0.uiMain, false)

	local var_12_75 = var_2.uiCamera
	local var_12_76 = var_3.GetComponent

	typeof = var_5
	Camera = iter_12_3
	arg_12_0.uiCam = var_12_76(var_12_75, var_5(iter_12_3))

	local var_12_77 = arg_12_0.uiMain

	arg_12_0.levelGrid = var_3.Find(var_12_77, "LevelGrid")
	setActive = var_3

	var_3(arg_12_0.levelGrid, true)

	local var_12_78 = arg_12_0.levelGrid

	arg_12_0.dragLayer = var_3.Find(var_12_78, "DragLayer")

	local var_12_79 = arg_12_0._tf

	arg_12_0.float = var_3.Find(var_12_79, "float")

	local var_12_80 = arg_12_0.float

	arg_12_0.clouds = var_3.Find(var_12_80, "clouds")
	setActive = var_3

	var_3(arg_12_0.clouds, true)

	setActive = var_3

	local var_12_81 = arg_12_0.float

	var_3(var_4.Find(var_12_81, "levels"), false)

	local var_12_82 = arg_12_0._tf

	arg_12_0.resources = var_3.Find(var_12_82, "resources")

	local var_12_83 = arg_12_0.resources

	arg_12_0.arrowTarget = var_3.Find(var_12_83, "Tpl_Arrow_Target")

	local var_12_84 = arg_12_0.resources

	arg_12_0.destinationMarkTpl = var_3.Find(var_12_84, "Tpl_Destination_Mark")

	local var_12_85 = arg_12_0.resources

	arg_12_0.championTpl = var_3.Find(var_12_85, "Tpl_Champion")

	local var_12_86 = arg_12_0.resources

	arg_12_0.deadTpl = var_3.Find(var_12_86, "Tpl_Dead")

	local var_12_87 = arg_12_0.resources

	arg_12_0.enemyTpl = var_3.Find(var_12_87, "Tpl_Enemy")

	local var_12_88 = arg_12_0.resources

	arg_12_0.oniTpl = var_3.Find(var_12_88, "Tpl_Oni")

	local var_12_89 = arg_12_0.resources

	arg_12_0.shipTpl = var_3.Find(var_12_89, "Tpl_Ship")

	local var_12_90 = arg_12_0.resources

	arg_12_0.subTpl = var_3.Find(var_12_90, "Tpl_Sub")

	local var_12_91 = arg_12_0.resources

	arg_12_0.transportTpl = var_3.Find(var_12_91, "Tpl_Transport")
	setText = var_3
	tf = var_12_91

	local var_12_92 = var_12_91(arg_12_0.enemyTpl)
	local var_12_93 = var_4.Find(var_12_92, "fighting/Text")

	i18n = var_12_92

	var_3(var_12_93, var_12_92("ui_word_levelui2_inevent"))
	arg_12_0:HideBtns()

	setAnchoredPosition = var_3

	var_3(arg_12_0.topChapter, {
		y = 0
	})

	setAnchoredPosition = var_3

	var_3(arg_12_0.leftChapter, {
		x = 0
	})

	setAnchoredPosition = var_3

	var_3(arg_12_0.rightChapter, {
		x = 0
	})

	arg_12_0.bubbleMsgBoxes = {}
	AutoLoader = var_3
	arg_12_0.loader = var_3.New()
	LevelFleetView = var_3
	arg_12_0.levelFleetView = var_3.New(arg_12_0.topPanel, arg_12_0.event, arg_12_0.contextData)
	LevelInfoView = var_3
	arg_12_0.levelInfoView = var_3.New(arg_12_0.topPanel, arg_12_0.event, arg_12_0.contextData)

	local var_12_94 = arg_12_0.levelInfoView

	var_3.RegisterView(var_12_94, arg_12_0)

	local var_12_95 = arg_12_0.levelFleetView

	var_3.RegisterView(var_12_95, arg_12_0)
	arg_12_0:buildCommanderPanel()

	LevelRemasterView = var_3
	arg_12_0.levelRemasterView = var_3.New(arg_12_0.topPanel, arg_12_0.event, arg_12_0.contextData)

	local var_12_96 = arg_12_0
	local var_12_97 = arg_12_0.SwitchMapBuilder

	MapBuilder = var_5

	var_12_97(var_12_96, var_5.TYPENORMAL)

	return
end

function var_0_1.initEvents(arg_13_0)
	local var_13_0 = arg_13_0
	local var_13_1 = arg_13_0.bind

	LevelUIConst = var_1_10003

	var_13_1(var_13_0, var_1_10003.OPEN_COMMANDER_PANEL, function(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
		local var_14_0 = arg_13_0

		var_4.openCommanderPanel(var_14_0, arg_14_1, arg_14_2, arg_14_3)

		return
	end)

	local var_13_2 = arg_13_0
	local var_13_3 = arg_13_0.bind

	LevelUIConst = var_3

	var_13_3(var_13_2, var_3.HANDLE_SHOW_MSG_BOX, function(arg_15_0, arg_15_1)
		local var_15_0 = arg_13_0

		var_2.HandleShowMsgBox(var_15_0, arg_15_1)

		return
	end)

	local var_13_4 = arg_13_0
	local var_13_5 = arg_13_0.bind

	LevelUIConst = var_3

	var_13_5(var_13_4, var_3.DO_AMBUSH_WARNING, function(arg_16_0, arg_16_1)
		local var_16_0 = arg_13_0

		var_2.doAmbushWarning(var_16_0, arg_16_1)

		return
	end)

	local var_13_6 = arg_13_0
	local var_13_7 = arg_13_0.bind

	LevelUIConst = var_3

	var_13_7(var_13_6, var_3.DISPLAY_AMBUSH_INFO, function(arg_17_0, arg_17_1)
		local var_17_0 = arg_13_0

		var_2.displayAmbushInfo(var_17_0, arg_17_1)

		return
	end)

	local var_13_8 = arg_13_0
	local var_13_9 = arg_13_0.bind

	LevelUIConst = var_3

	var_13_9(var_13_8, var_3.DISPLAY_STRATEGY_INFO, function(arg_18_0, arg_18_1)
		local var_18_0 = arg_13_0

		var_2.displayStrategyInfo(var_18_0, arg_18_1)

		return
	end)

	local var_13_10 = arg_13_0
	local var_13_11 = arg_13_0.bind

	LevelUIConst = var_3

	var_13_11(var_13_10, var_3.FROZEN, function(arg_19_0)
		local var_19_0 = arg_13_0

		var_1.frozen(var_19_0)

		return
	end)

	local var_13_12 = arg_13_0
	local var_13_13 = arg_13_0.bind

	LevelUIConst = var_3

	var_13_13(var_13_12, var_3.UN_FROZEN, function(arg_20_0)
		local var_20_0 = arg_13_0

		var_1.unfrozen(var_20_0)

		return
	end)

	local var_13_14 = arg_13_0
	local var_13_15 = arg_13_0.bind

	LevelUIConst = var_3

	var_13_15(var_13_14, var_3.DO_TRACKING, function(arg_21_0, arg_21_1)
		local var_21_0 = arg_13_0

		var_2.doTracking(var_21_0, arg_21_1)

		return
	end)

	local var_13_16 = arg_13_0
	local var_13_17 = arg_13_0.bind

	LevelUIConst = var_3

	var_13_17(var_13_16, var_3.SWITCH_TO_MAP, function()
		local var_22_0 = arg_13_0

		if var_0.isfrozen(var_22_0) then
			return
		end

		local var_22_1 = arg_13_0

		var_0.switchToMap(var_22_1)

		return
	end)

	local var_13_18 = arg_13_0
	local var_13_19 = arg_13_0.bind

	LevelUIConst = var_3

	var_13_19(var_13_18, var_3.DISPLAY_REPAIR_WINDOW, function(arg_23_0, arg_23_1)
		local var_23_0 = arg_13_0

		var_2.displayRepairWindow(var_23_0, arg_23_1)

		return
	end)

	local var_13_20 = arg_13_0
	local var_13_21 = arg_13_0.bind

	LevelUIConst = var_3

	var_13_21(var_13_20, var_3.DO_PLAY_ANIM, function(arg_24_0, arg_24_1)
		local var_24_0 = arg_13_0

		var_2.doPlayAnim(var_24_0, arg_24_1.name, arg_24_1.callback, arg_24_1.onStart)

		return
	end)

	local var_13_22 = arg_13_0
	local var_13_23 = arg_13_0.bind

	LevelUIConst = var_3

	var_13_23(var_13_22, var_3.HIDE_FLEET_SELECT, function()
		local var_25_0 = arg_13_0

		var_0.hideFleetSelect(var_25_0)

		return
	end)

	local var_13_24 = arg_13_0
	local var_13_25 = arg_13_0.bind

	LevelUIConst = var_3

	var_13_25(var_13_24, var_3.HIDE_FLEET_EDIT, function(arg_26_0)
		local var_26_0 = arg_13_0

		var_1.hideFleetEdit(var_26_0)

		return
	end)

	local var_13_26 = arg_13_0
	local var_13_27 = arg_13_0.bind

	LevelUIConst = var_3

	var_13_27(var_13_26, var_3.ADD_MSG_QUEUE, function(arg_27_0, arg_27_1)
		local var_27_0 = arg_13_0

		var_2.addbubbleMsgBox(var_27_0, arg_27_1)

		return
	end)

	local var_13_28 = arg_13_0
	local var_13_29 = arg_13_0.bind

	LevelUIConst = var_3

	var_13_29(var_13_28, var_3.SET_MAP, function(arg_28_0, arg_28_1)
		local var_28_0 = arg_13_0

		var_2.setMap(var_28_0, arg_28_1)

		return
	end)

	return
end

function var_0_1.addbubbleMsgBox(arg_29_0, arg_29_1)
	table = var_1_10002

	var_1_10002.insert(arg_29_0.bubbleMsgBoxes, arg_29_1)

	if #arg_29_0.bubbleMsgBoxes > 1 then
		return
	end

	local var_29_0

	;(function()
		if arg_29_0.bubbleMsgBoxes[1] then
			var_0(function()
				table = var_3_10000

				var_3_10000.remove(arg_29_0.bubbleMsgBoxes, 1)
				var_0()

				return
			end)
		end

		return
	end)()

	return
end

function var_0_1.CleanBubbleMsgbox(arg_32_0)
	table = var_1_10001

	var_1_10001.clean(arg_32_0.bubbleMsgBoxes)

	return
end

function var_0_1.updatePtActivity(arg_33_0, arg_33_1)
	arg_33_0.ptActivity = arg_33_1

	if not arg_33_0.ptActivity then
		return
	end

	arg_33_0:updateActivityRes()

	return
end

function var_0_1.updateActivityRes(arg_34_0)
	findTF = var_1_10001

	local var_34_0 = var_1_10001(arg_34_0.ptTotal, "Text")

	findTF = var_2

	local var_34_1 = var_2(arg_34_0.ptTotal, "icon/Image")

	if var_34_0 and var_34_1 and arg_34_0.ptActivity then
		setText = var_3

		var_3(var_34_0, "x" .. arg_34_0.ptActivity.data1)

		GetImageSpriteFromAtlasAsync = var_3
		Drop = var_4

		local var_34_2 = var_4.New
		local var_34_3 = {}

		DROP_TYPE_RESOURCE = var_6
		var_34_3.type = var_6
		tonumber = var_6

		local var_34_4 = arg_34_0.ptActivity

		var_34_3.id = var_6(var_7.getConfig(var_34_4, "config_id"))

		local var_34_5 = var_34_2(var_34_3)

		var_3(var_4.getIcon(var_34_5), "", var_34_1, true)
	end

	return
end

function var_0_1.setCommanderPrefabs(arg_35_0, arg_35_1)
	arg_35_0.commanderPrefabs = arg_35_1

	return
end

function var_0_1.didEnter(arg_36_0)
	LOCK_COMMANDER = var_1_10001

	local var_36_1

	if not var_1_10001 then
		pg = var_1_10001

		local var_36_0 = var_1_10001.SystemOpenMgr.GetInstance()

		var_36_1 = var_1.isOpenSystem(var_36_0, arg_36_0.player.level, "CommanderCatMediator")
	else
		var_36_1 = false
	end

	if false then
		var_36_1 = true
	end

	arg_36_0.openedCommanerSystem = var_36_1
	onButton = var_36_1

	local var_36_2 = arg_36_0
	local var_36_3 = arg_36_0.topChapter
	local var_36_4 = var_3.Find(var_36_3, "back_button")

	local function var_36_5()
		local var_37_0 = arg_36_0

		if var_0.isfrozen(var_37_0) then
			return
		end

		if arg_36_0.contextData.map and (var_0:isActivity() or var_0:isEscort()) then
			local var_37_1 = arg_36_0
			local var_37_2 = var_1.emit

			LevelMediator2 = var_2_10003

			var_37_2(var_37_1, var_2_10003.ON_SWITCH_NORMAL_MAP)

			return
		elseif var_0 and var_0:isSkirmish() then
			local var_37_3 = arg_36_0

			var_1.emit(var_37_3, var_0_1.ON_BACK)
		elseif not arg_36_0.contextData.entranceStatus then
			local var_37_4 = arg_36_0

			var_1.ShowEntranceUI(var_37_4, true)
		else
			local var_37_5 = arg_36_0

			var_1.emit(var_37_5, var_0_1.ON_BACK)
		end

		return
	end

	SFX_CANCEL = var_5

	var_36_1(var_36_2, var_36_4, var_36_5, var_5)

	onButton = var_36_1

	local var_36_6 = arg_36_0
	local var_36_7 = arg_36_0.btnSpecial

	local function var_36_8()
		local var_38_0 = arg_36_0

		if var_0.isfrozen(var_38_0) then
			return
		end

		local var_38_1 = arg_36_0
		local var_38_2 = var_0.emit

		LevelMediator2 = var_2_10002

		var_38_2(var_38_1, var_2_10002.ON_OPEN_EVENT_SCENE)

		return
	end

	SFX_PANEL = var_5

	var_36_1(var_36_6, var_36_7, var_36_8, var_5)

	onButton = var_36_1

	local var_36_9 = arg_36_0
	local var_36_10 = arg_36_0.dailyBtn

	local function var_36_11()
		local var_39_0 = arg_36_0

		if var_0.isfrozen(var_39_0) then
			return
		end

		DailyLevelProxy = var_0
		var_0.dailyLevelId = nil

		local var_39_1 = arg_36_0

		var_0.updatDailyBtnTip(var_39_1)

		local var_39_2 = arg_36_0
		local var_39_3 = var_0.emit

		LevelMediator2 = var_2_10002

		var_39_3(var_39_2, var_2_10002.ON_DAILY_LEVEL)

		return
	end

	SFX_PANEL = var_5

	var_36_1(var_36_9, var_36_10, var_36_11, var_5)

	onButton = var_36_1

	local var_36_12 = arg_36_0
	local var_36_13 = arg_36_0.challengeBtn

	local function var_36_14()
		local var_40_0 = arg_36_0

		if var_0.isfrozen(var_40_0) then
			return
		end

		local var_40_1 = arg_36_0
		local var_40_2, var_40_3 = var_0.checkChallengeOpen(var_40_1)

		if var_40_2 == false then
			pg = var_2_10002

			local var_40_4 = var_2_10002.TipsMgr.GetInstance()

			var_2.ShowTips(var_40_4, var_40_3)
		else
			local var_40_5 = arg_36_0
			local var_40_6 = var_2.emit

			LevelMediator2 = var_2_10004

			var_40_6(var_40_5, var_2_10004.CLICK_CHALLENGE_BTN)
		end

		return
	end

	SFX_PANEL = var_5

	var_36_1(var_36_12, var_36_13, var_36_14, var_5)

	onButton = var_36_1

	local var_36_15 = arg_36_0
	local var_36_16 = arg_36_0.militaryExerciseBtn

	local function var_36_17()
		local var_41_0 = arg_36_0

		if var_0.isfrozen(var_41_0) then
			return
		end

		local var_41_1 = arg_36_0
		local var_41_2 = var_0.emit

		LevelMediator2 = var_2_10002

		var_41_2(var_41_1, var_2_10002.ON_OPEN_MILITARYEXERCISE)

		return
	end

	SFX_PANEL = var_5

	var_36_1(var_36_15, var_36_16, var_36_17, var_5)

	onButton = var_36_1

	local var_36_18 = arg_36_0
	local var_36_19 = arg_36_0.normalBtn

	local function var_36_20()
		local var_42_0 = arg_36_0

		if var_0.isfrozen(var_42_0) then
			return
		end

		local var_42_1 = arg_36_0
		local var_42_2 = var_0.setMap
		local var_42_3 = arg_36_0.contextData.map

		var_42_2(var_42_1, var_2.getBindMapId(var_42_3))

		return
	end

	SFX_PANEL = var_5

	var_36_1(var_36_18, var_36_19, var_36_20, var_5)

	onButton = var_36_1

	local var_36_21 = arg_36_0
	local var_36_22 = arg_36_0.eliteBtn

	local function var_36_23()
		local var_43_0 = arg_36_0

		if var_0.isfrozen(var_43_0) then
			return
		end

		local var_43_1 = arg_36_0.contextData.map

		if var_0.getBindMapId(var_43_1) == 0 then
			pg = var_0

			local var_43_2 = var_0.TipsMgr.GetInstance()
			local var_43_3 = var_0.ShowTips

			i18n = var_2_10002

			var_43_3(var_43_2, var_2_10002("elite_disable_unusable"))

			getProxy = var_43_3
			ChapterProxy = var_43_2
			var_2_10002 = var_43_3(var_43_2)

			if var_0.getUseableMaxEliteMap(var_2_10002) then
				local var_43_4 = arg_36_0

				var_2_10002.setMap(var_43_4, var_1.configId)

				pg = var_2_10002

				local var_43_5 = var_2_10002.TipsMgr.GetInstance()

				var_2_10002 = var_2_10002.ShowTips
				i18n = var_4

				var_2_10002(var_43_5, var_4("elite_warp_to_latest_map"))
			end
		else
			local var_43_6 = arg_36_0.contextData.map
			local var_43_8

			if var_0.isEliteEnabled(var_43_6) then
				local var_43_7 = arg_36_0

				var_43_8 = var_43_8.setMap

				local var_43_9 = arg_36_0.contextData.map

				var_43_8(var_43_7, var_2_10002.getBindMapId(var_43_9))
			else
				pg = var_43_8

				local var_43_10 = var_43_8.TipsMgr.GetInstance()
				local var_43_11 = var_0.ShowTips

				i18n = var_2_10002

				var_43_11(var_43_10, var_2_10002("elite_disable_unsatisfied"))
			end
		end

		return
	end

	SFX_UI_WEIGHANCHOR_HARD = var_5

	var_36_1(var_36_21, var_36_22, var_36_23, var_5)

	onButton = var_36_1

	local var_36_24 = arg_36_0
	local var_36_25 = arg_36_0.remasterBtn

	local function var_36_26()
		local var_44_0 = arg_36_0

		if var_0.isfrozen(var_44_0) then
			return
		end

		local var_44_1 = arg_36_0

		var_0.displayRemasterPanel(var_44_1)

		getProxy = var_0
		ChapterProxy = var_44_1

		local var_44_2 = var_0(var_44_1)

		var_0.setRemasterTip(var_44_2, false)

		local var_44_3 = arg_36_0

		var_0.updateRemasterBtnTip(var_44_3)

		return
	end

	SFX_PANEL = var_5

	var_36_1(var_36_24, var_36_25, var_36_26, var_5)

	onButton = var_36_1

	local var_36_27 = arg_36_0
	local var_36_28 = arg_36_0.entranceLayer
	local var_36_29 = var_3.Find(var_36_28, "enters/enter_main")

	local function var_36_30()
		local var_45_0 = arg_36_0

		if var_0.isfrozen(var_45_0) then
			return
		end

		local var_45_1 = arg_36_0
		local var_45_2 = var_0.ShowSelectedMap
		local var_45_3 = arg_36_0

		var_45_2(var_45_1, var_2.GetInitializeMap(var_45_3))

		return
	end

	SFX_PANEL = var_5

	var_36_1(var_36_27, var_36_29, var_36_30, var_5)

	setText = var_36_1

	local var_36_31 = arg_36_0.entranceLayer
	local var_36_32 = var_2.Find(var_36_31, "enters/enter_main/Text")

	getProxy = var_36_31
	ChapterProxy = var_4

	local var_36_33 = var_36_31(var_4)
	local var_36_34 = var_3.getLastUnlockMap(var_36_33)

	var_36_1(var_36_32, var_3.getLastUnlockChapterName(var_36_34))

	onButton = var_36_1

	local var_36_35 = arg_36_0
	local var_36_36 = arg_36_0.entranceLayer
	local var_36_37 = var_3.Find(var_36_36, "enters/enter_world/enter")

	local function var_36_38()
		local var_46_0 = arg_36_0

		if var_0.isfrozen(var_46_0) then
			return
		end

		local var_46_1 = arg_36_0
		local var_46_2 = var_0.emit

		LevelMediator2 = var_2_10002

		var_46_2(var_46_1, var_2_10002.ENTER_WORLD)

		return
	end

	SFX_PANEL = var_5

	var_36_1(var_36_35, var_36_37, var_36_38, var_5)

	onButton = var_36_1

	local var_36_39 = arg_36_0
	local var_36_40 = arg_36_0.entranceLayer
	local var_36_41 = var_3.Find(var_36_40, "enters/enter_ready/activity")

	local function var_36_42()
		local var_47_0 = arg_36_0

		if var_0.isfrozen(var_47_0) then
			return
		end

		switch = var_0

		local var_47_1 = arg_36_0.entranceActivity
		local var_47_2 = var_1.getConfig(var_47_1, "type")
		local var_47_3 = {}

		ActivityConst = var_3
		var_47_3[var_3.ACTIVITY_TYPE_ZPROJECT] = function()
			local var_48_0 = arg_36_0
			local var_48_1 = var_0.emit

			LevelMediator2 = var_3_10002

			var_48_1(var_48_0, var_3_10002.ON_ACTIVITY_MAP, arg_36_0.entranceActivity.id)

			return
		end
		ActivityConst = var_3
		var_47_3[var_3.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2] = function()
			local var_49_0 = arg_36_0
			local var_49_1 = var_0.emit

			LevelMediator2 = var_3_10002

			var_49_1(var_49_0, var_3_10002.ON_OPEN_ACT_BOSS_BATTLE)

			return
		end
		ActivityConst = var_3
		var_47_3[var_3.ACTIVITY_TYPE_BOSSRUSH] = function()
			local var_50_0 = arg_36_0
			local var_50_1 = var_0.emit

			LevelMediator2 = var_3_10002

			var_50_1(var_50_0, var_3_10002.ON_BOSSRUSH_MAP)

			return
		end
		ActivityConst = var_3
		var_47_3[var_3.ACTIVITY_TYPE_BOSSSINGLE] = function()
			local var_51_0 = arg_36_0
			local var_51_1 = var_0.emit

			LevelMediator2 = var_3_10002

			local var_51_2 = var_3_10002.ON_BOSSSINGLE_MAP
			local var_51_3 = {}

			OtherworldMapScene = var_3_10004
			var_51_3.mode = var_3_10004.MODE_BATTLE

			var_51_1(var_51_0, var_51_2, var_51_3)

			return
		end
		ActivityConst = var_3
		var_47_3[var_3.ACTIVITY_TYPE_BOSSSINGLE_VARIABLE] = function()
			local var_52_0 = arg_36_0
			local var_52_1 = var_0.emit

			LevelMediator2 = var_3_10002

			var_52_1(var_52_0, var_3_10002.ON_CLUE_MAP)

			return
		end
		ActivityConst = var_3
		var_47_3[var_3.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB] = function()
			local var_53_0 = arg_36_0
			local var_53_1 = var_0.emit

			LevelMediator2 = var_3_10002

			var_53_1(var_53_0, var_3_10002.ON_COLLAB_BOSSRUSH_MAP)

			return
		end

		var_0(var_47_2, var_47_3)

		return
	end

	SFX_PANEL = var_5

	var_36_1(var_36_39, var_36_41, var_36_42, var_5)

	onButton = var_36_1

	local var_36_43 = arg_36_0
	local var_36_44 = arg_36_0.entranceLayer
	local var_36_45 = var_3.Find(var_36_44, "btns/btn_remaster")

	local function var_36_46()
		local var_54_0 = arg_36_0

		if var_0.isfrozen(var_54_0) then
			return
		end

		local var_54_1 = arg_36_0

		var_0.displayRemasterPanel(var_54_1)

		getProxy = var_0
		ChapterProxy = var_54_1

		local var_54_2 = var_0(var_54_1)

		var_0.setRemasterTip(var_54_2, false)

		local var_54_3 = arg_36_0

		var_0.updateRemasterBtnTip(var_54_3)

		return
	end

	SFX_PANEL = var_5

	var_36_1(var_36_43, var_36_45, var_36_46, var_5)

	setActive = var_36_1

	local var_36_47 = arg_36_0.entranceLayer
	local var_36_48 = var_2.Find(var_36_47, "btns/btn_remaster")

	OPEN_REMASTER = var_36_47

	var_36_1(var_36_48, var_36_47)

	onButton = var_36_1

	local var_36_49 = arg_36_0
	local var_36_50 = arg_36_0.entranceLayer
	local var_36_51 = var_3.Find(var_36_50, "btns/btn_challenge")

	local function var_36_52()
		local var_55_0 = arg_36_0

		if var_0.isfrozen(var_55_0) then
			return
		end

		local var_55_1 = arg_36_0
		local var_55_2, var_55_3 = var_0.checkChallengeOpen(var_55_1)

		if var_55_2 == false then
			pg = var_2_10002

			local var_55_4 = var_2_10002.TipsMgr.GetInstance()

			var_2.ShowTips(var_55_4, var_55_3)
		else
			local var_55_5 = arg_36_0
			local var_55_6 = var_2.emit

			LevelMediator2 = var_2_10004

			var_55_6(var_55_5, var_2_10004.CLICK_CHALLENGE_BTN)
		end

		return
	end

	SFX_PANEL = var_5

	var_36_1(var_36_49, var_36_51, var_36_52, var_5)

	onButton = var_36_1

	local var_36_53 = arg_36_0
	local var_36_54 = arg_36_0.entranceLayer
	local var_36_55 = var_3.Find(var_36_54, "btns/btn_pvp")

	local function var_36_56()
		local var_56_0 = arg_36_0

		if var_0.isfrozen(var_56_0) then
			return
		end

		local var_56_1 = arg_36_0
		local var_56_2 = var_0.emit

		LevelMediator2 = var_2_10002

		var_56_2(var_56_1, var_2_10002.ON_OPEN_MILITARYEXERCISE)

		return
	end

	SFX_PANEL = var_5

	var_36_1(var_36_53, var_36_55, var_36_56, var_5)

	onButton = var_36_1

	local var_36_57 = arg_36_0
	local var_36_58 = arg_36_0.entranceLayer
	local var_36_59 = var_3.Find(var_36_58, "btns/btn_daily")

	local function var_36_60()
		local var_57_0 = arg_36_0

		if var_0.isfrozen(var_57_0) then
			return
		end

		DailyLevelProxy = var_0
		var_0.dailyLevelId = nil

		local var_57_1 = arg_36_0

		var_0.updatDailyBtnTip(var_57_1)

		local var_57_2 = arg_36_0
		local var_57_3 = var_0.emit

		LevelMediator2 = var_2_10002

		var_57_3(var_57_2, var_2_10002.ON_DAILY_LEVEL)

		return
	end

	SFX_PANEL = var_5

	var_36_1(var_36_57, var_36_59, var_36_60, var_5)

	onButton = var_36_1

	local var_36_61 = arg_36_0
	local var_36_62 = arg_36_0.entranceLayer
	local var_36_63 = var_3.Find(var_36_62, "btns/btn_task")

	local function var_36_64()
		local var_58_0 = arg_36_0

		if var_0.isfrozen(var_58_0) then
			return
		end

		local var_58_1 = arg_36_0
		local var_58_2 = var_0.emit

		LevelMediator2 = var_2_10002

		var_58_2(var_58_1, var_2_10002.ON_OPEN_EVENT_SCENE)

		return
	end

	SFX_PANEL = var_5

	var_36_1(var_36_61, var_36_63, var_36_64, var_5)

	setActive = var_36_1

	local var_36_65 = arg_36_0.entranceLayer
	local var_36_66 = var_2.Find(var_36_65, "enters/enter_world/enter")

	WORLD_ENTER_LOCK = var_36_65

	var_36_1(var_36_66, not var_36_65)

	setActive = var_36_1

	local var_36_67 = arg_36_0.entranceLayer
	local var_36_68 = var_2.Find(var_36_67, "enters/enter_world/nothing")

	WORLD_ENTER_LOCK = var_36_67

	var_36_1(var_36_68, var_36_67)

	getProxy = var_36_1
	ActivityProxy = var_36_68

	local var_36_69 = var_36_1(var_36_68)

	arg_36_0.entranceActivity = var_1.getEnterReadyActivity(var_36_69)[1]
	setActive = var_1

	local var_36_70 = arg_36_0.entranceLayer
	local var_36_71 = var_2.Find(var_36_70, "enters/enter_ready/nothing")

	tobool = var_36_70

	var_1(var_36_71, not var_36_70(arg_36_0.entranceActivity))

	setActive = var_1

	local var_36_72 = arg_36_0.entranceLayer
	local var_36_73 = var_2.Find(var_36_72, "enters/enter_ready/activity")

	tobool = var_36_72

	var_1(var_36_73, var_36_72(arg_36_0.entranceActivity))

	tobool = var_1

	if var_1(arg_36_0.entranceActivity) then
		local var_36_74 = arg_36_0.entranceActivity

		if var_1.getConfig(var_36_74, "config_client").entrance_bg then
			GetImageSpriteFromAtlasAsync = var_36_74

			local var_36_75 = var_1
			local var_36_76 = ""
			local var_36_77 = arg_36_0.entranceLayer

			var_36_74(var_36_75, var_36_76, var_5.Find(var_36_77, "enters/enter_ready/activity"), true)
		end
	end

	arg_36_0:updateRightPanel()

	pg = var_1

	local var_36_78 = var_1.SystemOpenMgr.GetInstance()
	local var_36_79 = var_1.isOpenSystem(var_36_78, arg_36_0.player.level, "EventMediator")

	setActive = var_36_78

	local var_36_80 = arg_36_0.btnSpecial

	var_36_78(var_3.Find(var_36_80, "lock"), not var_36_79)

	setActive = var_36_78

	local var_36_81 = arg_36_0.entranceLayer

	var_36_78(var_3.Find(var_36_81, "btns/btn_task/lock"), not var_36_79)

	pg = var_36_78

	local var_36_82 = var_36_78.SystemOpenMgr.GetInstance()
	local var_36_83 = var_2.isOpenSystem(var_36_82, arg_36_0.player.level, "DailyLevelMediator")

	setActive = var_36_82

	local var_36_84 = arg_36_0.dailyBtn

	var_36_82(var_4.Find(var_36_84, "lock"), not var_36_83)

	setActive = var_36_82

	local var_36_85 = arg_36_0.entranceLayer

	var_36_82(var_4.Find(var_36_85, "btns/btn_daily/lock"), not var_36_83)

	pg = var_36_82

	local var_36_86 = var_36_82.SystemOpenMgr.GetInstance()
	local var_36_87 = var_3.isOpenSystem(var_36_86, arg_36_0.player.level, "MilitaryExerciseMediator")

	setActive = var_36_86

	local var_36_88 = arg_36_0.militaryExerciseBtn

	var_36_86(var_5.Find(var_36_88, "lock"), not var_36_87)

	setActive = var_36_86

	local var_36_89 = arg_36_0.entranceLayer

	var_36_86(var_5.Find(var_36_89, "btns/btn_pvp/lock"), not var_36_87)

	pg = var_36_86

	local var_36_90 = var_36_86.SystemOpenMgr.GetInstance()
	local var_36_91 = var_4.isOpenSystem(var_36_90, arg_36_0.player.level, "WorldMediator")

	setActive = var_36_90

	local var_36_92 = arg_36_0.entranceLayer

	var_36_90(var_6.Find(var_36_92, "enters/enter_world/enter/lock"), not var_36_91)

	LimitChallengeConst = var_36_90

	local var_36_93 = var_36_90.IsOpen()

	setActive = var_6

	local var_36_94 = arg_36_0.challengeBtn

	var_6(var_7.Find(var_36_94, "lock"), not var_36_93)

	setActive = var_6

	local var_36_95 = arg_36_0.entranceLayer

	var_6(var_7.Find(var_36_95, "btns/btn_challenge/lock"), not var_36_93)

	LimitChallengeConst = var_6

	local var_36_96 = var_6.IsInAct()

	setActive = var_7

	var_7(arg_36_0.challengeBtn, var_36_96)

	setActive = var_7

	local var_36_97 = arg_36_0.entranceLayer

	var_7(var_8.Find(var_36_97, "btns/btn_challenge"), var_36_96)

	LimitChallengeConst = var_7

	local var_36_98 = var_7.IsShowRedPoint()

	setActive = var_8

	local var_36_99 = arg_36_0.entranceLayer

	var_8(var_9.Find(var_36_99, "btns/btn_challenge/tip"), var_36_98)
	arg_36_0:initMapBtn(arg_36_0.btnPrev, -1)
	arg_36_0:initMapBtn(arg_36_0.btnNext, 1)

	local var_36_100 = arg_36_0

	arg_36_0.registerActBtn(var_36_100)

	if arg_36_0.contextData.editEliteChapter then
		getProxy = var_8
		ChapterProxy = var_36_100

		local var_36_101 = var_8(var_36_100)
		local var_36_102 = var_8.getChapterById(var_36_101, arg_36_0.contextData.editEliteChapter)

		arg_36_0:displayFleetEdit(var_36_102)

		arg_36_0.contextData.editEliteChapter = nil
	elseif arg_36_0.contextData.selectedChapterVO then
		arg_36_0:displayFleetSelect(arg_36_0.contextData.selectedChapterVO)

		arg_36_0.contextData.selectedChapterVO = nil
	end

	if not arg_36_0.contextData.chapterVO or not var_8.active then
		arg_36_0:tryPlaySubGuide()
	end

	arg_36_0:updateRemasterBtnTip()
	arg_36_0:updatDailyBtnTip()

	if arg_36_0.contextData.open_remaster then
		arg_36_0:displayRemasterPanel(arg_36_0.contextData.isSP)

		arg_36_0.contextData.open_remaster = nil
	end

	arg_36_0:ShowEntranceUI(arg_36_0.contextData.entranceStatus)

	if not arg_36_0.contextData.entranceStatus then
		local var_36_103 = arg_36_0
		local var_36_104 = arg_36_0.emit

		LevelMediator2 = var_11

		var_36_104(var_36_103, var_11.ON_ENTER_MAINLEVEL, arg_36_0:GetInitializeMap())
	end

	local var_36_105 = arg_36_0
	local var_36_106 = arg_36_0.emit

	LevelMediator2 = var_11

	var_36_106(var_36_105, var_11.ON_DIDENTER)

	return
end

function var_0_1.updateRightPanel(arg_59_0)
	defaultValue = var_1_10001

	local var_59_0 = arg_59_0.rightActivityBtns
	local var_59_1 = {}

	LevelSecondMapBtn = var_1_10004
	var_59_1[1] = var_1_10004.New(arg_59_0.actBtnTpl, arg_59_0.event, false)
	arg_59_0.rightActivityBtns = var_1_10001(var_59_0, var_59_1)

	local var_59_2 = {}
	local var_59_3 = {}

	ipairs = var_59_1

	for iter_59_0, iter_59_1 in var_59_1(arg_59_0.rightActivityBtns) do
		if iter_59_1:InShowTime() then
			table = var_8

			var_8.insert(var_59_2, iter_59_1)
		else
			table = var_8

			var_8.insert(var_59_3, iter_59_1)
		end
	end

	table = var_3

	local var_59_4 = var_3.sort
	local var_59_5 = var_59_2

	CompareFuncs = var_5

	var_59_4(var_59_5, var_5({
		function(arg_60_0)
			return arg_60_0.config.group_id
		end
	}))

	ipairs = var_59_4

	for iter_59_2, iter_59_3 in var_59_4(var_59_2) do
		iter_59_3:Init(iter_59_2)
	end

	ipairs = var_3

	for iter_59_4, iter_59_5 in var_3(var_59_3) do
		iter_59_5:Clear()
	end

	return
end

function var_0_1.checkChallengeOpen(arg_61_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_61_0 = var_1_10001(var_1_10002)
	local var_61_1 = var_1.getRawData(var_61_0).level

	pg = var_1_10003

	local var_61_2 = var_1_10003.SystemOpenMgr.GetInstance()

	return var_3.isOpenSystem(var_61_2, var_61_1, "ChallengeMainMediator")
end

function var_0_1.tryPlaySubGuide(arg_62_0)
	local var_62_0

	if arg_62_0.contextData.map then
		var_1_10002 = arg_62_0.contextData.map
		var_62_0 = var_1.isSkirmish(var_1_10002)
	end

	if var_62_0 then
		return
	end

	pg = var_1_10002

	local var_62_1 = var_1_10002.SystemGuideMgr.GetInstance()

	var_2.Play(var_62_1, arg_62_0)

	return
end

function var_0_1.onBackPressed(arg_63_0)
	if arg_63_0:isfrozen() then
		return
	end

	if arg_63_0.levelAmbushView then
		return
	end

	pg = var_1

	local var_63_0 = var_1.CriMgr.GetInstance()
	local var_63_1 = var_1.PlaySoundEffect_V3

	SFX_CANCEL = var_1_10003

	var_63_1(var_63_0, var_1_10003)

	local var_63_2 = arg_63_0.levelInfoView

	if var_1.isShowing(var_63_2) then
		arg_63_0:hideChapterPanel()

		return
	end

	if arg_63_0.levelInfoSPView then
		local var_63_3 = arg_63_0.levelInfoSPView

		if var_1.isShowing(var_63_3) then
			arg_63_0:HideLevelInfoSPPanel()

			return
		end
	end

	local var_63_4 = arg_63_0.levelFleetView

	if var_1.isShowing(var_63_4) then
		arg_63_0:hideFleetEdit()

		return
	end

	if arg_63_0.levelStrategyView then
		arg_63_0:hideStrategyInfo()

		return
	end

	if arg_63_0.levelRepairView then
		arg_63_0:hideRepairWindow()

		return
	end

	local var_63_5 = arg_63_0.levelRemasterView

	if var_1.isShowing(var_63_5) then
		arg_63_0:hideRemasterPanel()

		return
	end

	local var_63_7

	if arg_63_0.contextData.map then
		local var_63_6 = arg_63_0.contextData.map

		var_63_7 = var_63_7.getConfig(var_63_6, "ui_type")
		MapBuilder = var_63_6

		if var_63_7 == var_63_6.TYPEEXSP then
			local var_63_8 = arg_63_0.mapBuilder.personalPage

			if var_63_7.IsActive(var_63_8) then
				local var_63_9 = arg_63_0.mapBuilder.personalPage

				var_63_7.Hide(var_63_9)

				return
			end
		end
	end

	isActive = var_63_7

	if var_63_7(arg_63_0.helpPage) then
		setActive = var_1

		var_1(arg_63_0.helpPage, false)

		return
	end

	local var_63_10 = arg_63_0.contextData.chapterVO

	getProxy = var_2
	ChapterProxy = var_1_10003

	local var_63_11 = var_2(var_1_10003)
	local var_63_12 = var_2.getActiveChapter(var_63_11)

	if var_63_10 and var_63_12 then
		arg_63_0:switchToMap()

		return
	end

	triggerButton = var_63_11

	local var_63_13 = arg_63_0.topChapter

	var_63_11(var_4.Find(var_63_13, "back_button"))

	return
end

function var_0_1.ShowEntranceUI(arg_64_0, arg_64_1)
	setActive = var_1_10002

	var_1_10002(arg_64_0.entranceLayer, arg_64_1)

	setActive = var_1_10002

	var_1_10002(arg_64_0.entranceBg, arg_64_1)

	setActive = var_1_10002

	var_1_10002(arg_64_0.map, not arg_64_1)

	setActive = var_1_10002

	var_1_10002(arg_64_0.float, not arg_64_1)

	setActive = var_1_10002

	var_1_10002(arg_64_0.mainLayer, not arg_64_1)

	setActive = var_1_10002

	local var_64_0 = arg_64_0.topChapter

	var_1_10002(var_3.Find(var_64_0, "type_entrance"), arg_64_1)

	local var_64_1 = arg_64_0.contextData

	tobool = var_3
	var_64_1.entranceStatus = var_3(arg_64_1)

	if arg_64_1 then
		setActive = var_64_1

		local var_64_2 = arg_64_0.topChapter

		var_64_1(var_3.Find(var_64_2, "title_chapter"), false)

		setActive = var_64_1

		local var_64_3 = arg_64_0.topChapter

		var_64_1(var_3.Find(var_64_3, "type_chapter"), false)

		setActive = var_64_1

		local var_64_4 = arg_64_0.topChapter

		var_64_1(var_3.Find(var_64_4, "type_escort"), false)

		setActive = var_64_1

		local var_64_5 = arg_64_0.topChapter

		var_64_1(var_3.Find(var_64_5, "type_skirmish"), false)

		if arg_64_0.newChapterCDTimer then
			local var_64_6 = arg_64_0.newChapterCDTimer

			var_2.Stop(var_64_6)

			arg_64_0.newChapterCDTimer = nil
		end

		arg_64_0:RecordLastMapOnExit()

		arg_64_0.contextData.mapIdx = nil
		arg_64_0.contextData.map = nil
	end

	arg_64_0:PlayBGM()

	return
end

function var_0_1.PreloadLevelMainUI(arg_65_0, arg_65_1, arg_65_2)
	if arg_65_0.preloadLevelDone then
		existCall = var_3

		var_3(arg_65_2)

		return
	end

	local var_65_0

	local function var_65_1()
		if not arg_65_0.exited then
			local var_66_0 = arg_65_0

			var_66_0.preloadLevelDone = true
			existCall = var_66_0

			var_66_0(arg_65_2)
		end

		return
	end

	getProxy = var_1_10004
	ChapterProxy = var_1_10005

	local var_65_2 = var_1_10004(var_1_10005)
	local var_65_3 = var_4.getMapById(var_65_2, arg_65_1)
	local var_65_4 = arg_65_0
	local var_65_5 = arg_65_0.GetMapBG(var_65_4, var_65_3)

	table = var_65_4

	var_65_4.ParallelIpairsAsync(var_65_5, function(arg_67_0, arg_67_1, arg_67_2)
		GetSpriteFromAtlasAsync = var_2_10003

		var_2_10003("levelmap/" .. arg_67_1.BG, "", arg_67_2)

		return
	end, var_65_1)

	return
end

function var_0_1.setShips(arg_68_0, arg_68_1)
	arg_68_0.shipVOs = arg_68_1

	return
end

function var_0_1.updateRes(arg_69_0, arg_69_1)
	if arg_69_0.levelStageView then
		local var_69_0 = arg_69_0.levelStageView

		var_2.ActionInvoke(var_69_0, "SetPlayer", arg_69_1)
	end

	arg_69_0.player = arg_69_1

	return
end

function var_0_1.setEliteQuota(arg_70_0, arg_70_1, arg_70_2)
	local var_70_0 = arg_70_2 - arg_70_1
	local var_70_1 = arg_70_0.eliteQuota
	local var_70_2 = var_4.Find(var_70_1, "bg/Text")
	local var_70_3 = var_4.GetComponent

	typeof = var_1_10007
	Text = var_1_10008

	local var_70_4 = var_70_3(var_70_2, var_1_10007(var_1_10008))

	if arg_70_1 == arg_70_2 then
		Color = var_70_2
		var_70_4.color = var_70_2.red
	else
		Color = var_70_2
		var_70_4.color = var_70_2.New(0.47, 0.89, 0.27)
	end

	var_70_4.text = var_70_0 .. "/" .. arg_70_2

	return
end

function var_0_1.updateEvent(arg_71_0, arg_71_1)
	local var_71_0 = arg_71_1
	local var_71_1 = arg_71_1.hasFinishState(var_71_0)

	setActive = var_71_0

	local var_71_2 = arg_71_0.btnSpecial

	var_71_0(var_4.Find(var_71_2, "tip"), var_71_1)

	setActive = var_71_0

	local var_71_3 = arg_71_0.entranceLayer

	var_71_0(var_4.Find(var_71_3, "btns/btn_task/tip"), var_71_1)

	return
end

function var_0_1.updateFleet(arg_72_0, arg_72_1)
	arg_72_0.fleets = arg_72_1

	return
end

function var_0_1.updateChapterVO(arg_73_0, arg_73_1, arg_73_2)
	if arg_73_0.contextData.chapterVO and arg_73_0.contextData.chapterVO.id == arg_73_1.id and arg_73_1.active then
		arg_73_0:setChapter(arg_73_1)
	end

	if arg_73_0.contextData.chapterVO and arg_73_0.contextData.chapterVO.id == arg_73_1.id and arg_73_1.active and arg_73_0.levelStageView and arg_73_0.grid then
		local var_73_0 = false
		local var_73_1 = false
		local var_73_2 = false

		if not (arg_73_2 < 0) then
			bit = var_6

			local var_73_3 = var_6.band
			local var_73_4 = arg_73_2

			ChapterConst = var_1_10008

			if var_73_3(var_73_4, var_1_10008.DirtyFleet) > 0 then
				local var_73_5 = arg_73_0.levelStageView

				var_6.updateStageFleet(var_73_5)

				local var_73_6 = arg_73_0.levelStageView

				var_6.updateAmbushRate(var_73_6, arg_73_1.fleet.line, true)

				var_73_2 = true

				if arg_73_0.grid then
					local var_73_7 = arg_73_0.grid

					var_6.RefreshFleetCells(var_73_7)

					local var_73_8 = arg_73_0.grid

					var_6.UpdateFloor(var_73_8)

					local var_73_9 = arg_73_0.grid

					var_6.UpdateWeatherCells(var_73_9)

					var_73_0 = true
				end
			end

			if not (arg_73_2 < 0) then
				bit = var_73_10

				local var_73_10 = var_73_10.band
				local var_73_11 = arg_73_2

				ChapterConst = var_1_10008

				if var_73_10(var_73_11, var_1_10008.DirtyChampion) > 0 then
					var_73_2 = true

					if arg_73_0.grid then
						local var_73_12 = arg_73_0.grid

						var_73_10.UpdateFleets(var_73_12)

						local var_73_13 = arg_73_0.grid

						var_73_10.clearChampions(var_73_13)

						local var_73_14 = arg_73_0.grid

						var_73_10.initChampions(var_73_14)

						var_73_1 = true
					end
				else
					bit = var_73_10

					local var_73_15 = var_73_10.band
					local var_73_16 = arg_73_2

					ChapterConst = var_1_10008

					if var_73_15(var_73_16, var_1_10008.DirtyChampionPosition) > 0 then
						var_73_2 = true

						if arg_73_0.grid then
							local var_73_17 = arg_73_0.grid

							var_6.UpdateFleets(var_73_17)

							local var_73_18 = arg_73_0.grid

							var_6.updateChampions(var_73_18)

							var_73_1 = true
						end
					end
				end

				if not (arg_73_2 < 0) then
					bit = var_6

					local var_73_19 = var_6.band
					local var_73_20 = arg_73_2

					ChapterConst = var_1_10008

					if var_73_19(var_73_20, var_1_10008.DirtyAchieve) > 0 then
						local var_73_21 = arg_73_0.levelStageView

						var_6.updateStageAchieve(var_73_21)
					end

					if not (arg_73_2 < 0) then
						bit = var_6

						local var_73_22 = var_6.band
						local var_73_23 = arg_73_2

						ChapterConst = var_1_10008

						if var_73_22(var_73_23, var_1_10008.DirtyAttachment) > 0 then
							local var_73_24 = arg_73_0.levelStageView

							var_6.updateAmbushRate(var_73_24, arg_73_1.fleet.line, true)

							if arg_73_0.grid then
								if not (arg_73_2 < 0) then
									bit = var_6

									local var_73_25 = var_6.band
									local var_73_26 = arg_73_2

									ChapterConst = var_1_10008

									if not (var_73_25(var_73_26, var_1_10008.DirtyFleet) > 0) then
										local var_73_27 = arg_73_0.grid

										var_6.updateFleet(var_73_27, arg_73_1.fleets[arg_73_1.findex].id)
									end
								end

								local var_73_28 = arg_73_0.grid

								var_6.updateAttachments(var_73_28)

								if not (arg_73_2 < 0) then
									bit = var_6

									local var_73_29 = var_6.band
									local var_73_30 = arg_73_2

									ChapterConst = var_1_10008

									if var_73_29(var_73_30, var_1_10008.DirtyAutoAction) > 0 then
										local var_73_31 = arg_73_0.grid
										local var_73_32 = var_6.updateQuadCells

										ChapterConst = var_1_10008

										var_73_32(var_73_31, var_1_10008.QuadStateNormal)
									else
										var_73_0 = true
									end

									if not (arg_73_2 < 0) then
										bit = var_6

										local var_73_33 = var_6.band
										local var_73_34 = arg_73_2

										ChapterConst = var_1_10008

										if var_73_33(var_73_34, var_1_10008.DirtyStrategy) > 0 then
											local var_73_35 = arg_73_0.levelStageView

											var_6.updateStageStrategy(var_73_35)

											var_73_2 = true

											local var_73_36 = arg_73_0.levelStageView

											var_6.updateStageBarrier(var_73_36)

											local var_73_37 = arg_73_0.levelStageView

											var_6.UpdateAutoFightPanel(var_73_37)
										end

										if not (arg_73_2 < 0) then
											bit = var_6

											local var_73_38 = var_6.band
											local var_73_39 = arg_73_2

											ChapterConst = var_1_10008

											if var_73_38(var_73_39, var_1_10008.DirtyAutoAction) > 0 then
												-- block empty
											elseif var_73_0 then
												local var_73_40 = arg_73_0.grid
												local var_73_41 = var_6.updateQuadCells

												ChapterConst = var_1_10008

												var_73_41(var_73_40, var_1_10008.QuadStateNormal)
											elseif var_73_1 then
												local var_73_42 = arg_73_0.grid
												local var_73_43 = var_6.updateQuadCells

												ChapterConst = var_1_10008

												var_73_43(var_73_42, var_1_10008.QuadStateFrozen)
											end
										end

										if not (arg_73_2 < 0) then
											bit = var_6

											local var_73_44 = var_6.band
											local var_73_45 = arg_73_2

											ChapterConst = var_1_10008

											if var_73_44(var_73_45, var_1_10008.DirtyCellFlag) > 0 then
												local var_73_46 = arg_73_0.grid

												var_6.UpdateFloor(var_73_46)
											end

											if not (arg_73_2 < 0) then
												bit = var_6

												local var_73_47 = var_6.band
												local var_73_48 = arg_73_2

												ChapterConst = var_1_10008

												if var_73_47(var_73_48, var_1_10008.DirtyBase) > 0 then
													local var_73_49 = arg_73_0.levelStageView

													var_6.UpdateDefenseStatus(var_73_49)
												end

												if not (arg_73_2 < 0) then
													bit = var_6

													local var_73_50 = var_6.band
													local var_73_51 = arg_73_2

													ChapterConst = var_1_10008

													if var_73_50(var_73_51, var_1_10008.DirtyFloatItems) > 0 then
														local var_73_52 = arg_73_0.grid

														var_6.UpdateItemCells(var_73_52)
													end

													if not (arg_73_2 < 0) then
														bit = var_6

														local var_73_53 = var_6.band
														local var_73_54 = arg_73_2

														ChapterConst = var_1_10008

														if var_73_53(var_73_54, var_1_10008.DirtyWeather) > 0 then
															local var_73_55 = arg_73_0.grid

															var_6.UpdateWeatherCells(var_73_55)
														end

														if var_73_2 then
															local var_73_56 = arg_73_0.levelStageView

															var_6.updateFleetBuff(var_73_56)
														end

														return
													end
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

function var_0_1.updateClouds(arg_74_0)
	arg_74_0.cloudRTFs = {}
	arg_74_0.cloudRects = {}
	arg_74_0.cloudTimer = {}

	for iter_74_0 = 1, 6 do
		local var_74_0 = arg_74_0.clouds
		local var_74_1 = var_5.Find(var_74_0, "cloud_" .. iter_74_0)

		rtf = var_74_0

		local var_74_2 = var_74_0(var_74_1)

		table = var_7

		var_7.insert(arg_74_0.cloudRTFs, var_74_2)

		table = var_7

		var_7.insert(arg_74_0.cloudRects, var_74_2.rect.width)
	end

	arg_74_0:initCloudsPos()

	ipairs = var_1

	for iter_74_1, iter_74_2 in var_1(arg_74_0.cloudRTFs) do
		local var_74_3 = arg_74_0.cloudRects[iter_74_1]
		local var_74_4

		if not arg_74_0.initPositions[iter_74_1] then
			Vector2 = var_74_4
			var_74_4 = var_74_4(0, 0)
		end

		local var_74_5 = 30 - var_74_4.y / 20
		local var_74_6 = (arg_74_0.mapWidth + var_74_3) / var_74_5
		local var_74_7

		LeanTween = var_1_10011

		local var_74_8 = var_1_10011.moveX(iter_74_2, arg_74_0.mapWidth, var_74_6)
		local var_74_9 = var_1_10011.setRepeat(var_74_8, -1)
		local var_74_10 = var_1_10011.setOnCompleteOnRepeat(var_74_9, true)

		var_1_10011 = var_1_10011.setOnComplete
		System = var_13
		var_74_7 = var_1_10011(var_74_10, var_13.Action(function()
			var_74_3 = arg_74_0.cloudRects[iter_74_1]

			local var_75_0 = iter_74_2

			Vector2 = var_1
			var_75_0.anchoredPosition = var_1(-var_74_3, var_74_4.y)

			local var_75_1 = var_74_7
			local var_75_2 = var_0.setFrom(var_75_1, -var_74_3)

			var_0.setTime(var_75_2, (arg_74_0.mapWidth + var_74_3) / var_74_5)

			return
		end))
		math = var_1_10011
		var_74_7.passed = var_1_10011.random() * var_74_6
		var_1_10011 = arg_74_0.cloudTimer
		var_1_10011[iter_74_1] = var_74_7.uniqueId
	end

	return
end

function var_0_1.RefreshMapBG(arg_76_0)
	arg_76_0:PlayBGM()
	arg_76_0:SwitchMapBG(arg_76_0.contextData.map, nil, true)

	return
end

function var_0_1.updateCouldAnimator(arg_77_0, arg_77_1, arg_77_2)
	if not arg_77_1 then
		return
	end

	local var_77_0 = arg_77_0.contextData.map
	local var_77_1 = var_3.getConfig(var_77_0, "ani_controller")

	local function var_77_2(arg_78_0)
		tf = var_2_10001
		arg_78_0 = var_2_10001(arg_78_0)
		Vector3 = var_1

		local var_78_0 = var_1.one

		if arg_78_0.rect.width > 0 and arg_78_0.rect.height > 0 then
			var_78_0.x = arg_78_0.parent.rect.width / arg_78_0.rect.width
			var_78_0.y = arg_78_0.parent.rect.height / arg_78_0.rect.height
		end

		arg_78_0.localScale = var_78_0

		if var_77_1 then
			local var_78_1 = #var_77_1

			if 0 < var_78_1 then
				getProxy = var_78_1
				ChapterProxy = var_3

				local var_78_2 = var_78_1(var_3)

				;(function()
					ipairs = var_3_10000

					for iter_79_0, iter_79_1 in var_3_10000(var_77_1) do
						local var_79_0 = false
						local var_79_1 = iter_79_1[2][1]

						ipairs = var_3_10007

						for iter_79_2, iter_79_3 in var_3_10007(var_79_1) do
							local var_79_2 = var_78_2

							if var_12.GetChapterItemById(var_79_2, iter_79_3) and var_12:isClear() then
								var_79_0 = true

								break
							end
						end

						if iter_79_1[1] == var_0_3 then
							_ = var_3_10007
							var_3_10007 = var_3_10007.rest(iter_79_1[2], 2)
							ipairs = var_8

							for iter_79_4, iter_79_5 in var_8(var_3_10007) do
								local var_79_3 = arg_78_0
								local var_79_4 = var_13.Find(var_79_3, iter_79_5)

								IsNil = var_79_3

								if not var_79_3(var_79_4) and not var_79_0 then
									setActive = var_14

									var_14(var_79_4, false)
								end
							end
						elseif iter_79_1[1] == var_0_4 then
							_ = var_3_10007
							var_3_10007 = var_3_10007.rest(iter_79_1[2], 2)
							ipairs = var_8

							for iter_79_6, iter_79_7 in var_8(var_3_10007) do
								local var_79_5 = arg_78_0
								local var_79_6 = var_13.Find(var_79_5, iter_79_7)

								IsNil = var_79_5

								if not var_79_5(var_79_6) and not var_79_0 then
									setActive = var_14

									var_14(var_79_6, true)

									return
								end
							end
						elseif iter_79_1[1] == var_0_5 then
							_ = var_3_10007
							var_3_10007 = var_3_10007.rest(iter_79_1[2], 2)
							ipairs = var_8

							for iter_79_8, iter_79_9 in var_8(var_3_10007) do
								local var_79_7 = arg_78_0
								local var_79_8 = var_13.Find(var_79_7, iter_79_9)

								IsNil = var_79_7

								if not var_79_7(var_79_8) and not var_79_0 then
									setActive = var_14

									var_14(var_79_8, true)
								end
							end
						end
					end

					return
				end)()
			end
		end

		return
	end

	local var_77_3 = arg_77_0.loader
	local var_77_4 = var_6.GetPrefab(var_77_3, "ui/" .. arg_77_1, arg_77_1, function(arg_80_0)
		arg_80_0:SetActive(true)

		local var_80_0 = arg_77_0.mapTFs[arg_77_2]

		setParent = var_2

		var_2(arg_80_0, var_80_0)

		pg = var_2

		local var_80_1 = var_2.ViewUtils.SetSortingOrder
		local var_80_2 = arg_80_0

		ChapterConst = var_4

		var_80_1(var_80_2, var_4.LayerWeightMap + arg_77_2 * 2 - 1)
		var_77_2(arg_80_0)

		return
	end)

	table = var_77_3

	var_77_3.insert(arg_77_0.mapGroup, var_77_4)

	return
end

function var_0_1.HideBtns(arg_81_0)
	setActive = var_1_10001

	var_1_10001(arg_81_0.btnPrev, false)

	setActive = var_1_10001

	var_1_10001(arg_81_0.eliteQuota, false)

	setActive = var_1_10001

	var_1_10001(arg_81_0.escortBar, false)

	setActive = var_1_10001

	var_1_10001(arg_81_0.skirmishBar, false)

	setActive = var_1_10001

	var_1_10001(arg_81_0.normalBtn, false)

	setActive = var_1_10001

	var_1_10001(arg_81_0.actNormalBtn, false)

	setActive = var_1_10001

	var_1_10001(arg_81_0.eliteBtn, false)

	setActive = var_1_10001

	var_1_10001(arg_81_0.actEliteBtn, false)

	setActive = var_1_10001

	var_1_10001(arg_81_0.actExtraBtn, false)

	setActive = var_1_10001

	var_1_10001(arg_81_0.remasterBtn, false)

	setActive = var_1_10001

	var_1_10001(arg_81_0.btnNext, false)

	setActive = var_1_10001

	var_1_10001(arg_81_0.remasterAwardBtn, false)

	setActive = var_1_10001

	var_1_10001(arg_81_0.eventContainer, false)

	setActive = var_1_10001

	var_1_10001(arg_81_0.activityBtn, false)

	setActive = var_1_10001

	var_1_10001(arg_81_0.ptTotal, false)

	setActive = var_1_10001

	var_1_10001(arg_81_0.ticketTxt.parent, false)

	setActive = var_1_10001

	var_1_10001(arg_81_0.countDown, false)

	setActive = var_1_10001

	var_1_10001(arg_81_0.actAtelierBuffBtn, false)

	setActive = var_1_10001

	var_1_10001(arg_81_0.actAtelierYumiaBuffBtn, false)

	setActive = var_1_10001

	var_1_10001(arg_81_0.actExtraRank, false)

	setActive = var_1_10001

	var_1_10001(arg_81_0.actExchangeShopBtn, false)

	setActive = var_1_10001

	var_1_10001(arg_81_0.mapHelpBtn, false)

	return
end

function var_0_1.updateDifficultyBtns(arg_82_0)
	local var_82_0 = arg_82_0.contextData.map
	local var_82_1 = var_1.getConfig(var_82_0, "type")

	setActive = var_82_0

	local var_82_2 = arg_82_0.normalBtn

	Map = var_1_10005

	var_82_0(var_82_2, var_82_1 == var_1_10005.ELITE)

	setActive = var_82_0

	local var_82_3 = arg_82_0.eliteQuota

	Map = var_5

	var_82_0(var_82_3, var_82_1 == var_5.ELITE)

	setActive = var_82_0

	local var_82_4 = arg_82_0.eliteBtn

	Map = var_5

	var_82_0(var_82_4, var_82_1 == var_5.SCENARIO)

	getProxy = var_82_0
	ActivityProxy = var_82_4

	local var_82_5 = var_82_0(var_82_4)
	local var_82_6 = var_3.getActivityById

	ActivityConst = var_1_10006

	local var_82_7 = var_82_6(var_82_5, var_1_10006.ELITE_AWARD_ACTIVITY_ID)

	setActive = var_82_5

	local var_82_8 = arg_82_0.eliteBtn

	var_82_5(var_6.Find(var_82_8, "pic_activity"), var_82_7 and not var_82_7:isEnd())

	return
end

function var_0_1.updateActivityBtns(arg_83_0)
	local var_83_0 = arg_83_0.contextData.map
	local var_83_1, var_83_2 = var_1.isActivity(var_83_0)
	local var_83_3 = var_1:isRemaster()
	local var_83_4 = var_1:isSkirmish()
	local var_83_5 = var_1:isEscort()
	local var_83_6 = var_1
	local var_83_7 = var_1.getConfig(var_83_6, "type")

	setmetatable = var_83_6

	local var_83_8 = {}

	MainActMapBtn = var_1_10010

	local var_83_9 = var_83_6(var_83_8, var_1_10010)
	local var_83_10

	if var_8.InShowTime(var_83_9) then
		var_83_10 = not var_83_1 and not var_83_4 and not var_83_5
	end

	arg_83_0.activityBtnLinkAct = var_8:GetActivity()

	local var_83_13

	if var_83_10 then
		local var_83_11 = arg_83_0.activityBtn
		local var_83_12 = var_83_13.Find(var_83_11, "Image")

		var_83_13 = var_83_13.GetComponent
		typeof = var_12
		Image = var_1_10013
		var_8.image = var_83_13(var_83_12, var_12(var_1_10013))

		local var_83_14 = arg_83_0.activityBtn
		local var_83_15 = var_83_13.Find(var_83_14, "sub_Image")

		var_83_13 = var_83_13.GetComponent
		typeof = var_12
		Image = var_1_10013
		var_8.subImage = var_83_13(var_83_15, var_12(var_1_10013))

		local var_83_16 = arg_83_0.activityBtn
		local var_83_17 = var_83_13.Find(var_83_16, "Tip")

		var_83_13 = var_83_13.GetComponent
		typeof = var_12
		Image = var_1_10013
		var_8.tipTr = var_83_13(var_83_17, var_12(var_1_10013))

		local var_83_18 = arg_83_0.activityBtn
		local var_83_19 = var_83_13.Find(var_83_18, "Tip/Text")

		var_83_13 = var_83_13.GetComponent
		typeof = var_12
		Text = var_1_10013
		var_8.tipTxt = var_83_13(var_83_19, var_12(var_1_10013))

		if var_8:InShowTime() then
			var_8:InitTipImage()
			var_8:InitSubImage()
			var_8:InitImage(function()
				return
			end)
			var_8:OnInit()
		end
	end

	setActive = var_83_13

	var_83_13(arg_83_0.activityBtn, var_83_10)
	arg_83_0:updateRemasterInfo()

	if var_83_1 and var_83_2 then
		local var_83_20
		local var_83_21 = var_1
		local var_83_23

		if var_1.isRemaster(var_83_21) then
			getProxy = var_83_23
			ChapterProxy = var_83_21
			var_83_21 = var_83_23(var_83_21)
			var_83_20 = var_83_23.getRemasterMaps(var_83_21, var_1.remasterId)
		else
			getProxy = var_83_23
			ChapterProxy = var_83_21

			local var_83_22 = var_83_23(var_83_21)

			var_83_23 = var_83_23.getMapsByActivities
			var_1_10014 = var_1
			var_83_20 = var_83_23(var_83_22, var_1.getConfig(var_1_10014, "on_activity"))
		end

		underscore = var_83_23

		local var_83_24 = var_83_23.any(var_83_20, function(arg_85_0)
			return arg_85_0:isActExtra()
		end)

		setActive = var_12

		local var_83_25 = arg_83_0.actExtraBtn

		if var_83_24 then
			::label_83_0::

			Map = var_1_10014
			var_1_10014 = var_83_7 ~= var_1_10014.ACT_EXTRA
		end

		var_12(var_83_25, var_1_10014)

		isActive = var_12

		local var_83_26

		if var_12(arg_83_0.actExtraBtn) then
			underscore = var_83_26
			var_83_26 = var_83_26.all
			underscore = var_13

			if var_83_26(var_13.filter(var_83_20, function(arg_86_0)
				local var_86_0 = arg_86_0
				local var_86_1 = arg_86_0.getMapType(var_86_0)

				Map = var_86_0

				local var_86_2

				if var_86_1 ~= var_86_0.ACTIVITY_EASY then
					Map = var_2

					if var_86_1 ~= var_2.ACTIVITY_HARD then
						var_86_2 = false

						goto label_86_0
					end
				end

				var_86_2 = true

				::label_86_0::

				return var_86_2
			end), function(arg_87_0)
				return arg_87_0:isAllChaptersClear()
			end) then
				setActive = var_83_26

				var_83_26(arg_83_0.actExtraBtnAnim, true)
			else
				setActive = var_83_26

				var_83_26(arg_83_0.actExtraBtnAnim, false)
			end

			setActive = var_83_26

			local var_83_27 = arg_83_0.actExtraBtn
			local var_83_28 = var_13.Find(var_83_27, "Tip")

			getProxy = var_83_27
			ChapterProxy = var_1_10015
			var_1_10015 = var_83_27(var_1_10015)

			local var_83_29 = var_14.IsActivitySPChapterActive

			var_1_10017 = var_1

			local var_83_30

			if var_83_29(var_1_10015, var_1.getConfig(var_1_10017, "on_activity")) then
				SettingsProxy = var_83_30
				var_83_30 = var_83_30.IsShowActivityMapSPTip()
			end

			var_83_26(var_83_28, var_83_30)
		end

		checkExist = var_83_26

		local var_83_31 = var_83_26(var_1:getBindMap(), {
			"isHardMap"
		})

		setActive = var_13

		local var_83_32 = arg_83_0.actEliteBtn

		if var_83_31 then
			::label_83_1::

			Map = var_1_10015
			var_1_10015 = var_83_7 ~= var_1_10015.ACTIVITY_HARD
		end

		var_13(var_83_32, var_1_10015)

		setActive = var_13

		local var_83_33 = arg_83_0.actNormalBtn

		Map = var_1_10015

		var_13(var_83_33, var_83_7 ~= var_1_10015.ACTIVITY_EASY)

		setActive = var_13

		local var_83_34 = arg_83_0.actExtraRank

		Map = var_15

		local var_83_37

		if var_83_7 == var_15.ACT_EXTRA then
			_ = var_15

			local var_83_35 = var_15.any

			getProxy = var_1_10016
			ActivityProxy = var_1_10017
			var_1_10017 = var_1_10016(var_1_10017)

			local var_83_36 = var_16.getActivitiesByType

			ActivityConst = var_1_10018
			var_83_37 = var_83_35(var_83_36(var_1_10017, var_1_10018.ACTIVITY_TYPE_EXTRA_CHAPTER_RANK), function(arg_88_0)
				if not arg_88_0 or arg_88_0:isEnd() then
					return
				end

				local var_88_0 = arg_88_0
				local var_88_1 = arg_88_0.getConfig(var_88_0, "config_data")[1]

				_ = var_88_0

				local var_88_2 = var_88_0.any
				local var_88_3 = var_0

				return var_88_2(var_3.getChapters(var_88_3), function(arg_89_0)
					if not arg_89_0:IsEXChapter() then
						return false
					end

					table = var_1

					return var_1.contains(arg_89_0:getConfig("boss_expedition_id"), var_88_1)
				end)
			end)
		else
			var_83_37 = false
		end

		if false then
			var_83_37 = true
		end

		var_13(var_83_34, var_83_37)

		setActive = var_13

		local var_83_38 = arg_83_0.actExchangeShopBtn

		ActivityConst = var_83_37

		var_13(var_83_38, not var_83_37.HIDE_PT_PANELS and not var_83_3 and var_83_2 and arg_83_0:IsActShopActive())

		if arg_83_0.contextData.map then
			getProxy = var_13
			ActivityProxy = var_83_38

			local var_83_39 = var_13(var_83_38)
			local var_83_40 = var_13.getActivityById
			local var_83_41 = arg_83_0.contextData.map
			local var_83_42

			if not var_83_40(var_83_39, var_15.getConfig(var_83_41, "on_activity")) then
				var_83_42 = nil
			end

			local var_83_43 = var_83_42 and not var_83_42:isEnd() and var_83_42:GetConfigClientSetting("PTID")
			local var_83_44 = arg_83_0
			local var_83_45 = arg_83_0.updatePtActivity

			underscore = var_1_10017

			local var_83_46 = var_1_10017.detect

			getProxy = var_1_10018
			ActivityProxy = var_1_10019

			local var_83_47 = var_1_10018(var_1_10019)
			local var_83_48 = var_18.getActivitiesByType

			ActivityConst = var_1_10020

			var_83_45(var_83_44, var_83_46(var_83_48(var_83_47, var_1_10020.ACTIVITY_TYPE_PT_RANK), function(arg_90_0)
				return arg_90_0:getConfig("config_id") == var_83_43
			end))

			setActive = var_83_45

			local var_83_49 = arg_83_0.ptTotal

			ActivityConst = var_17

			local var_83_51

			if not var_17.HIDE_PT_PANELS and not var_83_3 then
				if var_83_2 and arg_83_0.ptActivity then
					local var_83_50 = arg_83_0.ptActivity

					var_83_51 = not var_17.isEnd(var_83_50)
				end
			else
				var_83_51 = false
			end

			if false then
				var_83_51 = true
			end

			var_83_45(var_83_49, var_83_51)

			if false then
				setActive = var_83_20

				var_83_20(arg_83_0.actExtraBtn, false)

				setActive = var_83_20

				var_83_20(arg_83_0.actEliteBtn, false)

				setActive = var_83_20

				var_83_20(arg_83_0.actNormalBtn, false)

				setActive = var_83_20

				var_83_20(arg_83_0.actExtraRank, false)

				setActive = var_83_20

				var_83_20(arg_83_0.actExchangeShopBtn, false)

				setActive = var_83_20

				var_83_20(arg_83_0.actAtelierBuffBtn, false)

				setActive = var_83_20

				var_83_20(arg_83_0.actAtelierYumiaBuffBtn, false)

				setActive = var_83_20

				var_83_20(arg_83_0.ptTotal, false)
			end

			setActive = var_83_20

			var_83_20(arg_83_0.eventContainer, (not var_83_1 or not var_83_2) and not var_83_5)

			setActive = var_83_20

			local var_83_52 = arg_83_0.remasterBtn

			OPEN_REMASTER = var_83_53

			local var_83_53 = var_83_53 and (var_83_3 or not var_83_1 and not var_83_5 and not var_83_4)

			var_83_20(var_83_52, var_83_53)

			setActive = var_83_20

			var_83_20(arg_83_0.ticketTxt.parent, var_83_3)
			arg_83_0:updateRemasterTicket()
			arg_83_0:updateCountDown()

			return
		end
	end
end

function var_0_1.updateRemasterTicket(arg_91_0)
	setText = var_1_10001

	local var_91_0 = arg_91_0.ticketTxt

	getProxy = var_1_10003
	ChapterProxy = var_1_10004

	local var_91_1 = var_1_10003(var_1_10004).remasterTickets
	local var_91_2 = " / "

	pg = var_1_10005

	var_1_10001(var_91_0, var_91_1 .. var_91_2 .. var_1_10005.gameset.reactivity_ticket_max.key_value)

	local var_91_3 = arg_91_0
	local var_91_4 = arg_91_0.emit

	LevelUIConst = var_3

	var_91_4(var_91_3, var_3.FLUSH_REMASTER_TICKET)

	return
end

function var_0_1.updateRemasterBtnTip(arg_92_0)
	getProxy = var_1_10001
	ChapterProxy = var_1_10002

	local var_92_0 = var_1_10001(var_1_10002)
	local var_92_1

	if not var_1.ifShowRemasterTip(var_92_0) then
		var_92_0 = var_1
		var_92_1 = var_1.anyRemasterAwardCanReceive(var_92_0)
	end

	SetActive = var_92_0

	local var_92_2 = arg_92_0.remasterBtn

	var_92_0(var_4.Find(var_92_2, "tip"), var_92_1)

	SetActive = var_92_0

	local var_92_3 = arg_92_0.entranceLayer

	var_92_0(var_4.Find(var_92_3, "btns/btn_remaster/tip"), var_92_1)

	return
end

function var_0_1.updatDailyBtnTip(arg_93_0)
	getProxy = var_1_10001
	DailyLevelProxy = var_1_10002

	local var_93_0 = var_1_10001(var_1_10002)
	local var_93_1 = var_1.ifShowDailyTip(var_93_0)

	SetActive = var_93_0

	local var_93_2 = arg_93_0.dailyBtn

	var_93_0(var_4.Find(var_93_2, "tip"), var_93_1)

	SetActive = var_93_0

	local var_93_3 = arg_93_0.entranceLayer

	var_93_0(var_4.Find(var_93_3, "btns/btn_daily/tip"), var_93_1)

	return
end

function var_0_1.updateRemasterInfo(arg_94_0)
	local var_94_0 = arg_94_0
	local var_94_1 = arg_94_0.emit

	LevelUIConst = var_1_10003

	var_94_1(var_94_0, var_1_10003.FLUSH_REMASTER_INFO)

	if not arg_94_0.contextData.map then
		return
	end

	getProxy = var_1
	ChapterProxy = var_94_0

	local var_94_2 = var_1(var_94_0)
	local var_94_3 = arg_94_0.contextData.map
	local var_94_4 = var_2.getRemaster(var_94_3)

	BossRushChapterRemasterHelper = var_94_3

	local var_94_5 = var_94_3.ChapterAwardInfo(var_94_4)

	setActive = var_4

	var_4(arg_94_0.remasterAwardBtn, var_94_5)

	if var_94_5 then
		local var_94_6 = var_94_5[1]

		unpack = var_5

		local var_94_7, var_94_8, var_94_9, var_94_10, var_94_11 = var_5(var_94_5[2])
		local var_94_12 = var_94_5[3]
		local var_94_13 = var_94_2
		local var_94_14 = var_94_2.getRemasterInfo(var_94_13, var_94_12, var_94_7, var_94_6)

		setText = var_94_13

		local var_94_15 = arg_94_0.remasterAwardBtn

		var_94_13(var_12.Find(var_94_15, "Text"), var_94_14.count .. "/" .. var_94_10)

		updateDrop = var_94_13

		local var_94_16 = arg_94_0.remasterAwardBtn

		var_94_13(var_12.Find(var_94_16, "IconTpl"), {
			type = var_94_8,
			id = var_94_9
		})

		setActive = var_94_13

		local var_94_17 = arg_94_0.remasterAwardBtn

		var_94_13(var_12.Find(var_94_17, "tip"), var_94_10 <= var_94_14.count)

		onButton = var_94_13

		local var_94_18 = arg_94_0
		local var_94_19 = arg_94_0.remasterAwardBtn

		local function var_94_20()
			BossRushChapterRemasterHelper = var_2_10000

			local var_95_0 = var_2_10000.GetAwardName(var_94_12, var_94_7)

			pg = var_1

			local var_95_1 = var_1.MsgboxMgr.GetInstance()
			local var_95_2 = var_1.ShowMsgBox
			local var_95_3 = {
				hideYes = true,
				hideNo = true
			}

			MSGBOX_TYPE_SINGLE_ITEM = var_2_10004
			var_95_3.type = var_2_10004
			var_95_3.drop = {
				type = var_94_8,
				id = var_94_9
			}

			local var_95_4 = {}

			i18n = var_5
			var_95_4.word = var_5("level_remaster_tip4", var_95_0)
			var_95_4.number = var_94_14.count .. "/" .. var_94_10
			i18n = var_5
			var_95_4.btn_text = var_5(var_94_14.count < var_94_10 and "level_remaster_tip2" or "level_remaster_tip3")

			function var_95_4.btn_call()
				if var_94_14.count < var_94_10 then
					local var_96_1

					if var_94_12 and var_94_12 > 0 then
						local var_96_0 = arg_94_0

						var_96_1 = var_96_1.emit
						LevelMediator2 = var_3_10002

						var_96_1(var_96_0, var_3_10002.ON_BOSSRUSH_REMASTER_ACTIVITY, var_94_12)

						return
					end

					pg = var_96_1

					local var_96_2 = var_96_1.chapter_template[var_94_7].map

					var_3_10002 = var_94_2
					var_3_10002 = var_1.getMapById(var_3_10002, var_96_2)

					local var_96_3

					var_96_3, var_3_10002 = var_1.isUnlock(var_3_10002)

					if not var_96_3 then
						pg = var_3

						local var_96_4 = var_3.TipsMgr.GetInstance()

						var_3.ShowTips(var_96_4, var_3_10002)
					else
						local var_96_5 = arg_94_0

						var_3.ShowSelectedMap(var_96_5, var_96_2)
					end
				else
					local var_96_6 = arg_94_0
					local var_96_7 = var_0.emit

					LevelMediator2 = var_3_10002

					var_96_7(var_96_6, var_3_10002.ON_CHAPTER_REMASTER_AWARD, var_94_7, var_94_6, var_94_12)
				end

				return
			end

			var_95_3.remaster = var_95_4

			var_95_2(var_95_1, var_95_3)

			return
		end

		SFX_PANEL = var_15

		var_94_13(var_94_18, var_94_19, var_94_20, var_15)
	end

	return
end

function var_0_1.updateCountDown(arg_97_0)
	getProxy = var_1_10001
	ChapterProxy = var_1_10002

	local var_97_0 = var_1_10001(var_1_10002)

	if arg_97_0.newChapterCDTimer then
		local var_97_1 = arg_97_0.newChapterCDTimer

		var_2.Stop(var_97_1)

		arg_97_0.newChapterCDTimer = nil
	end

	local var_97_2 = 0
	local var_97_3 = arg_97_0.contextData.map
	local var_97_6

	if var_3.isActivity(var_97_3) then
		local var_97_4 = arg_97_0.contextData.map

		if not var_97_6.isRemaster(var_97_4) then
			local var_97_5 = var_97_0

			var_97_6 = var_97_0.getMapsByActivities

			local var_97_7 = arg_97_0.contextData.map

			var_97_6 = var_97_6(var_97_5, var_5.getConfig(var_97_7, "on_activity"))
			_ = var_97_5

			var_97_5.each(var_97_6, function(arg_98_0)
				local var_98_0 = arg_98_0:getChapterTimeLimit()

				if var_97_2 == 0 then
					var_97_2 = var_98_0
				else
					math = var_2
					var_97_2 = var_2.min(var_97_2, var_98_0)
				end

				return
			end)

			setActive = var_4

			var_4(arg_97_0.countDown, var_97_2 > 0)

			setText = var_4

			local var_97_8 = arg_97_0.countDown
			local var_97_9 = var_5.Find(var_97_8, "title")

			i18n = var_97_8

			var_4(var_97_9, var_97_8("levelScene_new_chapter_coming"))

			goto label_97_0
		end
	end

	setActive = var_97_6

	var_97_6(arg_97_0.countDown, false)

	::label_97_0::

	if 0 < var_97_2 then
		setText = var_3

		local var_97_10 = arg_97_0.countDown
		local var_97_11 = var_4.Find(var_97_10, "time")

		pg = var_97_10

		local var_97_12 = var_97_10.TimeMgr.GetInstance()

		var_3(var_97_11, var_5.DescCDTime(var_97_12, var_97_2))

		Timer = var_3
		arg_97_0.newChapterCDTimer = var_3.New(function()
			var_97_2 = var_97_2 - 1

			if var_97_2 <= 0 then
				local var_99_0 = arg_97_0

				var_0.updateCountDown(var_99_0)

				if not arg_97_0.contextData.chapterVO then
					local var_99_1 = arg_97_0

					var_0.setMap(var_99_1, arg_97_0.contextData.mapIdx)
				end
			else
				setText = var_0

				local var_99_2 = arg_97_0.countDown
				local var_99_3 = var_1.Find(var_99_2, "time")

				pg = var_99_2

				local var_99_4 = var_99_2.TimeMgr.GetInstance()

				var_0(var_99_3, var_2.DescCDTime(var_99_4, var_97_2))
			end

			return
		end, 1, -1)

		local var_97_13 = arg_97_0.newChapterCDTimer

		var_3.Start(var_97_13)
	else
		setText = var_3

		local var_97_14 = arg_97_0.countDown

		var_3(var_4.Find(var_97_14, "time"), "")
	end

	return
end

function var_0_1.registerActBtn(arg_100_0)
	onButton = var_1_10001

	local var_100_0 = arg_100_0
	local var_100_1 = arg_100_0.actExtraRank

	local function var_100_2()
		local var_101_0 = arg_100_0

		if var_0.isfrozen(var_101_0) then
			return
		end

		local var_101_1 = arg_100_0
		local var_101_2 = var_0.emit

		LevelMediator2 = var_2_10002

		var_101_2(var_101_1, var_2_10002.ON_EXTRA_RANK)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_100_0, var_100_1, var_100_2, var_1_10005)

	onButton = var_1_10001

	local var_100_3 = arg_100_0
	local var_100_4 = arg_100_0.activityBtn

	local function var_100_5()
		local var_102_0 = arg_100_0

		if var_0.isfrozen(var_102_0) then
			return
		end

		if arg_100_0.activityBtnLinkAct then
			local var_102_1 = arg_100_0.activityBtnLinkAct
			local var_102_2 = var_0.getConfig(var_102_1, "type")
			local var_102_3 = arg_100_0.activityBtnLinkAct.id

			ActivityConst = var_2_10002

			if var_102_2 == var_2_10002.ACTIVITY_TYPE_BOSSRUSH then
				pg = var_2_10002

				local var_102_4 = var_2_10002.m02

				var_2_10002 = var_2_10002.sendNotification
				GAME = var_2_10004
				var_2_10004 = var_2_10004.GO_SCENE
				SCENE = var_2_10005

				var_2_10002(var_102_4, var_2_10004, var_2_10005.BOSSRUSH_MAIN)

				return
			else
				ActivityConst = var_2_10002

				if var_102_2 == var_2_10002.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB then
					pg = var_2_10002

					local var_102_5 = var_2_10002.m02

					var_2_10002 = var_2_10002.sendNotification
					GAME = var_2_10004
					var_2_10004 = var_2_10004.GO_SCENE
					SCENE = var_2_10005

					var_2_10002(var_102_5, var_2_10004, var_2_10005.BOSSRUSH_DAL_COLLAB)

					return
				else
					ActivityConst = var_2_10002

					if var_102_3 == var_2_10002.OTHER_WORLD_TERMINAL_BATTLE_ID then
						pg = var_2_10002

						local var_102_6 = var_2_10002.m02

						var_2_10002 = var_2_10002.sendNotification
						GAME = var_2_10004
						var_2_10004 = var_2_10004.GO_SCENE
						SCENE = var_2_10005

						var_2_10002(var_102_6, var_2_10004, var_2_10005.OTHERWORLD_MAP)

						return
					else
						ActivityConst = var_2_10002

						if var_102_2 == var_2_10002.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2 then
							pg = var_2_10002

							local var_102_7 = var_2_10002.m02

							var_2_10002 = var_2_10002.sendNotification
							GAME = var_2_10004

							local var_102_8 = var_2_10004.GO_SCENE

							SCENE = var_2_10005

							var_2_10002(var_102_7, var_102_8, var_2_10005.ZHANG_WU_BOSS)

							return
						end
					end
				end
			end
		end

		local var_102_9 = arg_100_0
		local var_102_10 = var_0.emit

		LevelMediator2 = var_2_10002

		var_102_10(var_102_9, var_2_10002.ON_ACTIVITY_MAP)

		return
	end

	SFX_UI_CLICK = var_1_10005

	var_1_10001(var_100_3, var_100_4, var_100_5, var_1_10005)

	onButton = var_1_10001

	local var_100_6 = arg_100_0
	local var_100_7 = arg_100_0.actExchangeShopBtn

	local function var_100_8()
		local var_103_0 = arg_100_0

		if var_0.isfrozen(var_103_0) then
			return
		end

		local var_103_1 = arg_100_0
		local var_103_2 = var_0.emit

		LevelMediator2 = var_2_10002

		var_103_2(var_103_1, var_2_10002.GO_ACT_SHOP)

		return
	end

	SFX_UI_CLICK = var_1_10005

	var_1_10001(var_100_6, var_100_7, var_100_8, var_1_10005)

	onButton = var_1_10001

	local var_100_9 = arg_100_0
	local var_100_10 = arg_100_0.actAtelierBuffBtn

	local function var_100_11()
		local var_104_0 = arg_100_0

		if var_0.isfrozen(var_104_0) then
			return
		end

		local var_104_1 = arg_100_0
		local var_104_2 = var_0.emit

		LevelMediator2 = var_2_10002

		var_104_2(var_104_1, var_2_10002.SHOW_ATELIER_BUFF)

		return
	end

	SFX_UI_CLICK = var_1_10005

	var_1_10001(var_100_9, var_100_10, var_100_11, var_1_10005)

	onButton = var_1_10001

	local var_100_12 = arg_100_0
	local var_100_13 = arg_100_0.actAtelierYumiaBuffBtn

	local function var_100_14()
		local var_105_0 = arg_100_0

		if var_0.isfrozen(var_105_0) then
			return
		end

		local var_105_1 = arg_100_0
		local var_105_2 = var_0.emit

		LevelMediator2 = var_2_10002

		var_105_2(var_105_1, var_2_10002.SHOW_ATELIER_BUFF, true)

		return
	end

	SFX_UI_CLICK = var_1_10005

	var_1_10001(var_100_12, var_100_13, var_100_14, var_1_10005)

	getProxy = var_1_10001
	ChapterProxy = var_100_12

	local var_100_15 = var_1_10001(var_100_12)

	local function var_100_16(arg_106_0, arg_106_1, arg_106_2)
		local var_106_0

		if arg_106_0:isRemaster() then
			local var_106_1 = var_100_15

			var_106_0 = var_4.getRemasterMaps(var_106_1, arg_106_0.remasterId)
		else
			local var_106_2 = var_100_15

			var_106_0 = var_4.getMapsByActivities(var_106_2, arg_106_0:getConfig("on_activity"))
		end

		_ = var_4

		local var_106_3 = var_4.select(var_106_0, function(arg_107_0)
			return arg_107_0:getMapType() == arg_106_1
		end)

		table = var_4

		var_4.sort(var_106_3, function(arg_108_0, arg_108_1)
			return arg_108_0.id < arg_108_1.id
		end)

		table = var_4

		local var_106_4 = var_4.indexof

		underscore = var_5

		local var_106_5

		if not var_106_4(var_5.map(var_106_3, function(arg_109_0)
			return arg_109_0.id
		end), arg_106_2) then
			var_106_5 = #var_106_3
		end

		::label_106_0::

		local var_106_6 = var_106_3[var_106_5]

		if not var_5.isUnlock(var_106_6) then
			repeat
				if var_106_5 > 1 then
					var_106_5 = var_106_5 - 1
				else
					break
				end

				goto label_106_0
			until true
		end

		return var_106_3[var_106_5]
	end

	local var_100_17 = arg_100_0
	local var_100_18 = arg_100_0.bind

	LevelUIConst = var_1_10005

	var_100_18(var_100_17, var_1_10005.SWITCH_ACT_MAP, function(arg_110_0, arg_110_1, arg_110_2)
		if not arg_110_2 then
			switch = var_2_10003

			local var_110_0 = arg_110_1
			local var_110_1 = {}

			Map = var_2_10006
			var_110_1[var_2_10006.ACTIVITY_EASY] = function()
				local var_111_0 = arg_100_0.contextData.map

				return var_0.getBindMapId(var_111_0)
			end
			Map = var_6
			var_110_1[var_6.ACTIVITY_HARD] = function()
				local var_112_0 = arg_100_0.contextData.map

				return var_0.getBindMapId(var_112_0)
			end
			Map = var_6
			var_110_1[var_6.ACT_EXTRA] = function()
				PlayerPrefs = var_3_10000

				return var_3_10000.GetInt("ex_mapId", 0)
			end
			arg_110_2 = var_2_10003(var_110_0, var_110_1)
		end

		local var_110_2 = var_100_16(arg_100_0.contextData.map, arg_110_1, arg_110_2)
		local var_110_3, var_110_4 = var_3.isUnlock(var_110_2)

		if var_110_3 then
			local var_110_5 = arg_100_0

			var_6.setMap(var_110_5, var_3.id)
		else
			pg = var_6

			local var_110_6 = var_6.TipsMgr.GetInstance()

			var_6.ShowTips(var_110_6, var_110_4)
		end

		return
	end)

	onButton = var_100_18

	local var_100_19 = arg_100_0
	local var_100_20 = arg_100_0.actNormalBtn

	local function var_100_21()
		local var_114_0 = arg_100_0

		if var_0.isfrozen(var_114_0) then
			return
		end

		local var_114_1 = arg_100_0
		local var_114_2 = var_0.emit

		LevelUIConst = var_2_10002

		local var_114_3 = var_2_10002.SWITCH_ACT_MAP

		Map = var_2_10003

		var_114_2(var_114_1, var_114_3, var_2_10003.ACTIVITY_EASY)

		return
	end

	SFX_PANEL = var_1_10007

	var_100_18(var_100_19, var_100_20, var_100_21, var_1_10007)

	onButton = var_100_18

	local var_100_22 = arg_100_0
	local var_100_23 = arg_100_0.actEliteBtn

	local function var_100_24()
		local var_115_0 = arg_100_0

		if var_0.isfrozen(var_115_0) then
			return
		end

		local var_115_1 = arg_100_0
		local var_115_2 = var_0.emit

		LevelUIConst = var_2_10002

		local var_115_3 = var_2_10002.SWITCH_ACT_MAP

		Map = var_2_10003

		var_115_2(var_115_1, var_115_3, var_2_10003.ACTIVITY_HARD)

		return
	end

	SFX_PANEL = var_1_10007

	var_100_18(var_100_22, var_100_23, var_100_24, var_1_10007)

	onButton = var_100_18

	local var_100_25 = arg_100_0
	local var_100_26 = arg_100_0.actExtraBtn

	local function var_100_27()
		local var_116_0 = arg_100_0

		if var_0.isfrozen(var_116_0) then
			return
		end

		local var_116_1 = arg_100_0
		local var_116_2 = var_0.emit

		LevelUIConst = var_2_10002

		local var_116_3 = var_2_10002.SWITCH_ACT_MAP

		Map = var_2_10003

		var_116_2(var_116_1, var_116_3, var_2_10003.ACT_EXTRA)

		return
	end

	SFX_PANEL = var_1_10007

	var_100_18(var_100_25, var_100_26, var_100_27, var_1_10007)

	return
end

function var_0_1.initCloudsPos(arg_117_0, arg_117_1)
	arg_117_0.initPositions = {}

	local var_117_0 = arg_117_1 or 1

	pg = var_1_10003

	local var_117_1 = var_1_10003.expedition_data_by_map[var_117_0].clouds_pos

	ipairs = var_1_10004

	for iter_117_0, iter_117_1 in var_1_10004(arg_117_0.cloudRTFs) do
		if var_117_1[iter_117_0] then
			Vector2 = var_1_10010
			iter_117_1.anchoredPosition = var_1_10010(var_9[1], var_9[2])
			table = var_1_10010

			var_1_10010.insert(arg_117_0.initPositions, iter_117_1.anchoredPosition)
		else
			setActive = var_1_10010

			var_1_10010(iter_117_1, false)
		end
	end

	return
end

function var_0_1.initMapBtn(arg_118_0, arg_118_1, arg_118_2)
	onButton = var_1_10003

	local var_118_0 = arg_118_0
	local var_118_1 = arg_118_1

	local function var_118_2()
		local var_119_0 = arg_118_0

		if var_0.isfrozen(var_119_0) then
			return
		end

		local var_119_1 = arg_118_0.contextData.mapIdx + arg_118_2

		getProxy = var_1
		ChapterProxy = var_2_10002

		local var_119_2 = var_1(var_2_10002)

		if not var_1.getMapById(var_119_2, var_119_1) then
			return
		end

		local var_119_3 = var_1
		local var_119_4 = var_1.getMapType(var_119_3)

		Map = var_119_3

		if var_119_4 == var_119_3.ELITE and not var_1:isEliteEnabled() then
			var_119_1 = var_1:getBindMap().id
			pg = var_3

			local var_119_5 = var_3.TipsMgr.GetInstance()
			local var_119_6 = var_3.ShowTips

			i18n = var_2_10005

			var_119_6(var_119_5, var_2_10005("elite_disable_unusable"))
		end

		local var_119_7, var_119_8 = var_1:isUnlock()

		if arg_118_2 > 0 and not var_119_7 then
			pg = var_5

			local var_119_9 = var_5.TipsMgr.GetInstance()

			var_5.ShowTips(var_119_9, var_119_8)

			return
		end

		local var_119_10 = arg_118_0

		var_5.setMap(var_119_10, var_119_1)

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10003(var_118_0, var_118_1, var_118_2, var_1_10007)

	return
end

function var_0_1.ShowSelectedMap(arg_120_0, arg_120_1, arg_120_2)
	seriesAsync = var_1_10003

	var_1_10003({
		function(arg_121_0)
			if arg_120_0.contextData.entranceStatus then
				local var_121_0 = arg_120_0

				var_1.frozen(var_121_0)

				arg_120_0.nextPreloadMap = arg_120_1

				local var_121_1 = arg_120_0

				var_1.PreloadLevelMainUI(var_121_1, arg_120_1, function()
					local var_122_0 = arg_120_0

					var_0.unfrozen(var_122_0)

					if arg_120_0.nextPreloadMap ~= arg_120_1 then
						return
					end

					local var_122_1 = arg_120_0

					var_0.ShowEntranceUI(var_122_1, false)

					local var_122_2 = arg_120_0
					local var_122_3 = var_0.emit

					LevelMediator2 = var_2

					var_122_3(var_122_2, var_2.ON_ENTER_MAINLEVEL, arg_120_1)
					arg_121_0()

					return
				end)
			else
				local var_121_2 = arg_120_0

				var_1.setMap(var_121_2, arg_120_1)
				arg_121_0()
			end

			return
		end
	}, arg_120_2)

	return
end

function var_0_1.setMap(arg_123_0, arg_123_1)
	local var_123_0 = arg_123_0.contextData.mapIdx

	arg_123_0.contextData.mapIdx = arg_123_1

	local var_123_1 = arg_123_0.contextData

	getProxy = var_1_10004
	ChapterProxy = var_1_10005

	local var_123_2 = var_1_10004(var_1_10005)

	var_123_1.map = var_4.getMapById(var_123_2, arg_123_1)
	assert = var_123_1

	var_123_1(arg_123_0.contextData.map, "map cannot be nil " .. arg_123_1)

	local var_123_3 = arg_123_0.contextData.map
	local var_123_4 = var_3.getMapType(var_123_3)

	Map = var_123_3

	if var_123_4 == var_123_3.ACT_EXTRA then
		PlayerPrefs = var_123_4

		var_123_4.SetInt("ex_mapId", arg_123_0.contextData.map.id)

		PlayerPrefs = var_3

		var_3.Save()
	else
		local var_123_5 = arg_123_0.contextData.map

		if var_3.isRemaster(var_123_5) then
			PlayerPrefs = var_3

			var_3.SetInt("remaster_lastmap_" .. arg_123_0.contextData.map.remasterId, arg_123_1)

			PlayerPrefs = var_3

			var_3.Save()
		end
	end

	arg_123_0:RecordLastMapOnExit()
	arg_123_0:updateMap(var_123_0)
	arg_123_0:tryPlayMapStory()

	return
end

import = var_5

local var_0_6 = var_5("view.level.MapBuilder.MapBuilder")
local var_0_7 = {
	[var_0_6.TYPENORMAL] = "MapBuilderNormal",
	[var_0_6.TYPEESCORT] = "MapBuilderEscort",
	[var_0_6.TYPESHINANO] = "MapBuilderShinano",
	[var_0_6.TYPESKIRMISH] = "MapBuilderSkirmish",
	[var_0_6.TYPEBISMARCK] = "MapBuilderBismarck",
	[var_0_6.TYPESSSS] = "MapBuilderSSSS",
	[var_0_6.TYPEATELIER] = "MapBuilderAtelier",
	[var_0_6.TYPESENRANKAGURA] = "MapBuilderSenrankagura",
	[var_0_6.TYPESP] = "MapBuilderSP",
	[var_0_6.TYPESPFULL] = "MapBuilderSPFull",
	[var_0_6.TYPESPSERIES] = "MapBuilderSPSeries",
	[var_0_6.TYPESPSERIESFULL] = "MapBuilderSPSeriesFull",
	[var_0_6.TYPEATELIERYUMIA] = "MapBuilderAtelierYumia",
	[var_0_6.TYPEEXSP] = "MapBuilderEXSP",
	[var_0_6.TYPESPSERIESRECREW] = "MapBuilderSPSeriesRecrew"
}

function var_0_1.SwitchMapBuilder(arg_124_0, arg_124_1)
	if arg_124_0.mapBuilder then
		local var_124_0 = arg_124_0.mapBuilder

		if var_2.GetType(var_124_0) ~= arg_124_1 then
			local var_124_1 = arg_124_0.mapBuilder.buffer

			var_2.Hide(var_124_1)
		end
	end

	arg_124_0.mapBuilder = arg_124_0:GetMapBuilderInBuffer(arg_124_1)

	local var_124_2 = var_2.buffer

	var_3.Show(var_124_2)

	return
end

function var_0_1.GetMapBuilderInBuffer(arg_125_0, arg_125_1)
	if not arg_125_0.mbDict[arg_125_1] then
		_G = var_2

		local var_125_0 = var_2[var_0_7[arg_125_1]]

		assert = var_3

		var_3(var_125_0, "Missing MapBuilder of type " .. (arg_125_1 or "NIL"))

		arg_125_0.mbDict[arg_125_1] = var_125_0.New(arg_125_0._tf, arg_125_0)
		arg_125_0.mbDict[arg_125_1].isFrozen = arg_125_0:isfrozen()

		local var_125_1 = arg_125_0.mbDict[arg_125_1]

		var_3.Load(var_125_1)
	end

	return arg_125_0.mbDict[arg_125_1]
end

function var_0_1.updateMap(arg_126_0, arg_126_1)
	local var_126_0 = arg_126_0.contextData.map
	local var_126_1 = var_2.getConfig(var_126_0, "anchor")
	local var_126_2

	if var_126_1 == "" then
		Vector2 = var_5
		var_126_2 = var_5(0.5, 0.5)
	else
		Vector2 = var_5
		unpack = var_1_10006
		var_126_2 = var_5(var_1_10006(var_126_1))
	end

	arg_126_0.map.pivot = var_126_2

	local var_126_3 = var_2:getConfig("uifx")

	for iter_126_0 = 1, arg_126_0.UIFXList.childCount do
		local var_126_4 = arg_126_0.UIFXList
		local var_126_5 = var_10.GetChild(var_126_4, iter_126_0 - 1)

		setActive = var_126_4

		var_126_4(var_126_5, var_126_5.name == var_126_3)
	end

	arg_126_0:SwitchMapBG(var_2, arg_126_1)
	arg_126_0:PlayBGM()

	local var_126_6 = arg_126_0.contextData.map
	local var_126_7 = var_6.getConfig(var_126_6, "ui_type")

	arg_126_0:SwitchMapBuilder(var_126_7)

	seriesAsync = var_7

	var_7({
		function(arg_127_0)
			local var_127_0 = arg_126_0.mapBuilder

			var_1.CallbackInvoke(var_127_0, arg_127_0)

			return
		end,
		function(arg_128_0)
			local var_128_0 = arg_126_0.mapBuilder

			var_1.UpdateMapVO(var_128_0, var_0)

			local var_128_1 = arg_126_0.mapBuilder

			var_1.UpdateView(var_128_1)

			local var_128_2 = arg_126_0.mapBuilder

			var_1.UpdateMapItems(var_128_2)

			local var_128_3 = arg_126_0.mapBuilder

			var_1.PlayEnterAnim(var_128_3)

			return
		end
	})

	return
end

function var_0_1.UpdateSwitchMapButton(arg_129_0)
	local var_129_0 = arg_129_0.contextData.map

	getProxy = var_1_10002
	ChapterProxy = var_1_10003

	local var_129_1 = var_1_10002(var_1_10003)
	local var_129_2 = var_2.getMapById(var_129_1, var_129_0.id - 1)
	local var_129_3 = var_2
	local var_129_4 = var_2.getMapById(var_129_3, var_129_0.id + 1)

	setActive = var_129_3

	local var_129_5 = arg_129_0.btnPrev

	tobool = var_1_10007

	var_129_3(var_129_5, var_1_10007(var_129_2))

	setActive = var_129_3

	local var_129_6 = arg_129_0.btnNext

	tobool = var_7

	var_129_3(var_129_6, var_7(var_129_4))

	Color = var_129_3

	local var_129_7 = var_129_3.New(0.5, 0.5, 0.5, 1)

	setImageColor = var_6

	local var_129_8 = arg_129_0.btnPrevCol

	if var_129_2 then
		Color = var_8

		local var_129_9

		if not var_8.white then
			var_129_9 = var_129_7
		end

		var_6(var_129_8, var_129_9)

		setImageColor = var_6

		local var_129_10 = arg_129_0.btnNextCol

		if var_129_4 and var_129_4:isUnlock() then
			Color = var_8

			local var_129_11

			if not var_8.white then
				var_129_11 = var_129_7
			end

			var_6(var_129_10, var_129_11)

			return
		end
	end
end

function var_0_1.tryPlayMapStory(arg_130_0)
	IsUnityEditor = var_1_10001

	if var_1_10001 then
		ENABLE_GUIDE = var_1_10001

		if not var_1_10001 then
			return
		end
	end

	seriesAsync = var_1_10001

	var_1_10001({
		function(arg_131_0)
			local var_131_0 = arg_130_0.contextData.map

			if var_1.getConfig(var_131_0, "enter_story") and var_1 ~= "" then
				pg = var_131_0

				local var_131_1 = var_131_0.NewStoryMgr.GetInstance()

				if not var_2.IsPlayed(var_131_1, var_1) then
					local var_131_2 = arg_130_0.contextData.map

					if not var_2.isRemaster(var_131_2) then
						pg = var_2

						if not var_2.SystemOpenMgr.GetInstance().active then
							tonumber = var_2

							local var_131_4

							if var_2(var_1) and 0 < var_2 then
								local var_131_3 = arg_130_0

								var_131_4 = var_131_4.emit
								LevelMediator2 = var_2_10005

								var_131_4(var_131_3, var_2_10005.ON_PERFORM_COMBAT, var_2)
							else
								pg = var_131_4

								local var_131_5 = var_131_4.NewStoryMgr.GetInstance()

								var_3.Play(var_131_5, var_1, arg_131_0)
							end

							return
						end
					end
				end
			end

			arg_131_0()

			return
		end,
		function(arg_132_0)
			local var_132_0 = arg_130_0.contextData.map

			if var_1.getConfig(var_132_0, "guide_id") and var_1 ~= "" then
				pg = var_132_0

				local var_132_1 = var_132_0.SystemGuideMgr.GetInstance()

				var_2.PlayByGuideId(var_132_1, var_1, nil, arg_132_0)

				return
			end

			arg_132_0()

			return
		end,
		function(arg_133_0)
			isActive = var_2_10001

			if var_2_10001(arg_130_0.actAtelierBuffBtn) then
				getProxy = var_1
				ActivityProxy = var_2

				local var_133_0 = var_1(var_2)

				if var_1.AtelierActivityAllSlotIsEmpty(var_133_0) then
					getProxy = var_1
					ActivityProxy = var_133_0

					local var_133_1 = var_1(var_133_0)

					if var_1.OwnAtelierActivityItemCnt(var_133_1, 34, 1) then
						PlayerPrefs = var_1

						local var_133_2 = var_1.GetInt
						local var_133_3 = "first_enter_ryza_buff_"

						getProxy = var_3
						PlayerProxy = var_4

						local var_133_4 = var_3(var_4)
						local var_133_5 = var_133_2(var_133_3 .. var_3.getRawData(var_133_4).id, 0) == 0
						local var_133_6

						if var_133_5 then
							var_133_6 = {
								1,
								2
							}
						else
							var_133_6 = {
								1
							}
						end

						pg = var_3

						local var_133_7 = var_3.SystemGuideMgr.GetInstance()

						var_3.PlayByGuideId(var_133_7, "NG0034", var_133_6)

						goto label_133_0
					end
				end
			end

			arg_133_0()

			::label_133_0::

			return
		end,
		function(arg_134_0)
			if arg_130_0.exited then
				return
			end

			pg = var_1

			local var_134_0 = var_1.SystemOpenMgr.GetInstance()

			var_1.notification(var_134_0, arg_130_0.player.level)

			pg = var_1

			if var_1.SystemOpenMgr.GetInstance().active then
				getProxy = var_1
				ChapterProxy = var_134_0

				local var_134_1 = var_1(var_134_0)

				var_1.StopAutoFight(var_134_1)
			end

			return
		end
	})

	return
end

function var_0_1.DisplaySPAnim(arg_135_0, arg_135_1, arg_135_2, arg_135_3)
	local var_135_0

	if not arg_135_0.uiAnims then
		var_135_0 = {}
	end

	arg_135_0.uiAnims = var_135_0

	local var_135_1 = arg_135_0.uiAnims[arg_135_1]

	local function var_135_2()
		arg_135_0.playing = true

		local var_136_0 = arg_135_0

		var_0.frozen(var_136_0)

		local var_136_1 = var_135_1

		var_0.SetActive(var_136_1, true)

		tf = var_0

		local var_136_2 = var_0(var_135_1)

		pg = var_1

		local var_136_3 = var_1.UIMgr.GetInstance()

		var_1.OverlayPanel(var_136_3, var_136_2)

		if arg_135_3 then
			arg_135_3(var_135_1)
		end

		local var_136_4 = var_136_2:GetComponent("DftAniEvent")

		var_1.SetEndEvent(var_136_4, function(arg_137_0)
			arg_135_0.playing = false

			if arg_135_2 then
				arg_135_2(var_135_1)
			end

			local var_137_0 = arg_135_0

			var_1.unfrozen(var_137_0)

			return
		end)

		pg = var_2

		local var_136_5 = var_2.CriMgr.GetInstance()
		local var_136_6 = var_2.PlaySoundEffect_V3

		SFX_UI_WARNING = var_4

		var_136_6(var_136_5, var_4)

		return
	end

	if not var_135_1 then
		PoolMgr = var_1_10006

		local var_135_3 = var_1_10006.GetInstance()

		var_6.GetUI(var_135_3, arg_135_1, true, function(arg_138_0)
			arg_138_0:SetActive(true)

			arg_135_0.uiAnims[arg_135_1] = arg_138_0
			var_135_1 = arg_135_0.uiAnims[arg_135_1]

			var_135_2()

			return
		end)
	else
		var_135_2()
	end

	return
end

function var_0_1.displaySpResult(arg_139_0, arg_139_1, arg_139_2)
	setActive = var_1_10003

	var_1_10003(arg_139_0.spResult, true)
	arg_139_0:DisplaySPAnim(arg_139_1 == 1 and "SpUnitWin" or "SpUnitLose", function(arg_140_0)
		onButton = var_2_10001

		local var_140_0 = arg_139_0
		local var_140_1 = arg_140_0

		local function var_140_2()
			removeOnButton = var_3_10000

			var_3_10000(arg_140_0)

			setActive = var_3_10000

			var_3_10000(arg_140_0, false)

			pg = var_3_10000

			local var_141_0 = var_3_10000.UIMgr.GetInstance()

			var_0.UnOverlayPanel(var_141_0, arg_140_0, arg_139_0._tf)

			local var_141_1 = arg_139_0

			var_0.hideSpResult(var_141_1)
			arg_139_2()

			return
		end

		SFX_PANEL = var_2_10005

		var_2_10001(var_140_0, var_140_1, var_140_2, var_2_10005)

		return
	end)

	return
end

function var_0_1.hideSpResult(arg_142_0)
	setActive = var_1_10001

	var_1_10001(arg_142_0.spResult, false)

	return
end

function var_0_1.displayBombResult(arg_143_0, arg_143_1)
	setActive = var_1_10002

	var_1_10002(arg_143_0.spResult, true)
	arg_143_0:DisplaySPAnim("SpBombRet", function(arg_144_0)
		onButton = var_2_10001

		local var_144_0 = arg_143_0
		local var_144_1 = arg_144_0

		local function var_144_2()
			removeOnButton = var_3_10000

			var_3_10000(arg_144_0)

			setActive = var_3_10000

			var_3_10000(arg_144_0, false)

			pg = var_3_10000

			local var_145_0 = var_3_10000.UIMgr.GetInstance()

			var_0.UnOverlayPanel(var_145_0, arg_144_0, arg_143_0._tf)

			local var_145_1 = arg_143_0

			var_0.hideSpResult(var_145_1)
			arg_143_1()

			return
		end

		SFX_PANEL = var_2_10005

		var_2_10001(var_144_0, var_144_1, var_144_2, var_2_10005)

		return
	end, function(arg_146_0)
		setText = var_2_10001

		local var_146_0 = arg_146_0.transform

		var_2_10001(var_2.Find(var_146_0, "right/name_bg/en"), arg_143_0.contextData.chapterVO.modelCount)

		return
	end)

	return
end

function var_0_1.OnLevelInfoPanelConfirm(arg_147_0, arg_147_1, arg_147_2)
	local var_147_0 = arg_147_0.contextData

	var_147_0.chapterLoopFlag = arg_147_2
	getProxy = var_147_0
	ChapterProxy = var_1_10004

	local var_147_1 = var_147_0(var_1_10004)
	local var_147_2 = var_3.getChapterById(var_147_1, arg_147_1, true)
	local var_147_3 = var_3.getConfig(var_147_2, "type")

	Chapter = var_147_2

	if var_147_3 == var_147_2.CustomFleet then
		arg_147_0:displayFleetEdit(var_3)

		return
	end

	if #var_3:getNpcShipByType(1) > 0 then
		local var_147_4 = arg_147_0
		local var_147_5 = arg_147_0.emit

		LevelMediator2 = var_1_10008

		var_147_5(var_147_4, var_1_10008.ON_TRACKING, arg_147_1)

		return
	end

	arg_147_0:displayFleetSelect(var_3)

	return
end

function var_0_1.DisplayLevelInfoPanel(arg_148_0, arg_148_1, arg_148_2)
	seriesAsync = var_1_10003

	var_1_10003({
		function(arg_149_0)
			local var_149_0 = arg_148_0.levelInfoView

			if not var_1.GetLoaded(var_149_0) then
				local var_149_1 = arg_148_0

				var_1.frozen(var_149_1)

				local var_149_2 = arg_148_0.levelInfoView

				var_1.Load(var_149_2)

				local var_149_3 = arg_148_0.levelInfoView

				var_1.CallbackInvoke(var_149_3, function()
					local var_150_0 = arg_148_0

					var_0.unfrozen(var_150_0)
					arg_149_0()

					return
				end)

				return
			end

			arg_149_0()

			return
		end,
		function(arg_151_0)
			local function var_151_0(arg_152_0, arg_152_1)
				local var_152_0 = arg_148_0

				var_2.hideChapterPanel(var_152_0)

				local var_152_1 = arg_148_0

				var_2.OnLevelInfoPanelConfirm(var_152_1, arg_152_0, arg_152_1)

				return
			end

			local function var_151_1()
				local var_153_0 = arg_148_0

				var_0.hideChapterPanel(var_153_0)

				return
			end

			getProxy = var_2_10003
			ChapterProxy = var_2_10004

			local var_151_2 = var_2_10003(var_2_10004)
			local var_151_3 = var_3.getChapterById(var_151_2, arg_148_1, true)

			getProxy = var_151_2
			ChapterProxy = var_5

			local var_151_4 = var_151_2(var_5)
			local var_151_5 = var_4.getMapById(var_151_4, var_151_3:getConfig("map"))

			if var_4.isSkirmish(var_151_5) and #var_151_3:getNpcShipByType(1) > 0 then
				var_151_0(false)

				return
			end

			local var_151_6 = arg_148_0.levelInfoView

			var_5.set(var_151_6, arg_148_1, arg_148_2)

			local var_151_7 = arg_148_0.levelInfoView

			var_5.setCBFunc(var_151_7, var_151_0, var_151_1)

			local var_151_8 = arg_148_0.levelInfoView

			var_5.Show(var_151_8)

			return
		end
	})

	return
end

function var_0_1.hideChapterPanel(arg_154_0)
	local var_154_0 = arg_154_0.levelInfoView

	if var_1.isShowing(var_154_0) then
		local var_154_1 = arg_154_0.levelInfoView

		var_1.Hide(var_154_1)
	end

	return
end

function var_0_1.destroyChapterPanel(arg_155_0)
	local var_155_0 = arg_155_0.levelInfoView

	var_1.Destroy(var_155_0)

	arg_155_0.levelInfoView = nil

	return
end

function var_0_1.DisplayLevelInfoSPPanel(arg_156_0, arg_156_1, arg_156_2, arg_156_3)
	seriesAsync = var_1_10004

	var_1_10004({
		function(arg_157_0)
			if not arg_156_0.levelInfoSPView then
				local var_157_0 = arg_156_0

				LevelInfoSPView = var_2_10002
				var_157_0.levelInfoSPView = var_2_10002.New(arg_156_0.topPanel, arg_156_0.event, arg_156_0.contextData)

				local var_157_1 = arg_156_0.levelInfoSPView

				var_1.RegisterView(var_157_1, arg_156_0)

				local var_157_2 = arg_156_0

				var_1.frozen(var_157_2)

				local var_157_3 = arg_156_0.levelInfoSPView

				var_1.Load(var_157_3)

				local var_157_4 = arg_156_0.levelInfoSPView

				var_1.CallbackInvoke(var_157_4, function()
					local var_158_0 = arg_156_0

					var_0.unfrozen(var_158_0)
					arg_157_0()

					return
				end)

				return
			end

			arg_157_0()

			return
		end,
		function(arg_159_0)
			local function var_159_0(arg_160_0, arg_160_1)
				local var_160_0 = arg_156_0

				var_2.HideLevelInfoSPPanel(var_160_0)

				local var_160_1 = arg_156_0

				var_2.OnLevelInfoPanelConfirm(var_160_1, arg_160_0, arg_160_1)

				return
			end

			local function var_159_1()
				local var_161_0 = arg_156_0

				var_0.HideLevelInfoSPPanel(var_161_0)

				return
			end

			local var_159_2 = arg_156_0.levelInfoSPView

			var_3.SetChapterGroupInfo(var_159_2, arg_156_2)

			local var_159_3 = arg_156_0.levelInfoSPView

			var_3.set(var_159_3, arg_156_1, arg_156_3)

			local var_159_4 = arg_156_0.levelInfoSPView

			var_3.setCBFunc(var_159_4, var_159_0, var_159_1)

			local var_159_5 = arg_156_0.levelInfoSPView

			var_3.Show(var_159_5)

			return
		end
	})

	return
end

function var_0_1.HideLevelInfoSPPanel(arg_162_0)
	if arg_162_0.levelInfoSPView then
		local var_162_0 = arg_162_0.levelInfoSPView

		if var_1.isShowing(var_162_0) then
			local var_162_1 = arg_162_0.levelInfoSPView

			var_1.Hide(var_162_1)
		end
	end

	return
end

function var_0_1.DestroyLevelInfoSPPanel(arg_163_0)
	if not arg_163_0.levelInfoSPView then
		return
	end

	local var_163_0 = arg_163_0.levelInfoSPView

	var_1.Destroy(var_163_0)

	arg_163_0.levelInfoSPView = nil

	return
end

function var_0_1.displayFleetSelect(arg_164_0, arg_164_1)
	local var_164_0

	if not arg_164_0.contextData.selectedFleetIDs then
		var_1_10003 = arg_164_1
		var_164_0 = arg_164_1.GetDefaultFleetIndex(var_1_10003)
	end

	Clone = var_1_10003
	arg_164_1 = var_1_10003(arg_164_1)
	arg_164_1.loopFlag = arg_164_0.contextData.chapterLoopFlag

	local var_164_1 = arg_164_0.levelFleetView

	var_3.updateSpecialOperationTickets(var_164_1, arg_164_0.spTickets)

	local var_164_2 = arg_164_0.levelFleetView

	var_3.Load(var_164_2)

	local var_164_3 = arg_164_0.levelFleetView

	var_3.ActionInvoke(var_164_3, "setHardShipVOs", arg_164_0.shipVOs)

	local var_164_4 = arg_164_0.levelFleetView

	var_3.ActionInvoke(var_164_4, "setOpenCommanderTag", arg_164_0.openedCommanerSystem)

	local var_164_5 = arg_164_0.levelFleetView

	var_3.ActionInvoke(var_164_5, "set", arg_164_1, arg_164_0.fleets, var_164_0)

	local var_164_6 = arg_164_0.levelFleetView

	var_3.ActionInvoke(var_164_6, "Show")

	return
end

function var_0_1.hideFleetSelect(arg_165_0)
	local var_165_0 = arg_165_0.levelCMDFormationView

	if var_1.isShowing(var_165_0) then
		local var_165_1 = arg_165_0.levelCMDFormationView

		var_1.Hide(var_165_1)
	end

	if arg_165_0.levelFleetView then
		local var_165_2 = arg_165_0.levelFleetView

		var_1.Hide(var_165_2)
	end

	return
end

function var_0_1.buildCommanderPanel(arg_166_0)
	LevelCMDFormationView = var_1_10001
	arg_166_0.levelCMDFormationView = var_1_10001.New(arg_166_0.topPanel, arg_166_0.event, arg_166_0.contextData)

	return
end

function var_0_1.destroyFleetSelect(arg_167_0)
	if not arg_167_0.levelFleetView then
		return
	end

	local var_167_0 = arg_167_0.levelFleetView

	var_1.Destroy(var_167_0)

	arg_167_0.levelFleetView = nil

	return
end

function var_0_1.displayFleetEdit(arg_168_0, arg_168_1)
	Clone = var_1_10002
	arg_168_1 = var_1_10002(arg_168_1)
	arg_168_1.loopFlag = arg_168_0.contextData.chapterLoopFlag

	local var_168_0 = arg_168_0.levelFleetView

	var_2.updateSpecialOperationTickets(var_168_0, arg_168_0.spTickets)

	local var_168_1 = arg_168_0.levelFleetView

	var_2.Load(var_168_1)

	local var_168_2 = arg_168_0.levelFleetView

	var_2.ActionInvoke(var_168_2, "setOpenCommanderTag", arg_168_0.openedCommanerSystem)

	local var_168_3 = arg_168_0.levelFleetView

	var_2.ActionInvoke(var_168_3, "setHardShipVOs", arg_168_0.shipVOs)

	local var_168_4 = arg_168_0.levelFleetView

	var_2.ActionInvoke(var_168_4, "setOnHard", arg_168_1)

	local var_168_5 = arg_168_0.levelFleetView

	var_2.ActionInvoke(var_168_5, "Show")

	return
end

function var_0_1.hideFleetEdit(arg_169_0)
	arg_169_0:hideFleetSelect()

	return
end

function var_0_1.destroyFleetEdit(arg_170_0)
	arg_170_0:destroyFleetSelect()

	return
end

function var_0_1.RefreshFleetSelectView(arg_171_0, arg_171_1)
	if not arg_171_0.levelFleetView then
		return
	end

	assert = var_2

	local var_171_0 = arg_171_0.levelFleetView

	var_2(var_3.GetLoaded(var_171_0))

	local var_171_1 = arg_171_0.levelFleetView
	local var_171_2 = var_2.IsSelectMode(var_171_1)
	local var_171_3

	if var_171_2 then
		local var_171_4 = arg_171_0.levelFleetView
		local var_171_5 = var_4.ActionInvoke
		local var_171_6 = "set"
		local var_171_7 = arg_171_1 or arg_171_0.levelFleetView.chapter
		local var_171_8 = arg_171_0.fleets
		local var_171_9 = arg_171_0.levelFleetView

		var_171_5(var_171_4, var_171_6, var_171_7, var_171_8, var_9.getSelectIds(var_171_9))

		local var_171_10 = arg_171_0.levelCMDFormationView

		if var_4.isShowing(var_171_10) then
			local var_171_11 = arg_171_0.levelCMDFormationView.fleet.id

			var_171_3 = arg_171_0.fleets[var_171_11]
		end
	else
		local var_171_12 = arg_171_0.levelFleetView

		var_4.ActionInvoke(var_171_12, "setOnHard", arg_171_1 or arg_171_0.levelFleetView.chapter)

		local var_171_13 = arg_171_0.levelCMDFormationView

		if var_4.isShowing(var_171_13) then
			local var_171_14 = arg_171_0.levelCMDFormationView.fleet.id

			var_171_3 = arg_171_1:wrapEliteFleet(var_171_14)
		end
	end

	if var_171_3 then
		local var_171_15 = arg_171_0.levelCMDFormationView

		var_4.ActionInvoke(var_171_15, "updateFleet", var_171_3)
	end

	return
end

function var_0_1.setChapter(arg_172_0, arg_172_1)
	local var_172_0

	if arg_172_1 then
		var_172_0 = arg_172_1.id
	end

	arg_172_0.contextData.chapterId = var_172_0
	arg_172_0.contextData.chapterVO = arg_172_1

	return
end

function var_0_1.switchToChapter(arg_173_0, arg_173_1)
	if arg_173_0.contextData.mapIdx ~= arg_173_1:getConfig("map") then
		arg_173_0:setMap(arg_173_1:getConfig("map"))
	end

	arg_173_0:setChapter(arg_173_1)

	arg_173_0.leftCanvasGroup.blocksRaycasts = false

	local var_173_0 = arg_173_0.rightCanvasGroup

	var_173_0.blocksRaycasts = false
	assert = var_173_0

	var_173_0(not arg_173_0.levelStageView, "LevelStageView Exists On SwitchToChapter")
	arg_173_0:DestroyLevelStageView()

	if not arg_173_0.levelStageView then
		LevelStageView = var_2
		arg_173_0.levelStageView = var_2.New(arg_173_0.topPanel, arg_173_0.event, arg_173_0.contextData)

		local var_173_1 = arg_173_0.levelStageView

		var_2.Load(var_173_1)

		arg_173_0.levelStageView.isFrozen = arg_173_0:isfrozen()
	end

	arg_173_0:frozen()

	local function var_173_2()
		seriesAsync = var_2_10000

		var_2_10000({
			function(arg_175_0)
				local var_175_0 = arg_173_0.mapBuilder

				var_1.CallbackInvoke(var_175_0, arg_175_0)

				return
			end,
			function(arg_176_0)
				setActive = var_3_10001

				var_3_10001(arg_173_0.clouds, false)

				local var_176_0 = arg_173_0.mapBuilder

				var_1.HideFloat(var_176_0)

				local var_176_1 = arg_173_0
				local var_176_2 = var_1.BlurPanel
				local var_176_3 = arg_173_0.topPanel
				local var_176_4 = {}
				local var_176_5 = {}

				pg = var_3_10006
				var_176_5[1] = var_3_10006.UIMgr.CameraUI
				var_176_4.blurCamList = var_176_5

				var_176_2(var_176_1, var_176_3, var_176_4)

				local var_176_6 = arg_173_0.levelStageView

				var_1.updateStageInfo(var_176_6)

				local var_176_7 = arg_173_0.levelStageView

				var_1.updateAmbushRate(var_176_7, arg_173_1.fleet.line, true)

				local var_176_8 = arg_173_0.levelStageView

				var_1.updateStageAchieve(var_176_8)

				local var_176_9 = arg_173_0.levelStageView

				var_1.updateStageBarrier(var_176_9)

				local var_176_10 = arg_173_0.levelStageView

				var_1.updateBombPanel(var_176_10)

				local var_176_11 = arg_173_0.levelStageView

				var_1.UpdateDefenseStatus(var_176_11)

				onNextTick = var_1

				var_1(arg_176_0)

				return
			end,
			function(arg_177_0)
				if arg_173_0.exited then
					return
				end

				local var_177_0 = arg_173_0.levelStageView

				var_1.updateStageStrategy(var_177_0)

				local var_177_1 = arg_173_0.canvasGroup

				var_177_1.blocksRaycasts = arg_173_0.frozenCount == 0
				onNextTick = var_177_1

				var_177_1(arg_177_0)

				return
			end,
			function(arg_178_0)
				if arg_173_0.exited then
					return
				end

				local var_178_0 = arg_173_0.levelStageView

				var_1.updateStageFleet(var_178_0)

				local var_178_1 = arg_173_0.levelStageView

				var_1.updateSupportFleet(var_178_1)

				local var_178_2 = arg_173_0.levelStageView

				var_1.updateFleetBuff(var_178_2)

				onNextTick = var_1

				var_1(arg_178_0)

				return
			end,
			function(arg_179_0)
				if arg_173_0.exited then
					return
				end

				parallelAsync = var_1

				var_1({
					function(arg_180_0)
						local var_180_0 = arg_173_1
						local var_180_1 = var_1.getConfig(var_180_0, "scale")

						LeanTween = var_180_0

						local var_180_2 = var_180_0.value

						go = var_3

						local var_180_3 = var_3(arg_173_0.map)
						local var_180_4 = arg_173_0.map.localScale

						Vector3 = var_4_10005

						local var_180_5 = var_180_2(var_180_3, var_180_4, var_4_10005.New(var_180_1[3], var_180_1[3], 1), var_0_2)
						local var_180_6 = var_2.setOnUpdateVector3(var_180_5, function(arg_181_0)
							arg_173_0.map.localScale = arg_181_0
							arg_173_0.float.localScale = arg_181_0

							return
						end)
						local var_180_7 = var_2.setOnComplete

						System = var_4

						local var_180_8 = var_180_7(var_180_6, var_4.Action(function()
							local var_182_0 = arg_173_0.mapBuilder

							var_0.ShowFloat(var_182_0)

							local var_182_1 = arg_173_0.mapBuilder

							var_0.Hide(var_182_1)
							arg_180_0()

							return
						end))
						local var_180_9 = var_2.setEase

						LeanTweenType = var_4

						local var_180_10 = var_180_9(var_180_8, var_4.easeOutSine)
						local var_180_11 = arg_173_0

						var_3.RecordTween(var_180_11, "mapScale", var_180_10.uniqueId)

						LeanTween = var_3

						local var_180_12 = var_3.value

						go = var_180_11

						local var_180_13 = var_180_11(arg_173_0.map)
						local var_180_14 = arg_173_0.map.pivot

						Vector2 = var_6

						local var_180_15 = var_6.New

						math = var_7

						local var_180_16 = var_7.clamp(var_180_1[1] - 0.5, 0, 1)

						math = var_8

						local var_180_17 = var_180_12(var_180_13, var_180_14, var_180_15(var_180_16, var_8.clamp(var_180_1[2] - 0.5, 0, 1)), var_0_2)
						local var_180_18 = var_3.setOnUpdateVector2(var_180_17, function(arg_183_0)
							arg_173_0.map.pivot = arg_183_0
							arg_173_0.float.pivot = arg_183_0

							return
						end)
						local var_180_19 = var_4.setEase

						LeanTweenType = var_6

						var_180_19(var_180_18, var_6.easeOutSine)

						local var_180_20 = arg_173_0

						var_4.RecordTween(var_180_20, "mapPivot", var_3.uniqueId)

						shiftPanel = var_4

						local var_180_21 = arg_173_0.leftChapter
						local var_180_22 = -arg_173_0.leftChapter.rect.width - 200
						local var_180_23 = 0
						local var_180_24 = 0.3
						local var_180_25 = 0
						local var_180_26 = true
						local var_180_27

						LeanTweenType = var_4_10012

						var_4(var_180_21, var_180_22, var_180_23, var_180_24, var_180_25, var_180_26, var_180_27, var_4_10012.easeOutSine)

						shiftPanel = var_4

						local var_180_28 = arg_173_0.rightChapter
						local var_180_29 = arg_173_0.rightChapter.rect.width + 200
						local var_180_30 = 0
						local var_180_31 = 0.3
						local var_180_32 = 0
						local var_180_33 = true
						local var_180_34

						LeanTweenType = var_12

						var_4(var_180_28, var_180_29, var_180_30, var_180_31, var_180_32, var_180_33, var_180_34, var_12.easeOutSine)

						shiftPanel = var_4

						local var_180_35 = arg_173_0.topChapter
						local var_180_36 = 0
						local var_180_37 = arg_173_0.topChapter.rect.height
						local var_180_38 = 0.3
						local var_180_39 = 0
						local var_180_40 = true
						local var_180_41

						LeanTweenType = var_12

						var_4(var_180_35, var_180_36, var_180_37, var_180_38, var_180_39, var_180_40, var_180_41, var_12.easeOutSine)

						local var_180_42 = arg_173_0.levelStageView

						var_4.ShiftStagePanelIn(var_180_42)

						return
					end,
					function(arg_184_0)
						local var_184_0 = arg_173_0

						var_1.PlayBGM(var_184_0)

						local var_184_1 = {}
						local var_184_2 = arg_173_1

						if var_2.getConfig(var_184_2, "bg") and #var_2 > 0 then
							var_184_1[1] = {
								BG = var_2
							}
						end

						local var_184_3 = arg_173_0

						var_3.SwitchBG(var_184_3, var_184_1, arg_184_0)

						return
					end
				}, function()
					onNextTick = var_4_10000

					var_4_10000(arg_179_0)

					return
				end)

				return
			end,
			function(arg_186_0)
				if arg_173_0.exited then
					return
				end

				setActive = var_1

				var_1(arg_173_0.topChapter, false)

				setActive = var_1

				var_1(arg_173_0.leftChapter, false)

				setActive = var_1

				var_1(arg_173_0.rightChapter, false)

				arg_173_0.leftCanvasGroup.blocksRaycasts = true
				arg_173_0.rightCanvasGroup.blocksRaycasts = true

				local var_186_0 = arg_173_0

				var_1.initGrid(var_186_0, arg_186_0)

				return
			end,
			function(arg_187_0)
				if arg_173_0.exited then
					return
				end

				local var_187_0 = arg_173_0.levelStageView

				var_1.SetGrid(var_187_0, arg_173_0.grid)

				arg_173_0.contextData.huntingRangeVisibility = arg_173_0.contextData.huntingRangeVisibility - 1

				local var_187_1 = arg_173_0.grid

				var_1.toggleHuntingRange(var_187_1)

				local var_187_2 = arg_173_1

				if var_1.getConfig(var_187_2, "pop_pic") and #var_1 > 0 and arg_173_0.FirstEnterChapter == arg_173_1.id then
					local var_187_3 = arg_173_0

					var_2.doPlayAnim(var_187_3, var_1, function(arg_188_0)
						setActive = var_4_10001

						var_4_10001(arg_188_0, false)

						if arg_173_0.exited then
							return
						end

						arg_187_0()

						return
					end)
				else
					arg_187_0()
				end

				return
			end,
			function(arg_189_0)
				local var_189_0 = arg_173_0.levelStageView

				var_1.tryAutoAction(var_189_0, arg_189_0)

				return
			end,
			function(arg_190_0)
				if arg_173_0.exited then
					return
				end

				local var_190_0 = arg_173_0

				var_1.unfrozen(var_190_0)

				if arg_173_0.FirstEnterChapter then
					local var_190_1 = arg_173_0
					local var_190_2 = var_1.emit

					LevelMediator2 = var_3_10003

					var_190_2(var_190_1, var_3_10003.ON_RESUME_SUBSTATE, arg_173_1.subAutoAttack)
				end

				arg_173_0.FirstEnterChapter = nil

				arg_190_0()

				return
			end,
			function(arg_191_0)
				local var_191_0 = arg_173_1

				if var_1.NeedSupportSubmarineStage(var_191_0) then
					local var_191_1 = arg_173_0.levelStageView

					var_1.TryEnterChapterSupportSubmarineStage(var_191_1, arg_191_0)
				else
					arg_191_0()
				end

				return
			end
		}, function()
			local var_192_0 = arg_173_0.levelStageView

			var_0.tryAutoTrigger(var_192_0, true)

			return
		end)

		return
	end

	local var_173_3 = arg_173_0.levelStageView

	var_3.ActionInvoke(var_173_3, "SetSeriesOperation", var_173_2)

	local var_173_4 = arg_173_0.levelStageView

	var_3.ActionInvoke(var_173_4, "SetPlayer", arg_173_0.player)

	local var_173_5 = arg_173_0.levelStageView

	var_3.ActionInvoke(var_173_5, "SwitchToChapter", arg_173_1)

	return
end

function var_0_1.switchToMap(arg_193_0, arg_193_1)
	arg_193_0:frozen()
	arg_193_0:destroyGrid()

	local var_193_0 = arg_193_0

	arg_193_0.setChapter(var_193_0, nil)

	LeanTween = var_2

	local var_193_1 = var_2.cancel

	go = var_193_0

	var_193_1(var_193_0(arg_193_0.map))

	LeanTween = var_193_1

	local var_193_2 = var_193_1.value

	go = var_3

	local var_193_3 = var_3(arg_193_0.map)
	local var_193_4 = arg_193_0.map.localScale

	Vector3 = var_1_10005

	local var_193_5 = var_193_2(var_193_3, var_193_4, var_1_10005.one, var_0_2)
	local var_193_6 = var_2.setOnUpdateVector3(var_193_5, function(arg_194_0)
		arg_193_0.map.localScale = arg_194_0
		arg_193_0.float.localScale = arg_194_0

		return
	end)
	local var_193_7 = var_2.setOnComplete

	System = var_4

	local var_193_8 = var_193_7(var_193_6, var_4.Action(function()
		local var_195_0 = arg_193_0

		var_0.unfrozen(var_195_0)

		local var_195_1 = arg_193_0.mapBuilder

		var_0.PlayEnterAnim(var_195_1)

		existCall = var_0

		var_0(arg_193_1)

		return
	end))
	local var_193_9 = var_2.setEase

	LeanTweenType = var_4

	local var_193_10 = var_193_9(var_193_8, var_4.easeOutSine)

	arg_193_0:RecordTween("mapScale", var_193_10.uniqueId)

	local var_193_11 = arg_193_0.contextData.map
	local var_193_12 = var_3.getConfig(var_193_11, "anchor")
	local var_193_13

	if var_193_12 == "" then
		Vector2 = var_5
		var_193_13 = var_5(0.5, 0.5)
	else
		Vector2 = var_5
		unpack = var_6
		var_193_13 = var_5(var_6(var_193_12))
	end

	LeanTween = var_5

	local var_193_14 = var_5.value

	go = var_6

	local var_193_15 = var_193_14(var_6(arg_193_0.map), arg_193_0.map.pivot, var_193_13, var_0_2)
	local var_193_16 = var_5.setOnUpdateVector2(var_193_15, function(arg_196_0)
		arg_193_0.map.pivot = arg_196_0
		arg_193_0.float.pivot = arg_196_0

		return
	end)
	local var_193_17 = var_6.setEase

	LeanTweenType = var_8

	var_193_17(var_193_16, var_8.easeOutSine)
	arg_193_0:RecordTween("mapPivot", var_5.uniqueId)

	setActive = var_6

	var_6(arg_193_0.topChapter, true)

	setActive = var_6

	var_6(arg_193_0.leftChapter, true)

	setActive = var_6

	var_6(arg_193_0.rightChapter, true)

	shiftPanel = var_6

	local var_193_18 = arg_193_0.leftChapter
	local var_193_19 = 0
	local var_193_20 = 0
	local var_193_21 = 0.3
	local var_193_22 = 0
	local var_193_23 = true
	local var_193_24

	LeanTweenType = var_1_10014

	var_6(var_193_18, var_193_19, var_193_20, var_193_21, var_193_22, var_193_23, var_193_24, var_1_10014.easeOutSine)

	shiftPanel = var_6

	local var_193_25 = arg_193_0.rightChapter
	local var_193_26 = 0
	local var_193_27 = 0
	local var_193_28 = 0.3
	local var_193_29 = 0
	local var_193_30 = true
	local var_193_31

	LeanTweenType = var_14

	var_6(var_193_25, var_193_26, var_193_27, var_193_28, var_193_29, var_193_30, var_193_31, var_14.easeOutSine)

	shiftPanel = var_6

	local var_193_32 = arg_193_0.topChapter
	local var_193_33 = 0
	local var_193_34 = 0
	local var_193_35 = 0.3
	local var_193_36 = 0
	local var_193_37 = true
	local var_193_38

	LeanTweenType = var_14

	var_6(var_193_32, var_193_33, var_193_34, var_193_35, var_193_36, var_193_37, var_193_38, var_14.easeOutSine)

	assert = var_6

	var_6(arg_193_0.levelStageView, "LevelStageView Doesnt Exist On SwitchToMap")

	if arg_193_0.levelStageView then
		local var_193_39 = arg_193_0.levelStageView

		var_6.ActionInvoke(var_193_39, "ShiftStagePanelOut", function()
			local var_197_0 = arg_193_0

			var_0.DestroyLevelStageView(var_197_0)

			return
		end)

		local var_193_40 = arg_193_0.levelStageView

		var_6.ActionInvoke(var_193_40, "SwitchToMap")
	end

	arg_193_0:SwitchMapBG(arg_193_0.contextData.map)
	arg_193_0:PlayBGM()

	seriesAsync = var_6

	var_6({
		function(arg_198_0)
			local var_198_0 = arg_193_0.mapBuilder

			var_1.CallbackInvoke(var_198_0, arg_198_0)

			return
		end,
		function(arg_199_0)
			local var_199_0 = arg_193_0.mapBuilder

			var_1.Show(var_199_0)

			local var_199_1 = arg_193_0.mapBuilder

			var_1.UpdateView(var_199_1)

			local var_199_2 = arg_193_0.mapBuilder

			var_1.UpdateMapItems(var_199_2)

			return
		end
	})
	arg_193_0:UnOverlayPanel(arg_193_0.topPanel, arg_193_0._tf)

	arg_193_0.canvasGroup.blocksRaycasts = arg_193_0.frozenCount == 0
	arg_193_0.canvasGroup.interactable = true

	if arg_193_0.ambushWarning and arg_193_0.ambushWarning.activeSelf then
		local var_193_41 = arg_193_0.ambushWarning

		var_6.SetActive(var_193_41, false)
		arg_193_0:unfrozen()
	end

	return
end

function var_0_1.SwitchBG(arg_200_0, arg_200_1, arg_200_2, arg_200_3)
	if not arg_200_1 or #arg_200_1 <= 0 then
		existCall = var_1_10004

		var_1_10004(arg_200_2)

		return
	elseif arg_200_3 then
		-- block empty
	else
		table = var_1_10004

		if var_1_10004.equal(arg_200_0.currentBG, arg_200_1) then
			return
		end
	end

	arg_200_0.currentBG = arg_200_1
	ipairs = var_1_10004

	for iter_200_0, iter_200_1 in var_1_10004(arg_200_0.mapGroup) do
		local var_200_0 = arg_200_0.loader

		var_9.ClearRequest(var_200_0, iter_200_1)
	end

	table = var_4

	var_4.clear(arg_200_0.mapGroup)

	local var_200_1 = {}

	table = var_5

	var_5.ParallelIpairsAsync(arg_200_1, function(arg_201_0, arg_201_1, arg_201_2)
		local var_201_0 = arg_200_0.mapTFs[arg_201_0]
		local var_201_1

		if not arg_201_1.bgPrefix or not (arg_201_1.bgPrefix .. "/") then
			var_201_1 = "levelmap/"
		end

		local var_201_2 = arg_200_0.loader
		local var_201_3 = var_5.GetSpriteDirect(var_201_2, var_201_1 .. arg_201_1.BG, "", function(arg_202_0)
			var_200_1[arg_201_0] = arg_202_0

			arg_201_2()

			return
		end, var_201_0)

		table = var_201_2

		var_201_2.insert(arg_200_0.mapGroup, var_201_3)

		local var_201_4 = arg_200_0

		var_6.updateCouldAnimator(var_201_4, arg_201_1.Animator, arg_201_0)

		return
	end, function()
		ipairs = var_2_10000

		for iter_203_0, iter_203_1 in var_2_10000(arg_200_0.mapTFs) do
			setImageSprite = var_2_10005

			var_2_10005(iter_203_1, var_200_1[iter_203_0])

			setActive = var_2_10005

			var_2_10005(iter_203_1, arg_200_1[iter_203_0])

			SetCompomentEnabled = var_2_10005

			local var_203_0 = iter_203_1

			typeof = var_7
			Image = var_2_10008

			var_2_10005(var_203_0, var_7(var_2_10008), true)
		end

		existCall = var_0

		var_0(arg_200_2)

		return
	end)

	return
end

local var_0_8 = {
	1520001,
	1520002,
	1520011,
	1520012
}
local var_0_9 = {
	{
		1420008,
		"map_1420008",
		1420021,
		"map_1420001"
	},
	{
		1420018,
		"map_1420018",
		1420031,
		"map_1420011"
	}
}
local var_0_10 = {
	1420001,
	1420011
}

function var_0_1.ClearMapTransitions(arg_204_0)
	if not arg_204_0.mapTransitions then
		return
	end

	pairs = var_1

	for iter_204_0, iter_204_1 in var_1(arg_204_0.mapTransitions) do
		if iter_204_1 then
			PoolMgr = var_1_10006

			local var_204_0 = var_1_10006.GetInstance()

			var_1_10006.ReturnPrefab(var_204_0, "ui/" .. iter_204_0, iter_204_0, iter_204_1, true)
		else
			PoolMgr = var_1_10006

			local var_204_1 = var_1_10006.GetInstance()

			var_1_10006.DestroyPrefab(var_204_1, "ui/" .. iter_204_0, iter_204_0)
		end
	end

	arg_204_0.mapTransitions = nil

	return
end

function var_0_1.SwitchMapBG(arg_205_0, arg_205_1, arg_205_2, arg_205_3)
	local var_205_0, var_205_1, var_205_2 = arg_205_0:GetMapBG(arg_205_1, arg_205_2)
	local var_205_3 = {}

	if var_205_1 then
		table = var_1_10008

		var_1_10008.insert(var_205_3, function(arg_206_0)
			local var_206_0 = arg_205_0

			var_1.PlayMapTransition(var_206_0, "LevelMapTransition_" .. var_205_1, var_205_2, arg_206_0)

			return
		end)
	end

	seriesAsync = var_1_10008

	var_1_10008(var_205_3, function()
		local var_207_0 = arg_205_0
		local var_207_1 = var_0.SwitchBGMapType
		local var_207_2 = arg_205_1

		var_207_1(var_207_0, var_2.getConfig(var_207_2, "pos_type"))

		local var_207_3 = arg_205_0

		var_0.SwitchBG(var_207_3, var_205_0, nil, arg_205_3)

		return
	end)

	return
end

function var_0_1.SwitchBGMapType(arg_208_0, arg_208_1)
	if arg_208_0.posType == arg_208_1 then
		return
	end

	ipairs = var_2

	for iter_208_0, iter_208_1 in var_2({
		arg_208_0.map,
		arg_208_0.float
	}) do
		GetOrAddComponent = var_1_10007

		local var_208_0 = iter_208_1

		typeof = var_1_10009
		AspectRatioFitter = var_1_10010
		var_1_10007 = var_1_10007(var_208_0, var_1_10009(var_1_10010))
		var_1_10007.aspectRatio = 1.7777777777777777
		var_1_10007.enabled = arg_208_1 == 0

		if arg_208_1 == 1 then
			Vector2 = var_8
			iter_208_1.anchorMin = var_8(0.5, 0.5)
			Vector2 = var_8
			iter_208_1.anchorMax = var_8(0.5, 0.5)
			setSizeDelta = var_8

			var_8(var_1_10007, {
				x = 2520,
				y = 1440
			})
		end
	end

	return
end

function var_0_1.GetMapBG(arg_209_0, arg_209_1, arg_209_2)
	table = var_1_10003

	if not var_1_10003.contains(var_0_8, arg_209_1.id) then
		return {
			arg_209_0:GetMapElement(arg_209_1)
		}
	end

	local var_209_0 = arg_209_1.id

	table = var_4

	local var_209_1 = var_4.indexof(var_0_8, var_209_0) - 1

	bit = var_5

	local var_209_2 = var_5.lshift

	bit = var_6

	local var_209_3 = var_209_2(var_6.rshift(var_209_1, 1), 1) + 1
	local var_209_4 = {
		var_0_8[var_209_3],
		var_0_8[var_209_3 + 1]
	}

	_ = var_7

	local var_209_5 = var_7.map(var_209_4, function(arg_210_0)
		getProxy = var_2_10001
		ChapterProxy = var_2_10002

		local var_210_0 = var_2_10001(var_2_10002)

		return var_1.getMapById(var_210_0, arg_210_0)
	end)

	_ = var_7

	if var_7.all(var_209_5, function(arg_211_0)
		return arg_211_0:isAllChaptersClear()
	end) then
		local var_209_6 = {}
		local var_209_7 = arg_209_0

		var_209_6[1] = arg_209_0.GetMapElement(var_209_7, arg_209_1)

		if arg_209_2 then
			math = var_8

			if var_8.abs(var_209_0 - arg_209_2) ~= 1 then
				return var_209_6
			end

			local var_209_8 = var_0_10

			bit = var_209_7

			local var_209_9 = var_209_8[var_209_7.rshift(var_209_3 - 1, 1) + 1]

			bit = var_9

			local var_209_10 = var_9.band(var_209_1, 1) == 1

			do return var_209_6, var_209_9, var_209_10 end

			if false then
				local var_209_11 = 0

				;(function()
					local var_212_0 = var_209_5[1]
					local var_212_1 = var_0.getChapters(var_212_0)

					ipairs = var_212_0

					for iter_212_0, iter_212_1 in var_212_0(var_212_1) do
						if not iter_212_1:isClear() then
							return
						end

						var_209_11 = var_209_11 + 1
					end

					local var_212_2 = var_209_5[2]

					if not var_1.isAnyChapterUnlocked(var_212_2, true) then
						return
					end

					var_209_11 = var_209_11 + 1

					local var_212_3 = var_209_5[2]
					local var_212_4 = var_1.getChapters(var_212_3)

					ipairs = var_212_3

					for iter_212_2, iter_212_3 in var_212_3(var_212_4) do
						if not iter_212_3:isClear() then
							return
						end

						var_209_11 = var_209_11 + 1
					end

					return
				end)()

				local var_209_12

				if var_209_11 > 0 then
					local var_209_13 = var_0_9

					bit = var_1_10011

					local var_209_14 = var_209_13[var_1_10011.rshift(var_209_3 - 1, 1) + 1]

					var_209_12 = {
						{
							BG = "map_" .. var_209_14[1],
							Animator = var_209_14[2]
						},
						{
							BG = "map_" .. var_209_14[3] + var_209_11,
							Animator = var_209_14[4]
						}
					}
				else
					var_209_12 = {
						arg_209_0:GetMapElement(arg_209_1)
					}
				end

				return var_209_12
			end

			return
		end
	end
end

function var_0_1.GetMapElement(arg_213_0, arg_213_1)
	local var_213_0 = arg_213_1:getConfig("bg")

	if arg_213_1:getConfig("ani_controller") and #var_3 > 0 then
		(function()
			getProxy = var_2_10000
			ChapterProxy = var_2_10001

			local var_214_0 = var_2_10000(var_2_10001)

			ipairs = var_2_10001

			for iter_214_0, iter_214_1 in var_2_10001(var_0) do
				_ = var_2_10006
				var_2_10006 = var_2_10006.rest(iter_214_1[2], 2)
				ipairs = var_7

				for iter_214_2, iter_214_3 in var_7(var_2_10006) do
					string = var_2_10012

					if var_2_10012.find(iter_214_3, "^map_") and iter_214_1[1] == var_0_4 then
						var_2_10012 = iter_214_1[2][1]

						local var_214_1 = false

						ipairs = var_14

						for iter_214_4, iter_214_5 in var_14(var_2_10012) do
							if var_214_0:GetChapterItemById(iter_214_5) and var_19:isClear() then
								var_214_1 = true

								break
							end
						end

						if not var_214_1 then
							var_213_0 = iter_214_3

							return
						end
					end
				end
			end

			return
		end)()
	end

	local var_213_1 = {
		BG = var_213_0
	}

	var_213_1.Animator, var_213_1.AnimatorController = arg_213_0:GetMapAnimator(arg_213_1)

	return var_213_1
end

function var_0_1.GetMapAnimator(arg_215_0, arg_215_1)
	local var_215_0 = arg_215_1:getConfig("ani_name")

	if arg_215_1:getConfig("animtor") == 1 and var_215_0 and #var_215_0 > 0 then
		if arg_215_1:getConfig("ani_controller") and #var_3 > 0 then
			(function()
				getProxy = var_2_10000
				ChapterProxy = var_2_10001

				local var_216_0 = var_2_10000(var_2_10001)

				ipairs = var_2_10001

				for iter_216_0, iter_216_1 in var_2_10001(var_0) do
					_ = var_2_10006
					var_2_10006 = var_2_10006.rest(iter_216_1[2], 2)
					ipairs = var_7

					for iter_216_2, iter_216_3 in var_7(var_2_10006) do
						string = var_2_10012

						if var_2_10012.find(iter_216_3, "^effect_") and iter_216_1[1] == var_0_4 then
							var_2_10012 = iter_216_1[2][1]

							local var_216_1 = false

							ipairs = var_14

							for iter_216_4, iter_216_5 in var_14(var_2_10012) do
								if var_216_0:GetChapterItemById(iter_216_5) and var_19:isClear() then
									var_216_1 = true

									break
								end
							end

							if not var_216_1 then
								local var_216_2 = "map_"

								string = var_15
								var_215_0 = var_216_2 .. var_15.sub(iter_216_3, 8)

								return
							end
						end
					end
				end

				return
			end)()
		end

		return var_215_0, var_3
	end

	return
end

function var_0_1.PlayMapTransition(arg_217_0, arg_217_1, arg_217_2, arg_217_3, arg_217_4)
	local var_217_0

	if not arg_217_0.mapTransitions then
		var_217_0 = {}
	end

	arg_217_0.mapTransitions = var_217_0

	local var_217_1

	local function var_217_2()
		local var_218_0 = arg_217_0

		var_0.frozen(var_218_0)

		existCall = var_0

		var_0(arg_217_3, var_217_1)

		local var_218_1 = var_217_1

		var_0.SetActive(var_218_1, true)

		tf = var_0

		local var_218_2 = var_0(var_217_1)

		pg = var_1

		local var_218_3 = var_1.UIMgr.GetInstance()

		var_1.OverlayPanel(var_218_3, var_218_2)

		local var_218_4 = var_217_1
		local var_218_5 = var_1.GetComponent

		typeof = var_3
		Animator = var_2_10004

		local var_218_6 = var_218_5(var_218_4, var_3(var_2_10004))

		var_1.Play(var_218_6, arg_217_2 and "Sequence" or "Inverted", -1, 0)

		local var_218_7 = var_218_2:GetComponent("DftAniEvent")

		var_2.SetEndEvent(var_218_7, function(arg_219_0)
			pg = var_3_10001

			local var_219_0 = var_3_10001.UIMgr.GetInstance()

			var_1.UnOverlayPanel(var_219_0, var_218_2, arg_217_0._tf)

			existCall = var_1

			var_1(arg_217_4, var_217_1)

			PoolMgr = var_1

			local var_219_1 = var_1.GetInstance()

			var_1.ReturnPrefab(var_219_1, "ui/" .. arg_217_1, arg_217_1, var_217_1)

			arg_217_0.mapTransitions[arg_217_1] = false

			local var_219_2 = arg_217_0

			var_1.unfrozen(var_219_2)

			return
		end)

		return
	end

	PoolMgr = var_1_10007

	local var_217_3 = var_1_10007.GetInstance()

	var_7.GetPrefab(var_217_3, "ui/" .. arg_217_1, arg_217_1, true, function(arg_220_0)
		var_217_1 = arg_220_0
		arg_217_0.mapTransitions[arg_217_1] = arg_220_0

		var_217_2()

		return
	end)

	return
end

function var_0_1.DestroyLevelStageView(arg_221_0)
	if arg_221_0.levelStageView then
		local var_221_0 = arg_221_0.levelStageView

		var_1.Destroy(var_221_0)

		arg_221_0.levelStageView = nil
	end

	return
end

function var_0_1.displayAmbushInfo(arg_222_0, arg_222_1)
	LevelAmbushView = var_1_10002
	arg_222_0.levelAmbushView = var_1_10002.New(arg_222_0.topPanel, arg_222_0.event, arg_222_0.contextData)

	local var_222_0 = arg_222_0.levelAmbushView

	var_2.Load(var_222_0)

	local var_222_1 = arg_222_0.levelAmbushView

	var_2.ActionInvoke(var_222_1, "SetFuncOnComplete", arg_222_1)

	return
end

function var_0_1.hideAmbushInfo(arg_223_0)
	if arg_223_0.levelAmbushView then
		local var_223_0 = arg_223_0.levelAmbushView

		var_1.Destroy(var_223_0)

		arg_223_0.levelAmbushView = nil
	end

	return
end

function var_0_1.doAmbushWarning(arg_224_0, arg_224_1)
	arg_224_0:frozen()

	local function var_224_0()
		local var_225_0 = arg_224_0.ambushWarning

		var_0.SetActive(var_225_0, true)

		tf = var_0

		local var_225_1 = var_0(arg_224_0.ambushWarning)
		local var_225_2 = var_0.SetParent

		pg = var_2_10003

		var_225_2(var_225_1, var_2_10003.UIMgr.GetInstance().OverlayMain.transform, false)
		var_0:SetSiblingIndex(1)

		local var_225_3 = var_0:GetComponent("DftAniEvent")

		var_1.SetTriggerEvent(var_225_3, function(arg_226_0)
			arg_224_1()

			return
		end)
		var_1:SetEndEvent(function(arg_227_0)
			local var_227_0 = arg_224_0.ambushWarning

			var_1.SetActive(var_227_0, false)

			local var_227_1 = arg_224_0

			var_1.unfrozen(var_227_1)

			return
		end)

		pg = var_2

		local var_225_4 = var_2.CriMgr.GetInstance()
		local var_225_5 = var_2.PlaySoundEffect_V3

		SFX_UI_WARNING = var_4

		var_225_5(var_225_4, var_4)

		Timer = var_225_5

		local var_225_6 = var_225_5.New(function()
			pg = var_3_10000

			local var_228_0 = var_3_10000.CriMgr.GetInstance()
			local var_228_1 = var_0.PlaySoundEffect_V3

			SFX_UI_WARNING = var_3_10002

			var_228_1(var_228_0, var_3_10002)

			return
		end, 1, 1)

		var_2.Start(var_225_6)

		return
	end

	if not arg_224_0.ambushWarning then
		PoolMgr = var_3

		local var_224_1 = var_3.GetInstance()

		var_3.GetUI(var_224_1, "ambushwarnui", true, function(arg_229_0)
			arg_229_0:SetActive(true)

			arg_224_0.ambushWarning = arg_229_0

			var_224_0()

			return
		end)
	else
		var_224_0()
	end

	return
end

function var_0_1.destroyAmbushWarn(arg_230_0)
	if arg_230_0.ambushWarning then
		PoolMgr = var_1

		local var_230_0 = var_1.GetInstance()

		var_1.ReturnUI(var_230_0, "ambushwarnui", arg_230_0.ambushWarning)

		arg_230_0.ambushWarning = nil
	end

	return
end

function var_0_1.displayStrategyInfo(arg_231_0, arg_231_1)
	LevelStrategyView = var_1_10002
	arg_231_0.levelStrategyView = var_1_10002.New(arg_231_0.topPanel, arg_231_0.event, arg_231_0.contextData)

	local var_231_0 = arg_231_0.levelStrategyView

	var_2.Load(var_231_0)

	local var_231_1 = arg_231_0.levelStrategyView

	var_2.ActionInvoke(var_231_1, "set", arg_231_1)

	local function var_231_2()
		local var_232_0 = arg_231_0.contextData.chapterVO.fleet

		pg = var_2_10002

		local var_232_1 = var_2_10002.strategy_data_template[arg_231_1.id]

		if not var_232_0:canUseStrategy(arg_231_1) then
			return
		end

		local var_232_2 = var_232_0:getNextStgUser(arg_231_1.id)
		local var_232_3 = var_232_1.type

		ChapterConst = var_5

		local var_232_4

		if var_232_3 == var_5.StgTypeForm then
			var_232_4 = arg_231_0

			local var_232_5 = var_4.emit

			LevelMediator2 = var_2_10006
			var_2_10006 = var_2_10006.ON_OP

			local var_232_6 = {}

			ChapterConst = var_2_10008
			var_232_6.type = var_2_10008.OpStrategy
			var_232_6.id = var_232_2
			var_232_6.arg1 = arg_231_1.id

			var_232_5(var_232_4, var_2_10006, var_232_6)
		else
			local var_232_7 = var_232_1.type

			ChapterConst = var_232_4

			if var_232_7 == var_232_4.StgTypeConsume then
				local var_232_8 = arg_231_0
				local var_232_9 = var_4.emit

				LevelMediator2 = var_2_10006

				local var_232_10 = var_2_10006.ON_OP
				local var_232_11 = {}

				ChapterConst = var_2_10008
				var_232_11.type = var_2_10008.OpStrategy
				var_232_11.id = var_232_2
				var_232_11.arg1 = arg_231_1.id

				var_232_9(var_232_8, var_232_10, var_232_11)
			end
		end

		local var_232_12 = arg_231_0

		var_4.hideStrategyInfo(var_232_12)

		return
	end

	local function var_231_3()
		local var_233_0 = arg_231_0

		var_0.hideStrategyInfo(var_233_0)

		return
	end

	local var_231_4 = arg_231_0.levelStrategyView

	var_4.ActionInvoke(var_231_4, "setCBFunc", var_231_2, var_231_3)

	return
end

function var_0_1.hideStrategyInfo(arg_234_0)
	if arg_234_0.levelStrategyView then
		local var_234_0 = arg_234_0.levelStrategyView

		var_1.Destroy(var_234_0)

		arg_234_0.levelStrategyView = nil
	end

	return
end

function var_0_1.displayRepairWindow(arg_235_0, arg_235_1)
	local var_235_0 = arg_235_0.contextData.chapterVO

	getProxy = var_1_10003
	ChapterProxy = var_1_10004

	local var_235_1 = var_1_10003(var_1_10004)
	local var_235_2
	local var_235_3
	local var_235_4
	local var_235_5
	local var_235_6 = var_235_1.repairTimes

	ChapterConst = var_1_10008

	local var_235_7, var_235_8, var_235_9 = var_1_10008.GetRepairParams()
	local var_235_10 = var_235_9
	local var_235_11 = var_235_8
	local var_235_12 = var_235_7

	LevelRepairView = var_235_7
	arg_235_0.levelRepairView = var_235_7.New(arg_235_0.topPanel, arg_235_0.event, arg_235_0.contextData)

	local var_235_13 = arg_235_0.levelRepairView

	var_8.Load(var_235_13)

	local var_235_14 = arg_235_0.levelRepairView

	var_8.ActionInvoke(var_235_14, "set", var_235_6, var_235_12, var_235_11, var_235_10)

	local function var_235_15()
		local var_236_0 = var_235_12

		math = var_2_10001

		if var_236_0 - var_2_10001.min(var_235_6, var_235_12) == 0 then
			local var_236_1 = arg_235_0.player

			if var_1.getTotalGem(var_236_1) < var_235_10 then
				pg = var_1

				local var_236_2 = var_1.TipsMgr.GetInstance()
				local var_236_3 = var_1.ShowTips

				i18n = var_3

				var_236_3(var_236_2, var_3("common_no_rmb"))

				return
			end
		end

		local var_236_4 = arg_235_0
		local var_236_5 = var_1.emit

		LevelMediator2 = var_3

		local var_236_6 = var_3.ON_OP
		local var_236_7 = {}

		ChapterConst = var_2_10005
		var_236_7.type = var_2_10005.OpRepair
		var_236_7.id = var_235_0.fleet.id
		var_236_7.arg1 = arg_235_1.id

		var_236_5(var_236_4, var_236_6, var_236_7)

		local var_236_8 = arg_235_0

		var_1.hideRepairWindow(var_236_8)

		return
	end

	local function var_235_16()
		local var_237_0 = arg_235_0

		var_0.hideRepairWindow(var_237_0)

		return
	end

	local var_235_17 = arg_235_0.levelRepairView

	var_10.ActionInvoke(var_235_17, "setCBFunc", var_235_15, var_235_16)

	return
end

function var_0_1.hideRepairWindow(arg_238_0)
	if arg_238_0.levelRepairView then
		local var_238_0 = arg_238_0.levelRepairView

		var_1.Destroy(var_238_0)

		arg_238_0.levelRepairView = nil
	end

	return
end

function var_0_1.displayRemasterPanel(arg_239_0, arg_239_1)
	local var_239_0 = arg_239_0.levelRemasterView

	var_2.Load(var_239_0)

	local function var_239_1(arg_240_0)
		local var_240_0 = arg_239_0

		var_1.ShowSelectedMap(var_240_0, arg_240_0)

		return
	end

	local var_239_2 = arg_239_0.levelRemasterView

	var_3.ActionInvoke(var_239_2, "Show")

	local var_239_3 = arg_239_0.levelRemasterView

	var_3.ActionInvoke(var_239_3, "set", var_239_1, arg_239_1)

	return
end

function var_0_1.hideRemasterPanel(arg_241_0)
	local var_241_0 = arg_241_0.levelRemasterView

	if var_1.isShowing(var_241_0) then
		local var_241_1 = arg_241_0.levelRemasterView

		var_1.ActionInvoke(var_241_1, "Hide")
	end

	return
end

function var_0_1.initGrid(arg_242_0, arg_242_1)
	if not arg_242_0.contextData.chapterVO then
		return
	end

	arg_242_0:enableLevelCamera()

	setActive = var_3

	var_3(arg_242_0.uiMain, true)

	local var_242_0 = arg_242_0.levelGrid

	Vector3 = var_4
	var_242_0.localEulerAngles = var_4(var_2.theme.angle, 0, 0)
	LevelGrid = var_242_0
	arg_242_0.grid = var_242_0.New(arg_242_0.dragLayer)

	local var_242_1 = arg_242_0.grid

	var_3.attach(var_242_1, arg_242_0)

	local var_242_2 = arg_242_0.grid

	var_3.ExtendItem(var_242_2, "shipTpl", arg_242_0.shipTpl)

	local var_242_3 = arg_242_0.grid

	var_3.ExtendItem(var_242_3, "subTpl", arg_242_0.subTpl)

	local var_242_4 = arg_242_0.grid

	var_3.ExtendItem(var_242_4, "transportTpl", arg_242_0.transportTpl)

	local var_242_5 = arg_242_0.grid

	var_3.ExtendItem(var_242_5, "enemyTpl", arg_242_0.enemyTpl)

	local var_242_6 = arg_242_0.grid

	var_3.ExtendItem(var_242_6, "championTpl", arg_242_0.championTpl)

	local var_242_7 = arg_242_0.grid

	var_3.ExtendItem(var_242_7, "oniTpl", arg_242_0.oniTpl)

	local var_242_8 = arg_242_0.grid

	var_3.ExtendItem(var_242_8, "arrowTpl", arg_242_0.arrowTarget)

	local var_242_9 = arg_242_0.grid

	var_3.ExtendItem(var_242_9, "destinationMarkTpl", arg_242_0.destinationMarkTpl)

	function arg_242_0.grid.onShipStepChange(arg_243_0)
		local var_243_0 = arg_242_0.levelStageView

		var_1.updateAmbushRate(var_243_0, arg_243_0)

		return
	end

	local var_242_10 = arg_242_0.grid

	var_3.initAll(var_242_10, arg_242_1)

	return
end

function var_0_1.destroyGrid(arg_244_0)
	if arg_244_0.grid then
		local var_244_0 = arg_244_0.grid

		var_1.detach(var_244_0)

		arg_244_0.grid = nil

		arg_244_0:disableLevelCamera()

		setActive = var_1

		var_1(arg_244_0.dragLayer, true)

		setActive = var_1

		var_1(arg_244_0.uiMain, false)
	end

	return
end

function var_0_1.doTracking(arg_245_0, arg_245_1)
	arg_245_0:frozen()

	local function var_245_0()
		local var_246_0 = arg_245_0.radar

		var_0.SetActive(var_246_0, true)

		tf = var_0

		local var_246_1 = var_0(arg_245_0.radar)

		var_0.SetParent(var_246_1, arg_245_0.topPanel, false)
		var_0:SetSiblingIndex(1)

		local var_246_2 = var_0:GetComponent("DftAniEvent")

		var_1.SetEndEvent(var_246_2, function(arg_247_0)
			local var_247_0 = arg_245_0.radar

			var_1.SetActive(var_247_0, false)

			local var_247_1 = arg_245_0

			var_1.unfrozen(var_247_1)
			arg_245_1()

			return
		end)

		pg = var_2

		local var_246_3 = var_2.CriMgr.GetInstance()
		local var_246_4 = var_2.PlaySoundEffect_V3

		SFX_UI_WEIGHANCHOR_SEARCH = var_4

		var_246_4(var_246_3, var_4)

		return
	end

	if not arg_245_0.radar then
		PoolMgr = var_3

		local var_245_1 = var_3.GetInstance()

		var_3.GetUI(var_245_1, "RadarEffectUI", true, function(arg_248_0)
			arg_248_0:SetActive(true)

			arg_245_0.radar = arg_248_0

			var_245_0()

			return
		end)
	else
		var_245_0()
	end

	return
end

function var_0_1.destroyTracking(arg_249_0)
	if arg_249_0.radar then
		PoolMgr = var_1

		local var_249_0 = var_1.GetInstance()

		var_1.ReturnUI(var_249_0, "RadarEffectUI", arg_249_0.radar)

		arg_249_0.radar = nil
	end

	return
end

function var_0_1.doPlayAirStrike(arg_250_0, arg_250_1, arg_250_2, arg_250_3)
	local function var_250_0()
		arg_250_0.playing = true

		local var_251_0 = arg_250_0

		var_0.frozen(var_251_0)

		local var_251_1 = arg_250_0.airStrike

		var_0.SetActive(var_251_1, true)

		tf = var_0

		local var_251_2 = var_0(arg_250_0.airStrike)
		local var_251_3 = var_0.SetParent

		pg = var_2_10003

		var_251_3(var_251_2, var_2_10003.UIMgr.GetInstance().OverlayMain.transform, false)
		var_0:SetAsLastSibling()

		setActive = var_1

		local var_251_4 = var_0:Find("words/be_striked")
		local var_251_5 = arg_250_1

		ChapterConst = var_4

		var_1(var_251_4, var_251_5 == var_4.SubjectChampion)

		setActive = var_1

		local var_251_6 = var_0:Find("words/strike_enemy")
		local var_251_7 = arg_250_1

		ChapterConst = var_4

		var_1(var_251_6, var_251_7 == var_4.SubjectPlayer)

		local function var_251_8()
			local var_252_0 = arg_250_0

			var_252_0.playing = false
			SetActive = var_252_0

			var_252_0(arg_250_0.airStrike, false)

			if arg_250_3 then
				arg_250_3()
			end

			local var_252_1 = arg_250_0

			var_0.unfrozen(var_252_1)

			return
		end

		local var_251_9 = var_0:GetComponent("DftAniEvent")

		var_2.SetEndEvent(var_251_9, var_251_8)

		local var_251_11

		if arg_250_2 then
			onButton = var_3

			local var_251_10 = arg_250_0

			var_251_11 = var_0

			local var_251_12 = var_251_8

			SFX_PANEL = var_2_10007

			var_3(var_251_10, var_251_11, var_251_12, var_2_10007)
		else
			removeOnButton = var_3

			var_3(var_0)
		end

		pg = var_3

		local var_251_13 = var_3.CriMgr.GetInstance()
		local var_251_14 = var_3.PlaySoundEffect_V3

		SFX_UI_WARNING = var_251_11

		var_251_14(var_251_13, var_251_11)

		return
	end

	if not arg_250_0.airStrike then
		PoolMgr = var_5

		local var_250_1 = var_5.GetInstance()

		var_5.GetUI(var_250_1, "AirStrike", true, function(arg_253_0)
			arg_253_0:SetActive(true)

			arg_250_0.airStrike = arg_253_0

			var_250_0()

			return
		end)
	else
		var_250_0()
	end

	return
end

function var_0_1.destroyAirStrike(arg_254_0)
	if arg_254_0.airStrike then
		local var_254_0 = arg_254_0.airStrike
		local var_254_1 = var_1.GetComponent(var_254_0, "DftAniEvent")

		var_1.SetEndEvent(var_254_1, nil)

		PoolMgr = var_2

		local var_254_2 = var_2.GetInstance()

		var_2.ReturnUI(var_254_2, "AirStrike", arg_254_0.airStrike)

		arg_254_0.airStrike = nil
	end

	return
end

function var_0_1.doPlayAnim(arg_255_0, arg_255_1, arg_255_2, arg_255_3)
	local var_255_0

	if not arg_255_0.uiAnims then
		var_255_0 = {}
	end

	arg_255_0.uiAnims = var_255_0

	local var_255_1 = arg_255_0.uiAnims[arg_255_1]

	local function var_255_2()
		arg_255_0.playing = true

		local var_256_0 = arg_255_0

		var_0.frozen(var_256_0)

		local var_256_1 = var_255_1

		var_0.SetActive(var_256_1, true)

		tf = var_0

		local var_256_2 = var_0(var_255_1)

		pg = var_1

		local var_256_3 = var_1.UIMgr.GetInstance()

		var_1.OverlayPanel(var_256_3, var_256_2)

		if arg_255_3 then
			arg_255_3(var_255_1)
		end

		local var_256_4 = var_256_2:GetComponent("DftAniEvent")

		var_1.SetEndEvent(var_256_4, function(arg_257_0)
			local var_257_0 = arg_255_0

			var_257_0.playing = false
			pg = var_257_0

			local var_257_1 = var_257_0.UIMgr.GetInstance()

			var_1.UnOverlayPanel(var_257_1, var_256_2, arg_255_0._tf)

			if arg_255_2 then
				arg_255_2(var_255_1)
			end

			local var_257_2 = arg_255_0

			var_1.unfrozen(var_257_2)

			return
		end)

		pg = var_2

		local var_256_5 = var_2.CriMgr.GetInstance()
		local var_256_6 = var_2.PlaySoundEffect_V3

		SFX_UI_WARNING = var_4

		var_256_6(var_256_5, var_4)

		return
	end

	if not var_255_1 then
		PoolMgr = var_1_10006

		local var_255_3 = var_1_10006.GetInstance()

		var_6.GetUI(var_255_3, arg_255_1, true, function(arg_258_0)
			arg_258_0:SetActive(true)

			arg_255_0.uiAnims[arg_255_1] = arg_258_0
			var_255_1 = arg_255_0.uiAnims[arg_255_1]

			var_255_2()

			return
		end)
	else
		var_255_2()
	end

	return
end

function var_0_1.destroyUIAnims(arg_259_0)
	if arg_259_0.uiAnims then
		pairs = var_1

		for iter_259_0, iter_259_1 in var_1(arg_259_0.uiAnims) do
			pg = var_1_10006

			local var_259_0 = var_1_10006.UIMgr.GetInstance()

			var_1_10006 = var_1_10006.UnOverlayPanel
			tf = var_1_10008

			var_1_10006(var_259_0, var_1_10008(iter_259_1), arg_259_0._tf)

			var_1_10008 = iter_259_1:GetComponent("DftAniEvent")

			var_1_10006.SetEndEvent(var_1_10008, nil)

			PoolMgr = var_7
			var_1_10008 = var_7.GetInstance()

			var_7.ReturnUI(var_1_10008, iter_259_0, iter_259_1)
		end

		arg_259_0.uiAnims = nil
	end

	return
end

function var_0_1.doPlayTorpedo(arg_260_0, arg_260_1)
	local function var_260_0()
		arg_260_0.playing = true

		local var_261_0 = arg_260_0

		var_0.frozen(var_261_0)

		local var_261_1 = arg_260_0.torpetoAni

		var_0.SetActive(var_261_1, true)

		tf = var_0

		local var_261_2 = var_0(arg_260_0.torpetoAni)

		var_0.SetParent(var_261_2, arg_260_0.topPanel, false)
		var_0:SetAsLastSibling()

		local var_261_3 = var_0:GetComponent("DftAniEvent")

		var_1.SetEndEvent(var_261_3, function(arg_262_0)
			local var_262_0 = arg_260_0

			var_262_0.playing = false
			SetActive = var_262_0

			var_262_0(arg_260_0.torpetoAni, false)

			if arg_260_1 then
				arg_260_1()
			end

			local var_262_1 = arg_260_0

			var_1.unfrozen(var_262_1)

			return
		end)

		pg = var_2

		local var_261_4 = var_2.CriMgr.GetInstance()
		local var_261_5 = var_2.PlaySoundEffect_V3

		SFX_UI_WARNING = var_4

		var_261_5(var_261_4, var_4)

		return
	end

	if not arg_260_0.torpetoAni then
		PoolMgr = var_3

		local var_260_1 = var_3.GetInstance()

		var_3.GetUI(var_260_1, "Torpeto", true, function(arg_263_0)
			arg_263_0:SetActive(true)

			arg_260_0.torpetoAni = arg_263_0

			var_260_0()

			return
		end)
	else
		var_260_0()
	end

	return
end

function var_0_1.destroyTorpedo(arg_264_0)
	if arg_264_0.torpetoAni then
		local var_264_0 = arg_264_0.torpetoAni
		local var_264_1 = var_1.GetComponent(var_264_0, "DftAniEvent")

		var_1.SetEndEvent(var_264_1, nil)

		PoolMgr = var_2

		local var_264_2 = var_2.GetInstance()

		var_2.ReturnUI(var_264_2, "Torpeto", arg_264_0.torpetoAni)

		arg_264_0.torpetoAni = nil
	end

	return
end

function var_0_1.doPlayStrikeAnim(arg_265_0, arg_265_1, arg_265_2, arg_265_3)
	local var_265_0

	if not arg_265_0.strikeAnims then
		var_265_0 = {}
	end

	arg_265_0.strikeAnims = var_265_0

	local var_265_1
	local var_265_2
	local var_265_3

	local function var_265_4()
		coroutine = var_2_10000

		if var_2_10000.status(var_265_3) == "suspended" then
			coroutine = var_0

			local var_266_0, var_266_1 = var_0.resume(var_265_3)

			assert = var_2_10002

			local var_266_2 = var_266_0

			debug = var_2_10004

			var_2_10002(var_266_2, var_2_10004.traceback(var_265_3, var_266_1))
		end

		return
	end

	coroutine = var_1_10008
	var_265_3 = var_1_10008.create(function()
		arg_265_0.playing = true

		local var_267_0 = arg_265_0

		var_0.frozen(var_267_0)

		local var_267_1 = arg_265_0.strikeAnims[arg_265_2]

		setActive = var_1

		var_1(var_267_1, true)

		tf = var_1

		local var_267_2 = var_1(var_267_1)

		findTF = var_2

		local var_267_3 = var_2(var_267_2, "torpedo")

		findTF = var_3

		local var_267_4 = var_3(var_267_2, "mask/painting")

		findTF = var_4

		local var_267_5 = var_4(var_267_2, "ship")

		setParent = var_5

		var_5(var_265_1, var_267_4:Find("fitter"), false)

		local var_267_6 = var_265_2

		var_5.SetParent(var_267_6, var_267_5)

		setActive = var_5

		var_5(var_267_5, false)

		setActive = var_5

		var_5(var_267_3, false)

		local var_267_7 = var_267_2
		local var_267_8 = var_267_2.SetParent

		pg = var_7

		var_267_8(var_267_7, var_7.UIMgr.GetInstance().OverlayMain.transform, false)
		var_267_2:SetAsLastSibling()

		local var_267_9 = var_267_2:GetComponent("DftAniEvent")
		local var_267_10 = var_265_2
		local var_267_11 = var_6.GetSkeletonGraphic(var_267_10)

		var_267_9:SetStartEvent(function(arg_268_0)
			local var_268_0 = var_265_2

			var_1.SetAction(var_268_0, "attack", 0)

			var_267_11.freeze = true

			return
		end)
		var_267_9:SetTriggerEvent(function(arg_269_0)
			var_267_11.freeze = false

			local var_269_0 = var_265_2

			var_1.SetActionCallBack(var_269_0, function(arg_270_0)
				if arg_270_0 == "action" then
					-- block empty
				elseif arg_270_0 == "finish" then
					var_267_11.freeze = true
				end

				return
			end)

			return
		end)
		var_267_9:SetEndEvent(function(arg_271_0)
			var_267_11.freeze = false

			var_265_4()

			return
		end)

		onButton = var_7

		local var_267_12 = arg_265_0
		local var_267_13 = var_267_2
		local var_267_14 = var_265_4

		SFX_CANCEL = var_2_10011

		var_7(var_267_12, var_267_13, var_267_14, var_2_10011)

		coroutine = var_7

		var_7.yield()

		retPaintingPrefab = var_7

		local var_267_15 = var_267_4
		local var_267_16 = arg_265_1

		var_7(var_267_15, var_9.getPainting(var_267_16))

		local var_267_17 = var_265_2

		var_7.SetActionCallBack(var_267_17, nil)

		var_267_11.freeze = false

		local var_267_18 = var_265_2

		var_7.Dispose(var_267_18)

		setActive = var_7

		var_7(var_267_1, false)

		arg_265_0.playing = false

		local var_267_19 = arg_265_0

		var_7.unfrozen(var_267_19)

		if arg_265_3 then
			arg_265_3()
		end

		return
	end)

	local function var_265_5()
		if arg_265_0.strikeAnims[arg_265_2] and var_265_1 and var_265_2 then
			var_265_4()
		end

		return
	end

	PoolMgr = var_9

	local var_265_6 = var_9.GetInstance()

	var_9.GetPainting(var_265_6, arg_265_1:getPainting(), true, function(arg_273_0)
		var_265_1 = arg_273_0
		ShipExpressionHelper = var_2_10001

		local var_273_0 = var_2_10001.SetExpression
		local var_273_1 = var_265_1
		local var_273_2 = arg_265_1

		var_273_0(var_273_1, var_3.getPainting(var_273_2))
		var_265_5()

		return
	end)

	SpineAnimChar = var_9

	local var_265_7 = var_9.New()

	var_265_2.SetPaint(var_265_7, arg_265_1:getPrefab())
	var_265_2:Load(true, function(arg_274_0)
		local var_274_0 = var_265_2
		local var_274_1 = var_1.SetLocalScale

		Vector3 = var_2_10003

		var_274_1(var_274_0, var_2_10003.one)
		var_265_5()

		return
	end)

	if not arg_265_0.strikeAnims[arg_265_2] then
		PoolMgr = var_9

		local var_265_8 = var_9.GetInstance()

		var_9.GetUI(var_265_8, arg_265_2, true, function(arg_275_0)
			arg_265_0.strikeAnims[arg_265_2] = arg_275_0

			var_265_5()

			return
		end)
	end

	return
end

function var_0_1.destroyStrikeAnim(arg_276_0)
	if arg_276_0.strikeAnims then
		pairs = var_1

		for iter_276_0, iter_276_1 in var_1(arg_276_0.strikeAnims) do
			local var_276_0 = iter_276_1:GetComponent("DftAniEvent")

			var_6.SetEndEvent(var_276_0, nil)

			PoolMgr = var_7

			local var_276_1 = var_7.GetInstance()

			var_7.ReturnUI(var_276_1, iter_276_0, iter_276_1)
		end

		arg_276_0.strikeAnims = nil
	end

	return
end

function var_0_1.doPlayEnemyAnim(arg_277_0, arg_277_1, arg_277_2, arg_277_3)
	local var_277_0

	if not arg_277_0.strikeAnims then
		var_277_0 = {}
	end

	arg_277_0.strikeAnims = var_277_0

	local var_277_1
	local var_277_2

	local function var_277_3()
		coroutine = var_2_10000

		if var_2_10000.status(var_277_2) == "suspended" then
			coroutine = var_0

			local var_278_0, var_278_1 = var_0.resume(var_277_2)

			assert = var_2_10002

			local var_278_2 = var_278_0

			debug = var_2_10004

			var_2_10002(var_278_2, var_2_10004.traceback(var_277_2, var_278_1))
		end

		return
	end

	coroutine = var_1_10007
	var_277_2 = var_1_10007.create(function()
		arg_277_0.playing = true

		local var_279_0 = arg_277_0

		var_0.frozen(var_279_0)

		local var_279_1 = arg_277_0.strikeAnims[arg_277_2]

		setActive = var_1

		var_1(var_279_1, true)

		tf = var_1

		local var_279_2 = var_1(var_279_1)

		findTF = var_2

		local var_279_3 = var_2(var_279_2, "torpedo")

		findTF = var_3

		local var_279_4 = var_3(var_279_2, "ship")
		local var_279_5 = var_277_1

		var_4.SetParent(var_279_5, var_279_4)

		setActive = var_4

		var_4(var_279_4, false)

		setActive = var_4

		var_4(var_279_3, false)

		local var_279_6 = var_279_2
		local var_279_7 = var_279_2.SetParent

		pg = var_6

		var_279_7(var_279_6, var_6.UIMgr.GetInstance().OverlayMain.transform, false)
		var_279_2:SetAsLastSibling()

		local var_279_8 = var_279_2:GetComponent("DftAniEvent")
		local var_279_9 = var_277_1
		local var_279_10 = var_5.GetSkeletonGraphic(var_279_9)

		var_279_8:SetStartEvent(function(arg_280_0)
			local var_280_0 = var_277_1

			var_1.SetAction(var_280_0, "attack", 0)

			var_279_10.freeze = true

			return
		end)
		var_279_8:SetTriggerEvent(function(arg_281_0)
			var_279_10.freeze = false

			local var_281_0 = var_277_1

			var_1.SetActionCallBack(var_281_0, function(arg_282_0)
				if arg_282_0 == "action" then
					-- block empty
				elseif arg_282_0 == "finish" then
					var_279_10.freeze = true
				end

				return
			end)

			return
		end)
		var_279_8:SetEndEvent(function(arg_283_0)
			var_279_10.freeze = false

			var_277_3()

			return
		end)

		onButton = var_6

		local var_279_11 = arg_277_0
		local var_279_12 = var_279_2
		local var_279_13 = var_277_3

		SFX_CANCEL = var_2_10010

		var_6(var_279_11, var_279_12, var_279_13, var_2_10010)

		coroutine = var_6

		var_6.yield()

		local var_279_14 = var_277_1

		var_6.SetActionCallBack(var_279_14, nil)

		var_279_10.freeze = false

		local var_279_15 = var_277_1

		var_6.Dispose(var_279_15)

		setActive = var_6

		var_6(var_279_1, false)

		arg_277_0.playing = false

		local var_279_16 = arg_277_0

		var_6.unfrozen(var_279_16)

		if arg_277_3 then
			arg_277_3()
		end

		return
	end)

	local function var_277_4()
		if arg_277_0.strikeAnims[arg_277_2] and var_277_1 then
			var_277_3()
		end

		return
	end

	SpineAnimChar = var_8

	local var_277_5 = var_8.New()

	var_277_1.SetPaint(var_277_5, arg_277_1:getPrefab())
	var_277_1:Load(true, function(arg_285_0)
		local var_285_0 = arg_285_0
		local var_285_1 = arg_285_0.SetLocalScale

		Vector3 = var_2_10003

		var_285_1(var_285_0, var_2_10003.one)
		var_277_4()

		return
	end)

	if not arg_277_0.strikeAnims[arg_277_2] then
		PoolMgr = var_8

		local var_277_6 = var_8.GetInstance()

		var_8.GetUI(var_277_6, arg_277_2, true, function(arg_286_0)
			arg_277_0.strikeAnims[arg_277_2] = arg_286_0

			var_277_4()

			return
		end)
	end

	return
end

function var_0_1.doPlayCommander(arg_287_0, arg_287_1, arg_287_2)
	arg_287_0:frozen()

	setActive = var_3

	var_3(arg_287_0.commanderTinkle, true)

	local var_287_0 = arg_287_1
	local var_287_1 = arg_287_1.getSkills(var_287_0)

	setText = var_287_0

	local var_287_2 = arg_287_0.commanderTinkle
	local var_287_3 = var_5.Find(var_287_2, "name")

	if #var_287_1 > 0 then
		local var_287_4 = var_287_1[1]
		local var_287_5

		if not var_6.getConfig(var_287_4, "name") then
			var_287_5 = ""
		end

		var_287_0(var_287_3, var_287_5)

		setImageSprite = var_287_0

		local var_287_6 = arg_287_0.commanderTinkle
		local var_287_7 = var_5.Find(var_287_6, "icon")

		GetSpriteFromAtlas = var_287_6

		var_287_0(var_287_7, var_287_6("commanderhrz/" .. arg_287_1:getConfig("painting"), ""))

		local var_287_8 = arg_287_0.commanderTinkle
		local var_287_9 = var_4.GetComponent

		typeof = var_6
		CanvasGroup = var_7

		local var_287_10 = var_287_9(var_287_8, var_6(var_7))

		var_287_10.alpha = 0
		Vector2 = var_5

		local var_287_11 = var_5(248, 237)

		LeanTween = var_6

		local var_287_12 = var_6.value

		go = var_7

		local var_287_13 = var_287_12(var_7(arg_287_0.commanderTinkle), 0, 1, 0.5)
		local var_287_14 = var_6.setOnUpdate

		System = var_8

		local var_287_15 = var_287_14(var_287_13, var_8.Action_float(function(arg_288_0)
			local var_288_0 = arg_287_0.commanderTinkle.localPosition

			var_288_0.x = var_287_11.x + 28 * (1 - arg_288_0)
			arg_287_0.commanderTinkle.localPosition = var_288_0
			var_287_10.alpha = arg_288_0

			return
		end))
		local var_287_16 = var_6.setEase

		LeanTweenType = var_8

		var_287_16(var_287_15, var_8.easeOutSine)

		LeanTween = var_287_16

		local var_287_17 = var_287_16.value

		go = var_287_15

		local var_287_18 = var_287_17(var_287_15(arg_287_0.commanderTinkle), 0, 1, 0.3)
		local var_287_19 = var_6.setDelay(var_287_18, 0.7)
		local var_287_20 = var_6.setOnUpdate

		System = var_8

		local var_287_21 = var_287_20(var_287_19, var_8.Action_float(function(arg_289_0)
			local var_289_0 = arg_287_0.commanderTinkle.localPosition

			var_289_0.x = var_287_11.x + 100 * arg_289_0
			arg_287_0.commanderTinkle.localPosition = var_289_0
			var_287_10.alpha = 1 - arg_289_0

			return
		end))
		local var_287_22 = var_6.setOnComplete

		System = var_8

		var_287_22(var_287_21, var_8.Action(function()
			if arg_287_2 then
				arg_287_2()
			end

			local var_290_0 = arg_287_0

			var_0.unfrozen(var_290_0)

			return
		end))

		return
	end
end

function var_0_1.strikeEnemy(arg_291_0, arg_291_1, arg_291_2, arg_291_3)
	local var_291_0 = arg_291_0.grid

	if not var_4.shakeCell(var_291_0, arg_291_1) then
		arg_291_3()

		return
	end

	arg_291_0:easeDamage(var_4, arg_291_2, function()
		arg_291_3()

		return
	end)

	return
end

function var_0_1.easeDamage(arg_293_0, arg_293_1, arg_293_2, arg_293_3)
	arg_293_0:frozen()

	local var_293_0 = arg_293_0.levelCam
	local var_293_1 = var_4.WorldToScreenPoint(var_293_0, arg_293_1.position)

	tf = var_293_0

	local var_293_2 = var_293_0(arg_293_0:GetDamageText())
	local var_293_3 = arg_293_0.uiCam

	var_293_2.position = var_6.ScreenToWorldPoint(var_293_3, var_293_1)
	var_6.y = var_293_2.localPosition.y + 40
	var_6.z = 0
	setText = var_7

	var_7(var_293_2, arg_293_2)

	var_293_2.localPosition = var_6
	LeanTween = var_7

	local var_293_4 = var_7.value

	go = var_8

	local var_293_5 = var_293_4(var_8(var_293_2), 0, 1, 1)
	local var_293_6 = var_7.setOnUpdate

	System = var_9

	local var_293_7 = var_293_6(var_293_5, var_9.Action_float(function(arg_294_0)
		local var_294_0 = var_293_2.localPosition

		var_294_0.y = var_0.y + 60 * arg_294_0

		local var_294_1 = var_293_2

		var_294_1.localPosition = var_294_0
		setTextAlpha = var_294_1

		var_294_1(var_293_2, 1 - arg_294_0)

		return
	end))
	local var_293_8 = var_7.setOnComplete

	System = var_9

	var_293_8(var_293_7, var_9.Action(function()
		local var_295_0 = arg_293_0

		var_0.ReturnDamageText(var_295_0, var_293_2)

		local var_295_1 = arg_293_0

		var_0.unfrozen(var_295_1)

		if arg_293_3 then
			arg_293_3()
		end

		return
	end))

	return
end

function var_0_1.easeAvoid(arg_296_0, arg_296_1, arg_296_2)
	arg_296_0:frozen()

	local var_296_0 = arg_296_0.levelCam
	local var_296_1 = var_3.WorldToScreenPoint(var_296_0, arg_296_1)
	local var_296_2 = arg_296_0.avoidText
	local var_296_3 = arg_296_0.uiCam

	var_296_2.position = var_5.ScreenToWorldPoint(var_296_3, var_296_1)

	local var_296_4 = arg_296_0.avoidText.localPosition

	var_296_4.z = 0

	local var_296_5 = arg_296_0.avoidText

	var_296_5.localPosition = var_296_4
	setActive = var_296_5

	var_296_5(arg_296_0.avoidText, true)

	local var_296_6 = arg_296_0.avoidText
	local var_296_7 = var_5.Find(var_296_6, "avoid")

	LeanTween = var_296_6

	local var_296_8 = var_296_6.value

	go = var_7

	local var_296_9 = var_296_8(var_7(arg_296_0.avoidText), 0, 1, 1)
	local var_296_10 = var_6.setOnUpdate

	System = var_8

	local var_296_11 = var_296_10(var_296_9, var_8.Action_float(function(arg_297_0)
		local var_297_0 = arg_296_0.avoidText.localPosition

		var_297_0.y = var_296_4.y + 100 * arg_297_0

		local var_297_1 = arg_296_0.avoidText

		var_297_1.localPosition = var_297_0
		setImageAlpha = var_297_1

		var_297_1(arg_296_0.avoidText, 1 - arg_297_0)

		setImageAlpha = var_297_1

		var_297_1(var_296_7, 1 - arg_297_0)

		return
	end))
	local var_296_12 = var_6.setOnComplete

	System = var_8

	var_296_12(var_296_11, var_8.Action(function()
		setActive = var_2_10000

		var_2_10000(arg_296_0.avoidText, false)

		local var_298_0 = arg_296_0

		var_0.unfrozen(var_298_0)

		if arg_296_2 then
			arg_296_2()
		end

		return
	end))

	return
end

function var_0_1.GetDamageText(arg_299_0)
	table = var_1_10001

	local var_299_0, var_299_2

	if not var_1_10001.remove(arg_299_0.damageTextPool) then
		Instantiate = var_299_2
		var_299_0 = var_299_2(arg_299_0.damageTextTemplate)
		tf = var_299_2

		local var_299_1 = var_299_2(arg_299_0.damageTextTemplate)

		var_299_2 = var_299_2.GetSiblingIndex(var_299_1)
		setParent = var_299_1

		local var_299_3 = var_299_0

		tf = var_1_10005

		var_299_1(var_299_3, var_1_10005(arg_299_0.damageTextTemplate).parent)

		tf = var_299_1

		local var_299_4 = var_299_1(var_299_0)

		var_3.SetSiblingIndex(var_299_4, var_299_2 + 1)
	end

	table = var_299_2

	var_299_2.insert(arg_299_0.damageTextActive, var_299_0)

	setActive = var_2

	var_2(var_299_0, true)

	return var_299_0
end

function var_0_1.ReturnDamageText(arg_300_0, arg_300_1)
	assert = var_1_10002

	var_1_10002(arg_300_1)

	if not arg_300_1 then
		return
	end

	go = var_1_10002
	arg_300_1 = var_1_10002(arg_300_1)
	table = var_2

	var_2.removebyvalue(arg_300_0.damageTextActive, arg_300_1)

	table = var_2

	var_2.insert(arg_300_0.damageTextPool, arg_300_1)

	setActive = var_2

	var_2(arg_300_1, false)

	return
end

function var_0_1.resetLevelGrid(arg_301_0)
	local var_301_0 = arg_301_0.dragLayer

	Vector3 = var_1_10002
	var_301_0.localPosition = var_1_10002.zero

	return
end

function var_0_1.ShowCurtains(arg_302_0, arg_302_1)
	setActive = var_1_10002

	var_1_10002(arg_302_0.curtain, arg_302_1)

	return
end

function var_0_1.frozen(arg_303_0)
	local var_303_0 = arg_303_0.frozenCount

	arg_303_0.frozenCount = arg_303_0.frozenCount + 1
	arg_303_0.canvasGroup.blocksRaycasts = arg_303_0.frozenCount == 0

	if var_303_0 == 0 and arg_303_0.frozenCount ~= 0 then
		local var_303_1 = arg_303_0
		local var_303_2 = arg_303_0.emit

		LevelUIConst = var_1_10004

		var_303_2(var_303_1, var_1_10004.ON_FROZEN)
	end

	return
end

function var_0_1.unfrozen(arg_304_0, arg_304_1)
	if arg_304_0.exited then
		return
	end

	local var_304_0 = arg_304_0.frozenCount
	local var_304_1

	if arg_304_1 ~= -1 or not arg_304_0.frozenCount then
		var_304_1 = arg_304_1 or 1
	end

	arg_304_0.frozenCount = arg_304_0.frozenCount - var_304_1
	arg_304_0.canvasGroup.blocksRaycasts = arg_304_0.frozenCount == 0

	if var_304_0 ~= 0 and arg_304_0.frozenCount == 0 then
		local var_304_2 = arg_304_0
		local var_304_3 = arg_304_0.emit

		LevelUIConst = var_1_10006

		var_304_3(var_304_2, var_1_10006.ON_UNFROZEN)
	end

	return
end

function var_0_1.isfrozen(arg_305_0)
	return arg_305_0.frozenCount > 0
end

function var_0_1.enableLevelCamera(arg_306_0)
	math = var_1_10001
	arg_306_0.levelCamIndices = var_1_10001.max(arg_306_0.levelCamIndices - 1, 0)

	if arg_306_0.levelCamIndices == 0 then
		local var_306_0 = arg_306_0.levelCam

		var_306_0.enabled = true
		pg = var_306_0

		local var_306_1 = var_306_0.LayerWeightMgr.GetInstance()

		var_1.CreateRefreshHandler(var_306_1)
	end

	return
end

function var_0_1.disableLevelCamera(arg_307_0)
	arg_307_0.levelCamIndices = arg_307_0.levelCamIndices + 1

	if arg_307_0.levelCamIndices > 0 then
		local var_307_0 = arg_307_0.levelCam

		var_307_0.enabled = false
		pg = var_307_0

		local var_307_1 = var_307_0.LayerWeightMgr.GetInstance()

		var_1.CreateRefreshHandler(var_307_1)
	end

	return
end

function var_0_1.RecordTween(arg_308_0, arg_308_1, arg_308_2)
	arg_308_0.tweens[arg_308_1] = arg_308_2

	return
end

function var_0_1.DeleteTween(arg_309_0, arg_309_1)
	if arg_309_0.tweens[arg_309_1] then
		LeanTween = var_1_10003

		var_1_10003.cancel(var_2)

		arg_309_0.tweens[arg_309_1] = nil
	end

	return
end

function var_0_1.openCommanderPanel(arg_310_0, arg_310_1, arg_310_2, arg_310_3)
	local var_310_0 = arg_310_2.id
	local var_310_1 = arg_310_0.levelCMDFormationView

	var_5.setCallback(var_310_1, function(arg_311_0)
		if not arg_310_3 then
			local var_311_0 = arg_311_0.type

			LevelUIConst = var_2_10002

			if var_311_0 == var_2_10002.COMMANDER_OP_SHOW_SKILL then
				var_2_10002 = arg_310_0

				local var_311_1 = var_1.emit

				LevelMediator2 = var_2_10003

				var_311_1(var_2_10002, var_2_10003.ON_COMMANDER_SKILL, arg_311_0.skill)
			else
				local var_311_2 = arg_311_0.type

				LevelUIConst = var_2_10002

				if var_311_2 == var_2_10002.COMMANDER_OP_ADD then
					arg_310_0.contextData.commanderSelected = {
						chapterId = var_310_0,
						fleetId = arg_310_1.id
					}
					var_2_10002 = arg_310_0

					local var_311_3 = var_1.emit

					LevelMediator2 = var_2_10003

					var_311_3(var_2_10002, var_2_10003.ON_SELECT_COMMANDER, arg_311_0.pos, arg_310_1.id, arg_310_2)

					var_2_10002 = arg_310_0

					var_1.closeCommanderPanel(var_2_10002)
				else
					var_2_10002 = arg_310_0

					local var_311_4 = var_1.emit

					LevelMediator2 = var_2_10003
					var_2_10003 = var_2_10003.ON_COMMANDER_OP

					local var_311_5 = {}

					LevelUIConst = var_2_10005
					var_311_5.FleetType = var_2_10005.FLEET_TYPE_SELECT
					var_311_5.data = arg_311_0
					var_311_5.fleetId = arg_310_1.id
					var_311_5.chapterId = var_310_0

					var_311_4(var_2_10002, var_2_10003, var_311_5, arg_310_2)
				end
			end
		else
			local var_311_6 = arg_311_0.type

			LevelUIConst = var_2_10002

			local var_311_7

			if var_311_6 == var_2_10002.COMMANDER_OP_SHOW_SKILL then
				var_311_7 = arg_310_0

				local var_311_8 = var_1.emit

				LevelMediator2 = var_2_10003

				var_311_8(var_311_7, var_2_10003.ON_COMMANDER_SKILL, arg_311_0.skill)
			else
				local var_311_9 = arg_311_0.type

				LevelUIConst = var_311_7

				if var_311_9 == var_311_7.COMMANDER_OP_ADD then
					arg_310_0.contextData.eliteCommanderSelected = {
						index = arg_310_3,
						pos = arg_311_0.pos,
						chapterId = var_310_0
					}

					local var_311_10 = arg_310_0
					local var_311_11 = var_1.emit

					LevelMediator2 = var_2_10003

					var_311_11(var_311_10, var_2_10003.ON_SELECT_ELITE_COMMANDER, arg_310_3, arg_311_0.pos, arg_310_2)

					local var_311_12 = arg_310_0

					var_1.closeCommanderPanel(var_311_12)
				else
					local var_311_13 = arg_310_0
					local var_311_14 = var_1.emit

					LevelMediator2 = var_2_10003

					local var_311_15 = var_2_10003.ON_COMMANDER_OP
					local var_311_16 = {}

					LevelUIConst = var_2_10005
					var_311_16.FleetType = var_2_10005.FLEET_TYPE_EDIT
					var_311_16.data = arg_311_0
					var_311_16.index = arg_310_3
					var_311_16.chapterId = var_310_0

					var_311_14(var_311_13, var_311_15, var_311_16, arg_310_2)
				end
			end
		end

		return
	end)

	local var_310_2 = arg_310_0.levelCMDFormationView

	var_5.Load(var_310_2)

	local var_310_3 = arg_310_0.levelCMDFormationView

	var_5.ActionInvoke(var_310_3, "update", arg_310_1, arg_310_0.commanderPrefabs)

	local var_310_4 = arg_310_0.levelCMDFormationView

	var_5.ActionInvoke(var_310_4, "Show")

	return
end

function var_0_1.updateCommanderPrefab(arg_312_0)
	local var_312_0 = arg_312_0.levelCMDFormationView

	if var_1.isShowing(var_312_0) then
		local var_312_1 = arg_312_0.levelCMDFormationView

		var_1.ActionInvoke(var_312_1, "updatePrefabs", arg_312_0.commanderPrefabs)
	end

	return
end

function var_0_1.closeCommanderPanel(arg_313_0)
	local var_313_0 = arg_313_0.levelCMDFormationView

	var_1.ActionInvoke(var_313_0, "Hide")

	return
end

function var_0_1.destroyCommanderPanel(arg_314_0)
	local var_314_0 = arg_314_0.levelCMDFormationView

	var_1.Destroy(var_314_0)

	arg_314_0.levelCMDFormationView = nil

	return
end

function var_0_1.setSpecialOperationTickets(arg_315_0, arg_315_1)
	arg_315_0.spTickets = arg_315_1

	return
end

function var_0_1.HandleShowMsgBox(arg_316_0, arg_316_1)
	pg = var_1_10002

	local var_316_0 = var_1_10002.MsgboxMgr.GetInstance()

	var_2.ShowMsgBox(var_316_0, arg_316_1)

	return
end

function var_0_1.updatePoisonAreaTip(arg_317_0)
	local var_317_0 = arg_317_0.contextData.chapterVO

	local function var_317_1(arg_318_0)
		local var_318_0 = {}

		pg = var_2_10002

		local var_318_1

		if not var_2_10002.map_event_list[var_317_0.id] then
			var_318_1 = {}
		end

		local var_318_2
		local var_318_3 = var_317_0

		if var_4.isLoop(var_318_3) then
			var_318_2 = var_318_1.event_list_loop or {}
		else
			var_318_2 = var_318_1.event_list or {}
		end

		ipairs = var_4

		for iter_318_0, iter_318_1 in var_4(var_318_2) do
			pg = var_2_10009

			if var_2_10009.map_event_template[iter_318_1].c_type == arg_318_0 then
				table = var_10

				var_10.insert(var_318_0, var_2_10009)
			end
		end

		return var_318_0
	end

	ChapterConst = var_1_10004

	if var_317_1(var_1_10004.EvtType_Poison) then
		ipairs = var_4

		for iter_317_0, iter_317_1 in var_4(var_3) do
			if iter_317_1.round_gametip ~= nil and var_9 ~= "" and var_317_0:getRoundNum() == var_9[1] then
				pg = var_10

				local var_317_2 = var_10.TipsMgr.GetInstance()
				local var_317_3 = var_10.ShowTips

				i18n = var_1_10012

				var_317_3(var_317_2, var_1_10012(var_9[2]))
			end
		end
	end

	return
end

function var_0_1.updateVoteBookBtn(arg_319_0)
	setActive = var_1_10001

	var_1_10001(arg_319_0._voteBookBtn, false)

	return
end

function var_0_1.RecordLastMapOnExit(arg_320_0)
	getProxy = var_1_10001
	ChapterProxy = var_1_10002

	if var_1_10001(var_1_10002) and not arg_320_0.contextData.noRecord then
		if not arg_320_0.contextData.map then
			return
		end

		if var_2:NeedRecordMap() then
			local var_320_0 = var_1
			local var_320_1 = var_1.recordLastMap

			ChapterProxy = var_1_10005

			var_320_1(var_320_0, var_1_10005.LAST_MAP, var_2.id)
		end

		if var_2:isActivity() and not var_2:isActExtra() then
			local var_320_2 = var_1
			local var_320_3 = var_1.recordLastMap

			ChapterProxy = var_1_10005

			var_320_3(var_320_2, var_1_10005.LAST_MAP_FOR_ACTIVITY, var_2.id)
		end
	end

	return
end

function var_0_1.IsActShopActive(arg_321_0)
	if arg_321_0.contextData.map then
		getProxy = var_1
		ActivityProxy = var_1_10002

		local var_321_0 = var_1(var_1_10002)
		local var_321_1 = var_1.getActivityById

		var_1_10004 = arg_321_0.contextData.map

		local var_321_2

		if not var_321_1(var_321_0, var_1_10003.getConfig(var_1_10004, "on_activity")) then
			var_321_2 = nil
		end

		local var_321_3

		if var_321_2 then
			::label_321_0::

			var_1_10003 = var_321_2

			if not var_321_2.isEnd(var_1_10003) then
				var_1_10003 = var_321_2
				var_321_3 = var_321_2.GetConfigClientSetting(var_1_10003, "PTID")
			else
				var_321_3 = false
			end

			if false then
				var_321_3 = true
			end
		end

		getProxy = var_1_10003
		ActivityProxy = var_1_10004

		local var_321_4 = var_1_10003(var_1_10004)
		local var_321_5 = var_3.getActivityByType

		ActivityConst = var_1_10005

		local var_321_6

		if var_321_5(var_321_4, var_1_10005.ACTIVITY_TYPE_LOTTERY) then
			var_321_6 = var_3

			if not var_3.isEnd(var_321_6) then
				var_321_6 = var_3

				if var_3.getConfig(var_321_6, "config_client").resId == var_321_3 then
					return true
				end
			end
		end

		_ = var_321_4

		local var_321_7 = var_321_4.detect

		getProxy = var_321_6
		ActivityProxy = var_1_10006

		local var_321_8 = var_321_6(var_1_10006)
		local var_321_9 = var_5.getActivitiesByType

		ActivityConst = var_1_10007

		if var_321_7(var_321_9(var_321_8, var_1_10007.ACTIVITY_TYPE_SHOP), function(arg_322_0)
			return not arg_322_0:isEnd() and arg_322_0:getConfig("config_client").pt_id == var_321_3
		end) then
			return true
		end

		return
	end
end

function var_0_1.willExit(arg_323_0)
	arg_323_0:ClearMapTransitions()

	local var_323_0 = arg_323_0.loader

	var_1.Clear(var_323_0)

	if arg_323_0.contextData.chapterVO then
		arg_323_0:UnOverlayPanel(arg_323_0.topPanel, arg_323_0._tf)
	end

	if arg_323_0.levelFleetView and arg_323_0.levelFleetView.selectIds then
		local var_323_1 = arg_323_0.contextData

		var_323_1.selectedFleetIDs = {}
		pairs = var_323_1

		for iter_323_0, iter_323_1 in var_323_1(arg_323_0.levelFleetView.selectIds) do
			pairs = var_1_10006

			for iter_323_2, iter_323_3 in var_1_10006(iter_323_1) do
				arg_323_0.contextData.selectedFleetIDs[#arg_323_0.contextData.selectedFleetIDs + 1] = iter_323_3
			end
		end
	end

	arg_323_0:destroyChapterPanel()
	arg_323_0:DestroyLevelInfoSPPanel()
	arg_323_0:destroyFleetEdit()
	arg_323_0:destroyCommanderPanel()
	arg_323_0:DestroyLevelStageView()
	arg_323_0:hideRepairWindow()
	arg_323_0:hideStrategyInfo()
	arg_323_0:hideRemasterPanel()
	arg_323_0:hideSpResult()
	arg_323_0:destroyGrid()
	arg_323_0:destroyAmbushWarn()
	arg_323_0:destroyAirStrike()
	arg_323_0:destroyTorpedo()
	arg_323_0:destroyStrikeAnim()
	arg_323_0:destroyTracking()
	arg_323_0:destroyUIAnims()

	PoolMgr = var_1

	local var_323_2 = var_1.GetInstance()

	var_1.DestroyPrefab(var_323_2, "chapter/cell_quad_mark", "")

	PoolMgr = var_1

	local var_323_3 = var_1.GetInstance()

	var_1.DestroyPrefab(var_323_3, "chapter/cell_quad", "")

	PoolMgr = var_1

	local var_323_4 = var_1.GetInstance()

	var_1.DestroyPrefab(var_323_4, "chapter/cell", "")

	PoolMgr = var_1

	local var_323_5 = var_1.GetInstance()

	var_1.DestroyPrefab(var_323_5, "chapter/plane", "")

	pairs = var_1

	for iter_323_4, iter_323_5 in var_1(arg_323_0.mbDict) do
		iter_323_5:Destroy()
	end

	arg_323_0.mbDict = nil
	pairs = var_1

	for iter_323_6, iter_323_7 in var_1(arg_323_0.tweens) do
		LeanTween = var_1_10006

		var_1_10006.cancel(iter_323_7)
	end

	arg_323_0.tweens = nil

	if arg_323_0.cloudTimer then
		_ = var_1

		var_1.each(arg_323_0.cloudTimer, function(arg_324_0)
			LeanTween = var_2_10001

			var_2_10001.cancel(arg_324_0)

			return
		end)

		arg_323_0.cloudTimer = nil
	end

	if arg_323_0.newChapterCDTimer then
		local var_323_6 = arg_323_0.newChapterCDTimer

		var_1.Stop(var_323_6)

		arg_323_0.newChapterCDTimer = nil
	end

	ipairs = var_1

	for iter_323_8, iter_323_9 in var_1(arg_323_0.damageTextActive) do
		LeanTween = var_1_10006

		var_1_10006.cancel(iter_323_9)
	end

	LeanTween = var_1

	local var_323_7 = var_1.cancel

	go = var_2

	var_323_7(var_2(arg_323_0.avoidText))

	local var_323_8 = arg_323_0.map

	Vector3 = var_2
	var_323_8.localScale = var_2.one

	local var_323_9 = arg_323_0.map

	Vector2 = var_2
	var_323_9.pivot = var_2(0.5, 0.5)

	local var_323_10 = arg_323_0.float

	Vector3 = var_2
	var_323_10.localScale = var_2.one

	local var_323_11 = arg_323_0.float

	Vector2 = var_2
	var_323_11.pivot = var_2(0.5, 0.5)
	ipairs = var_323_11

	for iter_323_10, iter_323_11 in var_323_11(arg_323_0.mapTFs) do
		clearImageSprite = var_1_10006

		var_1_10006(iter_323_11)
	end

	_ = var_1

	var_1.each(arg_323_0.cloudRTFs, function(arg_325_0)
		clearImageSprite = var_2_10001

		var_2_10001(arg_325_0)

		return
	end)

	Destroy = var_1

	var_1(arg_323_0.enemyTpl)
	arg_323_0:RecordLastMapOnExit()

	local var_323_12 = arg_323_0.levelRemasterView

	var_1.Destroy(var_323_12)

	return
end

return var_0_1
