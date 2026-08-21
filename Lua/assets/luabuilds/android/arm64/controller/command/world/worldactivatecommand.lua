local var_0_0 = class("WorldActivateCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(33101, arg_1_1:getBody(), 33102, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(WorldProxy)
			local var_2_1 = arg_2_0.global_flag_list or {}

			var_2_0:NetUpdateWorld(arg_2_0.world, var_2_1, var_0.camp)
			var_2_0:NetUpdateWorldCountInfo(arg_2_0.count_info)
			var_2_0:NetUpdateWorldMapPressing({})
			var_2_0:NetUpdateWorldPressingAward(arg_2_0.chapter_award)
			var_2_0:NetUpdateWorldPortShopMark(arg_2_0.port_list, arg_2_0.new_flag_port_list)
			nowWorld():GetBossProxy():GenFleet()
			arg_1_0:sendNotification(GAME.WORLD_ACTIVATE_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("world_activate_error_", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
