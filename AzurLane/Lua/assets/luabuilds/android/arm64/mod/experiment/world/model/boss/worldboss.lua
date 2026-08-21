local var_0_0 = class("WorldBoss", import("....BaseEntity"))

var_0_0.Fields = {
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
var_0_0.SUPPORT_TYPE_FRIEND = 1
var_0_0.SUPPORT_TYPE_GUILD = 2
var_0_0.SUPPORT_TYPE_WORLD = 3
var_0_0.BOSS_TYPE_FRIEND = 1
var_0_0.BOSS_TYPE_GUILD = 2
var_0_0.BOSS_TYPE_WORLD = 3
var_0_0.BOSS_TYPE_SELF = 0

function var_0_0.Setup(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_1.template_id
	arg_1_0.hp = arg_1_1.hp
	arg_1_0.level = arg_1_1.lv
	arg_1_0.owner = arg_1_1.owner
	arg_1_0.lastTime = arg_1_1.last_time
	arg_1_0.killTime = arg_1_1.kill_time or 0
	arg_1_0.player = arg_1_2
	arg_1_0.joinTime = joinTime or 0

	local var_1_0 = pg.world_joint_boss_template[arg_1_0.configId]

	if pg.world_joint_boss_template[arg_1_0.configId] then
		local var_1_1 = pg.world_boss_level[pg.world_joint_boss_template[arg_1_0.configId].boss_level_id + (arg_1_0.level - 1)]

		arg_1_0.config = setmetatable({}, {
			__index = function(arg_2_0, arg_2_1)
				return var_1_0[arg_2_1] or var_1_1[arg_2_1]
			end
		})
	end

	arg_1_0.fightCount = arg_1_1.fight_count or 0
	arg_1_0.rankCount = arg_1_1.rank_count or 0
	arg_1_0.type = arg_1_0:SetBossType()

	return
end

function var_0_0.GetConfigID(arg_3_0)
	return arg_3_0.configId
end

function var_0_0.SetJoinTime(arg_4_0, arg_4_1)
	arg_4_0.joinTime = arg_4_1

	return
end

function var_0_0.GetJoinTime(arg_5_0)
	return arg_5_0.joinTime
end

function var_0_0.GetMetaId(arg_6_0)
	return arg_6_0.config.meta_id
end

function var_0_0.IncreaseFightCnt(arg_7_0)
	arg_7_0.fightCount = arg_7_0.fightCount + 1

	return
end

function var_0_0.GetSelfFightCnt(arg_8_0)
	return arg_8_0.fightCount
end

function var_0_0.GetOilConsume(arg_9_0)
	if not arg_9_0:IsSelf() then
		return 0
	end

	return WorldBossConst.GetBossOilConsume(arg_9_0.fightCount + 1)
end

function var_0_0.SetRankCnt(arg_10_0, arg_10_1)
	arg_10_0.rankCount = arg_10_1

	return
end

function var_0_0.GetRankCnt(arg_11_0)
	return arg_11_0.rankCount
end

function var_0_0.GetPlayer(arg_12_0)
	return arg_12_0.player
end

function var_0_0.IsFullPeople(arg_13_0)
	return arg_13_0:GetRankCnt() >= pg.gameset.joint_boss_fighter_max.key_value
end

function var_0_0.UpdateBossType(arg_14_0, arg_14_1)
	if not arg_14_0:IsSelf() then
		arg_14_0.type = arg_14_1
	end

	return
end

function var_0_0.GetWaitForResultTime(arg_15_0)
	return arg_15_0.killTime
end

function var_0_0.ShouldWaitForResult(arg_16_0)
	local var_16_0 = pg.TimeMgr.GetInstance()

	return var_16_0:GetServerTime() < arg_16_0.killTime
end

function var_0_0.GetRoleName(arg_17_0)
	if arg_17_0.player then
		return arg_17_0.player.name
	else
		return ""
	end

	return
end

function var_0_0.isSameLevel(arg_18_0, arg_18_1)
	return arg_18_0.level == arg_18_1.level
end

function var_0_0.SetBossType(arg_19_0)
	local var_19_9000
	local var_19_0 = getProxy(PlayerProxy)
	local var_19_1 = getProxy(GuildProxy).getRawData(var_19_0)

	if arg_19_0.owner == var_19_0.getRawData(var_19_9000).id then
		return var_0_0.BOSS_TYPE_SELF
	else
		if var_19_1 and var_19_1:getMemberById(arg_19_0.owner) then
			return var_0_0.BOSS_TYPE_GUILD
		end

		if getProxy(FriendProxy):getFriend(arg_19_0.owner) then
			return var_0_0.BOSS_TYPE_FRIEND
		end
	end

	return var_0_0.BOSS_TYPE_WORLD
end

function var_0_0.IsSelf(arg_20_0)
	return arg_20_0.type == var_0_0.BOSS_TYPE_SELF
end

function var_0_0.GetType(arg_21_0)
	return arg_21_0.type
end

function var_0_0.GetStageID(arg_22_0)
	return arg_22_0.config.expedition_id
end

function var_0_0.UpdateHp(arg_23_0, arg_23_1)
	arg_23_0.hp = arg_23_1

	return
end

function var_0_0.GetHP(arg_24_0)
	return arg_24_0.hp
end

function var_0_0.Active(arg_25_0)
	return arg_25_0.id > 0
end

function var_0_0.isDeath(arg_26_0)
	return arg_26_0.hp <= 0
end

function var_0_0.UpdateKillTime(arg_27_0)
	local var_27_0 = nowWorld():GetBossProxy():GetRank(arg_27_0.id)

	if var_27_0 and #var_27_0 > 1 then
		arg_27_0.killTime = pg.TimeMgr.GetInstance():GetServerTime() + pg.gameset.world_boss_rank_wait_time.key_value
	end

	return
end

function var_0_0.GetAwards(arg_28_0)
	if arg_28_0:IsSelf() then
		return arg_28_0.config.drop_show_self
	else
		return arg_28_0.config.drop_show_other
	end

	return
end

function var_0_0.GetLeftTime(arg_29_0)
	return arg_29_0.lastTime - pg.TimeMgr.GetInstance():GetServerTime()
end

function var_0_0.GetMaxHp(arg_30_0)
	return arg_30_0.config.hp
end

function var_0_0.IsFullHp(arg_31_0)
	return arg_31_0.hp >= arg_31_0:GetMaxHp()
end

function var_0_0.GetName(arg_32_0)
	return arg_32_0.config.name
end

function var_0_0.GetLevel(arg_33_0)
	return arg_33_0.level
end

function var_0_0.GetExpiredTime(arg_34_0)
	return arg_34_0.lastTime
end

function var_0_0.IsExpired(arg_35_0)
	return arg_35_0:GetLeftTime() <= 0
end

function var_0_0.BuildTipText(arg_36_0)
	local var_36_0 = arg_36_0:GetRoleName()

	if arg_36_0.type == var_0_0.BOSS_TYPE_FRIEND then
		return i18n("world_joint_call_friend_support_txt", var_36_0, arg_36_0.config.name, arg_36_0.level)
	elseif arg_36_0.type == var_0_0.BOSS_TYPE_GUILD then
		return i18n("world_joint_call_guild_support_txt", var_36_0, arg_36_0.config.name, arg_36_0.level)
	else
		return i18n("world_joint_call_world_support_txt", var_36_0, arg_36_0.config.name, arg_36_0.level)
	end

	return
end

return var_0_0
