local var_0_0 = class("RollingBallGrid")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tf = arg_1_1
	arg_1_0.type = nil
	arg_1_0.pos = nil
	arg_1_0.eventActive = false
	arg_1_0.gridTf = findTF(arg_1_0._tf, "grid")

	return
end

function var_0_0.changeImage(arg_2_0)
	GetSpriteFromAtlasAsync(RollingBallConst.ui_atlas, "grid_" .. arg_2_0.type, function(arg_3_0)
		setImageSprite(arg_2_0.gridTf, arg_3_0, true)

		return
	end)

	return
end

function var_0_0.setType(arg_4_0, arg_4_1)
	arg_4_0.type = arg_4_1

	arg_4_0:changeImage()

	return
end

function var_0_0.getType(arg_5_0)
	return arg_5_0.type
end

function var_0_0.setPosData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.x = arg_6_1
	arg_6_0.y = arg_6_2

	if arg_6_0.gridTf then
		arg_6_0.gridTf.name = arg_6_0:printData()
	end

	return
end

function var_0_0.addDownCallback(arg_7_0, arg_7_1)
	arg_7_0.dragDelegate = GetOrAddComponent(arg_7_0._tf, "EventTriggerListener")

	arg_7_0.dragDelegate:AddPointDownFunc(function()
		if arg_7_0.eventActive then
			arg_7_1()
		end

		return
	end)

	return
end

function var_0_0.addUpCallback(arg_9_0, arg_9_1)
	arg_9_0.dragDelegate = GetOrAddComponent(arg_9_0._tf, "EventTriggerListener")

	arg_9_0.dragDelegate:AddPointUpFunc(function()
		if arg_9_0.eventActive then
			arg_9_1()
		end

		return
	end)

	return
end

function var_0_0.addBeginDragCallback(arg_11_0, arg_11_1)
	arg_11_0.dragDelegate = GetOrAddComponent(arg_11_0._tf, "EventTriggerListener")

	arg_11_0.dragDelegate:AddBeginDragFunc(function(arg_12_0, arg_12_1)
		if arg_11_0.eventActive then
			arg_11_1(arg_12_0, arg_12_1)
		end

		return
	end)

	return
end

function var_0_0.addDragCallback(arg_13_0, arg_13_1)
	arg_13_0.dragDelegate = GetOrAddComponent(arg_13_0._tf, "EventTriggerListener")

	arg_13_0.dragDelegate:AddDragFunc(function(arg_14_0, arg_14_1)
		if arg_13_0.eventActive then
			arg_13_1(arg_14_0, arg_14_1)
		end

		return
	end)

	return
end

function var_0_0.onEndDrag(arg_15_0)
	arg_15_0.dragDelegate:RemoveDragFunc()
	arg_15_0.dragDelegate:RemovePointUpFunc()

	return
end

function var_0_0.getPosData(arg_16_0)
	return arg_16_0.x, arg_16_0.y
end

function var_0_0.getPosition(arg_17_0)
	return arg_17_0._tf.localPosition
end

function var_0_0.setPosition(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0._tf.localPosition = Vector3(arg_18_1, arg_18_2, 0)

	return
end

function var_0_0.changePosition(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0._tf.localPosition = Vector3(arg_19_1, arg_19_2, 0)

	return
end

function var_0_0.getRealPosition(arg_20_0)
	return (arg_20_0.x - 1) * RollingBallConst.grid_width, (arg_20_0.y - 1) * RollingBallConst.grid_height
end

function var_0_0.setRemoveFlagV(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0.removeFlagV = arg_21_1
	arg_21_0.removeKey = arg_21_2

	return
end

function var_0_0.getRemoveFlagV(arg_22_0)
	return arg_22_0.removeFlagV
end

function var_0_0.setRemoveFlagH(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0.removeFlagH = arg_23_1
	arg_23_0.removeKey = arg_23_2

	return
end

function var_0_0.getRemoveFlagH(arg_24_0)
	return arg_24_0.removeFlagH
end

function var_0_0.getRemoveId(arg_25_0)
	return arg_25_0.removeKey
end

function var_0_0.setParent(arg_26_0, arg_26_1)
	setParent(arg_26_0._tf, arg_26_1, false)

	return
end

function var_0_0.setSelect(arg_27_0, arg_27_1)
	setActive(findTF(arg_27_0._tf, "select"), arg_27_1)

	return
end

function var_0_0.setDirect(arg_28_0, arg_28_1, arg_28_2, arg_28_3, arg_28_4)
	setActive(findTF(arg_28_0._tf, "direct/up"), arg_28_1)
	setActive(findTF(arg_28_0._tf, "direct/bottom"), arg_28_2)
	setActive(findTF(arg_28_0._tf, "direct/left"), arg_28_3)
	setActive(findTF(arg_28_0._tf, "direct/right"), arg_28_4)

	return
end

function var_0_0.clearDirect(arg_29_0)
	arg_29_0:setDirect(false, false, false, false)

	return
end

function var_0_0.getTf(arg_30_0)
	return arg_30_0._tf
end

function var_0_0.setEventActive(arg_31_0, arg_31_1)
	arg_31_0.eventActive = arg_31_1

	return
end

function var_0_0.printData(arg_32_0)
	return "x:" .. arg_32_0.x .. " , y:" .. arg_32_0.y .. " , type:" .. arg_32_0.type
end

function var_0_0.getWolrdVec3(arg_33_0)
	return arg_33_0._tf:TransformPoint(RollingBallConst.grid_width / 2, RollingBallConst.grid_height / 2, 0)
end

function var_0_0.clearData(arg_34_0)
	arg_34_0.removeFlagH = false
	arg_34_0.removeFlagV = false
	arg_34_0.removeKey = nil

	return
end

function var_0_0.dispose(arg_35_0)
	if arg_35_0.dragDelegate then
		ClearEventTrigger(arg_35_0.dragDelegate)
	end

	return
end

return var_0_0
