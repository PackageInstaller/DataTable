class = var_0_10000

local var_0_0 = "MusicMainPlayAlbumChangeCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().albumName

	getProxy = var_1_10004
	AppreciateProxy = var_1_10005

	local var_1_1 = var_1_10004(var_1_10005)
	local var_1_2

	if not (var_1_0 == "none" and 0 or var_1_0 == "favor" and 999 or var_1_1:getAlbumMusicList(var_1_0)[1]) then
		return
	end

	pg = var_1_10006

	local var_1_3 = var_1_10006.ConnectionMgr.GetInstance()

	var_6.Send(var_1_3, 17513, {
		music_no = var_5,
		music_mode = var_1_1.musicPlayerLoopType
	}, 17514, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			local var_2_0 = var_1_1

			var_2_2.setMainPlayMusicAlbum(var_2_0, var_0)

			local var_2_1 = arg_1_0

			var_2_2 = var_2_2.sendNotification
			GAME = var_2_10003

			var_2_2(var_2_1, var_2_10003.APPRECIATE_CHANGE_MAIN_PLAY_ALBUM_DONE)
		else
			pg = var_2_2

			local var_2_3 = var_2_2.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_4(var_2_3, var_2_10003("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
