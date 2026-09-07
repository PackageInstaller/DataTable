local MapBuilderNormal = class("MapBuilderNormal", import(".MapBuilderPermanent"))

function MapBuilderNormal:GetType()
	return MapBuilder.TYPENORMAL
end

function MapBuilderNormal:getUIName()
	return "levels"
end

function MapBuilderNormal:Load()
	if self._state ~= MapBuilderNormal.STATES.NONE then
		return
	end

	self._state = MapBuilderNormal.STATES.LOADING

	pg.UIMgr.GetInstance():LoadingOn()
	self:Loaded(self.float:Find("levels").gameObject)
	self:Init()

	return
end

function MapBuilderNormal:Destroy()
	if self._state == MapBuilderNormal.STATES.DESTROY then
		return
	end

	if not self:GetLoaded() then
		self._state = MapBuilderNormal.STATES.DESTROY

		return
	end

	self:Hide()
	self:OnDestroy()
	pg.DelegateInfo.Dispose(self)

	self._go = nil

	self:disposeEvent()
	self:cleanManagedTween()

	self._state = MapBuilderNormal.STATES.DESTROY

	return
end

function MapBuilderNormal:OnInit()
	self.chapterTpl = self._tf:Find("level_tpl")

	setActive(self.chapterTpl, false)

	self.storyTpl = self._tf:Find("story_tpl")

	setActive(self.storyTpl, false)

	self.itemHolder = self._tf:Find("items")
	self.storyHolder = self._tf:Find("stories")
	self.chapterTFsById = {}
	self.chaptersInBackAnimating = {}

	return
end

function MapBuilderNormal:OnShow()
	MapBuilderNormal.super.OnShow(self)
	setActive(self.sceneParent.mainLayer:Find("title_chapter_lines"), true)
	setActive(self.sceneParent.topChapter:Find("title_chapter"), true)
	setActive(self.sceneParent.topChapter:Find("type_chapter"), true)

	return
end

function MapBuilderNormal:OnHide()
	setActive(self.sceneParent.mainLayer:Find("title_chapter_lines"), false)
	setActive(self.sceneParent.topChapter:Find("title_chapter"), false)
	setActive(self.sceneParent.topChapter:Find("type_chapter"), false)
	table.clear(self.chaptersInBackAnimating)

	for iter_7_0, iter_7_1 in pairs(self.chapterTFsById) do
		LeanTween.cancel(rtf((findTF(iter_7_1, "main/info/bk"))))
	end

	MapBuilderNormal.super.OnHide(self)

	return
end

function MapBuilderNormal:UpdateView()
	setText(self.sceneParent.chapterName, string.split(self.contextData.map:getConfig("name"), "||")[1])
	self.sceneParent.loader:GetSpriteQuiet("chapterno", "chapter" .. self.contextData.map:getMapTitleNumber(), self.sceneParent.chapterNoTitle, true)
	MapBuilderNormal.super.UpdateView(self)

	return
end

function MapBuilderNormal:UpdateBonusPtIconPath()
	self.bonusPtIconPath = nil

	local var_9_0 = self.data or self.contextData.map

	if not var_9_0 then
		return
	end

	local var_9_1 = var_9_0:getConfig("on_activity")

	if not var_9_1 or var_9_1 == 0 then
		return
	end

	local var_9_2 = getProxy(ActivityProxy)
	local var_9_3 = var_9_2:getActivityById(var_9_1)

	if not var_9_3 or var_9_3:isEnd() then
		return
	end

	local var_9_4 = var_9_3:GetConfigClientSetting("PTID")

	if not var_9_4 then
		return
	end

	local var_9_5 = underscore.detect(var_9_2:getActivitiesByType(ActivityConst.ACTIVITY_TYPE_PT_RANK), function(arg_10_0)
		return arg_10_0 and not arg_10_0:isEnd() and arg_10_0:getConfig("config_id") == var_9_4
	end)

	if not var_9_5 then
		return
	end

	local var_9_6 = tonumber(var_9_5:getConfig("config_id"))

	if not var_9_6 then
		return
	end

	self.bonusPtIconPath = Drop.New({
		type = DROP_TYPE_RESOURCE,
		id = var_9_6
	}):getIcon()

	return
