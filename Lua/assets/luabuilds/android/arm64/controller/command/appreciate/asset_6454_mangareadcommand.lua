local MangaReadCommand = class("MangaReadCommand", pm.SimpleCommand)

function MangaReadCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.mangaID
	local var_1_2 = var_1_0.mangaCB
	local var_1_3 = getProxy(AppreciateProxy)

	print("17509 Send Manga ID", var_1_0.mangaID)
	pg.ConnectionMgr.GetInstance():Send(17509, {
		id = var_1_0.mangaID
	}, 17510, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_3:addMangaIDToReadList(var_1_1)

			if var_1_2 then
				var_1_2()
			end

			self:sendNotification(GAME.APPRECIATE_MANGA_READ_DONE, {
				mangaID = var_1_1
			})
		else
			pg.TipsMgr.GetInstance():ShowTips("17510 Manga Read Fail" .. tostring(arg_2_0.result))
		end

		return
	end)

	return
end

return MangaReadCommand
