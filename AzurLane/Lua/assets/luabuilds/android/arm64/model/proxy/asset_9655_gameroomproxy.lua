class = var_0_10000

local var_0_0 = "GameRoomProxy"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NetProxy"))

var_0_1.coin_res_id = 11
var_0_1.ticket_res_id = 12
var_0_1.ticket_remind = false

function var_0_1.register(arg_1_0)
	arg_1_0.data = {}
	arg_1_0.rooms = {}

	arg_1_0:on(26120, function(arg_2_0)
		arg_1_0.weekly = arg_2_0.weekly_free
		arg_1_0.monthlyTicket = arg_2_0.monthly_ticket

		if arg_2_0.rooms then
			ipairs = var_1

			for iter_2_0, iter_2_1 in var_1(arg_2_0.rooms) do
				table = var_2_10006

				var_2_10006.insert(arg_1_0.rooms, {
					roomId = iter_2_1.roomid,
					maxScore = iter_2_1.max_score
				})
			end
		end

		arg_1_0.payCoinCount = arg_2_0.pay_coin_count
		arg_1_0.firstEnter = arg_2_0.first_enter

		return
	end)

	return
end

function var_0_1.getRoomScore(arg_3_0, arg_3_1)
	ipairs = var_1_10002

	for iter_3_0, iter_3_1 in var_1_10002(arg_3_0.rooms) do
		if iter_3_1.roomId == arg_3_1 then
			return iter_3_1.maxScore
		end
	end

	return 0
end

function var_0_1.storeGameScore(arg_4_0, arg_4_1, arg_4_2)
	ipairs = var_1_10003

	for iter_4_0, iter_4_1 in var_1_10003(arg_4_0.rooms) do
		if iter_4_1.roomId == arg_4_1 and arg_4_2 > iter_4_1.maxScore then
			iter_4_1.maxScore = arg_4_2

			return
		end
	end

	table = var_3

	var_3.insert(arg_4_0.rooms, {
		roomId = arg_4_1,
		maxScore = arg_4_2
	})

	return
end

function var_0_1.getCoin(arg_5_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_5_0 = var_1_10001(var_1_10003)
	local var_5_1 = var_1.getRawData(var_5_0)

	return var_1.getResource(var_5_1, var_0_1.coin_res_id)
end

function var_0_1.getTicket(arg_6_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_6_0 = var_1_10001(var_1_10003)
	local var_6_1 = var_1.getRawData(var_6_0)

	return var_1.getResource(var_6_1, var_0_1.ticket_res_id)
end

function var_0_1.getMonthlyTicket(arg_7_0)
	return arg_7_0.monthlyTicket
end

function var_0_1.setMonthlyTicket(arg_8_0, arg_8_1)
	arg_8_0.monthlyTicket = arg_8_0.monthlyTicket + arg_8_1

	return
end

function var_0_1.lastMonthlyTicket(arg_9_0)
	pg = var_1_10001

	return var_1_10001.gameset.game_ticket_month.key_value - arg_9_0.monthlyTicket < 0 and 0 or var_1
end

function var_0_1.lastTicketMax(arg_10_0)
	pg = var_1_10001

	return var_1_10001.gameset.game_room_remax.key_value - arg_10_0:getTicket() < 0 and 0 or var_1
end

function var_0_1.ticketMaxTip(arg_11_0)
	if arg_11_0:lastMonthlyTicket() <= 200 then
		i18n = var_1

		return var_1("game_ticket_max_month")
	elseif arg_11_0:lastTicketMax() <= 200 then
		i18n = var_1

		return var_1("game_ticket_max_all")
	end

	return nil
end

function var_0_1.getFirstEnter(arg_12_0)
	return arg_12_0.firstEnter == 0
end

function var_0_1.getPayCoinCount(arg_13_0)
	return arg_13_0.payCoinCount
end

function var_0_1.setPayCoinCount(arg_14_0, arg_14_1)
	arg_14_0.payCoinCount = arg_14_0.payCoinCount + arg_14_1

	return
end

function var_0_1.setFirstEnter(arg_15_0)
	arg_15_0.firstEnter = 1

	return
end

function var_0_1.getWeekly(arg_16_0)
	return arg_16_0.weekly == 0
end

function var_0_1.setWeekly(arg_17_0)
	arg_17_0.weekly = 1

	return
end

function var_0_1.getTip(arg_18_0)
	if arg_18_0.firstEnter == 0 then
		return true
	end

	if arg_18_0.weekly == 0 then
		return true
	end

	return false
end

return var_0_1
