local IslandShipAttr = class("IslandShipAttr")

IslandShipAttr.MANAGE_KEY = 5
IslandShipAttr.COLLECT_KEY = 2
IslandShipAttr.ATTRS = {
	"plant",
	"collect",
	"conserve",
	"cooking",
	"manage",
	"machinery"
}
IslandShipAttr.ATTRS_CH = {
	i18n("island_ship_attrName_1"),
	i18n("island_ship_attrName_2"),
	i18n("island_ship_attrName_3"),
	i18n("island_ship_attrName_4"),
	i18n("island_ship_attrName_5"),
	i18n("island_ship_attrName_6")
}
IslandShipAttr.ATTR_IMAGE = {
	{
		"SSS",
		"SS_"
	},
	{
		"SS",
		"SS_"
	},
	{
		"S",
		"S_"
	},
	{
		"A",
		"A_"
	},
	{
		"B",
		"B_"
	},
	{
		"C",
		"C_"
	},
	{
		"D",
		"D_"
	},
	{
		"E",
		"D_"
	}
}

function IslandShipAttr:ToChinese()
	return IslandShipAttr.ATTRS_CH[table.indexof(IslandShipAttr.ATTRS, self)]
end

function IslandShipAttr:GetAtrrName()
	return IslandShipAttr.ATTRS[self]
end

function IslandShipAttr:Grade2Img()
	return IslandShipAttr.ATTR_IMAGE[self]
end

return IslandShipAttr
