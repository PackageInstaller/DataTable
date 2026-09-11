local LoginBrahmaBonusView = class("LoginBrahmaBonusView", ReduxView)

function LoginBrahmaBonusView:UIName()
	return "Widget/System/LoginInterface/LoginBrahmaBonus"
end

function LoginBrahmaBonusView:UIParent()
	return manager.ui.uiMain.transform
end

function LoginBrahmaBonusView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.criManaMovieController_ = self.movieGo_:GetComponent("CriManaMovieControllerForUI")
	self.criplayer_ = self.criManaMovieController_.player

	self.criplayer_:SetMaxPictureDataSize(300000)

	self.criManaMovieController2_ = self.movie2Go_:GetComponent("CriManaMovieControllerForUI")
	self.criplayer2_ = self.criManaMovieController2_.player

	self.criplayer2_:SetMaxPictureDataSize(300000)
	self:InitMovieData()

	self.chooseTimer_ = nil
end

function LoginBrahmaBonusView:InitMovieData()
	self.moviePath_ = {}
	self.movieTotalFrames_ = {}

	for iter_4_0 = 1, 5 do
		table.insert(self.moviePath_, GameDisplayCfg.login_bonus_movie_path.value[iter_4_0])

		self.movieTotalFrames_[iter_4_0] = GameDisplayCfg.login_bonus_movie_frames.value[iter_4_0]
	end

	self.criplayer_:SetVolume(manager.audio:GetEffectVolume())
	self:SetVideoTrack(self.criplayer_, GameDisplayCfg.login_bonus_movie_path.value[1])
	self.criplayer_:SetBufferingTime(0.033)
	self.criplayer2_:SetVolume(manager.audio:GetEffectVolume())
	self:SetVideoTrack(self.criplayer2_, GameDisplayCfg.login_bonus_movie_path.value[3])
	self.criplayer2_:SetBufferingTime(0.033)
	SetFile(self.criplayer_, nil, self.moviePath_[1], CriMana.Player.SetMode.New)
	SetFile(self.criplayer_, nil, self.moviePath_[2], CriMana.Player.SetMode.AppendRepeatedly)
end

function LoginBrahmaBonusView:AddListeners()
	self:AddBtnListener(self.nextBtn_1_yes, nil, function()
		self:Choose1(1)
	end)
	self:AddBtnListener(self.nextBtn_1_no, nil, function()
		self:Choose1(2)
	end)
	self:AddBtnListener(self.nextBtn_2, nil, function()
		self:Choose2(1)
	end)
end

function LoginBrahmaBonusView:Choose1(arg_9_1)
	self:StopChooseTimer()
	LoginBonusAction.DoChoose(1, arg_9_1)
	self:StepPlayLoopMovie(2)
	SetActive(self.nextGo_1_yes, false)
	SetActive(self.nextGo_1_no, false)
end

function LoginBrahmaBonusView:Choose2(arg_10_1)
	self:StopChooseTimer()
	LoginBonusAction.DoChoose(2, arg_10_1)
	self:StepPlayExitMovie()
	SetActive(self.nextGo_2, false)
end

function LoginBrahmaBonusView:OnEnter()
	manager.audio:PlayEffect("ui_battle", "ui_battle_stopbgm")
	SetActive(self.nextGo_1_yes, false)
	SetActive(self.nextGo_1_no, false)
	SetActive(self.nextGo_2, false)
	self:StepPlayLoopMovie(1)
end

function LoginBrahmaBonusView:OnExit()
	if self._timer then
		self._timer:Stop()

		self._timer = nil
	end

	if self._timer2 then
		self._timer2:Stop()

		self._timer2 = nil
	end

	if self._startTimer2 then
		self._startTimer2:Stop()

		self._startTimer2 = nil
	end

	if self._startTimer3 then
		self._startTimer3:Stop()

		self._startTimer3 = nil
	end
end

function LoginBrahmaBonusView:Dispose()
	LoginBrahmaBonusView.super.Dispose(self)
end

function LoginBrahmaBonusView:StatusChangeCallback(arg_14_1)
	local var_14_0 = tostring(arg_14_1)

	if var_14_0 == "PlayEnd" then
		self:OnMovieEnd(3)
	elseif var_14_0 == "Playing" then
		-- block empty
	end
