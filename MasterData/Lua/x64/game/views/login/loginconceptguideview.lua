local LoginConceptGuideView = class("LoginConceptGuideView", ReduxView)

function LoginConceptGuideView:UIName()
	return "Widget/System/LoginInterface/LoginConceptGuild"
end

function LoginConceptGuideView:UIParent()
	return manager.ui.uiMain.transform
end

function LoginConceptGuideView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.criManaExMultipleVideo_ = self.movieGo_:GetComponent("CriManaExMultipleVedio")
	self.criManaMovieController_ = self.movieGo_:GetComponent("CriManaMovieControllerForUI")
	self.criplayer_ = self.criManaMovieController_.player
	self.criplayer_.statusChangeCallback = handler(self, self.StatusChangeCallback)

	self.criplayer_:SetVolume(manager.audio:GetEffectVolume())
	self.criplayer_:SetMaxPictureDataSize(600000)
	self.criplayer_:SetBufferingTime(0.05)
	self:InitMovieData()

	self._timer = FrameTimer.New(handler(self, self.MovieProcess), 1, -1)
end

function LoginConceptGuideView:InitMovieData()
	self.moviePath_ = {}
	self.movieTotalFrames_ = {}

	for iter_4_0 = 1, 4 do
		table.insert(self.moviePath_, GameDisplayCfg.login_concept_guild_movie_path.value[iter_4_0])

		self.movieTotalFrames_[iter_4_0] = GameDisplayCfg.login_concept_guild_movie_frames.value[iter_4_0]
	end

	self.movieEndFrames_ = {}

	self:CalcNextMovieData(0)
end

function LoginConceptGuideView:AddListeners()
	self:AddBtnListener(self.nextBtn_1, nil, function()
		self:CalcNextMovieData(1)
		self:StepPlayLoopMovie(2)
		SetActive(self.nextGo_1, false)
	end)
	self:AddBtnListener(self.nextBtn_2, nil, function()
		self:CalcNextMovieData(3)
		SetActive(self.nextGo_2, false)
	end)
end

function LoginConceptGuideView:OnEnter()
	GameLocalData:SaveToCommonModule("LoginConceptGuideData", "watched", true)
	gameContext:SetSystemLayer("login")

	_G.isLogining = false

	LoadingUIManager.inst:CloseLoadUI()
	SetActive(self.nextGo_1, false)
	SetActive(self.nextGo_2, false)

	self.curMovieIdx_ = 1

	self:StepPlayLoopMovie(1)
	self._timer:Start()
	manager.audio:PlayVoice("vo_login_vocal", "vo_login_vocal_1", "vo_login_vocal.awb")
	manager.audio:PlayBGM("bgm_login_4_0", "bgm_login_4_0_part1", "bgm_login_4_0")

	self.movieExited_ = {}
end

function LoginConceptGuideView:OnExit()
	GameLocalData:SaveToCommonModule("LoginConceptGuideData", "watched", true)
	self._timer:Stop()
end

function LoginConceptGuideView:Dispose()
	LoginConceptGuideView.super.Dispose(self)
end

function LoginConceptGuideView:StatusChangeCallback(arg_11_1)
	local var_11_0 = tostring(arg_11_1)

	if var_11_0 == "PlayEnd" then
		self:OnMovieEnd(self.curMovieIdx_)
	elseif var_11_0 == "Playing" then
		self:FetchMovieTotalFrames()
	end
end

function LoginConceptGuideView:OnMovieEnd(arg_12_1)
	if self.movieExited_[arg_12_1] then
		return
	end

	self.movieExited_[arg_12_1] = true

	if arg_12_1 == 1 then
		SetActive(self.nextGo_1, true)
	elseif arg_12_1 == 2 then
		self:CalcNextMovieData(arg_12_1)
		manager.audio:PlayBGM("bgm_login_4_0", "bgm_login_4_0_part3", "bgm_login_4_0")
	elseif arg_12_1 == 3 then
		self:CalcNextMovieData(arg_12_1)
	elseif arg_12_1 == 4 then
		self:JumpToLoginPage()
	elseif arg_12_1 == 5 then
		self:JumpToLoginPage()
	end

	self.curMovieIdx_ = self.curMovieIdx_ + 1
end

function LoginConceptGuideView:StepPlayLoopMovie(arg_13_1)
	SetFile(self.criplayer_, nil, self.moviePath_[arg_13_1 * 2 - 1], CriMana.Player.SetMode.Append)
	SetFile(self.criplayer_, nil, self.moviePath_[arg_13_1 * 2 - 1 + 1], CriMana.Player.SetMode.AppendRepeatedly)
	self.criManaMovieController_:Play()
end

function LoginConceptGuideView:StepPlayExitMovie()
	SetFile(self.criplayer_, nil, self.moviePath_[5], CriMana.Player.SetMode.New)
	self.criManaMovieController_:Play()
end

function LoginConceptGuideView:FetchMovieTotalFrames()
	return
end

function LoginConceptGuideView:MovieProcess()
	if self.curMovieIdx_ == 2 then
		if not self.lastAudioPlayTime_ then
			self.lastAudioPlayTime_ = Time.time
		elseif Time.time - self.lastAudioPlayTime_ > 6 then
			self.lastAudioPlayTime_ = Time.time

			manager.audio:PlayVoice("vo_login_vocal", "vo_login_vocal_2", "vo_login_vocal.awb")
		end
	end

	if self.movieEndFrames_[self.curMovieIdx_] == nil then
		return
	end

	if self.criplayer_:GetDisplayedFrameNo() >= self.movieEndFrames_[self.curMovieIdx_] then
		self:OnMovieEnd(self.curMovieIdx_)
	end
end

function LoginConceptGuideView:JumpToLoginPage()
	manager.transition:OnlyShowEffect(true, function()
		if self.OnlyShowEffectExiting_ then
			return
		end

		self.OnlyShowEffectExiting_ = true

		manager.transition:OnlyShowEffect(false)

		self.OnlyShowEffectExiting_ = false

		self:Back()
		gameContext:Go("/login", {
			isAutoLogin = self.params_.isAutoLogin
		})
	end)
end

function LoginConceptGuideView:CalcNextMovieData(arg_19_1, arg_19_2)
	if arg_19_1 == 0 then
		self.movieEndFrames_[arg_19_1 + 1] = self.movieTotalFrames_[arg_19_1 + 1]

		return
	end

	if arg_19_2 == nil then
		arg_19_2 = 0
	end

	self.movieEndFrames_[arg_19_1 + 1] = self.movieEndFrames_[arg_19_1] + self.movieTotalFrames_[arg_19_1 + 1] * math.max(math.ceil((self.criplayer_:GetDisplayedFrameNo() - self.movieEndFrames_[arg_19_1]) / self.movieTotalFrames_[arg_19_1 + 1]) + arg_19_2, 1)
end

return LoginConceptGuideView
