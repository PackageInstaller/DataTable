class = var_0_10000

local var_0_0 = "MapBuilderNormal"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MapBuilderPermanent"))

function var_0_1.GetType(arg_1_0)
	MapBuilder = var_1_10001

	return var_1_10001.TYPENORMAL
end

function var_0_1.getUIName(arg_2_0)
	return "levels"
end

function var_0_1.Load(arg_3_0)
	if arg_3_0._state ~= var_0_1.STATES.NONE then
		return
	end

	arg_3_0._state = var_0_1.STATES.LOADING
	pg = var_1

	local var_3_0 = var_1.UIMgr.GetInstance()

	var_1.LoadingOn(var_3_0)

	local var_3_1 = arg_3_0.float
	local var_3_2 = var_1.Find(var_3_1, "levels").gameObject

	arg_3_0:Loaded(var_3_2)
	arg_3_0:Init()

	return
end

function var_0_1.Destroy(arg_4_0)
	if arg_4_0._state == var_0_1.STATES.DESTROY then
		return
	end

	if not arg_4_0:GetLoaded() then
		arg_4_0._state = var_0_1.STATES.DESTROY

		return
	end

	arg_4_0:Hide()
	arg_4_0:OnDestroy()

	pg = var_1

	var_1.DelegateInfo.Dispose(arg_4_0)

	arg_4_0._go = nil

	arg_4_0:disposeEvent()
	arg_4_0:cleanManagedTween()

	arg_4_0._state = var_0_1.STATES.DESTROY

	return
end

function var_0_1.OnInit(arg_5_0)
	local var_5_0 = arg_5_0._tf

	arg_5_0.chapterTpl = var_1.Find(var_5_0, "level_tpl")
	setActive = var_1

	var_1(arg_5_0.chapterTpl, false)

	local var_5_1 = arg_5_0._tf

	arg_5_0.storyTpl = var_1.Find(var_5_1, "story_tpl")
	setActive = var_1

	var_1(arg_5_0.storyTpl, false)

	local var_5_2 = arg_5_0._tf

	arg_5_0.itemHolder = var_1.Find(var_5_2, "items")

	local var_5_3 = arg_5_0._tf

	arg_5_0.storyHolder = var_1.Find(var_5_3, "stories")
	arg_5_0.chapterTFsById = {}
	arg_5_0.chaptersInBackAnimating = {}

	return
end

function var_0_1.OnShow(arg_6_0)
	var_0_1.super.OnShow(arg_6_0)

	setActive = var_1

	local var_6_0 = arg_6_0.sceneParent.mainLayer

	var_1(var_2.Find(var_6_0, "title_chapter_lines"), true)

	setActive = var_1

	local var_6_1 = arg_6_0.sceneParent.topChapter

	var_1(var_2.Find(var_6_1, "title_chapter"), true)

	setActive = var_1

	local var_6_2 = arg_6_0.sceneParent.topChapter

	var_1(var_2.Find(var_6_2, "type_chapter"), true)

	return
end

function var_0_1.OnHide(arg_7_0)
	setActive = var_1_10001

	local var_7_0 = arg_7_0.sceneParent.mainLayer

	var_1_10001(var_2.Find(var_7_0, "title_chapter_lines"), false)

	setActive = var_1_10001

	local var_7_1 = arg_7_0.sceneParent.topChapter

	var_1_10001(var_2.Find(var_7_1, "title_chapter"), false)

	setActive = var_1_10001

	local var_7_2 = arg_7_0.sceneParent.topChapter

	var_1_10001(var_2.Find(var_7_2, "type_chapter"), false)

	table = var_1_10001

	var_1_10001.clear(arg_7_0.chaptersInBackAnimating)

	pairs = var_1

	for iter_7_0, iter_7_1 in var_1(arg_7_0.chapterTFsById) do
		findTF = var_1_10006
		var_1_10006 = var_1_10006(iter_7_1, "main/info/bk")
		LeanTween = var_7

		local var_7_3 = var_7.cancel

		rtf = var_8

		var_7_3(var_8(var_1_10006))
	end

	var_0_1.super.OnHide(arg_7_0)

	return
