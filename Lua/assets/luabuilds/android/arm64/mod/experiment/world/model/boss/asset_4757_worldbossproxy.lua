local WorldBossProxy = class("WorldBossProxy", import("....BaseEntity"))
local var_0_1 = "WorldbossFleet"
local var_0_2 = "WorldbossFleet_for_archives"

WorldBossProxy.Fields = {
	ranks = "table",
	isSetup = "boolean",
	boss = "table",
	summonPtDailyAcc = "number",
	refreshBossesTime = "number",
	ptTime = "number",
	summonPtOldDailyAcc = "number",
	summonFree = "number",
	otherBosses = "table",
	summonPt = "number",
	highestDamage = "number",
	guildSupport = "number",
	archivesId = "number",
	fleet = "table",
	currentBossLV = "number",
	summonPtOld = "number",
	cacheLock = "number",
	tipProgress = "boolean",
	isFetched = "boolean",
	fleetForArchives = "table",
	autoFightFinishTime = "number",
	cacheBosses = "table",
	worldSupport = "number",
	friendSupport = "number",
	pt = "number",
	timers = "table"
}
WorldBossProxy.REFRESH_BOSSES_TIME = 300
WorldBossProxy.EventProcessBossListUpdated = "WorldBossProxy.EventProcessBossListUpdated"
WorldBossProxy.EventCacheBossListUpdated = "WorldBossProxy.EventCacheBossListUpdated"
WorldBossProxy.EventBossUpdated = "WorldBossProxy.EventBossUpdated"
WorldBossProxy.EventFleetUpdated = "WorldBossProxy.EventFleetUpdated"
WorldBossProxy.EventPtUpdated = "WorldBossProxy.EventPtUpdated"
WorldBossProxy.EventRankListUpdated = "WorldBossProxy.EventRankListUpdated"
WorldBossProxy.EventUnlockProgressUpdated = "WorldBossProxy.EventUnlockProgressUpdated"

function WorldBossProxy:Setup(arg_1_1)
	self.pt = self:GetMaxPt() - (arg_1_1.fight_count or 0)

	if arg_1_1.self_boss then
		local var_1_1 = WorldBoss.New()

		var_1_1:Setup(arg_1_1.self_boss, (getProxy(PlayerProxy):getData()))

		if var_1_1:Active() then
			self.boss = var_1_1
		end
	end

	self.summonPt = arg_1_1.summon_pt or 0
	self.summonPtOld = arg_1_1.summon_pt_old or 0
	self.summonPtDailyAcc = arg_1_1.summon_pt_daily_acc or 0
	self.summonPtOldDailyAcc = arg_1_1.summon_pt_old_daily_acc or 0
	self.autoFightFinishTime = arg_1_1.auto_fight_finish_time or 0
	self.summonFree = arg_1_1.summon_free or 0
	self.archivesId = arg_1_1.default_boss_id or 0
	self.highestDamage = arg_1_1.auto_fight_max_damage or 0
	self.guildSupport = arg_1_1.guild_support or 0
	self.friendSupport = arg_1_1.friend_support or 0
	self.worldSupport = arg_1_1.world_support or 0
	self.currentBossLV = arg_1_1.self_boss_lv or 1
	self.cacheBosses = {}
	self.ranks = {}
	self.timers = {}
	self.fleet = nil
	self.fleetForArchives = nil

	self:GenFleet()

	self.refreshBossesTime = 0
	self.isSetup = true
	self.isFetched = false

	return
end

function WorldBossProxy:CheckRemouldShip()
	if self.fleet and self.fleetForArchives then
		self:GenFleet()
	end

	return
end

function WorldBossProxy:FriendSupported()
	return self.friendSupport > pg.TimeMgr.GetInstance():GetServerTime()
end

function WorldBossProxy:UpdateFriendSupported()
	self.friendSupport = pg.TimeMgr.GetInstance():GetServerTime() + pg.gameset.joint_boss_world_time.key_value

	return
end

function WorldBossProxy:ClearFriendSupported()
	self.friendSupport = 0

	return
end

