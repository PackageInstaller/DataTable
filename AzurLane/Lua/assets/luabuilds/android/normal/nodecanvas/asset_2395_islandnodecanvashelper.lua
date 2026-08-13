local function var_0_0(arg_1_0, arg_1_1)
	_IslandGetUnit = var_1_10002

	return var_1_10002(arg_1_0, arg_1_1) and var_2._go
end

local var_0_1 = _IslandFindUnit

local function var_0_2(arg_2_0, arg_2_1)
	_IslandCore = var_1_10002

	if not var_1_10002 then
		return nil
	end

	_IslandCore = var_1_10002

	local var_2_0 = var_1_10002:GetView()

	if not var_2.GetUnitModuleWithType(var_2_0, arg_2_0, arg_2_1) then
		return nil
	end

	return var_2
end

local var_0_3 = _IslandGetUnit

local function var_0_4(arg_3_0, arg_3_1)
	_IslandCore = var_1_10002

	if not var_1_10002 then
		return nil
	end

	_IslandCore = var_1_10002

	local var_3_0 = var_1_10002
	local var_3_1 = var_1_10002.Link

	ISLAND_EVT = var_1_10004

	var_3_1(var_3_0, var_1_10004.RMOVE_UNIT, arg_3_0, arg_3_1)

	return
end

local var_0_5 = _IslandDestoryUnit

local function var_0_6(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	_IslandCore = var_1_10005

	if not var_1_10005 then
		return nil
	end

	_IslandCore = var_1_10005

	local var_4_0 = var_1_10005
	local var_4_1 = var_1_10005.Link

	ISLAND_EVT = var_1_10007

	var_4_1(var_4_0, var_1_10007.MOVE_UNIT, {
		id = arg_4_1,
		type = arg_4_0,
		position = arg_4_2,
		speed = arg_4_3,
		charaRadius = arg_4_4
	})

	return
end

local var_0_7 = _IslandMoveUnit

local function var_0_8(arg_5_0, arg_5_1)
	_IslandCore = var_1_10002

	if not var_1_10002 then
		return nil
	end

	_IslandCore = var_1_10002

	local var_5_0 = var_1_10002
	local var_5_1 = var_1_10002.Link

	ISLAND_EVT = var_1_10004

	var_5_1(var_5_0, var_1_10004.STOP_MOVE_UNIT, {
		id = arg_5_1,
		type = arg_5_0
	})

	return
end

local var_0_9 = _IslandStopMoveUnit

local function var_0_10(arg_6_0, arg_6_1)
	_IslandCore = var_1_10002

	if not var_1_10002 then
		return nil
	end

	_IslandCore = var_1_10002

	local var_6_0 = var_1_10002
	local var_6_1 = var_1_10002.Link

	ISLAND_EVT = var_1_10004

	var_6_1(var_6_0, var_1_10004.PLAY_BUBBLE, {
		name = arg_6_0,
		callback = arg_6_1
	})

	return
end

local var_0_11 = _IslandPlayBubble

local function var_0_12(arg_7_0, arg_7_1, arg_7_2)
	_IslandCore = var_1_10003

	if not var_1_10003 then
		return nil
	end

	getProxy = var_1_10003
	IslandProxy = var_1_10004

	local var_7_0 = var_1_10003(var_1_10004)
	local var_7_1 = var_3.GetIsland(var_7_0)
	local var_7_2 = var_3.DispatchEvent

	ISLAND_EVT = var_1_10006

	var_7_2(var_7_1, var_1_10006.CHANGE_SLOT_MODEL, {
		id = arg_7_1,
		type = arg_7_0,
		modelId = arg_7_2
	})

	return
end

local var_0_13 = _IslandChangeDelegateSlotModel

local function var_0_14(arg_8_0, arg_8_1)
	_IslandCore = var_1_10002

	if not var_1_10002 then
		return nil
	end

	getProxy = var_1_10002
	IslandProxy = var_1_10003

	local var_8_0 = var_1_10002(var_1_10003)
	local var_8_1 = var_2.GetIsland(var_8_0)

	_IslandCore = var_8_0

	local var_8_2 = var_8_0
	local var_8_3 = var_8_0.Link

	ISLAND_EVT = var_1_10005

	var_8_3(var_8_2, var_1_10005.START_DELEGATE_SLOT_PERFORM, {
		id = arg_8_1,
		type = arg_8_0
	})

	return
end

local var_0_15 = _IslandStartDelegateSlotPerform

return
