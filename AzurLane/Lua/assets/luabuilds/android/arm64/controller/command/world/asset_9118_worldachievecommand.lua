class = var_0_10000

local var_0_0 = "WorldAchieveCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg = var_1_10003

	local var_1_1 = var_1_10003.ConnectionMgr.GetInstance()

	var_3.Send(var_1_1, 33602, var_1_0, 33603, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			PlayerConst = var_2_0
			var_2_0 = var_2_0.addTranDrop(arg_2_0.drops)
			nowWorld = var_2_10002

			local var_2_1 = var_2_10002()

			ipairs = var_3

			for iter_2_0, iter_2_1 in var_3(var_1_0.list) do
				local var_2_2 = var_2_1:GetMap(iter_2_1.id)

				ipairs = var_2_10009

				for iter_2_2, iter_2_3 in var_2_10009(iter_2_1.star_list) do
					var_2_1:SetAchieveSuccess(iter_2_1.id, iter_2_3)
				end
			end

			local var_2_3 = var_2_1
			local var_2_4 = var_2_1.DispatchEvent

			World = iter_2_0

			var_2_4(var_2_3, iter_2_0.EventAchieved)

			local var_2_5 = arg_1_0
			local var_2_6 = var_3.sendNotification

			GAME = var_6

			var_2_6(var_2_5, var_6.WORLD_ACHIEVE_DONE, {
				list = var_1_0.list,
				drops = var_2_0
			})
		else
			pg = var_2_0

			local var_2_7 = var_2_0.TipsMgr.GetInstance()
			local var_2_8 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_8(var_2_7, var_2_10004("world_achieve_error_", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
