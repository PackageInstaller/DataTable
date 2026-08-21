local var_0_0 = class("MapBuilderSPSeries", import(".MapBuilder"))

var_0_0.DISPLAY = {
	STORY = 2,
	BATTLE = 1
}
var_0_0.DIFFICULITY = {
	EASY = 1,
	HARD = 2
}

function var_0_0.GetType(arg_1_0)
	return MapBuilder.TYPESPSERIES
end

function var_0_0.getUIName(arg_2_0)
	return "LevelSelectSPSeriesUI"
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
	arg_4_0.storyNodeTpl = arg_4_0.storyHolder:Find("tpl")

	setActive(arg_4_0.storyNodeTpl, false)

	arg_4_0.progressText = arg_4_0._tf:Find("Story/Desc/Text")
	arg_4_0.storyAward = arg_4_0._tf:Find("Story/Award")
	arg_4_0.activeItems = {}
	arg_4_0.displayChapterIDs = {}
	arg_4_0.chapterTFsById = {}
	arg_4_0.storyNodeTFsById = {}

	arg_4_0:bind(LevelUIConst.SWITCH_SPCHAPTER_DIFFICULTY, function(arg_5_0, arg_5_1)
		arg_4_0:SwitchChapter(arg_5_1)

		return
	end)
	onButton(arg_4_0, arg_4_0.battleLayer:Find("Story/Switch"), function()
		arg_4_0:SetDisplayMode(var_0_0.DISPLAY.STORY)

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
	arg_12_0.storyNodesDict = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.activity:getConfig("config_client").storys) do
		arg_12_0.storyNodesDict[iter_12_1] = BossRushStoryNode.New({
			id = iter_12_1
		})

		local var_12_1 = arg_12_0.storyHolder:Find(tostring(iter_12_1)) or cloneTplTo(arg_12_0.storyNodeTpl, arg_12_0.storyHolder, iter_12_1)
		local var_12_2 = arg_12_0.storyNodesDict[iter_12_1]:getConfigTable()

		setLocalPosition(var_12_1, {
			x = 0 * tonumber(var_12_2.pos_x),
			y = 1080 * tonumber(var_12_2.pos_y)
		})
	end

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

function var_0_0.SetDisplayMode(arg_19_0, arg_19_1)
	if arg_19_1 == arg_19_0.contextData.displayMode then
		return
	end

	arg_19_0.contextData.displayMode = arg_19_1

	arg_19_0:UpdateView()

	return
end

function var_0_0.UpdateView(arg_20_0)
	local var_20_0 = string.split(arg_20_0.contextData.map:getConfig("name"), "||")

	if arg_20_0.contextData.displayMode == var_0_0.DISPLAY.STORY then
		var_20_0 = string.split(var_20_0[1], "·")

		setText(arg_20_0.sceneParent.chapterName, var_20_0[1] .. i18n("levelscene_title_story"))
	else
		setText(arg_20_0.sceneParent.chapterName, var_20_0[1])
	end

	arg_20_0.sceneParent.loader:GetSpriteQuiet("chapterno", "chapter" .. arg_20_0.contextData.map:getMapTitleNumber(), arg_20_0.sceneParent.chapterNoTitle, true)

	arg_20_0.contextData.displayMode = arg_20_0.contextData.displayMode or var_0_0.DISPLAY.BATTLE

	var_0_0.super.UpdateView(arg_20_0)

	local var_20_1 = arg_20_0.contextData.displayMode == var_0_0.DISPLAY.BATTLE

	setActive(arg_20_0._tf:Find("Battle"), arg_20_0.contextData.displayMode == var_0_0.DISPLAY.BATTLE)
	setActive(arg_20_0._tf:Find("Story"), not var_20_1)

	local var_20_2 = getProxy(ChapterProxy):IsActivitySPChapterActive(arg_20_0.contextData.map:getConfig("on_activity"))

	var_20_2 = var_20_2 and SettingsProxy.IsShowActivityMapSPTip()

	setActive(arg_20_0.battleLayer:Find("Story/BattleTip"), false)
	setActive(arg_20_0.storyLayer:Find("Battle/BattleTip"), var_20_2)
	arg_20_0:UpdateStoryTask()

	if var_20_1 then
		arg_20_0:UpdateBonusPtIconPath()
		arg_20_0:UpdateBattle()
		arg_20_0.sceneParent:SwitchMapBG(arg_20_0.contextData.map)
		arg_20_0.sceneParent:PlayBGM()
	else
		arg_20_0:UpdateStory()
		arg_20_0:SwitchStoryMapAndBGM()
	end

	arg_20_0:TrySubmitTask()

	return
