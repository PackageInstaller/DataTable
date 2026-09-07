local MapBuilderSPSeries = class("MapBuilderSPSeries", import(".MapBuilder"))

MapBuilderSPSeries.DISPLAY = {
	STORY = 2,
	BATTLE = 1
}
MapBuilderSPSeries.DIFFICULITY = {
	EASY = 1,
	HARD = 2
}

function MapBuilderSPSeries:GetType()
	return MapBuilder.TYPESPSERIES
end

function MapBuilderSPSeries:getUIName()
	return "LevelSelectSPSeriesUI"
end

function MapBuilderSPSeries:OnLoaded()
	setParent(self._tf, self._parentTf)
	self._tf:SetSiblingIndex(4)

	return
end

function MapBuilderSPSeries:OnInit()
	self.battleLayer = self._tf:Find("Battle")
	self.storyLayer = self._tf:Find("Story")
	self.top = self._tf:Find("Top")
	self.itemHolder = self._tf:Find("Battle/Nodes")
	self.chapterTpl = self.itemHolder:Find("LevelTpl")
	self.storyHolder = self._tf:Find("Story/Nodes")
	self.storyNodeTpl = self.storyHolder:Find("tpl")

	setActive(self.storyNodeTpl, false)

	self.progressText = self._tf:Find("Story/Desc/Text")
	self.storyAward = self._tf:Find("Story/Award")
	self.activeItems = {}
	self.displayChapterIDs = {}
	self.chapterTFsById = {}
	self.storyNodeTFsById = {}

	self:bind(LevelUIConst.SWITCH_SPCHAPTER_DIFFICULTY, function(arg_5_0, arg_5_1)
		self:SwitchChapter(arg_5_1)

		return
	end)
	onButton(self, self.battleLayer:Find("Story/Switch"), function()
		self:SetDisplayMode(MapBuilderSPSeries.DISPLAY.STORY)

		return
	end, SFX_PANEL)
	onButton(self, self.storyLayer:Find("Battle/Switch"), function()
		self:SetDisplayMode(MapBuilderSPSeries.DISPLAY.BATTLE)

		return
	end, SFX_PANEL)
	setText(self.storyLayer:Find("Desc/Desc"), i18n("series_enemy_storyreward"))

	return
end

function MapBuilderSPSeries:OnShow()
	MapBuilderSPSeries.super.OnShow(self)
	setActive(self.sceneParent.mainLayer:Find("title_chapter_lines"), true)
	setActive(self.sceneParent.topChapter:Find("title_chapter"), true)
	setActive(self.sceneParent.topChapter:Find("type_chapter"), true)

	self.needFocusStory = true

	return
end

function MapBuilderSPSeries:UpdateButtons()
	MapBuilderSPSeries.super.UpdateButtons(self)

	local var_9_0, var_9_1 = self.contextData.map:isActivity()
	local var_9_2 = self.contextData.map:isRemaster()
	local var_9_3 = self.contextData.displayMode == MapBuilderSPSeries.DISPLAY.BATTLE

	setActive(self.sceneParent.actExchangeShopBtn, not ActivityConst.HIDE_PT_PANELS and var_9_3 and not var_9_2 and var_9_1 and self.sceneParent:IsActShopActive())

	local var_9_6

	if self.contextData.map then
		var_9_6 = getProxy(ActivityProxy):getActivityById(self.contextData.map:getConfig("on_activity")) or nil
	end

	local var_9_7 = var_9_6 and not var_9_6:isEnd() and var_9_6:GetConfigClientSetting("PTID")

	self.sceneParent:updatePtActivity(underscore.detect(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_PT_RANK), function(arg_10_0)
		return arg_10_0:getConfig("config_id") == var_9_7
	end))

	local var_9_8 = setActive
	local var_9_9 = self.sceneParent.ptTotal

	if not ActivityConst.HIDE_PT_PANELS and not var_9_2 then
		local var_9_10

		if var_9_1 then
			::label_9_0::

			var_9_10 = self.sceneParent.ptActivity
			var_9_10 = self.sceneParent.ptActivity and (not self.sceneParent.ptActivity:isEnd() and var_9_3 or false) or true
		end
	end

	var_9_8(var_9_9, var_9_10)

	return
end

