local LinerActivity = class("LinerActivity", import("model.vo.Activity"))

function LinerActivity:Ctor(arg_1_1)
	LinerActivity.super.Ctor(self, arg_1_1)

	self.curFinishEvents = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.date1_key_value_list or {}) do
		self.curFinishEvents[iter_1_1.key] = self.curFinishEvents[iter_1_1.key] or {}

		table.insert(self.curFinishEvents[iter_1_1.key], iter_1_1.value)
	end

	self.timeGroupIds = self:getConfig("config_data")[1]
	self.roomGroupIds = self:getConfig("config_data")[2]
	self.eventGroupIds = self:getConfig("config_data")[3]
	self.times = {}
	self.timeMaxIdx = 1
	self.timeIdx2Day = {}

	for iter_1_2, iter_1_3 in ipairs(self.timeGroupIds) do
		for iter_1_4, iter_1_5 in ipairs(pg.activity_liner_time_group[iter_1_3].ids) do
			self.timeMaxIdx = 1
			self.times[1] = LinerTime.New(iter_1_5)
			self.timeIdx2Day[1] = iter_1_2
		end
	end

	if self.data2 == 0 then
		self.data2 = 1
	end

	return
end

function LinerActivity:GetTimeGroupIds()
	return self.timeGroupIds
end

function LinerActivity:GetRoomGroupIds()
	return self.roomGroupIds
end

function LinerActivity:GetEventGroupIds()
	return self.eventGroupIds
end

function LinerActivity:UpdateRoomIdx(arg_5_1)
	self.data2 = arg_5_1 and 1 or self.data2 + 1

	return
end

function LinerActivity:GetRoomIdx()
	return self.data2
end

function LinerActivity:UpdateTimeIdx()
	self.data1 = self.data1 + 1

	self:ClearCurEventInfo()

	return
end

function LinerActivity:GetCurIdx()
	return math.min(self.data1, self.timeMaxIdx)
end

function LinerActivity:GetTimeMaxIdx()
	return self.timeMaxIdx
end

function LinerActivity:IsFinishAllTime()
	return self.data1 > self.timeMaxIdx
end

function LinerActivity:GetFinishTimeIds()
	local var_11_0 = {}
	local var_11_1 = self:GetCurIdx()

	for iter_11_0 = 1, self.data1 - 1 do
		table.insert(var_11_0, self.times[iter_11_0].id)
	end

	return var_11_0
end

function LinerActivity:GetDayByIdx(arg_12_1)
	return self.timeIdx2Day[arg_12_1]
end

function LinerActivity:GetTimeByIdx(arg_13_1)
	return self.times[arg_13_1]
end

function LinerActivity:GetCurTime()
	return self.times[self:GetCurIdx()]
end

function LinerActivity:CheckTimeFinish(arg_15_1)
	local var_15_0 = arg_15_1 or self:GetCurTime()

	return switch(var_15_0:GetType(), {
		[LinerTime.TYPE.TARGET] = function()
			return pg.NewStoryMgr.GetInstance():IsPlayed(var_15_0:GetStory())
		end,
		[LinerTime.TYPE.EXPLORE] = function()
			return self:GetRemainExploreCnt() == 0
		end,
		[LinerTime.TYPE.EVENT] = function()
			if self:GetRoomIdx() ~= #var_15_0:GetParamInfo() then
				return false
			else
				return self:CheckRoomFinish(arg_15_1)
			end

			return
		end,
		[LinerTime.TYPE.STORY] = function()
			return pg.NewStoryMgr.GetInstance():IsPlayed(var_15_0:GetStory())
		end
	}, function()
		return false
	end)
end

function LinerActivity:CheckRoomFinish(arg_21_1)
	local var_21_0 = arg_21_1 or self:GetCurTime()

	if var_21_0:GetType() ~= LinerTime.TYPE.EVENT then
		return false
	end

	local var_21_1 = var_21_0:GetParamInfo()[self:GetRoomIdx()]

	if var_21_1[2] == LinerTime.EVENT_SUB_TYPE.CLUE then
		local var_21_2 = self:GetCurEventInfo()

		return underscore.all(var_21_1[4], function(arg_22_0)
			if not var_21_2[var_21_1[1]] then
				return false
			end

			return table.contains(var_21_2[var_21_1[1]], arg_22_0)
		end)
	elseif var_21_1[2] == LinerTime.EVENT_SUB_TYPE.STORY then
		return pg.NewStoryMgr.GetInstance():IsPlayed(var_21_1[3])
	end

	return false
