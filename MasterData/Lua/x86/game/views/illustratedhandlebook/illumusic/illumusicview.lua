local IlluMusicView = class("IlluMusicView", ReduxView)

function IlluMusicView:UIName()
	return "Widget/System/IllustratedHandbook/IlluMusicAlbumUI"
end

function IlluMusicView:UIParent()
	return manager.ui.uiMain.transform
end

function IlluMusicView:Init()
	self:InitUI()
	self:AddUIListener()
end

function IlluMusicView:InitUI()
	self:BindCfgUI()

	self.common_list = LuaList.New(handler(self, self.IndexCommonItem), self.m_common_list, IlluMusicAlbumItem)
	self.detail_list = LuaList.New(handler(self, self.IndexDetailItem), self.m_detail_list, IlluMusicInfoItem)
	self.isInDertails = false
	self.pauseController = ControllerUtil.GetController(self.transform_, "pause")
	self.bgmController = ControllerUtil.GetController(self.transform_, "bgm")
	self.statusController = ControllerUtil.GetController(self.transform_, "status")

	SetActive(self.m_musicName.gameObject, false)
	SetActive(self.m_author.gameObject, false)
	TimeTools.StartAfterSeconds(0.1, function()
		self.m_musicName.alignment = UnityEngine.TextAnchor.MiddleLeft
		self.m_author.alignment = UnityEngine.TextAnchor.MiddleLeft

		SetActive(self.m_musicName.gameObject, true)
		SetActive(self.m_author.gameObject, true)
	end, {})
end

function IlluMusicView:AddUIListener()
	self.m_scroller.onValueChanged:AddListener(function()
		return
	end)
	self:AddBtnListener(self.m_nextBtn, nil, function()
		self:ChangeMusic(1)
	end)
	self:AddBtnListener(self.m_lastBtn, nil, function()
		self:ChangeMusic(-1)
	end)
	self:AddBtnListener(self.m_randomBtn, nil, function()
		self:RandomChangeMusic()
	end)
	self:AddBtnListener(self.m_musicBtn, nil, function()
		self:AnchorCurrentMusic(false)
	end)
	self:AddBtnListener(self.m_playBtn, nil, function()
		if self.player then
			self.player:Pause(false)
		end

		self:RefreshState()
	end)
	self:AddBtnListener(self.m_pauseBtn, nil, function()
		if self.player then
			self.player:Pause(true)
		end

		self:RefreshState()
	end)
	self:AddBtnListener(self.m_setBgmBtn, nil, function()
		IllustratedAction.QuerySetBgm(self.music_id)
	end)
	self:AddBtnListener(self.m_detailMask, nil, function()
		self:SwitchToCommon()
	end)
	self:AddBtnListener(self.m_mask, nil, function()
		self:SwitchToCommon()
	end)
	self.detail_list:SetPageChangeHandler(handler(self, self.OnDetailPageChange))
end

function IlluMusicView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function IlluMusicView:SwitchToCommon()
	if self.isInDertails then
		self.common_list:ScrollToIndex(self.pageIndex, true, false)
		SetActive(self.detailViewPort_, false)
		SetActive(self.commonViewPort_, true)

		for iter_18_0, iter_18_1 in pairs((self.common_list:GetItemList())) do
			iter_18_1:UpdateAnima(self.pageIndex)
		end

		self.isInDertails = false
	end
end

function IlluMusicView:OnDetailPageChange(arg_19_1)
	if arg_19_1 <= #self.albums then
		self.pageIndex = arg_19_1

		for iter_19_0, iter_19_1 in pairs((self.detail_list:GetItemList())) do
			iter_19_1:UpdateState(self.pageIndex)
		end
	end
end

function IlluMusicView:OnCommonPageChange(arg_20_1)
	return
end