function MapBuilderSPSeries:OnHide()
	setActive(self.sceneParent.mainLayer:Find("title_chapter_lines"), false)
	setActive(self.sceneParent.topChapter:Find("title_chapter"), false)
	setActive(self.sceneParent.topChapter:Find("type_chapter"), false)
	setActive(self.sceneParent.ptTotal, false)
	setActive(self.sceneParent.actExchangeShopBtn, false)
	MapBuilderSPSeries.super.OnHide(self)

	return
end

function MapBuilderSPSeries:UpdateMapVO(arg_12_1)
	MapBuilderSPSeries.super.UpdateMapVO(self, arg_12_1)

	self.activity = getProxy(ActivityProxy):getActivityById(arg_12_1:getConfig("on_activity"))

	local var_12_0 = getProxy(PlayerProxy):getRawData().id

	self.chapterGroups = _.map(arg_12_1:getConfig("chapterGroups"), function(arg_13_0)
		return {
			list = arg_13_0,
			index = PlayerPrefs.GetInt("spchapter_selected_" .. var_12_0 .. "_" .. arg_13_0[1], MapBuilderSPSeries.DIFFICULITY.EASY)
		}
	end)
	self.chapterGroupDict = {}

	_.each(self.chapterGroups, function(arg_14_0)
		_.each(arg_14_0.list, function(arg_15_0)
			self.chapterGroupDict[arg_15_0] = arg_14_0

			return
		end)

		return
	end)

	self.displayChapterIDs = _.map(self.chapterGroups, function(arg_16_0)
		return arg_16_0.list[arg_16_0.index]
	end)
	self.storyNodesDict = {}

	for iter_12_0, iter_12_1 in ipairs(self.activity:getConfig("config_client").storys) do
		self.storyNodesDict[iter_12_1] = BossRushStoryNode.New({
			id = iter_12_1
		})

		local var_12_1 = self.storyHolder:Find(tostring(iter_12_1)) or cloneTplTo(self.storyNodeTpl, self.storyHolder, iter_12_1)
		local var_12_2 = self.storyNodesDict[iter_12_1]:getConfigTable()

		setLocalPosition(var_12_1, {
			x = 0 * tonumber(var_12_2.pos_x),
			y = 1080 * tonumber(var_12_2.pos_y)
		})
	end

	return
end

function MapBuilderSPSeries:UpdateBonusPtIconPath()
	self.bonusPtIconPath = nil

	local var_17_0 = self.data or self.contextData.map

	if not var_17_0 then
		return
	end

	local var_17_1 = var_17_0:getConfig("on_activity")

	if not var_17_1 or var_17_1 == 0 then
		return
	end

	local var_17_2 = getProxy(ActivityProxy)
	local var_17_3 = var_17_2:getActivityById(var_17_1)

	if not var_17_3 or var_17_3:isEnd() then
		return
	end

	local var_17_4 = var_17_3:GetConfigClientSetting("PTID")

	if not var_17_4 then
		return
	end

	local var_17_5 = underscore.detect(var_17_2:getActivitiesByType(ActivityConst.ACTIVITY_TYPE_PT_RANK), function(arg_18_0)
		return arg_18_0 and not arg_18_0:isEnd() and arg_18_0:getConfig("config_id") == var_17_4
	end)

	if not var_17_5 then
		return
	end

	local var_17_6 = tonumber(var_17_5:getConfig("config_id"))

	if not var_17_6 then
		return
	end

	self.bonusPtIconPath = Drop.New({
		type = DROP_TYPE_RESOURCE,
		id = var_17_6
	}):getIcon()

	return
end

function MapBuilderSPSeries:SetDisplayMode(arg_19_1)
	if arg_19_1 == self.contextData.displayMode then
		return
	end

	self.contextData.displayMode = arg_19_1

	self:UpdateView()

	return
end

