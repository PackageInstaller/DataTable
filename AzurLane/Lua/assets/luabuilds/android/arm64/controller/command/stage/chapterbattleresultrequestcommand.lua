class = var_0_10000

local var_0_0 = "ChapterBattleResultRequestCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0

	if not arg_1_1.body then
		var_1_0 = {}
	end

	local var_1_1 = var_1_0.isSkipBattle

	pg = var_1_10004

	local var_1_2 = var_1_10004.ConnectionMgr.GetInstance()

	var_4.Send(var_1_2, 13106, {
		arg = 0
	}, 13105, function(arg_2_0)
		getProxy = var_2_10001
		ChapterProxy = var_2_10003

		local var_2_0 = var_2_10001(var_2_10003)

		var_1.OnBattleFinished(var_2_0, arg_2_0, var_1_1)

		existCall = var_1

		var_1(var_1_0.callback)

		return
	end)

	return
end

return var_0_1
