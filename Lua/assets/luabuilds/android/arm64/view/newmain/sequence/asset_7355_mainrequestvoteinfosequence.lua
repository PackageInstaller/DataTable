local MainRequestVoteInfoSequence = class("MainRequestVoteInfoSequence")

function MainRequestVoteInfoSequence:Execute(arg_1_1)
	if not self:ExistVoteAct() then
		arg_1_1()

		return
	end

	seriesAsync({
		function(arg_2_0)
			self:RequestMainStage(arg_2_0)

			return
		end,
		function(arg_3_0)
			self:RequestFunStage(arg_3_0)

			return
		end
	}, arg_1_1)

	return
end

function MainRequestVoteInfoSequence:ExistVoteAct()
	return MainVoteEntranceBtn.New():InShowTime()
end

function MainRequestVoteInfoSequence:RequestMainStage(arg_5_1)
	local var_5_0 = _.detect(pg.activity_vote.all, function(arg_6_0)
		local var_6_0 = pg.TimeMgr.GetInstance():inTime(pg.activity_vote[arg_6_0].time_vote)

		var_6_0 = var_6_0 and pg.activity_vote[arg_6_0].is_in_game == 1 and pg.activity_vote[arg_6_0].type ~= VoteConst.RACE_TYPE_FUN

		return var_6_0
	end)

	if not var_5_0 or not self:ShouldRequestMainStage(var_5_0) then
		arg_5_1()

		return
	end

	pg.m02:sendNotification(GAME.FETCH_VOTE_INFO, {
		voteId = var_5_0,
		callback = function()
			MainRequestVoteInfoSequence.lastRequestTime = pg.TimeMgr.GetInstance():GetServerTime()

			arg_5_1()

			return
		end
	})

	return
end

function MainRequestVoteInfoSequence:ShouldRequestMainStage(arg_8_1)
	local var_8_0 = getProxy(VoteProxy):RawGetVoteGroupByConfigId(arg_8_1)

	if var_8_0 then
		if pg.TimeMgr.GetInstance():GetServerTime() - (MainRequestVoteInfoSequence.lastRequestTime or 0) <= VoteConst.RankExpiredTime then
			if var_8_0 then
				local var_8_2

				::label_8_0::

				var_8_2 = var_8_0.configId ~= arg_8_1
			end
		end
	end

	return var_8_2
end

function MainRequestVoteInfoSequence:RequestFunStage(arg_9_1)
	local var_9_0 = _.detect(pg.activity_vote.all, function(arg_10_0)
		local var_10_0 = pg.TimeMgr.GetInstance():inTime(pg.activity_vote[arg_10_0].time_vote)

		var_10_0 = var_10_0 and pg.activity_vote[arg_10_0].is_in_game == 1 and pg.activity_vote[arg_10_0].type == VoteConst.RACE_TYPE_FUN

		return var_10_0
	end)

	if not var_9_0 or not self:ShouldRequestFunStage(var_9_0) then
		arg_9_1()

		return
	end

	pg.m02:sendNotification(GAME.FETCH_VOTE_INFO, {
		voteId = var_9_0,
		callback = function()
			MainRequestVoteInfoSequence.lastRequestTimeForFun = pg.TimeMgr.GetInstance():GetServerTime()

			arg_9_1()

			return
		end
	})

	return
end

function MainRequestVoteInfoSequence:ShouldRequestFunStage(arg_12_1)
	local var_12_0 = getProxy(VoteProxy):RawGetVoteGroupByConfigId(arg_12_1)

	if var_12_0 then
		if pg.TimeMgr.GetInstance():GetServerTime() - (MainRequestVoteInfoSequence.lastRequestTimeForFun or 0) <= VoteConst.RankExpiredTime then
			if var_12_0 then
				local var_12_2

				::label_12_0::

				var_12_2 = var_12_0.configId ~= arg_12_1
			end
		end
	end

	return var_12_2
end

return MainRequestVoteInfoSequence
