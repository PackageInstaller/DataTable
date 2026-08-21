local var_0_0 = class("LevelScene", import("..base.BaseUI"))
local var_0_1 = 0.5
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3

function var_0_0.forceGC(arg_1_0)
	return true
end

function var_0_0.getUIName(arg_2_0)
	return "LevelMainScene"
end

function var_0_0.ResUISettings(arg_3_0)
	return {
		groupDelta = 1,
		showType = PlayerResUI.TYPE_ALL
	}
end

function var_0_0.getBGM(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs({
		(function()
			return checkExist(arg_4_0.contextData.chapterVO, {
				"getConfig",
				{
					"bgm"
				}
			}) or ""
		end)(),
		(function()
			if not arg_4_0.contextData.map then
				return
			end

			local var_6_0 = arg_4_0.contextData.map:getConfig("ani_controller")
			local var_6_1 = getProxy(ChapterProxy)

			if var_6_0 and #var_6_0 > 0 then
				for iter_6_0, iter_6_1 in ipairs(var_6_0) do
					for iter_6_2, iter_6_3 in ipairs((_.rest(iter_6_1[2], 2))) do
						if string.find(iter_6_3, "^bgm_") and iter_6_1[1] == var_0_3 then
							local var_6_2 = false

							for iter_6_4, iter_6_5 in ipairs(iter_6_1[2][1]) do
								local var_6_3 = var_6_1:GetChapterItemById(iter_6_5)

								if var_6_3 and var_6_3:isClear() then
									var_6_2 = true

									break
								end
							end

							if not var_6_2 then
								return string.sub(iter_6_3, 5)
							end
						end
					end
				end
			end

			return checkExist(arg_4_0.contextData.map, {
				"getConfig",
				{
					"bgm"
				}
			}) or ""
		end)()
	}) do
		if iter_4_1 ~= "" then
			return iter_4_1
		end
	end

	return var_0_0.super.getBGM(arg_4_0)
end

var_0_0.optionsPath = {
	"top/top_chapter/option"
}

function var_0_0.preload(arg_7_0, arg_7_1)
	if arg_7_0.contextData.mapIdx and arg_7_0.contextData.chapterId then
		local var_7_0 = getProxy(ChapterProxy):getChapterById(arg_7_0.contextData.chapterId)

		if var_7_0:getConfig("map") == arg_7_0.contextData.mapIdx then
			arg_7_0.contextData.chapterVO = var_7_0

			if var_7_0.active then
				assert(not arg_7_0.contextData.openChapterId or arg_7_0.contextData.openChapterId == arg_7_0.contextData.chapterId)

				arg_7_0.contextData.openChapterId = nil
			end
		end
	end

	local var_7_1, var_7_2 = arg_7_0:GetInitializeMap()

	if arg_7_0.contextData.entranceStatus == nil then
		arg_7_0.contextData.entranceStatus = not var_7_2
	end

	if not arg_7_0.contextData.entranceStatus then
		arg_7_0:PreloadLevelMainUI(var_7_1, arg_7_1)
	else
		arg_7_1()
	end

	return
end

function var_0_0.GetInitializeMap(arg_8_0)
	local var_8_0 = (function()
		if arg_8_0.contextData.chapterVO and arg_8_0.contextData.chapterVO.active then
			return arg_8_0.contextData.chapterVO:getConfig("map")
		end

		local var_9_0 = arg_8_0.contextData.mapIdx

		if arg_8_0.contextData.mapIdx then
			return var_9_0
		end

		local var_9_1

		if arg_8_0.contextData.targetChapter and arg_8_0.contextData.targetMap then
			arg_8_0.contextData.openChapterId = arg_8_0.contextData.targetChapter
			var_9_1 = arg_8_0.contextData.targetMap.id
			arg_8_0.contextData.targetChapter = nil
			arg_8_0.contextData.targetMap = nil
		elseif arg_8_0.contextData.eliteDefault then
			local var_9_2 = getProxy(ChapterProxy):getUseableMaxEliteMap()

			var_9_1 = var_9_2 and var_9_2.id or nil
			arg_8_0.contextData.eliteDefault = nil
		end

		return var_9_1
	end)()
	local var_8_1 = var_8_0 and getProxy(ChapterProxy):getMapById(var_8_0)

	if var_8_1 then
		local var_8_2, var_8_3 = var_8_1:isUnlock()

		if not var_8_2 then
			pg.TipsMgr.GetInstance():ShowTips(var_8_3)

			var_8_0 = getProxy(ChapterProxy):getLastUnlockMap().id
			arg_8_0.contextData.mapIdx = var_8_0
		end
	else
		var_8_0 = nil
	end

	local var_8_4 = var_8_0 or getProxy(ChapterProxy):GetLastNormalMap()
	local var_8_5 = tobool(var_8_0)
end

function var_0_0.init(arg_10_0)
	arg_10_0:initData()
	arg_10_0:initUI()
	arg_10_0:initEvents()
	arg_10_0:updateClouds()

	return
end

function var_0_0.initData(arg_11_0)
	arg_11_0.tweens = {}
	arg_11_0.mapWidth, arg_11_0.mapHeight = arg_11_0._tf.rect.size.x, arg_11_0._tf.rect.size.y
	arg_11_0.levelCamIndices = 1
	arg_11_0.frozenCount = 0
	arg_11_0.currentBG = nil
	arg_11_0.mbDict = {}
	arg_11_0.mapGroup = {}
	arg_11_0.contextData.huntingRangeVisibility = arg_11_0.contextData.huntingRangeVisibility or 2

	return
end

function var_0_0.initUI(arg_12_0)
	arg_12_0.topPanel = arg_12_0._tf:Find("top")
	arg_12_0.canvasGroup = arg_12_0.topPanel:GetComponent("CanvasGroup")
	arg_12_0.canvasGroup.blocksRaycasts = not arg_12_0.canvasGroup.blocksRaycasts
	arg_12_0.canvasGroup.blocksRaycasts = not arg_12_0.canvasGroup.blocksRaycasts
	arg_12_0.entranceLayer = arg_12_0._tf:Find("entrance")
	arg_12_0.ptBonus = EventPtBonus.New(arg_12_0.entranceLayer:Find("btns/btn_task/bonusPt"))
	arg_12_0.entranceBg = arg_12_0._tf:Find("entrance_bg")
	arg_12_0.topChapter = arg_12_0.topPanel:Find("top_chapter")

	setActive(arg_12_0.topChapter:Find("title_chapter"), false)
	setActive(arg_12_0.topChapter:Find("type_chapter"), false)
	setActive(arg_12_0.topChapter:Find("type_escort"), false)
	setActive(arg_12_0.topChapter:Find("type_skirmish"), false)

	arg_12_0.chapterName = arg_12_0.topChapter:Find("title_chapter/name")
	arg_12_0.chapterNoTitle = arg_12_0.topChapter:Find("title_chapter/chapter")
	arg_12_0.resChapter = arg_12_0.topChapter:Find("resources")

	setActive(arg_12_0.topChapter, true)

	arg_12_0._voteBookBtn = arg_12_0.topChapter:Find("vote_book")
	arg_12_0.leftChapter = arg_12_0._tf:Find("main/left_chapter")

	setActive(arg_12_0.leftChapter, true)

	arg_12_0.leftCanvasGroup = arg_12_0.leftChapter:GetComponent(typeof(CanvasGroup))
	arg_12_0.btnPrev = arg_12_0.leftChapter:Find("btn_prev")
	arg_12_0.btnPrevCol = arg_12_0.leftChapter:Find("btn_prev/prev_image")
	arg_12_0.eliteBtn = arg_12_0.leftChapter:Find("buttons/btn_elite")
	arg_12_0.normalBtn = arg_12_0.leftChapter:Find("buttons/btn_normal")
	arg_12_0.actNormalBtn = arg_12_0.leftChapter:Find("buttons/btn_act_normal")
	arg_12_0.actEliteBtn = arg_12_0.leftChapter:Find("buttons/btn_act_elite")
	arg_12_0.actExtraBtn = arg_12_0.leftChapter:Find("buttons/btn_act_extra")
	arg_12_0.actExtraBtnAnim = arg_12_0.actExtraBtn:Find("usm")
	arg_12_0.remasterBtn = arg_12_0.leftChapter:Find("buttons/btn_remaster")
	arg_12_0.escortBar = arg_12_0.leftChapter:Find("escort_bar")
	arg_12_0.eliteQuota = arg_12_0.leftChapter:Find("elite_quota")
	arg_12_0.skirmishBar = arg_12_0.leftChapter:Find("left_times")
	arg_12_0.mainLayer = arg_12_0._tf:Find("main")

	setActive(arg_12_0.mainLayer:Find("title_chapter_lines"), false)

	arg_12_0.rightChapter = arg_12_0._tf:Find("main/right_chapter")
	arg_12_0.rightCanvasGroup = arg_12_0.rightChapter:GetComponent(typeof(CanvasGroup))
	arg_12_0.eventContainer = arg_12_0.rightChapter:Find("event_btns/event_container")
	arg_12_0.btnSpecial = arg_12_0.eventContainer:Find("btn_task")
	arg_12_0.challengeBtn = arg_12_0.eventContainer:Find("btn_challenge")
	arg_12_0.dailyBtn = arg_12_0.eventContainer:Find("btn_daily")
	arg_12_0.militaryExerciseBtn = arg_12_0.eventContainer:Find("btn_pvp")
	arg_12_0.activityBtn = arg_12_0.rightChapter:Find("event_btns/activity_btn")
	arg_12_0.ptTotal = arg_12_0.rightChapter:Find("event_btns/pt_text")
	arg_12_0.ticketTxt = arg_12_0.rightChapter:Find("event_btns/tickets/Text")
	arg_12_0.remasterAwardBtn = arg_12_0.rightChapter:Find("btn_remaster_award")
	arg_12_0.btnNext = arg_12_0.rightChapter:Find("btn_next")
	arg_12_0.btnNextCol = arg_12_0.rightChapter:Find("btn_next/next_image")
	arg_12_0.countDown = arg_12_0.rightChapter:Find("event_btns/count_down")

	setActive(arg_12_0.rightChapter:Find("event_btns/BottomList"), true)

	arg_12_0.actExchangeShopBtn = arg_12_0.rightChapter:Find("event_btns/BottomList/btn_exchange")
	arg_12_0.actAtelierBuffBtn = arg_12_0.rightChapter:Find("event_btns/BottomList/btn_control_center")
	arg_12_0.actAtelierYumiaBuffBtn = arg_12_0.rightChapter:Find("event_btns/BottomList/btn_yumia_buff")
	arg_12_0.actExtraRank = arg_12_0.rightChapter:Find("event_btns/BottomList/act_extra_rank")

	setActive(arg_12_0.rightChapter, true)

	arg_12_0.damageTextTemplate = go(arg_12_0.topPanel:Find("damage"))

	setActive(arg_12_0.damageTextTemplate, false)

	arg_12_0.damageTextPool = {
		arg_12_0.damageTextTemplate
	}
	arg_12_0.damageTextActive = {}
	arg_12_0.mapHelpBtn = arg_12_0.topPanel:Find("help_button")
	arg_12_0.avoidText = arg_12_0.topPanel:Find("text_avoid")
	arg_12_0.commanderTinkle = arg_12_0.topPanel:Find("neko_tinkle")

	setActive(arg_12_0.commanderTinkle, false)

	arg_12_0.spResult = arg_12_0.topPanel:Find("sp_result")

	setActive(arg_12_0.spResult, false)

	arg_12_0.helpPage = arg_12_0.topPanel:Find("help_page")
	arg_12_0.helpImage = arg_12_0.helpPage:Find("icon")

	setActive(arg_12_0.helpPage, false)

	arg_12_0.curtain = arg_12_0.topPanel:Find("curtain")

	setActive(arg_12_0.curtain, false)

	arg_12_0.map = arg_12_0._tf:Find("maps")
	arg_12_0.mapTFs = {
		arg_12_0._tf:Find("maps/map1"),
		arg_12_0._tf:Find("maps/map2")
	}

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.mapTFs) do
		iter_12_1:GetComponent(typeof(Image)).enabled = false
	end

	arg_12_0.UIFXList = arg_12_0._tf:Find("maps/UI_FX_list")

	for iter_12_2, iter_12_3 in ipairs((arg_12_0.UIFXList:GetComponentsInChildren(typeof(Renderer)):ToTable())) do
		iter_12_3.sortingOrder = -1
	end

	arg_12_0.rtRightPanel = arg_12_0._tf:Find("entrance/enters/right_panel")
	arg_12_0.actBtnTpl = arg_12_0.rtRightPanel:Find("content/tpl")

	local var_12_0 = pg.UIMgr.GetInstance()

	arg_12_0.levelCam = var_12_0.levelCamera:GetComponent(typeof(Camera))
	arg_12_0.uiMain = var_12_0.LevelMain

	setActive(arg_12_0.uiMain, false)

	arg_12_0.uiCam = var_12_0.uiCamera:GetComponent(typeof(Camera))
	arg_12_0.levelGrid = arg_12_0.uiMain:Find("LevelGrid")

	setActive(arg_12_0.levelGrid, true)

	arg_12_0.dragLayer = arg_12_0.levelGrid:Find("DragLayer")
	arg_12_0.float = arg_12_0._tf:Find("float")
	arg_12_0.clouds = arg_12_0.float:Find("clouds")

	setActive(arg_12_0.clouds, true)
	setActive(arg_12_0.float:Find("levels"), false)

	arg_12_0.resources = arg_12_0._tf:Find("resources")
	arg_12_0.arrowTarget = arg_12_0.resources:Find("Tpl_Arrow_Target")
	arg_12_0.destinationMarkTpl = arg_12_0.resources:Find("Tpl_Destination_Mark")
	arg_12_0.championTpl = arg_12_0.resources:Find("Tpl_Champion")
	arg_12_0.deadTpl = arg_12_0.resources:Find("Tpl_Dead")
	arg_12_0.enemyTpl = arg_12_0.resources:Find("Tpl_Enemy")
	arg_12_0.oniTpl = arg_12_0.resources:Find("Tpl_Oni")
	arg_12_0.shipTpl = arg_12_0.resources:Find("Tpl_Ship")
	arg_12_0.subTpl = arg_12_0.resources:Find("Tpl_Sub")
	arg_12_0.transportTpl = arg_12_0.resources:Find("Tpl_Transport")

	setText(tf(arg_12_0.enemyTpl):Find("fighting/Text"), i18n("ui_word_levelui2_inevent"))
	arg_12_0:HideBtns()
	setAnchoredPosition(arg_12_0.topChapter, {
		y = 0
	})
	setAnchoredPosition(arg_12_0.leftChapter, {
		x = 0
	})
	setAnchoredPosition(arg_12_0.rightChapter, {
		x = 0
	})

	arg_12_0.bubbleMsgBoxes = {}
	arg_12_0.loader = AutoLoader.New()
	arg_12_0.levelFleetView = LevelFleetView.New(arg_12_0.topPanel, arg_12_0.event, arg_12_0.contextData)
	arg_12_0.levelInfoView = LevelInfoView.New(arg_12_0.topPanel, arg_12_0.event, arg_12_0.contextData)

	arg_12_0.levelInfoView:RegisterView(arg_12_0)
	arg_12_0.levelFleetView:RegisterView(arg_12_0)
	arg_12_0:buildCommanderPanel()

	arg_12_0.levelRemasterView = LevelRemasterView.New(arg_12_0.topPanel, arg_12_0.event, arg_12_0.contextData)

	arg_12_0:SwitchMapBuilder(MapBuilder.TYPENORMAL)

	return
end

