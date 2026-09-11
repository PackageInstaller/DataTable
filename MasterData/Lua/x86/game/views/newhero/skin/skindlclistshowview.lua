SkinDlcShowView = import("game.views.newHero.skin.SkinDlcShowView")

local SkinDlcShowListView = class("SkinDlcShowListView", SkinDlcShowView)

function SkinDlcShowListView:AddUIListener()
	self:AddBtnListener(self.skipBtn_, nil, function()
		self.criMovie_:Stop()
	end)
end

function SkinDlcShowListView:OnTop()
	manager.windowBar:SwitchBar({})
end

function SkinDlcShowListView:OnEnter()
	self.dlcPlayList_ = self.params_.dlcPlayList
	self.callBack = self.params_.callBack
	self.params_.callBack = nil
	self.index_ = 1

	self:SetData()
end

function SkinDlcShowListView:SetData()
	local var_5_1 = self.dlcPlayList_[self.index_].start_path

	if not self.dlcPlayList_[self.index_].start_path then
		local var_5_2 = getShopCfg((self.dlcPlayList_[self.index_].dlcId or nil) and self.dlcPlayList_[self.index_].dlcId)
		local var_5_3

		if var_5_2 then
			var_5_3 = var_5_2.give_id or var_5_2.description
		end

		local var_5_8 = var_5_2 and var_5_2.description and RechargeShopDescriptionCfg[var_5_2.description] or var_5_2 and ItemCfg[var_5_3] or ItemCfg[self.dlcPlayList_[self.index_].dlcItemID]

		for iter_5_0, iter_5_1 in ipairs(SkinSceneActionCfg.all) do
			if SkinSceneActionCfg[iter_5_1].special_scene_id == var_5_8.param[1] then
				self.start_path = SkinSceneActionCfg[iter_5_1].start_path

				self:Play()

				break
			end
		end
	else
		DownloadSingleAssetQuanquan(self.dlcPlayList_[self.index_].start_path, function()
			self.start_path = var_5_1

			self:Play()
		end)
	end
end

function SkinDlcShowListView:OnExit()
	if self.callBack then
		self.callBack()

		self.callBack = nil
	end

	self.criplayer_.statusChangeCallback = nil

	self.criMovie_:Stop()
	manager.windowBar:HideBar()
end

function SkinDlcShowListView:Play()
	SetFile(self.criplayer_, nil, self.start_path, CriMana.Player.SetMode.New)
	self.criplayer_:SetVolume((manager.audio:GetMusicVolume()))
	self:SetVideoTrack(self.criplayer_, self.start_path)
	self.criMovie_:Play()

	self.criplayer_.statusChangeCallback = self.criplayer_.statusChangeCallback or handler(self, self.CirMovieStatusChange)
end

function SkinDlcShowListView:CirMovieStatusChange(arg_9_1)
	local var_9_0 = tostring(arg_9_1)

	if var_9_0 == "PlayEnd" or var_9_0 == "Stop" then
		self:DoNextDLC()
	end
end

function SkinDlcShowListView:DoNextDLC()
	if self.index_ >= #self.dlcPlayList_ then
		self:Back()
	else
		self.index_ = self.index_ + 1

		self:SetData()
	end
end

return SkinDlcShowListView
