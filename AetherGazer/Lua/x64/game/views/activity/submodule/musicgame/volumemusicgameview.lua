local var_0_0 = class("VolumeMusicGameView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VolumeIIIDownUI/AthenaMusicGame/VolumeIIIDownMusicGameUI"
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

	arg_7_0.playEffect = MusicData:GetPlayKeyEffectSound()
end

function var_0_0.OnExit(arg_8_0)
	manager.ui:ResetMainCamera()
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

	arg_11_0.m_comboLab.text = ""

	arg_11_0.ratingController:SetSelectedIndex(0)
end

function var_0_0.OnMusicNodeHit(arg_12_0, arg_12_1, arg_12_2)
	SetActive(arg_12_0.m_effect, false)
	SetActive(arg_12_0.m_effect, true)
	arg_12_0:UpdateScore()

	if MusicConst.MusicNodeHitRating.PerfectPlus == arg_12_1 then
		arg_12_0.ratingController:SetSelectedIndex(3)
	elseif MusicConst.MusicNodeHitRating.Perfect == arg_12_1 then
		arg_12_0.ratingController:SetSelectedIndex(3)
	elseif MusicConst.MusicNodeHitRating.Good == arg_12_1 then
		arg_12_0.ratingController:SetSelectedIndex(2)
	else
		arg_12_0.ratingController:SetSelectedIndex(1)
	end

	arg_12_0.m_comboLab.text = MusicData:GetComboHit()

	if arg_12_0.playEffect and arg_12_1 ~= MusicConst.MusicNodeHitRating.Miss and (MusicConst.MusicNodeHitType.Short == arg_12_2 or MusicConst.MusicNodeHitType.Long == arg_12_2) then
		manager.audio:PlayEffect("minigame_activity_1_4", "minigame_activity_1_4_tambourine", "")
	end
end

function var_0_0.InitBackScene(arg_13_0)
	local var_13_0 = "UI/Common/BackgroundQuad"

	arg_13_0.backGround_ = manager.resourcePool:Get(var_13_0, ASSET_TYPE.SCENE)
	arg_13_0.backGroundTrs_ = arg_13_0.backGround_.transform

	arg_13_0.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

	arg_13_0.backGroundTrs_.localPosition = Vector3(0, 0, 100)
	arg_13_0.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)
	arg_13_0.backGroundTrs_.localScale = Vector3(11, 11, 1)
	arg_13_0.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = pureGetSpriteWithoutAtlas("TextureConfig/VolumeIIIDownUI/VolumeDown_bg_00050")
end

return var_0_0
