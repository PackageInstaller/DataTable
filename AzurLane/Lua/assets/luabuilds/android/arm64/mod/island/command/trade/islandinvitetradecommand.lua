class = var_0_10000

local var_0_0 = "IslandInviteTradeCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().list
	local var_1_1 = var_2.mapId
	local var_1_2 = var_2.price

	if #var_1_0 <= 0 then
		return
	end

	getProxy = var_6
	IslandProxy = var_1_10008

	local var_1_3 = var_6(var_1_10008)
	local var_1_4 = var_6.GetIsland(var_1_3)
	local var_1_5 = var_6.GetTradeAgency(var_1_4)

	pg = var_7

	local var_1_6 = var_7.ConnectionMgr.GetInstance()

	var_7.Send(var_1_6, 21245, {
		friend_list = var_1_0,
		map_id = var_1_1,
		price = var_1_2
	}, 21246, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_1_5

			var_1.UpdateInviteList(var_2_0, var_1_0)

			pg = var_1

			local var_2_1 = var_1.TipsMgr.GetInstance()
			local var_2_2 = var_1.ShowTips

			i18n = var_4

			var_2_2(var_2_1, var_4("island_trade_invite_success"))
		end

		return
	end)

	return
end

return var_0_1
