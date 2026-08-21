local var_0_0 = class("VoteFunRaceShipsPageForRank", import("..FinalsRece.VoteFinalsRaceShipsPageForRank"))

function var_0_0.getUIName(arg_1_0)
	if arg_1_0.contextData.voteGroup:IsFunMetaRace() then
		return "FinalsRaceShipsRankForMeta"
	elseif arg_1_0.contextData.voteGroup:IsFunSireRace() then
		return "FinalsRaceShipsRankForSire"
	elseif arg_1_0.contextData.voteGroup:IsFunKidRace() then
		return "FinalsRaceShipsRankForKid"
	else
		assert(false)
	end

	return
end

return var_0_0
