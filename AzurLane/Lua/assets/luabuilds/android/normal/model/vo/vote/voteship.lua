class = var_0_10000

local var_0_0 = "VoteShip"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.voteId = arg_1_2
	arg_1_0.group = arg_1_1.key
	arg_1_0.totalVotes = arg_1_1.value1
	arg_1_0.votes = arg_1_1.value2
	arg_1_0.netVotes = arg_1_1.value3
	arg_1_0.configId = arg_1_0:GenConfigId(arg_1_0.group)
	assert = var_3

	var_3(arg_1_0.configId)

	return
end

function var_0_1.GenConfigId(arg_2_0, arg_2_1)
	for iter_2_0 = 4, 1, -1 do
		tonumber = var_1_10006
		var_1_10006 = var_1_10006(arg_2_1 .. iter_2_0)
		pg = var_7

		if var_7.ship_data_statistics[var_1_10006] then
			return var_1_10006
		end
	end

	return
end

function var_0_1.bindConfigTable(arg_3_0)
	pg = var_1_10001

	return var_1_10001.ship_data_statistics
end

function var_0_1.getRarity(arg_4_0)
	return arg_4_0:getConfig("rarity")
end

function var_0_1.getShipName(arg_5_0)
	if arg_5_0.group == 30507 then
		i18n = var_1

		local var_5_0, var_5_1 = var_1("name_zhanliejahe")

		return var_5_0
	end

	return arg_5_0:getConfig("name")
end

function var_0_1.getEnName(arg_6_0)
	return arg_6_0:getConfig("english_name")
end

function var_0_1.getTeamType(arg_7_0)
	ShipType = var_1_10001

	return var_1_10001.GetTeamFromShipType(arg_7_0:getShipType())
end

function var_0_1.getPainting(arg_8_0)
	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.getConfig(var_8_0, "skin_id")

	pg = var_8_0

	return var_8_0.ship_skin_template[var_8_1].painting
end

function var_0_1.GetDesc(arg_9_0)
	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.getConfig(var_9_0, "skin_id")

	ShipWordHelper = var_9_0

	local var_9_2 = var_9_0.RawGetWord
	local var_9_3 = var_9_1

	ShipWordHelper = var_1_10004

	return var_9_2(var_9_3, var_1_10004.WORD_TYPE_PROFILE)
end

function var_0_1.getShipType(arg_10_0)
	if arg_10_0:IsFunRace() then
		return ""
	else
		return (arg_10_0:getConfig("type"))
	end

	return
end

function var_0_1.getShipTypeName(arg_11_0)
	if arg_11_0:IsFunRace() then
		return ""
	else
		local var_11_0 = arg_11_0
		local var_11_1 = arg_11_0.getConfig(var_11_0, "type")

		pg = var_11_0

		return var_11_0.ship_data_by_type[var_11_1].type_name
	end

	return
end

function var_0_1.IsFunRace(arg_12_0)
	pg = var_1_10001

	local var_12_0 = var_1_10001.activity_vote[arg_12_0.voteId].type

	VoteConst = var_2

	return var_12_0 == var_2.RACE_TYPE_FUN
end

function var_0_1.getNationality(arg_13_0)
	if arg_13_0:IsFunRace() then
		return nil
	else
		return arg_13_0:getConfig("nationality")
	end

	return
end

function var_0_1.getNation(arg_14_0)
	return arg_14_0:getNationality()
end

function var_0_1.IsMatchSearchKey(arg_15_0, arg_15_1)
	if not arg_15_1 or arg_15_1 == "" then
		return true
	end

	string = var_1_10002

	local var_15_0 = var_1_10002.lower

	string = var_1_10003
	arg_15_1 = var_15_0(var_1_10003.gsub(arg_15_1, "%.", "%%."))
	string = var_2

	local var_15_1 = var_2.find

	string = var_3

	return var_15_1(var_3.lower(arg_15_0:getShipName()), arg_15_1)
end

function var_0_1.UpdateVoteCnt(arg_16_0, arg_16_1)
	arg_16_0.votes = arg_16_0.votes + arg_16_1

	return
end

function var_0_1.getScore(arg_17_0)
	return arg_17_0.votes
end

function var_0_1.GetTotalScore(arg_18_0)
	return arg_18_0.totalVotes
end

function var_0_1.isSamaGroup(arg_19_0, arg_19_1)
	return arg_19_0.group == arg_19_1
end

function var_0_1.GetGameVotes(arg_20_0)
	if arg_20_0.votes >= 100000 then
		math = var_1

		return var_1.floor(arg_20_0.votes / 1000) .. "K"
	else
		return arg_20_0.votes
	end

	return
end

function var_0_1.getTotalVotes(arg_21_0)
	if arg_21_0.totalVotes >= 100000 then
		math = var_1

		return var_1.floor(arg_21_0.totalVotes / 1000) .. "K"
	else
		return arg_21_0.totalVotes
	end

	return
end

return var_0_1
