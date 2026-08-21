local var_0_0 = class("VirtualVoteShip", import(".VoteShip"))

function var_0_0.GenConfigId(arg_1_0, arg_1_1)
	return arg_1_1
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.activity_vote_virtual_ship_data
end

function var_0_0.getRarity(arg_3_0)
	return arg_3_0:getConfig("rarity")
end

function var_0_0.getShipName(arg_4_0)
	return arg_4_0:getConfig("name")
end

function var_0_0.getEnName(arg_5_0)
	return arg_5_0:getConfig("english_name")
end

function var_0_0.getTeamType(arg_6_0)
	return ShipType.GetTeamFromShipType(arg_6_0:getShipType())
end

function var_0_0.getPainting(arg_7_0)
	return arg_7_0:getConfig("painting")
end

function var_0_0.GetDesc(arg_8_0)
	return arg_8_0:getConfig("desc")
end

function var_0_0.getShipType(arg_9_0)
	return ""
end

function var_0_0.getNationality(arg_10_0)
	return nil
end

return var_0_0
