local GuildEvent = class("GuildEvent", import("...BaseVO"))

function GuildEvent:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.configId = self.id
	self.active = false
	self.startTime = 0
	self.clueCount = 0
	self.missions = {}
	self.boss = nil
	self.durTime = pg.guildset.operation_duration_time.key_value

	return
end

function GuildEvent:bindConfigTable()
	return pg.guild_operation_template
end

function GuildEvent:GetConsume()
	return self:getConfig("consume")
end

function GuildEvent:Active(arg_4_1)
	self:Deactivate()

	self.startTime = arg_4_1.start_time
	self.endTime = self.durTime + self.startTime
	self.clueCount = arg_4_1.clue_count
	self.joinCnt = arg_4_1.join_times
	self.isParticipant = arg_4_1.is_participant

	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.perfs) do
		var_4_0[iter_4_1.event_id] = iter_4_1.index
	end

	local var_4_1 = {}

	for iter_4_2, iter_4_3 in ipairs(arg_4_1.formation_time) do
		var_4_1[iter_4_3.key] = iter_4_3.value
	end

	local var_4_2 = 0

	local function var_4_3(arg_5_0)
		local var_5_0 = GuildMission.New(arg_5_0)
		local var_5_1 = var_5_0:GetPosition()

		if var_5_1 > var_4_2 then
			var_4_2 = var_5_1
		end

		self.missions[var_5_1] = self.missions[var_5_1] or {}

		if var_4_0[var_5_0.id] then
			var_5_0:UpdateNodeAnimFlagIndex(var_4_0[var_5_0.id])
		end

		if var_4_1[var_5_0.id] then
			var_5_0:UpdateFormationTime(var_4_1[var_5_0.id])
		end

		table.insert(self.missions[var_5_1], var_5_0)

		return
	end

	for iter_4_4, iter_4_5 in ipairs(arg_4_1.base_events) do
		var_4_3(iter_4_5)
	end

	for iter_4_6, iter_4_7 in ipairs(arg_4_1.completed_events) do
		var_4_3(GuildMission.CompleteData2FullData(iter_4_7))
	end

	self.boss = GuildBossMission.New(0 + 1, arg_4_1.daily_count, arg_4_1.fleets)

	if arg_4_1.boss_event and arg_4_1.boss_event.boss_id ~= 0 then
		self.boss:Flush(arg_4_1.boss_event)
	end

	self.active = true

	return
end

function GuildEvent:IsParticipant()
	return self.isParticipant > 0
end

function GuildEvent:GetJoinCnt()
	return self.joinCnt
end

function GuildEvent:IncreaseJoinCnt()
	self.isParticipant = 1

	if self.joinCnt < self:GetMaxJoinCnt() then
		self.joinCnt = self.joinCnt + 1
	else
		getProxy(GuildProxy):getRawData():ReduceExtraBattleCnt(1)
	end

	return
end

function GuildEvent:GetExtraJoinCnt()
	return getProxy(GuildProxy):getRawData():GetExtraBattleCnt()
end

function GuildEvent:IsLimitedJoin()
	return not (self:GetJoinCnt() < self:GetMaxJoinCnt() or self:GetExtraJoinCnt() > 0)
end

function GuildEvent:GetMaxJoinCnt()
	return pg.guildset.efficiency_param_times.key_value
end

function GuildEvent:GetBossMission()
	return self.boss
end

function GuildEvent:GetMissions()
	return self.missions
end

function GuildEvent:Deactivate()
	self.startTime = 0
	self.clueCount = 0
	self.missions = {}
	self.boss = nil
	self.active = false
	self.isParticipant = 0

	return
end

function GuildEvent:IsExpired()
	return pg.TimeMgr.GetInstance():GetServerTime() >= self.endTime
end

function GuildEvent:IsActive()
	return self.active == true
end

function GuildEvent:GetDesc()
	return self:getConfig("profile")
end

function GuildEvent:GetName()
	return self:getConfig("name")
end

function GuildEvent:GetScaleDesc()
	return self:getConfig("scale")
end

function GuildEvent:GetDisplayMission()
	return self:getConfig("event_type_list")
end

function GuildEvent:GetDisplayAward()
	return self:getConfig("award_display")
end

function GuildEvent:IsUnlock(arg_22_1)
	return arg_22_1 >= self:getConfig("unlock_guild_level")
end

function GuildEvent:GetTheme()
	return self:getConfig("theme")
end

