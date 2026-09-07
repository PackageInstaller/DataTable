local WorldActivateCommand = class("WorldActivateCommand", pm.SimpleCommand)

function WorldActivateCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(33101, var_1_0, 33102, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(WorldProxy)

			var_2_0:NetUpdateWorld(arg_2_0.world, arg_2_0.global_flag_list or {}, var_1_0.camp)
			var_2_0:NetUpdateWorldCountInfo(arg_2_0.count_info)
			var_2_0:NetUpdateWorldMapPressing({})
			var_2_0:NetUpdateWorldPressingAward(arg_2_0.chapter_award)
			var_2_0:NetUpdateWorldPortShopMark(arg_2_0.port_list, arg_2_0.new_flag_port_list)
			nowWorld():GetBossProxy():GenFleet()
			self:sendNotification(GAME.WORLD_ACTIVATE_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("world_activate_error_", arg_2_0.result))
		end

		return
	end)

	return
end

return WorldActivateCommand