function WorldBossProxy:GetNextFriendSupportTime()
	return self.friendSupport
end

function WorldBossProxy:GuildSupported()
	return self.guildSupport > pg.TimeMgr.GetInstance():GetServerTime()
end

function WorldBossProxy:UpdateGuildSupported()
	self.guildSupport = pg.TimeMgr.GetInstance():GetServerTime() + pg.gameset.joint_boss_world_time.key_value

	return
end

function WorldBossProxy:ClearGuildSupported()
	self.guildSupport = 0

	return
end

function WorldBossProxy:GetNextGuildSupportTime()
	return self.guildSupport
end

function WorldBossProxy:WorldSupported()
	return self.worldSupport > pg.TimeMgr.GetInstance():GetServerTime()
end

function WorldBossProxy:UpdateWorldSupported()
	self.worldSupport = pg.TimeMgr.GetInstance():GetServerTime() + pg.gameset.joint_boss_world_time.key_value

	return
end

function WorldBossProxy:ClearWorldSupported()
	self.worldSupport = 0

	return
end

function WorldBossProxy:GetNextWorldSupportTime()
	return self.worldSupport
end

function WorldBossProxy:UpdateAutoBattleFinishTime(arg_15_1)
	self.autoFightFinishTime = arg_15_1

	return
end

function WorldBossProxy:InAutoBattle()
	return self.autoFightFinishTime > 0
end

function WorldBossProxy:ClearAutoBattle()
	self.autoFightFinishTime = 0

	return
end

function WorldBossProxy:GetAutoBattleFinishTime()
	return self.autoFightFinishTime
end

function WorldBossProxy:GetHighestDamage()
	return self.highestDamage
end

function WorldBossProxy:UpdateHighestDamage(arg_20_1)
	if arg_20_1 > self.highestDamage then
		self.highestDamage = arg_20_1
	end

	return
end

function WorldBossProxy:ClearHighestDamage()
	self.highestDamage = 0

	return
end

function WorldBossProxy:AddSummonFree(arg_22_1)
	self.summonFree = self.summonFree + arg_22_1

	return
end

function WorldBossProxy:GetSummonPt()
	return self.summonPt
end

function WorldBossProxy:AddSummonPt(arg_24_1)
	local var_24_0, var_24_1, var_24_2 = WorldBossConst.GetCurrBossConsume()

	if var_24_1 < self.summonPtDailyAcc + arg_24_1 then
		arg_24_1 = var_24_1 - self.summonPtDailyAcc
	end

	if arg_24_1 <= 0 then
		return
	end

	local var_24_3 = self.summonPt

	self.summonPt = math.min(self.summonPt + arg_24_1, var_24_2)
	self.summonPtDailyAcc = math.min(self.summonPtDailyAcc + math.min(var_24_2 - var_24_3, arg_24_1), var_24_1)

	self:UpdatedUnlockProgress(var_24_3, self.summonPt)

	return
end

function WorldBossProxy:ConsumeSummonPt(arg_25_1)
	self.summonPt = self.summonPt - arg_25_1

	self:DispatchEvent(WorldBossProxy.EventUnlockProgressUpdated)

	return
end

function WorldBossProxy:GetSummonPtDailyAcc()
	return self.summonPtDailyAcc
end

function WorldBossProxy:ClearSummonPtDailyAcc()
	self.summonPtDailyAcc = 0

	self:DispatchEvent(WorldBossProxy.EventUnlockProgressUpdated)

	return
end

function WorldBossProxy:GetSummonPtOld()
	return self.summonPtOld
end

function WorldBossProxy:AddSummonPtOld(arg_29_1)
	local var_29_0, var_29_1, var_29_2 = WorldBossConst.GetAchieveBossConsume()

	if var_29_1 < self.summonPtOldDailyAcc + arg_29_1 then
		arg_29_1 = var_29_1 - self.summonPtOldDailyAcc
	end

	if arg_29_1 <= 0 then
		return
	end

	local var_29_3 = self.summonPtOld

	self.summonPtOld = math.min(self.summonPtOld + arg_29_1, var_29_2)
	self.summonPtOldDailyAcc = math.min(self.summonPtOldDailyAcc + math.min(var_29_2 - var_29_3, arg_29_1), var_29_1)

	return
