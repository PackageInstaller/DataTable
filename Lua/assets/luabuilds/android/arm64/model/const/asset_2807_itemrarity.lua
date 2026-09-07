local ItemRarity = class("ItemRarity")

ItemRarity.Gray = 1
ItemRarity.Blue = 2
ItemRarity.Purple = 3
ItemRarity.Gold = 4
ItemRarity.SSR = 5

function ItemRarity:Rarity2Print()
	if math.clamp(self, 1, 9) == self then
		return tostring(self)
	else
		return ItemRarity.Gray
	end

	return
end

ItemRarity.colors = {
	"FFFFFFFF",
	"41D7FFFF",
	"CC7BFFFF",
	"FDC637FF",
	"FF5E39FF",
	"FFFFFFFF",
	"FDC637FF",
	"FFFFFFFF",
	"FDC637FF"
}

function ItemRarity:Rarity2HexColor()
	return ItemRarity.colors[self]
end

ItemRarity.frameColors = {
	"BDBDBDFF",
	"65C7FFFF",
	"BFA3FFFF",
	"FFE743FF",
	"FFFFFFFF",
	"FFFFFFFF",
	"FFE743FF",
	"FFFFFFFF",
	"FFE743FF"
}

function ItemRarity:Rarity2FrameHexColor()
	return ItemRarity.frameColors[self]
end

return ItemRarity
