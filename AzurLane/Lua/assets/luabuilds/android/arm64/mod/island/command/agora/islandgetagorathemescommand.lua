class = var_0_10000

local var_0_0 = "IslandGetAgoraThemesCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).callback

	getProxy = var_1_0
	IslandProxy = var_1_10006

	local var_1_2 = var_1_0(var_1_10006)
	local var_1_3 = var_4.GetIsland(var_1_2)
	local var_1_4 = var_4.GetAgoraAgency(var_1_3)

	if var_5.IsUpdateThemes(var_1_4) then
		if var_1_1 then
			var_1_1()
		end

		return
	end

	pg = var_5

	local var_1_5 = var_5.ConnectionMgr.GetInstance()

	var_5.Send(var_1_5, 21321, {
		id = var_4.id
	}, 21322, function(arg_2_0)
		local var_2_0 = {}

		ipairs = var_2_10002

		for iter_2_0, iter_2_1 in var_2_10002(arg_2_0.theme_list) do
			table = var_2_10007
			var_2_10007 = var_2_10007.insert

			local var_2_1 = var_2_0

			IslandTheme = var_2_10010

			var_2_10007(var_2_1, var_2_10010.New(iter_2_1))
		end

		local var_2_2 = var_0
		local var_2_3 = var_2.GetAgoraAgency(var_2_2)

		var_2.SetThemes(var_2_3, var_2_0)

		if var_1_1 then
			var_1_1()
		end

		local var_2_4 = arg_1_0
		local var_2_5 = var_2.sendNotification

		GAME = var_5

		var_2_5(var_2_4, var_5.ISLAND_GET_AGORA_THEME_DONE)

		return
	end)

	return
end

return var_0_1
