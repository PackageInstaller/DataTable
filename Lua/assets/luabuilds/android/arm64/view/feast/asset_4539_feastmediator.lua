local FeastMediator = class("FeastMediator", import("view.backYard.CourtYardMediator"))

FeastMediator.SET_UP = "FeastMediator:SET_UP"
FeastMediator.MAKE_TICKET = "FeastMediator:MAKE_TICKET"
FeastMediator.GIVE_TICKET = "FeastMediator:GIVE_TICKET"
FeastMediator.GIVE_GIFT = "FeastMediator:GIVE_GIFT"
FeastMediator.EVENT_PT_OPERATION = "FeastMediator:EVENT_PT_OPERATION"
FeastMediator.ON_SUBMIT = "FeastMediator:ON_SUBMIT"
FeastMediator.ON_GO = "FeastMediator:ON_GO"
FeastMediator.ON_SUBMIT_ONE_KEY = "FeastMediator:ON_SUBMIT_ONE_KEY"
FeastMediator.ON_SHIP_ENTER_FEAST = "FeastMediator:ON_SHIP_ENTER_FEAST"

function FeastMediator:register()
	self.caches = {}

	local var_1_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_FEAST)

	self:bind(FeastMediator.SET_UP, function(arg_2_0, arg_2_1)
		_courtyard = CourtYardBridge.New((self:GenCourtYardData(arg_2_1)))

		return
	end)
	self:bind(FeastMediator.MAKE_TICKET, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.FEAST_OP, {
			activityId = var_1_0.id,
			cmd = FeastDorm.OP_MAKE_TICKET,
			arg1 = arg_3_1
		})

		return
	end)
	self:bind(FeastMediator.GIVE_TICKET, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.FEAST_OP, {
			activityId = var_1_0.id,
			cmd = FeastDorm.OP_GIVE_TICKET,
			arg1 = arg_4_1
		})

		return
	end)
	self:bind(FeastMediator.GIVE_GIFT, function(arg_5_0, arg_5_1)
		self:sendNotification(GAME.FEAST_OP, {
			activityId = var_1_0.id,
			cmd = FeastDorm.OP_GIVE_GIFT,
			arg1 = arg_5_1
		})

		return
	end)
	self:bind(FeastMediator.EVENT_PT_OPERATION, function(arg_6_0, arg_6_1)
		self:sendNotification(GAME.ACT_NEW_PT, arg_6_1)

		return
	end)
	self:bind(FeastMediator.ON_SUBMIT, function(arg_7_0, arg_7_1)
		self:sendNotification(GAME.SUBMIT_TASK, arg_7_1)

		return
	end)
	self:bind(FeastMediator.ON_GO, function(arg_8_0, arg_8_1)
		self:HandleTaskGo(arg_8_1)

		return
	end)
	self:bind(FeastMediator.ON_SUBMIT_ONE_KEY, function(arg_9_0, arg_9_1)
		self:sendNotification(GAME.SUBMIT_TASK_ONESTEP, {
			resultList = arg_9_1
		})

		return
	end)
	self:bind(FeastMediator.ON_SHIP_ENTER_FEAST, function(arg_10_0, arg_10_1)
		if _courtyard then
			_courtyard:GetController():ShipEnterFeast(arg_10_1)
		end

		return
	end)
	self:sendNotification(GAME.FEAST_OP, {
		activityId = var_1_0.id,
		cmd = FeastDorm.OP_ENTER
	})

	return
end

function FeastMediator:HandleTaskGo(arg_11_1)
	if arg_11_1:IsActRoutineType() and arg_11_1:getConfig("sub_type") == 430 then
		-- block empty
	elseif arg_11_1:IsActRoutineType() and arg_11_1:getConfig("sub_type") == 431 then
		self.viewComponent:emit(FeastScene.GO_INTERACTION)
	elseif arg_11_1:IsActType() and (arg_11_1:getConfig("sub_type") == 432 or arg_11_1:getConfig("sub_type") == 433) then
		self.viewComponent:emit(FeastScene.GO_INVITATION)
	elseif arg_11_1:IsActType() and arg_11_1:getConfig("sub_type") == 417 then
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 56)
	else
		self:sendNotification(GAME.TASK_GO, {
			taskVO = arg_11_1
		})
	end

	return
end

function FeastMediator:listNotificationInterests()
	return {
		CourtYardEvent._QUIT,
		CourtYardEvent._INITED,
		CourtYardEvent._FEAST_INTERACTION,
		GAME.ACT_NEW_PT_DONE,
		GAME.SUBMIT_TASK_DONE,
		GAME.FEAST_OP_DONE,
		TaskProxy.TASK_ADDED,
		TaskProxy.TASK_UPDATED,
		TaskProxy.TASK_REMOVED,
		TaskProxy.TASK_DELETE,
		ActivityProxy.ACTIVITY_UPDATED
	}
end

