class = var_0_10000

local var_0_0 = "FunRaceShipsPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..FinalsRece.VoteFinalsRaceShipsPage"))

function var_0_1.getUIName(arg_1_0)
	local var_1_0 = arg_1_0.contextData.voteGroup

	if var_1.IsFunMetaRace(var_1_0) then
		return "FinalsRaceShipsForMeta"
	elseif var_1:IsFunSireRace() then
		return "FinalsRaceShipsForSire"
	elseif var_1:IsFunKidRace() then
		return "FinalsRaceShipsForKid"
	else
		assert = var_2

		var_2(false)
	end

	return
end

return var_0_1
