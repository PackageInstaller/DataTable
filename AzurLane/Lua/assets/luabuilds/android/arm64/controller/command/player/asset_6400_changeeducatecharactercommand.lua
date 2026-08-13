class = var_0_10000

local var_0_0 = "ChangeEducateCharacterCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).id

	getProxy = var_1_0
	PlayerProxy = var_1_10006

	local var_1_2 = var_1_0(var_1_10006)
	local var_1_3 = var_4.getRawData(var_1_2)
	local var_1_4 = var_4.GetEducateCharacter(var_1_3)

	pg = var_1_2

	local var_1_5 = var_1_2.ConnectionMgr.GetInstance()

	var_6.Send(var_1_5, 27041, {
		ending_id = var_1_1
	}, 27042, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			if var_1_1 > 0 and var_1_4 then
				pg = var_2_0

				if var_2_0.secretary_special_ship[var_1_4] then
					pg = var_2_0
					var_2_0 = var_2_0.secretary_special_ship[var_1_4].group
					pg = var_2

					if var_2_0 == var_2.secretary_special_ship[var_1_1].group then
						pg = var_2

						if var_2.secretary_special_ship[var_1_1].genghuan_word == 1 then
							getProxy = var_2
							PlayerProxy = var_2_10004
							var_2_10004 = var_2(var_2_10004)

							var_2.setFlag(var_2_10004, "change_tb", true)
						end
					end
				end
			end

			getProxy = var_2_0
			PlayerProxy = var_2_10003
			var_2_10004 = var_2_0(var_2_10003)

			local var_2_1 = var_2_0.getData(var_2_10004)

			var_2.SetEducateCharacter(var_2_1, var_1_1)
			var_2_0:updatePlayer(var_2)

			local var_2_2 = arg_1_0
			local var_2_3 = var_3.sendNotification

			GAME = var_6

			var_2_3(var_2_2, var_6.CHANGE_EDUCATE_DONE)
		else
			pg = var_2_0

			local var_2_4 = var_2_0.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_5(var_2_4, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
