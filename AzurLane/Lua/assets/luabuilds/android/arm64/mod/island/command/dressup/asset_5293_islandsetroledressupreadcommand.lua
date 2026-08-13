class = var_0_10000

local var_0_0 = "IslandSetRoleDressupReadCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).dress_List

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_4.Send(var_1_2, 21624, {
		dress_id = var_1_1
	}, 21625, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			IslandProxy = var_2_10003

			local var_2_0 = var_1(var_2_10003)

			var_2_10004 = var_1.GetIsland(var_2_0)

			local var_2_1 = var_1.GetCharacterAgency(var_2_10004)

			ipairs = var_2_0

			for iter_2_0, iter_2_1 in var_2_0(var_1_1) do
				var_2_1:SetDressHasRead(iter_2_1)
			end

			local var_2_2 = arg_1_0
			local var_2_3 = var_3.sendNotification

			GAME = iter_2_0

			var_2_3(var_2_2, iter_2_0.ISLAND_SEND_ROLE_DRESS_READ_DONE, var_1_1)
		else
			pg = var_1

			local var_2_4 = var_1.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_5(var_2_4, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
