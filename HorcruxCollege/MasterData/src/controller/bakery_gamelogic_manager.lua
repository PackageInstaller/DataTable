local var_0_0 = {
	workingType = {}
}
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4 = 3

function var_0_0.initData(arg_1_0)
	arg_1_0.max_ongoing_order_num = var_0_4
	arg_1_0.ongoing_order = {}
	arg_1_0.refresh_order_time = 0
	arg_1_0.wait_refresh_time = 0
	arg_1_0.max_wait_time = 0
	arg_1_0.first_order_time = 0
	arg_1_0.no_order_refresh_time = 0
	arg_1_0.cakeMachine = {
		tray_num = 0,
		chopping_num = 0,
		oven_num = 0,
		ovensPool = {},
		trays = {},
		choppingPool = {}
	}
	arg_1_0.milkteaMachine = {
		time = 0,
		working = false,
		empty_num = 0,
		milkteas = {}
	}
	arg_1_0.taroballsMachine = {
		time = 0,
		working = false,
		empty_num = 0,
		taroballs = {}
	}
	arg_1_0.gamePaused = false
	arg_1_0.gameEvents = {}
	arg_1_0.auto_commit = false
	arg_1_0.time_speedup = false
	arg_1_0.no_burning = false
	arg_1_0.double_gold = false
	arg_1_0.gold = 0
	arg_1_0.target_gold = 0
	arg_1_0.level_time = 0
	arg_1_0.time = 0
	arg_1_0.order_create = {}
	arg_1_0.prize = {}
	arg_1_0.is_first_order = true
end

function var_0_0.registerUIRef(arg_2_0, arg_2_1)
	arg_2_0.uiref = arg_2_1
end

function var_0_0.unregisterUIRef(arg_3_0)
	arg_3_0.uiref = nil
end

function var_0_0:exitGame()
	self:unloop()
	self:initData()
	self:unregisterUIRef()
end

function var_0_0:registerGameEvent(arg_5_1, arg_5_2, arg_5_3)
	self.gameEvents[arg_5_1] = self.gameEvents[arg_5_1] or {}

	table.insert(self.gameEvents[arg_5_1], {
		obj = arg_5_2,
		handler = arg_5_3
	})
end

function var_0_0:unregisterGameEvent(arg_6_1, arg_6_2)
	if self.gameEvents[arg_6_1] then
		for iter_6_0, iter_6_1 in pairs(self.gameEvents[arg_6_1]) do
			if iter_6_1.handler == arg_6_2 then
				table.remove(self.gameEvents[arg_6_1], iter_6_1)
			end
		end
	end
end

function var_0_0:dispatcherEvent(arg_7_1, ...)
	if self.gameEvents[arg_7_1] then
		for iter_7_0, iter_7_1 in pairs(self.gameEvents[arg_7_1]) do
			iter_7_1.handler(iter_7_1.obj, ...)
		end
	end
end

