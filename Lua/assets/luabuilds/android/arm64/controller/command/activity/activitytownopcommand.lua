local var_0_0 = class("ActivityTownOPCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback
	local var_1_2 = getProxy(ActivityProxy)
	local var_1_3 = getProxy(ActivityProxy):getActivityById(var_1_0.activity_id)

	if not var_1_3 or var_1_3:isEnd() then
		return
	end

	local var_1_4 = pg.ConnectionMgr.GetInstance()

	;({
		activity_id = var_1_0.activity_id
	}).cmd = var_1_0.cmd or 0
	;({
		activity_id = var_1_0.activity_id
	}).arg1 = var_1_0.arg1 or 0
	;({
		activity_id = var_1_0.activity_id
	}).arg2 = var_1_0.arg2 or 0
	;({
		activity_id = var_1_0.activity_id
	}).arg_list = var_1_0.arg_list or {}
	;({
		activity_id = var_1_0.activity_id
	}).kvargs1 = var_1_0.kvargs1

	var_1_4:Send(11202, {
		activity_id = var_1_0.activity_id
	}, 11203, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_1 = PlayerConst.addTranDrop(arg_2_0.award_list)

			var_1_3 = var_1_2:getActivityById(var_1_0.activity_id)

			if var_1_3:getConfig("type") == ActivityConst.ACTIVITY_TYPE_TOWN2 then
				switch(var_1_0.cmd, {
					[TownActivity2.OPERATION.UPGRADE_TOWN] = function()
						return
					end,
					[TownActivity2.OPERATION.UPGRADE_PLACE] = function()
						var_1_3:OnUpgradePlace(var_1_0.arg1, arg_2_0.number[1])

						return
					end,
					[TownActivity2.OPERATION.CHANGE_SHIPS] = function()
						var_1_3:OnChangeShips(var_1_0.kvargs1)

						return
					end,
					[TownActivity2.OPERATION.CLICK_BUBBLE] = function()
						var_1_3:OnGetBubbleAward(var_1_0.arg_list, arg_2_0.number)

						return
					end,
					[TownActivity2.OPERATION.SETTLE_GOLD] = function()
						var_1_3:OnGatherPlaceGold(var_1_0.arg1, arg_2_0.number[2])

						return
					end,
					[TownActivity2.OPERATION.ALL_GOLD] = function()
						var_1_3:OnAllGatherPlaceGold(arg_2_0.number)

						return
					end
				})
			else
				switch(var_1_0.cmd, {
					[TownActivity.OPERATION.UPGRADE_TOWN] = function()
						var_1_3:OnUpgradeTown(arg_2_0.number[1])

						return
					end,
					[TownActivity.OPERATION.UPGRADE_PLACE] = function()
						var_1_3:OnUpgradePlace(var_1_0.arg1, arg_2_0.number[1])

						return
					end,
					[TownActivity.OPERATION.CHANGE_SHIPS] = function()
						var_1_3:OnChangeShips(var_1_0.kvargs1)

						return
					end,
					[TownActivity.OPERATION.CLICK_BUBBLE] = function()
						var_1_3:OnGetBubbleAward(var_1_0.arg_list, arg_2_0.number)

						return
					end,
					[TownActivity.OPERATION.SETTLE_GOLD] = function()
						var_1_3:OnSettleGold(arg_2_0.number[2])

						return
					end
				})
			end

			var_1_2:updateActivity(var_1_3)

			if var_1_1 then
				var_1_1()
			end

			arg_1_0:sendNotification(GAME.ACTIVITY_TOWN_OP_DONE, {
				awards = var_2_1,
				cmd = var_1_0.cmd
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
