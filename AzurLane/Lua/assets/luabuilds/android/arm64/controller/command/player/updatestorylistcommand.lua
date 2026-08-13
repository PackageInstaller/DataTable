class = var_0_10000

local var_0_0 = "UpdateStoryListCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().storyIds
	local var_1_1 = var_2.callback

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	if var_5.getConnection(var_1_2) then
		pg = var_5
		var_1_2 = var_5.ConnectionMgr.GetInstance()

		if not var_5.isConnected(var_1_2) then
			return
		end

		getProxy = var_5
		PlayerProxy = var_1_2

		if not var_5(var_1_2) then
			return
		end

		pg = var_5

		local var_1_3 = var_5.NewStoryMgr.GetInstance()
		local var_1_4 = {}

		ipairs = var_1_2

		for iter_1_0, iter_1_1 in var_1_2(var_1_0) do
			if not var_1_3:GetPlayedFlag(iter_1_1) then
				table = var_12

				var_12.insert(var_1_4, iter_1_1)
			end
		end

		if #var_1_4 == 0 then
			existCall = var_7

			var_7(var_1_1)

			return
		end

		pg = var_7

		local var_1_5 = var_7.ConnectionMgr.GetInstance()

		var_7.Send(var_1_5, 11032, {
			story_ids = var_1_4
		}, 11033, function(arg_2_0)
			local var_2_2

			if arg_2_0.result == 0 then
				local var_2_0 = var_1_3

				var_2_2.SetPlayedFlagList(var_2_0, var_1_4)

				existCall = var_2_2

				var_2_2(var_1_1)

				local var_2_1 = arg_1_0

				var_2_2 = var_2_2.sendNotification
				GAME = var_2_10004

				var_2_2(var_2_1, var_2_10004.STORY_UPDATE_LIST_DONE, {
					storyIds = var_1_4
				})
			else
				pg = var_2_2

				local var_2_3 = var_2_2.TipsMgr.GetInstance()
				local var_2_4 = var_1.ShowTips

				ERROR_MESSAGE = var_2_10004

				var_2_4(var_2_3, var_2_10004[arg_2_0.result] .. arg_2_0.result)
			end

			return
		end)

		return
	end
end

return var_0_1
