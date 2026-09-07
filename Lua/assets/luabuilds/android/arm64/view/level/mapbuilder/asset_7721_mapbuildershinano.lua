local MapBuilderShinano = class("MapBuilderShinano", import(".MapBuilderPermanent"))

function MapBuilderShinano:Ctor(...)
	MapBuilderShinano.super.Ctor(self, ...)

	self.chapterTFsById = {}
	self.chaptersInBackAnimating = {}

	return
end

function MapBuilderShinano:GetType()
	return MapBuilder.TYPESHINANO
end

function MapBuilderShinano:getUIName()
	return "Shinano_levels"
end

function MapBuilderShinano:OnInit()
	self.tpl = self._tf:Find("level_tpl")

	setActive(self.tpl, false)

	self.itemHolder = self._tf:Find("items")

	local var_4_0 = self._tf:Find("preloadResources")
	local var_4_1 = var_4_0:Find("mengjing_rumeng")

	setAnchoredPosition(self._tf:Find("rumeng"), tf(var_4_1).anchoredPosition)
	setParent(var_4_1, self._tf:Find("rumeng"))
	setAnchoredPosition(var_4_1, Vector2.zero)
	self:InitTransformMapBtn(self._tf:Find("rumeng"), 1, var_4_0:Find("mengjing_rumeng_zhuangchang"))

	local var_4_2 = var_4_0:Find("mengjing_huigui")

	setAnchoredPosition(self._tf:Find("huigui"), tf(var_4_2).anchoredPosition)
	setParent(var_4_2, self._tf:Find("huigui"))
	setAnchoredPosition(var_4_2, Vector2.zero)
	self:InitTransformMapBtn(self._tf:Find("huigui"), -1, var_4_0:Find("mengjing_huigui_zhuangchang"))

	return
end

function MapBuilderShinano:OnShow()
	MapBuilderShinano.super.OnShow(self)
	setActive(self.sceneParent.mainLayer:Find("title_chapter_lines"), true)
	setActive(self.sceneParent.topChapter:Find("title_chapter"), true)
	setActive(self.sceneParent.topChapter:Find("type_skirmish"), true)

	return
end

function MapBuilderShinano:OnHide()
	setActive(self.sceneParent.mainLayer:Find("title_chapter_lines"), false)
	setActive(self.sceneParent.topChapter:Find("title_chapter"), false)
	setActive(self.sceneParent.topChapter:Find("type_skirmish"), false)
	table.clear(self.chaptersInBackAnimating)

	for iter_6_0, iter_6_1 in pairs(self.chapterTFsById) do
		LeanTween.cancel(rtf((findTF(iter_6_1, "main/info/bk"))))
	end

	MapBuilderShinano.super.OnHide(self)

	return
end

function MapBuilderShinano:TrySwitchNextMap(arg_7_1)
	local var_7_0 = getProxy(ChapterProxy):getMapById(self.contextData.mapIdx + arg_7_1)

	if not var_7_0 then
		return
	end

	if var_7_0:getMapType() == Map.ELITE and not var_7_0:isEliteEnabled() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("elite_disable_unusable"))

		return
	end

	local var_7_1, var_7_2 = var_7_0:isUnlock()

	if not var_7_1 then
		pg.TipsMgr.GetInstance():ShowTips(var_7_2)

		return
	end

	return true
end

function MapBuilderShinano:InitTransformMapBtn(arg_8_1, arg_8_2, arg_8_3)
	onButton(self, arg_8_1, function()
		if self:isfrozen() then
			return
		end

		local var_9_0

		seriesAsync({
			function(arg_10_0)
				if not self:TrySwitchNextMap(arg_8_2) then
					return
				end

				pg.CriMgr.GetInstance():StopBGM()
				pg.CriMgr.GetInstance():PlaySE_V3("ui-qiehuan")

				var_9_0 = self._tf:Find(arg_8_3.name .. "(Clone)") or Instantiate(arg_8_3)

				setParent(var_9_0, self._tf)
				setAnchoredPosition(var_9_0, rtf(arg_8_1).anchoredPosition)

				local var_10_0 = Map:bindConfigTable()[self.contextData.mapIdx + arg_8_2]

				if var_10_0 and #var_10_0.bg > 0 then
					GetSpriteFromAtlasAsync("levelmap/" .. var_10_0.bg, "", function(arg_11_0)
						return
					end)
				end

				self.sceneParent:frozen()
				LeanTween.delayedCall(go(arg_8_1), 2.3, System.Action(arg_10_0))

				return
			end,
			function(arg_12_0)
				self.sceneParent:setMap(self.contextData.mapIdx + arg_8_2)
				LeanTween.delayedCall(go(arg_8_1), 0.5, System.Action(arg_12_0))

				return
			end,
			function(arg_13_0)
				if not IsNil(var_9_0) then
					Destroy(var_9_0)
				end

				self.sceneParent:unfrozen()

				return
			end
		})

		return
	end)

	return
