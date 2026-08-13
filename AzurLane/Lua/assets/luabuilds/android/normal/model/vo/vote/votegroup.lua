class = var_0_10000

local var_0_0 = "VoteGroup"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BaseVO"))

var_0_1.VOTE_STAGE = 1
var_0_1.STTLEMENT_STAGE = 2
var_0_1.DISPLAY_STAGE = 3

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.list = arg_1_1.list

	arg_1_0:updateRankMap()

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.activity_vote
end

function var_0_1.isResurrectionRace(arg_3_0)
	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.getConfig(var_3_0, "type")

	VoteConst = var_3_0

	return var_3_1 == var_3_0.RACE_TYPE_RESURGENCE
end

function var_0_1.isFinalsRace(arg_4_0)
	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.getConfig(var_4_0, "type")

	VoteConst = var_4_0

	return var_4_1 == var_4_0.RACE_TYPE_FINAL
end

function var_0_1.IsPrevResurrectionRace(arg_5_0)
	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.getConfig(var_5_0, "type")

	VoteConst = var_5_0

	return var_5_1 == var_5_0.RACE_TYPE_PRE_RESURGENCE
end

function var_0_1.IsFunRace(arg_6_0)
	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.getConfig(var_6_0, "type")

	VoteConst = var_6_0

	return var_6_1 == var_6_0.RACE_TYPE_FUN
end

function var_0_1.IsFunMetaRace(arg_7_0)
	local var_7_0

	if arg_7_0:IsFunRace() then
		var_7_0 = arg_7_0:getConfig("sub_type") == 2
	end

	return var_7_0
end

function var_0_1.IsFunSireRace(arg_8_0)
	local var_8_0

	if arg_8_0:IsFunRace() then
		var_8_0 = arg_8_0:getConfig("sub_type") == 1
	end

	return var_8_0
end

function var_0_1.IsFunKidRace(arg_9_0)
	local var_9_0

	if arg_9_0:IsFunRace() then
		var_9_0 = arg_9_0:getConfig("sub_type") == 3
	end

	return var_9_0
end

function var_0_1.GetRankMark(arg_10_0)
	local var_10_0 = 0
	local var_10_1 = 0
	local var_10_2 = arg_10_0
	local var_10_3 = arg_10_0.getConfig(var_10_2, "rank_to_next")

	ipairs = var_10_2

	for iter_10_0, iter_10_1 in var_10_2(var_10_3) do
		local var_10_4 = iter_10_1[1]
		local var_10_5 = iter_10_1[2]

		pg = var_1_10011

		if var_1_10011.activity_vote[var_10_4] then
			local var_10_6 = var_1_10011.type

			VoteConst = var_1_10013

			if var_10_6 ~= var_1_10013.RACE_TYPE_RESURGENCE then
				local var_10_7 = var_1_10011.type

				VoteConst = var_1_10013

				if var_10_7 == var_1_10013.RACE_TYPE_PRE_RESURGENCE then
					var_10_1 = #var_10_5

					goto label_10_0
				end

				var_10_0 = var_10_0 + #var_10_5

				::label_10_0::
			end
		end
	end

	return var_10_0, var_10_1
end

function var_0_1.CanRankToNextTurn(arg_11_0, arg_11_1)
	local var_11_0, var_11_1 = arg_11_0:GetRankMark()
	local var_11_2 = arg_11_1 <= var_11_0
	local var_11_3 = var_11_0 < arg_11_1 and arg_11_1 <= var_11_0 + var_11_1

	return var_11_2, var_11_3
end

function var_0_1.GetRiseColor(arg_12_0, arg_12_1)
	local var_12_0, var_12_1 = arg_12_0:CanRankToNextTurn(arg_12_1)
	local var_12_2 = arg_12_0
	local var_12_3 = arg_12_0.IsOpening(var_12_2)

	COLOR_WHITE = var_12_2

	if not var_12_3 and var_12_0 then
		var_12_2 = "#FEDD6C"
	elseif not var_12_3 and var_12_1 then
		var_12_2 = "#77e4de"
	end

	return var_12_2
end

function var_0_1.getList(arg_13_0)
	return arg_13_0.list
end

function var_0_1.UpdateVoteCnt(arg_14_0, arg_14_1, arg_14_2)
	ipairs = var_1_10003

	for iter_14_0, iter_14_1 in var_1_10003(arg_14_0.list) do
		if iter_14_1:isSamaGroup(arg_14_1) then
			iter_14_1:UpdateVoteCnt(arg_14_2)
		end
	end

	arg_14_0:updateRankMap()

	return
end

function var_0_1.updateRankMap(arg_15_0)
	local var_15_0 = arg_15_0

	if arg_15_0.IsOpening(var_15_0) then
		table = var_15_0

		var_15_0.sort(arg_15_0.list, function(arg_16_0, arg_16_1)
			return arg_16_0:getScore() > arg_16_1:getScore()
		end)
	end

	arg_15_0.rankMaps = {}
	ipairs = var_2

	for iter_15_0, iter_15_1 in var_2(arg_15_0.list) do
		arg_15_0.rankMaps[iter_15_1.group] = iter_15_0
	end

	return
