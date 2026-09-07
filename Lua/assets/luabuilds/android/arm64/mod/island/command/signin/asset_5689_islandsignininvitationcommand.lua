local IslandSignInInvitationCommand = class("IslandSignInInvitationCommand", pm.SimpleCommand)

function IslandSignInInvitationCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().list or {}
	local var_1_1 = getProxy(IslandProxy)
	local var_1_2 = var_1_1:GetIsland():GetSignInAgency()
	local var_1_3 = _.select(var_1_0, function(arg_2_0)
		return not var_1_2:IsInvited(arg_2_0)
	end)

	if #var_1_1 == 0 then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(21312, {
		friend_list = var_1_3
	}, 21313, function(arg_3_0)
		if arg_3_0.result == 0 then
			for iter_3_0, iter_3_1 in ipairs(var_1_3) do
				var_1_2:AddInviter(iter_3_1)
			end

			self:sendNotification(GAME.ISLAND_SIGN_IN_INVITATION_DONE)
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_invitation_gift_success"))
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandInvitation(var_1_3))
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_3_0.result] .. arg_3_0.result)
		end

		return
	end)

	return
end

return IslandSignInInvitationCommand
