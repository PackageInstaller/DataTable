local VideoShowView = class("VideoShowView", ReduxView)

function VideoShowView:UIName()
	return "Widget/System/Hero/VideoShowUI"
end

function VideoShowView:UIParent()
	return manager.ui.uiMain.transform
end

function VideoShowView:Init()
	self:InitUI()
	self:AddUIListener()

	self.maxVideoX_ = self.movie_.transform.sizeDelta.x
	self.maxVideoY_ = self.movie_.transform.sizeDelta.y
end

function VideoShowView:InitUI()
	self:BindCfgUI()

	self.criMovie_ = self.movie_:GetComponent("CriManaMovieControllerForUI")
	self.criplayer_ = self.criMovie_.player
end

function VideoShowView:AddUIListener()
	self:AddBtnListener(self.skipBtn_, nil, function()
		self:Back()
	end)
end

function VideoShowView:OnTop()
	manager.windowBar:SwitchBar({})
end

function VideoShowView:OnEnter()
	self.start_path = self.params_.start_path

	self:AdaptVideo()
	self:Play()
end

function VideoShowView:AdaptVideo()
	local var_9_0 = self.maxVideoX_
	local var_9_1 = self.maxVideoY_

	if self.maxVideoX_ / manager.ui.canvasSize_.x > 1 then
		var_9_0 = manager.ui.canvasSize_.x
		var_9_1 = var_9_1 / (self.maxVideoX_ / manager.ui.canvasSize_.x)
	elseif self.maxVideoY_ / manager.ui.canvasSize_.y > 1 then
		var_9_0 = var_9_0 / (self.maxVideoY_ / manager.ui.canvasSize_.y)
		var_9_1 = manager.ui.canvasSize_.y
	end

	self.movie_.transform.sizeDelta = Vector2(var_9_0, var_9_1)
end

function VideoShowView:Play()
	SetFile(self.criplayer_, nil, self.start_path, CriMana.Player.SetMode.New)
	self.criplayer_:SetVolume((manager.audio:GetMusicVolume()))
	self:SetVideoTrack(self.criplayer_, self.start_path)
	self.criMovie_:Play()

	self.criplayer_.statusChangeCallback = handler(self, self.CirMovieStatusChange)
end

function VideoShowView:CirMovieStatusChange(arg_11_1)
	local var_11_0 = tostring(arg_11_1)

	if var_11_0 == "PlayEnd" or var_11_0 == "Stop" then
		self:Back()
	end
end

function VideoShowView:SetVideoTrack(arg_12_1, arg_12_2)
	local var_12_0 = manager.video:GetVedioTrackIndex(arg_12_2)

	arg_12_1:SetAudioTrack(var_12_0)
	arg_12_1:SetSubtitleChannel(var_12_0)
end

function VideoShowView:OnExit()
	if self.callBack then
		self.callBack()

		self.callBack = nil
	end

	self.criplayer_.statusChangeCallback = nil

	self.criMovie_:Stop()
	manager.windowBar:HideBar()
end

function VideoShowView:Dispose()
	VideoShowView.super.Dispose(self)
end

return VideoShowView
