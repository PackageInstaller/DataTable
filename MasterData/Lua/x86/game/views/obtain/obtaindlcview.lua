local ObtainDLCView = class("ObtainDLCView", require("game.views.obtain.ObtainBaseView"))

function ObtainDLCView:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	self.transform_ = self.gameObject_.transform
end

function ObtainDLCView:Init()
	self:InitUI()
	ObtainDLCView.super.Init(self)
end

function ObtainDLCView:InitUI()
	self:BindCfgUI()

	self.criMovie_ = self.movie_:GetComponent("CriManaMovieControllerForUI")
	self.criplayer_ = self.criMovie_.player

	self.criplayer_:SetMaxPictureDataSize(300000)
end

function ObtainDLCView:OnClick()
	return true
end

function ObtainDLCView:Show(arg_5_1)
	self.item = arg_5_1

	if self.gameObject_ then
		SetActive(self.gameObject_, true)
	end

	local var_5_0 = ItemCfg[arg_5_1.id]

	for iter_5_0, iter_5_1 in ipairs(SkinSceneActionCfg.all) do
		if SkinSceneActionCfg[iter_5_1].special_scene_id == var_5_0.param[1] then
			self.start_path = SkinSceneActionCfg[iter_5_1].start_path

			self.criMovie_:Stop()
			DownloadSingleAssetQuanquan(self.start_path, function()
				if tostring(self.criplayer_.status) ~= "Stop" then
					self.stopTimer_ = Timer.New(function()
						if tostring(self.criplayer_.status) == "Stop" then
							self:Play()
							self:StopMovieStopTimer()

							return
						end
					end, 0.033, -1)

					self.stopTimer_:Start()
				else
					self:Play()
				end
			end, function()
				print("ObtainDLCView Download Fail")
			end)

			break
		end
	end
end

function ObtainDLCView:SetVideoTrack(arg_9_1, arg_9_2)
	local var_9_0 = manager.video:GetVedioTrackIndex(arg_9_2)

	arg_9_1:SetAudioTrack(var_9_0)
	arg_9_1:SetSubtitleChannel(var_9_0)
end

function ObtainDLCView:Play()
	SetFile(self.criplayer_, nil, self.start_path, CriMana.Player.SetMode.New)
	SetFile(self.criplayer_, nil, self.start_path, CriMana.Player.SetMode.AppendRepeatedly)
	self.criplayer_:SetVolume((manager.audio:GetMusicVolume()))
	self:SetVideoTrack(self.criplayer_, self.start_path)
	self.criMovie_:Play()
end

function ObtainDLCView:Dispose()
	self:StopMovieStopTimer()
	ObtainDLCView.super.Dispose(self)
end

function ObtainDLCView:Hide()
	manager.audio:StopVoice()
	self.criMovie_:Stop()
	self:StopMovieStopTimer()
	ObtainBaseView.Hide(self)
end

function ObtainDLCView:StopMovieStopTimer()
	if self.stopTimer_ then
		self.stopTimer_:Stop()

		self.stopTimer_ = nil
	end
end

function ObtainDLCView:NeedHideShare()
	return true
end

return ObtainDLCView
