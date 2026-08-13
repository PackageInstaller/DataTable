class = var_0_10000

local var_0_0 = var_0_10000("WorldBossConst")

var_0_0.WORLD_BOSS_ITEM_ID = 100000
var_0_0.WORLD_PAST_BOSS_ITEM_ID = 100002
var_0_0.ACHIEVE_STATE_NOSTART = 1
var_0_0.ACHIEVE_STATE_STARTING = 2
var_0_0.ACHIEVE_STATE_CLEAR = 3
var_0_0.BOSS_TYPE_CURR = 1
var_0_0.BOSS_TYPE_ARCHIVES = 2
var_0_0.STOP_AUTO_BATTLE_MANUAL = 1
var_0_0.STOP_AUTO_BATTLE_TIMEOVER = 2
var_0_0.AUTO_BATTLE_STATE_NORMAL = 0
var_0_0.AUTO_BATTLE_STATE_LOCK = 1
var_0_0.AUTO_BATTLE_STATE_STARTING = 2
var_0_0.AUTO_BATTLE_STATE_HIDE = 3

function var_0_0.__IsCurrBoss(arg_1_0)
	return var_0_0.GetCurrBossID() == arg_1_0
end

function var_0_0.IsAchieveBoss(arg_2_0)
	local var_2_0 = var_0_0.GetAchieveBossIdList()

	table = var_1_10002

	return var_1_10002.contains(var_2_0, arg_2_0)
end

function var_0_0.IsCurrBoss(arg_3_0)
	return var_0_0.GetCurrBossGroup() == arg_3_0
end

function var_0_0._IsCurrBoss(arg_4_0)
	local var_4_0 = arg_4_0.config.id

	return var_0_0.GetCurrBossID() == var_4_0
end

function var_0_0.GetCurrBossGroup()
	pg = var_1_10000

	for iter_5_0 = #var_1_10000.world_joint_boss_template.all, 1, -1 do
		local var_5_0 = var_0.all[iter_5_0]

		type = var_1_10006

		if var_1_10006(var_0[var_5_0].state) == "table" then
			pg = var_1_10006

			local var_5_1 = var_1_10006.TimeMgr.GetInstance()

			if var_1_10006.inTime(var_5_1, var_0[var_5_0].state) then
				return var_0[var_5_0].meta_id
			end
		end
	end

	return nil
end

function var_0_0.GetCurrBossID()
	pg = var_1_10000

	for iter_6_0 = #var_1_10000.world_joint_boss_template.all, 1, -1 do
		local var_6_0 = var_0.all[iter_6_0]

		type = var_1_10006

		if var_1_10006(var_0[var_6_0].state) == "table" then
			pg = var_1_10006

			local var_6_1 = var_1_10006.TimeMgr.GetInstance()

			if var_1_10006.inTime(var_6_1, var_0[var_6_0].state) then
				return var_0[var_6_0].id
			end
		end
	end

	return nil
end

function var_0_0.GetCurrBossLeftDay()
	local var_7_0 = var_0_0.GetCurrBossID()

	pg = var_1_10001

	local var_7_1 = var_1_10001.world_joint_boss_template[var_7_0]

	pg = var_1_10002

	local var_7_2 = var_1_10002.TimeMgr.GetInstance()
	local var_7_3 = var_2.GetServerTime(var_7_2)

	pg = var_1_10003

	local var_7_4 = var_1_10003.TimeMgr.GetInstance()
	local var_7_5 = var_3.parseTimeFromConfig(var_7_4, var_7_1.state[2]) - var_7_3

	pg = var_7_4

	local var_7_6 = var_7_4.TimeMgr.GetInstance()

	return var_5.DiffDay(var_7_6, var_7_3, var_3), var_7_5 % 0
end

function var_0_0.GetCurrBossDayIndex()
	local var_8_0 = var_0_0.GetCurrBossID()

	pg = var_1_10001

	local var_8_1 = var_1_10001.world_joint_boss_template[var_8_0]

	pg = var_1_10002

	local var_8_2 = var_1_10002.TimeMgr.GetInstance()
	local var_8_3 = var_2.parseTimeFromConfig(var_8_2, var_8_1.state[1])

	pg = var_1_10003

	local var_8_4 = var_1_10003.TimeMgr.GetInstance()
	local var_8_5 = var_3.GetServerTime(var_8_4)

	return var_3:DiffDay(var_8_3, var_8_5) + 1
end

function var_0_0.GetCurrBossStartTimeAndEndTime()
	local var_9_0 = var_0_0.GetCurrBossID()

	pg = var_1_10001

	return var_1_10001.world_joint_boss_template[var_9_0].state
