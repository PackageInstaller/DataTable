class = var_0_10000

local var_0_0 = "VoteFunRaceShipsPageForRank"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..FinalsRece.VoteFinalsRaceShipsPageForRank"))

function var_0_1.getUIName(arg_1_0)
	local var_1_0 = arg_1_0.contextData.voteGroup

	if var_1.IsFunMetaRace(var_1_0) then
		return "FinalsRaceShipsRankForMeta"
	elseif var_1:IsFunSireRace() then
		return "FinalsRaceShipsRankForSire"
	elseif var_1:IsFunKidRace() then
		return "FinalsRaceShipsRankForKid"
	else
		assert = var_2

		var_2(false)
	end

	return
end

return var_0_1
