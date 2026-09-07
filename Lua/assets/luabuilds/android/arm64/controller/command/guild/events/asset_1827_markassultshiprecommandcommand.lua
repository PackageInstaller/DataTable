local MarkAssultShipRecommandCommand = class("MarkAssultShipRecommandCommand", pm.SimpleCommand)

function MarkAssultShipRecommandCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.shipId
	local var_1_2 = var_1_0.cmd
	local var_1_3 = getProxy(GuildProxy)
	local var_1_4 = var_1_3:getRawData()

	if not var_1_4 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_no_exist"))

		return
	end

	if not GuildMember.IsAdministrator(var_1_4:getSelfDuty()) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_commander_and_sub_op"))

		return
	end

	local var_1_5 = GuildAssaultFleet.GetUserId(var_1_0.shipId)
	local var_1_6 = GuildAssaultFleet.GetRealId(var_1_0.shipId)

	print(var_1_5, var_1_6, var_1_0.cmd)
	pg.ConnectionMgr.GetInstance():Send(61033, {
		recommend_uid = var_1_5,
		recommend_shipid = var_1_6,
		cmd = var_1_0.cmd
	}, 61034, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_1_3:getData()
			local var_2_1 = var_2_0:getMemberById(var_1_5)

			assert(var_2_1)

			local var_2_2 = var_2_1:GetAssaultFleet()

			if var_1_2 == GuildConst.RECOMMAND_SHIP then
				var_2_2:SetShipBeRecommanded(var_1_6, true)
				pg.TipsMgr.GetInstance():ShowTips(i18n("guild_assult_ship_recommend"))
			elseif var_1_2 == GuildConst.CANCEL_RECOMMAND_SHIP then
				var_2_2:SetShipBeRecommanded(var_1_6, false)
				pg.TipsMgr.GetInstance():ShowTips(i18n("guild_cancel_assult_ship_recommend"))
			end

			var_1_3:updateGuild(var_2_0)
			self:sendNotification(GAME.GUILD_RECOMMAND_ASSULT_SHIP_DONE, {
				shipId = var_1_1
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return MarkAssultShipRecommandCommand
