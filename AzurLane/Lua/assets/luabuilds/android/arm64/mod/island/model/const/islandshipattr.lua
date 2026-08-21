local var_0_0 = class("IslandShipAttr")

var_0_0.MANAGE_KEY = 5
var_0_0.COLLECT_KEY = 2
var_0_0.ATTRS = {
	"plant",
	"collect",
	"conserve",
	"cooking",
	"manage",
	"machinery"
}
var_0_0.ATTRS_CH = {
	i18n("island_ship_attrName_1"),
	i18n("island_ship_attrName_2"),
	i18n("island_ship_attrName_3"),
	i18n("island_ship_attrName_4"),
	i18n("island_ship_attrName_5"),
	i18n("island_ship_attrName_6")
}
var_0_0.ATTR_IMAGE = {
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

function var_0_0.ToChinese(arg_1_0)
	return var_0_0.ATTRS_CH[table.indexof(var_0_0.ATTRS, arg_1_0)]
end

function var_0_0.GetAtrrName(arg_2_0)
	return var_0_0.ATTRS[arg_2_0]
end

function var_0_0.Grade2Img(arg_3_0)
	return var_0_0.ATTR_IMAGE[arg_3_0]
end

return var_0_0
