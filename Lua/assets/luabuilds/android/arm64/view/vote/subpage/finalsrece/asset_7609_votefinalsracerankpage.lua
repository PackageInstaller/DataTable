local VoteFinalsRaceRankPage = class("VoteFinalsRaceRankPage", import("..GroupRace.VoteGroupRaceRankPage"))

function VoteFinalsRaceRankPage:getUIName()
	return "FinalsRaceRank"
end

function VoteFinalsRaceRankPage:NewCard(arg_2_1)
	local var_2_0 = arg_2_1.transform

	return {
		Update = function(self, arg_3_1, arg_3_2, arg_3_3)
			setActive(var_2_0:Find("1"), arg_3_1 == 1)
			setActive(var_2_0:Find("2"), arg_3_1 == 2)
			setActive(var_2_0:Find("3"), arg_3_1 == 3)
			setText(var_2_0:Find("number"), arg_3_1)
			setText(var_2_0:Find("name"), shortenString(self:getShipName(), 6))
			setText(var_2_0:Find("Text"), arg_3_2)

			return
		end
	}
end

function VoteFinalsRaceRankPage:OnDestroy()
	return
end

return VoteFinalsRaceRankPage