end

function WorldBossProxy:ConsumeSummonPtOld(arg_30_1)
	self.summonPtOld = self.summonPtOld - arg_30_1

	self:DispatchEvent(WorldBossProxy.EventUnlockProgressUpdated)

	return
end

function WorldBossProxy:ClearSummonPtOldAcc()
	self.summonPtOldDailyAcc = 0

	self:DispatchEvent(WorldBossProxy.EventUnlockProgressUpdated)

	return
end

function WorldBossProxy:GetSummonPtOldAcc()
	return self.summonPtOldDailyAcc
end

function WorldBossProxy:GetArchivesId()
	return self.archivesId
end

function WorldBossProxy:SetArchivesId(arg_34_1)
	self.archivesId = arg_34_1

	return
end

function WorldBossProxy:BossId2FleetKey(arg_35_1)
	local var_35_0 = self:GetBossById(arg_35_1)

	if var_35_0 and not WorldBossConst._IsCurrBoss(var_35_0) then
		return var_0_2
	else
		return var_0_1
	end

	return
end

function WorldBossProxy:GenFleet()
	self.fleet = TypedFleet.New({
		id = 1,
		name = i18n("world_boss_fleet"),
		ship_list = self:GetCacheShips(var_0_1),
		fleetType = FleetType.Normal
	})
	self.fleetForArchives = TypedFleet.New({
		id = 1,
		name = i18n("world_boss_fleet"),
		ship_list = self:GetCacheShips(var_0_2),
		fleetType = FleetType.Normal
	})

	return
end

function WorldBossProxy:GetCacheShips(arg_37_1)
	local function var_37_0(arg_38_0, arg_38_1)
		if TeamType.GetTeamShipMax((arg_38_0:getTeamType())) < arg_38_1 + 1 then
			return true
		end

		return false
	end

	local var_37_1 = string.split(PlayerPrefs.GetString(arg_37_1 .. getProxy(PlayerProxy):getRawData().id), "|")
	local var_37_2 = {}
	local var_37_3 = {
		[TeamType.Vanguard] = 0,
		[TeamType.Main] = 0,
		[TeamType.Submarine] = 0
	}

	if var_37_1 and #var_37_1 > 0 and (#var_37_1 ~= 1 or var_37_1[1] ~= "") then
		for iter_37_0, iter_37_1 in ipairs(var_37_1) do
			local var_37_4 = tonumber(iter_37_1)
			local var_37_5 = getProxy(BayProxy):getShipById(var_37_4)

			if var_37_5 then
				local var_37_6 = var_37_5:getTeamType()

				if not var_37_0(var_37_5, var_37_3[var_37_6]) then
					var_37_3[var_37_6] = var_37_3[var_37_6] + 1

					table.insert(var_37_2, var_37_4)
				end
			end
		end
	end

	return var_37_2
end

function WorldBossProxy:GetFleet(arg_39_1)
	local var_39_0 = var_0_2 == self:BossId2FleetKey(arg_39_1) and self.fleetForArchives or self.fleet

	var_39_0 = var_39_0 or Fleet.New({
		id = 1,
		name = i18n("world_boss_fleet"),
		ship_list = {},
		fleetType = FleetType.Normal
	})

	for iter_39_0 = #var_39_0.ships, 1, -1 do
		if not getProxy(BayProxy):getShipById(var_39_0.ships[iter_39_0]) then
			var_39_0:removeShipById(var_39_0.ships[iter_39_0])
		end
	end

	return var_39_0
end

function WorldBossProxy:UpdateFleet(arg_40_1, arg_40_2)
	if var_0_2 == self:BossId2FleetKey(arg_40_1) then
		self.fleetForArchives = arg_40_2
	else
		self.fleet = arg_40_2
	end

	self:DispatchEvent(WorldBossProxy.EventFleetUpdated)

	return
end