function var_0_0:loadGameData(arg_8_1)
	self:usingHelpItem(arg_8_1.usingHelpItem)

	local var_8_0 = self.time_speedup and 0.5 or 1

	self.max_ongoing_order_num = arg_8_1.max_ongoing_order_num
	self.ongoing_order = {}
	self.refresh_order_time = arg_8_1.refresh_order_time
	self.wait_refresh_time = 0
	self.max_wait_time = arg_8_1.max_wait_time
	self.first_order_time = arg_8_1.first_order_time
	self.no_order_refresh_time = arg_8_1.no_order_refresh_time
	self.cakeMachine = {
		oven_num = arg_8_1.oven_num,
		ovensPool = {},
		tray_num = arg_8_1.tray_num,
		trays = {},
		chopping_num = arg_8_1.chopping_num,
		choppingPool = {},
		fruitPool = {}
	}
	self.milkteaMachine = {
		time = 0,
		working = false,
		empty_num = arg_8_1.milktea_num,
		milkteas = {}
	}
	self.taroballsMachine = {
		time = 0,
		working = false,
		empty_num = arg_8_1.taroballs_num,
		taroballs = {}
	}
	self.oventime = arg_8_1.oventime * var_8_0
	self.burningtime = arg_8_1.burningtime
	self.choptime = arg_8_1.choptime * var_8_0
	self.milkteatime = arg_8_1.milkteatime * var_8_0
	self.taroballstime = arg_8_1.taroballstime * var_8_0
	self.fruitPoolNum = arg_8_1.fruitPoolNum
	self.is_first_order = true

	for iter_8_0 = 1, arg_8_1.oven_num do
		table.insert(self.cakeMachine.ovensPool, {
			time = 0
		})
	end

	for iter_8_1 = 1, arg_8_1.tray_num do
		table.insert(self.cakeMachine.trays, {})
	end

	for iter_8_2 = 1, arg_8_1.chopping_num do
		table.insert(self.cakeMachine.choppingPool, {
			time = 0
		})
	end

	self:dispatcherEvent("UPDATE_CAKEMACHINE", self.cakeMachine)

	for iter_8_3 = 1, arg_8_1.milktea_num do
		table.insert(self.milkteaMachine.milkteas, {})
	end

	self:dispatcherEvent("UPDATE_MILKTEA", self.milkteaMachine)

	for iter_8_4 = 1, arg_8_1.taroballs_num do
		table.insert(self.taroballsMachine.taroballs, {})
	end

	self:dispatcherEvent("UPDATE_TAROBALLS", self.taroballsMachine)

	self.gold = 0
	self.target_gold = arg_8_1.target_gold
	self.level_time = arg_8_1.level_time
	self.time = 0

	self:dispatcherEvent("UPDATE_ORDERS", self.ongoing_order)

	self.order_create = arg_8_1.order_create
	self.prize = arg_8_1.prize
end

function var_0_0:gameUpdate(arg_9_1)
	if self.gamePaused then
		return
	end

	if self.time < self.level_time then
		self.time = self.time + arg_9_1
	else
		self:gameEnd()
	end

	if self.auto_commit then
		self.auto_commit_time = self.auto_commit_time or 0

		if self.auto_commit_time > 1 then
			self:autoCommit()

			self.auto_commit_time = 0
		else
			self.auto_commit_time = self.auto_commit_time + arg_9_1
		end
	end

	self:ordersUpdate(arg_9_1)
	self:producingUpdate(arg_9_1)
	self:updateUIElements()
end

function var_0_0:ordersUpdate(arg_10_1)
	local var_10_0
	local var_10_1 = 0

	for iter_10_0 = 1, self.max_ongoing_order_num do
		self.ongoing_order[iter_10_0] = self.ongoing_order[iter_10_0] or {}

		if not next(self.ongoing_order[iter_10_0]) then
			var_10_0 = true
			var_10_1 = var_10_1 + 1
		end

		if self.ongoing_order[iter_10_0].time and self.ongoing_order[iter_10_0].max_wait_time then
			if self.ongoing_order[iter_10_0].max_wait_time > self.ongoing_order[iter_10_0].time then
				self.ongoing_order[iter_10_0].time = self.ongoing_order[iter_10_0].time + arg_10_1
			else
				self.ongoing_order[iter_10_0] = {}

				self:dispatcherEvent("UPDATE_ORDERS", self.ongoing_order)
				self:dispatcherEvent("PLAY_ORDER_FAIL_ANI", iter_10_0)
			end
		end
	end

	if var_10_0 then
		self.wait_refresh_time = self.wait_refresh_time + arg_10_1
	end

	if (var_10_1 == var_0_4 and (self.is_first_order and self.first_order_time or self.no_order_refresh_time) or self.is_first_order and self.first_order_time or self.refresh_order_time) <= self.wait_refresh_time then
		self.wait_refresh_time = 0
		self.is_first_order = false

		for iter_10_1 = 1, self.max_ongoing_order_num do
			if not next(self.ongoing_order[iter_10_1]) then
				self.ongoing_order[iter_10_1] = self:createNewOrder()

				self:dispatcherEvent("UPDATE_ORDERS", self.ongoing_order)

				break
			end
		end
	end
