local FunRaceShipsPage = class("FunRaceShipsPage", import("..FinalsRece.VoteFinalsRaceShipsPage"))

function FunRaceShipsPage:getUIName()
	if self.contextData.voteGroup:IsFunMetaRace() then
		return "FinalsRaceShipsForMeta"
	elseif self.contextData.voteGroup:IsFunSireRace() then
		return "FinalsRaceShipsForSire"
	elseif self.contextData.voteGroup:IsFunKidRace() then
		return "FinalsRaceShipsForKid"
	else
		assert(false)
	end

	return
end

return FunRaceShipsPage