function MapBuilderSPSeries:UpdateView()
	local var_20_0 = string.split(self.contextData.map:getConfig("name"), "||")

	if self.contextData.displayMode == MapBuilderSPSeries.DISPLAY.STORY then
		var_20_0 = string.split(var_20_0[1], "·")

		setText(self.sceneParent.chapterName, var_20_0[1] .. i18n("levelscene_title_story"))
	else
		setText(self.sceneParent.chapterName, var_20_0[1])
	end

	self.sceneParent.loader:GetSpriteQuiet("chapterno", "chapter" .. self.contextData.map:getMapTitleNumber(), self.sceneParent.chapterNoTitle, true)

	self.contextData.displayMode = self.contextData.displayMode or MapBuilderSPSeries.DISPLAY.BATTLE

	MapBuilderSPSeries.super.UpdateView(self)

	local var_20_1 = self.contextData.displayMode == MapBuilderSPSeries.DISPLAY.BATTLE

	setActive(self._tf:Find("Battle"), self.contextData.displayMode == MapBuilderSPSeries.DISPLAY.BATTLE)
	setActive(self._tf:Find("Story"), not var_20_1)

	local var_20_2 = getProxy(ChapterProxy):IsActivitySPChapterActive(self.contextData.map:getConfig("on_activity"))

	var_20_2 = var_20_2 and SettingsProxy.IsShowActivityMapSPTip()

	setActive(self.battleLayer:Find("Story/BattleTip"), false)
	setActive(self.storyLayer:Find("Battle/BattleTip"), var_20_2)
	self:UpdateStoryTask()

	if var_20_1 then
		self:UpdateBonusPtIconPath()
		self:UpdateBattle()
		self.sceneParent:SwitchMapBG(self.contextData.map)
		self.sceneParent:PlayBGM()
	else
		self:UpdateStory()
		self:SwitchStoryMapAndBGM()
	end

	self:TrySubmitTask()

	return
end

function MapBuilderSPSeries:UpdateBattle()
	local var_21_0 = getProxy(ChapterProxy)
	local var_21_1 = {}

	for iter_21_0, iter_21_1 in ipairs(self.displayChapterIDs) do
		table.insert(var_21_1, (var_21_0:getChapterById(iter_21_1)))
	end

	table.clear(self.chapterTFsById)
	UIItemList.StaticAlign(self.itemHolder, self.chapterTpl, #var_21_1, function(arg_22_0, arg_22_1, arg_22_2)
		if arg_22_0 ~= UIItemList.EventUpdate then
			return
		end

		local var_22_0 = var_21_1[arg_22_1 + 1]

		self:UpdateMapItem(arg_22_2, var_21_1[arg_22_1 + 1])

		arg_22_2.name = "Chapter_" .. var_22_0.id
		self.chapterTFsById[var_22_0.id] = arg_22_2

		return
	end)

	return
end

function MapBuilderSPSeries:HideFloat()
	MapBuilderSPSeries.super.HideFloat(self)
	setActive(self.itemHolder, false)

	return
end

function MapBuilderSPSeries:ShowFloat()
	MapBuilderSPSeries.super.ShowFloat(self)
	setActive(self.itemHolder, true)

	return
end

