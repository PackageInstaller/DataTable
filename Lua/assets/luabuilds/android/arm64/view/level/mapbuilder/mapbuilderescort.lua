local var_0_0 = class("MapBuilderEscort", import(".MapBuilderPermanent"))

function var_0_0.GetType(arg_1_0)
	return MapBuilder.TYPEESCORT
end

function var_0_0.getUIName(arg_2_0)
	return "escort_levels"
end

function var_0_0.OnInit(arg_3_0)
	arg_3_0.tpl = arg_3_0._tf:Find("escort_level_tpl")
	arg_3_0.itemHolder = arg_3_0._tf:Find("items")

	return
end

function var_0_0.UpdateView(arg_4_0)
	local var_4_0 = 1

	if arg_4_0.map.rect.width / arg_4_0.map.rect.height < arg_4_0._parentTf.rect.width / arg_4_0._parentTf.rect.height then
		var_4_0 = arg_4_0._parentTf.rect.width / 0
		arg_4_0._tf.localScale = Vector3(arg_4_0._parentTf.rect.width / 0, arg_4_0._parentTf.rect.width / 0, 1)
	else
		var_4_0 = arg_4_0._parentTf.rect.height / 720
		arg_4_0._tf.localScale = Vector3(arg_4_0._parentTf.rect.height / 720, arg_4_0._parentTf.rect.height / 720, 1)
	end

	arg_4_0.scaleRatio = var_4_0

	setText(arg_4_0.sceneParent.chapterName, string.split(arg_4_0.contextData.map:getConfig("name"), "||")[1])
	arg_4_0.sceneParent.loader:GetSprite("chapterno", "chapterex", arg_4_0.sceneParent.chapterNoTitle, true)
	var_0_0.super.UpdateView(arg_4_0)

	return
end

function var_0_0.UpdateEscortInfo(arg_5_0)
	local var_5_0 = getProxy(ChapterProxy)
	local var_5_1 = var_5_0:getMaxEscortChallengeTimes()

	setText(arg_5_0.sceneParent.escortBar:Find("times/text"), var_5_1 - var_5_0.escortChallengeTimes .. "/" .. var_5_1)
	onButton(arg_5_0.sceneParent, arg_5_0.sceneParent.mapHelpBtn, function()
		arg_5_0.sceneParent:HandleShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("levelScene_escort_help_tip")
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.UpdateMapItems(arg_7_0)
	var_0_0.super.UpdateMapItems(arg_7_0)
	arg_7_0:UpdateEscortInfo()

	local var_7_0 = getProxy(ChapterProxy):getEscortChapterIds()

	UIItemList.StaticAlign(arg_7_0.itemHolder, arg_7_0.tpl, #_.filter(arg_7_0.data:getChapters(), function(arg_8_0)
		return table.contains(var_7_0, arg_8_0.id)
	end), function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_0 ~= UIItemList.EventUpdate then
			return
		end

		arg_7_0:UpdateEscortItem(arg_9_2, var_0[arg_9_1 + 1].id, var_0[arg_9_1 + 1])

		return
	end)

	return
end

function var_0_0.UpdateEscortItem(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	assert(pg.escort_template[arg_10_2], "escort template not exist: " .. arg_10_2)

	local var_10_0 = getProxy(ChapterProxy):getActiveChapter(true)

	arg_10_1.name = "chapter_" .. arg_10_3.id
	arg_10_1.anchoredPosition = Vector2(arg_10_0.map.rect.width / arg_10_0.scaleRatio * (tonumber(pg.escort_template[arg_10_2].pos_x) - 0.5), arg_10_0.map.rect.height / arg_10_0.scaleRatio * (tonumber(pg.escort_template[arg_10_2].pos_y) - 0.5))

	local var_10_1 = arg_10_1:Find("fighting")
	local var_10_2 = var_10_0 and var_10_0.id == arg_10_3.id

	setActive(var_10_1, var_10_0 and var_10_0.id == arg_10_3.id)
	arg_10_0:DeleteTween("fighting" .. arg_10_3.id)

	if var_10_2 then
		setImageAlpha(var_10_1, 1)
		arg_10_0:RecordTween("fighting" .. arg_10_3.id, LeanTween.alpha(var_10_1, 0, 0.5):setEase(LeanTweenType.easeInOutSine):setLoopPingPong().uniqueId)
	end

	GetImageSpriteFromAtlasAsync("levelmap/mapquad/" .. pg.escort_template[arg_10_2].pic, "", arg_10_1, true)

	local var_10_3 = table.indexof(getProxy(ChapterProxy):getEscortChapterIds(), arg_10_2) or 1

	for iter_10_0, iter_10_1 in ipairs((arg_10_1:Find("anim"):GetComponentsInChildren(typeof(Image)):ToTable())) do
		iter_10_1.color = ({
			Color.green,
			Color.yellow,
			Color.red
		})[var_10_3]
	end

	setImageColor(arg_10_1, ({
		Color.green,
		Color.yellow,
		Color.red
	})[var_10_3])

	local var_10_4 = arg_10_3.id

	onButton(arg_10_0, arg_10_1, function()
		arg_10_0:TryOpenChapterInfo(var_10_4)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnShow(arg_12_0)
	var_0_0.super.OnShow(arg_12_0)
	setActive(arg_12_0.sceneParent.mainLayer:Find("title_chapter_lines"), true)
	setActive(arg_12_0.sceneParent.topChapter:Find("title_chapter"), true)
	setActive(arg_12_0.sceneParent.topChapter:Find("type_escort"), true)
	setActive(arg_12_0.sceneParent.escortBar, true)
	setActive(arg_12_0.sceneParent.mapHelpBtn, true)

	return
end

function var_0_0.OnHide(arg_13_0)
	setActive(arg_13_0.sceneParent.mainLayer:Find("title_chapter_lines"), false)
	setActive(arg_13_0.sceneParent.topChapter:Find("title_chapter"), false)
	setActive(arg_13_0.sceneParent.topChapter:Find("type_escort"), false)
	setActive(arg_13_0.sceneParent.escortBar, false)
	setActive(arg_13_0.sceneParent.mapHelpBtn, false)
	var_0_0.super.OnHide(arg_13_0)

	return
end

function var_0_0.HideFloat(arg_14_0)
	setActive(arg_14_0.itemHolder, false)

	return
end

function var_0_0.ShowFloat(arg_15_0)
	setActive(arg_15_0.itemHolder, true)

	return
end

return var_0_0
