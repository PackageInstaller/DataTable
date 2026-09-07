local LevelScene = class("LevelScene", import("..base.BaseUI"))
local var_0_1 = 0.5
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3

function LevelScene:forceGC()
	return true
end

function LevelScene:getUIName()
	return "LevelMainScene"
end

function LevelScene:ResUISettings()
	return {
		groupDelta = 1,
		showType = PlayerResUI.TYPE_ALL
	}
end

function LevelScene:getBGM()
	for iter_4_0, iter_4_1 in ipairs({
		(function()
			return checkExist(self.contextData.chapterVO, {
				"getConfig",
				{
					"bgm"
				}
			}) or ""
		end)(),
		(function()
			if not self.contextData.map then
				return
			end

			local var_6_0 = self.contextData.map:getConfig("ani_controller")
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

			return checkExist(self.contextData.map, {
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

	return LevelScene.super.getBGM(self)
end

LevelScene.optionsPath = {
	"top/top_chapter/option"
}

function LevelScene:preload(arg_7_1)
	if self.contextData.mapIdx and self.contextData.chapterId then
		local var_7_0 = getProxy(ChapterProxy):getChapterById(self.contextData.chapterId)

		if var_7_0:getConfig("map") == self.contextData.mapIdx then
			self.contextData.chapterVO = var_7_0

			if var_7_0.active then
				assert(not self.contextData.openChapterId or self.contextData.openChapterId == self.contextData.chapterId)

				self.contextData.openChapterId = nil
			end
		end
	end

	local var_7_1, var_7_2 = self:GetInitializeMap()

	if self.contextData.entranceStatus == nil then
		self.contextData.entranceStatus = not var_7_2
	end

	if not self.contextData.entranceStatus then
		self:PreloadLevelMainUI(var_7_1, arg_7_1)
	else
		arg_7_1()
	end

	return
end

function LevelScene:GetInitializeMap()
	local var_8_0 = (function()
		if self.contextData.chapterVO and self.contextData.chapterVO.active then
			return self.contextData.chapterVO:getConfig("map")
		end

		if self.contextData.mapIdx then
			return self.contextData.mapIdx
		end

		local var_9_0

		if self.contextData.targetChapter and self.contextData.targetMap then
			self.contextData.openChapterId = self.contextData.targetChapter
			var_9_0 = self.contextData.targetMap.id
			self.contextData.targetChapter = nil
			self.contextData.targetMap = nil
		elseif self.contextData.eliteDefault then
			local var_9_1 = getProxy(ChapterProxy):getUseableMaxEliteMap()

			var_9_0 = var_9_1 and var_9_1.id or nil
			self.contextData.eliteDefault = nil
		end

		return var_9_0
	end)()
	local var_8_1 = var_8_0 and getProxy(ChapterProxy):getMapById(var_8_0)

	if var_8_1 then
		local var_8_2, var_8_3 = var_8_1:isUnlock()

		if not var_8_2 then
			pg.TipsMgr.GetInstance():ShowTips(var_8_3)

			var_8_0 = getProxy(ChapterProxy):getLastUnlockMap().id
			self.contextData.mapIdx = var_8_0
		end
	else
		var_8_0 = nil
	end

	local var_8_4 = var_8_0 or getProxy(ChapterProxy):GetLastNormalMap()
	local var_8_5 = tobool(var_8_0)
end

function LevelScene:init()
	self:initData()
	self:initUI()
	self:initEvents()
	self:updateClouds()

	return
end

function LevelScene:initData()
	self.tweens = {}
	self.mapWidth, self.mapHeight = self._tf.rect.size.x, self._tf.rect.size.y
	self.levelCamIndices = 1
	self.frozenCount = 0
	self.currentBG = nil
	self.mbDict = {}
	self.mapGroup = {}
	self.contextData.huntingRangeVisibility = self.contextData.huntingRangeVisibility or 2

	return
end

function LevelScene:initUI()
	self.topPanel = self._tf:Find("top")
	self.canvasGroup = self.topPanel:GetComponent("CanvasGroup")
	self.canvasGroup.blocksRaycasts = not self.canvasGroup.blocksRaycasts
	self.canvasGroup.blocksRaycasts = not self.canvasGroup.blocksRaycasts
	self.entranceLayer = self._tf:Find("entrance")
	self.ptBonus = EventPtBonus.New(self.entranceLayer:Find("btns/btn_task/bonusPt"))
	self.entranceBg = self._tf:Find("entrance_bg")
	self.topChapter = self.topPanel:Find("top_chapter")

	setActive(self.topChapter:Find("title_chapter"), false)
	setActive(self.topChapter:Find("type_chapter"), false)
	setActive(self.topChapter:Find("type_escort"), false)
	setActive(self.topChapter:Find("type_skirmish"), false)

	self.chapterName = self.topChapter:Find("title_chapter/name")
	self.chapterNoTitle = self.topChapter:Find("title_chapter/chapter")
	self.resChapter = self.topChapter:Find("resources")

	setActive(self.topChapter, true)

	self._voteBookBtn = self.topChapter:Find("vote_book")
	self.leftChapter = self._tf:Find("main/left_chapter")

	setActive(self.leftChapter, true)

	self.leftCanvasGroup = self.leftChapter:GetComponent(typeof(CanvasGroup))
	self.btnPrev = self.leftChapter:Find("btn_prev")
	self.btnPrevCol = self.leftChapter:Find("btn_prev/prev_image")
	self.eliteBtn = self.leftChapter:Find("buttons/btn_elite")
	self.normalBtn = self.leftChapter:Find("buttons/btn_normal")
	self.actNormalBtn = self.leftChapter:Find("buttons/btn_act_normal")
	self.actEliteBtn = self.leftChapter:Find("buttons/btn_act_elite")
	self.actExtraBtn = self.leftChapter:Find("buttons/btn_act_extra")
	self.actExtraBtnAnim = self.actExtraBtn:Find("usm")
	self.remasterBtn = self.leftChapter:Find("buttons/btn_remaster")
	self.escortBar = self.leftChapter:Find("escort_bar")
	self.eliteQuota = self.leftChapter:Find("elite_quota")
	self.skirmishBar = self.leftChapter:Find("left_times")
	self.mainLayer = self._tf:Find("main")

	setActive(self.mainLayer:Find("title_chapter_lines"), false)

	self.rightChapter = self._tf:Find("main/right_chapter")
	self.rightCanvasGroup = self.rightChapter:GetComponent(typeof(CanvasGroup))
	self.eventContainer = self.rightChapter:Find("event_btns/event_container")
	self.btnSpecial = self.eventContainer:Find("btn_task")
	self.challengeBtn = self.eventContainer:Find("btn_challenge")
	self.dailyBtn = self.eventContainer:Find("btn_daily")
	self.militaryExerciseBtn = self.eventContainer:Find("btn_pvp")
	self.activityBtn = self.rightChapter:Find("event_btns/activity_btn")
	self.ptTotal = self.rightChapter:Find("event_btns/pt_text")
	self.ticketTxt = self.rightChapter:Find("event_btns/tickets/Text")
	self.remasterAwardBtn = self.rightChapter:Find("btn_remaster_award")
	self.btnNext = self.rightChapter:Find("btn_next")
	self.btnNextCol = self.rightChapter:Find("btn_next/next_image")
	self.countDown = self.rightChapter:Find("event_btns/count_down")

	setActive(self.rightChapter:Find("event_btns/BottomList"), true)

	self.actExchangeShopBtn = self.rightChapter:Find("event_btns/BottomList/btn_exchange")
	self.actAtelierBuffBtn = self.rightChapter:Find("event_btns/BottomList/btn_control_center")
	self.actAtelierYumiaBuffBtn = self.rightChapter:Find("event_btns/BottomList/btn_yumia_buff")
	self.actExtraRank = self.rightChapter:Find("event_btns/BottomList/act_extra_rank")

	setActive(self.rightChapter, true)

	self.damageTextTemplate = go(self.topPanel:Find("damage"))

	setActive(self.damageTextTemplate, false)

	self.damageTextPool = {
		self.damageTextTemplate
	}
	self.damageTextActive = {}
	self.mapHelpBtn = self.topPanel:Find("help_button")
	self.avoidText = self.topPanel:Find("text_avoid")
	self.commanderTinkle = self.topPanel:Find("neko_tinkle")

	setActive(self.commanderTinkle, false)

	self.spResult = self.topPanel:Find("sp_result")

	setActive(self.spResult, false)

	self.helpPage = self.topPanel:Find("help_page")
	self.helpImage = self.helpPage:Find("icon")

	setActive(self.helpPage, false)

	self.curtain = self.topPanel:Find("curtain")

	setActive(self.curtain, false)

	self.map = self._tf:Find("maps")
	self.mapTFs = {
		self._tf:Find("maps/map1"),
		self._tf:Find("maps/map2")
	}

	for iter_12_0, iter_12_1 in ipairs(self.mapTFs) do
		iter_12_1:GetComponent(typeof(Image)).enabled = false
	end

	self.UIFXList = self._tf:Find("maps/UI_FX_list")

	for iter_12_2, iter_12_3 in ipairs((self.UIFXList:GetComponentsInChildren(typeof(Renderer)):ToTable())) do
		iter_12_3.sortingOrder = -1
	end

	self.rtRightPanel = self._tf:Find("entrance/enters/right_panel")
	self.actBtnTpl = self.rtRightPanel:Find("content/tpl")

	local var_12_0 = pg.UIMgr.GetInstance()

	self.levelCam = var_12_0.levelCamera:GetComponent(typeof(Camera))
	self.uiMain = var_12_0.LevelMain

	setActive(self.uiMain, false)

	self.uiCam = var_12_0.uiCamera:GetComponent(typeof(Camera))
	self.levelGrid = self.uiMain:Find("LevelGrid")

	setActive(self.levelGrid, true)

	self.dragLayer = self.levelGrid:Find("DragLayer")
	self.float = self._tf:Find("float")
	self.clouds = self.float:Find("clouds")

	setActive(self.clouds, true)
	setActive(self.float:Find("levels"), false)

	self.resources = self._tf:Find("resources")
	self.arrowTarget = self.resources:Find("Tpl_Arrow_Target")
	self.destinationMarkTpl = self.resources:Find("Tpl_Destination_Mark")
	self.championTpl = self.resources:Find("Tpl_Champion")
	self.deadTpl = self.resources:Find("Tpl_Dead")
	self.enemyTpl = self.resources:Find("Tpl_Enemy")
	self.oniTpl = self.resources:Find("Tpl_Oni")
	self.shipTpl = self.resources:Find("Tpl_Ship")
	self.subTpl = self.resources:Find("Tpl_Sub")
	self.transportTpl = self.resources:Find("Tpl_Transport")

	setText(tf(self.enemyTpl):Find("fighting/Text"), i18n("ui_word_levelui2_inevent"))
	self:HideBtns()
	setAnchoredPosition(self.topChapter, {
		y = 0
	})
	setAnchoredPosition(self.leftChapter, {
		x = 0
	})
	setAnchoredPosition(self.rightChapter, {
		x = 0
	})

	self.bubbleMsgBoxes = {}
	self.loader = AutoLoader.New()
	self.levelFleetView = LevelFleetView.New(self.topPanel, self.event, self.contextData)
	self.levelInfoView = LevelInfoView.New(self.topPanel, self.event, self.contextData)

	self.levelInfoView:RegisterView(self)
	self.levelFleetView:RegisterView(self)
	self:buildCommanderPanel()

	self.levelRemasterView = LevelRemasterView.New(self.topPanel, self.event, self.contextData)
	self.chapterAutoDetailPanel = ChapterAutoDetailPanel.New(self.topPanel, self.event, self.contextData)

	self.chapterAutoDetailPanel:RegisterView(self)
	self:SwitchMapBuilder(MapBuilder.TYPENORMAL)

	return
end

function LevelScene:initEvents()
	self:bind(LevelUIConst.OPEN_COMMANDER_PANEL, function(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
		self:openCommanderPanel(arg_14_1, arg_14_2, arg_14_3)

		return
	end)
	self:bind(LevelUIConst.HANDLE_SHOW_MSG_BOX, function(arg_15_0, arg_15_1)
		self:HandleShowMsgBox(arg_15_1)

		return
	end)
	self:bind(LevelUIConst.DO_AMBUSH_WARNING, function(arg_16_0, arg_16_1)
		self:doAmbushWarning(arg_16_1)

		return
	end)
	self:bind(LevelUIConst.DISPLAY_AMBUSH_INFO, function(arg_17_0, arg_17_1)
		self:displayAmbushInfo(arg_17_1)

		return
	end)
	self:bind(LevelUIConst.DISPLAY_STRATEGY_INFO, function(arg_18_0, arg_18_1)
		self:displayStrategyInfo(arg_18_1)

		return
	end)
	self:bind(LevelUIConst.FROZEN, function(arg_19_0)
		self:frozen()

		return
	end)
	self:bind(LevelUIConst.UN_FROZEN, function(arg_20_0)
		self:unfrozen()

		return
	end)
	self:bind(LevelUIConst.DO_TRACKING, function(arg_21_0, arg_21_1)
		self:doTracking(arg_21_1)

		return
	end)
	self:bind(LevelUIConst.SWITCH_TO_MAP, function()
		if self:isfrozen() then
			return
		end

		self:switchToMap()

		return
	end)
	self:bind(LevelUIConst.DISPLAY_REPAIR_WINDOW, function(arg_23_0, arg_23_1)
		self:displayRepairWindow(arg_23_1)

		return
	end)
	self:bind(LevelUIConst.DO_PLAY_ANIM, function(arg_24_0, arg_24_1)
		self:doPlayAnim(arg_24_1.name, arg_24_1.callback, arg_24_1.onStart)

		return
	end)
	self:bind(LevelUIConst.HIDE_FLEET_SELECT, function()
		self:hideFleetSelect()

		return
	end)
	self:bind(LevelUIConst.HIDE_FLEET_EDIT, function(arg_26_0)
		self:hideFleetEdit()

		return
	end)
	self:bind(LevelUIConst.ADD_MSG_QUEUE, function(arg_27_0, arg_27_1)
		self:addbubbleMsgBox(arg_27_1)

		return
	end)
	self:bind(LevelUIConst.SET_MAP, function(arg_28_0, arg_28_1)
		self:setMap(arg_28_1)

		return
	end)

	return
end

function LevelScene:onZeroHourRefresh()
	if self.levelInfoView:isShowing() then
		self.levelInfoView:RefreshChapterAutoPanel()
	end

	if self.levelInfoSPView and self.levelInfoSPView:isShowing() then
		self.levelInfoView:RefreshChapterAutoPanel()
	end

	return
end

function LevelScene:addbubbleMsgBox(arg_30_1)
	table.insert(self.bubbleMsgBoxes, arg_30_1)

	if #self.bubbleMsgBoxes > 1 then
		return
	end

	local function var_30_1()
		if self.bubbleMsgBoxes[1] then
			self.bubbleMsgBoxes[1](function()
				table.remove(self.bubbleMsgBoxes, 1)
				var_30_1()

				return
			end)
		end

		return
	end

	;(nil)()

	return
end

function LevelScene:CleanBubbleMsgbox()
	table.clean(self.bubbleMsgBoxes)

	return
end

function LevelScene:updatePtActivity(arg_34_1)
	self.ptActivity = arg_34_1

	if not self.ptActivity then
		return
	end

	self:updateActivityRes()

	return
end

function LevelScene:updateActivityRes()
	local var_35_0 = findTF(self.ptTotal, "Text")
	local var_35_1 = findTF(self.ptTotal, "icon/Image")

	if var_35_0 and var_35_1 and self.ptActivity then
		setText(var_35_0, "x" .. self.ptActivity.data1)
		GetImageSpriteFromAtlasAsync(Drop.New({
			type = DROP_TYPE_RESOURCE,
			id = tonumber(self.ptActivity:getConfig("config_id"))
		}):getIcon(), "", var_35_1, true)
	end

	return
end

function LevelScene:setCommanderPrefabs(arg_36_1)
	self.commanderPrefabs = arg_36_1

	return
end

function LevelScene:didEnter()
	self.openedCommanerSystem = not LOCK_COMMANDER and pg.SystemOpenMgr.GetInstance():isOpenSystem(self.player.level, "CommanderCatMediator")

	onButton(self, self.topChapter:Find("back_button"), function()
		if self:isfrozen() then
			return
		end

		local var_38_0 = self.contextData.map

		if self.contextData.map and (var_38_0:isActivity() or var_38_0:isEscort()) then
			self:emit(LevelMediator2.ON_SWITCH_NORMAL_MAP)

			return
		elseif var_38_0 and var_38_0:isSkirmish() then
			self:emit(LevelScene.ON_BACK)
		elseif not self.contextData.entranceStatus then
			self:ShowEntranceUI(true)
		else
			self:emit(LevelScene.ON_BACK)
		end

		return
	end, SFX_CANCEL)
	onButton(self, self.btnSpecial, function()
		if self:isfrozen() then
			return
		end

		self:emit(LevelMediator2.ON_OPEN_EVENT_SCENE)

		return
	end, SFX_PANEL)
	onButton(self, self.dailyBtn, function()
		if self:isfrozen() then
			return
		end

		DailyLevelProxy.dailyLevelId = nil

		self:updatDailyBtnTip()
		self:emit(LevelMediator2.ON_DAILY_LEVEL)

		return
	end, SFX_PANEL)
	onButton(self, self.challengeBtn, function()
		if self:isfrozen() then
			return
		end

		local var_41_0, var_41_1 = self:checkChallengeOpen()

		if var_41_0 == false then
			pg.TipsMgr.GetInstance():ShowTips(var_41_1)
		else
			self:emit(LevelMediator2.CLICK_CHALLENGE_BTN)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.militaryExerciseBtn, function()
		if self:isfrozen() then
			return
		end

		self:emit(LevelMediator2.ON_OPEN_MILITARYEXERCISE)

		return
	end, SFX_PANEL)
	onButton(self, self.normalBtn, function()
		if self:isfrozen() then
			return
		end

		self:setMap(self.contextData.map:getBindMapId())

		return
	end, SFX_PANEL)
	onButton(self, self.eliteBtn, function()
		if self:isfrozen() then
			return
		end

		if self.contextData.map:getBindMapId() == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("elite_disable_unusable"))

			local var_44_0 = getProxy(ChapterProxy):getUseableMaxEliteMap()

			if var_44_0 then
				self:setMap(var_44_0.configId)
				pg.TipsMgr.GetInstance():ShowTips(i18n("elite_warp_to_latest_map"))
			end
		elseif self.contextData.map:isEliteEnabled() then
			self:setMap(self.contextData.map:getBindMapId())
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("elite_disable_unsatisfied"))
		end

		return
	end, SFX_UI_WEIGHANCHOR_HARD)
	onButton(self, self.remasterBtn, function()
		if self:isfrozen() then
			return
		end

		self:displayRemasterPanel()
		getProxy(ChapterProxy):setRemasterTip(false)
		self:updateRemasterBtnTip()

		return
	end, SFX_PANEL)
	onButton(self, self.entranceLayer:Find("enters/enter_main"), function()
		if self:isfrozen() then
			return
		end

		self:ShowSelectedMap(self:GetInitializeMap())

		return
	end, SFX_PANEL)
	setText(self.entranceLayer:Find("enters/enter_main/Text"), getProxy(ChapterProxy):getLastUnlockMap():getLastUnlockChapterName())
	onButton(self, self.entranceLayer:Find("enters/enter_world/enter"), function()
		if self:isfrozen() then
			return
		end

		self:emit(LevelMediator2.ENTER_WORLD)

		return
	end, SFX_PANEL)
	onButton(self, self.entranceLayer:Find("enters/enter_ready/activity"), function()
		if self:isfrozen() then
			return
		end

		switch(self.entranceActivity:getConfig("type"), {
			[ActivityConst.ACTIVITY_TYPE_ZPROJECT] = function()
				self:emit(LevelMediator2.ON_ACTIVITY_MAP, self.entranceActivity.id)

				return
			end,
			[ActivityConst.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2] = function()
				self:emit(LevelMediator2.ON_OPEN_ACT_BOSS_BATTLE)

				return
			end,
			[ActivityConst.ACTIVITY_TYPE_BOSSRUSH] = function()
				self:emit(LevelMediator2.ON_BOSSRUSH_MAP)

				return
			end,
			[ActivityConst.ACTIVITY_TYPE_BOSSSINGLE] = function()
				self:emit(LevelMediator2.ON_BOSSSINGLE_MAP, {
					mode = OtherworldMapScene.MODE_BATTLE
				})

				return
			end,
			[ActivityConst.ACTIVITY_TYPE_BOSSSINGLE_VARIABLE] = function()
				self:emit(LevelMediator2.ON_CLUE_MAP)

				return
			end,
			[ActivityConst.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB] = function()
				self:emit(LevelMediator2.ON_COLLAB_BOSSRUSH_MAP)

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(self, self.entranceLayer:Find("btns/btn_remaster"), function()
		if self:isfrozen() then
			return
		end

		self:displayRemasterPanel()
		getProxy(ChapterProxy):setRemasterTip(false)
		self:updateRemasterBtnTip()

		return
	end, SFX_PANEL)
	setActive(self.entranceLayer:Find("btns/btn_remaster"), OPEN_REMASTER)
	onButton(self, self.entranceLayer:Find("btns/btn_challenge"), function()
		if self:isfrozen() then
			return
		end

		local var_56_0, var_56_1 = self:checkChallengeOpen()

		if var_56_0 == false then
			pg.TipsMgr.GetInstance():ShowTips(var_56_1)
		else
			self:emit(LevelMediator2.CLICK_CHALLENGE_BTN)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.entranceLayer:Find("btns/btn_pvp"), function()
		if self:isfrozen() then
			return
		end

		self:emit(LevelMediator2.ON_OPEN_MILITARYEXERCISE)

		return
	end, SFX_PANEL)
	onButton(self, self.entranceLayer:Find("btns/btn_daily"), function()
		if self:isfrozen() then
			return
		end

		DailyLevelProxy.dailyLevelId = nil

		self:updatDailyBtnTip()
		self:emit(LevelMediator2.ON_DAILY_LEVEL)

		return
	end, SFX_PANEL)
	onButton(self, self.entranceLayer:Find("btns/btn_task"), function()
		if self:isfrozen() then
			return
		end

		self:emit(LevelMediator2.ON_OPEN_EVENT_SCENE)

		return
	end, SFX_PANEL)
	setActive(self.entranceLayer:Find("enters/enter_world/enter"), not WORLD_ENTER_LOCK)
	setActive(self.entranceLayer:Find("enters/enter_world/nothing"), WORLD_ENTER_LOCK)

	self.entranceActivity = getProxy(ActivityProxy):getEnterReadyActivity()[1]

	setActive(self.entranceLayer:Find("enters/enter_ready/nothing"), not tobool(self.entranceActivity))
	setActive(self.entranceLayer:Find("enters/enter_ready/activity"), tobool(self.entranceActivity))

	if tobool(self.entranceActivity) then
		local var_37_0 = self.entranceActivity:getConfig("config_client").entrance_bg

		if var_37_0 then
			GetImageSpriteFromAtlasAsync(var_37_0, "", self.entranceLayer:Find("enters/enter_ready/activity"), true)
		end
	end

	self:updateRightPanel()

	local var_37_1 = pg.SystemOpenMgr.GetInstance():isOpenSystem(self.player.level, "EventMediator")

	setActive(self.btnSpecial:Find("lock"), not var_37_1)
	setActive(self.entranceLayer:Find("btns/btn_task/lock"), not var_37_1)

	local var_37_2 = pg.SystemOpenMgr.GetInstance():isOpenSystem(self.player.level, "DailyLevelMediator")

	setActive(self.dailyBtn:Find("lock"), not var_37_2)
	setActive(self.entranceLayer:Find("btns/btn_daily/lock"), not var_37_2)

	local var_37_3 = pg.SystemOpenMgr.GetInstance():isOpenSystem(self.player.level, "MilitaryExerciseMediator")

	setActive(self.militaryExerciseBtn:Find("lock"), not var_37_3)
	setActive(self.entranceLayer:Find("btns/btn_pvp/lock"), not var_37_3)
	setActive(self.entranceLayer:Find("enters/enter_world/enter/lock"), not pg.SystemOpenMgr.GetInstance():isOpenSystem(self.player.level, "WorldMediator"))

	local var_37_4 = LimitChallengeConst.IsOpen()

	setActive(self.challengeBtn:Find("lock"), not var_37_4)
	setActive(self.entranceLayer:Find("btns/btn_challenge/lock"), not var_37_4)

	local var_37_5 = LimitChallengeConst.IsInAct()

	setActive(self.challengeBtn, var_37_5)
	setActive(self.entranceLayer:Find("btns/btn_challenge"), var_37_5)
	setActive(self.entranceLayer:Find("btns/btn_challenge/tip"), (LimitChallengeConst.IsShowRedPoint()))
	self:initMapBtn(self.btnPrev, -1)
	self:initMapBtn(self.btnNext, 1)
	self:registerActBtn()

	if self.contextData.editEliteChapter then
		self:displayFleetEdit((getProxy(ChapterProxy):getChapterById(self.contextData.editEliteChapter)))

		self.contextData.editEliteChapter = nil
	elseif self.contextData.selectedChapterVO then
		self:displayFleetSelect(self.contextData.selectedChapterVO)

		self.contextData.selectedChapterVO = nil
	end

	if not self.contextData.chapterVO or not self.contextData.chapterVO.active then
		self:tryPlaySubGuide()
	end

	self:updateRemasterBtnTip()
	self:updatDailyBtnTip()

	if self.contextData.open_remaster then
		self:displayRemasterPanel(self.contextData.isSP)

		self.contextData.open_remaster = nil
	end

	self:ShowEntranceUI(self.contextData.entranceStatus)

	if not self.contextData.entranceStatus then
		self:emit(LevelMediator2.ON_ENTER_MAINLEVEL, self:GetInitializeMap())
	end

	self:emit(LevelMediator2.ON_DIDENTER)

	return
end

function LevelScene:updateRightPanel()
	self.rightActivityBtns = defaultValue(self.rightActivityBtns, {
		LevelSecondMapBtn.New(self.actBtnTpl, self.event, false)
	})

	local var_60_0 = {}
	local var_60_1 = {}

	for iter_60_0, iter_60_1 in ipairs(self.rightActivityBtns) do
		if iter_60_1:InShowTime() then
			table.insert(var_60_0, iter_60_1)
		else
			table.insert(var_60_1, iter_60_1)
		end
	end

	table.sort(var_60_0, CompareFuncs({
		function(arg_61_0)
			return arg_61_0.config.group_id
		end
	}))

	for iter_60_2, iter_60_3 in ipairs(var_60_0) do
		iter_60_3:Init(iter_60_2)
	end

	for iter_60_4, iter_60_5 in ipairs(var_60_1) do
		iter_60_5:Clear()
	end

	return
end

function LevelScene:checkChallengeOpen()
	return pg.SystemOpenMgr.GetInstance():isOpenSystem(getProxy(PlayerProxy):getRawData().level, "ChallengeMainMediator")
end

function LevelScene:tryPlaySubGuide()
	if self.contextData.map and self.contextData.map:isSkirmish() then
		return
	end

	pg.SystemGuideMgr.GetInstance():Play(self)

	return
end

function LevelScene:onBackPressed()
	if self:isfrozen() then
		return
	end

	if self.levelAmbushView then
		return
	end

	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)

	if self.chapterAutoDetailPanel:isShowing() then
		self:HideChapterAutoDetailPanel()
	end

	if self.levelInfoView:isShowing() then
		self:hideChapterPanel()

		return
	end

	if self.levelInfoSPView and self.levelInfoSPView:isShowing() then
		self:HideLevelInfoSPPanel()

		return
	end

	if self.levelFleetView:isShowing() then
		self:hideFleetEdit()

		return
	end

	if self.levelStrategyView then
		self:hideStrategyInfo()

		return
	end

	if self.levelRepairView then
		self:hideRepairWindow()

		return
	end

	if self.levelRemasterView:isShowing() then
		self:hideRemasterPanel()

		return
	end

	if self.contextData.map and self.contextData.map:getConfig("ui_type") == MapBuilder.TYPEEXSP and self.mapBuilder.personalPage:IsActive() then
		self.mapBuilder.personalPage:Hide()

		return
	end

	if isActive(self.helpPage) then
		setActive(self.helpPage, false)

		return
	end

	if self.contextData.chapterVO and getProxy(ChapterProxy):getActiveChapter() then
		self:switchToMap()

		return
	end

	triggerButton(self.topChapter:Find("back_button"))

	return
end

function LevelScene:ShowEntranceUI(arg_65_1)
	setActive(self.entranceLayer, arg_65_1)
	setActive(self.entranceBg, arg_65_1)
	setActive(self.map, not arg_65_1)
	setActive(self.float, not arg_65_1)
	setActive(self.mainLayer, not arg_65_1)
	setActive(self.topChapter:Find("type_entrance"), arg_65_1)

	self.contextData.entranceStatus = tobool(arg_65_1)

	if arg_65_1 then
		setActive(self.topChapter:Find("title_chapter"), false)
		setActive(self.topChapter:Find("type_chapter"), false)
		setActive(self.topChapter:Find("type_escort"), false)
		setActive(self.topChapter:Find("type_skirmish"), false)

		if self.newChapterCDTimer then
			self.newChapterCDTimer:Stop()

			self.newChapterCDTimer = nil
		end

		self:RecordLastMapOnExit()

		self.contextData.mapIdx = nil
		self.contextData.map = nil
	end

	self:PlayBGM()

	return
end

function LevelScene:PreloadLevelMainUI(arg_66_1, arg_66_2)
	if self.preloadLevelDone then
		existCall(arg_66_2)

		return
	end

	table.ParallelIpairsAsync(self:GetMapBG((getProxy(ChapterProxy):getMapById(arg_66_1))), function(arg_68_0, arg_68_1, arg_68_2)
		GetSpriteFromAtlasAsync("levelmap/" .. arg_68_1.BG, "", arg_68_2)

		return
	end, function()
		if not self.exited then
			self.preloadLevelDone = true

			existCall(arg_66_2)
		end

		return
	end)

	return
end

function LevelScene:setShips(arg_69_1)
	self.shipVOs = arg_69_1

	return
end

function LevelScene:updateRes(arg_70_1)
	if self.levelStageView then
		self.levelStageView:ActionInvoke("SetPlayer", arg_70_1)
	end

	self.player = arg_70_1

	return
end

function LevelScene:setEliteQuota(arg_71_1, arg_71_2)
	local var_71_0 = self.eliteQuota:Find("bg/Text"):GetComponent(typeof(Text))

	var_71_0.color = arg_71_1 == arg_71_2 and Color.red or Color.New(0.47, 0.89, 0.27)
	var_71_0.text = arg_71_2 - arg_71_1 .. "/" .. arg_71_2

	return
end

function LevelScene:updateEvent(arg_72_1)
	local var_72_0 = arg_72_1:hasFinishState()

	setActive(self.btnSpecial:Find("tip"), var_72_0)
	setActive(self.entranceLayer:Find("btns/btn_task/tip"), var_72_0)

	return
end

function LevelScene:updateFleet(arg_73_1)
	self.fleets = arg_73_1

	return
end

function LevelScene:updateChapterVO(arg_74_1, arg_74_2)
	if self.contextData.chapterVO and self.contextData.chapterVO.id == arg_74_1.id and arg_74_1.active then
		self:setChapter(arg_74_1)
	end

	if self.contextData.chapterVO and self.contextData.chapterVO.id == arg_74_1.id and arg_74_1.active and self.levelStageView and self.grid then
		local var_74_0 = false
		local var_74_1 = false
		local var_74_2 = false

		if arg_74_2 < 0 or bit.band(arg_74_2, ChapterConst.DirtyFleet) > 0 then
			self.levelStageView:updateStageFleet()
			self.levelStageView:updateAmbushRate(arg_74_1.fleet.line, true)

			var_74_2 = true

			if self.grid then
				self.grid:RefreshFleetCells()
				self.grid:UpdateFloor()
				self.grid:UpdateWeatherCells()

				var_74_0 = true
			end
		end

		if arg_74_2 < 0 or bit.band(arg_74_2, ChapterConst.DirtyChampion) > 0 then
			var_74_2 = true

			if self.grid then
				self.grid:UpdateFleets()
				self.grid:clearChampions()
				self.grid:initChampions()

				var_74_1 = true
			end
		elseif bit.band(arg_74_2, ChapterConst.DirtyChampionPosition) > 0 then
			var_74_2 = true

			if self.grid then
				self.grid:UpdateFleets()
				self.grid:updateChampions()

				var_74_1 = true
			end
		end

		if arg_74_2 < 0 or bit.band(arg_74_2, ChapterConst.DirtyAchieve) > 0 then
			self.levelStageView:updateStageAchieve()
		end

		if arg_74_2 < 0 or bit.band(arg_74_2, ChapterConst.DirtyAttachment) > 0 then
			self.levelStageView:updateAmbushRate(arg_74_1.fleet.line, true)

			if self.grid then
				if arg_74_2 >= 0 and bit.band(arg_74_2, ChapterConst.DirtyFleet) <= 0 then
					self.grid:updateFleet(arg_74_1.fleets[arg_74_1.findex].id)
				end

				self.grid:updateAttachments()

				if arg_74_2 < 0 or bit.band(arg_74_2, ChapterConst.DirtyAutoAction) > 0 then
					self.grid:updateQuadCells(ChapterConst.QuadStateNormal)
				else
					var_74_0 = true
				end
			end
		end

		if arg_74_2 < 0 or bit.band(arg_74_2, ChapterConst.DirtyStrategy) > 0 then
			self.levelStageView:updateStageStrategy()

			var_74_2 = true

			self.levelStageView:updateStageBarrier()
			self.levelStageView:UpdateAutoFightPanel()
		end

		if arg_74_2 < 0 or bit.band(arg_74_2, ChapterConst.DirtyAutoAction) > 0 then
			-- block empty
		elseif var_74_0 then
			self.grid:updateQuadCells(ChapterConst.QuadStateNormal)
		elseif var_74_1 then
			self.grid:updateQuadCells(ChapterConst.QuadStateFrozen)
		end

		if arg_74_2 < 0 or bit.band(arg_74_2, ChapterConst.DirtyCellFlag) > 0 then
			self.grid:UpdateFloor()
		end

		if arg_74_2 < 0 or bit.band(arg_74_2, ChapterConst.DirtyBase) > 0 then
			self.levelStageView:UpdateDefenseStatus()
		end

		if arg_74_2 < 0 or bit.band(arg_74_2, ChapterConst.DirtyFloatItems) > 0 then
			self.grid:UpdateItemCells()
		end

		if arg_74_2 < 0 or bit.band(arg_74_2, ChapterConst.DirtyWeather) > 0 then
			self.grid:UpdateWeatherCells()
		end

		if var_74_2 then
			self.levelStageView:updateFleetBuff()
		end
	end

	return
end

function LevelScene:updateClouds()
	self.cloudRTFs = {}
	self.cloudRects = {}
	self.cloudTimer = {}

	for iter_75_0 = 1, 6 do
		local var_75_0 = rtf((self.clouds:Find("cloud_" .. iter_75_0)))

		table.insert(self.cloudRTFs, var_75_0)
		table.insert(self.cloudRects, var_75_0.rect.width)
	end

	self:initCloudsPos()

	for iter_75_1, iter_75_2 in ipairs(self.cloudRTFs) do
		local var_75_1 = self.cloudRects[iter_75_1]
		local var_75_2 = self.initPositions[iter_75_1] or Vector2(0, 0)
		local var_75_3 = 30 - var_75_2.y / 20
		local var_75_4

		var_75_4 = LeanTween.moveX(iter_75_2, self.mapWidth, (self.mapWidth + self.cloudRects[iter_75_1]) / (30 - var_75_2.y / 20)):setRepeat(-1):setOnCompleteOnRepeat(true):setOnComplete(System.Action(function()
			var_75_1 = self.cloudRects[iter_75_1]
			iter_75_2.anchoredPosition = Vector2(-var_75_1, var_75_2.y)

			var_75_4:setFrom(-var_75_1):setTime((self.mapWidth + var_75_1) / var_75_3)

			return
		end))
		var_75_4.passed = math.random() * ((self.mapWidth + self.cloudRects[iter_75_1]) / (30 - var_75_2.y / 20))
		self.cloudTimer[iter_75_1] = var_75_4.uniqueId
	end

	return
end

function LevelScene:RefreshMapBG()
	self:PlayBGM()
	self:SwitchMapBG(self.contextData.map, nil, true)

	return
end

function LevelScene:updateCouldAnimator(arg_78_1, arg_78_2)
	if not arg_78_1 then
		return
	end

	local var_78_0 = self.contextData.map:getConfig("ani_controller")

	local function var_78_1(arg_79_0)
		arg_79_0 = tf(arg_79_0)

		if arg_79_0.rect.width > 0 and arg_79_0.rect.height > 0 then
			Vector3.one.x = arg_79_0.parent.rect.width / arg_79_0.rect.width
			Vector3.one.y = arg_79_0.parent.rect.height / arg_79_0.rect.height
		end

		arg_79_0.localScale = Vector3.one

		if var_78_0 and #var_78_0 > 0 then
			local var_79_0 = getProxy(ChapterProxy)

			;(function()
				for iter_80_0, iter_80_1 in ipairs(var_78_0) do
					local var_80_0 = false

					for iter_80_2, iter_80_3 in ipairs(iter_80_1[2][1]) do
						local var_80_1 = var_79_0:GetChapterItemById(iter_80_3)

						if var_80_1 and var_80_1:isClear() then
							var_80_0 = true

							break
						end
					end

					if iter_80_1[1] == var_0_2 then
						for iter_80_4, iter_80_5 in ipairs((_.rest(iter_80_1[2], 2))) do
							local var_80_2 = arg_79_0:Find(iter_80_5)

							if not IsNil(var_80_2) and not var_80_0 then
								setActive(var_80_2, false)
							end
						end
					elseif iter_80_1[1] == var_0_3 then
						for iter_80_6, iter_80_7 in ipairs((_.rest(iter_80_1[2], 2))) do
							local var_80_3 = arg_79_0:Find(iter_80_7)

							if not IsNil(var_80_3) and not var_80_0 then
								setActive(var_80_3, true)

								return
							end
						end
					elseif iter_80_1[1] == var_0_4 then
						for iter_80_8, iter_80_9 in ipairs((_.rest(iter_80_1[2], 2))) do
							local var_80_4 = arg_79_0:Find(iter_80_9)

							if not IsNil(var_80_4) and not var_80_0 then
								setActive(var_80_4, true)
							end
						end
					end
				end

				return
			end)()
		end

		return
	end

	table.insert(self.mapGroup, (self.loader:GetPrefab("ui/" .. arg_78_1, arg_78_1, function(arg_81_0)
		arg_81_0:SetActive(true)
		setParent(arg_81_0, self.mapTFs[arg_78_2])
		pg.ViewUtils.SetSortingOrder(arg_81_0, ChapterConst.LayerWeightMap + arg_78_2 * 2 - 1)
		var_78_1(arg_81_0)

		return
	end)))

	return
end

function LevelScene:HideBtns()
	setActive(self.btnPrev, false)
	setActive(self.eliteQuota, false)
	setActive(self.escortBar, false)
	setActive(self.skirmishBar, false)
	setActive(self.normalBtn, false)
	setActive(self.actNormalBtn, false)
	setActive(self.eliteBtn, false)
	setActive(self.actEliteBtn, false)
	setActive(self.actExtraBtn, false)
	setActive(self.remasterBtn, false)
	setActive(self.btnNext, false)
	setActive(self.remasterAwardBtn, false)
	setActive(self.eventContainer, false)
	setActive(self.activityBtn, false)
	setActive(self.ptTotal, false)
	setActive(self.ticketTxt.parent, false)
	setActive(self.countDown, false)
	setActive(self.actAtelierBuffBtn, false)
	setActive(self.actAtelierYumiaBuffBtn, false)
	setActive(self.actExtraRank, false)
	setActive(self.actExchangeShopBtn, false)
	setActive(self.mapHelpBtn, false)

	return
end

function LevelScene:updateDifficultyBtns()
	local var_83_0 = self.contextData.map:getConfig("type")

	setActive(self.normalBtn, var_83_0 == Map.ELITE)
	setActive(self.eliteQuota, var_83_0 == Map.ELITE)
	setActive(self.eliteBtn, var_83_0 == Map.SCENARIO)

	local var_83_1 = getProxy(ActivityProxy):getActivityById(ActivityConst.ELITE_AWARD_ACTIVITY_ID)

	setActive(self.eliteBtn:Find("pic_activity"), var_83_1 and not var_83_1:isEnd())

	return
end

function LevelScene:updateActivityBtns()
	local var_84_0 = self.contextData.map
	local var_84_1, var_84_2 = self.contextData.map:isActivity()
	local var_84_3 = var_84_0:isRemaster()
	local var_84_4 = var_84_0:isSkirmish()
	local var_84_5 = var_84_0:isEscort()
	local var_84_6 = var_84_0:getConfig("type")
	local var_84_7 = setmetatable({}, MainActMapBtn)
	local var_84_8 = var_84_7:InShowTime() and not var_84_1 and not var_84_4 and not var_84_5

	self.activityBtnLinkAct = var_84_7:GetActivity()

	if var_84_8 then
		var_84_7.image = self.activityBtn:Find("Image"):GetComponent(typeof(Image))
		var_84_7.subImage = self.activityBtn:Find("sub_Image"):GetComponent(typeof(Image))
		var_84_7.tipTr = self.activityBtn:Find("Tip"):GetComponent(typeof(Image))
		var_84_7.tipTxt = self.activityBtn:Find("Tip/Text"):GetComponent(typeof(Text))
		var_84_8 = var_84_7:InShowTime()

		if var_84_8 then
			var_84_7:InitTipImage()
			var_84_7:InitSubImage()
			var_84_7:InitImage(function()
				return
			end)
			var_84_7:OnInit()
		end
	end

	setActive(self.activityBtn, var_84_8)
	self:updateRemasterInfo()

	if var_84_1 and var_84_2 then
		local var_84_9 = var_84_0:isRemaster() and getProxy(ChapterProxy):getRemasterMaps(var_84_0.remasterId) or getProxy(ChapterProxy):getMapsByActivities(var_84_0:getConfig("on_activity"))

		setActive(self.actExtraBtn, underscore.any(var_84_9, function(arg_86_0)
			return arg_86_0:isActExtra()
		end) and var_84_6 ~= Map.ACT_EXTRA)

		if isActive(self.actExtraBtn) then
			if underscore.all(underscore.filter(var_84_9, function(arg_87_0)
				local var_87_0 = arg_87_0:getMapType()

				return var_87_0 == Map.ACTIVITY_EASY or var_87_0 == Map.ACTIVITY_HARD
			end), function(arg_88_0)
				return arg_88_0:isAllChaptersClear()
			end) then
				setActive(self.actExtraBtnAnim, true)
			else
				setActive(self.actExtraBtnAnim, false)
			end

			local var_84_10 = setActive
			local var_84_11 = getProxy(ChapterProxy):IsActivitySPChapterActive(var_84_0:getConfig("on_activity"))

			var_84_11 = var_84_11 and SettingsProxy.IsShowActivityMapSPTip()

			var_84_10(self.actExtraBtn:Find("Tip"), var_84_11)
		end

		setActive(self.actEliteBtn, checkExist(var_84_0:getBindMap(), {
			"isHardMap"
		}) and var_84_6 ~= Map.ACTIVITY_HARD)
		setActive(self.actNormalBtn, var_84_6 ~= Map.ACTIVITY_EASY)

		local var_84_12 = setActive
		local var_84_13 = self.actExtraRank
		local var_84_14 = var_84_6 == Map.ACT_EXTRA and _.any(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_EXTRA_CHAPTER_RANK), function(arg_89_0)
			if not arg_89_0 or arg_89_0:isEnd() then
				return
			end

			local var_89_0 = arg_89_0:getConfig("config_data")[1]

			return _.any(var_84_0:getChapters(), function(arg_90_0)
				if not arg_90_0:IsEXChapter() then
					return false
				end

				return table.contains(arg_90_0:getConfig("boss_expedition_id"), var_89_0)
			end)
		end) or false

		var_84_12(var_84_13, (false or nil) and true)
		setActive(self.actExchangeShopBtn, not ActivityConst.HIDE_PT_PANELS and not var_84_3 and var_84_2 and self:IsActShopActive())

		local var_84_15

		if self.contextData.map then
			var_84_15 = getProxy(ActivityProxy):getActivityById(self.contextData.map:getConfig("on_activity")) or nil
		end

		local var_84_16 = var_84_15 and not var_84_15:isEnd() and var_84_15:GetConfigClientSetting("PTID")

		self:updatePtActivity(underscore.detect(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_PT_RANK), function(arg_91_0)
			return arg_91_0:getConfig("config_id") == var_84_16
		end))

		local var_84_17 = setActive
		local var_84_18 = self.ptTotal
		local var_84_19

		if not ActivityConst.HIDE_PT_PANELS and not var_84_3 then
			if var_84_2 then
				::label_84_0::

				var_84_19 = self.ptActivity and not self.ptActivity:isEnd()

				goto label_84_1
			end
		end

		::label_84_1::

		var_84_17(var_84_18, true)
	else
		setActive(self.actExtraBtn, false)
		setActive(self.actEliteBtn, false)
		setActive(self.actNormalBtn, false)
		setActive(self.actExtraRank, false)
		setActive(self.actExchangeShopBtn, false)
		setActive(self.actAtelierBuffBtn, false)
		setActive(self.actAtelierYumiaBuffBtn, false)
		setActive(self.ptTotal, false)
	end

	setActive(self.eventContainer, (not var_84_1 or not var_84_2) and not var_84_5)
	setActive(self.remasterBtn, OPEN_REMASTER and (var_84_3 or not var_84_1 and not var_84_5 and not var_84_4))
	setActive(self.ticketTxt.parent, var_84_3)
	self:updateRemasterTicket()
	self:updateCountDown()

	return
end

function LevelScene:updateRemasterTicket()
	setText(self.ticketTxt, getProxy(ChapterProxy).remasterTickets .. " / " .. pg.gameset.reactivity_ticket_max.key_value)
	self:emit(LevelUIConst.FLUSH_REMASTER_TICKET)

	return
end

function LevelScene:updateRemasterBtnTip()
	local var_93_0 = getProxy(ChapterProxy)
	local var_93_1 = var_93_0:ifShowRemasterTip() or var_93_0:anyRemasterAwardCanReceive()

	SetActive(self.remasterBtn:Find("tip"), var_93_1)
	SetActive(self.entranceLayer:Find("btns/btn_remaster/tip"), var_93_1)

	return
end

function LevelScene:updatDailyBtnTip()
	local var_94_0 = getProxy(DailyLevelProxy):ifShowDailyTip()

	SetActive(self.dailyBtn:Find("tip"), var_94_0)
	SetActive(self.entranceLayer:Find("btns/btn_daily/tip"), var_94_0)

	return
end

function LevelScene:updateRemasterInfo()
	self:emit(LevelUIConst.FLUSH_REMASTER_INFO)

	if not self.contextData.map then
		return
	end

	local var_95_0 = getProxy(ChapterProxy)
	local var_95_1 = BossRushChapterRemasterHelper.ChapterAwardInfo((self.contextData.map:getRemaster()))

	setActive(self.remasterAwardBtn, var_95_1)

	if var_95_1 then
		local var_95_2 = var_95_1[1]
		local var_95_3, var_95_4, var_95_5, var_95_6, var_95_7 = unpack(var_95_1[2])
		local var_95_8 = var_95_1[3]
		local var_95_9 = var_95_0:getRemasterInfo(var_95_1[3], var_95_3, var_95_1[1])

		setText(self.remasterAwardBtn:Find("Text"), var_95_9.count .. "/" .. var_95_6)
		updateDrop(self.remasterAwardBtn:Find("IconTpl"), {
			type = var_95_4,
			id = var_95_5
		})
		setActive(self.remasterAwardBtn:Find("tip"), var_95_6 <= var_95_9.count)
		onButton(self, self.remasterAwardBtn, function()
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideYes = true,
				hideNo = true,
				type = MSGBOX_TYPE_SINGLE_ITEM,
				drop = {
					type = var_95_4,
					id = var_95_5
				},
				remaster = {
					word = i18n("level_remaster_tip4", (BossRushChapterRemasterHelper.GetAwardName(var_95_8, var_95_3))),
					number = var_95_9.count .. "/" .. var_95_6,
					btn_text = i18n(var_95_9.count < var_95_6 and "level_remaster_tip2" or "level_remaster_tip3"),
					btn_call = function()
						if var_95_9.count < var_95_6 then
							if var_95_8 and var_95_8 > 0 then
								self:emit(LevelMediator2.ON_BOSSRUSH_REMASTER_ACTIVITY, var_95_8)

								return
							end

							local var_97_0 = pg.chapter_template[var_95_3].map
							local var_97_1, var_97_2 = var_95_0:getMapById(pg.chapter_template[var_95_3].map):isUnlock()

							if not var_97_1 then
								pg.TipsMgr.GetInstance():ShowTips(var_97_2)
							else
								self:ShowSelectedMap(var_97_0)
							end
						else
							self:emit(LevelMediator2.ON_CHAPTER_REMASTER_AWARD, var_95_3, var_95_2, var_95_8)
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

function LevelScene:updateCountDown()
	if self.newChapterCDTimer then
		self.newChapterCDTimer:Stop()

		self.newChapterCDTimer = nil
	end

	local var_98_0 = 0

	if self.contextData.map:isActivity() and not self.contextData.map:isRemaster() then
		_.each(getProxy(ChapterProxy):getMapsByActivities(self.contextData.map:getConfig("on_activity")), function(arg_99_0)
			local var_99_0 = arg_99_0:getChapterTimeLimit()

			var_98_0 = var_98_0 == 0 and var_99_0 or math.min(var_98_0, var_99_0)

			return
		end)
		setActive(self.countDown, var_98_0 > 0)
		setText(self.countDown:Find("title"), i18n("levelScene_new_chapter_coming"))
	else
		setActive(self.countDown, false)
	end

	if var_98_0 > 0 then
		setText(self.countDown:Find("time"), pg.TimeMgr.GetInstance():DescCDTime(var_98_0))

		self.newChapterCDTimer = Timer.New(function()
			var_98_0 = var_98_0 - 1

			if var_98_0 <= 0 then
				self:updateCountDown()

				if not self.contextData.chapterVO then
					self:setMap(self.contextData.mapIdx)
				end
			else
				setText(self.countDown:Find("time"), pg.TimeMgr.GetInstance():DescCDTime(var_98_0))
			end

			return
		end, 1, -1)

		self.newChapterCDTimer:Start()
	else
		setText(self.countDown:Find("time"), "")
	end

	return
end

function LevelScene:registerActBtn()
	onButton(self, self.actExtraRank, function()
		if self:isfrozen() then
			return
		end

		self:emit(LevelMediator2.ON_EXTRA_RANK)

		return
	end, SFX_PANEL)
	onButton(self, self.activityBtn, function()
		if self:isfrozen() then
			return
		end

		if self.activityBtnLinkAct then
			local var_103_0 = self.activityBtnLinkAct:getConfig("type")

			if var_103_0 == ActivityConst.ACTIVITY_TYPE_BOSSRUSH then
				pg.m02:sendNotification(GAME.GO_SCENE, SCENE.BOSSRUSH_MAIN)

				return
			elseif var_103_0 == ActivityConst.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB then
				pg.m02:sendNotification(GAME.GO_SCENE, SCENE.BOSSRUSH_DAL_COLLAB)

				return
			elseif self.activityBtnLinkAct.id == ActivityConst.OTHER_WORLD_TERMINAL_BATTLE_ID then
				pg.m02:sendNotification(GAME.GO_SCENE, SCENE.OTHERWORLD_MAP)

				return
			elseif var_103_0 == ActivityConst.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2 then
				pg.m02:sendNotification(GAME.GO_SCENE, SCENE.ZHANG_WU_BOSS)

				return
			end
		end

		self:emit(LevelMediator2.ON_ACTIVITY_MAP)

		return
	end, SFX_UI_CLICK)
	onButton(self, self.actExchangeShopBtn, function()
		if self:isfrozen() then
			return
		end

		self:emit(LevelMediator2.GO_ACT_SHOP)

		return
	end, SFX_UI_CLICK)
	onButton(self, self.actAtelierBuffBtn, function()
		if self:isfrozen() then
			return
		end

		self:emit(LevelMediator2.SHOW_ATELIER_BUFF)

		return
	end, SFX_UI_CLICK)
	onButton(self, self.actAtelierYumiaBuffBtn, function()
		if self:isfrozen() then
			return
		end

		self:emit(LevelMediator2.SHOW_ATELIER_BUFF, true)

		return
	end, SFX_UI_CLICK)

	local var_101_0 = getProxy(ChapterProxy)

	local function var_101_1(arg_107_0, arg_107_1, arg_107_2)
		local var_107_0 = _.select(arg_107_0:isRemaster() and var_101_0:getRemasterMaps(arg_107_0.remasterId) or var_101_0:getMapsByActivities(arg_107_0:getConfig("on_activity")), function(arg_108_0)
			return arg_108_0:getMapType() == arg_107_1
		end)

		table.sort(var_107_0, function(arg_109_0, arg_109_1)
			return arg_109_0.id < arg_109_1.id
		end)

		local var_107_2 = table.indexof(underscore.map(var_107_0, function(arg_110_0)
			return arg_110_0.id
		end), arg_107_2) or #var_107_0

		while not var_107_0[var_107_2]:isUnlock() do
			if var_107_2 > 1 then
				var_107_2 = var_107_2 - 1
			else
				break
			end
		end

		return var_107_0[var_107_2]
	end

	self:bind(LevelUIConst.SWITCH_ACT_MAP, function(arg_111_0, arg_111_1, arg_111_2)
		arg_111_2 = arg_111_2 or switch(arg_111_1, {
			[Map.ACTIVITY_EASY] = function()
				return self.contextData.map:getBindMapId()
			end,
			[Map.ACTIVITY_HARD] = function()
				return self.contextData.map:getBindMapId()
			end,
			[Map.ACT_EXTRA] = function()
				return PlayerPrefs.GetInt("ex_mapId", 0)
			end
		})

		local var_111_0 = var_101_1(self.contextData.map, arg_111_1, arg_111_2)
		local var_111_1, var_111_2 = var_111_0:isUnlock()

		if var_111_1 then
			self:setMap(var_111_0.id)
		else
			pg.TipsMgr.GetInstance():ShowTips(var_111_2)
		end

		return
	end)
	onButton(self, self.actNormalBtn, function()
		if self:isfrozen() then
			return
		end

		self:emit(LevelUIConst.SWITCH_ACT_MAP, Map.ACTIVITY_EASY)

		return
	end, SFX_PANEL)
	onButton(self, self.actEliteBtn, function()
		if self:isfrozen() then
			return
		end

		self:emit(LevelUIConst.SWITCH_ACT_MAP, Map.ACTIVITY_HARD)

		return
	end, SFX_PANEL)
	onButton(self, self.actExtraBtn, function()
		if self:isfrozen() then
			return
		end

		self:emit(LevelUIConst.SWITCH_ACT_MAP, Map.ACT_EXTRA)

		return
	end, SFX_PANEL)

	return
end

function LevelScene:initCloudsPos(arg_118_1)
	self.initPositions = {}

	for iter_118_0, iter_118_1 in ipairs(self.cloudRTFs) do
		if pg.expedition_data_by_map[arg_118_1 or 1].clouds_pos[iter_118_0] then
			iter_118_1.anchoredPosition = Vector2(pg.expedition_data_by_map[arg_118_1 or 1].clouds_pos[iter_118_0][1], pg.expedition_data_by_map[arg_118_1 or 1].clouds_pos[iter_118_0][2])

			table.insert(self.initPositions, iter_118_1.anchoredPosition)
		else
			setActive(iter_118_1, false)
		end
	end

	return
end

function LevelScene:initMapBtn(arg_119_1, arg_119_2)
	onButton(self, arg_119_1, function()
		if self:isfrozen() then
			return
		end

		local var_120_0 = self.contextData.mapIdx + arg_119_2
		local var_120_1 = getProxy(ChapterProxy):getMapById(self.contextData.mapIdx + arg_119_2)

		if not var_120_1 then
			return
		end

		if var_120_1:getMapType() == Map.ELITE and not var_120_1:isEliteEnabled() then
			var_120_1 = var_120_1:getBindMap()
			var_120_0 = var_120_1.id

			pg.TipsMgr.GetInstance():ShowTips(i18n("elite_disable_unusable"))
		end

		local var_120_2, var_120_3 = var_120_1:isUnlock()

		if arg_119_2 > 0 and not var_120_2 then
			pg.TipsMgr.GetInstance():ShowTips(var_120_3)

			return
		end

		self:setMap(var_120_0)

		return
	end, SFX_PANEL)

	return
end

function LevelScene:ShowSelectedMap(arg_121_1, arg_121_2)
	seriesAsync({
		function(arg_122_0)
			if self.contextData.entranceStatus then
				self:frozen()

				self.nextPreloadMap = arg_121_1

				self:PreloadLevelMainUI(arg_121_1, function()
					self:unfrozen()

					if self.nextPreloadMap ~= arg_121_1 then
						return
					end

					self:ShowEntranceUI(false)
					self:emit(LevelMediator2.ON_ENTER_MAINLEVEL, arg_121_1)
					arg_122_0()

					return
				end)
			else
				self:setMap(arg_121_1)
				arg_122_0()
			end

			return
		end
	}, arg_121_2)

	return
end

function LevelScene:setMap(arg_124_1)
	local var_124_0 = self.contextData.mapIdx

	self.contextData.mapIdx = arg_124_1
	self.contextData.map = getProxy(ChapterProxy):getMapById(arg_124_1)

	assert(self.contextData.map, "map cannot be nil " .. arg_124_1)

	if self.contextData.map:getMapType() == Map.ACT_EXTRA then
		PlayerPrefs.SetInt("ex_mapId", self.contextData.map.id)
		PlayerPrefs.Save()
	elseif self.contextData.map:isRemaster() then
		PlayerPrefs.SetInt("remaster_lastmap_" .. self.contextData.map.remasterId, arg_124_1)
		PlayerPrefs.Save()
	end

	self:RecordLastMapOnExit()
	self:updateMap(var_124_0)
	self:tryPlayMapStory()

	return
end

local MapBuilder = import("view.level.MapBuilder.MapBuilder")
local var_0_6 = {
	[MapBuilder.TYPENORMAL] = "MapBuilderNormal",
	[MapBuilder.TYPEESCORT] = "MapBuilderEscort",
	[MapBuilder.TYPESHINANO] = "MapBuilderShinano",
	[MapBuilder.TYPESKIRMISH] = "MapBuilderSkirmish",
	[MapBuilder.TYPEBISMARCK] = "MapBuilderBismarck",
	[MapBuilder.TYPESSSS] = "MapBuilderSSSS",
	[MapBuilder.TYPEATELIER] = "MapBuilderAtelier",
	[MapBuilder.TYPESENRANKAGURA] = "MapBuilderSenrankagura",
	[MapBuilder.TYPESP] = "MapBuilderSP",
	[MapBuilder.TYPESPFULL] = "MapBuilderSPFull",
	[MapBuilder.TYPESPSERIES] = "MapBuilderSPSeries",
	[MapBuilder.TYPESPSERIESFULL] = "MapBuilderSPSeriesFull",
	[MapBuilder.TYPEATELIERYUMIA] = "MapBuilderAtelierYumia",
	[MapBuilder.TYPEEXSP] = "MapBuilderEXSP",
	[MapBuilder.TYPESPSERIESRECREW] = "MapBuilderSPSeriesRecrew"
}

function LevelScene:SwitchMapBuilder(arg_125_1)
	if self.mapBuilder and self.mapBuilder:GetType() ~= arg_125_1 then
		self.mapBuilder.buffer:Hide()
	end

	local var_125_0 = self:GetMapBuilderInBuffer(arg_125_1)

	self.mapBuilder = var_125_0

	var_125_0.buffer:Show()

	return
end

function LevelScene:GetMapBuilderInBuffer(arg_126_1)
	if not self.mbDict[arg_126_1] then
		assert(_G[var_0_6[arg_126_1]], "Missing MapBuilder of type " .. (arg_126_1 or "NIL"))

		self.mbDict[arg_126_1] = _G[var_0_6[arg_126_1]].New(self._tf, self)
		self.mbDict[arg_126_1].isFrozen = self:isfrozen()

		self.mbDict[arg_126_1]:Load()
	end

	return self.mbDict[arg_126_1]
end

function LevelScene:updateMap(arg_127_1)
	local var_127_0 = self.contextData.map
	local var_127_1 = self.contextData.map:getConfig("anchor")

	self.map.pivot = var_127_1 == "" and Vector2(0.5, 0.5) or Vector2(unpack(var_127_1))

	local var_127_3 = var_127_0:getConfig("uifx")

	for iter_127_0 = 1, self.UIFXList.childCount do
		local var_127_4 = self.UIFXList:GetChild(iter_127_0 - 1)

		setActive(var_127_4, var_127_4.name == var_127_3)
	end

	self:SwitchMapBG(var_127_0, arg_127_1)
	self:PlayBGM()
	self:SwitchMapBuilder((self.contextData.map:getConfig("ui_type")))
	seriesAsync({
		function(arg_128_0)
			self.mapBuilder:CallbackInvoke(arg_128_0)

			return
		end,
		function(arg_129_0)
			self.mapBuilder:UpdateMapVO(var_127_0)
			self.mapBuilder:UpdateView()
			self.mapBuilder:UpdateMapItems()
			self.mapBuilder:PlayEnterAnim()

			return
		end
	})

	return
end

function LevelScene:UpdateSwitchMapButton()
	local var_130_0 = getProxy(ChapterProxy)
	local var_130_1 = var_130_0:getMapById(self.contextData.map.id - 1)
	local var_130_2 = var_130_0:getMapById(self.contextData.map.id + 1)

	setActive(self.btnPrev, tobool(var_130_1))
	setActive(self.btnNext, tobool(var_130_2))

	local var_130_3 = Color.New(0.5, 0.5, 0.5, 1)

	setImageColor(self.btnPrevCol, (var_130_1 or nil) and (Color.white or var_130_3))
	setImageColor(self.btnNextCol, (var_130_2 and var_130_2:isUnlock() or nil) and (Color.white or var_130_3))

	return
end

function LevelScene:tryPlayMapStory()
	if IsUnityEditor and not ENABLE_GUIDE then
		return
	end

	seriesAsync({
		function(arg_132_0)
			local var_132_0 = self.contextData.map:getConfig("enter_story")

			if var_132_0 and var_132_0 ~= "" then
				if not pg.NewStoryMgr.GetInstance():IsPlayed(var_132_0) and not self.contextData.map:isRemaster() and not pg.SystemOpenMgr.GetInstance().active then
					local var_132_1 = tonumber(var_132_0)

					if var_132_1 and var_132_1 > 0 then
						self:emit(LevelMediator2.ON_PERFORM_COMBAT, var_132_1)
					else
						pg.NewStoryMgr.GetInstance():Play(var_132_0, arg_132_0)
					end

					return
				end
			end

			arg_132_0()

			return
		end,
		function(arg_133_0)
			local var_133_0 = self.contextData.map:getConfig("guide_id")

			if var_133_0 and var_133_0 ~= "" then
				pg.SystemGuideMgr.GetInstance():PlayByGuideId(var_133_0, nil, arg_133_0)

				return
			end

			arg_133_0()

			return
		end,
		function(arg_134_0)
			if isActive(self.actAtelierBuffBtn) then
				if getProxy(ActivityProxy):AtelierActivityAllSlotIsEmpty() then
					if getProxy(ActivityProxy):OwnAtelierActivityItemCnt(34, 1) then
						pg.SystemGuideMgr.GetInstance():PlayByGuideId("NG0034", PlayerPrefs.GetInt("first_enter_ryza_buff_" .. getProxy(PlayerProxy):getRawData().id, 0) == 0 and {
							1,
							2
						} or {
							1
						})

						goto label_134_0
					end
				end
			end

			arg_134_0()

			::label_134_0::

			return
		end,
		function(arg_135_0)
			if self.exited then
				return
			end

			pg.SystemOpenMgr.GetInstance():notification(self.player.level)

			if pg.SystemOpenMgr.GetInstance().active then
				getProxy(ChapterProxy):StopAutoFight()
			end

			return
		end
	})

	return
end

function LevelScene:DisplaySPAnim(arg_136_1, arg_136_2, arg_136_3)
	self.uiAnims = self.uiAnims or {}

	local var_136_0 = self.uiAnims[arg_136_1]

	local function var_136_1()
		self.playing = true

		self:frozen()
		var_136_0:SetActive(true)

		local var_137_0 = tf(var_136_0)

		pg.UIMgr.GetInstance():OverlayPanel(var_137_0)

		if arg_136_3 then
			arg_136_3(var_136_0)
		end

		var_137_0:GetComponent("DftAniEvent"):SetEndEvent(function(arg_138_0)
			self.playing = false

			if arg_136_2 then
				arg_136_2(var_136_0)
			end

			self:unfrozen()

			return
		end)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_WARNING)

		return
	end

	if not self.uiAnims[arg_136_1] then
		PoolMgr.GetInstance():GetUI(arg_136_1, true, function(arg_139_0)
			arg_139_0:SetActive(true)

			self.uiAnims[arg_136_1] = arg_139_0
			var_136_0 = self.uiAnims[arg_136_1]

			var_136_1()

			return
		end)
	else
		var_136_1()
	end

	return
end

function LevelScene:displaySpResult(arg_140_1, arg_140_2)
	setActive(self.spResult, true)
	self:DisplaySPAnim(arg_140_1 == 1 and "SpUnitWin" or "SpUnitLose", function(arg_141_0)
		onButton(self, arg_141_0, function()
			removeOnButton(arg_141_0)
			setActive(arg_141_0, false)
			pg.UIMgr.GetInstance():UnOverlayPanel(arg_141_0, self._tf)
			self:hideSpResult()
			arg_140_2()

			return
		end, SFX_PANEL)

		return
	end)

	return
end

function LevelScene:hideSpResult()
	setActive(self.spResult, false)

	return
end

function LevelScene:displayBombResult(arg_144_1)
	setActive(self.spResult, true)
	self:DisplaySPAnim("SpBombRet", function(arg_145_0)
		onButton(self, arg_145_0, function()
			removeOnButton(arg_145_0)
			setActive(arg_145_0, false)
			pg.UIMgr.GetInstance():UnOverlayPanel(arg_145_0, self._tf)
			self:hideSpResult()
			arg_144_1()

			return
		end, SFX_PANEL)

		return
	end, function(arg_147_0)
		setText(arg_147_0.transform:Find("right/name_bg/en"), self.contextData.chapterVO.modelCount)

		return
	end)

	return
end

function LevelScene:OnLevelInfoPanelConfirm(arg_148_1, arg_148_2)
	self.contextData.chapterLoopFlag = arg_148_2

	local var_148_0 = getProxy(ChapterProxy):getChapterById(arg_148_1, true)

	if var_148_0:getConfig("type") == Chapter.CustomFleet then
		self:displayFleetEdit(var_148_0)

		return
	end

	if #var_148_0:getNpcShipByType(1) > 0 then
		self:emit(LevelMediator2.ON_TRACKING, arg_148_1)

		return
	end

	self:displayFleetSelect(var_148_0)

	return
end

function LevelScene:DisplayLevelInfoPanel(arg_149_1, arg_149_2)
	seriesAsync({
		function(arg_150_0)
			if not self.levelInfoView:GetLoaded() then
				self:frozen()
				self.levelInfoView:Load()
				self.levelInfoView:CallbackInvoke(function()
					self:unfrozen()
					arg_150_0()

					return
				end)

				return
			end

			arg_150_0()

			return
		end,
		function(arg_152_0)
			local function var_152_0(arg_153_0, arg_153_1)
				self:hideChapterPanel()
				self:OnLevelInfoPanelConfirm(arg_153_0, arg_153_1)

				return
			end

			local var_152_1 = getProxy(ChapterProxy):getChapterById(arg_149_1, true)

			if getProxy(ChapterProxy):getMapById(var_152_1:getConfig("map")):isSkirmish() and #var_152_1:getNpcShipByType(1) > 0 then
				var_152_0(false)

				return
			end

			self.levelInfoView:set(arg_149_1, arg_149_2)
			self.levelInfoView:setCBFunc(var_152_0, function()
				self:hideChapterPanel()

				return
			end)
			self.levelInfoView:Show()

			return
		end
	})

	return
end

function LevelScene:hideChapterPanel()
	if self.levelInfoView:isShowing() then
		self.levelInfoView:Hide()
	end

	return
end

function LevelScene:destroyChapterPanel()
	self.levelInfoView:Destroy()

	self.levelInfoView = nil

	return
end

function LevelScene:DisplayLevelInfoSPPanel(arg_157_1, arg_157_2, arg_157_3)
	seriesAsync({
		function(arg_158_0)
			if not self.levelInfoSPView then
				self.levelInfoSPView = LevelInfoSPView.New(self.topPanel, self.event, self.contextData)

				self.levelInfoSPView:RegisterView(self)
				self:frozen()
				self.levelInfoSPView:Load()
				self.levelInfoSPView:CallbackInvoke(function()
					self:unfrozen()
					arg_158_0()

					return
				end)

				return
			end

			arg_158_0()

			return
		end,
		function(arg_160_0)
			self.levelInfoSPView:SetChapterGroupInfo(arg_157_2)
			self.levelInfoSPView:set(arg_157_1, arg_157_3)
			self.levelInfoSPView:setCBFunc(function(arg_161_0, arg_161_1)
				self:HideLevelInfoSPPanel()
				self:OnLevelInfoPanelConfirm(arg_161_0, arg_161_1)

				return
			end, function()
				self:HideLevelInfoSPPanel()

				return
			end)
			self.levelInfoSPView:Show()

			return
		end
	})

	return
end

function LevelScene:HideLevelInfoSPPanel()
	if self.levelInfoSPView and self.levelInfoSPView:isShowing() then
		self.levelInfoSPView:Hide()
	end

	return
end

function LevelScene:DestroyLevelInfoSPPanel()
	if not self.levelInfoSPView then
		return
	end

	self.levelInfoSPView:Destroy()

	self.levelInfoSPView = nil

	return
end

function LevelScene:displayFleetSelect(arg_165_1)
	local var_165_0 = self.contextData.selectedFleetIDs or arg_165_1:GetDefaultFleetIndex()

	arg_165_1 = Clone(arg_165_1)
	arg_165_1.loopFlag = self.contextData.chapterLoopFlag

	self.levelFleetView:updateSpecialOperationTickets(self.spTickets)
	self.levelFleetView:Load()
	self.levelFleetView:ActionInvoke("setHardShipVOs", self.shipVOs)
	self.levelFleetView:ActionInvoke("setOpenCommanderTag", self.openedCommanerSystem)
	self.levelFleetView:ActionInvoke("set", arg_165_1, self.fleets, var_165_0)
	self.levelFleetView:ActionInvoke("Show")

	return
end

function LevelScene:hideFleetSelect()
	if self.levelCMDFormationView:isShowing() then
		self.levelCMDFormationView:Hide()
	end

	if self.levelFleetView then
		self.levelFleetView:Hide()
	end

	return
end

function LevelScene:buildCommanderPanel()
	self.levelCMDFormationView = LevelCMDFormationView.New(self.topPanel, self.event, self.contextData)

	return
end

function LevelScene:destroyFleetSelect()
	if not self.levelFleetView then
		return
	end

	self.levelFleetView:Destroy()

	self.levelFleetView = nil

	return
end

function LevelScene:displayFleetEdit(arg_169_1)
	arg_169_1 = Clone(arg_169_1)
	arg_169_1.loopFlag = self.contextData.chapterLoopFlag

	self.levelFleetView:updateSpecialOperationTickets(self.spTickets)
	self.levelFleetView:Load()
	self.levelFleetView:ActionInvoke("setOpenCommanderTag", self.openedCommanerSystem)
	self.levelFleetView:ActionInvoke("setHardShipVOs", self.shipVOs)
	self.levelFleetView:ActionInvoke("setOnHard", arg_169_1)
	self.levelFleetView:ActionInvoke("Show")

	return
end

function LevelScene:hideFleetEdit()
	self:hideFleetSelect()

	return
end

function LevelScene:destroyFleetEdit()
	self:destroyFleetSelect()

	return
end

function LevelScene:RefreshFleetSelectView(arg_172_1)
	if not self.levelFleetView then
		return
	end

	assert(self.levelFleetView:GetLoaded())

	local var_172_0

	if self.levelFleetView:IsSelectMode() then
		self.levelFleetView:ActionInvoke("set", arg_172_1 or self.levelFleetView.chapter, self.fleets, self.levelFleetView:getSelectIds())

		if self.levelCMDFormationView:isShowing() then
			var_172_0 = self.fleets[self.levelCMDFormationView.fleet.id]
		end
	else
		self.levelFleetView:ActionInvoke("setOnHard", arg_172_1 or self.levelFleetView.chapter)

		if self.levelCMDFormationView:isShowing() then
			var_172_0 = arg_172_1:wrapEliteFleet(self.levelCMDFormationView.fleet.id)
		end
	end

	if var_172_0 then
		self.levelCMDFormationView:ActionInvoke("updateFleet", var_172_0)
	end

	return
end

function LevelScene:setChapter(arg_173_1)
	if arg_173_1 then
		self.contextData.chapterId = arg_173_1.id
	end

	self.contextData.chapterVO = arg_173_1

	return
end

function LevelScene:switchToChapter(arg_174_1)
	if self.contextData.mapIdx ~= arg_174_1:getConfig("map") then
		self:setMap(arg_174_1:getConfig("map"))
	end

	self:setChapter(arg_174_1)

	self.leftCanvasGroup.blocksRaycasts = false
	self.rightCanvasGroup.blocksRaycasts = false

	assert(not self.levelStageView, "LevelStageView Exists On SwitchToChapter")
	self:DestroyLevelStageView()

	if not self.levelStageView then
		self.levelStageView = LevelStageView.New(self.topPanel, self.event, self.contextData)

		self.levelStageView:Load()

		self.levelStageView.isFrozen = self:isfrozen()
	end

	self:frozen()
	self.levelStageView:ActionInvoke("SetSeriesOperation", function()
		seriesAsync({
			function(arg_176_0)
				self.mapBuilder:CallbackInvoke(arg_176_0)

				return
			end,
			function(arg_177_0)
				setActive(self.clouds, false)
				self.mapBuilder:HideFloat()
				self:BlurPanel(self.topPanel, {
					blurCamList = {
						pg.UIMgr.CameraUI
					}
				})
				self.levelStageView:updateStageInfo()
				self.levelStageView:updateAmbushRate(arg_174_1.fleet.line, true)
				self.levelStageView:updateStageAchieve()
				self.levelStageView:updateStageBarrier()
				self.levelStageView:updateBombPanel()
				self.levelStageView:UpdateDefenseStatus()
				onNextTick(arg_177_0)

				return
			end,
			function(arg_178_0)
				if self.exited then
					return
				end

				self.levelStageView:updateStageStrategy()

				self.canvasGroup.blocksRaycasts = self.frozenCount == 0

				onNextTick(arg_178_0)

				return
			end,
			function(arg_179_0)
				if self.exited then
					return
				end

				self.levelStageView:updateStageFleet()
				self.levelStageView:updateSupportFleet()
				self.levelStageView:updateFleetBuff()
				onNextTick(arg_179_0)

				return
			end,
			function(arg_180_0)
				if self.exited then
					return
				end

				parallelAsync({
					function(arg_181_0)
						local var_181_0 = arg_174_1:getConfig("scale")

						self:RecordTween("mapScale", LeanTween.value(go(self.map), self.map.localScale, Vector3.New(var_181_0[3], var_181_0[3], 1), var_0_1):setOnUpdateVector3(function(arg_182_0)
							self.map.localScale = arg_182_0
							self.float.localScale = arg_182_0

							return
						end):setOnComplete(System.Action(function()
							self.mapBuilder:ShowFloat()
							self.mapBuilder:Hide()
							arg_181_0()

							return
						end)):setEase(LeanTweenType.easeOutSine).uniqueId)

						local var_181_1 = LeanTween.value(go(self.map), self.map.pivot, Vector2.New(math.clamp(var_181_0[1] - 0.5, 0, 1), math.clamp(var_181_0[2] - 0.5, 0, 1)), var_0_1)

						var_181_1:setOnUpdateVector2(function(arg_184_0)
							self.map.pivot = arg_184_0
							self.float.pivot = arg_184_0

							return
						end):setEase(LeanTweenType.easeOutSine)
						self:RecordTween("mapPivot", var_181_1.uniqueId)
						shiftPanel(self.leftChapter, -self.leftChapter.rect.width - 200, 0, 0.3, 0, true, nil, LeanTweenType.easeOutSine)
						shiftPanel(self.rightChapter, self.rightChapter.rect.width + 200, 0, 0.3, 0, true, nil, LeanTweenType.easeOutSine)
						shiftPanel(self.topChapter, 0, self.topChapter.rect.height, 0.3, 0, true, nil, LeanTweenType.easeOutSine)
						self.levelStageView:ShiftStagePanelIn()

						return
					end,
					function(arg_185_0)
						self:PlayBGM()

						local var_185_0 = {}
						local var_185_1 = arg_174_1:getConfig("bg")

						if var_185_1 and #var_185_1 > 0 then
							var_185_0[1] = {
								BG = var_185_1
							}
						end

						self:SwitchBG(var_185_0, arg_185_0)

						return
					end
				}, function()
					onNextTick(arg_180_0)

					return
				end)

				return
			end,
			function(arg_187_0)
				if self.exited then
					return
				end

				setActive(self.topChapter, false)
				setActive(self.leftChapter, false)
				setActive(self.rightChapter, false)

				self.leftCanvasGroup.blocksRaycasts = true
				self.rightCanvasGroup.blocksRaycasts = true

				self:initGrid(arg_187_0)

				return
			end,
			function(arg_188_0)
				if self.exited then
					return
				end

				self.levelStageView:SetGrid(self.grid)

				self.contextData.huntingRangeVisibility = self.contextData.huntingRangeVisibility - 1

				self.grid:toggleHuntingRange()

				local var_188_0 = arg_174_1:getConfig("pop_pic")

				if var_188_0 and #var_188_0 > 0 and self.FirstEnterChapter == arg_174_1.id then
					self:doPlayAnim(var_188_0, function(arg_189_0)
						setActive(arg_189_0, false)

						if self.exited then
							return
						end

						arg_188_0()

						return
					end)
				else
					arg_188_0()
				end

				return
			end,
			function(arg_190_0)
				self.levelStageView:tryAutoAction(arg_190_0)

				return
			end,
			function(arg_191_0)
				if self.exited then
					return
				end

				self:unfrozen()

				if self.FirstEnterChapter then
					self:emit(LevelMediator2.ON_RESUME_SUBSTATE, arg_174_1.subAutoAttack)
				end

				self.FirstEnterChapter = nil

				arg_191_0()

				return
			end,
			function(arg_192_0)
				if arg_174_1:NeedSupportSubmarineStage() then
					self.levelStageView:TryEnterChapterSupportSubmarineStage(arg_192_0)
				else
					arg_192_0()
				end

				return
			end
		}, function()
			self.levelStageView:tryAutoTrigger(true)

			return
		end)

		return
	end)
	self.levelStageView:ActionInvoke("SetPlayer", self.player)
	self.levelStageView:ActionInvoke("SwitchToChapter", arg_174_1)

	return
end

function LevelScene:switchToMap(arg_194_1)
	self:frozen()
	self:destroyGrid()
	self:setChapter(nil)
	LeanTween.cancel(go(self.map))
	self:RecordTween("mapScale", LeanTween.value(go(self.map), self.map.localScale, Vector3.one, var_0_1):setOnUpdateVector3(function(arg_195_0)
		self.map.localScale = arg_195_0
		self.float.localScale = arg_195_0

		return
	end):setOnComplete(System.Action(function()
		self:unfrozen()
		self.mapBuilder:PlayEnterAnim()
		existCall(arg_194_1)

		return
	end)):setEase(LeanTweenType.easeOutSine).uniqueId)

	local var_194_0 = self.contextData.map:getConfig("anchor")
	local var_194_2 = LeanTween.value(go(self.map), self.map.pivot, var_194_0 == "" and Vector2(0.5, 0.5) or Vector2(unpack(var_194_0)), var_0_1)

	var_194_2:setOnUpdateVector2(function(arg_197_0)
		self.map.pivot = arg_197_0
		self.float.pivot = arg_197_0

		return
	end):setEase(LeanTweenType.easeOutSine)
	self:RecordTween("mapPivot", var_194_2.uniqueId)
	setActive(self.topChapter, true)
	setActive(self.leftChapter, true)
	setActive(self.rightChapter, true)
	shiftPanel(self.leftChapter, 0, 0, 0.3, 0, true, nil, LeanTweenType.easeOutSine)
	shiftPanel(self.rightChapter, 0, 0, 0.3, 0, true, nil, LeanTweenType.easeOutSine)
	shiftPanel(self.topChapter, 0, 0, 0.3, 0, true, nil, LeanTweenType.easeOutSine)
	assert(self.levelStageView, "LevelStageView Doesnt Exist On SwitchToMap")

	if self.levelStageView then
		self.levelStageView:ActionInvoke("ShiftStagePanelOut", function()
			self:DestroyLevelStageView()

			return
		end)
		self.levelStageView:ActionInvoke("SwitchToMap")
	end

	self:SwitchMapBG(self.contextData.map)
	self:PlayBGM()
	seriesAsync({
		function(arg_199_0)
			self.mapBuilder:CallbackInvoke(arg_199_0)

			return
		end,
		function(arg_200_0)
			self.mapBuilder:Show()
			self.mapBuilder:UpdateView()
			self.mapBuilder:UpdateMapItems()

			return
		end
	})
	self:UnOverlayPanel(self.topPanel, self._tf)

	self.canvasGroup.blocksRaycasts = self.frozenCount == 0
	self.canvasGroup.interactable = true

	if self.ambushWarning and self.ambushWarning.activeSelf then
		self.ambushWarning:SetActive(false)
		self:unfrozen()
	end

	return
end

function LevelScene:SwitchBG(arg_201_1, arg_201_2, arg_201_3)
	if not arg_201_1 or #arg_201_1 <= 0 then
		existCall(arg_201_2)

		return
	elseif arg_201_3 then
		-- block empty
	elseif table.equal(self.currentBG, arg_201_1) then
		return
	end

	self.currentBG = arg_201_1

	for iter_201_0, iter_201_1 in ipairs(self.mapGroup) do
		self.loader:ClearRequest(iter_201_1)
	end

	table.clear(self.mapGroup)

	local var_201_0 = {}

	table.ParallelIpairsAsync(arg_201_1, function(arg_202_0, arg_202_1, arg_202_2)
		table.insert(self.mapGroup, (self.loader:GetSpriteDirect(((arg_202_1.bgPrefix or nil) and (arg_202_1.bgPrefix .. "/" or "levelmap/")) .. arg_202_1.BG, "", function(arg_203_0)
			var_201_0[arg_202_0] = arg_203_0

			arg_202_2()

			return
		end, self.mapTFs[arg_202_0])))
		self:updateCouldAnimator(arg_202_1.Animator, arg_202_0)

		return
	end, function()
		for iter_204_0, iter_204_1 in ipairs(self.mapTFs) do
			setImageSprite(iter_204_1, var_201_0[iter_204_0])
			setActive(iter_204_1, arg_201_1[iter_204_0])
			SetCompomentEnabled(iter_204_1, typeof(Image), true)
		end

		existCall(arg_201_2)

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

function LevelScene:ClearMapTransitions()
	if not self.mapTransitions then
		return
	end

	for iter_205_0, iter_205_1 in pairs(self.mapTransitions) do
		if iter_205_1 then
			PoolMgr.GetInstance():ReturnPrefab("ui/" .. iter_205_0, iter_205_0, iter_205_1, true)
		else
			PoolMgr.GetInstance():DestroyPrefab("ui/" .. iter_205_0, iter_205_0)
		end
	end

	self.mapTransitions = nil

	return
end

function LevelScene:SwitchMapBG(arg_206_1, arg_206_2, arg_206_3)
	local var_206_0, var_206_1, var_206_2 = self:GetMapBG(arg_206_1, arg_206_2)
	local var_206_3 = {}

	if var_206_1 then
		table.insert(var_206_3, function(arg_207_0)
			self:PlayMapTransition("LevelMapTransition_" .. var_206_1, var_206_2, arg_207_0)

			return
		end)
	end

	seriesAsync(var_206_3, function()
		self:SwitchBGMapType(arg_206_1:getConfig("pos_type"))
		self:SwitchBG(var_206_0, nil, arg_206_3)

		return
	end)

	return
end

function LevelScene:SwitchBGMapType(arg_209_1)
	if self.posType == arg_209_1 then
		return
	end

	for iter_209_0, iter_209_1 in ipairs({
		self.map,
		self.float
	}) do
		local var_209_0 = GetOrAddComponent(iter_209_1, typeof(AspectRatioFitter))

		var_209_0.aspectRatio = 1.7777777777777777
		var_209_0.enabled = arg_209_1 == 0

		if arg_209_1 == 1 then
			iter_209_1.anchorMin = Vector2(0.5, 0.5)
			iter_209_1.anchorMax = Vector2(0.5, 0.5)

			setSizeDelta(var_209_0, {
				x = 2520,
				y = 1440
			})
		end
	end

	return
end

function LevelScene:GetMapBG(arg_210_1, arg_210_2)
	if not table.contains(var_0_7, arg_210_1.id) then
		return {
			self:GetMapElement(arg_210_1)
		}
	end

	local var_210_0 = arg_210_1.id
	local var_210_1 = table.indexof(var_0_7, arg_210_1.id) - 1
	local var_210_2 = bit.lshift(bit.rshift(var_210_1, 1), 1) + 1
	local var_210_3 = _.map({
		var_0_7[var_210_2],
		var_0_7[var_210_2 + 1]
	}, function(arg_211_0)
		return getProxy(ChapterProxy):getMapById(arg_211_0)
	end)

	if _.all(var_210_3, function(arg_212_0)
		return arg_212_0:isAllChaptersClear()
	end) then
		local var_210_4 = {
			self:GetMapElement(arg_210_1)
		}
		local var_210_6
		local var_210_5

		if not arg_210_2 or math.abs(var_210_0 - arg_210_2) ~= 1 then
			do return var_210_4 end

			var_210_5 = bit.band(var_210_1, 1) == 1
			var_210_6 = var_210_4
		end

		return var_210_6, var_0_9[bit.rshift(var_210_2 - 1, 1) + 1], var_210_5
	else
		local var_210_7 = 0

		;(function()
			for iter_213_0, iter_213_1 in ipairs((var_210_3[1]:getChapters())) do
				if not iter_213_1:isClear() then
					return
				end

				var_210_7 = var_210_7 + 1
			end

			if not var_210_3[2]:isAnyChapterUnlocked(true) then
				return
			end

			var_210_7 = var_210_7 + 1

			for iter_213_2, iter_213_3 in ipairs((var_210_3[2]:getChapters())) do
				if not iter_213_3:isClear() then
					return
				end

				var_210_7 = var_210_7 + 1
			end

			return
		end)()

		local var_210_8

		if var_210_7 > 0 then
			local var_210_9 = var_0_8[bit.rshift(var_210_2 - 1, 1) + 1]

			var_210_8 = {
				{
					BG = "map_" .. var_210_9[1],
					Animator = var_210_9[2]
				},
				{
					BG = "map_" .. var_210_9[3] + var_210_7,
					Animator = var_210_9[4]
				}
			}
		else
			var_210_8 = {
				self:GetMapElement(arg_210_1)
			}
		end

		return var_210_8
	end

	return
end

function LevelScene:GetMapElement(arg_214_1)
	local var_214_0 = arg_214_1:getConfig("bg")
	local var_214_1 = arg_214_1:getConfig("ani_controller")

	if var_214_1 and #var_214_1 > 0 then
		(function()
			local var_215_0 = getProxy(ChapterProxy)

			for iter_215_0, iter_215_1 in ipairs(var_214_1) do
				for iter_215_2, iter_215_3 in ipairs((_.rest(iter_215_1[2], 2))) do
					if string.find(iter_215_3, "^map_") and iter_215_1[1] == var_0_3 then
						local var_215_1 = false

						for iter_215_4, iter_215_5 in ipairs(iter_215_1[2][1]) do
							local var_215_2 = var_215_0:GetChapterItemById(iter_215_5)

							if var_215_2 and var_215_2:isClear() then
								var_215_1 = true

								break
							end
						end

						if not var_215_1 then
							var_214_0 = iter_215_3

							return
						end
					end
				end
			end

			return
		end)()
	end

	local var_214_2 = {
		BG = var_214_0
	}

	var_214_2.Animator, var_214_2.AnimatorController = self:GetMapAnimator(arg_214_1)

	return var_214_2
end

function LevelScene:GetMapAnimator(arg_216_1)
	local var_216_0 = arg_216_1:getConfig("ani_name")

	if arg_216_1:getConfig("animtor") == 1 and var_216_0 and #var_216_0 > 0 then
		local var_216_1 = arg_216_1:getConfig("ani_controller")

		if var_216_1 and #var_216_1 > 0 then
			(function()
				local var_217_0 = getProxy(ChapterProxy)

				for iter_217_0, iter_217_1 in ipairs(var_216_1) do
					for iter_217_2, iter_217_3 in ipairs((_.rest(iter_217_1[2], 2))) do
						if string.find(iter_217_3, "^effect_") and iter_217_1[1] == var_0_3 then
							local var_217_1 = false

							for iter_217_4, iter_217_5 in ipairs(iter_217_1[2][1]) do
								local var_217_2 = var_217_0:GetChapterItemById(iter_217_5)

								if var_217_2 and var_217_2:isClear() then
									var_217_1 = true

									break
								end
							end

							if not var_217_1 then
								var_216_0 = "map_" .. string.sub(iter_217_3, 8)

								return
							end
						end
					end
				end

				return
			end)()
		end

		return var_216_0, var_216_1
	end

	return
end

function LevelScene:PlayMapTransition(arg_218_1, arg_218_2, arg_218_3, arg_218_4)
	self.mapTransitions = self.mapTransitions or {}

	local var_218_0

	local function var_218_1()
		self:frozen()
		existCall(arg_218_3, var_218_0)
		var_218_0:SetActive(true)

		local var_219_0 = tf(var_218_0)

		pg.UIMgr.GetInstance():OverlayPanel(var_219_0)
		var_218_0:GetComponent(typeof(Animator)):Play(arg_218_2 and "Sequence" or "Inverted", -1, 0)
		var_219_0:GetComponent("DftAniEvent"):SetEndEvent(function(arg_220_0)
			pg.UIMgr.GetInstance():UnOverlayPanel(var_219_0, self._tf)
			existCall(arg_218_4, var_218_0)
			PoolMgr.GetInstance():ReturnPrefab("ui/" .. arg_218_1, arg_218_1, var_218_0)

			self.mapTransitions[arg_218_1] = false

			self:unfrozen()

			return
		end)

		return
	end

	PoolMgr.GetInstance():GetPrefab("ui/" .. arg_218_1, arg_218_1, true, function(arg_221_0)
		var_218_0 = arg_221_0
		self.mapTransitions[arg_218_1] = arg_221_0

		var_218_1()

		return
	end)

	return
end

function LevelScene:DestroyLevelStageView()
	if self.levelStageView then
		self.levelStageView:Destroy()

		self.levelStageView = nil
	end

	return
end

function LevelScene:displayAmbushInfo(arg_223_1)
	self.levelAmbushView = LevelAmbushView.New(self.topPanel, self.event, self.contextData)

	self.levelAmbushView:Load()
	self.levelAmbushView:ActionInvoke("SetFuncOnComplete", arg_223_1)

	return
end

function LevelScene:hideAmbushInfo()
	if self.levelAmbushView then
		self.levelAmbushView:Destroy()

		self.levelAmbushView = nil
	end

	return
end

function LevelScene:doAmbushWarning(arg_225_1)
	self:frozen()

	local function var_225_0()
		self.ambushWarning:SetActive(true)

		local var_226_0 = tf(self.ambushWarning)

		var_226_0:SetParent(pg.UIMgr.GetInstance().OverlayMain.transform, false)
		var_226_0:SetSiblingIndex(1)

		local var_226_1 = var_226_0:GetComponent("DftAniEvent")

		var_226_1:SetTriggerEvent(function(arg_227_0)
			arg_225_1()

			return
		end)
		var_226_1:SetEndEvent(function(arg_228_0)
			self.ambushWarning:SetActive(false)
			self:unfrozen()

			return
		end)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_WARNING)
		Timer.New(function()
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_WARNING)

			return
		end, 1, 1):Start()

		return
	end

	if not self.ambushWarning then
		PoolMgr.GetInstance():GetUI("ambushwarnui", true, function(arg_230_0)
			arg_230_0:SetActive(true)

			self.ambushWarning = arg_230_0

			var_225_0()

			return
		end)
	else
		var_225_0()
	end

	return
end

function LevelScene:destroyAmbushWarn()
	if self.ambushWarning then
		PoolMgr.GetInstance():ReturnUI("ambushwarnui", self.ambushWarning)

		self.ambushWarning = nil
	end

	return
end

function LevelScene:displayStrategyInfo(arg_232_1)
	self.levelStrategyView = LevelStrategyView.New(self.topPanel, self.event, self.contextData)

	self.levelStrategyView:Load()
	self.levelStrategyView:ActionInvoke("set", arg_232_1)
	self.levelStrategyView:ActionInvoke("setCBFunc", function()
		if not self.contextData.chapterVO.fleet:canUseStrategy(arg_232_1) then
			return
		end

		local var_233_0 = self.contextData.chapterVO.fleet:getNextStgUser(arg_232_1.id)

		if pg.strategy_data_template[arg_232_1.id].type == ChapterConst.StgTypeForm then
			self:emit(LevelMediator2.ON_OP, {
				type = ChapterConst.OpStrategy,
				id = var_233_0,
				arg1 = arg_232_1.id
			})
		elseif pg.strategy_data_template[arg_232_1.id].type == ChapterConst.StgTypeConsume then
			self:emit(LevelMediator2.ON_OP, {
				type = ChapterConst.OpStrategy,
				id = var_233_0,
				arg1 = arg_232_1.id
			})
		end

		self:hideStrategyInfo()

		return
	end, function()
		self:hideStrategyInfo()

		return
	end)

	return
end

function LevelScene:hideStrategyInfo()
	if self.levelStrategyView then
		self.levelStrategyView:Destroy()

		self.levelStrategyView = nil
	end

	return
end

function LevelScene:displayRepairWindow(arg_236_1)
	local var_236_0 = self.contextData.chapterVO
	local var_236_1 = getProxy(ChapterProxy).repairTimes
	local var_236_3, var_236_4, var_236_5 = ChapterConst.GetRepairParams()

	self.levelRepairView = LevelRepairView.New(self.topPanel, self.event, self.contextData)

	self.levelRepairView:Load()
	self.levelRepairView:ActionInvoke("set", var_236_1, nil, nil, nil)
	self.levelRepairView:ActionInvoke("setCBFunc", function()
		if var_236_3 - math.min(var_236_1, var_236_3) == 0 and self.player:getTotalGem() < var_236_5 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_rmb"))

			return
		end

		self:emit(LevelMediator2.ON_OP, {
			type = ChapterConst.OpRepair,
			id = var_236_0.fleet.id,
			arg1 = arg_236_1.id
		})
		self:hideRepairWindow()

		return
	end, function()
		self:hideRepairWindow()

		return
	end)

	return
end

function LevelScene:hideRepairWindow()
	if self.levelRepairView then
		self.levelRepairView:Destroy()

		self.levelRepairView = nil
	end

	return
end

function LevelScene:displayRemasterPanel(arg_240_1)
	self.levelRemasterView:Load()
	self.levelRemasterView:ActionInvoke("Show")
	self.levelRemasterView:ActionInvoke("set", function(arg_241_0)
		self:ShowSelectedMap(arg_241_0)

		return
	end, arg_240_1)

	return
end

function LevelScene:hideRemasterPanel()
	if self.levelRemasterView:isShowing() then
		self.levelRemasterView:ActionInvoke("Hide")
	end

	return
end

function LevelScene:initGrid(arg_243_1)
	if not self.contextData.chapterVO then
		return
	end

	self:enableLevelCamera()
	setActive(self.uiMain, true)

	self.levelGrid.localEulerAngles = Vector3(self.contextData.chapterVO.theme.angle, 0, 0)
	self.grid = LevelGrid.New(self.dragLayer)

	self.grid:attach(self)
	self.grid:ExtendItem("shipTpl", self.shipTpl)
	self.grid:ExtendItem("subTpl", self.subTpl)
	self.grid:ExtendItem("transportTpl", self.transportTpl)
	self.grid:ExtendItem("enemyTpl", self.enemyTpl)
	self.grid:ExtendItem("championTpl", self.championTpl)
	self.grid:ExtendItem("oniTpl", self.oniTpl)
	self.grid:ExtendItem("arrowTpl", self.arrowTarget)
	self.grid:ExtendItem("destinationMarkTpl", self.destinationMarkTpl)

	function self.grid.onShipStepChange(arg_244_0)
		self.levelStageView:updateAmbushRate(arg_244_0)

		return
	end

	self.grid:initAll(arg_243_1)

	return
end

function LevelScene:destroyGrid()
	if self.grid then
		self.grid:detach()

		self.grid = nil

		self:disableLevelCamera()
		setActive(self.dragLayer, true)
		setActive(self.uiMain, false)
	end

	return
end

function LevelScene:doTracking(arg_246_1)
	self:frozen()

	local function var_246_0()
		self.radar:SetActive(true)

		local var_247_0 = tf(self.radar)

		var_247_0:SetParent(self.topPanel, false)
		var_247_0:SetSiblingIndex(1)
		var_247_0:GetComponent("DftAniEvent"):SetEndEvent(function(arg_248_0)
			self.radar:SetActive(false)
			self:unfrozen()
			arg_246_1()

			return
		end)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_WEIGHANCHOR_SEARCH)

		return
	end

	if not self.radar then
		PoolMgr.GetInstance():GetUI("RadarEffectUI", true, function(arg_249_0)
			arg_249_0:SetActive(true)

			self.radar = arg_249_0

			var_246_0()

			return
		end)
	else
		var_246_0()
	end

	return
end

function LevelScene:destroyTracking()
	if self.radar then
		PoolMgr.GetInstance():ReturnUI("RadarEffectUI", self.radar)

		self.radar = nil
	end

	return
end

function LevelScene:doPlayAirStrike(arg_251_1, arg_251_2, arg_251_3)
	local function var_251_0()
		self.playing = true

		self:frozen()
		self.airStrike:SetActive(true)

		local var_252_0 = tf(self.airStrike)

		var_252_0:SetParent(pg.UIMgr.GetInstance().OverlayMain.transform, false)
		var_252_0:SetAsLastSibling()
		setActive(var_252_0:Find("words/be_striked"), arg_251_1 == ChapterConst.SubjectChampion)
		setActive(var_252_0:Find("words/strike_enemy"), arg_251_1 == ChapterConst.SubjectPlayer)

		local function var_252_1()
			self.playing = false

			SetActive(self.airStrike, false)

			if arg_251_3 then
				arg_251_3()
			end

			self:unfrozen()

			return
		end

		var_252_0:GetComponent("DftAniEvent"):SetEndEvent(var_252_1)

		if arg_251_2 then
			onButton(self, var_252_0, var_252_1, SFX_PANEL)
		else
			removeOnButton(var_252_0)
		end

		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_WARNING)

		return
	end

	if not self.airStrike then
		PoolMgr.GetInstance():GetUI("AirStrike", true, function(arg_254_0)
			arg_254_0:SetActive(true)

			self.airStrike = arg_254_0

			var_251_0()

			return
		end)
	else
		var_251_0()
	end

	return
end

function LevelScene:destroyAirStrike()
	if self.airStrike then
		self.airStrike:GetComponent("DftAniEvent"):SetEndEvent(nil)
		PoolMgr.GetInstance():ReturnUI("AirStrike", self.airStrike)

		self.airStrike = nil
	end

	return
end

function LevelScene:doPlayAnim(arg_256_1, arg_256_2, arg_256_3)
	self.uiAnims = self.uiAnims or {}

	local var_256_0 = self.uiAnims[arg_256_1]

	local function var_256_1()
		self.playing = true

		self:frozen()
		var_256_0:SetActive(true)

		local var_257_0 = tf(var_256_0)

		pg.UIMgr.GetInstance():OverlayPanel(var_257_0)

		if arg_256_3 then
			arg_256_3(var_256_0)
		end

		var_257_0:GetComponent("DftAniEvent"):SetEndEvent(function(arg_258_0)
			self.playing = false

			pg.UIMgr.GetInstance():UnOverlayPanel(var_257_0, self._tf)

			if arg_256_2 then
				arg_256_2(var_256_0)
			end

			self:unfrozen()

			return
		end)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_WARNING)

		return
	end

	if not self.uiAnims[arg_256_1] then
		PoolMgr.GetInstance():GetUI(arg_256_1, true, function(arg_259_0)
			arg_259_0:SetActive(true)

			self.uiAnims[arg_256_1] = arg_259_0
			var_256_0 = self.uiAnims[arg_256_1]

			var_256_1()

			return
		end)
	else
		var_256_1()
	end

	return
end

function LevelScene:destroyUIAnims()
	if self.uiAnims then
		for iter_260_0, iter_260_1 in pairs(self.uiAnims) do
			pg.UIMgr.GetInstance():UnOverlayPanel(tf(iter_260_1), self._tf)
			iter_260_1:GetComponent("DftAniEvent"):SetEndEvent(nil)
			PoolMgr.GetInstance():ReturnUI(iter_260_0, iter_260_1)
		end

		self.uiAnims = nil
	end

	return
end

function LevelScene:doPlayTorpedo(arg_261_1)
	local function var_261_0()
		self.playing = true

		self:frozen()
		self.torpetoAni:SetActive(true)

		local var_262_0 = tf(self.torpetoAni)

		var_262_0:SetParent(self.topPanel, false)
		var_262_0:SetAsLastSibling()
		var_262_0:GetComponent("DftAniEvent"):SetEndEvent(function(arg_263_0)
			self.playing = false

			SetActive(self.torpetoAni, false)

			if arg_261_1 then
				arg_261_1()
			end

			self:unfrozen()

			return
		end)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_WARNING)

		return
	end

	if not self.torpetoAni then
		PoolMgr.GetInstance():GetUI("Torpeto", true, function(arg_264_0)
			arg_264_0:SetActive(true)

			self.torpetoAni = arg_264_0

			var_261_0()

			return
		end)
	else
		var_261_0()
	end

	return
