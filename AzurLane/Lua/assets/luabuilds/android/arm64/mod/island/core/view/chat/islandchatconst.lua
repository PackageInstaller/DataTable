local var_0_0 = class("IslandChatConst")

var_0_0.CHANNEL_ISLAND = 1
var_0_0.CHANNEL_WORLD = 2
var_0_0.CHANNEL_FRIEND = 4
var_0_0.CHANNEL_GUILD = 8

local var_0_1 = {
	var_0_0.CHANNEL_ISLAND,
	var_0_0.CHANNEL_WORLD,
	var_0_0.CHANNEL_FRIEND,
	var_0_0.CHANNEL_GUILD
}
local var_0_2 = {
	i18n("channel_name_6"),
	i18n("channel_name_2"),
	i18n("channel_name_4"),
	i18n("channel_name_5")
}

var_0_0.CHANNEL_ALL = IndexConst.BitAll({
	var_0_0.CHANNEL_ISLAND,
	var_0_0.CHANNEL_WORLD,
	var_0_0.CHANNEL_FRIEND,
	var_0_0.CHANNEL_GUILD
})
var_0_0.CHANNELS = {}

table.insert(var_0_0.CHANNELS, var_0_0.CHANNEL_ALL)

for iter_0_0, iter_0_1 in ipairs({
	var_0_0.CHANNEL_ISLAND,
	var_0_0.CHANNEL_WORLD,
	var_0_0.CHANNEL_FRIEND,
	var_0_0.CHANNEL_GUILD
}) do
	table.insert(var_0_0.CHANNELS, iter_0_1)
end

function var_0_0.CHANNEL2CN(arg_1_0)
	if arg_1_0 == var_0_0.CHANNEL_ALL then
		return i18n("channel_name_1")
	end

	return var_0_2[table.indexof(var_0_1, arg_1_0)]
end

var_0_0.SEND_CHANNELS = {
	var_0_0.CHANNEL_ISLAND,
	var_0_0.CHANNEL_WORLD,
	var_0_0.CHANNEL_GUILD
}

return var_0_0
