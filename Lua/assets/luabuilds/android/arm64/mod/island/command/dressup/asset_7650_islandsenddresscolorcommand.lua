local IslandSendDressColorCommand = class("IslandSendDressColorCommand", pm.SimpleCommand)

function IslandSendDressColorCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.id
	local var_1_2 = var_1_0.dress_id
	local var_1_3 = var_1_0.color_id
	local var_1_4 = getProxy(IslandProxy):GetIsland()

	pg.ConnectionMgr.GetInstance():Send(21628, {
		id = var_1_0.id,
		dress_id = var_1_0.dress_id,
		color_id = var_1_0.color_id
	}, 21629, function(arg_2_0)
		if arg_2_0.result == 0 then
			if var_1_1 == 0 then
				var_1_4:GetDressUpAgency():AddDressColor(var_1_2, var_1_3)
			end

			self:sendNotification(GAME.ISLAND_BUY_ROLE_DRESS_COLOR_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return IslandSendDressColorCommand
