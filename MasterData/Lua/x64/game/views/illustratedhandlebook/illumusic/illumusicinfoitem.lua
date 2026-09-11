local IlluMusicInfoItem = class("IlluMusicInfoItem", ReduxView)

function IlluMusicInfoItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function IlluMusicInfoItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function IlluMusicInfoItem:InitUI()
	self:BindCfgUI()

	self.m_icon.immediate = true
	self.songItems = {}
	self.posX = {}
	self.scrollRect = self.transform_:Find("content/inform/Scroll View").gameObject:GetComponent(typeof(ScrollRectEx))
end

function IlluMusicInfoItem:AddUIListener()
	self:AddBtnListener(self.m_mask, nil, function()
		if self.maskClickFunc then
			self.maskClickFunc(self.index)
		end
	end)
	self:AddBtnListener(self.m_cdBtn, nil, function()
		if self.cdClickFunc then
			self.cdClickFunc()
		end
	end)
end

function IlluMusicInfoItem:SetData(arg_7_1, arg_7_2, arg_7_3)
	self.index = arg_7_3
	self.music_id = arg_7_2

	if self.album == arg_7_1 then
		return
	end

	self.album = arg_7_1
	self.m_icon.spriteSync = "TextureConfig/IllustratedHandbook/musicCD/" .. MusicAlbumRecordCfg[arg_7_1].cover
	self.songs = MusicRecordCfg.get_id_list_by_album[self.album] or {}

	self:RefreshSongs()
	self:RefreshSongsState(arg_7_2)

	self.m_verName.text = GetI18NText(MusicAlbumRecordCfg[arg_7_1].verName)
	self.m_albumName.text = GetI18NText(MusicAlbumRecordCfg[arg_7_1].albumName)
end

function IlluMusicInfoItem:UpdateAnima(arg_8_1)
	if arg_8_1 == self.index then
		self.m_animator:Play("detail_item_on", -1, 0)
	else
		self.m_animator:Play("detail_item_on", -1, 1)
	end
end

function IlluMusicInfoItem:UpdateState(arg_9_1)
	if self.index == arg_9_1 then
		SetActive(self.m_mask.gameObject, false)
	else
		SetActive(self.m_mask.gameObject, true)
	end
end

function IlluMusicInfoItem:RefreshSongs()
	for iter_10_0, iter_10_1 in ipairs(self.songs) do
		self.songItems[iter_10_0] = self.songItems[iter_10_0] or IlluMusicSongItem.New(Object.Instantiate(self.m_songItem, self.m_songContent), self)

		self.songItems[iter_10_0]:SetActive(true)
		self.songItems[iter_10_0]:RefreshUI(iter_10_1)
	end

	for iter_10_2 = #self.songs + 1, #self.songItems do
		self.songItems[iter_10_2]:SetActive(false)
	end
end

function IlluMusicInfoItem:RefreshSongsState(arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(self.songItems) do
		iter_11_1:RefreshSongsState(arg_11_1)
	end
end

function IlluMusicInfoItem:GetSongsIndex(arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(self.songItems) do
		if iter_12_1:GetMusicId() == arg_12_1 then
			return iter_12_0
		end
	end

	return 1
end

function IlluMusicInfoItem:RegistCallBack(arg_13_1)
	self.clickFunc = arg_13_1
end

function IlluMusicInfoItem:PlayMusic(arg_14_1)
	if self.clickFunc then
		self.clickFunc(arg_14_1)
	end
end

function IlluMusicInfoItem:RegistMaskCallBack(arg_15_1)
	self.maskClickFunc = arg_15_1
end

function IlluMusicInfoItem:RegistCdCallBack(arg_16_1)
	self.cdClickFunc = arg_16_1
end

function IlluMusicInfoItem:JumpToSong(arg_17_1)
	local var_17_0 = self.songItems[self:GetSongsIndex(arg_17_1)]

	self.scrollRect:SetVerticalAnchoredPositionInter(-var_17_0:GetAnchoredPosition().y)
	var_17_0:SetExpand(true)
end

function IlluMusicInfoItem:ForceRebuild()
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_songContent)
end

function IlluMusicInfoItem:Dispose()
	for iter_19_0, iter_19_1 in ipairs(self.songItems) do
		iter_19_1:Dispose()
	end

	self.songItems = {}

	IlluMusicInfoItem.super.Dispose(self)
end

return IlluMusicInfoItem
