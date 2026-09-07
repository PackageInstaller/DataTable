local AddChapterAutoTimeCommand = class("AddChapterAutoTimeCommand", pm.SimpleCommand)

function AddChapterAutoTimeCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.type1Num
	local var_1_2 = var_1_0.type3Num
	local var_1_3 = var_1_0.callback

	pg.ConnectionMgr.GetInstance():Send(13016, {
		ticket_num_1 = var_1_0.type1Num,
		ticket_num_3 = var_1_0.type3Num
	}, 13017, function(arg_2_0)
		if arg_2_0.result == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("auto_battle_time_add_success"))

			local var_2_0 = getProxy(ChapterAutoProxy)

			var_2_0:ReduceTicketByType(ChapterAutoTicket.TYPE.MAIN, var_1_1)
			var_2_0:ReduceTicketByType(ChapterAutoTicket.TYPE.TIME, var_1_2)
			var_2_0:AddDailyExtraTime(var_1_1 * pg.gameset.auto_battle_tickect_to_second_type1.key_value + var_1_2 * pg.gameset.auto_battle_tickect_to_second_type3.key_value)
			existCall(var_1_3)
			self:sendNotification(GAME.ADD_CHAPTER_AUTO_TIME_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("chapter_auto_add_time_fail", arg_2_0.result))
		end

		return
	end)

	return
end

return AddChapterAutoTimeCommand