end

function MapBuilderShinano:UpdateView()
	setText(self.sceneParent.chapterName, string.split(self.contextData.map:getConfig("name"), "||")[1])
	self.sceneParent.loader:GetSpriteQuiet("chapterno", "chapter" .. self.contextData.map:getMapTitleNumber(), self.sceneParent.chapterNoTitle, true)
	MapBuilderShinano.super.UpdateView(self)

	return
end

function MapBuilderShinano:UpdateButtons()
	MapBuilderShinano.super.UpdateButtons(self)
	self:UpdateCustomButtons()

	return
end

function MapBuilderShinano:UpdateBonusPtIconPath()
	self.bonusPtIconPath = nil

	local var_16_0 = self.data or self.contextData.map

	if not var_16_0 then
		return
	end

	local var_16_1 = var_16_0:getConfig("on_activity")

	if not var_16_1 or var_16_1 == 0 then
		return
	end

	local var_16_2 = getProxy(ActivityProxy)
	local var_16_3 = var_16_2:getActivityById(var_16_1)

	if not var_16_3 or var_16_3:isEnd() then
		return
	end

	local var_16_4 = var_16_3:GetConfigClientSetting("PTID")

	if not var_16_4 then
		return
	end

	local var_16_5 = underscore.detect(var_16_2:getActivitiesByType(ActivityConst.ACTIVITY_TYPE_PT_RANK), function(arg_17_0)
		return arg_17_0 and not arg_17_0:isEnd() and arg_17_0:getConfig("config_id") == var_16_4
	end)

	if not var_16_5 then
		return
	end

	local var_16_6 = tonumber(var_16_5:getConfig("config_id"))

	if not var_16_6 then
		return
	end

	self.bonusPtIconPath = Drop.New({
		type = DROP_TYPE_RESOURCE,
		id = var_16_6
	}):getIcon()

	return
end

function MapBuilderShinano:UpdateCustomButtons()
	local var_18_0 = self.contextData.map
	local var_18_1 = self.contextData.map:getConfig("type") == Map.ACT_EXTRA
	local var_18_2 = self._tf:Find("rumeng")
	local var_18_3 = self._tf:Find("huigui")

	setActive(var_18_2, false)
	setActive(var_18_3, false)

	if not var_18_1 then
		setActive(self.sceneParent.btnPrev, false)
		setActive(self.sceneParent.btnNext, false)

		local var_18_4 = getProxy(ChapterProxy):getMapById(var_18_0.id + 1)
		local var_18_5 = getProxy(ChapterProxy):getMapById(var_18_0.id - 1)

		setActive(var_18_2, var_18_4)
		setActive(var_18_3, var_18_5)
		LeanTween.cancel(go(var_18_2), true)
		LeanTween.cancel(go(var_18_3), true)

		if var_18_4 then
			local var_18_6 = tf(var_18_2).localScale
			local var_18_7 = tf(var_18_2):GetChild(0):Find("Quad"):GetComponent(typeof(MeshRenderer)).sharedMaterial
			local var_18_8 = var_18_7:GetColor("_MainColor")
			local var_18_9 = Clone(var_18_8)

			self:RecordTween("rumengAlphaTween", LeanTween.value(go(var_18_2), 0, 1, 0.8):setOnUpdate(System.Action_float(function(arg_19_0)
				var_18_9.a = var_18_8.a * arg_19_0

				var_18_7:SetColor("_MainColor", var_18_9)

				return
			end)):setEase(LeanTweenType.easeInCubic):setOnComplete(System.Action(function()
				var_18_7:SetColor("_MainColor", var_18_8)

				return
			end)).id)
		elseif var_18_5 then
			local var_18_10 = tf(var_18_3).localScale
			local var_18_11 = tf(var_18_3):GetChild(0):Find("Quad"):GetComponent(typeof(MeshRenderer)).sharedMaterial
			local var_18_12 = var_18_11:GetColor("_MainColor")
			local var_18_13 = Clone(var_18_12)

			self:RecordTween("huiguiAlphaTween", LeanTween.value(go(var_18_3), 0, 1, 0.8):setOnUpdate(System.Action_float(function(arg_21_0)
				var_18_13.a = var_18_12.a * arg_21_0

				var_18_11:SetColor("_MainColor", var_18_13)

				return
			end)):setEase(LeanTweenType.easeInCubic):setOnComplete(System.Action(function()
				var_18_11:SetColor("_MainColor", var_18_12)

				return
			end)).id)
		end
	end

	return
