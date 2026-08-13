class = var_0_10000

local var_0_0 = "GetAllLoveLetterLevelDataCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg = var_1_10003

	local var_1_1 = var_1_10003.ConnectionMgr.GetInstance()

	var_3.Send(var_1_1, 12406, {
		type = 0
	}, 12407, function(arg_2_0)
		getProxy = var_2_10001
		LoveLetterProxy = var_2_10003

		local var_2_0 = var_2_10001(var_2_10003)

		var_1.SetGroupList(var_2_0, arg_2_0)

		existCall = var_1

		var_1(var_1_0.callback)

		pg = var_1

		local var_2_1 = var_1.m02
		local var_2_2 = var_1.sendNotification

		GAME = var_4

		var_2_2(var_2_1, var_4.GET_ALL_LOVE_LETTER_DATA_DONE)

		return
	end)

	return
end

return var_0_1
