local var_0_0 = class("IslandRefreshInviteCodeCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().auto
	local var_1_1 = getProxy(IslandProxy):GetIsland():GetAccessAgency()

	if getProxy(IslandProxy):GetIsland():GetAccessAgency():isFreshInviteCode() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_inviteCode_refresh"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(21008, {
		type = 0
	}, 21009, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_1:SetInviteCode(arg_2_0.invite_code)

			if not var_1_0 then
				var_1_1:MarkFreshInviteCodeFlag()
			end

			arg_1_0:sendNotification(GAME.ISLAND_REFRESH_INVITECODE_DONE)
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_shop_flash_success"))
		end

		return
	end)

	return
end

return var_0_0
