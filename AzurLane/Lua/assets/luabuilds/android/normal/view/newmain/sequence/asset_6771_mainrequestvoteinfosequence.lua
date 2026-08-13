class = var_0_10000

local var_0_0 = var_0_10000("MainRequestVoteInfoSequence")

function var_0_0.Execute(arg_1_0, arg_1_1)
	if not arg_1_0:ExistVoteAct() then
		arg_1_1()

		return
	end

	seriesAsync = var_2

	var_2({
		function(arg_2_0)
			local var_2_0 = arg_1_0

			var_1.RequestMainStage(var_2_0, arg_2_0)

			return
		end,
		function(arg_3_0)
			local var_3_0 = arg_1_0

			var_1.RequestFunStage(var_3_0, arg_3_0)

			return
		end
	}, arg_1_1)

	return
end

function var_0_0.ExistVoteAct(arg_4_0)
	MainVoteEntranceBtn = var_1_10001

	local var_4_0 = var_1_10001.New()

	return var_1.InShowTime(var_4_0)
end

function var_0_0.RequestMainStage(arg_5_0, arg_5_1)
	_ = var_1_10002

	local var_5_0 = var_1_10002.detect

	pg = var_1_10003

	if not var_5_0(var_1_10003.activity_vote.all, function(arg_6_0)
		pg = var_2_10001

		local var_6_0 = var_2_10001.activity_vote[arg_6_0].time_vote

		pg = var_2_10003

		local var_6_1 = var_2_10003.TimeMgr.GetInstance()

		if var_3.inTime(var_6_1, var_6_0) then
			if var_1.is_in_game == 1 then
				local var_6_2 = var_1.type

				VoteConst = var_6_1

				if var_6_2 == var_6_1.RACE_TYPE_FUN then
					var_6_2 = false
				else
					var_6_2 = true
				end

				return var_6_2
			end
		end
	end) or not arg_5_0:ShouldRequestMainStage(var_2) then
		arg_5_1()

		return
	end

	pg = var_3

	local var_5_1 = var_3.m02
	local var_5_2 = var_3.sendNotification

	GAME = var_1_10005

	var_5_2(var_5_1, var_1_10005.FETCH_VOTE_INFO, {
		voteId = var_2,
		callback = function()
			local var_7_0 = var_0_0

			pg = var_2_10001

			local var_7_1 = var_2_10001.TimeMgr.GetInstance()

			var_7_0.lastRequestTime = var_1.GetServerTime(var_7_1)

			arg_5_1()

			return
		end
	})

	return
end

function var_0_0.ShouldRequestMainStage(arg_8_0, arg_8_1)
	getProxy = var_1_10002
	VoteProxy = var_1_10003

	local var_8_0 = var_1_10002(var_1_10003)
	local var_8_1 = var_2.RawGetVoteGroupByConfigId(var_8_0, arg_8_1)

	pg = var_8_0

	local var_8_2 = var_8_0.TimeMgr.GetInstance()
	local var_8_3 = var_3.GetServerTime(var_8_2)

	if var_8_1 then
		local var_8_4

		if not var_0_0.lastRequestTime then
			var_8_4 = 0
		end

		local var_8_5 = var_8_3 - var_8_4

		VoteConst = var_1_10005

		if not (var_8_5 > var_1_10005.RankExpiredTime) then
			local var_8_6

			if var_8_1 then
				::label_8_0::

				if var_8_1.configId == arg_8_1 then
					var_8_6 = false

					goto label_8_1
				end

				var_8_6 = true
			end

			::label_8_1::

			return var_8_6
		end
	end
end

function var_0_0.RequestFunStage(arg_9_0, arg_9_1)
	_ = var_1_10002

	local var_9_0 = var_1_10002.detect

	pg = var_1_10003

	if not var_9_0(var_1_10003.activity_vote.all, function(arg_10_0)
		pg = var_2_10001

		local var_10_0 = var_2_10001.activity_vote[arg_10_0].time_vote

		pg = var_2_10003

		local var_10_1 = var_2_10003.TimeMgr.GetInstance()

		if var_3.inTime(var_10_1, var_10_0) then
			if var_1.is_in_game == 1 then
				local var_10_2 = var_1.type

				VoteConst = var_10_1

				if var_10_2 ~= var_10_1.RACE_TYPE_FUN then
					var_10_2 = false
				else
					var_10_2 = true
				end

				return var_10_2
			end
		end
	end) or not arg_9_0:ShouldRequestFunStage(var_2) then
		arg_9_1()

		return
	end

	pg = var_3

	local var_9_1 = var_3.m02
	local var_9_2 = var_3.sendNotification

	GAME = var_1_10005

	var_9_2(var_9_1, var_1_10005.FETCH_VOTE_INFO, {
		voteId = var_2,
		callback = function()
			local var_11_0 = var_0_0

			pg = var_2_10001

			local var_11_1 = var_2_10001.TimeMgr.GetInstance()

			var_11_0.lastRequestTimeForFun = var_1.GetServerTime(var_11_1)

			arg_9_1()

			return
		end
	})

	return
end

function var_0_0.ShouldRequestFunStage(arg_12_0, arg_12_1)
	getProxy = var_1_10002
	VoteProxy = var_1_10003

	local var_12_0 = var_1_10002(var_1_10003)
	local var_12_1 = var_2.RawGetVoteGroupByConfigId(var_12_0, arg_12_1)

	pg = var_12_0

	local var_12_2 = var_12_0.TimeMgr.GetInstance()
	local var_12_3 = var_3.GetServerTime(var_12_2)

	if var_12_1 then
		local var_12_4

		if not var_0_0.lastRequestTimeForFun then
			var_12_4 = 0
		end

		local var_12_5 = var_12_3 - var_12_4

		VoteConst = var_1_10005

		if not (var_12_5 > var_1_10005.RankExpiredTime) then
			local var_12_6

			if var_12_1 then
				::label_12_0::

				if var_12_1.configId == arg_12_1 then
					var_12_6 = false

					goto label_12_1
				end

				var_12_6 = true
			end

			::label_12_1::

			return var_12_6
		end
	end
end

return var_0_0
