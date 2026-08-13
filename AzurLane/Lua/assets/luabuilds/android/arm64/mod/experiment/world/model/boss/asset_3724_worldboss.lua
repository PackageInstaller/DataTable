class = var_0_10000

local var_0_0 = "WorldBoss"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("....BaseEntity"))

var_0_1.Fields = {
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
var_0_1.SUPPORT_TYPE_FRIEND = 1
var_0_1.SUPPORT_TYPE_GUILD = 2
var_0_1.SUPPORT_TYPE_WORLD = 3
var_0_1.BOSS_TYPE_FRIEND = 1
var_0_1.BOSS_TYPE_GUILD = 2
var_0_1.BOSS_TYPE_WORLD = 3
var_0_1.BOSS_TYPE_SELF = 0

function var_0_1.Setup(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_1.template_id
	arg_1_0.hp = arg_1_1.hp
	arg_1_0.level = arg_1_1.lv
	arg_1_0.owner = arg_1_1.owner
	arg_1_0.lastTime = arg_1_1.last_time

	local var_1_0

	if not arg_1_1.kill_time then
		var_1_0 = 0
	end

	arg_1_0.killTime = var_1_0
	arg_1_0.player = arg_1_2
	joinTime = var_1_0
	var_1_0 = var_1_0 or 0
	arg_1_0.joinTime = var_1_0
	pg = var_1_0

	if var_1_0.world_joint_boss_template[arg_1_0.configId] then
		local var_1_1 = var_3.boss_level_id + (arg_1_0.level - 1)

		pg = var_5

		local var_1_2 = var_5.world_boss_level[var_1_1]

		setmetatable = var_1_10006
		arg_1_0.config = var_1_10006({}, {
			__index = function(arg_2_0, arg_2_1)
				local var_2_0

				if not var_0[arg_2_1] then
					var_2_0 = var_1_2[arg_2_1]
				end

				return var_2_0
			end
		})
	end

	local var_1_3

	if not arg_1_1.fight_count then
		var_1_3 = 0
	end

	arg_1_0.fightCount = var_1_3

	local var_1_4

	if not arg_1_1.rank_count then
		var_1_4 = 0
	end

	arg_1_0.rankCount = var_1_4
	arg_1_0.type = arg_1_0:SetBossType()

	return
end

function var_0_1.GetConfigID(arg_3_0)
	return arg_3_0.configId
end

function var_0_1.SetJoinTime(arg_4_0, arg_4_1)
	arg_4_0.joinTime = arg_4_1

	return
end

function var_0_1.GetJoinTime(arg_5_0)
	return arg_5_0.joinTime
end

function var_0_1.GetMetaId(arg_6_0)
	return arg_6_0.config.meta_id
end

function var_0_1.IncreaseFightCnt(arg_7_0)
	arg_7_0.fightCount = arg_7_0.fightCount + 1

	return
end

function var_0_1.GetSelfFightCnt(arg_8_0)
	return arg_8_0.fightCount
end

function var_0_1.GetOilConsume(arg_9_0)
	if not arg_9_0:IsSelf() then
		return 0
	end

	local var_9_0 = arg_9_0.fightCount + 1

	WorldBossConst = var_1_10002

	return var_1_10002.GetBossOilConsume(var_9_0)
end

function var_0_1.SetRankCnt(arg_10_0, arg_10_1)
	arg_10_0.rankCount = arg_10_1

	return
end

function var_0_1.GetRankCnt(arg_11_0)
	return arg_11_0.rankCount
end

function var_0_1.GetPlayer(arg_12_0)
	return arg_12_0.player
end

function var_0_1.IsFullPeople(arg_13_0)
	local var_13_0 = arg_13_0:GetRankCnt()

	pg = var_1_10002

	return var_13_0 >= var_1_10002.gameset.joint_boss_fighter_max.key_value
end

function var_0_1.UpdateBossType(arg_14_0, arg_14_1)
	if not arg_14_0:IsSelf() then
		arg_14_0.type = arg_14_1
	end

	return
end

function var_0_1.GetWaitForResultTime(arg_15_0)
	return arg_15_0.killTime
end

function var_0_1.ShouldWaitForResult(arg_16_0)
	pg = var_1_10001

	local var_16_0 = var_1_10001.TimeMgr.GetInstance()

	return var_1.GetServerTime(var_16_0) < arg_16_0.killTime
end

function var_0_1.GetRoleName(arg_17_0)
	if arg_17_0.player then
		return arg_17_0.player.name
	else
		return ""
	end

	return
end

function var_0_1.isSameLevel(arg_18_0, arg_18_1)
	return arg_18_0.level == arg_18_1.level
end

function var_0_1.SetBossType(arg_19_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_19_0 = var_1_10001(var_1_10003)
	local var_19_1 = var_1.getRawData(var_19_0)

	getProxy = var_1_10002
	FriendProxy = var_1_10004

	local var_19_2 = var_1_10002(var_1_10004)

	getProxy = var_19_0
	GuildProxy = var_1_10005

	local var_19_3 = var_19_0(var_1_10005)
	local var_19_4 = var_3.getRawData(var_19_3)

	if arg_19_0.owner == var_19_1.id then
		return var_0_1.BOSS_TYPE_SELF
	else
		if var_19_4 and var_19_4:getMemberById(arg_19_0.owner) then
			return var_0_1.BOSS_TYPE_GUILD
		end

		if var_19_2:getFriend(arg_19_0.owner) then
			return var_0_1.BOSS_TYPE_FRIEND
		end
	end

	return var_0_1.BOSS_TYPE_WORLD
end

function var_0_1.IsSelf(arg_20_0)
	return arg_20_0.type == var_0_1.BOSS_TYPE_SELF
end

function var_0_1.GetType(arg_21_0)
	return arg_21_0.type
end

function var_0_1.GetStageID(arg_22_0)
	return arg_22_0.config.expedition_id
end

function var_0_1.UpdateHp(arg_23_0, arg_23_1)
	arg_23_0.hp = arg_23_1

	return
end

function var_0_1.GetHP(arg_24_0)
	return arg_24_0.hp
end

function var_0_1.Active(arg_25_0)
	return arg_25_0.id > 0
end

function var_0_1.isDeath(arg_26_0)
	return arg_26_0.hp <= 0
end

function var_0_1.UpdateKillTime(arg_27_0)
	nowWorld = var_1_10001

	local var_27_0 = var_1_10001()
	local var_27_1 = var_1.GetBossProxy(var_27_0)

	if var_2.GetRank(var_27_1, arg_27_0.id) then
		local var_27_2 = #var_2

		if 1 < var_27_2 then
			pg = var_27_2

			local var_27_3 = var_27_2.gameset.world_boss_rank_wait_time.key_value

			pg = var_4

			local var_27_4 = var_4.TimeMgr.GetInstance()

			arg_27_0.killTime = var_4.GetServerTime(var_27_4) + var_27_3
		end
	end

	return
end

function var_0_1.GetAwards(arg_28_0)
	if arg_28_0:IsSelf() then
		return arg_28_0.config.drop_show_self
	else
		return arg_28_0.config.drop_show_other
	end

	return
end

function var_0_1.GetLeftTime(arg_29_0)
	pg = var_1_10001

	local var_29_0 = var_1_10001.TimeMgr.GetInstance()
	local var_29_1 = var_1.GetServerTime(var_29_0)

	return arg_29_0.lastTime - var_29_1
end

function var_0_1.GetMaxHp(arg_30_0)
	return arg_30_0.config.hp
end

function var_0_1.IsFullHp(arg_31_0)
	return arg_31_0.hp >= arg_31_0:GetMaxHp()
end

function var_0_1.GetName(arg_32_0)
	return arg_32_0.config.name
end

function var_0_1.GetLevel(arg_33_0)
	return arg_33_0.level
end

function var_0_1.GetExpiredTime(arg_34_0)
	return arg_34_0.lastTime
end

function var_0_1.IsExpired(arg_35_0)
	return arg_35_0:GetLeftTime() <= 0
end

function var_0_1.BuildTipText(arg_36_0)
	local var_36_0 = arg_36_0:GetRoleName()
	local var_36_1 = arg_36_0.config.name
	local var_36_2 = arg_36_0.level

	if arg_36_0.type == var_0_1.BOSS_TYPE_FRIEND then
		i18n = var_4

		return var_4("world_joint_call_friend_support_txt", var_36_0, var_36_1, var_36_2)
	elseif arg_36_0.type == var_0_1.BOSS_TYPE_GUILD then
		i18n = var_4

		return var_4("world_joint_call_guild_support_txt", var_36_0, var_36_1, var_36_2)
	else
		i18n = var_4

		return var_4("world_joint_call_world_support_txt", var_36_0, var_36_1, var_36_2)
	end

	return
end

return var_0_1
