IlluMusicInfoItem = import("game.views.IllustratedHandleBook.IlluMusic.IlluMusicInfoItem")

local VolumeMusicMainItem = class("VolumeMusicMainItem", IlluMusicInfoItem)

function VolumeMusicMainItem:InitUI()
	VolumeMusicMainItem.super.InitUI(self)
	self.m_animator:Play("detail_item_off", -1, 1)
end

function VolumeMusicMainItem:AddUIListener()
	self:AddBtnListener(self.m_btn, nil, function()
		if self.clickFunc2 then
			self.clickFunc2(self.index)
		end
	end)
end

function VolumeMusicMainItem:SetData(arg_4_1, arg_4_2, arg_4_3)
	self.index = arg_4_3
	self.music_id = arg_4_2

	if self.album == arg_4_1 then
		return
	end

	self.album = arg_4_1
	self.m_icon.spriteSync = "TextureConfig/IllustratedHandbook/musicCD/" .. MusicAlbumRecordCfg[arg_4_1].cover
	self.songs = MusicRecordCfg.get_id_list_by_album[self.album] or {}
	self.m_verName.text = GetI18NText(MusicAlbumRecordCfg[arg_4_1].verName)
	self.m_albumName.text = GetI18NText(MusicAlbumRecordCfg[arg_4_1].albumName)
end

function VolumeMusicMainItem:RegistCallBack(arg_5_1)
	self.clickFunc2 = arg_5_1
end

function VolumeMusicMainItem:UpdateAnima(arg_6_1)
	if arg_6_1 == self.index then
		self.m_animator:Play("detail_item_off", -1, 0)
	else
		self.m_animator:Play("detail_item_off", -1, 1)
	end
end

return VolumeMusicMainItem
