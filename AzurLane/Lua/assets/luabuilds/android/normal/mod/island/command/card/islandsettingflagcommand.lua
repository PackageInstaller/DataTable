class = var_0_10000

local var_0_0 = "IslandSettingFlagCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().flags

	getProxy = var_1_10004
	IslandProxy = var_1_10005

	local var_1_1 = var_1_10004(var_1_10005)
	local var_1_2 = var_4.GetIsland(var_1_1)
	local var_1_3 = var_4.GetSettingsAgency(var_1_2)
	local var_1_4 = {}

	ipairs = var_1_10006

	for iter_1_0, iter_1_1 in var_1_10006(var_1_0) do
		if var_1_3:GetFlagByType(iter_1_1.type) ~= iter_1_1.flag then
			table = var_12

			var_12.insert(var_1_4, iter_1_1)
		end
	end

	if #var_1_4 == 0 then
		return
	end

	pg = var_6

	local var_1_5 = var_6.ConnectionMgr.GetInstance()

	var_6.Send(var_1_5, 21332, {
		flag_list = var_1_4
	}, 21333, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			local var_2_0 = var_1_3

			var_2_2.SetFlags(var_2_0, var_1_4)

			local var_2_1 = arg_1_0

			var_2_2 = var_2_2.sendNotification
			GAME = var_2_10003

			var_2_2(var_2_1, var_2_10003.ISLAND_SETTING_FLAG_DONE)
		else
			pg = var_2_2

			local var_2_3 = var_2_2.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_4(var_2_3, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
