class = var_0_10000

local var_0_0 = "GetPhantomQuestProgressCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().shipIds
	local var_1_1 = var_2.callback

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 12212, {
		ship_id_list = var_1_0
	}, 12213, function(arg_2_0)
		local var_2_0 = {}

		underscore = var_2_10002

		var_2_10002.each(arg_2_0.ship_count_list, function(arg_3_0)
			var_2_0[arg_3_0.key] = arg_3_0.value

			return
		end)

		getProxy = var_2
		TechnologyProxy = var_4

		local var_2_1 = var_2(var_4)

		var_2.updatePhantomQuestProgress(var_2_1, 3, var_2_0)

		existCall = var_2

		var_2(var_1_1)

		local var_2_2 = arg_1_0
		local var_2_3 = var_2.sendNotification

		GAME = var_5

		var_2_3(var_2_2, var_5.GET_PHANTOM_QUEST_PROGRESS_DONE)

		return
	end)

	return
end

return var_0_1
