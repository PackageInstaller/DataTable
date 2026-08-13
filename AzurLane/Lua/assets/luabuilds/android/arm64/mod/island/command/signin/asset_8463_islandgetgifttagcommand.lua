class = var_0_10000

local var_0_0 = "IslandGetGiftTagCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().list
	local var_1_1 = var_2.callback
	local var_1_2 = {}

	ipairs = var_1_10006

	for iter_1_0, iter_1_1 in var_1_10006(var_1_0) do
		getProxy = var_1_10011
		IslandProxy = var_1_10013
		var_1_10013 = var_1_10011(var_1_10013)

		if var_1_10011.GetGiftTagInfoCache(var_1_10013, iter_1_1) then
			-- block empty
		else
			table = var_1_10012

			var_1_10012.insert(var_1_2, iter_1_1)
		end
	end

	pg = var_6

	local var_1_3 = var_6.ConnectionMgr.GetInstance()

	var_6.Send(var_1_3, 21315, {
		user_id_list = var_1_2
	}, 21316, function(arg_2_0)
		ipairs = var_2_10001

		for iter_2_0, iter_2_1 in var_2_10001(arg_2_0.gift_list) do
			IslandGiftTagInfo = var_2_10006
			var_2_10006 = var_2_10006.New(iter_2_1)
			getProxy = var_2_10007
			IslandProxy = var_2_10009
			var_2_10009 = var_2_10007(var_2_10009)

			var_2_10007.AddGiftTagInfoCache(var_2_10009, var_2_10006)
		end

		if var_1_1 then
			var_1_1()
		end

		return
	end)

	return
end

return var_0_1
