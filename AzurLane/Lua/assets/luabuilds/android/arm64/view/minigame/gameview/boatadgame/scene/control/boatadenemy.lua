local var_0_0 = class("BoatAdEnemy")
local var_0_1
local var_0_2

var_0_0.name_index = 1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1 = BoatAdGameVo
	var_0_2 = BoatAdGameConst
	arg_1_0._tf = arg_1_1
	arg_1_0._eventCall = arg_1_2
	arg_1_0._collider = GetComponent(findTF(arg_1_0._tf, "ad/bound"), typeof(BoxCollider2D))
	arg_1_0._moveAnimator = GetComponent(arg_1_0._tf, typeof(Animator))
	arg_1_0._moveDftEvent = GetComponent(arg_1_0._tf, typeof(DftAniEvent))
	arg_1_0._hpTf = findTF(arg_1_0._tf, "ad/img/hp")
	arg_1_0._ad = findTF(arg_1_0._tf, "ad")
	arg_1_0._imgTf = findTF(arg_1_0._tf, "ad/img")
	arg_1_0._speedDownTf = findTF(arg_1_0._tf, "ad/img/speedDown")

	if arg_1_0._speedDownTf then
		setActive(arg_1_0._speedDownTf, false)
	end

	arg_1_0._moveDftEvent:SetEndEvent(function()
		print("触发移除标记")
		arg_1_0:setRemoveFlag(true)

		return
	end)

	return
end

function var_0_0.setData(arg_3_0, arg_3_1)
	arg_3_0._data = arg_3_1
	arg_3_0._tf.name = arg_3_0._data.id
	arg_3_0._moveFlag = arg_3_0:getConfig("move")
	arg_3_0._moveSpeed = arg_3_0:getConfig("speed")

	arg_3_0:update()

	return
end

function var_0_0.update(arg_4_0)
	setText(arg_4_0._hpTf, arg_4_0._hp)

	return
end

function var_0_0.start(arg_5_0)
	var_0_0.name_index = var_0_0.name_index + 1
	arg_5_0._removeFlag = false

	local var_5_0 = arg_5_0:getConfig("hp")

	arg_5_0._hp = 10

	if type(var_5_0) == "number" then
		arg_5_0._hp = var_5_0
	elseif type(var_5_0) == "table" then
		arg_5_0._hp = math.random(var_5_0[1], var_5_0[2])
	end

	arg_5_0.moveDirect = math.random() < 0.5 and 1 or -1

	if arg_5_0._speedDownTf then
		setActive(arg_5_0._speedDownTf, false)
	end

	arg_5_0._battleHp = 0
	arg_5_0._destroyFlag = false
	arg_5_0._stopFlag = false
	arg_5_0._battleFlag = false
	arg_5_0._ad.anchoredPosition = Vector2(0, 0)

	if arg_5_0:getConfig("boss") then
		arg_5_0._battleSubHp = var_0_2.battle_sub_hp_boss or var_0_2.battle_sub_hp

		arg_5_0:speedDown(false)
		arg_5_0:update()

		return
	end
end

function var_0_0.step(arg_6_0, arg_6_1)
	if arg_6_0._battleHp > 0 then
		arg_6_0._hp = arg_6_0._hp - arg_6_0._battleSubHp

		if arg_6_0._hp < 0 then
			arg_6_0._hp = 0
			arg_6_0._battleHp = 0
			arg_6_0._battleFlag = true

			arg_6_0:setRemoveFlag(true)
		end

		arg_6_0:update()
	end

	if arg_6_0._moveFlag and arg_6_0:getSpeed() > 0 and arg_6_0._battleHp <= 0 and not arg_6_0:getRemoveFlag() then
		local var_6_0 = arg_6_0._imgTf.localScale.x

		if arg_6_0._speedDownFlag then
			local var_6_1 = var_0_2.speed_down_rate or 1

			arg_6_0._ad.anchoredPosition = Vector2(arg_6_0._ad.anchoredPosition.x + arg_6_0.moveDirect * arg_6_0._moveSpeed * arg_6_1 * var_6_0 * var_6_1, arg_6_0._ad.anchoredPosition.y)

			local var_6_2 = false

			if arg_6_0.moveDirect == 1 then
				var_6_2 = var_0_1.CheckPointOutRightLine(arg_6_0:getScenePosition())
			elseif arg_6_0.moveDirect == -1 then
				var_6_2 = var_0_1.CheckPointOutLeftLine(arg_6_0:getScenePosition())
			end

			if var_6_2 then
				arg_6_0.moveDirect = -arg_6_0.moveDirect
			end

			return
		end
	end
end

