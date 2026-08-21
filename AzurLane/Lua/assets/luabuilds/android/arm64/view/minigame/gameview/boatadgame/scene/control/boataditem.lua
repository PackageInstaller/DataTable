local var_0_0 = class("BoatAdItem")
local var_0_1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1 = BoatAdGameVo
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._collider = GetComponent(findTF(arg_1_0._tf, "ad/bound"), typeof(BoxCollider2D))
	arg_1_0._moveAnimator = GetComponent(arg_1_0._tf, typeof(Animator))
	arg_1_0._moveDftEvent = GetComponent(arg_1_0._tf, typeof(DftAniEvent))
	arg_1_0._hpTf = findTF(arg_1_0._tf, "ad/img/hp")
	arg_1_0.leftTf = findTF(arg_1_0._tf, "ad/img/left")
	arg_1_0.rightTf = findTF(arg_1_0._tf, "ad/img/right")
	arg_1_0.textureTf = findTF(arg_1_0._tf, "ad/img/texture")

	arg_1_0._moveDftEvent:SetEndEvent(function()
		arg_1_0:setRemoveFlag(true)

		return
	end)

	return
end

function var_0_0.setData(arg_3_0, arg_3_1)
	arg_3_0._itemData = arg_3_1

	local var_3_0 = 0

	arg_3_0._tf.name = arg_3_1.id

	if type(arg_3_0:getConfig("hp")) == "number" then
		var_3_0 = arg_3_0:getConfig("hp")
	elseif type(arg_3_0:getConfig("hp")) == "table" then
		local var_3_1 = arg_3_0:getConfig("hp")

		var_3_0 = math.random(var_3_1[1], var_3_1[2])
	end

	arg_3_0._hp = var_3_0

	return
end

function var_0_0.start(arg_4_0)
	arg_4_0._removeFlag = false

	setActive(arg_4_0.textureTf, true)

	arg_4_0._touchFlag = false

	arg_4_0:updateUI()

	return
end

function var_0_0.step(arg_5_0, arg_5_1)
	return
end

function var_0_0.updateUI(arg_6_0)
	if arg_6_0:getConfig("buff") then
		if arg_6_0._hp and not arg_6_0:getConfig("item") then
			local var_6_0 = arg_6_0:getConfig("hp_type")
			local var_6_1 = ""

			if var_6_0 == BoatAdGameConst.hp_type_sub then
				var_6_1 = arg_6_0._hp >= 0 and "+" or ""
			elseif var_6_0 == BoatAdGameConst.hp_type_mul then
				var_6_1 = "*"
			elseif var_6_0 == BoatAdGameConst.hp_type_div then
				var_6_1 = "/"
			end

			setText(arg_6_0._hpTf, var_6_1 .. arg_6_0._hp)
			setActive(arg_6_0._hpTf, true)
		else
			setActive(arg_6_0._hpTf, false)
		end
	end

	return
end

function var_0_0.getHp(arg_7_0)
	return arg_7_0._hp
end