end

function var_0_0.UpdateBattle(arg_21_0)
	local var_21_0 = getProxy(ChapterProxy)
	local var_21_1 = {}

	for iter_21_0, iter_21_1 in ipairs(arg_21_0.displayChapterIDs) do
		table.insert({}, (var_21_0:getChapterById(iter_21_1)))
	end

	table.clear(arg_21_0.chapterTFsById)
	UIItemList.StaticAlign(arg_21_0.itemHolder, arg_21_0.chapterTpl, #{}, function(arg_22_0, arg_22_1, arg_22_2)
		if arg_22_0 ~= UIItemList.EventUpdate then
			return
		end

		local var_22_0 = var_21_1[arg_22_1 + 1]

		arg_21_0:UpdateMapItem(arg_22_2, var_21_1[arg_22_1 + 1])

		arg_22_2.name = "Chapter_" .. var_22_0.id
		arg_21_0.chapterTFsById[var_22_0.id] = arg_22_2

		return
	end)

	return
end

function var_0_0.HideFloat(arg_23_0)
	var_0_0.super.HideFloat(arg_23_0)
	setActive(arg_23_0.itemHolder, false)

	return
end

function var_0_0.ShowFloat(arg_24_0)
	var_0_0.super.ShowFloat(arg_24_0)
	setActive(arg_24_0.itemHolder, true)

	return
end

