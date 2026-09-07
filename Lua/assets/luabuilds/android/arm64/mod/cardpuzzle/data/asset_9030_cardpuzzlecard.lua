local CardPuzzleCard = class("CardPuzzleCard", BaseVO)

CardPuzzleCard.CARD_TYPE = {
	ATTACK = 1,
	ABILITY = 3,
	TACTIC = 2
}

function CardPuzzleCard:CreateByNetData()
	local var_1_0 = {}

	for iter_1_0 = 1, self.num do
		table.insert(var_1_0, CardPuzzleCard.New({
			configId = self.id
		}))
	end

	return var_1_0
end

function CardPuzzleCard:bindConfigTable()
	return pg.card_template
end

function CardPuzzleCard:GetIconPath()
	return CardPuzzleCard.GetCardIconPath(self:getConfig("icon"))
end

function CardPuzzleCard:GetConfigId()
	return self.configId
end

function CardPuzzleCard:GetName()
	return self:getConfig("name")
end

function CardPuzzleCard:GetCost()
	return self:getConfig("cost")
end

function CardPuzzleCard:GetType()
	return self:getConfig("card_type")
end

function CardPuzzleCard:GetDesc()
	return self:getConfig("discript")
end

function CardPuzzleCard:GetRarity()
	return self:getConfig("rarity")
end

function CardPuzzleCard:GetEffects()
	return {
		{
			keywords = {}
		}
	}
end

function CardPuzzleCard:GetKeywords()
	return CardPuzzleCard.GetCardKeyWord(self:getConfig("label"))
end

function CardPuzzleCard:GetCardKeyWord()
	return _.map(self, function(arg_13_0)
		return pg.puzzle_card_affix[arg_13_0]
	end)
end

function CardPuzzleCard:GetCardIconPath()
	return "RogueCards/" .. self
end

return CardPuzzleCard
