local MapBuilderSP = class("MapBuilderSP", import(".MapBuilder"))
local PoolPlural = import("Mgr/Pool/PoolPlural")

MapBuilderSP.DISPLAY = {
	STORY = 2,
	BATTLE = 1
}
MapBuilderSP.DIFFICULITY = {
	EASY = 1,
	HARD = 2
}

function MapBuilderSP:GetType()
	return MapBuilder.TYPESP
end

function MapBuilderSP:getUIName()
	return "LevelSelectSPUI"
end

function MapBuilderSP:OnLoaded()
	setParent(self._tf, self._parentTf)
	self._tf:SetSiblingIndex(4)

	return
end

function MapBuilderSP:OnInit()
	self.battleLayer = self._tf:Find("Battle")
	self.storyLayer = self._tf:Find("Story")
	self.top = self._tf:Find("Top")
	self.itemHolder = self._tf:Find("Battle/Nodes")
	self.chapterTpl = self.itemHolder:Find("LevelTpl")
	self.storyHolder = self._tf:Find("Story/Nodes")
	self.storyContainer = self.storyHolder:Find("Viewport/Content")
	self.nodes = {}
	self.progressText = self._tf:Find("Story/Desc/Text")
	self.storyAward = self._tf:Find("Story/Award")
	self.storyNodeTpl = self._tf:Find("Story/NodeTemplate")
	self.oneLineTpl = self._tf:Find("Story/OneLine")
	self.branchHeadTpl = self._tf:Find("Story/BranchHead")
	self.branchCenterTpl = self._tf:Find("Story/BranchCenter")
	self.branchUpTpl = self._tf:Find("Story/BranchUp")
	self.branchDownTpl = self._tf:Find("Story/BranchDown")
	self.unionTailTpl = self._tf:Find("Story/UnionTail")
	self.unionCenterTpl = self._tf:Find("Story/UnionCenter")
	self.unionUpTpl = self._tf:Find("Story/UnionUp")
	self.unionDownTpl = self._tf:Find("Story/UnionDown")
	self.unreleasedNodeTpl = self._tf:Find("Story/UnreleasedNode")

	setActive(self.storyNodeTpl, false)
	setActive(self.oneLineTpl, false)
	setActive(self.branchHeadTpl, false)
	setActive(self.branchCenterTpl, false)
	setActive(self.branchUpTpl, false)
	setActive(self.branchDownTpl, false)
	setActive(self.unionTailTpl, false)
	setActive(self.unionCenterTpl, false)
	setActive(self.unionUpTpl, false)
	setActive(self.unionDownTpl, false)
	setActive(self.unreleasedNodeTpl, false)

	self.pools = {
		[self.storyNodeTpl] = PoolPlural.New(go(self.storyNodeTpl), 0),
		[self.oneLineTpl] = PoolPlural.New(go(self.oneLineTpl), 0),
		[self.branchHeadTpl] = PoolPlural.New(go(self.branchHeadTpl), 0),
		[self.branchCenterTpl] = PoolPlural.New(go(self.branchCenterTpl), 0),
		[self.branchUpTpl] = PoolPlural.New(go(self.branchUpTpl), 0),
		[self.branchDownTpl] = PoolPlural.New(go(self.branchDownTpl), 0),
		[self.unionTailTpl] = PoolPlural.New(go(self.unionTailTpl), 0),
		[self.unionCenterTpl] = PoolPlural.New(go(self.unionCenterTpl), 0),
		[self.unionUpTpl] = PoolPlural.New(go(self.unionUpTpl), 0),
		[self.unionDownTpl] = PoolPlural.New(go(self.unionDownTpl), 0)
	}
	self.nodeTplWidth = self.storyNodeTpl.rect.width
	self.oneLineWidth = self.oneLineTpl.rect.width
	self.oneLineHeight = self.oneLineTpl.rect.height
	self.branchHeadWidth = self.branchHeadTpl.rect.width
	self.branchUpWidth = self.branchUpTpl.rect.width
	self.branchUpHeight = self.branchUpTpl.rect.height
	self.UnionTailWidth = self.unionTailTpl.rect.width
	self.activeItems = {}
	self.displayChapterIDs = {}
	self.chapterTFsById = {}
	self.storyNodeTFsById = {}

	self:bind(LevelUIConst.SWITCH_SPCHAPTER_DIFFICULTY, function(arg_5_0, arg_5_1)
		self:SwitchChapter(arg_5_1)

		return
	end)
	onButton(self, self.battleLayer:Find("Mask/Story/Switch"), function()
		self:SetDisplayMode(MapBuilderSP.DISPLAY.STORY)

		self.needFocusStory = true

		self:Move2UnlockStory()

		return
	end, SFX_PANEL)
	onButton(self, self.storyLayer:Find("Battle/Switch"), function()
		self:SetDisplayMode(MapBuilderSP.DISPLAY.BATTLE)

		return
	end, SFX_PANEL)
	setText(self.storyLayer:Find("Desc/Desc"), i18n("series_enemy_storyreward"))

	return
end

function MapBuilderSP:OnShow()
	MapBuilderSP.super.OnShow(self)
	setActive(self.sceneParent.mainLayer:Find("title_chapter_lines"), true)
	setActive(self.sceneParent.topChapter:Find("title_chapter"), true)
	setActive(self.sceneParent.topChapter:Find("type_chapter"), true)

	self.needFocusStory = true

	return
end

function MapBuilderSP:UpdateButtons()
	MapBuilderSP.super.UpdateButtons(self)

	local var_9_0, var_9_1 = self.contextData.map:isActivity()
	local var_9_2 = self.contextData.map:isRemaster()

	if var_9_2 then
		self.sceneParent:updateRemasterInfo()
	end

	local var_9_3 = self.contextData.displayMode == MapBuilderSP.DISPLAY.BATTLE

	setActive(self.sceneParent.actExchangeShopBtn, not ActivityConst.HIDE_PT_PANELS and var_9_3 and not var_9_2 and var_9_1 and self.sceneParent:IsActShopActive())

	local var_9_6

	if self.contextData.map then
		var_9_6 = getProxy(ActivityProxy):getActivityById(self.contextData.map:getConfig("on_activity")) or nil
	end

	local var_9_7 = var_9_6 and not var_9_6:isEnd() and var_9_6:GetConfigClientSetting("PTID")

	self.sceneParent:updatePtActivity(underscore.detect(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_PT_RANK), function(arg_10_0)
		return arg_10_0:getConfig("config_id") == var_9_7
	end))
	setActive(self.sceneParent.rightChapter:Find("event_btns/tickets"), var_9_2)
	self.sceneParent:updateRemasterTicket()

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

