local var_0_0 = class("LevelInfoSPView", import(".LevelInfoView"))

function var_0_0.getUIName(arg_1_0)
	return "LevelInfoSPUI"
end

function var_0_0.InitUI(arg_2_0)
	var_0_0.super.InitUI(arg_2_0)

	arg_2_0.levelBanner = arg_2_0._tf:Find("panel/Level")
	arg_2_0.btnSwitchNormal = arg_2_0._tf:Find("panel/Difficulty/Normal")
	arg_2_0.btnSwitchHard = arg_2_0._tf:Find("panel/Difficulty/Hard")
	arg_2_0.tfAnim = arg_2_0._tf:GetComponent(typeof(Animation))
	arg_2_0.tfAniEvent = arg_2_0._tf:GetComponent(typeof(DftAniEvent))

	arg_2_0.tfAniEvent:SetEndEvent(function()
		arg_2_0:playSelectFX()

		return
	end)

	arg_2_0.diffBtn = arg_2_0._tf:Find("panel/Difficulty")
	arg_2_0.btnAnim = arg_2_0._tf:Find("panel/Difficulty"):GetComponent(typeof(Animation))
	arg_2_0.btnAniEvent = arg_2_0._tf:Find("panel/Difficulty"):GetComponent(typeof(DftAniEvent))

	arg_2_0.btnAniEvent:SetEndEvent(function()
		arg_2_0:playButtonLoopFX()

		return
	end)

	arg_2_0.btnAnimNormal = arg_2_0._tf:Find("panel/Difficulty/Mask_Normal")
	arg_2_0.btnAnimHard = arg_2_0._tf:Find("panel/Difficulty/Mask_Difficlty")
	arg_2_0.btnAnimLoopNormal = arg_2_0._tf:Find("panel/Difficulty/Normal/Mask_Normal_Loop/Image")
	arg_2_0.btnAnimLoopHard = arg_2_0._tf:Find("panel/Difficulty/Hard/Mask_Difficulty_Loop")
	arg_2_0.doEaseIn = false

	return
end

function var_0_0.playSelectFX(arg_5_0)
	local var_5_0 = 1

	if #arg_5_0.groupInfo > 1 then
		var_5_0 = table.indexof(arg_5_0.groupInfo, arg_5_0.chapter.id)
	elseif arg_5_0.chapter:IsSpChapter() or arg_5_0.chapter:IsEXChapter() then
		var_5_0 = 2
	end

	if #arg_5_0.groupInfo > 1 then
		if var_5_0 == 2 then
			setActive(arg_5_0.btnAnimNormal, false)
			setActive(arg_5_0.btnAnimLoopNormal, false)
			quickPlayAnimation(arg_5_0.diffBtn, "Anim_LevelInfoSPUI_DifficultySelected")
		else
			setActive(arg_5_0.btnAnimHard, false)
			setActive(arg_5_0.btnAnimLoopHard, false)
			quickPlayAnimation(arg_5_0.diffBtn, "Anim_LevelInfoSPUI_NormalSelected")
		end
	end

	return
end

function var_0_0.playButtonLoopFX(arg_6_0)
	if arg_6_0.btnAnim:IsPlaying("Anim_LevelInfoSPUI_DifficultySelected") then
		quickPlayAnimation(arg_6_0.diffBtn, "Anim_LevelInfoSPUI_DifficultyInLoop")
	elseif arg_6_0.btnAnim:IsPlaying("Anim_LevelInfoSPUI_NormalSelected") then
		quickPlayAnimation(arg_6_0.diffBtn, "Anim_LevelInfoSPUI_NormalInLoop")
	end

	return
end

function var_0_0.SetChapterGroupInfo(arg_7_0, arg_7_1)
	arg_7_0.groupInfo = arg_7_1

	return
end

function var_0_0.Show(arg_8_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_8_0._tf, {
		force = true
	})
	setActive(arg_8_0._tf, true)
	quickPlayAnimation(arg_8_0._tf, "Anim_LevelInfoSPUI_in")

	return
end

