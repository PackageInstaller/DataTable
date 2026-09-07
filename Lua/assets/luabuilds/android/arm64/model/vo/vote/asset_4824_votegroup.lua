local VoteGroup = class("VoteGroup", import("..BaseVO"))

VoteGroup.VOTE_STAGE = 1
VoteGroup.STTLEMENT_STAGE = 2
VoteGroup.DISPLAY_STAGE = 3

function VoteGroup:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.configId = self.id
	self.list = arg_1_1.list

	self:updateRankMap()

	return
end

function VoteGroup:bindConfigTable()
	return pg.activity_vote
end

function VoteGroup:isResurrectionRace()
	return self:getConfig("type") == VoteConst.RACE_TYPE_RESURGENCE
end

function VoteGroup:isFinalsRace()
	return self:getConfig("type") == VoteConst.RACE_TYPE_FINAL
end

function VoteGroup:IsPrevResurrectionRace()
	return self:getConfig("type") == VoteConst.RACE_TYPE_PRE_RESURGENCE
end

function VoteGroup:IsFunRace()
	return self:getConfig("type") == VoteConst.RACE_TYPE_FUN
end

function VoteGroup:IsFunMetaRace()
	return self:IsFunRace() and self:getConfig("sub_type") == 2
end

function VoteGroup:IsFunSireRace()
	return self:IsFunRace() and self:getConfig("sub_type") == 1
end

function VoteGroup:IsFunKidRace()
	return self:IsFunRace() and self:getConfig("sub_type") == 3
end

function VoteGroup:GetRankMark()
	local var_10_0 = 0
	local var_10_1 = 0

	for iter_10_0, iter_10_1 in ipairs((self:getConfig("rank_to_next"))) do
		if pg.activity_vote[iter_10_1[1]] and (pg.activity_vote[iter_10_1[1]].type == VoteConst.RACE_TYPE_RESURGENCE or pg.activity_vote[iter_10_1[1]].type == VoteConst.RACE_TYPE_PRE_RESURGENCE) then
			var_10_1 = #iter_10_1[2]
		else
			var_10_0 = var_10_0 + #iter_10_1[2]
		end
	end

	return var_10_0, var_10_1
end

function VoteGroup:CanRankToNextTurn(arg_11_1)
	local var_11_0, var_11_1 = self:GetRankMark()

	return arg_11_1 <= var_11_0, var_11_0 < arg_11_1 and arg_11_1 <= var_11_0 + var_11_1
end

function VoteGroup:GetRiseColor(arg_12_1)
	local var_12_0, var_12_1 = self:CanRankToNextTurn(arg_12_1)
	local var_12_2 = self:IsOpening()
	local var_12_3 = COLOR_WHITE

	if not var_12_2 and var_12_0 then
		var_12_3 = "#FEDD6C"
	elseif not var_12_2 and var_12_1 then
		var_12_3 = "#77e4de"
	end

	return var_12_3
end

function VoteGroup:getList()
	return self.list
end

function VoteGroup:UpdateVoteCnt(arg_14_1, arg_14_2)
	for iter_14_0, iter_14_1 in ipairs(self.list) do
		if iter_14_1:isSamaGroup(arg_14_1) then
			iter_14_1:UpdateVoteCnt(arg_14_2)
		end
	end

	self:updateRankMap()

	return
end

function VoteGroup:updateRankMap()
	if self:IsOpening() then
		table.sort(self.list, function(arg_16_0, arg_16_1)
			return arg_16_0:getScore() > arg_16_1:getScore()
		end)
	end

	self.rankMaps = {}

	for iter_15_0, iter_15_1 in ipairs(self.list) do
		self.rankMaps[iter_15_1.group] = iter_15_0
	end

	return
end

function VoteGroup:GetRank(arg_17_1)
	return self.rankMaps[arg_17_1.group] or 0
end

function VoteGroup:GetStage()
	if pg.TimeMgr.GetInstance():inTime((self:getConfig("time_vote"))) then
		return VoteGroup.VOTE_STAGE
	elseif pg.TimeMgr.GetInstance():inTime((self:getConfig("time_vote_client"))) then
		return VoteGroup.STTLEMENT_STAGE
	elseif pg.TimeMgr.GetInstance():inTime((self:getConfig("time_show"))) then
		return VoteGroup.DISPLAY_STAGE
	else
		assert(false)
	end

	return
end

function VoteGroup:IsOpening()
	return self:GetStage() == VoteGroup.VOTE_STAGE
end

function VoteGroup:getTimeDesc()
	return VoteGroup.GetTimeDesc(self:getConfig("time_vote"), self:getConfig("type"))
end

function VoteGroup:GetTimeDesc(arg_21_1)
	return table.concat(self[1][1], ".") .. (arg_21_1 == 1 and i18n("word_maintain") or "(" .. string.format("%02u:%02u", self[1][2][1], self[1][2][2]) .. ")") .. " ~ " .. self[2][1][1] .. "." .. self[2][1][2] .. "." .. self[2][1][3] .. "(" .. string.format("%02u:%02u", self[2][2][1], self[2][2][2]) .. ")"
end

function VoteGroup:GetTimeDesc2(arg_22_1)
	return "<size=21>" .. (table.concat(self[1][1], ".") .. (arg_22_1 == 1 and "<size=18>" .. i18n("word_maintain") .. "</size>" or "(" .. string.format("<size=18>%02u:%02u</size>", self[1][2][1], self[1][2][2]) .. ")") .. " ~ " .. self[2][1][1] .. "." .. self[2][1][2] .. "." .. self[2][1][3] .. "<size=18>(" .. string.format("%02u:%02u", self[2][2][1], self[2][2][2]) .. ")</size>") .. "</size>"
end

function VoteGroup:GetVotes(arg_23_1)
	if self:IsOpening() then
		return arg_23_1:GetGameVotes()
	else
		return arg_23_1:getTotalVotes()
	end

	return
end

function VoteGroup:GetRankList()
	local var_24_0 = {}
	local var_24_1 = {}

	for iter_24_0, iter_24_1 in ipairs((self:getList())) do
		table.insert(var_24_0, iter_24_1)

		var_24_1[iter_24_1.group] = self:GetRank(iter_24_1)
	end

	table.sort(var_24_0, function(arg_25_0, arg_25_1)
		return var_24_1[arg_25_0.group] < var_24_1[arg_25_1.group]
	end)

	return var_24_0
end

return VoteGroup
