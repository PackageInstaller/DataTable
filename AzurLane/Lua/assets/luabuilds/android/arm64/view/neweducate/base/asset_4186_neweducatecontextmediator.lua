class = var_0_10000

local var_0_0 = "NewEducateContextMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

function var_0_1.onRegister(arg_1_0)
	var_0_1.super.onRegister(arg_1_0)

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bind

	NewEducateBaseUI = var_1_10004

	var_1_1(var_1_0, var_1_10004.GO_SCENE, function(arg_2_0, arg_2_1, ...)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.GO_SCENE, arg_2_1, ...)

		return
	end)

	local var_1_2 = arg_1_0
	local var_1_3 = arg_1_0.bind

	NewEducateBaseUI = var_4

	var_1_3(var_1_2, var_4.CHANGE_SCENE, function(arg_3_0, arg_3_1, ...)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.CHANGE_SCENE, arg_3_1, ...)

		return
	end)

	local var_1_4 = arg_1_0
	local var_1_5 = arg_1_0.bind

	NewEducateBaseUI = var_4

	var_1_5(var_1_4, var_4.GO_SUBLAYER, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_1_0

		var_3.addSubLayers(var_4_0, arg_4_1, nil, arg_4_2)

		return
	end)

	local var_1_6 = arg_1_0
	local var_1_7 = arg_1_0.bind

	NewEducateBaseUI = var_4

	var_1_7(var_1_6, var_4.ON_DROP, function(arg_5_0, arg_5_1)
		if #arg_5_1.items == 0 then
			existCall = var_2

			var_2(arg_5_1.removeFunc)

			return
		end

		local var_5_0 = arg_1_0
		local var_5_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_5_2 = var_2_10005.New
		local var_5_3 = {}

		NewEducateDropMediator = var_2_10008
		var_5_3.mediator = var_2_10008
		NewEducateDropLayer = var_2_10008
		var_5_3.viewComponent = var_2_10008
		var_5_3.data = arg_5_1

		var_5_1(var_5_0, var_5_2(var_5_3))

		return
	end)

	local var_1_8 = arg_1_0
	local var_1_9 = arg_1_0.bind

	NewEducateBaseUI = var_4

	var_1_9(var_1_8, var_4.ON_ITEM, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_6_2 = var_2_10005.New
		local var_6_3 = {}

		NewEducateMsgBoxLayer = var_2_10008
		var_6_3.viewComponent = var_2_10008
		NewEducateMsgBoxMediator = var_2_10008
		var_6_3.mediator = var_2_10008
		setmetatable = var_2_10008

		local var_6_4 = {}

		NewEducateMsgBoxLayer = var_2_10011
		var_6_4.type = var_2_10011.TYPE.ITEM
		var_6_3.data = var_2_10008(var_6_4, {
			__index = arg_6_1
		})

		var_6_1(var_6_0, var_6_2(var_6_3))

		return
	end)

	local var_1_10 = arg_1_0
	local var_1_11 = arg_1_0.bind

	NewEducateBaseUI = var_4

	var_1_11(var_1_10, var_4.ON_BOX, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_1_0
		local var_7_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_7_2 = var_2_10005.New
		local var_7_3 = {}

		NewEducateMsgBoxLayer = var_2_10008
		var_7_3.viewComponent = var_2_10008
		NewEducateMsgBoxMediator = var_2_10008
		var_7_3.mediator = var_2_10008
		setmetatable = var_2_10008

		local var_7_4 = {}

		NewEducateMsgBoxLayer = var_2_10011
		var_7_4.type = var_2_10011.TYPE.BOX
		var_7_3.data = var_2_10008(var_7_4, {
			__index = arg_7_1
		})

		var_7_1(var_7_0, var_7_2(var_7_3))

		return
	end)

	local var_1_12 = arg_1_0
	local var_1_13 = arg_1_0.bind

	NewEducateBaseUI = var_4

	var_1_13(var_1_12, var_4.ON_SHOP, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_1_0
		local var_8_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_8_2 = var_2_10005.New
		local var_8_3 = {}

		NewEducateMsgBoxLayer = var_2_10008
		var_8_3.viewComponent = var_2_10008
		NewEducateMsgBoxMediator = var_2_10008
		var_8_3.mediator = var_2_10008
		setmetatable = var_2_10008

		local var_8_4 = {}

		NewEducateMsgBoxLayer = var_2_10011
		var_8_4.type = var_2_10011.TYPE.SHOP
		var_8_3.data = var_2_10008(var_8_4, {
			__index = arg_8_1
		})

		var_8_1(var_8_0, var_8_2(var_8_3))

		return
	end)

	local var_1_14 = arg_1_0
	local var_1_15 = arg_1_0.bind

	NewEducateBaseUI = var_4

	var_1_15(var_1_14, var_4.ON_PRIORITY_STATE, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_1_0

		var_2.CheckPriorityState(var_9_0, arg_9_1)

		return
	end)

	local var_1_16 = arg_1_0.contextData

	getProxy = var_1_10002
	NewEducateProxy = var_4

	local var_1_17 = var_1_10002(var_4)

	var_1_16.char = var_2.GetCurChar(var_1_17)

	return