end

function var_0_1.UpdateView(arg_8_0)
	string = var_1_10001

	local var_8_0 = var_1_10001.split
	local var_8_1 = arg_8_0.contextData.map
	local var_8_2 = var_8_0(var_2.getConfig(var_8_1, "name"), "||")

	setText = var_2

	var_2(arg_8_0.sceneParent.chapterName, var_8_2[1])

	local var_8_3 = arg_8_0.contextData.map
	local var_8_4 = var_2.getMapTitleNumber(var_8_3)
	local var_8_5 = arg_8_0.sceneParent.loader

	var_3.GetSpriteQuiet(var_8_5, "chapterno", "chapter" .. var_8_4, arg_8_0.sceneParent.chapterNoTitle, true)
	var_0_1.super.UpdateView(arg_8_0)

	return
end

function var_0_1.UpdateBonusPtIconPath(arg_9_0)
	arg_9_0.bonusPtIconPath = nil

	local var_9_0

	if not arg_9_0.data then
		var_9_0 = arg_9_0.contextData.map
	end

	if not var_9_0 then
		return
	end

	local var_9_1 = var_9_0

	if not var_9_0.getConfig(var_9_1, "on_activity") or var_2 == 0 then
		return
	end

	getProxy = var_9_1
	ActivityProxy = var_4

	local var_9_2 = var_9_1(var_4)

	if not var_3.getActivityById(var_9_2, var_2) or var_4:isEnd() then
		return
	end

	local var_9_3 = var_4

	if not var_4.GetConfigClientSetting(var_9_3, "PTID") then
		return
	end

	underscore = var_9_3

	local var_9_4 = var_9_3.detect
	local var_9_5 = var_3
	local var_9_6 = var_3.getActivitiesByType

	ActivityConst = var_1_10009

	if not var_9_4(var_9_6(var_9_5, var_1_10009.ACTIVITY_TYPE_PT_RANK), function(arg_10_0)
		return arg_10_0 and not arg_10_0:isEnd() and arg_10_0:getConfig("config_id") == var_0
	end) then
		return
	end

	tonumber = var_7

	if not var_7(var_6:getConfig("config_id")) then
		return
	end

	Drop = var_8

	local var_9_7 = var_8.New
	local var_9_8 = {}

	DROP_TYPE_RESOURCE = var_10
	var_9_8.type = var_10
	var_9_8.id = var_7

	local var_9_9 = var_9_7(var_9_8)

	arg_9_0.bonusPtIconPath = var_8.getIcon(var_9_9)

	return
end

