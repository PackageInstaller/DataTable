local var_0_0 = class("BaseGuild", import("...BaseVO"))

function var_0_0.GetTechnologys(arg_1_0)
	assert(false)

	return
end

function var_0_0.getAddition(arg_2_0, arg_2_1)
	return 0 + arg_2_0:GetTechnologys()[GuildConst.TYPE_TO_GROUP[arg_2_1]]:getAddition()
end

function var_0_0.getMaxOilAddition(arg_3_0)
	return arg_3_0:getAddition(GuildConst.TYPE_OIL_MAX)
end

function var_0_0.getMaxGoldAddition(arg_4_0)
	return arg_4_0:getAddition(GuildConst.TYPE_GOLD_MAX)
end

function var_0_0.getCatBoxGoldAddition(arg_5_0)
	return arg_5_0:getAddition(GuildConst.TYPE_CATBOX_GOLD_COST)
end

function var_0_0.getEquipmentBagAddition(arg_6_0)
	return arg_6_0:getAddition(GuildConst.TYPE_EQUIPMENT_BAG)
end

function var_0_0.getShipBagAddition(arg_7_0)
	return arg_7_0:getAddition(GuildConst.TYPE_SHIP_BAG)
end

function var_0_0.getShipAddition(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in pairs((arg_8_0:GetTechnologys())) do
		var_8_0 = var_8_0 + iter_8_1:GetShipAttrAddition(arg_8_1, arg_8_2)
	end

	return var_8_0
end

function var_0_0.GetGuildMemberCntAddition(arg_9_0)
	return arg_9_0:getAddition(GuildConst.TYPE_GUILD_MEMBER_CNT)
end

return var_0_0