function var_0_0.initEvents(arg_13_0)
	arg_13_0:bind(LevelUIConst.OPEN_COMMANDER_PANEL, function(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
		arg_13_0:openCommanderPanel(arg_14_1, arg_14_2, arg_14_3)

		return
	end)
	arg_13_0:bind(LevelUIConst.HANDLE_SHOW_MSG_BOX, function(arg_15_0, arg_15_1)
		arg_13_0:HandleShowMsgBox(arg_15_1)

		return
	end)
	arg_13_0:bind(LevelUIConst.DO_AMBUSH_WARNING, function(arg_16_0, arg_16_1)
		arg_13_0:doAmbushWarning(arg_16_1)

		return
	end)
	arg_13_0:bind(LevelUIConst.DISPLAY_AMBUSH_INFO, function(arg_17_0, arg_17_1)
		arg_13_0:displayAmbushInfo(arg_17_1)

		return
	end)
	arg_13_0:bind(LevelUIConst.DISPLAY_STRATEGY_INFO, function(arg_18_0, arg_18_1)
		arg_13_0:displayStrategyInfo(arg_18_1)

		return
	end)
	arg_13_0:bind(LevelUIConst.FROZEN, function(arg_19_0)
		arg_13_0:frozen()

		return
	end)
	arg_13_0:bind(LevelUIConst.UN_FROZEN, function(arg_20_0)
		arg_13_0:unfrozen()

		return
	end)
	arg_13_0:bind(LevelUIConst.DO_TRACKING, function(arg_21_0, arg_21_1)
		arg_13_0:doTracking(arg_21_1)

		return
	end)
	arg_13_0:bind(LevelUIConst.SWITCH_TO_MAP, function()
		if arg_13_0:isfrozen() then
			return
		end

		arg_13_0:switchToMap()

		return
	end)
	arg_13_0:bind(LevelUIConst.DISPLAY_REPAIR_WINDOW, function(arg_23_0, arg_23_1)
		arg_13_0:displayRepairWindow(arg_23_1)

		return
	end)
	arg_13_0:bind(LevelUIConst.DO_PLAY_ANIM, function(arg_24_0, arg_24_1)
		arg_13_0:doPlayAnim(arg_24_1.name, arg_24_1.callback, arg_24_1.onStart)

		return
	end)
	arg_13_0:bind(LevelUIConst.HIDE_FLEET_SELECT, function()
		arg_13_0:hideFleetSelect()

		return
	end)
	arg_13_0:bind(LevelUIConst.HIDE_FLEET_EDIT, function(arg_26_0)
		arg_13_0:hideFleetEdit()

		return
	end)
	arg_13_0:bind(LevelUIConst.ADD_MSG_QUEUE, function(arg_27_0, arg_27_1)
		arg_13_0:addbubbleMsgBox(arg_27_1)

		return
	end)
	arg_13_0:bind(LevelUIConst.SET_MAP, function(arg_28_0, arg_28_1)
		arg_13_0:setMap(arg_28_1)

		return
	end)

	return
end

function var_0_0.addbubbleMsgBox(arg_29_0, arg_29_1)
	table.insert(arg_29_0.bubbleMsgBoxes, arg_29_1)

	if #arg_29_0.bubbleMsgBoxes > 1 then
		return
	end

	;(function()
		if arg_29_0.bubbleMsgBoxes[1] then
			arg_29_0.bubbleMsgBoxes[1](function()
				table.remove(arg_29_0.bubbleMsgBoxes, 1)
				var_0()

				return
			end)
		end

		return
	end)()

	return
end

function var_0_0.CleanBubbleMsgbox(arg_32_0)
	table.clean(arg_32_0.bubbleMsgBoxes)

	return
end

function var_0_0.updatePtActivity(arg_33_0, arg_33_1)
	arg_33_0.ptActivity = arg_33_1

	if not arg_33_0.ptActivity then
		return
	end

	arg_33_0:updateActivityRes()

	return
end

function var_0_0.updateActivityRes(arg_34_0)
	local var_34_0 = findTF(arg_34_0.ptTotal, "Text")
	local var_34_1 = findTF(arg_34_0.ptTotal, "icon/Image")

	if var_34_0 and var_34_1 and arg_34_0.ptActivity then
		setText(var_34_0, "x" .. arg_34_0.ptActivity.data1)
		GetImageSpriteFromAtlasAsync(Drop.New({
			type = DROP_TYPE_RESOURCE,
			id = tonumber(arg_34_0.ptActivity:getConfig("config_id"))
		}):getIcon(), "", var_34_1, true)
	end

	return
end

function var_0_0.setCommanderPrefabs(arg_35_0, arg_35_1)
	arg_35_0.commanderPrefabs = arg_35_1

	return
end

function var_0_0.didEnter(arg_36_0)
	arg_36_0.openedCommanerSystem = not LOCK_COMMANDER and pg.SystemOpenMgr.GetInstance():isOpenSystem(arg_36_0.player.level, "CommanderCatMediator")

	onButton(arg_36_0, arg_36_0.topChapter:Find("back_button"), function()
		if arg_36_0:isfrozen() then
			return
		end

		local var_37_0 = arg_36_0.contextData.map

		if arg_36_0.contextData.map and (var_37_0:isActivity() or var_37_0:isEscort()) then
			arg_36_0:emit(LevelMediator2.ON_SWITCH_NORMAL_MAP)

			return
		elseif var_37_0 and var_37_0:isSkirmish() then
			arg_36_0:emit(var_0_0.ON_BACK)
		elseif not arg_36_0.contextData.entranceStatus then
			arg_36_0:ShowEntranceUI(true)
		else
			arg_36_0:emit(var_0_0.ON_BACK)
		end

		return
	end, SFX_CANCEL)
	onButton(arg_36_0, arg_36_0.btnSpecial, function()
		if arg_36_0:isfrozen() then
			return
		end

		arg_36_0:emit(LevelMediator2.ON_OPEN_EVENT_SCENE)

		return
	end, SFX_PANEL)
	onButton(arg_36_0, arg_36_0.dailyBtn, function()
		if arg_36_0:isfrozen() then
			return
		end

		DailyLevelProxy.dailyLevelId = nil

		arg_36_0:updatDailyBtnTip()
		arg_36_0:emit(LevelMediator2.ON_DAILY_LEVEL)

		return
	end, SFX_PANEL)
	onButton(arg_36_0, arg_36_0.challengeBtn, function()
		if arg_36_0:isfrozen() then
			return
		end

		local var_40_0, var_40_1 = arg_36_0:checkChallengeOpen()

		if var_40_0 == false then
			pg.TipsMgr.GetInstance():ShowTips(var_40_1)
		else
			arg_36_0:emit(LevelMediator2.CLICK_CHALLENGE_BTN)
		end

		return
	end, SFX_PANEL)
	onButton(arg_36_0, arg_36_0.militaryExerciseBtn, function()
		if arg_36_0:isfrozen() then
			return
		end

		arg_36_0:emit(LevelMediator2.ON_OPEN_MILITARYEXERCISE)

		return
	end, SFX_PANEL)
	onButton(arg_36_0, arg_36_0.normalBtn, function()
		if arg_36_0:isfrozen() then
			return
		end

		arg_36_0:setMap(arg_36_0.contextData.map:getBindMapId())

		return
	end, SFX_PANEL)
	onButton(arg_36_0, arg_36_0.eliteBtn, function()
		if arg_36_0:isfrozen() then
			return
		end

		if arg_36_0.contextData.map:getBindMapId() == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("elite_disable_unusable"))

			local var_43_0 = getProxy(ChapterProxy):getUseableMaxEliteMap()

			if var_43_0 then
				arg_36_0:setMap(var_43_0.configId)
				pg.TipsMgr.GetInstance():ShowTips(i18n("elite_warp_to_latest_map"))
			end
		elseif arg_36_0.contextData.map:isEliteEnabled() then
			arg_36_0:setMap(arg_36_0.contextData.map:getBindMapId())
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("elite_disable_unsatisfied"))
		end

		return
	end, SFX_UI_WEIGHANCHOR_HARD)
	onButton(arg_36_0, arg_36_0.remasterBtn, function()
		if arg_36_0:isfrozen() then
			return
		end

		arg_36_0:displayRemasterPanel()
		getProxy(ChapterProxy):setRemasterTip(false)
		arg_36_0:updateRemasterBtnTip()

		return
	end, SFX_PANEL)
	onButton(arg_36_0, arg_36_0.entranceLayer:Find("enters/enter_main"), function()
		if arg_36_0:isfrozen() then
			return
		end

		arg_36_0:ShowSelectedMap(arg_36_0:GetInitializeMap())

		return
	end, SFX_PANEL)
	setText(arg_36_0.entranceLayer:Find("enters/enter_main/Text"), getProxy(ChapterProxy):getLastUnlockMap():getLastUnlockChapterName())
	onButton(arg_36_0, arg_36_0.entranceLayer:Find("enters/enter_world/enter"), function()
		if arg_36_0:isfrozen() then
			return
		end

		arg_36_0:emit(LevelMediator2.ENTER_WORLD)

		return
	end, SFX_PANEL)
	onButton(arg_36_0, arg_36_0.entranceLayer:Find("enters/enter_ready/activity"), function()
		if arg_36_0:isfrozen() then
			return
		end

		switch(arg_36_0.entranceActivity:getConfig("type"), {
			[ActivityConst.ACTIVITY_TYPE_ZPROJECT] = function()
				arg_36_0:emit(LevelMediator2.ON_ACTIVITY_MAP, arg_36_0.entranceActivity.id)

				return
			end,
			[ActivityConst.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2] = function()
				arg_36_0:emit(LevelMediator2.ON_OPEN_ACT_BOSS_BATTLE)

				return
			end,
			[ActivityConst.ACTIVITY_TYPE_BOSSRUSH] = function()
				arg_36_0:emit(LevelMediator2.ON_BOSSRUSH_MAP)

				return
			end,
			[ActivityConst.ACTIVITY_TYPE_BOSSSINGLE] = function()
				arg_36_0:emit(LevelMediator2.ON_BOSSSINGLE_MAP, {
					mode = OtherworldMapScene.MODE_BATTLE
				})

				return
			end,
			[ActivityConst.ACTIVITY_TYPE_BOSSSINGLE_VARIABLE] = function()
				arg_36_0:emit(LevelMediator2.ON_CLUE_MAP)

				return
			end,
			[ActivityConst.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB] = function()
				arg_36_0:emit(LevelMediator2.ON_COLLAB_BOSSRUSH_MAP)

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(arg_36_0, arg_36_0.entranceLayer:Find("btns/btn_remaster"), function()
		if arg_36_0:isfrozen() then
			return
		end

		arg_36_0:displayRemasterPanel()
		getProxy(ChapterProxy):setRemasterTip(false)
		arg_36_0:updateRemasterBtnTip()

		return
	end, SFX_PANEL)
	setActive(arg_36_0.entranceLayer:Find("btns/btn_remaster"), OPEN_REMASTER)
	onButton(arg_36_0, arg_36_0.entranceLayer:Find("btns/btn_challenge"), function()
		if arg_36_0:isfrozen() then
			return
		end

		local var_55_0, var_55_1 = arg_36_0:checkChallengeOpen()

		if var_55_0 == false then
			pg.TipsMgr.GetInstance():ShowTips(var_55_1)
		else
			arg_36_0:emit(LevelMediator2.CLICK_CHALLENGE_BTN)
		end

		return
	end, SFX_PANEL)
	onButton(arg_36_0, arg_36_0.entranceLayer:Find("btns/btn_pvp"), function()
		if arg_36_0:isfrozen() then
			return
		end

		arg_36_0:emit(LevelMediator2.ON_OPEN_MILITARYEXERCISE)

		return
	end, SFX_PANEL)
	onButton(arg_36_0, arg_36_0.entranceLayer:Find("btns/btn_daily"), function()
		if arg_36_0:isfrozen() then
			return
		end

		DailyLevelProxy.dailyLevelId = nil

		arg_36_0:updatDailyBtnTip()
		arg_36_0:emit(LevelMediator2.ON_DAILY_LEVEL)

		return
	end, SFX_PANEL)
	onButton(arg_36_0, arg_36_0.entranceLayer:Find("btns/btn_task"), function()
		if arg_36_0:isfrozen() then
			return
		end

		arg_36_0:emit(LevelMediator2.ON_OPEN_EVENT_SCENE)

		return
	end, SFX_PANEL)
	setActive(arg_36_0.entranceLayer:Find("enters/enter_world/enter"), not WORLD_ENTER_LOCK)
	setActive(arg_36_0.entranceLayer:Find("enters/enter_world/nothing"), WORLD_ENTER_LOCK)

	arg_36_0.entranceActivity = getProxy(ActivityProxy):getEnterReadyActivity()[1]

	setActive(arg_36_0.entranceLayer:Find("enters/enter_ready/nothing"), not tobool(arg_36_0.entranceActivity))
	setActive(arg_36_0.entranceLayer:Find("enters/enter_ready/activity"), tobool(arg_36_0.entranceActivity))

	if tobool(arg_36_0.entranceActivity) then
		local var_36_0 = arg_36_0.entranceActivity:getConfig("config_client").entrance_bg

		if var_36_0 then
			GetImageSpriteFromAtlasAsync(var_36_0, "", arg_36_0.entranceLayer:Find("enters/enter_ready/activity"), true)
		end
	end

	arg_36_0:updateRightPanel()

	local var_36_1 = pg.SystemOpenMgr.GetInstance():isOpenSystem(arg_36_0.player.level, "EventMediator")

	setActive(arg_36_0.btnSpecial:Find("lock"), not var_36_1)
	setActive(arg_36_0.entranceLayer:Find("btns/btn_task/lock"), not var_36_1)

	local var_36_2 = pg.SystemOpenMgr.GetInstance():isOpenSystem(arg_36_0.player.level, "DailyLevelMediator")

	setActive(arg_36_0.dailyBtn:Find("lock"), not var_36_2)
	setActive(arg_36_0.entranceLayer:Find("btns/btn_daily/lock"), not var_36_2)

	local var_36_3 = pg.SystemOpenMgr.GetInstance():isOpenSystem(arg_36_0.player.level, "MilitaryExerciseMediator")

	setActive(arg_36_0.militaryExerciseBtn:Find("lock"), not var_36_3)
	setActive(arg_36_0.entranceLayer:Find("btns/btn_pvp/lock"), not var_36_3)
	setActive(arg_36_0.entranceLayer:Find("enters/enter_world/enter/lock"), not pg.SystemOpenMgr.GetInstance():isOpenSystem(arg_36_0.player.level, "WorldMediator"))

	local var_36_4 = LimitChallengeConst.IsOpen()

	setActive(arg_36_0.challengeBtn:Find("lock"), not var_36_4)
	setActive(arg_36_0.entranceLayer:Find("btns/btn_challenge/lock"), not var_36_4)

	local var_36_5 = LimitChallengeConst.IsInAct()

	setActive(arg_36_0.challengeBtn, var_36_5)
	setActive(arg_36_0.entranceLayer:Find("btns/btn_challenge"), var_36_5)
	setActive(arg_36_0.entranceLayer:Find("btns/btn_challenge/tip"), (LimitChallengeConst.IsShowRedPoint()))
	arg_36_0:initMapBtn(arg_36_0.btnPrev, -1)
	arg_36_0:initMapBtn(arg_36_0.btnNext, 1)
	arg_36_0:registerActBtn()

	if arg_36_0.contextData.editEliteChapter then
		arg_36_0:displayFleetEdit((getProxy(ChapterProxy):getChapterById(arg_36_0.contextData.editEliteChapter)))

		arg_36_0.contextData.editEliteChapter = nil
	elseif arg_36_0.contextData.selectedChapterVO then
		arg_36_0:displayFleetSelect(arg_36_0.contextData.selectedChapterVO)

		arg_36_0.contextData.selectedChapterVO = nil
	end

	local var_36_6 = arg_36_0.contextData.chapterVO

	if not arg_36_0.contextData.chapterVO or not var_36_6.active then
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
		arg_36_0:emit(LevelMediator2.ON_ENTER_MAINLEVEL, arg_36_0:GetInitializeMap())
	end

	arg_36_0:emit(LevelMediator2.ON_DIDENTER)

	return
end

function var_0_0.updateRightPanel(arg_59_0)
	arg_59_0.rightActivityBtns = defaultValue(arg_59_0.rightActivityBtns, {
		LevelSecondMapBtn.New(arg_59_0.actBtnTpl, arg_59_0.event, false)
	})

	for iter_59_0, iter_59_1 in ipairs(arg_59_0.rightActivityBtns) do
		if iter_59_1:InShowTime() then
			table.insert({}, iter_59_1)
		else
			table.insert({}, iter_59_1)
		end
	end

	table.sort({}, CompareFuncs({
		function(arg_60_0)
			return arg_60_0.config.group_id
		end
	}))

	for iter_59_2, iter_59_3 in ipairs({}) do
		iter_59_3:Init(iter_59_2)
	end

	for iter_59_4, iter_59_5 in ipairs({}) do
		iter_59_5:Clear()
	end

	return
end

function var_0_0.checkChallengeOpen(arg_61_0)
	local var_61_9000
	local var_61_0 = getProxy(PlayerProxy)

	return pg.SystemOpenMgr.GetInstance().isOpenSystem(var_61_0, var_61_0.getRawData(var_61_9000).level, "ChallengeMainMediator")
end

function var_0_0.tryPlaySubGuide(arg_62_0)
	local var_62_0 = arg_62_0.contextData.map and arg_62_0.contextData.map:isSkirmish()

	if var_62_0 then
		return
	end

	pg.SystemGuideMgr.GetInstance():Play(arg_62_0)

	return
end

function var_0_0.onBackPressed(arg_63_0)
	if arg_63_0:isfrozen() then
		return
	end

	if arg_63_0.levelAmbushView then
		return
	end

	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)

	if arg_63_0.levelInfoView:isShowing() then
		arg_63_0:hideChapterPanel()

		return
	end

	if arg_63_0.levelInfoSPView and arg_63_0.levelInfoSPView:isShowing() then
		arg_63_0:HideLevelInfoSPPanel()

		return
	end

	if arg_63_0.levelFleetView:isShowing() then
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

	if arg_63_0.levelRemasterView:isShowing() then
		arg_63_0:hideRemasterPanel()

		return
	end

	if arg_63_0.contextData.map and arg_63_0.contextData.map:getConfig("ui_type") == MapBuilder.TYPEEXSP and arg_63_0.mapBuilder.personalPage:IsActive() then
		arg_63_0.mapBuilder.personalPage:Hide()

		return
	end

	if isActive(arg_63_0.helpPage) then
		setActive(arg_63_0.helpPage, false)

		return
	end

	if arg_63_0.contextData.chapterVO and getProxy(ChapterProxy):getActiveChapter() then
		arg_63_0:switchToMap()

		return
	end

	triggerButton(arg_63_0.topChapter:Find("back_button"))

	return
end

function var_0_0.ShowEntranceUI(arg_64_0, arg_64_1)
	setActive(arg_64_0.entranceLayer, arg_64_1)
	setActive(arg_64_0.entranceBg, arg_64_1)
	setActive(arg_64_0.map, not arg_64_1)
	setActive(arg_64_0.float, not arg_64_1)
	setActive(arg_64_0.mainLayer, not arg_64_1)
	setActive(arg_64_0.topChapter:Find("type_entrance"), arg_64_1)

	arg_64_0.contextData.entranceStatus = tobool(arg_64_1)

	if arg_64_1 then
		setActive(arg_64_0.topChapter:Find("title_chapter"), false)
		setActive(arg_64_0.topChapter:Find("type_chapter"), false)
		setActive(arg_64_0.topChapter:Find("type_escort"), false)
		setActive(arg_64_0.topChapter:Find("type_skirmish"), false)

		if arg_64_0.newChapterCDTimer then
			arg_64_0.newChapterCDTimer:Stop()

			arg_64_0.newChapterCDTimer = nil
		end

		arg_64_0:RecordLastMapOnExit()

		arg_64_0.contextData.mapIdx = nil
		arg_64_0.contextData.map = nil
	end

	arg_64_0:PlayBGM()

	return
end

function var_0_0.PreloadLevelMainUI(arg_65_0, arg_65_1, arg_65_2)
	if arg_65_0.preloadLevelDone then
		existCall(arg_65_2)

		return
	end

	table.ParallelIpairsAsync(arg_65_0:GetMapBG((getProxy(ChapterProxy):getMapById(arg_65_1))), function(arg_67_0, arg_67_1, arg_67_2)
		GetSpriteFromAtlasAsync("levelmap/" .. arg_67_1.BG, "", arg_67_2)

		return
	end, function()
		if not arg_65_0.exited then
			arg_65_0.preloadLevelDone = true

			existCall(arg_65_2)
		end

		return
	end)

	return
end

function var_0_0.setShips(arg_68_0, arg_68_1)
	arg_68_0.shipVOs = arg_68_1

	return
end

function var_0_0.updateRes(arg_69_0, arg_69_1)
	if arg_69_0.levelStageView then
		arg_69_0.levelStageView:ActionInvoke("SetPlayer", arg_69_1)
	end

	arg_69_0.player = arg_69_1

	return
end

function var_0_0.setEliteQuota(arg_70_0, arg_70_1, arg_70_2)
	local var_70_0 = arg_70_0.eliteQuota:Find("bg/Text"):GetComponent(typeof(Text))

	var_70_0.color = arg_70_1 == arg_70_2 and Color.red or Color.New(0.47, 0.89, 0.27)
	var_70_0.text = arg_70_2 - arg_70_1 .. "/" .. arg_70_2

	return
end

function var_0_0.updateEvent(arg_71_0, arg_71_1)
	local var_71_0 = arg_71_1:hasFinishState()

	setActive(arg_71_0.btnSpecial:Find("tip"), var_71_0)
	setActive(arg_71_0.entranceLayer:Find("btns/btn_task/tip"), var_71_0)

	return
end

function var_0_0.updateFleet(arg_72_0, arg_72_1)
	arg_72_0.fleets = arg_72_1

	return
end

function var_0_0.updateChapterVO(arg_73_0, arg_73_1, arg_73_2)
	if arg_73_0.contextData.chapterVO and arg_73_0.contextData.chapterVO.id == arg_73_1.id and arg_73_1.active then
		arg_73_0:setChapter(arg_73_1)
	end

	if arg_73_0.contextData.chapterVO and arg_73_0.contextData.chapterVO.id == arg_73_1.id and arg_73_1.active and arg_73_0.levelStageView and arg_73_0.grid then
		local var_73_0 = false
		local var_73_1 = false
		local var_73_2 = false

		if arg_73_2 < 0 or bit.band(arg_73_2, ChapterConst.DirtyFleet) > 0 then
			arg_73_0.levelStageView:updateStageFleet()
			arg_73_0.levelStageView:updateAmbushRate(arg_73_1.fleet.line, true)

			var_73_2 = true

			if arg_73_0.grid then
				arg_73_0.grid:RefreshFleetCells()
				arg_73_0.grid:UpdateFloor()
				arg_73_0.grid:UpdateWeatherCells()

				var_73_0 = true
			end
		end

		if arg_73_2 < 0 or bit.band(arg_73_2, ChapterConst.DirtyChampion) > 0 then
			var_73_2 = true

			if arg_73_0.grid then
				arg_73_0.grid:UpdateFleets()
				arg_73_0.grid:clearChampions()
				arg_73_0.grid:initChampions()

				var_73_1 = true
			end
		elseif bit.band(arg_73_2, ChapterConst.DirtyChampionPosition) > 0 then
			var_73_2 = true

			if arg_73_0.grid then
				arg_73_0.grid:UpdateFleets()
				arg_73_0.grid:updateChampions()

				var_73_1 = true
			end
		end

		if arg_73_2 < 0 or bit.band(arg_73_2, ChapterConst.DirtyAchieve) > 0 then
			arg_73_0.levelStageView:updateStageAchieve()
		end

		if arg_73_2 < 0 or bit.band(arg_73_2, ChapterConst.DirtyAttachment) > 0 then
			arg_73_0.levelStageView:updateAmbushRate(arg_73_1.fleet.line, true)

			if arg_73_0.grid then
				if arg_73_2 >= 0 and bit.band(arg_73_2, ChapterConst.DirtyFleet) <= 0 then
					arg_73_0.grid:updateFleet(arg_73_1.fleets[arg_73_1.findex].id)
				end

				arg_73_0.grid:updateAttachments()

				if arg_73_2 < 0 or bit.band(arg_73_2, ChapterConst.DirtyAutoAction) > 0 then
					arg_73_0.grid:updateQuadCells(ChapterConst.QuadStateNormal)
				else
					var_73_0 = true
				end
			end
		end

		if arg_73_2 < 0 or bit.band(arg_73_2, ChapterConst.DirtyStrategy) > 0 then
			arg_73_0.levelStageView:updateStageStrategy()

			var_73_2 = true

			arg_73_0.levelStageView:updateStageBarrier()
			arg_73_0.levelStageView:UpdateAutoFightPanel()
		end

		if arg_73_2 < 0 or bit.band(arg_73_2, ChapterConst.DirtyAutoAction) > 0 then
			-- block empty
		elseif var_73_0 then
			arg_73_0.grid:updateQuadCells(ChapterConst.QuadStateNormal)
		elseif var_73_1 then
			arg_73_0.grid:updateQuadCells(ChapterConst.QuadStateFrozen)
		end

		if arg_73_2 < 0 or bit.band(arg_73_2, ChapterConst.DirtyCellFlag) > 0 then
			arg_73_0.grid:UpdateFloor()
		end

		if arg_73_2 < 0 or bit.band(arg_73_2, ChapterConst.DirtyBase) > 0 then
			arg_73_0.levelStageView:UpdateDefenseStatus()
		end

		if arg_73_2 < 0 or bit.band(arg_73_2, ChapterConst.DirtyFloatItems) > 0 then
			arg_73_0.grid:UpdateItemCells()
		end

		if arg_73_2 < 0 or bit.band(arg_73_2, ChapterConst.DirtyWeather) > 0 then
			arg_73_0.grid:UpdateWeatherCells()
		end

		if var_73_2 then
			arg_73_0.levelStageView:updateFleetBuff()
		end
	end

	return
end

function var_0_0.updateClouds(arg_74_0)
	arg_74_0.cloudRTFs = {}
	arg_74_0.cloudRects = {}
	arg_74_0.cloudTimer = {}

	for iter_74_0 = 1, 6 do
		local var_74_0 = rtf((arg_74_0.clouds:Find("cloud_" .. iter_74_0)))

		table.insert(arg_74_0.cloudRTFs, var_74_0)
		table.insert(arg_74_0.cloudRects, var_74_0.rect.width)
	end

	arg_74_0:initCloudsPos()

	for iter_74_1, iter_74_2 in ipairs(arg_74_0.cloudRTFs) do
		local var_74_1 = arg_74_0.cloudRects[iter_74_1]
		local var_74_2 = arg_74_0.initPositions[iter_74_1]
		local var_74_3

		if not arg_74_0.initPositions[iter_74_1] then
			var_74_2 = Vector2(0, 0)
			var_74_3 = nil
			var_74_3 = LeanTween.moveX(iter_74_2, arg_74_0.mapWidth, (arg_74_0.mapWidth + arg_74_0.cloudRects[iter_74_1]) / (30 - var_74_2.y / 20)):setRepeat(-1):setOnCompleteOnRepeat(true):setOnComplete(System.Action(function()
				var_74_1 = arg_74_0.cloudRects[iter_74_1]
				iter_74_2.anchoredPosition = Vector2(-var_74_1, var_74_2.y)

				var_74_3:setFrom(-var_74_1):setTime((arg_74_0.mapWidth + var_74_1) / var_0)

				return
			end))
		end

		var_74_3.passed = math.random() * ((arg_74_0.mapWidth + arg_74_0.cloudRects[iter_74_1]) / (30 - var_74_2.y / 20))
		arg_74_0.cloudTimer[iter_74_1] = var_74_3.uniqueId
	end

	return
end

function var_0_0.RefreshMapBG(arg_76_0)
	arg_76_0:PlayBGM()
	arg_76_0:SwitchMapBG(arg_76_0.contextData.map, nil, true)

	return
end

function var_0_0.updateCouldAnimator(arg_77_0, arg_77_1, arg_77_2)
	if not arg_77_1 then
		return
	end

	local var_77_0 = arg_77_0.contextData.map:getConfig("ani_controller")

	local function var_77_1(arg_78_0)
		arg_78_0 = tf(arg_78_0)

		if arg_78_0.rect.width > 0 and arg_78_0.rect.height > 0 then
			Vector3.one.x = arg_78_0.parent.rect.width / arg_78_0.rect.width
			Vector3.one.y = arg_78_0.parent.rect.height / arg_78_0.rect.height
		end

		arg_78_0.localScale = Vector3.one

		if var_77_0 and #var_77_0 > 0 then
			local var_78_0 = getProxy(ChapterProxy)

			;(function()
				for iter_79_0, iter_79_1 in ipairs(var_77_0) do
					local var_79_0 = false

					for iter_79_2, iter_79_3 in ipairs(iter_79_1[2][1]) do
						local var_79_1 = var_78_0:GetChapterItemById(iter_79_3)

						if var_79_1 and var_79_1:isClear() then
							var_79_0 = true

							break
						end
					end

					if iter_79_1[1] == var_0_2 then
						for iter_79_4, iter_79_5 in ipairs((_.rest(iter_79_1[2], 2))) do
							local var_79_2 = arg_78_0:Find(iter_79_5)

							if not IsNil(var_79_2) and not var_79_0 then
								setActive(var_79_2, false)
							end
						end
					elseif iter_79_1[1] == var_0_3 then
						for iter_79_6, iter_79_7 in ipairs((_.rest(iter_79_1[2], 2))) do
							local var_79_3 = arg_78_0:Find(iter_79_7)

							if not IsNil(var_79_3) and not var_79_0 then
								setActive(var_79_3, true)

								return
							end
						end
					elseif iter_79_1[1] == var_0_4 then
						for iter_79_8, iter_79_9 in ipairs((_.rest(iter_79_1[2], 2))) do
							local var_79_4 = arg_78_0:Find(iter_79_9)

							if not IsNil(var_79_4) and not var_79_0 then
								setActive(var_79_4, true)
							end
						end
					end
				end

				return
			end)()
		end

		return
	end

	table.insert(arg_77_0.mapGroup, (arg_77_0.loader:GetPrefab("ui/" .. arg_77_1, arg_77_1, function(arg_80_0)
		arg_80_0:SetActive(true)
		setParent(arg_80_0, arg_77_0.mapTFs[arg_77_2])
		pg.ViewUtils.SetSortingOrder(arg_80_0, ChapterConst.LayerWeightMap + arg_77_2 * 2 - 1)
		var_77_1(arg_80_0)

		return
	end)))

	return
end

function var_0_0.HideBtns(arg_81_0)
	setActive(arg_81_0.btnPrev, false)
	setActive(arg_81_0.eliteQuota, false)
	setActive(arg_81_0.escortBar, false)
	setActive(arg_81_0.skirmishBar, false)
	setActive(arg_81_0.normalBtn, false)
	setActive(arg_81_0.actNormalBtn, false)
	setActive(arg_81_0.eliteBtn, false)
	setActive(arg_81_0.actEliteBtn, false)
	setActive(arg_81_0.actExtraBtn, false)
	setActive(arg_81_0.remasterBtn, false)
	setActive(arg_81_0.btnNext, false)
	setActive(arg_81_0.remasterAwardBtn, false)
	setActive(arg_81_0.eventContainer, false)
	setActive(arg_81_0.activityBtn, false)
	setActive(arg_81_0.ptTotal, false)
	setActive(arg_81_0.ticketTxt.parent, false)
	setActive(arg_81_0.countDown, false)
	setActive(arg_81_0.actAtelierBuffBtn, false)
	setActive(arg_81_0.actAtelierYumiaBuffBtn, false)
	setActive(arg_81_0.actExtraRank, false)
	setActive(arg_81_0.actExchangeShopBtn, false)
	setActive(arg_81_0.mapHelpBtn, false)

	return
end

function var_0_0.updateDifficultyBtns(arg_82_0)
	local var_82_0 = arg_82_0.contextData.map:getConfig("type")

	setActive(arg_82_0.normalBtn, var_82_0 == Map.ELITE)
	setActive(arg_82_0.eliteQuota, var_82_0 == Map.ELITE)
	setActive(arg_82_0.eliteBtn, var_82_0 == Map.SCENARIO)

	local var_82_1 = getProxy(ActivityProxy):getActivityById(ActivityConst.ELITE_AWARD_ACTIVITY_ID)

	setActive(arg_82_0.eliteBtn:Find("pic_activity"), var_82_1 and not var_82_1:isEnd())

	return
end

function var_0_0.updateActivityBtns(arg_83_0)
	local var_83_0 = arg_83_0.contextData.map
	local var_83_1, var_83_2 = arg_83_0.contextData.map:isActivity()
	local var_83_3 = var_83_0:isRemaster()
	local var_83_4 = var_83_0:isSkirmish()
	local var_83_5 = var_83_0:isEscort()
	local var_83_6 = var_83_0:getConfig("type")
	local var_83_7 = setmetatable({}, MainActMapBtn)
	local var_83_8 = var_83_7:InShowTime() and not var_83_1 and not var_83_4 and not var_83_5

	arg_83_0.activityBtnLinkAct = var_83_7:GetActivity()

	if var_83_8 then
		var_83_7.image = arg_83_0.activityBtn:Find("Image"):GetComponent(typeof(Image))
		var_83_7.subImage = arg_83_0.activityBtn:Find("sub_Image"):GetComponent(typeof(Image))
		var_83_7.tipTr = arg_83_0.activityBtn:Find("Tip"):GetComponent(typeof(Image))
		var_83_7.tipTxt = arg_83_0.activityBtn:Find("Tip/Text"):GetComponent(typeof(Text))
		var_83_8 = var_83_7:InShowTime()

		if var_83_8 then
			var_83_7:InitTipImage()
			var_83_7:InitSubImage()
			var_83_7:InitImage(function()
				return
			end)
			var_83_7:OnInit()
		end
	end

	setActive(arg_83_0.activityBtn, var_83_8)
	arg_83_0:updateRemasterInfo()

	if var_83_1 and var_83_2 then
		local var_83_9 = var_83_0:isRemaster() and getProxy(ChapterProxy):getRemasterMaps(var_83_0.remasterId) or getProxy(ChapterProxy):getMapsByActivities(var_83_0:getConfig("on_activity"))

		setActive(arg_83_0.actExtraBtn, underscore.any(var_83_9, function(arg_85_0)
			return arg_85_0:isActExtra()
		end) and var_83_6 ~= Map.ACT_EXTRA)

		if isActive(arg_83_0.actExtraBtn) then
			if underscore.all(underscore.filter(var_83_9, function(arg_86_0)
				local var_86_0 = arg_86_0:getMapType()

				return var_86_0 == Map.ACTIVITY_EASY or var_86_0 == Map.ACTIVITY_HARD
			end), function(arg_87_0)
				return arg_87_0:isAllChaptersClear()
			end) then
				setActive(arg_83_0.actExtraBtnAnim, true)
			else
				setActive(arg_83_0.actExtraBtnAnim, false)
			end

			local var_83_11 = getProxy(ChapterProxy):IsActivitySPChapterActive(var_83_0:getConfig("on_activity"))

			var_83_11 = var_83_11 and SettingsProxy.IsShowActivityMapSPTip()

			var_83_10(arg_83_0.actExtraBtn:Find("Tip"), var_83_11)
		end

		setActive(arg_83_0.actEliteBtn, checkExist(var_83_0:getBindMap(), {
			"isHardMap"
		}) and var_83_6 ~= Map.ACTIVITY_HARD)
		setActive(arg_83_0.actNormalBtn, var_83_6 ~= Map.ACTIVITY_EASY)

		local var_83_13 = arg_83_0.actExtraRank
		local var_83_14 = var_83_6 == Map.ACT_EXTRA and _.any(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_EXTRA_CHAPTER_RANK), function(arg_88_0)
			if not arg_88_0 or arg_88_0:isEnd() then
				return
			end

			local var_88_0 = arg_88_0:getConfig("config_data")[1]

			return _.any(var_83_0:getChapters(), function(arg_89_0)
				if not arg_89_0:IsEXChapter() then
					return false
				end

				return table.contains(arg_89_0:getConfig("boss_expedition_id"), var_88_0)
			end)
		end) or false

		if false then
			var_83_14 = true
		end

		var_83_12(var_83_13, var_83_14)
		setActive(arg_83_0.actExchangeShopBtn, not ActivityConst.HIDE_PT_PANELS and not var_83_3 and var_83_2 and arg_83_0:IsActShopActive())

		if arg_83_0.contextData.map then
			local var_83_15 = getProxy(ActivityProxy):getActivityById(arg_83_0.contextData.map:getConfig("on_activity")) or nil
			local var_83_16 = var_83_15 and not var_83_15:isEnd() and var_83_15:GetConfigClientSetting("PTID")

			arg_83_0:updatePtActivity(underscore.detect(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_PT_RANK), function(arg_90_0)
				return arg_90_0:getConfig("config_id") == var_83_16
			end))

			local var_83_18 = arg_83_0.ptTotal

			if not ActivityConst.HIDE_PT_PANELS and not var_83_3 then
				local var_83_19

				if var_83_2 then
					::label_83_0::

					var_83_19 = arg_83_0.ptActivity and not arg_83_0.ptActivity:isEnd()

					if false then
						var_83_19 = false
					end

					if false then
						var_83_19 = true
					end
				end

				var_83_17(var_83_18, var_83_19)

				goto label_83_1

				setActive(arg_83_0.actExtraBtn, false)
				setActive(arg_83_0.actEliteBtn, false)
				setActive(arg_83_0.actNormalBtn, false)
				setActive(arg_83_0.actExtraRank, false)
				setActive(arg_83_0.actExchangeShopBtn, false)
				setActive(arg_83_0.actAtelierBuffBtn, false)
				setActive(arg_83_0.actAtelierYumiaBuffBtn, false)
				setActive(arg_83_0.ptTotal, false)

				::label_83_1::

				setActive(arg_83_0.eventContainer, (not var_83_1 or not var_83_2) and not var_83_5)

				local var_83_20 = OPEN_REMASTER and (var_83_3 or not var_83_1 and not var_83_5 and not var_83_4)

				setActive(arg_83_0.remasterBtn, var_83_20)
				setActive(arg_83_0.ticketTxt.parent, var_83_3)
				arg_83_0:updateRemasterTicket()
				arg_83_0:updateCountDown()

				return
			end
		end
	end
