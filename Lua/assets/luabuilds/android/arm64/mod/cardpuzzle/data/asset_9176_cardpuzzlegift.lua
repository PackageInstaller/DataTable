local CardPuzzleGift = class("CardPuzzleGift", BaseVO)

CardPuzzleGift.TYPE = {
	GLOBAL = 1,
	USABLE = 3,
	BATTLE = 2
}
CardPuzzleGift.EFFECT_TYPE = {
	BATTLE_BUFF = 2,
	COIN_BONUS = 5,
	ROGUE_DROP_BONUS = 3,
	CARD_CLIPPING = 4,
	GLOBAL_ATTRIBUTE_BONUS = 1
}

function CardPuzzleGift:CreateByNetData()
	local var_1_0 = {}

	for iter_1_0 = 1, self.num do
		table.insert(var_1_0, CardPuzzleGift.New({
			configId = self.id
		}))
	end

	return var_1_0
end

function CardPuzzleGift:bindConfigTable()
	return pg.puzzle_relics_template
end

function CardPuzzleGift:GetIconPath()
	return "roguegifts/" .. self:getConfig("icon")
end

function CardPuzzleGift:GetConfigId()
	return self.configId
end

function CardPuzzleGift:GetName()
	return self:getConfig("name")
end

function CardPuzzleGift:GetType()
	return self:getConfig("type")
end

function CardPuzzleGift:GetDesc()
	return self:getConfig("desc")
end

function CardPuzzleGift:GetRarity()
	return self:getConfig("rarity")
end

function CardPuzzleGift:GetEffects()
	return _.map(self:getConfig("arg_list"), function(arg_10_0)
		assert(pg.puzzle_relics_effect[arg_10_0])

		return pg.puzzle_relics_effect[arg_10_0]
	end)
end

function CardPuzzleGift:GetAttributeBonus(arg_11_1)
	local var_11_0 = {}

	if self:GetType() ~= CardPuzzleGift.TYPE.GLOBAL then
		return var_11_0
	end

	for iter_11_0, iter_11_1 in ipairs(self:GetEffects()) do
		if iter_11_1.type == CardPuzzleGift.EFFECT_TYPE.GLOBAL_ATTRIBUTE_BONUS then
			for iter_11_2, iter_11_3 in ipairs(iter_11_1.arg_list) do
				if table.contains(iter_11_3[1], arg_11_1:getShipType()) then
					table.insert(var_11_0, {
						type = CardPuzzleShip.PROPERTIES[iter_11_3[2]],
						value = iter_11_3[3]
					})
				end
			end
		end
	end

	return var_11_0
end

return CardPuzzleGift