end

function LevelScene:destroyTorpedo()
	if self.torpetoAni then
		self.torpetoAni:GetComponent("DftAniEvent"):SetEndEvent(nil)
		PoolMgr.GetInstance():ReturnUI("Torpeto", self.torpetoAni)

		self.torpetoAni = nil
	end

	return
end

function LevelScene:doPlayStrikeAnim(arg_266_1, arg_266_2, arg_266_3)
	self.strikeAnims = self.strikeAnims or {}

	local var_266_0
	local var_266_1
	local var_266_2

	local function var_266_3()
		if coroutine.status(var_266_2) == "suspended" then
			local var_267_0, var_267_1 = coroutine.resume(var_266_2)

			assert(var_267_0, debug.traceback(var_266_2, var_267_1))
		end

		return
	end

	var_266_2 = coroutine.create(function()
		self.playing = true

		self:frozen()
		setActive(self.strikeAnims[arg_266_2], true)

		local var_268_0 = tf(self.strikeAnims[arg_266_2])
		local var_268_1 = findTF(var_268_0, "mask/painting")
		local var_268_2 = findTF(var_268_0, "ship")

		setParent(var_266_0, var_268_1:Find("fitter"), false)
		var_266_1:SetParent(var_268_2)
		setActive(var_268_2, false)
		setActive(findTF(var_268_0, "torpedo"), false)
		var_268_0:SetParent(pg.UIMgr.GetInstance().OverlayMain.transform, false)
		var_268_0:SetAsLastSibling()

		local var_268_3 = var_268_0:GetComponent("DftAniEvent")
		local var_268_4 = var_266_1:GetSkeletonGraphic()

		var_268_3:SetStartEvent(function(arg_269_0)
			var_266_1:SetAction("attack", 0)

			var_268_4.freeze = true

			return
		end)
		var_268_3:SetTriggerEvent(function(arg_270_0)
			var_268_4.freeze = false

			var_266_1:SetActionCallBack(function(arg_271_0)
				if arg_271_0 == "action" then
					-- block empty
				elseif arg_271_0 == "finish" then
					var_268_4.freeze = true
				end

				return
			end)

			return
		end)
		var_268_3:SetEndEvent(function(arg_272_0)
			var_268_4.freeze = false

			var_266_3()

			return
		end)
		onButton(self, var_268_0, var_266_3, SFX_CANCEL)
		coroutine.yield()
		retPaintingPrefab(var_268_1, arg_266_1:getPainting())
		var_266_1:SetActionCallBack(nil)

		var_268_4.freeze = false

		var_266_1:Dispose()
		setActive(self.strikeAnims[arg_266_2], false)

		self.playing = false

		self:unfrozen()

		if arg_266_3 then
			arg_266_3()
		end

		return
	end)

	local function var_266_4()
		if self.strikeAnims[arg_266_2] and var_266_0 and var_266_1 then
			var_266_3()
		end

		return
	end

	PoolMgr.GetInstance():GetPainting(arg_266_1:getPainting(), true, function(arg_274_0)
		var_266_0 = arg_274_0

		ShipExpressionHelper.SetExpression(var_266_0, arg_266_1:getPainting())
		var_266_4()

		return
	end)

	var_266_1 = SpineAnimChar.New()

	var_266_1:SetPaint(arg_266_1:getPrefab())
	var_266_1:Load(true, function(arg_275_0)
		var_266_1:SetLocalScale(Vector3.one)
		var_266_4()

		return
	end)

	if not self.strikeAnims[arg_266_2] then
		PoolMgr.GetInstance():GetUI(arg_266_2, true, function(arg_276_0)
			self.strikeAnims[arg_266_2] = arg_276_0

			var_266_4()

			return
		end)
	end

	return
