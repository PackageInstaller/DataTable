local var_0_0 = class("VoteGroup", import("..BaseVO"))

var_0_0.VOTE_STAGE = 1
var_0_0.STTLEMENT_STAGE = 2
var_0_0.DISPLAY_STAGE = 3

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.list = arg_1_1.list

	arg_1_0:updateRankMap()

	return
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.activity_vote
end

function var_0_0.isResurrectionRace(arg_3_0)
	return arg_3_0:getConfig("type") == VoteConst.RACE_TYPE_RESURGENCE
end

function var_0_0.isFinalsRace(arg_4_0)
	return arg_4_0:getConfig("type") == VoteConst.RACE_TYPE_FINAL
end

function var_0_0.IsPrevResurrectionRace(arg_5_0)
	return arg_5_0:getConfig("type") == VoteConst.RACE_TYPE_PRE_RESURGENCE
end

function var_0_0.IsFunRace(arg_6_0)
	return arg_6_0:getConfig("type") == VoteConst.RACE_TYPE_FUN
end

function var_0_0.IsFunMetaRace(arg_7_0)
	return arg_7_0:IsFunRace() and arg_7_0:getConfig("sub_type") == 2
end

function var_0_0.IsFunSireRace(arg_8_0)
	return arg_8_0:IsFunRace() and arg_8_0:getConfig("sub_type") == 1
end

function var_0_0.IsFunKidRace(arg_9_0)
	return arg_9_0:IsFunRace() and arg_9_0:getConfig("sub_type") == 3
end

function var_0_0.GetRankMark(arg_10_0)
	local var_10_0 = 0
	local var_10_1 = 0

	for iter_10_0, iter_10_1 in ipairs((arg_10_0:getConfig("rank_to_next"))) do
		if pg.activity_vote[iter_10_1[1]] and (pg.activity_vote[iter_10_1[1]].type == VoteConst.RACE_TYPE_RESURGENCE or pg.activity_vote[iter_10_1[1]].type == VoteConst.RACE_TYPE_PRE_RESURGENCE) then
			var_10_1 = #iter_10_1[2]
		else
			var_10_0 = var_10_0 + #iter_10_1[2]
		end
	end

	return var_10_0, var_10_1
end

function var_0_0.CanRankToNextTurn(arg_11_0, arg_11_1)
	local var_11_0, var_11_1 = arg_11_0:GetRankMark()

	return arg_11_1 <= var_11_0, var_11_0 < arg_11_1 and arg_11_1 <= var_11_0 + var_11_1
end

function var_0_0.GetRiseColor(arg_12_0, arg_12_1)
	local var_12_0, var_12_1 = arg_12_0:CanRankToNextTurn(arg_12_1)
	local var_12_2 = arg_12_0:IsOpening()
	local var_12_3 = COLOR_WHITE

	if not var_12_2 and var_12_0 then
		var_12_3 = "#FEDD6C"
	elseif not var_12_2 and var_12_1 then
		var_12_3 = "#77e4de"
	end

	return var_12_3
end

function var_0_0.getList(arg_13_0)
	return arg_13_0.list
end

function var_0_0.UpdateVoteCnt(arg_14_0, arg_14_1, arg_14_2)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0.list) do
		if iter_14_1:isSamaGroup(arg_14_1) then
			iter_14_1:UpdateVoteCnt(arg_14_2)
		end
	end

	arg_14_0:updateRankMap()

	return
end

function var_0_0.updateRankMap(arg_15_0)
	if arg_15_0:IsOpening() then
		table.sort(arg_15_0.list, function(arg_16_0, arg_16_1)
			return arg_16_0:getScore() > arg_16_1:getScore()
		end)
	end

	arg_15_0.rankMaps = {}

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.list) do
		arg_15_0.rankMaps[iter_15_1.group] = iter_15_0
	end

	return
end

function var_0_0.GetRank(arg_17_0, arg_17_1)
	return arg_17_0.rankMaps[arg_17_1.group] or 0
end

function var_0_0.GetStage(arg_18_0)
	if pg.TimeMgr.GetInstance():inTime((arg_18_0:getConfig("time_vote"))) then
		return var_0_0.VOTE_STAGE
	else
		local var_18_0 = pg.TimeMgr.GetInstance()

		if var_18_0:inTime((arg_18_0:getConfig("time_vote_client"))) then
			return var_0_0.STTLEMENT_STAGE
		else
			local var_18_1 = pg.TimeMgr.GetInstance()

			if var_18_1:inTime((arg_18_0:getConfig("time_show"))) then
				return var_0_0.DISPLAY_STAGE
			else
				assert(false)
			end
		end
	end

	return
end

function var_0_0.IsOpening(arg_19_0)
	return arg_19_0:GetStage() == var_0_0.VOTE_STAGE
end

function var_0_0.getTimeDesc(arg_20_0)
	return var_0_0.GetTimeDesc(arg_20_0:getConfig("time_vote"), arg_20_0:getConfig("type"))
end

function var_0_0.GetTimeDesc(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1 == 1 and i18n("word_maintain") or "(" .. string.format("%02u:%02u", arg_21_0[1][2][1], arg_21_0[1][2][2]) .. ")"

	return table.concat(arg_21_0[1][1], ".") .. var_21_0 .. " ~ " .. arg_21_0[2][1][1] .. "." .. arg_21_0[2][1][2] .. "." .. arg_21_0[2][1][3] .. "(" .. string.format("%02u:%02u", arg_21_0[2][2][1], arg_21_0[2][2][2]) .. ")"
end

function var_0_0.GetTimeDesc2(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_1 == 1 and "<size=18>" .. i18n("word_maintain") .. "</size>" or "(" .. string.format("<size=18>%02u:%02u</size>", arg_22_0[1][2][1], arg_22_0[1][2][2]) .. ")"

	return "<size=21>" .. (table.concat(arg_22_0[1][1], ".") .. var_22_0 .. " ~ " .. arg_22_0[2][1][1] .. "." .. arg_22_0[2][1][2] .. "." .. arg_22_0[2][1][3] .. "<size=18>(" .. string.format("%02u:%02u", arg_22_0[2][2][1], arg_22_0[2][2][2]) .. ")</size>") .. "</size>"
end

function var_0_0.GetVotes(arg_23_0, arg_23_1)
	if arg_23_0:IsOpening() then
		return arg_23_1:GetGameVotes()
	else
		return arg_23_1:getTotalVotes()
	end

	return
end

function var_0_0.GetRankList(arg_24_0)
	local var_24_0 = {}

	for iter_24_0, iter_24_1 in ipairs((arg_24_0:getList())) do
		table.insert({}, iter_24_1)

		;({})[iter_24_1.group] = arg_24_0:GetRank(iter_24_1)
	end

	table.sort({}, function(arg_25_0, arg_25_1)
		return var_24_0[arg_25_0.group] < var_24_0[arg_25_1.group]
	end)

	return {}
end

return var_0_0
