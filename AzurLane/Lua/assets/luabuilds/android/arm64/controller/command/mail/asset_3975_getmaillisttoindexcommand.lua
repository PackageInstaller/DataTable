class = var_0_10000

local var_0_0 = "GetMailListToIndexCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().index
	local var_1_1 = var_2.callback

	getProxy = var_1_10005
	MailProxy = var_1_10007

	local var_1_2 = var_1_10005(var_1_10007)
	local var_1_3

	;(function(arg_2_0)
		local var_2_0 = 1

		getProxy = var_2_10002
		MailProxy = var_2_10004

		local var_2_1 = var_2_10002(var_2_10004)
		local var_2_2, var_2_3 = var_2.GetNextIndex(var_2_1)

		pg = var_2_1

		local var_2_4 = var_2_1.ConnectionMgr.GetInstance()

		var_4.Send(var_2_4, 30002, {
			type = 1,
			index_begin = var_2_2,
			index_end = var_2_3
		}, 30003, function(arg_3_0)
			underscore = var_3_10001

			local var_3_0 = var_3_10001.map(arg_3_0.mail_list, function(arg_4_0)
				Mail = var_4_10001

				return var_4_10001.New(arg_4_0)
			end)
			local var_3_1 = var_1_2

			var_2.AddNextMails(var_3_1, var_3_0)

			if #var_1_2.ids < var_1_0 then
				var_0(arg_2_0)
			else
				arg_2_0()
			end

			return
		end)

		return
	end)(function()
		existCall = var_2_10000

		var_2_10000(var_1_1)

		local var_5_0 = arg_1_0
		local var_5_1 = var_0.sendNotification

		GAME = var_2_10003

		var_5_1(var_5_0, var_2_10003.GET_MAIL_LIST_TO_INDEX_DONE)

		return
	end)

	return
end

return var_0_1
