local GuildBossMission = class("GuildBossMission", import("...BaseVO"))

GuildBossMission.MAIN_FLEET_ID = 1
GuildBossMission.SUB_FLEET_ID = 11

function GuildBossMission:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.position = arg_1_1
	self.dailyCount = arg_1_2 or 0
	self.fleets = {
		[GuildBossMission.MAIN_FLEET_ID] = GuildBossMissionFleet.New({
			fleet_id = GuildBossMission.MAIN_FLEET_ID
		}),
		[GuildBossMission.SUB_FLEET_ID] = GuildBossMissionFleet.New({
			fleet_id = GuildBossMission.SUB_FLEET_ID
		})
	}

	for iter_1_0, iter_1_1 in ipairs(arg_1_3) do
		if self.fleets[iter_1_1.fleet_id] then
			self.fleets[iter_1_1.fleet_id]:Flush(iter_1_1)
		end
	end

	self.active = false
	self.rankUpdateTime = 0

	return
end

function GuildBossMission:Flush(arg_2_1)
	self.id = arg_2_1.boss_id
	self.configId = self.id
	self.damage = arg_2_1.damage or 0
	self.totalHp = arg_2_1.hp or 1
	self.active = true

	return
end

function GuildBossMission:GetPosition()
	return self.position
end

function GuildBossMission:bindConfigTable()
	return pg.guild_boss_event
end

function GuildBossMission:GetIcon()
	return self:getConfig("pic") or self.configId
end

function GuildBossMission:GetFleetByIndex(arg_6_1)
	return self.fleets[arg_6_1]
end

function GuildBossMission:GetMainFleet()
	return self.fleets[GuildBossMission.MAIN_FLEET_ID]
end

function GuildBossMission:GetSubFleet()
	return self.fleets[GuildBossMission.SUB_FLEET_ID]
end

function GuildBossMission:UpdateFleet(arg_9_1)
	self.fleets[arg_9_1.id] = arg_9_1

	return
end

function GuildBossMission:GetFleets()
	return self.fleets
end

function GuildBossMission:GetAllShipIds()
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in pairs(self.fleets) do
		for iter_11_2, iter_11_3 in ipairs((iter_11_1:GetShips())) do
			table.insert(var_11_0, (GuildAssaultFleet.GetRealId(iter_11_3.ship.id)))
		end
	end

	return var_11_0
end

function GuildBossMission:GetMyShipIds()
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in pairs(self.fleets) do
		for iter_12_2, iter_12_3 in ipairs((iter_12_1:GetMyShipIds())) do
			table.insert(var_12_0, iter_12_3)
		end
	end

	return var_12_0
end

function GuildBossMission:GetShipsSplitByUserID()
	local var_13_0 = {}
	local var_13_1 = getProxy(PlayerProxy):getRawData().id

	for iter_13_0, iter_13_1 in pairs(self.fleets) do
		for iter_13_2, iter_13_3 in ipairs((iter_13_1:GetShips())) do
			if iter_13_3.member.id ~= var_13_1 then
				table.insert(var_13_0, {
					shipID = GuildAssaultFleet.GetRealId(iter_13_3.ship.id),
					userID = iter_13_3.member.id
				})
			end
		end
	end

	return var_13_0
end

function GuildBossMission:GetTotalHp()
	return self.totalHp
end

function GuildBossMission:GetHp()
	return self:GetTotalHp() - self.damage
end

function GuildBossMission:IsDeath()
	return self.damage >= self:GetTotalHp()
end

function GuildBossMission:GetStageID()
	return self:getConfig("expedition_id")[1]
end

function GuildBossMission:IsMain()
	return true
end

function GuildBossMission:IsFinish()
	return false
end

function GuildBossMission:GetName()
	return self:getConfig("name")
end

function GuildBossMission:GetSubType()
	return 1
end

function GuildBossMission:IsActive()
	return self.active
end

function GuildBossMission:IsBoss()
	return true
end

function GuildBossMission:GetTag()
	return 3
end

function GuildBossMission:GetCanUsageCnt()
	return GuildConst.MISSION_BOSS_MAX_CNT() - self.dailyCount
end

function GuildBossMission:ReduceDailyCnt()
	self.dailyCount = self.dailyCount + 1

	return
end

function GuildBossMission:ResetDailyCnt()
	self.dailyCount = 0

	return
end

function GuildBossMission:GetAwards()
	return self:getConfig("award")
end

function GuildBossMission:CanEnterBattle()
	return not self:IsReachDailyCnt() and not self:IsDeath()
end

function GuildBossMission:IsReachDailyCnt()
	return self.dailyCount >= GuildConst.MISSION_BOSS_MAX_CNT()
end

function GuildBossMission:GetPainting()
	return self:getConfig("painting")
end

function GuildBossMission:GetPrefab()
	local var_32_0 = pg.enemy_data_statistics[self:getConfig("expedition_id")[2][1]]

	assert(var_32_0)

	return var_32_0.prefab
end

function GuildBossMission:GetEmenyId()
	return self:getConfig("expedition_id")[2][1]
end

function GuildBossMission:CanFormation()
	return false
end

function GuildBossMission:ExistCommander(arg_35_1)
	for iter_35_0, iter_35_1 in pairs(self.fleets) do
		if iter_35_1:ExistCommander(arg_35_1) then
			return true
		end
	end

	return false
end

function GuildBossMission:GetFleetUserId(arg_36_1, arg_36_2)
	for iter_36_0, iter_36_1 in pairs(self.fleets) do
		if iter_36_1:ContainShip(arg_36_1, arg_36_2) then
			return iter_36_1
		end
	end

	return false
end

function GuildBossMission:GetFleetCommanderId(arg_37_1)
	for iter_37_0, iter_37_1 in pairs(self.fleets) do
		if iter_37_1:ExistCommander(arg_37_1) then
			return iter_37_1
		end
	end

	return false
end

return GuildBossMission
