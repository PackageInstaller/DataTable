class = var_0_10000

local var_0_0 = var_0_10000("SailBoatItem")
local var_0_1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	SailBoatGameVo = var_1_10003
	var_0_1 = var_1_10003
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	GetComponent = var_1_10003
	findTF = var_1_10005

	local var_1_0 = var_1_10005(arg_1_0._tf, "bound")

	typeof = var_1_10006
	BoxCollider2D = var_8
	arg_1_0._collider = var_1_10003(var_1_0, var_1_10006(var_8))

	return
end

function var_0_0.setData(arg_2_0, arg_2_1)
	arg_2_0._itemData = arg_2_1

	return
end

function var_0_0.start(arg_3_0)
	arg_3_0._removeFlag = false
	arg_3_0._sceneWidth, arg_3_0._sceneHeight = var_0_1.scene_width, var_0_1.scene_height
	arg_3_0._maxRemoveHeight = -arg_3_0._sceneHeight * 2
	arg_3_0._maxRemoveWidth = arg_3_0._sceneWidth * 2
	arg_3_0._speed = arg_3_0:getConfig("speed")

	arg_3_0:setVisible(true)

	return
end

function var_0_0.step(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._tf.anchoredPosition
	local var_4_1 = var_0_1.GetSceneSpeed()

	arg_4_0._speed.x = arg_4_0._speed.x * arg_4_1 + var_4_1.x
	arg_4_0._speed.y = arg_4_0._speed.y * arg_4_1 + var_4_1.y
	var_4_0.x = var_4_0.x + arg_4_0._speed.x
	var_4_0.y = var_4_0.y + arg_4_0._speed.y
	arg_4_0._tf.anchoredPosition = var_4_0

	if not arg_4_0._removeFlag then
		if var_4_0.y < arg_4_0._maxRemoveHeight then
			arg_4_0._removeFlag = true
		else
			math = var_4

			if var_4.abs(var_4_0.x) > arg_4_0._maxRemoveWidth then
				arg_4_0._removeFlag = true
			end
		end
	end

	return
end

function var_0_0.getSpeed(arg_5_0)
	return arg_5_0._speed
end

function var_0_0.setContent(arg_6_0, arg_6_1)
	arg_6_0._content = arg_6_1
	SetParent = var_1_10002

	var_1_10002(arg_6_0._tf, arg_6_1)

	return
end

function var_0_0.getId(arg_7_0)
	return arg_7_0._itemData.id
end

function var_0_0.setVisible(arg_8_0, arg_8_1)
	setActive = var_1_10002

	var_1_10002(arg_8_0._tf, arg_8_1)

	return
end

function var_0_0.setPosition(arg_9_0, arg_9_1)
	arg_9_0._tf.anchoredPosition = arg_9_1

	return
end

function var_0_0.clear(arg_10_0)
	arg_10_0:setVisible(false)

	return
end

function var_0_0.setRemoveFlag(arg_11_0, arg_11_1)
	arg_11_0._removeFlag = arg_11_1

	return
end

function var_0_0.getRemoveFlag(arg_12_0)
	return arg_12_0._removeFlag
end

function var_0_0.dispose(arg_13_0)
	var_0_1 = nil

	return
end

function var_0_0.getColliderData(arg_14_0)
	local var_14_0 = arg_14_0._content
	local var_14_1 = var_1.InverseTransformPoint(var_14_0, arg_14_0._collider.bounds.min)

	if not arg_14_0._boundData then
		local var_14_2 = arg_14_0._content
		local var_14_3 = var_2.InverseTransformPoint(var_14_2, arg_14_0._collider.bounds.max)
		local var_14_4 = {}

		math = var_14_2
		var_14_4.width = var_14_2.floor(var_14_3.x - var_14_1.x)
		math = var_4
		var_14_4.height = var_4.floor(var_14_3.y - var_14_1.y)
		arg_14_0._boundData = var_14_4
	end

	return var_14_1, arg_14_0._boundData
end

function var_0_0.getWorldColliderData(arg_15_0)
	local var_15_0 = arg_15_0._collider.bounds.min

	if not arg_15_0._worldBoundData then
		local var_15_1 = arg_15_0._collider.bounds.max

		arg_15_0._worldBoundData = {
			width = var_15_1.x - var_15_0.x,
			height = var_15_1.y - var_15_0.y
		}
	end

	return var_15_0, arg_15_0._worldBoundData
end

function var_0_0.getTf(arg_16_0)
	return arg_16_0._tf
end

function var_0_0.getUseData(arg_17_0)
	return {
		score = arg_17_0:getConfig("score"),
		hp = arg_17_0:getConfig("hp"),
		skill = arg_17_0:getConfig("skill")
	}
end

function var_0_0.checkPositionInRange(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0._tf.anchoredPosition

	math = var_1_10003

	local var_18_1 = var_1_10003.abs(var_18_0.x - arg_18_1.x)

	math = var_1_10004

	local var_18_2 = var_1_10004.abs(var_18_0.y - arg_18_1.y)

	if var_18_1 < arg_18_0:getConfig("range").x and var_18_2 < var_5.y then
		return true
	end

	return false
end

function var_0_0.getPosition(arg_19_0)
	return arg_19_0._tf.anchoredPosition
end

function var_0_0.getConfig(arg_20_0, arg_20_1)
	return arg_20_0._itemData[arg_20_1]
end

return var_0_0