function MapBuilderSP:OnHide()
	setActive(self.sceneParent.mainLayer:Find("title_chapter_lines"), false)
	setActive(self.sceneParent.topChapter:Find("title_chapter"), false)
	setActive(self.sceneParent.topChapter:Find("type_chapter"), false)
	setActive(self.sceneParent.ptTotal, false)
	setActive(self.sceneParent.actExchangeShopBtn, false)
	MapBuilderSP.super.OnHide(self)

	return
end

function MapBuilderSP:UpdateMapVO(arg_12_1)
	MapBuilderSP.super.UpdateMapVO(self, arg_12_1)

	self.activity = getProxy(ActivityProxy):getActivityById(arg_12_1:getConfig("on_activity"))

	local var_12_0 = getProxy(PlayerProxy):getRawData().id

	self.chapterGroups = _.map(arg_12_1:getConfig("chapterGroups"), function(arg_13_0)
		return {
			list = arg_13_0,
			index = PlayerPrefs.GetInt("spchapter_selected_" .. var_12_0 .. "_" .. arg_13_0[1], MapBuilderSP.DIFFICULITY.EASY)
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

	self:BuildStoryTree()

	return
end

function MapBuilderSP:UpdateBonusPtIconPath()
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

function MapBuilderSP:BuildStoryTree()
	self.spStoryIDs = self.data:getConfig("story_id")
	self.spStoryNodeDict = {}
	self.spStoryNodes = {}
	self.spStoryUnreleasedNode = nil

	local var_19_0 = {}

	_.each(self.spStoryIDs, function(arg_20_0)
		local var_20_0 = ActivitySpStoryNode.New({
			configId = arg_20_0
		})

		if var_20_0:GetType() ~= ActivitySpStoryNode.NODE_TYPE.UNRELEASED then
			self.spStoryNodeDict[arg_20_0] = var_20_0

			local var_20_1 = var_19_0[self.spStoryNodeDict[arg_20_0]:GetPreEvent()] or {}

			table.insert(var_20_1, arg_20_0)

			var_19_0[self.spStoryNodeDict[arg_20_0]:GetPreEvent()] = var_20_1
		else
			self.spStoryUnreleasedNode = var_20_0
		end

		return
	end)

	local var_19_1 = 0

	while (function()
		if not var_19_0[var_19_1] then
			return
		end

		tailList = var_19_0[var_19_1]

		local var_21_0

		_.each(tailList, function(arg_22_0)
			table.insert(self.spStoryNodes, self.spStoryNodeDict[arg_22_0])

			if var_19_0[arg_22_0] then
				var_21_0 = true
				var_19_1 = arg_22_0
			end

			return
		end)

		return nil
	end)() do
		-- block empty
	end

	local var_19_2 = {}
	local var_19_3

	_.each(self.spStoryNodes, function(arg_23_0)
		local var_23_0 = arg_23_0:GetPreNodes()

		if #var_23_0 == 0 then
			var_19_3 = arg_23_0

			return
		end

		_.each(var_23_0, function(arg_24_0)
			var_19_2[arg_24_0] = var_19_2[arg_24_0] or {}

			table.insert(var_19_2[arg_24_0], arg_23_0)

			return
		end)

		return
	end)

	self.storyTree = {
		root = nil,
		childDict = var_19_2
	}

	return
end

function MapBuilderSP:SetDisplayMode(arg_25_1)
	if arg_25_1 == self.contextData.displayMode then
		return
	end

	self.contextData.displayMode = arg_25_1

	self:UpdateView()

	return
end

function MapBuilderSP:UpdateView()
	local var_26_0 = self.contextData.map
	local var_26_1 = string.split(self.contextData.map:getConfig("name"), "||")

	if self.contextData.displayMode == MapBuilderSP.DISPLAY.STORY then
		var_26_1 = string.split(var_26_1[1], "·")

		setText(self.sceneParent.chapterName, var_26_1[1] .. i18n("levelscene_title_story"))
	else
		setText(self.sceneParent.chapterName, var_26_1[1])
	end

	self.sceneParent.loader:GetSpriteQuiet("chapterno", "chapter" .. var_26_0:getMapTitleNumber(), self.sceneParent.chapterNoTitle, true)

	self.contextData.displayMode = self.contextData.displayMode or MapBuilderSP.DISPLAY.BATTLE

	MapBuilderSP.super.UpdateView(self)

	local var_26_2 = self.contextData.displayMode == MapBuilderSP.DISPLAY.BATTLE

	setActive(self._tf:Find("Battle"), self.contextData.displayMode == MapBuilderSP.DISPLAY.BATTLE)
	setActive(self._tf:Find("Story"), not var_26_2)

	local var_26_3 = getProxy(ChapterProxy):IsActivitySPChapterActive(var_26_0:getConfig("on_activity"))

	var_26_3 = var_26_3 and SettingsProxy.IsShowActivityMapSPTip()

	setActive(self.battleLayer:Find("Mask/Story/BattleTip"), false)
	setActive(self.storyLayer:Find("Battle/BattleTip"), var_26_3)

	if type(self.spStoryIDs) ~= "table" or #self.spStoryIDs == 0 then
		local var_26_4 = var_26_0:isRemaster()

		if var_26_4 then
			setActive(self.battleLayer:Find("Mask"), false)

			local var_26_5, var_26_6 = var_26_0:isActivity()

			setActive(self.sceneParent.remasterBtn, OPEN_REMASTER and (var_26_4 or not var_26_5 and not var_26_0:isEscort() and not var_26_0:isSkirmish()))
		else
			self.battleLayer:Find("Mask"):GetComponent(typeof(RectMask2D)).enabled = true
		end
	end

	self:UpdateStoryTask()

	if var_26_2 then
		self:UpdateBonusPtIconPath()
		self:UpdateBattle()
		self.sceneParent:SwitchMapBG(self.contextData.map)
		pg.BgmMgr.GetInstance():Pop(self.__cname)
		self.sceneParent:PlayBGM()
	else
		self:UpdateStoryNodeStatus()
		self:UpdateStory()
		self:Move2UnlockStory()
		self:SwitchStoryMapAndBGM()
	end

	self:TrySubmitTask()

	return
end

function MapBuilderSP:UpdateBattle()
	local var_27_0 = getProxy(ChapterProxy)
	local var_27_1 = {}

	for iter_27_0, iter_27_1 in ipairs(self.displayChapterIDs) do
		table.insert(var_27_1, (var_27_0:getChapterById(iter_27_1)))
	end

	table.clear(self.chapterTFsById)
	UIItemList.StaticAlign(self.itemHolder, self.chapterTpl, #var_27_1, function(arg_28_0, arg_28_1, arg_28_2)
		if arg_28_0 ~= UIItemList.EventUpdate then
			return
		end

		local var_28_0 = var_27_1[arg_28_1 + 1]

		self:UpdateMapItem(arg_28_2, var_27_1[arg_28_1 + 1])

		arg_28_2.name = "Chapter_" .. var_28_0.id
		self.chapterTFsById[var_28_0.id] = arg_28_2

		return
	end)

	return
end

function MapBuilderSP:HideFloat()
	MapBuilderSP.super.HideFloat(self)
	setActive(self.itemHolder, false)

	return
end

function MapBuilderSP:ShowFloat()
	MapBuilderSP.super.ShowFloat(self)
	setActive(self.itemHolder, true)

	return
end

function MapBuilderSP:UpdateMapItem(arg_31_1, arg_31_2)
	local var_31_0 = arg_31_2:getConfigTable()

	setLocalPosition(arg_31_1, {
		x = 0 * var_31_0.pos_x,
		y = 1080 * var_31_0.pos_y
	})

	local var_31_1 = findTF(arg_31_1, "main")

	setActive(var_31_1, true)

	local var_31_2 = findTF(var_31_1, "info/bk/fordark")

	setActive(findTF(var_31_1, "circle/fordark"), var_31_0.icon_outline == 1)
	setActive(var_31_2, var_31_0.icon_outline == 1)

	local var_31_3 = self.chapterGroupDict[arg_31_2.id]

	assert(self.chapterGroupDict[arg_31_2.id])

	local var_31_4 = {
		"Lock",
		"Normal",
		"Hard"
	}
	local var_31_5 = 1

	if arg_31_2:isUnlock() then
		var_31_5 = 2

		if #self.chapterGroupDict[arg_31_2.id].list > 1 then
			var_31_5 = table.indexof(self.chapterGroupDict[arg_31_2.id].list, arg_31_2.id) + 1
		elseif arg_31_2:IsSpChapter() or arg_31_2:IsEXChapter() then
			var_31_5 = 3
		elseif self.contextData.map:isHardMap() then
			var_31_5 = 3
		end
	end

	local var_31_6 = findTF(var_31_1, "circle/bk")

	for iter_31_0, iter_31_1 in ipairs(var_31_4) do
		setActive(var_31_6:Find(iter_31_1), iter_31_0 == var_31_5)
	end

	local var_31_7 = findTF(var_31_1, "circle/clear_flag")
	local var_31_8 = findTF(var_31_1, "circle/lock")
	local var_31_9 = findTF(var_31_1, "circle/progress_text")
	local var_31_10 = findTF(var_31_1, "circle/stars")
	local var_31_11 = string.split(var_31_0.name, "|")

	setText(findTF(var_31_1, "info/bk/title_form/title_index"), var_31_0.chapter_name .. "  ")
	setText(findTF(var_31_1, "info/bk/title_form/title"), var_31_11[1])
	setText(findTF(var_31_1, "info/bk/title_form/title_en"), var_31_11[2] or "")
	setFillAmount(findTF(var_31_1, "circle/progress"), arg_31_2.progress / 100)
	setText(var_31_9, string.format("%d%%", arg_31_2.progress))
	setActive(var_31_10, arg_31_2:existAchieve())

	if arg_31_2:existAchieve() then
		for iter_31_2, iter_31_3 in ipairs(arg_31_2.achieves) do
			local var_31_12 = var_31_10:GetChild(iter_31_2 - 1):Find("light")

			setActive(var_31_12, (ChapterConst.IsAchieved(iter_31_3)))

			for iter_31_4, iter_31_5 in ipairs(var_31_4) do
				if iter_31_5 ~= "Lock" then
					setActive(var_31_12:Find(iter_31_5), iter_31_4 == var_31_5)
				end
			end
		end
	end

	local var_31_13 = findTF(var_31_1, "info/bk/BG")

	for iter_31_6, iter_31_7 in ipairs(var_31_4) do
		setActive(var_31_13:Find(iter_31_7), iter_31_6 == var_31_5)
	end

	setActive(findTF(var_31_1, "HardEffect"), var_31_5 == 3)

	local var_31_14 = not arg_31_2.active and arg_31_2:isClear()
	local var_31_15 = not arg_31_2.active and not arg_31_2:isUnlock()

	setActive(var_31_7, var_31_14)
	setActive(var_31_8, var_31_15)
	setActive(var_31_9, not var_31_14 and not var_31_15)
	self:DeleteTween("fighting" .. arg_31_2.id)

	local var_31_16 = findTF(var_31_1, "circle/fighting")

	setText(findTF(var_31_16, "Text"), i18n("tag_level_fighting"))

	local var_31_17 = findTF(var_31_1, "circle/oni")

	setText(findTF(var_31_17, "Text"), i18n("tag_level_oni"))

	local var_31_18 = findTF(var_31_1, "circle/narrative")

	setText(findTF(var_31_18, "Text"), i18n("tag_level_narrative"))
	setActive(var_31_16, false)
	setActive(var_31_17, false)
	setActive(var_31_18, false)

	local var_31_19

	if arg_31_2:getConfig("chapter_tag") == 1 then
		var_31_19 = var_31_18
	end

	if arg_31_2.active then
		var_31_19 = arg_31_2:existOni() and var_31_17 or var_31_16
	end

	if var_31_19 then
		setActive(var_31_19, true)

		local var_31_21 = GetOrAddComponent(var_31_19, "CanvasGroup")

		var_31_21.alpha = 1

		self:RecordTween("fighting" .. arg_31_2.id, LeanTween.alphaCanvas(var_31_21, 0, 0.5):setFrom(1):setEase(LeanTweenType.easeInOutSine):setLoopPingPong().uniqueId)
	end

	local var_31_22 = findTF(var_31_1, "triesLimit")
	local var_31_23 = arg_31_2:isTriesLimit()

	setActive(var_31_22, var_31_23)

	if var_31_23 then
		local var_31_24 = arg_31_2:getConfig("count")

		setText(var_31_22:Find("label"), i18n("levelScene_chapter_count_tip"))

		local var_31_25 = setText

		var_31_25(var_31_22:Find("Text"), setColorStr(var_31_24 - arg_31_2:getTodayDefeatCount() .. "/" .. var_31_24, (var_31_24 <= arg_31_2:getTodayDefeatCount() or nil) and (COLOR_RED or COLOR_GREEN)))

		local var_31_29 = getProxy(ChapterProxy):IsActivitySPChapterActive(pg.expedition_data_by_map[arg_31_2:getConfig("map")].on_activity)

		var_31_29 = var_31_29 and SettingsProxy.IsShowActivityMapSPTip()

		setActive(var_31_22:Find("TipRect"), var_31_29)
	end

	local var_31_30 = arg_31_2:GetDailyBonusQuota()
	local var_31_31 = findTF(var_31_1, "mark")
	local var_31_32 = var_31_31:Find("bonus")
	local var_31_33 = var_31_32:Find("icon")
	local var_31_34 = findTF(var_31_32, "icon/Image")

	setActive(var_31_32, var_31_30)
	setActive(var_31_31, var_31_30)

	if var_31_33 then
		setActive(var_31_33, var_31_30 and self.bonusPtIconPath)
	end

	if var_31_30 then
		local var_31_35 = var_31_31:GetComponent(typeof(CanvasGroup))

		self.sceneParent.loader:GetSprite("ui/levelmainscene_atlas", arg_31_2:GetDailyBonusIconName(), var_31_32)

		if var_31_33 and self.bonusPtIconPath then
			if var_31_34 then
				GetImageSpriteFromAtlasAsync(self.bonusPtIconPath, "", var_31_34, true)
			else
				GetImageSpriteFromAtlasAsync(self.bonusPtIconPath, "", var_31_33, true)
			end
		end

		LeanTween.cancel(go(var_31_31), true)

		local var_31_36 = var_31_31.anchoredPosition.y

		var_31_35.alpha = 0

		LeanTween.value(go(var_31_31), 0, 1, 0.2):setOnUpdate(System.Action_float(function(arg_32_0)
			var_31_35.alpha = arg_32_0
			var_31_31.anchoredPosition.y = var_31_36 * arg_32_0
			var_31_31.anchoredPosition = var_31_31.anchoredPosition

			return
		end)):setOnComplete(System.Action(function()
			var_31_35.alpha = 1
			var_31_31.anchoredPosition.y = var_31_36
			var_31_31.anchoredPosition = var_31_31.anchoredPosition

			return
		end)):setEase(LeanTweenType.easeOutSine):setDelay(0.7)
	end

	local var_31_37 = arg_31_2.id

	onButton(self, var_31_1, function()
		self:TryOpenChapterInfo(var_31_37, nil, var_31_3.list)

		return
	end, SFX_UI_WEIGHANCHOR_SELECT)

	return
end

function MapBuilderSP:SwitchChapter(arg_35_1)
	if not self.chapterGroupDict[arg_35_1] then
		return
	end

	local var_35_0 = self.chapterGroupDict[arg_35_1].list[self.chapterGroupDict[arg_35_1].index]

	if self.chapterGroupDict[arg_35_1].list[self.chapterGroupDict[arg_35_1].index] == arg_35_1 then
		return
	end

	local var_35_1 = table.indexof(self.chapterGroupDict[arg_35_1].list, arg_35_1)

	self.chapterGroupDict[arg_35_1].index = var_35_1

	PlayerPrefs.SetInt("spchapter_selected_" .. getProxy(PlayerProxy):getRawData().id .. "_" .. self.chapterGroupDict[arg_35_1].list[1], var_35_1)

	self.chapterTFsById[var_35_0] = nil
	self.chapterTFsById[arg_35_1] = self.chapterTFsById[var_35_0]

	self:UpdateChapterTF(arg_35_1)

	return
end

function MapBuilderSP:UpdateChapterTF(arg_36_1)
	if not self.chapterGroupDict[arg_36_1] then
		return
	end

	if self.chapterTFsById[arg_36_1] then
		self:UpdateMapItem(self.chapterTFsById[arg_36_1], (getProxy(ChapterProxy):getChapterById(arg_36_1)))
	end

	return
end

function MapBuilderSP:RecyclePools()
	for iter_37_0 = #self.activeItems, 1, -1 do
		if self.activeItems[iter_37_0].template == self.oneLineTpl then
			setSizeDelta(self.activeItems[iter_37_0].active, {
				x = self.oneLineWidth,
				y = self.oneLineHeight
			})
		end

		self.pools[self.activeItems[iter_37_0].template]:Enqueue(self.activeItems[iter_37_0].active)
	end

	table.clean(self.activeItems)

	self.storyNodeTFsById = {}

	return
end

local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3

function MapBuilderSP:UpdateStoryNodeStatus()
	local var_38_0 = 0
	local var_38_1 = 0
	local var_38_2 = pg.NewStoryMgr.GetInstance()
	local var_38_3 = {}

	table.Foreach(self.spStoryIDs, function(arg_39_0, arg_39_1)
		var_38_3[arg_39_1] = {}

		return
	end)

	local var_38_4 = self.spStoryNodes

	for iter_38_0 = 1, #self.spStoryNodes do
		local var_38_5 = var_38_4[iter_38_0]
		local var_38_6 = var_38_4[iter_38_0]:GetConfigID()
		local var_38_7 = var_38_4[iter_38_0]:GetPreEvent()
		local var_38_9 = var_38_7 == 0 and true or var_38_3[var_38_7].status == var_0_4
		local var_38_10 = var_0_2
		local var_38_11 = var_38_4[iter_38_0]:GetStoryName()
		local var_38_12 = false

		if var_38_11 and var_38_11 ~= "" then
			var_38_12 = var_38_2:IsPlayed(var_38_11)
			var_38_0 = var_38_0 + (var_38_12 and 1 or 0)
			var_38_1 = var_38_1 + 1
		end

		if not var_38_12 and var_38_9 then
			local var_38_13 = {}

			_.each(var_38_5:GetUnlockConditions(), function(arg_40_0)
				local var_40_0 = true

				if arg_40_0[1] == ActivitySpStoryNode.CONDITION.TIME then
					var_40_0 = pg.TimeMgr.GetInstance():parseTimeFromConfig(arg_40_0[2]) <= pg.TimeMgr.GetInstance():GetServerTime()
				elseif arg_40_0[1] == ActivitySpStoryNode.CONDITION.PASSCHAPTER then
					var_40_0 = _.all(arg_40_0[2], function(arg_41_0)
						return getProxy(ChapterProxy):getChapterById(arg_41_0, true):isClear()
					end)
				elseif arg_40_0[1] == ActivitySpStoryNode.CONDITION.PT then
					local var_40_1 = arg_40_0[2][3]
					local var_40_2 = 0

					if arg_40_0[2][1] == DROP_TYPE_RESOURCE then
						var_40_2 = getProxy(PlayerProxy):getRawData():getResource(arg_40_0[2])
					elseif arg_40_0[2][1] == DROP_TYPE_ITEM then
						var_40_2 = getProxy(BagProxy):getItemCountById(arg_40_0[2][2])
					end

					var_40_0 = var_40_1 <= var_40_2
				end

				table.insert(var_38_13, var_40_0)

				var_38_9 = var_38_9 and var_40_0

				return
			end)

			var_38_3[var_38_6].conditionFinishedList = var_38_13
		end

		if var_38_12 then
			var_38_10 = var_0_4
		elseif var_38_9 then
			var_38_10 = var_0_3
		end

		var_38_3[var_38_6].status = var_38_10
	end

	self.storyNodeStatus = var_38_3
	self.storyReadCount, self.storyReadMax = var_38_0, var_38_1

	return
end

function MapBuilderSP:UpdateStory()
	self:RecyclePools()

	local var_42_0 = {
		"162443",
		"ffffff",
		"ffcb5a"
	}
	local var_42_1 = self.data:getConfig("story_inactive_color")

	if var_42_1 and #var_42_1 > 0 then
		var_42_0[1] = var_42_1
	end

	local var_42_2 = 0
	local var_42_3 = 150
	local var_42_4 = {
		{
			node = self.storyTree.root,
			nodePos = Vector2.New(150, 0)
		}
	}
	local var_42_5 = self.nodeTplWidth
	local var_42_6 = self.oneLineWidth
	local var_42_7 = self.branchHeadWidth
	local var_42_8 = self.branchUpWidth
	local var_42_9 = self.branchUpHeight
	local var_42_10 = self.UnionTailWidth
	local var_42_11 = 75
	local var_42_12 = 82
	local var_42_13 = 32

	while (function()
		local var_43_0 = table.remove(var_42_4, 1)
		local var_43_1 = var_43_0.node:GetConfigID()

		;(function()
			local var_44_0 = self:DequeItem(self.storyNodeTpl)

			var_44_0.name = var_43_1

			setAnchoredPosition(var_44_0, var_43_0.nodePos)

			self.storyNodeTFsById[var_43_1] = {
				nodeTF = tf(var_44_0)
			}

			return
		end)()

		local var_43_2 = self.storyTree.childDict[var_43_1] or {}

		if #var_43_2 == 0 then
			var_42_2 = var_43_0.nodePos.x + var_42_5 + var_42_3
		elseif #var_43_2 == 1 then
			local var_43_3 = var_43_2[1]:GetConfigID()
			local var_43_4 = self:DequeItem(self.oneLineTpl)

			var_43_4.name = string.format("Line%s_%s", var_43_1, var_43_3)

			setAnchoredPosition(var_43_4, var_43_0.nodePos + Vector2.New(var_42_5 + var_42_13, 0))

			nextPos = tf(var_43_4).anchoredPosition + Vector2.New(var_42_6 + var_42_11, 0)

			local var_43_5 = self.storyNodeStatus[var_43_3].status

			eachChild(var_43_4, function(arg_45_0)
				setImageColor(arg_45_0, Color.NewHex(var_42_0[var_43_5]))

				return
			end)
			table.insert(var_42_4, {
				node = var_43_2[1],
				nodePos = nextPos
			})
		elseif #var_43_2 > 1 then
			local var_43_6 = {}
			local var_43_7

			table.Ipairs(var_43_2, function(arg_46_0, arg_46_1)
				local var_46_0 = 0
				local var_46_1 = arg_46_1

				while (function()
					var_46_0 = var_46_0 + 1

					local var_47_0 = self.storyTree.childDict[var_46_1:GetConfigID()]

					if not var_47_0 then
						return false
					end

					assert(#var_47_0 <= 1)

					if var_47_0[1] and #var_47_0[1]:GetPreNodes() == 1 then
						var_46_1 = var_47_0[1]

						return true
					else
						var_43_7 = var_47_0[1]
					end

					return
				end)() do
					-- block empty
				end

				var_43_6[arg_46_0] = 0

				return
			end)

			local var_43_8 = _.max(var_43_6)
			local var_43_9 = var_43_8 * (var_42_5 + var_42_11 + var_42_13) + (var_43_8 - 1) * var_42_6
			local var_43_10 = var_43_0.nodePos + Vector2.New(var_42_5 + var_42_13, 0)

			;(function()
				local var_48_0 = self:DequeItem(self.branchHeadTpl)

				setAnchoredPosition(var_48_0, var_43_10)

				var_43_10 = var_43_10 + Vector2.New(var_42_7, 0)

				local var_48_1 = self.storyNodeStatus[var_43_2[1]:GetConfigID()].status

				eachChild(var_48_0, function(arg_49_0)
					setImageColor(arg_49_0, Color.NewHex(var_42_0[var_48_1]))

					return
				end)

				return
			end)()
			table.Ipairs(var_43_2, function(arg_50_0, arg_50_1)
				local var_50_0 = var_42_6

				if var_43_6[arg_50_0] < var_43_8 then
					var_50_0 = (var_43_9 - var_43_6[arg_50_0] * (var_42_5 + var_42_11 + var_42_13)) / (var_43_6[arg_50_0] + 1)
				end

				local var_50_1 = arg_50_1:GetConfigID()
				local var_50_2 = var_43_10

				;(function()
					local var_51_0

					if arg_50_0 == 1 then
						var_51_0 = self:DequeItem(self.branchUpTpl)

						setAnchoredPosition(var_51_0, var_50_2)

						var_50_2 = var_50_2 + Vector2.New(var_42_8, var_42_9)

						if var_43_6[arg_50_0] < var_43_8 then
							setSizeDelta(var_51_0, {
								x = var_42_8 + var_50_0,
								y = var_42_9
							})

							local var_51_1 = tf(var_51_0):Find("Line_1").sizeDelta

							var_51_1.x = var_51_1.x + var_50_0

							setSizeDelta(tf(var_51_0):Find("Line_1"), var_51_1)

							var_50_2 = var_50_2 + Vector2.New(var_50_0, 0)
						end
					elseif (arg_50_0 == 3 or arg_50_0 == 2 and #var_43_2 == 2) and self.storyTree.childDict[var_43_2[1]:GetConfigID()] then
						var_51_0 = self:DequeItem(self.branchDownTpl)

						setAnchoredPosition(var_51_0, var_50_2)

						var_50_2 = var_50_2 + Vector2.New(var_42_8, -var_42_9)

						if var_43_6[arg_50_0] < var_43_8 then
							setSizeDelta(var_51_0, {
								x = var_42_8 + var_50_0,
								y = var_42_9
							})

							local var_51_2 = tf(var_51_0):Find("Line_1").sizeDelta

							var_51_2.x = var_51_2.x + var_50_0

							setSizeDelta(tf(var_51_0):Find("Line_1"), var_51_2)

							var_50_2 = var_50_2 + Vector2.New(var_50_0, 0)
						end
					else
						var_51_0 = self:DequeItem(self.branchCenterTpl)

						setAnchoredPosition(var_51_0, var_50_2)

						var_50_2 = var_50_2 + Vector2.New(var_42_8, 0)

						if var_43_6[arg_50_0] < var_43_8 then
							local var_51_3 = tf(var_51_0).sizeDelta

							var_51_3.x = var_51_3.x + var_50_0

							setSizeDelta(var_51_0, var_51_3)

							var_50_2 = var_50_2 + Vector2.New(var_50_0, 0)
						end
					end

					var_51_0.name = string.format("Branch%s_%s", var_43_1, var_50_1)

					local var_51_4 = self.storyNodeStatus[var_50_1].status

					eachChild(var_51_0, function(arg_52_0)
						setImageColor(arg_52_0, Color.NewHex(var_42_0[var_51_4]))

						return
					end)

					return
				end)()

				var_50_2 = var_50_2 + Vector2.New(var_42_11, 0)

				local var_50_3 = self:DequeItem(self.storyNodeTpl)

				var_50_3.name = var_50_1

				setAnchoredPosition(var_50_3, var_50_2)

				self.storyNodeTFsById[var_50_1] = {
					nodeTF = tf(var_50_3)
				}
				var_50_2 = var_50_2 + Vector2.New(var_42_5 + var_42_13, 0)

				local var_50_4 = arg_50_1

				if self.storyTree.childDict[var_50_1] then
					local var_50_5 = self.storyTree.childDict[var_50_1][1]

					while (function()
						if not var_50_5 or var_50_5 == var_43_7 then
							return
						end

						local var_53_0 = self:DequeItem(self.oneLineTpl)

						var_53_0.name = string.format("Line%s_%s", var_50_4:GetConfigID(), var_50_5:GetConfigID())

						setAnchoredPosition(var_53_0, var_50_2)

						var_50_2 = var_50_2 + Vector2.New(var_50_0 + var_42_11, 0)

						setSizeDelta(var_53_0, {
							x = var_50_0,
							y = self.oneLineHeight
						})

						local var_53_1 = self.storyNodeStatus[var_50_5:GetConfigID()].status

						eachChild(var_53_0, function(arg_54_0)
							setImageColor(arg_54_0, Color.NewHex(var_42_0[var_53_1]))

							return
						end)

						local var_53_2 = self:DequeItem(self.storyNodeTpl)

						var_53_2.name = var_50_5:GetConfigID()

						setAnchoredPosition(var_53_2, var_50_2)

						self.storyNodeTFsById[var_50_5:GetConfigID()] = {
							nodeTF = tf(var_53_2)
						}
						var_50_2 = var_50_2 + Vector2.New(var_42_5 + var_42_13, 0)

						local var_53_3 = self.storyTree.childDict[var_50_5:GetConfigID()]

						if not var_53_3 then
							return false
						end

						var_50_5, var_50_4 = var_53_3[1], var_50_5

						return true
					end)() do
						-- block empty
					end
				end

				if var_43_7 then
					local var_50_6

					if arg_50_0 == 1 then
						var_50_6 = self:DequeItem(self.unionUpTpl)

						setAnchoredPosition(var_50_6, var_50_2)

						if var_43_6[arg_50_0] < var_43_8 then
							setSizeDelta(var_50_6, {
								x = var_42_8 + var_50_0,
								y = var_42_9
							})

							local var_50_7 = tf(var_50_6):Find("Line_1").sizeDelta

							var_50_7.x = var_50_7.x + var_50_0

							setSizeDelta(tf(var_50_6):Find("Line_1"), var_50_7)

							var_50_2 = var_50_2 + Vector2.New(var_50_0, 0)
						end
					elseif arg_50_0 == 3 or arg_50_0 == 2 and #var_43_2 == 2 then
						var_50_6 = self:DequeItem(self.unionDownTpl)

						setAnchoredPosition(var_50_6, var_50_2)

						if var_43_6[arg_50_0] < var_43_8 then
							setSizeDelta(var_50_6, {
								x = var_42_8 + var_50_0,
								y = var_42_9
							})

							local var_50_8 = tf(var_50_6):Find("Line_1").sizeDelta

							var_50_8.x = var_50_8.x + var_50_0

							setSizeDelta(tf(var_50_6):Find("Line_1"), var_50_8)

							var_50_2 = var_50_2 + Vector2.New(var_50_0, 0)
						end
					else
						var_50_6 = self:DequeItem(self.unionCenterTpl)

						setAnchoredPosition(var_50_6, var_50_2)

						if var_43_6[arg_50_0] < var_43_8 then
							local var_50_9 = tf(var_50_6).sizeDelta

							var_50_9.x = var_50_9.x + var_50_0

							setSizeDelta(var_50_6, var_50_9)

							var_50_2 = var_50_2 + Vector2.New(var_50_0, 0)
						end
					end

					var_50_6.name = string.format("Union%s_%s", var_50_4:GetConfigID(), var_43_7:GetConfigID())

					local var_50_10 = self.storyNodeStatus[var_43_7:GetConfigID()].status

					eachChild(var_50_6, function(arg_55_0)
						setImageColor(arg_55_0, Color.NewHex(var_42_0[var_50_10]))

						return
					end)
				end

				return
			end)

			var_43_10 = var_43_10 + Vector2.New(var_43_8 * (var_42_5 + var_42_11 + var_42_13) + (var_43_8 - 1) * var_42_6 + var_42_8, 0)

			if nil then
				(function()
					var_43_10 = var_43_10 + Vector2.New(var_42_8, 0)

					local var_56_0 = self:DequeItem(self.unionTailTpl)

					setAnchoredPosition(var_56_0, var_43_10)

					var_43_10 = var_43_10 + Vector2.New(var_42_10 + var_42_12, 0)

					local var_56_1 = self.storyNodeStatus[var_43_7:GetConfigID()].status

					eachChild(var_56_0, function(arg_57_0)
						setImageColor(arg_57_0, Color.NewHex(var_42_0[var_56_1]))

						return
					end)

					return
				end)()
				table.insert(var_42_4, {
					node = nil,
					nodePos = var_43_10
				})
			else
				var_42_2 = var_43_10.x + var_42_3
			end
		end

		return next(var_42_4)
	end)() do
		-- block empty
	end

	setSizeDelta(self.storyContainer, {
		x = var_42_2
	})

	if self.spStoryUnreleasedNode then
		local var_42_14 = cloneTplTo(self.unreleasedNodeTpl, self.storyContainer)

		setAnchoredPosition(var_42_14, {
			y = 0,
			x = var_42_2
		})
		setText(var_42_14:Find("text"), self.spStoryUnreleasedNode:GetDisplayName())
		ResourceMgr.Inst:getAssetAsync("ui/" .. self.spStoryUnreleasedNode:GetCleanAnimator(), "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_58_0)
			local var_58_0 = Instantiate(arg_58_0)

			tf(var_58_0).localPosition = Vector3.New(-525, 0, 380)

			setParent(var_58_0, var_42_14)

			return
		end), true, true)
	end

	local var_42_15 = self.spStoryNodes

	for iter_42_0 = 1, #self.spStoryNodes do
		local var_42_16 = var_42_15[iter_42_0]
		local var_42_17 = var_42_15[iter_42_0]:GetConfigID()
		local var_42_18 = self.storyNodeStatus[var_42_17].status
		local var_42_19 = self.storyNodeTFsById[var_42_17].nodeTF
		local var_42_20 = self.storyNodeTFsById[var_42_17].nodeTF:Find("info/bk/title_form/title")

		if self.storyNodeStatus[var_42_17].status == var_0_2 then
			local var_42_21 = var_42_16:GetUnlockDesc()
			local var_42_22 = ""

			if type(var_42_21) == "table" then
				local var_42_23 = self.storyNodeStatus[var_42_17].conditionFinishedList or {}

				var_42_22 = var_42_21[1] or ""

				for iter_42_1, iter_42_2 in ipairs(var_42_21) do
					if not var_42_23[iter_42_1] then
						var_42_22 = iter_42_2 or ""

						break
					end
				end
			else
				var_42_22 = var_42_21 or ""
			end

			setScrollText(var_42_20, HXSet.hxLan(var_42_22))
			setTextAlpha(var_42_20, 0.5)
		else
			setScrollText(var_42_20, HXSet.hxLan(var_42_16:GetDisplayName()))
			setTextAlpha(var_42_20, 1)
		end

		local var_42_24 = var_42_16:GetType()

		setActive(var_42_19:Find("circle/lock"), var_42_18 == var_0_2)

		if var_42_18 == var_0_2 then
			setActive(var_42_19:Find("circle/Story"), false)
			setActive(var_42_19:Find("circle/Battle"), false)
			setActive(var_42_19:Find("circle/Option"), false)
			setText(var_42_19:Find(""))
		elseif var_42_24 == ActivitySpStoryNode.NODE_TYPE.STORY then
			setActive(var_42_19:Find("circle/Option"), false)
			setActive(var_42_19:Find("circle/Story"), true)
			setActive(var_42_19:Find("circle/Battle"), false)
			setActive(var_42_19:Find("circle/Story/Done"), var_42_18 == var_0_4)
		elseif var_42_24 == ActivitySpStoryNode.NODE_TYPE.OPTION_BRANCH then
			setActive(var_42_19:Find("circle/Option"), true)
			setActive(var_42_19:Find("circle/Story"), false)
			setActive(var_42_19:Find("circle/Battle"), false)
			setActive(var_42_19:Find("circle/Option/Done"), var_42_18 == var_0_4)
		else
			local var_42_25
			local var_42_26

			if var_42_24 == ActivitySpStoryNode.NODE_TYPE.BATTLE then
				setActive(var_42_19:Find("circle/Story"), false)
				setActive(var_42_19:Find("circle/Option"), false)
				setActive(var_42_19:Find("circle/Battle"), var_42_24 == ActivitySpStoryNode.NODE_TYPE.BATTLE)
				setActive(var_42_19:Find("circle/Battle/Done"), var_42_18 == var_0_4)

				var_42_25 = setActive
				var_42_26 = var_42_19:Find("circle/progress")
			end
		end

		var_42_25(var_42_26, var_42_18 == var_0_4)

		local var_42_27 = var_42_16:IsRecrew()

		if var_42_27 == nil then
			setActive(var_42_19:Find("recrew"), false)
		else
			setActive(var_42_19:Find("recrew"), true)
			setActive(var_42_19:Find("recrew/recrewed"), var_42_27)
			setActive(var_42_19:Find("recrew/not_recrew"), not var_42_27)
			setText(var_42_19:Find("recrew/recrewed/label"), i18n("story_recrewed"))
			setText(var_42_19:Find("recrew/not_recrew/label"), i18n("story_not_recrew"))
		end

		onButton(self, var_42_19, function()
			if var_42_18 == var_0_2 then
				return
			end

			self:PlayStory(var_42_16:GetStoryName(), function()
				self.needFocusStory = true

				self:Move2UnlockStory()

				return
			end, true)

			return
		end)
	end

	setText(self.progressText, self.storyReadCount .. "/" .. self.storyReadMax)
	setActive(self.storyAward, tobool(self.storyTask))

	if self.storyTask then
		local var_42_28 = self.storyTask:getConfig("award_display")
		local var_42_29 = Drop.New({
			type = var_42_28[1][1],
			id = var_42_28[1][2],
			count = var_42_28[1][3]
		})

		updateDrop(self.storyAward:GetChild(0), var_42_29)

		local var_42_30 = self.storyTask:getTaskStatus()

		setActive(self.storyAward:Find("get"), var_42_30 == 1)
		setActive(self.storyAward:Find("got"), var_42_30 == 2)
		onButton(self, self.storyAward, function()
			self:emit(BaseUI.ON_DROP, var_42_29)

			return
		end)
	end

	return
end

function MapBuilderSP:DequeItem(arg_62_1)
	local var_62_0 = self.pools[arg_62_1]:Dequeue()

	table.insert(self.activeItems, {
		template = arg_62_1,
		active = var_62_0
	})
	setActive(var_62_0, true)
	setParent(var_62_0, self.storyContainer)

	return var_62_0
end

function MapBuilderSP:Move2UnlockStory()
	if not self.needFocusStory then
		return
	end

	self.needFocusStory = nil

	local var_63_0

	for iter_63_0 = #self.spStoryNodes, 1, -1 do
		local var_63_1 = self.spStoryNodes[iter_63_0]:GetConfigID()

		if self.storyNodeStatus[var_63_1].status > var_0_2 then
			var_63_0 = var_63_1

			break
		end
	end

	local var_63_2 = {}

	var_63_2.x = -math.clamp(self.storyNodeTFsById[var_63_0].nodeTF.anchoredPosition.x + self.storyNodeTpl.rect.width * 0.5 - self.storyContainer.parent.rect.width * 0.5, 0, math.max(0, self.storyContainer.rect.width - self.storyContainer.parent.rect.width))

	setAnchoredPosition(self.storyContainer, var_63_2)

	return
end

function MapBuilderSP:SwitchStoryMapAndBGM()
	local var_64_0 = self.data:getConfig("default_background")
	local var_64_1 = self.data:getConfig("default_bgm")
	local var_64_2

	for iter_64_0 = 1, #self.spStoryNodes do
		if self.storyNodeStatus[self.spStoryNodes[iter_64_0]:GetConfigID()].status == var_0_4 then
			var_64_1 = self.spStoryNodes[iter_64_0]:GetCleanBGM()
			var_64_0 = self.spStoryNodes[iter_64_0]:GetCleanBG()
			var_64_2 = self.spStoryNodes[iter_64_0]:GetCleanAnimator()
		else
			break
		end
	end

	self.sceneParent:SwitchBG({
		{
			bgPrefix = "bg",
			BG = var_64_0,
			Animator = var_64_2
		}
	})
	pg.BgmMgr.GetInstance():Pop(self.__cname)
	pg.BgmMgr.GetInstance():Push(self.__cname, var_64_1)

	return
end

function MapBuilderSP:TrySubmitTask()
	local var_65_0 = true

	for iter_65_0, iter_65_1 in ipairs(self.spStoryNodes) do
		local var_65_1 = iter_65_1:GetStoryName()

		if var_65_1 and var_65_1 ~= "" then
			var_65_0 = var_65_0 and pg.NewStoryMgr.GetInstance():IsPlayed(var_65_1)
		end

		if not var_65_0 then
			break
		end
	end

	if var_65_0 and self.storyTask and self.storyTask:getTaskStatus() == 1 then
		self:emit(LevelMediator2.ON_SUBMIT_TASK, self.storyTask.id)

		return
	end

	return
end

function MapBuilderSP:PlayStory(arg_66_1, arg_66_2, arg_66_3)
	if not arg_66_1 then
		return existCall(arg_66_2)
	end

	local var_66_0 = pg.NewStoryMgr.GetInstance()
	local var_66_1 = var_66_0:IsPlayed(arg_66_1)

	seriesAsync({
		function(arg_67_0)
			if var_66_1 and not arg_66_3 then
				return arg_67_0()
			end

			local var_67_0 = tonumber(arg_66_1)

			if var_67_0 and var_67_0 > 0 then
				self:emit(LevelMediator2.ON_PERFORM_COMBAT, var_67_0, nil, var_66_1)
			else
				var_66_0:PlayForAcivitySpStory(arg_66_1, arg_67_0, arg_66_3)
			end

			return
		end,
		function(arg_68_0, ...)
			existCall(arg_66_2, ...)
			self:UpdateView()

			return
		end
	})

	return
end

function MapBuilderSP:UpdateStoryTask()
	local var_69_0 = self.activity and self.activity:getConfig("config_client").task_id

	if not var_69_0 then
		return
	end

	local var_69_1 = getProxy(TaskProxy):getTaskVO(var_69_0)

	var_69_1 = var_69_1 or Task.New({
		submit_time = 1,
		id = var_69_0
	})
	self.storyTask = var_69_1

	return
end

function MapBuilderSP:OnSubmitTaskDone()
	self:UpdateView()

	return
end

function MapBuilderSP:OnDestroy()
	self:RecyclePools()

	for iter_71_0, iter_71_1 in pairs(self.pools) do
		iter_71_1:Clear()
	end

	return
end

return MapBuilderSP