function MapBuilderSPSeries:UpdateMapItem(arg_25_1, arg_25_2)
	local var_25_0 = arg_25_2:getConfigTable()

	warning(0 * var_25_0.pos_x, 1080 * var_25_0.pos_y)
	setLocalPosition(arg_25_1, {
		x = 0 * var_25_0.pos_x,
		y = 1080 * var_25_0.pos_y
	})

	local var_25_1 = findTF(arg_25_1, "main")

	setActive(var_25_1, true)

	local var_25_2 = findTF(var_25_1, "info/bk/fordark")

	setActive(findTF(var_25_1, "circle/fordark"), var_25_0.icon_outline == 1)
	setActive(var_25_2, var_25_0.icon_outline == 1)

	local var_25_3 = self.chapterGroupDict[arg_25_2.id]

	assert(self.chapterGroupDict[arg_25_2.id])

	local var_25_4 = {
		"Lock",
		"Normal",
		"Hard"
	}
	local var_25_5 = 1

	if arg_25_2:isUnlock() then
		var_25_5 = 2

		if #self.chapterGroupDict[arg_25_2.id].list > 1 then
			var_25_5 = table.indexof(self.chapterGroupDict[arg_25_2.id].list, arg_25_2.id) + 1
		elseif arg_25_2:IsSpChapter() or arg_25_2:IsEXChapter() then
			var_25_5 = 3
		elseif self.contextData.map:isHardMap() then
			var_25_5 = 3
		end
	end

	local var_25_6 = findTF(var_25_1, "circle/bk")

	for iter_25_0, iter_25_1 in ipairs(var_25_4) do
		setActive(var_25_6:Find(iter_25_1), iter_25_0 == var_25_5)
	end

	local var_25_7 = findTF(var_25_1, "circle/clear_flag")
	local var_25_8 = findTF(var_25_1, "circle/lock")
	local var_25_9 = findTF(var_25_1, "circle/progress_text")
	local var_25_10 = findTF(var_25_1, "circle/stars")
	local var_25_11 = string.split(var_25_0.name, "|")

	setText(findTF(var_25_1, "info/bk/title_form/title_index"), var_25_0.chapter_name .. "  ")
	setText(findTF(var_25_1, "info/bk/title_form/title"), var_25_11[1])
	setText(findTF(var_25_1, "info/bk/title_form/title_en"), var_25_11[2] or "")
	setFillAmount(findTF(var_25_1, "circle/progress"), arg_25_2.progress / 100)
	setText(var_25_9, string.format("%d%%", arg_25_2.progress))
	setActive(var_25_10, arg_25_2:existAchieve())

	if arg_25_2:existAchieve() then
		for iter_25_2, iter_25_3 in ipairs(arg_25_2.achieves) do
			local var_25_12 = var_25_10:GetChild(iter_25_2 - 1):Find("light")

			setActive(var_25_12, (ChapterConst.IsAchieved(iter_25_3)))

			for iter_25_4, iter_25_5 in ipairs(var_25_4) do
				if iter_25_5 ~= "Lock" then
					setActive(var_25_12:Find(iter_25_5), iter_25_4 == var_25_5)
				end
			end
		end
	end

	local var_25_13 = findTF(var_25_1, "info/bk/BG")

	for iter_25_6, iter_25_7 in ipairs(var_25_4) do
		setActive(var_25_13:Find(iter_25_7), iter_25_6 == var_25_5)
	end

	setActive(findTF(var_25_1, "HardEffect"), var_25_5 == 3)

	local var_25_14 = not arg_25_2.active and arg_25_2:isClear()
	local var_25_15 = not arg_25_2.active and not arg_25_2:isUnlock()

	setActive(var_25_7, var_25_14)
	setActive(var_25_8, var_25_15)
	setActive(var_25_9, not var_25_14 and not var_25_15)
	self:DeleteTween("fighting" .. arg_25_2.id)

	local var_25_16 = findTF(var_25_1, "circle/fighting")

	setText(findTF(var_25_16, "Text"), i18n("tag_level_fighting"))

	local var_25_17 = findTF(var_25_1, "circle/oni")

	setText(findTF(var_25_17, "Text"), i18n("tag_level_oni"))

	local var_25_18 = findTF(var_25_1, "circle/narrative")

	setText(findTF(var_25_18, "Text"), i18n("tag_level_narrative"))
	setActive(var_25_16, false)
	setActive(var_25_17, false)
	setActive(var_25_18, false)

	local var_25_19

	if arg_25_2:getConfig("chapter_tag") == 1 then
		var_25_19 = var_25_18
	end

	if arg_25_2.active then
		var_25_19 = arg_25_2:existOni() and var_25_17 or var_25_16
	end

	if var_25_19 then
		setActive(var_25_19, true)

		local var_25_21 = GetOrAddComponent(var_25_19, "CanvasGroup")

		var_25_21.alpha = 1

		self:RecordTween("fighting" .. arg_25_2.id, LeanTween.alphaCanvas(var_25_21, 0, 0.5):setFrom(1):setEase(LeanTweenType.easeInOutSine):setLoopPingPong().uniqueId)
	end

	local var_25_22 = findTF(var_25_1, "triesLimit")
	local var_25_23 = arg_25_2:isTriesLimit()

	setActive(var_25_22, var_25_23)

	if var_25_23 then
		local var_25_24 = arg_25_2:getConfig("count")

		setText(var_25_22:Find("label"), i18n("levelScene_chapter_count_tip"))

		local var_25_25 = setText

		var_25_25(var_25_22:Find("Text"), setColorStr(var_25_24 - arg_25_2:getTodayDefeatCount() .. "/" .. var_25_24, (var_25_24 <= arg_25_2:getTodayDefeatCount() or nil) and (COLOR_RED or COLOR_GREEN)))

		local var_25_29 = getProxy(ChapterProxy):IsActivitySPChapterActive(pg.expedition_data_by_map[arg_25_2:getConfig("map")].on_activity)

		var_25_29 = var_25_29 and SettingsProxy.IsShowActivityMapSPTip()

		setActive(var_25_22:Find("TipRect"), var_25_29)
	end

	local var_25_30 = arg_25_2:GetDailyBonusQuota()
	local var_25_31 = findTF(var_25_1, "mark")
	local var_25_32 = var_25_31:Find("bonus")
	local var_25_33 = var_25_32:Find("icon")
	local var_25_34 = findTF(var_25_32, "icon/Image")

	setActive(var_25_32, var_25_30)
	setActive(var_25_31, var_25_30)

	if var_25_33 then
		setActive(var_25_33, var_25_30 and self.bonusPtIconPath)
	end

	if var_25_30 then
		local var_25_35 = var_25_31:GetComponent(typeof(CanvasGroup))

		self.sceneParent.loader:GetSprite("ui/levelmainscene_atlas", arg_25_2:GetDailyBonusIconName(), var_25_32)

		if var_25_33 and self.bonusPtIconPath then
			if var_25_34 then
				GetImageSpriteFromAtlasAsync(self.bonusPtIconPath, "", var_25_34, true)
			else
				GetImageSpriteFromAtlasAsync(self.bonusPtIconPath, "", var_25_33, true)
			end
		end

		LeanTween.cancel(go(var_25_31), true)

		local var_25_36 = var_25_31.anchoredPosition.y

		var_25_35.alpha = 0

		LeanTween.value(go(var_25_31), 0, 1, 0.2):setOnUpdate(System.Action_float(function(arg_26_0)
			var_25_35.alpha = arg_26_0
			var_25_31.anchoredPosition.y = var_25_36 * arg_26_0
			var_25_31.anchoredPosition = var_25_31.anchoredPosition

			return
		end)):setOnComplete(System.Action(function()
			var_25_35.alpha = 1
			var_25_31.anchoredPosition.y = var_25_36
			var_25_31.anchoredPosition = var_25_31.anchoredPosition

			return
		end)):setEase(LeanTweenType.easeOutSine):setDelay(0.7)
	end

	local var_25_37 = arg_25_2.id

	onButton(self, var_25_1, function()
		self:TryOpenChapterInfo(var_25_37, nil, var_25_3.list)

		return
	end, SFX_UI_WEIGHANCHOR_SELECT)
	self:PlayerLevelTplAnimation(arg_25_1, {
		status = var_25_4[var_25_5],
		chapterVO = arg_25_2
	})

	return
