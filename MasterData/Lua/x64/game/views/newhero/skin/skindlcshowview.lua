local SkinDlcShowView = class("SkinDlcShowView", ReduxView)

function SkinDlcShowView:UIName()
	return "Widget/System/Hero/SkinDlcShowUI"
end

function SkinDlcShowView:UIParent()
	return manager.ui.uiMain.transform
end

function SkinDlcShowView:Init()
	self:InitUI()
	self:AddUIListener()
end

function SkinDlcShowView:InitUI()
	self:BindCfgUI()

	self.criMovie_ = self.movie_:GetComponent("CriManaMovieControllerForUI")
	self.criplayer_ = self.criMovie_.player

	self.criplayer_:SetMaxPictureDataSize(300000)
end

function SkinDlcShowView:AddUIListener()
	self:AddBtnListener(self.skipBtn_, nil, function()
		self:Back()
	end)
end

function SkinDlcShowView:OnTop()
	manager.windowBar:SwitchBar({})
end

function SkinDlcShowView:OnEnter()
	self.callBack = self.params_.callBack
	self.params_.callBack = nil

	local var_8_0 = self.params_.start_path

	if not self.params_.start_path then
		if self.params_.dlcId then
			self.params_.dlcId = nil
		end

		local var_8_2 = getShopCfg(self.params_.goodId)
		local var_8_3

		if var_8_2 then
			var_8_3 = var_8_2.give_id or var_8_2.description
		end

		local var_8_8 = var_8_2 and var_8_2.description and RechargeShopDescriptionCfg[var_8_2.description] or var_8_2 and ItemCfg[var_8_3] or ItemCfg[self.params_.dlcItemID]

		for iter_8_0, iter_8_1 in ipairs(SkinSceneActionCfg.all) do
			local var_8_10 = SkinSceneActionCfg[iter_8_1]

			if SkinSceneActionCfg[iter_8_1].special_scene_id == var_8_8.param[1] then
				DownloadSingleAssetQuanquan(SkinSceneActionCfg[iter_8_1].start_path, function()
					self.start_path = var_8_10.start_path

					self:Play()
				end)

				break
			end
		end
	else
		DownloadSingleAssetQuanquan(self.params_.start_path, function()
			self.start_path = var_8_0

			self:Play()
		end)
	end
end

function SkinDlcShowView:OnExit()
	if self.callBack then
		self.callBack()

		self.callBack = nil
	end

	self.criplayer_.statusChangeCallback = nil

	self.criMovie_:Stop()
	manager.windowBar:HideBar()
end

function SkinDlcShowView:CirMovieStatusChange(arg_12_1)
	local var_12_0 = tostring(arg_12_1)

	if var_12_0 == "PlayEnd" or var_12_0 == "Stop" then
		self:Back()
	end
end

function SkinDlcShowView:Play()
	SetFile(self.criplayer_, nil, self.start_path, CriMana.Player.SetMode.New)
	self.criplayer_:SetVolume((manager.audio:GetMusicVolume()))
	self:SetVideoTrack(self.criplayer_, self.start_path)
	self.criMovie_:Play()

	self.criplayer_.statusChangeCallback = handler(self, self.CirMovieStatusChange)
end

function SkinDlcShowView:SetVideoTrack(arg_14_1, arg_14_2)
	local var_14_0 = manager.video:GetVedioTrackIndex(arg_14_2)

	arg_14_1:SetAudioTrack(var_14_0)
	arg_14_1:SetSubtitleChannel(var_14_0)
end

function SkinDlcShowView:Dispose()
	SkinDlcShowView.super.Dispose(self)
end

return SkinDlcShowView
