class = var_0_10000

local var_0_0 = "BaseGuild"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...BaseVO"))

function var_0_1.GetTechnologys(arg_1_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_1.getAddition(arg_2_0, arg_2_1)
	local var_2_0 = 0

	GuildConst = var_1_10003

	local var_2_1 = var_1_10003.TYPE_TO_GROUP[arg_2_1]
	local var_2_2 = arg_2_0:GetTechnologys()[var_2_1]

	return var_2_0 + var_5.getAddition(var_2_2)
end

function var_0_1.getMaxOilAddition(arg_3_0)
	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.getAddition

	GuildConst = var_1_10004

	return var_3_1(var_3_0, var_1_10004.TYPE_OIL_MAX)
end

function var_0_1.getMaxGoldAddition(arg_4_0)
	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.getAddition

	GuildConst = var_1_10004

	return var_4_1(var_4_0, var_1_10004.TYPE_GOLD_MAX)
end

function var_0_1.getCatBoxGoldAddition(arg_5_0)
	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.getAddition

	GuildConst = var_1_10004

	return var_5_1(var_5_0, var_1_10004.TYPE_CATBOX_GOLD_COST)
end

function var_0_1.getEquipmentBagAddition(arg_6_0)
	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.getAddition

	GuildConst = var_1_10004

	return var_6_1(var_6_0, var_1_10004.TYPE_EQUIPMENT_BAG)
end

function var_0_1.getShipBagAddition(arg_7_0)
	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.getAddition

	GuildConst = var_1_10004

	return var_7_1(var_7_0, var_1_10004.TYPE_SHIP_BAG)
end

function var_0_1.getShipAddition(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = 0
	local var_8_1 = arg_8_0:GetTechnologys()

	pairs = var_1_10005

	for iter_8_0, iter_8_1 in var_1_10005(var_8_1) do
		var_8_0 = var_8_0 + iter_8_1:GetShipAttrAddition(arg_8_1, arg_8_2)
	end

	return var_8_0
end

function var_0_1.GetGuildMemberCntAddition(arg_9_0)
	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.getAddition

	GuildConst = var_1_10004

	return var_9_1(var_9_0, var_1_10004.TYPE_GUILD_MEMBER_CNT)
end

return var_0_1
