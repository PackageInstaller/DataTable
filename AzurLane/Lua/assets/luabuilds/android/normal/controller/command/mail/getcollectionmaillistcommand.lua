class = var_0_10000

local var_0_0 = "GetCollectionMailListCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().callback

	getProxy = var_1_10004
	MailProxy = var_1_10005

	if var_1_10004(var_1_10005).collectionIds then
		return
	end

	var_4.collectionIds = {}

	local var_1_1

	;(function(arg_2_0)
		local var_2_0 = #var_0.collectionIds + 1
		local var_2_1 = #var_0.collectionIds

		SINGLE_MAIL_REQUIRE_SIZE = var_2_10003

		local var_2_2 = var_2_1 + var_2_10003

		pg = var_2_10003

		local var_2_3 = var_2_10003.ConnectionMgr.GetInstance()

		var_3.Send(var_2_3, 30004, {
			index_begin = var_2_0,
			index_end = var_2_2
		}, 30005, function(arg_3_0)
			underscore = var_3_10001

			local var_3_0 = var_3_10001.map(arg_3_0.mail_list, function(arg_4_0)
				BaseMail = var_4_10001

				return var_4_10001.New(arg_4_0)
			end)
			local var_3_1 = var_0

			var_2.AddCollectionMails(var_3_1, var_3_0)

			local var_3_2 = #var_3_0

			SINGLE_MAIL_REQUIRE_SIZE = var_3_1

			if var_3_2 < var_3_1 then
				arg_2_0()
			else
				var_0(arg_2_0)
			end

			return
		end)

		return
	end)(function()
		existCall = var_2_10000

		var_2_10000(var_1_0)

		local var_5_0 = arg_1_0
		local var_5_1 = var_0.sendNotification

		GAME = var_2_10002

		var_5_1(var_5_0, var_2_10002.GET_COLLECTION_MAIL_LIST_DONE)

		return
	end)

	return
end

return var_0_1
