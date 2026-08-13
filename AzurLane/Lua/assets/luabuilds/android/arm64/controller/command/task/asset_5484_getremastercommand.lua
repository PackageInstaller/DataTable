class = var_0_10000

local var_0_0 = "GetRemasterCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	pg = var_1_10002

	local var_1_0 = var_1_10002.ConnectionMgr.GetInstance()

	var_2.Send(var_1_0, 13503, {
		type = 0
	}, 13504, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			ChapterProxy = var_2_10003

			local var_2_0 = var_1(var_2_10003)

			var_1.updateDailyCount(var_2_0)

			Drop = var_2

			local var_2_1 = var_2.New
			local var_2_2 = {}

			DROP_TYPE_VITEM = var_2_10005
			var_2_2.type = var_2_10005
			ITEM_ID_REACT_CHAPTER_TICKET = var_2_10005
			var_2_2.id = var_2_10005
			math = var_2_10005

			local var_2_3 = var_2_10005.min

			pg = var_2_10007

			local var_2_4 = var_2_10007.gameset.reactivity_ticket_daily.key_value

			pg = var_2_10008
			var_2_2.count = var_2_3(var_2_4, var_2_10008.gameset.reactivity_ticket_max.key_value - var_1.remasterTickets)

			local var_2_5 = var_2_1(var_2_2)
			local var_2_6 = arg_1_0
			local var_2_7 = var_3.sendNotification

			GAME = var_2_10006

			var_2_7(var_2_6, var_2_10006.ADD_ITEM, var_2_5)

			local var_2_8 = arg_1_0
			local var_2_9 = var_3.sendNotification

			GAME = var_6

			var_2_9(var_2_8, var_6.GET_REMASTER_TICKETS_DONE, {
				var_2_5
			})
		else
			pg = var_1

			local var_2_10 = var_1.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_10, "领取失败")
		end

		return
	end)

	return
end

return var_0_1
