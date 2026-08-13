class = var_0_10000

local var_0_0 = "ActivityBeUpdatedCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().activity
	local var_1_1 = var_3.getConfig(var_1_0, "type")

	ActivityConst = var_1_0

	if var_1_1 == var_1_0.ACTIVITY_TYPE_PT_BUFF and arg_1_0:IsLinkVoteAct(var_3) then
		ActivityPtData = var_4

		local var_1_2 = var_4.New(var_3)

		if var_4.CanGetAward(var_1_2) then
			local var_1_3 = var_4:GetCurrTarget()
			local var_1_4 = arg_1_0
			local var_1_5 = arg_1_0.sendNotification

			GAME = var_1_10008

			var_1_5(var_1_4, var_1_10008.ACT_NEW_PT, {
				cmd = 4,
				activity_id = var_4:GetId(),
				arg1 = var_1_3
			})
		end
	end

	return
end

function var_0_1.IsLinkVoteAct(arg_2_0, arg_2_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10003

	local var_2_0 = var_1_10002(var_1_10003)
	local var_2_1 = var_2.getActivityById

	ActivityConst = var_1_10004

	if var_2_1(var_2_0, var_1_10004.VOTE_ENTRANCE_ACT_ID) and not var_2:isEnd() then
		local var_2_2 = var_2:getConfig("config_client")[1]

		return arg_2_1.id == var_2_2
	end

	return false
end

return var_0_1
