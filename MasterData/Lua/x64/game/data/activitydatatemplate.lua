ActivityTemplate = class("ActivityTemplate")

function ActivityTemplate:Ctor(arg_1_1)
	self.id = arg_1_1.activity_id
	self.startTime = arg_1_1.start_time
	self.stopTime = arg_1_1.stop_time
	self.state = arg_1_1.state or 0
	self.theme = arg_1_1.theme or 0
	self.template = arg_1_1.template or 0
	self.subActivityIdList = {}

	if arg_1_1.sub_activity_id_list then
		for iter_1_0, iter_1_1 in ipairs(arg_1_1.sub_activity_id_list) do
			table.insert(self.subActivityIdList, iter_1_1)
		end
	end
end

function ActivityTemplate:IsActivitying()
	if self.stopTime == 0 then
		return true
	end

	if manager.time:GetServerTime() <= self.stopTime then
		if self.state ~= 1 then
			return false
		end

		return true
	end

	return false
end

function ActivityTemplate:IsOverdue()
	local var_3_0 = manager.time:GetServerTime()

	if self.stopTime == 0 then
		return false
	end

	return var_3_0 > self.stopTime
end

function ActivityTemplate:GetRemainTime()
	return self.stopTime - manager.time:GetServerTime()
end

function ActivityTemplate:GetTimeBeforeStart()
	return self.startTime - manager.time:GetServerTime()
end

function ActivityTemplate:GetStateBool()
	return self.state == 1
end
