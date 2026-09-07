local BossAward = class("BossAward", import("....BaseEntity"))

BossAward.Fields = {
	bossId = "number",
	duetime = "number",
	rank = "number",
	config = "table",
	acceptTime = "number",
	level = "number"
}

function BossAward:Setup(arg_1_1)
	self.bossId = arg_1_1.bossId
	self.config = pg.world_joint_boss_template[self.bossId]
	self.level = arg_1_1.level
	self.rank = arg_1_1.rank
	self.duetime = arg_1_1.duetime
	self.acceptTime = arg_1_1.accept_time or 0

	return
end

function BossAward:IsReceived()
	return self.acceptTime > 0
end

function BossAward:GetAwards()
	return self.config.drop_show
end

function BossAward:IsExpired()
	return pg.TimeMgr.GetInstance():GetServerTime() >= self.duetime
end

function BossAward:GetExpiredTime(...)
	return self.duetime
end

function BossAward:GetBossName()
	return self.config.name
end

function BossAward:GetRank()
	return self.rank
end

return BossAward
