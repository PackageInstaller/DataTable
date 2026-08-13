class = var_0_10000

local var_0_0 = var_0_10000("PlayRoomChatConst")

var_0_0.CHANNEL_PLAYROOM = 1
var_0_0.CHANNEL_WORLD = 2
var_0_0.CHANNEL_FRIEND = 4
var_0_0.CHANNEL_GUILD = 8

local var_0_1 = {
	var_0_0.CHANNEL_PLAYROOM,
	var_0_0.CHANNEL_WORLD,
	var_0_0.CHANNEL_FRIEND,
	var_0_0.CHANNEL_GUILD
}
local var_0_2 = {}

i18n = var_0_10003
var_0_2[1] = var_0_10003("match_ui_chat")
i18n = var_3
var_0_2[2] = var_3("channel_name_2")
i18n = var_3
var_0_2[3] = var_3("island_friend")
i18n = var_3
var_0_2[4] = var_3("channel_name_5")
IndexConst = var_3
var_0_0.CHANNEL_ALL = var_3.BitAll(var_0_1)
var_0_0.CHANNELS = {}
table = var_3

var_3.insert(var_0_0.CHANNELS, var_0_0.CHANNEL_ALL)

ipairs = var_3

for iter_0_0, iter_0_1 in var_3(var_0_1) do
	table = var_0_10008

	var_0_10008.insert(var_0_0.CHANNELS, iter_0_1)
end

function var_0_0.CHANNEL2CN(arg_1_0)
	if arg_1_0 == var_0_0.CHANNEL_ALL then
		i18n = var_1

		return var_1("channel_name_1")
	end

	table = var_1

	local var_1_0 = var_1.indexof(var_0_1, arg_1_0)

	return var_0_2[var_1_0]
end

var_0_0.SEND_CHANNELS = {
	var_0_0.CHANNEL_PLAYROOM,
	var_0_0.CHANNEL_WORLD,
	var_0_0.CHANNEL_GUILD
}

return var_0_0
