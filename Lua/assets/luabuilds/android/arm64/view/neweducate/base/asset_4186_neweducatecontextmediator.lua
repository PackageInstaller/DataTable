local NewEducateContextMediator = class("NewEducateContextMediator", import("view.base.ContextMediator"))

function NewEducateContextMediator:onRegister()
	NewEducateContextMediator.super.onRegister(self)
	self:bind(NewEducateBaseUI.GO_SCENE, function(arg_2_0, arg_2_1, ...)
		self:sendNotification(GAME.GO_SCENE, arg_2_1, ...)

		return
	end)
	self:bind(NewEducateBaseUI.CHANGE_SCENE, function(arg_3_0, arg_3_1, ...)
		self:sendNotification(GAME.CHANGE_SCENE, arg_3_1, ...)

		return
	end)
	self:bind(NewEducateBaseUI.GO_SUBLAYER, function(arg_4_0, arg_4_1, arg_4_2)
		self:addSubLayers(arg_4_1, nil, arg_4_2)

		return
	end)
	self:bind(NewEducateBaseUI.ON_DROP, function(arg_5_0, arg_5_1)
		if #arg_5_1.items == 0 then
			existCall(arg_5_1.removeFunc)

			return
		end

		self:addSubLayers(Context.New({
			mediator = NewEducateDropMediator,
			viewComponent = NewEducateDropLayer,
			data = arg_5_1
		}))

		return
	end)
	self:bind(NewEducateBaseUI.ON_ITEM, function(arg_6_0, arg_6_1)
		self:addSubLayers(Context.New({
			viewComponent = NewEducateMsgBoxLayer,
			mediator = NewEducateMsgBoxMediator,
			data = setmetatable({
				type = NewEducateMsgBoxLayer.TYPE.ITEM
			}, {
				__index = arg_6_1
			})
		}))

		return
	end)
	self:bind(NewEducateBaseUI.ON_BOX, function(arg_7_0, arg_7_1)
		self:addSubLayers(Context.New({
			viewComponent = NewEducateMsgBoxLayer,
			mediator = NewEducateMsgBoxMediator,
			data = setmetatable({
				type = NewEducateMsgBoxLayer.TYPE.BOX
			}, {
				__index = arg_7_1
			})
		}))

		return
	end)
	self:bind(NewEducateBaseUI.ON_SHOP, function(arg_8_0, arg_8_1)
		self:addSubLayers(Context.New({
			viewComponent = NewEducateMsgBoxLayer,
			mediator = NewEducateMsgBoxMediator,
			data = setmetatable({
				type = NewEducateMsgBoxLayer.TYPE.SHOP
			}, {
				__index = arg_8_1
			})
		}))

		return
	end)
	self:bind(NewEducateBaseUI.ON_PRIORITY_STATE, function(arg_9_0, arg_9_1)
		self:CheckPriorityState(arg_9_1)

		return
	end)

	self.contextData.char = getProxy(NewEducateProxy):GetCurChar()

	return
end

function NewEducateContextMediator:CheckPriorityState(arg_10_1)
	local var_10_0 = self.contextData.char:GetFSM()

	if not var_10_0:CheckPriorityStystem() then
		self:sendNotification(GAME.NEW_EDUCATE_CHECK_FSM)

		return
	end

	switch(var_10_0:GetPriorityState():GetSystemNo(), {
		[NewEducatePriorityFSM.SYSTEM.CHOOSE] = function()
			self:PriorityChooseHandler(arg_10_1)

			return
		end,
		[NewEducatePriorityFSM.SYSTEM.UPGRADE_ENTRY] = function()
			self:PriorityUpEntryHandler(arg_10_1)

			return
		end,
		[NewEducatePriorityFSM.SYSTEM.REPLACE_TAROT] = function()
			self:PriorityReplaceTarotHandler(arg_10_1)

			return
		end
	}, function()
		assert(false, "不合法PriorityFSM状态")

		return
	end)

	return
end

function NewEducateContextMediator:PriorityChooseHandler(arg_15_1)
	self:addSubLayers(Context.New({
		viewComponent = NewEducateChooseLayer,
		mediator = NewEducateChooseMediator,
		data = {
			onExit = function()
				self:CheckPriorityState()

				return
			end
		}
	}))

	return
end

function NewEducateContextMediator:PriorityUpEntryHandler(arg_17_1)
	local var_17_0 = {
		viewComponent = NewEducateTarotEntryLayer,
		mediator = NewEducateTarotEntryMediator
	}
	local var_17_1 = {}

	if arg_17_1 then
		var_17_1.type = arg_17_1.type or NewEducateTarotEntryLayer.TYPE.DROP
	end

	function var_17_1.onExit()
		self:CheckPriorityState()

		return
	end

	var_17_0.data = var_17_1

	self:addSubLayers(Context.New(var_17_0))

	return
end

function NewEducateContextMediator:PriorityReplaceTarotHandler(arg_19_1)
	self:addSubLayers(Context.New({
		viewComponent = NewEducateReplaceTarotLayer,
		mediator = NewEducateReplaceTarotMediator,
		data = {
			onExit = function()
				self:CheckPriorityState()

				return
			end
		}
	}))

	return
end

return NewEducateContextMediator
