class = var_0_10000

local var_0_0 = "MapBuilderShinano"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MapBuilderPermanent"))

function var_0_1.Ctor(arg_1_0, ...)
	var_0_1.super.Ctor(arg_1_0, ...)

	arg_1_0.chapterTFsById = {}
	arg_1_0.chaptersInBackAnimating = {}

	return
end

function var_0_1.GetType(arg_2_0)
	MapBuilder = var_1_10001

	return var_1_10001.TYPESHINANO
end

function var_0_1.getUIName(arg_3_0)
	return "Shinano_levels"
end

function var_0_1.OnInit(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0.tpl = var_1.Find(var_4_0, "level_tpl")
	setActive = var_1

	var_1(arg_4_0.tpl, false)

	local var_4_1 = arg_4_0._tf

	arg_4_0.itemHolder = var_1.Find(var_4_1, "items")

	local var_4_2 = arg_4_0._tf
	local var_4_3 = var_1.Find(var_4_2, "preloadResources")
	local var_4_4 = var_1.Find(var_4_3, "mengjing_rumeng")

	setAnchoredPosition = var_4_2

	local var_4_5 = arg_4_0._tf
	local var_4_6 = var_5.Find(var_4_5, "rumeng")

	tf = var_1_10006

	var_4_2(var_4_6, var_1_10006(var_4_4).anchoredPosition)

	setParent = var_4_2

	local var_4_7 = var_4_4
	local var_4_8 = arg_4_0._tf

	var_4_2(var_4_7, var_6.Find(var_4_8, "rumeng"))

	setAnchoredPosition = var_4_2

	local var_4_9 = var_4_4

	Vector2 = var_6

	var_4_2(var_4_9, var_6.zero)

	local var_4_10 = arg_4_0
	local var_4_11 = arg_4_0.InitTransformMapBtn
	local var_4_12 = arg_4_0._tf

	var_4_11(var_4_10, var_6.Find(var_4_12, "rumeng"), 1, var_1:Find("mengjing_rumeng_zhuangchang"))

	local var_4_13 = var_1:Find("mengjing_huigui")

	setAnchoredPosition = var_4_3

	local var_4_14 = arg_4_0._tf
	local var_4_15 = var_6.Find(var_4_14, "huigui")

	tf = var_7

	var_4_3(var_4_15, var_7(var_4_13).anchoredPosition)

	setParent = var_4_3

	local var_4_16 = var_4_13
	local var_4_17 = arg_4_0._tf

	var_4_3(var_4_16, var_7.Find(var_4_17, "huigui"))

	setAnchoredPosition = var_4_3

	local var_4_18 = var_4_13

	Vector2 = var_7

	var_4_3(var_4_18, var_7.zero)

	local var_4_19 = arg_4_0
	local var_4_20 = arg_4_0.InitTransformMapBtn
	local var_4_21 = arg_4_0._tf

	var_4_20(var_4_19, var_7.Find(var_4_21, "huigui"), -1, var_1:Find("mengjing_huigui_zhuangchang"))

	return
end

function var_0_1.OnShow(arg_5_0)
	var_0_1.super.OnShow(arg_5_0)

	setActive = var_1

	local var_5_0 = arg_5_0.sceneParent.mainLayer

	var_1(var_3.Find(var_5_0, "title_chapter_lines"), true)

	setActive = var_1

	local var_5_1 = arg_5_0.sceneParent.topChapter

	var_1(var_3.Find(var_5_1, "title_chapter"), true)

	setActive = var_1

	local var_5_2 = arg_5_0.sceneParent.topChapter

	var_1(var_3.Find(var_5_2, "type_skirmish"), true)

	return
end

function var_0_1.OnHide(arg_6_0)
	setActive = var_1_10001

	local var_6_0 = arg_6_0.sceneParent.mainLayer

	var_1_10001(var_3.Find(var_6_0, "title_chapter_lines"), false)

	setActive = var_1_10001

	local var_6_1 = arg_6_0.sceneParent.topChapter

	var_1_10001(var_3.Find(var_6_1, "title_chapter"), false)

	setActive = var_1_10001

	local var_6_2 = arg_6_0.sceneParent.topChapter

	var_1_10001(var_3.Find(var_6_2, "type_skirmish"), false)

	table = var_1_10001

	var_1_10001.clear(arg_6_0.chaptersInBackAnimating)

	pairs = var_1

	for iter_6_0, iter_6_1 in var_1(arg_6_0.chapterTFsById) do
		findTF = var_6_3

		local var_6_3 = var_6_3(iter_6_1, "main/info/bk")

		LeanTween = var_1_10007
		var_1_10007 = var_1_10007.cancel
		rtf = var_9

		var_1_10007(var_9(var_6_3))
	end

	var_0_1.super.OnHide(arg_6_0)

	return
end

function var_0_1.TrySwitchNextMap(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.contextData.mapIdx + arg_7_1

	getProxy = var_1_10003
	ChapterProxy = var_1_10005

	local var_7_1 = var_1_10003(var_1_10005)

	if not var_3.getMapById(var_7_1, var_7_0) then
		return
	end

	local var_7_2 = var_3:getMapType()

	Map = var_7_1

	if var_7_2 == var_7_1.ELITE and not var_3:isEliteEnabled() then
		pg = var_5

		local var_7_3 = var_5.TipsMgr.GetInstance()
		local var_7_4 = var_5.ShowTips

		i18n = var_1_10008

		var_7_4(var_7_3, var_1_10008("elite_disable_unusable"))

		return
	end

	local var_7_5 = var_3
	local var_7_6, var_7_7 = var_3.isUnlock(var_7_5)

	if not var_7_6 then
		pg = var_7_5

		local var_7_8 = var_7_5.TipsMgr.GetInstance()

		var_7.ShowTips(var_7_8, var_7_7)

		return
	end

	return true
end

function var_0_1.InitTransformMapBtn(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	onButton = var_1_10004

	var_1_10004(arg_8_0, arg_8_1, function()
		local var_9_0 = arg_8_0

		if var_0.isfrozen(var_9_0) then
			return
		end

		local var_9_1

		seriesAsync = var_2_10001

		var_2_10001({
			function(arg_10_0)
				local var_10_0 = arg_8_0

				if not var_1.TrySwitchNextMap(var_10_0, arg_8_2) then
					return
				end

				pg = var_1

				local var_10_1 = var_1.CriMgr.GetInstance()

				var_1.StopBGM(var_10_1)

				pg = var_1

				local var_10_2 = var_1.CriMgr.GetInstance()

				var_1.PlaySE_V3(var_10_2, "ui-qiehuan")

				local var_10_3 = arg_8_0._tf
				local var_10_4

				if not var_1.Find(var_10_3, arg_8_3.name .. "(Clone)") then
					Instantiate = var_10_4
					var_10_4 = var_10_4(arg_8_3)
				end

				var_9_1 = var_10_4
				setParent = var_10_4

				var_10_4(var_9_1, arg_8_0._tf)

				setAnchoredPosition = var_10_4

				local var_10_5 = var_9_1

				rtf = var_4

				var_10_4(var_10_5, var_4(arg_8_1).anchoredPosition)

				local var_10_6 = arg_8_0.contextData.mapIdx + arg_8_2

				Map = var_2

				local var_10_7 = var_2.bindConfigTable

				Map = var_4

				if var_10_7(var_4)[var_10_6] and #var_2.bg > 0 then
					GetSpriteFromAtlasAsync = var_3

					var_3("levelmap/" .. var_2.bg, "", function(arg_11_0)
						return
					end)
				end

				local var_10_8 = arg_8_0.sceneParent

				var_3.frozen(var_10_8)

				LeanTween = var_3

				local var_10_9 = var_3.delayedCall

				go = var_10_8

				local var_10_10 = var_10_8(arg_8_1)
				local var_10_11 = 2.3

				System = var_7

				var_10_9(var_10_10, var_10_11, var_7.Action(arg_10_0))

				return
			end,
			function(arg_12_0)
				local var_12_0 = arg_8_0.sceneParent

				var_1.setMap(var_12_0, arg_8_0.contextData.mapIdx + arg_8_2)

				LeanTween = var_1

				local var_12_1 = var_1.delayedCall

				go = var_12_0

				local var_12_2 = var_12_0(arg_8_1)
				local var_12_3 = 0.5

				System = var_5

				var_12_1(var_12_2, var_12_3, var_5.Action(arg_12_0))

				return
			end,
			function(arg_13_0)
				IsNil = var_3_10001

				if not var_3_10001(var_9_1) then
					Destroy = var_1

					var_1(var_9_1)
				end

				local var_13_0 = arg_8_0.sceneParent

				var_1.unfrozen(var_13_0)

				return
			end
		})

		return
	end)

	return
end

function var_0_1.UpdateView(arg_14_0)
	string = var_1_10001

	local var_14_0 = var_1_10001.split
	local var_14_1 = arg_14_0.contextData.map
	local var_14_2 = var_14_0(var_3.getConfig(var_14_1, "name"), "||")

	setText = var_1_10002

	var_1_10002(arg_14_0.sceneParent.chapterName, var_14_2[1])

	local var_14_3 = arg_14_0.contextData.map
	local var_14_4 = var_2.getMapTitleNumber(var_14_3)
	local var_14_5 = arg_14_0.sceneParent.loader

	var_3.GetSpriteQuiet(var_14_5, "chapterno", "chapter" .. var_14_4, arg_14_0.sceneParent.chapterNoTitle, true)
	var_0_1.super.UpdateView(arg_14_0)

	return
end

function var_0_1.UpdateButtons(arg_15_0)
	var_0_1.super.UpdateButtons(arg_15_0)
	arg_15_0:UpdateCustomButtons()

	return
end

function var_0_1.UpdateBonusPtIconPath(arg_16_0)
	arg_16_0.bonusPtIconPath = nil

	local var_16_0

	if not arg_16_0.data then
		var_16_0 = arg_16_0.contextData.map
	end

	if not var_16_0 then
		return
	end

	if not var_16_0:getConfig("on_activity") or var_2 == 0 then
		return
	end

	getProxy = var_1_10003
	ActivityProxy = var_5

	local var_16_1 = var_1_10003(var_5)

	if not var_3.getActivityById(var_16_1, var_2) or var_4:isEnd() then
		return
	end

	local var_16_2 = var_4

	if not var_4.GetConfigClientSetting(var_16_2, "PTID") then
		return
	end

	underscore = var_16_1

	local var_16_3 = var_16_1.detect
	local var_16_4 = var_3
	local var_16_5 = var_3.getActivitiesByType

	ActivityConst = var_1_10011

	if not var_16_3(var_16_5(var_16_4, var_1_10011.ACTIVITY_TYPE_PT_RANK), function(arg_17_0)
		return arg_17_0 and not arg_17_0:isEnd() and arg_17_0:getConfig("config_id") == var_0
	end) then
		return
	end

	tonumber = var_16_2

	local var_16_6 = var_6

	if not var_16_2(var_6.getConfig(var_16_6, "config_id")) then
		return
	end

	Drop = var_8

	local var_16_7 = var_8.New
	local var_16_8 = {}

	DROP_TYPE_RESOURCE = var_16_6
	var_16_8.type = var_16_6
	var_16_8.id = var_7

	local var_16_9 = var_16_7(var_16_8)

	arg_16_0.bonusPtIconPath = var_8.getIcon(var_16_9)

	return
end

function var_0_1.UpdateCustomButtons(arg_18_0)
	local var_18_0 = arg_18_0.contextData.map
	local var_18_1 = var_1.getConfig(var_18_0, "type")

	Map = var_1_10003

	local var_18_2 = var_18_1 == var_1_10003.ACT_EXTRA
	local var_18_3 = arg_18_0._tf
	local var_18_4 = var_4.Find(var_18_3, "rumeng")
	local var_18_5 = arg_18_0._tf
	local var_18_6 = var_5.Find(var_18_5, "huigui")

	setActive = var_18_3

	var_18_3(var_18_4, false)

	setActive = var_18_3

	var_18_3(var_18_6, false)

	if not var_18_2 then
		setActive = var_18_3

		var_18_3(arg_18_0.sceneParent.btnPrev, false)

		setActive = var_18_3

		var_18_3(arg_18_0.sceneParent.btnNext, false)

		getProxy = var_18_3
		ChapterProxy = var_8

		local var_18_7 = var_18_3(var_8)
		local var_18_8 = var_6.getMapById(var_18_7, var_1.id + 1)

		getProxy = var_18_5
		ChapterProxy = var_9

		local var_18_9 = var_18_5(var_9)
		local var_18_10 = var_7.getMapById(var_18_9, var_1.id - 1)

		setActive = var_18_7

		var_18_7(var_18_4, var_18_8)

		setActive = var_18_7

		var_18_7(var_18_6, var_18_10)

		LeanTween = var_18_7

		local var_18_11 = var_18_7.cancel

		go = var_10

		var_18_11(var_10(var_18_4), true)

		LeanTween = var_18_11

		local var_18_12 = var_18_11.cancel

		go = var_10

		var_18_12(var_10(var_18_6), true)

		if var_18_8 then
			tf = var_18_12
			var_18_12 = var_18_12(var_18_4).localScale
			tf = var_18_9

			local var_18_13 = var_18_9(var_18_4)
			local var_18_14 = var_18_9.GetChild(var_18_13, 0)
			local var_18_15 = var_18_9.Find(var_18_14, "Quad")

			var_18_9 = var_18_9.GetComponent
			typeof = var_12
			MeshRenderer = var_1_10014

			local var_18_16 = var_18_9(var_18_15, var_12(var_1_10014)).sharedMaterial
			local var_18_17 = var_18_9.GetColor(var_18_16, "_MainColor")

			Clone = var_18_15

			local var_18_18 = var_18_15(var_18_17)

			LeanTween = var_18_16

			local var_18_19 = var_18_16.value

			go = var_1_10014
			var_1_10014 = var_18_19(var_1_10014(var_18_4), 0, 1, 0.8)

			local var_18_20 = var_12.setOnUpdate

			System = var_15
			var_1_10014 = var_18_20(var_1_10014, var_15.Action_float(function(arg_19_0)
				var_18_18.a = var_18_17.a * arg_19_0

				local var_19_0 = var_18_9

				var_1.SetColor(var_19_0, "_MainColor", var_18_18)

				return
			end))

			local var_18_21 = var_12.setEase

			LeanTweenType = var_15
			var_1_10014 = var_18_21(var_1_10014, var_15.easeInCubic)

			local var_18_22 = var_12.setOnComplete

			System = var_15

			local var_18_23 = var_18_22(var_1_10014, var_15.Action(function()
				local var_20_0 = var_18_9

				var_0.SetColor(var_20_0, "_MainColor", var_18_17)

				return
			end))

			arg_18_0:RecordTween("rumengAlphaTween", var_18_23.id)
		elseif var_18_10 then
			tf = var_18_12

			local var_18_24 = var_18_12(var_18_6).localScale

			tf = var_18_9

			local var_18_25 = var_18_9(var_18_6)
			local var_18_26 = var_9.GetChild(var_18_25, 0)
			local var_18_27 = var_9.Find(var_18_26, "Quad")
			local var_18_28 = var_9.GetComponent

			typeof = var_12
			MeshRenderer = var_1_10014

			local var_18_29 = var_18_28(var_18_27, var_12(var_1_10014)).sharedMaterial
			local var_18_30 = var_9.GetColor(var_18_29, "_MainColor")

			Clone = var_18_27

			local var_18_31 = var_18_27(var_18_30)

			LeanTween = var_18_29

			local var_18_32 = var_18_29.value

			go = var_1_10014

			local var_18_33 = var_18_32(var_1_10014(var_18_6), 0, 1, 0.8)
			local var_18_34 = var_12.setOnUpdate

			System = var_15

			local var_18_35 = var_18_34(var_18_33, var_15.Action_float(function(arg_21_0)
				var_18_31.a = var_18_30.a * arg_21_0

				local var_21_0 = var_0

				var_1.SetColor(var_21_0, "_MainColor", var_18_31)

				return
			end))
			local var_18_36 = var_12.setEase

			LeanTweenType = var_15

			local var_18_37 = var_18_36(var_18_35, var_15.easeInCubic)
			local var_18_38 = var_12.setOnComplete

			System = var_15

			local var_18_39 = var_18_38(var_18_37, var_15.Action(function()
				local var_22_0 = var_0

				var_0.SetColor(var_22_0, "_MainColor", var_18_30)

				return
			end))

			arg_18_0:RecordTween("huiguiAlphaTween", var_18_39.id)
		end
	end

	return
end

function var_0_1.UpdateMapItems(arg_23_0)
	var_0_1.super.UpdateMapItems(arg_23_0)

	local var_23_0 = arg_23_0.data

	getProxy = var_1_10002
	ChapterProxy = var_1_10004

	local var_23_1 = var_1_10002(var_1_10004)

	arg_23_0:UpdateBonusPtIconPath()

	table = var_3

	var_3.clear(arg_23_0.chapterTFsById)

	local var_23_2 = {}

	pairs = var_1_10004

	for iter_23_0, iter_23_1 in var_1_10004(var_23_0:getChapters()) do
		if (iter_23_1:isUnlock() or iter_23_1:activeAlways()) and (not iter_23_1:ifNeedHide() or var_23_1:GetJustClearChapters(iter_23_1.id)) then
			table = var_9

			var_9.insert(var_23_2, iter_23_1)
		end
	end

	UIItemList = var_4

	var_4.StaticAlign(arg_23_0.itemHolder, arg_23_0.tpl, #var_23_2, function(arg_24_0, arg_24_1, arg_24_2)
		UIItemList = var_2_10003

		if arg_24_0 == var_2_10003.EventUpdate then
			local var_24_0 = var_23_2[arg_24_1 + 1]
			local var_24_1 = arg_23_0

			var_4.UpdateMapItem(var_24_1, arg_24_2, var_24_0)

			arg_24_2.name = "Chapter_" .. var_24_0.id
			arg_23_0.chapterTFsById[var_24_0.id] = arg_24_2
		end

		return
	end)

	local var_23_3 = {}

	pairs = var_5

	for iter_23_2, iter_23_3 in var_5(var_23_2) do
		local var_23_4 = iter_23_3:getConfigTable().pos_x
		local var_23_5

		if not var_23_3[var_1_10010.pos_x] then
			var_23_5 = {}
		end

		var_23_3[var_23_4] = var_23_5

		local var_23_6 = var_23_3[var_1_10010.pos_x]
		local var_23_7 = var_1_10010.pos_y
		local var_23_8

		if not var_23_6[var_1_10010.pos_y] then
			var_23_8 = {}
		end

		var_23_6[var_23_7] = var_23_8

		local var_23_9 = var_23_6[var_1_10010.pos_y]

		table = var_23_8

		var_23_8.insert(var_23_9, iter_23_3)
	end

	pairs = var_5

	for iter_23_4, iter_23_5 in var_5(var_23_3) do
		pairs = var_1_10010

		for iter_23_6, iter_23_7 in var_1_10010(iter_23_5) do
			local var_23_10 = {}

			seriesAsync = var_1_10016

			var_1_10016({
				function(arg_25_0)
					local var_25_0 = 0

					pairs = var_2_10002

					for iter_25_0, iter_25_1 in var_2_10002(iter_23_7) do
						if iter_25_1:ifNeedHide() then
							local var_25_1 = var_23_1

							if var_7.GetJustClearChapters(var_25_1, iter_25_1.id) and arg_23_0.chapterTFsById[iter_25_1.id] then
								var_25_0 = var_25_0 + 1

								local var_25_2 = arg_23_0.chapterTFsById[iter_25_1.id]

								setActive = var_8

								var_8(var_25_2, true)

								local var_25_3 = arg_23_0

								var_8.PlayChapterItemAnimationBackward(var_25_3, var_25_2, iter_25_1, function()
									var_25_0 = var_25_0 - 1
									setActive = var_0

									var_0(var_25_2, false)

									local var_26_0 = var_23_1

									var_0.RecordJustClearChapters(var_26_0, iter_25_1.id, nil)

									if var_25_0 <= 0 then
										arg_25_0()
									end

									return
								end)

								var_23_10[iter_25_1.id] = true

								goto label_25_0
							end
						end

						if arg_23_0.chapterTFsById[iter_25_1.id] then
							setActive = var_7

							var_7(arg_23_0.chapterTFsById[iter_25_1.id], false)
						end

						::label_25_0::
					end

					if var_25_0 <= 0 then
						arg_25_0()
					end

					return
				end,
				function(arg_27_0)
					local var_27_0 = 0

					pairs = var_2_10002

					for iter_27_0, iter_27_1 in var_2_10002(iter_23_7) do
						if not var_23_10[iter_27_1.id] then
							var_27_0 = var_27_0 + 1
							setActive = var_7

							var_7(arg_23_0.chapterTFsById[iter_27_1.id], true)

							local var_27_1 = arg_23_0

							var_7.PlayChapterItemAnimation(var_27_1, arg_23_0.chapterTFsById[iter_27_1.id], iter_27_1, function()
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

function var_0_1.UpdateMapItem(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_2
	local var_29_1 = arg_29_2.getConfigTable(var_29_0)

	setLocalPosition = var_1_10004

	var_1_10004(arg_29_1, {
		x = 0 * var_29_1.pos_x,
		y = 1080 * var_29_1.pos_y
	})

	findTF = var_1_10004

	local var_29_2 = var_1_10004(arg_29_1, "main")

	setActive = var_29_0

	var_29_0(var_29_2, true)

	findTF = var_29_0

	local var_29_3 = var_29_0(var_29_2, "info/bk/fordark")

	setActive = var_6

	var_6(var_29_3, var_29_1.icon_outline == 1)

	findTF = var_6

	local var_29_4 = var_6(var_29_2, "circle/clear_flag")

	findTF = var_7

	local var_29_5 = var_7(var_29_2, "circle/lock")
	local var_29_6, var_29_7

	if not arg_29_2.active then
		var_29_6 = arg_29_2
		var_29_7 = not arg_29_2.isUnlock(var_29_6)
	else
		var_29_7 = false
	end

	if false then
		var_29_7 = true
	end

	findTF = var_9

	local var_29_8 = var_9(var_29_2, "circle/progress")

	findTF = var_29_6

	local var_29_9 = var_29_6(var_29_2, "circle/progress_text")

	findTF = var_11

	local var_29_10 = var_11(var_29_2, "circle/stars")

	string = var_12

	local var_29_11 = var_12.split(var_29_1.name, "|")
	local var_29_12 = var_29_7 and "#737373" or "#FFFFFF"

	setText = var_14
	findTF = var_1_10016

	local var_29_13 = var_1_10016(var_29_2, "info/bk/title_form/title_index")

	setColorStr = var_1_10017

	var_14(var_29_13, var_1_10017(var_29_1.chapter_name .. "  ", var_29_12))

	setText = var_14
	findTF = var_29_13

	local var_29_14 = var_29_13(var_29_2, "info/bk/title_form/title")

	setColorStr = var_17

	var_14(var_29_14, var_17(var_29_11[1], var_29_12))

	setText = var_14
	findTF = var_29_14

	local var_29_15 = var_29_14(var_29_2, "info/bk/title_form/title_en")

	setColorStr = var_17

	local var_29_16

	if not var_29_11[2] then
		var_29_16 = ""
	end

	var_14(var_29_15, var_17(var_29_16, var_29_12))

	setFillAmount = var_14

	var_14(var_29_8, arg_29_2.progress / 100)

	setText = var_14

	local var_29_17 = var_29_9

	string = var_17

	var_14(var_29_17, var_17.format("%d%%", arg_29_2.progress))

	setActive = var_14

	local var_29_18 = var_29_10
	local var_29_19 = arg_29_2

	var_14(var_29_18, arg_29_2.existAchieve(var_29_19))

	local var_29_20 = arg_29_2

	if arg_29_2.existAchieve(var_29_20) then
		ipairs = var_14

		for iter_29_0, iter_29_1 in var_14(arg_29_2.achieves) do
			ChapterConst = var_29_19
			var_29_19 = var_29_19.IsAchieved(iter_29_1)

			local var_29_21 = var_29_10:Find("star" .. iter_29_0 .. "/light")

			setActive = var_21

			var_21(var_29_21, var_29_19)
		end
	end

	local var_29_22

	if not arg_29_2.active then
		var_29_20 = arg_29_2
		var_29_22 = arg_29_2.isClear(var_29_20)
	else
		var_29_22 = false
	end

	if false then
		var_29_22 = true
	end

	setActive = var_15

	var_15(var_29_4, var_29_22)

	setActive = var_15

	var_15(var_29_5, var_29_7)

	setActive = var_15

	var_15(var_29_9, not var_29_22 and not var_29_7)
	arg_29_0:DeleteTween("fighting" .. arg_29_2.id)

	findTF = var_15

	local var_29_23 = var_15(var_29_2, "circle/fighting")

	setText = var_29_20
	findTF = var_18

	local var_29_24 = var_18(var_29_23, "Text")

	i18n = var_19

	var_29_20(var_29_24, var_19("tag_level_fighting"))

	findTF = var_29_20

	local var_29_25 = var_29_20(var_29_2, "circle/oni")

	setText = var_17
	findTF = var_19

	local var_29_26 = var_19(var_29_25, "Text")

	i18n = var_20

	var_17(var_29_26, var_20("tag_level_oni"))

	findTF = var_17

	local var_29_27 = var_17(var_29_2, "circle/narrative")

	setText = var_18
	findTF = var_20

	local var_29_28 = var_20(var_29_27, "Text")

	i18n = var_21

	var_18(var_29_28, var_21("tag_level_narrative"))

	setActive = var_18

	var_18(var_29_23, false)

	setActive = var_18

	var_18(var_29_25, false)

	setActive = var_18

	var_18(var_29_27, false)

	local var_29_29
	local var_29_30

	if arg_29_2:getConfig("chapter_tag") == 1 then
		var_29_29 = var_29_27
	end

	if arg_29_2.active then
		var_29_29 = arg_29_2:existOni() and var_29_25 or var_29_23
	end

	local var_29_33

	if var_29_29 then
		setActive = var_29_33

		var_29_33(var_29_29, true)

		GetOrAddComponent = var_29_33

		local var_29_31 = var_29_33(var_29_29, "CanvasGroup")

		var_29_31.alpha = 1

		local var_29_32 = arg_29_0

		var_29_33 = arg_29_0.RecordTween

		local var_29_34 = "fighting" .. arg_29_2.id

		LeanTween = var_24

		local var_29_35 = var_24.alphaCanvas(var_29_31, 0, 0.5)
		local var_29_36 = var_24.setFrom(var_29_35, 1)
		local var_29_37 = var_24.setEase

		LeanTweenType = var_1_10027

		local var_29_38 = var_29_37(var_29_36, var_1_10027.easeInOutSine)

		var_29_33(var_29_32, var_29_34, var_24.setLoopPingPong(var_29_38).uniqueId)
	end

	findTF = var_29_33

	local var_29_39 = var_29_33(var_29_2, "triesLimit")

	setActive = var_21

	var_21(var_29_39, false)

	local var_29_40 = arg_29_2

	if arg_29_2.isTriesLimit(var_29_40) then
		var_29_40 = arg_29_2:getConfig("count") - arg_29_2:getTodayDefeatCount() .. "/" .. var_22
		setText = var_24

		local var_29_41 = var_29_39:Find("label")

		i18n = var_1_10027

		var_24(var_29_41, var_1_10027("levelScene_chapter_count_tip"))

		setText = var_24

		local var_29_42 = var_29_39:Find("Text")

		setColorStr = var_27

		local var_29_43 = var_29_40

		var_1_10032 = arg_29_2

		if var_22 <= arg_29_2.getTodayDefeatCount(var_1_10032) then
			COLOR_RED = var_30

			if not var_30 then
				COLOR_GREEN = var_30
			end

			var_24(var_29_42, var_27(var_29_43, var_30))

			local var_29_44 = arg_29_2:GetDailyBonusQuota()

			findTF = var_29_40

			local var_29_45 = var_29_40(var_29_2, "mark")
			local var_29_46 = var_23.Find(var_29_45, "bonus")
			local var_29_47 = var_24.Find(var_29_46, "icon")

			findTF = var_29_45

			local var_29_48 = var_29_45(var_24, "icon/Image")

			setActive = var_29_46

			var_29_46(var_24, var_29_44)

			setActive = var_29_46

			var_29_46(var_23, var_29_44)

			local var_29_50

			if var_29_47 then
				setActive = var_29_46

				local var_29_49 = var_29_47

				var_29_50 = var_29_44 and arg_29_0.bonusPtIconPath

				var_29_46(var_29_49, var_29_50)
			end

			local var_29_54

			if var_29_44 then
				local var_29_51 = var_23
				local var_29_52 = var_23.GetComponent

				typeof = var_29_50
				CanvasGroup = var_1_10032

				local var_29_53 = var_29_52(var_29_51, var_29_50(var_1_10032))

				var_29_54 = arg_29_2:GetDailyBonusIconName()

				local var_29_55 = arg_29_0.sceneParent.loader

				var_29.GetSprite(var_29_55, "ui/levelmainscene_atlas", var_29_54, var_24)

				if var_29_47 and arg_29_0.bonusPtIconPath then
					if var_29_48 then
						GetImageSpriteFromAtlasAsync = var_29

						var_29(arg_29_0.bonusPtIconPath, "", var_29_48, true)
					else
						GetImageSpriteFromAtlasAsync = var_29

						var_29(arg_29_0.bonusPtIconPath, "", var_29_47, true)
					end
				end

				LeanTween = var_29

				local var_29_56 = var_29.cancel

				go = var_29_55

				var_29_56(var_29_55(var_23), true)

				local var_29_57 = var_23.anchoredPosition.y

				var_29_53.alpha = 0
				LeanTween = var_30

				local var_29_58 = var_30.value

				go = var_32

				local var_29_59 = var_29_58(var_32(var_23), 0, 1, 0.2)
				local var_29_60 = var_30.setOnUpdate

				System = var_1_10033

				local var_29_61 = var_29_60(var_29_59, var_1_10033.Action_float(function(arg_30_0)
					var_29_53.alpha = arg_30_0

					local var_30_0 = var_0.anchoredPosition

					var_30_0.y = var_29_57 * arg_30_0
					var_0.anchoredPosition = var_30_0

					return
				end))
				local var_29_62 = var_30.setOnComplete

				System = var_1_10033

				local var_29_63 = var_29_62(var_29_61, var_1_10033.Action(function()
					var_29_53.alpha = 1

					local var_31_0 = var_0.anchoredPosition

					var_31_0.y = var_29_57
					var_0.anchoredPosition = var_31_0

					return
				end))
				local var_29_64 = var_30.setEase

				LeanTweenType = var_1_10033

				local var_29_65 = var_29_64(var_29_63, var_1_10033.easeOutSine)

				var_30.setDelay(var_29_65, 0.7)
			end

			local var_29_66 = arg_29_2.id

			onButton = var_29_54

			local var_29_67 = arg_29_0
			local var_29_68 = var_29_2

			local function var_29_69()
				if arg_29_0.chaptersInBackAnimating[var_29_66] then
					return
				end

				local var_32_0 = arg_29_1.localPosition
				local var_32_1 = arg_29_0
				local var_32_2 = var_1.TryOpenChapterInfo
				local var_32_3 = var_29_66

				Vector3 = var_2_10005

				var_32_2(var_32_1, var_32_3, var_2_10005(var_32_0.x - 10, var_32_0.y + 22))

				return
			end

			SFX_UI_WEIGHANCHOR_SELECT = var_1_10033

			var_29_54(var_29_67, var_29_68, var_29_69, var_1_10033)

			return
		end
	end
end

function var_0_1.PlayChapterItemAnimation(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	findTF = var_1_10004

	local var_33_0 = var_1_10004(arg_33_1, "main")
	local var_33_1 = var_4.Find(var_33_0, "info")

	findTF = var_6

	local var_33_2 = var_6(var_4, "circle")

	findTF = var_33_0

	local var_33_3 = var_33_0(var_4, "info/bk")

	LeanTween = var_8

	local var_33_4 = var_8.cancel

	go = var_10

	var_33_4(var_10(var_33_2))

	Vector3 = var_33_4
	var_33_2.localScale = var_33_4.zero
	LeanTween = var_8

	local var_33_5 = var_8.scale
	local var_33_6 = var_33_2

	Vector3 = var_1_10011

	local var_33_7 = var_33_5(var_33_6, var_1_10011.one, 0.3)
	local var_33_8 = var_8.setDelay(var_33_7, 0.3)
	local var_33_9 = arg_33_0

	arg_33_0.RecordTween(var_33_9, var_33_8.uniqueId)

	LeanTween = var_9

	local var_33_10 = var_9.cancel

	go = var_33_9

	var_33_10(var_33_9(var_33_3))

	setAnchoredPosition = var_33_10

	var_33_10(var_33_3, {
		x = -1 * var_33_1.rect.width
	})

	shiftPanel = var_33_10

	var_33_10(var_33_3, 0, nil, 0.4, 0.4, true, true, nil, function()
		local var_34_0 = arg_33_2

		if var_0.isTriesLimit(var_34_0) then
			setActive = var_0
			findTF = var_34_0

			var_0(var_34_0(var_0, "triesLimit"), true)
		end

		if arg_33_3 then
			arg_33_3()
		end

		return
	end)

	return
end

function var_0_1.PlayChapterItemAnimationBackward(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	findTF = var_1_10004

	local var_35_0 = var_1_10004(arg_35_1, "main")
	local var_35_1 = var_4.Find(var_35_0, "info")

	findTF = var_6

	local var_35_2 = var_6(var_4, "circle")

	findTF = var_35_0

	local var_35_3 = var_35_0(var_4, "info/bk")

	LeanTween = var_8

	local var_35_4 = var_8.cancel

	go = var_10

	var_35_4(var_10(var_35_2))

	Vector3 = var_35_4
	var_35_2.localScale = var_35_4.one
	LeanTween = var_8

	local var_35_5 = var_8.scale

	go = var_10

	local var_35_6 = var_10(var_35_2)

	Vector3 = var_1_10011

	local var_35_7 = var_35_5(var_35_6, var_1_10011.zero, 0.3)
	local var_35_8 = var_8.setDelay(var_35_7, 0.3)

	arg_35_0:RecordTween(var_35_8.uniqueId)

	local var_35_9 = arg_35_0.chaptersInBackAnimating

	var_35_9[arg_35_2.id] = true
	LeanTween = var_35_9

	local var_35_10 = var_35_9.cancel

	go = var_11

	var_35_10(var_11(var_35_3))

	setAnchoredPosition = var_35_10

	var_35_10(var_35_3, {
		x = 0
	})

	shiftPanel = var_35_10

	var_35_10(var_35_3, -1 * var_35_1.rect.width, nil, 0.4, 0.4, true, true, nil, function()
		arg_35_0.chaptersInBackAnimating[arg_35_2.id] = nil

		if arg_35_3 then
			arg_35_3()
		end

		return
	end)

	local var_35_11 = arg_35_2

	if arg_35_2.isTriesLimit(var_35_11) then
		setActive = var_9
		findTF = var_35_11

		var_9(var_35_11(var_4, "triesLimit"), false)
	end

	return
end

function var_0_1.UpdateChapterTF(arg_37_0, arg_37_1)
	if arg_37_0.chapterTFsById[arg_37_1] then
		getProxy = var_1_10003
		ChapterProxy = var_1_10005

		local var_37_0 = var_1_10003(var_1_10005)
		local var_37_1 = var_3.getChapterById(var_37_0, arg_37_1)

		arg_37_0:UpdateMapItem(var_2, var_37_1)
		arg_37_0:PlayChapterItemAnimation(var_2, var_37_1)
	end

	return
end

function var_0_1.TryOpenChapter(arg_38_0, arg_38_1)
	if arg_38_0.chapterTFsById[arg_38_1] then
		local var_38_0 = var_2:Find("main")

		triggerButton = var_1_10004

		var_1_10004(var_38_0)
	end

	return
end

function var_0_1.HideFloat(arg_39_0)
	setActive = var_1_10001

	var_1_10001(arg_39_0.itemHolder, false)

	return
end

function var_0_1.ShowFloat(arg_40_0)
	setActive = var_1_10001

	var_1_10001(arg_40_0.itemHolder, true)

	return
end

return var_0_1
