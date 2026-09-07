local IslandTicketAgency = class("IslandTicketAgency", import(".IslandBaseAgency"))

IslandTicketAgency.REMIND_TIP_KEY = "IslandTicketAgency.REMIND_TIP_KEY"

function IslandTicketAgency:OnInit(arg_1_1)
	self.data = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.speed_tickets) do
		self.data[iter_1_1.key.speed_id] = self.data[iter_1_1.key.speed_id] or {}
		self.data[iter_1_1.key.speed_id][iter_1_1.key.end_time] = IslandTicket.New(iter_1_1.key.speed_id, iter_1_1.key.end_time, iter_1_1.num)
	end

	self.localTipKey = IslandTicketAgency.REMIND_TIP_KEY .. "_" .. getProxy(PlayerProxy):getRawData().id

	return
end

function IslandTicketAgency:AddTicket(arg_2_1, arg_2_2, arg_2_3)
	self.data[arg_2_1] = self.data[arg_2_1] or {}

	if self.data[arg_2_1][arg_2_2] then
		self.data[arg_2_1][arg_2_2]:AddCount(arg_2_3)
	else
		self.data[arg_2_1][arg_2_2] = IslandTicket.New(arg_2_1, arg_2_2, arg_2_3)
	end

	return
end

function IslandTicketAgency:ReduceTicket(arg_3_1, arg_3_2, arg_3_3)
	if not self.data[arg_3_1] then
		return
	end

	local var_3_0 = self.data[arg_3_1][arg_3_2]

	if not self.data[arg_3_1][arg_3_2] then
		return
	end

	if arg_3_3 > var_3_0:GetCount() then
		return
	end

	var_3_0:ReduceCount(arg_3_3)

	if var_3_0:IsEmpty() then
		self:RemoveTicket(arg_3_1, arg_3_2)
	else
		self.data[arg_3_1][arg_3_2] = var_3_0
	end

	return
end

function IslandTicketAgency:RemoveTicket(arg_4_1, arg_4_2)
	self.data[arg_4_1][arg_4_2] = nil

	return
end

function IslandTicketAgency:GetAllTicketList()
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in pairs(self.data) do
		for iter_5_2, iter_5_3 in pairs(iter_5_1) do
			table.insert(var_5_0, iter_5_3)
		end
	end

	return var_5_0
end

function IslandTicketAgency:GetTicketData()
	return self.data
end

function IslandTicketAgency:GetTikcetListById(arg_7_1)
	if not self.data[arg_7_1] then
		return {}
	end

	return underscore.values(self.data[arg_7_1])
end

function IslandTicketAgency:GetExpiredTickets()
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in pairs(self.data) do
		for iter_8_2, iter_8_3 in pairs(iter_8_1) do
			if iter_8_3:IsExpired() then
				table.insert(var_8_0, iter_8_3)
			end
		end
	end

	return var_8_0
end

function IslandTicketAgency:GetExpireRemindTickets()
	local var_9_0 = {}

	if PlayerPrefs.GetInt(self.localTipKey .. "_" .. GetZeroTime()) == 1 then
		return var_9_0
	end

	for iter_9_0, iter_9_1 in pairs(self.data) do
		for iter_9_2, iter_9_3 in pairs(iter_9_1) do
			if iter_9_3:WillExpire() then
				table.insert(var_9_0, iter_9_3)
			end
		end
	end

	return var_9_0
end

function IslandTicketAgency:SetRemindFlag()
	PlayerPrefs.SetInt(self.localTipKey .. "_" .. GetZeroTime(), 1)
	PlayerPrefs.Save()

	return
end

return IslandTicketAgency
