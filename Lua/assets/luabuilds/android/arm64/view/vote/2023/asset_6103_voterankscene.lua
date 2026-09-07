local VoteRankScene = class("VoteRankScene", import("..VoteScene"))

function VoteRankScene:init()
	VoteRankScene.super.init(self)
	setActive(self._tf:Find("blur_panel/adapt/top/title_rank"), true)
	setActive(self._tf:Find("blur_panel/adapt/top/title"), false)
	setActive(self._tf:Find("main/right_panel/filter_bg"), false)
	setActive(self._tf:Find("main/right_panel/title/help"), false)
	setActive(self._tf:Find("main/right_panel/title/schedule"), false)
	setActive(self._tf:Find("main/right_panel/title/Text"), false)

	return
end

function VoteRankScene:GetPageMap()
	return {
		[VoteConst.RACE_TYPE_PRE] = {
			VotePreRaceShipPage,
			VoteGroupRaceRankPage
		},
		[VoteConst.RACE_TYPE_GROUP] = {
			VoteGroupRaceShipPage,
			VoteGroupRaceRankPage
		},
		[VoteConst.RACE_TYPE_RESURGENCE] = {
			VoteGroupRaceShipPage,
			VoteGroupRaceRankPage
		},
		[VoteConst.RACE_TYPE_FINAL] = {
			VoteFinalsRaceShipsPageForRank,
			VoteFinalsRaceRankPage
		},
		[VoteConst.RACE_TYPE_PRE_RESURGENCE] = {
			VoteGroupRaceShipPage,
			VoteGroupRaceRankPage
		},
		[VoteConst.RACE_TYPE_FUN] = {
			VoteFunRaceShipsPageForRank,
			VoteFunRaceRankPage
		}
	}
end

function VoteRankScene:initShips()
	self.displays = {}

	local var_3_0 = getInputText(self.search)

	for iter_3_0, iter_3_1 in ipairs((self.contextData.voteGroup:GetRankList())) do
		table.insert(self.displays, iter_3_1)
	end

	self.shipsPage:ExecuteAction("Update", self.contextData.voteGroup, self.displays, (self:GetVotes()))

	return
end

return VoteRankScene
