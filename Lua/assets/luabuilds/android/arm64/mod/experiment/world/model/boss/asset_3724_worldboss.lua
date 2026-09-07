local WorldBoss = class("WorldBoss", import("....BaseEntity"))

WorldBoss.Fields = {
	config = "table",
	configId = "number",
	killTime = "number",
	type = "number",
	lastTime = "number",
	fightCount = "number",
	player = "table",
	owner = "number",
	joinTime = "number",
	rankCount = "number",
	hp = "number",
	id = "number",
	level = "number"
}
WorldBoss.SUPPORT_TYPE_FRIEND = 1
WorldBoss.SUPPORT_TYPE_GUILD = 2
WorldBoss.SUPPORT_TYPE_WORLD = 3
WorldBoss.BOSS_TYPE_FRIEND = 1
WorldBoss.BOSS_TYPE_GUILD = 2
WorldBoss.BOSS_TYPE_WORLD = 3
WorldBoss.BOSS_TYPE_SELF = 0

function WorldBoss:Setup(arg_1_1, arg_1_2)
	self.id = arg_1_1.id
	self.configId = arg_1_1.template_id
	self.hp = arg_1_1.hp
	self.level = arg_1_1.lv
	self.owner = arg_1_1.owner
	self.lastTime = arg_1_1.last_time
	self.killTime = arg_1_1.kill_time or 0
	self.player = arg_1_2
	self.joinTime = joinTime or 0

	local var_1_0 = pg.world_joint_boss_template[self.configId]

	if pg.world_joint_boss_template[self.configId] then
		local var_1_1 = pg.world_boss_level[pg.world_joint_boss_template[self.configId].boss_level_id + (self.level - 1)]

		self.config = setmetatable({}, {
			__index = function(arg_2_0, arg_2_1)
				return var_1_0[arg_2_1] or var_1_1[arg_2_1]
			end
		})
	end

	self.fightCount = arg_1_1.fight_count or 0
	self.rankCount = arg_1_1.rank_count or 0
	self.type = self:SetBossType()

	return
end

function WorldBoss:GetConfigID()
	return self.configId
end

function WorldBoss:SetJoinTime(arg_4_1)
	self.joinTime = arg_4_1

	return
end

function WorldBoss:GetJoinTime()
	return self.joinTime
end

function WorldBoss:GetMetaId()
	return self.config.meta_id
end

function WorldBoss:IncreaseFightCnt()
	self.fightCount = self.fightCount + 1

	return
end

function WorldBoss:GetSelfFightCnt()
	return self.fightCount
end

function WorldBoss:GetOilConsume()
	if not self:IsSelf() then
		return 0
	end

	return WorldBossConst.GetBossOilConsume(self.fightCount + 1)
end

function WorldBoss:SetRankCnt(arg_10_1)
	self.rankCount = arg_10_1

	return
end

function WorldBoss:GetRankCnt()
	return self.rankCount
end

function WorldBoss:GetPlayer()
	return self.player
end

function WorldBoss:IsFullPeople()
	return self:GetRankCnt() >= pg.gameset.joint_boss_fighter_max.key_value
end

function WorldBoss:UpdateBossType(arg_14_1)
	if not self:IsSelf() then
		self.type = arg_14_1
	end

	return
end

function WorldBoss:GetWaitForResultTime()
	return self.killTime
end

function WorldBoss:ShouldWaitForResult()
	return pg.TimeMgr.GetInstance():GetServerTime() < self.killTime
end

function WorldBoss:GetRoleName()
	if self.player then
		return self.player.name
	else
		return ""
	end

	return
end

function WorldBoss:isSameLevel(arg_18_1)
	return self.level == arg_18_1.level
end

function WorldBoss:SetBossType()
	local var_19_0 = getProxy(PlayerProxy)
	local var_19_1 = getProxy(GuildProxy).getRawData(var_19_0)

	if self.owner == var_19_0:getRawData().id then
		return WorldBoss.BOSS_TYPE_SELF
	else
		if var_19_1 and var_19_1:getMemberById(self.owner) then
			return WorldBoss.BOSS_TYPE_GUILD
		end

		if getProxy(FriendProxy):getFriend(self.owner) then
			return WorldBoss.BOSS_TYPE_FRIEND
		end
	end

	return WorldBoss.BOSS_TYPE_WORLD
end

function WorldBoss:IsSelf()
	return self.type == WorldBoss.BOSS_TYPE_SELF
end

function WorldBoss:GetType()
	return self.type
end

function WorldBoss:GetStageID()
	return self.config.expedition_id
end

function WorldBoss:UpdateHp(arg_23_1)
	self.hp = arg_23_1

	return
end

function WorldBoss:GetHP()
	return self.hp
end

function WorldBoss:Active()
	return self.id > 0
end

function WorldBoss:isDeath()
	return self.hp <= 0
end

function WorldBoss:UpdateKillTime()
	local var_27_0 = nowWorld():GetBossProxy():GetRank(self.id)

	if var_27_0 and #var_27_0 > 1 then
		self.killTime = pg.TimeMgr.GetInstance():GetServerTime() + pg.gameset.world_boss_rank_wait_time.key_value
	end

	return
end

function WorldBoss:GetAwards()
	if self:IsSelf() then
		return self.config.drop_show_self
	else
		return self.config.drop_show_other
	end

	return
end

function WorldBoss:GetLeftTime()
	return self.lastTime - pg.TimeMgr.GetInstance():GetServerTime()
end

function WorldBoss:GetMaxHp()
	return self.config.hp
end

function WorldBoss:IsFullHp()
	return self.hp >= self:GetMaxHp()
end

function WorldBoss:GetName()
	return self.config.name
end

function WorldBoss:GetLevel()
	return self.level
end

function WorldBoss:GetExpiredTime()
	return self.lastTime
end

function WorldBoss:IsExpired()
	return self:GetLeftTime() <= 0
end

function WorldBoss:BuildTipText()
	local var_36_0 = self:GetRoleName()

	if self.type == WorldBoss.BOSS_TYPE_FRIEND then
		return i18n("world_joint_call_friend_support_txt", var_36_0, self.config.name, self.level)
	elseif self.type == WorldBoss.BOSS_TYPE_GUILD then
		return i18n("world_joint_call_guild_support_txt", var_36_0, self.config.name, self.level)
	else
		return i18n("world_joint_call_world_support_txt", var_36_0, self.config.name, self.level)
	end

	return
end

return WorldBoss
