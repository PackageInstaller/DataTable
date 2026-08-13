class = var_0_10000

local var_0_0 = var_0_10000("BoatAdChar")
local var_0_1
local var_0_2
local var_0_3 = 0.5

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	BoatAdGameVo = var_1_10003
	var_0_1 = var_1_10003
	BoatAdGameConst = var_1_10003
	var_0_2 = var_1_10003
	arg_1_0._tf = arg_1_1
	arg_1_0._eventCallback = arg_1_2
	GetComponent = var_1_10003
	findTF = var_1_10005

	local var_1_0 = var_1_10005(arg_1_0._tf, "bound")

	typeof = var_1_10006
	BoxCollider2D = var_8
	arg_1_0._collider = var_1_10003(var_1_0, var_1_10006(var_8))
	findTF = var_3
	arg_1_0.imgTf = var_3(arg_1_0._tf, "img")
	GetComponent = var_3
	findTF = var_5

	local var_1_1 = var_5(arg_1_0.imgTf, "char")

	typeof = var_6
	SpineAnimUI = var_8
	arg_1_0._charSpineAnim = var_3(var_1_1, var_6(var_8))
	findTF = var_3
	arg_1_0._yanwuTf = var_3(arg_1_0.imgTf, "yanwu")
	GetComponent = var_3

	local var_1_2 = arg_1_0._yanwuTf

	typeof = var_6
	SpineAnimUI = var_8
	arg_1_0._yanwuAnimUI = var_3(var_1_2, var_6(var_8))
	findTF = var_3
	arg_1_0._hpTf = var_3(arg_1_0._tf, "hp")
	setActive = var_3

	var_3(arg_1_0._tf, false)

	GetComponent = var_3

	local var_1_3 = arg_1_0._tf

	typeof = var_6
	Animator = var_8
	arg_1_0._playerAnimator = var_3(var_1_3, var_6(var_8))
	findTF = var_3
	arg_1_0.battleEffectTf = var_3(arg_1_0._tf, "battleEffect")
	GetComponent = var_3
	findTF = var_5

	local var_1_4 = var_5(arg_1_0.battleEffectTf, "spine1")

	typeof = var_6
	SpineAnimUI = var_8
	arg_1_0.battleEffectSpine1 = var_3(var_1_4, var_6(var_8))
	GetComponent = var_3
	findTF = var_1_4

	local var_1_5 = var_1_4(arg_1_0.battleEffectTf, "spine2")

	typeof = var_6
	SpineAnimUI = var_8
	arg_1_0.battleEffectSpine2 = var_3(var_1_5, var_6(var_8))
	findTF = var_3
	arg_1_0.guardTf = var_3(arg_1_0._tf, "guard")

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
	SetParent = var_1_10002

	var_1_10002(arg_3_0._tf, arg_3_1)

	return
end

