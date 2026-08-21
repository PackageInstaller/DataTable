-- chunkname: @IQIGame\\Module\\CenterRankModule\\CenterRankData_ChallengeWorldBoss.lua

local CenterRankData_Base = require("IQIGame/Module/CenterRankModule/CenterRankData_Base")
local RankData = Clone(CenterRankData_Base)

function RankData:__GetRankCallback_GetSelfRankGoalieData(rankData, args)
	args.callbackArgs.rankData = rankData

	local goalieCfgData

	if rankData.myRanking == -1 then
		if #rankData.rankings > 0 then
			goalieCfgData = ChallengeWorldBossModule.GetLastLevelRankRangeCfg(Constant.CenterRankRankType.Percentage)
		end
	else
		goalieCfgData = ChallengeWorldBossModule.GetUpLevelGoalieCfgData(rankData.rankType, rankData.myRanking)
	end

	if goalieCfgData == nil then
		if args.callback == nil then
			return
		end

		args.callback(nil, args.callbackArgs)

		return
	end

	local getRankGoalieData = {}

	getRankGoalieData.rankType = goalieCfgData.RankType
	getRankGoalieData.rank = goalieCfgData.RankUpperLimit

	self:GetRankGoalieData(getRankGoalieData, args.callback, args.callbackArgs)
end

return RankData
