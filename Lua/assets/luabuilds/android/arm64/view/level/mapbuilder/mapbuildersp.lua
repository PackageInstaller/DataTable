local var_0_0 = class("MapBuilderSP", import(".MapBuilder"))
local var_0_1 = import("Mgr/Pool/PoolPlural")

var_0_0.DISPLAY = {
	STORY = 2,
	BATTLE = 1
}
var_0_0.DIFFICULITY = {
	EASY = 1,
	HARD = 2
}

function var_0_0.GetType(arg_1_0)
	return MapBuilder.TYPESP
end

function var_0_0.getUIName(arg_2_0)
	return "LevelSelectSPUI"
end

function var_0_0.OnLoaded(arg_3_0)
	setParent(arg_3_0._tf, arg_3_0._parentTf)
	arg_3_0._tf:SetSiblingIndex(4)

	return
end

function var_0_0.OnInit(arg_4_0)
	arg_4_0.battleLayer = arg_4_0._tf:Find("Battle")
	arg_4_0.storyLayer = arg_4_0._tf:Find("Story")
	arg_4_0.top = arg_4_0._tf:Find("Top")
	arg_4_0.itemHolder = arg_4_0._tf:Find("Battle/Nodes")
	arg_4_0.chapterTpl = arg_4_0.itemHolder:Find("LevelTpl")
	arg_4_0.storyHolder = arg_4_0._tf:Find("Story/Nodes")
	arg_4_0.storyContainer = arg_4_0.storyHolder:Find("Viewport/Content")
	arg_4_0.nodes = {}
	arg_4_0.progressText = arg_4_0._tf:Find("Story/Desc/Text")
	arg_4_0.storyAward = arg_4_0._tf:Find("Story/Award")
	arg_4_0.storyNodeTpl = arg_4_0._tf:Find("Story/NodeTemplate")
	arg_4_0.oneLineTpl = arg_4_0._tf:Find("Story/OneLine")
	arg_4_0.branchHeadTpl = arg_4_0._tf:Find("Story/BranchHead")
	arg_4_0.branchCenterTpl = arg_4_0._tf:Find("Story/BranchCenter")
	arg_4_0.branchUpTpl = arg_4_0._tf:Find("Story/BranchUp")
	arg_4_0.branchDownTpl = arg_4_0._tf:Find("Story/BranchDown")
	arg_4_0.unionTailTpl = arg_4_0._tf:Find("Story/UnionTail")
	arg_4_0.unionCenterTpl = arg_4_0._tf:Find("Story/UnionCenter")
	arg_4_0.unionUpTpl = arg_4_0._tf:Find("Story/UnionUp")
	arg_4_0.unionDownTpl = arg_4_0._tf:Find("Story/UnionDown")
	arg_4_0.unreleasedNodeTpl = arg_4_0._tf:Find("Story/UnreleasedNode")

	setActive(arg_4_0.storyNodeTpl, false)
	setActive(arg_4_0.oneLineTpl, false)
	setActive(arg_4_0.branchHeadTpl, false)
	setActive(arg_4_0.branchCenterTpl, false)
	setActive(arg_4_0.branchUpTpl, false)
	setActive(arg_4_0.branchDownTpl, false)
	setActive(arg_4_0.unionTailTpl, false)
	setActive(arg_4_0.unionCenterTpl, false)
	setActive(arg_4_0.unionUpTpl, false)
	setActive(arg_4_0.unionDownTpl, false)
	setActive(arg_4_0.unreleasedNodeTpl, false)

	arg_4_0.pools = {
		[arg_4_0.storyNodeTpl] = var_0_1.New(go(arg_4_0.storyNodeTpl), 0),
		[arg_4_0.oneLineTpl] = var_0_1.New(go(arg_4_0.oneLineTpl), 0),
		[arg_4_0.branchHeadTpl] = var_0_1.New(go(arg_4_0.branchHeadTpl), 0),
		[arg_4_0.branchCenterTpl] = var_0_1.New(go(arg_4_0.branchCenterTpl), 0),
		[arg_4_0.branchUpTpl] = var_0_1.New(go(arg_4_0.branchUpTpl), 0),
		[arg_4_0.branchDownTpl] = var_0_1.New(go(arg_4_0.branchDownTpl), 0),
		[arg_4_0.unionTailTpl] = var_0_1.New(go(arg_4_0.unionTailTpl), 0),
		[arg_4_0.unionCenterTpl] = var_0_1.New(go(arg_4_0.unionCenterTpl), 0),
		[arg_4_0.unionUpTpl] = var_0_1.New(go(arg_4_0.unionUpTpl), 0),
		[arg_4_0.unionDownTpl] = var_0_1.New(go(arg_4_0.unionDownTpl), 0)
	}
	arg_4_0.nodeTplWidth = arg_4_0.storyNodeTpl.rect.width
	arg_4_0.oneLineWidth = arg_4_0.oneLineTpl.rect.width
	arg_4_0.oneLineHeight = arg_4_0.oneLineTpl.rect.height
	arg_4_0.branchHeadWidth = arg_4_0.branchHeadTpl.rect.width
	arg_4_0.branchUpWidth = arg_4_0.branchUpTpl.rect.width
	arg_4_0.branchUpHeight = arg_4_0.branchUpTpl.rect.height
	arg_4_0.UnionTailWidth = arg_4_0.unionTailTpl.rect.width
	arg_4_0.activeItems = {}
	arg_4_0.displayChapterIDs = {}
	arg_4_0.chapterTFsById = {}
	arg_4_0.storyNodeTFsById = {}

	arg_4_0:bind(LevelUIConst.SWITCH_SPCHAPTER_DIFFICULTY, function(arg_5_0, arg_5_1)
		arg_4_0:SwitchChapter(arg_5_1)

		return
	end)
	onButton(arg_4_0, arg_4_0.battleLayer:Find("Mask/Story/Switch"), function()
		arg_4_0:SetDisplayMode(var_0_0.DISPLAY.STORY)

		arg_4_0.needFocusStory = true

		arg_4_0:Move2UnlockStory()

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.storyLayer:Find("Battle/Switch"), function()
		arg_4_0:SetDisplayMode(var_0_0.DISPLAY.BATTLE)

		return
	end, SFX_PANEL)
	setText(arg_4_0.storyLayer:Find("Desc/Desc"), i18n("series_enemy_storyreward"))

	return