end

function MapBuilderNormal:UpdateMapItems()
	MapBuilderNormal.super.UpdateMapItems(self)

	local var_11_0 = self.data:GetChapterInProgress()

	if var_11_0 and isa(var_11_0, ChapterStoryGroup) then
		setActive(self.itemHolder, false)
		setActive(self.storyHolder, true)
		self:UpdateStoryGroup()

		return
	end

	setActive(self.itemHolder, true)
	setActive(self.storyHolder, false)
	self:UpdateBonusPtIconPath()

	local var_11_1 = getProxy(ChapterProxy)
	local var_11_2 = {}

	for iter_11_0, iter_11_1 in pairs(self.data:getChapters()) do
		if (iter_11_1:isUnlock() or iter_11_1:activeAlways()) and (not iter_11_1:ifNeedHide() or var_11_1:GetJustClearChapters(iter_11_1.id)) then
			table.insert(var_11_2, iter_11_1)
		end
	end

	table.clear(self.chapterTFsById)
	UIItemList.StaticAlign(self.itemHolder, self.chapterTpl, #var_11_2, function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_0 ~= UIItemList.EventUpdate then
			return
		end

		local var_12_0 = var_11_2[arg_12_1 + 1]

		self:UpdateMapItem(arg_12_2, var_11_2[arg_12_1 + 1])

		arg_12_2.name = "Chapter_" .. var_12_0.id
		self.chapterTFsById[var_12_0.id] = arg_12_2

		return
	end)

	local var_11_3 = {}

	for iter_11_2, iter_11_3 in pairs(var_11_2) do
		local var_11_4 = iter_11_3:getConfigTable()

		var_11_3[var_11_4.pos_x] = var_11_3[var_11_4.pos_x] or {}
		var_11_3[var_11_4.pos_x][var_11_4.pos_y] = var_11_3[var_11_4.pos_x][var_11_4.pos_y] or {}

		table.insert(var_11_3[var_11_4.pos_x][var_11_4.pos_y], iter_11_3)
	end

	for iter_11_4, iter_11_5 in pairs(var_11_3) do
		for iter_11_6, iter_11_7 in pairs(iter_11_5) do
			local var_11_5 = {}

			seriesAsync({
				function(arg_13_0)
					local var_13_0 = 0

					for iter_13_0, iter_13_1 in pairs(iter_11_7) do
						if iter_13_1:ifNeedHide() and var_11_1:GetJustClearChapters(iter_13_1.id) and self.chapterTFsById[iter_13_1.id] then
							var_13_0 = var_13_0 + 1

							local var_13_1 = self.chapterTFsById[iter_13_1.id]

							setActive(self.chapterTFsById[iter_13_1.id], true)
							self:PlayChapterItemAnimationBackward(self.chapterTFsById[iter_13_1.id], iter_13_1, function()
								var_13_0 = var_13_0 - 1

								setActive(var_13_1, false)
								var_11_1:RecordJustClearChapters(iter_13_1.id, nil)

								if var_13_0 <= 0 then
									arg_13_0()
								end

								return
							end)

							var_11_5[iter_13_1.id] = true
						elseif self.chapterTFsById[iter_13_1.id] then
							setActive(self.chapterTFsById[iter_13_1.id], false)
						end
					end

					if var_13_0 <= 0 then
						arg_13_0()
					end

					return
				end,
				function(arg_15_0)
					local var_15_0 = 0

					for iter_15_0, iter_15_1 in pairs(iter_11_7) do
						if not var_11_5[iter_15_1.id] then
							var_15_0 = var_15_0 + 1

							setActive(self.chapterTFsById[iter_15_1.id], true)
							self:PlayChapterItemAnimation(self.chapterTFsById[iter_15_1.id], iter_15_1, function()
								var_15_0 = var_15_0 - 1

								if var_15_0 <= 0 then
									arg_15_0()
								end

								return
							end)
						end
					end

					return
				end
			})
		end
	end

	return
