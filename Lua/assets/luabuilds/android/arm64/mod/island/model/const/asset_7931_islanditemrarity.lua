local IslandItemRarity = class("IslandItemRarity")

IslandItemRarity.GREY = 1
IslandItemRarity.BLUE = 2
IslandItemRarity.PURPLE = 3
IslandItemRarity.ORANGE = 4

function IslandItemRarity:Rarity2FrameName()
	IslandItemRarity.RARITY2FRAME = IslandItemRarity.RARITY2FRAME or {
		"rarity_grey",
		"rarity_blue",
		"rarity_purple",
		"rarity_orange"
	}

	return IslandItemRarity.RARITY2FRAME[self]
end

return IslandItemRarity
