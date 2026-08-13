class = var_0_10000

local var_0_0 = var_0_10000("SailBoatChar")
local var_0_1

var_0_0.fire_cd = 0.1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	SailBoatGameVo = var_1_10003
	var_0_1 = var_1_10003
	arg_1_0._tf = arg_1_1
	arg_1_0._eventCallback = arg_1_2
	GetComponent = var_1_10003
	findTF = var_1_10004

	local var_1_0 = var_1_10004(arg_1_0._tf, "bound")

	typeof = var_5
	BoxCollider2D = var_6
	arg_1_0._collider = var_1_10003(var_1_0, var_5(var_6))
	findTF = var_3
	arg_1_0.imgTf = var_3(arg_1_0._tf, "img")
	GetComponent = var_3

	local var_1_1 = arg_1_0.imgTf

	typeof = var_5
	Animator = var_6
	arg_1_0._animator = var_3(var_1_1, var_5(var_6))

	local var_1_2 = {}

	arg_1_0._rightWeapons = {}
	arg_1_0._leftWeapons = var_1_2
	findTF = var_1_2
	arg_1_0._hpTf = var_1_2(arg_1_0._tf, "hp")
	GetComponent = var_3
	findTF = var_4

	local var_1_3 = var_4(arg_1_0._tf, "hp")

	typeof = var_5
	Slider = var_6
	arg_1_0._hpSlider = var_3(var_1_3, var_5(var_6))
	setActive = var_3

	var_3(arg_1_0._tf, false)

	GetComponent = var_3

	local var_1_4 = arg_1_0._tf

	typeof = var_5
	Animator = var_6
	arg_1_0._playerAnimator = var_3(var_1_4, var_5(var_6))

	return
end

function var_0_0.setData(arg_2_0, arg_2_1)
	arg_2_0._data = arg_2_1
	arg_2_0._baseSpeed = arg_2_0:getConfig("speed")
	arg_2_0._baseHp = arg_2_0:getConfig("hp")

	return
end