end

function MapBuilderNormal:UpdateMapItem(arg_17_1, arg_17_2)
	local var_17_0 = arg_17_2:getConfigTable()

	warning(0 * var_17_0.pos_x, 1080 * var_17_0.pos_y)
	setLocalPosition(arg_17_1, {
		x = 0 * var_17_0.pos_x,
		y = 1080 * var_17_0.pos_y
	})

	local var_17_1 = findTF(arg_17_1, "main")

	setActive(var_17_1, true)

	local var_17_2 = findTF(var_17_1, "info/bk/fordark")

	setActive(findTF(var_17_1, "circle/fordark"), var_17_0.icon_outline == 1)
	setActive(var_17_2, var_17_0.icon_outline == 1)

	local var_17_3 = findTF(var_17_1, "circle/clear_flag")
	local var_17_4 = findTF(var_17_1, "circle/progress_text")
	local var_17_5 = findTF(var_17_1, "circle/stars")
	local var_17_6 = string.split(var_17_0.name, "|")

	setText(findTF(var_17_1, "info/bk/title_form/title_index"), var_17_0.chapter_name .. "  ")
	setText(findTF(var_17_1, "info/bk/title_form/title"), var_17_6[1])
	setText(findTF(var_17_1, "info/bk/title_form/title_en"), var_17_6[2] or "")
	setFillAmount(findTF(var_17_1, "circle/progress"), arg_17_2.progress / 100)
	setText(var_17_4, string.format("%d%%", arg_17_2.progress))
	setActive(var_17_5, arg_17_2:existAchieve())

	if arg_17_2:existAchieve() then
		for iter_17_0, iter_17_1 in ipairs(arg_17_2.achieves) do
			setActive(var_17_5:Find("star" .. iter_17_0 .. "/light"), (ChapterConst.IsAchieved(iter_17_1)))
		end
	end

	local var_17_7 = not arg_17_2.active and arg_17_2:isClear()

	setActive(var_17_3, var_17_7)
	setActive(var_17_4, not var_17_7)
	self:DeleteTween("fighting" .. arg_17_2.id)

	local var_17_8 = findTF(var_17_1, "circle/fighting")

	setText(findTF(var_17_8, "Text"), i18n("tag_level_fighting"))

	local var_17_9 = findTF(var_17_1, "circle/oni")

	setText(findTF(var_17_9, "Text"), i18n("tag_level_oni"))

	local var_17_10 = findTF(var_17_1, "circle/narrative")

	setText(findTF(var_17_10, "Text"), i18n("tag_level_narrative"))

	local var_17_11 = findTF(var_17_1, "circle/auto")

	setText(findTF(var_17_11, "Text"), i18n("tag_level_autoing"))
	setActive(var_17_8, false)
	setActive(var_17_9, false)
	setActive(var_17_10, false)
	setActive(var_17_11, false)

	local var_17_12

	if arg_17_2:getConfig("chapter_tag") == 1 then
		var_17_12 = var_17_10
	end

	if arg_17_2.active then
		var_17_12 = arg_17_2:existOni() and var_17_9 or var_17_8
	end

	local var_17_14 = getProxy(ChapterProxy):GetAutoChapterId()

	if var_17_14 and var_17_14 == arg_17_2.id then
		var_17_12 = var_17_11

		local var_17_15, var_17_16 = getProxy(ChapterAutoProxy):GetCntInfo()

		setText(findTF(var_17_11, "Text"), var_17_15 < var_17_16 and i18n("tag_level_autoing") or i18n("tag_level_auto_finish"))
	end

	if var_17_12 then
		setActive(var_17_12, true)

		local var_17_17 = GetOrAddComponent(var_17_12, "CanvasGroup")

		var_17_17.alpha = 1

		self:RecordTween("fighting" .. arg_17_2.id, LeanTween.alphaCanvas(var_17_17, 0, 0.5):setFrom(1):setEase(LeanTweenType.easeInOutSine):setLoopPingPong().uniqueId)
	end

	local var_17_18 = findTF(var_17_1, "triesLimit")

	setActive(var_17_18, false)

	if arg_17_2:isTriesLimit() then
		local var_17_19 = arg_17_2:getConfig("count")

		setText(var_17_18:Find("label"), i18n("levelScene_chapter_count_tip"))

		local var_17_20 = setText

		var_17_20(var_17_18:Find("Text"), setColorStr(var_17_19 - arg_17_2:getTodayDefeatCount() .. "/" .. var_17_19, (var_17_19 <= arg_17_2:getTodayDefeatCount() or nil) and (COLOR_RED or COLOR_GREEN)))

		local var_17_24 = getProxy(ChapterProxy):IsActivitySPChapterActive(pg.expedition_data_by_map[arg_17_2:getConfig("map")].on_activity)

		var_17_24 = var_17_24 and SettingsProxy.IsShowActivityMapSPTip()

		setActive(var_17_18:Find("TipRect"), var_17_24)
	end

	local var_17_25 = arg_17_2:GetDailyBonusQuota()
	local var_17_26 = findTF(var_17_1, "mark")
	local var_17_27 = var_17_26:Find("bonus")
	local var_17_28 = var_17_27:Find("icon")
	local var_17_29 = findTF(var_17_27, "icon/Image")

	setActive(var_17_27, var_17_25)
	setActive(var_17_26, var_17_25)

	if var_17_28 then
		setActive(var_17_28, var_17_25 and self.bonusPtIconPath)
	end

	if var_17_25 then
		local var_17_30 = var_17_26:GetComponent(typeof(CanvasGroup))

		self.sceneParent.loader:GetSprite("ui/levelmainscene_atlas", arg_17_2:GetDailyBonusIconName(), var_17_27)

		if var_17_28 and self.bonusPtIconPath then
			if var_17_29 then
				GetImageSpriteFromAtlasAsync(self.bonusPtIconPath, "", var_17_29, true)
			else
				GetImageSpriteFromAtlasAsync(self.bonusPtIconPath, "", var_17_28, true)
			end
		end

		LeanTween.cancel(go(var_17_26), true)

		local var_17_31 = var_17_26.anchoredPosition.y

		var_17_30.alpha = 0

		LeanTween.value(go(var_17_26), 0, 1, 0.2):setOnUpdate(System.Action_float(function(arg_18_0)
			var_17_30.alpha = arg_18_0
			var_17_26.anchoredPosition.y = var_17_31 * arg_18_0
			var_17_26.anchoredPosition = var_17_26.anchoredPosition

			return
		end)):setOnComplete(System.Action(function()
			var_17_30.alpha = 1
			var_17_26.anchoredPosition.y = var_17_31
			var_17_26.anchoredPosition = var_17_26.anchoredPosition

			return
		end)):setEase(LeanTweenType.easeOutSine):setDelay(0.7)
	end

	local var_17_32 = arg_17_2.id

	onButton(self, var_17_1, function()
		if self.chaptersInBackAnimating[var_17_32] then
			return
		end

		self:TryOpenChapterInfo(var_17_32, Vector3(arg_17_1.localPosition.x - 10, arg_17_1.localPosition.y + 22))

		return
	end, SFX_UI_WEIGHANCHOR_SELECT)

	return
