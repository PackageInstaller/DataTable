local GetCollectionMailListCommand = class("GetCollectionMailListCommand", pm.SimpleCommand)

function GetCollectionMailListCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().callback
	local var_1_1 = getProxy(MailProxy)

	if var_1_1.collectionIds then
		return
	end

	var_1_1.collectionIds = {}

	local function var_1_3(arg_2_0)
		pg.ConnectionMgr.GetInstance():Send(30004, {
			index_begin = #var_1_1.collectionIds + 1,
			index_end = #var_1_1.collectionIds + SINGLE_MAIL_REQUIRE_SIZE
		}, 30005, function(arg_3_0)
			local var_3_0 = underscore.map(arg_3_0.mail_list, function(arg_4_0)
				return BaseMail.New(arg_4_0)
			end)

			var_1_1:AddCollectionMails(var_3_0)

			if #var_3_0 < SINGLE_MAIL_REQUIRE_SIZE then
				arg_2_0()
			else
				var_1_3(arg_2_0)
			end

			return
		end)

		return
	end

	;(nil)(function()
		existCall(var_1_0)
		self:sendNotification(GAME.GET_COLLECTION_MAIL_LIST_DONE)

		return
	end)

	return
end

return GetCollectionMailListCommand
