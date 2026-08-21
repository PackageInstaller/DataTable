local var_0_0 = class("IslandSelectgiftCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.pos
	local var_1_2 = var_1_0.islandId
	local var_1_3 = getProxy(IslandProxy)

	if var_1_3:GetIsland().id ~= var_1_0.islandId then
		local var_1_4 = getProxy(IslandProxy):GetSharedIsland():GetSignInAgency()

		if var_1_4:IsFetched(getProxy(PlayerProxy):getRawData().id) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_get_git_tip"))

			return
		end

		if var_1_4:IsMaxFetchCnt() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_get_git_cnt_tip"))

			return
		end
	end

	pg.ConnectionMgr.GetInstance():Send(21310, {
		island_id = var_1_2,
		pos = var_1_1
	}, 21311, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = IslandDropHelper.AddItems(arg_2_0)
			local var_2_1 = var_0:GetSignInAgency()

			if var_0 then
				var_2_1:SetFetchCnt()
			else
				var_2_1:SetOtherFetchCnt()
			end

			arg_1_0:sendNotification(GAME.ISLAND_SELECT_GIFT_DONE, {
				dropData = var_2_0
			})
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandGetGift(var_1_2))
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