function FeastMediator:handleNotification(arg_13_1)
	local var_13_0 = arg_13_1:getName()
	local var_13_1 = arg_13_1:getBody()
	local var_13_2 = arg_13_1:getType()

	if var_13_0 == CourtYardEvent._QUIT then
		self.viewComponent:emit(BaseUI.ON_BACK)
	elseif var_13_0 == CourtYardEvent._INITED then
		self.viewComponent:OnCourtYardLoaded()
	elseif var_13_0 == CourtYardEvent._FEAST_INTERACTION then
		local var_13_3 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_FEAST)
		local var_13_4

		if not var_13_3 or var_13_3:isEnd() then
			do return end

			var_13_4 = {
				activityId = var_13_3.id,
				cmd = FeastDorm.OP_INTERACTION
			}
		end

		var_13_4.arg1 = var_13_1.groupId
		var_13_4.arg2 = var_13_1.special

		self:sendNotification(GAME.FEAST_OP, var_13_4)
	elseif var_13_0 == GAME.FEAST_OP_DONE then
		local var_13_5 = 0
		local var_13_6 = true

		if var_13_1.cmd == FeastDorm.OP_INTERACTION then
			_courtyard:GetController():UpdateBubble(var_13_1.groupId, var_13_1.value)

			if var_13_1.chat and var_13_1.chat ~= "" then
				_courtyard:GetController():UpdateChatBubble(var_13_1.groupId, var_13_1.chat)
			end

			var_13_5 = CourtYardConst.FEAST_EFFECT_TIME
		elseif var_13_1.cmd == FeastDorm.OP_GIVE_TICKET then
			_courtyard:GetController():AddShipWithSpecialPosition((getProxy(FeastProxy):getRawData():GetFeastShip(var_13_1.groupId)))
			self.viewComponent:emit(FeastScene.ON_GOT_TICKET, var_13_1.awards)

			local var_13_7 = getProxy(FeastProxy):getRawData():GetInvitedFeastShip(var_13_1.groupId)

			var_13_6 = false
		elseif var_13_1.cmd == FeastDorm.OP_RANDOM_SHIPS then
			_courtyard:GetController():ExitAllShip()

			local var_13_8 = {}

			for iter_13_0, iter_13_1 in ipairs(var_13_1.ships or {}) do
				table.insert(var_13_8, function(arg_14_0)
					_courtyard:GetController():AddShip(iter_13_1, 0, 0)
					onNextTick(arg_14_0)

					return
				end)
			end

			seriesAsync(var_13_8)
		elseif var_13_1.cmd == FeastDorm.OP_GIVE_GIFT then
			self.viewComponent:emit(FeastScene.ON_GOT_GIFT, var_13_1.awards)

			local var_13_9 = getProxy(FeastProxy):getRawData():GetInvitedFeastShip(var_13_1.groupId)

			var_13_6 = false
		elseif var_13_1.cmd == FeastDorm.OP_MAKE_TICKET then
			self.viewComponent:emit(FeastScene.ON_MAKE_TICKET, var_13_1.groupId)
		end

		if #var_13_1.awards > 0 and var_13_6 then
			table.insert(self.caches, {
				var_13_1.awards,
				var_13_1.cmd == FeastDorm.OP_INTERACTION and #self.caches == 0 and var_13_5 or 0
			})

			if #self.caches == 1 then
				self:DisplayAwards()
			end
		end
	elseif var_13_0 == TaskProxy.TASK_ADDED or var_13_0 == TaskProxy.TASK_UPDATED or var_13_0 == TaskProxy.TASK_REMOVED or var_13_0 == TaskProxy.TASK_DELETE then
		self.viewComponent:emit(FeastScene.ON_TASK_UPDATE)
	elseif var_13_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_13_1.id == ActivityConst.FEAST_PT_ACT then
			self.viewComponent:emit(FeastScene.ON_ACT_UPDATE)
		end
	elseif var_13_0 == GAME.SUBMIT_TASK_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_13_1, function()
			getProxy(FeastProxy):HandleTaskStories(var_13_2)

			return
		end)
	elseif var_13_0 == GAME.ACT_NEW_PT_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_13_1.awards, function()
			return
		end)
	end

	return
end

function FeastMediator:DisplayAwards()
	local var_17_0 = self.caches[1][1]
	local var_17_1 = self.caches[1][2]
	local var_17_2 = {}

	if self.caches[1][2] > 0 then
		table.insert(var_17_2, function(arg_18_0)
			if not self.viewComponent then
				return
			end

			onDelayTick(arg_18_0, var_17_1, 1)

			return
		end)
	end

	table.insert(var_17_2, function(arg_19_0)
		if not self.viewComponent then
			return
		end

		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_17_0, arg_19_0)

		return
	end)
	seriesAsync(var_17_2, function()
		table.remove(self.caches, 1)

		if #self.caches > 0 then
			self:DisplayAwards()
		end

		return
	end)

	return
end

return FeastMediator
