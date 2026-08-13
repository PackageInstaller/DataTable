class = var_0_10000

local var_0_0 = "FetchVoteRankCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().voteId
	local var_1_1 = var_2.callback

	getProxy = var_1_10005
	VoteProxy = var_1_10007

	local var_1_2 = var_1_10005(var_1_10007)

	if var_5.RawGetTempVoteGroup(var_1_2, var_1_0) and var_5.id == var_1_0 then
		var_1_1()

		return
	end

	pg = var_1_10006

	local var_1_3 = var_1_10006.ConnectionMgr.GetInstance()

	var_6.Send(var_1_3, 17203, {
		type = var_1_0
	}, 17204, function(arg_2_0)
		getProxy = var_2_10001
		VoteProxy = var_2_10003

		local var_2_0 = var_2_10001(var_2_10003)

		var_1.AddTempVoteGroup(var_2_0, arg_2_0, var_1_0)
		var_1_1()

		return
	end)

	return
end

return var_0_1
