class = var_0_10000

local var_0_0 = "ChangeChatRoomCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)
local var_0_2 = 99

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	getProxy = var_1_10003
	PlayerProxy = var_1_10005

	if not var_1_10003(var_1_10005) then
		return
	end

	if not var_3:getData() then
		return
	end

	if not var_1_0 then
		pg = var_1_10005

		local var_1_1 = var_1_10005.TipsMgr.GetInstance()
		local var_1_2 = var_5.ShowTips

		i18n = var_1_10008

		var_1_2(var_1_1, var_1_10008("main_notificationLayer_not_roomId"))

		return
	end

	local var_1_4

	if var_0_2 < var_1_0 or var_1_0 < 0 then
		pg = var_1_4

		local var_1_3 = var_1_4.TipsMgr.GetInstance()

		var_1_4 = var_1_4.ShowTips
		i18n = var_1_10008

		var_1_4(var_1_3, var_1_10008("main_notificationLayer_roomId_invaild"))

		return
	end

	pg = var_1_4

	local var_1_5 = var_1_4.ConnectionMgr.GetInstance()

	var_5.Send(var_1_5, 11401, {
		room_id = var_1_0
	}, 11402, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_0
			local var_2_1 = var_1.changeChatRoom

			if not arg_2_0.room_id then
				var_2_10004 = var_1_0
			end

			var_2_1(var_2_0, var_2_10004)

			local var_2_2 = var_0

			var_1.updatePlayer(var_2_2, var_0)

			getProxy = var_1
			ChatProxy = var_2_2
			var_2_10004 = var_1(var_2_2)

			var_1.clearMsg(var_2_10004)

			var_2_10004 = arg_1_0

			local var_2_3 = var_2.sendNotification

			GAME = var_2_10005

			var_2_3(var_2_10004, var_2_10005.CHANGE_CHAT_ROOM_DONE, var_0)
		else
			local var_2_5

			if arg_2_0.result == 6 then
				local var_2_4 = arg_1_0

				var_2_5 = var_2_5.sendNotification
				GAME = var_2_10004

				var_2_5(var_2_4, var_2_10004.CHAT_ROOM_MAX_NUMBER)
			else
				pg = var_2_5

				local var_2_6 = var_2_5.TipsMgr.GetInstance()
				local var_2_7 = var_1.ShowTips

				errorTip = var_2_10004

				var_2_7(var_2_6, var_2_10004("player_change_chat_room_erro", arg_2_0.result))
			end
		end

		return
	end)

	return
end

return var_0_1