end

function var_0_0.updateRemasterTicket(arg_91_0)
	setText(arg_91_0.ticketTxt, getProxy(ChapterProxy).remasterTickets .. " / " .. pg.gameset.reactivity_ticket_max.key_value)
	arg_91_0:emit(LevelUIConst.FLUSH_REMASTER_TICKET)

	return
end

function var_0_0.updateRemasterBtnTip(arg_92_0)
	local var_92_0 = getProxy(ChapterProxy)
	local var_92_1 = var_92_0:ifShowRemasterTip() or var_92_0:anyRemasterAwardCanReceive()

	SetActive(arg_92_0.remasterBtn:Find("tip"), var_92_1)
	SetActive(arg_92_0.entranceLayer:Find("btns/btn_remaster/tip"), var_92_1)

	return
end

function var_0_0.updatDailyBtnTip(arg_93_0)
	local var_93_0 = getProxy(DailyLevelProxy):ifShowDailyTip()

	SetActive(arg_93_0.dailyBtn:Find("tip"), var_93_0)
	SetActive(arg_93_0.entranceLayer:Find("btns/btn_daily/tip"), var_93_0)

	return
end

function var_0_0.updateRemasterInfo(arg_94_0)
	arg_94_0:emit(LevelUIConst.FLUSH_REMASTER_INFO)

	if not arg_94_0.contextData.map then
		return
	end

	local var_94_0 = getProxy(ChapterProxy)
	local var_94_1 = BossRushChapterRemasterHelper.ChapterAwardInfo((arg_94_0.contextData.map:getRemaster()))

	setActive(arg_94_0.remasterAwardBtn, var_94_1)

	if var_94_1 then
		local var_94_2 = var_94_1[1]
		local var_94_3, var_94_4, var_94_5, var_94_6, var_94_7 = unpack(var_94_1[2])
		local var_94_8 = var_94_0:getRemasterInfo(var_94_1[3], var_94_3, var_94_1[1])

		setText(arg_94_0.remasterAwardBtn:Find("Text"), var_94_8.count .. "/" .. var_94_6)
		updateDrop(arg_94_0.remasterAwardBtn:Find("IconTpl"), {
			type = var_94_4,
			id = var_94_5
		})
		setActive(arg_94_0.remasterAwardBtn:Find("tip"), var_94_6 <= var_94_8.count)
		onButton(arg_94_0, arg_94_0.remasterAwardBtn, function()
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideYes = true,
				hideNo = true,
				type = MSGBOX_TYPE_SINGLE_ITEM,
				drop = {
					type = var_94_4,
					id = var_94_5
				},
				remaster = {
					word = i18n("level_remaster_tip4", (BossRushChapterRemasterHelper.GetAwardName(var_0, var_94_3))),
					number = var_94_8.count .. "/" .. var_94_6,
					btn_text = i18n(var_94_8.count < var_94_6 and "level_remaster_tip2" or "level_remaster_tip3"),
					btn_call = function()
						if var_94_8.count < var_94_6 then
							if var_0 and var_0 > 0 then
								arg_94_0:emit(LevelMediator2.ON_BOSSRUSH_REMASTER_ACTIVITY, var_0)

								return
							end

							local var_96_0 = pg.chapter_template[var_94_3].map
							local var_96_1, var_96_2 = var_94_0:getMapById(pg.chapter_template[var_94_3].map):isUnlock()

							if not var_96_1 then
								pg.TipsMgr.GetInstance():ShowTips(var_96_2)
							else
								arg_94_0:ShowSelectedMap(var_96_0)
							end
						else
							arg_94_0:emit(LevelMediator2.ON_CHAPTER_REMASTER_AWARD, var_94_3, var_94_2, var_0)
						end

						return
					end
				}
			})

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.updateCountDown(arg_97_0)
	if arg_97_0.newChapterCDTimer then
		arg_97_0.newChapterCDTimer:Stop()

		arg_97_0.newChapterCDTimer = nil
	end

	local var_97_0 = 0

	if arg_97_0.contextData.map:isActivity() and not arg_97_0.contextData.map:isRemaster() then
		_.each(getProxy(ChapterProxy):getMapsByActivities(arg_97_0.contextData.map:getConfig("on_activity")), function(arg_98_0)
			local var_98_0 = arg_98_0:getChapterTimeLimit()

			var_97_0 = var_97_0 == 0 and var_98_0 or math.min(var_97_0, var_98_0)

			return
		end)
		setActive(arg_97_0.countDown, var_97_0 > 0)
		setText(arg_97_0.countDown:Find("title"), i18n("levelScene_new_chapter_coming"))
	else
		setActive(arg_97_0.countDown, false)
	end

	if var_97_0 > 0 then
		setText(arg_97_0.countDown:Find("time"), pg.TimeMgr.GetInstance():DescCDTime(var_97_0))

		arg_97_0.newChapterCDTimer = Timer.New(function()
			var_97_0 = var_97_0 - 1

			if var_97_0 <= 0 then
				arg_97_0:updateCountDown()

				if not arg_97_0.contextData.chapterVO then
					arg_97_0:setMap(arg_97_0.contextData.mapIdx)
				end
			else
				setText(arg_97_0.countDown:Find("time"), pg.TimeMgr.GetInstance():DescCDTime(var_97_0))
			end

			return
		end, 1, -1)

		arg_97_0.newChapterCDTimer:Start()
	else
		setText(arg_97_0.countDown:Find("time"), "")
	end

	return