end

function var_0_0.OnShow(arg_8_0)
	var_0_0.super.OnShow(arg_8_0)
	setActive(arg_8_0.sceneParent.mainLayer:Find("title_chapter_lines"), true)
	setActive(arg_8_0.sceneParent.topChapter:Find("title_chapter"), true)
	setActive(arg_8_0.sceneParent.topChapter:Find("type_chapter"), true)

	arg_8_0.needFocusStory = true

	return
end

function var_0_0.UpdateButtons(arg_9_0)
	var_0_0.super.UpdateButtons(arg_9_0)

	local var_9_0, var_9_1 = arg_9_0.contextData.map:isActivity()
	local var_9_2 = arg_9_0.contextData.map:isRemaster()

	if var_9_2 then
		arg_9_0.sceneParent:updateRemasterInfo()
	end

	local var_9_3 = arg_9_0.contextData.displayMode == var_0_0.DISPLAY.BATTLE
	local var_9_5 = arg_9_0.sceneParent.actExchangeShopBtn
	local var_9_6 = not ActivityConst.HIDE_PT_PANELS and var_9_3 and not var_9_2 and var_9_1 and arg_9_0.sceneParent:IsActShopActive()

	var_9_4(var_9_5, var_9_6)

	if arg_9_0.contextData.map then
		local var_9_7 = getProxy(ActivityProxy):getActivityById(arg_9_0.contextData.map:getConfig("on_activity")) or nil
		local var_9_8 = var_9_7 and not var_9_7:isEnd() and var_9_7:GetConfigClientSetting("PTID")

		arg_9_0.sceneParent:updatePtActivity(underscore.detect(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_PT_RANK), function(arg_10_0)
			return arg_10_0:getConfig("config_id") == var_9_8
		end))
		setActive(arg_9_0.sceneParent.rightChapter:Find("event_btns/tickets"), var_9_2)
		arg_9_0.sceneParent:updateRemasterTicket()

		local var_9_10 = arg_9_0.sceneParent.ptTotal

		if not ActivityConst.HIDE_PT_PANELS and not var_9_2 then
			local var_9_11

			if var_9_1 then
				::label_9_0::

				var_9_11 = arg_9_0.sceneParent.ptActivity

				if arg_9_0.sceneParent.ptActivity then
					if not arg_9_0.sceneParent.ptActivity:isEnd() then
						var_9_11 = var_9_3

						goto label_9_1
					end

					var_9_11 = false and true
				end
			end

			::label_9_1::

			var_9_9(var_9_10, var_9_11)

			return
		end
	end
end

function var_0_0.OnHide(arg_11_0)
	setActive(arg_11_0.sceneParent.mainLayer:Find("title_chapter_lines"), false)
	setActive(arg_11_0.sceneParent.topChapter:Find("title_chapter"), false)
	setActive(arg_11_0.sceneParent.topChapter:Find("type_chapter"), false)
	setActive(arg_11_0.sceneParent.ptTotal, false)
	setActive(arg_11_0.sceneParent.actExchangeShopBtn, false)
	var_0_0.super.OnHide(arg_11_0)

	return
end

function var_0_0.UpdateMapVO(arg_12_0, arg_12_1)
	var_0_0.super.UpdateMapVO(arg_12_0, arg_12_1)

	arg_12_0.activity = getProxy(ActivityProxy):getActivityById(arg_12_1:getConfig("on_activity"))

	local var_12_0 = getProxy(PlayerProxy):getRawData().id

	arg_12_0.chapterGroups = _.map(arg_12_1:getConfig("chapterGroups"), function(arg_13_0)
		return {
			list = arg_13_0,
			index = PlayerPrefs.GetInt("spchapter_selected_" .. var_12_0 .. "_" .. arg_13_0[1], var_0_0.DIFFICULITY.EASY)
		}
	end)
	arg_12_0.chapterGroupDict = {}

	_.each(arg_12_0.chapterGroups, function(arg_14_0)
		_.each(arg_14_0.list, function(arg_15_0)
			arg_12_0.chapterGroupDict[arg_15_0] = arg_14_0

			return
		end)

		return
	end)

	arg_12_0.displayChapterIDs = _.map(arg_12_0.chapterGroups, function(arg_16_0)
		return arg_16_0.list[arg_16_0.index]
	end)

	arg_12_0:BuildStoryTree()

	return
end