function var_0_0.setMoveCount(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.moveCount = arg_8_1
	arg_8_0.line = arg_8_2

	arg_8_0:setVisible(false)
	arg_8_0:setVisible(true)
	arg_8_0:setSpeed(1)
	arg_8_0:setInteger(arg_8_0._moveAnimator, "move_count", arg_8_1)

	if arg_8_0:getConfig("buff") then
		arg_8_0:setTrigger(arg_8_0._moveAnimator, "buff")
	else
		arg_8_0:setTrigger(arg_8_0._moveAnimator, "move")
	end

	setActive(arg_8_0.leftTf, false)
	setActive(arg_8_0.rightTf, false)

	arg_8_0.leftTf.localScale = Vector3(-1, 1, 1)
	arg_8_0.rightTf.localScale = Vector3(1, 1, 1)

	if arg_8_0.moveCount == 3 then
		setActive(arg_8_0.leftTf, true)
		setActive(arg_8_0.rightTf, true)
	elseif arg_8_0.moveCount < 3 then
		setActive(arg_8_0.leftTf, true)
	elseif arg_8_0.moveCount > 3 then
		setActive(arg_8_0.rightTf, true)
	end

	return
end

function var_0_0.getLine(arg_9_0)
	return arg_9_0.line
end

function var_0_0.setSpeed(arg_10_0, arg_10_1)
	arg_10_0._moveAnimator.speed = arg_10_1

	return
end

function var_0_0.getMoveCount(arg_11_0)
	return arg_11_0.moveCount
end

function var_0_0.getBuff(arg_12_0)
	return arg_12_0:getConfig("buff")
end

function var_0_0.setTrigger(arg_13_0, arg_13_1, arg_13_2)
	arg_13_1:SetTrigger(arg_13_2)

	return
end

function var_0_0.setTouch(arg_14_0)
	setActive(arg_14_0.textureTf, false)
	setActive(arg_14_0._hpTf, false)

	arg_14_0._touchFlag = true

	return
end

function var_0_0.getTouchFlag(arg_15_0)
	return arg_15_0._touchFlag
end

function var_0_0.setInteger(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_1:SetInteger(arg_16_2, arg_16_3)

	return
end

function var_0_0.getSpeed(arg_17_0)
	return arg_17_0._speed
end

function var_0_0.setContent(arg_18_0, arg_18_1)
	arg_18_0._content = arg_18_1

	SetParent(arg_18_0._tf, arg_18_1)

	return
end

function var_0_0.getId(arg_19_0)
	return arg_19_0._itemData.id
end

function var_0_0.setVisible(arg_20_0, arg_20_1)
	setActive(arg_20_0._tf, arg_20_1)

	return
end

function var_0_0.clear(arg_21_0)
	arg_21_0:setVisible(false)

	return
end

function var_0_0.setRemoveFlag(arg_22_0, arg_22_1)
	arg_22_0._removeFlag = arg_22_1

	return
end

function var_0_0.getRemoveFlag(arg_23_0)
	return arg_23_0._removeFlag
end

function var_0_0.dispose(arg_24_0)
	var_0_1 = nil

	return
end

function var_0_0.getColliderData(arg_25_0)
	local var_25_0 = arg_25_0._content:InverseTransformPoint(arg_25_0._collider.bounds.min)

	if not arg_25_0._boundData then
		local var_25_1 = arg_25_0._content:InverseTransformPoint(arg_25_0._collider.bounds.max)

		arg_25_0._boundData = {
			width = math.floor(var_25_1.x - var_25_0.x),
			height = math.floor(var_25_1.y - var_25_0.y)
		}
	end

	return var_25_0, arg_25_0._boundData
end

function var_0_0.getWorldColliderData(arg_26_0)
	arg_26_0._worldBoundData = arg_26_0._worldBoundData or {
		width = arg_26_0._collider.bounds.max.x - arg_26_0._collider.bounds.min.x,
		height = arg_26_0._collider.bounds.max.y - arg_26_0._collider.bounds.min.y
	}

	return arg_26_0._collider.bounds.min, arg_26_0._worldBoundData
end

function var_0_0.getTf(arg_27_0)
	return arg_27_0._tf
end

function var_0_0.getUseData(arg_28_0)
	return {
		score = arg_28_0:getConfig("score"),
		hp = arg_28_0:getConfig("hp"),
		skill = arg_28_0:getConfig("skill")
	}
end

function var_0_0.getScore(arg_29_0)
	return arg_29_0:getConfig("score")
end

function var_0_0.checkPositionInRange(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0:getConfig("range")

	if math.abs(arg_30_0._tf.anchoredPosition.x - arg_30_1.x) < var_30_0.x and math.abs(arg_30_0._tf.anchoredPosition.y - arg_30_1.y) < var_30_0.y then
		return true
	end

	return false
end

function var_0_0.getPosition(arg_31_0)
	return arg_31_0._tf.anchoredPosition
end

function var_0_0.getConfig(arg_32_0, arg_32_1)
	return arg_32_0._itemData[arg_32_1]
end

return var_0_0