function var_0_0.set(arg_9_0, arg_9_1, arg_9_2)
	var_0_0.super.set(arg_9_0, arg_9_1, arg_9_2)

	local var_9_0 = getProxy(ChapterProxy):getChapterById(arg_9_1, true)
	local var_9_1 = arg_9_0.groupInfo

	assert(arg_9_0.groupInfo)

	local var_9_2 = {
		"Normal",
		"Hard"
	}
	local var_9_3 = 1
	local var_9_4

	if #var_9_1 > 1 then
		local var_9_5 = table.indexof(var_9_1, arg_9_1)

		var_9_3 = var_9_5
		var_9_4 = var_9_1[#var_9_1 - var_9_5 + 1]
	elseif var_9_0:IsSpChapter() or var_9_0:IsEXChapter() then
		var_9_3 = 2
	end

	for iter_9_0, iter_9_1 in ipairs(var_9_2) do
		setActive(arg_9_0.titleBG:Find(iter_9_1), iter_9_0 == var_9_3)
	end

	for iter_9_2, iter_9_3 in ipairs(var_9_2) do
		setActive(arg_9_0.levelBanner:Find(iter_9_3), iter_9_2 == var_9_3)
	end

	setActive(arg_9_0.btnSwitchNormal, #var_9_1 > 1 and var_9_3 == 1)
	setActive(arg_9_0.btnSwitchHard, #var_9_1 > 1 and var_9_3 == 2)

	if #var_9_1 > 1 then
		if var_9_3 == 1 then
			for iter_9_4 = 1, 2 do
				local var_9_7 = var_9_6:Find("Bonus" .. iter_9_4)
				local var_9_8 = getProxy(ChapterProxy):getChapterById(var_9_1[iter_9_4], true)
				local var_9_9 = var_9_8:GetDailyBonusQuota()

				setActive(var_9_7, var_9_9)

				if var_9_9 then
					local var_9_10 = getProxy(ChapterProxy):getMapById(var_9_8:getConfig("map"))

					arg_9_0.loader:GetSprite("ui/levelmainscene_atlas", var_9_10:getConfig("type") == Map.ACTIVITY_HARD and "bonus_us_hard" or "bonus_us", var_9_7:Find("Image"))
				end
			end

			local var_9_11 = var_9_3 == 1 and Color.NewHex("FFDE38") or Color.white

			setTextColor(arg_9_0.txTitle:Find("title_index"), var_9_11)
			setTextColor(arg_9_0.txTitle:Find("title"), var_9_11)
			setTextColor(arg_9_0.txTitle:Find("title_en"), var_9_11)

			local var_9_12 = var_9_0:getConfig("boss_expedition_id")

			if var_9_0:getPlayType() == ChapterConst.TypeMultiStageBoss then
				var_9_12 = pg.chapter_model_multistageboss[var_9_0.id].boss_expedition_id
			end

			setText(arg_9_0.levelBanner:Find("Text"), "LV " .. pg.expedition_data_template[var_9_12[#var_9_12]].level)
			onButton(arg_9_0, arg_9_0.btnSwitchNormal:Find("Switch"), function()
				setActive(arg_9_0.btnAnimNormal, false)
				setActive(arg_9_0.btnAnimLoopNormal, false)
				quickPlayAnimation(arg_9_0.diffBtn, "Anim_LevelInfoSPUI_DifficultySelected")
				arg_9_0:emit(LevelUIConst.SWITCH_SPCHAPTER_DIFFICULTY, var_9_4)
				arg_9_0:set(var_9_4)

				return
			end, SFX_PANEL)
			onButton(arg_9_0, arg_9_0.btnSwitchHard:Find("Switch"), function()
				setActive(arg_9_0.btnAnimHard, false)
				setActive(arg_9_0.btnAnimLoopHard, false)
				quickPlayAnimation(arg_9_0.diffBtn, "Anim_LevelInfoSPUI_NormalSelected")
				arg_9_0:emit(LevelUIConst.SWITCH_SPCHAPTER_DIFFICULTY, var_9_4)
				arg_9_0:set(var_9_4)

				return
			end, SFX_PANEL)
			;(function()
				if IsUnityEditor and not ENABLE_GUIDE then
					return
				end

				if var_9_3 ~= 1 or #var_9_1 == 1 then
					return
				end

				local var_12_0 = "NG0045"

				if pg.NewStoryMgr.GetInstance():IsPlayed("NG0045") then
					return
				end

				pg.SystemGuideMgr.GetInstance():PlayByGuideId(var_12_0)

				return
			end)()

			return
		end
	end
end

return var_0_0
