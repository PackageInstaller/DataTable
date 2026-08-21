local var_0_0 = class("FushunBeastChar")

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
	arg_1_0.animator = arg_1_0._go:GetComponent(typeof(Animator))
	arg_1_0.animatorEvent = arg_1_0._go:GetComponent(typeof(DftAniEvent))
	arg_1_0.collider2D = arg_1_0._tf:GetComponent(typeof(UnityEngine.Collider2D))
	arg_1_0.effectCollider2D = arg_1_0._tf:Find("effect"):GetComponent(typeof(UnityEngine.Collider2D))
	arg_1_0.hpBar = UIItemList.New(arg_1_1.transform:Find("hp"), arg_1_1.transform:Find("hp/tpl"))

	arg_1_0:MakeHpBar()

	return
end

function var_0_0.MakeHpBar(arg_2_0)
	setActive(arg_2_0.hpBar.container, true)
	arg_2_0.hpBar:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
			setActive(arg_3_2:Find("mark"), arg_3_1 < arg_2_0.hp)
		end

		return
	end)
	arg_2_0.hpBar:align(arg_2_0.maxHp)

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
	return arg_7_0._tf.localPosition - Vector3(arg_7_0.attackDistance, 0, 0)
end

function var_0_0.Move(arg_8_0)
	if arg_8_0.attacking then
		return
	end

	arg_8_0._tf:Translate(Vector3(-1 * arg_8_0.speed * Time.deltaTime, 0, 0))
	arg_8_0.animator:SetFloat("speed", arg_8_0.speed)

	return
end

function var_0_0.Attack(arg_9_0)
	arg_9_0.animatorEvent:SetEndEvent(nil)
	arg_9_0.animatorEvent:SetEndEvent(function()
		arg_9_0.attacking = false

		arg_9_0:Unfreeze()
		arg_9_0:Die()

		return
	end)
	arg_9_0.animatorEvent:SetTriggerEvent(nil)
	arg_9_0.animatorEvent:SetTriggerEvent(function()
		setActive(arg_9_0.hpBar.container, false)

		return
	end)

	arg_9_0.attacking = true

	arg_9_0.animator:SetTrigger("attack")

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
	arg_16_0.hp = math.max(arg_16_1, 0)

	arg_16_0.hpBar:align(arg_16_0.maxHp)

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
	return arg_21_0:IsDeath() or arg_21_0:IsEscape()
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

		arg_23_0.animatorEvent:SetEndEvent(nil)
		arg_23_0.animatorEvent:SetEndEvent(function()
			arg_23_0:Dispose()

			return
		end)
		arg_23_0.animator:SetTrigger("vanish")
	end

	setActive(arg_23_0.hpBar.container, false)

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
	arg_28_0.animatorEvent:SetTriggerEvent(nil)
	arg_28_0.animatorEvent:SetEndEvent(nil)

	if arg_28_0._go then
		Destroy(arg_28_0._go)
	end

	arg_28_0._go = nil
	arg_28_0._tf = nil
	arg_28_0.animator = nil

	return
end

return var_0_0
