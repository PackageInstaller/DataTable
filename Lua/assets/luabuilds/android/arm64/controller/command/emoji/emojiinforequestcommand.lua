local var_0_0 = class("EmojiInfoRequestCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(11601, {
		type = 0
	}, 11602, function(arg_2_0)
		if arg_2_0.emoji_list then
			print("request emoji info success")

			local var_2_0 = getProxy(EmojiProxy)

			for iter_2_0, iter_2_1 in ipairs(arg_2_0.emoji_list) do
				if pg.emoji_template[iter_2_1].achieve == 1 then
					var_2_0:addToEmojiIDLIst(iter_2_1)
				end
			end

			var_2_0:loadNewEmojiIDList()
			var_2_0:setInitedTag()
			arg_1_0:sendNotification(GAME.REQUEST_EMOJI_INFO_FROM_SERVER_DONE)
		end

		return
	end)

	return
end

return var_0_0
