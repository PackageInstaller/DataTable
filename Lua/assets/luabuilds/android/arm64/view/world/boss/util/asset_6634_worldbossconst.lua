local WorldBossConst = class("WorldBossConst")

WorldBossConst.WORLD_BOSS_ITEM_ID = 100000
WorldBossConst.WORLD_PAST_BOSS_ITEM_ID = 100002
WorldBossConst.ACHIEVE_STATE_NOSTART = 1
WorldBossConst.ACHIEVE_STATE_STARTING = 2
WorldBossConst.ACHIEVE_STATE_CLEAR = 3
WorldBossConst.BOSS_TYPE_CURR = 1
WorldBossConst.BOSS_TYPE_ARCHIVES = 2
WorldBossConst.STOP_AUTO_BATTLE_MANUAL = 1
WorldBossConst.STOP_AUTO_BATTLE_TIMEOVER = 2
WorldBossConst.AUTO_BATTLE_STATE_NORMAL = 0
WorldBossConst.AUTO_BATTLE_STATE_LOCK = 1
WorldBossConst.AUTO_BATTLE_STATE_STARTING = 2
WorldBossConst.AUTO_BATTLE_STATE_HIDE = 3

function WorldBossConst:__IsCurrBoss()
	return WorldBossConst.GetCurrBossID() == self
end

function WorldBossConst:IsAchieveBoss()
	return table.contains(WorldBossConst.GetAchieveBossIdList(), self)
end

function WorldBossConst:IsCurrBoss()
	return WorldBossConst.GetCurrBossGroup() == self
end

function WorldBossConst:_IsCurrBoss()
	return WorldBossConst.GetCurrBossID() == self.config.id
end

function WorldBossConst.GetCurrBossGroup()
	for iter_5_0 = #pg.world_joint_boss_template.all, 1, -1 do
		if type(pg.world_joint_boss_template[pg.world_joint_boss_template.all[iter_5_0]].state) == "table" then
			if pg.TimeMgr.GetInstance():inTime(pg.world_joint_boss_template[pg.world_joint_boss_template.all[iter_5_0]].state) then
				return pg.world_joint_boss_template[pg.world_joint_boss_template.all[iter_5_0]].meta_id
			end
		end
	end

	return nil
end

function WorldBossConst.GetCurrBossID()
	for iter_6_0 = #pg.world_joint_boss_template.all, 1, -1 do
		if type(pg.world_joint_boss_template[pg.world_joint_boss_template.all[iter_6_0]].state) == "table" then
			if pg.TimeMgr.GetInstance():inTime(pg.world_joint_boss_template[pg.world_joint_boss_template.all[iter_6_0]].state) then
				return pg.world_joint_boss_template[pg.world_joint_boss_template.all[iter_6_0]].id
			end
		end
	end

	return nil
end

function WorldBossConst.GetCurrBossLeftDay()
	local var_7_0 = pg.TimeMgr.GetInstance():GetServerTime()
	local var_7_1 = pg.TimeMgr.GetInstance():parseTimeFromConfig(pg.world_joint_boss_template[WorldBossConst.GetCurrBossID()].state[2])

	return pg.TimeMgr.GetInstance():DiffDay(var_7_0, var_7_1), (var_7_1 - var_7_0) % 0
end

function WorldBossConst.GetCurrBossDayIndex()
	local var_8_0 = pg.TimeMgr.GetInstance()

	return var_8_0:DiffDay(pg.TimeMgr.GetInstance():parseTimeFromConfig(pg.world_joint_boss_template[WorldBossConst.GetCurrBossID()].state[1]), (var_8_0:GetServerTime())) + 1
end

function WorldBossConst.GetCurrBossStartTimeAndEndTime()
	return pg.world_joint_boss_template[WorldBossConst.GetCurrBossID()].state
end

