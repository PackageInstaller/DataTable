IlluMusicInfoItem = import("game.views.IllustratedHandleBook.IlluMusic.IlluMusicInfoItem")

local var_0_0 = class("VolumeMusicMainItem", IlluMusicInfoItem)

function var_0_0.InitUI(arg_1_0)
	var_0_0.super.InitUI(arg_1_0)
	arg_1_0.m_animator:Play("detail_item_off", -1, 1)
end

function var_0_0.AddUIListener(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.m_btn, nil, function()
		if arg_2_0.clickFunc2 then
			arg_2_0.clickFunc2(arg_2_0.index)
		end
	end)
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.index = arg_4_3
	arg_4_0.music_id = arg_4_2

	if arg_4_0.album == arg_4_1 then
		return
	end

	arg_4_0.album = arg_4_1

	local var_4_0 = MusicAlbumRecordCfg[arg_4_1]

	arg_4_0.m_icon.spriteSync = "TextureConfig/IllustratedHandbook/musicCD/" .. var_4_0.cover
	arg_4_0.songs = MusicRecordCfg.get_id_list_by_album[arg_4_0.album] or {}
	arg_4_0.m_verName.text = GetI18NText(var_4_0.verName)
	arg_4_0.m_albumName.text = GetI18NText(var_4_0.albumName)
end

function var_0_0.RegistCallBack(arg_5_0, arg_5_1)
	arg_5_0.clickFunc2 = arg_5_1
end

function var_0_0.UpdateAnima(arg_6_0, arg_6_1)
	if arg_6_1 == arg_6_0.index then
		arg_6_0.m_animator:Play("detail_item_off", -1, 0)
	else
		arg_6_0.m_animator:Play("detail_item_off", -1, 1)
	end
end

return var_0_0
