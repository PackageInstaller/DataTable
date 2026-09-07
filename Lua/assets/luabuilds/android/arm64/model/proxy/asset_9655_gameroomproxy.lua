local GameRoomProxy = class("GameRoomProxy", import(".NetProxy"))

GameRoomProxy.coin_res_id = 11
GameRoomProxy.ticket_res_id = 12
GameRoomProxy.ticket_remind = false

function GameRoomProxy:register()
	self.data = {}
	self.rooms = {}

	self:on(26120, function(arg_2_0)
		self.weekly = arg_2_0.weekly_free
		self.monthlyTicket = arg_2_0.monthly_ticket

		if arg_2_0.rooms then
			for iter_2_0, iter_2_1 in ipairs(arg_2_0.rooms) do
				table.insert(self.rooms, {
					roomId = iter_2_1.roomid,
					maxScore = iter_2_1.max_score
				})
			end
		end

		self.payCoinCount = arg_2_0.pay_coin_count
		self.firstEnter = arg_2_0.first_enter

		return
	end)

	return
end

function GameRoomProxy:getRoomScore(arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(self.rooms) do
		if iter_3_1.roomId == arg_3_1 then
			return iter_3_1.maxScore
		end
	end

	return 0
end

function GameRoomProxy:storeGameScore(arg_4_1, arg_4_2)
	for iter_4_0, iter_4_1 in ipairs(self.rooms) do
		if iter_4_1.roomId == arg_4_1 and arg_4_2 > iter_4_1.maxScore then
			iter_4_1.maxScore = arg_4_2

			return
		end
	end

	table.insert(self.rooms, {
		roomId = arg_4_1,
		maxScore = arg_4_2
	})

	return
end

function GameRoomProxy:getCoin()
	return getProxy(PlayerProxy):getRawData():getResource(GameRoomProxy.coin_res_id)
end

function GameRoomProxy:getTicket()
	return getProxy(PlayerProxy):getRawData():getResource(GameRoomProxy.ticket_res_id)
end

function GameRoomProxy:getMonthlyTicket()
	return self.monthlyTicket
end

function GameRoomProxy:setMonthlyTicket(arg_8_1)
	self.monthlyTicket = self.monthlyTicket + arg_8_1

	return
end

function GameRoomProxy:lastMonthlyTicket()
	return pg.gameset.game_ticket_month.key_value - self.monthlyTicket < 0 and 0 or pg.gameset.game_ticket_month.key_value - self.monthlyTicket
end

function GameRoomProxy:lastTicketMax()
	local var_10_0 = pg.gameset.game_room_remax.key_value - self:getTicket()

	return var_10_0 < 0 and 0 or var_10_0
end

function GameRoomProxy:ticketMaxTip()
	if self:lastMonthlyTicket() <= 200 then
		return i18n("game_ticket_max_month")
	elseif self:lastTicketMax() <= 200 then
		return i18n("game_ticket_max_all")
	end

	return nil
end

function GameRoomProxy:getFirstEnter()
	return self.firstEnter == 0
end

function GameRoomProxy:getPayCoinCount()
	return self.payCoinCount
end

function GameRoomProxy:setPayCoinCount(arg_14_1)
	self.payCoinCount = self.payCoinCount + arg_14_1

	return
end

function GameRoomProxy:setFirstEnter()
	self.firstEnter = 1

	return
end

function GameRoomProxy:getWeekly()
	return self.weekly == 0
end

function GameRoomProxy:setWeekly()
	self.weekly = 1

	return
end

function GameRoomProxy:getTip()
	if self.firstEnter == 0 then
		return true
	end

	if self.weekly == 0 then
		return true
	end

	return false
end

return GameRoomProxy
