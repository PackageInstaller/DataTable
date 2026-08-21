local var_0_0 = class("BeachGuardGrid")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._gridTf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0.preIcon = findTF(arg_1_0._gridTf, "charPos/preIcon")

	setActive(arg_1_0.preIcon, false)

	arg_1_0.collider = findTF(arg_1_0._gridTf, "gridCollider")
	arg_1_0.minX = arg_1_0.collider.rect.min.x
	arg_1_0.minY = arg_1_0.collider.rect.min.y
	arg_1_0.maxX = arg_1_0.collider.rect.max.x
	arg_1_0.maxY = arg_1_0.collider.rect.max.y
	arg_1_0.select = findTF(arg_1_0._gridTf, "select")

	setActive(arg_1_0.select, false)

	arg_1_0.char = nil
	arg_1_0.range = findTF(arg_1_0._gridTf, "range")

	setActive(arg_1_0.range, false)

	arg_1_0.full = findTF(arg_1_0._gridTf, "full")

	setActive(arg_1_0.full, false)

	arg_1_0.recycle = findTF(arg_1_0._gridTf, "recycle")

	setActive(arg_1_0.recycle, false)

	arg_1_0.pos = findTF(arg_1_0._gridTf, "charPos")

	return
end

function var_0_0.setLineIndex(arg_2_0, arg_2_1)
	arg_2_0._lineIndex = arg_2_1

	return
end

function var_0_0.getLineIndex(arg_3_0)
	return arg_3_0._lineIndex
end

function var_0_0.setIndex(arg_4_0, arg_4_1)
	arg_4_0._index = arg_4_1

	return
end

function var_0_0.getIndex(arg_5_0)
	return arg_5_0._index
end

function var_0_0.getPos(arg_6_0)
	return arg_6_0.pos
end

function var_0_0.active(arg_7_0, arg_7_1)
	setActive(arg_7_0._lineTf, arg_7_1)

	return
end

function var_0_0.prechar(arg_8_0, arg_8_1)
	local var_8_0 = GetComponent(arg_8_0.preIcon, typeof(Image))

	var_8_0.sprite = BeachGuardAsset.getCardIcon(BeachGuardConst.chars[arg_8_1].name)

	var_8_0:SetNativeSize()
	setActive(arg_8_0.preIcon, true)
	setActive(arg_8_0.select, true)

	return
end

function var_0_0.unPreChar(arg_9_0)
	setActive(arg_9_0.preIcon, false)
	setActive(arg_9_0.select, false)

	return
end

function var_0_0.inGridWorld(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0._gridTf:InverseTransformPoint(arg_10_1)

	if var_10_0.x > arg_10_0.minX and var_10_0.x < arg_10_0.maxX and var_10_0.y > arg_10_0.minY and var_10_0.y < arg_10_0.maxY then
		return true
	end

	return false
end

function var_0_0.setChar(arg_11_0, arg_11_1)
	if arg_11_0.char then
		return
	end

	arg_11_0.char = arg_11_1

	return
end

function var_0_0.getChar(arg_12_0)
	return arg_12_0.char
end

function var_0_0.removeChar(arg_13_0)
	arg_13_0.char = nil

	setActive(arg_13_0.full, false)

	return
end

function var_0_0.isEmpty(arg_14_0)
	return arg_14_0.char == nil
end

function var_0_0.start(arg_15_0)
	return
end

function var_0_0.step(arg_16_0, arg_16_1)
	if arg_16_0.char and arg_16_0.char:getRecycleFlag() then
		setActive(arg_16_0.recycle, true)
	else
		setActive(arg_16_0.recycle, false)
	end

	return
end

function var_0_0.clear(arg_17_0)
	setActive(arg_17_0.select, false)
	setActive(arg_17_0.preIcon, false)
	setActive(arg_17_0.full, false)

	arg_17_0.char = nil

	return
end

function var_0_0.preDistance(arg_18_0)
	setActive(arg_18_0.range, true)

	return
end

function var_0_0.unPreDistance(arg_19_0)
	setActive(arg_19_0.range, false)

	return
end

return var_0_0