function WorldBossConst.GetCurrBossConsume()
	return pg.gameset.curr_boss_ticket.description[1], pg.gameset.curr_boss_ticket.description[2], pg.gameset.curr_boss_ticket.description[3]
end

function WorldBossConst.GetCurrBossItemProgress()
	return nowWorld().worldBossProxy:GetSummonPt()
end

function WorldBossConst.GetCurrBossItemAcc()
	return nowWorld().worldBossProxy:GetSummonPtDailyAcc()
end

function WorldBossConst.CanUnlockCurrBoss()
	return WorldBossConst.GetCurrBossItemProgress() >= WorldBossConst.GetCurrBossConsume()
end

function WorldBossConst.GetCurrBossItemCapacity()
	local var_14_0, var_14_1, var_14_2 = WorldBossConst.GetCurrBossConsume()

	return WorldBossConst.GetCurrBossItemProgress(), WorldBossConst.GetCurrBossItemAcc(), var_14_1, var_14_2
end

function WorldBossConst.GetAchieveBossConsume()
	return pg.gameset.past_joint_boss_ticket.description[1], pg.gameset.past_joint_boss_ticket.description[2], pg.gameset.past_joint_boss_ticket.description[3]
end

function WorldBossConst.GetAchieveBossItemProgress()
	return nowWorld().worldBossProxy:GetSummonPtOld()
end

function WorldBossConst.GetSummonPtOldAcc()
	return nowWorld().worldBossProxy:GetSummonPtOldAcc()
end

function WorldBossConst.CanUnlockArchivesBoss()
	return WorldBossConst.GetAchieveBossItemProgress() >= WorldBossConst.GetAchieveBossConsume()
end

function WorldBossConst.GetAchieveBossItemCapacity()
	local var_19_0, var_19_1, var_19_2 = WorldBossConst.GetAchieveBossConsume()

	return WorldBossConst.GetAchieveBossItemProgress(), WorldBossConst.GetSummonPtOldAcc(), var_19_1, var_19_2
end

function WorldBossConst.GetAchieveBossIdList()
	local var_20_0 = {}

	for iter_20_0 = 1, #pg.world_joint_boss_template.all do
		if pg.world_joint_boss_template[pg.world_joint_boss_template.all[iter_20_0]].state == "always" then
			table.insert(var_20_0, pg.world_joint_boss_template[pg.world_joint_boss_template.all[iter_20_0]].meta_id)
		end
	end

	return var_20_0
end

function WorldBossConst.GetAchieveBossList()
	local var_21_0 = {}

	for iter_21_0 = 1, #pg.world_joint_boss_template.all do
		if pg.world_joint_boss_template[pg.world_joint_boss_template.all[iter_21_0]].state == "always" then
			table.insert(var_21_0, pg.world_joint_boss_template[pg.world_joint_boss_template.all[iter_21_0]])
		end
	end

	return var_21_0
end

function WorldBossConst.GetCurrBossItemInfo()
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

function WorldBossConst.GetAchieveBossItemInfo()
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

function WorldBossConst.IsClearAllAchieveBoss()
	return _.all(WorldBossConst.GetAchieveBossIdList(), function(arg_25_0)
		return not getProxy(MetaCharacterProxy):getMetaProgressVOByID(arg_25_0).metaPtData:CanGetNextAward()
	end)
end

function WorldBossConst.GetArchivesId()
	return nowWorld():GetBossProxy():GetArchivesId()
end

function WorldBossConst.GetAchieveState()
	local var_27_0 = WorldBossConst.GetArchivesId()

	if var_27_0 == 0 then
		return WorldBossConst.ACHIEVE_STATE_NOSTART
	end

	if #WorldBossConst.GetAchieveBossIdList() == 0 then
		return WorldBossConst.ACHIEVE_STATE_NOSTART
	elseif WorldBossConst.IsClearAllAchieveBoss() then
		return WorldBossConst.ACHIEVE_STATE_CLEAR
	else
		local var_27_1 = getProxy(MetaCharacterProxy):getMetaProgressVOByID(pg.world_joint_boss_template[var_27_0].meta_id)

		if not var_27_1.metaPtData:CanGetNextAward() or var_27_1.metaPtData:IsMaxPt() then
			return WorldBossConst.ACHIEVE_STATE_NOSTART
		else
			return WorldBossConst.ACHIEVE_STATE_STARTING
		end
	end

	return