end

function LoginBrahmaBonusView:OnMovieEnd(arg_15_1)
	if arg_15_1 == 1 then
		SetActive(self.nextGo_1_yes, true)
		SetActive(self.nextGo_1_no, true)
		self:CreateChooseTimer(function()
			self:Choose1(0)
		end, 10)
	elseif arg_15_1 == 2 then
		SetActive(self.nextGo_2, true)
		self:CreateChooseTimer(function()
			self:Choose2(0)
		end, 10)
	elseif arg_15_1 == 3 then
		self:JumpToLoginPage()
	end
end

function LoginBrahmaBonusView:StepPlayLoopMovie(arg_18_1)
	LoginBonusAction.EnterState(arg_18_1)

	if arg_18_1 == 1 then
		self.criManaMovieController_:Play()

		self._timer = FrameTimer.New(function()
			if self.criplayer_:GetDisplayedFrameNo() >= self.movieTotalFrames_[1] then
				self:OnMovieEnd(1)
				self._timer:Stop()

				self._timer = nil
			end
		end, 1, -1)

		self._timer:Start()
	elseif arg_18_1 == 2 then
		SetFile(self.criplayer2_, nil, self.moviePath_[3], CriMana.Player.SetMode.New)
		SetFile(self.criplayer2_, nil, self.moviePath_[4], CriMana.Player.SetMode.AppendRepeatedly)
		self.criManaMovieController2_:Play()

		self._startTimer2 = FrameTimer.New(function()
			if self.criplayer2_:GetDisplayedFrameNo() >= 1 then
				self.movie2Go_.transform.localPosition = Vector2(0, 0)
				self.movieGo_.transform.localPosition = Vector2(9999, 9999)

				self.criManaMovieController_:Stop()
				self._startTimer2:Stop()

				self._startTimer2 = nil
			end
		end, 1, -1)

		self._startTimer2:Start()

		self._timer2 = FrameTimer.New(function()
			if self.criplayer2_:GetDisplayedFrameNo() >= self.movieTotalFrames_[3] then
				self:OnMovieEnd(2)
				self._timer2:Stop()

				self._timer2 = nil
			end
		end, 1, -1)

		self._timer2:Start()
	end
end

function LoginBrahmaBonusView:StepPlayExitMovie()
	LoginBonusAction.EnterState(3)
	SetFile(self.criplayer_, nil, self.moviePath_[5], CriMana.Player.SetMode.New)

	self.criplayer_.statusChangeCallback = handler(self, self.StatusChangeCallback)

	self.criManaMovieController_:Play()

	self._startTimer3 = FrameTimer.New(function()
		if self.criplayer_:GetDisplayedFrameNo() >= 1 then
			self.movieGo_.transform.localPosition = Vector2(0, 0)
			self.movie2Go_.transform.localPosition = Vector2(9999, 9999)

			self.criManaMovieController2_:Stop()
			self._startTimer3:Stop()

			self._startTimer3 = nil
		end
	end, 1, -1)

	self._startTimer3:Start()
end

function LoginBrahmaBonusView:JumpToLoginPage()
	gameContext:ClearHistory()
	PreLoadAssetByPlayer()
end

function LoginBrahmaBonusView:CreateChooseTimer(arg_25_1, arg_25_2)
	self:StopChooseTimer()

	self.chooseTimer_ = Timer.New(arg_25_1, arg_25_2, 1)

	self.chooseTimer_:Start()
end

function LoginBrahmaBonusView:StopChooseTimer()
	if self.chooseTimer_ then
		self.chooseTimer_:Stop()

		self.chooseTimer_ = nil
	end
end

function LoginBrahmaBonusView:Cacheable()
	return false
end

function LoginBrahmaBonusView:SetVideoTrack(arg_28_1, arg_28_2)
	local var_28_0 = manager.video:GetVedioTrackIndex(arg_28_2)

	arg_28_1:SetAudioTrack(var_28_0)
	arg_28_1:SetSubtitleChannel(var_28_0)
end

return LoginBrahmaBonusView