end

function var_0_0:producingUpdate(arg_11_1)
	for iter_11_0 = 1, self.cakeMachine.oven_num do
		if not self.cakeMachine.ovensPool[iter_11_0] or not next(self.cakeMachine.ovensPool[iter_11_0]) then
			self.cakeMachine.ovensPool[iter_11_0] = {
				time = 0
			}
		end

		if self.cakeMachine.ovensPool[iter_11_0].cake then
			if self.cakeMachine.ovensPool[iter_11_0].time < self.burningtime + self.oventime then
				self.cakeMachine.ovensPool[iter_11_0].time = self.cakeMachine.ovensPool[iter_11_0].time + arg_11_1
			elseif not self.no_burning and not self.cakeMachine.ovensPool[iter_11_0].is_burning then
				self.cakeMachine.ovensPool[iter_11_0].is_burning = true

				self:dispatcherEvent("UPDATE_CAKEMACHINE", self.cakeMachine)
			end
		end
	end

	for iter_11_1 = 1, self.cakeMachine.chopping_num do
		if not self.cakeMachine.choppingPool[iter_11_1] or not next(self.cakeMachine.choppingPool[iter_11_1]) then
			self.cakeMachine.choppingPool[iter_11_1] = {
				time = 0
			}
		end

		if self.cakeMachine.choppingPool[iter_11_1].fruit then
			self.cakeMachine.choppingPool[iter_11_1].time = self.cakeMachine.choppingPool[iter_11_1].time + arg_11_1
		end

		if self.cakeMachine.choppingPool[iter_11_1].time >= self.choptime then
			self.cakeMachine.choppingPool[iter_11_1].time = 0
			self.cakeMachine.choppingPool[iter_11_1].fruit = nil
			self.cakeMachine.fruitPool[self.cakeMachine.choppingPool[iter_11_1].fruit] = self.fruitPoolNum

			self:dispatcherEvent("UPDATE_CAKEMACHINE", self.cakeMachine)
		end
	end

	if self.milkteaMachine.working then
		self.milkteaMachine.time = self.milkteaMachine.time + arg_11_1

		if self.milkteaMachine.time >= self.milkteatime then
			self.milkteaMachine.working = false

			for iter_11_2 = 1, self.milkteaMachine.empty_num do
				self.milkteaMachine.milkteas[iter_11_2] = self.milkteaMachine.milkteas[iter_11_2] or {}

				if not next(self.milkteaMachine.milkteas[iter_11_2]) then
					self.milkteaMachine.milkteas[iter_11_2] = {
						pearl = 0,
						base = true
					}
				end
			end

			self.milkteaMachine.time = 0

			self:dispatcherEvent("UPDATE_MILKTEA", self.milkteaMachine)
		end
	end

	if self.taroballsMachine.working then
		self.taroballsMachine.time = self.taroballsMachine.time + arg_11_1

		if self.taroballsMachine.time >= self.taroballstime then
			self.taroballsMachine.working = false

			for iter_11_3 = 1, self.taroballsMachine.empty_num do
				self.taroballsMachine.taroballs[iter_11_3] = self.taroballsMachine.taroballs[iter_11_3] or {}

				if not next(self.taroballsMachine.taroballs[iter_11_3]) then
					self.taroballsMachine.taroballs[iter_11_3] = {
						excipient1 = 0,
						excipient2 = 0,
						base = true
					}
				end
			end

			self.taroballsMachine.time = 0

			self:dispatcherEvent("UPDATE_TAROBALLS", self.taroballsMachine)
		end
	end
end

