class = var_0_10000

local var_0_0 = var_0_10000("FushunBeastChar")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.index = arg_1_2
	arg_1_0.template_id = arg_1_3.id
	arg_1_0.name = arg_1_3.name
	arg_1_0.dir = -1
	arg_1_0.maxHp = arg_1_3.hp
	arg_1_0.hp = arg_1_3.hp
	arg_1_0.attackDistance = arg_1_3.attackDistance
	arg_1_0.score = arg_1_3.score
	arg_1_0.energyScore = arg_1_3.energyScore
	arg_1_0.escape = false
	arg_1_0.freeze = false
	arg_1_0.attacking = false

	local var_1_0 = arg_1_0._go
	local var_1_1 = var_4.GetComponent

	typeof = var_1_10007
	Animator = var_1_10009
	arg_1_0.animator = var_1_1(var_1_0, var_1_10007(var_1_10009))

	local var_1_2 = arg_1_0._go
	local var_1_3 = var_4.GetComponent

	typeof = var_7
	DftAniEvent = var_1_10009
	arg_1_0.animatorEvent = var_1_3(var_1_2, var_7(var_1_10009))

	local var_1_4 = arg_1_0._tf
	local var_1_5 = var_4.GetComponent

	typeof = var_7
	UnityEngine = var_1_10009
	arg_1_0.collider2D = var_1_5(var_1_4, var_7(var_1_10009.Collider2D))

	local var_1_6 = arg_1_0._tf
	local var_1_7 = var_4.Find(var_1_6, "effect")
	local var_1_8 = var_4.GetComponent

	typeof = var_7
	UnityEngine = var_9
	arg_1_0.effectCollider2D = var_1_8(var_1_7, var_7(var_9.Collider2D))
	UIItemList = var_4

	local var_1_9 = var_4.New
	local var_1_10 = arg_1_1.transform
	local var_1_11 = var_6.Find(var_1_10, "hp")
	local var_1_12 = arg_1_1.transform

	arg_1_0.hpBar = var_1_9(var_1_11, var_7.Find(var_1_12, "hp/tpl"))

	arg_1_0:MakeHpBar()

	return
end

function var_0_0.MakeHpBar(arg_2_0)
	setActive = var_1_10001

	var_1_10001(arg_2_0.hpBar.container, true)

	local var_2_0 = arg_2_0.hpBar

	var_1.make(var_2_0, function(arg_3_0, arg_3_1, arg_3_2)
		UIItemList = var_2_10003

		if arg_3_0 == var_2_10003.EventUpdate then
			setActive = var_3

			var_3(arg_3_2:Find("mark"), arg_3_1 < arg_2_0.hp)
		end

		return
	end)

	local var_2_1 = arg_2_0.hpBar

	var_1.align(var_2_1, arg_2_0.maxHp)

	return
end

function var_0_0.SetSpeed(arg_4_0, arg_4_1)
	arg_4_0.speed = arg_4_1

	return
end

function var_0_0.SetPosition(arg_5_0, arg_5_1)
	arg_5_0._tf.localPosition = arg_5_1

	return
end

function var_0_0.GetPosition(arg_6_0)
	return arg_6_0._tf.localPosition
end

function var_0_0.GetAttackPosition(arg_7_0)
	local var_7_0 = arg_7_0._tf.localPosition

	Vector3 = var_1_10002

	return var_7_0 - var_1_10002(arg_7_0.attackDistance, 0, 0)
end

function var_0_0.Move(arg_8_0)
	if arg_8_0.attacking then
		return
	end

	local var_8_0 = arg_8_0._tf
	local var_8_1 = var_1.Translate

	Vector3 = var_1_10004

	local var_8_2 = -1 * arg_8_0.speed

	Time = var_1_10007

	var_8_1(var_8_0, var_1_10004(var_8_2 * var_1_10007.deltaTime, 0, 0))

	local var_8_3 = arg_8_0.animator

	var_1.SetFloat(var_8_3, "speed", arg_8_0.speed)

	return
end