end

function var_0_1.CheckPriorityState(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.contextData.char
	local var_10_1 = var_2.GetFSM(var_10_0)

	if not var_2.CheckPriorityStystem(var_10_1) then
		local var_10_2 = arg_10_0
		local var_10_3 = arg_10_0.sendNotification

		GAME = var_1_10006

		var_10_3(var_10_2, var_1_10006.NEW_EDUCATE_CHECK_FSM)

		return
	end

	local var_10_4 = var_2:GetPriorityState()

	switch = var_10_0

	local var_10_5 = var_10_4
	local var_10_6 = var_10_4.GetSystemNo(var_10_5)
	local var_10_7 = {}

	NewEducatePriorityFSM = var_10_5
	var_10_7[var_10_5.SYSTEM.CHOOSE] = function()
		local var_11_0 = arg_10_0

		var_0.PriorityChooseHandler(var_11_0, arg_10_1)

		return
	end
	NewEducatePriorityFSM = var_8
	var_10_7[var_8.SYSTEM.UPGRADE_ENTRY] = function()
		local var_12_0 = arg_10_0

		var_0.PriorityUpEntryHandler(var_12_0, arg_10_1)

		return
	end
	NewEducatePriorityFSM = var_8
	var_10_7[var_8.SYSTEM.REPLACE_TAROT] = function()
		local var_13_0 = arg_10_0

		var_0.PriorityReplaceTarotHandler(var_13_0, arg_10_1)

		return
	end

	var_10_0(var_10_6, var_10_7, function()
		assert = var_2_10000

		var_2_10000(false, "不合法PriorityFSM状态")

		return
	end)

	return
end

function var_0_1.PriorityChooseHandler(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.addSubLayers

	Context = var_1_10005

	local var_15_2 = var_1_10005.New
	local var_15_3 = {}

	NewEducateChooseLayer = var_1_10008
	var_15_3.viewComponent = var_1_10008
	NewEducateChooseMediator = var_1_10008
	var_15_3.mediator = var_1_10008
	var_15_3.data = {
		onExit = function()
			local var_16_0 = arg_15_0

			var_0.CheckPriorityState(var_16_0)

			return
		end
	}

	var_15_1(var_15_0, var_15_2(var_15_3))

	return
end

function var_0_1.PriorityUpEntryHandler(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0
	local var_17_1 = arg_17_0.addSubLayers

	Context = var_1_10005

	local var_17_2 = var_1_10005.New
	local var_17_3 = {}

	NewEducateTarotEntryLayer = var_1_10008
	var_17_3.viewComponent = var_1_10008
	NewEducateTarotEntryMediator = var_1_10008
	var_17_3.mediator = var_1_10008

	local var_17_4 = {}

	if not arg_17_1 or not arg_17_1.type then
		NewEducateTarotEntryLayer = var_1_10009
		var_1_10009 = var_1_10009.TYPE.DROP
	end

	var_17_4.type = var_1_10009

	function var_17_4.onExit()
		local var_18_0 = arg_17_0

		var_0.CheckPriorityState(var_18_0)

		return
	end

	var_17_3.data = var_17_4

	var_17_1(var_17_0, var_17_2(var_17_3))

	return
end

function var_0_1.PriorityReplaceTarotHandler(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0
	local var_19_1 = arg_19_0.addSubLayers

	Context = var_1_10005

	local var_19_2 = var_1_10005.New
	local var_19_3 = {}

	NewEducateReplaceTarotLayer = var_1_10008
	var_19_3.viewComponent = var_1_10008
	NewEducateReplaceTarotMediator = var_1_10008
	var_19_3.mediator = var_1_10008
	var_19_3.data = {
		onExit = function()
			local var_20_0 = arg_19_0

			var_0.CheckPriorityState(var_20_0)

			return
		end
	}

	var_19_1(var_19_0, var_19_2(var_19_3))

	return
end

return var_0_1