end

function var_0_0.registerActBtn(arg_100_0)
	onButton(arg_100_0, arg_100_0.actExtraRank, function()
		if arg_100_0:isfrozen() then
			return
		end

		arg_100_0:emit(LevelMediator2.ON_EXTRA_RANK)

		return
	end, SFX_PANEL)
	onButton(arg_100_0, arg_100_0.activityBtn, function()
		if arg_100_0:isfrozen() then
			return
		end

		if arg_100_0.activityBtnLinkAct then
			local var_102_0 = arg_100_0.activityBtnLinkAct:getConfig("type")

			if var_102_0 == ActivityConst.ACTIVITY_TYPE_BOSSRUSH then
				pg.m02:sendNotification(GAME.GO_SCENE, SCENE.BOSSRUSH_MAIN)

				return
			elseif var_102_0 == ActivityConst.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB then
				pg.m02:sendNotification(GAME.GO_SCENE, SCENE.BOSSRUSH_DAL_COLLAB)

				return
			elseif arg_100_0.activityBtnLinkAct.id == ActivityConst.OTHER_WORLD_TERMINAL_BATTLE_ID then
				pg.m02:sendNotification(GAME.GO_SCENE, SCENE.OTHERWORLD_MAP)

				return
			elseif var_102_0 == ActivityConst.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2 then
				pg.m02:sendNotification(GAME.GO_SCENE, SCENE.ZHANG_WU_BOSS)

				return
			end
		end

		arg_100_0:emit(LevelMediator2.ON_ACTIVITY_MAP)

		return
	end, SFX_UI_CLICK)
	onButton(arg_100_0, arg_100_0.actExchangeShopBtn, function()
		if arg_100_0:isfrozen() then
			return
		end

		arg_100_0:emit(LevelMediator2.GO_ACT_SHOP)

		return
	end, SFX_UI_CLICK)
	onButton(arg_100_0, arg_100_0.actAtelierBuffBtn, function()
		if arg_100_0:isfrozen() then
			return
		end

		arg_100_0:emit(LevelMediator2.SHOW_ATELIER_BUFF)

		return
	end, SFX_UI_CLICK)
	onButton(arg_100_0, arg_100_0.actAtelierYumiaBuffBtn, function()
		if arg_100_0:isfrozen() then
			return
		end

		arg_100_0:emit(LevelMediator2.SHOW_ATELIER_BUFF, true)

		return
	end, SFX_UI_CLICK)

	local var_100_0 = getProxy(ChapterProxy)

	local function var_100_1(arg_106_0, arg_106_1, arg_106_2)
		local var_106_0 = arg_106_0:isRemaster() and var_100_0:getRemasterMaps(arg_106_0.remasterId) or var_100_0:getMapsByActivities(arg_106_0:getConfig("on_activity"))
		local var_106_1 = _.select(var_106_0, function(arg_107_0)
			return arg_107_0:getMapType() == arg_106_1
		end)

		table.sort(var_106_1, function(arg_108_0, arg_108_1)
			return arg_108_0.id < arg_108_1.id
		end)

		local var_106_2 = table.indexof(underscore.map(var_106_1, function(arg_109_0)
			return arg_109_0.id
		end), arg_106_2) or #var_106_1

		while not var_106_1[var_106_2]:isUnlock() do
			if var_106_2 > 1 then
				var_106_2 = var_106_2 - 1
			else
				break
			end
		end

		return var_106_1[var_106_2]
	end

	arg_100_0:bind(LevelUIConst.SWITCH_ACT_MAP, function(arg_110_0, arg_110_1, arg_110_2)
		arg_110_2 = arg_110_2 or switch(arg_110_1, {
			[Map.ACTIVITY_EASY] = function()
				return arg_100_0.contextData.map:getBindMapId()
			end,
			[Map.ACTIVITY_HARD] = function()
				return arg_100_0.contextData.map:getBindMapId()
			end,
			[Map.ACT_EXTRA] = function()
				return PlayerPrefs.GetInt("ex_mapId", 0)
			end
		})

		local var_110_0 = var_100_1(arg_100_0.contextData.map, arg_110_1, arg_110_2)
		local var_110_1, var_110_2 = var_110_0:isUnlock()

		if var_110_1 then
			arg_100_0:setMap(var_110_0.id)
		else
			pg.TipsMgr.GetInstance():ShowTips(var_110_2)
		end

		return
	end)
	onButton(arg_100_0, arg_100_0.actNormalBtn, function()
		if arg_100_0:isfrozen() then
			return
		end

		arg_100_0:emit(LevelUIConst.SWITCH_ACT_MAP, Map.ACTIVITY_EASY)

		return
	end, SFX_PANEL)
	onButton(arg_100_0, arg_100_0.actEliteBtn, function()
		if arg_100_0:isfrozen() then
			return
		end

		arg_100_0:emit(LevelUIConst.SWITCH_ACT_MAP, Map.ACTIVITY_HARD)

		return
	end, SFX_PANEL)
	onButton(arg_100_0, arg_100_0.actExtraBtn, function()
		if arg_100_0:isfrozen() then
			return
		end

		arg_100_0:emit(LevelUIConst.SWITCH_ACT_MAP, Map.ACT_EXTRA)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.initCloudsPos(arg_117_0, arg_117_1)
	arg_117_0.initPositions = {}

	for iter_117_0, iter_117_1 in ipairs(arg_117_0.cloudRTFs) do
		if pg.expedition_data_by_map[arg_117_1 or 1].clouds_pos[iter_117_0] then
			iter_117_1.anchoredPosition = Vector2(pg.expedition_data_by_map[arg_117_1 or 1].clouds_pos[iter_117_0][1], pg.expedition_data_by_map[arg_117_1 or 1].clouds_pos[iter_117_0][2])

			table.insert(arg_117_0.initPositions, iter_117_1.anchoredPosition)
		else
			setActive(iter_117_1, false)
		end
	end

	return
end

function var_0_0.initMapBtn(arg_118_0, arg_118_1, arg_118_2)
	onButton(arg_118_0, arg_118_1, function()
		if arg_118_0:isfrozen() then
			return
		end

		local var_119_0 = arg_118_0.contextData.mapIdx + arg_118_2
		local var_119_1 = getProxy(ChapterProxy):getMapById(arg_118_0.contextData.mapIdx + arg_118_2)

		if not var_119_1 then
			return
		end

		if var_119_1:getMapType() == Map.ELITE and not var_119_1:isEliteEnabled() then
			var_119_1 = var_119_1:getBindMap()
			var_119_0 = var_119_1.id

			pg.TipsMgr.GetInstance():ShowTips(i18n("elite_disable_unusable"))
		end

		local var_119_2, var_119_3 = var_119_1:isUnlock()

		if arg_118_2 > 0 and not var_119_2 then
			pg.TipsMgr.GetInstance():ShowTips(var_119_3)

			return
		end

		arg_118_0:setMap(var_119_0)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.ShowSelectedMap(arg_120_0, arg_120_1, arg_120_2)
	seriesAsync({
		function(arg_121_0)
			if arg_120_0.contextData.entranceStatus then
				arg_120_0:frozen()

				arg_120_0.nextPreloadMap = arg_120_1

				arg_120_0:PreloadLevelMainUI(arg_120_1, function()
					arg_120_0:unfrozen()

					if arg_120_0.nextPreloadMap ~= arg_120_1 then
						return
					end

					arg_120_0:ShowEntranceUI(false)
					arg_120_0:emit(LevelMediator2.ON_ENTER_MAINLEVEL, arg_120_1)
					arg_121_0()

					return
				end)
			else
				arg_120_0:setMap(arg_120_1)
				arg_121_0()
			end

			return
		end
	}, arg_120_2)

	return
end

function var_0_0.setMap(arg_123_0, arg_123_1)
	local var_123_0 = arg_123_0.contextData.mapIdx

	arg_123_0.contextData.mapIdx = arg_123_1
	arg_123_0.contextData.map = getProxy(ChapterProxy):getMapById(arg_123_1)

	assert(arg_123_0.contextData.map, "map cannot be nil " .. arg_123_1)

	if arg_123_0.contextData.map:getMapType() == Map.ACT_EXTRA then
		PlayerPrefs.SetInt("ex_mapId", arg_123_0.contextData.map.id)
		PlayerPrefs.Save()
	elseif arg_123_0.contextData.map:isRemaster() then
		PlayerPrefs.SetInt("remaster_lastmap_" .. arg_123_0.contextData.map.remasterId, arg_123_1)
		PlayerPrefs.Save()
	end

	arg_123_0:RecordLastMapOnExit()
	arg_123_0:updateMap(var_123_0)
	arg_123_0:tryPlayMapStory()

	return
end

local var_0_5 = import("view.level.MapBuilder.MapBuilder")
local var_0_6 = {
	[var_0_5.TYPENORMAL] = "MapBuilderNormal",
	[var_0_5.TYPEESCORT] = "MapBuilderEscort",
	[var_0_5.TYPESHINANO] = "MapBuilderShinano",
	[var_0_5.TYPESKIRMISH] = "MapBuilderSkirmish",
	[var_0_5.TYPEBISMARCK] = "MapBuilderBismarck",
	[var_0_5.TYPESSSS] = "MapBuilderSSSS",
	[var_0_5.TYPEATELIER] = "MapBuilderAtelier",
	[var_0_5.TYPESENRANKAGURA] = "MapBuilderSenrankagura",
	[var_0_5.TYPESP] = "MapBuilderSP",
	[var_0_5.TYPESPFULL] = "MapBuilderSPFull",
	[var_0_5.TYPESPSERIES] = "MapBuilderSPSeries",
	[var_0_5.TYPESPSERIESFULL] = "MapBuilderSPSeriesFull",
	[var_0_5.TYPEATELIERYUMIA] = "MapBuilderAtelierYumia",
	[var_0_5.TYPEEXSP] = "MapBuilderEXSP",
	[var_0_5.TYPESPSERIESRECREW] = "MapBuilderSPSeriesRecrew"
}

function var_0_0.SwitchMapBuilder(arg_124_0, arg_124_1)
	if arg_124_0.mapBuilder and arg_124_0.mapBuilder:GetType() ~= arg_124_1 then
		arg_124_0.mapBuilder.buffer:Hide()
	end

	local var_124_0 = arg_124_0:GetMapBuilderInBuffer(arg_124_1)

	arg_124_0.mapBuilder = var_124_0

	var_124_0.buffer:Show()

	return
end

function var_0_0.GetMapBuilderInBuffer(arg_125_0, arg_125_1)
	if not arg_125_0.mbDict[arg_125_1] then
		assert(_G[var_0_6[arg_125_1]], "Missing MapBuilder of type " .. (arg_125_1 or "NIL"))

		arg_125_0.mbDict[arg_125_1] = _G[var_0_6[arg_125_1]].New(arg_125_0._tf, arg_125_0)
		arg_125_0.mbDict[arg_125_1].isFrozen = arg_125_0:isfrozen()

		arg_125_0.mbDict[arg_125_1]:Load()
	end

	return arg_125_0.mbDict[arg_125_1]
end

function var_0_0.updateMap(arg_126_0, arg_126_1)
	local var_126_0 = arg_126_0.contextData.map
	local var_126_1 = arg_126_0.contextData.map:getConfig("anchor")

	arg_126_0.map.pivot = var_126_1 == "" and Vector2(0.5, 0.5) or Vector2(unpack(var_126_1))

	local var_126_3 = var_126_0:getConfig("uifx")

	for iter_126_0 = 1, arg_126_0.UIFXList.childCount do
		local var_126_4 = arg_126_0.UIFXList:GetChild(iter_126_0 - 1)

		setActive(var_126_4, var_126_4.name == var_126_3)
	end

	arg_126_0:SwitchMapBG(var_126_0, arg_126_1)
	arg_126_0:PlayBGM()
	arg_126_0:SwitchMapBuilder((arg_126_0.contextData.map:getConfig("ui_type")))
	seriesAsync({
		function(arg_127_0)
			arg_126_0.mapBuilder:CallbackInvoke(arg_127_0)

			return
		end,
		function(arg_128_0)
			arg_126_0.mapBuilder:UpdateMapVO(var_126_0)
			arg_126_0.mapBuilder:UpdateView()
			arg_126_0.mapBuilder:UpdateMapItems()
			arg_126_0.mapBuilder:PlayEnterAnim()

			return
		end
	})

	return
end

function var_0_0.UpdateSwitchMapButton(arg_129_0)
	local var_129_0 = getProxy(ChapterProxy)
	local var_129_1 = var_129_0:getMapById(arg_129_0.contextData.map.id - 1)
	local var_129_2 = var_129_0:getMapById(arg_129_0.contextData.map.id + 1)

	setActive(arg_129_0.btnPrev, tobool(var_129_1))
	setActive(arg_129_0.btnNext, tobool(var_129_2))

	local var_129_3 = Color.New(0.5, 0.5, 0.5, 1)
	local var_129_5 = arg_129_0.btnPrevCol

	if var_129_1 then
		local var_129_6 = Color.white or var_129_3

		var_129_4(var_129_5, var_129_6)

		local var_129_8 = arg_129_0.btnNextCol

		if var_129_2 and var_129_2:isUnlock() then
			local var_129_9 = Color.white or var_129_3

			var_129_7(var_129_8, var_129_9)

			return
		end
	end
end

function var_0_0.tryPlayMapStory(arg_130_0)
	if IsUnityEditor and not ENABLE_GUIDE then
		return
	end

	seriesAsync({
		function(arg_131_0)
			local var_131_0 = arg_130_0.contextData.map:getConfig("enter_story")

			if var_131_0 and var_131_0 ~= "" then
				if not pg.NewStoryMgr.GetInstance():IsPlayed(var_131_0) and not arg_130_0.contextData.map:isRemaster() and not pg.SystemOpenMgr.GetInstance().active then
					local var_131_1 = tonumber(var_131_0)

					if var_131_1 and var_131_1 > 0 then
						arg_130_0:emit(LevelMediator2.ON_PERFORM_COMBAT, var_131_1)
					else
						pg.NewStoryMgr.GetInstance():Play(var_131_0, arg_131_0)
					end

					return
				end
			end

			arg_131_0()

			return
		end,
		function(arg_132_0)
			local var_132_0 = arg_130_0.contextData.map:getConfig("guide_id")

			if var_132_0 and var_132_0 ~= "" then
				pg.SystemGuideMgr.GetInstance():PlayByGuideId(var_132_0, nil, arg_132_0)

				return
			end

			arg_132_0()

			return
		end,
		function(arg_133_0)
			if isActive(arg_130_0.actAtelierBuffBtn) then
				if getProxy(ActivityProxy):AtelierActivityAllSlotIsEmpty() then
					if getProxy(ActivityProxy):OwnAtelierActivityItemCnt(34, 1) then
						local var_133_0 = "first_enter_ryza_buff_" .. getProxy(PlayerProxy):getRawData().id
						local var_133_1 = PlayerPrefs.GetInt(var_133_0, 0) == 0 and {
							1,
							2
						} or {
							1
						}

						pg.SystemGuideMgr.GetInstance():PlayByGuideId("NG0034", var_133_1)

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

			pg.SystemOpenMgr.GetInstance():notification(arg_130_0.player.level)

			if pg.SystemOpenMgr.GetInstance().active then
				getProxy(ChapterProxy):StopAutoFight()
			end

			return
		end
	})

	return
end

function var_0_0.DisplaySPAnim(arg_135_0, arg_135_1, arg_135_2, arg_135_3)
	arg_135_0.uiAnims = arg_135_0.uiAnims or {}

	local function var_135_0()
		arg_135_0.playing = true

		arg_135_0:frozen()
		var_0:SetActive(true)

		local var_136_0 = tf(var_0)

		pg.UIMgr.GetInstance():OverlayPanel(var_136_0)

		if arg_135_3 then
			arg_135_3(var_0)
		end

		var_136_0:GetComponent("DftAniEvent"):SetEndEvent(function(arg_137_0)
			arg_135_0.playing = false

			if arg_135_2 then
				arg_135_2(var_0)
			end

			arg_135_0:unfrozen()

			return
		end)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_WARNING)

		return
	end

	if not arg_135_0.uiAnims[arg_135_1] then
		PoolMgr.GetInstance():GetUI(arg_135_1, true, function(arg_138_0)
			arg_138_0:SetActive(true)

			arg_135_0.uiAnims[arg_135_1] = arg_138_0
			var_0 = arg_135_0.uiAnims[arg_135_1]

			var_135_0()

			return
		end)
	else
		(function()
			arg_135_0.playing = true

			arg_135_0:frozen()
			var_0:SetActive(true)

			local var_136_0 = tf(var_0)

			pg.UIMgr.GetInstance():OverlayPanel(var_136_0)

			if arg_135_3 then
				arg_135_3(var_0)
			end

			var_136_0:GetComponent("DftAniEvent"):SetEndEvent(function(arg_137_0)
				arg_135_0.playing = false

				if arg_135_2 then
					arg_135_2(var_0)
				end

				arg_135_0:unfrozen()

				return
			end)
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_WARNING)

			return
		end)()
	end

	return