function IlluMusicView:OnEnter()
	self.player = manager.audio:GetBgmPlayer()
	self.music_id = self:GetMusicId()

	self:RefreshState()

	self.albums = MusicAlbumRecordCfg.all

	SetActive(self.detailViewPort_, false)
	SetActive(self.commonViewPort_, true)

	self.isInDertails = false
	self.pageIndex = table.indexof(self.albums, MusicRecordCfg[self.music_id].album) or 1

	self.common_list:StartScroll(#self.albums, self.pageIndex, true, false)
	self.detail_list:StartScroll(#self.albums, self.pageIndex, true, false)
end

function IlluMusicView:OnExit()
	manager.windowBar:HideBar()

	if self.player then
		self.player:Pause(false)
	end
end

function IlluMusicView:Dispose()
	self.common_list:Dispose()
	self.detail_list:Dispose()
	IlluMusicView.super.Dispose(self)
end

function IlluMusicView:IndexCommonItem(arg_24_1, arg_24_2)
	arg_24_2:SetData(self.albums[arg_24_1], self.music_id, arg_24_1)
	arg_24_2:RegistCallBack(handler(self, self.OnAlbumClick))
end

function IlluMusicView:IndexDetailItem(arg_25_1, arg_25_2)
	arg_25_2:SetData(self.albums[arg_25_1], self.music_id, arg_25_1)
	arg_25_2:UpdateState(self.pageIndex)
	arg_25_2:RegistCallBack(handler(self, self.PlayMusic))
	arg_25_2:RegistMaskCallBack(handler(self, self.ChangePageIndex))
	arg_25_2:RegistCdCallBack(handler(self, self.SwitchToCommon))
end

function IlluMusicView:ChangePageIndex(arg_26_1)
	self.detail_list:SwitchToPage(arg_26_1)
end

function IlluMusicView:OnAlbumClick(arg_27_1)
	if arg_27_1 == self.pageIndex and self.isInDertails then
		return
	end

	SetActive(self.detailViewPort_, true)
	SetActive(self.commonViewPort_, false)

	self.isInDertails = true
	self.pageIndex = arg_27_1

	self.detail_list:ScrollToIndex(self.pageIndex, true, false)

	for iter_27_0, iter_27_1 in pairs((self.detail_list:GetItemList())) do
		iter_27_1:UpdateAnima(self.pageIndex)
	end

	self:OnDetailPageChange(self.pageIndex)
end

function IlluMusicView:GetMusicId()
	local var_28_0 = GetHomeMusicID()

	if var_28_0 ~= 0 and MusicRecordCfg[var_28_0] then
		return var_28_0
	else
		if self.player then
			local var_28_1 = self.player.cueName or ""
			local var_28_2 = self.player.cueSheet or ""

			if var_28_1 ~= "" and var_28_2 ~= "" then
				for iter_28_0, iter_28_1 in ipairs(MusicRecordCfg.all) do
					if MusicRecordCfg[iter_28_1].cueName == var_28_1 and MusicRecordCfg[iter_28_1].cuesheet == var_28_2 then
						return iter_28_1
					end
				end
			end
		end

		return MusicRecordCfg.all[1]
	end
end

function IlluMusicView:ChangeMusic(arg_29_1)
	local var_29_0 = (table.indexof(MusicRecordCfg.get_id_list_by_album[MusicRecordCfg[self.music_id].album], self.music_id) + #MusicRecordCfg.get_id_list_by_album[MusicRecordCfg[self.music_id].album] + arg_29_1) % #MusicRecordCfg.get_id_list_by_album[MusicRecordCfg[self.music_id].album]

	if var_29_0 == 0 then
		var_29_0 = #MusicRecordCfg.get_id_list_by_album[MusicRecordCfg[self.music_id].album]
	end

	self:PlayMusic(MusicRecordCfg.get_id_list_by_album[MusicRecordCfg[self.music_id].album][var_29_0])
end

function IlluMusicView:RandomChangeMusic()
	self:PlayMusic(MusicRecordCfg.all[math.random(#MusicRecordCfg.all)])
	self:AnchorCurrentMusic(false)
end

function IlluMusicView:AnchorCurrentMusic(arg_31_1)
	self.pageIndex = table.indexof(self.albums, MusicRecordCfg[self.music_id].album) or 1

	self.common_list:ScrollToIndex(self.pageIndex, true, arg_31_1)
	self.detail_list:ScrollToIndex(self.pageIndex, true, arg_31_1)
	self:OnAlbumClick(self.pageIndex, true)
	self.detail_list:GetItemList()[self.pageIndex]:JumpToSong(self.music_id)
end

function IlluMusicView:PlayMusic(arg_32_1)
	if arg_32_1 == self.music_id then
		return
	end

	manager.audio:StopBgmImmediate()

	self.music_id = arg_32_1

	if self.player then
		self.player:Pause(false)

		for iter_32_0, iter_32_1 in pairs((MusicData:GetAisacSet(self.music_id))) do
			AudioManager.Instance:SetAisacControlOfCategory("music", iter_32_0, iter_32_1)
		end
	end

	manager.audio:PlayBGM(MusicRecordCfg[self.music_id].cuesheet, MusicRecordCfg[self.music_id].cueName, MusicRecordCfg[self.music_id].awbName)
	self:RefreshState()
end

function IlluMusicView:RefreshState()
	if self.player and not self.player:IsPaused() then
		self.pauseController:SetSelectedIndex(0)
	else
		self.pauseController:SetSelectedIndex(1)
	end

	local var_33_0 = MusicRecordCfg[self.music_id]

	self.m_musicName.text = GetI18NText(MusicRecordCfg[self.music_id].musicName)
	self.m_author.text = GetI18NText(var_33_0.authorName)

	for iter_33_0, iter_33_1 in pairs((self.detail_list:GetItemList())) do
		iter_33_1:RefreshSongsState(self.music_id)
	end

	if self.music_id == GetHomeMusicID() then
		self.bgmController:SetSelectedIndex(0)
	elseif var_33_0.ableBGM == 1 then
		self.bgmController:SetSelectedIndex(1)
	else
		self.bgmController:SetSelectedIndex(2)
	end
end

function IlluMusicView:OnSetBgmSuccess()
	self:RefreshState()
end

return IlluMusicView
