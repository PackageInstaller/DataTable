local IslandItemKind = class("IslandItemKind")

function IslandItemKind:Type2TagName()
	IslandItemKind.TagNames = IslandItemKind.TagNames or {
		i18n("island_item_type_res"),
		i18n("island_item_type_consume"),
		i18n("island_item_type_spe")
	}

	return IslandItemKind.TagNames[self]
end

return IslandItemKind