function var_0_0.UpdateMapItem(arg_25_0, arg_25_1, arg_25_2)
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

	local var_25_3 = arg_25_0.chapterGroupDict[arg_25_2.id]

	assert(arg_25_0.chapterGroupDict[arg_25_2.id])

	local var_25_4 = {
		"Lock",
		"Normal",
		"Hard"
	}
	local var_25_5 = 1

	if arg_25_2:isUnlock() then
		var_25_5 = 2

		if #arg_25_0.chapterGroupDict[arg_25_2.id].list > 1 then
			var_25_5 = table.indexof(arg_25_0.chapterGroupDict[arg_25_2.id].list, arg_25_2.id) + 1
		elseif arg_25_2:IsSpChapter() or arg_25_2:IsEXChapter() then
			var_25_5 = 3
		elseif arg_25_0.contextData.map:isHardMap() then
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

	local var_25_12 = var_25_11[2] or ""

	setText(findTF(var_25_1, "info/bk/title_form/title_en"), var_25_12)
	setFillAmount(findTF(var_25_1, "circle/progress"), arg_25_2.progress / 100)
	setText(var_25_9, string.format("%d%%", arg_25_2.progress))
	setActive(var_25_10, arg_25_2:existAchieve())

	if arg_25_2:existAchieve() then
		for iter_25_2, iter_25_3 in ipairs(arg_25_2.achieves) do
			local var_25_13 = var_25_10:GetChild(iter_25_2 - 1):Find("light")

			setActive(var_25_13, (ChapterConst.IsAchieved(iter_25_3)))

			for iter_25_4, iter_25_5 in ipairs(var_25_4) do
				if iter_25_5 ~= "Lock" then
					setActive(var_25_13:Find(iter_25_5), iter_25_4 == var_25_5)
				end
			end
		end
	end

	local var_25_14 = findTF(var_25_1, "info/bk/BG")

	for iter_25_6, iter_25_7 in ipairs(var_25_4) do
		setActive(var_25_14:Find(iter_25_7), iter_25_6 == var_25_5)
	end

	setActive(findTF(var_25_1, "HardEffect"), var_25_5 == 3)

	local var_25_15 = not arg_25_2.active and arg_25_2:isClear()
	local var_25_16 = not arg_25_2.active and not arg_25_2:isUnlock()

	setActive(var_25_7, var_25_15)
	setActive(var_25_8, var_25_16)
	setActive(var_25_9, not var_25_15 and not var_25_16)
	arg_25_0:DeleteTween("fighting" .. arg_25_2.id)

	local var_25_17 = findTF(var_25_1, "circle/fighting")

	setText(findTF(var_25_17, "Text"), i18n("tag_level_fighting"))

	local var_25_18 = findTF(var_25_1, "circle/oni")

	setText(findTF(var_25_18, "Text"), i18n("tag_level_oni"))

	local var_25_19 = findTF(var_25_1, "circle/narrative")

	setText(findTF(var_25_19, "Text"), i18n("tag_level_narrative"))
	setActive(var_25_17, false)
	setActive(var_25_18, false)
	setActive(var_25_19, false)

	local var_25_20

	if arg_25_2:getConfig("chapter_tag") == 1 then
		var_25_20 = var_25_19
	end

	if arg_25_2.active then
		var_25_20 = arg_25_2:existOni() and var_25_18 or var_25_17
	end

	if var_25_20 then
		setActive(var_25_20, true)

		local var_25_22 = GetOrAddComponent(var_25_20, "CanvasGroup")

		var_25_22.alpha = 1

		arg_25_0:RecordTween("fighting" .. arg_25_2.id, LeanTween.alphaCanvas(var_25_22, 0, 0.5):setFrom(1):setEase(LeanTweenType.easeInOutSine):setLoopPingPong().uniqueId)
	end

	local var_25_23 = findTF(var_25_1, "triesLimit")
	local var_25_24 = arg_25_2:isTriesLimit()

	setActive(var_25_23, var_25_24)

	if var_25_24 then
		local var_25_25 = arg_25_2:getConfig("count")

		setText(var_25_23:Find("label"), i18n("levelScene_chapter_count_tip"))

		local var_25_27 = var_25_23:Find("Text")
		local var_25_29 = var_25_25 - arg_25_2:getTodayDefeatCount() .. "/" .. var_25_25

		if var_25_25 <= arg_25_2:getTodayDefeatCount() then
			var_25_26(var_25_27, var_25_28(var_25_29, var_25_30))

			local var_25_31 = getProxy(ChapterProxy):IsActivitySPChapterActive(pg.expedition_data_by_map[arg_25_2:getConfig("map")].on_activity)

			var_25_31 = var_25_31 and SettingsProxy.IsShowActivityMapSPTip()

			setActive(var_25_23:Find("TipRect"), var_25_31)

			local var_25_32 = arg_25_2:GetDailyBonusQuota()
			local var_25_33 = findTF(var_25_1, "mark")
			local var_25_34 = var_25_33:Find("bonus")
			local var_25_35 = var_25_34:Find("icon")
			local var_25_36 = findTF(var_25_34, "icon/Image")

			setActive(var_25_34, var_25_32)
			setActive(var_25_33, var_25_32)

			if var_25_35 then
				setActive(var_25_35, var_25_32 and arg_25_0.bonusPtIconPath)
			end

			if var_25_32 then
				local var_25_37 = var_25_33:GetComponent(typeof(CanvasGroup))

				arg_25_0.sceneParent.loader:GetSprite("ui/levelmainscene_atlas", arg_25_2:GetDailyBonusIconName(), var_25_34)

				if var_25_35 and arg_25_0.bonusPtIconPath then
					if var_25_36 then
						GetImageSpriteFromAtlasAsync(arg_25_0.bonusPtIconPath, "", var_25_36, true)
					else
						GetImageSpriteFromAtlasAsync(arg_25_0.bonusPtIconPath, "", var_25_35, true)
					end
				end

				LeanTween.cancel(go(var_25_33), true)

				local var_25_38 = var_25_33.anchoredPosition.y

				var_25_33:GetComponent(typeof(CanvasGroup)).alpha = 0

				LeanTween.value(go(var_25_33), 0, 1, 0.2):setOnUpdate(System.Action_float(function(arg_26_0)
					var_25_37.alpha = arg_26_0
					var_25_33.anchoredPosition.y = var_25_38 * arg_26_0
					var_25_33.anchoredPosition = var_25_33.anchoredPosition

					return
				end)):setOnComplete(System.Action(function()
					var_25_37.alpha = 1
					var_25_33.anchoredPosition.y = var_25_38
					var_25_33.anchoredPosition = var_25_33.anchoredPosition

					return
				end)):setEase(LeanTweenType.easeOutSine):setDelay(0.7)
			end

			local var_25_39 = arg_25_2.id

			onButton(arg_25_0, var_25_1, function()
				arg_25_0:TryOpenChapterInfo(var_25_39, nil, var_25_3.list)

				return
			end, SFX_UI_WEIGHANCHOR_SELECT)
			arg_25_0:PlayerLevelTplAnimation(arg_25_1, {
				status = var_25_4[var_25_5],
				chapterVO = arg_25_2
			})

			return
		end
	end
