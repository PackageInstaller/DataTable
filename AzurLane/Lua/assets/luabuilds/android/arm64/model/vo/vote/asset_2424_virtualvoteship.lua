class = var_0_10000

local var_0_0 = "VirtualVoteShip"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".VoteShip"))

function var_0_1.GenConfigId(arg_1_0, arg_1_1)
	return arg_1_1
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.activity_vote_virtual_ship_data
end

function var_0_1.getRarity(arg_3_0)
	return arg_3_0:getConfig("rarity")
end

function var_0_1.getShipName(arg_4_0)
	return arg_4_0:getConfig("name")
end

function var_0_1.getEnName(arg_5_0)
	return arg_5_0:getConfig("english_name")
end

function var_0_1.getTeamType(arg_6_0)
	ShipType = var_1_10001

	return var_1_10001.GetTeamFromShipType(arg_6_0:getShipType())
end

function var_0_1.getPainting(arg_7_0)
	return arg_7_0:getConfig("painting")
end

function var_0_1.GetDesc(arg_8_0)
	return arg_8_0:getConfig("desc")
end

function var_0_1.getShipType(arg_9_0)
	return ""
end

function var_0_1.getNationality(arg_10_0)
	return nil
end

return var_0_1
