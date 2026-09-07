local ActivityBossConfig = class("ActivityBossConfig", import("model.vo.BaseVO"))

function ActivityBossConfig:bindConfigTable()
	return pg.activity_event_worldboss
end

function ActivityBossConfig:GetConfigID()
	return self.configId
end

function ActivityBossConfig:Ctor(arg_3_1)
	ActivityBossConfig.super.Ctor(self, arg_3_1)

	local var_3_0 = self:getConfig("extrachallenge_id")

	if var_3_0 > 0 then
		self.spEnemy = ActivityBossSPEnemy.New({
			configId = var_3_0
		})
	end

	return
end

function ActivityBossConfig:GetTicketID()
	return self:getConfig("ticket")
end

function ActivityBossConfig:GetBattleTime()
	return self:getConfig("time")
end

function ActivityBossConfig:GetNormalStageIDs()
	return self:getConfig("normal_expedition")
end

function ActivityBossConfig:GetEXStageID()
	return self:getConfig("ex_expedition")
end

function ActivityBossConfig:GetOilLimits()
	return self:getConfig("use_oil_limit")
end

function ActivityBossConfig:GetBossID()
	return self:getConfig("boss_id")[1]
end

function ActivityBossConfig:GetMilestoneRewards()
	return AcessWithinNull(pg.extraenemy_template[self:GetBossID()], "reward_display") or {}
end

function ActivityBossConfig:GetInitTicketPools()
	return self:getConfig("normal_expedition_drop_num")
end

function ActivityBossConfig:GetSPEnemy()
	return self.spEnemy
end

function ActivityBossConfig:GetSPStageID()
	if not self.spEnemy then
		return
	end

	return self.spEnemy:GetExtraStageId()
end

return ActivityBossConfig