end

function var_0_0.GetCurrBossConsume()
	pg = var_1_10000

	local var_10_0 = var_1_10000.gameset.curr_boss_ticket.description[1]
	local var_10_1 = var_0[2]
	local var_10_2 = var_0[3]

	return var_10_0, var_10_1, var_10_2
end

function var_0_0.GetCurrBossItemProgress()
	nowWorld = var_1_10000

	local var_11_0 = var_1_10000().worldBossProxy

	return var_0.GetSummonPt(var_11_0)
end

function var_0_0.GetCurrBossItemAcc()
	nowWorld = var_1_10000

	local var_12_0 = var_1_10000().worldBossProxy

	return var_0.GetSummonPtDailyAcc(var_12_0)
end

function var_0_0.CanUnlockCurrBoss()
	return var_0_0.GetCurrBossItemProgress() >= var_0_0.GetCurrBossConsume()
end

function var_0_0.GetCurrBossItemCapacity()
	local var_14_0 = var_0_0.GetCurrBossItemProgress()
	local var_14_1 = var_0_0.GetCurrBossItemAcc()
	local var_14_2, var_14_3, var_14_4 = var_0_0.GetCurrBossConsume()

	return var_14_0, var_14_1, var_14_3, var_14_4
end

function var_0_0.GetAchieveBossConsume()
	pg = var_1_10000

	local var_15_0 = var_1_10000.gameset.past_joint_boss_ticket.description[1]
	local var_15_1 = var_0[2]
	local var_15_2 = var_0[3]

	return var_15_0, var_15_1, var_15_2
end

function var_0_0.GetAchieveBossItemProgress()
	nowWorld = var_1_10000

	local var_16_0 = var_1_10000().worldBossProxy

	return var_0.GetSummonPtOld(var_16_0)
end

function var_0_0.GetSummonPtOldAcc()
	nowWorld = var_1_10000

	local var_17_0 = var_1_10000().worldBossProxy

	return var_0.GetSummonPtOldAcc(var_17_0)
end

function var_0_0.CanUnlockArchivesBoss()
	return var_0_0.GetAchieveBossItemProgress() >= var_0_0.GetAchieveBossConsume()
end

function var_0_0.GetAchieveBossItemCapacity()
	local var_19_0 = var_0_0.GetAchieveBossItemProgress()
	local var_19_1 = var_0_0.GetSummonPtOldAcc()
	local var_19_2, var_19_3, var_19_4 = var_0_0.GetAchieveBossConsume()

	return var_19_0, var_19_1, var_19_3, var_19_4
end

function var_0_0.GetAchieveBossIdList()
	local var_20_0 = {}

	pg = var_1_10001

	local var_20_1 = var_1_10001.world_joint_boss_template

	for iter_20_0 = 1, #var_20_1.all do
		if var_20_1[var_20_1.all[iter_20_0]].state == "always" then
			table = var_7

			var_7.insert(var_20_0, var_20_1[var_6].meta_id)
		end
	end

	return var_20_0
end

function var_0_0.GetAchieveBossList()
	local var_21_0 = {}

	pg = var_1_10001

	local var_21_1 = var_1_10001.world_joint_boss_template

	for iter_21_0 = 1, #var_21_1.all do
		if var_21_1[var_21_1.all[iter_21_0]].state == "always" then
			table = var_7

			var_7.insert(var_21_0, var_21_1[var_6])
		end
	end

	return var_21_0
end

function var_0_0.GetCurrBossItemInfo()
	WorldBossConst = var_1_10000

	local var_22_0, var_22_1, var_22_2, var_22_3 = var_1_10000.GetCurrBossItemCapacity()

	i18n = var_1_10004

	local var_22_4 = var_1_10004("world_boss_item_info")

	string = var_1_10005

	local var_22_5 = var_1_10005.split(var_22_4, "|")[2]

	ipairs = var_7

	for iter_22_0, iter_22_1 in var_7({
		var_22_1,
		var_22_2,
		var_22_0,
		var_22_3
	}) do
		string = var_1_10012
		var_22_5 = var_1_10012.gsub(var_22_5, "$" .. iter_22_0, iter_22_1)
	end

	return {
		rarity = 4,
		name = var_5[1],
		display = var_22_5,
		icon = {
			"Props/world_boss_record"
		}
	}
end

