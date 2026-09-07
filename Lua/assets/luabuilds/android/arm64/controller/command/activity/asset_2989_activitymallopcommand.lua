local ActivityMallOPCommand = class("ActivityMallOPCommand", pm.SimpleCommand)

ActivityMallOPCommand.CMD = {
	START_ORDER = 1,
	GET_STAFF_DATA = 8,
	TRIGGER_POINT = 6,
	SET_FLOOR_STAFF = 7,
	INPUT_GOLD = 4,
	SETTLE_ROUND = 3,
	COMPLETE_ORDER = 2
}

function ActivityMallOPCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback
	local var_1_2 = getProxy(ActivityProxy)
	local var_1_3 = var_1_0.activity_id
	local var_1_4 = var_1_2:getActivityById(var_1_0.activity_id)

	if not var_1_4 or var_1_4:isEnd() then
		return
	end

	local var_1_5 = {
		activity_id = var_1_0.activity_id
	}

	var_1_5.cmd = var_1_0.cmd or 0
	var_1_5.arg1 = var_1_0.arg1 or 0
	var_1_5.arg2 = var_1_0.arg2 or 0
	var_1_5.arg_list = var_1_0.arg_list or {}

	pg.ConnectionMgr.GetInstance():Send(11202, var_1_5, 11203, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_1_2:getActivityById(var_1_3)
			local var_2_1 = var_2_0:GetLevelData().level
			local var_2_2 = var_2_1

			switch(var_1_0.cmd, {
				[ActivityMallOPCommand.CMD.START_ORDER] = function()
					var_2_0:OnStartOrderDone(var_1_0.arg1, arg_2_0.number[1], var_1_0.arg_list)

					for iter_3_0, iter_3_1 in ipairs(MallOrder.GetCost(var_1_0.arg1)) do
						reducePlayerOwn(iter_3_1)
					end

					return
				end,
				[ActivityMallOPCommand.CMD.COMPLETE_ORDER] = function()
					var_2_2 = arg_2_0.number[1]

					var_2_0:OnCompleteOrderDone(var_1_0.arg1)

					return
				end,
				[ActivityMallOPCommand.CMD.SETTLE_ROUND] = function()
					var_2_2 = arg_2_0.number[1]

					var_2_0:NextRound(arg_2_0.number)

					return
				end,
				[ActivityMallOPCommand.CMD.INPUT_GOLD] = function()
					var_2_0:ReduceGold(var_1_0.arg1)
					pg.TipsMgr.GetInstance():ShowTips(i18n("mall_gold_input_success_tip"))

					return
				end,
				[ActivityMallOPCommand.CMD.TRIGGER_POINT] = function()
					var_2_0:OnTriggerPointDone(var_1_0.arg1)

					return
				end,
				[ActivityMallOPCommand.CMD.SET_FLOOR_STAFF] = function()
					var_2_0:OnUpdateFloorStaffDone(var_1_0.arg_list)

					return
				end,
				[ActivityMallOPCommand.CMD.GET_STAFF_DATA] = function()
					assert(#arg_2_0.number % 2 == 0, "staff attr data must be even")
					var_2_0:SetStaffExtraData(var_1_0.arg1, arg_2_0.number)

					return
				end
			})

			if var_2_1 ~= var_2_1 then
				var_2_0:OnUpgradeDone(var_2_1)
			end

			var_1_2:updateActivity(var_2_0)

			local var_2_4 = GAME.ACTIVITY_MALL_OP_DONE
			local var_2_5 = {
				cmd = var_1_0.cmd,
				awards = PlayerConst.addTranDrop(arg_2_0.award_list),
				levels = {
					var_2_1,
					var_2_1
				}
			}

			if var_1_0.cmd == ActivityMallOPCommand.CMD.COMPLETE_ORDER then
				var_2_5.completeOrderId = var_1_0.arg1 or 0
			end

			self:sendNotification(var_2_4, var_2_5)
			existCall(var_1_1)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return ActivityMallOPCommand
