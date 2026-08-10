local var_0_0 = class("V210MusicGameView", ReduxView)

function var_0_0.UIName(arg_1_0)
	local var_1_0 = MusicData:GetNowMusicUINameList()

	if var_1_0 and var_1_0.gameView then
		return var_1_0.gameView
	else
		return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionMusicUI/MusicGameUI"
	end
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
	arg_4_0.keyTipsController = arg_4_0.controller_:GetController("showKeyTips")
	arg_4_0.specialModeController = arg_4_0.controller_:GetController("specialMode")
	arg_4_0.keyTipsTrsList = {}

	for iter_4_0 = 0, arg_4_0.keytipsnodeTrs_.childCount - 1 do
		arg_4_0.keyTipsTrsList[iter_4_0] = arg_4_0.keytipsnodeTrs_:GetChild(iter_4_0)
	end
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

	arg_7_0.m_difficutLab.text = MusicData:GetMusicdifficultLab(var_7_1.difficult)

	arg_7_0.ratingController:SetSelectedIndex(0)

	arg_7_0.playEffect = true

	SetActive(arg_7_0.specialObj_, false)
end

function var_0_0.OnExit(arg_8_0)
	arg_8_0:DelSpecialTimer()
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
	arg_11_0:DelSpecialTimer()
	SetActive(arg_11_0.specialObj_, false)
	MusicData:SetSpecialEffectState(false)
	arg_11_0:UpdateScore()
	arg_11_0:SetComboLab("")
	arg_11_0.ratingController:SetSelectedIndex(0)
	arg_11_0:OnKeyTipsShowUpdate()
	arg_11_0.specialModeController:SetSelectedState("hide")
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
	arg_15_0:OnKeyTipsShowUpdate()
	arg_15_0.specialModeController:SetSelectedState("hide")
end

function var_0_0.OnKeyTipsShowUpdate(arg_16_0)
	if GameToSDK.IsPCPlatform() or LuaForGamepad.GetGamepadType() == LuaHidTools.GetPlayerSelectKeyboard() and LuaHidTools.GetRemapNotice(LuaHidTools.GetPlayerSelectKeyboard()) then
		arg_16_0.keyTipsController:SetSelectedState("show")
		arg_16_0:OnAdpatKeyTipsPos()
	else
		arg_16_0.keyTipsController:SetSelectedState("hide")
	end
end

function var_0_0.OnAdpatKeyTipsPos(arg_17_0)
	if not GameObject.Find("gameRoot/center") then
		return
	end

	local var_17_0 = MusicLuaBridge.GetTrackNum()

	for iter_17_0, iter_17_1 in pairs(arg_17_0.keyTipsTrsList) do
		SetActive(iter_17_1.gameObject, false)
	end

	for iter_17_2 = 1, var_17_0 do
		local var_17_1 = arg_17_0.keyTipsTrsList[iter_17_2 - 1]

		SetActive(var_17_1.gameObject, true)

		local var_17_2 = GameObject.Find("Music/gameRoot/Track" .. iter_17_2).transform

		var_17_1:Find("text"):GetComponent("Text").text = MusicData:GetTrackKeySetData(var_17_0)[iter_17_2]
		var_17_1.localPosition = arg_17_0:ConvertWorldToUIPos(var_17_2.position) + Vector2(0, 10)
	end
end

function var_0_0.ConvertWorldToUIPos(arg_18_0, arg_18_1)
	local var_18_0 = manager.ui.canvas
	local var_18_1 = UnityEngine.Camera.main:WorldToScreenPoint(arg_18_1)
	local var_18_2 = var_18_0:GetComponent(typeof(Canvas)).worldCamera
	local var_18_3, var_18_4 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(var_18_0.transform, var_18_1, var_18_2, nil)

	if var_18_4 == nil then
		print("未找到对应的视口坐标")
	end

	return var_18_4
end

function var_0_0.OnMusicsSpecialEffectTrigger(arg_19_0, arg_19_1)
	local var_19_0 = MusicData:GetGameId()
	local var_19_1 = ActivityMusicCfg[var_19_0].activity_id

	if not getData("Music", "Performance" .. var_19_1) then
		saveData("Music", "Performance" .. var_19_1, 1)
	else
		return
	end

	SetActive(arg_19_0.specialObj_, true)
	MusicData:SetSpecialEffectState(true)
	arg_19_0.specialModeController:SetSelectedState("show")
	arg_19_0.keyTipsController:SetSelectedState("hide")
	manager.audio:Play("voice", "vo_activity_v_3_11", "vo_activity_v_3_11_musicgame_special")

	local var_19_2 = manager.audio:GetVoiceLength("vo_activity_v_3_11", "vo_activity_v_3_11_musicgame_special")

	var_19_2 = var_19_2 and var_19_2 / 1000

	arg_19_0:AddSpecialTimer(var_19_2)
end

function var_0_0.DelSpecialTimer(arg_20_0)
	if arg_20_0.specialTimer then
		arg_20_0.specialTimer:Stop()

		arg_20_0.specialTimer = nil
	end
end

function var_0_0.AddSpecialTimer(arg_21_0, arg_21_1)
	arg_21_0:DelSpecialTimer()

	local var_21_0 = MusicData:GetGameId()
	local var_21_1 = ActivityMusicCfg[var_21_0].activity_id

	arg_21_0.specialTimer = Timer.New(function()
		local var_22_0 = MusicData:GetScore(var_21_0)

		MusicData:SetSpecialEffectState(false)
		MusicAction.OpenSettlement(var_21_1, var_22_0, var_22_0, true, true)
	end, arg_21_1)

	arg_21_0.specialTimer:Start()
end

return var_0_0