function var_0_0.GetAchieveBossItemInfo()
	WorldBossConst = var_1_10000

	local var_23_0, var_23_1, var_23_2, var_23_3 = var_1_10000.GetAchieveBossItemCapacity()

	i18n = var_1_10004

	local var_23_4 = var_1_10004("world_past_boss_item_info")

	string = var_1_10005

	local var_23_5 = var_1_10005.split(var_23_4, "|")[2]

	ipairs = var_7

	for iter_23_0, iter_23_1 in var_7({
		var_23_1,
		var_23_2,
		var_23_0,
		var_23_3
	}) do
		string = var_1_10012
		var_23_5 = var_1_10012.gsub(var_23_5, "$" .. iter_23_0, iter_23_1)
	end

	return {
		rarity = 4,
		name = var_5[1],
		display = var_23_5,
		icon = {
			"Props/world_past_boss_record"
		}
	}
end

function var_0_0.IsClearAllAchieveBoss()
	local var_24_0 = var_0_0.GetAchieveBossIdList()

	_ = var_1_10001

	return var_1_10001.all(var_24_0, function(arg_25_0)
		getProxy = var_2_10001
		MetaCharacterProxy = var_2_10003

		local var_25_0 = var_2_10001(var_2_10003)
		local var_25_1 = var_1.getMetaProgressVOByID(var_25_0, arg_25_0).metaPtData

		return not var_2.CanGetNextAward(var_25_1)
	end)
end

function var_0_0.GetArchivesId()
	nowWorld = var_1_10000

	local var_26_0 = var_1_10000()
	local var_26_1 = var_0.GetBossProxy(var_26_0)

	return var_0.GetArchivesId(var_26_1)
end

function var_0_0.GetAchieveState()
	if var_0_0.GetArchivesId() == 0 then
		return var_0_0.ACHIEVE_STATE_NOSTART
	end

	if #var_0_0.GetAchieveBossIdList() == 0 then
		do return var_0_0.ACHIEVE_STATE_NOSTART end

		goto label_27_0
	end

	if var_0_0.IsClearAllAchieveBoss() then
		do return var_0_0.ACHIEVE_STATE_CLEAR end

		goto label_27_0
	end

	pg = var_2

	local var_27_0 = var_2.world_joint_boss_template[var_0].meta_id

	getProxy = var_1_10003
	MetaCharacterProxy = var_1_10005

	local var_27_1 = var_1_10003(var_1_10005)
	local var_27_2 = var_3.getMetaProgressVOByID(var_27_1, var_27_0).metaPtData

	if var_4.CanGetNextAward(var_27_2) then
		do
			local var_27_3 = var_3.metaPtData

			if var_4.IsMaxPt(var_27_3) then
				return var_0_0.ACHIEVE_STATE_NOSTART
			else
				return var_0_0.ACHIEVE_STATE_STARTING
			end
		end

		::label_27_0::

		return
	end
end

