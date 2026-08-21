local var_0_0 = class("WorldBossConst")

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
	return table.contains(var_0_0.GetAchieveBossIdList(), arg_2_0)
end

function var_0_0.IsCurrBoss(arg_3_0)
	return var_0_0.GetCurrBossGroup() == arg_3_0
end

function var_0_0._IsCurrBoss(arg_4_0)
	return var_0_0.GetCurrBossID() == arg_4_0.config.id
end

function var_0_0.GetCurrBossGroup()
	for iter_5_0 = #pg.world_joint_boss_template.all, 1, -1 do
		if type(pg.world_joint_boss_template[pg.world_joint_boss_template.all[iter_5_0]].state) == "table" then
			local var_5_0 = pg.TimeMgr.GetInstance()

			if var_5_0:inTime(pg.world_joint_boss_template[pg.world_joint_boss_template.all[iter_5_0]].state) then
				return pg.world_joint_boss_template[pg.world_joint_boss_template.all[iter_5_0]].meta_id
			end
		end
	end

	return nil
end

function var_0_0.GetCurrBossID()
	for iter_6_0 = #pg.world_joint_boss_template.all, 1, -1 do
		if type(pg.world_joint_boss_template[pg.world_joint_boss_template.all[iter_6_0]].state) == "table" then
			local var_6_0 = pg.TimeMgr.GetInstance()

			if var_6_0:inTime(pg.world_joint_boss_template[pg.world_joint_boss_template.all[iter_6_0]].state) then
				return pg.world_joint_boss_template[pg.world_joint_boss_template.all[iter_6_0]].id
			end
		end
	end

	return nil
end

function var_0_0.GetCurrBossLeftDay()
	local var_7_9000
	local var_7_0 = pg.TimeMgr.GetInstance():GetServerTime()
	local var_7_1 = pg.TimeMgr.GetInstance().parseTimeFromConfig(var_7_9000, pg.world_joint_boss_template[var_0_0.GetCurrBossID()].state[2])

	return pg.TimeMgr.GetInstance():DiffDay(var_7_0, var_7_1), (var_7_1 - var_7_0) % 0
end

function var_0_0.GetCurrBossDayIndex()
	local var_8_0 = pg.TimeMgr.GetInstance()

	return var_8_0:DiffDay(pg.TimeMgr.GetInstance():parseTimeFromConfig(pg.world_joint_boss_template[var_0_0.GetCurrBossID()].state[1]), (var_8_0:GetServerTime())) + 1
end

function var_0_0.GetCurrBossStartTimeAndEndTime()
	return pg.world_joint_boss_template[var_0_0.GetCurrBossID()].state
end

function var_0_0.GetCurrBossConsume()
	return pg.gameset.curr_boss_ticket.description[1], pg.gameset.curr_boss_ticket.description[2], pg.gameset.curr_boss_ticket.description[3]
end

function var_0_0.GetCurrBossItemProgress()
	return nowWorld().worldBossProxy:GetSummonPt()
end

function var_0_0.GetCurrBossItemAcc()
	return nowWorld().worldBossProxy:GetSummonPtDailyAcc()
end

function var_0_0.CanUnlockCurrBoss()
	return var_0_0.GetCurrBossItemProgress() >= var_0_0.GetCurrBossConsume()
end

function var_0_0.GetCurrBossItemCapacity()
	local var_14_0, var_14_1, var_14_2 = var_0_0.GetCurrBossConsume()

	return var_0_0.GetCurrBossItemProgress(), var_0_0.GetCurrBossItemAcc(), var_14_1, var_14_2
end

function var_0_0.GetAchieveBossConsume()
	return pg.gameset.past_joint_boss_ticket.description[1], pg.gameset.past_joint_boss_ticket.description[2], pg.gameset.past_joint_boss_ticket.description[3]
end

function var_0_0.GetAchieveBossItemProgress()
	return nowWorld().worldBossProxy:GetSummonPtOld()
end

function var_0_0.GetSummonPtOldAcc()
	return nowWorld().worldBossProxy:GetSummonPtOldAcc()
end

function var_0_0.CanUnlockArchivesBoss()
	return var_0_0.GetAchieveBossItemProgress() >= var_0_0.GetAchieveBossConsume()
