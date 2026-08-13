class = var_0_10000

local var_0_0 = "WorldBossProxy"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("....BaseEntity"))
local var_0_2 = "WorldbossFleet"
local var_0_3 = "WorldbossFleet_for_archives"

var_0_1.Fields = {
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
var_0_1.REFRESH_BOSSES_TIME = 300
var_0_1.EventProcessBossListUpdated = "WorldBossProxy.EventProcessBossListUpdated"
var_0_1.EventCacheBossListUpdated = "WorldBossProxy.EventCacheBossListUpdated"
var_0_1.EventBossUpdated = "WorldBossProxy.EventBossUpdated"
var_0_1.EventFleetUpdated = "WorldBossProxy.EventFleetUpdated"
var_0_1.EventPtUpdated = "WorldBossProxy.EventPtUpdated"
var_0_1.EventRankListUpdated = "WorldBossProxy.EventRankListUpdated"
var_0_1.EventUnlockProgressUpdated = "WorldBossProxy.EventUnlockProgressUpdated"

function var_0_1.Setup(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.GetMaxPt(var_1_0)
	local var_1_2

	if not arg_1_1.fight_count then
		var_1_2 = 0
	end

	arg_1_0.pt = var_1_1 - var_1_2

	if arg_1_1.self_boss then
		WorldBoss = var_3

		local var_1_3 = var_3.New()

		getProxy = var_1_0
		PlayerProxy = var_1_10006

		local var_1_4 = var_1_0(var_1_10006)
		local var_1_5 = var_4.getData(var_1_4)

		var_1_3:Setup(arg_1_1.self_boss, var_1_5)

		if var_1_3:Active() then
			arg_1_0.boss = var_1_3
		end
	end

	local var_1_6

	if not arg_1_1.summon_pt then
		var_1_6 = 0
	end

	arg_1_0.summonPt = var_1_6

	local var_1_7

	if not arg_1_1.summon_pt_old then
		var_1_7 = 0
	end

	arg_1_0.summonPtOld = var_1_7

	local var_1_8

	if not arg_1_1.summon_pt_daily_acc then
		var_1_8 = 0
	end

	arg_1_0.summonPtDailyAcc = var_1_8

	local var_1_9

	if not arg_1_1.summon_pt_old_daily_acc then
		var_1_9 = 0
	end

	arg_1_0.summonPtOldDailyAcc = var_1_9

	local var_1_10

	if not arg_1_1.auto_fight_finish_time then
		var_1_10 = 0
	end

	arg_1_0.autoFightFinishTime = var_1_10

	local var_1_11

	if not arg_1_1.summon_free then
		var_1_11 = 0
	end

	arg_1_0.summonFree = var_1_11

	local var_1_12

	if not arg_1_1.default_boss_id then
		var_1_12 = 0
	end

	arg_1_0.archivesId = var_1_12

	local var_1_13

	if not arg_1_1.auto_fight_max_damage then
		var_1_13 = 0
	end

	arg_1_0.highestDamage = var_1_13

	local var_1_14

	if not arg_1_1.guild_support then
		var_1_14 = 0
	end

	arg_1_0.guildSupport = var_1_14

	local var_1_15

	if not arg_1_1.friend_support then
		var_1_15 = 0
	end

	arg_1_0.friendSupport = var_1_15

	local var_1_16

	if not arg_1_1.world_support then
		var_1_16 = 0
	end

	arg_1_0.worldSupport = var_1_16

	local var_1_17

	if not arg_1_1.self_boss_lv then
		var_1_17 = 1
	end

	arg_1_0.currentBossLV = var_1_17
	arg_1_0.cacheBosses = {}
	arg_1_0.ranks = {}
	arg_1_0.timers = {}
	arg_1_0.fleet = nil
	arg_1_0.fleetForArchives = nil

	arg_1_0:GenFleet()

	arg_1_0.refreshBossesTime = 0
	arg_1_0.isSetup = true
	arg_1_0.isFetched = false

	return
end

function var_0_1.CheckRemouldShip(arg_2_0)
	if arg_2_0.fleet and arg_2_0.fleetForArchives then
		arg_2_0:GenFleet()
	end

	return
end

function var_0_1.FriendSupported(arg_3_0)
	local var_3_0 = arg_3_0.friendSupport

	pg = var_1_10002

	local var_3_1 = var_1_10002.TimeMgr.GetInstance()

	return var_3_0 > var_2.GetServerTime(var_3_1)
end

function var_0_1.UpdateFriendSupported(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.gameset.joint_boss_world_time.key_value

	pg = var_1_10002

	local var_4_1 = var_1_10002.TimeMgr.GetInstance()

	arg_4_0.friendSupport = var_2.GetServerTime(var_4_1) + var_4_0

	return
end

function var_0_1.ClearFriendSupported(arg_5_0)
	arg_5_0.friendSupport = 0

	return
end

function var_0_1.GetNextFriendSupportTime(arg_6_0)
	return arg_6_0.friendSupport
end

function var_0_1.GuildSupported(arg_7_0)
	local var_7_0 = arg_7_0.guildSupport

	pg = var_1_10002

	local var_7_1 = var_1_10002.TimeMgr.GetInstance()

	return var_7_0 > var_2.GetServerTime(var_7_1)
end

function var_0_1.UpdateGuildSupported(arg_8_0)
	pg = var_1_10001

	local var_8_0 = var_1_10001.gameset.joint_boss_world_time.key_value

	pg = var_1_10002

	local var_8_1 = var_1_10002.TimeMgr.GetInstance()

	arg_8_0.guildSupport = var_2.GetServerTime(var_8_1) + var_8_0

	return
end

function var_0_1.ClearGuildSupported(arg_9_0)
	arg_9_0.guildSupport = 0

	return
end

function var_0_1.GetNextGuildSupportTime(arg_10_0)
	return arg_10_0.guildSupport
end

function var_0_1.WorldSupported(arg_11_0)
	local var_11_0 = arg_11_0.worldSupport

	pg = var_1_10002

	local var_11_1 = var_1_10002.TimeMgr.GetInstance()

	return var_11_0 > var_2.GetServerTime(var_11_1)
end

function var_0_1.UpdateWorldSupported(arg_12_0)
	pg = var_1_10001

	local var_12_0 = var_1_10001.gameset.joint_boss_world_time.key_value

	pg = var_1_10002

	local var_12_1 = var_1_10002.TimeMgr.GetInstance()

	arg_12_0.worldSupport = var_2.GetServerTime(var_12_1) + var_12_0

	return
end

function var_0_1.ClearWorldSupported(arg_13_0)
	arg_13_0.worldSupport = 0

	return
end

function var_0_1.GetNextWorldSupportTime(arg_14_0)
	return arg_14_0.worldSupport
end

function var_0_1.UpdateAutoBattleFinishTime(arg_15_0, arg_15_1)
	arg_15_0.autoFightFinishTime = arg_15_1

	return
end

function var_0_1.InAutoBattle(arg_16_0)
	return arg_16_0.autoFightFinishTime > 0
end

function var_0_1.ClearAutoBattle(arg_17_0)
	arg_17_0.autoFightFinishTime = 0

	return
end

function var_0_1.GetAutoBattleFinishTime(arg_18_0)
	return arg_18_0.autoFightFinishTime
end

function var_0_1.GetHighestDamage(arg_19_0)
	return arg_19_0.highestDamage
end

function var_0_1.UpdateHighestDamage(arg_20_0, arg_20_1)
	if arg_20_1 > arg_20_0.highestDamage then
		arg_20_0.highestDamage = arg_20_1
	end

	return
end

function var_0_1.ClearHighestDamage(arg_21_0)
	arg_21_0.highestDamage = 0

	return
end

function var_0_1.AddSummonFree(arg_22_0, arg_22_1)
	arg_22_0.summonFree = arg_22_0.summonFree + arg_22_1

	return
end

function var_0_1.GetSummonPt(arg_23_0)
	return arg_23_0.summonPt
end

function var_0_1.AddSummonPt(arg_24_0, arg_24_1)
	WorldBossConst = var_1_10002

	local var_24_0, var_24_1, var_24_2 = var_1_10002.GetCurrBossConsume()

	if var_24_1 < arg_24_0.summonPtDailyAcc + arg_24_1 then
		arg_24_1 = var_24_1 - arg_24_0.summonPtDailyAcc
	end

	if arg_24_1 <= 0 then
		return
	end

	local var_24_3 = arg_24_0.summonPt

	math = var_1_10006
	arg_24_0.summonPt = var_1_10006.min(arg_24_0.summonPt + arg_24_1, var_24_2)
	math = var_6

	local var_24_4 = var_6.min(var_24_2 - var_24_3, arg_24_1)

	math = var_1_10007
	arg_24_0.summonPtDailyAcc = var_1_10007.min(arg_24_0.summonPtDailyAcc + var_24_4, var_24_1)

	arg_24_0:UpdatedUnlockProgress(var_24_3, arg_24_0.summonPt)

	return
end

function var_0_1.ConsumeSummonPt(arg_25_0, arg_25_1)
	arg_25_0.summonPt = arg_25_0.summonPt - arg_25_1

	arg_25_0:DispatchEvent(var_0_1.EventUnlockProgressUpdated)

	return
end

function var_0_1.GetSummonPtDailyAcc(arg_26_0)
	return arg_26_0.summonPtDailyAcc
end

function var_0_1.ClearSummonPtDailyAcc(arg_27_0)
	arg_27_0.summonPtDailyAcc = 0

	arg_27_0:DispatchEvent(var_0_1.EventUnlockProgressUpdated)

	return
end

function var_0_1.GetSummonPtOld(arg_28_0)
	return arg_28_0.summonPtOld
end

function var_0_1.AddSummonPtOld(arg_29_0, arg_29_1)
	WorldBossConst = var_1_10002

	local var_29_0, var_29_1, var_29_2 = var_1_10002.GetAchieveBossConsume()

	if var_29_1 < arg_29_0.summonPtOldDailyAcc + arg_29_1 then
		arg_29_1 = var_29_1 - arg_29_0.summonPtOldDailyAcc
	end

	if arg_29_1 <= 0 then
		return
	end

	local var_29_3 = arg_29_0.summonPtOld

	math = var_1_10006
	arg_29_0.summonPtOld = var_1_10006.min(arg_29_0.summonPtOld + arg_29_1, var_29_2)
	math = var_6

	local var_29_4 = var_6.min(var_29_2 - var_29_3, arg_29_1)

	math = var_1_10007
	arg_29_0.summonPtOldDailyAcc = var_1_10007.min(arg_29_0.summonPtOldDailyAcc + var_29_4, var_29_1)

	return
end

function var_0_1.ConsumeSummonPtOld(arg_30_0, arg_30_1)
	arg_30_0.summonPtOld = arg_30_0.summonPtOld - arg_30_1

	arg_30_0:DispatchEvent(var_0_1.EventUnlockProgressUpdated)

	return
end

function var_0_1.ClearSummonPtOldAcc(arg_31_0)
	arg_31_0.summonPtOldDailyAcc = 0

	arg_31_0:DispatchEvent(var_0_1.EventUnlockProgressUpdated)

	return
end

function var_0_1.GetSummonPtOldAcc(arg_32_0)
	return arg_32_0.summonPtOldDailyAcc
end

function var_0_1.GetArchivesId(arg_33_0)
	return arg_33_0.archivesId
end

function var_0_1.SetArchivesId(arg_34_0, arg_34_1)
	arg_34_0.archivesId = arg_34_1

	return
end

function var_0_1.BossId2FleetKey(arg_35_0, arg_35_1)
	if arg_35_0:GetBossById(arg_35_1) then
		WorldBossConst = var_1_10003

		if not var_1_10003._IsCurrBoss(var_2) then
			do return var_0_3 end

			goto label_35_0
		end
	end

	do return var_0_2 end

	::label_35_0::

	return
end

function var_0_1.GenFleet(arg_36_0)
	local var_36_0 = arg_36_0
	local var_36_1 = arg_36_0.GetCacheShips(var_36_0, var_0_2)

	TypedFleet = var_1_10002

	local var_36_2 = var_1_10002.New
	local var_36_3 = {
		id = 1
	}

	i18n = var_1_10005
	var_36_3.name = var_1_10005("world_boss_fleet")
	var_36_3.ship_list = var_36_1
	FleetType = var_5
	var_36_3.fleetType = var_5.Normal
	arg_36_0.fleet = var_36_2(var_36_3)

	local var_36_4 = arg_36_0:GetCacheShips(var_0_3)

	TypedFleet = var_36_0

	local var_36_5 = var_36_0.New
	local var_36_6 = {
		id = 1
	}

	i18n = var_1_10006
	var_36_6.name = var_1_10006("world_boss_fleet")
	var_36_6.ship_list = var_36_4
	FleetType = var_6
	var_36_6.fleetType = var_6.Normal
	arg_36_0.fleetForArchives = var_36_5(var_36_6)

	return
end

function var_0_1.GetCacheShips(arg_37_0, arg_37_1)
	local function var_37_0(arg_38_0, arg_38_1)
		local var_38_0 = arg_38_0:getTeamType()

		TeamType = var_2_10003

		if var_2_10003.GetTeamShipMax(var_38_0) < arg_38_1 + 1 then
			return true
		end

		return false
	end

	PlayerPrefs = var_1_10003

	local var_37_1 = var_1_10003.GetString
	local var_37_2 = arg_37_1

	getProxy = var_1_10006
	PlayerProxy = var_1_10008

	local var_37_3 = var_1_10006(var_1_10008)
	local var_37_4 = var_37_1(var_37_2 .. var_6.getRawData(var_37_3).id)

	string = var_1_10004

	local var_37_5 = var_1_10004.split(var_37_4, "|")
	local var_37_6 = {}
	local var_37_7 = {}

	TeamType = var_7
	var_37_7[var_7.Vanguard] = 0
	TeamType = var_7
	var_37_7[var_7.Main] = 0
	TeamType = var_7
	var_37_7[var_7.Submarine] = 0

	if var_37_5 and #var_37_5 > 0 and (#var_37_5 ~= 1 or var_37_5[1] ~= "") then
		ipairs = var_7

		for iter_37_0, iter_37_1 in var_7(var_37_5) do
			tonumber = var_1_10012
			var_1_10012 = var_1_10012(iter_37_1)
			getProxy = var_1_10013
			BayProxy = var_1_10015
			var_1_10015 = var_1_10013(var_1_10015)

			if var_1_10013.getShipById(var_1_10015, var_1_10012) then
				local var_37_8 = var_1_10013:getTeamType()

				if not var_37_0(var_1_10013, var_37_7[var_37_8]) then
					var_37_7[var_37_8] = var_37_7[var_37_8] + 1
					table = var_1_10015

					var_1_10015.insert(var_37_6, var_1_10012)
				end
			end
		end
	end

	return var_37_6
end

function var_0_1.GetFleet(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_0:BossId2FleetKey(arg_39_1)
	local var_39_1

	if var_0_3 == var_39_0 then
		var_39_1 = arg_39_0.fleetForArchives
	else
		var_39_1 = arg_39_0.fleet
	end

	if not var_39_1 then
		Fleet = var_4

		local var_39_2 = var_4.New
		local var_39_3 = {
			id = 1
		}

		i18n = var_1_10007
		var_39_3.name = var_1_10007("world_boss_fleet")
		var_39_3.ship_list = {}
		FleetType = var_7
		var_39_3.fleetType = var_7.Normal
		var_39_1 = var_39_2(var_39_3)
	end

	for iter_39_0 = #var_39_1.ships, 1, -1 do
		local var_39_4 = var_39_1.ships[iter_39_0]

		getProxy = var_1_10009
		BayProxy = var_1_10011
		var_1_10011 = var_1_10009(var_1_10011)

		if not var_1_10009.getShipById(var_1_10011, var_39_4) then
			var_1_10011 = var_39_1

			var_39_1.removeShipById(var_1_10011, var_39_4)
		end
	end

	return var_39_1
end

function var_0_1.UpdateFleet(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = arg_40_0:BossId2FleetKey(arg_40_1)

	if var_0_3 == var_40_0 then
		arg_40_0.fleetForArchives = arg_40_2
	else
		arg_40_0.fleet = arg_40_2
	end

	arg_40_0:DispatchEvent(var_0_1.EventFleetUpdated)

	return
end

function var_0_1.SavaCacheShips(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = arg_41_0:BossId2FleetKey(arg_41_1)
	local var_41_1 = arg_41_2
	local var_41_2 = arg_41_2.getShipIds(var_41_1)
	local var_41_3 = ""

	ipairs = var_41_1

	for iter_41_0, iter_41_1 in var_41_1(var_41_2) do
		var_41_3 = var_41_3 .. iter_41_1 .. "|"
	end

	PlayerPrefs = var_6

	local var_41_4 = var_6.SetString
	local var_41_5 = var_41_0

	getProxy = iter_41_0
	PlayerProxy = var_1_10011

	local var_41_6 = iter_41_0(var_1_10011)

	var_41_4(var_41_5 .. var_9.getRawData(var_41_6).id, var_41_3)

	PlayerPrefs = var_41_4

	var_41_4.Save()

	return
end

function var_0_1.ClearCacheShips(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_0:BossId2FleetKey(arg_42_1)

	PlayerPrefs = var_1_10003

	local var_42_1 = var_1_10003.DeleteKey
	local var_42_2 = var_42_0

	getProxy = var_1_10006
	PlayerProxy = var_1_10008

	local var_42_3 = var_1_10006(var_1_10008)

	var_42_1(var_42_2 .. var_6.getRawData(var_42_3).id)

	PlayerPrefs = var_42_1

	var_42_1.Save()

	return
end

function var_0_1.UpdteRefreshBossesTime(arg_43_0)
	pg = var_1_10001

	local var_43_0 = var_1_10001.TimeMgr.GetInstance()

	arg_43_0.refreshBossesTime = var_1.GetServerTime(var_43_0) + var_0_1.REFRESH_BOSSES_TIME

	return
end

function var_0_1.ShouldRefreshBosses(arg_44_0)
	pg = var_1_10001

	local var_44_0 = var_1_10001.TimeMgr.GetInstance()

	return var_1.GetServerTime(var_44_0) >= arg_44_0.refreshBossesTime
end

function var_0_1.UpdateCacheBoss(arg_45_0, arg_45_1)
	if arg_45_0:IsSelfBoss(arg_45_1) then
		arg_45_0:UpdateSelfBoss(arg_45_1)
	else
		arg_45_0.cacheBosses[arg_45_1.id] = arg_45_1

		arg_45_0:BalanceMaxBossCnt()
	end

	return
end

function var_0_1.BalanceMaxBossCnt(arg_46_0)
	pg = var_1_10001

	local var_46_0 = var_1_10001.gameset.boss_cnt_limit.description

	table = var_1_10002

	if var_1_10002.getCount(arg_46_0.cacheBosses) < var_46_0[1] then
		return
	end

	local var_46_1 = {}
	local var_46_2 = {}
	local var_46_3 = {}
	local var_46_4 = {}

	pairs = var_1_10006

	for iter_46_0, iter_46_1 in var_1_10006(arg_46_0.cacheBosses) do
		local var_46_5 = iter_46_1:GetType()

		if iter_46_1:isDeath() or iter_46_1:IsExpired() then
			table = var_12

			var_12.insert(var_46_4, iter_46_1)
		else
			WorldBoss = var_12

			if var_46_5 == var_12.BOSS_TYPE_FRIEND then
				table = var_12

				var_12.insert(var_46_3, iter_46_1)
			else
				WorldBoss = var_12

				if var_46_5 == var_12.BOSS_TYPE_GUILD then
					table = var_12

					var_12.insert(var_46_2, iter_46_1)
				else
					WorldBoss = var_12

					if var_46_5 == var_12.BOSS_TYPE_WORLD then
						table = var_12

						var_12.insert(var_46_1, iter_46_1)
					end
				end
			end
		end
	end

	if #var_46_1 > var_46_0[2] then
		table = var_6

		var_6.sort(var_46_1, function(arg_47_0, arg_47_1)
			return arg_47_0:GetJoinTime() < arg_47_1:GetJoinTime()
		end)

		if var_46_1[1] then
			table = var_6

			var_6.insert(var_46_4, var_46_1[1])
		end
	end

	if #var_46_2 > var_46_0[3] then
		table = var_6

		var_6.sort(var_46_2, function(arg_48_0, arg_48_1)
			return arg_48_0:GetJoinTime() < arg_48_1:GetJoinTime()
		end)

		if var_46_2[1] then
			table = var_6

			var_6.insert(var_46_4, var_46_2[1])
		end
	end

	if #var_46_3 > var_46_0[4] then
		table = var_6

		var_6.sort(var_46_3, function(arg_49_0, arg_49_1)
			return arg_49_0:GetJoinTime() < arg_49_1:GetJoinTime()
		end)

		if var_46_3[1] then
			table = var_6

			var_6.insert(var_46_4, var_46_3[1])
		end
	end

	if #var_46_4 > 0 then
		ipairs = var_6

		for iter_46_2, iter_46_3 in var_6(var_46_4) do
			if arg_46_0.cacheBosses[iter_46_3.id] and iter_46_3.id ~= arg_46_0.cacheLock then
				arg_46_0.cacheBosses[iter_46_3.id] = nil
			end
		end

		arg_46_0:DispatchEvent(var_0_1.EventCacheBossListUpdated)
	end

	return
end

function var_0_1.RemoveCacheBoss(arg_50_0, arg_50_1)
	if arg_50_0.cacheBosses[arg_50_1] then
		arg_50_0.cacheBosses[arg_50_1] = nil

		arg_50_0:DispatchEvent(var_0_1.EventCacheBossListUpdated)
	end

	return
end

function var_0_1.GetCacheBoss(arg_51_0, arg_51_1)
	return arg_51_0.cacheBosses[arg_51_1]
end

function var_0_1.LockCacheBoss(arg_52_0, arg_52_1)
	arg_52_0.cacheLock = arg_52_1

	return
end

function var_0_1.UnlockCacheBoss(arg_53_0)
	arg_53_0.cacheLock = nil

	return
end

function var_0_1.canGetSelfAward(arg_54_0)
	return arg_54_0:GetSelfBoss() and var_1:isDeath()
end

function var_0_1.UpdateSelfBoss(arg_55_0, arg_55_1)
	if arg_55_0.boss and arg_55_1 and not arg_55_1:isSameLevel(arg_55_0.boss) then
		local var_55_0 = arg_55_0.fleet

		var_2.clearFleet(var_55_0)
	end

	arg_55_0.boss = arg_55_1

	arg_55_0:DispatchEvent(var_0_1.EventBossUpdated)

	return
end

function var_0_1.RemoveSelfBoss(arg_56_0)
	if arg_56_0.boss then
		arg_56_0:UpdateSelfBoss(nil)
	end

	arg_56_0:ClearHighestDamage()
	arg_56_0:ClearAutoBattle()
	arg_56_0:ClearFriendSupported()
	arg_56_0:ClearGuildSupported()
	arg_56_0:ClearWorldSupported()

	return
end

function var_0_1.updateBossHp(arg_57_0, arg_57_1, arg_57_2)
	if arg_57_0.boss and arg_57_1 == arg_57_0.boss.id then
		local var_57_0 = arg_57_0.boss

		var_3.UpdateHp(var_57_0, arg_57_2)
		arg_57_0:UpdateSelfBoss(arg_57_0.boss)
	elseif arg_57_0.cacheBosses[arg_57_1] then
		var_3:UpdateHp(arg_57_2)
		arg_57_0:UpdateCacheBoss(var_3)
	end

	return
end

function var_0_1.GetBossById(arg_58_0, arg_58_1)
	if arg_58_0.boss and arg_58_0.boss.id == arg_58_1 then
		return arg_58_0.boss
	end

	if arg_58_0.cacheBosses[arg_58_1] then
		return var_2
	end

	return
end

function var_0_1.GetSelfBoss(arg_59_0)
	return arg_59_0.boss
end

function var_0_1.IsSelfBoss(arg_60_0, arg_60_1)
	assert = var_1_10002

	var_1_10002(arg_60_1)

	return arg_60_0.boss and arg_60_0.boss.id == arg_60_1.id or arg_60_1:IsSelf()
end

function var_0_1.GetBoss(arg_61_0)
	return arg_61_0.boss
end

function var_0_1.ExistSelfBoss(arg_62_0)
	local var_62_1

	if arg_62_0.boss ~= nil then
		local var_62_0 = arg_62_0.boss

		var_62_1 = not var_1.IsExpired(var_62_0)
	else
		var_62_1 = false
	end

	if false then
		var_62_1 = true
	end

	return var_62_1
end

function var_0_1.GetCacheBossList(arg_63_0)
	local var_63_0 = {}

	pairs = var_1_10002

	for iter_63_0, iter_63_1 in var_1_10002(arg_63_0.cacheBosses) do
		if not arg_63_0:IsSelfBoss(iter_63_1) then
			table = var_7

			var_7.insert(var_63_0, iter_63_1)
		end
	end

	return var_63_0
end

function var_0_1.reducePt(arg_64_0)
	arg_64_0.pt = arg_64_0.pt - 1

	arg_64_0:DispatchEvent(var_0_1.EventPtUpdated)

	return
end

function var_0_1.increasePt(arg_65_0)
	local var_65_0 = arg_65_0:GetMaxPt()

	math = var_1_10002

	local var_65_1 = var_1_10002.min
	local var_65_2 = var_65_0
	local var_65_3 = arg_65_0.pt

	pg = var_1_10006
	arg_65_0.pt = var_65_1(var_65_2, var_65_3 + var_1_10006.gameset.joint_boss_ap_recove_cnt_pre_day.key_value)

	arg_65_0:DispatchEvent(var_0_1.EventPtUpdated)

	return
end

function var_0_1.SetRank(arg_66_0, arg_66_1, arg_66_2)
	arg_66_0.ranks[arg_66_1] = arg_66_2

	if arg_66_0:GetBossById(arg_66_1) then
		var_3:SetRankCnt(#arg_66_2)
	end

	arg_66_0:addTimer(arg_66_1)
	arg_66_0:DispatchEvent(var_0_1.EventRankListUpdated, arg_66_1)

	return
end

function var_0_1.GetRank(arg_67_0, arg_67_1)
	return arg_67_0.ranks[arg_67_1]
end

function var_0_1.ClearRank(arg_68_0, arg_68_1)
	arg_68_0.ranks[arg_68_1] = nil

	return
end

function var_0_1.addTimer(arg_69_0, arg_69_1)
	if not arg_69_1 then
		return
	end

	if arg_69_0.timers[arg_69_1] then
		local var_69_0 = arg_69_0.timers[arg_69_1]

		var_2.Stop(var_69_0)

		arg_69_0.timers[arg_69_1] = nil
	end

	local var_69_1 = arg_69_0.timers

	Timer = var_1_10003
	var_69_1[arg_69_1] = var_1_10003.New(function()
		if arg_69_0.ranks then
			arg_69_0.ranks[arg_69_1] = nil
		end

		if arg_69_0.timer and arg_69_0.timers[arg_69_1] then
			local var_70_0 = arg_69_0.timers[arg_69_1]

			var_0.Stop(var_70_0)

			arg_69_0.timers[arg_69_1] = nil
		end

		return
	end, 300, 1)

	local var_69_2 = arg_69_0.timers[arg_69_1]

	var_2.Start(var_69_2)

	return
end

function var_0_1.GetPt(arg_71_0)
	return arg_71_0.pt
end

function var_0_1.GetMaxPt(arg_72_0)
	pg = var_1_10001

	return var_1_10001.gameset.joint_boss_ap_max.key_value
end

function var_0_1.isMaxPt(arg_73_0)
	return arg_73_0.pt == arg_73_0:GetMaxPt()
end

function var_0_1.GetRecoverPtTime(arg_74_0)
	pg = var_1_10001

	return var_1_10001.gameset.joint_boss_ap_recover_time.key_value
end

function var_0_1.GetNextReconveTime(arg_75_0)
	return arg_75_0.ptTime
end

function var_0_1.updatePtTime(arg_76_0, arg_76_1)
	arg_76_0.ptTime = arg_76_1

	return
end

function var_0_1.Dispose(arg_77_0)
	var_0_1.super.Dispose(arg_77_0)

	pairs = var_1

	local var_77_0

	if not arg_77_0.timers then
		var_77_0 = {}
	end

	for iter_77_0, iter_77_1 in var_1(var_77_0) do
		iter_77_1:Stop()
	end

	arg_77_0.timers = nil

	return
end

function var_0_1.NeedTip(arg_78_0)
	return (function()
		if arg_78_0.boss then
			local var_79_0 = arg_78_0.boss

			if var_0.isDeath(var_79_0) then
				local var_79_1 = arg_78_0.boss

				if not var_0.IsExpired(var_79_1) then
					local var_79_2 = arg_78_0.boss

					if not var_0.ShouldWaitForResult(var_79_2) then
						return true
					end
				end
			end
		end

		return false
	end)()
end

function var_0_1.UpdatedUnlockProgress(arg_80_0, arg_80_1, arg_80_2)
	if not (arg_80_2 <= arg_80_1) then
		nowWorld = var_1_10003

		local var_80_0 = var_1_10003()

		var_1_10003 = var_1_10003.IsSystemOpen
		WorldConst = var_1_10006

		if not var_1_10003(var_80_0, var_1_10006.SystemWorldBoss) then
			arg_80_0.tipProgress = false
		else
			pg = var_1_10003

			local var_80_1 = var_1_10003.NewStoryMgr.GetInstance()
			local var_80_2

			if not var_3.IsPlayed(var_80_1, "WorldG190") then
				GUIDE_WROLD = var_80_2
				var_80_2 = not var_80_2
			end

			if not var_80_2 then
				arg_80_0.tipProgress = true
			else
				getProxy = var_80_1
				SettingsProxy = var_1_10007

				local var_80_3 = var_80_1(var_1_10007)

				if #var_5.GetWorldBossProgressTipTable(var_80_3) == 0 then
					arg_80_0.tipProgress = false
				else
					_ = var_6
					arg_80_0.tipProgress = var_6.any(var_5, function(arg_81_0)
						local var_81_0 = arg_80_1

						tonumber = var_2_10002

						if var_81_0 < var_2_10002(arg_81_0) then
							local var_81_1 = arg_80_2

							tonumber = var_2

							local var_81_2

							if not (var_81_1 >= var_2(arg_81_0)) then
								var_81_2 = false
							else
								var_81_2 = true
							end

							return var_81_2
						end
					end)
				end
			end
		end

		arg_80_0:DispatchEvent(var_0_1.EventUnlockProgressUpdated)

		return
	end
end

function var_0_1.ShouldTipProgress(arg_82_0)
	return arg_82_0.tipProgress
end

function var_0_1.ClearTipProgress(arg_83_0)
	arg_83_0.tipProgress = false

	return
end

function var_0_1.GetCanGetAwardBoss(arg_84_0)
	return nil
end

function var_0_1.ExistSelfBossAward(arg_85_0)
	if arg_85_0.boss then
		local var_85_0 = arg_85_0.boss

		if var_1.isDeath(var_85_0) then
			local var_85_1 = arg_85_0.boss

			if not var_1.IsExpired(var_85_1) then
				return true
			end
		end
	end

	return false
end

function var_0_1.ExistCacheBoss(arg_86_0)
	table = var_1_10001

	return var_1_10001.getCount(arg_86_0.cacheBosses) ~= 0
end

function var_0_1.IsOpen(arg_87_0)
	WorldBossConst = var_1_10001

	return var_1_10001.GetCurrBossID() ~= nil
end

function var_0_1.IsNeedSupport()
	WorldBossConst = var_1_10000

	local var_88_0 = var_1_10000.GetCurrBossDayIndex()

	pg = var_1_10001

	local var_88_1 = var_1_10001.gameset.world_metaboss_supportattack.description

	nowWorld = var_1_10002

	local var_88_2 = var_1_10002()
	local var_88_3 = var_2.GetBossProxy(var_88_2)

	if not var_2.GetSelfBoss(var_88_3) then
		return
	end

	WorldBossConst = var_1_10003

	if not var_1_10003._IsCurrBoss(var_2) then
		return
	end

	if var_88_0 < var_88_1[1] then
		return
	end

	return true
end

function var_0_1.GetSupportValue()
	WorldBossProxy = var_1_10000

	if not var_1_10000.IsNeedSupport() then
		return
	end

	pg = var_1_10001

	local var_89_0 = var_1_10001.gameset.world_metaboss_supportattack.description
	local var_89_1 = 0

	assert = var_1_10003

	var_1_10003(var_89_0[6], "Missing WorldBoss SupportAttack Buff")

	return true, var_89_1, var_89_0[6]
end

return var_0_1
