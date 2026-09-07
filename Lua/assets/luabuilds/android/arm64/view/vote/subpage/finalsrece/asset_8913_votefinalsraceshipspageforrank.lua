local VoteFinalsRaceShipsPageForRank = class("VoteFinalsRaceShipsPageForRank", import(".VoteFinalsRaceShipsPage"))

function VoteFinalsRaceShipsPageForRank:getUIName()
	return "FinalsRaceShipsRank"
end

function VoteFinalsRaceShipsPageForRank:OnLoaded()
	VoteFinalsRaceShipsPageForRank.super.OnLoaded(self)

	self.loadedPaintings = {}

	return
end

function VoteFinalsRaceShipsPageForRank:UpdateTop3(arg_3_1, arg_3_2, arg_3_3)
	self:ClearPaintings()
	VoteFinalsRaceShipsPageForRank.super.UpdateTop3(self, arg_3_1, arg_3_2, arg_3_3)
	setText(self.num1TF:Find("Text"), i18n("vote_lable_ship_votes", arg_3_1 and self.voteGroup:GetVotes(arg_3_1) or 0))

	return
end

function VoteFinalsRaceShipsPageForRank:LoadPainting(arg_4_1, arg_4_2)
	setPaintingPrefabAsync(arg_4_1, arg_4_2, "pifu", function()
		table.insert(self.loadedPaintings, {
			tr = arg_4_1,
			painting = arg_4_2
		})

		return
	end)

	return
end

function VoteFinalsRaceShipsPageForRank:ClearPaintings()
	for iter_6_0, iter_6_1 in ipairs(self.loadedPaintings) do
		retPaintingPrefab(iter_6_1.tr, iter_6_1.painting)
	end

	self.loadedPaintings = {}

	return
end

function VoteFinalsRaceShipsPageForRank:OnDestroy()
	VoteFinalsRaceShipsPageForRank.super.OnDestroy(self)
	self:ClearPaintings()

	return
end

return VoteFinalsRaceShipsPageForRank
