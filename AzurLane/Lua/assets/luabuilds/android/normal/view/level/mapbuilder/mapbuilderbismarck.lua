class = var_0_10000

local var_0_0 = "MapBuilderBismarck"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MapBuilderShinano"))

function var_0_1.GetType(arg_1_0)
	MapBuilder = var_1_10001

	return var_1_10001.TYPEBISMARCK
end

function var_0_1.getUIName(arg_2_0)
	return "Bismarck_levels"
end

function var_0_1.GetAtlasPath(arg_3_0)
	return "ui/" .. arg_3_0:getUIName() .. "_atlas"
end

local var_0_2 = {
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

function var_0_1.OnInit(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0.tpl = var_1.Find(var_4_0, "level_tpl")
	setActive = var_1

	var_1(arg_4_0.tpl, false)

	local var_4_1 = arg_4_0._tf

	arg_4_0.itemHolder = var_1.Find(var_4_1, "items")

	local var_4_2 = arg_4_0._tf

	arg_4_0.buttonUp = var_1.Find(var_4_2, "up")

	local var_4_3 = arg_4_0._tf

	arg_4_0.effectUp = var_1.Find(var_4_3, "upEffect")

	local var_4_4 = arg_4_0._tf

	arg_4_0.buttonDown = var_1.Find(var_4_4, "down")

	local var_4_5 = arg_4_0._tf

	arg_4_0.effectDown = var_1.Find(var_4_5, "downEffect")
	pg = var_1

	local var_4_6 = var_1.ViewUtils.SetSortingOrder
	local var_4_7 = arg_4_0.effectUp
	local var_4_8 = var_2.Find(var_4_7, "zhongzhijiguang_jiasu")

	ChapterConst = var_4_7

	var_4_6(var_4_8, var_4_7.LayerWeightMap + 1)

	pg = var_4_6

	local var_4_9 = var_4_6.ViewUtils.SetSortingOrder
	local var_4_10 = arg_4_0.effectDown
	local var_4_11 = var_2.Find(var_4_10, "zhongzhijiguang_jiasu")

	ChapterConst = var_4_10

	var_4_9(var_4_11, var_4_10.LayerWeightMap + 1)
	arg_4_0:InitTransformMapBtn(arg_4_0.buttonDown, 1, arg_4_0.effectDown)
	arg_4_0:InitTransformMapBtn(arg_4_0.buttonUp, -1, arg_4_0.effectUp)

	AutoLoader = var_1
	arg_4_0.loader = var_1.New()

	return
end

function var_0_1.InitTransformMapBtn(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	onButton = var_1_10004

	var_1_10004(arg_5_0, arg_5_1, function()
		local var_6_0 = arg_5_0

		if var_0.isfrozen(var_6_0) then
			return
		end

		seriesAsync = var_0

		var_0({
			function(arg_7_0)
				local var_7_0 = arg_5_0

				if not var_1.TrySwitchNextMap(var_7_0, arg_5_2) then
					return
				end

				pg = var_1

				local var_7_1 = var_1.CriMgr.GetInstance()

				var_1.StopBGM(var_7_1)

				pg = var_1

				local var_7_2 = var_1.CriMgr.GetInstance()

				var_1.PlaySE_V3(var_7_2, "battle-ship-move")

				setActive = var_1

				var_1(arg_5_3, true)

				local var_7_3 = arg_5_0.sceneParent

				var_1.frozen(var_7_3)

				LeanTween = var_1

				local var_7_4 = var_1.delayedCall

				go = var_7_3

				local var_7_5 = var_7_3(arg_5_1)
				local var_7_6 = 1.8

				System = var_3_10004

				var_7_4(var_7_5, var_7_6, var_3_10004.Action(arg_7_0))

				return
			end,
			function(arg_8_0)
				local var_8_0 = arg_5_0.sceneParent

				var_1.setMap(var_8_0, arg_5_0.contextData.mapIdx + arg_5_2)

				LeanTween = var_1

				local var_8_1 = var_1.delayedCall

				go = var_8_0

				local var_8_2 = var_8_0(arg_5_1)
				local var_8_3 = 0.5

				System = var_4

				var_8_1(var_8_2, var_8_3, var_4.Action(arg_8_0))

				return
			end,
			function(arg_9_0)
				local var_9_0 = arg_5_0.sceneParent

				var_1.unfrozen(var_9_0)

				return
			end
		})

		return
	end)

	return
end

function var_0_1.UpdateCustomButtons(arg_10_0)
	local var_10_0 = arg_10_0.contextData.map
	local var_10_1 = var_1.getConfig(var_10_0, "type")

	Map = var_10_0

	local var_10_2 = var_10_1 == var_10_0.ACT_EXTRA

	setActive = var_4

	var_4(arg_10_0.buttonUp, false)

	setActive = var_4

	var_4(arg_10_0.effectUp, false)

	setActive = var_4

	var_4(arg_10_0.buttonDown, false)

	setActive = var_4

	var_4(arg_10_0.effectDown, false)

	if not var_10_2 then
		setActive = var_4

		var_4(arg_10_0.sceneParent.btnPrev, false)

		setActive = var_4

		var_4(arg_10_0.sceneParent.btnNext, false)

		getProxy = var_4
		ChapterProxy = var_5

		local var_10_3 = var_4(var_5)

		tobool = var_5

		local var_10_4 = var_5(var_10_3:getMapById(var_1.id - 1))

		tobool = var_6

		local var_10_5 = var_6(var_10_3:getMapById(var_1.id + 1))

		setActive = var_7

		var_7(arg_10_0.buttonDown, var_10_5)

		setActive = var_7

		var_7(arg_10_0.buttonUp, var_10_4)

		LeanTween = var_7

		local var_10_6 = var_7.cancel

		go = var_8

		var_10_6(var_8(arg_10_0.buttonUp), true)

		LeanTween = var_10_6

		local var_10_7 = var_10_6.cancel

		go = var_8

		var_10_7(var_8(arg_10_0.buttonDown), true)
	end

	return
end

function var_0_1.UpdateMapItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_2
	local var_11_1 = arg_11_2.getConfigTable(var_11_0)

	setLocalPosition = var_11_0

	var_11_0(arg_11_1, {
		x = 0 * var_11_1.pos_x,
		y = 1080 * var_11_1.pos_y
	})

	findTF = var_11_0

	local var_11_2 = var_11_0(arg_11_1, "main")

	setActive = var_5

	var_5(var_11_2, true)

	findTF = var_5

	local var_11_3 = var_5(var_11_2, "info/bk/fordark")

	setActive = var_6

	var_6(var_11_3, var_11_1.icon_outline == 1)

	findTF = var_6

	local var_11_4 = var_6(var_11_2, "circle/clear_flag")

	findTF = var_7

	local var_11_5 = var_7(var_11_2, "circle/lock")
	local var_11_6, var_11_7

	if not arg_11_2.active then
		var_11_6 = arg_11_2
		var_11_7 = not arg_11_2.isUnlock(var_11_6)
	else
		var_11_7 = false
	end

	if false then
		var_11_7 = true
	end

	findTF = var_11_6

	local var_11_8 = var_11_6(var_11_2, "circle/progress")

	findTF = var_10

	local var_11_9 = var_10(var_11_2, "circle/progress_text")

	findTF = var_11

	local var_11_10 = var_11(var_11_2, "circle/stars")

	string = var_12

	local var_11_11 = var_12.split(var_11_1.name, "|")
	local var_11_12 = var_0_2
	local var_11_13 = arg_11_0.data
	local var_11_14 = var_11_12[var_14.GetConfigID(var_11_13)]
	local var_11_15 = arg_11_0.loader

	var_14.GetSpriteQuiet(var_11_15, arg_11_0:GetAtlasPath(), "stage_bar_" .. var_11_14, var_11_2:Find("info/bk"))

	local var_11_16 = arg_11_0.loader

	var_14.GetSpriteQuiet(var_11_16, arg_11_0:GetAtlasPath(), "chapter_progress_bg_" .. var_11_14, var_11_2:Find("circle/bk"))

	local var_11_17 = arg_11_0.loader

	var_14.GetSpriteQuiet(var_11_17, arg_11_0:GetAtlasPath(), "chapter_progress_circle_" .. var_11_14, var_11_2:Find("circle/progress/Fill/progress"))

	local var_11_18 = arg_11_0.loader

	var_14.GetSpriteQuiet(var_11_18, arg_11_0:GetAtlasPath(), "chapter_progress_wave_" .. var_11_14, var_11_2:Find("circle/progress/Mask/Handler/Wave"))

	local var_11_19 = arg_11_0.loader

	var_14.GetSpriteQuiet(var_11_19, arg_11_0:GetAtlasPath(), "clear_text_" .. var_11_14, var_11_2:Find("circle/clear_flag"))

	setSlider = var_14

	var_14(var_11_2:Find("circle/progress"), 0, 1, arg_11_2.progress / 100)

	local var_11_20 = var_11_7 and "#737373" or "#FFFFFF"

	setText = var_15
	findTF = var_16

	local var_11_21 = var_16(var_11_2, "info/bk/title_form/title_index")

	setColorStr = var_17

	var_15(var_11_21, var_17(var_11_1.chapter_name .. "  ", var_11_20))

	setText = var_15
	findTF = var_11_21

	local var_11_22 = var_11_21(var_11_2, "info/bk/title_form/title")

	setColorStr = var_17

	var_15(var_11_22, var_17(var_11_11[1], var_11_20))

	setText = var_15
	findTF = var_11_22

	local var_11_23 = var_11_22(var_11_2, "info/bk/title_form/title_en")

	setColorStr = var_17

	local var_11_24

	if not var_11_11[2] then
		var_11_24 = ""
	end

	var_15(var_11_23, var_17(var_11_24, var_11_20))

	setText = var_15

	local var_11_25 = var_11_9

	string = var_17

	var_15(var_11_25, var_17.format("%d%%", arg_11_2.progress))

	setActive = var_15

	var_15(var_11_10, arg_11_2:existAchieve())

	local var_11_26 = arg_11_2

	if arg_11_2.existAchieve(var_11_26) then
		ipairs = var_15

		for iter_11_0, iter_11_1 in var_15(arg_11_2.achieves) do
			ChapterConst = var_11_27

			local var_11_27 = var_11_27.IsAchieved(iter_11_1)
			local var_11_28 = var_11_10
			local var_11_29 = var_11_10.Find(var_11_28, "star" .. iter_11_0 .. "/light")

			setActive = var_11_28

			var_11_28(var_11_29, var_11_27)
		end
	end

	local var_11_30

	if not arg_11_2.active then
		var_11_26 = arg_11_2
		var_11_30 = arg_11_2.isClear(var_11_26)
	else
		var_11_30 = false
	end

	if false then
		var_11_30 = true
	end

	setActive = var_11_26

	var_11_26(var_11_4, var_11_30)

	setActive = var_11_26

	var_11_26(var_11_5, var_11_7)

	setActive = var_11_26

	var_11_26(var_11_9, not var_11_30 and not var_11_7)
	arg_11_0:DeleteTween("fighting" .. arg_11_2.id)

	findTF = var_16

	local var_11_31 = var_16(var_11_2, "circle/fighting")

	setText = var_17
	findTF = var_18

	local var_11_32 = var_18(var_11_31, "Text")

	i18n = var_19

	var_17(var_11_32, var_19("tag_level_fighting"))

	findTF = var_17

	local var_11_33 = var_17(var_11_2, "circle/oni")

	setText = var_18
	findTF = var_19

	local var_11_34 = var_19(var_11_33, "Text")

	i18n = var_20

	var_18(var_11_34, var_20("tag_level_oni"))

	findTF = var_18

	local var_11_35 = var_18(var_11_2, "circle/narrative")

	setText = var_19
	findTF = var_20

	local var_11_36 = var_20(var_11_35, "Text")

	i18n = var_21

	var_19(var_11_36, var_21("tag_level_narrative"))

	setActive = var_19

	var_19(var_11_31, false)

	setActive = var_19

	var_19(var_11_33, false)

	setActive = var_19

	var_19(var_11_35, false)

	local var_11_37
	local var_11_38

	if arg_11_2:getConfig("chapter_tag") == 1 then
		var_11_37 = var_11_35
	end

	if arg_11_2.active then
		var_11_37 = arg_11_2:existOni() and var_11_33 or var_11_31
	end

	local var_11_41

	if var_11_37 then
		setActive = var_11_41

		var_11_41(var_11_37, true)

		GetOrAddComponent = var_11_41

		local var_11_39 = var_11_41(var_11_37, "CanvasGroup")

		var_11_39.alpha = 1

		local var_11_40 = arg_11_0

		var_11_41 = arg_11_0.RecordTween

		local var_11_42 = "fighting" .. arg_11_2.id

		LeanTween = var_24

		local var_11_43 = var_24.alphaCanvas(var_11_39, 0, 0.5)
		local var_11_44 = var_24.setFrom(var_11_43, 1)
		local var_11_45 = var_24.setEase

		LeanTweenType = var_26

		local var_11_46 = var_11_45(var_11_44, var_26.easeInOutSine)

		var_11_41(var_11_40, var_11_42, var_24.setLoopPingPong(var_11_46).uniqueId)
	end

	findTF = var_11_41

	local var_11_47 = var_11_41(var_11_2, "triesLimit")
	local var_11_48 = arg_11_2
	local var_11_49 = arg_11_2.isTriesLimit(var_11_48)

	setActive = var_11_48

	var_11_48(var_11_47, var_11_49)

	if var_11_49 then
		local var_11_50 = arg_11_2:getConfig("count") - arg_11_2:getTodayDefeatCount() .. "/" .. var_23

		setText = var_25

		local var_11_51 = var_11_47
		local var_11_52 = var_11_47.Find(var_11_51, "label")

		i18n = var_11_51

		var_25(var_11_52, var_11_51("levelScene_chapter_count_tip"))

		setText = var_25

		local var_11_53 = var_11_47
		local var_11_54 = var_11_47.Find(var_11_53, "Text")

		setColorStr = var_11_53

		local var_11_55 = var_11_50

		if var_23 <= arg_11_2:getTodayDefeatCount() then
			COLOR_RED = var_29

			if not var_29 then
				COLOR_GREEN = var_29
			end

			var_25(var_11_54, var_11_53(var_11_55, var_29))

			local var_11_56 = arg_11_2
			local var_11_57 = arg_11_2.GetDailyBonusQuota(var_11_56)

			findTF = var_11_56

			local var_11_58 = var_11_56(var_11_2, "mark")
			local var_11_59 = var_24.Find(var_11_58, "bonus")
			local var_11_60 = var_25.Find(var_11_59, "icon")

			findTF = var_11_59

			local var_11_61 = var_11_59(var_25, "icon/Image")

			setActive = var_28

			var_28(var_25, var_11_57)

			setActive = var_28

			var_28(var_24, var_11_57)

			local var_11_62, var_11_63

			if var_11_60 then
				setActive = var_28
				var_11_62 = var_11_60
				var_11_63 = var_11_57 and arg_11_0.bonusPtIconPath

				var_28(var_11_62, var_11_63)
			end

			if var_11_57 then
				var_11_62 = var_24

				local var_11_64 = var_24.GetComponent

				typeof = var_11_63
				CanvasGroup = var_1_10031

				local var_11_65 = var_11_64(var_11_62, var_11_63(var_1_10031))

				var_11_62 = arg_11_2:GetDailyBonusIconName()

				local var_11_66 = arg_11_0.sceneParent.loader

				var_30.GetSprite(var_11_66, "ui/levelmainscene_atlas", var_11_62, var_25)

				if var_11_60 and arg_11_0.bonusPtIconPath then
					if var_11_61 then
						GetImageSpriteFromAtlasAsync = var_30

						var_30(arg_11_0.bonusPtIconPath, "", var_11_61, true)
					else
						GetImageSpriteFromAtlasAsync = var_30

						var_30(arg_11_0.bonusPtIconPath, "", var_11_60, true)
					end
				end

				LeanTween = var_30

				local var_11_67 = var_30.cancel

				go = var_11_66

				var_11_67(var_11_66(var_24), true)

				local var_11_68 = var_24.anchoredPosition.y

				var_11_65.alpha = 0
				LeanTween = var_31

				local var_11_69 = var_31.value

				go = var_32

				local var_11_70 = var_11_69(var_32(var_24), 0, 1, 0.2)
				local var_11_71 = var_31.setOnUpdate

				System = var_1_10033

				local var_11_72 = var_11_71(var_11_70, var_1_10033.Action_float(function(arg_12_0)
					var_11_65.alpha = arg_12_0

					local var_12_0 = var_0.anchoredPosition

					var_12_0.y = var_11_68 * arg_12_0
					var_0.anchoredPosition = var_12_0

					return
				end))
				local var_11_73 = var_31.setOnComplete

				System = var_1_10033

				local var_11_74 = var_11_73(var_11_72, var_1_10033.Action(function()
					var_11_65.alpha = 1

					local var_13_0 = var_0.anchoredPosition

					var_13_0.y = var_11_68
					var_0.anchoredPosition = var_13_0

					return
				end))
				local var_11_75 = var_31.setEase

				LeanTweenType = var_1_10033

				local var_11_76 = var_11_75(var_11_74, var_1_10033.easeOutSine)

				var_31.setDelay(var_11_76, 0.7)
			end

			local var_11_77 = arg_11_2.id

			onButton = var_11_62

			local var_11_78 = arg_11_0
			local var_11_79 = var_11_2

			local function var_11_80()
				if arg_11_0.chaptersInBackAnimating[var_11_77] then
					return
				end

				local var_14_0 = arg_11_1.localPosition
				local var_14_1 = arg_11_0
				local var_14_2 = var_1.TryOpenChapterInfo
				local var_14_3 = var_11_77

				Vector3 = var_2_10004

				var_14_2(var_14_1, var_14_3, var_2_10004(var_14_0.x - 10, var_14_0.y + 22))

				return
			end

			SFX_UI_WEIGHANCHOR_SELECT = var_1_10033

			var_11_62(var_11_78, var_11_79, var_11_80, var_1_10033)

			return
		end
	end
end

function var_0_1.OnDestroy(arg_15_0)
	local var_15_0 = arg_15_0.loader

	var_1.Clear(var_15_0)
	var_0_1.super.OnDestroy(arg_15_0)

	return
end

return var_0_1