function var_0_0.Attack(arg_9_0)
	local var_9_0 = arg_9_0.animatorEvent

	var_1.SetEndEvent(var_9_0, nil)

	local var_9_1 = arg_9_0.animatorEvent

	var_1.SetEndEvent(var_9_1, function()
		arg_9_0.attacking = false

		local var_10_0 = arg_9_0

		var_0.Unfreeze(var_10_0)

		local var_10_1 = arg_9_0

		var_0.Die(var_10_1)

		return
	end)

	local var_9_2 = arg_9_0.animatorEvent

	var_1.SetTriggerEvent(var_9_2, nil)

	local var_9_3 = arg_9_0.animatorEvent

	var_1.SetTriggerEvent(var_9_3, function()
		setActive = var_2_10000

		var_2_10000(arg_9_0.hpBar.container, false)

		return
	end)

	arg_9_0.attacking = true

	local var_9_4 = arg_9_0.animator

	var_1.SetTrigger(var_9_4, "attack")

	return
end

function var_0_0.OnHit(arg_12_0)
	arg_12_0.escape = true

	arg_12_0:Freeze()

	return
end

function var_0_0.IsEscape(arg_13_0)
	return arg_13_0.escape
end

function var_0_0.Die(arg_14_0)
	arg_14_0:UpdateHp(0)

	return
end

function var_0_0.Hurt(arg_15_0, arg_15_1)
	if arg_15_0:IsDeath() or arg_15_0:IsEscape() then
		return
	end

	arg_15_0:UpdateHp(arg_15_0.hp - arg_15_1)

	return
end

function var_0_0.UpdateHp(arg_16_0, arg_16_1)
	math = var_1_10002
	arg_16_0.hp = var_1_10002.max(arg_16_1, 0)

	local var_16_0 = arg_16_0.hpBar

	var_2.align(var_16_0, arg_16_0.maxHp)

	return
end

function var_0_0.IsFreeze(arg_17_0)
	return arg_17_0.freeze
end

function var_0_0.Freeze(arg_18_0)
	arg_18_0.freeze = true

	return
end

function var_0_0.Unfreeze(arg_19_0)
	arg_19_0.freeze = false

	return
end

function var_0_0.IsDeath(arg_20_0)
	return arg_20_0.hp <= 0
end

function var_0_0.WillDeath(arg_21_0)
	local var_21_0

	if not arg_21_0:IsDeath() then
		var_21_0 = arg_21_0:IsEscape()
	end

	return var_21_0
end

function var_0_0.GetHp(arg_22_0)
	return arg_22_0.hp
end

function var_0_0.Vanish(arg_23_0)
	if arg_23_0.vanish then
		return
	end

	if arg_23_0:IsEscape() then
		arg_23_0:Dispose()
	else
		arg_23_0.vanish = true

		local var_23_0 = arg_23_0.animatorEvent

		var_1.SetEndEvent(var_23_0, nil)

		local var_23_1 = arg_23_0.animatorEvent

		var_1.SetEndEvent(var_23_1, function()
			local var_24_0 = arg_23_0

			var_0.Dispose(var_24_0)

			return
		end)

		local var_23_2 = arg_23_0.animator

		var_1.SetTrigger(var_23_2, "vanish")
	end

	setActive = var_1

	var_1(arg_23_0.hpBar.container, false)

	return
end

function var_0_0.GetScore(arg_25_0)
	return arg_25_0.score
end

function var_0_0.GetEnergyScore(arg_26_0)
	return arg_26_0.energyScore
end

function var_0_0.GetMaxHp(arg_27_0)
	return arg_27_0.maxHp
end

function var_0_0.Dispose(arg_28_0)
	local var_28_0 = arg_28_0.animatorEvent

	var_1.SetTriggerEvent(var_28_0, nil)

	local var_28_1 = arg_28_0.animatorEvent

	var_1.SetEndEvent(var_28_1, nil)

	if arg_28_0._go then
		Destroy = var_1

		var_1(arg_28_0._go)
	end

	arg_28_0._go = nil
	arg_28_0._tf = nil
	arg_28_0.animator = nil

	return
end

return var_0_0
