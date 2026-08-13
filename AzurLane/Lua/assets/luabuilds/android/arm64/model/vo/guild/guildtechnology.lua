class = var_0_10000

local var_0_0 = "GuildTechnology"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..BaseVO"))

var_0_1.UPGRADE_TYPE_SELF = 1
var_0_1.UPGRADE_TYPE_PUBLIC = 2

function var_0_1.Ctor(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0:bindConfigTable().get_id_list_by_group[arg_1_1.id][1]

	arg_1_0:Update(var_1_0, arg_1_1)

	return
end

function var_0_1.Update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.group = arg_2_2

	local var_2_0 = arg_2_0.group

	if var_3.GuildMemberCntType(var_2_0) then
		arg_2_0.id = arg_2_0.group.pid
	else
		arg_2_0.id = arg_2_1
	end

	arg_2_0.configId = arg_2_0.id
	arg_2_0.level = arg_2_0:getConfig("level")

	return
end

function var_0_1.GetShipAttrAddition(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0:getConfig("effect_args")[1]
	local var_3_1 = var_3[2]

	if var_3_0 == arg_3_1 then
		table = var_6

		if var_6.contains(var_3_1, arg_3_2) then
			do return arg_3_0:getConfig("num") end

			goto label_3_0
		end
	end

	do return 0 end

	::label_3_0::

	return
end

function var_0_1.GetTargetLivness(arg_4_0)
	if arg_4_0:GetNextLevelId() == 0 then
		return 0
	else
		pg = var_1_10002

		return var_1_10002.guild_technology_template[var_1].need_guild_active
	end

	return
end

function var_0_1.ReachTargetLiveness(arg_5_0, arg_5_1)
	return arg_5_1:GetLiveness() >= arg_5_0:GetTargetLivness()
end

function var_0_1._ReachTargetLiveness_(arg_6_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_6_0 = var_1_10001(var_1_10003)
	local var_6_1 = var_1.getRawData(var_6_0).id

	getProxy = var_1_10002
	GuildProxy = var_1_10004

	local var_6_2 = var_1_10002(var_1_10004)
	local var_6_3 = var_2.getRawData(var_6_2)
	local var_6_4 = var_2.getMemberById(var_6_3, var_6_1)

	return arg_6_0:ReachTargetLiveness(var_6_4)
end

function var_0_1.levelUp(arg_7_0)
	if arg_7_0:GetNextLevelId() ~= 0 then
		arg_7_0:Update(var_1, arg_7_0.group)
	end

	return
end

function var_0_1.GetNextLevelId(arg_8_0)
	return arg_8_0:getConfig("next_tech")
end

function var_0_1.GetLevel(arg_9_0)
	return arg_9_0.level
end

function var_0_1.isMaxLevel(arg_10_0)
	return arg_10_0:GetLevel() >= arg_10_0:GetMaxLevel()
end

function var_0_1.CanUpgradeBySelf(arg_11_0)
	local var_11_0 = arg_11_0:_ReachTargetLiveness_()
	local var_11_1 = arg_11_0:GetLevel() < arg_11_0:GetMaxLevel()

	return var_11_0 and var_11_1, var_11_0, var_11_1
end

function var_0_1.GetLivenessOffset(arg_12_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_12_0 = var_1_10001(var_1_10003)
	local var_12_1 = var_1.getRawData(var_12_0).id

	getProxy = var_1_10002
	GuildProxy = var_1_10004

	local var_12_2 = var_1_10002(var_1_10004)
	local var_12_3 = var_2.getRawData(var_12_2)
	local var_12_4 = var_2.getMemberById(var_12_3, var_12_1)

	return arg_12_0:GetTargetLivness() - var_12_4:GetLiveness()
end

function var_0_1.GetUpgradeType(arg_13_0)
	if arg_13_0:CanUpgradeBySelf() then
		return var_0_1.UPGRADE_TYPE_SELF
	else
		local var_13_0 = arg_13_0.group
		local var_13_1 = var_1.GetFakeLevel(var_13_0)
		local var_13_2 = arg_13_0:GetMaxLevel()

		if var_13_1 > arg_13_0:GetLevel() then
			return var_0_1.UPGRADE_TYPE_PUBLIC
		end
	end

	return false
end

function var_0_1.CanUpgrade(arg_14_0)
	return arg_14_0:GetUpgradeType() ~= false
end

function var_0_1.GetMaxLevel(arg_15_0)
	local var_15_0 = arg_15_0.group

	return var_1.GetLevel(var_15_0)
end

function var_0_1.bindConfigTable(arg_16_0)
	pg = var_1_10001

	return var_1_10001.guild_technology_template
end

function var_0_1.GetDesc(arg_17_0)
	local var_17_0 = arg_17_0
	local var_17_1 = arg_17_0.getConfig(var_17_0, "effect_args")
	local var_17_2 = arg_17_0:getConfig("num")

	GuildConst = var_17_0

	return var_17_0.GET_TECHNOLOGY_DESC(var_17_1, var_17_2)
end

function var_0_1.getAddition(arg_18_0)
	if arg_18_0:GetLevel() > 0 then
		return arg_18_0:getConfig("num")
	else
		return 0
	end

	return
end

function var_0_1.GetConsume(arg_19_0)
	local var_19_0 = arg_19_0:getConfig("contribution_consume")
	local var_19_1 = arg_19_0:getConfig("gold_consume")

	if arg_19_0:IsRiseInPrice() then
		return var_19_0 * arg_19_0:getConfig("contribution_multiple"), var_19_1 * var_3
	else
		return var_19_0, var_19_1
	end

	return
end

function var_0_1.IsRiseInPrice(arg_20_0)
	return arg_20_0:GetUpgradeType() == var_0_1.UPGRADE_TYPE_PUBLIC
end

function var_0_1.IsGuildMember(arg_21_0)
	return arg_21_0:getConfig("group") == 1
end

return var_0_1
