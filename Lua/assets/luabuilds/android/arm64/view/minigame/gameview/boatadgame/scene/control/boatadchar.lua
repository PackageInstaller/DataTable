local var_0_0 = class("BoatAdChar")
local var_0_1
local var_0_2
local var_0_3 = 0.5

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1 = BoatAdGameVo
	var_0_2 = BoatAdGameConst
	arg_1_0._tf = arg_1_1
	arg_1_0._eventCallback = arg_1_2
	arg_1_0._collider = GetComponent(findTF(arg_1_0._tf, "bound"), typeof(BoxCollider2D))
	arg_1_0.imgTf = findTF(arg_1_0._tf, "img")
	arg_1_0._charSpineAnim = GetComponent(findTF(arg_1_0.imgTf, "char"), typeof(SpineAnimUI))
	arg_1_0._yanwuTf = findTF(arg_1_0.imgTf, "yanwu")
	arg_1_0._yanwuAnimUI = GetComponent(arg_1_0._yanwuTf, typeof(SpineAnimUI))
	arg_1_0._hpTf = findTF(arg_1_0._tf, "hp")

	setActive(arg_1_0._tf, false)

	arg_1_0._playerAnimator = GetComponent(arg_1_0._tf, typeof(Animator))
	arg_1_0.battleEffectTf = findTF(arg_1_0._tf, "battleEffect")
	arg_1_0.battleEffectSpine1 = GetComponent(findTF(arg_1_0.battleEffectTf, "spine1"), typeof(SpineAnimUI))
	arg_1_0.battleEffectSpine2 = GetComponent(findTF(arg_1_0.battleEffectTf, "spine2"), typeof(SpineAnimUI))
	arg_1_0.guardTf = findTF(arg_1_0._tf, "guard")

	return
end

function var_0_0.setData(arg_2_0, arg_2_1)
	arg_2_0._data = arg_2_1
	arg_2_0._baseSpeed = arg_2_0:getConfig("speed")
	arg_2_0._baseHp = arg_2_0:getConfig("hp")

	return
end

function var_0_0.setContent(arg_3_0, arg_3_1)
	arg_3_0._content = arg_3_1

	SetParent(arg_3_0._tf, arg_3_1)

	return
end

function var_0_0.changeDirect(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._directX = arg_4_1
	arg_4_0._directY = arg_4_2
	arg_4_0.imgTf.localEulerAngles = arg_4_0._battleHp > 0 and Vector3(0, 0, 0) or arg_4_0._directX < 0 and Vector3(0, 0, 3) or arg_4_0._directX > 0 and Vector3(0, 0, -3) or Vector3(0, 0, 0)

	return
end

function var_0_0.getWorld(arg_5_0)
	return arg_5_0._tf.position
end

function var_0_0.start(arg_6_0)
	arg_6_0._directX = 0
	arg_6_0._directY = 0

	setActive(arg_6_0._tf, true)

	arg_6_0._tf.anchoredPosition = arg_6_0:getConfig("start_pos")
	arg_6_0._speed = Vector2(0, 0)
	arg_6_0._speed.x = arg_6_0._baseSpeed.x
	arg_6_0._speed.y = arg_6_0._baseSpeed.y
	arg_6_0._hp = arg_6_0._baseHp
	arg_6_0._timeForDead = nil
	arg_6_0._battleHp = 0
	arg_6_0.colliderLine = 0
	arg_6_0.guardTime = 0
	arg_6_0.stopFlag = false

	arg_6_0:updateCharMoveCount()
	arg_6_0:updateUI()
	arg_6_0:updateChange(false)

	arg_6_0.stepSound = 0

	return
end

function var_0_0.step(arg_7_0, arg_7_1)
	arg_7_0.stepSound = arg_7_0.stepSound - arg_7_1

	if arg_7_0._battleHp > 0 then
		if arg_7_0._battleHp > arg_7_0._battleSubHp then
			local var_7_1 = arg_7_0._battleSubHp or arg_7_0._battleHp

			arg_7_0._battleHp = arg_7_0._battleHp - var_7_1

			arg_7_0:subHp(var_7_1)

			if arg_7_0._hp <= 0 then
				arg_7_0._hp = 0
				arg_7_0._battleHp = 0
			end

			arg_7_0:updateUI()

			if arg_7_0.stepSound <= 0 then
				pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_1.SFX_SOUND_BATTLE)

				arg_7_0.stepSound = var_0_3
			end

			if arg_7_0:getLife() and arg_7_0._battleHp == 0 then
				local var_7_3 = arg_7_0:getNextPosition(arg_7_0._directX, arg_7_0._directY)

				if math.abs(var_7_3.x) > var_0_2.player_width / 2 + 50 or math.abs(var_7_3.y) > var_0_2.player_height / 2 + 50 then
					-- block empty
				else
					arg_7_0._tf.anchoredPosition = var_7_3

					arg_7_0:updateCharMoveCount()
				end
			end

			if arg_7_0.guardTime and arg_7_0.guardTime > 0 and arg_7_0._battleHp <= 0 then
				arg_7_0.guardTime = arg_7_0.guardTime - arg_7_1

				if arg_7_0.guardTime <= 0 then
					arg_7_0.guardTime = 0

					arg_7_0:updateGuard()
				end
			end

			if arg_7_0:getLife() and arg_7_0._battleHp <= 0 and arg_7_0._changeIndex ~= arg_7_0:getCharChange() then
				arg_7_0:updateChange(true)
			end

			return
		end
	end
