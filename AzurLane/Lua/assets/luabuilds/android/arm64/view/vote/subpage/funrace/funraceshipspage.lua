local var_0_0 = class("FunRaceShipsPage", import("..FinalsRece.VoteFinalsRaceShipsPage"))

function var_0_0.getUIName(arg_1_0)
	if arg_1_0.contextData.voteGroup:IsFunMetaRace() then
		return "FinalsRaceShipsForMeta"
	elseif arg_1_0.contextData.voteGroup:IsFunSireRace() then
		return "FinalsRaceShipsForSire"
	elseif arg_1_0.contextData.voteGroup:IsFunKidRace() then
		return "FinalsRaceShipsForKid"
	else
		assert(false)
	end

	return
end

return var_0_0
