class = var_0_10000

local var_0_0 = "RealizeLoveLetterGiftCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).list

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_4.Send(var_1_2, 12404, {
		item_list = var_1_1
	}, 12405, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			getProxy = var_2_2
			LoveLetterProxy = var_2_10003

			local var_2_0 = var_2_2(var_2_10003)

			var_2_2.UpdateRealizeGift(var_2_0, var_1_1)

			pg = var_2_2

			local var_2_1 = var_2_2.TipsMgr.GetInstance()

			var_2_2 = var_2_2.ShowTips
			i18n = var_2_10004

			var_2_2(var_2_1, var_2_10004("loveactivity_ui_17"))

			pg = var_2_2

			local var_2_3 = var_2_2.m02

			var_2_2 = var_2_2.sendNotification
			GAME = var_2_10004

			var_2_2(var_2_3, var_2_10004.REALIZE_LOVE_LETTER_GIFT_DONE)
		else
			pg = var_2_2

			local var_2_4 = var_2_2.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_5(var_2_4, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
