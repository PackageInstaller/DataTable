local MallOrderMediator = class("MallOrderMediator", import("view.base.ContextMediator"))

MallOrderMediator.START_ORDER = "MallOrderMediator.START_ORDER"
MallOrderMediator.COMPLETE_ORDER = "MallOrderMediator.COMPLETE_ORDER"

function MallOrderMediator:register()
	self:bind(MallOrderMediator.START_ORDER, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		self:sendNotification(GAME.ACTIVITY_MALL_OP, {
			activity_id = arg_2_1,
			cmd = ActivityMallOPCommand.CMD.START_ORDER,
			arg1 = arg_2_2,
			arg_list = arg_2_3
		})

		return
	end)
	self:bind(MallOrderMediator.COMPLETE_ORDER, function(arg_3_0, arg_3_1, arg_3_2)
		self:sendNotification(GAME.ACTIVITY_MALL_OP, {
			activity_id = arg_3_1,
			cmd = ActivityMallOPCommand.CMD.COMPLETE_ORDER,
			arg1 = arg_3_2
		})

		return
	end)

	return
end

function MallOrderMediator:listNotificationInterests()
	return {
		GAME.ACTIVITY_MALL_OP_DONE,
		GAME.ZERO_HOUR_OP_DONE
	}
end

function MallOrderMediator:handleNotification(arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	if var_5_0 == GAME.ACTIVITY_MALL_OP_DONE then
		local var_5_2 = var_5_1.levels[1]
		local var_5_3 = var_5_1.levels[2]
		local var_5_4 = {}

		if var_5_1.cmd == ActivityMallOPCommand.CMD.COMPLETE_ORDER then
			self.viewComponent:ClearSelectedIds()
			table.insert(var_5_4, function(arg_6_0)
				self.viewComponent:ShowCompleteDialogue(arg_6_0)

				return
			end)

			local var_5_5 = pg.activity_mall_custom_order[var_5_1.completeOrderId].story_unlock

			if pg.activity_mall_custom_order[var_5_1.completeOrderId].story_unlock ~= "" then
				table.insert(var_5_4, function(arg_7_0)
					pg.NewStoryMgr.GetInstance():Play(var_5_5, arg_7_0)

					return
				end)
			end

			if #var_5_1.awards >= 0 then
				table.insert(var_5_4, function(arg_8_0)
					self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_5_1.awards, arg_8_0)

					return
				end)
			end

			if var_5_1.levels[2] ~= var_5_1.levels[1] then
				table.insert(var_5_4, function(arg_9_0)
					self.viewComponent:ShowUpgradeBox(var_5_2, var_5_3, arg_9_0)

					return
				end)
			end
		end

		seriesAsync(var_5_4, function()
			self.viewComponent:UpdateData()
			self.viewComponent:UpdateView()

			return
		end)
	elseif var_5_0 == GAME.ZERO_HOUR_OP_DONE then
		self.viewComponent:UpdateData()
		self.viewComponent:UpdateView()
	end

	return
end

return MallOrderMediator