end

function MapBuilderShinano:UpdateMapItems()
	MapBuilderShinano.super.UpdateMapItems(self)

	local var_23_0 = getProxy(ChapterProxy)

	self:UpdateBonusPtIconPath()
	table.clear(self.chapterTFsById)

	local var_23_1 = {}

	for iter_23_0, iter_23_1 in pairs(self.data:getChapters()) do
		if (iter_23_1:isUnlock() or iter_23_1:activeAlways()) and (not iter_23_1:ifNeedHide() or var_23_0:GetJustClearChapters(iter_23_1.id)) then
			table.insert(var_23_1, iter_23_1)
		end
	end

	UIItemList.StaticAlign(self.itemHolder, self.tpl, #var_23_1, function(arg_24_0, arg_24_1, arg_24_2)
		if arg_24_0 == UIItemList.EventUpdate then
			self:UpdateMapItem(arg_24_2, var_23_1[arg_24_1 + 1])

			arg_24_2.name = "Chapter_" .. var_23_1[arg_24_1 + 1].id
			self.chapterTFsById[var_23_1[arg_24_1 + 1].id] = arg_24_2
		end

		return
	end)

	local var_23_2 = {}

	for iter_23_2, iter_23_3 in pairs(var_23_1) do
		local var_23_3 = iter_23_3:getConfigTable()

		var_23_2[var_23_3.pos_x] = var_23_2[var_23_3.pos_x] or {}
		var_23_2[var_23_3.pos_x][var_23_3.pos_y] = var_23_2[var_23_3.pos_x][var_23_3.pos_y] or {}

		table.insert(var_23_2[var_23_3.pos_x][var_23_3.pos_y], iter_23_3)
	end

	for iter_23_4, iter_23_5 in pairs(var_23_2) do
		for iter_23_6, iter_23_7 in pairs(iter_23_5) do
			local var_23_4 = {}

			seriesAsync({
				function(arg_25_0)
					local var_25_0 = 0

					for iter_25_0, iter_25_1 in pairs(iter_23_7) do
						if iter_25_1:ifNeedHide() and var_23_0:GetJustClearChapters(iter_25_1.id) and self.chapterTFsById[iter_25_1.id] then
							var_25_0 = var_25_0 + 1

							local var_25_1 = self.chapterTFsById[iter_25_1.id]

							setActive(self.chapterTFsById[iter_25_1.id], true)
							self:PlayChapterItemAnimationBackward(self.chapterTFsById[iter_25_1.id], iter_25_1, function()
								var_25_0 = var_25_0 - 1

								setActive(var_25_1, false)
								var_23_0:RecordJustClearChapters(iter_25_1.id, nil)

								if var_25_0 <= 0 then
									arg_25_0()
								end

								return
							end)

							var_23_4[iter_25_1.id] = true
						elseif self.chapterTFsById[iter_25_1.id] then
							setActive(self.chapterTFsById[iter_25_1.id], false)
						end
					end

					if var_25_0 <= 0 then
						arg_25_0()
					end

					return
				end,
				function(arg_27_0)
					local var_27_0 = 0

					for iter_27_0, iter_27_1 in pairs(iter_23_7) do
						if not var_23_4[iter_27_1.id] then
							var_27_0 = var_27_0 + 1

							setActive(self.chapterTFsById[iter_27_1.id], true)
							self:PlayChapterItemAnimation(self.chapterTFsById[iter_27_1.id], iter_27_1, function()
								var_27_0 = var_27_0 - 1

								if var_27_0 <= 0 then
									arg_27_0()
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

function MapBuilderShinano:UpdateMapItem(arg_29_1, arg_29_2)
	local var_29_0 = arg_29_2:getConfigTable()

	setLocalPosition(arg_29_1, {
		x = 0 * var_29_0.pos_x,
		y = 1080 * var_29_0.pos_y
	})

	local var_29_1 = findTF(arg_29_1, "main")

	setActive(var_29_1, true)
	setActive(findTF(var_29_1, "info/bk/fordark"), var_29_0.icon_outline == 1)

	local var_29_2 = findTF(var_29_1, "circle/clear_flag")
	local var_29_3 = findTF(var_29_1, "circle/lock")
	local var_29_4 = not arg_29_2.active and not arg_29_2:isUnlock()
	local var_29_5 = findTF(var_29_1, "circle/progress")
	local var_29_6 = findTF(var_29_1, "circle/progress_text")
	local var_29_7 = findTF(var_29_1, "circle/stars")
	local var_29_8 = string.split(var_29_0.name, "|")
	local var_29_9 = var_29_4 and "#737373" or "#FFFFFF"

	setText(findTF(var_29_1, "info/bk/title_form/title_index"), setColorStr(var_29_0.chapter_name .. "  ", var_29_4 and "#737373" or "#FFFFFF"))
	setText(findTF(var_29_1, "info/bk/title_form/title"), setColorStr(var_29_8[1], var_29_9))
	setText(findTF(var_29_1, "info/bk/title_form/title_en"), setColorStr(var_29_8[2] or "", var_29_9))
	setFillAmount(var_29_5, arg_29_2.progress / 100)
	setText(var_29_6, string.format("%d%%", arg_29_2.progress))
	setActive(var_29_7, arg_29_2:existAchieve())

	if arg_29_2:existAchieve() then
		for iter_29_0, iter_29_1 in ipairs(arg_29_2.achieves) do
			setActive(var_29_7:Find("star" .. iter_29_0 .. "/light"), (ChapterConst.IsAchieved(iter_29_1)))
		end
	end

	local var_29_10 = not arg_29_2.active and arg_29_2:isClear()

	setActive(var_29_2, var_29_10)
	setActive(var_29_3, var_29_4)
	setActive(var_29_6, not var_29_10 and not var_29_4)
	self:DeleteTween("fighting" .. arg_29_2.id)

	local var_29_11 = findTF(var_29_1, "circle/fighting")

	setText(findTF(var_29_11, "Text"), i18n("tag_level_fighting"))

	local var_29_12 = findTF(var_29_1, "circle/oni")

	setText(findTF(var_29_12, "Text"), i18n("tag_level_oni"))

	local var_29_13 = findTF(var_29_1, "circle/narrative")

	setText(findTF(var_29_13, "Text"), i18n("tag_level_narrative"))
	setActive(var_29_11, false)
	setActive(var_29_12, false)
	setActive(var_29_13, false)

	local var_29_14

	if arg_29_2:getConfig("chapter_tag") == 1 then
		var_29_14 = var_29_13
	end

	if arg_29_2.active then
		var_29_14 = arg_29_2:existOni() and var_29_12 or var_29_11
	end

	if var_29_14 then
		setActive(var_29_14, true)

		local var_29_16 = GetOrAddComponent(var_29_14, "CanvasGroup")

		var_29_16.alpha = 1

		self:RecordTween("fighting" .. arg_29_2.id, LeanTween.alphaCanvas(var_29_16, 0, 0.5):setFrom(1):setEase(LeanTweenType.easeInOutSine):setLoopPingPong().uniqueId)
	end

	local var_29_17 = findTF(var_29_1, "triesLimit")

	setActive(var_29_17, false)

	if arg_29_2:isTriesLimit() then
		local var_29_18 = arg_29_2:getConfig("count")

		setText(var_29_17:Find("label"), i18n("levelScene_chapter_count_tip"))

		local var_29_19 = setText

		var_29_19(var_29_17:Find("Text"), setColorStr(var_29_18 - arg_29_2:getTodayDefeatCount() .. "/" .. var_29_18, (var_29_18 <= arg_29_2:getTodayDefeatCount() or nil) and (COLOR_RED or COLOR_GREEN)))
	end

	local var_29_23 = arg_29_2:GetDailyBonusQuota()
	local var_29_24 = findTF(var_29_1, "mark")
	local var_29_25 = var_29_24:Find("bonus")
	local var_29_26 = var_29_25:Find("icon")
	local var_29_27 = findTF(var_29_25, "icon/Image")

	setActive(var_29_25, var_29_23)
	setActive(var_29_24, var_29_23)

	if var_29_26 then
		setActive(var_29_26, var_29_23 and self.bonusPtIconPath)
	end

	if var_29_23 then
		local var_29_28 = var_29_24:GetComponent(typeof(CanvasGroup))

		self.sceneParent.loader:GetSprite("ui/levelmainscene_atlas", arg_29_2:GetDailyBonusIconName(), var_29_25)

		if var_29_26 and self.bonusPtIconPath then
			if var_29_27 then
				GetImageSpriteFromAtlasAsync(self.bonusPtIconPath, "", var_29_27, true)
			else
				GetImageSpriteFromAtlasAsync(self.bonusPtIconPath, "", var_29_26, true)
			end
		end

		LeanTween.cancel(go(var_29_24), true)

		local var_29_29 = var_29_24.anchoredPosition.y

		var_29_28.alpha = 0

		LeanTween.value(go(var_29_24), 0, 1, 0.2):setOnUpdate(System.Action_float(function(arg_30_0)
			var_29_28.alpha = arg_30_0
			var_29_24.anchoredPosition.y = var_29_29 * arg_30_0
			var_29_24.anchoredPosition = var_29_24.anchoredPosition

			return
		end)):setOnComplete(System.Action(function()
			var_29_28.alpha = 1
			var_29_24.anchoredPosition.y = var_29_29
			var_29_24.anchoredPosition = var_29_24.anchoredPosition

			return
		end)):setEase(LeanTweenType.easeOutSine):setDelay(0.7)
	end

	local var_29_30 = arg_29_2.id

	onButton(self, var_29_1, function()
		if self.chaptersInBackAnimating[var_29_30] then
			return
		end

		self:TryOpenChapterInfo(var_29_30, Vector3(arg_29_1.localPosition.x - 10, arg_29_1.localPosition.y + 22))

		return
	end, SFX_UI_WEIGHANCHOR_SELECT)

	return
end

function MapBuilderShinano:PlayChapterItemAnimation(arg_33_1, arg_33_2, arg_33_3)
	local var_33_0 = findTF(arg_33_1, "main")
	local var_33_1 = findTF(var_33_0, "circle")
	local var_33_2 = findTF(var_33_0, "info/bk")

	LeanTween.cancel(go(var_33_1))

	var_33_1.localScale = Vector3.zero

	self:RecordTween(LeanTween.scale(var_33_1, Vector3.one, 0.3):setDelay(0.3).uniqueId)
	LeanTween.cancel(go(var_33_2))
	setAnchoredPosition(var_33_2, {
		x = -1 * var_33_0:Find("info").rect.width
	})
	shiftPanel(var_33_2, 0, nil, 0.4, 0.4, true, true, nil, function()
		if arg_33_2:isTriesLimit() then
			setActive(findTF(var_33_0, "triesLimit"), true)
		end

		if arg_33_3 then
			arg_33_3()
		end

		return
	end)

	return
end

function MapBuilderShinano:PlayChapterItemAnimationBackward(arg_35_1, arg_35_2, arg_35_3)
	local var_35_0 = findTF(arg_35_1, "main")
	local var_35_1 = findTF(var_35_0, "circle")
	local var_35_2 = findTF(var_35_0, "info/bk")

	LeanTween.cancel(go(var_35_1))

	var_35_1.localScale = Vector3.one

	self:RecordTween(LeanTween.scale(go(var_35_1), Vector3.zero, 0.3):setDelay(0.3).uniqueId)

	self.chaptersInBackAnimating[arg_35_2.id] = true

	LeanTween.cancel(go(var_35_2))
	setAnchoredPosition(var_35_2, {
		x = 0
	})
	shiftPanel(var_35_2, -1 * var_35_0:Find("info").rect.width, nil, 0.4, 0.4, true, true, nil, function()
		self.chaptersInBackAnimating[arg_35_2.id] = nil

		if arg_35_3 then
			arg_35_3()
		end

		return
	end)

	if arg_35_2:isTriesLimit() then
		setActive(findTF(var_35_0, "triesLimit"), false)
	end

	return
end

function MapBuilderShinano:UpdateChapterTF(arg_37_1)
	if self.chapterTFsById[arg_37_1] then
		local var_37_0 = getProxy(ChapterProxy):getChapterById(arg_37_1)

		self:UpdateMapItem(self.chapterTFsById[arg_37_1], var_37_0)
		self:PlayChapterItemAnimation(self.chapterTFsById[arg_37_1], var_37_0)
	end

	return
end

function MapBuilderShinano:TryOpenChapter(arg_38_1)
	if self.chapterTFsById[arg_38_1] then
		triggerButton((self.chapterTFsById[arg_38_1]:Find("main")))
	end

	return
end

function MapBuilderShinano:HideFloat()
	setActive(self.itemHolder, false)

	return
end

function MapBuilderShinano:ShowFloat()
	setActive(self.itemHolder, true)

	return
end

return MapBuilderShinano