function var_0_0.changeDirect(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._directX = arg_4_1
	arg_4_0._directY = arg_4_2

	local var_4_0 = arg_4_0._battleHp

	if 0 < var_4_0 then
		local var_4_1 = arg_4_0.imgTf

		Vector3 = var_4
		var_4_1.localEulerAngles = var_4(0, 0, 0)
	elseif arg_4_0._directX < 0 then
		local var_4_2 = arg_4_0.imgTf

		Vector3 = var_4
		var_4_2.localEulerAngles = var_4(0, 0, 3)
	else
		local var_4_3 = arg_4_0._directX

		if 0 < var_4_3 then
			local var_4_4 = arg_4_0.imgTf

			Vector3 = var_4
			var_4_4.localEulerAngles = var_4(0, 0, -3)
		else
			local var_4_5 = arg_4_0.imgTf

			Vector3 = var_4
			var_4_5.localEulerAngles = var_4(0, 0, 0)
		end
	end

	return
end

function var_0_0.getWorld(arg_5_0)
	return arg_5_0._tf.position
end

function var_0_0.start(arg_6_0)
	arg_6_0._directX = 0
	arg_6_0._directY = 0
	setActive = var_1

	var_1(arg_6_0._tf, true)

	local var_6_0 = arg_6_0._tf

	var_6_0.anchoredPosition = arg_6_0:getConfig("start_pos")
	Vector2 = var_6_0
	arg_6_0._speed = var_6_0(0, 0)
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
	local var_7_0 = false

	arg_7_0.stepSound = arg_7_0.stepSound - arg_7_1

	local var_7_1 = arg_7_0._battleHp

	if 0 < var_7_1 then
		local var_7_2 = arg_7_0._battleHp
		local var_7_3

		if not (arg_7_0._battleSubHp < var_7_2) or not arg_7_0._battleSubHp then
			var_7_3 = arg_7_0._battleHp
		end

		arg_7_0._battleHp = arg_7_0._battleHp - var_7_3

		arg_7_0:subHp(var_7_3)

		if arg_7_0._hp <= 0 then
			arg_7_0._hp = 0
			arg_7_0._battleHp = 0
		end

		local var_7_4 = true

		arg_7_0:updateUI()

		if arg_7_0.stepSound <= 0 then
			pg = var_4

			local var_7_5 = var_4.CriMgr.GetInstance()

			var_4.PlaySoundEffect_V3(var_7_5, var_0_1.SFX_SOUND_BATTLE)

			arg_7_0.stepSound = var_0_3
		end
	end

	if arg_7_0:getLife() and arg_7_0._battleHp == 0 then
		local var_7_6 = arg_7_0:getNextPosition(arg_7_0._directX, arg_7_0._directY)

		math = var_4

		if not (var_4.abs(var_7_6.x) > var_0_2.player_width / 2 + 50) then
			math = var_4

			if var_4.abs(var_7_6.y) > var_0_2.player_height / 2 + 50 then
				-- block empty
			else
				arg_7_0._tf.anchoredPosition = var_7_6

				arg_7_0:updateCharMoveCount()
			end
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
		setActive = var_1

		var_1(arg_11_0.guardTf, arg_11_0.guardTime > 0)
	end

	return
end

function var_0_0.updateChange(arg_12_0, arg_12_1)
	arg_12_0._changeIndex = arg_12_0:getCharChange()

	if arg_12_1 then
		setActive = var_2

		var_2(arg_12_0._yanwuTf, true)
		arg_12_0:setAnimation(arg_12_0._yanwuAnimUI, "normal", function()
			setActive = var_2_10000

			var_2_10000(arg_12_0._yanwuTf, false)

			return
		end)
		arg_12_0:setAnimation(arg_12_0._charSpineAnim, "normal" .. arg_12_0._changeIndex)
	else
		setActive = var_2

		var_2(arg_12_0._yanwuTf, false)
		arg_12_0:setAnimation(arg_12_0._charSpineAnim, "normal" .. arg_12_0._changeIndex)
	end

	return
end

function var_0_0.getCharChange(arg_14_0)
	local var_14_0 = 1
	local var_14_1 = 1

	BoatAdGameConst = var_1_10003

	for iter_14_0 = var_14_1, #var_1_10003.char_change_hp do
		local var_14_2 = arg_14_0._hp

		BoatAdGameConst = var_1_10007

		if var_1_10007.char_change_hp[iter_14_0] <= var_14_2 then
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
			local var_16_0 = arg_15_1

			var_1.SetActionCallBack(var_16_0, nil)

			if arg_15_3 then
				arg_15_3()
			end
		end

		return
	end)

	return
end

function var_0_0.updateUI(arg_17_0)
	if arg_17_0._battleHp > 0 then
		isActive = var_1

		if not var_1(arg_17_0.battleEffectTf) then
			setActive = var_1

			var_1(arg_17_0.battleEffectTf, true)
			arg_17_0:setAnimation(arg_17_0.battleEffectSpine1, "normal")
			arg_17_0:setAnimation(arg_17_0.battleEffectSpine2, "normal")

			goto label_17_0
		end
	end

	if arg_17_0._battleHp <= 0 then
		isActive = var_1

		if var_1(arg_17_0.battleEffectTf) then
			setActive = var_1

			var_1(arg_17_0.battleEffectTf, false)
		end
	end

	::label_17_0::

	setText = var_1

	var_1(arg_17_0._hpTf, arg_17_0._hp)
	arg_17_0:updateGuard()

	return
end

