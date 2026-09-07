local BaseGuild = class("BaseGuild", import("...BaseVO"))

function BaseGuild:GetTechnologys()
	assert(false)

	return
end

function BaseGuild:getAddition(arg_2_1)
	return 0 + self:GetTechnologys()[GuildConst.TYPE_TO_GROUP[arg_2_1]]:getAddition()
end

function BaseGuild:getMaxOilAddition()
	return self:getAddition(GuildConst.TYPE_OIL_MAX)
end

function BaseGuild:getMaxGoldAddition()
	return self:getAddition(GuildConst.TYPE_GOLD_MAX)
end

function BaseGuild:getCatBoxGoldAddition()
	return self:getAddition(GuildConst.TYPE_CATBOX_GOLD_COST)
end

function BaseGuild:getEquipmentBagAddition()
	return self:getAddition(GuildConst.TYPE_EQUIPMENT_BAG)
end

function BaseGuild:getShipBagAddition()
	return self:getAddition(GuildConst.TYPE_SHIP_BAG)
end

function BaseGuild:getShipAddition(arg_8_1, arg_8_2)
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in pairs((self:GetTechnologys())) do
		var_8_0 = var_8_0 + iter_8_1:GetShipAttrAddition(arg_8_1, arg_8_2)
	end

	return var_8_0
end

function BaseGuild:GetGuildMemberCntAddition()
	return self:getAddition(GuildConst.TYPE_GUILD_MEMBER_CNT)
end

return BaseGuild
