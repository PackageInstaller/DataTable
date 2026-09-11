local HeroMovieReplayView = class("HeroMovieReplayView", ReduxView)
local ObtainHeroMovieView = require("game.views.obtain.ObtainHeroMovieView")

function HeroMovieReplayView:UIName()
	return "Widget/System/ObtainUI/HeroMovie/ObtainHeroMovieUI"
end

function HeroMovieReplayView:UIParent()
	return manager.ui.uiMain.transform
end

function HeroMovieReplayView:Init()
	self:InitUI()
	self:AddUIListener()
	HeroMovieReplayView.super.Init(self)
end

function HeroMovieReplayView:InitUI()
	self:BindCfgUI()

	self.starController_ = ControllerUtil.GetController(self.transform_, "star")
	self.criMovie_ = self.movie_:GetComponent("CriManaMovieControllerForUI")
	self.criplayer_ = self.criMovie_.player
	self.cirMovieLoop_ = self.movieLoop_:GetComponent("CriManaMovieControllerForUI")
	self.criplayerLoop_ = self.cirMovieLoop_.player
	self.SimplePlayer_ = self:FindCom("VoiceOfObtainHeroSimplePlayer", "CriwareAudio")
	self.startDirectorStopCallBack = handler(self, self.StartDirectorStopCallBack)
	self.playableDirectorStart_.stopped = self.playableDirectorStart_.stopped + self.startDirectorStopCallBack

	self.criplayer_:SetMaxPictureDataSize(300000)

	self._timer = FrameTimer.New(handler(self, self.MovieProcess), 1, -1)
end

function HeroMovieReplayView:AddUIListener()
	return
end

function HeroMovieReplayView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function HeroMovieReplayView:OnEnter()
	self.item = {
		id = self.params_.heroID
	}

	self:Show(self.item)
end

function HeroMovieReplayView:OnExit()
	self._timer:Stop()
	manager.audio:StopVoice()
	self.criMovie_:Stop()
	self.cirMovieLoop_:Stop()
end

function HeroMovieReplayView:Hide()
	HeroMovieReplayView.super.Hide(self)
end

HeroMovieReplayView.SetupCriPlayer = ObtainHeroMovieView.SetupCriPlayer

function HeroMovieReplayView:Show(arg_10_1)
	self.item = arg_10_1

	if self.gameObject_ then
		SetActive(self.gameObject_, true)
	end

	self:SetupCriPlayer(ObtainHeroMovieCfg[arg_10_1.id])
	self:SetInfo(arg_10_1)
	self.playableDirectorStart_:Evaluate()
	self.playableDirectorStart_:Play()
	SetActive(self.rebateGo_, false)
	SetActive(self.convertGo_, false)
	SetActive(self.m_endGo, false)

	self.SkipStart = true

	if self.SkipStart then
		self.playableDirectorStart_.time = self.playableDirectorStart_.duration
	end
end

function HeroMovieReplayView:PlayGetHeroVoice()
	local var_11_0 = self:GetHeroID()

	manager.audio:PlayVoice(string.format("vo_sys_%d", var_11_0), string.format("v_s_%d_%s", var_11_0, "get_cg"), string.format("vo_sys_%d.awb", var_11_0))
end

function HeroMovieReplayView:GetPlayable()
	return self.playableDirector_
end

function HeroMovieReplayView:GetHeroID()
	return self.item.id
end

HeroMovieReplayView.SetVideoTrack = ObtainHeroMovieView.SetVideoTrack

function HeroMovieReplayView:PlayMovie(arg_14_1)
	if self.isPlayMovie then
		if arg_14_1 then
			self.isPlayMovieEnd = true

			self.criMovie_:Stop()

			self.movieTrs_.localPosition = Vector2(9999, 9999)

			self.cirMovieLoop_:Play()

			self.movieLoopTrs_.localPosition = Vector2(0, 0)
		end

		return
	end

	local var_14_0 = self.item.id

	if self.start_voice_frames == 0 then
		manager.audio:PlayVoice(string.format("vo_sys_%d", var_14_0), string.format("v_s_%d_%s", var_14_0, "get_cg"), string.format("vo_sys_%d.awb", var_14_0))
	end

	self.isPlayMovie = true

	if arg_14_1 then
		self.cirMovieLoop_:Play()

		self.movieLoopTrs_.localPosition = Vector2(0, 0)
	else
		self.criMovie_:Play()

		self.movieTrs_.localPosition = Vector2(0, 0)
	end

	self._timer:Start()
end

function HeroMovieReplayView:MovieProcess()
	local var_15_0 = self.criplayer_:GetDisplayedFrameNo()

	if self.start_voice_frames ~= 0 and tostring(self.criplayer_.status) == "Playing" and var_15_0 >= self.start_voice_frames then
		self.start_voice_frames = 0

		self:PlayGetHeroVoice()
	end

	if tostring(self.criplayer_.status) == "Playing" and var_15_0 > self.start_movie_frames then
		SetActive(self.m_endGo, true)

		local var_15_1 = self:GetPlayable()

		var_15_1:Evaluate()
		var_15_1:Play()
		self._timer:Stop()

		self.isPlayMovieEnd = true

		if self.showSkipHandler then
			self.showSkipHandler()
		end

		if self.refreshShareHandler_ then
			self.refreshShareHandler_()
		end
	end
end

function HeroMovieReplayView:OnClick()
	local var_16_0 = self:GetPlayable()

	if self.isPlayMovieEnd and (var_16_0.time == 0 or var_16_0.time >= self:GetTimeLineEndTime()) then
		return true
	end

	if not self.isPlayMovieEnd then
		self:PlayMovie(true)
	end

	self.isPlayMovieEnd = true

	self._timer:Stop()
	SetActive(self.m_endGo, true)

	self.playableDirectorStart_.time = self.playableDirectorStart_.duration
	var_16_0.time = self:GetTimeLineEndTime()

	var_16_0:Play()

	if self.showSkipHandler then
		self.showSkipHandler()
	end

	return false
end

HeroMovieReplayView.Skip2End = ObtainHeroMovieView.Skip2End
HeroMovieReplayView.GetTimeLineEndTime = ObtainHeroMovieView.GetTimeLineEndTime
HeroMovieReplayView.RefreshContent = ObtainHeroMovieView.RefreshContent

function HeroMovieReplayView:SetInfo(arg_17_1)
	if not HeroCfg[arg_17_1.id] then
		return
	end

	self:RefreshContent(arg_17_1.id, HeroCfg[arg_17_1.id])
end

function HeroMovieReplayView:Dispose()
	self.playableDirectorStart_.stopped = self.playableDirectorStart_.stopped - self.startDirectorStopCallBack

	HeroMovieReplayView.super.Dispose(self)
end

function HeroMovieReplayView:OnObtainHeroMovieAnimtionEvent()
	self:PlayMovie()
end

function HeroMovieReplayView:StartDirectorStopCallBack()
	self:PlayMovie()
end

return HeroMovieReplayView
