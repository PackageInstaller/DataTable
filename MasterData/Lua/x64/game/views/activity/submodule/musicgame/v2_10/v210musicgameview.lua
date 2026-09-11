local V210MusicGameView = class("V210MusicGameView", ReduxView)

function V210MusicGameView:UIName()
	local var_1_0 = MusicData:GetNowMusicUINameList()

	if var_1_0 and var_1_0.gameView then
		return var_1_0.gameView
	else
		return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionMusicUI/MusicGameUI"
	end
end

function V210MusicGameView:UIParent()
	return manager.ui.uiMain.transform
end

function V210MusicGameView:Init()
	self:InitUI()
	self:AddUIListener()
end

function V210MusicGameView:InitUI()
	self:BindCfgUI()

	self.ratingController = ControllerUtil.GetController(self.transform_, "rating")
	self.keyTipsController = self.controller_:GetController("showKeyTips")
	self.specialModeController = self.controller_:GetController("specialMode")
	self.keyTipsTrsList = {}

	for iter_4_0 = 0, self.keytipsnodeTrs_.childCount - 1 do
		self.keyTipsTrsList[iter_4_0] = self.keytipsnodeTrs_:GetChild(iter_4_0)
	end
end

function V210MusicGameView:AddUIListener()
	self:AddBtnListener(self.m_pauseBtn, nil, function()
		local var_6_0 = MusicLuaBridge.GetCurrentState()

		if var_6_0 == "PlayState" or var_6_0 == "PlayPreparationState" then
			MusicLuaBridge.PauseMusicGame()
		end
	end)
end

function V210MusicGameView:OnEnter()
	local var_7_0 = ActivityMusicCfg[MusicData:GetGameId()]

	self.m_name.text = GetI18NText(var_7_0.name)

	if not MusicData:GetShowMovie() then
		self:InitBackScene()
	end

	self.m_difficutLab.text = MusicData:GetMusicdifficultLab(var_7_0.difficult)

	self.ratingController:SetSelectedIndex(0)

	self.playEffect = true

	SetActive(self.specialObj_, false)
end

function V210MusicGameView:OnExit()
	self:DelSpecialTimer()
	manager.ui:ResetMainCamera()
	MusicLuaBridge.SetProcessSlider(nil)
end

function V210MusicGameView:Dispose()
	V210MusicGameView.super.Dispose(self)
end

function V210MusicGameView:UpdateScore()
	self.m_scoreLab.text = MusicData:GetGameScore()
end

function V210MusicGameView:OnMusicInitPlay()
	self:DelSpecialTimer()
	SetActive(self.specialObj_, false)
	MusicData:SetSpecialEffectState(false)
	self:UpdateScore()
	self:SetComboLab("")
	self.ratingController:SetSelectedIndex(0)
	self:OnKeyTipsShowUpdate()
	self.specialModeController:SetSelectedState("hide")
end

function V210MusicGameView:OnMusicNodeHit(arg_12_1, arg_12_2)
	SetActive(self.m_effect, false)
	SetActive(self.m_effect, true)
	self:UpdateScore()

	if MusicConst.MusicNodeHitRating.PerfectPlus == arg_12_1 then
		self.ratingController:SetSelectedIndex(4)
	elseif MusicConst.MusicNodeHitRating.Perfect == arg_12_1 then
		self.ratingController:SetSelectedIndex(3)
	elseif MusicConst.MusicNodeHitRating.Good == arg_12_1 then
		self.ratingController:SetSelectedIndex(2)
	else
		self.ratingController:SetSelectedIndex(1)
	end

	self:SetComboLab(MusicData:GetComboHit())

	if self.playEffect and arg_12_1 ~= MusicConst.MusicNodeHitRating.Miss and (MusicConst.MusicNodeHitType.Short == arg_12_2 or MusicConst.MusicNodeHitType.Long == arg_12_2) then
		manager.audio:PlayEffect("minigame_activity_2_0", "minigame_activity_2_0_musicgame_hitsound", "")
	end
end

function V210MusicGameView:SetComboLab(arg_13_1)
	self.m_comboLab1.text = arg_13_1
	self.m_comboLab2.text = arg_13_1
	self.m_comboLab3.text = arg_13_1
	self.m_comboLab4.text = arg_13_1
