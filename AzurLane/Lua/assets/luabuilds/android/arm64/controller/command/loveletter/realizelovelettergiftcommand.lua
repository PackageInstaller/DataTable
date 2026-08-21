local var_0_0 = class("RealizeLoveLetterGiftCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(12404, {
		item_list = arg_1_1:getBody().list
	}, 12405, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(LoveLetterProxy):UpdateRealizeGift(var_0)
			pg.TipsMgr.GetInstance():ShowTips(i18n("loveactivity_ui_17"))
			pg.m02:sendNotification(GAME.REALIZE_LOVE_LETTER_GIFT_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