end

function LevelScene:destroyStrikeAnim()
	if self.strikeAnims then
		for iter_277_0, iter_277_1 in pairs(self.strikeAnims) do
			iter_277_1:GetComponent("DftAniEvent"):SetEndEvent(nil)
			PoolMgr.GetInstance():ReturnUI(iter_277_0, iter_277_1)
		end

		self.strikeAnims = nil
	end

	return
end

function LevelScene:doPlayEnemyAnim(arg_278_1, arg_278_2, arg_278_3)
	self.strikeAnims = self.strikeAnims or {}

	local var_278_0
	local var_278_1

	local function var_278_2()
		if coroutine.status(var_278_1) == "suspended" then
			local var_279_0, var_279_1 = coroutine.resume(var_278_1)

			assert(var_279_0, debug.traceback(var_278_1, var_279_1))
		end

		return
	end

	var_278_1 = coroutine.create(function()
		self.playing = true

		self:frozen()
		setActive(self.strikeAnims[arg_278_2], true)

		local var_280_0 = tf(self.strikeAnims[arg_278_2])
		local var_280_1 = findTF(var_280_0, "ship")

		var_278_0:SetParent(var_280_1)
		setActive(var_280_1, false)
		setActive(findTF(var_280_0, "torpedo"), false)
		var_280_0:SetParent(pg.UIMgr.GetInstance().OverlayMain.transform, false)
		var_280_0:SetAsLastSibling()

		local var_280_2 = var_280_0:GetComponent("DftAniEvent")
		local var_280_3 = var_278_0:GetSkeletonGraphic()

		var_280_2:SetStartEvent(function(arg_281_0)
			var_278_0:SetAction("attack", 0)

			var_280_3.freeze = true

			return
		end)
		var_280_2:SetTriggerEvent(function(arg_282_0)
			var_280_3.freeze = false

			var_278_0:SetActionCallBack(function(arg_283_0)
				if arg_283_0 == "action" then
					-- block empty
				elseif arg_283_0 == "finish" then
					var_280_3.freeze = true
				end

				return
			end)

			return
		end)
		var_280_2:SetEndEvent(function(arg_284_0)
			var_280_3.freeze = false

			var_278_2()

			return
		end)
		onButton(self, var_280_0, var_278_2, SFX_CANCEL)
		coroutine.yield()
		var_278_0:SetActionCallBack(nil)

		var_280_3.freeze = false

		var_278_0:Dispose()
		setActive(self.strikeAnims[arg_278_2], false)

		self.playing = false

		self:unfrozen()

		if arg_278_3 then
			arg_278_3()
		end

		return
	end)

	local function var_278_3()
		if self.strikeAnims[arg_278_2] and var_278_0 then
			var_278_2()
		end

		return
	end

	var_278_0 = SpineAnimChar.New()

	;(nil):SetPaint(arg_278_1:getPrefab())
	var_278_0:Load(true, function(arg_286_0)
		arg_286_0:SetLocalScale(Vector3.one)
		var_278_3()

		return
	end)

	if not self.strikeAnims[arg_278_2] then
		PoolMgr.GetInstance():GetUI(arg_278_2, true, function(arg_287_0)
			self.strikeAnims[arg_278_2] = arg_287_0

			var_278_3()

			return
		end)
	end

	return