function var_0_0.updateCharMoveCount(arg_18_0)
	local var_18_0 = arg_18_0._tf.anchoredPosition.x
	local var_18_1
	local var_18_2

	ipairs = var_1_10004
	BoatAdGameConst = var_1_10006

	for iter_18_0, iter_18_1 in var_1_10004(var_1_10006.move_line_width) do
		if not var_18_2 then
			math = var_1_10009
			var_18_2 = var_1_10009.abs(var_18_0 - iter_18_1)
			var_18_1 = iter_18_0
		else
			math = var_1_10009

			if var_1_10009.abs(var_18_0 - iter_18_1) < var_18_2 then
				math = var_1_10009
				var_18_2 = var_1_10009.abs(var_18_0 - iter_18_1)
				var_18_1 = iter_18_0
			end
		end
	end

	if arg_18_0.moveCount ~= var_18_1 then
		print = var_4

		var_4("设置角色moveCount" .. var_18_1)
	end

	arg_18_0.moveCount = var_18_1

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

	local var_22_0

	if not arg_22_2 or not var_0_2.battle_sub_hp_boss then
		var_22_0 = var_0_2.battle_sub_hp
	end

	arg_22_0._battleSubHp = var_22_0

	return
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
	local var_28_0 = arg_28_0._content
	local var_28_1 = var_1.InverseTransformPoint(var_28_0, arg_28_0._collider.bounds.min)

	if not arg_28_0._boundData then
		local var_28_2 = arg_28_0._content
		local var_28_3 = var_2.InverseTransformPoint(var_28_2, arg_28_0._collider.bounds.max)
		local var_28_4 = {}

		math = var_28_2
		var_28_4.width = var_28_2.floor(var_28_3.x - var_28_1.x)
		math = var_4
		var_28_4.height = var_4.floor(var_28_3.y - var_28_1.y)
		arg_28_0._boundData = var_28_4
	end

	return var_28_1, arg_28_0._boundData
end

function var_0_0.flash(arg_29_0)
	local var_29_0 = arg_29_0._playerAnimator

	var_1.SetTrigger(var_29_0, "flash")

	return
end

function var_0_0.changeHp(arg_30_0, arg_30_1, arg_30_2)
	if arg_30_1 ~= 0 then
		local var_30_0 = arg_30_0._hp

		BoatAdGameConst = var_1_10004

		if arg_30_2 == var_1_10004.hp_type_sub then
			var_30_0 = arg_30_0._hp + arg_30_1
		else
			BoatAdGameConst = var_4

			if arg_30_2 == var_4.hp_type_mul then
				var_30_0 = arg_30_0._hp * arg_30_1
			else
				BoatAdGameConst = var_4

				if arg_30_2 == var_4.hp_type_div then
					var_30_0 = arg_30_0._hp / arg_30_1
				end
			end
		end

		math = var_4

		if var_4.floor(var_30_0) < arg_30_0._hp then
			arg_30_0:flash()
		end

		if arg_30_0:getGuard() and var_3 <= arg_30_0._hp then
			arg_30_0._hp = arg_30_0._hp
		else
			arg_30_0._hp = var_3
		end

		arg_30_0:updateUI()

		if arg_30_0._changeIndex ~= arg_30_0:getCharChange() then
			arg_30_0:updateChange(true)
		end
	end

	return
end

function var_0_0.getWorldColliderData(arg_31_0)
	local var_31_0 = arg_31_0._collider.bounds.min

	if not arg_31_0._worldBoundData then
		local var_31_1 = arg_31_0._collider.bounds.max

		arg_31_0._worldBoundData = {
			width = var_31_1.x - var_31_0.x,
			height = var_31_1.y - var_31_0.y
		}
	end

	return var_31_0, arg_31_0._worldBoundData
end

function var_0_0.getLife(arg_32_0)
	return arg_32_0._hp > 0
end

function var_0_0.getColliderMinPosition(arg_33_0)
	if not arg_33_0._minPosition then
		local var_33_0 = arg_33_0._tf

		arg_33_0._minPosition = var_1.InverseTransformPoint(var_33_0, arg_33_0._collider.bounds.min)
	end

	return arg_33_0._minPosition
end

function var_0_0.getBoundData(arg_34_0)
	local var_34_0 = arg_34_0._content
	local var_34_1 = var_1.InverseTransformPoint(var_34_0, arg_34_0._collider.bounds.min)

	if not arg_34_0._boundData then
		local var_34_2 = arg_34_0._content
		local var_34_3 = var_2.InverseTransformPoint(var_34_2, arg_34_0._collider.bounds.max)
		local var_34_4 = {}

		math = var_34_2
		var_34_4.width = var_34_2.floor(var_34_3.x - var_34_1.x)
		math = var_4
		var_34_4.height = var_4.floor(var_34_3.y - var_34_1.y)
		arg_34_0._boundData = var_34_4
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
	setActive = var_1

	var_1(arg_38_0.guardTf, false)

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
	local var_42_0 = arg_42_0._tf.anchoredPosition

	math = var_1_10003

	local var_42_1 = var_1_10003.abs(var_42_0.x - arg_42_1.x)

	math = var_1_10004

	local var_42_2 = var_1_10004.abs(var_42_0.y - arg_42_1.y)

	if var_42_1 < arg_42_0:getConfig("range") and var_42_2 < arg_42_0:getConfig("range") then
		return true
	end

	return false
end

function var_0_0.dispose(arg_43_0)
	return
end

return var_0_0
