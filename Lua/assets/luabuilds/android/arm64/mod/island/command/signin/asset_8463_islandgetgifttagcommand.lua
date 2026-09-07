local IslandGetGiftTagCommand = class("IslandGetGiftTagCommand", pm.SimpleCommand)

function IslandGetGiftTagCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback
	local var_1_2 = {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0.list) do
		if getProxy(IslandProxy):GetGiftTagInfoCache(iter_1_1) then
			-- block empty
		else
			table.insert(var_1_2, iter_1_1)
		end
	end

	pg.ConnectionMgr.GetInstance():Send(21315, {
		user_id_list = var_1_2
	}, 21316, function(arg_2_0)
		for iter_2_0, iter_2_1 in ipairs(arg_2_0.gift_list) do
			getProxy(IslandProxy):AddGiftTagInfoCache((IslandGiftTagInfo.New(iter_2_1)))
		end

		if var_1_1 then
			var_1_1()
		end

		return
	end)

	return
end

return IslandGetGiftTagCommand