function WorldBossProxy:SavaCacheShips(arg_41_1, arg_41_2)
	local var_41_0 = ""

	for iter_41_0, iter_41_1 in ipairs((arg_41_2:getShipIds())) do
		var_41_0 = var_41_0 .. iter_41_1 .. "|"
	end

	PlayerPrefs.SetString(self:BossId2FleetKey(arg_41_1) .. getProxy(PlayerProxy):getRawData().id, var_41_0)
	PlayerPrefs.Save()

	return
end

function WorldBossProxy:ClearCacheShips(arg_42_1)
	PlayerPrefs.DeleteKey(self:BossId2FleetKey(arg_42_1) .. getProxy(PlayerProxy):getRawData().id)
	PlayerPrefs.Save()

	return
end

function WorldBossProxy:UpdteRefreshBossesTime()
	self.refreshBossesTime = pg.TimeMgr.GetInstance():GetServerTime() + WorldBossProxy.REFRESH_BOSSES_TIME

	return
end

function WorldBossProxy:ShouldRefreshBosses()
	return pg.TimeMgr.GetInstance():GetServerTime() >= self.refreshBossesTime
end

function WorldBossProxy:UpdateCacheBoss(arg_45_1)
	if self:IsSelfBoss(arg_45_1) then
		self:UpdateSelfBoss(arg_45_1)
	else
		self.cacheBosses[arg_45_1.id] = arg_45_1

		self:BalanceMaxBossCnt()
	end

	return
end

function WorldBossProxy:BalanceMaxBossCnt()
	if table.getCount(self.cacheBosses) < pg.gameset.boss_cnt_limit.description[1] then
		return
	end

	local var_46_0 = {}
	local var_46_1 = {}
	local var_46_2 = {}
	local var_46_3 = {}

	for iter_46_0, iter_46_1 in pairs(self.cacheBosses) do
		local var_46_4 = iter_46_1:GetType()

		if iter_46_1:isDeath() or iter_46_1:IsExpired() then
			table.insert(var_46_3, iter_46_1)
		elseif var_46_4 == WorldBoss.BOSS_TYPE_FRIEND then
			table.insert(var_46_2, iter_46_1)
		elseif var_46_4 == WorldBoss.BOSS_TYPE_GUILD then
			table.insert(var_46_1, iter_46_1)
		elseif var_46_4 == WorldBoss.BOSS_TYPE_WORLD then
			table.insert(var_46_0, iter_46_1)
		end
	end

	if #var_46_0 > pg.gameset.boss_cnt_limit.description[2] then
		table.sort(var_46_0, function(arg_47_0, arg_47_1)
			return arg_47_0:GetJoinTime() < arg_47_1:GetJoinTime()
		end)

		if var_46_0[1] then
			table.insert(var_46_3, var_46_0[1])
		end
	end

	if #var_46_1 > pg.gameset.boss_cnt_limit.description[3] then
		table.sort(var_46_1, function(arg_48_0, arg_48_1)
			return arg_48_0:GetJoinTime() < arg_48_1:GetJoinTime()
		end)

		if var_46_1[1] then
			table.insert(var_46_3, var_46_1[1])
		end
	end

	if #var_46_2 > pg.gameset.boss_cnt_limit.description[4] then
		table.sort(var_46_2, function(arg_49_0, arg_49_1)
			return arg_49_0:GetJoinTime() < arg_49_1:GetJoinTime()
		end)

		if var_46_2[1] then
			table.insert(var_46_3, var_46_2[1])
		end
	end

	if #var_46_3 > 0 then
		for iter_46_2, iter_46_3 in ipairs(var_46_3) do
			if self.cacheBosses[iter_46_3.id] and iter_46_3.id ~= self.cacheLock then
				self.cacheBosses[iter_46_3.id] = nil
			end
		end

		self:DispatchEvent(WorldBossProxy.EventCacheBossListUpdated)
	end

	return
end

function WorldBossProxy:RemoveCacheBoss(arg_50_1)
	if self.cacheBosses[arg_50_1] then
		self.cacheBosses[arg_50_1] = nil

		self:DispatchEvent(WorldBossProxy.EventCacheBossListUpdated)
	end

	return