function var_0_0.setWeapon(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0._leftWeapons and #arg_3_0._leftWeapons > 0 then
		for iter_3_0 = 1, #arg_3_0._leftWeapons do
			local var_3_0 = arg_3_0._leftWeapons[iter_3_0]

			var_7.clear(var_3_0)
		end
	end

	if arg_3_0._rightWeapons and #arg_3_0._rightWeapons > 0 then
		for iter_3_1 = 1, #arg_3_0._rightWeapons do
			local var_3_1 = arg_3_0._rightWeapons[iter_3_1]

			var_7.clear(var_3_1)
		end
	end

	arg_3_0._leftWeapons = arg_3_1
	arg_3_0._rightWeapons = arg_3_2
	arg_3_0._weaponMaxDistance = nil

	return
end

function var_0_0.setContent(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._content = arg_4_1
	SetParent = var_1_10003

	var_1_10003(arg_4_0._tf, arg_4_1)

	arg_4_0._tf.anchoredPosition = arg_4_2

	return
end

function var_0_0.changeDirect(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._directX = arg_5_1
	arg_5_0._directY = arg_5_2

	if arg_5_0._directX < 0 then
		local var_5_0 = arg_5_0.imgTf

		Vector3 = var_4
		var_5_0.localEulerAngles = var_4(0, 0, 3)
	else
		local var_5_1 = arg_5_0._directX

		if 0 < var_5_1 then
			local var_5_2 = arg_5_0.imgTf

			Vector3 = var_4
			var_5_2.localEulerAngles = var_4(0, 0, -3)
		else
			local var_5_3 = arg_5_0.imgTf

			Vector3 = var_4
			var_5_3.localEulerAngles = var_4(0, 0, 0)
		end
	end

	return
end

function var_0_0.getWorld(arg_6_0)
	return arg_6_0._tf.position
end

function var_0_0.start(arg_7_0)
	arg_7_0._directX = 0
	arg_7_0._directY = 0
	setActive = var_1

	var_1(arg_7_0._tf, true)

	local var_7_0 = arg_7_0._tf

	Vector2 = var_2
	var_7_0.anchoredPosition = var_2(0, 0)

	for iter_7_0 = 1, #arg_7_0._leftWeapons do
		local var_7_1 = arg_7_0._leftWeapons[iter_7_0]

		var_5.start(var_7_1)
	end

	for iter_7_1 = 1, #arg_7_0._rightWeapons do
		local var_7_2 = arg_7_0._rightWeapons[iter_7_1]

		var_5.start(var_7_2)
	end

	Vector2 = var_1
	arg_7_0._speed = var_1(0, 0)
	arg_7_0._speed.x = arg_7_0._baseSpeed.x + arg_7_0:getEquipAttr("speed")
	arg_7_0._speed.y = arg_7_0._baseSpeed.y + arg_7_0:getEquipAttr("speed")
	arg_7_0._hp = arg_7_0._baseHp + arg_7_0:getEquipAttr("hp")
	arg_7_0._hpSlider.minValue = 0
	arg_7_0._hpSlider.maxValue = arg_7_0._hp
	arg_7_0._timeForDead = nil
	arg_7_0._fireLeftCd = 0
	arg_7_0._fireRightCd = 0
	arg_7_0._skillTime = 0
	arg_7_0.colliderDamageCd = 0
	arg_7_0._hpSlider.value = arg_7_0._hp

	return
end

function var_0_0.step(arg_8_0, arg_8_1)
	if arg_8_0:getLife() then
		local var_8_0 = arg_8_0
		local var_8_1 = arg_8_0.getNextPosition(var_8_0, arg_8_0._directX, arg_8_0._directY)

		math = var_8_0

		if not (var_8_0.abs(var_8_1.x) > var_0_1.scene_width / 2 + 50) then
			math = var_3

			if var_3.abs(var_8_1.y) > var_0_1.scene_height / 2 + 50 then
				-- block empty
			else
				arg_8_0._tf.anchoredPosition = var_8_1
			end
		end

		for iter_8_0 = #arg_8_0._leftWeapons, 1, -1 do
			local var_8_2 = arg_8_0._leftWeapons[iter_8_0]

			var_7.step(var_8_2, arg_8_1)

			if arg_8_0._skillTime and arg_8_0._skillTime > 0 then
				local var_8_3 = arg_8_0._leftWeapons[iter_8_0]

				var_7.skillStep(var_8_3, arg_8_1)
			end
		end

		for iter_8_1 = #arg_8_0._rightWeapons, 1, -1 do
			local var_8_4 = arg_8_0._rightWeapons[iter_8_1]

			var_7.step(var_8_4, arg_8_1)

			if arg_8_0._skillTime and arg_8_0._skillTime > 0 then
				local var_8_5 = arg_8_0._rightWeapons[iter_8_1]

				var_7.skillStep(var_8_5, arg_8_1)
			end
		end
	end

	if arg_8_0._skillTime and arg_8_0._skillTime > 0 then
		arg_8_0._skillTime = arg_8_0._skillTime - arg_8_1
	end

	if arg_8_0.colliderDamageCd and arg_8_0.colliderDamageCd > 0 then
		arg_8_0.colliderDamageCd = arg_8_0.colliderDamageCd - arg_8_1
	end

	if arg_8_0._timeForDead and arg_8_0._timeForDead > 0 then
		arg_8_0._timeForDead = arg_8_0._timeForDead - arg_8_1

		if arg_8_0._timeForDead <= 0 then
			arg_8_0._timeForDead = nil

			local var_8_6 = arg_8_0._eventCallback

			SailBoatGameEvent = var_3

			var_8_6(var_3.PLAYER_DEAD)
		end
	end

	if arg_8_0._fireLeftCd and arg_8_0._fireLeftCd > 0 then
		arg_8_0._fireLeftCd = arg_8_0._fireLeftCd - arg_8_1

		if arg_8_0._fireLeftCd <= 0 then
			arg_8_0._fireLeftCd = 0
		end
	end

	if arg_8_0._fireRightCd and arg_8_0._fireRightCd > 0 then
		arg_8_0._fireRightCd = arg_8_0._fireRightCd - arg_8_1

		if arg_8_0._fireRightCd <= 0 then
			arg_8_0._fireRightCd = 0
		end
	end

	math = var_2

	if not (var_2.abs(arg_8_0._tf.anchoredPosition.x) > var_0_1.scene_width / 2 + 50) then
		math = var_2

		if var_2.abs(arg_8_0._tf.anchoredPosition.y) > var_0_1.scene_height / 2 + 50 then
			local var_8_7 = arg_8_0
			local var_8_8 = arg_8_0.damage
			local var_8_9 = {
				num = 999
			}

			Vector2 = var_1_10005
			var_8_9.position = var_1_10005(0, 0)

			var_8_8(var_8_7, var_8_9)
		end

		return
	end
end

function var_0_0.getHp(arg_9_0)
	return arg_9_0._hp
end

function var_0_0.getHpPos(arg_10_0)
	return arg_10_0._hpTf.position
end

function var_0_0.useSkill(arg_11_0)
	SailBoatGameVo = var_1_10001
	arg_11_0._skillTime = var_1_10001.skillTime
	pg = var_1

	local var_11_0 = var_1.CriMgr.GetInstance()

	var_1.PlaySoundEffect_V3(var_11_0, var_0_1.SFX_SOUND_SKILL)

	return
end

function var_0_0.getNextPosition(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = 0

	if arg_12_1 ~= 0 then
		var_12_0 = arg_12_0._speed.x * arg_12_1 * var_0_1.deltaTime
	end

	local var_12_1 = 0

	if arg_12_2 ~= 0 then
		var_12_1 = arg_12_0._speed.y * arg_12_2 * var_0_1.deltaTime
	end

	local var_12_2 = arg_12_0._tf.anchoredPosition

	if var_12_0 ~= 0 or var_12_1 ~= 0 then
		var_12_2.x = var_12_2.x + var_12_0
		var_12_2.y = var_12_2.y + var_12_1

		return var_12_2
	end

	return var_12_2
end

function var_0_0.getWeapons(arg_13_0)
	return arg_13_0._leftWeapons, arg_13_0._rightWeapons
end

function var_0_0.getFirePos(arg_14_0)
	if not arg_14_0._leftFireTf then
		findTF = var_1
		arg_14_0._leftFireTf = var_1(arg_14_0._tf, "leftFire")
	end

	if not arg_14_0._rightFireTf then
		findTF = var_1
		arg_14_0._rightFireTf = var_1(arg_14_0._tf, "rightFire")
	end

	local var_14_0 = arg_14_0._content
	local var_14_1 = var_1.InverseTransformPoint(var_14_0, arg_14_0._leftFireTf.position)
	local var_14_2 = arg_14_0._content
	local var_14_3 = var_2.InverseTransformPoint(var_14_2, arg_14_0._rightFireTf.position)
end

function var_0_0.getFireContent(arg_15_0)
	return arg_15_0._leftFireTf, arg_15_0._rightFireTf
end

function var_0_0.getWeaponMaxDistance(arg_16_0)
	if not arg_16_0._weaponMaxDistance then
		arg_16_0._weaponMaxDistance = 0

		for iter_16_0 = 1, #arg_16_0._leftWeapons do
			local var_16_0 = arg_16_0._leftWeapons[iter_16_0]

			if var_5.getDistance(var_16_0) > arg_16_0._weaponMaxDistance then
				arg_16_0._weaponMaxDistance = var_5:getDistance()
			end
		end

		for iter_16_1 = 1, #arg_16_0._rightWeapons do
			local var_16_1 = arg_16_0._rightWeapons[iter_16_1]

			if var_5.getDistance(var_16_1) > arg_16_0._weaponMaxDistance then
				arg_16_0._weaponMaxDistance = var_5:getDistance()
			end
		end
	end

	return arg_16_0._weaponMaxDistance
end

function var_0_0.flash(arg_17_0)
	arg_17_0.colliderDamageCd = var_0_1.collider_time

	local var_17_0 = arg_17_0._playerAnimator

	var_1.SetTrigger(var_17_0, "flash")

	return
end

function var_0_0.move(arg_18_0, arg_18_1, arg_18_2)
	var_3.x = arg_18_0._tf.anchoredPosition.x + arg_18_1
	var_3.y = var_3.y + arg_18_2
	arg_18_0._tf.anchoredPosition = var_3

	return
end

function var_0_0.getMaxHp(arg_19_0)
	return arg_19_0._baseHp + arg_19_0:getEquipAttr("hp")
end

function var_0_0.getTf(arg_20_0)
	return arg_20_0._tf
end

function var_0_0.clearEquipData(arg_21_0)
	arg_21_0._equipData = {}

	return
end

function var_0_0.setEquipData(arg_22_0, arg_22_1)
	table = var_1_10002

	var_1_10002.insert(arg_22_0._equipData, arg_22_1)

	return
end

function var_0_0.getEquipAttr(arg_23_0, arg_23_1)
	local var_23_0 = 0

	for iter_23_0 = 1, #arg_23_0._equipData do
		var_23_0 = var_23_0 + arg_23_0._equipData[iter_23_0][arg_23_1]
	end

	return var_23_0
end

function var_0_0.getColliderData(arg_24_0)
	local var_24_0 = arg_24_0._content
	local var_24_1 = var_1.InverseTransformPoint(var_24_0, arg_24_0._collider.bounds.min)

	if not arg_24_0._boundData then
		local var_24_2 = arg_24_0._content
		local var_24_3 = var_2.InverseTransformPoint(var_24_2, arg_24_0._collider.bounds.max)
		local var_24_4 = {}

		math = var_4
		var_24_4.width = var_4.floor(var_24_3.x - var_24_1.x)
		math = var_4
		var_24_4.height = var_4.floor(var_24_3.y - var_24_1.y)
		arg_24_0._boundData = var_24_4
	end

	return var_24_1, arg_24_0._boundData
end

function var_0_0.getWorldColliderData(arg_25_0)
	local var_25_0 = arg_25_0._collider.bounds.min

	if not arg_25_0._worldBoundData then
		local var_25_1 = arg_25_0._collider.bounds.max

		arg_25_0._worldBoundData = {
			width = var_25_1.x - var_25_0.x,
			height = var_25_1.y - var_25_0.y
		}
	end

	return var_25_0, arg_25_0._worldBoundData
end

function var_0_0.addHp(arg_26_0, arg_26_1)
	if arg_26_0:getLife() then
		arg_26_0._hp = arg_26_0._hp + arg_26_1

		if arg_26_0:getMaxHp() < arg_26_0._hp then
			arg_26_0._hp = var_2
		end
	end

	return
end

function var_0_0.getLife(arg_27_0)
	return arg_27_0._hp > 0
end

function var_0_0.getColliderMinPosition(arg_28_0)
	if not arg_28_0._minPosition then
		local var_28_0 = arg_28_0._tf

		arg_28_0._minPosition = var_1.InverseTransformPoint(var_28_0, arg_28_0._collider.bounds.min)
	end

	return arg_28_0._minPosition
end

function var_0_0.getBoundData(arg_29_0)
	local var_29_0 = arg_29_0._content
	local var_29_1 = var_1.InverseTransformPoint(var_29_0, arg_29_0._collider.bounds.min)

	if not arg_29_0._boundData then
		local var_29_2 = arg_29_0._content
		local var_29_3 = var_2.InverseTransformPoint(var_29_2, arg_29_0._collider.bounds.max)
		local var_29_4 = {}

		math = var_4
		var_29_4.width = var_4.floor(var_29_3.x - var_29_1.x)
		math = var_4
		var_29_4.height = var_4.floor(var_29_3.y - var_29_1.y)
		arg_29_0._boundData = var_29_4
	end

	return arg_29_0._boundData
end

function var_0_0.getPosition(arg_30_0)
	return arg_30_0._tf.anchoredPosition
end

function var_0_0.getGroup(arg_31_0)
	return arg_31_0:getConfig("group")
end

function var_0_0.getHitGroup(arg_32_0)
	return arg_32_0:getConfig("hit_group")
end

function var_0_0.inFireCd(arg_33_0, arg_33_1)
	if arg_33_1 > 0 then
		return arg_33_0._fireRightCd > 0
	else
		return arg_33_0._fireLeftCd > 0
	end

	return
end

function var_0_0.fire(arg_34_0, arg_34_1)
	if arg_34_1 > 0 then
		if arg_34_0._fireRightCd <= 0 then
			arg_34_0._fireRightCd = var_0_0.fire_cd

			return true
		end

		return false
	else
		if arg_34_0._fireLeftCd <= 0 then
			arg_34_0._fireLeftCd = var_0_0.fire_cd

			return true
		end

		return false
	end

	return
end

function var_0_0.clear(arg_35_0)
	return
end

function var_0_0.stop(arg_36_0)
	return
end

function var_0_0.checkColliderDamage(arg_37_0)
	return arg_37_0.colliderDamageCd <= 0
end

function var_0_0.damage(arg_38_0, arg_38_1)
	if not arg_38_0:getLife() then
		return
	end

	if arg_38_1.position then
		if var_2.x > arg_38_0._tf.position.x then
			arg_38_0:setInteger("damage_direct", 1)
		else
			arg_38_0:setInteger("damage_direct", -1)
		end
	end

	arg_38_0._hp = arg_38_0._hp - arg_38_1.num

	if arg_38_0._hp <= 0 then
		arg_38_0._hp = 0

		arg_38_0:setTrigger("dead", true)

		arg_38_0._timeForDead = 1
	elseif var_2 then
		arg_38_0:setTrigger("damage")
	end

	return
end

function var_0_0.setTrigger(arg_39_0, arg_39_1, arg_39_2)
	if arg_39_0:getLife() then
		local var_39_0 = arg_39_0._animator

		var_3.SetTrigger(var_39_0, arg_39_1)
	elseif arg_39_2 then
		local var_39_1 = arg_39_0._animator

		var_3.SetTrigger(var_39_1, arg_39_1)
	end

	return
end

function var_0_0.setInteger(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = arg_40_0._animator

	var_3.SetInteger(var_40_0, arg_40_1, arg_40_2)

	return
end

function var_0_0.getMinMaxPosition(arg_41_0)
	return arg_41_0._collider.bounds.min, arg_41_0._collider.bounds.max
end

function var_0_0.getConfig(arg_42_0, arg_42_1)
	return arg_42_0._data[arg_42_1]
end

function var_0_0.checkPositionInRange(arg_43_0, arg_43_1)
	local var_43_0 = arg_43_0._tf.anchoredPosition

	math = var_1_10003

	local var_43_1 = var_1_10003.abs(var_43_0.x - arg_43_1.x)

	math = var_4

	local var_43_2 = var_4.abs(var_43_0.y - arg_43_1.y)

	if var_43_1 < 250 and var_43_2 < 300 then
		return true
	end

	return false
end

function var_0_0.dispose(arg_44_0)
	return
end

return var_0_0
