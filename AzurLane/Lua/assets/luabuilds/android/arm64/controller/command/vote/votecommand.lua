local var_0_0 = class("VoteCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.gid
	local var_1_2 = var_1_0.count
	local var_1_3 = getProxy(VoteProxy)
	local var_1_4 = var_1_3:GetVoteActivityByConfigId(var_1_0.voteId)

	if not var_1_4 or var_1_4:isEnd() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

		return
	end

	local var_1_5 = var_1_4.id
	local var_1_6 = var_1_3:RawGetVoteGroupByConfigId(var_1_0.voteId)

	if not var_1_6 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

		return
	end

	if not var_1_6:IsOpening() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

		return
	end

	if var_1_0.count > var_1_3:GetVotesByConfigId(var_1_0.voteId) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("vote_not_enough"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(11202, {
		cmd = 1,
		activity_id = var_1_5,
		arg1 = var_1_0.voteId,
		arg2 = var_1_0.gid,
		arg3 = var_1_0.count,
		arg_list = {}
	}, 11203, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(ActivityProxy)
			local var_2_1 = var_2_0:getActivityById(var_1_5)

			var_2_1.data1 = var_2_1.data1 - var_1_2
			var_2_1.data2 = var_2_1.data2 + var_1_2

			var_2_0:updateActivity(var_2_1)
			var_1_6:UpdateVoteCnt(var_1_1, var_1_2)
			arg_1_0:sendNotification(GAME.ON_NEW_VOTE_DONE, {
				awards = PlayerConst.addTranDrop(arg_2_0.award_list)
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result])
		end

		return
	end)

	return
end

return var_0_0