end

function LevelScene:doPlayCommander(arg_288_1, arg_288_2)
	self:frozen()
	setActive(self.commanderTinkle, true)

	local var_288_0 = arg_288_1:getSkills()

	setText(self.commanderTinkle:Find("name"), #var_288_0 > 0 and var_288_0[1]:getConfig("name") or "")
	setImageSprite(self.commanderTinkle:Find("icon"), GetSpriteFromAtlas("commanderhrz/" .. arg_288_1:getConfig("painting"), ""))

	local var_288_1 = self.commanderTinkle:GetComponent(typeof(CanvasGroup))

	var_288_1.alpha = 0

	local var_288_2 = Vector2(248, 237)

	LeanTween.value(go(self.commanderTinkle), 0, 1, 0.5):setOnUpdate(System.Action_float(function(arg_289_0)
		self.commanderTinkle.localPosition.x = var_288_2.x + 28 * (1 - arg_289_0)
		self.commanderTinkle.localPosition = self.commanderTinkle.localPosition
		var_288_1.alpha = arg_289_0

		return
	end)):setEase(LeanTweenType.easeOutSine)
	LeanTween.value(go(self.commanderTinkle), 0, 1, 0.3):setDelay(0.7):setOnUpdate(System.Action_float(function(arg_290_0)
		self.commanderTinkle.localPosition.x = var_288_2.x + 100 * arg_290_0
		self.commanderTinkle.localPosition = self.commanderTinkle.localPosition
		var_288_1.alpha = 1 - arg_290_0

		return
	end)):setOnComplete(System.Action(function()
		if arg_288_2 then
			arg_288_2()
		end

		self:unfrozen()

		return
	end))

	return
end

function LevelScene:strikeEnemy(arg_292_1, arg_292_2, arg_292_3)
	local var_292_0 = self.grid:shakeCell(arg_292_1)

	if not var_292_0 then
		arg_292_3()

		return
	end

	self:easeDamage(var_292_0, arg_292_2, function()
		arg_292_3()

		return
	end)

	return
end

function LevelScene:easeDamage(arg_294_1, arg_294_2, arg_294_3)
	self:frozen()

	local var_294_0 = tf(self:GetDamageText())

	var_294_0.position = self.uiCam:ScreenToWorldPoint((self.levelCam:WorldToScreenPoint(arg_294_1.position)))

	local var_294_1 = var_294_0.localPosition

	var_294_0.localPosition.y = var_294_0.localPosition.y + 40
	var_294_0.localPosition.z = 0

	setText(var_294_0, arg_294_2)

	var_294_0.localPosition = var_294_0.localPosition

	LeanTween.value(go(var_294_0), 0, 1, 1):setOnUpdate(System.Action_float(function(arg_295_0)
		var_294_0.localPosition.y = var_294_1.y + 60 * arg_295_0
		var_294_0.localPosition = var_294_0.localPosition

		setTextAlpha(var_294_0, 1 - arg_295_0)

		return
	end)):setOnComplete(System.Action(function()
		self:ReturnDamageText(var_294_0)
		self:unfrozen()

		if arg_294_3 then
			arg_294_3()
		end

		return
	end))

	return
end

function LevelScene:easeAvoid(arg_297_1, arg_297_2)
	self:frozen()

	self.avoidText.position = self.uiCam:ScreenToWorldPoint((self.levelCam:WorldToScreenPoint(arg_297_1)))

	local var_297_0 = self.avoidText.localPosition

	self.avoidText.localPosition.z = 0
	self.avoidText.localPosition = self.avoidText.localPosition

	setActive(self.avoidText, true)

	local var_297_1 = self.avoidText:Find("avoid")

	LeanTween.value(go(self.avoidText), 0, 1, 1):setOnUpdate(System.Action_float(function(arg_298_0)
		self.avoidText.localPosition.y = var_297_0.y + 100 * arg_298_0
		self.avoidText.localPosition = self.avoidText.localPosition

		setImageAlpha(self.avoidText, 1 - arg_298_0)
		setImageAlpha(var_297_1, 1 - arg_298_0)

		return
	end)):setOnComplete(System.Action(function()
		setActive(self.avoidText, false)
		self:unfrozen()

		if arg_297_2 then
			arg_297_2()
		end

		return
	end))

	return
end

function LevelScene:GetDamageText()
	local var_300_0 = table.remove(self.damageTextPool)

	if not var_300_0 then
		var_300_0 = Instantiate(self.damageTextTemplate)

		setParent(var_300_0, tf(self.damageTextTemplate).parent)
		tf(var_300_0):SetSiblingIndex(tf(self.damageTextTemplate):GetSiblingIndex() + 1)
	end

	table.insert(self.damageTextActive, var_300_0)
	setActive(var_300_0, true)

	return var_300_0
end

function LevelScene:ReturnDamageText(arg_301_1)
	assert(arg_301_1)

	if not arg_301_1 then
		return
	end

	arg_301_1 = go(arg_301_1)

	table.removebyvalue(self.damageTextActive, arg_301_1)
	table.insert(self.damageTextPool, arg_301_1)
	setActive(arg_301_1, false)

	return
end

function LevelScene:resetLevelGrid()
	self.dragLayer.localPosition = Vector3.zero

	return
end

function LevelScene:ShowCurtains(arg_303_1)
	setActive(self.curtain, arg_303_1)

	return
end

function LevelScene:frozen()
	self.frozenCount = self.frozenCount + 1
	self.canvasGroup.blocksRaycasts = self.frozenCount == 0

	if self.frozenCount == 0 and self.frozenCount ~= 0 then
		self:emit(LevelUIConst.ON_FROZEN)
	end

	return
end

function LevelScene:unfrozen(arg_305_1)
	if self.exited then
		return
	end

	self.frozenCount = self.frozenCount - ((arg_305_1 == -1 or nil) and (self.frozenCount or arg_305_1 or 1))
	self.canvasGroup.blocksRaycasts = self.frozenCount == 0

	if self.frozenCount ~= 0 and self.frozenCount == 0 then
		self:emit(LevelUIConst.ON_UNFROZEN)
	end

	return
end

function LevelScene:isfrozen()
	return self.frozenCount > 0
end

function LevelScene:enableLevelCamera()
	self.levelCamIndices = math.max(self.levelCamIndices - 1, 0)

	if self.levelCamIndices == 0 then
		self.levelCam.enabled = true

		pg.LayerWeightMgr.GetInstance():CreateRefreshHandler()
	end

	return
end

function LevelScene:disableLevelCamera()
	self.levelCamIndices = self.levelCamIndices + 1

	if self.levelCamIndices > 0 then
		self.levelCam.enabled = false

		pg.LayerWeightMgr.GetInstance():CreateRefreshHandler()
	end

	return
end

function LevelScene:RecordTween(arg_309_1, arg_309_2)
	self.tweens[arg_309_1] = arg_309_2

	return
end

function LevelScene:DeleteTween(arg_310_1)
	if self.tweens[arg_310_1] then
		LeanTween.cancel(self.tweens[arg_310_1])

		self.tweens[arg_310_1] = nil
	end

	return
end

function LevelScene:openCommanderPanel(arg_311_1, arg_311_2, arg_311_3)
	local var_311_0 = arg_311_2.id

	self.levelCMDFormationView:setCallback(function(arg_312_0)
		if not arg_311_3 then
			if arg_312_0.type == LevelUIConst.COMMANDER_OP_SHOW_SKILL then
				self:emit(LevelMediator2.ON_COMMANDER_SKILL, arg_312_0.skill)
			elseif arg_312_0.type == LevelUIConst.COMMANDER_OP_ADD then
				self.contextData.commanderSelected = {
					chapterId = var_311_0,
					fleetId = arg_311_1.id
				}

				self:emit(LevelMediator2.ON_SELECT_COMMANDER, arg_312_0.pos, arg_311_1.id, arg_311_2)
				self:closeCommanderPanel()
			else
				self:emit(LevelMediator2.ON_COMMANDER_OP, {
					FleetType = LevelUIConst.FLEET_TYPE_SELECT,
					data = arg_312_0,
					fleetId = arg_311_1.id,
					chapterId = var_311_0
				}, arg_311_2)
			end
		elseif arg_312_0.type == LevelUIConst.COMMANDER_OP_SHOW_SKILL then
			self:emit(LevelMediator2.ON_COMMANDER_SKILL, arg_312_0.skill)
		elseif arg_312_0.type == LevelUIConst.COMMANDER_OP_ADD then
			self.contextData.eliteCommanderSelected = {
				index = arg_311_3,
				pos = arg_312_0.pos,
				chapterId = var_311_0
			}

			self:emit(LevelMediator2.ON_SELECT_ELITE_COMMANDER, arg_311_3, arg_312_0.pos, arg_311_2)
			self:closeCommanderPanel()
		else
			self:emit(LevelMediator2.ON_COMMANDER_OP, {
				FleetType = LevelUIConst.FLEET_TYPE_EDIT,
				data = arg_312_0,
				index = arg_311_3,
				chapterId = var_311_0
			}, arg_311_2)
		end

		return
	end)
	self.levelCMDFormationView:Load()
	self.levelCMDFormationView:ActionInvoke("update", arg_311_1, self.commanderPrefabs)
	self.levelCMDFormationView:ActionInvoke("Show")

	return
end

function LevelScene:updateCommanderPrefab()
	if self.levelCMDFormationView:isShowing() then
		self.levelCMDFormationView:ActionInvoke("updatePrefabs", self.commanderPrefabs)
	end

	return
end

function LevelScene:closeCommanderPanel()
	self.levelCMDFormationView:ActionInvoke("Hide")

	return
end

function LevelScene:destroyCommanderPanel()
	self.levelCMDFormationView:Destroy()

	self.levelCMDFormationView = nil

	return
end

function LevelScene:setSpecialOperationTickets(arg_316_1)
	self.spTickets = arg_316_1

	return
end

function LevelScene:HandleShowMsgBox(arg_317_1)
	pg.MsgboxMgr.GetInstance():ShowMsgBox(arg_317_1)

	return
end

function LevelScene:updatePoisonAreaTip()
	local var_318_0 = self.contextData.chapterVO
	local var_318_1 = (function(arg_319_0)
		local var_319_0 = {}
		local var_319_1 = pg.map_event_list[var_318_0.id] or {}

		for iter_319_0, iter_319_1 in ipairs(var_318_0:isLoop() and (var_319_1.event_list_loop or {}) or var_319_1.event_list or {}) do
			if pg.map_event_template[iter_319_1].c_type == arg_319_0 then
				table.insert(var_319_0, pg.map_event_template[iter_319_1])
			end
		end

		return var_319_0
	end)(ChapterConst.EvtType_Poison)

	if var_318_1 then
		for iter_318_0, iter_318_1 in ipairs(var_318_1) do
			if iter_318_1.round_gametip ~= nil and iter_318_1.round_gametip ~= "" and self.contextData.chapterVO:getRoundNum() == iter_318_1.round_gametip[1] then
				pg.TipsMgr.GetInstance():ShowTips(i18n(iter_318_1.round_gametip[2]))
			end
		end
	end

	return
end

function LevelScene:updateVoteBookBtn()
	setActive(self._voteBookBtn, false)

	return
end

function LevelScene:RecordLastMapOnExit()
	local var_321_0 = getProxy(ChapterProxy)

	if var_321_0 and not self.contextData.noRecord then
		if not self.contextData.map then
			return
		end

		if self.contextData.map:NeedRecordMap() then
			var_321_0:recordLastMap(ChapterProxy.LAST_MAP, self.contextData.map.id)
		end

		if self.contextData.map:isActivity() and not self.contextData.map:isActExtra() then
			var_321_0:recordLastMap(ChapterProxy.LAST_MAP_FOR_ACTIVITY, self.contextData.map.id)
		end
	end

	return
end

function LevelScene:IsActShopActive()
	local var_322_0

	if self.contextData.map then
		var_322_0 = getProxy(ActivityProxy):getActivityById(self.contextData.map:getConfig("on_activity")) or nil
	end

	local var_322_1 = var_322_0 and not var_322_0:isEnd() and var_322_0:GetConfigClientSetting("PTID")
	local var_322_2 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_LOTTERY)

	if var_322_2 and not var_322_2:isEnd() and var_322_2:getConfig("config_client").resId == var_322_1 then
		return true
	end

	if _.detect(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_SHOP), function(arg_323_0)
		return not arg_323_0:isEnd() and arg_323_0:getConfig("config_client").pt_id == var_322_1
	end) then
		return true
	end

	return
