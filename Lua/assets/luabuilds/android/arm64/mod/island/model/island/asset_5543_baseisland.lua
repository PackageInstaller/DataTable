local BaseIsland = class("BaseIsland", import("Mod.Island.IslandDispatcher"))

function BaseIsland:Ctor(arg_1_1)
	BaseIsland.super.Ctor(self)

	self.id = arg_1_1.id
	self.level = arg_1_1.level or 1
	self.configId = self.level
	self.exp = arg_1_1.exp or 0
	self.name = arg_1_1.name or "1"
	self.prosperity = arg_1_1.prosperity or 0
	self.manifesto = arg_1_1.signature or ""
	self.prosperityList = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.prosperity_rewarded or {}) do
		self.prosperityList[iter_1_1] = true
	end

	self.ablityAgency = IslandAblityAgency.New(self, arg_1_1)
	self.characterAgency = IslandCharacterAgency.New(self, arg_1_1)
	self.visitorAgency = IslandVisitorAgency.New(self, arg_1_1)
	self.technologyAgency = IslandTechnologyAgency.New(self, arg_1_1)
	self.signInAgency = IslandSignInAgency.New(self, arg_1_1)
	self.taskAgency = IslandTaskAgency.New(self, arg_1_1)
	self.accessAgency = IslandAccessAgency.New(self, arg_1_1)
	self.gatherCollectAgency = IslandGatherCollectAgency.New(self, arg_1_1)
	self.buildingAgency = IslandBuildingAgency.New(self, arg_1_1)
	self.followerAgency = IslandFollowerAgency.New(self)
	self.activityNpcAgency = IslandActivityNpcAgency.New(self)
	self.tradeAgency = IslandTradegency.New(self, arg_1_1)
	self.agoraAgency = IslandAgoraAgency.New(self, arg_1_1)
	self.manageAgency = IslandManageAgecny.New(self, arg_1_1)
	self.cheaterTavernAgency = IslandCheaterTavernAgency.New(self)
	self.mapID = pg.island_set.initial_scene.key_value_int
	self.lastExitPosition = {
		mapId = 0,
		position = Vector3.zero,
		rotation = Vector3.zero
	}

	if not self.taskAgency:IsFinishTask(IslandGuideChecker.MOVE_TASK_ID) then
		self:SetSpawnPointId(pg.island_set.initial_spawn_point.key_value_int)
	end

	return
end

function BaseIsland:GetTradeAgency()
	return self.tradeAgency
end

function BaseIsland:GetActivityNpcAgency()
	return self.activityNpcAgency
end

function BaseIsland:GetFollowerAgency()
	return self.followerAgency
end

function BaseIsland:GetAccessAgency()
	return self.accessAgency
end

function BaseIsland:IsPrivate()
	return false
end

function BaseIsland:GetVisitorAgency()
	return self.visitorAgency
end

function BaseIsland:GetAgoraAgency()
	return self.agoraAgency
end

function BaseIsland:GetCharacterAgency()
	return self.characterAgency
end

function BaseIsland:GetTechnologyAgency()
	return self.technologyAgency
end

function BaseIsland:GetAblityAgency()
	return self.ablityAgency
end

function BaseIsland:GetSignInAgency()
	return self.signInAgency
end

function BaseIsland:GetTaskAgency()
	return self.taskAgency
end

function BaseIsland:GetCheaterTavernAgency()
	return self.cheaterTavernAgency
end

function BaseIsland:GetManageAgency()
	return self.manageAgency
end

function BaseIsland:GetWildCollectAgency()
	return self.gatherCollectAgency
end

function BaseIsland:GetBuildingAgency()
	return self.buildingAgency
end

function BaseIsland:SetSpawnPointId(arg_18_1)
	self.spawnPointId = arg_18_1

	return
end

function BaseIsland:GetSpawnPointId()
	self.spawnPointId = nil

	return self.spawnPointId
end

function BaseIsland:SetLastExitPosition(arg_20_1, arg_20_2, arg_20_3)
	if arg_20_1 <= 0 then
		return
	end

	self.lastExitPosition = {
		mapId = arg_20_1,
		position = arg_20_2,
		rotation = arg_20_3
	}

	return
end

function BaseIsland:GetLastExitPosition()
	return self.lastExitPosition
end

function BaseIsland:GetMapId()
	return self.mapID
end

function BaseIsland:SetMapId(arg_23_1)
	if not pg.island_map[arg_23_1] then
		return
	end

	if not pg.TimeMgr.GetInstance():inTime(pg.island_map[arg_23_1].time) then
		return
	end

	self.mapID = arg_23_1

	return
end

function BaseIsland:GetUnlockBuildingList()
	if self:IsMaxLevel() then
		return {}
	end

	return pg.island_level[self.level].island_level_award
end

function BaseIsland:IsNew()
	return self.name == ""
end

function BaseIsland:CanModifyName()
	return true
end

function BaseIsland:SetName(arg_27_1)
	self.name = arg_27_1

	return
end

function BaseIsland:GetName()
	if self.name == "" then
		return i18n("island_default_name", getProxy(PlayerProxy):getRawData().name)
	else
		return self.name
	end

	return
end

