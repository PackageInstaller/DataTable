local var_0_0 = class("VoteFunRaceRankPage", import("..FinalsRece.VoteFinalsRaceRankPage"))

function var_0_0.getUIName(arg_1_0)
	if arg_1_0.contextData.voteGroup:IsFunMetaRace() then
		return "FinalsRaceRankForMeta"
	elseif arg_1_0.contextData.voteGroup:IsFunSireRace() then
		return "FinalsRaceRankForSire"
	elseif arg_1_0.contextData.voteGroup:IsFunKidRace() then
		return "FinalsRaceRankForKid"
	else
		assert(false)
	end

	return
end

return var_0_0
