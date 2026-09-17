local var_0_0 = {}

var_0_0.instance = nil

local EventManager = require("common.EventManager")
local Utility = require("common.Utility")

var_0_0.FIGHT_TYPE = {
	PVE = 1,
	PVP = 2
}
var_0_0.PVP_TYPE = {
	VERSUS = "3v3",
	SCORE = "scorearena",
	ARENA = "arena"
}
var_0_0.RANK_TYPE = Utility:enumeration({
	"NORMAL",
	"ARENA",
	"SCORE",
	"VERSUS"
})

local var_0_3 = {
	[var_0_0.PVP_TYPE.ARENA] = var_0_0.RANK_TYPE.ARENA,
	[var_0_0.PVP_TYPE.SCORE] = var_0_0.RANK_TYPE.SCORE,
	[var_0_0.PVP_TYPE.VERSUS] = var_0_0.RANK_TYPE.VERSUS
}

var_0_0.RANK_TYPE_SET = var_0_3

function var_0_0.new(arg_1_0, ...)
	local var_1_0 = {}

	setmetatable(var_1_0, arg_1_0)

	arg_1_0.__index = arg_1_0

	var_1_0:init(...)

	return var_1_0
end

function var_0_0.getInstance()
	var_0_0.instance = var_0_0.instance or var_0_0:new()

	return var_0_0.instance
end

function var_0_0.destroyInstance()
	var_0_0.instance = nil
end

function var_0_0.init(arg_4_0, ...)
	arg_4_0.normalRanks = {}
	arg_4_0.arenaRanks = {}
	arg_4_0.scoreRanks = {}
	arg_4_0.versusRanks = {}
	arg_4_0.currentIndex = 0
	arg_4_0.totalCount = 0
	arg_4_0.requestCount = 100
	arg_4_0.rankType = var_0_0.RANK_TYPE.NORMAL
	arg_4_0.indexs = {}
	arg_4_0.appearTimes = {}
	arg_4_0.uniqueIndex = ""
end

function var_0_0:requestGetServantRank(arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6)
	arg_5_6 = arg_5_6 or self.requestCount
	arg_5_2 = arg_5_2 or 0
	arg_5_3 = arg_5_3 or 0

	local var_5_0 = var_0_0.RANK_TYPE.NORMAL

	if arg_5_1 == var_0_0.FIGHT_TYPE.PVP then
		var_5_0 = var_0_3[arg_5_4]
	end

	if self.uniqueIndex ~= "" .. arg_5_1 .. arg_5_2 .. arg_5_3 or self.rankType ~= var_5_0 then
		self.currentIndex = arg_5_5 or 0
	end

	self.uniqueIndex = "" .. arg_5_1 .. arg_5_2 .. arg_5_3
	self.rankType = var_5_0

	EventManager:requestGetServantRank(arg_5_1, arg_5_2, arg_5_3, arg_5_4, self.currentIndex, arg_5_6)
end

function var_0_0:updateRankDatas(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if arg_6_1 ~= self.rankType then
		return
	end

	local var_6_0 = self:getRankDatas(arg_6_1, arg_6_3, arg_6_4)

	if #var_6_0 == 0 then
		self.appearTimes[arg_6_1] = #arg_6_2 > 0 and arg_6_2[1].score or 1
	end

	for iter_6_0, iter_6_1 in ipairs(arg_6_2) do
		var_6_0[self.currentIndex + 1] = {
			servantId = iter_6_1.servantid,
			horcruxId = iter_6_1.horcurxid,
			score = math.floor(iter_6_1.score / self.appearTimes[arg_6_1] * 9999),
			teammates = {},
			rank = self.currentIndex + 1
		}
		self.currentIndex = self.currentIndex + 1
	end

	self.indexs[arg_6_1] = self.currentIndex
end

function var_0_0:updateBestTeamates(arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = self:getRankDatas(arg_7_1)
	local var_7_1 = self:queryRankDataByServantId(arg_7_2)

	if not var_7_1 then
		return
	end

	var_7_1.teammates = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_3) do
		var_7_1.teammates[#var_7_1.teamIndex + 1] = iter_7_1
	end
end

function var_0_0.queryRankDataByServantId(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = Utility:indexOf(arg_8_1, function(arg_9_0)
		return arg_9_0.servantId == arg_8_2
	end)

	if var_8_0 < 0 then
		print("unknown servantId: ", arg_8_2)

		return nil
	end

	return arg_8_1[var_8_0]
end

function var_0_0:getRankDatas(arg_10_1, arg_10_2, arg_10_3)
	if arg_10_1 == var_0_0.RANK_TYPE.NORMAL then
		return self:getNormalRankDatas(arg_10_2, arg_10_3)
	elseif arg_10_1 == var_0_0.RANK_TYPE.ARENA then
		return self.arenaRanks
	elseif arg_10_1 == var_0_0.RANK_TYPE.SCORE then
		return self.scoreRanks
	elseif arg_10_1 == var_0_0.RANK_TYPE.VERSUS then
		return self.versusRanks
	end
end

function var_0_0:getNormalRankDatas(arg_11_1, arg_11_2)
	self.normalRanks["" .. arg_11_1 .. arg_11_2] = self.normalRanks["" .. arg_11_1 .. arg_11_2] or {}

	return self.normalRanks["" .. arg_11_1 .. arg_11_2]
end

function var_0_0:getCurrentIndex()
	return self.currentIndex or 0
end

function var_0_0:getIndexByRankType(arg_13_1)
	return self.indexs[arg_13_1] or 0
end

return var_0_0