end

function MapBuilderSPSeries:PlayerLevelTplAnimation(arg_29_1, arg_29_2)
	return
end

function MapBuilderSPSeries:SwitchChapter(arg_30_1)
	if not self.chapterGroupDict[arg_30_1] then
		return
	end

	local var_30_0 = self.chapterGroupDict[arg_30_1].list[self.chapterGroupDict[arg_30_1].index]

	if self.chapterGroupDict[arg_30_1].list[self.chapterGroupDict[arg_30_1].index] == arg_30_1 then
		return
	end

	local var_30_1 = table.indexof(self.chapterGroupDict[arg_30_1].list, arg_30_1)

	self.chapterGroupDict[arg_30_1].index = var_30_1

	PlayerPrefs.SetInt("spchapter_selected_" .. getProxy(PlayerProxy):getRawData().id .. "_" .. self.chapterGroupDict[arg_30_1].list[1], var_30_1)

	self.chapterTFsById[var_30_0] = nil
	self.chapterTFsById[arg_30_1] = self.chapterTFsById[var_30_0]

	self:UpdateChapterTF(arg_30_1)

	return
end

function MapBuilderSPSeries:UpdateChapterTF(arg_31_1)
	if not self.chapterGroupDict[arg_31_1] then
		return
	end

	if self.chapterTFsById[arg_31_1] then
		self:UpdateMapItem(self.chapterTFsById[arg_31_1], (getProxy(ChapterProxy):getChapterById(arg_31_1)))
	end

	return
end