end

function var_0_0.displaySpResult(arg_139_0, arg_139_1, arg_139_2)
	setActive(arg_139_0.spResult, true)
	arg_139_0:DisplaySPAnim(arg_139_1 == 1 and "SpUnitWin" or "SpUnitLose", function(arg_140_0)
		onButton(arg_139_0, arg_140_0, function()
			removeOnButton(arg_140_0)
			setActive(arg_140_0, false)
			pg.UIMgr.GetInstance():UnOverlayPanel(arg_140_0, arg_139_0._tf)
			arg_139_0:hideSpResult()
			arg_139_2()

			return
		end, SFX_PANEL)

		return
	end)

	return
end

function var_0_0.hideSpResult(arg_142_0)
	setActive(arg_142_0.spResult, false)

	return
end

function var_0_0.displayBombResult(arg_143_0, arg_143_1)
	setActive(arg_143_0.spResult, true)
	arg_143_0:DisplaySPAnim("SpBombRet", function(arg_144_0)
		onButton(arg_143_0, arg_144_0, function()
			removeOnButton(arg_144_0)
			setActive(arg_144_0, false)
			pg.UIMgr.GetInstance():UnOverlayPanel(arg_144_0, arg_143_0._tf)
			arg_143_0:hideSpResult()
			arg_143_1()

			return
		end, SFX_PANEL)

		return
	end, function(arg_146_0)
		setText(arg_146_0.transform:Find("right/name_bg/en"), arg_143_0.contextData.chapterVO.modelCount)

		return
	end)

	return
end

function var_0_0.OnLevelInfoPanelConfirm(arg_147_0, arg_147_1, arg_147_2)
	arg_147_0.contextData.chapterLoopFlag = arg_147_2

	local var_147_0 = getProxy(ChapterProxy):getChapterById(arg_147_1, true)

	if var_147_0:getConfig("type") == Chapter.CustomFleet then
		arg_147_0:displayFleetEdit(var_147_0)

		return
	end

	if #var_147_0:getNpcShipByType(1) > 0 then
		arg_147_0:emit(LevelMediator2.ON_TRACKING, arg_147_1)

		return
	end

	arg_147_0:displayFleetSelect(var_147_0)

	return
end

function var_0_0.DisplayLevelInfoPanel(arg_148_0, arg_148_1, arg_148_2)
	seriesAsync({
		function(arg_149_0)
			if not arg_148_0.levelInfoView:GetLoaded() then
				arg_148_0:frozen()
				arg_148_0.levelInfoView:Load()
				arg_148_0.levelInfoView:CallbackInvoke(function()
					arg_148_0:unfrozen()
					arg_149_0()

					return
				end)

				return
			end

			arg_149_0()

			return
		end,
		function(arg_151_0)
			local var_151_0 = getProxy(ChapterProxy):getChapterById(arg_148_1, true)

			if getProxy(ChapterProxy):getMapById(var_151_0:getConfig("map")):isSkirmish() and #var_151_0:getNpcShipByType(1) > 0 then
				(function(arg_152_0, arg_152_1)
					arg_148_0:hideChapterPanel()
					arg_148_0:OnLevelInfoPanelConfirm(arg_152_0, arg_152_1)

					return
				end)(false)

				return
			end

			arg_148_0.levelInfoView:set(arg_148_1, arg_148_2)
			arg_148_0.levelInfoView:setCBFunc(function(arg_152_0, arg_152_1)
				arg_148_0:hideChapterPanel()
				arg_148_0:OnLevelInfoPanelConfirm(arg_152_0, arg_152_1)

				return
			end, function()
				arg_148_0:hideChapterPanel()

				return
			end)
			arg_148_0.levelInfoView:Show()

			return
		end
	})

	return
end

function var_0_0.hideChapterPanel(arg_154_0)
	if arg_154_0.levelInfoView:isShowing() then
		arg_154_0.levelInfoView:Hide()
	end

	return
end

function var_0_0.destroyChapterPanel(arg_155_0)
	arg_155_0.levelInfoView:Destroy()

	arg_155_0.levelInfoView = nil

	return
end

function var_0_0.DisplayLevelInfoSPPanel(arg_156_0, arg_156_1, arg_156_2, arg_156_3)
	seriesAsync({
		function(arg_157_0)
			if not arg_156_0.levelInfoSPView then
				arg_156_0.levelInfoSPView = LevelInfoSPView.New(arg_156_0.topPanel, arg_156_0.event, arg_156_0.contextData)

				arg_156_0.levelInfoSPView:RegisterView(arg_156_0)
				arg_156_0:frozen()
				arg_156_0.levelInfoSPView:Load()
				arg_156_0.levelInfoSPView:CallbackInvoke(function()
					arg_156_0:unfrozen()
					arg_157_0()

					return
				end)

				return
			end

			arg_157_0()

			return
		end,
		function(arg_159_0)
			arg_156_0.levelInfoSPView:SetChapterGroupInfo(arg_156_2)
			arg_156_0.levelInfoSPView:set(arg_156_1, arg_156_3)
			arg_156_0.levelInfoSPView:setCBFunc(function(arg_160_0, arg_160_1)
				arg_156_0:HideLevelInfoSPPanel()
				arg_156_0:OnLevelInfoPanelConfirm(arg_160_0, arg_160_1)

				return
			end, function()
				arg_156_0:HideLevelInfoSPPanel()

				return
			end)
			arg_156_0.levelInfoSPView:Show()

			return
		end
	})

	return
end

function var_0_0.HideLevelInfoSPPanel(arg_162_0)
	if arg_162_0.levelInfoSPView and arg_162_0.levelInfoSPView:isShowing() then
		arg_162_0.levelInfoSPView:Hide()
	end

	return
end

function var_0_0.DestroyLevelInfoSPPanel(arg_163_0)
	if not arg_163_0.levelInfoSPView then
		return
	end

	arg_163_0.levelInfoSPView:Destroy()

	arg_163_0.levelInfoSPView = nil

	return
end

function var_0_0.displayFleetSelect(arg_164_0, arg_164_1)
	local var_164_0 = arg_164_0.contextData.selectedFleetIDs or arg_164_1:GetDefaultFleetIndex()

	arg_164_1 = Clone(arg_164_1)
	arg_164_1.loopFlag = arg_164_0.contextData.chapterLoopFlag

	arg_164_0.levelFleetView:updateSpecialOperationTickets(arg_164_0.spTickets)
	arg_164_0.levelFleetView:Load()
	arg_164_0.levelFleetView:ActionInvoke("setHardShipVOs", arg_164_0.shipVOs)
	arg_164_0.levelFleetView:ActionInvoke("setOpenCommanderTag", arg_164_0.openedCommanerSystem)
	arg_164_0.levelFleetView:ActionInvoke("set", arg_164_1, arg_164_0.fleets, var_164_0)
	arg_164_0.levelFleetView:ActionInvoke("Show")

	return
end

function var_0_0.hideFleetSelect(arg_165_0)
	if arg_165_0.levelCMDFormationView:isShowing() then
		arg_165_0.levelCMDFormationView:Hide()
	end

	if arg_165_0.levelFleetView then
		arg_165_0.levelFleetView:Hide()
	end

	return
end

function var_0_0.buildCommanderPanel(arg_166_0)
	arg_166_0.levelCMDFormationView = LevelCMDFormationView.New(arg_166_0.topPanel, arg_166_0.event, arg_166_0.contextData)

	return
end

function var_0_0.destroyFleetSelect(arg_167_0)
	if not arg_167_0.levelFleetView then
		return
	end

	arg_167_0.levelFleetView:Destroy()

	arg_167_0.levelFleetView = nil

	return
end

function var_0_0.displayFleetEdit(arg_168_0, arg_168_1)
	arg_168_1 = Clone(arg_168_1)
	arg_168_1.loopFlag = arg_168_0.contextData.chapterLoopFlag

	arg_168_0.levelFleetView:updateSpecialOperationTickets(arg_168_0.spTickets)
	arg_168_0.levelFleetView:Load()
	arg_168_0.levelFleetView:ActionInvoke("setOpenCommanderTag", arg_168_0.openedCommanerSystem)
	arg_168_0.levelFleetView:ActionInvoke("setHardShipVOs", arg_168_0.shipVOs)
	arg_168_0.levelFleetView:ActionInvoke("setOnHard", arg_168_1)
	arg_168_0.levelFleetView:ActionInvoke("Show")

	return
end

function var_0_0.hideFleetEdit(arg_169_0)
	arg_169_0:hideFleetSelect()

	return
end

function var_0_0.destroyFleetEdit(arg_170_0)
	arg_170_0:destroyFleetSelect()

	return
end

function var_0_0.RefreshFleetSelectView(arg_171_0, arg_171_1)
	if not arg_171_0.levelFleetView then
		return
	end

	assert(arg_171_0.levelFleetView:GetLoaded())

	local var_171_0

	if arg_171_0.levelFleetView:IsSelectMode() then
		arg_171_0.levelFleetView:ActionInvoke("set", arg_171_1 or arg_171_0.levelFleetView.chapter, arg_171_0.fleets, arg_171_0.levelFleetView:getSelectIds())

		if arg_171_0.levelCMDFormationView:isShowing() then
			var_171_0 = arg_171_0.fleets[arg_171_0.levelCMDFormationView.fleet.id]
		end
	else
		arg_171_0.levelFleetView:ActionInvoke("setOnHard", arg_171_1 or arg_171_0.levelFleetView.chapter)

		if arg_171_0.levelCMDFormationView:isShowing() then
			var_171_0 = arg_171_1:wrapEliteFleet(arg_171_0.levelCMDFormationView.fleet.id)
		end
	end

	if var_171_0 then
		arg_171_0.levelCMDFormationView:ActionInvoke("updateFleet", var_171_0)
	end

	return
end

function var_0_0.setChapter(arg_172_0, arg_172_1)
	local var_172_0

	if arg_172_1 then
		var_172_0 = arg_172_1.id
	end

	arg_172_0.contextData.chapterId = var_172_0
	arg_172_0.contextData.chapterVO = arg_172_1

	return
end

