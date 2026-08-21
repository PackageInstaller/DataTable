local var_0_0 = class("IslandChangeCommanderDressupCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback
	local var_1_2 = var_1_0.hideTip
	local var_1_3 = getProxy(IslandProxy):GetIsland()

	pg.ConnectionMgr.GetInstance():Send(21626, {
		island_id = var_1_0.island_id,
		dress_list = var_1_0.dress_List,
		color_list = var_1_0.color_list
	}, 21627, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_1_3:GetDressUpAgency()

			var_2_0:ChangeCapState(arg_2_0.cap_list)

			for iter_2_0, iter_2_1 in ipairs(var_0) do
				var_2_0:ChangeDressColor(iter_2_1)
			end

			var_2_0:ChangeDress(var_0)
			var_1_3:DispatchEvent(IslandDressUpAgency.CHANGE_PLAYER_DRESS, var_0, var_0)
			arg_1_0:sendNotification(GAME.ISLAND_CHANGE_COMMANDER_DRESS_DONE)

			if not var_1_2 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("island_dress_save1"))
			end

			existCall(var_1_1)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
			existCall(var_1_1)
		end

		return
	end)

	return
end

return var_0_0
