local StoryPlayBackgroundVideoNode = class("StoryPlayBackgroundVideoNode", require("manager/story/StoryPlayNode/StoryPlayBaseNode"))

function StoryPlayBackgroundVideoNode:OnCtor(arg_1_1)
	self.isPlay_ = true
	self.playMode_ = StoryPlayerConst.BACKGROUND_VIDEO_PLAY_MODE.ONCE
	self.videoPath_ = ""
	self.partLoopVideoPath_ = ""
	self.videoStopMode_ = StoryPlayerConst.BACKGROUND_VIDEO_STOP_MODE.MANUAL
end

function StoryPlayBackgroundVideoNode:SetConfig(arg_2_1)
	StoryPlayBackgroundVideoNode.super.SetConfig(self, arg_2_1)

	self.isPlay_ = arg_2_1.isPlay
	self.playMode_ = arg_2_1.playMode
	self.videoPath_ = arg_2_1.videoPath
	self.partLoopVideoPath_ = arg_2_1.partLoopVideoPath
	self.videoStopMode_ = arg_2_1.videoStopMode
end

function StoryPlayBackgroundVideoNode:OnPlay()
	self.criManaMovieController_, self.needReplaceShader_ = self.storyPlayer_:GetBackgroundVideoController()
	self.criplayer_ = self.criManaMovieController_.player

	if self.isPlay_ then
		if self.needReplaceShader_ then
			self:PlayVideoDelayFrame()

			self.hasDelayPlay_ = true
		else
			self:PlayVideo()
		end
	else
		self:StopVideo()
	end
end

function StoryPlayBackgroundVideoNode:PlayVideoDelayFrame()
	FrameTimer.New(function()
		self:PlayVideo()
	end, 1, 1):Start()
end

function StoryPlayBackgroundVideoNode:PlayVideo()
	if not self.videoPath_ or self.videoPath_ == "" then
		if not self.hasDelayPlay_ then
			self.hasDelayPlay_ = false

			Debug.LogError("videoPath is nil")
		end

		return
	end

	if self.playMode_ == StoryPlayerConst.BACKGROUND_VIDEO_PLAY_MODE.ONCE then
		self:SetupVideo(self.videoPath_, false, CriMana.Player.SetMode.New)
	elseif self.playMode_ == StoryPlayerConst.BACKGROUND_VIDEO_PLAY_MODE.LOOP then
		self:SetupVideo(self.videoPath_, true, CriMana.Player.SetMode.New)
	elseif self.playMode_ == StoryPlayerConst.BACKGROUND_VIDEO_PLAY_MODE.PART_LOOP then
		self.criplayer_:SetMaxPictureDataSize(300000)
		self:SetupVideo(self.videoPath_, true, CriMana.Player.SetMode.New)
		self:SetupVideo(self.partLoopVideoPath_, false, CriMana.Player.SetMode.AppendRepeatedly)
	end

	self.musicVolume_ = manager.audio:GetMusicVolume()

	self.criplayer_:SetVolume(self.musicVolume_)
	self.criManaMovieController_:Play()
end

function StoryPlayBackgroundVideoNode:SetupVideo(arg_7_1, arg_7_2, arg_7_3)
	manager.video:SetAudioTrack(self.criplayer_, arg_7_1)
	self.criplayer_:Loop(arg_7_2)
	SetFile(self.criplayer_, nil, manager.video:GetI18NVideoPath(arg_7_1), arg_7_3)
end

function StoryPlayBackgroundVideoNode:StopVideo()
	if self.criManaMovieController_ and self.criManaMovieController_.player then
		self.criManaMovieController_:Stop()
	end

	self.storyPlayer_:RetureBackgroundVideoController()
end

function StoryPlayBackgroundVideoNode:OnPause()
	self.criManaMovieController_:Pause(true)
end

function StoryPlayBackgroundVideoNode:OnResume()
	self.criManaMovieController_:Pause(false)
end

function StoryPlayBackgroundVideoNode:OnFinish()
	if self.playMode_ == StoryPlayerConst.BACKGROUND_VIDEO_PLAY_MODE.ONCE and self.videoStopMode_ == StoryPlayerConst.BACKGROUND_VIDEO_STOP_MODE.MOVIE_END then
		self:StopVideo()
	end
end

function StoryPlayBackgroundVideoNode:OnDispose()
	self:StopVideo()
end

return StoryPlayBackgroundVideoNode