function var_0_0.switchToChapter(arg_173_0, arg_173_1)
	if arg_173_0.contextData.mapIdx ~= arg_173_1:getConfig("map") then
		arg_173_0:setMap(arg_173_1:getConfig("map"))
	end

	arg_173_0:setChapter(arg_173_1)

	arg_173_0.leftCanvasGroup.blocksRaycasts = false
	arg_173_0.rightCanvasGroup.blocksRaycasts = false

	assert(not arg_173_0.levelStageView, "LevelStageView Exists On SwitchToChapter")
	arg_173_0:DestroyLevelStageView()

	if not arg_173_0.levelStageView then
		arg_173_0.levelStageView = LevelStageView.New(arg_173_0.topPanel, arg_173_0.event, arg_173_0.contextData)

		arg_173_0.levelStageView:Load()

		arg_173_0.levelStageView.isFrozen = arg_173_0:isfrozen()
	end

	arg_173_0:frozen()
	arg_173_0.levelStageView:ActionInvoke("SetSeriesOperation", function()
		seriesAsync({
			function(arg_175_0)
				arg_173_0.mapBuilder:CallbackInvoke(arg_175_0)

				return
			end,
			function(arg_176_0)
				setActive(arg_173_0.clouds, false)
				arg_173_0.mapBuilder:HideFloat()
				arg_173_0:BlurPanel(arg_173_0.topPanel, {
					blurCamList = {
						pg.UIMgr.CameraUI
					}
				})
				arg_173_0.levelStageView:updateStageInfo()
				arg_173_0.levelStageView:updateAmbushRate(arg_173_1.fleet.line, true)
				arg_173_0.levelStageView:updateStageAchieve()
				arg_173_0.levelStageView:updateStageBarrier()
				arg_173_0.levelStageView:updateBombPanel()
				arg_173_0.levelStageView:UpdateDefenseStatus()
				onNextTick(arg_176_0)

				return
			end,
			function(arg_177_0)
				if arg_173_0.exited then
					return
				end

				arg_173_0.levelStageView:updateStageStrategy()

				arg_173_0.canvasGroup.blocksRaycasts = arg_173_0.frozenCount == 0

				onNextTick(arg_177_0)

				return
			end,
			function(arg_178_0)
				if arg_173_0.exited then
					return
				end

				arg_173_0.levelStageView:updateStageFleet()
				arg_173_0.levelStageView:updateSupportFleet()
				arg_173_0.levelStageView:updateFleetBuff()
				onNextTick(arg_178_0)

				return
			end,
			function(arg_179_0)
				if arg_173_0.exited then
					return
				end

				parallelAsync({
					function(arg_180_0)
						local var_180_0 = arg_173_1:getConfig("scale")

						arg_173_0:RecordTween("mapScale", LeanTween.value(go(arg_173_0.map), arg_173_0.map.localScale, Vector3.New(var_180_0[3], var_180_0[3], 1), var_0_1):setOnUpdateVector3(function(arg_181_0)
							arg_173_0.map.localScale = arg_181_0
							arg_173_0.float.localScale = arg_181_0

							return
						end):setOnComplete(System.Action(function()
							arg_173_0.mapBuilder:ShowFloat()
							arg_173_0.mapBuilder:Hide()
							arg_180_0()

							return
						end)):setEase(LeanTweenType.easeOutSine).uniqueId)

						local var_180_1 = LeanTween.value(go(arg_173_0.map), arg_173_0.map.pivot, Vector2.New(math.clamp(var_180_0[1] - 0.5, 0, 1), math.clamp(var_180_0[2] - 0.5, 0, 1)), var_0_1)

						var_180_1:setOnUpdateVector2(function(arg_183_0)
							arg_173_0.map.pivot = arg_183_0
							arg_173_0.float.pivot = arg_183_0

							return
						end):setEase(LeanTweenType.easeOutSine)
						arg_173_0:RecordTween("mapPivot", var_180_1.uniqueId)
						shiftPanel(arg_173_0.leftChapter, -arg_173_0.leftChapter.rect.width - 200, 0, 0.3, 0, true, nil, LeanTweenType.easeOutSine)
						shiftPanel(arg_173_0.rightChapter, arg_173_0.rightChapter.rect.width + 200, 0, 0.3, 0, true, nil, LeanTweenType.easeOutSine)
						shiftPanel(arg_173_0.topChapter, 0, arg_173_0.topChapter.rect.height, 0.3, 0, true, nil, LeanTweenType.easeOutSine)
						arg_173_0.levelStageView:ShiftStagePanelIn()

						return
					end,
					function(arg_184_0)
						arg_173_0:PlayBGM()

						local var_184_0 = arg_173_1:getConfig("bg")

						if var_184_0 and #var_184_0 > 0 then
							({})[1] = {
								BG = var_184_0
							}
						end

						arg_173_0:SwitchBG({}, arg_184_0)

						return
					end
				}, function()
					onNextTick(arg_179_0)

					return
				end)

				return
			end,
			function(arg_186_0)
				if arg_173_0.exited then
					return
				end

				setActive(arg_173_0.topChapter, false)
				setActive(arg_173_0.leftChapter, false)
				setActive(arg_173_0.rightChapter, false)

				arg_173_0.leftCanvasGroup.blocksRaycasts = true
				arg_173_0.rightCanvasGroup.blocksRaycasts = true

				arg_173_0:initGrid(arg_186_0)

				return
			end,
			function(arg_187_0)
				if arg_173_0.exited then
					return
				end

				arg_173_0.levelStageView:SetGrid(arg_173_0.grid)

				arg_173_0.contextData.huntingRangeVisibility = arg_173_0.contextData.huntingRangeVisibility - 1

				arg_173_0.grid:toggleHuntingRange()

				local var_187_0 = arg_173_1:getConfig("pop_pic")

				if var_187_0 and #var_187_0 > 0 and arg_173_0.FirstEnterChapter == arg_173_1.id then
					arg_173_0:doPlayAnim(var_187_0, function(arg_188_0)
						setActive(arg_188_0, false)

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
				arg_173_0.levelStageView:tryAutoAction(arg_189_0)

				return
			end,
			function(arg_190_0)
				if arg_173_0.exited then
					return
				end

				arg_173_0:unfrozen()

				if arg_173_0.FirstEnterChapter then
					arg_173_0:emit(LevelMediator2.ON_RESUME_SUBSTATE, arg_173_1.subAutoAttack)
				end

				arg_173_0.FirstEnterChapter = nil

				arg_190_0()

				return
			end,
			function(arg_191_0)
				if arg_173_1:NeedSupportSubmarineStage() then
					arg_173_0.levelStageView:TryEnterChapterSupportSubmarineStage(arg_191_0)
				else
					arg_191_0()
				end

				return
			end
		}, function()
			arg_173_0.levelStageView:tryAutoTrigger(true)

			return
		end)

		return
	end)
	arg_173_0.levelStageView:ActionInvoke("SetPlayer", arg_173_0.player)
	arg_173_0.levelStageView:ActionInvoke("SwitchToChapter", arg_173_1)

	return
end

function var_0_0.switchToMap(arg_193_0, arg_193_1)
	arg_193_0:frozen()
	arg_193_0:destroyGrid()
	arg_193_0:setChapter(nil)
	LeanTween.cancel(go(arg_193_0.map))
	arg_193_0:RecordTween("mapScale", LeanTween.value(go(arg_193_0.map), arg_193_0.map.localScale, Vector3.one, var_0_1):setOnUpdateVector3(function(arg_194_0)
		arg_193_0.map.localScale = arg_194_0
		arg_193_0.float.localScale = arg_194_0

		return
	end):setOnComplete(System.Action(function()
		arg_193_0:unfrozen()
		arg_193_0.mapBuilder:PlayEnterAnim()
		existCall(arg_193_1)

		return
	end)):setEase(LeanTweenType.easeOutSine).uniqueId)

	local var_193_0 = arg_193_0.contextData.map:getConfig("anchor")
	local var_193_1 = var_193_0 == "" and Vector2(0.5, 0.5) or Vector2(unpack(var_193_0))
	local var_193_2 = LeanTween.value(go(arg_193_0.map), arg_193_0.map.pivot, var_193_1, var_0_1)

	var_193_2:setOnUpdateVector2(function(arg_196_0)
		arg_193_0.map.pivot = arg_196_0
		arg_193_0.float.pivot = arg_196_0

		return
	end):setEase(LeanTweenType.easeOutSine)
	arg_193_0:RecordTween("mapPivot", var_193_2.uniqueId)
	setActive(arg_193_0.topChapter, true)
	setActive(arg_193_0.leftChapter, true)
	setActive(arg_193_0.rightChapter, true)
	shiftPanel(arg_193_0.leftChapter, 0, 0, 0.3, 0, true, nil, LeanTweenType.easeOutSine)
	shiftPanel(arg_193_0.rightChapter, 0, 0, 0.3, 0, true, nil, LeanTweenType.easeOutSine)
	shiftPanel(arg_193_0.topChapter, 0, 0, 0.3, 0, true, nil, LeanTweenType.easeOutSine)
	assert(arg_193_0.levelStageView, "LevelStageView Doesnt Exist On SwitchToMap")

	if arg_193_0.levelStageView then
		arg_193_0.levelStageView:ActionInvoke("ShiftStagePanelOut", function()
			arg_193_0:DestroyLevelStageView()

			return
		end)
		arg_193_0.levelStageView:ActionInvoke("SwitchToMap")
	end

	arg_193_0:SwitchMapBG(arg_193_0.contextData.map)
	arg_193_0:PlayBGM()
	seriesAsync({
		function(arg_198_0)
			arg_193_0.mapBuilder:CallbackInvoke(arg_198_0)

			return
		end,
		function(arg_199_0)
			arg_193_0.mapBuilder:Show()
			arg_193_0.mapBuilder:UpdateView()
			arg_193_0.mapBuilder:UpdateMapItems()

			return
		end
	})
	arg_193_0:UnOverlayPanel(arg_193_0.topPanel, arg_193_0._tf)

	arg_193_0.canvasGroup.blocksRaycasts = arg_193_0.frozenCount == 0
	arg_193_0.canvasGroup.interactable = true

	if arg_193_0.ambushWarning and arg_193_0.ambushWarning.activeSelf then
		arg_193_0.ambushWarning:SetActive(false)
		arg_193_0:unfrozen()
	end

	return
end

function var_0_0.SwitchBG(arg_200_0, arg_200_1, arg_200_2, arg_200_3)
	if not arg_200_1 or #arg_200_1 <= 0 then
		existCall(arg_200_2)

		return
	elseif arg_200_3 then
		-- block empty
	elseif table.equal(arg_200_0.currentBG, arg_200_1) then
		return
	end

	arg_200_0.currentBG = arg_200_1

	for iter_200_0, iter_200_1 in ipairs(arg_200_0.mapGroup) do
		arg_200_0.loader:ClearRequest(iter_200_1)
	end

	table.clear(arg_200_0.mapGroup)

	local var_200_0 = {}

	table.ParallelIpairsAsync(arg_200_1, function(arg_201_0, arg_201_1, arg_201_2)
		local var_201_0 = arg_200_0.mapTFs[arg_201_0]

		if arg_201_1.bgPrefix then
			local var_201_1 = arg_201_1.bgPrefix .. "/" or "levelmap/"

			table.insert(arg_200_0.mapGroup, (arg_200_0.loader:GetSpriteDirect(var_201_1 .. arg_201_1.BG, "", function(arg_202_0)
				var_200_0[arg_201_0] = arg_202_0

				arg_201_2()

				return
			end, var_201_0)))
			arg_200_0:updateCouldAnimator(arg_201_1.Animator, arg_201_0)

			return
		end
	end, function()
		for iter_203_0, iter_203_1 in ipairs(arg_200_0.mapTFs) do
			setImageSprite(iter_203_1, var_200_0[iter_203_0])
			setActive(iter_203_1, arg_200_1[iter_203_0])
			SetCompomentEnabled(iter_203_1, typeof(Image), true)
		end

		existCall(arg_200_2)

		return
	end)

	return
end

local var_0_7 = {
	1520001,
	1520002,
	1520011,
	1520012
}
local var_0_8 = {
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
local var_0_9 = {
	1420001,
	1420011
}

function var_0_0.ClearMapTransitions(arg_204_0)
	if not arg_204_0.mapTransitions then
		return
	end

	for iter_204_0, iter_204_1 in pairs(arg_204_0.mapTransitions) do
		if iter_204_1 then
			PoolMgr.GetInstance():ReturnPrefab("ui/" .. iter_204_0, iter_204_0, iter_204_1, true)
		else
			PoolMgr.GetInstance():DestroyPrefab("ui/" .. iter_204_0, iter_204_0)
		end
	end

	arg_204_0.mapTransitions = nil

	return
end

function var_0_0.SwitchMapBG(arg_205_0, arg_205_1, arg_205_2, arg_205_3)
	local var_205_0, var_205_1, var_205_2 = arg_205_0:GetMapBG(arg_205_1, arg_205_2)

	if var_205_1 then
		table.insert({}, function(arg_206_0)
			arg_205_0:PlayMapTransition("LevelMapTransition_" .. var_205_1, var_205_2, arg_206_0)

			return
		end)
	end

	seriesAsync({}, function()
		arg_205_0:SwitchBGMapType(arg_205_1:getConfig("pos_type"))
		arg_205_0:SwitchBG(var_205_0, nil, arg_205_3)

		return
	end)

	return
end

function var_0_0.SwitchBGMapType(arg_208_0, arg_208_1)
	if arg_208_0.posType == arg_208_1 then
		return
	end

	for iter_208_0, iter_208_1 in ipairs({
		arg_208_0.map,
		arg_208_0.float
	}) do
		local var_208_0 = GetOrAddComponent(iter_208_1, typeof(AspectRatioFitter))

		var_208_0.aspectRatio = 1.7777777777777777
		var_208_0.enabled = arg_208_1 == 0

		if arg_208_1 == 1 then
			iter_208_1.anchorMin = Vector2(0.5, 0.5)
			iter_208_1.anchorMax = Vector2(0.5, 0.5)

			setSizeDelta(var_208_0, {
				x = 2520,
				y = 1440
			})
		end
	end

	return
end

function var_0_0.GetMapBG(arg_209_0, arg_209_1, arg_209_2)
	if not table.contains(var_0_7, arg_209_1.id) then
		return {
			arg_209_0:GetMapElement(arg_209_1)
		}
	end

	local var_209_0 = arg_209_1.id
	local var_209_1 = table.indexof(var_0_7, arg_209_1.id) - 1
	local var_209_2 = bit.lshift(bit.rshift(var_209_1, 1), 1) + 1

	if _.all(_.map({
		var_0_7[var_209_2],
		var_0_7[var_209_2 + 1]
	}, function(arg_210_0)
		return getProxy(ChapterProxy):getMapById(arg_210_0)
	end), function(arg_211_0)
		return arg_211_0:isAllChaptersClear()
	end) then
		local var_209_3 = {
			arg_209_0:GetMapElement(arg_209_1)
		}
		local var_209_4, var_209_5

		if not arg_209_2 or math.abs(var_209_0 - arg_209_2) ~= 1 then
			do return var_209_3 end

			var_209_4 = bit.band(var_209_1, 1) == 1
			var_209_5 = var_209_3
		end

		return var_209_5, var_0_9[bit.rshift(var_209_2 - 1, 1) + 1], var_209_4
	else
		local var_209_6 = 0

		;(function()
			for iter_212_0, iter_212_1 in ipairs((var_0[1]:getChapters())) do
				if not iter_212_1:isClear() then
					return
				end

				var_209_6 = var_209_6 + 1
			end

			if not var_0[2]:isAnyChapterUnlocked(true) then
				return
			end

			var_209_6 = var_209_6 + 1

			for iter_212_2, iter_212_3 in ipairs((var_0[2]:getChapters())) do
				if not iter_212_3:isClear() then
					return
				end

				var_209_6 = var_209_6 + 1
			end

			return
		end)()

		local var_209_7

		if var_209_6 > 0 then
			local var_209_8 = var_0_8[bit.rshift(var_209_2 - 1, 1) + 1]

			var_209_7 = {
				{
					BG = "map_" .. var_209_8[1],
					Animator = var_209_8[2]
				},
				{
					BG = "map_" .. var_209_8[3] + var_209_6,
					Animator = var_209_8[4]
				}
			}
		else
			var_209_7 = {
				arg_209_0:GetMapElement(arg_209_1)
			}
		end

		return var_209_7
	end

	return
end

function var_0_0.GetMapElement(arg_213_0, arg_213_1)
	local var_213_0 = arg_213_1:getConfig("bg")
	local var_213_1 = arg_213_1:getConfig("ani_controller")

	if var_213_1 and #var_213_1 > 0 then
		(function()
			local var_214_0 = getProxy(ChapterProxy)

			for iter_214_0, iter_214_1 in ipairs(var_213_1) do
				for iter_214_2, iter_214_3 in ipairs((_.rest(iter_214_1[2], 2))) do
					if string.find(iter_214_3, "^map_") and iter_214_1[1] == var_0_3 then
						local var_214_1 = false

						for iter_214_4, iter_214_5 in ipairs(iter_214_1[2][1]) do
							local var_214_2 = var_214_0:GetChapterItemById(iter_214_5)

							if var_214_2 and var_214_2:isClear() then
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

	local var_213_2 = {
		BG = arg_213_1:getConfig("bg")
	}

	var_213_2.Animator, var_213_2.AnimatorController = arg_213_0:GetMapAnimator(arg_213_1)

	return var_213_2
end

function var_0_0.GetMapAnimator(arg_215_0, arg_215_1)
	local var_215_0 = arg_215_1:getConfig("ani_name")

	if arg_215_1:getConfig("animtor") == 1 and var_215_0 and #var_215_0 > 0 then
		local var_215_1 = arg_215_1:getConfig("ani_controller")

		if var_215_1 and #var_215_1 > 0 then
			(function()
				local var_216_0 = getProxy(ChapterProxy)

				for iter_216_0, iter_216_1 in ipairs(var_215_1) do
					for iter_216_2, iter_216_3 in ipairs((_.rest(iter_216_1[2], 2))) do
						if string.find(iter_216_3, "^effect_") and iter_216_1[1] == var_0_3 then
							local var_216_1 = false

							for iter_216_4, iter_216_5 in ipairs(iter_216_1[2][1]) do
								local var_216_2 = var_216_0:GetChapterItemById(iter_216_5)

								if var_216_2 and var_216_2:isClear() then
									var_216_1 = true

									break
								end
							end

							if not var_216_1 then
								var_215_0 = "map_" .. string.sub(iter_216_3, 8)

								return
							end
						end
					end
				end

				return
			end)()
		end

		return var_215_0, var_215_1
	end

	return
end

function var_0_0.PlayMapTransition(arg_217_0, arg_217_1, arg_217_2, arg_217_3, arg_217_4)
	arg_217_0.mapTransitions = arg_217_0.mapTransitions or {}

	local var_217_0

	local function var_217_1()
		arg_217_0:frozen()
		existCall(arg_217_3, var_217_0)
		var_217_0:SetActive(true)

		local var_218_0 = tf(var_217_0)

		pg.UIMgr.GetInstance():OverlayPanel(var_218_0)
		var_217_0:GetComponent(typeof(Animator)):Play(arg_217_2 and "Sequence" or "Inverted", -1, 0)
		var_218_0:GetComponent("DftAniEvent"):SetEndEvent(function(arg_219_0)
			pg.UIMgr.GetInstance():UnOverlayPanel(var_218_0, arg_217_0._tf)
			existCall(arg_217_4, var_217_0)
			PoolMgr.GetInstance():ReturnPrefab("ui/" .. arg_217_1, arg_217_1, var_217_0)

			arg_217_0.mapTransitions[arg_217_1] = false

			arg_217_0:unfrozen()

			return
		end)

		return
	end

	PoolMgr.GetInstance():GetPrefab("ui/" .. arg_217_1, arg_217_1, true, function(arg_220_0)
		var_217_0 = arg_220_0
		arg_217_0.mapTransitions[arg_217_1] = arg_220_0

		var_217_1()

		return
	end)

	return
end

function var_0_0.DestroyLevelStageView(arg_221_0)
	if arg_221_0.levelStageView then
		arg_221_0.levelStageView:Destroy()

		arg_221_0.levelStageView = nil
	end

	return
end

function var_0_0.displayAmbushInfo(arg_222_0, arg_222_1)
	arg_222_0.levelAmbushView = LevelAmbushView.New(arg_222_0.topPanel, arg_222_0.event, arg_222_0.contextData)

	arg_222_0.levelAmbushView:Load()
	arg_222_0.levelAmbushView:ActionInvoke("SetFuncOnComplete", arg_222_1)

	return
end

function var_0_0.hideAmbushInfo(arg_223_0)
	if arg_223_0.levelAmbushView then
		arg_223_0.levelAmbushView:Destroy()

		arg_223_0.levelAmbushView = nil
	end

	return
end

function var_0_0.doAmbushWarning(arg_224_0, arg_224_1)
	arg_224_0:frozen()

	local function var_224_0()
		arg_224_0.ambushWarning:SetActive(true)

		local var_225_0 = tf(arg_224_0.ambushWarning)

		var_225_0:SetParent(pg.UIMgr.GetInstance().OverlayMain.transform, false)
		var_225_0:SetSiblingIndex(1)

		local var_225_1 = var_225_0:GetComponent("DftAniEvent")

		var_225_1:SetTriggerEvent(function(arg_226_0)
			arg_224_1()

			return
		end)
		var_225_1:SetEndEvent(function(arg_227_0)
			arg_224_0.ambushWarning:SetActive(false)
			arg_224_0:unfrozen()

			return
		end)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_WARNING)
		Timer.New(function()
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_WARNING)

			return
		end, 1, 1):Start()

		return
	end

	if not arg_224_0.ambushWarning then
		PoolMgr.GetInstance():GetUI("ambushwarnui", true, function(arg_229_0)
			arg_229_0:SetActive(true)

			arg_224_0.ambushWarning = arg_229_0

			var_224_0()

			return
		end)
	else
		(function()
			arg_224_0.ambushWarning:SetActive(true)

			local var_225_0 = tf(arg_224_0.ambushWarning)

			var_225_0:SetParent(pg.UIMgr.GetInstance().OverlayMain.transform, false)
			var_225_0:SetSiblingIndex(1)

			local var_225_1 = var_225_0:GetComponent("DftAniEvent")

			var_225_1:SetTriggerEvent(function(arg_226_0)
				arg_224_1()

				return
			end)
			var_225_1:SetEndEvent(function(arg_227_0)
				arg_224_0.ambushWarning:SetActive(false)
				arg_224_0:unfrozen()

				return
			end)
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_WARNING)
			Timer.New(function()
				pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_WARNING)

				return
			end, 1, 1):Start()

			return
		end)()
	end

	return
end

function var_0_0.destroyAmbushWarn(arg_230_0)
	if arg_230_0.ambushWarning then
		PoolMgr.GetInstance():ReturnUI("ambushwarnui", arg_230_0.ambushWarning)

		arg_230_0.ambushWarning = nil
	end

	return
end

function var_0_0.displayStrategyInfo(arg_231_0, arg_231_1)
	arg_231_0.levelStrategyView = LevelStrategyView.New(arg_231_0.topPanel, arg_231_0.event, arg_231_0.contextData)

	arg_231_0.levelStrategyView:Load()
	arg_231_0.levelStrategyView:ActionInvoke("set", arg_231_1)
	arg_231_0.levelStrategyView:ActionInvoke("setCBFunc", function()
		if not arg_231_0.contextData.chapterVO.fleet:canUseStrategy(arg_231_1) then
			return
		end

		local var_232_0 = arg_231_0.contextData.chapterVO.fleet:getNextStgUser(arg_231_1.id)

		if pg.strategy_data_template[arg_231_1.id].type == ChapterConst.StgTypeForm then
			arg_231_0:emit(LevelMediator2.ON_OP, {
				type = ChapterConst.OpStrategy,
				id = var_232_0,
				arg1 = arg_231_1.id
			})
		elseif pg.strategy_data_template[arg_231_1.id].type == ChapterConst.StgTypeConsume then
			arg_231_0:emit(LevelMediator2.ON_OP, {
				type = ChapterConst.OpStrategy,
				id = var_232_0,
				arg1 = arg_231_1.id
			})
		end

		arg_231_0:hideStrategyInfo()

		return
	end, function()
		arg_231_0:hideStrategyInfo()

		return
	end)

	return
end

function var_0_0.hideStrategyInfo(arg_234_0)
	if arg_234_0.levelStrategyView then
		arg_234_0.levelStrategyView:Destroy()

		arg_234_0.levelStrategyView = nil
	end

	return
