local ChapterAutoProxy = class("ChapterAutoProxy", import("model.proxy.NetProxy"))

ChapterAutoProxy.FINISH_UPDATE = "ChapterAutoProxy.FINISH_UPDATE"
ChapterAutoProxy.TYPE = {
	SLG = 1
}

function ChapterAutoProxy:register()
	self:on(13001, function(arg_2_0)
		self.recordData = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.chapter_auto_record_list) do
			self.recordData[iter_2_1.type] = self.recordData[iter_2_1.type] or {}
			self.recordData[iter_2_1.type][iter_2_1.id] = ChapterAutoProxy.GetFixTime(iter_2_1.type, iter_2_1.id, iter_2_1.seconds)
		end

		self.ticketData = {}

		for iter_2_2, iter_2_3 in ipairs(arg_2_0.chapter_auto_ticket_list) do
			self.ticketData[iter_2_3.type] = self.ticketData[iter_2_3.type] or {}
			self.ticketData[iter_2_3.type][iter_2_3.time] = ChapterAutoTicket.New(iter_2_3)
		end

		self:SetCommissionList(arg_2_0.chapter_auto_battle_list)

		self.oil = arg_2_0.oil
		self.dailyCostTime = arg_2_0.time_acc
		self.dailyExtraTime = arg_2_0.extra_time_max

		return
	end)
	self:ClearEventIds()

	return
end

function ChapterAutoProxy:UpdateRecord(arg_3_1, arg_3_2, arg_3_3)
	self.recordData[arg_3_1] = self.recordData[arg_3_1] or {}

	local var_3_0 = self.recordData[arg_3_1][arg_3_2] or 0
	local var_3_1 = ChapterAutoProxy.GetFixTime(arg_3_1, arg_3_2, arg_3_3)

	self.recordData[arg_3_1][arg_3_2] = var_3_0 == 0 and var_3_1 or math.min(var_3_0, var_3_1)

	return
end

function ChapterAutoProxy:GetRecord(arg_4_1, arg_4_2)
	if not self.recordData[arg_4_1] then
		return 0
	end

	return self.recordData[arg_4_1][arg_4_2] or 0
end

function ChapterAutoProxy:GetOil()
	return self.oil
end

function ChapterAutoProxy:ReduceOil(arg_6_1)
	self.oil = math.max(0, self.oil - arg_6_1)

	return
end

function ChapterAutoProxy:IncreaseOil(arg_7_1)
	self.oil = self.oil + arg_7_1

	return
end

function ChapterAutoProxy:GetMaxTime()
	return pg.gameset.auto_battle_time_limit.key_value + self.dailyExtraTime
end

function ChapterAutoProxy:GetRemainTime()
	return self:GetMaxTime() - self.dailyCostTime
end

function ChapterAutoProxy:AddCostTime(arg_10_1)
	self.dailyCostTime = self.dailyCostTime + arg_10_1

	return
end

function ChapterAutoProxy:ReduceCostTime(arg_11_1)
	self.dailyCostTime = math.max(0, self.dailyCostTime - arg_11_1)

	return
end

function ChapterAutoProxy:AddDailyExtraTime(arg_12_1)
	self.dailyExtraTime = self.dailyExtraTime + arg_12_1

	return
end

function ChapterAutoProxy:ResetDailyData()
	self.dailyCostTime = 0
	self.dailyExtraTime = 0

	return
end

function ChapterAutoProxy:GetTicketListByType(arg_14_1)
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in pairs(self.ticketData[arg_14_1] or {}) do
		if not iter_14_1:IsExpired() then
			table.insert(var_14_0, iter_14_1)
		end
	end

	return var_14_0
end

function ChapterAutoProxy:GetValidTicketCntByType(arg_15_1)
	local var_15_0 = 0

	for iter_15_0, iter_15_1 in pairs(self.ticketData[arg_15_1] or {}) do
		if not iter_15_1:IsExpired() then
			var_15_0 = var_15_0 + iter_15_1:GetCount()
		end
	end

	return var_15_0
end

function ChapterAutoProxy:ReduceTicketByType(arg_16_1, arg_16_2)
	local var_16_0 = arg_16_2
	local var_16_1 = {}

	for iter_16_0, iter_16_1 in pairs(self.ticketData[arg_16_1] or {}) do
		if not iter_16_1:IsExpired() then
			table.insert(var_16_1, iter_16_1.expireTime)
		end
	end

	table.sort(var_16_1)

	for iter_16_2, iter_16_3 in ipairs(var_16_1) do
		if not self.ticketData[arg_16_1][iter_16_3]:IsExpired() then
			local var_16_2 = self.ticketData[arg_16_1][iter_16_3]:GetCount()

			if arg_16_2 <= var_16_2 then
				self.ticketData[arg_16_1][iter_16_3]:ReduceCount(arg_16_2)

				if var_16_2 == arg_16_2 then
					self.ticketData[arg_16_1][iter_16_3] = nil
				end

				break
			else
				self.ticketData[arg_16_1][iter_16_3] = nil
				var_16_0 = arg_16_2 - var_16_2
			end
		end
	end

	return
end

function ChapterAutoProxy:AddTickets(arg_17_1)
	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		self.ticketData[iter_17_1.type] = self.ticketData[iter_17_1.type] or {}

		if self.ticketData[iter_17_1.type][iter_17_1.time] then
			self.ticketData[iter_17_1.type][iter_17_1.time]:IncreaseCount(iter_17_1.num)
		else
			self.ticketData[iter_17_1.type][iter_17_1.time] = ChapterAutoTicket.New(iter_17_1)
		end
	end

	return
