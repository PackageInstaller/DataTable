local VolumeMusicGameView = class("VolumeMusicGameView", ReduxView)

function VolumeMusicGameView:UIName()
	return "UI/VolumeIIIDownUI/AthenaMusicGame/VolumeIIIDownMusicGameUI"
end

function VolumeMusicGameView:UIParent()
	return manager.ui.uiMain.transform
end

function VolumeMusicGameView:Init()
	self:InitUI()
	self:AddUIListener()
end

function VolumeMusicGameView:InitUI()
	self:BindCfgUI()

	self.ratingController = ControllerUtil.GetController(self.transform_, "rating")
end

function VolumeMusicGameView:AddUIListener()
	self:AddBtnListener(self.m_pauseBtn, nil, function()
		local var_6_0 = MusicLuaBridge.GetCurrentState()

		if var_6_0 == "PlayState" or var_6_0 == "PlayPreparationState" then
			MusicLuaBridge.PauseMusicGame()
		end
	end)
end

function VolumeMusicGameView:OnEnter()
	local var_7_0 = ActivityMusicCfg[MusicData:GetGameId()]

	self.m_name.text = GetI18NText(var_7_0.name)

	if not MusicData:GetShowMovie() then
		self:InitBackScene()
	end

	self.m_difficutLab.text = var_7_0.difficult == 2 and GetTips("ACTIVITY_MUSIC_LEVEL_2") or var_7_0.difficult == 9 and GetTips("ACTIVITY_MUSIC_LEVEL_3") or GetTips("ACTIVITY_MUSIC_LEVEL_1")

	self.ratingController:SetSelectedIndex(0)

	self.playEffect = MusicData:GetPlayKeyEffectSound()
end

function VolumeMusicGameView:OnExit()
	manager.ui:ResetMainCamera()
end

function VolumeMusicGameView:Dispose()
	VolumeMusicGameView.super.Dispose(self)
end

function VolumeMusicGameView:UpdateScore()
	self.m_scoreLab.text = MusicData:GetGameScore()
end

function VolumeMusicGameView:OnMusicInitPlay()
	self:UpdateScore()

	self.m_comboLab.text = ""

	self.ratingController:SetSelectedIndex(0)
end

function VolumeMusicGameView:OnMusicNodeHit(arg_12_1, arg_12_2)
	SetActive(self.m_effect, false)
	SetActive(self.m_effect, true)
	self:UpdateScore()

	if MusicConst.MusicNodeHitRating.PerfectPlus == arg_12_1 then
		self.ratingController:SetSelectedIndex(3)
	elseif MusicConst.MusicNodeHitRating.Perfect == arg_12_1 then
		self.ratingController:SetSelectedIndex(3)
	elseif MusicConst.MusicNodeHitRating.Good == arg_12_1 then
		self.ratingController:SetSelectedIndex(2)
	else
		self.ratingController:SetSelectedIndex(1)
	end

	self.m_comboLab.text = MusicData:GetComboHit()

	if self.playEffect and arg_12_1 ~= MusicConst.MusicNodeHitRating.Miss and (MusicConst.MusicNodeHitType.Short == arg_12_2 or MusicConst.MusicNodeHitType.Long == arg_12_2) then
		manager.audio:PlayEffect("minigame_activity_1_4", "minigame_activity_1_4_tambourine", "")
	end
end

function VolumeMusicGameView:InitBackScene()
	self.backGround_ = manager.resourcePool:Get("UI/Common/BackgroundQuad", ASSET_TYPE.SCENE)
	self.backGroundTrs_ = self.backGround_.transform

	self.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

	self.backGroundTrs_.localPosition = Vector3(0, 0, 100)
	self.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)
	self.backGroundTrs_.localScale = Vector3(11, 11, 1)
	self.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = pureGetSpriteWithoutAtlas("TextureConfig/VolumeIIIDownUI/VolumeDown_bg_00050")
end

return VolumeMusicGameView