end

function var_0_0.displayRepairWindow(arg_235_0, arg_235_1)
	local var_235_0 = arg_235_0.contextData.chapterVO
	local var_235_1 = getProxy(ChapterProxy).repairTimes
	local var_235_3, var_235_4, var_235_5 = ChapterConst.GetRepairParams()

	arg_235_0.levelRepairView = LevelRepairView.New(arg_235_0.topPanel, arg_235_0.event, arg_235_0.contextData)

	arg_235_0.levelRepairView:Load()
	arg_235_0.levelRepairView:ActionInvoke("set", getProxy(ChapterProxy).repairTimes, nil, nil, nil)
	arg_235_0.levelRepairView:ActionInvoke("setCBFunc", function()
		if var_235_3 - math.min(var_235_1, var_235_3) == 0 and arg_235_0.player:getTotalGem() < var_235_5 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_rmb"))

			return
		end

		arg_235_0:emit(LevelMediator2.ON_OP, {
			type = ChapterConst.OpRepair,
			id = var_235_0.fleet.id,
			arg1 = arg_235_1.id
		})
		arg_235_0:hideRepairWindow()

		return
	end, function()
		arg_235_0:hideRepairWindow()

		return
	end)

	return
end

function var_0_0.hideRepairWindow(arg_238_0)
	if arg_238_0.levelRepairView then
		arg_238_0.levelRepairView:Destroy()

		arg_238_0.levelRepairView = nil
	end

	return
end

function var_0_0.displayRemasterPanel(arg_239_0, arg_239_1)
	arg_239_0.levelRemasterView:Load()
	arg_239_0.levelRemasterView:ActionInvoke("Show")
	arg_239_0.levelRemasterView:ActionInvoke("set", function(arg_240_0)
		arg_239_0:ShowSelectedMap(arg_240_0)

		return
	end, arg_239_1)

	return
end

function var_0_0.hideRemasterPanel(arg_241_0)
	if arg_241_0.levelRemasterView:isShowing() then
		arg_241_0.levelRemasterView:ActionInvoke("Hide")
	end

	return
end

function var_0_0.initGrid(arg_242_0, arg_242_1)
	if not arg_242_0.contextData.chapterVO then
		return
	end

	arg_242_0:enableLevelCamera()
	setActive(arg_242_0.uiMain, true)

	arg_242_0.levelGrid.localEulerAngles = Vector3(arg_242_0.contextData.chapterVO.theme.angle, 0, 0)
	arg_242_0.grid = LevelGrid.New(arg_242_0.dragLayer)

	arg_242_0.grid:attach(arg_242_0)
	arg_242_0.grid:ExtendItem("shipTpl", arg_242_0.shipTpl)
	arg_242_0.grid:ExtendItem("subTpl", arg_242_0.subTpl)
	arg_242_0.grid:ExtendItem("transportTpl", arg_242_0.transportTpl)
	arg_242_0.grid:ExtendItem("enemyTpl", arg_242_0.enemyTpl)
	arg_242_0.grid:ExtendItem("championTpl", arg_242_0.championTpl)
	arg_242_0.grid:ExtendItem("oniTpl", arg_242_0.oniTpl)
	arg_242_0.grid:ExtendItem("arrowTpl", arg_242_0.arrowTarget)
	arg_242_0.grid:ExtendItem("destinationMarkTpl", arg_242_0.destinationMarkTpl)

	function arg_242_0.grid.onShipStepChange(arg_243_0)
		arg_242_0.levelStageView:updateAmbushRate(arg_243_0)

		return
	end

	arg_242_0.grid:initAll(arg_242_1)

	return
end

function var_0_0.destroyGrid(arg_244_0)
	if arg_244_0.grid then
		arg_244_0.grid:detach()

		arg_244_0.grid = nil

		arg_244_0:disableLevelCamera()
		setActive(arg_244_0.dragLayer, true)
		setActive(arg_244_0.uiMain, false)
	end

	return
end

function var_0_0.doTracking(arg_245_0, arg_245_1)
	arg_245_0:frozen()

	local function var_245_0()
		arg_245_0.radar:SetActive(true)

		local var_246_0 = tf(arg_245_0.radar)

		var_246_0:SetParent(arg_245_0.topPanel, false)
		var_246_0:SetSiblingIndex(1)
		var_246_0:GetComponent("DftAniEvent"):SetEndEvent(function(arg_247_0)
			arg_245_0.radar:SetActive(false)
			arg_245_0:unfrozen()
			arg_245_1()

			return
		end)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_WEIGHANCHOR_SEARCH)

		return
	end

	if not arg_245_0.radar then
		PoolMgr.GetInstance():GetUI("RadarEffectUI", true, function(arg_248_0)
			arg_248_0:SetActive(true)

			arg_245_0.radar = arg_248_0

			var_245_0()

			return
		end)
	else
		(function()
			arg_245_0.radar:SetActive(true)

			local var_246_0 = tf(arg_245_0.radar)

			var_246_0:SetParent(arg_245_0.topPanel, false)
			var_246_0:SetSiblingIndex(1)
			var_246_0:GetComponent("DftAniEvent"):SetEndEvent(function(arg_247_0)
				arg_245_0.radar:SetActive(false)
				arg_245_0:unfrozen()
				arg_245_1()

				return
			end)
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_WEIGHANCHOR_SEARCH)

			return
		end)()
	end

	return
end

function var_0_0.destroyTracking(arg_249_0)
	if arg_249_0.radar then
		PoolMgr.GetInstance():ReturnUI("RadarEffectUI", arg_249_0.radar)

		arg_249_0.radar = nil
	end

	return
end

function var_0_0.doPlayAirStrike(arg_250_0, arg_250_1, arg_250_2, arg_250_3)
	local function var_250_0()
		arg_250_0.playing = true

		arg_250_0:frozen()
		arg_250_0.airStrike:SetActive(true)

		local var_251_0 = tf(arg_250_0.airStrike)

		var_251_0:SetParent(pg.UIMgr.GetInstance().OverlayMain.transform, false)
		var_251_0:SetAsLastSibling()
		setActive(var_251_0:Find("words/be_striked"), arg_250_1 == ChapterConst.SubjectChampion)
		setActive(var_251_0:Find("words/strike_enemy"), arg_250_1 == ChapterConst.SubjectPlayer)
		var_251_0:GetComponent("DftAniEvent"):SetEndEvent(function()
			arg_250_0.playing = false

			SetActive(arg_250_0.airStrike, false)

			if arg_250_3 then
				arg_250_3()
			end

			arg_250_0:unfrozen()

			return
		end)

		if arg_250_2 then
			onButton(arg_250_0, var_251_0, function()
				arg_250_0.playing = false

				SetActive(arg_250_0.airStrike, false)

				if arg_250_3 then
					arg_250_3()
				end

				arg_250_0:unfrozen()

				return
			end, SFX_PANEL)
		else
			removeOnButton(var_251_0)
		end

		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_WARNING)

		return
	end

	if not arg_250_0.airStrike then
		PoolMgr.GetInstance():GetUI("AirStrike", true, function(arg_253_0)
			arg_253_0:SetActive(true)

			arg_250_0.airStrike = arg_253_0

			var_250_0()

			return
		end)
	else
		(function()
			arg_250_0.playing = true

			arg_250_0:frozen()
			arg_250_0.airStrike:SetActive(true)

			local var_251_0 = tf(arg_250_0.airStrike)

			var_251_0:SetParent(pg.UIMgr.GetInstance().OverlayMain.transform, false)
			var_251_0:SetAsLastSibling()
			setActive(var_251_0:Find("words/be_striked"), arg_250_1 == ChapterConst.SubjectChampion)
			setActive(var_251_0:Find("words/strike_enemy"), arg_250_1 == ChapterConst.SubjectPlayer)
			var_251_0:GetComponent("DftAniEvent"):SetEndEvent(function()
				arg_250_0.playing = false

				SetActive(arg_250_0.airStrike, false)

				if arg_250_3 then
					arg_250_3()
				end

				arg_250_0:unfrozen()

				return
			end)

			if arg_250_2 then
				onButton(arg_250_0, var_251_0, function()
					arg_250_0.playing = false

					SetActive(arg_250_0.airStrike, false)

					if arg_250_3 then
						arg_250_3()
					end

					arg_250_0:unfrozen()

					return
				end, SFX_PANEL)
			else
				removeOnButton(var_251_0)
			end

			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_WARNING)

			return
		end)()
	end

	return
end

function var_0_0.destroyAirStrike(arg_254_0)
	if arg_254_0.airStrike then
		arg_254_0.airStrike:GetComponent("DftAniEvent"):SetEndEvent(nil)
		PoolMgr.GetInstance():ReturnUI("AirStrike", arg_254_0.airStrike)

		arg_254_0.airStrike = nil
	end

	return
end

function var_0_0.doPlayAnim(arg_255_0, arg_255_1, arg_255_2, arg_255_3)
	arg_255_0.uiAnims = arg_255_0.uiAnims or {}

	local function var_255_0()
		arg_255_0.playing = true

		arg_255_0:frozen()
		var_0:SetActive(true)

		local var_256_0 = tf(var_0)

		pg.UIMgr.GetInstance():OverlayPanel(var_256_0)

		if arg_255_3 then
			arg_255_3(var_0)
		end

		var_256_0:GetComponent("DftAniEvent"):SetEndEvent(function(arg_257_0)
			arg_255_0.playing = false

			pg.UIMgr.GetInstance():UnOverlayPanel(var_256_0, arg_255_0._tf)

			if arg_255_2 then
				arg_255_2(var_0)
			end

			arg_255_0:unfrozen()

			return
		end)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_WARNING)

		return
	end

	if not arg_255_0.uiAnims[arg_255_1] then
		PoolMgr.GetInstance():GetUI(arg_255_1, true, function(arg_258_0)
			arg_258_0:SetActive(true)

			arg_255_0.uiAnims[arg_255_1] = arg_258_0
			var_0 = arg_255_0.uiAnims[arg_255_1]

			var_255_0()

			return
		end)
	else
		(function()
			arg_255_0.playing = true

			arg_255_0:frozen()
			var_0:SetActive(true)

			local var_256_0 = tf(var_0)

			pg.UIMgr.GetInstance():OverlayPanel(var_256_0)

			if arg_255_3 then
				arg_255_3(var_0)
			end

			var_256_0:GetComponent("DftAniEvent"):SetEndEvent(function(arg_257_0)
				arg_255_0.playing = false

				pg.UIMgr.GetInstance():UnOverlayPanel(var_256_0, arg_255_0._tf)

				if arg_255_2 then
					arg_255_2(var_0)
				end

				arg_255_0:unfrozen()

				return
			end)
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_WARNING)

			return
		end)()
	end

	return
end

function var_0_0.destroyUIAnims(arg_259_0)
	if arg_259_0.uiAnims then
		for iter_259_0, iter_259_1 in pairs(arg_259_0.uiAnims) do
			pg.UIMgr.GetInstance():UnOverlayPanel(tf(iter_259_1), arg_259_0._tf)
			iter_259_1:GetComponent("DftAniEvent"):SetEndEvent(nil)
			PoolMgr.GetInstance():ReturnUI(iter_259_0, iter_259_1)
		end

		arg_259_0.uiAnims = nil
	end

	return
end

function var_0_0.doPlayTorpedo(arg_260_0, arg_260_1)
	local function var_260_0()
		arg_260_0.playing = true

		arg_260_0:frozen()
		arg_260_0.torpetoAni:SetActive(true)

		local var_261_0 = tf(arg_260_0.torpetoAni)

		var_261_0:SetParent(arg_260_0.topPanel, false)
		var_261_0:SetAsLastSibling()
		var_261_0:GetComponent("DftAniEvent"):SetEndEvent(function(arg_262_0)
			arg_260_0.playing = false

			SetActive(arg_260_0.torpetoAni, false)

			if arg_260_1 then
				arg_260_1()
			end

			arg_260_0:unfrozen()

			return
		end)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_WARNING)

		return
	end

	if not arg_260_0.torpetoAni then
		PoolMgr.GetInstance():GetUI("Torpeto", true, function(arg_263_0)
			arg_263_0:SetActive(true)

			arg_260_0.torpetoAni = arg_263_0

			var_260_0()

			return
		end)
	else
		(function()
			arg_260_0.playing = true

			arg_260_0:frozen()
			arg_260_0.torpetoAni:SetActive(true)

			local var_261_0 = tf(arg_260_0.torpetoAni)

			var_261_0:SetParent(arg_260_0.topPanel, false)
			var_261_0:SetAsLastSibling()
			var_261_0:GetComponent("DftAniEvent"):SetEndEvent(function(arg_262_0)
				arg_260_0.playing = false

				SetActive(arg_260_0.torpetoAni, false)

				if arg_260_1 then
					arg_260_1()
				end

				arg_260_0:unfrozen()

				return
			end)
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_WARNING)

			return
		end)()
	end

	return
end

function var_0_0.destroyTorpedo(arg_264_0)
	if arg_264_0.torpetoAni then
		arg_264_0.torpetoAni:GetComponent("DftAniEvent"):SetEndEvent(nil)
		PoolMgr.GetInstance():ReturnUI("Torpeto", arg_264_0.torpetoAni)

		arg_264_0.torpetoAni = nil
	end

	return
end

function var_0_0.doPlayStrikeAnim(arg_265_0, arg_265_1, arg_265_2, arg_265_3)
	arg_265_0.strikeAnims = arg_265_0.strikeAnims or {}

	local var_265_0
	local var_265_1
	local var_265_2

	local function var_265_3()
		if coroutine.status(var_265_2) == "suspended" then
			local var_266_0, var_266_1 = coroutine.resume(var_265_2)

			assert(var_266_0, debug.traceback(var_265_2, var_266_1))
		end

		return
	end

	var_265_2 = coroutine.create(function()
		arg_265_0.playing = true

		arg_265_0:frozen()
		setActive(arg_265_0.strikeAnims[arg_265_2], true)

		local var_267_0 = tf(arg_265_0.strikeAnims[arg_265_2])
		local var_267_1 = findTF(var_267_0, "mask/painting")
		local var_267_2 = findTF(var_267_0, "ship")

		setParent(var_265_0, var_267_1:Find("fitter"), false)
		var_265_1:SetParent(var_267_2)
		setActive(var_267_2, false)
		setActive(findTF(var_267_0, "torpedo"), false)
		var_267_0:SetParent(pg.UIMgr.GetInstance().OverlayMain.transform, false)
		var_267_0:SetAsLastSibling()

		local var_267_3 = var_267_0:GetComponent("DftAniEvent")
		local var_267_4 = var_265_1:GetSkeletonGraphic()

		var_267_3:SetStartEvent(function(arg_268_0)
			var_265_1:SetAction("attack", 0)

			var_267_4.freeze = true

			return
		end)
		var_267_3:SetTriggerEvent(function(arg_269_0)
			var_267_4.freeze = false

			var_265_1:SetActionCallBack(function(arg_270_0)
				if arg_270_0 == "action" then
					-- block empty
				elseif arg_270_0 == "finish" then
					var_267_4.freeze = true
				end

				return
			end)

			return
		end)
		var_267_3:SetEndEvent(function(arg_271_0)
			var_267_4.freeze = false

			var_265_3()

			return
		end)
		onButton(arg_265_0, var_267_0, var_265_3, SFX_CANCEL)
		coroutine.yield()
		retPaintingPrefab(var_267_1, arg_265_1:getPainting())
		var_265_1:SetActionCallBack(nil)

		var_265_1:GetSkeletonGraphic().freeze = false

		var_265_1:Dispose()
		setActive(arg_265_0.strikeAnims[arg_265_2], false)

		arg_265_0.playing = false

		arg_265_0:unfrozen()

		if arg_265_3 then
			arg_265_3()
		end

		return
	end)

	local function var_265_4()
		if arg_265_0.strikeAnims[arg_265_2] and var_265_0 and var_265_1 then
			var_265_3()
		end

		return
	end

	PoolMgr.GetInstance():GetPainting(arg_265_1:getPainting(), true, function(arg_273_0)
		var_265_0 = arg_273_0

		ShipExpressionHelper.SetExpression(var_265_0, arg_265_1:getPainting())
		var_265_4()

		return
	end)

	var_265_1 = SpineAnimChar.New()

	var_265_1:SetPaint(arg_265_1:getPrefab())
	var_265_1:Load(true, function(arg_274_0)
		var_265_1:SetLocalScale(Vector3.one)
		var_265_4()

		return
	end)

	if not arg_265_0.strikeAnims[arg_265_2] then
		PoolMgr.GetInstance():GetUI(arg_265_2, true, function(arg_275_0)
			arg_265_0.strikeAnims[arg_265_2] = arg_275_0

			var_265_4()

			return
		end)
	end

	return
end

function var_0_0.destroyStrikeAnim(arg_276_0)
	if arg_276_0.strikeAnims then
		for iter_276_0, iter_276_1 in pairs(arg_276_0.strikeAnims) do
			iter_276_1:GetComponent("DftAniEvent"):SetEndEvent(nil)
			PoolMgr.GetInstance():ReturnUI(iter_276_0, iter_276_1)
		end

		arg_276_0.strikeAnims = nil
	end

	return
end

