class = var_0_10000

local var_0_0 = "ChangeMedalDisplayCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).medalList

	getProxy = var_1_0
	PlayerProxy = var_1_10006

	local var_1_2 = var_1_0(var_1_10006)
	local var_1_3 = var_4.getData(var_1_2).displayTrophyList
	local var_1_4 = 0

	while var_1_4 < 5 do
		if var_1_1[var_1_4] ~= var_1_3[var_1_4] then
			break
		end

		if var_1_4 == 5 then
			return
		end

		var_1_4 = var_1_4 + 1
	end

	local var_1_5 = {}

	ipairs = var_1_10009

	for iter_1_0, iter_1_1 in var_1_10009(var_1_1) do
		table = var_1_10014

		var_1_10014.insert(var_1_5, iter_1_1)
	end

	pg = var_9

	local var_1_6 = var_9.ConnectionMgr.GetInstance()

	var_9.Send(var_1_6, 17401, {
		fixed_const = 1,
		medal_id = var_1_1
	}, 17402, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			local var_2_0 = var_0

			var_2_2.updatePlayerMedalDisplay(var_2_0, var_1_1)

			pg = var_2_2

			local var_2_1 = var_2_2.TipsMgr.GetInstance()

			var_2_2 = var_2_2.ShowTips
			i18n = var_2_10004

			var_2_2(var_2_1, var_2_10004("change_display_medal_success"))

			local var_2_3 = arg_1_0

			var_2_2 = var_2_2.sendNotification
			GAME = var_2_10004

			var_2_2(var_2_3, var_2_10004.CHANGE_PLAYER_MEDAL_DISPLAY_DONE)
		else
			pg = var_2_2

			local var_2_4 = var_2_2.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_5(var_2_4, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
