local MapBuilderBismarck = class("MapBuilderBismarck", import(".MapBuilderShinano"))

function MapBuilderBismarck:GetType()
	return MapBuilder.TYPEBISMARCK
end

function MapBuilderBismarck:getUIName()
	return "Bismarck_levels"
end

function MapBuilderBismarck:GetAtlasPath()
	return "ui/" .. self:getUIName() .. "_atlas"
end

local var_0_1 = {
	[2100582] = "yellow",
	[1720026] = "red",
	[2100592] = "red",
	[2100591] = "blue",
	[1720011] = "blue",
	[1720012] = "red",
	[1720025] = "blue",
	[1720001] = "green",
	[1720002] = "yellow",
	[2100581] = "green"
}

function MapBuilderBismarck:OnInit()
	self.tpl = self._tf:Find("level_tpl")

	setActive(self.tpl, false)

	self.itemHolder = self._tf:Find("items")
	self.buttonUp = self._tf:Find("up")
	self.effectUp = self._tf:Find("upEffect")
	self.buttonDown = self._tf:Find("down")
	self.effectDown = self._tf:Find("downEffect")

	pg.ViewUtils.SetSortingOrder(self.effectUp:Find("zhongzhijiguang_jiasu"), ChapterConst.LayerWeightMap + 1)
	pg.ViewUtils.SetSortingOrder(self.effectDown:Find("zhongzhijiguang_jiasu"), ChapterConst.LayerWeightMap + 1)
	self:InitTransformMapBtn(self.buttonDown, 1, self.effectDown)
	self:InitTransformMapBtn(self.buttonUp, -1, self.effectUp)

	self.loader = AutoLoader.New()

	return
end

function MapBuilderBismarck:InitTransformMapBtn(arg_5_1, arg_5_2, arg_5_3)
	onButton(self, arg_5_1, function()
		if self:isfrozen() then
			return
		end

		seriesAsync({
			function(arg_7_0)
				if not self:TrySwitchNextMap(arg_5_2) then
					return
				end

				pg.CriMgr.GetInstance():StopBGM()
				pg.CriMgr.GetInstance():PlaySE_V3("battle-ship-move")
				setActive(arg_5_3, true)
				self.sceneParent:frozen()
				LeanTween.delayedCall(go(arg_5_1), 1.8, System.Action(arg_7_0))

				return
			end,
			function(arg_8_0)
				self.sceneParent:setMap(self.contextData.mapIdx + arg_5_2)
				LeanTween.delayedCall(go(arg_5_1), 0.5, System.Action(arg_8_0))

				return
			end,
			function(arg_9_0)
				self.sceneParent:unfrozen()

				return
			end
		})

		return
	end)

	return
end

function MapBuilderBismarck:UpdateCustomButtons()
	local var_10_0 = self.contextData.map
	local var_10_1 = self.contextData.map:getConfig("type") == Map.ACT_EXTRA

	setActive(self.buttonUp, false)
	setActive(self.effectUp, false)
	setActive(self.buttonDown, false)
	setActive(self.effectDown, false)

	if not var_10_1 then
		setActive(self.sceneParent.btnPrev, false)
		setActive(self.sceneParent.btnNext, false)

		local var_10_2 = getProxy(ChapterProxy)

		setActive(self.buttonDown, (tobool(var_10_2:getMapById(var_10_0.id + 1))))
		setActive(self.buttonUp, (tobool(var_10_2:getMapById(var_10_0.id - 1))))
		LeanTween.cancel(go(self.buttonUp), true)
		LeanTween.cancel(go(self.buttonDown), true)
	end

	return
end