end

function WorldBossConst:GetBossOilConsume()
	self = math.min(self, #pg.gameset.joint_boss_oil_consume.description)

	return pg.gameset.joint_boss_oil_consume.description[self]
end

function WorldBossConst.GetArchivesBossAutoBattleSecond()
	return pg.gameset.past_joint_boss_autofight_time.key_value
end

function WorldBossConst.GetArchivesBossAutoBattleMinute()
	return math.ceil(WorldBossConst.GetArchivesBossAutoBattleSecond() / 60)
end

function WorldBossConst.GetHighestDamage()
	return math.max(nowWorld():GetBossProxy():GetHighestDamage(), 1)
end

function WorldBossConst.GetAutoBattleCnt()
	return math.ceil(nowWorld():GetBossProxy():GetSelfBoss().hp / WorldBossConst.GetHighestDamage())
end

function WorldBossConst.GetAutoBattleOilConsume()
	local var_33_0 = 0
	local var_33_1 = nowWorld():GetBossProxy():GetSelfBoss().fightCount

	for iter_33_0 = var_33_1 + 1, var_33_1 + WorldBossConst.GetAutoBattleCnt() do
		var_33_0 = var_33_0 + WorldBossConst.GetBossOilConsume(iter_33_0)
	end

	return var_33_0
end

function WorldBossConst.InAutoBattle()
	return nowWorld():GetBossProxy():InAutoBattle()
end

function WorldBossConst.GetAutoBattleLeftTime()
	local var_35_0 = nowWorld()

	return var_35_0:GetBossProxy():GetAutoBattleFinishTime() - pg.TimeMgr.GetInstance().GetServerTime(var_35_0)
end

function WorldBossConst:GetAutoBattleState()
	if not self or self:isDeath() then
		return WorldBossConst.AUTO_BATTLE_STATE_HIDE
	end

	if WorldBossConst.InAutoBattle() then
		return WorldBossConst.AUTO_BATTLE_STATE_STARTING
	elseif self:isDeath() then
		return WorldBossConst.AUTO_BATTLE_STATE_HIDE
	else
		if self:GetSelfFightCnt() > 0 then
			if nowWorld():GetBossProxy():GetHighestDamage() <= 0 then
				do return WorldBossConst.AUTO_BATTLE_STATE_LOCK end

				goto label_36_0
			end
		end

		return WorldBossConst.AUTO_BATTLE_STATE_NORMAL
	end

	::label_36_0::

	return
end

function WorldBossConst:BossId2MetaId()
	return pg.world_joint_boss_template[self].meta_id
end

function WorldBossConst:MetaId2BossId()
	for iter_38_0, iter_38_1 in ipairs(pg.world_joint_boss_template.all) do
		if WorldBossConst.BossId2MetaId(iter_38_1) == self then
			return iter_38_1
		end
	end

	return
end

function WorldBossConst.AnyArchivesBossCanGetAward()
	return _.any(WorldBossConst.GetAchieveBossIdList(), function(arg_40_0)
		return getProxy(MetaCharacterProxy):getMetaProgressVOByID(arg_40_0).metaPtData:CanGetAward()
	end)
end

function WorldBossConst.GetCommissionSceneMetaBossBtnState()
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

	if var_41_1:NeedTip() or WorldBossConst.AnyArchivesBossCanGetAward() then
		return CommissionMetaBossBtn.STATE_GET_AWARDS
	end

	return CommissionMetaBossBtn.STATE_NORMAL
end

return WorldBossConst
