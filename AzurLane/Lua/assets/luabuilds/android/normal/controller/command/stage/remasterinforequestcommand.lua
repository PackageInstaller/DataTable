class = var_0_10000

local var_0_0 = "RemasterInfoRequestCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	pg = var_1_10002

	local var_1_0 = var_1_10002.ConnectionMgr.GetInstance()

	var_2.Send(var_1_0, 13505, {
		type = 0
	}, 13506, function(arg_2_0)
		getProxy = var_2_10001
		ChapterProxy = var_2_10002

		local var_2_0 = var_2_10001(var_2_10002).remasterInfo

		ipairs = var_2_10002

		for iter_2_0, iter_2_1 in var_2_10002(arg_2_0.remap_count_list) do
			local var_2_1

			if not iter_2_1.act_id then
				var_2_1 = 0
			end

			if var_2_0[var_2_1] and var_2_0[var_2_1][iter_2_1.chapter_id] and var_2_0[var_2_1][iter_2_1.chapter_id][iter_2_1.pos] then
				var_2_0[var_2_1][iter_2_1.chapter_id][iter_2_1.pos].count = iter_2_1.count
				var_2_0[var_2_1][iter_2_1.chapter_id][iter_2_1.pos].receive = iter_2_1.flag > 0
			end
		end

		local var_2_2 = arg_1_0
		local var_2_3 = var_2.sendNotification

		GAME = var_4

		var_2_3(var_2_2, var_4.CHAPTER_REMASTER_INFO_REQUEST_DONE)

		return
	end)

	return
end

return var_0_1