function MapBuilderBismarck:UpdateMapItem(arg_11_1, arg_11_2)
	local var_11_0 = arg_11_2:getConfigTable()

	setLocalPosition(arg_11_1, {
		x = 0 * var_11_0.pos_x,
		y = 1080 * var_11_0.pos_y
	})

	local var_11_1 = findTF(arg_11_1, "main")

	setActive(var_11_1, true)
	setActive(findTF(var_11_1, "info/bk/fordark"), var_11_0.icon_outline == 1)

	local var_11_2 = findTF(var_11_1, "circle/clear_flag")
	local var_11_3 = findTF(var_11_1, "circle/lock")
	local var_11_4 = not arg_11_2.active and not arg_11_2:isUnlock()
	local var_11_5 = findTF(var_11_1, "circle/progress")
	local var_11_6 = findTF(var_11_1, "circle/progress_text")
	local var_11_7 = findTF(var_11_1, "circle/stars")
	local var_11_8 = string.split(var_11_0.name, "|")
	local var_11_9 = var_0_1[self.data:GetConfigID()]

	self.loader:GetSpriteQuiet(self:GetAtlasPath(), "stage_bar_" .. var_11_9, var_11_1:Find("info/bk"))
	self.loader:GetSpriteQuiet(self:GetAtlasPath(), "chapter_progress_bg_" .. var_11_9, var_11_1:Find("circle/bk"))
	self.loader:GetSpriteQuiet(self:GetAtlasPath(), "chapter_progress_circle_" .. var_11_9, var_11_1:Find("circle/progress/Fill/progress"))
	self.loader:GetSpriteQuiet(self:GetAtlasPath(), "chapter_progress_wave_" .. var_11_9, var_11_1:Find("circle/progress/Mask/Handler/Wave"))
	self.loader:GetSpriteQuiet(self:GetAtlasPath(), "clear_text_" .. var_11_9, var_11_1:Find("circle/clear_flag"))
	setSlider(var_11_1:Find("circle/progress"), 0, 1, arg_11_2.progress / 100)

	local var_11_10 = var_11_4 and "#737373" or "#FFFFFF"

	setText(findTF(var_11_1, "info/bk/title_form/title_index"), setColorStr(var_11_0.chapter_name .. "  ", var_11_4 and "#737373" or "#FFFFFF"))
	setText(findTF(var_11_1, "info/bk/title_form/title"), setColorStr(var_11_8[1], var_11_10))
	setText(findTF(var_11_1, "info/bk/title_form/title_en"), setColorStr(var_11_8[2] or "", var_11_10))
	setText(var_11_6, string.format("%d%%", arg_11_2.progress))
	setActive(var_11_7, arg_11_2:existAchieve())

	if arg_11_2:existAchieve() then
		for iter_11_0, iter_11_1 in ipairs(arg_11_2.achieves) do
			setActive(var_11_7:Find("star" .. iter_11_0 .. "/light"), (ChapterConst.IsAchieved(iter_11_1)))
		end
	end

	local var_11_11 = not arg_11_2.active and arg_11_2:isClear()

	setActive(var_11_2, var_11_11)
	setActive(var_11_3, var_11_4)
	setActive(var_11_6, not var_11_11 and not var_11_4)
	self:DeleteTween("fighting" .. arg_11_2.id)

	local var_11_12 = findTF(var_11_1, "circle/fighting")

	setText(findTF(var_11_12, "Text"), i18n("tag_level_fighting"))

	local var_11_13 = findTF(var_11_1, "circle/oni")

	setText(findTF(var_11_13, "Text"), i18n("tag_level_oni"))

	local var_11_14 = findTF(var_11_1, "circle/narrative")

	setText(findTF(var_11_14, "Text"), i18n("tag_level_narrative"))
	setActive(var_11_12, false)
	setActive(var_11_13, false)
	setActive(var_11_14, false)

	local var_11_15

	if arg_11_2:getConfig("chapter_tag") == 1 then
		var_11_15 = var_11_14
	end

	if arg_11_2.active then
		var_11_15 = arg_11_2:existOni() and var_11_13 or var_11_12
	end

	if var_11_15 then
		setActive(var_11_15, true)

		local var_11_17 = GetOrAddComponent(var_11_15, "CanvasGroup")

		var_11_17.alpha = 1

		self:RecordTween("fighting" .. arg_11_2.id, LeanTween.alphaCanvas(var_11_17, 0, 0.5):setFrom(1):setEase(LeanTweenType.easeInOutSine):setLoopPingPong().uniqueId)
	end

	local var_11_18 = findTF(var_11_1, "triesLimit")
	local var_11_19 = arg_11_2:isTriesLimit()

	setActive(var_11_18, var_11_19)

	if var_11_19 then
		local var_11_20 = arg_11_2:getConfig("count")

		setText(var_11_18:Find("label"), i18n("levelScene_chapter_count_tip"))

		local var_11_21 = setText

		var_11_21(var_11_18:Find("Text"), setColorStr(var_11_20 - arg_11_2:getTodayDefeatCount() .. "/" .. var_11_20, (var_11_20 <= arg_11_2:getTodayDefeatCount() or nil) and (COLOR_RED or COLOR_GREEN)))
	end

	local var_11_25 = arg_11_2:GetDailyBonusQuota()
	local var_11_26 = findTF(var_11_1, "mark")
	local var_11_27 = var_11_26:Find("bonus")
	local var_11_28 = var_11_27:Find("icon")
	local var_11_29 = findTF(var_11_27, "icon/Image")

	setActive(var_11_27, var_11_25)
	setActive(var_11_26, var_11_25)

	if var_11_28 then
		setActive(var_11_28, var_11_25 and self.bonusPtIconPath)
	end

	if var_11_25 then
		local var_11_30 = var_11_26:GetComponent(typeof(CanvasGroup))

		self.sceneParent.loader:GetSprite("ui/levelmainscene_atlas", arg_11_2:GetDailyBonusIconName(), var_11_27)

		if var_11_28 and self.bonusPtIconPath then
			if var_11_29 then
				GetImageSpriteFromAtlasAsync(self.bonusPtIconPath, "", var_11_29, true)
			else
				GetImageSpriteFromAtlasAsync(self.bonusPtIconPath, "", var_11_28, true)
			end
		end

		LeanTween.cancel(go(var_11_26), true)

		local var_11_31 = var_11_26.anchoredPosition.y

		var_11_30.alpha = 0

		LeanTween.value(go(var_11_26), 0, 1, 0.2):setOnUpdate(System.Action_float(function(arg_12_0)
			var_11_30.alpha = arg_12_0
			var_11_26.anchoredPosition.y = var_11_31 * arg_12_0
			var_11_26.anchoredPosition = var_11_26.anchoredPosition

			return
		end)):setOnComplete(System.Action(function()
			var_11_30.alpha = 1
			var_11_26.anchoredPosition.y = var_11_31
			var_11_26.anchoredPosition = var_11_26.anchoredPosition

			return
		end)):setEase(LeanTweenType.easeOutSine):setDelay(0.7)
	end

	local var_11_32 = arg_11_2.id

	onButton(self, var_11_1, function()
		if self.chaptersInBackAnimating[var_11_32] then
			return
		end

		self:TryOpenChapterInfo(var_11_32, Vector3(arg_11_1.localPosition.x - 10, arg_11_1.localPosition.y + 22))

		return
	end, SFX_UI_WEIGHANCHOR_SELECT)

	return
end

function MapBuilderBismarck:OnDestroy()
	self.loader:Clear()
	MapBuilderBismarck.super.OnDestroy(self)

	return
end

return MapBuilderBismarck