function GuildEvent:GetJoinShips()
	local var_24_0 = {}

	for iter_24_0, iter_24_1 in ipairs(self.missions) do
		for iter_24_2, iter_24_3 in ipairs(iter_24_1) do
			if not iter_24_3:IsFinish() then
				for iter_24_4, iter_24_5 in ipairs((iter_24_3:GetMyShips())) do
					table.insert(var_24_0, iter_24_5)
				end
			end
		end
	end

	return var_24_0
end

function GuildEvent:GetMissionById(arg_25_1)
	for iter_25_0, iter_25_1 in pairs(self.missions) do
		for iter_25_2, iter_25_3 in ipairs(iter_25_1) do
			if iter_25_3.id == arg_25_1 then
				return iter_25_3
			end
		end
	end

	assert(false)

	return
end

function GuildEvent:GetJoinShipCnt()
	local var_26_0 = 0

	for iter_26_0, iter_26_1 in pairs(self.missions) do
		for iter_26_2, iter_26_3 in ipairs(iter_26_1) do
			var_26_0 = var_26_0 + iter_26_3:GetJoinCnt()
		end
	end

	return var_26_0
end

function GuildEvent:GetBossShipIds()
	local var_27_0 = {}

	if self.boss and self.boss:IsActive() then
		for iter_27_0, iter_27_1 in ipairs((self.boss:GetMyShipIds())) do
			table.insert(var_27_0, iter_27_1)
		end
	end

	return var_27_0
end

function GuildEvent:GetMissionCnt()
	local var_28_0 = 0

	for iter_28_0, iter_28_1 in pairs(self.missions) do
		for iter_28_2, iter_28_3 in ipairs(iter_28_1) do
			var_28_0 = var_28_0 + 1
		end
	end

	return var_28_0
end

function GuildEvent:GetMainMissionCntAndFinishCnt()
	local var_29_0 = 0
	local var_29_1 = 0

	for iter_29_0, iter_29_1 in pairs(self.missions) do
		for iter_29_2, iter_29_3 in ipairs(iter_29_1) do
			if iter_29_3:IsMain() then
				var_29_0 = var_29_0 + 1
			end

			if iter_29_3:IsMain() and iter_29_3:IsFinish() then
				var_29_1 = var_29_1 + 1
			end
		end
	end

	return var_29_0, var_29_1
end

function GuildEvent:GetMissionFinishCnt()
	local var_30_0 = 0

	for iter_30_0, iter_30_1 in pairs(self.missions) do
		for iter_30_2, iter_30_3 in ipairs(iter_30_1) do
			if iter_30_3:IsFinish() then
				var_30_0 = var_30_0 + 1
			end
		end
	end

	return var_30_0
end

function GuildEvent:GetCanFormationMisstions()
	local function var_31_0(arg_32_0)
		if arg_32_0:IsFinish() then
			return false
		end

		local var_32_0 = self.missions[arg_32_0:GetPosition() - 1]

		if var_32_0 then
			for iter_32_0, iter_32_1 in pairs(var_32_0) do
				if iter_32_1:IsMain() and iter_32_1:IsFinish() then
					return true
				end
			end
		else
			return true
		end

		return false
	end

	local var_31_1 = {}

	for iter_31_0, iter_31_1 in pairs(self.missions) do
		for iter_31_2, iter_31_3 in ipairs(iter_31_1) do
			if var_31_0(iter_31_3) and iter_31_3:CanFormation() and not iter_31_3:IsFinish() then
				table.insert(var_31_1, iter_31_3)
			end
		end
	end

	return var_31_1
end

function GuildEvent:AnyMissionCanFormation()
	return #self:GetCanFormationMisstions() > 0
end

function GuildEvent:AnyMissionFirstFleetCanFroamtion()
	local var_34_0 = _.detect(self:GetCanFormationMisstions(), function(arg_35_0)
		return arg_35_0:FirstFleetCanFormation() or arg_35_0:IsFinish() and not arg_35_0:IsFinishedByServer()
	end)

	return var_34_0 ~= nil, var_34_0
end

function GuildEvent:GetUnlockMission()
	local var_36_0 = 0

	for iter_36_0, iter_36_1 in pairs(self.missions) do
		for iter_36_2, iter_36_3 in ipairs(iter_36_1) do
			if iter_36_3:IsMain() and (iter_36_3:IsFinishedByServer() or iter_36_3:IsFinish()) then
				var_36_0 = iter_36_0
			end
		end
	end

	for iter_36_4, iter_36_5 in ipairs(self.missions[var_36_0 + 1] or {}) do
		if iter_36_5:IsMain() then
			return iter_36_5
		end
	end

	return nil
end

function GuildEvent:GetLeftTime()
	return self.endTime - pg.TimeMgr.GetInstance():GetServerTime()
end

return GuildEvent