function var_0_0.doPlayEnemyAnim(arg_277_0, arg_277_1, arg_277_2, arg_277_3)
	arg_277_0.strikeAnims = arg_277_0.strikeAnims or {}

	local var_277_0
	local var_277_1

	local function var_277_2()
		if coroutine.status(var_277_1) == "suspended" then
			local var_278_0, var_278_1 = coroutine.resume(var_277_1)

			assert(var_278_0, debug.traceback(var_277_1, var_278_1))
		end

		return
	end

	var_277_1 = coroutine.create(function()
		arg_277_0.playing = true

		arg_277_0:frozen()
		setActive(arg_277_0.strikeAnims[arg_277_2], true)

		local var_279_0 = tf(arg_277_0.strikeAnims[arg_277_2])
		local var_279_1 = findTF(var_279_0, "ship")

		var_277_0:SetParent(var_279_1)
		setActive(var_279_1, false)
		setActive(findTF(var_279_0, "torpedo"), false)
		var_279_0:SetParent(pg.UIMgr.GetInstance().OverlayMain.transform, false)
		var_279_0:SetAsLastSibling()

		local var_279_2 = var_279_0:GetComponent("DftAniEvent")
		local var_279_3 = var_277_0:GetSkeletonGraphic()

		var_279_2:SetStartEvent(function(arg_280_0)
			var_277_0:SetAction("attack", 0)

			var_279_3.freeze = true

			return
		end)
		var_279_2:SetTriggerEvent(function(arg_281_0)
			var_279_3.freeze = false

			var_277_0:SetActionCallBack(function(arg_282_0)
				if arg_282_0 == "action" then
					-- block empty
				elseif arg_282_0 == "finish" then
					var_279_3.freeze = true
				end

				return
			end)

			return
		end)
		var_279_2:SetEndEvent(function(arg_283_0)
			var_279_3.freeze = false

			var_277_2()

			return
		end)
		onButton(arg_277_0, var_279_0, var_277_2, SFX_CANCEL)
		coroutine.yield()
		var_277_0:SetActionCallBack(nil)

		var_277_0:GetSkeletonGraphic().freeze = false

		var_277_0:Dispose()
		setActive(arg_277_0.strikeAnims[arg_277_2], false)

		arg_277_0.playing = false

		arg_277_0:unfrozen()

		if arg_277_3 then
			arg_277_3()
		end

		return
	end)

	local function var_277_3()
		if arg_277_0.strikeAnims[arg_277_2] and var_277_0 then
			var_277_2()
		end

		return
	end

	var_277_0 = SpineAnimChar.New()

	;(nil):SetPaint(arg_277_1:getPrefab())
	var_277_0:Load(true, function(arg_285_0)
		arg_285_0:SetLocalScale(Vector3.one)
		var_277_3()

		return
	end)

	if not arg_277_0.strikeAnims[arg_277_2] then
		PoolMgr.GetInstance():GetUI(arg_277_2, true, function(arg_286_0)
			arg_277_0.strikeAnims[arg_277_2] = arg_286_0

			var_277_3()

			return
		end)
	end

	return
end

function var_0_0.doPlayCommander(arg_287_0, arg_287_1, arg_287_2)
	arg_287_0:frozen()
	setActive(arg_287_0.commanderTinkle, true)

	local var_287_0 = arg_287_1:getSkills()
	local var_287_1 = #var_287_0 > 0 and var_287_0[1]:getConfig("name") or ""

	setText(arg_287_0.commanderTinkle:Find("name"), var_287_1)
	setImageSprite(arg_287_0.commanderTinkle:Find("icon"), GetSpriteFromAtlas("commanderhrz/" .. arg_287_1:getConfig("painting"), ""))

	local var_287_2 = arg_287_0.commanderTinkle:GetComponent(typeof(CanvasGroup))

	arg_287_0.commanderTinkle:GetComponent(typeof(CanvasGroup)).alpha = 0

	local var_287_3 = Vector2(248, 237)

	LeanTween.value(go(arg_287_0.commanderTinkle), 0, 1, 0.5):setOnUpdate(System.Action_float(function(arg_288_0)
		arg_287_0.commanderTinkle.localPosition.x = var_287_3.x + 28 * (1 - arg_288_0)
		arg_287_0.commanderTinkle.localPosition = arg_287_0.commanderTinkle.localPosition
		var_287_2.alpha = arg_288_0

		return
	end)):setEase(LeanTweenType.easeOutSine)
	LeanTween.value(go(arg_287_0.commanderTinkle), 0, 1, 0.3):setDelay(0.7):setOnUpdate(System.Action_float(function(arg_289_0)
		arg_287_0.commanderTinkle.localPosition.x = var_287_3.x + 100 * arg_289_0
		arg_287_0.commanderTinkle.localPosition = arg_287_0.commanderTinkle.localPosition
		var_287_2.alpha = 1 - arg_289_0

		return
	end)):setOnComplete(System.Action(function()
		if arg_287_2 then
			arg_287_2()
		end

		arg_287_0:unfrozen()

		return
	end))

	return
end

function var_0_0.strikeEnemy(arg_291_0, arg_291_1, arg_291_2, arg_291_3)
	local var_291_0 = arg_291_0.grid:shakeCell(arg_291_1)

	if not var_291_0 then
		arg_291_3()

		return
	end

	arg_291_0:easeDamage(var_291_0, arg_291_2, function()
		arg_291_3()

		return
	end)

	return
end

function var_0_0.easeDamage(arg_293_0, arg_293_1, arg_293_2, arg_293_3)
	arg_293_0:frozen()

	local var_293_0 = tf(arg_293_0:GetDamageText())

	var_293_0.position = arg_293_0.uiCam:ScreenToWorldPoint((arg_293_0.levelCam:WorldToScreenPoint(arg_293_1.position)))

	local var_293_1 = var_293_0.localPosition

	var_293_0.localPosition.y = var_293_0.localPosition.y + 40
	var_293_0.localPosition.z = 0

	setText(var_293_0, arg_293_2)

	var_293_0.localPosition = var_293_0.localPosition

	LeanTween.value(go(var_293_0), 0, 1, 1):setOnUpdate(System.Action_float(function(arg_294_0)
		var_293_0.localPosition.y = var_293_1.y + 60 * arg_294_0
		var_293_0.localPosition = var_293_0.localPosition

		setTextAlpha(var_293_0, 1 - arg_294_0)

		return
	end)):setOnComplete(System.Action(function()
		arg_293_0:ReturnDamageText(var_293_0)
		arg_293_0:unfrozen()

		if arg_293_3 then
			arg_293_3()
		end

		return
	end))

	return
end

function var_0_0.easeAvoid(arg_296_0, arg_296_1, arg_296_2)
	arg_296_0:frozen()

	arg_296_0.avoidText.position = arg_296_0.uiCam:ScreenToWorldPoint((arg_296_0.levelCam:WorldToScreenPoint(arg_296_1)))

	local var_296_0 = arg_296_0.avoidText.localPosition

	arg_296_0.avoidText.localPosition.z = 0
	arg_296_0.avoidText.localPosition = arg_296_0.avoidText.localPosition

	setActive(arg_296_0.avoidText, true)

	local var_296_1 = arg_296_0.avoidText:Find("avoid")

	LeanTween.value(go(arg_296_0.avoidText), 0, 1, 1):setOnUpdate(System.Action_float(function(arg_297_0)
		arg_296_0.avoidText.localPosition.y = var_296_0.y + 100 * arg_297_0
		arg_296_0.avoidText.localPosition = arg_296_0.avoidText.localPosition

		setImageAlpha(arg_296_0.avoidText, 1 - arg_297_0)
		setImageAlpha(var_296_1, 1 - arg_297_0)

		return
	end)):setOnComplete(System.Action(function()
		setActive(arg_296_0.avoidText, false)
		arg_296_0:unfrozen()

		if arg_296_2 then
			arg_296_2()
		end

		return
	end))

	return
end

function var_0_0.GetDamageText(arg_299_0)
	local var_299_0 = table.remove(arg_299_0.damageTextPool)

	if not var_299_0 then
		var_299_0 = Instantiate(arg_299_0.damageTextTemplate)

		setParent(var_299_0, tf(arg_299_0.damageTextTemplate).parent)
		tf(var_299_0):SetSiblingIndex(tf(arg_299_0.damageTextTemplate):GetSiblingIndex() + 1)
	end

	table.insert(arg_299_0.damageTextActive, var_299_0)
	setActive(var_299_0, true)

	return var_299_0
end

function var_0_0.ReturnDamageText(arg_300_0, arg_300_1)
	assert(arg_300_1)

	if not arg_300_1 then
		return
	end

	arg_300_1 = go(arg_300_1)

	table.removebyvalue(arg_300_0.damageTextActive, arg_300_1)
	table.insert(arg_300_0.damageTextPool, arg_300_1)
	setActive(arg_300_1, false)

	return
end

function var_0_0.resetLevelGrid(arg_301_0)
	arg_301_0.dragLayer.localPosition = Vector3.zero

	return
end

function var_0_0.ShowCurtains(arg_302_0, arg_302_1)
	setActive(arg_302_0.curtain, arg_302_1)

	return
end

function var_0_0.frozen(arg_303_0)
	arg_303_0.frozenCount = arg_303_0.frozenCount + 1
	arg_303_0.canvasGroup.blocksRaycasts = arg_303_0.frozenCount == 0

	if arg_303_0.frozenCount == 0 and arg_303_0.frozenCount ~= 0 then
		arg_303_0:emit(LevelUIConst.ON_FROZEN)
	end

	return
end

function var_0_0.unfrozen(arg_304_0, arg_304_1)
	if arg_304_0.exited then
		return
	end

	local var_304_0 = arg_304_0.frozenCount

	if arg_304_1 == -1 then
		local var_304_1 = arg_304_0.frozenCount or arg_304_1 or 1

		arg_304_0.frozenCount = arg_304_0.frozenCount - var_304_1
		arg_304_0.canvasGroup.blocksRaycasts = arg_304_0.frozenCount == 0

		if var_304_0 ~= 0 and arg_304_0.frozenCount == 0 then
			arg_304_0:emit(LevelUIConst.ON_UNFROZEN)
		end

		return
	end
end

function var_0_0.isfrozen(arg_305_0)
	return arg_305_0.frozenCount > 0
end

function var_0_0.enableLevelCamera(arg_306_0)
	arg_306_0.levelCamIndices = math.max(arg_306_0.levelCamIndices - 1, 0)

	if arg_306_0.levelCamIndices == 0 then
		arg_306_0.levelCam.enabled = true

		pg.LayerWeightMgr.GetInstance():CreateRefreshHandler()
	end

	return
end

function var_0_0.disableLevelCamera(arg_307_0)
	arg_307_0.levelCamIndices = arg_307_0.levelCamIndices + 1

	if arg_307_0.levelCamIndices > 0 then
		arg_307_0.levelCam.enabled = false

		pg.LayerWeightMgr.GetInstance():CreateRefreshHandler()
	end

	return
end

function var_0_0.RecordTween(arg_308_0, arg_308_1, arg_308_2)
	arg_308_0.tweens[arg_308_1] = arg_308_2

	return
end

function var_0_0.DeleteTween(arg_309_0, arg_309_1)
	if arg_309_0.tweens[arg_309_1] then
		LeanTween.cancel(arg_309_0.tweens[arg_309_1])

		arg_309_0.tweens[arg_309_1] = nil
	end

	return
end

function var_0_0.openCommanderPanel(arg_310_0, arg_310_1, arg_310_2, arg_310_3)
	local var_310_0 = arg_310_2.id

	arg_310_0.levelCMDFormationView:setCallback(function(arg_311_0)
		if not arg_310_3 then
			if arg_311_0.type == LevelUIConst.COMMANDER_OP_SHOW_SKILL then
				arg_310_0:emit(LevelMediator2.ON_COMMANDER_SKILL, arg_311_0.skill)
			elseif arg_311_0.type == LevelUIConst.COMMANDER_OP_ADD then
				arg_310_0.contextData.commanderSelected = {
					chapterId = var_310_0,
					fleetId = arg_310_1.id
				}

				arg_310_0:emit(LevelMediator2.ON_SELECT_COMMANDER, arg_311_0.pos, arg_310_1.id, arg_310_2)
				arg_310_0:closeCommanderPanel()
			else
				arg_310_0:emit(LevelMediator2.ON_COMMANDER_OP, {
					FleetType = LevelUIConst.FLEET_TYPE_SELECT,
					data = arg_311_0,
					fleetId = arg_310_1.id,
					chapterId = var_310_0
				}, arg_310_2)
			end
		elseif arg_311_0.type == LevelUIConst.COMMANDER_OP_SHOW_SKILL then
			arg_310_0:emit(LevelMediator2.ON_COMMANDER_SKILL, arg_311_0.skill)
		elseif arg_311_0.type == LevelUIConst.COMMANDER_OP_ADD then
			arg_310_0.contextData.eliteCommanderSelected = {
				index = arg_310_3,
				pos = arg_311_0.pos,
				chapterId = var_310_0
			}

			arg_310_0:emit(LevelMediator2.ON_SELECT_ELITE_COMMANDER, arg_310_3, arg_311_0.pos, arg_310_2)
			arg_310_0:closeCommanderPanel()
		else
			arg_310_0:emit(LevelMediator2.ON_COMMANDER_OP, {
				FleetType = LevelUIConst.FLEET_TYPE_EDIT,
				data = arg_311_0,
				index = arg_310_3,
				chapterId = var_310_0
			}, arg_310_2)
		end

		return
	end)
	arg_310_0.levelCMDFormationView:Load()
	arg_310_0.levelCMDFormationView:ActionInvoke("update", arg_310_1, arg_310_0.commanderPrefabs)
	arg_310_0.levelCMDFormationView:ActionInvoke("Show")

	return
end

function var_0_0.updateCommanderPrefab(arg_312_0)
	if arg_312_0.levelCMDFormationView:isShowing() then
		arg_312_0.levelCMDFormationView:ActionInvoke("updatePrefabs", arg_312_0.commanderPrefabs)
	end

	return
end

function var_0_0.closeCommanderPanel(arg_313_0)
	arg_313_0.levelCMDFormationView:ActionInvoke("Hide")

	return
end

function var_0_0.destroyCommanderPanel(arg_314_0)
	arg_314_0.levelCMDFormationView:Destroy()

	arg_314_0.levelCMDFormationView = nil

	return
end

function var_0_0.setSpecialOperationTickets(arg_315_0, arg_315_1)
	arg_315_0.spTickets = arg_315_1

	return
end

function var_0_0.HandleShowMsgBox(arg_316_0, arg_316_1)
	pg.MsgboxMgr.GetInstance():ShowMsgBox(arg_316_1)

	return
end

function var_0_0.updatePoisonAreaTip(arg_317_0)
	local var_317_0 = arg_317_0.contextData.chapterVO
	local var_317_1 = (function(arg_318_0)
		local var_318_0 = pg.map_event_list[var_317_0.id] or {}
		local var_318_1 = var_317_0:isLoop() and (var_318_0.event_list_loop or {}) or var_318_0.event_list or {}

		for iter_318_0, iter_318_1 in ipairs(var_318_1) do
			if pg.map_event_template[iter_318_1].c_type == arg_318_0 then
				table.insert({}, pg.map_event_template[iter_318_1])
			end
		end

		return {}
	end)(ChapterConst.EvtType_Poison)

	if var_317_1 then
		for iter_317_0, iter_317_1 in ipairs(var_317_1) do
			if iter_317_1.round_gametip ~= nil and iter_317_1.round_gametip ~= "" and arg_317_0.contextData.chapterVO:getRoundNum() == iter_317_1.round_gametip[1] then
				pg.TipsMgr.GetInstance():ShowTips(i18n(iter_317_1.round_gametip[2]))
			end
		end
	end

	return
end

function var_0_0.updateVoteBookBtn(arg_319_0)
	setActive(arg_319_0._voteBookBtn, false)

	return
end

function var_0_0.RecordLastMapOnExit(arg_320_0)
	local var_320_0 = getProxy(ChapterProxy)

	if var_320_0 and not arg_320_0.contextData.noRecord then
		if not arg_320_0.contextData.map then
			return
		end

		if arg_320_0.contextData.map:NeedRecordMap() then
			var_320_0:recordLastMap(ChapterProxy.LAST_MAP, arg_320_0.contextData.map.id)
		end

		if arg_320_0.contextData.map:isActivity() and not arg_320_0.contextData.map:isActExtra() then
			var_320_0:recordLastMap(ChapterProxy.LAST_MAP_FOR_ACTIVITY, arg_320_0.contextData.map.id)
		end
	end

	return
end

function var_0_0.IsActShopActive(arg_321_0)
	if arg_321_0.contextData.map then
		local var_321_0 = getProxy(ActivityProxy):getActivityById(arg_321_0.contextData.map:getConfig("on_activity")) or nil
		local var_321_1 = var_321_0 and not var_321_0:isEnd() and var_321_0:GetConfigClientSetting("PTID")
		local var_321_2 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_LOTTERY)

		if var_321_2 and not var_321_2:isEnd() and var_321_2:getConfig("config_client").resId == var_321_1 then
			return true
		end

		if _.detect(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_SHOP), function(arg_322_0)
			return not arg_322_0:isEnd() and arg_322_0:getConfig("config_client").pt_id == var_321_1
		end) then
			return true
		end

		return
	end
end

function var_0_0.willExit(arg_323_0)
	arg_323_0:ClearMapTransitions()
	arg_323_0.loader:Clear()

	if arg_323_0.contextData.chapterVO then
		arg_323_0:UnOverlayPanel(arg_323_0.topPanel, arg_323_0._tf)
	end

	if arg_323_0.levelFleetView and arg_323_0.levelFleetView.selectIds then
		arg_323_0.contextData.selectedFleetIDs = {}

		for iter_323_0, iter_323_1 in pairs(arg_323_0.levelFleetView.selectIds) do
			for iter_323_2, iter_323_3 in pairs(iter_323_1) do
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
	PoolMgr.GetInstance():DestroyPrefab("chapter/cell_quad_mark", "")
	PoolMgr.GetInstance():DestroyPrefab("chapter/cell_quad", "")
	PoolMgr.GetInstance():DestroyPrefab("chapter/cell", "")
	PoolMgr.GetInstance():DestroyPrefab("chapter/plane", "")

	for iter_323_4, iter_323_5 in pairs(arg_323_0.mbDict) do
		iter_323_5:Destroy()
	end

	arg_323_0.mbDict = nil

	for iter_323_6, iter_323_7 in pairs(arg_323_0.tweens) do
		LeanTween.cancel(iter_323_7)
	end

	arg_323_0.tweens = nil

	if arg_323_0.cloudTimer then
		_.each(arg_323_0.cloudTimer, function(arg_324_0)
			LeanTween.cancel(arg_324_0)

			return
		end)

		arg_323_0.cloudTimer = nil
	end

	if arg_323_0.newChapterCDTimer then
		arg_323_0.newChapterCDTimer:Stop()

		arg_323_0.newChapterCDTimer = nil
	end

	for iter_323_8, iter_323_9 in ipairs(arg_323_0.damageTextActive) do
		LeanTween.cancel(iter_323_9)
	end

	LeanTween.cancel(go(arg_323_0.avoidText))

	arg_323_0.map.localScale = Vector3.one
	arg_323_0.map.pivot = Vector2(0.5, 0.5)
	arg_323_0.float.localScale = Vector3.one
	arg_323_0.float.pivot = Vector2(0.5, 0.5)

	for iter_323_10, iter_323_11 in ipairs(arg_323_0.mapTFs) do
		clearImageSprite(iter_323_11)
	end

	_.each(arg_323_0.cloudRTFs, function(arg_325_0)
		clearImageSprite(arg_325_0)

		return
	end)
	Destroy(arg_323_0.enemyTpl)
	arg_323_0:RecordLastMapOnExit()
	arg_323_0.levelRemasterView:Destroy()

	return
end

return var_0_0