function MapBuilderSPSeries:UpdateStory()
	local var_32_1 = pg.NewStoryMgr.GetInstance()
	local var_32_2 = 0
	local var_32_3 = 0

	for iter_32_0, iter_32_1 in pairs(self.storyNodesDict) do
		local var_32_4 = self.storyHolder:Find(tostring(iter_32_1.id))

		setActive(var_32_4, (iter_32_1:IsActive(self.activity, self.sceneParent.ptActivity)))
		setText(var_32_4:Find("main/char/bg/Text"), iter_32_1:GetName())

		local var_32_5 = iter_32_1:IsReaded()

		setActive(var_32_4:Find("main/char"), not var_32_5)
		setActive(var_32_4:Find("main/talk"), var_32_5)
		onButton(self, var_32_4, function()
			if var_32_5 then
				return
			end

			self:PlayStory(iter_32_1:GetStory(), function()
				self:UpdateView()

				return
			end)

			return
		end)

		var_32_2 = var_32_2 + (var_32_5 and 1 or 0)
		var_32_3 = var_32_3 + 1
	end

	setText(self.progressText, var_32_2 .. "/" .. var_32_3)
	setActive(self.storyAward, tobool(self.storyTask))

	if self.storyTask then
		local var_32_6 = Drop.Create(self.storyTask:getConfig("award_display")[1])

		updateDrop(self.storyAward:GetChild(0), var_32_6)

		local var_32_7 = self.storyTask:getTaskStatus()

		setActive(self.storyAward:Find("get"), var_32_7 == 1)
		setActive(self.storyAward:Find("got"), var_32_7 == 2)
		onButton(self, self.storyAward, function()
			self:emit(BaseUI.ON_DROP, var_32_6)

			return
		end)
	end

	return
end

function MapBuilderSPSeries:SwitchStoryMapAndBGM()
	local var_36_0 = self.data:getConfig("default_background")
	local var_36_1 = self.data:getConfig("default_bgm")
	local var_36_2
	local var_36_3 = underscore.keys(self.storyNodesDict)

	table.sort(var_36_3)

	for iter_36_0 = 1, #var_36_3 do
		if self.storyNodesDict[var_36_3[iter_36_0]]:IsReaded() then
			var_36_0 = defaultValue(self.storyNodesDict[var_36_3[iter_36_0]]:GetCleanBG(), var_36_0)
			var_36_1 = defaultValue(self.storyNodesDict[var_36_3[iter_36_0]]:GetCleanBGM(), var_36_1)
			var_36_2 = defaultValue(self.storyNodesDict[var_36_3[iter_36_0]]:GetCleanAnimator(), var_36_2)
		else
			break
		end
	end

	self.sceneParent:SwitchBG({
		{
			bgPrefix = "bg",
			BG = var_36_0,
			Animator = var_36_2
		}
	})
	pg.BgmMgr.GetInstance():Push(self.__cname, var_36_1)

	return
end

function MapBuilderSPSeries:TrySubmitTask()
	if underscore.all(underscore.values(self.storyNodesDict), function(arg_38_0)
		return arg_38_0:IsReaded()
	end) and self.storyTask and self.storyTask:getTaskStatus() == 1 then
		self:emit(LevelMediator2.ON_SUBMIT_TASK, self.storyTask.id)

		return
	end

	return
end

function MapBuilderSPSeries:TryOpenChapter(arg_39_1)
	if self.chapterTFsById[arg_39_1] then
		triggerButton((self.chapterTFsById[arg_39_1]:Find("main")))
	end

	return
end

function MapBuilderSPSeries:PlayStory(arg_40_1, arg_40_2, arg_40_3)
	if not arg_40_1 then
		return existCall(arg_40_2)
	end

	local var_40_0 = pg.NewStoryMgr.GetInstance()
	local var_40_1 = var_40_0:IsPlayed(arg_40_1)

	seriesAsync({
		function(arg_41_0)
			if var_40_1 and not arg_40_3 then
				return arg_41_0()
			end

			local var_41_0 = tonumber(arg_40_1)

			if var_41_0 and var_41_0 > 0 then
				self:emit(LevelMediator2.ON_PERFORM_COMBAT, var_41_0, nil, var_40_1)
			else
				var_40_0:Play(arg_40_1, arg_41_0, arg_40_3)
			end

			return
		end,
		function(arg_42_0, ...)
			existCall(arg_40_2, ...)

			return
		end
	})

	return
end

function MapBuilderSPSeries:UpdateStoryTask()
	local var_43_0 = self.activity:getConfig("config_client").task_id
	local var_43_1 = getProxy(TaskProxy):getTaskVO(var_43_0)

	if not var_43_1 then
		errorMsg("Missing Activity Task ID : " .. var_43_0)
	end

	print(var_43_0)

	self.storyTask = var_43_1 or Task.New({
		id = var_43_0
	})

	return
end

function MapBuilderSPSeries:OnSubmitTaskDone()
	self:UpdateView()

	return
end

function MapBuilderSPSeries:OnDestroy()
	return
end

return MapBuilderSPSeries