end

function ChapterAutoProxy:AddTicketByItem(arg_18_1, arg_18_2)
	local var_18_0 = ChapterAutoTicket.CreateByItem(arg_18_1, arg_18_2)

	self.ticketData[arg_18_1] = self.ticketData[arg_18_1] or {}

	if self.ticketData[arg_18_1][var_18_0.id] then
		self.ticketData[arg_18_1][var_18_0.id]:IncreaseCount(var_18_0:GetCount())
	else
		self.ticketData[arg_18_1][var_18_0.id] = var_18_0
	end

	return
end

function ChapterAutoProxy:GetWillExpireTicketCnt()
	local var_19_0 = 0

	for iter_19_0, iter_19_1 in pairs(self.ticketData) do
		for iter_19_2, iter_19_3 in pairs(iter_19_1) do
			if iter_19_3:WillExpire() then
				var_19_0 = var_19_0 + iter_19_3:GetCount()
			end
		end
	end

	return var_19_0
end

function ChapterAutoProxy:SortCommissionList()
	table.sort(self.commissionList, CompareFuncs({
		function(arg_21_0)
			return arg_21_0:GetFinishTime()
		end,
		function(arg_22_0)
			return -arg_22_0.id
		end
	}))

	return
end

function ChapterAutoProxy:GetFinishedCnt()
	local var_23_0 = 0
	local var_23_1 = 0

	for iter_23_0, iter_23_1 in ipairs(self.commissionList) do
		if iter_23_1:IsFinished() then
			var_23_0 = var_23_0 + 1

			if iter_23_1:UsedTicket() then
				var_23_1 = var_23_1 + 1
			end
		end
	end

	return var_23_0, var_23_1
end

function ChapterAutoProxy:GetCntInfo()
	return self.finishedCnt, #self.commissionList
end

function ChapterAutoProxy:ClearCommissionList()
	self.commissionList = {}

	return
end

function ChapterAutoProxy:SetCommissionList(arg_26_1)
	self.commissionList = {}

	for iter_26_0, iter_26_1 in ipairs(arg_26_1) do
		table.insert(self.commissionList, ChapterAutoCommission.New(iter_26_1))
	end

	self:SortCommissionList()

	self.finishedCnt = self:GetFinishedCnt()

	return
end

function ChapterAutoProxy:GetCommissionList()
	return self.commissionList
end

function ChapterAutoProxy:GetFinishAllCommissionTime()
	if #self.commissionList == 0 then
		return 0
	end

	return self.commissionList[#self.commissionList]:GetFinishTime()
end

function ChapterAutoProxy:IsShowTip()
	if self.finishedCnt > 0 then
		return true
	end

	if self:GetWillExpireTicketCnt() > 0 then
		return true
	end

	return false
end

function ChapterAutoProxy:timeCall()
	return {
		[ProxyRegister.SecondCall] = function(arg_31_0)
			self:UpdatePerSecond()

			return
		end,
		[ProxyRegister.DayCall] = function(arg_32_0)
			self:UpdatePerDay()

			return
		end
	}
end

function ChapterAutoProxy:UpdatePerSecond()
	local var_33_0 = self:GetFinishedCnt()

	if var_33_0 ~= self.finishedCnt then
		self.finishedCnt = var_33_0

		self:sendNotification(ChapterAutoProxy.FINISH_UPDATE)
	end

	return
end

function ChapterAutoProxy:UpdatePerDay()
	for iter_34_0, iter_34_1 in pairs(self.ticketData) do
		for iter_34_2, iter_34_3 in ipairs(iter_34_1) do
			if iter_34_3:IsExpired() then
				self.ticketData[iter_34_3.id] = nil
			end
		end
	end

	self:ResetDailyData()

	return
end

function ChapterAutoProxy:GetSkipBatchBuildFlag()
	return self.skipBatchFlag or false
end

function ChapterAutoProxy:SetSkipBatchBuildFlag(arg_36_1)
	self.skipBatchFlag = arg_36_1

	return
end

function ChapterAutoProxy:SetRecordEventFlag(arg_37_1)
	self.recordEventFlag = arg_37_1

	return
end

function ChapterAutoProxy:RecordNewEventIds(arg_38_1)
	if self.recordEventFlag then
		self.newEventIds = table.mergeArray(self.newEventIds, arg_38_1)
	end

	return
end

function ChapterAutoProxy:GetNewEventIds()
	return self.newEventIds
end

function ChapterAutoProxy:ClearEventIds(arg_40_1)
	self.newEventIds = {}

	return
end

function ChapterAutoProxy:remove()
	return
end

function ChapterAutoProxy:GetFixTime(arg_42_1, arg_42_2)
	return switch(self, {
		[ChapterAutoProxy.TYPE.SLG] = function()
			if not pg.chapter_auto_statistics[arg_42_1] then
				return arg_42_2
			end

			return math.floor(arg_42_2 * pg.chapter_auto_statistics[arg_42_1].time_rate) + pg.chapter_auto_statistics[arg_42_1].time_correction
		end
	}, function()
		return arg_42_2
	end)
end

function ChapterAutoProxy.IsSystemOpen()
	return AutoBotCommand.autoBotSatisfied()
end

return ChapterAutoProxy