end

function MapBuilderNormal:PlayChapterItemAnimation(arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = findTF(arg_21_1, "main")
	local var_21_1 = findTF(var_21_0, "circle")
	local var_21_2 = findTF(var_21_0, "info/bk")

	LeanTween.cancel(go(var_21_1))

	var_21_1.localScale = Vector3.zero

	self:RecordTween(LeanTween.scale(var_21_1, Vector3.one, 0.3):setDelay(0.3).uniqueId)
	LeanTween.cancel(go(var_21_2))
	setAnchoredPosition(var_21_2, {
		x = -1 * var_21_0:Find("info").rect.width
	})
	shiftPanel(var_21_2, 0, nil, 0.4, 0.4, true, true, nil, function()
		if arg_21_2:isTriesLimit() then
			setActive(findTF(var_21_0, "triesLimit"), true)
		end

		if arg_21_3 then
			arg_21_3()
		end

		return
	end)

	return
end

function MapBuilderNormal:PlayChapterItemAnimationBackward(arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = findTF(arg_23_1, "main")
	local var_23_1 = findTF(var_23_0, "circle")
	local var_23_2 = findTF(var_23_0, "info/bk")

	LeanTween.cancel(go(var_23_1))

	var_23_1.localScale = Vector3.one

	self:RecordTween(LeanTween.scale(go(var_23_1), Vector3.zero, 0.3):setDelay(0.3).uniqueId)

	self.chaptersInBackAnimating[arg_23_2.id] = true

	LeanTween.cancel(go(var_23_2))
	setAnchoredPosition(var_23_2, {
		x = 0
	})
	shiftPanel(var_23_2, -1 * var_23_0:Find("info").rect.width, nil, 0.4, 0.4, true, true, nil, function()
		self.chaptersInBackAnimating[arg_23_2.id] = nil

		if arg_23_3 then
			arg_23_3()
		end

		return
	end)

	if arg_23_2:isTriesLimit() then
		setActive(findTF(var_23_0, "triesLimit"), false)
	end

	return
end

function MapBuilderNormal:UpdateChapterTF(arg_25_1)
	if self.chapterTFsById[arg_25_1] then
		local var_25_0 = getProxy(ChapterProxy):getChapterById(arg_25_1)

		self:UpdateMapItem(self.chapterTFsById[arg_25_1], var_25_0)
		self:PlayChapterItemAnimation(self.chapterTFsById[arg_25_1], var_25_0)
	end

	return
end

function MapBuilderNormal:TryOpenChapter(arg_26_1)
	if self.chapterTFsById[arg_26_1] then
		triggerButton((self.chapterTFsById[arg_26_1]:Find("main")))
	end

	return
end

function MapBuilderNormal:UpdateStoryGroup()
	local var_27_0 = self.data:GetChapterInProgress():GetChapterStories()

	UIItemList.StaticAlign(self.storyHolder, self.storyTpl, #var_27_0, function(arg_28_0, arg_28_1, arg_28_2)
		if arg_28_0 ~= UIItemList.EventUpdate then
			return
		end

		local var_28_0 = var_27_0[arg_28_1 + 1]

		self:UpdateMapStory(arg_28_2, var_27_0[arg_28_1 + 1])

		arg_28_2.name = "Chapter_" .. var_28_0:GetName()

		return
	end)

	return
end

function MapBuilderNormal:UpdateMapStory(arg_29_1, arg_29_2)
	local var_29_0 = arg_29_2:GetPosition()

	setAnchoredPosition(arg_29_1, {
		x = self.mapWidth * var_29_0[1],
		y = self.mapHeight * var_29_0[2]
	})
	setText(arg_29_1:Find("Name"), arg_29_2:GetName())

	local var_29_1, var_29_2 = arg_29_2:GetIcon()

	self.sceneParent.loader:GetSpriteQuiet(var_29_1, var_29_2, arg_29_1:Find("Icon"), true)

	local var_29_3 = arg_29_2:GetStoryName()

	onButton(self, arg_29_1, function()
		pg.NewStoryMgr.GetInstance():Play(var_29_3, function()
			self.sceneParent:RefreshMapBG()
			self:UpdateMapItems()

			return
		end)

		return
	end, SFX_PANEL)
	setActive(arg_29_1, not pg.NewStoryMgr.GetInstance():IsPlayed(var_29_3))

	return
end

function MapBuilderNormal:HideFloat()
	setActive(self.itemHolder, false)
	setActive(self.storyHolder, false)

	return
end

function MapBuilderNormal:ShowFloat()
	setActive(self.itemHolder, true)
	setActive(self.storyHolder, true)

	return
end

return MapBuilderNormal