end

function var_0_0.GetAchieveBossItemCapacity()
	local var_19_0, var_19_1, var_19_2 = var_0_0.GetAchieveBossConsume()

	return var_0_0.GetAchieveBossItemProgress(), var_0_0.GetSummonPtOldAcc(), var_19_1, var_19_2
end

function var_0_0.GetAchieveBossIdList()
	for iter_20_0 = 1, #pg.world_joint_boss_template.all do
		if pg.world_joint_boss_template[pg.world_joint_boss_template.all[iter_20_0]].state == "always" then
			table.insert({}, pg.world_joint_boss_template[pg.world_joint_boss_template.all[iter_20_0]].meta_id)
		end
	end

	return {}
end

function var_0_0.GetAchieveBossList()
	for iter_21_0 = 1, #pg.world_joint_boss_template.all do
		if pg.world_joint_boss_template[pg.world_joint_boss_template.all[iter_21_0]].state == "always" then
			table.insert({}, pg.world_joint_boss_template[pg.world_joint_boss_template.all[iter_21_0]])
		end
	end

	return {}
end

function var_0_0.GetCurrBossItemInfo()
	local var_22_0, var_22_1, var_22_2, var_22_3 = WorldBossConst.GetCurrBossItemCapacity()
	local var_22_4 = string.split(i18n("world_boss_item_info"), "|")
	local var_22_5 = var_22_4[2]

	for iter_22_0, iter_22_1 in ipairs({
		var_22_1,
		var_22_2,
		var_22_0,
		var_22_3
	}) do
		var_22_5 = string.gsub(var_22_5, "$" .. iter_22_0, iter_22_1)
	end

	return {
		rarity = 4,
		name = var_22_4[1],
		display = var_22_5,
		icon = {
			"Props/world_boss_record"
		}
	}
end

function var_0_0.GetAchieveBossItemInfo()
	local var_23_0, var_23_1, var_23_2, var_23_3 = WorldBossConst.GetAchieveBossItemCapacity()
	local var_23_4 = string.split(i18n("world_past_boss_item_info"), "|")
	local var_23_5 = var_23_4[2]

	for iter_23_0, iter_23_1 in ipairs({
		var_23_1,
		var_23_2,
		var_23_0,
		var_23_3
	}) do
		var_23_5 = string.gsub(var_23_5, "$" .. iter_23_0, iter_23_1)
	end

	return {
		rarity = 4,
		name = var_23_4[1],
		display = var_23_5,
		icon = {
			"Props/world_past_boss_record"
		}
	}
end

function var_0_0.IsClearAllAchieveBoss()
	return _.all(var_0_0.GetAchieveBossIdList(), function(arg_25_0)
		return not getProxy(MetaCharacterProxy):getMetaProgressVOByID(arg_25_0).metaPtData:CanGetNextAward()
	end)
end

function var_0_0.GetArchivesId()
	return nowWorld():GetBossProxy():GetArchivesId()
end

function var_0_0.GetAchieveState()
	local var_27_0 = var_0_0.GetArchivesId()

	if var_27_0 == 0 then
		return var_0_0.ACHIEVE_STATE_NOSTART
	end

	if #var_0_0.GetAchieveBossIdList() == 0 then
		return var_0_0.ACHIEVE_STATE_NOSTART
	elseif var_0_0.IsClearAllAchieveBoss() then
		return var_0_0.ACHIEVE_STATE_CLEAR
	else
		local var_27_1 = getProxy(MetaCharacterProxy):getMetaProgressVOByID(pg.world_joint_boss_template[var_27_0].meta_id)

		if not var_27_1.metaPtData:CanGetNextAward() or var_27_1.metaPtData:IsMaxPt() then
			return var_0_0.ACHIEVE_STATE_NOSTART
		else
			return var_0_0.ACHIEVE_STATE_STARTING
		end
	end

	return
end

