class = var_0_10000

local var_0_0 = "UnlockLoveLetterCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).id

	pg = var_1_0

	local var_1_2 = var_1_0.lover_letter_content[var_1_1]

	getProxy = var_1_10005
	LoveLetterProxy = var_1_10007

	local var_1_3 = var_1_10005(var_1_10007)
	local var_1_4 = var_5.GetGroupData(var_1_3, var_1_2.ship_group)

	if not var_5.CanUnlockLetter(var_1_4, var_1_1) then
		return
	end

	pg = var_6

	local var_1_5 = var_6.ConnectionMgr.GetInstance()

	var_6.Send(var_1_5, 12400, {
		id = var_1_1
	}, 12401, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			getProxy = var_2_2
			LoveLetterProxy = var_2_10003

			local var_2_0 = var_2_2(var_2_10003)

			var_2_2.UnlockLetter(var_2_0, var_1_2.ship_group, var_1_1)

			pg = var_2_2

			local var_2_1 = var_2_2.m02

			var_2_2 = var_2_2.sendNotification
			GAME = var_2_10004

			var_2_2(var_2_1, var_2_10004.UNLOCK_LOVE_LETTER_DONE, {
				letterId = var_1_1
			})
		else
			pg = var_2_2

			local var_2_3 = var_2_2.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_4(var_2_3, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