function BaseIsland:SetManifesto(arg_29_1)
	self.manifesto = arg_29_1

	return
end

function BaseIsland:GetManifesto()
	return self.manifesto
end

function BaseIsland:AddExp(arg_31_1)
	if self:IsMaxLevel() then
		return
	end

	self.exp = self.exp + arg_31_1

	return
end

function BaseIsland:Upgrade()
	if self:IsMaxLevel() then
		return
	end

	if self:CanLevelUp() then
		self.exp = self:IsMaxLevel() and 0 or self.exp - self:GetTargeExp()

		self:LevelUp()
	end

	return
end

function BaseIsland:LevelUp()
	self.level = self.level + 1
	self.configId = self.level

	return
end

function BaseIsland:GetTargeExp()
	assert(pg.island_level[self.level])

	return pg.island_level[self.level].island_exp
end

function BaseIsland:CanLevelUp()
	if self:IsMaxLevel() then
		return false
	end

	return self:GetTargeExp() <= self.exp
end

function BaseIsland:IsMaxLevel()
	return pg.island_level.all[#pg.island_level.all] <= self.level
end

function BaseIsland:StaticIsMaxLevel(arg_37_1)
	return arg_37_1 >= pg.island_level.all[#pg.island_level.all]
end

function BaseIsland:GetLevel()
	return self.level
end

function BaseIsland:GetExp()
	return self.exp
end

function BaseIsland:GetUpgradeAwardsByLevel(arg_40_1)
	if self:StaticIsMaxLevel(arg_40_1) then
		return {}
	end

	local var_40_0 = pg.island_level[arg_40_1]

	assert(pg.island_level[arg_40_1])

	local var_40_1 = {}

	for iter_40_0, iter_40_1 in ipairs(var_40_0.island_level_award) do
		table.insert(var_40_1, {
			DROP_TYPE_ISLAND_ITEM,
			iter_40_1[1],
			iter_40_1[2]
		})
	end

	return var_40_1
end

function BaseIsland:GetUpgradeAwards()
	return (self:GetUpgradeAwardsByLevel(self.level))
end

function BaseIsland:AddProsperity(arg_42_1)
	if not self:CanAddProsperity() then
		return
	end

	self.prosperity = self.prosperity + arg_42_1

	return
end

function BaseIsland:CanAddProsperity()
	return pg.island_prosperity[self:GetMaxProsperityLevel()].prosperity > self.prosperity
end

function BaseIsland:GetProsperity()
	return self.prosperity
end

function BaseIsland:GetMaxProsperityLevel()
	return pg.island_prosperity.all[#pg.island_prosperity.all]
end

function BaseIsland:GetTargetProsperityByLevel(arg_46_1)
	assert(pg.island_prosperity[arg_46_1])

	return pg.island_prosperity[arg_46_1].prosperity
end

function BaseIsland:GetTargetProsperity()
	local var_47_0 = self:GetProsperity()

	for iter_47_0, iter_47_1 in ipairs(pg.island_prosperity.all) do
		local var_47_1 = self:GetTargetProsperityByLevel(iter_47_1)

		if var_47_0 < var_47_1 then
			return var_47_1
		end
	end

	return 0
end

function BaseIsland:GetProsperityLevel()
	local var_48_0 = self:GetProsperity()

	for iter_48_0, iter_48_1 in ipairs(pg.island_prosperity.all) do
		if var_48_0 < self:GetTargetProsperityByLevel(iter_48_1) then
			return iter_48_1
		end
	end

	return self:GetMaxProsperityLevel()
end

function BaseIsland:CanGetProsperityAwards(arg_49_1)
	if self:IsReceiveProsperityAwards(arg_49_1) then
		return false
	end

	local var_49_0 = pg.island_prosperity[arg_49_1]

	if not pg.island_prosperity[arg_49_1] then
		return false
	end

	return var_49_0.prosperity <= self:GetProsperity()
end

function BaseIsland:AnyProsperityAwardCanGet()
	for iter_50_0, iter_50_1 in ipairs(pg.island_prosperity.all) do
		if self:CanGetProsperityAwards(iter_50_1) then
			return true
		end
	end

	return false
end

function BaseIsland:IsReceiveProsperityAwards(arg_51_1)
	return self.prosperityList[arg_51_1] == true
end

function BaseIsland:ReceiveProsperityAwards(arg_52_1)
	self.prosperityList[arg_52_1] = true

	return
end

function BaseIsland:GetProsperityAward(arg_53_1)
	return pg.island_prosperity[arg_53_1].award_display
end

function BaseIsland:getConfig(arg_54_1)
	return pg.island_level[self.configId][arg_54_1]
end

function BaseIsland:UpdatePerDay()
	self:GetSignInAgency():ResetSignInCnt()
	self:GetAccessAgency():ResetFreshInviteCodeFlag()
	self:GetCharacterAgency():ResetShipSkillUsed()

	return
end

function BaseIsland:UpdatePerSecond()
	if self.buildingAgency then
		self.buildingAgency:UpdatePerSecond()
	end

	return
end

function BaseIsland:UpdatePerHour(arg_57_1)
	self:GetTradeAgency():UpdatePerHour(arg_57_1)

	return
end

return BaseIsland
