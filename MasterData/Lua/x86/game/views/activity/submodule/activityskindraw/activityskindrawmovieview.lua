local ActivitySkinDrawMovieView = class("ActivitySkinDrawMovieView", ReduxView)

function ActivitySkinDrawMovieView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ActivitySkinDrawMovieView:Init()
	self:InitUI()
	self:AddBtnListeners()
end

function ActivitySkinDrawMovieView:InitUI()
	self:BindCfgUI()
end

function ActivitySkinDrawMovieView:AddBtnListeners()
	return
end

function ActivitySkinDrawMovieView:OnEnter()
	return
end

function ActivitySkinDrawMovieView:SetData(arg_6_1, arg_6_2)
	SetActive(self.gameObject_, true)

	self.itemID_ = ActivityLimitedDrawPoolCfg[arg_6_1].reward[1][1]

	if ActivitySkinDrawTools.GetIsSkinGift(self.itemID_) then
		self.itemID_ = ItemCfg[self.itemID_].param[1][1]
	end

	self.backcall_ = arg_6_2
	self.movieCfg_ = ObtainSkinMovieCfg[self.itemID_]
	self.moviePath_ = self.movieCfg_.start_path
	self.criMovie_ = self.movie_:GetComponent("CriManaMovieControllerForUI")
	self.criplayer_ = self.criMovie_.player
	self.isPlayMovie_ = false
	self.isPlayMovieEnd_ = false

	self.criMovie_:Stop()

	self.movieTrs_.localPosition = Vector2(9999, 9999)

	SetFile(self.criplayer_, nil, self.moviePath_, CriMana.Player.SetMode.New)
	self.criplayer_:SetVolume((manager.audio:GetMusicVolume()))
	self:SetVideoTrack(self.criplayer_, self.moviePath_)
	self:StopTimer()

	self.timer_ = FrameTimer.New(handler(self, self.MovieProcess), 1, -1)

	self:PlayMovie()
end

function ActivitySkinDrawMovieView:SetVideoTrack(arg_7_1, arg_7_2)
	local var_7_0 = manager.video:GetVedioTrackIndex(arg_7_2)

	arg_7_1:SetAudioTrack(var_7_0)
	arg_7_1:SetSubtitleChannel(var_7_0)
end

function ActivitySkinDrawMovieView:PlayMovie(arg_8_1)
	if self.isPlayMovie_ then
		if arg_8_1 then
			self.isPlayMovieEnd_ = true

			self.criMovie_:Stop()

			self.movieTrs_.localPosition = Vector2(9999, 9999)

			self:Hide()

			if self.backcall_ then
				self.backcall_()
			end
		end

		return
	end

	manager.audio:PlayVoice(string.format("vo_sys_%d", self.itemID_), string.format("skin_v_getvideo_%d_%s", self.itemID_, "get"), string.format("vo_sys_%d.awb", self.itemID_))

	self.isPlayMovie_ = true

	if arg_8_1 then
		self:Hide()

		if self.backcall_ then
			self.backcall_()
		end
	else
		self.criMovie_:Play()

		self.movieTrs_.localPosition = Vector2(0, 0)
	end

	self.timer_:Start()
end

function ActivitySkinDrawMovieView:MovieProcess()
	if tostring(self.criplayer_.status) == "Playing" and self.criplayer_:GetDisplayedFrameNo() > self.movieCfg_.end_movie_frames then
		self.timer_:Stop()

		self.isPlayMovieEnd_ = true

		self:Hide()

		if self.backcall_ then
			self.backcall_()
		end
	end
end

function ActivitySkinDrawMovieView:Hide()
	SetActive(self.gameObject_, false)
	manager.audio:StopVoice()
	self:StopTimer()
end

function ActivitySkinDrawMovieView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ActivitySkinDrawMovieView:OnExit()
	self.backcall_ = nil

	self:StopTimer()
end

function ActivitySkinDrawMovieView:Dispose()
	self:RemoveAllListeners()
	self.super.Dispose(self)
end

return ActivitySkinDrawMovieView
