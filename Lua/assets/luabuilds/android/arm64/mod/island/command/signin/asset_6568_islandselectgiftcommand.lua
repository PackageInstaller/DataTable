local IslandSelectgiftCommand = class("IslandSelectgiftCommand", pm.SimpleCommand)

function IslandSelectgiftCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.pos
	local var_1_2 = var_1_0.islandId
	local var_1_3 = getProxy(IslandProxy):GetIsland()
	local var_1_4 = var_1_3.id == var_1_0.islandId

	if var_1_3.id ~= var_1_0.islandId then
		local var_1_5 = getProxy(IslandProxy):GetSharedIsland():GetSignInAgency()

		if var_1_5:IsFetched(getProxy(PlayerProxy):getRawData().id) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_get_git_tip"))

			return
		end

		if var_1_5:IsMaxFetchCnt() then
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
			local var_2_1 = var_1_3:GetSignInAgency()

			if var_1_4 then
				var_2_1:SetFetchCnt()
			else
				var_2_1:SetOtherFetchCnt()
			end

			self:sendNotification(GAME.ISLAND_SELECT_GIFT_DONE, {
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

return IslandSelectgiftCommand
