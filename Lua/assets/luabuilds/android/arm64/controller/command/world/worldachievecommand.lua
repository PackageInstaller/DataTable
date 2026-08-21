local var_0_0 = class("WorldAchieveCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(33602, arg_1_1:getBody(), 33603, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = nowWorld()

			for iter_2_0, iter_2_1 in ipairs(var_0.list) do
				local var_2_1 = var_2_0:GetMap(iter_2_1.id)

				for iter_2_2, iter_2_3 in ipairs(iter_2_1.star_list) do
					var_2_0:SetAchieveSuccess(iter_2_1.id, iter_2_3)
				end
			end

			var_2_0:DispatchEvent(World.EventAchieved)
			arg_1_0:sendNotification(GAME.WORLD_ACHIEVE_DONE, {
				list = var_0.list,
				drops = PlayerConst.addTranDrop(arg_2_0.drops)
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("world_achieve_error_", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
