local IslandShareSignInCommand = class("IslandShareSignInCommand", pm.SimpleCommand)

function IslandShareSignInCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(IslandProxy):GetIsland():GetAccessAgency()
	local var_1_2 = {}
	local var_1_3 = {}

	if not var_1_1:HasOpenFlag(IslandConst.OPEN_SIGNIN) then
		table.insert(var_1_2, IslandConst.OPEN_SIGNIN)
	else
		table.insert(var_1_3, IslandConst.OPEN_SIGNIN)
	end

	pg.ConnectionMgr.GetInstance():Send(21002, {
		open_flag = var_1_2,
		close_flag = var_1_3
	}, 21003, function(arg_2_0)
		if arg_2_0.result == 0 then
			for iter_2_0, iter_2_1 in ipairs(var_1_2) do
				var_1_1:AddOpenFlag(IslandConst.OPEN_SIGNIN)
			end

			for iter_2_2, iter_2_3 in ipairs(var_1_3) do
				var_1_1:RemoveOpenFlag(IslandConst.OPEN_SIGNIN)
			end

			self:sendNotification(GAME.ISLAND_SIGN_SHARE_SIGNIN_DONE)
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_share_gift_success"))
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandShareSignIn())
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return IslandShareSignInCommand
