local var_0_0 = class("VoteShip", import("..BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.voteId = arg_1_2
	arg_1_0.group = arg_1_1.key
	arg_1_0.totalVotes = arg_1_1.value1
	arg_1_0.votes = arg_1_1.value2
	arg_1_0.netVotes = arg_1_1.value3
	arg_1_0.configId = arg_1_0:GenConfigId(arg_1_0.group)

	assert(arg_1_0.configId)

	return
end

function var_0_0.GenConfigId(arg_2_0, arg_2_1)
	for iter_2_0 = 4, 1, -1 do
		local var_2_0 = tonumber(arg_2_1 .. iter_2_0)

		if pg.ship_data_statistics[var_2_0] then
			return var_2_0
		end
	end

	return
end

function var_0_0.bindConfigTable(arg_3_0)
	return pg.ship_data_statistics
end

function var_0_0.getRarity(arg_4_0)
	return arg_4_0:getConfig("rarity")
end

function var_0_0.getShipName(arg_5_0)
	if arg_5_0.group == 30507 then
		local var_5_0, var_5_1 = i18n("name_zhanliejahe")

		return var_5_0
	end

	return arg_5_0:getConfig("name")
end

function var_0_0.getEnName(arg_6_0)
	return arg_6_0:getConfig("english_name")
end

function var_0_0.getTeamType(arg_7_0)
	return ShipType.GetTeamFromShipType(arg_7_0:getShipType())
end

function var_0_0.getPainting(arg_8_0)
	return pg.ship_skin_template[arg_8_0:getConfig("skin_id")].painting
end

function var_0_0.GetDesc(arg_9_0)
	return ShipWordHelper.RawGetWord(arg_9_0:getConfig("skin_id"), ShipWordHelper.WORD_TYPE_PROFILE)
end

function var_0_0.getShipType(arg_10_0)
	if arg_10_0:IsFunRace() then
		return ""
	else
		return (arg_10_0:getConfig("type"))
	end

	return
end

function var_0_0.getShipTypeName(arg_11_0)
	if arg_11_0:IsFunRace() then
		return ""
	else
		return pg.ship_data_by_type[arg_11_0:getConfig("type")].type_name
	end

	return
end

function var_0_0.IsFunRace(arg_12_0)
	return pg.activity_vote[arg_12_0.voteId].type == VoteConst.RACE_TYPE_FUN
end

function var_0_0.getNationality(arg_13_0)
	if arg_13_0:IsFunRace() then
		return nil
	else
		return arg_13_0:getConfig("nationality")
	end

	return
end

function var_0_0.getNation(arg_14_0)
	return arg_14_0:getNationality()
end

function var_0_0.IsMatchSearchKey(arg_15_0, arg_15_1)
	if not arg_15_1 or arg_15_1 == "" then
		return true
	end

	arg_15_1 = string.lower(string.gsub(arg_15_1, "%.", "%%."))

	return string.find(string.lower(arg_15_0:getShipName()), arg_15_1)
end

function var_0_0.UpdateVoteCnt(arg_16_0, arg_16_1)
	arg_16_0.votes = arg_16_0.votes + arg_16_1

	return
end

function var_0_0.getScore(arg_17_0)
	return arg_17_0.votes
end

function var_0_0.GetTotalScore(arg_18_0)
	return arg_18_0.totalVotes
end

function var_0_0.isSamaGroup(arg_19_0, arg_19_1)
	return arg_19_0.group == arg_19_1
end

function var_0_0.GetGameVotes(arg_20_0)
	if arg_20_0.votes >= 100000 then
		return math.floor(arg_20_0.votes / 1000) .. "K"
	else
		return arg_20_0.votes
	end

	return
end

function var_0_0.getTotalVotes(arg_21_0)
	if arg_21_0.totalVotes >= 100000 then
		return math.floor(arg_21_0.totalVotes / 1000) .. "K"
	else
		return arg_21_0.totalVotes
	end

	return
end

return var_0_0