function var_0_0:choppingFruit(arg_12_1)
	local var_12_0

	for iter_12_0, iter_12_1 in ipairs(self.cakeMachine.choppingPool) do
		if not iter_12_1.fruit then
			var_12_0 = iter_12_0

			break
		end
	end

	if not var_12_0 then
		global_ShowBlockWords("当前没有空闲的砧板了~")

		return
	end

	self.cakeMachine.choppingPool[var_12_0].fruit = arg_12_1

	self:dispatcherEvent("UPDATE_CAKEMACHINE", self.cakeMachine)
end

function var_0_0:ovenCake(arg_13_1)
	if not arg_13_1 then
		for iter_13_0, iter_13_1 in ipairs(self.cakeMachine.choppingPool) do
			if not iter_13_1.cake then
				arg_13_1 = iter_13_0

				break
			end
		end

		if not arg_13_1 then
			global_ShowBlockWords("当前没有空闲的烤箱了~")

			return
		end
	end

	if not self.cakeMachine.ovensPool[arg_13_1] then
		return
	end

	self.cakeMachine.ovensPool[arg_13_1].cake = true

	self:dispatcherEvent("UPDATE_CAKEMACHINE", self.cakeMachine)
end

function var_0_0:milkteaMachineWorking()
	if self.milkteaMachine.working then
		global_ShowBlockWords("奶茶机正在工作哦~")

		return
	end

	self.milkteaMachine.working = true

	self:dispatcherEvent("UPDATE_MILKTEA", self.milkteaMachine)
end

function var_0_0:taroballsMachineWorking()
	if self.taroballsMachine.working then
		global_ShowBlockWords("芋圆正在制作中~")

		return
	end

	self.taroballsMachine.working = true

	self:dispatcherEvent("UPDATE_TAROBALLS", self.taroballsMachine)
end

function var_0_0:addDough(arg_16_1)
	if not self.cakeMachine.ovensPool[arg_16_1] then
		global_ShowBlockWords("烤箱还未解锁~")

		return
	end

	if not self.cakeMachine.ovensPool[arg_16_1].cake then
		self:ovenCake(arg_16_1)

		return
	end

	if self.cakeMachine.ovensPool[arg_16_1].is_burning then
		self.cakeMachine.ovensPool[arg_16_1] = {
			time = 0
		}

		self:dispatcherEvent("UPDATE_CAKEMACHINE", self.cakeMachine)

		return
	end

	if self.cakeMachine.ovensPool[arg_16_1].time < self.oventime then
		global_ShowBlockWords("蛋糕烤制中")

		return
	end

	local var_16_0

	for iter_16_0, iter_16_1 in ipairs(self.cakeMachine.trays) do
		if not iter_16_1.cake then
			var_16_0 = iter_16_0

			break
		end
	end

	if not var_16_0 then
		global_ShowBlockWords("当前没有空盘子了")

		return
	end

	self.cakeMachine.trays[var_16_0] = {
		fruit = 0,
		cake = 1,
		cream = 0
	}
	self.cakeMachine.ovensPool[arg_16_1] = {}

	self:dispatcherEvent("UPDATE_CAKEMACHINE", self.cakeMachine)
end

function var_0_0:addPearls()
	local var_17_0

	for iter_17_0, iter_17_1 in ipairs(self.milkteaMachine.milkteas) do
		if iter_17_1.base and iter_17_1.pearl == 0 then
			var_17_0 = iter_17_0

			break
		end
	end

	if not var_17_0 then
		global_ShowBlockWords("当前没有可以加珍珠的奶茶")

		return
	end

	self.milkteaMachine.milkteas[var_17_0].pearl = 1

	self:dispatcherEvent("UPDATE_MILKTEA", self.milkteaMachine)
end

function var_0_0:addExcipients(arg_18_1)
	local var_18_0

	for iter_18_0, iter_18_1 in ipairs(self.taroballsMachine.taroballs) do
		if iter_18_1.base and (not iter_18_1["excipient" .. arg_18_1] or iter_18_1["excipient" .. arg_18_1] == 0) then
			var_18_0 = iter_18_0

			break
		end
	end

	if not var_18_0 then
		global_ShowBlockWords("当前没有可以加该辅料的芋圆")

		return
	end

	self.taroballsMachine.taroballs[var_18_0]["excipient" .. arg_18_1] = 1

	self:dispatcherEvent("UPDATE_TAROBALLS", self.taroballsMachine)
