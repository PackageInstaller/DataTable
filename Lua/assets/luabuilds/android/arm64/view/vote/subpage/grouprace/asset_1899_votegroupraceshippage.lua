local VoteGroupRaceShipPage = class("VoteGroupRaceShipPage", import("..PreRace.VotePreRaceShipPage"))

function VoteGroupRaceShipPage:getUIName()
	return "GroupRaceShips"
end

function VoteGroupRaceShipPage:onInitItem(arg_2_1)
	VoteGroupRaceShipPage.super.onInitItem(self, arg_2_1)

	local var_2_0 = self.voteItems[arg_2_1]

	onButton(self, self.voteItems[arg_2_1].go, function()
		if self.CallBack and self.phase == VoteGroup.VOTE_STAGE then
			self.CallBack(var_2_0, var_2_0.voteShip.votes)
		end

		return
	end, SFX_PANEL)

	return
end

function VoteGroupRaceShipPage:UpdateShips(arg_4_1, arg_4_2)
	self.scrollRect:SetTotalCount(#self.displays)

	return
end

function VoteGroupRaceShipPage:OnDestroy()
	return
end

return VoteGroupRaceShipPage
