local var_0_0 = class("NewEducateContextMediator", import("view.base.ContextMediator"))

function var_0_0.onRegister(arg_1_0)
	var_0_0.super.onRegister(arg_1_0)
	arg_1_0:bind(NewEducateBaseUI.GO_SCENE, function(arg_2_0, arg_2_1, ...)
		arg_1_0:sendNotification(GAME.GO_SCENE, arg_2_1, ...)

		return
	end)
	arg_1_0:bind(NewEducateBaseUI.CHANGE_SCENE, function(arg_3_0, arg_3_1, ...)
		arg_1_0:sendNotification(GAME.CHANGE_SCENE, arg_3_1, ...)

		return
	end)
	arg_1_0:bind(NewEducateBaseUI.GO_SUBLAYER, function(arg_4_0, arg_4_1, arg_4_2)
		arg_1_0:addSubLayers(arg_4_1, nil, arg_4_2)

		return
	end)
	arg_1_0:bind(NewEducateBaseUI.ON_DROP, function(arg_5_0, arg_5_1)
		if #arg_5_1.items == 0 then
			existCall(arg_5_1.removeFunc)

			return
		end

		arg_1_0:addSubLayers(Context.New({
			mediator = NewEducateDropMediator,
			viewComponent = NewEducateDropLayer,
			data = arg_5_1
		}))

		return
	end)
	arg_1_0:bind(NewEducateBaseUI.ON_ITEM, function(arg_6_0, arg_6_1)
		arg_1_0:addSubLayers(Context.New({
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
	arg_1_0:bind(NewEducateBaseUI.ON_BOX, function(arg_7_0, arg_7_1)
		arg_1_0:addSubLayers(Context.New({
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
	arg_1_0:bind(NewEducateBaseUI.ON_SHOP, function(arg_8_0, arg_8_1)
		arg_1_0:addSubLayers(Context.New({
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
	arg_1_0:bind(NewEducateBaseUI.ON_PRIORITY_STATE, function(arg_9_0, arg_9_1)
		arg_1_0:CheckPriorityState(arg_9_1)

		return
	end)

	arg_1_0.contextData.char = getProxy(NewEducateProxy):GetCurChar()

	return
end

function var_0_0.CheckPriorityState(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.contextData.char:GetFSM()

	if not var_10_0:CheckPriorityStystem() then
		arg_10_0:sendNotification(GAME.NEW_EDUCATE_CHECK_FSM)

		return
	end

	local var_10_1 = var_10_0:GetPriorityState()

	switch(var_10_1:GetSystemNo(), {
		[NewEducatePriorityFSM.SYSTEM.CHOOSE] = function()
			arg_10_0:PriorityChooseHandler(arg_10_1)

			return
		end,
		[NewEducatePriorityFSM.SYSTEM.UPGRADE_ENTRY] = function()
			arg_10_0:PriorityUpEntryHandler(arg_10_1)

			return
		end,
		[NewEducatePriorityFSM.SYSTEM.REPLACE_TAROT] = function()
			arg_10_0:PriorityReplaceTarotHandler(arg_10_1)

			return
		end
	}, function()
		assert(false, "不合法PriorityFSM状态")

		return
	end)

	return
end

function var_0_0.PriorityChooseHandler(arg_15_0, arg_15_1)
	arg_15_0:addSubLayers(Context.New({
		viewComponent = NewEducateChooseLayer,
		mediator = NewEducateChooseMediator,
		data = {
			onExit = function()
				arg_15_0:CheckPriorityState()

				return
			end
		}
	}))

	return
end

function var_0_0.PriorityUpEntryHandler(arg_17_0, arg_17_1)
	local var_17_2 = {
		viewComponent = NewEducateTarotEntryLayer,
		mediator = NewEducateTarotEntryMediator
	}
	local var_17_3 = {}

	if arg_17_1 then
		var_17_3.type = arg_17_1.type or NewEducateTarotEntryLayer.TYPE.DROP

		function var_17_3.onExit()
			arg_17_0:CheckPriorityState()

			return
		end

		var_17_2.data = var_17_3

		var_17_0(arg_17_0, var_17_1(var_17_2))

		return
	end
end

function var_0_0.PriorityReplaceTarotHandler(arg_19_0, arg_19_1)
	arg_19_0:addSubLayers(Context.New({
		viewComponent = NewEducateReplaceTarotLayer,
		mediator = NewEducateReplaceTarotMediator,
		data = {
			onExit = function()
				arg_19_0:CheckPriorityState()

				return
			end
		}
	}))

	return
end

return var_0_0
