class = var_0_10000

local var_0_0 = "IslandRefreshInviteCodeCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().auto

	getProxy = var_1_10004
	IslandProxy = var_1_10005

	local var_1_1 = var_1_10004(var_1_10005)
	local var_1_2 = var_4.GetIsland(var_1_1)
	local var_1_3 = var_4.GetAccessAgency(var_1_2)
	local var_1_5

	if var_4.isFreshInviteCode(var_1_3) then
		pg = var_1_5

		local var_1_4 = var_1_5.TipsMgr.GetInstance()

		var_1_5 = var_1_5.ShowTips
		i18n = var_1_10007

		var_1_5(var_1_4, var_1_10007("island_inviteCode_refresh"))

		return
	end

	pg = var_1_5

	local var_1_6 = var_1_5.ConnectionMgr.GetInstance()

	var_5.Send(var_1_6, 21008, {
		type = 0
	}, 21009, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_0

			var_1.SetInviteCode(var_2_0, arg_2_0.invite_code)

			if not var_1_0 then
				local var_2_1 = var_0

				var_1.MarkFreshInviteCodeFlag(var_2_1)
			end

			local var_2_2 = arg_1_0
			local var_2_3 = var_1.sendNotification

			GAME = var_3

			var_2_3(var_2_2, var_3.ISLAND_REFRESH_INVITECODE_DONE)

			pg = var_2_3

			local var_2_4 = var_2_3.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			i18n = var_3

			var_2_5(var_2_4, var_3("guild_shop_flash_success"))
		end

		return
	end)

	return
end

return var_0_1
