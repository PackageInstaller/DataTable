local var_0_0 = class("IslandFollowerOpCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_9000
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.shipId
	local var_1_2 = var_1_0.op
	local var_1_3 = getProxy(IslandProxy)
	local var_1_4 = var_1_3.GetIsland(var_1_9000)
	local var_1_5 = var_1_4:GetFollowerAgency()
	local var_1_6 = var_1_4:GetCharacterAgency()

	if not var_1_6.GetShipById(var_1_3, var_1_0.shipId) then
		return
	end

	if var_1_0.op == IslandConst.FOLLOWER_OP_ADD and not var_1_6:CanFollowPlayer(var_1_0.shipId) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_follower_state_no_normal"))

		return
	end

	if var_1_0.op == IslandConst.FOLLOWER_OP_ADD and var_1_4:GetFollowerAgency():ReachMaxCnt() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_follower_cnt_max"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(21630, {
		ship_id = var_1_0.shipId,
		type = var_1_0.op
	}, 21631, function(arg_2_0)
		if arg_2_0.result == 0 then
			if var_1_2 == IslandConst.FOLLOWER_OP_ADD then
				var_1_5:AddFollower(var_1_1)
				pg.TipsMgr.GetInstance():ShowTips(i18n("island_follow_success"))
			elseif var_1_2 == IslandConst.FOLLOWER_OP_DEL then
				var_1_5:DelFollower(var_1_1)
				pg.TipsMgr.GetInstance():ShowTips(i18n("island_cancel_follow_success"))
			end

			arg_1_0:sendNotification(GAME.ISLAND_FOLLOWER_OP_DONE, var_1_1)

			if var_1_0.callback then
				var_1_0.callback()
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
