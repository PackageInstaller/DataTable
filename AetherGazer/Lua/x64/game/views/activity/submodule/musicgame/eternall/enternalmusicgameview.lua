local var_0_0 = class("EnternalMusicGameView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/XuHeng1stUI/Music/XH1stMusicGameUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.ratingController = ControllerUtil.GetController(arg_4_0.transform_, "rating")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_pauseBtn, nil, function()
		local var_6_0 = MusicLuaBridge.GetCurrentState()

		if var_6_0 == "PlayState" or var_6_0 == "PlayPreparationState" then
			MusicLuaBridge.PauseMusicGame()
		end
	end)
end

function var_0_0.OnEnter(arg_7_0)
	local var_7_0 = MusicData:GetGameId()
	local var_7_1 = ActivityMusicCfg[var_7_0]

	arg_7_0.m_name.text = GetI18NText(var_7_1.name)

	if not MusicData:GetShowMovie() then
		arg_7_0:InitBackScene()
	end

	if var_7_1.difficult == 2 then
		arg_7_0.m_difficutLab.text = GetTips("ACTIVITY_MUSIC_LEVEL_2")
	elseif var_7_1.difficult == 9 then
		arg_7_0.m_difficutLab.text = GetTips("ACTIVITY_MUSIC_LEVEL_3")
	else
		arg_7_0.m_difficutLab.text = GetTips("ACTIVITY_MUSIC_LEVEL_1")
	end

	arg_7_0.ratingController:SetSelectedIndex(0)

	arg_7_0.playEffect = true
end

function var_0_0.OnExit(arg_8_0)
	manager.ui:ResetMainCamera()
	MusicLuaBridge.SetProcessSlider(nil)
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
end

function var_0_0.UpdateScore(arg_10_0)
	local var_10_0 = MusicData:GetGameScore()

	arg_10_0.m_scoreLab.text = var_10_0
end

function var_0_0.OnMusicInitPlay(arg_11_0)
	arg_11_0:UpdateScore()
	arg_11_0:SetComboLab("")
	arg_11_0.ratingController:SetSelectedIndex(0)
end

function var_0_0.OnMusicNodeHit(arg_12_0, arg_12_1, arg_12_2)
	SetActive(arg_12_0.m_effect, false)
	SetActive(arg_12_0.m_effect, true)
	arg_12_0:UpdateScore()

	if MusicConst.MusicNodeHitRating.PerfectPlus == arg_12_1 then
		arg_12_0.ratingController:SetSelectedIndex(4)
	elseif MusicConst.MusicNodeHitRating.Perfect == arg_12_1 then
		arg_12_0.ratingController:SetSelectedIndex(3)
	elseif MusicConst.MusicNodeHitRating.Good == arg_12_1 then
		arg_12_0.ratingController:SetSelectedIndex(2)
	else
		arg_12_0.ratingController:SetSelectedIndex(1)
	end

	arg_12_0:SetComboLab(MusicData:GetComboHit())

	if arg_12_0.playEffect and arg_12_1 ~= MusicConst.MusicNodeHitRating.Miss and (MusicConst.MusicNodeHitType.Short == arg_12_2 or MusicConst.MusicNodeHitType.Long == arg_12_2) then
		manager.audio:PlayEffect("minigame_activity_2_0", "minigame_activity_2_0_musicgame_hitsound", "")
	end
end

function var_0_0.SetComboLab(arg_13_0, arg_13_1)
	arg_13_0.m_comboLab1.text = arg_13_1
	arg_13_0.m_comboLab2.text = arg_13_1
	arg_13_0.m_comboLab3.text = arg_13_1
	arg_13_0.m_comboLab4.text = arg_13_1
end

function var_0_0.InitBackScene(arg_14_0)
	local var_14_0 = "UI/Common/BackgroundQuad"

	arg_14_0.backGround_ = manager.resourcePool:Get(var_14_0, ASSET_TYPE.SCENE)
	arg_14_0.backGroundTrs_ = arg_14_0.backGround_.transform

	arg_14_0.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

	arg_14_0.backGroundTrs_.localPosition = Vector3(0, 0, 100)
	arg_14_0.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)
	arg_14_0.backGroundTrs_.localScale = Vector3(11, 11, 1)
	arg_14_0.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/XuHeng1stUI/XuHeng1st_bg_00122")
end

function var_0_0.OnMusicSceneLoaded(arg_15_0)
	MusicLuaBridge.SetProcessSlider(arg_15_0.m_slider)
end

return var_0_0