end

function var_0_1.GetRank(arg_17_0, arg_17_1)
	local var_17_0

	if not arg_17_0.rankMaps[arg_17_1.group] then
		var_17_0 = 0
	end

	return var_17_0
end

function var_0_1.GetStage(arg_18_0)
	local var_18_0 = arg_18_0:getConfig("time_vote")
	local var_18_1 = arg_18_0:getConfig("time_vote_client")
	local var_18_2 = arg_18_0
	local var_18_3 = arg_18_0.getConfig(var_18_2, "time_show")

	pg = var_18_2

	local var_18_4 = var_18_2.TimeMgr.GetInstance()

	if var_4.inTime(var_18_4, var_18_0) then
		return var_0_1.VOTE_STAGE
	else
		pg = var_4

		local var_18_5 = var_4.TimeMgr.GetInstance()

		if var_4.inTime(var_18_5, var_18_1) then
			return var_0_1.STTLEMENT_STAGE
		else
			pg = var_4

			local var_18_6 = var_4.TimeMgr.GetInstance()

			if var_4.inTime(var_18_6, var_18_3) then
				return var_0_1.DISPLAY_STAGE
			else
				assert = var_4

				var_4(false)
			end
		end
	end

	return
end

function var_0_1.IsOpening(arg_19_0)
	return arg_19_0:GetStage() == var_0_1.VOTE_STAGE
end

function var_0_1.getTimeDesc(arg_20_0)
	local var_20_0 = arg_20_0:getConfig("time_vote")

	return var_0_1.GetTimeDesc(var_20_0, arg_20_0:getConfig("type"))
end

function var_0_1.GetTimeDesc(arg_21_0, arg_21_1)
	table = var_1_10002

	local var_21_0 = var_1_10002.concat(arg_21_0[1][1], ".")

	if arg_21_1 == 1 then
		i18n = var_21_1

		local var_21_1

		if not var_21_1("word_maintain") then
			var_21_1 = "("
			string = var_4
			var_21_1 = var_21_1 .. var_4.format("%02u:%02u", arg_21_0[1][2][1], arg_21_0[1][2][2]) .. ")"
		end

		local var_21_2 = " ~ "
		local var_21_3 = arg_21_0[2][1][1]
		local var_21_4 = "."
		local var_21_5 = arg_21_0[2][1][2]
		local var_21_6 = "."
		local var_21_7 = arg_21_0[2][1][3]
		local var_21_8 = "("

		string = var_1_10011

		return var_21_0 .. var_21_1 .. var_21_2 .. var_21_3 .. var_21_4 .. var_21_5 .. var_21_6 .. var_21_7 .. var_21_8 .. var_1_10011.format("%02u:%02u", arg_21_0[2][2][1], arg_21_0[2][2][2]) .. ")"
	end
end

function var_0_1.GetTimeDesc2(arg_22_0, arg_22_1)
	table = var_1_10002

	local var_22_0 = var_1_10002.concat(arg_22_0[1][1], ".")

	if arg_22_1 == 1 then
		local var_22_1 = "<size=18>"

		i18n = var_4

		if not (var_22_1 .. var_4("word_maintain") .. "</size>") then
			var_22_1 = "("
			string = var_4
			var_22_1 = var_22_1 .. var_4.format("<size=18>%02u:%02u</size>", arg_22_0[1][2][1], arg_22_0[1][2][2]) .. ")"
		end

		local var_22_2 = " ~ "
		local var_22_3 = arg_22_0[2][1][1]
		local var_22_4 = "."
		local var_22_5 = arg_22_0[2][1][2]
		local var_22_6 = "."
		local var_22_7 = arg_22_0[2][1][3]
		local var_22_8 = "<size=18>("

		string = var_1_10011

		local var_22_9 = var_22_0 .. var_22_1 .. var_22_2 .. var_22_3 .. var_22_4 .. var_22_5 .. var_22_6 .. var_22_7 .. var_22_8 .. var_1_10011.format("%02u:%02u", arg_22_0[2][2][1], arg_22_0[2][2][2]) .. ")</size>"

		return "<size=21>" .. var_22_9 .. "</size>"
	end
end

function var_0_1.GetVotes(arg_23_0, arg_23_1)
	if arg_23_0:IsOpening() then
		return arg_23_1:GetGameVotes()
	else
		return arg_23_1:getTotalVotes()
	end

	return
end

function var_0_1.GetRankList(arg_24_0)
	local var_24_0 = arg_24_0:getList()
	local var_24_1 = {}
	local var_24_2 = {}

	ipairs = var_1_10004

	for iter_24_0, iter_24_1 in var_1_10004(var_24_0) do
		table = var_1_10009

		var_1_10009.insert(var_24_1, iter_24_1)

		var_24_2[iter_24_1.group] = arg_24_0:GetRank(iter_24_1)
	end

	table = var_4

	var_4.sort(var_24_1, function(arg_25_0, arg_25_1)
		return var_24_2[arg_25_0.group] < var_24_2[arg_25_1.group]
	end)

	return var_24_1
end

return var_0_1
