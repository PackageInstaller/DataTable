local ArmorType = class("ArmorType")

ArmorType.Light = 1
ArmorType.Medium = 2
ArmorType.Heavy = 3

function ArmorType:Type2Name()
	ArmorType.names = ArmorType.names or {
		i18n("word_lightArmor"),
		i18n("word_mediumArmor"),
		i18n("word_heavyarmor")
	}

	return ArmorType.names[self]
end

return ArmorType
