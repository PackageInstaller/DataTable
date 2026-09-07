local GetRemasterCommand = class("GetRemasterCommand", pm.SimpleCommand)

function GetRemasterCommand:execute(arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(13503, {
		type = 0
	}, 13504, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(ChapterProxy)

			var_2_0:updateDailyCount()

			local var_2_1 = Drop.New({
				type = DROP_TYPE_VITEM,
				id = ITEM_ID_REACT_CHAPTER_TICKET,
				count = math.min(pg.gameset.reactivity_ticket_daily.key_value, pg.gameset.reactivity_ticket_max.key_value - var_2_0.remasterTickets)
			})

			self:sendNotification(GAME.ADD_ITEM, var_2_1)
			self:sendNotification(GAME.GET_REMASTER_TICKETS_DONE, {
				var_2_1
			})
		else
			pg.TipsMgr.GetInstance():ShowTips("领取失败")
		end

		return
	end)

	return
end

return GetRemasterCommand