end

function V210MusicGameView:InitBackScene()
	self.backGround_ = manager.resourcePool:Get("UI/Common/BackgroundQuad", ASSET_TYPE.SCENE)
	self.backGroundTrs_ = self.backGround_.transform

	self.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

	self.backGroundTrs_.localPosition = Vector3(0, 0, 100)
	self.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)
	self.backGroundTrs_.localScale = Vector3(11, 11, 1)
	self.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/XuHeng1stUI/XuHeng1st_bg_00122")
end

function V210MusicGameView:OnMusicSceneLoaded()
	MusicLuaBridge.SetProcessSlider(self.m_slider)
	self:OnKeyTipsShowUpdate()
	self.specialModeController:SetSelectedState("hide")
end

function V210MusicGameView:OnKeyTipsShowUpdate()
	if GameToSDK.IsPCPlatform() or LuaForGamepad.GetGamepadType() == LuaHidTools.GetPlayerSelectKeyboard() and LuaHidTools.GetRemapNotice(LuaHidTools.GetPlayerSelectKeyboard()) then
		self.keyTipsController:SetSelectedState("show")
		self:OnAdpatKeyTipsPos()
	else
		self.keyTipsController:SetSelectedState("hide")
	end
end

function V210MusicGameView:OnAdpatKeyTipsPos()
	if not GameObject.Find("gameRoot/center") then
		return
	end

	local var_17_0 = MusicLuaBridge.GetTrackNum()

	for iter_17_0, iter_17_1 in pairs(self.keyTipsTrsList) do
		SetActive(iter_17_1.gameObject, false)
	end

	for iter_17_2 = 1, var_17_0 do
		SetActive(self.keyTipsTrsList[iter_17_2 - 1].gameObject, true)

		local var_17_1 = GameObject.Find("Music/gameRoot/Track" .. iter_17_2).transform

		self.keyTipsTrsList[iter_17_2 - 1]:Find("text"):GetComponent("Text").text = MusicData:GetTrackKeySetData(var_17_0)[iter_17_2]
		self.keyTipsTrsList[iter_17_2 - 1].localPosition = self:ConvertWorldToUIPos(var_17_1.position) + Vector2(0, 10)
	end
end

function V210MusicGameView:ConvertWorldToUIPos(arg_18_1)
	local var_18_0, var_18_1 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(manager.ui.canvas.transform, UnityEngine.Camera.main:WorldToScreenPoint(arg_18_1), manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera, nil)

	if var_18_1 == nil then
		print("未找到对应的视口坐标")
	end

	return var_18_1
end

function V210MusicGameView:OnMusicsSpecialEffectTrigger(arg_19_1)
	local var_19_0 = ActivityMusicCfg[MusicData:GetGameId()].activity_id

	if not getData("Music", "Performance" .. var_19_0) then
		saveData("Music", "Performance" .. var_19_0, 1)
	else
		return
	end

	SetActive(self.specialObj_, true)
	MusicData:SetSpecialEffectState(true)
	self.specialModeController:SetSelectedState("show")
	self.keyTipsController:SetSelectedState("hide")
	manager.audio:Play("voice", "vo_activity_v_3_11", "vo_activity_v_3_11_musicgame_special")

	local var_19_1 = manager.audio:GetVoiceLength("vo_activity_v_3_11", "vo_activity_v_3_11_musicgame_special")

	var_19_1 = var_19_1 and var_19_1 / 1000

	self:AddSpecialTimer(var_19_1)
end

function V210MusicGameView:DelSpecialTimer()
	if self.specialTimer then
		self.specialTimer:Stop()

		self.specialTimer = nil
	end
end

function V210MusicGameView:AddSpecialTimer(arg_21_1)
	self:DelSpecialTimer()

	local var_21_0 = MusicData:GetGameId()
	local var_21_1 = ActivityMusicCfg[var_21_0].activity_id

	self.specialTimer = Timer.New(function()
		local var_22_0 = MusicData:GetScore(var_21_0)

		MusicData:SetSpecialEffectState(false)
		MusicAction.OpenSettlement(var_21_1, var_22_0, var_22_0, true, true)
	end, arg_21_1)

	self.specialTimer:Start()
end

return V210MusicGameView