end

function var_0_0:addFruit(arg_19_1)
	if not self.cakeMachine.fruitPool[arg_19_1] or self.cakeMachine.fruitPool[arg_19_1] <= 0 then
		global_ShowBlockWords("水果用完啦！")

		return
	end

	local var_19_0

	for iter_19_0, iter_19_1 in ipairs(self.cakeMachine.trays) do
		if iter_19_1.cake and (iter_19_1.fruit == 0 or not iter_19_1.fruit) then
			var_19_0 = iter_19_0

			break
		end
	end

	if not var_19_0 then
		global_ShowBlockWords("没有可以加水果的蛋糕！")

		return
	end

	self.cakeMachine.trays[var_19_0].fruit = arg_19_1
	self.cakeMachine.fruitPool[arg_19_1] = self.cakeMachine.fruitPool[arg_19_1] - 1

	self:dispatcherEvent("UPDATE_CAKEMACHINE", self.cakeMachine)
end

function var_0_0:addCream(arg_20_1)
	local var_20_0

	for iter_20_0, iter_20_1 in ipairs(self.cakeMachine.trays) do
		if iter_20_1.cake and (iter_20_1.cream == 0 or not iter_20_1.cream) then
			var_20_0 = iter_20_0

			break
		end
	end

	if not var_20_0 then
		global_ShowBlockWords("没有可以加奶油的蛋糕！")

		return
	end

	self.cakeMachine.trays[var_20_0].cream = arg_20_1

	self:dispatcherEvent("UPDATE_CAKEMACHINE", self.cakeMachine)
end

function var_0_0:commitProduct(arg_21_1, arg_21_2, arg_21_3)
	local var_21_0
	local var_21_2
	local var_21_3

	if arg_21_1 == var_0_1 then
		var_21_0 = self.cakeMachine.trays
		var_21_2 = "UPDATE_CAKEMACHINE"
		var_21_3 = self.cakeMachine
	elseif arg_21_1 == var_0_2 then
		var_21_0 = self.milkteaMachine.milkteas
		var_21_2 = "UPDATE_MILKTEA"
		var_21_3 = self.milkteaMachine
	elseif arg_21_1 == var_0_3 then
		var_21_0 = self.taroballsMachine.taroballs
		var_21_2 = "UPDATE_TAROBALLS"
		var_21_3 = self.taroballsMachine
	end

	local var_21_4 = var_21_0 and var_21_0[arg_21_2]

	if not (var_21_0 and var_21_0[arg_21_2]) or not next(var_21_4) then
		return
	end

	local var_21_5 = {}

	for iter_21_0, iter_21_1 in ipairs(self.ongoing_order) do
		local var_21_6, var_21_7 = self:checkIsInOrder(iter_21_0, var_21_4)

		if var_21_6 then
			table.insert(var_21_5, var_21_7)
		end
	end

	if not next(var_21_5) then
		if not arg_21_3 then
			global_ShowBlockWords("顾客们好像不需要这个~双击可以丢弃")
		end

		return
	end

	table.sort(var_21_5, function(arg_22_0, arg_22_1)
		return arg_22_0.percent >= arg_22_1.percent
	end)

	var_21_0[arg_21_2] = {}
	var_21_5[1].product.isfinished = true

	self:checkOrderFinsihed(var_21_5[1].orderIndex)
	self:dispatcherEvent(var_21_2, var_21_3)
	self:dispatcherEvent("UPDATE_ORDERS", self.ongoing_order)
end

