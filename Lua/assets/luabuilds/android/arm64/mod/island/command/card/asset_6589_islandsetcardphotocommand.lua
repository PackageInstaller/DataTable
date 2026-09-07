local IslandSetCardPhotoCommand = class("IslandSetCardPhotoCommand", pm.SimpleCommand)

function IslandSetCardPhotoCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.photo

	pg.ConnectionMgr.GetInstance():Send(21328, {
		type = var_1_0.type,
		picture = var_1_0.photo
	}, 21329, function(arg_2_0)
		if arg_2_0.result == 0 then
			self:sendNotification(GAME.ISLAND_SET_CARD_PHOTO_DONE, {
				photo = var_1_1
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return IslandSetCardPhotoCommand
