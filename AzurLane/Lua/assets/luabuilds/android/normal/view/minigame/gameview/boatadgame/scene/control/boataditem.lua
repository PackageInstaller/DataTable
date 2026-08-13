class = var_0_10000

local var_0_0 = var_0_10000("BoatAdItem")
local var_0_1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	BoatAdGameVo = var_1_10003
	var_0_1 = var_1_10003
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	GetComponent = var_1_10003
	findTF = var_1_10004

	local var_1_0 = var_1_10004(arg_1_0._tf, "ad/bound")

	typeof = var_5
	BoxCollider2D = var_6
	arg_1_0._collider = var_1_10003(var_1_0, var_5(var_6))
	GetComponent = var_3

	local var_1_1 = arg_1_0._tf

	typeof = var_5
	Animator = var_6
	arg_1_0._moveAnimator = var_3(var_1_1, var_5(var_6))
	GetComponent = var_3

	local var_1_2 = arg_1_0._tf

	typeof = var_5
	DftAniEvent = var_6
	arg_1_0._moveDftEvent = var_3(var_1_2, var_5(var_6))
	findTF = var_3
	arg_1_0._hpTf = var_3(arg_1_0._tf, "ad/img/hp")
	findTF = var_3
	arg_1_0.leftTf = var_3(arg_1_0._tf, "ad/img/left")
	findTF = var_3
	arg_1_0.rightTf = var_3(arg_1_0._tf, "ad/img/right")
	findTF = var_3
	arg_1_0.textureTf = var_3(arg_1_0._tf, "ad/img/texture")

	local var_1_3 = arg_1_0._moveDftEvent

	var_3.SetEndEvent(var_1_3, function()
		local var_2_0 = arg_1_0

		var_0.setRemoveFlag(var_2_0, true)

		return
	end)

	return
end

function var_0_0.setData(arg_3_0, arg_3_1)
	arg_3_0._itemData = arg_3_1

	local var_3_0 = 0
	local var_3_1 = arg_3_0._tf

	var_3_1.name = arg_3_1.id
	type = var_3_1

	if var_3_1(arg_3_0:getConfig("hp")) == "number" then
		var_3_0 = arg_3_0:getConfig("hp")
	else
		type = var_3

		if var_3(arg_3_0:getConfig("hp")) == "table" then
			local var_3_2 = arg_3_0
			local var_3_3 = arg_3_0.getConfig(var_3_2, "hp")

			math = var_3_2
			var_3_0 = var_3_2.random(var_3_3[1], var_3_3[2])
		end
	end

	arg_3_0._hp = var_3_0

	return
end

function var_0_0.start(arg_4_0)
	arg_4_0._removeFlag = false
	setActive = var_1

	var_1(arg_4_0.textureTf, true)

	arg_4_0._touchFlag = false

	arg_4_0:updateUI()

	return
end

function var_0_0.step(arg_5_0, arg_5_1)
	return
end

function var_0_0.updateUI(arg_6_0)
	if arg_6_0:getConfig("buff") then
		local var_6_0

		if arg_6_0._hp and not arg_6_0:getConfig("item") then
			var_6_0 = arg_6_0:getConfig("hp_type")

			local var_6_1 = ""

			BoatAdGameConst = var_3

			if var_6_0 == var_3.hp_type_sub then
				var_6_1 = arg_6_0._hp >= 0 and "+" or ""
			else
				BoatAdGameConst = var_3

				if var_6_0 == var_3.hp_type_mul then
					var_6_1 = "*"
				else
					BoatAdGameConst = var_3

					if var_6_0 == var_3.hp_type_div then
						var_6_1 = "/"
					end
				end
			end

			setText = var_3

			var_3(arg_6_0._hpTf, var_6_1 .. arg_6_0._hp)

			setActive = var_3

			var_3(arg_6_0._hpTf, true)
		else
			setActive = var_6_0

			var_6_0(arg_6_0._hpTf, false)
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

	setActive = var_3

	var_3(arg_8_0.leftTf, false)

	setActive = var_3

	var_3(arg_8_0.rightTf, false)

	local var_8_0 = arg_8_0.leftTf

	Vector3 = var_4
	var_8_0.localScale = var_4(-1, 1, 1)

	local var_8_1 = arg_8_0.rightTf

	Vector3 = var_4
	var_8_1.localScale = var_4(1, 1, 1)

	if arg_8_0.moveCount == 3 then
		setActive = var_3

		var_3(arg_8_0.leftTf, true)

		setActive = var_3

		var_3(arg_8_0.rightTf, true)
	elseif arg_8_0.moveCount < 3 then
		setActive = var_3

		var_3(arg_8_0.leftTf, true)
	elseif arg_8_0.moveCount > 3 then
		setActive = var_3

		var_3(arg_8_0.rightTf, true)
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
	setActive = var_1_10001

	var_1_10001(arg_14_0.textureTf, false)

	setActive = var_1_10001

	var_1_10001(arg_14_0._hpTf, false)

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
	SetParent = var_1_10002

	var_1_10002(arg_18_0._tf, arg_18_1)

	return
end

function var_0_0.getId(arg_19_0)
	return arg_19_0._itemData.id
end

function var_0_0.setVisible(arg_20_0, arg_20_1)
	setActive = var_1_10002

	var_1_10002(arg_20_0._tf, arg_20_1)

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
	local var_25_0 = arg_25_0._content
	local var_25_1 = var_1.InverseTransformPoint(var_25_0, arg_25_0._collider.bounds.min)

	if not arg_25_0._boundData then
		local var_25_2 = arg_25_0._content
		local var_25_3 = var_2.InverseTransformPoint(var_25_2, arg_25_0._collider.bounds.max)
		local var_25_4 = {}

		math = var_4
		var_25_4.width = var_4.floor(var_25_3.x - var_25_1.x)
		math = var_4
		var_25_4.height = var_4.floor(var_25_3.y - var_25_1.y)
		arg_25_0._boundData = var_25_4
	end

	return var_25_1, arg_25_0._boundData
end

function var_0_0.getWorldColliderData(arg_26_0)
	local var_26_0 = arg_26_0._collider.bounds.min

	if not arg_26_0._worldBoundData then
		local var_26_1 = arg_26_0._collider.bounds.max

		arg_26_0._worldBoundData = {
			width = var_26_1.x - var_26_0.x,
			height = var_26_1.y - var_26_0.y
		}
	end

	return var_26_0, arg_26_0._worldBoundData
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
	local var_30_0 = arg_30_0._tf.anchoredPosition

	math = var_1_10003

	local var_30_1 = var_1_10003.abs(var_30_0.x - arg_30_1.x)

	math = var_4

	local var_30_2 = var_4.abs(var_30_0.y - arg_30_1.y)

	if var_30_1 < arg_30_0:getConfig("range").x and var_30_2 < var_5.y then
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