function var_0_0.UpdateBonusPtIconPath(arg_17_0)
	arg_17_0.bonusPtIconPath = nil

	local var_17_0 = arg_17_0.data or arg_17_0.contextData.map

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

	if not var_17_3:GetConfigClientSetting("PTID") then
		return
	end

	local var_17_4 = underscore.detect(var_17_2:getActivitiesByType(ActivityConst.ACTIVITY_TYPE_PT_RANK), function(arg_18_0)
		return arg_18_0 and not arg_18_0:isEnd() and arg_18_0:getConfig("config_id") == var_0
	end)

	if not var_17_4 then
		return
	end

	local var_17_5 = tonumber(var_17_4:getConfig("config_id"))

	if not var_17_5 then
		return
	end

	arg_17_0.bonusPtIconPath = Drop.New({
		type = DROP_TYPE_RESOURCE,
		id = var_17_5
	}):getIcon()

	return
end

function var_0_0.BuildStoryTree(arg_19_0)
	arg_19_0.spStoryIDs = arg_19_0.data:getConfig("story_id")
	arg_19_0.spStoryNodeDict = {}
	arg_19_0.spStoryNodes = {}
	arg_19_0.spStoryUnreleasedNode = nil

	local var_19_0 = {}

	_.each(arg_19_0.spStoryIDs, function(arg_20_0)
		local var_20_0 = ActivitySpStoryNode.New({
			configId = arg_20_0
		})

		if var_20_0:GetType() ~= ActivitySpStoryNode.NODE_TYPE.UNRELEASED then
			arg_19_0.spStoryNodeDict[arg_20_0] = var_20_0

			local var_20_1 = var_19_0[arg_19_0.spStoryNodeDict[arg_20_0]:GetPreEvent()] or {}

			table.insert(var_20_1, arg_20_0)

			var_19_0[arg_19_0.spStoryNodeDict[arg_20_0]:GetPreEvent()] = var_20_1
		else
			arg_19_0.spStoryUnreleasedNode = var_20_0
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
			table.insert(arg_19_0.spStoryNodes, arg_19_0.spStoryNodeDict[arg_22_0])

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

	_.each(arg_19_0.spStoryNodes, function(arg_23_0)
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

	arg_19_0.storyTree = {
		root = nil,
		childDict = var_19_2
	}

	return
end

function var_0_0.SetDisplayMode(arg_25_0, arg_25_1)
	if arg_25_1 == arg_25_0.contextData.displayMode then
		return
	end

	arg_25_0.contextData.displayMode = arg_25_1

	arg_25_0:UpdateView()

	return
end

function var_0_0.UpdateView(arg_26_0)
	local var_26_1 = string.split(arg_26_0.contextData.map:getConfig("name"), "||")

	if arg_26_0.contextData.displayMode == var_0_0.DISPLAY.STORY then
		var_26_1 = string.split(var_26_1[1], "·")

		setText(arg_26_0.sceneParent.chapterName, var_26_1[1] .. i18n("levelscene_title_story"))
	else
		setText(arg_26_0.sceneParent.chapterName, var_26_1[1])
	end

	arg_26_0.sceneParent.loader:GetSpriteQuiet("chapterno", "chapter" .. var_26_0:getMapTitleNumber(), arg_26_0.sceneParent.chapterNoTitle, true)

	arg_26_0.contextData.displayMode = arg_26_0.contextData.displayMode or var_0_0.DISPLAY.BATTLE

	var_0_0.super.UpdateView(arg_26_0)

	local var_26_2 = arg_26_0.contextData.displayMode == var_0_0.DISPLAY.BATTLE

	setActive(arg_26_0._tf:Find("Battle"), arg_26_0.contextData.displayMode == var_0_0.DISPLAY.BATTLE)
	setActive(arg_26_0._tf:Find("Story"), not var_26_2)

	local var_26_3 = getProxy(ChapterProxy):IsActivitySPChapterActive(var_26_0:getConfig("on_activity"))

	var_26_3 = var_26_3 and SettingsProxy.IsShowActivityMapSPTip()

	setActive(arg_26_0.battleLayer:Find("Mask/Story/BattleTip"), false)
	setActive(arg_26_0.storyLayer:Find("Battle/BattleTip"), var_26_3)

	if type(arg_26_0.spStoryIDs) ~= "table" or #arg_26_0.spStoryIDs == 0 then
		local var_26_4 = var_26_0:isRemaster()

		if var_26_4 then
			setActive(arg_26_0.battleLayer:Find("Mask"), false)

			local var_26_5, var_26_6 = var_26_0:isActivity()
			local var_26_7 = var_26_0:isSkirmish()
			local var_26_8 = var_26_0:isEscort()
			local var_26_9 = OPEN_REMASTER and (var_26_4 or not var_26_5 and not var_26_8 and not var_26_7)

			setActive(arg_26_0.sceneParent.remasterBtn, var_26_9)
		else
			arg_26_0.battleLayer:Find("Mask"):GetComponent(typeof(RectMask2D)).enabled = true
		end
	end

	arg_26_0:UpdateStoryTask()

	if var_26_2 then
		arg_26_0:UpdateBonusPtIconPath()
		arg_26_0:UpdateBattle()
		arg_26_0.sceneParent:SwitchMapBG(arg_26_0.contextData.map)
		pg.BgmMgr.GetInstance():Pop(arg_26_0.__cname)
		arg_26_0.sceneParent:PlayBGM()
	else
		arg_26_0:UpdateStoryNodeStatus()
		arg_26_0:UpdateStory()
		arg_26_0:Move2UnlockStory()
		arg_26_0:SwitchStoryMapAndBGM()
	end

	arg_26_0:TrySubmitTask()

	return
end

function var_0_0.UpdateBattle(arg_27_0)
	local var_27_0 = getProxy(ChapterProxy)
	local var_27_1 = {}

	for iter_27_0, iter_27_1 in ipairs(arg_27_0.displayChapterIDs) do
		table.insert({}, (var_27_0:getChapterById(iter_27_1)))
	end

	table.clear(arg_27_0.chapterTFsById)
	UIItemList.StaticAlign(arg_27_0.itemHolder, arg_27_0.chapterTpl, #{}, function(arg_28_0, arg_28_1, arg_28_2)
		if arg_28_0 ~= UIItemList.EventUpdate then
			return
		end

		local var_28_0 = var_27_1[arg_28_1 + 1]

		arg_27_0:UpdateMapItem(arg_28_2, var_27_1[arg_28_1 + 1])

		arg_28_2.name = "Chapter_" .. var_28_0.id
		arg_27_0.chapterTFsById[var_28_0.id] = arg_28_2

		return
	end)

	return
end

function var_0_0.HideFloat(arg_29_0)
	var_0_0.super.HideFloat(arg_29_0)
	setActive(arg_29_0.itemHolder, false)

	return
end

function var_0_0.ShowFloat(arg_30_0)
	var_0_0.super.ShowFloat(arg_30_0)
	setActive(arg_30_0.itemHolder, true)

	return
end

function var_0_0.UpdateMapItem(arg_31_0, arg_31_1, arg_31_2)
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

	local var_31_3 = arg_31_0.chapterGroupDict[arg_31_2.id]

	assert(arg_31_0.chapterGroupDict[arg_31_2.id])

	local var_31_4 = 1

	if arg_31_2:isUnlock() then
		var_31_4 = 2

		if #arg_31_0.chapterGroupDict[arg_31_2.id].list > 1 then
			var_31_4 = table.indexof(arg_31_0.chapterGroupDict[arg_31_2.id].list, arg_31_2.id) + 1
		elseif arg_31_2:IsSpChapter() or arg_31_2:IsEXChapter() then
			var_31_4 = 3
		elseif arg_31_0.contextData.map:isHardMap() then
			var_31_4 = 3
		end
	end

	local var_31_5 = findTF(var_31_1, "circle/bk")

	for iter_31_0, iter_31_1 in ipairs({
		"Lock",
		"Normal",
		"Hard"
	}) do
		setActive(var_31_5:Find(iter_31_1), iter_31_0 == var_31_4)
	end

	local var_31_6 = findTF(var_31_1, "circle/clear_flag")
	local var_31_7 = findTF(var_31_1, "circle/lock")
	local var_31_8 = findTF(var_31_1, "circle/progress_text")
	local var_31_9 = findTF(var_31_1, "circle/stars")
	local var_31_10 = string.split(var_31_0.name, "|")

	setText(findTF(var_31_1, "info/bk/title_form/title_index"), var_31_0.chapter_name .. "  ")
	setText(findTF(var_31_1, "info/bk/title_form/title"), var_31_10[1])

	local var_31_11 = var_31_10[2] or ""

	setText(findTF(var_31_1, "info/bk/title_form/title_en"), var_31_11)
	setFillAmount(findTF(var_31_1, "circle/progress"), arg_31_2.progress / 100)
	setText(var_31_8, string.format("%d%%", arg_31_2.progress))
	setActive(var_31_9, arg_31_2:existAchieve())

	if arg_31_2:existAchieve() then
		for iter_31_2, iter_31_3 in ipairs(arg_31_2.achieves) do
			local var_31_12 = var_31_9:GetChild(iter_31_2 - 1):Find("light")

			setActive(var_31_12, (ChapterConst.IsAchieved(iter_31_3)))

			for iter_31_4, iter_31_5 in ipairs({
				"Lock",
				"Normal",
				"Hard"
			}) do
				if iter_31_5 ~= "Lock" then
					setActive(var_31_12:Find(iter_31_5), iter_31_4 == var_31_4)
				end
			end
		end
	end

	local var_31_13 = findTF(var_31_1, "info/bk/BG")

	for iter_31_6, iter_31_7 in ipairs({
		"Lock",
		"Normal",
		"Hard"
	}) do
		setActive(var_31_13:Find(iter_31_7), iter_31_6 == var_31_4)
	end

	setActive(findTF(var_31_1, "HardEffect"), var_31_4 == 3)

	local var_31_14 = not arg_31_2.active and arg_31_2:isClear()
	local var_31_15 = not arg_31_2.active and not arg_31_2:isUnlock()

	setActive(var_31_6, var_31_14)
	setActive(var_31_7, var_31_15)
	setActive(var_31_8, not var_31_14 and not var_31_15)
	arg_31_0:DeleteTween("fighting" .. arg_31_2.id)

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

		arg_31_0:RecordTween("fighting" .. arg_31_2.id, LeanTween.alphaCanvas(var_31_21, 0, 0.5):setFrom(1):setEase(LeanTweenType.easeInOutSine):setLoopPingPong().uniqueId)
	end

	local var_31_22 = findTF(var_31_1, "triesLimit")
	local var_31_23 = arg_31_2:isTriesLimit()

	setActive(var_31_22, var_31_23)

	if var_31_23 then
		local var_31_24 = arg_31_2:getConfig("count")

		setText(var_31_22:Find("label"), i18n("levelScene_chapter_count_tip"))

		local var_31_26 = var_31_22:Find("Text")
		local var_31_28 = var_31_24 - arg_31_2:getTodayDefeatCount() .. "/" .. var_31_24

		if var_31_24 <= arg_31_2:getTodayDefeatCount() then
			var_31_25(var_31_26, var_31_27(var_31_28, var_31_29))

			local var_31_30 = getProxy(ChapterProxy):IsActivitySPChapterActive(pg.expedition_data_by_map[arg_31_2:getConfig("map")].on_activity)

			var_31_30 = var_31_30 and SettingsProxy.IsShowActivityMapSPTip()

			setActive(var_31_22:Find("TipRect"), var_31_30)

			local var_31_31 = arg_31_2:GetDailyBonusQuota()
			local var_31_32 = findTF(var_31_1, "mark")
			local var_31_33 = var_31_32:Find("bonus")
			local var_31_34 = var_31_33:Find("icon")
			local var_31_35 = findTF(var_31_33, "icon/Image")

			setActive(var_31_33, var_31_31)
			setActive(var_31_32, var_31_31)

			if var_31_34 then
				setActive(var_31_34, var_31_31 and arg_31_0.bonusPtIconPath)
			end

			if var_31_31 then
				local var_31_36 = var_31_32:GetComponent(typeof(CanvasGroup))

				arg_31_0.sceneParent.loader:GetSprite("ui/levelmainscene_atlas", arg_31_2:GetDailyBonusIconName(), var_31_33)

				if var_31_34 and arg_31_0.bonusPtIconPath then
					if var_31_35 then
						GetImageSpriteFromAtlasAsync(arg_31_0.bonusPtIconPath, "", var_31_35, true)
					else
						GetImageSpriteFromAtlasAsync(arg_31_0.bonusPtIconPath, "", var_31_34, true)
					end
				end

				LeanTween.cancel(go(var_31_32), true)

				local var_31_37 = var_31_32.anchoredPosition.y

				var_31_32:GetComponent(typeof(CanvasGroup)).alpha = 0

				LeanTween.value(go(var_31_32), 0, 1, 0.2):setOnUpdate(System.Action_float(function(arg_32_0)
					var_31_36.alpha = arg_32_0
					var_31_32.anchoredPosition.y = var_31_37 * arg_32_0
					var_31_32.anchoredPosition = var_31_32.anchoredPosition

					return
				end)):setOnComplete(System.Action(function()
					var_31_36.alpha = 1
					var_31_32.anchoredPosition.y = var_31_37
					var_31_32.anchoredPosition = var_31_32.anchoredPosition

					return
				end)):setEase(LeanTweenType.easeOutSine):setDelay(0.7)
			end

			local var_31_38 = arg_31_2.id

			onButton(arg_31_0, var_31_1, function()
				arg_31_0:TryOpenChapterInfo(var_31_38, nil, var_31_3.list)

				return
			end, SFX_UI_WEIGHANCHOR_SELECT)

			return
		end
	end
end

function var_0_0.SwitchChapter(arg_35_0, arg_35_1)
	if not arg_35_0.chapterGroupDict[arg_35_1] then
		return
	end

	local var_35_0 = arg_35_0.chapterGroupDict[arg_35_1].list[arg_35_0.chapterGroupDict[arg_35_1].index]

	if arg_35_0.chapterGroupDict[arg_35_1].list[arg_35_0.chapterGroupDict[arg_35_1].index] == arg_35_1 then
		return
	end

	local var_35_1 = table.indexof(arg_35_0.chapterGroupDict[arg_35_1].list, arg_35_1)

	arg_35_0.chapterGroupDict[arg_35_1].index = var_35_1

	PlayerPrefs.SetInt("spchapter_selected_" .. getProxy(PlayerProxy):getRawData().id .. "_" .. arg_35_0.chapterGroupDict[arg_35_1].list[1], var_35_1)

	arg_35_0.chapterTFsById[var_35_0] = nil
	arg_35_0.chapterTFsById[arg_35_1] = arg_35_0.chapterTFsById[var_35_0]

	arg_35_0:UpdateChapterTF(arg_35_1)

	return
end

function var_0_0.UpdateChapterTF(arg_36_0, arg_36_1)
	if not arg_36_0.chapterGroupDict[arg_36_1] then
		return
	end

	local var_36_0 = arg_36_0.chapterTFsById[arg_36_1]

	if arg_36_0.chapterTFsById[arg_36_1] then
		arg_36_0:UpdateMapItem(var_36_0, (getProxy(ChapterProxy):getChapterById(arg_36_1)))
	end

	return
end

function var_0_0.RecyclePools(arg_37_0)
	for iter_37_0 = #arg_37_0.activeItems, 1, -1 do
		if arg_37_0.activeItems[iter_37_0].template == arg_37_0.oneLineTpl then
			setSizeDelta(arg_37_0.activeItems[iter_37_0].active, {
				x = arg_37_0.oneLineWidth,
				y = arg_37_0.oneLineHeight
			})
		end

		arg_37_0.pools[arg_37_0.activeItems[iter_37_0].template]:Enqueue(arg_37_0.activeItems[iter_37_0].active)
	end

	table.clean(arg_37_0.activeItems)

	arg_37_0.storyNodeTFsById = {}

	return
end

local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3

function var_0_0.UpdateStoryNodeStatus(arg_38_0)
	local var_38_0 = 0
	local var_38_1 = 0
	local var_38_2 = pg.NewStoryMgr.GetInstance()
	local var_38_3 = {}

	table.Foreach(arg_38_0.spStoryIDs, function(arg_39_0, arg_39_1)
		var_38_3[arg_39_1] = {}

		return
	end)

	for iter_38_0 = 1, #arg_38_0.spStoryNodes do
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

			var_38_3[var_38_6].conditionFinishedList = {}
		end

		if var_38_12 then
			var_38_10 = var_0_4
		elseif var_38_9 then
			var_38_10 = var_0_3
		end

		var_38_3[var_38_6].status = var_38_10
	end

	arg_38_0.storyNodeStatus = var_38_3
	arg_38_0.storyReadCount, arg_38_0.storyReadMax = var_38_0, var_38_1

	return
end

function var_0_0.UpdateStory(arg_42_0)
	arg_42_0:RecyclePools()

	local var_42_0 = {
		"162443",
		"ffffff",
		"ffcb5a"
	}
	local var_42_1 = arg_42_0.data:getConfig("story_inactive_color")

	if var_42_1 and #var_42_1 > 0 then
		({
			"162443",
			"ffffff",
			"ffcb5a"
		})[1] = var_42_1
	end

	local var_42_2 = 0
	local var_42_3 = 150
	local var_42_4 = {
		{
			node = arg_42_0.storyTree.root,
			nodePos = Vector2.New(150, 0)
		}
	}
	local var_42_5 = arg_42_0.nodeTplWidth
	local var_42_6 = arg_42_0.oneLineWidth
	local var_42_7 = arg_42_0.branchHeadWidth
	local var_42_8 = arg_42_0.branchUpWidth
	local var_42_9 = arg_42_0.branchUpHeight
	local var_42_10 = arg_42_0.UnionTailWidth
	local var_42_11 = 75
	local var_42_12 = 82
	local var_42_13 = 32

	while (function()
		local var_43_0 = table.remove(var_42_4, 1)
		local var_43_1 = var_43_0.node:GetConfigID()

		;(function()
			local var_44_0 = arg_42_0:DequeItem(arg_42_0.storyNodeTpl)

			var_44_0.name = var_43_1

			setAnchoredPosition(var_44_0, var_43_0.nodePos)

			arg_42_0.storyNodeTFsById[var_43_1] = {
				nodeTF = tf(var_44_0)
			}

			return
		end)()

		local var_43_2 = arg_42_0.storyTree.childDict[var_43_1] or {}

		if #var_43_2 == 0 then
			var_42_2 = var_43_0.nodePos.x + var_42_5 + var_42_3
		elseif #var_43_2 == 1 then
			local var_43_3 = var_43_2[1]:GetConfigID()
			local var_43_4 = arg_42_0:DequeItem(arg_42_0.oneLineTpl)

			var_43_4.name = string.format("Line%s_%s", var_43_1, var_43_3)

			setAnchoredPosition(var_43_4, var_43_0.nodePos + Vector2.New(var_42_5 + var_42_13, 0))

			nextPos = tf(var_43_4).anchoredPosition + Vector2.New(var_42_6 + var_42_11, 0)

			local var_43_5 = arg_42_0.storyNodeStatus[var_43_3].status

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

					local var_47_0 = arg_42_0.storyTree.childDict[var_46_1:GetConfigID()]

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

			local var_43_8 = _.max({})
			local var_43_9 = var_43_8 * (var_42_5 + var_42_11 + var_42_13) + (var_43_8 - 1) * var_42_6
			local var_43_10 = var_43_0.nodePos + Vector2.New(var_42_5 + var_42_13, 0)

			;(function()
				local var_48_0 = arg_42_0:DequeItem(arg_42_0.branchHeadTpl)

				setAnchoredPosition(var_48_0, var_43_10)

				var_43_10 = var_43_10 + Vector2.New(var_42_7, 0)

				local var_48_1 = arg_42_0.storyNodeStatus[var_43_2[1]:GetConfigID()].status

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
						var_51_0 = arg_42_0:DequeItem(arg_42_0.branchUpTpl)

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
					elseif (arg_50_0 == 3 or arg_50_0 == 2 and #var_43_2 == 2) and arg_42_0.storyTree.childDict[var_43_2[1]:GetConfigID()] then
						var_51_0 = arg_42_0:DequeItem(arg_42_0.branchDownTpl)

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
						var_51_0 = arg_42_0:DequeItem(arg_42_0.branchCenterTpl)

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

					local var_51_4 = arg_42_0.storyNodeStatus[var_50_1].status

					eachChild(var_51_0, function(arg_52_0)
						setImageColor(arg_52_0, Color.NewHex(var_42_0[var_51_4]))

						return
					end)

					return
				end)()

				var_50_2 = var_50_2 + Vector2.New(var_42_11, 0)

				local var_50_3 = arg_42_0:DequeItem(arg_42_0.storyNodeTpl)

				var_50_3.name = var_50_1

				setAnchoredPosition(var_50_3, var_50_2)

				arg_42_0.storyNodeTFsById[var_50_1] = {
					nodeTF = tf(var_50_3)
				}
				var_50_2 = var_50_2 + Vector2.New(var_42_5 + var_42_13, 0)

				local var_50_4 = arg_50_1

				if arg_42_0.storyTree.childDict[var_50_1] then
					local var_50_5 = arg_42_0.storyTree.childDict[var_50_1][1]

					while (function()
						if not var_50_5 or var_50_5 == var_43_7 then
							return
						end

						local var_53_0 = arg_42_0:DequeItem(arg_42_0.oneLineTpl)

						var_53_0.name = string.format("Line%s_%s", var_50_4:GetConfigID(), var_50_5:GetConfigID())

						setAnchoredPosition(var_53_0, var_50_2)

						var_50_2 = var_50_2 + Vector2.New(var_50_0 + var_42_11, 0)

						setSizeDelta(var_53_0, {
							x = var_50_0,
							y = arg_42_0.oneLineHeight
						})

						local var_53_1 = arg_42_0.storyNodeStatus[var_50_5:GetConfigID()].status

						eachChild(var_53_0, function(arg_54_0)
							setImageColor(arg_54_0, Color.NewHex(var_42_0[var_53_1]))

							return
						end)

						local var_53_2 = arg_42_0:DequeItem(arg_42_0.storyNodeTpl)

						var_53_2.name = var_50_5:GetConfigID()

						setAnchoredPosition(var_53_2, var_50_2)

						arg_42_0.storyNodeTFsById[var_50_5:GetConfigID()] = {
							nodeTF = tf(var_53_2)
						}
						var_50_2 = var_50_2 + Vector2.New(var_42_5 + var_42_13, 0)

						local var_53_3 = arg_42_0.storyTree.childDict[var_50_5:GetConfigID()]

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
						var_50_6 = arg_42_0:DequeItem(arg_42_0.unionUpTpl)

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
						var_50_6 = arg_42_0:DequeItem(arg_42_0.unionDownTpl)

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
						var_50_6 = arg_42_0:DequeItem(arg_42_0.unionCenterTpl)

						setAnchoredPosition(var_50_6, var_50_2)

						if var_43_6[arg_50_0] < var_43_8 then
							local var_50_9 = tf(var_50_6).sizeDelta

							var_50_9.x = var_50_9.x + var_50_0

							setSizeDelta(var_50_6, var_50_9)

							var_50_2 = var_50_2 + Vector2.New(var_50_0, 0)
						end
					end

					var_50_6.name = string.format("Union%s_%s", var_50_4:GetConfigID(), var_43_7:GetConfigID())

					local var_50_10 = arg_42_0.storyNodeStatus[var_43_7:GetConfigID()].status

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

					local var_56_0 = arg_42_0:DequeItem(arg_42_0.unionTailTpl)

					setAnchoredPosition(var_56_0, var_43_10)

					var_43_10 = var_43_10 + Vector2.New(var_42_10 + var_42_12, 0)

					local var_56_1 = arg_42_0.storyNodeStatus[var_43_7:GetConfigID()].status

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

	setSizeDelta(arg_42_0.storyContainer, {
		x = var_42_2
	})

	if arg_42_0.spStoryUnreleasedNode then
		local var_42_14 = cloneTplTo(arg_42_0.unreleasedNodeTpl, arg_42_0.storyContainer)

		setAnchoredPosition(var_42_14, {
			y = 0,
			x = var_42_2
		})
		setText(var_42_14:Find("text"), arg_42_0.spStoryUnreleasedNode:GetDisplayName())
		ResourceMgr.Inst:getAssetAsync("ui/" .. arg_42_0.spStoryUnreleasedNode:GetCleanAnimator(), "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_58_0)
			local var_58_0 = Instantiate(arg_58_0)

			tf(var_58_0).localPosition = Vector3.New(-525, 0, 380)

			setParent(var_58_0, var_42_14)

			return
		end), true, true)
	end

	local var_42_15 = arg_42_0.spStoryNodes

	for iter_42_0 = 1, #arg_42_0.spStoryNodes do
		local var_42_16 = var_42_15[iter_42_0]
		local var_42_17 = var_42_15[iter_42_0]:GetConfigID()
		local var_42_18 = arg_42_0.storyNodeStatus[var_42_17].status
		local var_42_19 = arg_42_0.storyNodeTFsById[var_42_17].nodeTF
		local var_42_20 = arg_42_0.storyNodeTFsById[var_42_17].nodeTF:Find("info/bk/title_form/title")

		if arg_42_0.storyNodeStatus[var_42_17].status == var_0_2 then
			local var_42_21 = var_42_16:GetUnlockDesc()
			local var_42_22 = ""

			if type(var_42_21) == "table" then
				local var_42_23 = arg_42_0.storyNodeStatus[var_42_17].conditionFinishedList or {}

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

		local var_42_25, var_42_26

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
		elseif var_42_24 == ActivitySpStoryNode.NODE_TYPE.BATTLE then
			setActive(var_42_19:Find("circle/Story"), false)
			setActive(var_42_19:Find("circle/Option"), false)
			setActive(var_42_19:Find("circle/Battle"), var_42_24 == ActivitySpStoryNode.NODE_TYPE.BATTLE)
			setActive(var_42_19:Find("circle/Battle/Done"), var_42_18 == var_0_4)

			var_42_25 = setActive
			var_42_26 = var_42_19:Find("circle/progress")
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

		onButton(arg_42_0, var_42_19, function()
			if var_42_18 == var_0_2 then
				return
			end

			arg_42_0:PlayStory(var_42_16:GetStoryName(), function()
				arg_42_0.needFocusStory = true

				arg_42_0:Move2UnlockStory()

				return
			end, true)

			return
		end)
	end

	setText(arg_42_0.progressText, arg_42_0.storyReadCount .. "/" .. arg_42_0.storyReadMax)
	setActive(arg_42_0.storyAward, tobool(arg_42_0.storyTask))

	if arg_42_0.storyTask then
		local var_42_28 = arg_42_0.storyTask:getConfig("award_display")

		updateDrop(arg_42_0.storyAward:GetChild(0), (Drop.New({
			type = var_42_28[1][1],
			id = var_42_28[1][2],
			count = var_42_28[1][3]
		})))

		local var_42_29 = arg_42_0.storyTask:getTaskStatus()

		setActive(arg_42_0.storyAward:Find("get"), var_42_29 == 1)
		setActive(arg_42_0.storyAward:Find("got"), var_42_29 == 2)
		onButton(arg_42_0, arg_42_0.storyAward, function()
			arg_42_0:emit(BaseUI.ON_DROP, var_0)

			return
		end)
	end

	return
end

function var_0_0.DequeItem(arg_62_0, arg_62_1)
	local var_62_0 = arg_62_0.pools[arg_62_1]:Dequeue()

	table.insert(arg_62_0.activeItems, {
		template = arg_62_1,
		active = var_62_0
	})
	setActive(var_62_0, true)
	setParent(var_62_0, arg_62_0.storyContainer)

	return var_62_0
end

function var_0_0.Move2UnlockStory(arg_63_0)
	if not arg_63_0.needFocusStory then
		return
	end

	arg_63_0.needFocusStory = nil

	local var_63_0

	for iter_63_0 = #arg_63_0.spStoryNodes, 1, -1 do
		local var_63_1 = arg_63_0.spStoryNodes[iter_63_0]:GetConfigID()

		if arg_63_0.storyNodeStatus[var_63_1].status > var_0_2 then
			var_63_0 = var_63_1

			break
		end
	end

	;({}).x = -math.clamp(arg_63_0.storyNodeTFsById[var_63_0].nodeTF.anchoredPosition.x + arg_63_0.storyNodeTpl.rect.width * 0.5 - arg_63_0.storyContainer.parent.rect.width * 0.5, 0, math.max(0, arg_63_0.storyContainer.rect.width - arg_63_0.storyContainer.parent.rect.width))

	setAnchoredPosition(arg_63_0.storyContainer, {})

	return
end

function var_0_0.SwitchStoryMapAndBGM(arg_64_0)
	local var_64_0 = arg_64_0.data:getConfig("default_background")
	local var_64_1 = arg_64_0.data:getConfig("default_bgm")
	local var_64_2

	for iter_64_0 = 1, #arg_64_0.spStoryNodes do
		if arg_64_0.storyNodeStatus[arg_64_0.spStoryNodes[iter_64_0]:GetConfigID()].status == var_0_4 then
			var_64_1 = arg_64_0.spStoryNodes[iter_64_0]:GetCleanBGM()
			var_64_0 = arg_64_0.spStoryNodes[iter_64_0]:GetCleanBG()
			var_64_2 = arg_64_0.spStoryNodes[iter_64_0]:GetCleanAnimator()
		else
			break
		end
	end

	arg_64_0.sceneParent:SwitchBG({
		{
			bgPrefix = "bg",
			BG = var_64_0,
			Animator = var_64_2
		}
	})
	pg.BgmMgr.GetInstance():Pop(arg_64_0.__cname)
	pg.BgmMgr.GetInstance():Push(arg_64_0.__cname, var_64_1)

	return
end

function var_0_0.TrySubmitTask(arg_65_0)
	local var_65_0 = true

	for iter_65_0, iter_65_1 in ipairs(arg_65_0.spStoryNodes) do
		local var_65_1 = iter_65_1:GetStoryName()

		if var_65_1 and var_65_1 ~= "" then
			var_65_0 = var_65_0 and pg.NewStoryMgr.GetInstance():IsPlayed(var_65_1)
		end

		if not var_65_0 then
			break
		end
	end

	if var_65_0 and arg_65_0.storyTask and arg_65_0.storyTask:getTaskStatus() == 1 then
		arg_65_0:emit(LevelMediator2.ON_SUBMIT_TASK, arg_65_0.storyTask.id)

		return
	end

	return
end

function var_0_0.PlayStory(arg_66_0, arg_66_1, arg_66_2, arg_66_3)
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
				arg_66_0:emit(LevelMediator2.ON_PERFORM_COMBAT, var_67_0, nil, var_66_1)
			else
				var_66_0:PlayForAcivitySpStory(arg_66_1, arg_67_0, arg_66_3)
			end

			return
		end,
		function(arg_68_0, ...)
			existCall(arg_66_2, ...)
			arg_66_0:UpdateView()

			return
		end
	})

	return
end

function var_0_0.UpdateStoryTask(arg_69_0)
	local var_69_0 = arg_69_0.activity and arg_69_0.activity:getConfig("config_client").task_id

	if not var_69_0 then
		return
	end

	local var_69_1 = getProxy(TaskProxy):getTaskVO(var_69_0)

	var_69_1 = var_69_1 or Task.New({
		submit_time = 1,
		id = var_69_0
	})
	arg_69_0.storyTask = var_69_1

	return
end

function var_0_0.OnSubmitTaskDone(arg_70_0)
	arg_70_0:UpdateView()

	return
end

function var_0_0.OnDestroy(arg_71_0)
	arg_71_0:RecyclePools()

	for iter_71_0, iter_71_1 in pairs(arg_71_0.pools) do
		iter_71_1:Clear()
	end

	return
end

return var_0_0
