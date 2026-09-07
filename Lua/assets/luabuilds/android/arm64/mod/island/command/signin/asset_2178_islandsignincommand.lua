local IslandSignInCommand = class("IslandSignInCommand", pm.SimpleCommand)

function IslandSignInCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(21310, {
		pos = 0,
		island_id = 0
	}, 21311, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(IslandProxy):GetIsland():GetSignInAgency():MarkSignIn()
			self:sendNotification(GAME.ISLAND_SIGN_IN_DONE)
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandSignIn())
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return IslandSignInCommand