end

function LinerActivity:GetRemainExploreCnt()
	local var_23_0 = 0

	for iter_23_0 = 1, self:GetCurIdx() do
		var_23_0 = var_23_0 + self.times[iter_23_0]:GetExploreCnt()
	end

	return var_23_0 - #self:GetExploredRoomIds()
end

function LinerActivity:GetTimeId2ExploredIds()
	local var_24_0 = {}
	local var_24_1 = self:GetExploredRoomIds()

	for iter_24_0 = 1, self:GetCurIdx() do
		if self.times[iter_24_0]:GetType() == LinerTime.TYPE.EXPLORE then
			var_24_0[self.times[iter_24_0].id] = {}

			for iter_24_1 = 1, math.min(1 + self.times[iter_24_0]:GetExploreCnt() - 1, #var_24_1) do
				table.insert(var_24_0[self.times[iter_24_0].id], var_24_1[iter_24_1])
			end
		end
	end

	return var_24_0
end

function LinerActivity:GetExploredRoomIds()
	return self.data4_list
end

function LinerActivity:AddExploredRoom(arg_26_1)
	table.insert(self:GetExploredRoomIds(), arg_26_1)

	return
end

function LinerActivity:GetCurEventInfo()
	return self.curFinishEvents
end

function LinerActivity:ClearCurEventInfo()
	self.curFinishEvents = {}

	return
end

function LinerActivity:AddEvent(arg_29_1, arg_29_2)
	self.curFinishEvents[arg_29_1] = self.curFinishEvents[arg_29_1] or {}

	table.insert(self.curFinishEvents[arg_29_1], arg_29_2)

	return
end

function LinerActivity:GetFinishEventIds()
	local var_30_0 = {}

	for iter_30_0 = 1, self:GetCurIdx() - 1 do
		var_30_0 = table.mergeArray(var_30_0, self.times[iter_30_0]:GetEventIds(), true)
	end

	for iter_30_1, iter_30_2 in pairs(self:GetCurEventInfo()) do
		var_30_0 = table.mergeArray(var_30_0, iter_30_2, true)
	end

	return var_30_0
end

function LinerActivity:AddTimeAwardFlag(arg_31_1)
	self.data1_list[arg_31_1] = 1

	return
end

function LinerActivity:IsGotTimeAward(arg_32_1)
	return self.data1_list[arg_32_1] and self.data1_list[arg_32_1] ~= 0
end

function LinerActivity:AddRoomAwardFlag(arg_33_1)
	self.data2_list[arg_33_1] = 1

	return
end

function LinerActivity:IsGotRoomAward(arg_34_1)
	return self.data2_list[arg_34_1] and self.data2_list[arg_34_1] ~= 0
end

function LinerActivity:AddEventAwardFlag(arg_35_1, arg_35_2)
	self.data3_list[arg_35_1] = arg_35_2

	return
end

function LinerActivity:IsGotEventAward(arg_36_1)
	return self.data3_list[arg_36_1] and self.data3_list[arg_36_1] ~= 0
end

function LinerActivity:GetEventAwardFlag(arg_37_1)
	return self.data3_list[arg_37_1]
end

function LinerActivity:GetAllExploreRoomIds()
	local var_38_0 = {}

	for iter_38_0, iter_38_1 in ipairs(self.roomGroupIds) do
		var_38_0 = table.mergeArray(var_38_0, pg.activity_liner_room_group[iter_38_1].ids, true)
	end

	return var_38_0
end

function LinerActivity:GetBgmName()
	local var_39_0 = self:IsFinishAllTime()

	var_39_0 = var_39_0 and pg.NewStoryMgr.GetInstance():IsPlayed(self:getConfig("config_client").endingstory[1])

	if var_39_0 then
		return self:GetCurTime():GetBgm((self:GetReallyTimeType(os.date("*t", os.time()).hour)))
	else
		return self:GetCurTime():GetBgm()
	end

	return
end

function LinerActivity:GetReallyTimeType(arg_40_1)
	for iter_40_0, iter_40_1 in ipairs(self:getConfig("config_client").endingtime) do
		if arg_40_1 >= iter_40_1[1][1] and arg_40_1 < iter_40_1[1][2] then
			return iter_40_1[2]
		end
	end

	return LinerTime.BG_TYPE.DAY
end

return LinerActivity