function var_0_1.UpdateMapItems(arg_11_0)
	var_0_1.super.UpdateMapItems(arg_11_0)

	local var_11_0 = arg_11_0.data

	if var_1.GetChapterInProgress(var_11_0) then
		isa = var_11_0

		local var_11_1 = var_2

		ChapterStoryGroup = var_1_10005

		if var_11_0(var_11_1, var_1_10005) then
			setActive = var_11_0

			var_11_0(arg_11_0.itemHolder, false)

			setActive = var_11_0

			var_11_0(arg_11_0.storyHolder, true)
			arg_11_0:UpdateStoryGroup()

			return
		end
	end

	setActive = var_11_0

	var_11_0(arg_11_0.itemHolder, true)

	setActive = var_11_0

	var_11_0(arg_11_0.storyHolder, false)

	local var_11_2 = arg_11_0

	arg_11_0.UpdateBonusPtIconPath(var_11_2)

	getProxy = var_3
	ChapterProxy = var_11_2

	local var_11_3 = var_3(var_11_2)
	local var_11_4 = {}

	pairs = var_5

	for iter_11_0, iter_11_1 in var_5(var_1:getChapters()) do
		var_1_10011 = iter_11_1

		if not iter_11_1.isUnlock(var_1_10011) then
			var_1_10011 = iter_11_1

			if iter_11_1.activeAlways(var_1_10011) then
				var_1_10011 = iter_11_1

				if iter_11_1.ifNeedHide(var_1_10011) then
					var_1_10011 = var_11_3

					if var_11_3.GetJustClearChapters(var_1_10011, iter_11_1.id) then
						table = var_10

						var_10.insert(var_11_4, iter_11_1)
					end
				end
			end
		end
	end

	table = var_5

	var_5.clear(arg_11_0.chapterTFsById)

	UIItemList = var_5

	var_5.StaticAlign(arg_11_0.itemHolder, arg_11_0.chapterTpl, #var_11_4, function(arg_12_0, arg_12_1, arg_12_2)
		UIItemList = var_2_10003

		if arg_12_0 ~= var_2_10003.EventUpdate then
			return
		end

		local var_12_0 = var_11_4[arg_12_1 + 1]
		local var_12_1 = arg_11_0

		var_4.UpdateMapItem(var_12_1, arg_12_2, var_12_0)

		arg_12_2.name = "Chapter_" .. var_12_0.id
		arg_11_0.chapterTFsById[var_12_0.id] = arg_12_2

		return
	end)

	local var_11_5 = {}

	pairs = var_6

	for iter_11_2, iter_11_3 in var_6(var_11_4) do
		local var_11_6 = iter_11_3:getConfigTable().pos_x
		local var_11_7

		if not var_11_5[var_1_10011.pos_x] then
			var_11_7 = {}
		end

		var_11_5[var_11_6] = var_11_7

		local var_11_8 = var_11_5[var_1_10011.pos_x]
		local var_11_9 = var_1_10011.pos_y
		local var_11_10

		if not var_11_8[var_1_10011.pos_y] then
			var_11_10 = {}
		end

		var_11_8[var_11_9] = var_11_10

		local var_11_11 = var_11_8[var_1_10011.pos_y]

		table = var_11_10

		var_11_10.insert(var_11_11, iter_11_3)
	end

	pairs = var_6

	for iter_11_4, iter_11_5 in var_6(var_11_5) do
		pairs = var_1_10011

		for iter_11_6, iter_11_7 in var_1_10011(iter_11_5) do
			local var_11_12 = {}

			seriesAsync = var_1_10017

			var_1_10017({
				function(arg_13_0)
					local var_13_0 = 0

					pairs = var_2_10002

					for iter_13_0, iter_13_1 in var_2_10002(iter_11_7) do
						if iter_13_1:ifNeedHide() then
							local var_13_1 = var_11_3

							if var_7.GetJustClearChapters(var_13_1, iter_13_1.id) and arg_11_0.chapterTFsById[iter_13_1.id] then
								var_13_0 = var_13_0 + 1

								local var_13_2 = arg_11_0.chapterTFsById[iter_13_1.id]

								setActive = var_8

								var_8(var_13_2, true)

								local var_13_3 = arg_11_0

								var_8.PlayChapterItemAnimationBackward(var_13_3, var_13_2, iter_13_1, function()
									var_13_0 = var_13_0 - 1
									setActive = var_0

									var_0(var_13_2, false)

									local var_14_0 = var_11_3

									var_0.RecordJustClearChapters(var_14_0, iter_13_1.id, nil)

									if var_13_0 <= 0 then
										arg_13_0()
									end

									return
								end)

								var_11_12[iter_13_1.id] = true

								goto label_13_0
							end
						end

						if arg_11_0.chapterTFsById[iter_13_1.id] then
							setActive = var_7

							var_7(arg_11_0.chapterTFsById[iter_13_1.id], false)
						end

						::label_13_0::
					end

					if var_13_0 <= 0 then
						arg_13_0()
					end

					return
				end,
				function(arg_15_0)
					local var_15_0 = 0

					pairs = var_2_10002

					for iter_15_0, iter_15_1 in var_2_10002(iter_11_7) do
						if not var_11_12[iter_15_1.id] then
							var_15_0 = var_15_0 + 1
							setActive = var_7

							var_7(arg_11_0.chapterTFsById[iter_15_1.id], true)

							local var_15_1 = arg_11_0

							var_7.PlayChapterItemAnimation(var_15_1, arg_11_0.chapterTFsById[iter_15_1.id], iter_15_1, function()
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

function var_0_1.UpdateMapItem(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_2
	local var_17_1 = arg_17_2.getConfigTable(var_17_0)

	warning = var_17_0

	var_17_0(0 * var_17_1.pos_x, 1080 * var_17_1.pos_y)

	setLocalPosition = var_17_0

	var_17_0(arg_17_1, {
		x = 0 * var_17_1.pos_x,
		y = 1080 * var_17_1.pos_y
	})

	findTF = var_17_0

	local var_17_2 = var_17_0(arg_17_1, "main")

	setActive = var_5

	var_5(var_17_2, true)

	findTF = var_5

	local var_17_3 = var_5(var_17_2, "circle/fordark")

	findTF = var_6

	local var_17_4 = var_6(var_17_2, "info/bk/fordark")

	setActive = var_7

	var_7(var_17_3, var_17_1.icon_outline == 1)

	setActive = var_7

	var_7(var_17_4, var_17_1.icon_outline == 1)

	findTF = var_7

	local var_17_5 = var_7(var_17_2, "circle/clear_flag")

	findTF = var_8

	local var_17_6 = var_8(var_17_2, "circle/progress")

	findTF = var_9

	local var_17_7 = var_9(var_17_2, "circle/progress_text")

	findTF = var_10

	local var_17_8 = var_10(var_17_2, "circle/stars")

	string = var_11

	local var_17_9 = var_11.split(var_17_1.name, "|")

	setText = var_12
	findTF = var_13

	var_12(var_13(var_17_2, "info/bk/title_form/title_index"), var_17_1.chapter_name .. "  ")

	setText = var_12
	findTF = var_13

	var_12(var_13(var_17_2, "info/bk/title_form/title"), var_17_9[1])

	setText = var_12
	findTF = var_13

	local var_17_10 = var_13(var_17_2, "info/bk/title_form/title_en")
	local var_17_11

	if not var_17_9[2] then
		var_17_11 = ""
	end

	var_12(var_17_10, var_17_11)

	setFillAmount = var_12

	var_12(var_17_6, arg_17_2.progress / 100)

	setText = var_12

	local var_17_12 = var_17_7

	string = var_14

	var_12(var_17_12, var_14.format("%d%%", arg_17_2.progress))

	setActive = var_12

	var_12(var_17_8, arg_17_2:existAchieve())

	local var_17_13 = arg_17_2

	if arg_17_2.existAchieve(var_17_13) then
		ipairs = var_12

		for iter_17_0, iter_17_1 in var_12(arg_17_2.achieves) do
			ChapterConst = var_1_10017
			var_1_10017 = var_1_10017.IsAchieved(iter_17_1)

			local var_17_14 = var_17_8
			local var_17_15 = var_17_8.Find(var_17_14, "star" .. iter_17_0 .. "/light")

			setActive = var_17_14

			var_17_14(var_17_15, var_1_10017)
		end
	end

	local var_17_16

	if not arg_17_2.active then
		var_17_13 = arg_17_2
		var_17_16 = arg_17_2.isClear(var_17_13)
	else
		var_17_16 = false
	end

	if false then
		var_17_16 = true
	end

	setActive = var_17_13

	var_17_13(var_17_5, var_17_16)

	setActive = var_17_13

	var_17_13(var_17_7, not var_17_16)
	arg_17_0:DeleteTween("fighting" .. arg_17_2.id)

	findTF = var_13

	local var_17_17 = var_13(var_17_2, "circle/fighting")

	setText = var_14
	findTF = var_15

	local var_17_18 = var_15(var_17_17, "Text")

	i18n = var_16

	var_14(var_17_18, var_16("tag_level_fighting"))

	findTF = var_14

	local var_17_19 = var_14(var_17_2, "circle/oni")

	setText = var_15
	findTF = var_16

	local var_17_20 = var_16(var_17_19, "Text")

	i18n = var_17

	var_15(var_17_20, var_17("tag_level_oni"))

	findTF = var_15

	local var_17_21 = var_15(var_17_2, "circle/narrative")

	setText = var_16
	findTF = var_17

	local var_17_22 = var_17(var_17_21, "Text")

	i18n = var_18

	var_16(var_17_22, var_18("tag_level_narrative"))

	setActive = var_16

	var_16(var_17_17, false)

	setActive = var_16

	var_16(var_17_19, false)

	setActive = var_16

	var_16(var_17_21, false)

	local var_17_23
	local var_17_24

	if arg_17_2:getConfig("chapter_tag") == 1 then
		var_17_23 = var_17_21
	end

	if arg_17_2.active then
		var_17_23 = arg_17_2:existOni() and var_17_19 or var_17_17
	end

	local var_17_27

	if var_17_23 then
		setActive = var_17_27

		var_17_27(var_17_23, true)

		GetOrAddComponent = var_17_27

		local var_17_25 = var_17_27(var_17_23, "CanvasGroup")

		var_17_25.alpha = 1

		local var_17_26 = arg_17_0

		var_17_27 = arg_17_0.RecordTween

		local var_17_28 = "fighting" .. arg_17_2.id

		LeanTween = var_21

		local var_17_29 = var_21.alphaCanvas(var_17_25, 0, 0.5)
		local var_17_30 = var_21.setFrom(var_17_29, 1)
		local var_17_31 = var_21.setEase

		LeanTweenType = var_23

		local var_17_32 = var_17_31(var_17_30, var_23.easeInOutSine)

		var_17_27(var_17_26, var_17_28, var_21.setLoopPingPong(var_17_32).uniqueId)
	end

	findTF = var_17_27

	local var_17_33 = var_17_27(var_17_2, "triesLimit")

	setActive = var_19

	var_19(var_17_33, false)

	if arg_17_2:isTriesLimit() then
		local var_17_34 = arg_17_2:getConfig("count") - arg_17_2:getTodayDefeatCount() .. "/" .. var_20

		setText = var_22

		local var_17_35 = var_17_33
		local var_17_36 = var_17_33.Find(var_17_35, "label")

		i18n = var_17_35

		var_22(var_17_36, var_17_35("levelScene_chapter_count_tip"))

		setText = var_22

		local var_17_37 = var_17_33
		local var_17_38 = var_17_33.Find(var_17_37, "Text")

		setColorStr = var_17_37

		local var_17_39 = var_17_34

		if var_20 <= arg_17_2:getTodayDefeatCount() then
			COLOR_RED = var_26

			if not var_26 then
				COLOR_GREEN = var_26
			end

			var_22(var_17_38, var_17_37(var_17_39, var_26))

			pg = var_22

			local var_17_40 = var_22.expedition_data_by_map
			local var_17_41 = arg_17_2
			local var_17_42 = var_17_40[arg_17_2.getConfig(var_17_41, "map")].on_activity

			getProxy = var_23
			ChapterProxy = var_17_41

			local var_17_43 = var_23(var_17_41)
			local var_17_44

			if var_23.IsActivitySPChapterActive(var_17_43, var_17_42) then
				SettingsProxy = var_17_44
				var_17_44 = var_17_44.IsShowActivityMapSPTip()
			end

			setActive = var_17_43

			var_17_43(var_17_33:Find("TipRect"), var_17_44)

			local var_17_45 = arg_17_2
			local var_17_46 = arg_17_2.GetDailyBonusQuota(var_17_45)

			findTF = var_17_45

			local var_17_47 = var_17_45(var_17_2, "mark")
			local var_17_48 = var_21.Find(var_17_47, "bonus")
			local var_17_49 = var_22.Find(var_17_48, "icon")

			findTF = var_17_48

			local var_17_50 = var_17_48(var_22, "icon/Image")

			setActive = var_25

			var_25(var_22, var_17_46)

			setActive = var_25

			var_25(var_21, var_17_46)

			local var_17_51, var_17_52

			if var_17_49 then
				setActive = var_25
				var_17_51 = var_17_49
				var_17_52 = var_17_46 and arg_17_0.bonusPtIconPath

				var_25(var_17_51, var_17_52)
			end

			if var_17_46 then
				var_17_51 = var_21

				local var_17_53 = var_21.GetComponent

				typeof = var_17_52
				CanvasGroup = var_1_10028

				local var_17_54 = var_17_53(var_17_51, var_17_52(var_1_10028))

				var_17_51 = arg_17_2:GetDailyBonusIconName()

				local var_17_55 = arg_17_0.sceneParent.loader

				var_27.GetSprite(var_17_55, "ui/levelmainscene_atlas", var_17_51, var_22)

				if var_17_49 and arg_17_0.bonusPtIconPath then
					if var_17_50 then
						GetImageSpriteFromAtlasAsync = var_27

						var_27(arg_17_0.bonusPtIconPath, "", var_17_50, true)
					else
						GetImageSpriteFromAtlasAsync = var_27

						var_27(arg_17_0.bonusPtIconPath, "", var_17_49, true)
					end
				end

				LeanTween = var_27

				local var_17_56 = var_27.cancel

				go = var_17_55

				var_17_56(var_17_55(var_21), true)

				local var_17_57 = var_21.anchoredPosition.y

				var_17_54.alpha = 0
				LeanTween = var_28

				local var_17_58 = var_28.value

				go = var_29

				local var_17_59 = var_17_58(var_29(var_21), 0, 1, 0.2)
				local var_17_60 = var_28.setOnUpdate

				System = var_1_10030

				local var_17_61 = var_17_60(var_17_59, var_1_10030.Action_float(function(arg_18_0)
					var_17_54.alpha = arg_18_0

					local var_18_0 = var_0.anchoredPosition

					var_18_0.y = var_17_57 * arg_18_0
					var_0.anchoredPosition = var_18_0

					return
				end))
				local var_17_62 = var_28.setOnComplete

				System = var_1_10030

				local var_17_63 = var_17_62(var_17_61, var_1_10030.Action(function()
					var_17_54.alpha = 1

					local var_19_0 = var_0.anchoredPosition

					var_19_0.y = var_17_57
					var_0.anchoredPosition = var_19_0

					return
				end))
				local var_17_64 = var_28.setEase

				LeanTweenType = var_1_10030

				local var_17_65 = var_17_64(var_17_63, var_1_10030.easeOutSine)

				var_28.setDelay(var_17_65, 0.7)
			end

			local var_17_66 = arg_17_2.id

			onButton = var_17_51

			local var_17_67 = arg_17_0
			local var_17_68 = var_17_2

			local function var_17_69()
				if arg_17_0.chaptersInBackAnimating[var_17_66] then
					return
				end

				local var_20_0 = arg_17_1.localPosition
				local var_20_1 = arg_17_0
				local var_20_2 = var_1.TryOpenChapterInfo
				local var_20_3 = var_17_66

				Vector3 = var_2_10004

				var_20_2(var_20_1, var_20_3, var_2_10004(var_20_0.x - 10, var_20_0.y + 22))

				return
			end

			SFX_UI_WEIGHANCHOR_SELECT = var_1_10030

			var_17_51(var_17_67, var_17_68, var_17_69, var_1_10030)

			return
		end
	end
end

function var_0_1.PlayChapterItemAnimation(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	findTF = var_1_10004

	local var_21_0 = var_1_10004(arg_21_1, "main")
	local var_21_1 = var_4.Find(var_21_0, "info")

	findTF = var_21_0

	local var_21_2 = var_21_0(var_4, "circle")

	findTF = var_7

	local var_21_3 = var_7(var_4, "info/bk")

	LeanTween = var_8

	local var_21_4 = var_8.cancel

	go = var_9

	var_21_4(var_9(var_21_2))

	Vector3 = var_21_4
	var_21_2.localScale = var_21_4.zero
	LeanTween = var_8

	local var_21_5 = var_8.scale
	local var_21_6 = var_21_2

	Vector3 = var_10

	local var_21_7 = var_21_5(var_21_6, var_10.one, 0.3)
	local var_21_8 = var_8.setDelay(var_21_7, 0.3)
	local var_21_9 = arg_21_0

	arg_21_0.RecordTween(var_21_9, var_21_8.uniqueId)

	LeanTween = var_9

	local var_21_10 = var_9.cancel

	go = var_21_9

	var_21_10(var_21_9(var_21_3))

	setAnchoredPosition = var_21_10

	var_21_10(var_21_3, {
		x = -1 * var_21_1.rect.width
	})

	shiftPanel = var_21_10

	var_21_10(var_21_3, 0, nil, 0.4, 0.4, true, true, nil, function()
		local var_22_0 = arg_21_2

		if var_0.isTriesLimit(var_22_0) then
			setActive = var_0
			findTF = var_22_0

			var_0(var_22_0(var_0, "triesLimit"), true)
		end

		if arg_21_3 then
			arg_21_3()
		end

		return
	end)

	return
end

function var_0_1.PlayChapterItemAnimationBackward(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	findTF = var_1_10004

	local var_23_0 = var_1_10004(arg_23_1, "main")
	local var_23_1 = var_4.Find(var_23_0, "info")

	findTF = var_23_0

	local var_23_2 = var_23_0(var_4, "circle")

	findTF = var_7

	local var_23_3 = var_7(var_4, "info/bk")

	LeanTween = var_8

	local var_23_4 = var_8.cancel

	go = var_9

	var_23_4(var_9(var_23_2))

	Vector3 = var_23_4
	var_23_2.localScale = var_23_4.one
	LeanTween = var_8

	local var_23_5 = var_8.scale

	go = var_9

	local var_23_6 = var_9(var_23_2)

	Vector3 = var_10

	local var_23_7 = var_23_5(var_23_6, var_10.zero, 0.3)
	local var_23_8 = var_8.setDelay(var_23_7, 0.3)

	arg_23_0:RecordTween(var_23_8.uniqueId)

	local var_23_9 = arg_23_0.chaptersInBackAnimating

	var_23_9[arg_23_2.id] = true
	LeanTween = var_23_9

	local var_23_10 = var_23_9.cancel

	go = var_10

	var_23_10(var_10(var_23_3))

	setAnchoredPosition = var_23_10

	var_23_10(var_23_3, {
		x = 0
	})

	shiftPanel = var_23_10

	var_23_10(var_23_3, -1 * var_23_1.rect.width, nil, 0.4, 0.4, true, true, nil, function()
		arg_23_0.chaptersInBackAnimating[arg_23_2.id] = nil

		if arg_23_3 then
			arg_23_3()
		end

		return
	end)

	local var_23_11 = arg_23_2

	if arg_23_2.isTriesLimit(var_23_11) then
		setActive = var_9
		findTF = var_23_11

		var_9(var_23_11(var_4, "triesLimit"), false)
	end

	return
end

function var_0_1.UpdateChapterTF(arg_25_0, arg_25_1)
	if arg_25_0.chapterTFsById[arg_25_1] then
		getProxy = var_1_10003
		ChapterProxy = var_1_10004

		local var_25_0 = var_1_10003(var_1_10004)
		local var_25_1 = var_3.getChapterById(var_25_0, arg_25_1)

		arg_25_0:UpdateMapItem(var_2, var_25_1)
		arg_25_0:PlayChapterItemAnimation(var_2, var_25_1)
	end

	return
end

function var_0_1.TryOpenChapter(arg_26_0, arg_26_1)
	if arg_26_0.chapterTFsById[arg_26_1] then
		local var_26_0 = var_2
		local var_26_1 = var_2.Find(var_26_0, "main")

		triggerButton = var_26_0

		var_26_0(var_26_1)
	end

	return
end

function var_0_1.UpdateStoryGroup(arg_27_0)
	local var_27_0 = arg_27_0.data
	local var_27_1 = var_1.GetChapterInProgress(var_27_0)
	local var_27_2 = var_1.GetChapterStories(var_27_1)

	UIItemList = var_27_1

	var_27_1.StaticAlign(arg_27_0.storyHolder, arg_27_0.storyTpl, #var_27_2, function(arg_28_0, arg_28_1, arg_28_2)
		UIItemList = var_2_10003

		if arg_28_0 ~= var_2_10003.EventUpdate then
			return
		end

		local var_28_0 = var_27_2[arg_28_1 + 1]
		local var_28_1 = arg_27_0

		var_4.UpdateMapStory(var_28_1, arg_28_2, var_28_0)

		arg_28_2.name = "Chapter_" .. var_28_0:GetName()

		return
	end)

	return
end

function var_0_1.UpdateMapStory(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_2
	local var_29_1 = arg_29_2.GetPosition(var_29_0)

	setAnchoredPosition = var_29_0

	var_29_0(arg_29_1, {
		x = arg_29_0.mapWidth * var_29_1[1],
		y = arg_29_0.mapHeight * var_29_1[2]
	})

	setText = var_29_0

	var_29_0(arg_29_1:Find("Name"), arg_29_2:GetName())

	local var_29_2, var_29_3 = arg_29_2:GetIcon()
	local var_29_4 = arg_29_0.sceneParent.loader

	var_6.GetSpriteQuiet(var_29_4, var_29_2, var_29_3, arg_29_1:Find("Icon"), true)

	local var_29_5 = arg_29_2
	local var_29_6 = arg_29_2.GetStoryName(var_29_5)

	onButton = var_29_5

	local var_29_7 = arg_29_0
	local var_29_8 = arg_29_1

	local function var_29_9()
		pg = var_2_10000

		local var_30_0 = var_2_10000.NewStoryMgr.GetInstance()

		var_0.Play(var_30_0, var_29_6, function()
			local var_31_0 = arg_29_0.sceneParent

			var_0.RefreshMapBG(var_31_0)

			local var_31_1 = arg_29_0

			var_0.UpdateMapItems(var_31_1)

			return
		end)

		return
	end

	SFX_PANEL = var_11

	var_29_5(var_29_7, var_29_8, var_29_9, var_11)

	setActive = var_29_5

	local var_29_10 = arg_29_1

	pg = var_29_8

	local var_29_11 = var_29_8.NewStoryMgr.GetInstance()

	var_29_5(var_29_10, not var_9.IsPlayed(var_29_11, var_29_6))

	return
end

function var_0_1.HideFloat(arg_32_0)
	setActive = var_1_10001

	var_1_10001(arg_32_0.itemHolder, false)

	setActive = var_1_10001

	var_1_10001(arg_32_0.storyHolder, false)

	return
end

function var_0_1.ShowFloat(arg_33_0)
	setActive = var_1_10001

	var_1_10001(arg_33_0.itemHolder, true)

	setActive = var_1_10001

	var_1_10001(arg_33_0.storyHolder, true)

	return
end

return var_0_1
