local IslandFriendList4GuildPage = class("IslandFriendList4GuildPage", import(".IslandFriendListPage"))

function IslandFriendList4GuildPage:GetData(arg_1_1)
	local var_1_0 = getProxy(GuildProxy):getRawData()
	local var_1_1 = var_1_0 and var_1_0:getSortMemberWithoutSelf() or {}

	if #var_1_1 <= 0 then
		return arg_1_1({})
	end

	local var_1_2 = {}

	for iter_1_0, iter_1_1 in pairs(var_1_1) do
		table.insert(var_1_2, iter_1_1.id)
	end

	self:emit(IslandMediator.GET_GIFT_TAG, var_1_2, function()
		arg_1_1(var_1_1)

		return
	end)

	return
end

return IslandFriendList4GuildPage
