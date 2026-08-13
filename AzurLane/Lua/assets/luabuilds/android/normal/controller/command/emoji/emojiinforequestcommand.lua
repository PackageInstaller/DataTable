class = var_0_10000

local var_0_0 = "EmojiInfoRequestCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_3.Send(var_1_2, 11601, {
		type = 0
	}, 11602, function(arg_2_0)
		if arg_2_0.emoji_list then
			print = var_1

			var_1("request emoji info success")

			getProxy = var_1
			EmojiProxy = var_2

			local var_2_0 = var_1(var_2)

			ipairs = var_2

			for iter_2_0, iter_2_1 in var_2(arg_2_0.emoji_list) do
				pg = var_2_10007

				if var_2_10007.emoji_template[iter_2_1].achieve == 1 then
					var_2_0:addToEmojiIDLIst(iter_2_1)
				end
			end

			var_2_0:loadNewEmojiIDList()
			var_2_0:setInitedTag()

			local var_2_1 = arg_1_0
			local var_2_2 = var_2.sendNotification

			GAME = var_4

			var_2_2(var_2_1, var_4.REQUEST_EMOJI_INFO_FROM_SERVER_DONE)
		end

		return
	end)

	return
end

return var_0_1
