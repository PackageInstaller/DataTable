class = var_0_10000

local var_0_0 = "VoteCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().voteId
	local var_1_1 = var_2.gid
	local var_1_2 = var_2.count

	getProxy = var_1_10006
	VoteProxy = var_1_10008

	local var_1_3 = var_1_10006(var_1_10008)

	if var_6.GetVoteActivityByConfigId(var_1_3, var_1_0) then
		local var_1_4 = var_7

		if var_7.isEnd(var_1_4) then
			pg = var_1_10008
			var_1_4 = var_1_10008.TipsMgr.GetInstance()

			local var_1_5 = var_8.ShowTips

			i18n = var_1_10011

			var_1_5(var_1_4, var_1_10011("common_activity_end"))

			return
		end

		local var_1_6 = var_7.id

		if not var_6:RawGetVoteGroupByConfigId(var_1_0) then
			pg = var_1_4

			local var_1_7 = var_1_4.TipsMgr.GetInstance()
			local var_1_8 = var_10.ShowTips

			i18n = var_1_10013

			var_1_8(var_1_7, var_1_10013("common_activity_end"))

			return
		end

		if not var_9:IsOpening() then
			pg = var_10

			local var_1_9 = var_10.TipsMgr.GetInstance()
			local var_1_10 = var_10.ShowTips

			i18n = var_1_10013

			var_1_10(var_1_9, var_1_10013("common_activity_end"))

			return
		end

		local var_1_12

		if var_6:GetVotesByConfigId(var_1_0) < var_1_2 then
			pg = var_1_12

			local var_1_11 = var_1_12.TipsMgr.GetInstance()

			var_1_12 = var_1_12.ShowTips
			i18n = var_13

			var_1_12(var_1_11, var_13("vote_not_enough"))

			return
		end

		pg = var_1_12

		local var_1_13 = var_1_12.ConnectionMgr.GetInstance()

		var_10.Send(var_1_13, 11202, {
			cmd = 1,
			activity_id = var_1_6,
			arg1 = var_1_0,
			arg2 = var_1_1,
			arg3 = var_1_2,
			arg_list = {}
		}, 11203, function(arg_2_0)
			local var_2_0

			if arg_2_0.result == 0 then
				PlayerConst = var_2_0
				var_2_0 = var_2_0.addTranDrop(arg_2_0.award_list)
				getProxy = var_2_10002
				ActivityProxy = var_2_10004

				local var_2_1 = var_2_10002(var_2_10004)

				var_3.data1 = var_2.getActivityById(var_2_1, var_1_6).data1 - var_1_2
				var_3.data2 = var_3.data2 + var_1_2

				var_2:updateActivity(var_3)

				local var_2_2 = var_0

				var_2_10004.UpdateVoteCnt(var_2_2, var_1_1, var_1_2)

				local var_2_3 = arg_1_0

				var_2_10004 = var_2_10004.sendNotification
				GAME = var_7

				var_2_10004(var_2_3, var_7.ON_NEW_VOTE_DONE, {
					awards = var_2_0
				})
			else
				pg = var_2_0

				local var_2_4 = var_2_0.TipsMgr.GetInstance()
				local var_2_5 = var_1.ShowTips

				ERROR_MESSAGE = var_2_10004

				var_2_5(var_2_4, var_2_10004[arg_2_0.result])
			end

			return
		end)

		return
	end
end

return var_0_1