end

function var_0_0.getGuard(arg_8_0)
	return arg_8_0.guardTime > 0
end

function var_0_0.addGuard(arg_9_0, arg_9_1)
	arg_9_0.guardTime = arg_9_1

	arg_9_0:updateGuard()

	return
end

function var_0_0.subHp(arg_10_0, arg_10_1)
	if not arg_10_0:getGuard() then
		arg_10_0._hp = arg_10_0._hp - arg_10_1
	end

	if arg_10_0._hp < 0 then
		arg_10_0._hp = 0
	end

	arg_10_0:updateUI()

	return
end

function var_0_0.updateGuard(arg_11_0)
	if not arg_11_0.stopFlag then
		setActive(arg_11_0.guardTf, arg_11_0.guardTime > 0)
	end

	return
end

function var_0_0.updateChange(arg_12_0, arg_12_1)
	arg_12_0._changeIndex = arg_12_0:getCharChange()

	if arg_12_1 then
		setActive(arg_12_0._yanwuTf, true)
		arg_12_0:setAnimation(arg_12_0._yanwuAnimUI, "normal", function()
			setActive(arg_12_0._yanwuTf, false)

			return
		end)
		arg_12_0:setAnimation(arg_12_0._charSpineAnim, "normal" .. arg_12_0._changeIndex)
	else
		setActive(arg_12_0._yanwuTf, false)
		arg_12_0:setAnimation(arg_12_0._charSpineAnim, "normal" .. arg_12_0._changeIndex)
	end

	return
end

function var_0_0.getCharChange(arg_14_0)
	local var_14_0 = 1

	for iter_14_0 = 1, #BoatAdGameConst.char_change_hp do
		if arg_14_0._hp >= BoatAdGameConst.char_change_hp[iter_14_0] then
			var_14_0 = iter_14_0 + 1
		end
	end

	return var_14_0
end