function var_0_0.setMoveCount(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.moveCount = arg_7_1
	arg_7_0.line = arg_7_2

	arg_7_0:setVisible(false)
	arg_7_0:setVisible(true)
	arg_7_0:setSpeed(1)
	arg_7_0:setInteger(arg_7_0._moveAnimator, "move_count", arg_7_1)
	arg_7_0:setTrigger(arg_7_0._moveAnimator, "move")

	return
end

function var_0_0.getScenePosition(arg_8_0)
	return {
		x = arg_8_0._tf.anchoredPosition.x + arg_8_0._ad.anchoredPosition.x,
		y = arg_8_0._tf.anchoredPosition.y + arg_8_0._ad.anchoredPosition.y
	}
end

function var_0_0.getLine(arg_9_0)
	return arg_9_0.line
end

function var_0_0.getMoveCount(arg_10_0)
	return arg_10_0.moveCount
end

function var_0_0.bossFocus(arg_11_0, arg_11_1)
	arg_11_0._ad.anchoredPosition.x = arg_11_0._ad.anchoredPosition.x + arg_11_1
	arg_11_0._ad.anchoredPosition = arg_11_0._ad.anchoredPosition

	return
end

function var_0_0.setTrigger(arg_12_0, arg_12_1, arg_12_2)
	arg_12_1:SetTrigger("move")

	return
end

function var_0_0.getBoss(arg_13_0)
	return arg_13_0:getConfig("boss")
end

function var_0_0.setInteger(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	arg_14_1:SetInteger(arg_14_2, arg_14_3)

	return
end

function var_0_0.getLife(arg_15_0)
	return arg_15_0._hp > 0
end

function var_0_0.getScale(arg_16_0)
	return arg_16_0._imgTf.localScale.y
end

function var_0_0.getHp(arg_17_0)
	return arg_17_0._hp
end

function var_0_0.speedDown(arg_18_0, arg_18_1)
	if arg_18_0._moveFlag then
		arg_18_0._speedDownFlag = arg_18_1

		setActive(arg_18_0._speedDownTf, arg_18_1)
	end

	return
end

function var_0_0.battle(arg_19_0, arg_19_1)
	arg_19_0._battleHp = arg_19_1

	return
end

function var_0_0.getBattle(arg_20_0)
	return arg_20_0._battleHp > 0
end

function var_0_0.getSpeed(arg_21_0)
	return arg_21_0._moveAnimator.speed
end

function var_0_0.setSpeed(arg_22_0, arg_22_1)
	arg_22_0._moveAnimator.speed = arg_22_1

	return
end

function var_0_0.getDestroyFlag(arg_23_0)
	return arg_23_0._destroyFlag
end

function var_0_0.setContent(arg_24_0, arg_24_1)
	arg_24_0._content = arg_24_1

	SetParent(arg_24_0._tf, arg_24_1)

	return
end

function var_0_0.getId(arg_25_0)
	return arg_25_0._data.id
end

function var_0_0.setVisible(arg_26_0, arg_26_1)
	setActive(arg_26_0._tf, arg_26_1)

	return
end

function var_0_0.getPosition(arg_27_0)
	return arg_27_0._tf.anchoredPosition
end

function var_0_0.getRelaPositionX(arg_28_0)
	return arg_28_0._tf.anchoredPosition.x + arg_28_0._ad.anchoredPosition.x, arg_28_0._tf.anchoredPosition.y + arg_28_0._ad.anchoredPosition.y
end

function var_0_0.getWorld(arg_29_0)
	return arg_29_0._tf.position
end

function var_0_0.clear(arg_30_0)
	arg_30_0:setVisible(false)

	return
end

function var_0_0.setRemoveFlag(arg_31_0, arg_31_1)
	arg_31_0._removeFlag = arg_31_1

	return
end

function var_0_0.getGroup(arg_32_0)
	return arg_32_0:getConfig("group")
end

function var_0_0.getTf(arg_33_0)
	return arg_33_0._tf
end

function var_0_0.getRemoveFlag(arg_34_0)
	return arg_34_0._removeFlag
end

function var_0_0.getMoveCount(arg_35_0)
	return arg_35_0.moveCount
end

function var_0_0.dispose(arg_36_0)
	var_0_1 = nil

	return
end

function var_0_0.getColliderData(arg_37_0)
	local var_37_0 = arg_37_0._content:InverseTransformPoint(arg_37_0._collider.bounds.min)

	if not arg_37_0._boundData then
		local var_37_1 = arg_37_0._content:InverseTransformPoint(arg_37_0._collider.bounds.max)

		arg_37_0._boundData = {
			width = math.floor(var_37_1.x - var_37_0.x),
			height = math.floor(var_37_1.y - var_37_0.y)
		}
	end

	return var_37_0, arg_37_0._boundData
end

function var_0_0.getWorldColliderData(arg_38_0)
	arg_38_0._worldBoundData = arg_38_0._worldBoundData or {
		width = arg_38_0._collider.bounds.max.x - arg_38_0._collider.bounds.min.x,
		height = arg_38_0._collider.bounds.max.y - arg_38_0._collider.bounds.min.y
	}

	return arg_38_0._collider.bounds.min, arg_38_0._worldBoundData
end

function var_0_0.getStop(arg_39_0)
	return arg_39_0._stopFlag
end

function var_0_0.getMinMaxPosition(arg_40_0)
	return arg_40_0._collider.bounds.min, arg_40_0._collider.bounds.max
end

function var_0_0.getBoundWidth(arg_41_0)
	return arg_41_0._collider.size.x / 2
end

function var_0_0.checkPositionInRange(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_0:getConfig("range")

	if math.abs(arg_42_0._tf.anchoredPosition.x - arg_42_1.x) < var_42_0.x and math.abs(arg_42_0._tf.anchoredPosition.y - arg_42_1.y) < var_42_0.y then
		return true
	end

	return false
end

function var_0_0.getConfig(arg_43_0, arg_43_1)
	return arg_43_0._data[arg_43_1]
end

return var_0_0
