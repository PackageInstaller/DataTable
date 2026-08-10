local var_0_0 = class("EnternalMusicSettlementView", ReduxView)

function var_0_0.UIName(arg_1_0)
	local var_1_0 = MusicData:GetNowMusicUINameList()

	if var_1_0 and var_1_0.scoreView then
		return var_1_0.scoreView
	else
		return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionMusicUI/MusicScoreUI"
	end
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Cacheable(arg_3_0)
	return false
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.difficultController_ = ControllerUtil.GetController(arg_5_0.transform_, "difficult")
	arg_5_0.gradeController_ = ControllerUtil.GetController(arg_5_0.transform_, "grade")
	arg_5_0.newController_ = ControllerUtil.GetController(arg_5_0.transform_, "new")
	arg_5_0.evaluateController_ = ControllerUtil.GetController(arg_5_0.transform_, "evaluate")
	arg_5_0.linkTagController_ = arg_5_0.controller_:GetController("linkTag")
	arg_5_0.specialController_ = arg_5_0.controller_:GetController("specialMode")
	arg_5_0.ratingTipsList = {}

	for iter_5_0 = 0, arg_5_0.ratingTrs_.childCount - 1 do
		table.insert(arg_5_0.ratingTipsList, arg_5_0.ratingTrs_:GetChild(iter_5_0):GetComponent("TipsAudio"))
	end
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.m_restartBtn, nil, function()
		local var_7_0 = MusicData:GetGameId()
		local var_7_1 = ActivityMusicCfg[var_7_0]

		if var_7_1 then
			SDKTools.SendMessageToSDK("activity_music_start", {
				is_restart = false,
				activity_id = var_7_1.activity_id,
				difficulty_id = var_7_1.difficult,
				other_data = MusicData:GetSpectralAndVercialSDKKey()
			})
		end

		MusicLuaBridge.ReStartMusicGame()
		arg_6_0:Back()
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_backBtn, nil, function()
		local var_8_0 = MusicData:GetGameId()
		local var_8_1 = ActivityMusicCfg[var_8_0].activity_id
		local var_8_2 = MusicData:GetMusicViewPathList(var_8_1)
		local var_8_3 = MusicData:GetPageActivityID()

		DestroyLua()

		if ActivityTools.GetActivityTheme(var_8_3) == ActivityConst.THEME.ACTIVITY_3_11 then
			LaunchQWorld(true)
		else
			LuaExchangeHelper.GoToMain()
			OpenPageUntilLoaded(var_8_2.musicMain, {
				activity_id = var_8_2.activityID
			})
		end
	end)
end

function var_0_0.OnTop(arg_9_0)
	return
end

function var_0_0.AddSpecialTimer(arg_10_0)
	if arg_10_0.specialTimer_ then
		arg_10_0.specialTimer_:Stop()

		arg_10_0.specialTimer_ = nil
	end

	arg_10_0.specialController_:SetSelectedState("black")

	arg_10_0.specialTimer_ = Timer.New(function()
		arg_10_0.specialController_:SetSelectedState("normal")
		arg_10_0.specialAni_:Play("UI_Acitvity_MusicGameUI_special_xs", 0, 0)
		arg_10_0.specialAni_:Update(0)
	end, 0.85)

	arg_10_0.specialTimer_:Start()
end

function var_0_0.OnEnter(arg_12_0)
	if arg_12_0.params_.isSpecialPerformance or false then
		SetActive(arg_12_0.specialObj_, true)
		arg_12_0.ani_:Play("XH1stMusicScoreUI", 0, 1)
		arg_12_0.ani_:Update(0)
		arg_12_0.specialAni_:Play("UI_Acitvity_MusicGameUI_special", 0, 1)
		arg_12_0.specialAni_:Update(0)
		arg_12_0.specialTxt1Ani_:Play("UI_text_xs", 0, 0)
		arg_12_0.specialTxt2Ani_:Play("UI_text_xs", 0, 0)
		arg_12_0:AddSpecialTimer()
	else
		SetActive(arg_12_0.specialObj_, false)
		arg_12_0.specialController_:SetSelectedState("normal")
		manager.audio:Play("effect", "minigame_activity_2_0", "minigame_activity_2_0_musicgame_icon")
	end

	arg_12_0:RefreshUI()

	arg_12_0.params_.isSpecialPerformance = nil
