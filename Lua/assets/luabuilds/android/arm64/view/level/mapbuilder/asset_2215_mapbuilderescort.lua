local MapBuilderEscort = class("MapBuilderEscort", import(".MapBuilderPermanent"))

function MapBuilderEscort:GetType()
	return MapBuilder.TYPEESCORT
end

function MapBuilderEscort:getUIName()
	return "escort_levels"
end

function MapBuilderEscort:OnInit()
	self.tpl = self._tf:Find("escort_level_tpl")
	self.itemHolder = self._tf:Find("items")

	return
end

function MapBuilderEscort:UpdateView()
	local var_4_0 = 1

	if self.map.rect.width / self.map.rect.height < self._parentTf.rect.width / self._parentTf.rect.height then
		var_4_0 = self._parentTf.rect.width / 0
		self._tf.localScale = Vector3(self._parentTf.rect.width / 0, self._parentTf.rect.width / 0, 1)
	else
		var_4_0 = self._parentTf.rect.height / 720
		self._tf.localScale = Vector3(self._parentTf.rect.height / 720, self._parentTf.rect.height / 720, 1)
	end

	self.scaleRatio = var_4_0

	setText(self.sceneParent.chapterName, string.split(self.contextData.map:getConfig("name"), "||")[1])
	self.sceneParent.loader:GetSprite("chapterno", "chapterex", self.sceneParent.chapterNoTitle, true)
	MapBuilderEscort.super.UpdateView(self)

	return
end

function MapBuilderEscort:UpdateEscortInfo()
	local var_5_0 = getProxy(ChapterProxy)
	local var_5_1 = var_5_0:getMaxEscortChallengeTimes()

	setText(self.sceneParent.escortBar:Find("times/text"), var_5_1 - var_5_0.escortChallengeTimes .. "/" .. var_5_1)
	onButton(self.sceneParent, self.sceneParent.mapHelpBtn, function()
		self.sceneParent:HandleShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("levelScene_escort_help_tip")
		})

		return
	end, SFX_PANEL)

	return
end

function MapBuilderEscort:UpdateMapItems()
	MapBuilderEscort.super.UpdateMapItems(self)
	self:UpdateEscortInfo()

	local var_7_0 = getProxy(ChapterProxy):getEscortChapterIds()
	local var_7_1 = _.filter(self.data:getChapters(), function(arg_8_0)
		return table.contains(var_7_0, arg_8_0.id)
	end)

	UIItemList.StaticAlign(self.itemHolder, self.tpl, #var_7_1, function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_0 ~= UIItemList.EventUpdate then
			return
		end

		self:UpdateEscortItem(arg_9_2, var_7_1[arg_9_1 + 1].id, var_7_1[arg_9_1 + 1])

		return
	end)

	return
end

function MapBuilderEscort:UpdateEscortItem(arg_10_1, arg_10_2, arg_10_3)
	assert(pg.escort_template[arg_10_2], "escort template not exist: " .. arg_10_2)

	local var_10_0 = getProxy(ChapterProxy):getActiveChapter(true)

	arg_10_1.name = "chapter_" .. arg_10_3.id
	arg_10_1.anchoredPosition = Vector2(self.map.rect.width / self.scaleRatio * (tonumber(pg.escort_template[arg_10_2].pos_x) - 0.5), self.map.rect.height / self.scaleRatio * (tonumber(pg.escort_template[arg_10_2].pos_y) - 0.5))

	local var_10_1 = arg_10_1:Find("fighting")
	local var_10_2 = var_10_0 and var_10_0.id == arg_10_3.id

	setActive(var_10_1, var_10_0 and var_10_0.id == arg_10_3.id)
	self:DeleteTween("fighting" .. arg_10_3.id)

	if var_10_2 then
		setImageAlpha(var_10_1, 1)
		self:RecordTween("fighting" .. arg_10_3.id, LeanTween.alpha(var_10_1, 0, 0.5):setEase(LeanTweenType.easeInOutSine):setLoopPingPong().uniqueId)
	end

	GetImageSpriteFromAtlasAsync("levelmap/mapquad/" .. pg.escort_template[arg_10_2].pic, "", arg_10_1, true)

	local var_10_3 = ({
		Color.green,
		Color.yellow,
		Color.red
	})[table.indexof(getProxy(ChapterProxy):getEscortChapterIds(), arg_10_2) or 1]

	for iter_10_0, iter_10_1 in ipairs((arg_10_1:Find("anim"):GetComponentsInChildren(typeof(Image)):ToTable())) do
		iter_10_1.color = var_10_3
	end

	setImageColor(arg_10_1, var_10_3)

	local var_10_4 = arg_10_3.id

	onButton(self, arg_10_1, function()
		self:TryOpenChapterInfo(var_10_4)

		return
	end, SFX_PANEL)

	return
end

function MapBuilderEscort:OnShow()
	MapBuilderEscort.super.OnShow(self)
	setActive(self.sceneParent.mainLayer:Find("title_chapter_lines"), true)
	setActive(self.sceneParent.topChapter:Find("title_chapter"), true)
	setActive(self.sceneParent.topChapter:Find("type_escort"), true)
	setActive(self.sceneParent.escortBar, true)
	setActive(self.sceneParent.mapHelpBtn, true)

	return
end

function MapBuilderEscort:OnHide()
	setActive(self.sceneParent.mainLayer:Find("title_chapter_lines"), false)
	setActive(self.sceneParent.topChapter:Find("title_chapter"), false)
	setActive(self.sceneParent.topChapter:Find("type_escort"), false)
	setActive(self.sceneParent.escortBar, false)
	setActive(self.sceneParent.mapHelpBtn, false)
	MapBuilderEscort.super.OnHide(self)

	return
end

function MapBuilderEscort:HideFloat()
	setActive(self.itemHolder, false)

	return
end

function MapBuilderEscort:ShowFloat()
	setActive(self.itemHolder, true)

	return
end

return MapBuilderEscort