end

function var_0_0.PlayerLevelTplAnimation(arg_29_0, arg_29_1, arg_29_2)
	return
end

function var_0_0.SwitchChapter(arg_30_0, arg_30_1)
	if not arg_30_0.chapterGroupDict[arg_30_1] then
		return
	end

	local var_30_0 = arg_30_0.chapterGroupDict[arg_30_1].list[arg_30_0.chapterGroupDict[arg_30_1].index]

	if arg_30_0.chapterGroupDict[arg_30_1].list[arg_30_0.chapterGroupDict[arg_30_1].index] == arg_30_1 then
		return
	end

	local var_30_1 = table.indexof(arg_30_0.chapterGroupDict[arg_30_1].list, arg_30_1)

	arg_30_0.chapterGroupDict[arg_30_1].index = var_30_1

	PlayerPrefs.SetInt("spchapter_selected_" .. getProxy(PlayerProxy):getRawData().id .. "_" .. arg_30_0.chapterGroupDict[arg_30_1].list[1], var_30_1)

	arg_30_0.chapterTFsById[var_30_0] = nil
	arg_30_0.chapterTFsById[arg_30_1] = arg_30_0.chapterTFsById[var_30_0]

	arg_30_0:UpdateChapterTF(arg_30_1)

	return
end

function var_0_0.UpdateChapterTF(arg_31_0, arg_31_1)
	if not arg_31_0.chapterGroupDict[arg_31_1] then
		return
	end

	local var_31_0 = arg_31_0.chapterTFsById[arg_31_1]

	if arg_31_0.chapterTFsById[arg_31_1] then
		arg_31_0:UpdateMapItem(var_31_0, (getProxy(ChapterProxy):getChapterById(arg_31_1)))
	end

	return
end

