local IslandSetRoleDressupReadCommand = class("IslandSetRoleDressupReadCommand", pm.SimpleCommand)

function IslandSetRoleDressupReadCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().dress_List

	pg.ConnectionMgr.GetInstance():Send(21624, {
		dress_id = var_1_0
	}, 21625, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(IslandProxy):GetIsland():GetCharacterAgency()

			for iter_2_0, iter_2_1 in ipairs(var_1_0) do
				var_2_0:SetDressHasRead(iter_2_1)
			end

			self:sendNotification(GAME.ISLAND_SEND_ROLE_DRESS_READ_DONE, var_1_0)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return IslandSetRoleDressupReadCommand
