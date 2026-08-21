local var_0_0 = class("RemasterAwardReceiveCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.chapterId
	local var_1_2 = var_1_0.pos
	local var_1_3 = var_1_0.actId or 0
	local var_1_4 = getProxy(ChapterProxy)
	local var_1_5 = var_1_4:getRemasterInfo(var_1_3, var_1_0.chapterId, var_1_0.pos)

	if not var_1_5 or var_1_5.receive then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(13507, {
		chapter_id = var_1_0.chapterId,
		pos = var_1_0.pos,
		act_id = var_1_3
	}, 13508, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_4:markRemasterPassReceive(var_1_1, var_1_2, var_1_3)
			arg_1_0:sendNotification(GAME.CHAPTER_REMASTER_AWARD_RECEIVE_DONE, (PlayerConst.addTranDrop(arg_2_0.drop_list)))
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