function var_0_0.UpdateStory(arg_32_0)
	local var_32_1 = pg.NewStoryMgr.GetInstance()
	local var_32_2 = 0
	local var_32_3 = 0

	for iter_32_0, iter_32_1 in pairs(arg_32_0.storyNodesDict) do
		local var_32_4 = arg_32_0.storyHolder:Find(tostring(iter_32_1.id))

		setActive(var_32_4, (iter_32_1:IsActive(arg_32_0.activity, arg_32_0.sceneParent.ptActivity)))
		setText(var_32_4:Find("main/char/bg/Text"), iter_32_1:GetName())

		local var_32_5 = iter_32_1:IsReaded()

		setActive(var_32_4:Find("main/char"), not var_32_5)
		setActive(var_32_4:Find("main/talk"), var_32_5)
		onButton(arg_32_0, var_32_4, function()
			if var_32_5 then
				return
			end

			arg_32_0:PlayStory(iter_32_1:GetStory(), function()
				arg_32_0:UpdateView()

				return
			end)

			return
		end)

		var_32_2 = var_32_2 + (var_32_5 and 1 or 0)
		var_32_3 = var_32_3 + 1
	end

	setText(arg_32_0.progressText, var_32_2 .. "/" .. var_32_3)
	setActive(arg_32_0.storyAward, tobool(arg_32_0.storyTask))

	if arg_32_0.storyTask then
		updateDrop(arg_32_0.storyAward:GetChild(0), (Drop.Create(arg_32_0.storyTask:getConfig("award_display")[1])))

		local var_32_6 = arg_32_0.storyTask:getTaskStatus()

		setActive(arg_32_0.storyAward:Find("get"), var_32_6 == 1)
		setActive(arg_32_0.storyAward:Find("got"), var_32_6 == 2)
		onButton(arg_32_0, arg_32_0.storyAward, function()
			arg_32_0:emit(BaseUI.ON_DROP, var_0)

			return
		end)
	end

	return
end

function var_0_0.SwitchStoryMapAndBGM(arg_36_0)
	local var_36_0 = arg_36_0.data:getConfig("default_background")
	local var_36_1 = arg_36_0.data:getConfig("default_bgm")
	local var_36_2
	local var_36_3 = underscore.keys(arg_36_0.storyNodesDict)

	table.sort(var_36_3)

	for iter_36_0 = 1, #var_36_3 do
		if arg_36_0.storyNodesDict[var_36_3[iter_36_0]]:IsReaded() then
			var_36_0 = defaultValue(arg_36_0.storyNodesDict[var_36_3[iter_36_0]]:GetCleanBG(), var_36_0)
			var_36_1 = defaultValue(arg_36_0.storyNodesDict[var_36_3[iter_36_0]]:GetCleanBGM(), var_36_1)
			var_36_2 = defaultValue(arg_36_0.storyNodesDict[var_36_3[iter_36_0]]:GetCleanAnimator(), var_36_2)
		else
			break
		end
	end

	arg_36_0.sceneParent:SwitchBG({
		{
			bgPrefix = "bg",
			BG = var_36_0,
			Animator = var_36_2
		}
	})
	pg.BgmMgr.GetInstance():Push(arg_36_0.__cname, var_36_1)

	return
end

function var_0_0.TrySubmitTask(arg_37_0)
	if underscore.all(underscore.values(arg_37_0.storyNodesDict), function(arg_38_0)
		return arg_38_0:IsReaded()
	end) and arg_37_0.storyTask and arg_37_0.storyTask:getTaskStatus() == 1 then
		arg_37_0:emit(LevelMediator2.ON_SUBMIT_TASK, arg_37_0.storyTask.id)

		return
	end

	return
end

function var_0_0.TryOpenChapter(arg_39_0, arg_39_1)
	if arg_39_0.chapterTFsById[arg_39_1] then
		triggerButton((arg_39_0.chapterTFsById[arg_39_1]:Find("main")))
	end

	return
end

function var_0_0.PlayStory(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
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
				arg_40_0:emit(LevelMediator2.ON_PERFORM_COMBAT, var_41_0, nil, var_40_1)
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

function var_0_0.UpdateStoryTask(arg_43_0)
	local var_43_0 = arg_43_0.activity:getConfig("config_client").task_id
	local var_43_1 = getProxy(TaskProxy):getTaskVO(var_43_0)

	if not var_43_1 then
		errorMsg("Missing Activity Task ID : " .. var_43_0)
	end

	print(var_43_0)

	arg_43_0.storyTask = var_43_1 or Task.New({
		id = var_43_0
	})

	return
end

function var_0_0.OnSubmitTaskDone(arg_44_0)
	arg_44_0:UpdateView()

	return
end

function var_0_0.OnDestroy(arg_45_0)
	return
end

return var_0_0
