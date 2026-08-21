local var_0_0 = class("IslandGetGiftTagCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback

	for iter_1_0, iter_1_1 in ipairs(var_1_0.list) do
		local var_1_2 = getProxy(IslandProxy)

		if var_1_2:GetGiftTagInfoCache(iter_1_1) then
			-- block empty
		else
			table.insert({}, iter_1_1)
		end
	end

	pg.ConnectionMgr.GetInstance():Send(21315, {
		user_id_list = {}
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

return var_0_0