end

function LevelScene:OnStartChapterAuto(arg_324_1)
	if self.levelInfoView:isShowing() then
		self:hideChapterPanel()
	end

	if self.levelInfoSPView and self.levelInfoSPView:isShowing() then
		self:HideLevelInfoSPPanel()
	end

	return
end

function LevelScene:OnEndChapterAuto(arg_325_1)
	return
end

function LevelScene:OnAddChapterAutoTimeDone()
	if self.levelInfoView:isShowing() then
		self.levelInfoView:RefreshChapterAutoPanel()
	end

	if self.levelInfoSPView and self.levelInfoSPView:isShowing() then
		self.levelInfoView:RefreshChapterAutoPanel()
	end

	return
end

function LevelScene:ShowChapterAutoDetailPanel(arg_327_1)
	self.chapterAutoDetailPanel:Load()
	self.chapterAutoDetailPanel:ActionInvoke("Enter", arg_327_1)

	return
end

function LevelScene:HideChapterAutoDetailPanel()
	if self.chapterAutoDetailPanel:isShowing() then
		self.chapterAutoDetailPanel:Hide()
	end

	return
end

function LevelScene:DestroyChapterAutoDetailPanel()
	if self.chapterAutoDetailPanel then
		self.chapterAutoDetailPanel:Destroy()

		self.chapterAutoDetailPanel = nil
	end

	return
