local VoteFunRaceShipsPageForRank = class("VoteFunRaceShipsPageForRank", import("..FinalsRece.VoteFinalsRaceShipsPageForRank"))

function VoteFunRaceShipsPageForRank:getUIName()
	if self.contextData.voteGroup:IsFunMetaRace() then
		return "FinalsRaceShipsRankForMeta"
	elseif self.contextData.voteGroup:IsFunSireRace() then
		return "FinalsRaceShipsRankForSire"
	elseif self.contextData.voteGroup:IsFunKidRace() then
		return "FinalsRaceShipsRankForKid"
	else
		assert(false)
	end

	return
end

return VoteFunRaceShipsPageForRank
