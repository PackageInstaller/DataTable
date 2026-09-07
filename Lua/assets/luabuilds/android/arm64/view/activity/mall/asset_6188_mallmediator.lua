local MallMediator = class("MallMediator", import("view.base.ContextMediator"))

MallMediator.CHANGE_SCENE = "MallMediator.CHANGE_SCENE"
MallMediator.GO_SCENE = "MallMediator.GO_SCENE"
MallMediator.GO_SUBLAYER = "MallMediator.GO_SUBLAYER"
MallMediator.OPEN_SUMMARY_BOX = "MallMediator.OPEN_SUMMARY_BOX"
MallMediator.SETTLE_ROUND = "MallMediator.SETTLE_ROUND"
MallMediator.INPUT_GOLD = "MallMediator.INPUT_GOLD"
MallMediator.GET_GOLD_AWARD = "MallMediator.GET_GOLD_AWARD"

function MallMediator:register()
	self:bind(MallMediator.CHANGE_SCENE, function(arg_2_0, arg_2_1, ...)
		self:sendNotification(GAME.CHANGE_SCENE, arg_2_1, ...)

		return
	end)
	self:bind(MallMediator.GO_SCENE, function(arg_3_0, arg_3_1, ...)
		self:sendNotification(GAME.GO_SCENE, arg_3_1, ...)

		return
	end)
	self:bind(MallMediator.GO_SUBLAYER, function(arg_4_0, arg_4_1, arg_4_2)
		self:addSubLayers(arg_4_1, nil, arg_4_2)

		return
	end)
	self:bind(MallMediator.OPEN_SUMMARY_BOX, function(arg_5_0)
		self.viewComponent:ShowSummaryBox()

		return
	end)
	self:bind(MallMediator.SETTLE_ROUND, function(arg_6_0, arg_6_1)
		self:sendNotification(GAME.ACTIVITY_MALL_OP, {
			activity_id = arg_6_1,
			cmd = ActivityMallOPCommand.CMD.SETTLE_ROUND
		})

		return
	end)
	self:bind(MallMediator.INPUT_GOLD, function(arg_7_0, arg_7_1, arg_7_2)
		self:sendNotification(GAME.ACTIVITY_MALL_OP, {
			activity_id = arg_7_1,
			cmd = ActivityMallOPCommand.CMD.INPUT_GOLD,
			arg1 = arg_7_2
		})

		return
	end)
	self:bind(MallMediator.GET_GOLD_AWARD, function(arg_8_0, arg_8_1, arg_8_2)
		self:sendNotification(GAME.ACTIVITY_MALL_OP, {
			activity_id = arg_8_1,
			cmd = ActivityMallOPCommand.CMD.GET_GOLD_AWARD,
			arg_list = arg_8_2
		})

		return
	end)

	return
end

function MallMediator:listNotificationInterests()
	return {
		GAME.ACTIVITY_MALL_OP_DONE,
		GAME.ZERO_HOUR_OP_DONE
	}
end

function MallMediator:handleNotification(arg_10_1)
	local var_10_0 = arg_10_1:getName()
	local var_10_1 = arg_10_1:getBody()

	if var_10_0 == GAME.ACTIVITY_MALL_OP_DONE then
		local var_10_2 = var_10_1.levels[1]
		local var_10_3 = var_10_1.levels[2]
		local var_10_4 = {}

		if var_10_1.cmd == ActivityMallOPCommand.CMD.SETTLE_ROUND then
			table.insert(var_10_4, function(arg_11_0)
				self.viewComponent:ShowSettleBox(var_10_2, arg_11_0)

				return
			end)

			if #var_10_1.awards >= 0 then
				table.insert(var_10_4, function(arg_12_0)
					self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_10_1.awards, arg_12_0)

					return
				end)
			end

			if var_10_1.levels[2] ~= var_10_1.levels[1] then
				table.insert(var_10_4, function(arg_13_0)
					self.viewComponent:ShowUpgradeBox(var_10_2, var_10_3, arg_13_0)

					return
				end)
			end
		end

		seriesAsync(var_10_4, function()
			self.viewComponent:UpdateData()
			self.viewComponent:UpdateView()

			return
		end)
	elseif var_10_0 == GAME.ZERO_HOUR_OP_DONE then
		self.viewComponent:UpdateData()
		self.viewComponent:UpdateView()
	end

	return
end

return MallMediator