end

function LevelScene:willExit()
	self:ClearMapTransitions()
	self.loader:Clear()

	if self.contextData.chapterVO then
		self:UnOverlayPanel(self.topPanel, self._tf)
	end

	if self.levelFleetView and self.levelFleetView.selectIds then
		self.contextData.selectedFleetIDs = {}

		for iter_330_0, iter_330_1 in pairs(self.levelFleetView.selectIds) do
			for iter_330_2, iter_330_3 in pairs(iter_330_1) do
				self.contextData.selectedFleetIDs[#self.contextData.selectedFleetIDs + 1] = iter_330_3
			end
		end
	end

	self:destroyChapterPanel()
	self:DestroyLevelInfoSPPanel()
	self:destroyFleetEdit()
	self:destroyCommanderPanel()
	self:DestroyLevelStageView()
	self:hideRepairWindow()
	self:hideStrategyInfo()
	self:hideRemasterPanel()
	self:hideSpResult()
	self:destroyGrid()
	self:destroyAmbushWarn()
	self:destroyAirStrike()
	self:destroyTorpedo()
	self:destroyStrikeAnim()
	self:destroyTracking()
	self:destroyUIAnims()
	self:DestroyChapterAutoDetailPanel()
	PoolMgr.GetInstance():DestroyPrefab("chapter/cell_quad_mark", "")
	PoolMgr.GetInstance():DestroyPrefab("chapter/cell_quad", "")
	PoolMgr.GetInstance():DestroyPrefab("chapter/cell", "")
	PoolMgr.GetInstance():DestroyPrefab("chapter/plane", "")

	for iter_330_4, iter_330_5 in pairs(self.mbDict) do
		iter_330_5:Destroy()
	end

	self.mbDict = nil

	for iter_330_6, iter_330_7 in pairs(self.tweens) do
		LeanTween.cancel(iter_330_7)
	end

	self.tweens = nil

	if self.cloudTimer then
		_.each(self.cloudTimer, function(arg_331_0)
			LeanTween.cancel(arg_331_0)

			return
		end)

		self.cloudTimer = nil
	end

	if self.newChapterCDTimer then
		self.newChapterCDTimer:Stop()

		self.newChapterCDTimer = nil
	end

	for iter_330_8, iter_330_9 in ipairs(self.damageTextActive) do
		LeanTween.cancel(iter_330_9)
	end

	LeanTween.cancel(go(self.avoidText))

	self.map.localScale = Vector3.one
	self.map.pivot = Vector2(0.5, 0.5)
	self.float.localScale = Vector3.one
	self.float.pivot = Vector2(0.5, 0.5)

	for iter_330_10, iter_330_11 in ipairs(self.mapTFs) do
		clearImageSprite(iter_330_11)
	end

	_.each(self.cloudRTFs, function(arg_332_0)
		clearImageSprite(arg_332_0)

		return
	end)
	Destroy(self.enemyTpl)
	self:RecordLastMapOnExit()
	self.levelRemasterView:Destroy()

	return
end

return LevelScene
