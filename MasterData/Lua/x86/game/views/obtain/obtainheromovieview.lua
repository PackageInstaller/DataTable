local ObtainHeroMovieView = class("ObtainHeroMovieView", require("game.views.obtain.ObtainHeroView"))

function ObtainHeroMovieView:Ctor(arg_1_1, arg_1_2, arg_1_3)
	ObtainHeroMovieView.super.Ctor(self, arg_1_1, arg_1_2)

	self.showSkipHandler = arg_1_3.obtainView.showSkipHandler
	self.refreshShareHandler_ = arg_1_3.obtainView.refreshShareHandler
	self.skipStart = arg_1_3.obtainView.skipStart
end

function ObtainHeroMovieView:InitUI()
	self:BindCfgUI()

	self.starController_ = ControllerUtil.GetController(self.transform_, "star")
	self.criMovie_ = self.movie_:GetComponent("CriManaMovieControllerForUI")
	self.criplayer_ = self.criMovie_.player
	self.cirMovieLoop_ = self.movieLoop_:GetComponent("CriManaMovieControllerForUI")
	self.criplayerLoop_ = self.cirMovieLoop_.player
	self.SimplePlayer_ = self:FindCom("VoiceOfObtainHeroSimplePlayer", "CriwareAudio")
	self.commonItem_ = CommonItem.New(self.itemGo_)
	self.startDirectorStopCallBack = handler(self, self.StartDirectorStopCallBack)
	self.playableDirectorStart_.stopped = self.playableDirectorStart_.stopped + self.startDirectorStopCallBack

	self.criplayer_:SetMaxPictureDataSize(300000)

	self._timer = FrameTimer.New(handler(self, self.MovieProcess), 1, -1)
end

function ObtainHeroMovieView:OnClick()
	local var_3_0 = self:GetPlayable()

	if self.isPlayMovieEnd and (var_3_0.time == 0 or var_3_0.time >= self:GetTimeLineEndTime()) then
		return true
	end

	if not (getData(DrawConst.WATCH_TAG, tostring(self:GetHeroID())) or false) then
		return false
	end

	if not self.isPlayMovieEnd then
		self:PlayMovie(true)
	end

	self.isPlayMovieEnd = true

	self._timer:Stop()
	SetActive(self.m_endGo, true)

	self.playableDirectorStart_.time = self.playableDirectorStart_.duration
	var_3_0.time = self:GetTimeLineEndTime()

	var_3_0:Play()

	if self.showSkipHandler then
		self.showSkipHandler()
	end

	return false
end

function ObtainHeroMovieView:SetupCriPlayer(arg_4_1)
	self.start_path = arg_4_1.start_path
	self.loop_path = arg_4_1.loop_path
	self.start_movie_frames = arg_4_1.start_movie_frames
	self.start_voice_frames = arg_4_1.start_voice_frames
	self.isPlayMovie = false
	self.isPlayMovieEnd = false

	self.criMovie_:Stop()

	self.movieTrs_.localPosition = Vector2(9999, 9999)

	self.cirMovieLoop_:Stop()

	self.movieLoopTrs_.localPosition = Vector2(9999, 9999)

	SetFile(self.criplayer_, nil, self.start_path, CriMana.Player.SetMode.New)
	SetFile(self.criplayer_, nil, self.loop_path, CriMana.Player.SetMode.AppendRepeatedly)
	SetFile(self.criplayerLoop_, nil, self.loop_path)

	local var_4_0 = manager.audio:GetMusicVolume()

	self.criplayer_:SetVolume(var_4_0)
	self.criplayerLoop_:SetVolume(var_4_0)
	self:SetVideoTrack(self.criplayer_, self.start_path)
	self:SetVideoTrack(self.criplayerLoop_, self.loop_path)
end

function ObtainHeroMovieView:Show(arg_5_1)
	self.item = arg_5_1
	self.convert = ItemWillConvert(arg_5_1)

	if self.gameObject_ then
		SetActive(self.gameObject_, true)
	end

	self:SetupCriPlayer(ObtainHeroMovieCfg[self:GetHeroID()])
	self:SetInfo(arg_5_1)
	self.playableDirectorStart_:Evaluate()
	self.playableDirectorStart_:Play()
	SetActive(self.m_endGo, false)

	if self.skipStart then
		self.playableDirectorStart_.time = self.playableDirectorStart_.duration
	end