end

function WorldBossProxy:GetCacheBoss(arg_51_1)
	return self.cacheBosses[arg_51_1]
end

function WorldBossProxy:LockCacheBoss(arg_52_1)
	self.cacheLock = arg_52_1

	return
end

function WorldBossProxy:UnlockCacheBoss()
	self.cacheLock = nil

	return
end

function WorldBossProxy:canGetSelfAward()
	local var_54_0 = self:GetSelfBoss()

	return var_54_0 and var_54_0:isDeath()
end

function WorldBossProxy:UpdateSelfBoss(arg_55_1)
	if self.boss and arg_55_1 and not arg_55_1:isSameLevel(self.boss) then
		self.fleet:clearFleet()
	end

	self.boss = arg_55_1

	self:DispatchEvent(WorldBossProxy.EventBossUpdated)

	return
end

function WorldBossProxy:RemoveSelfBoss()
	if self.boss then
		self:UpdateSelfBoss(nil)
	end

	self:ClearHighestDamage()
	self:ClearAutoBattle()
	self:ClearFriendSupported()
	self:ClearGuildSupported()
	self:ClearWorldSupported()

	return
end

function WorldBossProxy:updateBossHp(arg_57_1, arg_57_2)
	if self.boss and arg_57_1 == self.boss.id then
		self.boss:UpdateHp(arg_57_2)
		self:UpdateSelfBoss(self.boss)
	else
		local var_57_0 = self.cacheBosses[arg_57_1]

		if self.cacheBosses[arg_57_1] then
			var_57_0:UpdateHp(arg_57_2)
			self:UpdateCacheBoss(var_57_0)
		end
	end

	return
end

function WorldBossProxy:GetBossById(arg_58_1)
	if self.boss and self.boss.id == arg_58_1 then
		return self.boss
	end

	if self.cacheBosses[arg_58_1] then
		return self.cacheBosses[arg_58_1]
	end

	return
end

function WorldBossProxy:GetSelfBoss()
	return self.boss
end

function WorldBossProxy:IsSelfBoss(arg_60_1)
	assert(arg_60_1)

	return self.boss and self.boss.id == arg_60_1.id or arg_60_1:IsSelf()
end

function WorldBossProxy:GetBoss()
	return self.boss
end

function WorldBossProxy:ExistSelfBoss()
	return self.boss ~= nil and not self.boss:IsExpired()
end

function WorldBossProxy:GetCacheBossList()
	local var_63_0 = {}

	for iter_63_0, iter_63_1 in pairs(self.cacheBosses) do
		if not self:IsSelfBoss(iter_63_1) then
			table.insert(var_63_0, iter_63_1)
		end
	end

	return var_63_0
end

function WorldBossProxy:reducePt()
	self.pt = self.pt - 1

	self:DispatchEvent(WorldBossProxy.EventPtUpdated)

	return
end

function WorldBossProxy:increasePt()
	self.pt = math.min(self:GetMaxPt(), self.pt + pg.gameset.joint_boss_ap_recove_cnt_pre_day.key_value)

	self:DispatchEvent(WorldBossProxy.EventPtUpdated)

	return
end

