class = var_0_10000

local var_0_0 = "AddBlackListCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_2

	if var_2.isFriend(var_1_0) then
		pg = var_1_2

		local var_1_1 = var_1_2.TipsMgr.GetInstance()

		var_1_2 = var_1_2.ShowTips
		i18n = var_1_10006

		var_1_2(var_1_1, var_1_10006("friend_player_is_friend_tip"))

		return
	end

	pg = var_1_2

	local var_1_3 = var_1_2.ConnectionMgr.GetInstance()

	var_3.Send(var_1_3, 50109, {
		id = var_2.id
	}, 50110, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			FriendProxy = var_2_10003
			var_2_10004 = var_1(var_2_10003)

			var_1.addIntoBlackList(var_2_10004, var_0)

			var_2_10004 = arg_1_0

			local var_2_0 = var_2.sendNotification

			GAME = var_5

			var_2_0(var_2_10004, var_5.FRIEND_ADD_BLACKLIST_DONE)

			pg = var_2_0
			var_2_10004 = var_2_0.TipsMgr.GetInstance()

			local var_2_1 = var_2.ShowTips

			i18n = var_5

			var_2_1(var_2_10004, var_5("friend_addblacklist_success"))
		else
			pg = var_1

			local var_2_2 = var_1.TipsMgr.GetInstance()
			local var_2_3 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_3(var_2_2, var_2_10004("friend_addblacklist", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
