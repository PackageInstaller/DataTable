function _IslandFindUnit(arg_1_0, arg_1_1)
	local var_1_0 = _IslandGetUnit(arg_1_0, arg_1_1)

	return var_1_0 and var_1_0._go
end

function _IslandGetUnit(arg_2_0, arg_2_1)
	if not _IslandCore then
		return nil
	end

	local var_2_0 = _IslandCore:GetView():GetUnitModuleWithType(arg_2_0, arg_2_1)

	if not var_2_0 then
		return nil
	end

	return var_2_0
end

function _IslandDestoryUnit(arg_3_0, arg_3_1)
	if not _IslandCore then
		return nil
	end

	_IslandCore:Link(ISLAND_EVT.RMOVE_UNIT, arg_3_0, arg_3_1)

	return
end

function _IslandMoveUnit(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	if not _IslandCore then
		return nil
	end

	_IslandCore:Link(ISLAND_EVT.MOVE_UNIT, {
		id = arg_4_1,
		type = arg_4_0,
		position = arg_4_2,
		speed = arg_4_3,
		charaRadius = arg_4_4
	})

	return
end

function _IslandStopMoveUnit(arg_5_0, arg_5_1)
	if not _IslandCore then
		return nil
	end

	_IslandCore:Link(ISLAND_EVT.STOP_MOVE_UNIT, {
		id = arg_5_1,
		type = arg_5_0
	})

	return
end

function _IslandPlayBubble(arg_6_0, arg_6_1)
	if not _IslandCore then
		return nil
	end

	_IslandCore:Link(ISLAND_EVT.PLAY_BUBBLE, {
		name = arg_6_0,
		callback = arg_6_1
	})

	return
end

function _IslandChangeDelegateSlotModel(arg_7_0, arg_7_1, arg_7_2)
	if not _IslandCore then
		return nil
	end

	getProxy(IslandProxy):GetIsland():DispatchEvent(ISLAND_EVT.CHANGE_SLOT_MODEL, {
		id = arg_7_1,
		type = arg_7_0,
		modelId = arg_7_2
	})

	return
end

function _IslandStartDelegateSlotPerform(arg_8_0, arg_8_1)
	if not _IslandCore then
		return nil
	end

	local var_8_0 = getProxy(IslandProxy):GetIsland()

	_IslandCore:Link(ISLAND_EVT.START_DELEGATE_SLOT_PERFORM, {
		id = arg_8_1,
		type = arg_8_0
	})

	return
end

return
