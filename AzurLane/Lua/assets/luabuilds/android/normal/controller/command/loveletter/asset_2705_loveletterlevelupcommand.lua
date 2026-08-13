class = var_0_10000

local var_0_0 = "LoveLetterLevelUpCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().groupId

	getProxy = var_1_10004
	LoveLetterProxy = var_1_10005

	local var_1_1 = var_1_10004(var_1_10005)
	local var_1_2 = var_4.GetGroupData(var_1_1, var_1_0)

	if not var_4.CanLevelUp(var_1_2) then
		return
	end

	pg = var_5

	local var_1_3 = var_5.ConnectionMgr.GetInstance()

	var_5.Send(var_1_3, 12408, {
		group_id = var_1_0
	}, 12409, function(arg_2_0)
		local var_2_2

		if arg_2_0.ret == 0 then
			getProxy = var_2_2
			LoveLetterProxy = var_2_10002

			local var_2_0 = var_2_2(var_2_10002)

			var_2_2.LevelUp(var_2_0, var_1_0)

			existCall = var_2_2

			var_2_2(var_0.callback)

			pg = var_2_2

			local var_2_1 = var_2_2.m02

			var_2_2 = var_2_2.sendNotification
			GAME = var_2_10003

			var_2_2(var_2_1, var_2_10003.LOVE_LETTER_LEVEL_UP_DONE, {
				groupId = var_1_0
			})
		else
			pg = var_2_2

			local var_2_3 = var_2_2.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_4(var_2_3, var_2_10003[arg_2_0.ret] .. arg_2_0.ret)
		end

		return
	end)

	return
end

return var_0_1
