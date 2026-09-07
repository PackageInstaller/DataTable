local SingleEventActivity = class("SingleEventActivity", import("model.vo.Activity"))

function SingleEventActivity:Ctor(arg_1_1)
	SingleEventActivity.super.Ctor(self, arg_1_1)

	self.eventData = {}

	for iter_1_0, iter_1_1 in ipairs(self:GetAllEventIds()) do
		local var_1_0 = SingleEvent.New({
			id = iter_1_1
		})

		if var_1_0:IsMain() then
			self.eventData[iter_1_1] = var_1_0
		end
	end

	for iter_1_2, iter_1_3 in ipairs(self:GetDailyEventIds()) do
		local var_1_1 = SingleEvent.New({
			id = iter_1_3
		})

		if var_1_1:IsDaily() then
			self.eventData[iter_1_3] = var_1_1
		end
	end

	return
end

function SingleEventActivity:GetEventById(arg_2_1)
	return self.eventData[arg_2_1]
end

function SingleEventActivity:GetAllEventIds()
	return self:getConfig("config_data")
end

function SingleEventActivity:GetFinishMainIds()
	return self.data1_list
end

function SingleEventActivity:AddFinishMainId(arg_5_1)
	if not table.contains(self:GetFinishMainIds(), arg_5_1) then
		table.insert(self:GetFinishMainIds(), arg_5_1)
	end

	return
end

function SingleEventActivity:IsFinish(arg_6_1)
	local var_6_0 = self:GetEventById(arg_6_1)

	if var_6_0:IsMain() then
		return table.contains(self:GetFinishMainIds(), arg_6_1)
	end

	if var_6_0:IsDaily() then
		return table.contains(self:GetDailyEventIds(), arg_6_1) and not table.contains(self:GetUnFinishDailyIds(), arg_6_1)
	end

	return false
end

function SingleEventActivity:IsFinishAllMain()
	for iter_7_0, iter_7_1 in pairs(self.eventData) do
		if iter_7_1:IsMain() and not self:IsFinish(iter_7_1.id) then
			return false
		end
	end

	return true
end

function SingleEventActivity:CheckDailyEventRequest()
	return #self:GetDailyEventIds() == 0
end

function SingleEventActivity:SetDailyEventIds(arg_9_1)
	for iter_9_0, iter_9_1 in pairs(self.eventData) do
		if iter_9_1:IsDaily() then
			self.eventData[iter_9_0] = nil
		end
	end

	self.data2_list = {}
	self.data3_list = {}

	for iter_9_2, iter_9_3 in ipairs(arg_9_1) do
		table.insert(self.data2_list, iter_9_3)
		table.insert(self.data3_list, iter_9_3)

		local var_9_0 = SingleEvent.New({
			id = iter_9_3
		})

		if var_9_0:IsDaily() then
			self.eventData[iter_9_3] = var_9_0
		end
	end

	return
end

function SingleEventActivity:GetDailyEventIds()
	return self.data2_list
end

function SingleEventActivity:GetUnFinishDailyIds()
	return self.data3_list
end

function SingleEventActivity:RemoveFinishDailyId(arg_12_1)
	if table.contains(self:GetUnFinishDailyIds(), arg_12_1) then
		table.removebyvalue(self:GetUnFinishDailyIds(), arg_12_1)
	end

	return
end

function SingleEventActivity:CheckTrigger(arg_13_1)
	if not self.eventData[arg_13_1] then
		return false
	end

	if self:IsFinish(arg_13_1) then
		return false
	end

	local var_13_0 = self.eventData[arg_13_1]:GetPreEventId()

	return var_13_0 == 0 or self:IsFinish(var_13_0)
end

function SingleEventActivity:AddFinishEvent(arg_14_1)
	local var_14_0 = self:GetEventById(arg_14_1)

	if var_14_0:IsMain() then
		self:AddFinishMainId(arg_14_1)
	end

	if var_14_0:IsDaily() then
		self:RemoveFinishDailyId(arg_14_1)
	end

	return
end

function SingleEventActivity:GetUnlockMapAreas()
	local var_15_0 = {}

	underscore.each(self:GetFinishMainIds(), function(arg_16_0)
		if pg.activity_single_event[arg_16_0].map_options == "" then
			return
		end

		local var_16_0 = tonumber(pg.activity_single_event[arg_16_0].map_options)

		if not table.contains(var_15_0, var_16_0) then
			table.insert(var_15_0, var_16_0)
		end

		return
	end)

	return var_15_0
end

function SingleEventActivity:GetLastShowConfig()
	local var_17_0 = self:GetFinishMainIds()

	if #var_17_0 == 0 then
		return {}
	end

	table.sort(var_17_0)

	for iter_17_0 = #var_17_0 - 1, 1, -1 do
		if #pg.activity_single_event[var_17_0[iter_17_0]].options > 0 then
			return pg.activity_single_event[var_17_0[iter_17_0]].options
		end
	end

	return pg.activity_single_event[var_17_0[1]].options
end

function SingleEventActivity:GetShowConfig()
	local var_18_0 = self:GetFinishMainIds()

	if #var_18_0 == 0 then
		return {}
	end

	table.sort(var_18_0)

	for iter_18_0 = #var_18_0, 1, -1 do
		if #pg.activity_single_event[var_18_0[iter_18_0]].options > 0 then
			return pg.activity_single_event[var_18_0[iter_18_0]].options
		end
	end

	return pg.activity_single_event[var_18_0[1]].options
end

function SingleEventActivity:IsShowMapAnim(arg_19_1)
	if not self:GetEventById(arg_19_1):IsMain() then
		return false
	end

	local var_19_0 = self:GetFinishMainIds()
	local var_19_1 = self:GetUnlockMapAreas()
	local var_19_2 = {}
	local var_19_3 = {}

	for iter_19_0 = 1, #var_19_0 - 1 do
		table.insert(var_19_2, var_19_0[iter_19_0])
	end

	underscore.each(var_19_2, function(arg_20_0)
		if pg.activity_single_event[arg_20_0].map_options == "" then
			return
		end

		local var_20_0 = tonumber(pg.activity_single_event[arg_20_0].map_options)

		if not table.contains(var_19_3, var_20_0) then
			table.insert(var_19_3, var_20_0)
		end

		return
	end)

	return #var_19_1 ~= #var_19_3
end

return SingleEventActivity