end

function var_0_0.RefreshUI(arg_13_0)
	local var_13_0 = MusicData:GetGameId()
	local var_13_1 = ActivityMusicCfg[var_13_0]

	arg_13_0.m_name.text = GetI18NText(var_13_1.name)
	arg_13_0.m_bg.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Music/Music_icon/" .. var_13_1.icon)
	arg_13_0.bgImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Music/Music1_icon/" .. var_13_1.icon)

	if var_13_1.difficult == 1 then
		arg_13_0.difficultController_:SetSelectedIndex(0)
	elseif var_13_1.difficult == 2 then
		arg_13_0.difficultController_:SetSelectedIndex(1)
	elseif var_13_1.difficult == 9 then
		arg_13_0.difficultController_:SetSelectedIndex(2)

		arg_13_0.keyText_.text = string.format(GetTips("ACTIVITY_MUSIC_SETTING_KEY"), var_13_1.track)
	else
		arg_13_0.difficultController_:SetSelectedIndex(3)
	end

	arg_13_0.linkTagController_:SetSelectedIndex(var_13_1.tagType)

	local var_13_2 = MusicData:GetTagImagePath(var_13_1.id)

	if var_13_2 then
		arg_13_0.linkImg_.sprite = getSpriteWithoutAtlas(var_13_2)
	end

	local var_13_3 = arg_13_0.params_.cur
	local var_13_4 = arg_13_0.params_.max

	arg_13_0.m_curScoreLab.text = var_13_3
	arg_13_0.m_maxScoreLab.text = var_13_4

	local var_13_5 = var_13_3 / var_13_1.total_score * 100
	local var_13_6 = arg_13_0:KeepDecimalPlace(var_13_5, 2)

	arg_13_0.m_comboLab.text = MusicData:GetMaxComboHit()
	arg_13_0.m_accuracyLab.text = string.format("%.2f%%", var_13_6)

	local var_13_7 = MusicData:GetGameRecord(MusicConst.MusicNodeHitRating.Miss)
	local var_13_8 = MusicData:GetGameRecord(MusicConst.MusicNodeHitRating.Good)

	arg_13_0.m_mistakeLab.text = var_13_7
	arg_13_0.m_preciseLab.text = var_13_8
	arg_13_0.m_perfectLab.text = MusicData:GetGameRecord(MusicConst.MusicNodeHitRating.Perfect)
	arg_13_0.m_perfectPluasLab.text = MusicData:GetGameRecord(MusicConst.MusicNodeHitRating.PerfectPlus)

	if var_13_8 == 0 and var_13_7 == 0 then
		arg_13_0.evaluateController_:SetSelectedIndex(2)
	elseif var_13_7 == 0 then
		arg_13_0.evaluateController_:SetSelectedIndex(1)
	else
		arg_13_0.evaluateController_:SetSelectedIndex(0)
	end

	arg_13_0.newController_:SetSelectedIndex(arg_13_0.params_.new and 1 or 0)

	local var_13_9 = GameSetting.attach_music_grade.value
	local var_13_10 = arg_13_0.params_.isSpecialPerformance or false

	for iter_13_0, iter_13_1 in pairs(arg_13_0.ratingTipsList) do
		iter_13_1.enabled = false
	end

	for iter_13_2, iter_13_3 in ipairs(var_13_9) do
		if iter_13_3 <= var_13_5 then
			arg_13_0.gradeController_:SetSelectedIndex(iter_13_2 - 1)

			if not var_13_10 then
				arg_13_0.ratingTipsList[iter_13_2].enabled = true
			end

			break
		end
	end
end

function var_0_0.KeepDecimalPlace(arg_14_0, arg_14_1, arg_14_2)
	return math.floor(arg_14_1 * 10^arg_14_2) / 10^arg_14_2
end

function var_0_0.OnExit(arg_15_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_16_0)
	if arg_16_0.specialTimer_ then
		arg_16_0.specialTimer_:Stop()

		arg_16_0.specialTimer_ = nil
	end

	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