function var_0_0.GetBossOilConsume(arg_28_0)
	pg = var_1_10001

	local var_28_0 = var_1_10001.gameset.joint_boss_oil_consume.description

	math = var_1_10002

	return var_28_0[var_1_10002.min(arg_28_0, #var_28_0)]
end

function var_0_0.GetArchivesBossAutoBattleSecond()
	pg = var_1_10000

	return var_1_10000.gameset.past_joint_boss_autofight_time.key_value
end

function var_0_0.GetArchivesBossAutoBattleMinute()
	local var_30_0 = var_0_0.GetArchivesBossAutoBattleSecond()

	math = var_1_10001

	return var_1_10001.ceil(var_30_0 / 60)
end

function var_0_0.GetHighestDamage()
	nowWorld = var_1_10000

	local var_31_0 = var_1_10000()
	local var_31_1 = var_0.GetBossProxy(var_31_0)

	math = var_1_10001

	return var_1_10001.max(var_31_1:GetHighestDamage(), 1)
end

function var_0_0.GetAutoBattleCnt()
	nowWorld = var_1_10000

	local var_32_0 = var_1_10000()
	local var_32_1 = var_0.GetBossProxy(var_32_0)
	local var_32_2 = var_0.GetSelfBoss(var_32_1)
	local var_32_3 = var_0_0.GetHighestDamage()

	math = var_32_1

	return var_32_1.ceil(var_32_2.hp / var_32_3)
end

function var_0_0.GetAutoBattleOilConsume()
	local var_33_0 = var_0_0.GetAutoBattleCnt()

	nowWorld = var_1_10001

	local var_33_1 = var_1_10001()
	local var_33_2 = var_1.GetBossProxy(var_33_1)
	local var_33_3 = var_1.GetSelfBoss(var_33_2)
	local var_33_4 = 0

	for iter_33_0 = var_33_3.fightCount + 1, var_4 + var_33_0 do
		WorldBossConst = var_1_10009
		var_33_4 = var_33_4 + var_1_10009.GetBossOilConsume(iter_33_0)
	end

	return var_33_4
end

function var_0_0.InAutoBattle()
	nowWorld = var_1_10000

	local var_34_0 = var_1_10000()
	local var_34_1 = var_0.GetBossProxy(var_34_0)

	return var_0.InAutoBattle(var_34_1)
end

function var_0_0.GetAutoBattleLeftTime()
	nowWorld = var_1_10000

	local var_35_0 = var_1_10000()
	local var_35_1 = var_0.GetBossProxy(var_35_0)
	local var_35_2 = var_0.GetAutoBattleFinishTime(var_35_1)

	pg = var_35_0

	local var_35_3 = var_35_0.TimeMgr.GetInstance()

	return var_35_2 - var_2.GetServerTime(var_35_3)
end

function var_0_0.GetAutoBattleState(arg_36_0)
	if not arg_36_0 or arg_36_0:isDeath() then
		return var_0_0.AUTO_BATTLE_STATE_HIDE
	end

	WorldBossConst = var_1_10001

	if var_1_10001.InAutoBattle() then
		do return var_0_0.AUTO_BATTLE_STATE_STARTING end

		goto label_36_0
	end

	if arg_36_0:isDeath() then
		do return var_0_0.AUTO_BATTLE_STATE_HIDE end

		goto label_36_0
	end

	if not (arg_36_0:GetSelfFightCnt() <= 0) then
		nowWorld = var_1

		do
			local var_36_0 = var_1()
			local var_36_1 = var_1.GetBossProxy(var_36_0)

			if var_1.GetHighestDamage(var_36_1) <= 0 then
				return var_0_0.AUTO_BATTLE_STATE_LOCK
			else
				return var_0_0.AUTO_BATTLE_STATE_NORMAL
			end
		end

		::label_36_0::

		return
	end
end

function var_0_0.BossId2MetaId(arg_37_0)
	pg = var_1_10001

	return var_1_10001.world_joint_boss_template[arg_37_0].meta_id
end

function var_0_0.MetaId2BossId(arg_38_0)
	ipairs = var_1_10001
	pg = var_1_10003

	for iter_38_0, iter_38_1 in var_1_10001(var_1_10003.world_joint_boss_template.all) do
		if var_0_0.BossId2MetaId(iter_38_1) == arg_38_0 then
			return iter_38_1
		end
	end

	return
end

function var_0_0.AnyArchivesBossCanGetAward()
	_ = var_1_10000

	return var_1_10000.any(var_0_0.GetAchieveBossIdList(), function(arg_40_0)
		getProxy = var_2_10001
		MetaCharacterProxy = var_2_10003

		local var_40_0 = var_2_10001(var_2_10003)
		local var_40_1 = var_1.getMetaProgressVOByID(var_40_0, arg_40_0).metaPtData

		return var_2.CanGetAward(var_40_1)
	end)
end

function var_0_0.GetCommissionSceneMetaBossBtnState()
	nowWorld = var_1_10000

	if not var_1_10000() or not var_0:IsActivate() then
		CommissionMetaBossBtn = var_1_10001

		return var_1_10001.STATE_LOCK
	end

	local var_41_0 = var_0

	if not var_0.GetBossProxy(var_41_0) or not var_1.isSetup or not var_1:IsOpen() then
		CommissionMetaBossBtn = var_1_10002

		return var_1_10002.STATE_LOCK
	end

	local var_41_1 = var_1

	if var_1.GetSelfBoss(var_41_1) then
		WorldBossConst = var_41_0

		local var_41_2 = var_41_0.GetAutoBattleState(var_2)

		WorldBossConst = var_41_1

		if var_41_2 == var_41_1.AUTO_BATTLE_STATE_STARTING then
			WorldBossConst = var_41_2

			local var_41_3 = var_41_2.GetAutoBattleLeftTime()

			if 0 < var_41_3 then
				CommissionMetaBossBtn = var_41_3

				return var_41_3.STATE_AUTO_BATTLE
			else
				CommissionMetaBossBtn = var_41_3

				return var_41_3.STATE_FINSH_BATTLE
			end
		end
	end

	local var_41_4

	if not var_1:NeedTip() then
		WorldBossConst = var_41_4
		var_41_4 = var_41_4.AnyArchivesBossCanGetAward()
	end

	if var_41_4 then
		CommissionMetaBossBtn = var_41_1

		return var_41_1.STATE_GET_AWARDS
	end

	CommissionMetaBossBtn = var_41_1

	return var_41_1.STATE_NORMAL
end

return var_0_0