function var_0_0:discardProduct(arg_23_1, arg_23_2)
	local var_23_0
	local var_23_2
	local var_23_3

	if arg_23_1 == var_0_1 then
		var_23_0 = self.cakeMachine.trays
		var_23_2 = "UPDATE_CAKEMACHINE"
		var_23_3 = self.cakeMachine
	elseif arg_23_1 == var_0_2 then
		var_23_0 = self.milkteaMachine.milkteas
		var_23_2 = "UPDATE_MILKTEA"
		var_23_3 = self.milkteaMachine
	elseif arg_23_1 == var_0_3 then
		var_23_0 = self.taroballsMachine.taroballs
		var_23_2 = "UPDATE_TAROBALLS"
		var_23_3 = self.taroballsMachine
	end

	if not (var_23_0 and var_23_0[arg_23_2]) or not next(var_23_0 and var_23_0[arg_23_2]) then
		return
	end

	var_23_0[arg_23_2] = {}

	global_ShowBlockWords("丢弃成功!!!")
	self:dispatcherEvent(var_23_2, var_23_3)
end

function var_0_0:checkOrderFinsihed(arg_24_1)
	if not self.ongoing_order[arg_24_1] or not next(self.ongoing_order[arg_24_1]) then
		return
	end

	for iter_24_0, iter_24_1 in pairs(self.ongoing_order[arg_24_1]) do
		if type(iter_24_1) == "table" and not iter_24_1.isfinished then
			return false
		end
	end

	local var_24_1 = (1 - self.ongoing_order[arg_24_1].time / self.max_wait_time) * 100 > 66 and 1 or (1 - self.ongoing_order[arg_24_1].time / self.max_wait_time) * 100 > 33 and 0.5 or 0.25

	if self.double_gold then
		var_24_1 = var_24_1 * 2
	end

	local var_24_2 = 0

	for iter_24_2 = 1, 4 do
		local var_24_3 = self.ongoing_order[arg_24_1]["product_" .. iter_24_2]

		if self.ongoing_order[arg_24_1]["product_" .. iter_24_2] then
			var_24_2 = var_24_2 + (var_24_3.cake and 0 or 1) * self.prize.cake_prize + (var_24_3.cream and var_24_3.cream ~= 0 and 1 or 0) * self.prize.cream_prize + ((var_24_3.fruit or nil) and (self.prize["fruit_prize_" .. var_24_3.fruit] or 0)) + (var_24_3.paerl or 0) * self.prize.milktea_prize + (var_24_3.paerl or 0) * self.prize.pearl_prize + (var_24_3.excipient1 and 0 or 1) * self.prize.taroballs_prize + (var_24_3.excipients_prize_1 or 0) * self.prize.excipients_prize_1 + (var_24_3.excipients_prize_2 or 0) * self.prize.excipients_prize_2
		end
	end

	self.gold = self.gold + math.max(1, math.floor(var_24_2 * var_24_1))
	self.ongoing_order[arg_24_1] = {}

	self:dispatcherEvent("PLAY_ORDER_SUCCESS_ANI", arg_24_1)

	return true
end

function var_0_0:updateUIElements()
	self:dispatcherEvent("UPDATE_UIPROGRESS", {
		oventime = self.oventime,
		burningtime = self.burningtime,
		choptime = self.choptime,
		milkteatime = self.milkteatime,
		taroballstime = self.taroballstime,
		max_wait_time = self.max_wait_time,
		level_time = self.level_time,
		ovendata = self.cakeMachine.ovensPool,
		choppingdata = self.cakeMachine.choppingPool,
		milkteadata = self.milkteaMachine.time,
		taroballsdata = self.taroballsMachine.time,
		orderdata = self.ongoing_order,
		game_time = self.time,
		gold = self.gold,
		target_gold = self.target_gold
	})
end

