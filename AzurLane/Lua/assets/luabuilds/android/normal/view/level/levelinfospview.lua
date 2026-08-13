class = var_0_10000

local var_0_0 = "LevelInfoSPView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".LevelInfoView"))

function var_0_1.getUIName(arg_1_0)
	return "LevelInfoSPUI"
end

function var_0_1.InitUI(arg_2_0)
	var_0_1.super.InitUI(arg_2_0)

	local var_2_0 = arg_2_0._tf

	arg_2_0.levelBanner = var_1.Find(var_2_0, "panel/Level")

	local var_2_1 = arg_2_0._tf

	arg_2_0.btnSwitchNormal = var_1.Find(var_2_1, "panel/Difficulty/Normal")

	local var_2_2 = arg_2_0._tf

	arg_2_0.btnSwitchHard = var_1.Find(var_2_2, "panel/Difficulty/Hard")

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.GetComponent

	typeof = var_3
	Animation = var_1_10004
	arg_2_0.tfAnim = var_2_4(var_2_3, var_3(var_1_10004))

	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_1_10004
	arg_2_0.tfAniEvent = var_2_6(var_2_5, var_3(var_1_10004))

	local var_2_7 = arg_2_0.tfAniEvent

	var_1.SetEndEvent(var_2_7, function()
		local var_3_0 = arg_2_0

		var_0.playSelectFX(var_3_0)

		return
	end)

	local var_2_8 = arg_2_0._tf

	arg_2_0.diffBtn = var_1.Find(var_2_8, "panel/Difficulty")

	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_1.Find(var_2_9, "panel/Difficulty")
	local var_2_11 = var_1.GetComponent

	typeof = var_3
	Animation = var_1_10004
	arg_2_0.btnAnim = var_2_11(var_2_10, var_3(var_1_10004))

	local var_2_12 = arg_2_0._tf
	local var_2_13 = var_1.Find(var_2_12, "panel/Difficulty")
	local var_2_14 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_1_10004
	arg_2_0.btnAniEvent = var_2_14(var_2_13, var_3(var_1_10004))

	local var_2_15 = arg_2_0.btnAniEvent

	var_1.SetEndEvent(var_2_15, function()
		local var_4_0 = arg_2_0

		var_0.playButtonLoopFX(var_4_0)

		return
	end)

	local var_2_16 = arg_2_0._tf

	arg_2_0.btnAnimNormal = var_1.Find(var_2_16, "panel/Difficulty/Mask_Normal")

	local var_2_17 = arg_2_0._tf

	arg_2_0.btnAnimHard = var_1.Find(var_2_17, "panel/Difficulty/Mask_Difficlty")

	local var_2_18 = arg_2_0._tf

	arg_2_0.btnAnimLoopNormal = var_1.Find(var_2_18, "panel/Difficulty/Normal/Mask_Normal_Loop/Image")

	local var_2_19 = arg_2_0._tf

	arg_2_0.btnAnimLoopHard = var_1.Find(var_2_19, "panel/Difficulty/Hard/Mask_Difficulty_Loop")
	arg_2_0.doEaseIn = false

	return
end

function var_0_1.playSelectFX(arg_5_0)
	local var_5_0 = 1

	if #arg_5_0.groupInfo > 1 then
		table = var_2
		var_5_0 = var_2.indexof(arg_5_0.groupInfo, arg_5_0.chapter.id)

		goto label_5_0
	end

	local var_5_1 = arg_5_0.chapter

	if not var_2.IsSpChapter(var_5_1) then
		do
			local var_5_2 = arg_5_0.chapter

			if var_2.IsEXChapter(var_5_2) then
				var_5_0 = 2
			end
		end

		::label_5_0::

		if #arg_5_0.groupInfo > 1 then
			if var_5_0 == 2 then
				setActive = var_2

				var_2(arg_5_0.btnAnimNormal, false)

				setActive = var_2

				var_2(arg_5_0.btnAnimLoopNormal, false)

				quickPlayAnimation = var_2

				var_2(arg_5_0.diffBtn, "Anim_LevelInfoSPUI_DifficultySelected")
			else
				setActive = var_2

				var_2(arg_5_0.btnAnimHard, false)

				setActive = var_2

				var_2(arg_5_0.btnAnimLoopHard, false)

				quickPlayAnimation = var_2

				var_2(arg_5_0.diffBtn, "Anim_LevelInfoSPUI_NormalSelected")
			end
		end

		return
	end