function var_0_0.GetBossOilConsume(arg_28_0)
	arg_28_0 = math.min(arg_28_0, #pg.gameset.joint_boss_oil_consume.description)

	return pg.gameset.joint_boss_oil_consume.description[arg_28_0]
end

function var_0_0.GetArchivesBossAutoBattleSecond()
	return pg.gameset.past_joint_boss_autofight_time.key_value
end

function var_0_0.GetArchivesBossAutoBattleMinute()
	return math.ceil(var_0_0.GetArchivesBossAutoBattleSecond() / 60)
end

function var_0_0.GetHighestDamage()
	return math.max(nowWorld():GetBossProxy():GetHighestDamage(), 1)
end

function var_0_0.GetAutoBattleCnt()
	return math.ceil(nowWorld():GetBossProxy():GetSelfBoss().hp / var_0_0.GetHighestDamage())
end

function var_0_0.GetAutoBattleOilConsume()
	local var_33_0 = 0
	local var_33_1 = nowWorld():GetBossProxy():GetSelfBoss().fightCount

	for iter_33_0 = var_33_1 + 1, var_33_1 + var_0_0.GetAutoBattleCnt() do
		var_33_0 = var_33_0 + WorldBossConst.GetBossOilConsume(iter_33_0)
	end

	return var_33_0
end

function var_0_0.InAutoBattle()
	return nowWorld():GetBossProxy():InAutoBattle()
end

function var_0_0.GetAutoBattleLeftTime()
	local var_35_9000
	local var_35_0 = nowWorld()

	return var_35_0.GetBossProxy(var_35_9000):GetAutoBattleFinishTime() - pg.TimeMgr.GetInstance().GetServerTime(var_35_0)
end

function var_0_0.GetAutoBattleState(arg_36_0)
	if not arg_36_0 or arg_36_0:isDeath() then
		return var_0_0.AUTO_BATTLE_STATE_HIDE
	end

	if WorldBossConst.InAutoBattle() then
		do return var_0_0.AUTO_BATTLE_STATE_STARTING end

		goto label_36_0
	end

	if arg_36_0:isDeath() then
		do return var_0_0.AUTO_BATTLE_STATE_HIDE end

		goto label_36_0
	end

	::label_36_0::

	if arg_36_0:GetSelfFightCnt() > 0 then
		if nowWorld():GetBossProxy():GetHighestDamage() <= 0 then
			return var_0_0.AUTO_BATTLE_STATE_LOCK
		else
			return var_0_0.AUTO_BATTLE_STATE_NORMAL
		end

		return
	end
end

function var_0_0.BossId2MetaId(arg_37_0)
	return pg.world_joint_boss_template[arg_37_0].meta_id
end

function var_0_0.MetaId2BossId(arg_38_0)
	for iter_38_0, iter_38_1 in ipairs(pg.world_joint_boss_template.all) do
		if var_0_0.BossId2MetaId(iter_38_1) == arg_38_0 then
			return iter_38_1
		end
	end

	return
end

function var_0_0.AnyArchivesBossCanGetAward()
	return _.any(var_0_0.GetAchieveBossIdList(), function(arg_40_0)
		return getProxy(MetaCharacterProxy):getMetaProgressVOByID(arg_40_0).metaPtData:CanGetAward()
	end)
end

function var_0_0.GetCommissionSceneMetaBossBtnState()
	local var_41_0 = nowWorld()

	if not var_41_0 or not var_41_0:IsActivate() then
		return CommissionMetaBossBtn.STATE_LOCK
	end

	local var_41_1 = var_41_0:GetBossProxy()

	if not var_41_1 or not var_41_1.isSetup or not var_41_1:IsOpen() then
		return CommissionMetaBossBtn.STATE_LOCK
	end

	local var_41_2 = var_41_1:GetSelfBoss()

	if var_41_2 and WorldBossConst.GetAutoBattleState(var_41_2) == WorldBossConst.AUTO_BATTLE_STATE_STARTING then
		if WorldBossConst.GetAutoBattleLeftTime() > 0 then
			return CommissionMetaBossBtn.STATE_AUTO_BATTLE
		else
			return CommissionMetaBossBtn.STATE_FINSH_BATTLE
		end
	end

	local var_41_3 = var_41_1:NeedTip() or WorldBossConst.AnyArchivesBossCanGetAward()

	if var_41_3 then
		return CommissionMetaBossBtn.STATE_GET_AWARDS
	end

	return CommissionMetaBossBtn.STATE_NORMAL
end

return var_0_0
