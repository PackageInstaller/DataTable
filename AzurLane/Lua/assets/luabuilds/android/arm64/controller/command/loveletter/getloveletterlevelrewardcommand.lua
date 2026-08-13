class = var_0_10000

local var_0_0 = "GetLoveLetterLevelRewardCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).list

	getProxy = var_1_0
	LoveLetterProxy = var_1_10006

	local var_1_2 = var_1_0(var_1_10006)

	if not var_4.CanGetReward(var_1_2, var_1_1) then
		return
	end

	pg = var_4

	local var_1_3 = var_4.ConnectionMgr.GetInstance()

	var_4.Send(var_1_3, 12402, {
		id_list = var_1_1
	}, 12403, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			getProxy = var_2_1
			LoveLetterProxy = var_2_10003

			local var_2_0 = var_2_1(var_2_10003)

			var_2_1.MarkReward(var_2_0, var_1_1)

			PlayerConst = var_2_1
			var_2_1 = var_2_1.addTranDrop(arg_2_0.drop_list)
			pg = var_2_10002
			var_2_10004 = var_2_10002.m02

			local var_2_2 = var_2.sendNotification

			GAME = var_2_10005

			var_2_2(var_2_10004, var_2_10005.GET_LOVE_LETTER_REWARD_DONE, {
				list = var_1_1,
				awards = var_2_1
			})
		else
			pg = var_2_1

			local var_2_3 = var_2_1.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_4(var_2_3, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