end

function var_0_1.playButtonLoopFX(arg_6_0)
	local var_6_0 = arg_6_0.btnAnim

	if var_1.IsPlaying(var_6_0, "Anim_LevelInfoSPUI_DifficultySelected") then
		quickPlayAnimation = var_1

		var_1(arg_6_0.diffBtn, "Anim_LevelInfoSPUI_DifficultyInLoop")
	else
		local var_6_1 = arg_6_0.btnAnim

		if var_1.IsPlaying(var_6_1, "Anim_LevelInfoSPUI_NormalSelected") then
			quickPlayAnimation = var_1

			var_1(arg_6_0.diffBtn, "Anim_LevelInfoSPUI_NormalInLoop")
		end
	end

	return
end

function var_0_1.SetChapterGroupInfo(arg_7_0, arg_7_1)
	arg_7_0.groupInfo = arg_7_1

	return
end

function var_0_1.Show(arg_8_0)
	pg = var_1_10001

	local var_8_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_8_0, arg_8_0._tf, {
		force = true
	})

	setActive = var_1

	var_1(arg_8_0._tf, true)

	quickPlayAnimation = var_1

	var_1(arg_8_0._tf, "Anim_LevelInfoSPUI_in")

	return
end

function var_0_1.set(arg_9_0, arg_9_1, arg_9_2)
	var_0_1.super.set(arg_9_0, arg_9_1, arg_9_2)

	getProxy = var_3
	ChapterProxy = var_4

	local var_9_0 = var_3(var_4)
	local var_9_1 = var_3.getChapterById(var_9_0, arg_9_1, true)
	local var_9_2 = arg_9_0.groupInfo

	assert = var_5

	var_5(var_9_2)

	local var_9_3 = {
		"Normal",
		"Hard"
	}
	local var_9_4 = 1
	local var_9_5

	if #var_9_2 > 1 then
		table = var_8
		var_9_4 = var_8.indexof(var_9_2, arg_9_1)
		var_9_5 = var_9_2[#var_9_2 - var_8 + 1]
	elseif var_9_1:IsSpChapter() or var_9_1:IsEXChapter() then
		var_9_4 = 2
	end

	ipairs = var_8

	for iter_9_0, iter_9_1 in var_8(var_9_3) do
		setActive = var_1_10013

		local var_9_6 = arg_9_0.titleBG

		var_1_10013(var_14.Find(var_9_6, iter_9_1), iter_9_0 == var_9_4)
	end

	ipairs = var_8

	for iter_9_2, iter_9_3 in var_8(var_9_3) do
		setActive = var_1_10013

		local var_9_7 = arg_9_0.levelBanner

		var_1_10013(var_14.Find(var_9_7, iter_9_3), iter_9_2 == var_9_4)
	end

	setActive = var_8

	var_8(arg_9_0.btnSwitchNormal, #var_9_2 > 1 and var_9_4 == 1)

	setActive = var_8

	var_8(arg_9_0.btnSwitchHard, #var_9_2 > 1 and var_9_4 == 2)

	local var_9_8 = #var_9_2

	if 1 < var_9_8 then
		if var_9_4 ~= 1 or not arg_9_0.btnSwitchNormal then
			var_9_8 = arg_9_0.btnSwitchHard
		end

		for iter_9_4 = 1, 2 do
			local var_9_9 = var_9_8
			local var_9_10 = var_9_8.Find(var_9_9, "Bonus" .. iter_9_4)

			getProxy = var_9_9
			ChapterProxy = var_15

			local var_9_11 = var_9_9(var_15)
			local var_9_12 = var_14.getChapterById(var_9_11, var_9_2[iter_9_4], true)
			local var_9_13 = var_14.GetDailyBonusQuota(var_9_12)

			setActive = var_9_12

			var_9_12(var_9_10, var_9_13)

			if var_9_13 then
				getProxy = var_9_12
				ChapterProxy = var_17

				local var_9_14 = var_9_12(var_17)
				local var_9_15 = var_16.getMapById(var_9_14, var_14:getConfig("map"))
				local var_9_16 = var_16.getConfig(var_9_15, "type")

				Map = var_9_15

				local var_9_17 = var_9_16 == var_9_15.ACTIVITY_HARD and "bonus_us_hard" or "bonus_us"
				local var_9_18 = arg_9_0.loader

				var_19.GetSprite(var_9_18, "ui/levelmainscene_atlas", var_9_17, var_9_10:Find("Image"))
			end
		end
	end

	if var_9_4 == 1 then
		Color = var_9_8

		if not var_9_8.NewHex("FFDE38") then
			Color = var_9_8
			var_9_8 = var_9_8.white
		end

		setTextColor = var_9

		local var_9_19 = arg_9_0.txTitle

		var_9(var_10.Find(var_9_19, "title_index"), var_9_8)

		setTextColor = var_9

		local var_9_20 = arg_9_0.txTitle

		var_9(var_10.Find(var_9_20, "title"), var_9_8)

		setTextColor = var_9

		local var_9_21 = arg_9_0.txTitle

		var_9(var_10.Find(var_9_21, "title_en"), var_9_8)

		local var_9_22 = var_9_1:getConfig("boss_expedition_id")
		local var_9_23 = var_9_1
		local var_9_24 = var_9_1.getPlayType(var_9_23)

		ChapterConst = var_9_23

		if var_9_24 == var_9_23.TypeMultiStageBoss then
			pg = var_9_24
			var_9_22 = var_9_24.chapter_model_multistageboss[var_9_1.id].boss_expedition_id
		end

		pg = var_9_24

		local var_9_25 = var_9_24.expedition_data_template[var_9_22[#var_9_22]].level

		setText = var_11

		local var_9_26 = arg_9_0.levelBanner

		var_11(var_12.Find(var_9_26, "Text"), "LV " .. var_9_25)

		onButton = var_11

		local var_9_27 = arg_9_0
		local var_9_28 = arg_9_0.btnSwitchNormal
		local var_9_29 = var_13.Find(var_9_28, "Switch")

		local function var_9_30()
			setActive = var_2_10000

			var_2_10000(arg_9_0.btnAnimNormal, false)

			setActive = var_2_10000

			var_2_10000(arg_9_0.btnAnimLoopNormal, false)

			quickPlayAnimation = var_2_10000

			var_2_10000(arg_9_0.diffBtn, "Anim_LevelInfoSPUI_DifficultySelected")

			local var_10_0 = arg_9_0
			local var_10_1 = var_0.emit

			LevelUIConst = var_2

			var_10_1(var_10_0, var_2.SWITCH_SPCHAPTER_DIFFICULTY, var_9_5)

			local var_10_2 = arg_9_0

			var_0.set(var_10_2, var_9_5)

			return
		end

		SFX_PANEL = var_15

		var_11(var_9_27, var_9_29, var_9_30, var_15)

		onButton = var_11

		local var_9_31 = arg_9_0
		local var_9_32 = arg_9_0.btnSwitchHard
		local var_9_33 = var_13.Find(var_9_32, "Switch")

		local function var_9_34()
			setActive = var_2_10000

			var_2_10000(arg_9_0.btnAnimHard, false)

			setActive = var_2_10000

			var_2_10000(arg_9_0.btnAnimLoopHard, false)

			quickPlayAnimation = var_2_10000

			var_2_10000(arg_9_0.diffBtn, "Anim_LevelInfoSPUI_NormalSelected")

			local var_11_0 = arg_9_0
			local var_11_1 = var_0.emit

			LevelUIConst = var_2

			var_11_1(var_11_0, var_2.SWITCH_SPCHAPTER_DIFFICULTY, var_9_5)

			local var_11_2 = arg_9_0

			var_0.set(var_11_2, var_9_5)

			return
		end

		SFX_PANEL = var_15

		var_11(var_9_31, var_9_33, var_9_34, var_15)
		;(function()
			IsUnityEditor = var_2_10000

			if var_2_10000 then
				ENABLE_GUIDE = var_2_10000

				if not var_2_10000 then
					return
				end
			end

			if var_9_4 ~= 1 or #var_9_2 == 1 then
				return
			end

			local var_12_0 = "NG0045"

			pg = var_2_10001

			local var_12_1 = var_2_10001.NewStoryMgr.GetInstance()

			if var_1.IsPlayed(var_12_1, var_12_0) then
				return
			end

			pg = var_1

			local var_12_2 = var_1.SystemGuideMgr.GetInstance()

			var_1.PlayByGuideId(var_12_2, var_12_0)

			return
		end)()

		return
	end
end

return var_0_1
