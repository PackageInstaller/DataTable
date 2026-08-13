class = var_0_10000

local var_0_0 = "IslandFriendList4GuildPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandFriendListPage"))

function var_0_1.GetData(arg_1_0, arg_1_1)
	getProxy = var_1_10002
	GuildProxy = var_1_10003

	local var_1_0 = var_1_10002(var_1_10003)
	local var_1_1

	if not var_2.getRawData(var_1_0) or not var_2:getSortMemberWithoutSelf() then
		var_1_1 = {}
	end

	if #var_1_1 <= 0 then
		return arg_1_1({})
	end

	local var_1_2 = {}

	pairs = var_5

	for iter_1_0, iter_1_1 in var_5(var_1_1) do
		table = var_1_10010

		var_1_10010.insert(var_1_2, iter_1_1.id)
	end

	local var_1_3 = arg_1_0
	local var_1_4 = arg_1_0.emit

	IslandMediator = var_7

	var_1_4(var_1_3, var_7.GET_GIFT_TAG, var_1_2, function()
		arg_1_1(var_1_1)

		return
	end)

	return
end

return var_0_1
