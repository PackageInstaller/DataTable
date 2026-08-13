class = var_0_10000

local var_0_0 = "ChangeChatRoomCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)
local var_0_2 = 99

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_0
	PlayerProxy = var_1_10004

	if not var_1_0(var_1_10004) then
		return
	end

	local var_1_2 = var_3

	if not var_3.getData(var_1_2) then
		return
	end

	if not var_1_1 then
		pg = var_1_2

		local var_1_3 = var_1_2.TipsMgr.GetInstance()
		local var_1_4 = var_5.ShowTips

		i18n = var_1_10007

		var_1_4(var_1_3, var_1_10007("main_notificationLayer_not_roomId"))

		return
	end

	local var_1_6

	if var_0_2 < var_1_1 or var_1_1 < 0 then
		pg = var_1_6

		local var_1_5 = var_1_6.TipsMgr.GetInstance()

		var_1_6 = var_1_6.ShowTips
		i18n = var_1_10007

		var_1_6(var_1_5, var_1_10007("main_notificationLayer_roomId_invaild"))

		return
	end

	pg = var_1_6

	local var_1_7 = var_1_6.ConnectionMgr.GetInstance()

	var_5.Send(var_1_7, 11401, {
		room_id = var_1_1
	}, 11402, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_0
			local var_2_1 = var_1.changeChatRoom

			if not arg_2_0.room_id then
				var_2_10003 = var_1_1
			end

			var_2_1(var_2_0, var_2_10003)

			local var_2_2 = var_0

			var_1.updatePlayer(var_2_2, var_0)

			getProxy = var_1
			ChatProxy = var_2_2
			var_2_10003 = var_1(var_2_2)

			var_1.clearMsg(var_2_10003)

			var_2_10003 = arg_1_0

			local var_2_3 = var_2.sendNotification

			GAME = var_2_10004

			var_2_3(var_2_10003, var_2_10004.CHANGE_CHAT_ROOM_DONE, var_0)
		else
			local var_2_5

			if arg_2_0.result == 6 then
				local var_2_4 = arg_1_0

				var_2_5 = var_2_5.sendNotification
				GAME = var_2_10003

				var_2_5(var_2_4, var_2_10003.CHAT_ROOM_MAX_NUMBER)
			else
				pg = var_2_5

				local var_2_6 = var_2_5.TipsMgr.GetInstance()
				local var_2_7 = var_1.ShowTips

				errorTip = var_2_10003

				var_2_7(var_2_6, var_2_10003("player_change_chat_room_erro", arg_2_0.result))
			end
		end

		return
	end)

	return
end

return var_0_1