function WorldBossProxy:SetRank(arg_66_1, arg_66_2)
	self.ranks[arg_66_1] = arg_66_2

	local var_66_0 = self:GetBossById(arg_66_1)

	if var_66_0 then
		var_66_0:SetRankCnt(#arg_66_2)
	end

	self:addTimer(arg_66_1)
	self:DispatchEvent(WorldBossProxy.EventRankListUpdated, arg_66_1)

	return
end

function WorldBossProxy:GetRank(arg_67_1)
	return self.ranks[arg_67_1]
end

function WorldBossProxy:ClearRank(arg_68_1)
	self.ranks[arg_68_1] = nil

	return
end

function WorldBossProxy:addTimer(arg_69_1)
	if not arg_69_1 then
		return
	end

	if self.timers[arg_69_1] then
		self.timers[arg_69_1]:Stop()

		self.timers[arg_69_1] = nil
	end

	self.timers[arg_69_1] = Timer.New(function()
		if self.ranks then
			self.ranks[arg_69_1] = nil
		end

		if self.timer and self.timers[arg_69_1] then
			self.timers[arg_69_1]:Stop()

			self.timers[arg_69_1] = nil
		end

		return
	end, 300, 1)

	self.timers[arg_69_1]:Start()

	return
end

function WorldBossProxy:GetPt()
	return self.pt
end

function WorldBossProxy:GetMaxPt()
	return pg.gameset.joint_boss_ap_max.key_value
end

function WorldBossProxy:isMaxPt()
	return self.pt == self:GetMaxPt()
end

function WorldBossProxy:GetRecoverPtTime()
	return pg.gameset.joint_boss_ap_recover_time.key_value
end

function WorldBossProxy:GetNextReconveTime()
	return self.ptTime
end

function WorldBossProxy:updatePtTime(arg_76_1)
	self.ptTime = arg_76_1

	return
end

function WorldBossProxy:Dispose()
	WorldBossProxy.super.Dispose(self)

	for iter_77_0, iter_77_1 in pairs(self.timers or {}) do
		iter_77_1:Stop()
	end

	self.timers = nil

	return
end

function WorldBossProxy:NeedTip()
	return (function()
		if self.boss and self.boss:isDeath() and not self.boss:IsExpired() and not self.boss:ShouldWaitForResult() then
			return true
		end

		return false
	end)()
end

function WorldBossProxy:UpdatedUnlockProgress(arg_80_1, arg_80_2)
	if arg_80_2 > arg_80_1 then
		if not nowWorld():IsSystemOpen(WorldConst.SystemWorldBoss) then
			self.tipProgress = false

			goto label_80_0
		end
	end

	do
		local var_80_0 = pg.NewStoryMgr.GetInstance():IsPlayed("WorldG190")

		var_80_0 = var_80_0 or not GUIDE_WROLD

		if not var_80_0 then
			self.tipProgress = true
		else
			local var_80_1 = getProxy(SettingsProxy):GetWorldBossProgressTipTable()

			if #var_80_1 == 0 then
				self.tipProgress = false
			else
				self.tipProgress = _.any(var_80_1, function(arg_81_0)
					return arg_80_1 < tonumber(arg_81_0) and arg_80_2 >= tonumber(arg_81_0)
				end)
			end
		end
	end

	::label_80_0::

	self:DispatchEvent(WorldBossProxy.EventUnlockProgressUpdated)

	return
end

function WorldBossProxy:ShouldTipProgress()
	return self.tipProgress
end

function WorldBossProxy:ClearTipProgress()
	self.tipProgress = false

	return
end

function WorldBossProxy:GetCanGetAwardBoss()
	return nil
end

function WorldBossProxy:ExistSelfBossAward()
	if self.boss and self.boss:isDeath() and not self.boss:IsExpired() then
		return true
	end

	return false
end

function WorldBossProxy:ExistCacheBoss()
	return table.getCount(self.cacheBosses) ~= 0
end

function WorldBossProxy:IsOpen()
	return WorldBossConst.GetCurrBossID() ~= nil
end

function WorldBossProxy.IsNeedSupport()
	local var_88_0 = nowWorld():GetBossProxy():GetSelfBoss()

	if not var_88_0 then
		return
	end

	if not WorldBossConst._IsCurrBoss(var_88_0) then
		return
	end

	if WorldBossConst.GetCurrBossDayIndex() < pg.gameset.world_metaboss_supportattack.description[1] then
		return
	end

	return true
end

function WorldBossProxy.GetSupportValue()
	if not WorldBossProxy.IsNeedSupport() then
		return
	end

	local var_89_0 = pg.gameset.world_metaboss_supportattack.description

	assert(pg.gameset.world_metaboss_supportattack.description[6], "Missing WorldBoss SupportAttack Buff")

	return true, 0, var_89_0[6]
end

return WorldBossProxy
