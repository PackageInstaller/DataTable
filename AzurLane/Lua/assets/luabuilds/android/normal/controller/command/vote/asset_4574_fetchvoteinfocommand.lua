class = var_0_10000

local var_0_0 = "FetchVoteInfoCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().voteId
	local var_1_1 = var_2.callback

	if not var_1_0 then
		pg = var_1_10005

		local var_1_2 = var_1_10005.TipsMgr.GetInstance()

		var_1_10005 = var_1_10005.ShowTips
		i18n = var_1_10007

		var_1_10005(var_1_2, var_1_10007("common_error"))

		return
	end

	pg = var_1_10005

	local var_1_3 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_3, 17203, {
		type = var_1_0
	}, 17204, function(arg_2_0)
		getProxy = var_2_10001
		VoteProxy = var_2_10002

		local var_2_0 = var_2_10001(var_2_10002)

		var_1.AddVoteGroup(var_2_0, arg_2_0, var_1_0)

		local var_2_1 = arg_1_0
		local var_2_2 = var_1.sendNotification

		GAME = var_3

		var_2_2(var_2_1, var_3.FETCH_VOTE_INFO_DONE)
		var_1_1()

		return
	end)

	return
end

return var_0_1
