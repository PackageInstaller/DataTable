local VoteShip = class("VoteShip", import("..BaseVO"))

function VoteShip:Ctor(arg_1_1, arg_1_2)
	self.voteId = arg_1_2
	self.group = arg_1_1.key
	self.totalVotes = arg_1_1.value1
	self.votes = arg_1_1.value2
	self.netVotes = arg_1_1.value3
	self.configId = self:GenConfigId(self.group)

	assert(self.configId)

	return
end

function VoteShip:GenConfigId(arg_2_1)
	for iter_2_0 = 4, 1, -1 do
		local var_2_0 = tonumber(arg_2_1 .. iter_2_0)

		if pg.ship_data_statistics[var_2_0] then
			return var_2_0
		end
	end

	return
end

function VoteShip:bindConfigTable()
	return pg.ship_data_statistics
end

function VoteShip:getRarity()
	return self:getConfig("rarity")
end

function VoteShip:getShipName()
	if self.group == 30507 then
		local var_5_0, var_5_1 = i18n("name_zhanliejahe")

		return var_5_0
	end

	return self:getConfig("name")
end

function VoteShip:getEnName()
	return self:getConfig("english_name")
end

function VoteShip:getTeamType()
	return ShipType.GetTeamFromShipType(self:getShipType())
end

function VoteShip:getPainting()
	return pg.ship_skin_template[self:getConfig("skin_id")].painting
end

function VoteShip:GetDesc()
	return ShipWordHelper.RawGetWord(self:getConfig("skin_id"), ShipWordHelper.WORD_TYPE_PROFILE)
end

function VoteShip:getShipType()
	if self:IsFunRace() then
		return ""
	else
		return (self:getConfig("type"))
	end

	return
end

function VoteShip:getShipTypeName()
	if self:IsFunRace() then
		return ""
	else
		return pg.ship_data_by_type[self:getConfig("type")].type_name
	end

	return
end

function VoteShip:IsFunRace()
	return pg.activity_vote[self.voteId].type == VoteConst.RACE_TYPE_FUN
end

function VoteShip:getNationality()
	if self:IsFunRace() then
		return nil
	else
		return self:getConfig("nationality")
	end

	return
end

function VoteShip:getNation()
	return self:getNationality()
end

function VoteShip:IsMatchSearchKey(arg_15_1)
	if not arg_15_1 or arg_15_1 == "" then
		return true
	end

	arg_15_1 = string.lower(string.gsub(arg_15_1, "%.", "%%."))

	return string.find(string.lower(self:getShipName()), arg_15_1)
end

function VoteShip:UpdateVoteCnt(arg_16_1)
	self.votes = self.votes + arg_16_1

	return
end

function VoteShip:getScore()
	return self.votes
end

function VoteShip:GetTotalScore()
	return self.totalVotes
end

function VoteShip:isSamaGroup(arg_19_1)
	return self.group == arg_19_1
end

function VoteShip:GetGameVotes()
	if self.votes >= 100000 then
		return math.floor(self.votes / 1000) .. "K"
	else
		return self.votes
	end

	return
end

function VoteShip:getTotalVotes()
	if self.totalVotes >= 100000 then
		return math.floor(self.totalVotes / 1000) .. "K"
	else
		return self.totalVotes
	end

	return
end

return VoteShip
