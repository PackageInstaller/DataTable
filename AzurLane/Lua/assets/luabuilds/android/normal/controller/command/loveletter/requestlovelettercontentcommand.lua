class = var_0_10000

local var_0_0 = "RequestLoveLetterContentCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.callback

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 12410, {
		letter_id = var_1_0
	}, 12411, function(arg_2_0)
		getProxy = var_2_10001
		LoveLetterProxy = var_2_10002

		local var_2_0 = var_2_10001(var_2_10002)

		var_1.RecordLoveLetterContent(var_2_0, var_1_0, arg_2_0.content)

		existCall = var_1

		var_1(var_1_1)

		pg = var_1

		local var_2_1 = var_1.m02
		local var_2_2 = var_1.sendNotification

		GAME = var_3

		var_2_2(var_2_1, var_3.REQUEST_LOVE_LETTER_TEXT_DONE, {
			letterId = var_1_0
		})

		return
	end)

	return
end

return var_0_1
