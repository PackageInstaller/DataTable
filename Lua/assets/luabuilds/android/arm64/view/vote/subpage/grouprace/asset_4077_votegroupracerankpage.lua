local VoteGroupRaceRankPage = class("VoteGroupRaceRankPage", import("....base.BaseSubView"))

function VoteGroupRaceRankPage:getUIName()
	return "GroupRaceRank"
end

function VoteGroupRaceRankPage:OnInit()
	self.cards = {}
	self.title1 = self._tf:Find("stages/title1")
	self.title2 = self._tf:Find("stages/title2")
	self.scrollRect = self._tf:Find("scrollrect"):GetComponent("LScrollRect")

	function self.scrollRect.onInitItem(arg_3_0)
		self:OnInitItem(arg_3_0)

		return
	end

	function self.scrollRect.onUpdateItem(arg_4_0, arg_4_1)
		self:OnUpdateItem(arg_4_0, arg_4_1)

		return
	end

	setText(self._tf:Find("titles/rank_title"), i18n("vote_label_rank"))
	setText(self._tf:Find("titles/votes"), i18n("word_votes"))
	setText(self._tf:Find("tip"), i18n("vote_label_rank_fresh_time_tip"))

	return
end

function VoteGroupRaceRankPage:Update(arg_5_1)
	self.voteGroup = arg_5_1
	self.phase = arg_5_1:GetStage()

	setActive(self.title1, self.phase == VoteGroup.VOTE_STAGE)
	setActive(self.title2, self.phase ~= VoteGroup.VOTE_STAGE)
	setActive(self._tf:Find("tip"), self.phase == VoteGroup.VOTE_STAGE)
	self:UpdateList()

	return
end

function VoteGroupRaceRankPage:UpdateList()
	self.displays = self.voteGroup:GetRankList()

	self.scrollRect:SetTotalCount(#self.displays)

	return
end

function VoteGroupRaceRankPage:OnInitItem(arg_7_1)
	self.cards[arg_7_1] = self:NewCard(arg_7_1)

	return
end

function VoteGroupRaceRankPage:OnUpdateItem(arg_8_1, arg_8_2)
	self.cards[arg_8_2].Update(self.displays[arg_8_1 + 1], arg_8_1 + 1, self.voteGroup:GetVotes(self.displays[arg_8_1 + 1]), (self.voteGroup:GetRiseColor(arg_8_1 + 1)))

	return
end

function VoteGroupRaceRankPage:NewCard(arg_9_1)
	local var_9_0 = arg_9_1.transform

	return {
		Update = function(self, arg_10_1, arg_10_2, arg_10_3)
			setText(var_9_0:Find("number"), setColorStr(arg_10_1, arg_10_3))
			setText(var_9_0:Find("name"), setColorStr(shortenString(self:getShipName(), 6), arg_10_3))
			setText(var_9_0:Find("Text"), setColorStr(arg_10_2, arg_10_3))

			return
		end
	}
end

function VoteGroupRaceRankPage:OnDestroy()
	return
end

return VoteGroupRaceRankPage