function var_0_0:createNewOrder()
	local var_26_0 = {
		time = 0,
		max_wait_time = self.max_wait_time
	}
	local var_26_1 = math.min(math.random(self.order_create.cake_need_min, self.order_create.cake_need_max), 4)
	local var_26_2 = 0
	local var_26_3 = 0

	if var_26_1 < 4 then
		if math.random(1, 2) == 1 then
			var_26_2 = math.min(math.random(self.order_create.milktea_need_min, self.order_create.milktea_need_max), 4 - var_26_1)
			var_26_3 = math.min(math.random(self.order_create.taroballs_need_min, self.order_create.taroballs_need_max), 4 - var_26_1 - var_26_2)
		else
			var_26_3 = math.min(math.random(self.order_create.taroballs_need_min, self.order_create.taroballs_need_max), 4 - var_26_1)
			var_26_2 = math.min(math.random(self.order_create.milktea_need_min, self.order_create.milktea_need_max), 4 - var_26_1 - var_26_3)
		end
	end

	for iter_26_0 = 1, var_26_1 do
		var_26_0["product_" .. iter_26_0] = {
			cake = 1,
			fruit = math.random(0, 3),
			cream = math.random(0, 3)
		}
	end

	for iter_26_1 = var_26_1 + 1, var_26_1 + var_26_2 do
		var_26_0["product_" .. iter_26_1] = {
			base = true,
			pearl = math.random(0, 1)
		}
	end

	for iter_26_2 = var_26_1 + var_26_2 + 1, var_26_1 + var_26_2 + var_26_3 do
		var_26_0["product_" .. iter_26_2] = {
			base = true,
			excipient1 = math.random(0, 1),
			excipient2 = math.random(0, 1)
		}
	end

	if var_26_1 + var_26_2 + var_26_3 == 0 then
		return self:createNewOrder()
	else
		return var_26_0
	end
end

function var_0_0.getInfo(arg_27_0)
	return
end

function var_0_0:checkIsInOrder(arg_28_1, arg_28_2)
	if not self.ongoing_order[arg_28_1] or not next(self.ongoing_order[arg_28_1]) then
		return false
	end

	for iter_28_0, iter_28_1 in pairs(self.ongoing_order[arg_28_1]) do
		if type(iter_28_1) == "table" and not iter_28_1.isfinished then
			local var_28_0 = true

			for iter_28_2, iter_28_3 in pairs(iter_28_1) do
				if iter_28_2 ~= "isfinished" and (not arg_28_2[iter_28_2] or arg_28_2[iter_28_2] ~= iter_28_3) then
					var_28_0 = false
				end
			end

			if var_28_0 then
				return true, {
					product = iter_28_1,
					percent = self.ongoing_order[arg_28_1].time / self.ongoing_order[arg_28_1].max_wait_time,
					orderIndex = arg_28_1
				}
			end
		end
	end

	return false
end

function var_0_0.usingHelpItem(arg_29_0, arg_29_1)
	if not arg_29_1 then
		return
	end

	arg_29_0.auto_commit = arg_29_1.auto_commit
	arg_29_0.time_speedup = arg_29_1.time_speedup
	arg_29_0.no_burning = arg_29_1.no_burning
	arg_29_0.double_gold = arg_29_1.double_gold
end

function var_0_0:autoCommit()
	for iter_30_0 = 1, self.cakeMachine.tray_num do
		self:commitProduct(var_0_1, iter_30_0, true)
	end

	for iter_30_1 = 1, self.milkteaMachine.empty_num do
		self:commitProduct(var_0_2, iter_30_1, true)
	end

	for iter_30_2 = 1, self.taroballsMachine.empty_num do
		self:commitProduct(var_0_3, iter_30_2, true)
	end
end

function var_0_0:gameEnd()
	self:unloop()

	if self.gold < self.target_gold then
		self:gameFailed()
	else
		self:gameWin()
	end
end

function var_0_0:gameFailed()
	self:dispatcherEvent("GAME_END", {
		gold = self.gold
	})
end

function var_0_0:gameWin()
	self:dispatcherEvent("GAME_END", {
		gold = self.gold
	})
end

function var_0_0:createMainLoop()
	self.mainloop = self.mainloop or cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_35_0)
		self:gameUpdate(arg_35_0)
	end, 0, false)
end

function var_0_0:unloop()
	if self.mainloop then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.mainloop)

		self.mainloop = nil
	end
end

return var_0_0
