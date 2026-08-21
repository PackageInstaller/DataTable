local var_0_0 = class("GuildGetSupplyAwardCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(GuildProxy)
	local var_1_2 = getProxy(GuildProxy):getData()

	if not var_1_2 then
		return
	end

	if not var_1_2:isOpenedSupply() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_supply_no_open"))

		return
	end

	if var_1_2:getSupplyCnt() <= 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_supply_award_got"))

		return
	end

	local var_1_3 = getProxy(PlayerProxy)
	local var_1_4 = var_1_2:getMemberById(var_1_3:getData().id)

	if not var_1_4 or var_1_4:isNewMember() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_new_member_get_award_tip"))

		return
	end

	if var_1_4:IsRecruit() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_duty_is_too_low"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(62009, {
		type = 0
	}, 62010, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = GetZeroTime() - 0
			local var_2_1 = var_1_1:getData()

			if not var_2_1:ExistSupply() then
				var_2_0 = var_2_1:GetSupplyEndTime()
			end

			var_2_1:updateSupplyTime(var_2_0)
			var_1_1:updateGuild(var_2_1)
			arg_1_0:sendNotification(GAME.GUILD_GET_SUPPLY_AWARD_DONE, {
				list = PlayerConst.addTranDrop(arg_2_0.drop_list)
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
