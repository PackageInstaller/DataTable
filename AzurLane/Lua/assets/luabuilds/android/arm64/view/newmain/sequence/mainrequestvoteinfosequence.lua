local var_0_0 = class("MainRequestVoteInfoSequence")

function var_0_0.Execute(arg_1_0, arg_1_1)
	if not arg_1_0:ExistVoteAct() then
		arg_1_1()

		return
	end

	seriesAsync({
		function(arg_2_0)
			arg_1_0:RequestMainStage(arg_2_0)

			return
		end,
		function(arg_3_0)
			arg_1_0:RequestFunStage(arg_3_0)

			return
		end
	}, arg_1_1)

	return
end

function var_0_0.ExistVoteAct(arg_4_0)
	return MainVoteEntranceBtn.New():InShowTime()
end

function var_0_0.RequestMainStage(arg_5_0, arg_5_1)
	local var_5_0 = _.detect(pg.activity_vote.all, function(arg_6_0)
		local var_6_0 = pg.TimeMgr.GetInstance():inTime(pg.activity_vote[arg_6_0].time_vote)

		var_6_0 = var_6_0 and pg.activity_vote[arg_6_0].is_in_game == 1 and pg.activity_vote[arg_6_0].type ~= VoteConst.RACE_TYPE_FUN

		return var_6_0
	end)

	if not var_5_0 or not arg_5_0:ShouldRequestMainStage(var_5_0) then
		arg_5_1()

		return
	end

	pg.m02:sendNotification(GAME.FETCH_VOTE_INFO, {
		voteId = var_5_0,
		callback = function()
			var_0_0.lastRequestTime = pg.TimeMgr.GetInstance():GetServerTime()

			arg_5_1()

			return
		end
	})

	return
end

function var_0_0.ShouldRequestMainStage(arg_8_0, arg_8_1)
	local var_8_0 = getProxy(VoteProxy):RawGetVoteGroupByConfigId(arg_8_1)

	if var_8_0 then
		local var_8_1 = var_0_0.lastRequestTime or 0

		if pg.TimeMgr.GetInstance():GetServerTime() - var_8_1 <= VoteConst.RankExpiredTime then
			local var_8_2

			if var_8_0 then
				::label_8_0::

				if var_8_0.configId == arg_8_1 then
					var_8_2 = false

					goto label_8_1
				end

				var_8_2 = true
			end

			::label_8_1::

			return var_8_2
		end
	end
end

function var_0_0.RequestFunStage(arg_9_0, arg_9_1)
	local var_9_0 = _.detect(pg.activity_vote.all, function(arg_10_0)
		local var_10_0 = pg.TimeMgr.GetInstance():inTime(pg.activity_vote[arg_10_0].time_vote)

		var_10_0 = var_10_0 and pg.activity_vote[arg_10_0].is_in_game == 1 and pg.activity_vote[arg_10_0].type == VoteConst.RACE_TYPE_FUN

		return var_10_0
	end)

	if not var_9_0 or not arg_9_0:ShouldRequestFunStage(var_9_0) then
		arg_9_1()

		return
	end

	pg.m02:sendNotification(GAME.FETCH_VOTE_INFO, {
		voteId = var_9_0,
		callback = function()
			var_0_0.lastRequestTimeForFun = pg.TimeMgr.GetInstance():GetServerTime()

			arg_9_1()

			return
		end
	})

	return
end

function var_0_0.ShouldRequestFunStage(arg_12_0, arg_12_1)
	local var_12_0 = getProxy(VoteProxy):RawGetVoteGroupByConfigId(arg_12_1)

	if var_12_0 then
		local var_12_1 = var_0_0.lastRequestTimeForFun or 0

		if pg.TimeMgr.GetInstance():GetServerTime() - var_12_1 <= VoteConst.RankExpiredTime then
			local var_12_2

			if var_12_0 then
				::label_12_0::

				if var_12_0.configId == arg_12_1 then
					var_12_2 = false

					goto label_12_1
				end

				var_12_2 = true
			end

			::label_12_1::

			return var_12_2
		end
	end
end

return var_0_0
