class = var_0_10000

local var_0_0 = "MapBuilderEscort"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MapBuilderPermanent"))

function var_0_1.GetType(arg_1_0)
	MapBuilder = var_1_10001

	return var_1_10001.TYPEESCORT
end

function var_0_1.getUIName(arg_2_0)
	return "escort_levels"
end

function var_0_1.OnInit(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.tpl = var_1.Find(var_3_0, "escort_level_tpl")

	local var_3_1 = arg_3_0._tf

	arg_3_0.itemHolder = var_1.Find(var_3_1, "items")

	return
end

function var_0_1.UpdateView(arg_4_0)
	local var_4_0 = arg_4_0.map.rect.width / arg_4_0.map.rect.height
	local var_4_1 = arg_4_0._parentTf.rect.width / arg_4_0._parentTf.rect.height
	local var_4_2 = 1

	if var_4_0 < var_4_1 then
		var_4_2 = arg_4_0._parentTf.rect.width / 0
		var_1_10004 = arg_4_0._tf
		Vector3 = var_1_10005
		var_1_10004.localScale = var_1_10005(var_4_2, var_4_2, 1)
	else
		var_4_2 = arg_4_0._parentTf.rect.height / 720
		var_1_10004 = arg_4_0._tf
		Vector3 = var_1_10005
		var_1_10004.localScale = var_1_10005(var_4_2, var_4_2, 1)
	end

	arg_4_0.scaleRatio = var_4_2
	string = var_1_10004

	local var_4_3 = var_1_10004.split
	local var_4_4 = arg_4_0.contextData.map
	local var_4_5 = var_4_3(var_6.getConfig(var_4_4, "name"), "||")

	setText = var_1_10005

	var_1_10005(arg_4_0.sceneParent.chapterName, var_4_5[1])

	local var_4_6 = arg_4_0.sceneParent.loader

	var_5.GetSprite(var_4_6, "chapterno", "chapterex", arg_4_0.sceneParent.chapterNoTitle, true)
	var_0_1.super.UpdateView(arg_4_0)

	return
end

function var_0_1.UpdateEscortInfo(arg_5_0)
	getProxy = var_1_10001
	ChapterProxy = var_1_10003

	local var_5_0 = var_1_10001(var_1_10003)
	local var_5_1 = var_1.getMaxEscortChallengeTimes(var_5_0)

	setText = var_1_10003

	local var_5_2 = arg_5_0.sceneParent.escortBar

	var_1_10003(var_5.Find(var_5_2, "times/text"), var_5_1 - var_1.escortChallengeTimes .. "/" .. var_5_1)

	onButton = var_1_10003

	local var_5_3 = arg_5_0.sceneParent
	local var_5_4 = arg_5_0.sceneParent.mapHelpBtn

	local function var_5_5()
		local var_6_0 = arg_5_0.sceneParent
		local var_6_1 = var_0.HandleShowMsgBox
		local var_6_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_6_2.type = var_2_10004
		i18n = var_2_10004
		var_6_2.helps = var_2_10004("levelScene_escort_help_tip")

		var_6_1(var_6_0, var_6_2)

		return
	end

	SFX_PANEL = var_8

	var_1_10003(var_5_3, var_5_4, var_5_5, var_8)

	return
end

function var_0_1.UpdateMapItems(arg_7_0)
	var_0_1.super.UpdateMapItems(arg_7_0)

	local var_7_0 = arg_7_0

	arg_7_0.UpdateEscortInfo(var_7_0)

	local var_7_1 = arg_7_0.data

	getProxy = var_1_10002
	ChapterProxy = var_1_10004

	local var_7_2 = var_1_10002(var_1_10004)
	local var_7_3 = var_2.getEscortChapterIds(var_7_2)

	_ = var_7_0

	local var_7_4 = var_7_0.filter(var_7_1:getChapters(), function(arg_8_0)
		table = var_2_10001

		return var_2_10001.contains(var_7_3, arg_8_0.id)
	end)

	UIItemList = var_7_2

	var_7_2.StaticAlign(arg_7_0.itemHolder, arg_7_0.tpl, #var_7_4, function(arg_9_0, arg_9_1, arg_9_2)
		UIItemList = var_2_10003

		if arg_9_0 ~= var_2_10003.EventUpdate then
			return
		end

		local var_9_0 = arg_7_0

		var_3.UpdateEscortItem(var_9_0, arg_9_2, var_7_4[arg_9_1 + 1].id, var_7_4[arg_9_1 + 1])

		return
	end)

	return
end

function var_0_1.UpdateEscortItem(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	pg = var_1_10004

	local var_10_0 = var_1_10004.escort_template[arg_10_2]

	assert = var_1_10005

	var_1_10005(var_10_0, "escort template not exist: " .. arg_10_2)

	getProxy = var_1_10005
	ChapterProxy = var_7

	local var_10_1 = var_1_10005(var_7)
	local var_10_2 = var_5.getActiveChapter(var_10_1, true)

	arg_10_1.name = "chapter_" .. arg_10_3.id

	local var_10_3 = arg_10_0.map.rect

	Vector2 = var_7

	local var_10_4 = var_10_3.width / arg_10_0.scaleRatio

	tonumber = var_10

	local var_10_5 = var_10_4 * (var_10(var_10_0.pos_x) - 0.5)
	local var_10_6 = var_10_3.height / arg_10_0.scaleRatio

	tonumber = var_11
	arg_10_1.anchoredPosition = var_7(var_10_5, var_10_6 * (var_11(var_10_0.pos_y) - 0.5))

	local var_10_7 = arg_10_1
	local var_10_8 = arg_10_1.Find(var_10_7, "fighting")
	local var_10_9 = var_10_2 and var_10_2.id == arg_10_3.id

	setActive = var_10_7

	var_10_7(var_10_8, var_10_9)
	arg_10_0:DeleteTween("fighting" .. arg_10_3.id)

	local var_10_11

	if var_10_9 then
		setImageAlpha = var_10_11

		var_10_11(var_10_8, 1)

		local var_10_10 = arg_10_0

		var_10_11 = arg_10_0.RecordTween

		local var_10_12 = "fighting" .. arg_10_3.id

		LeanTween = var_13
		var_1_10015 = var_13.alpha(var_10_8, 0, 0.5)

		local var_10_13 = var_13.setEase

		LeanTweenType = var_16
		var_1_10015 = var_10_13(var_1_10015, var_16.easeInOutSine)

		var_10_11(var_10_10, var_10_12, var_13.setLoopPingPong(var_1_10015).uniqueId)
	end

	GetImageSpriteFromAtlasAsync = var_10_11

	var_10_11("levelmap/mapquad/" .. var_10_0.pic, "", arg_10_1, true)

	local var_10_14 = arg_10_1
	local var_10_15 = arg_10_1.Find(var_10_14, "anim")

	getProxy = var_10
	ChapterProxy = var_12

	local var_10_16 = var_10(var_12)
	local var_10_17 = var_10.getEscortChapterIds(var_10_16)

	table = var_10_14

	local var_10_18 = var_10_14.indexof(var_10_17, arg_10_2)
	local var_10_19 = {}

	Color = var_13
	var_10_19[1] = var_13.green
	Color = var_13
	var_10_19[2] = var_13.yellow
	Color = var_13
	var_10_19[3] = var_13.red

	local var_10_20 = var_10_19[var_10_18 or 1]
	local var_10_21 = var_10_15
	local var_10_22 = var_10_15.GetComponentsInChildren

	typeof = var_1_10017
	Image = var_1_10019

	local var_10_23 = var_10_22(var_10_21, var_1_10017(var_1_10019))
	local var_10_24 = var_14.ToTable(var_10_23)

	ipairs = var_1_10015

	for iter_10_0, iter_10_1 in var_1_10015(var_10_24) do
		iter_10_1.color = var_10_20
	end

	setImageColor = var_15

	var_15(arg_10_1, var_10_20)

	local var_10_25 = arg_10_3.id

	onButton = var_16

	local var_10_26 = arg_10_0
	local var_10_27 = arg_10_1

	local function var_10_28()
		local var_11_0 = arg_10_0

		var_0.TryOpenChapterInfo(var_11_0, var_10_25)

		return
	end

	SFX_PANEL = var_1_10021

	var_16(var_10_26, var_10_27, var_10_28, var_1_10021)

	return
end

function var_0_1.OnShow(arg_12_0)
	var_0_1.super.OnShow(arg_12_0)

	setActive = var_1

	local var_12_0 = arg_12_0.sceneParent.mainLayer

	var_1(var_3.Find(var_12_0, "title_chapter_lines"), true)

	setActive = var_1

	local var_12_1 = arg_12_0.sceneParent.topChapter

	var_1(var_3.Find(var_12_1, "title_chapter"), true)

	setActive = var_1

	local var_12_2 = arg_12_0.sceneParent.topChapter

	var_1(var_3.Find(var_12_2, "type_escort"), true)

	setActive = var_1

	var_1(arg_12_0.sceneParent.escortBar, true)

	setActive = var_1

	var_1(arg_12_0.sceneParent.mapHelpBtn, true)

	return
end

function var_0_1.OnHide(arg_13_0)
	setActive = var_1_10001

	local var_13_0 = arg_13_0.sceneParent.mainLayer

	var_1_10001(var_3.Find(var_13_0, "title_chapter_lines"), false)

	setActive = var_1_10001

	local var_13_1 = arg_13_0.sceneParent.topChapter

	var_1_10001(var_3.Find(var_13_1, "title_chapter"), false)

	setActive = var_1_10001

	local var_13_2 = arg_13_0.sceneParent.topChapter

	var_1_10001(var_3.Find(var_13_2, "type_escort"), false)

	setActive = var_1_10001

	var_1_10001(arg_13_0.sceneParent.escortBar, false)

	setActive = var_1_10001

	var_1_10001(arg_13_0.sceneParent.mapHelpBtn, false)
	var_0_1.super.OnHide(arg_13_0)

	return
end

function var_0_1.HideFloat(arg_14_0)
	setActive = var_1_10001

	var_1_10001(arg_14_0.itemHolder, false)

	return
end

function var_0_1.ShowFloat(arg_15_0)
	setActive = var_1_10001

	var_1_10001(arg_15_0.itemHolder, true)

	return
end

return var_0_1