function var_0_0.setAnimation(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	arg_15_1:SetActionCallBack(nil)
	arg_15_1:SetAction(arg_15_2, 0)
	arg_15_1:SetActionCallBack(function(arg_16_0)
		if arg_16_0 == "action" and arg_15_4 then
			arg_15_4()
		end

		if arg_16_0 == "finish" then
			arg_15_1:SetActionCallBack(nil)

			if arg_15_3 then
				arg_15_3()
			end
		end

		return
	end)

	return
end

function var_0_0.updateUI(arg_17_0)
	if arg_17_0._battleHp > 0 and not isActive(arg_17_0.battleEffectTf) then
		setActive(arg_17_0.battleEffectTf, true)
		arg_17_0:setAnimation(arg_17_0.battleEffectSpine1, "normal")
		arg_17_0:setAnimation(arg_17_0.battleEffectSpine2, "normal")
	elseif arg_17_0._battleHp <= 0 and isActive(arg_17_0.battleEffectTf) then
		setActive(arg_17_0.battleEffectTf, false)
	end

	setText(arg_17_0._hpTf, arg_17_0._hp)
	arg_17_0:updateGuard()

	return
end

function var_0_0.updateCharMoveCount(arg_18_0)
	local var_18_0
	local var_18_1

	for iter_18_0, iter_18_1 in ipairs(BoatAdGameConst.move_line_width) do
		if not var_18_1 then
			var_18_1 = math.abs(arg_18_0._tf.anchoredPosition.x - iter_18_1)
			var_18_0 = iter_18_0
		elseif var_18_1 > math.abs(arg_18_0._tf.anchoredPosition.x - iter_18_1) then
			var_18_1 = math.abs(arg_18_0._tf.anchoredPosition.x - iter_18_1)
			var_18_0 = iter_18_0
		end
	end

	if arg_18_0.moveCount ~= var_18_0 then
		print("设置角色moveCount" .. var_18_0)
	end

	arg_18_0.moveCount = var_18_0

	return
end

function var_0_0.setLine(arg_19_0, arg_19_1)
	arg_19_0.colliderLine = arg_19_1

	return
end

function var_0_0.getLine(arg_20_0)
	return arg_20_0.colliderLine
end

function var_0_0.getMoveCount(arg_21_0)
	return arg_21_0.moveCount
end

function var_0_0.battle(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0._battleHp = arg_22_1
	arg_22_0._battleBoss = arg_22_2

	if arg_22_2 then
		arg_22_0._battleSubHp = var_0_2.battle_sub_hp_boss or var_0_2.battle_sub_hp

		return
	end
end

function var_0_0.getBattle(arg_23_0)
	return arg_23_0._battleHp > 0
end

function var_0_0.getHpPos(arg_24_0)
	return arg_24_0._hpTf.position
end

function var_0_0.getNextPosition(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = 0

	if arg_25_1 ~= 0 then
		var_25_0 = arg_25_0._speed.x * arg_25_1 * var_0_1.deltaTime
	end

	local var_25_1 = 0

	if arg_25_2 ~= 0 then
		var_25_1 = arg_25_0._speed.y * arg_25_2 * var_0_1.deltaTime
	end

	local var_25_2 = arg_25_0._tf.anchoredPosition

	if var_25_0 ~= 0 or var_25_1 ~= 0 then
		var_25_2.x = var_25_2.x + var_25_0
		var_25_2.y = var_25_2.y + var_25_1

		return var_25_2
	end

	return var_25_2
end

function var_0_0.getTf(arg_26_0)
	return arg_26_0._tf
end

function var_0_0.getHp(arg_27_0)
	return arg_27_0._hp
end

function var_0_0.getColliderData(arg_28_0)
	local var_28_0 = arg_28_0._content:InverseTransformPoint(arg_28_0._collider.bounds.min)

	if not arg_28_0._boundData then
		local var_28_1 = arg_28_0._content:InverseTransformPoint(arg_28_0._collider.bounds.max)

		arg_28_0._boundData = {
			width = math.floor(var_28_1.x - var_28_0.x),
			height = math.floor(var_28_1.y - var_28_0.y)
		}
	end

	return var_28_0, arg_28_0._boundData
end

function var_0_0.flash(arg_29_0)
	arg_29_0._playerAnimator:SetTrigger("flash")

	return
end

function var_0_0.changeHp(arg_30_0, arg_30_1, arg_30_2)
	if arg_30_1 ~= 0 then
		local var_30_0 = arg_30_0._hp

		if arg_30_2 == BoatAdGameConst.hp_type_sub then
			var_30_0 = arg_30_0._hp + arg_30_1
		elseif arg_30_2 == BoatAdGameConst.hp_type_mul then
			var_30_0 = arg_30_0._hp * arg_30_1
		elseif arg_30_2 == BoatAdGameConst.hp_type_div then
			var_30_0 = arg_30_0._hp / arg_30_1
		end

		local var_30_1 = math.floor(var_30_0)

		if var_30_1 < arg_30_0._hp then
			arg_30_0:flash()
		end

		arg_30_0._hp = arg_30_0:getGuard() and var_30_1 <= arg_30_0._hp and arg_30_0._hp or var_30_1

		arg_30_0:updateUI()

		if arg_30_0._changeIndex ~= arg_30_0:getCharChange() then
			arg_30_0:updateChange(true)
		end
	end

	return
end

function var_0_0.getWorldColliderData(arg_31_0)
	arg_31_0._worldBoundData = arg_31_0._worldBoundData or {
		width = arg_31_0._collider.bounds.max.x - arg_31_0._collider.bounds.min.x,
		height = arg_31_0._collider.bounds.max.y - arg_31_0._collider.bounds.min.y
	}

	return arg_31_0._collider.bounds.min, arg_31_0._worldBoundData
end

function var_0_0.getLife(arg_32_0)
	return arg_32_0._hp > 0
end

function var_0_0.getColliderMinPosition(arg_33_0)
	arg_33_0._minPosition = arg_33_0._minPosition or arg_33_0._tf:InverseTransformPoint(arg_33_0._collider.bounds.min)

	return arg_33_0._minPosition
end

function var_0_0.getBoundData(arg_34_0)
	local var_34_0 = arg_34_0._content:InverseTransformPoint(arg_34_0._collider.bounds.min)

	if not arg_34_0._boundData then
		local var_34_1 = arg_34_0._content:InverseTransformPoint(arg_34_0._collider.bounds.max)

		arg_34_0._boundData = {
			width = math.floor(var_34_1.x - var_34_0.x),
			height = math.floor(var_34_1.y - var_34_0.y)
		}
	end

	return arg_34_0._boundData
end

function var_0_0.getPosition(arg_35_0)
	return arg_35_0._tf.anchoredPosition
end

function var_0_0.getGroup(arg_36_0)
	return arg_36_0:getConfig("group")
end

function var_0_0.clear(arg_37_0)
	arg_37_0._battleHp = 0

	arg_37_0:updateUI()

	return
end

function var_0_0.stop(arg_38_0)
	arg_38_0.stopFlag = true

	setActive(arg_38_0.guardTf, false)

	return
end

function var_0_0.resume(arg_39_0)
	arg_39_0.stopFlag = false

	arg_39_0:updateGuard()

	return
end

function var_0_0.getMinMaxPosition(arg_40_0)
	return arg_40_0._collider.bounds.min, arg_40_0._collider.bounds.max
end

function var_0_0.getConfig(arg_41_0, arg_41_1)
	return arg_41_0._data[arg_41_1]
end

function var_0_0.checkPositionInRange(arg_42_0, arg_42_1)
	if math.abs(arg_42_0._tf.anchoredPosition.x - arg_42_1.x) < arg_42_0:getConfig("range") and math.abs(arg_42_0._tf.anchoredPosition.y - arg_42_1.y) < arg_42_0:getConfig("range") then
		return true
	end

	return false
end

function var_0_0.dispose(arg_43_0)
	return
end

return var_0_0
