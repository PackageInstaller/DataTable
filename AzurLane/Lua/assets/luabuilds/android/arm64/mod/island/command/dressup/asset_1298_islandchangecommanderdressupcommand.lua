class = var_0_10000

local var_0_0 = "IslandChangeCommanderDressupCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().island_id
	local var_1_1 = var_2.dress_List
	local var_1_2 = var_2.color_list
	local var_1_3 = var_2.callback
	local var_1_4 = var_2.hideTip

	getProxy = var_1_10008
	IslandProxy = var_1_10010

	local var_1_5 = var_1_10008(var_1_10010)
	local var_1_6 = var_8.GetIsland(var_1_5)

	pg = var_1_10009

	local var_1_7 = var_1_10009.ConnectionMgr.GetInstance()

	var_9.Send(var_1_7, 21626, {
		island_id = var_1_0,
		dress_list = var_1_1,
		color_list = var_1_2
	}, 21627, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_1_6

			var_2_10004 = var_1.GetDressUpAgency(var_2_0)

			var_1.ChangeCapState(var_2_10004, arg_2_0.cap_list)

			ipairs = var_2

			for iter_2_0, iter_2_1 in var_2(var_1_2) do
				var_1:ChangeDressColor(iter_2_1)
			end

			var_2_10004 = var_1

			var_1.ChangeDress(var_2_10004, var_1_1)

			var_2_10004 = var_1_6

			local var_2_1 = var_2.DispatchEvent

			IslandDressUpAgency = var_5

			var_2_1(var_2_10004, var_5.CHANGE_PLAYER_DRESS, var_1_1, var_1_2)

			var_2_10004 = arg_1_0

			local var_2_2 = var_2.sendNotification

			GAME = var_5

			var_2_2(var_2_10004, var_5.ISLAND_CHANGE_COMMANDER_DRESS_DONE)

			local var_2_3

			if not var_1_4 then
				pg = var_2_3
				var_2_10004 = var_2_3.TipsMgr.GetInstance()
				var_2_3 = var_2_3.ShowTips
				i18n = var_5

				var_2_3(var_2_10004, var_5("island_dress_save1"))
			end

			existCall = var_2_3

			var_2_3(var_1_3)
		else
			pg = var_1

			local var_2_4 = var_1.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_5(var_2_4, var_2_10004[arg_2_0.result] .. arg_2_0.result)

			existCall = var_2_5

			var_2_5(var_1_3)
		end

		return
	end)

	return
end

return var_0_1