end

function ObtainHeroMovieView:SetVideoTrack(arg_6_1, arg_6_2)
	local var_6_0 = manager.video:GetVedioTrackIndex(arg_6_2)

	arg_6_1:SetAudioTrack(var_6_0)
	arg_6_1:SetSubtitleChannel(var_6_0)
end

function ObtainHeroMovieView:PlayMovie(arg_7_1)
	if self.isPlayMovie then
		if arg_7_1 then
			self.isPlayMovieEnd = true

			self.criMovie_:Stop()

			self.movieTrs_.localPosition = Vector2(9999, 9999)

			self.cirMovieLoop_:Play()

			self.movieLoopTrs_.localPosition = Vector2(0, 0)
		end

		return
	end

	if self.start_voice_frames == 0 then
		self:PlayGetHeroVoice()
	end

	self.isPlayMovie = true

	if arg_7_1 then
		self.cirMovieLoop_:Play()

		self.movieLoopTrs_.localPosition = Vector2(0, 0)
	else
		self.criMovie_:Play()

		self.movieTrs_.localPosition = Vector2(0, 0)
	end

	self._timer:Start()
end

function ObtainHeroMovieView:MovieProcess()
	local var_8_0 = self.criplayer_:GetDisplayedFrameNo()

	if self.start_voice_frames ~= 0 and tostring(self.criplayer_.status) == "Playing" and var_8_0 >= self.start_voice_frames then
		self.start_voice_frames = 0

		self:PlayGetHeroVoice()
	end

	if tostring(self.criplayer_.status) == "Playing" and var_8_0 > self.start_movie_frames then
		SetActive(self.m_endGo, true)

		local var_8_1 = self:GetPlayable()

		var_8_1:Evaluate()
		var_8_1:Play()
		self._timer:Stop()

		self.isPlayMovieEnd = true

		saveData(DrawConst.WATCH_TAG, tostring(self:GetHeroID()), true)

		if self.showSkipHandler then
			self.showSkipHandler()
		end

		if self.refreshShareHandler_ then
			self.refreshShareHandler_()
		end
	end
end

function ObtainHeroMovieView:RefreshContent(arg_9_1, arg_9_2)
	self.name_.text = HeroTools.GetHeroFullName(arg_9_1)
	self.camp_.sprite = getSprite("Atlas/CampItemAtlas", RaceEffectCfg[arg_9_2.race].icon)

	local var_9_0 = math.min(ItemCfg[arg_9_1].display_rare, 5)

	self.starController_:SetSelectedIndex(var_9_0)

	if var_9_0 == 5 then
		manager.audio:SetObtainGoldSelectorLabel()
	elseif var_9_0 == 4 then
		manager.audio:SetObtainPurpleSelectorLabel()
	else
		manager.audio:SetObtainBlueSelectorLabel()
	end
end

function ObtainHeroMovieView:GetTimeLineEndTime()
	return 1.5
end

function ObtainHeroMovieView:Skip2End()
	local var_11_0 = self:GetPlayable()

	if not self.isPlayMovieEnd then
		self:PlayMovie(true)
	end

	self.isPlayMovieEnd = true

	self._timer:Stop()
	SetActive(self.m_endGo, true)

	self.playableDirectorStart_.time = self.playableDirectorStart_.duration
	var_11_0.time = 1.5

	var_11_0:Play()

	if self.showSkipHandler then
		self.showSkipHandler()
	end
end

function ObtainHeroMovieView:Dispose()
	self.playableDirectorStart_.stopped = self.playableDirectorStart_.stopped - self.startDirectorStopCallBack

	ObtainHeroMovieView.super.Dispose(self)
end

function ObtainHeroMovieView:Hide()
	self._timer:Stop()
	manager.audio:StopVoice()
	ObtainBaseView.Hide(self)
end

function ObtainHeroMovieView:OnObtainHeroMovieAnimtionEvent()
	self:PlayMovie()
end

function ObtainHeroMovieView:StartDirectorStopCallBack()
	self:PlayMovie()
end

return ObtainHeroMovieView
