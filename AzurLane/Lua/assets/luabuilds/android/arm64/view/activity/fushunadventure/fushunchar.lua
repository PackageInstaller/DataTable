local var_0_0 = class("FushunChar")
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4 = 4
local var_0_5 = 5

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.animator = arg_1_0._go:GetComponent(typeof(Animator))
	arg_1_0.animatorEvent = arg_1_0._go:GetComponent(typeof(DftAniEvent))
	arg_1_0.contactFilter2D = UnityEngine.ContactFilter2D.New()
	arg_1_0.contactFilter2D.useTriggers = true
	arg_1_0.keys = {}
	arg_1_0.state = var_0_1
	arg_1_0.hp = 3
	arg_1_0.harm = 0
	arg_1_0.energy = 0
	arg_1_0.exEnergyTarget = 100
	arg_1_0.collider2D = arg_1_0._go:GetComponent(typeof(UnityEngine.Collider2D))
	arg_1_0.effectCollider2D = arg_1_0._tf:Find("effect"):GetComponent(typeof(UnityEngine.Collider2D))

	arg_1_0.animatorEvent:SetEndEvent(function()
		if arg_1_0.state == var_0_5 then
			return
		end

		arg_1_0.state = var_0_1

		if arg_1_0.OnAttackFinish then
			arg_1_0.OnAttackFinish()

			arg_1_0.OnAttackFinish = nil
		end

		arg_1_0.harm = 0

		if arg_1_0.OnAnimEnd then
			arg_1_0.OnAnimEnd()
		end

		return
	end)

	return
end

function var_0_0.GetAttackPosition(arg_3_0)
	return Vector3(FushunAdventureGameConst.FUSHUN_ATTACK_DISTANCE + arg_3_0._tf.localPosition.x, arg_3_0._tf.localPosition.y, 0)
end

function var_0_0.ClearHarm(arg_4_0)
	if arg_4_0.state == var_0_5 then
		return
	end

	arg_4_0.harm = 0

	return
end

function var_0_0.GetHarm(arg_5_0)
	return math.max(0, arg_5_0.harm)
end

function var_0_0.SetOnAnimEnd(arg_6_0, arg_6_1)
	arg_6_0.OnAnimEnd = arg_6_1

	return
end

function var_0_0.SetPosition(arg_7_0, arg_7_1)
	arg_7_0._tf.localPosition = arg_7_1

	return
end

function var_0_0.GetPosition(arg_8_0)
	return arg_8_0._tf.localPosition
end

function var_0_0.InAttackState(arg_9_0)
	return arg_9_0.state == var_0_2
end

function var_0_0.TriggerAction(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0.state == var_0_1 or arg_10_0.state == var_0_2 then
		arg_10_0.state = var_0_2
		arg_10_0.harm = arg_10_0.harm + 1
		arg_10_0.OnAttackFinish = arg_10_2

		arg_10_0:StartAction(arg_10_1)
	end

	return
end

function var_0_0.Miss(arg_11_0)
	if arg_11_0.state == var_0_5 then
		return
	end

	if arg_11_0.OnAttackFinish then
		arg_11_0.OnAttackFinish = nil
	end

	arg_11_0.state = var_0_4

	arg_11_0:StartAction("miss")

	return
end

function var_0_0.Hurt(arg_12_0)
	if arg_12_0.state == var_0_5 then
		return
	end

	if arg_12_0.OnAttackFinish then
		arg_12_0.OnAttackFinish = nil
	end

	arg_12_0.state = var_0_3
	arg_12_0.hp = arg_12_0.hp - 1

	arg_12_0:StartAction("damage")

	return
end

function var_0_0.AddEnergy(arg_13_0, arg_13_1)
	if arg_13_0.state == var_0_5 then
		return
	end

	arg_13_0.energy = math.min(arg_13_0.energy + arg_13_1, arg_13_0.exEnergyTarget)

	return
end

function var_0_0.StartAction(arg_14_0, arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0.keys) do
		arg_14_0.animator:ResetTrigger(iter_14_0)
	end

	arg_14_0.animator:SetTrigger(arg_14_1)

	arg_14_0.keys[arg_14_1] = true

	return
end

function var_0_0.GetHp(arg_15_0)
	return arg_15_0.hp
end

function var_0_0.IsDeath(arg_16_0)
	return arg_16_0.hp <= 0
end

function var_0_0.Die(arg_17_0)
	arg_17_0:StartAction("down")

	return
end

function var_0_0.GetEnergy(arg_18_0)
	return arg_18_0.energy
end

function var_0_0.GetEnergyTarget(arg_19_0)
	return arg_19_0.exEnergyTarget
end

function var_0_0.ReduceEnergy(arg_20_0, arg_20_1)
	arg_20_0.energy = arg_20_0.energy - arg_20_1

	return
end

function var_0_0.ShouldInvincible(arg_21_0)
	return arg_21_0.state ~= var_0_5 and arg_21_0.energy >= arg_21_0.exEnergyTarget
end

function var_0_0.ShouldVincible(arg_22_0)
	if arg_22_0.state == var_0_5 and arg_22_0.energy <= 0 then
		return true
	end

	return false
end

function var_0_0.InvincibleState(arg_23_0)
	return arg_23_0.state == var_0_5
end

function var_0_0.Invincible(arg_24_0)
	arg_24_0.harm = 1
	arg_24_0.state = var_0_5

	return
end

function var_0_0.IsMissState(arg_25_0)
	return arg_25_0.state == var_0_4
end

function var_0_0.IsDamageState(arg_26_0)
	return arg_26_0.state == var_0_3
end

function var_0_0.Vincible(arg_27_0)
	arg_27_0:StartAction("EX_FINISH")

	arg_27_0.harm = 0
	arg_27_0.state = var_0_1

	return
end

function var_0_0.Destory(arg_28_0)
	arg_28_0.animatorEvent:SetEndEvent(nil)
	Destroy(arg_28_0._go)

	arg_28_0._go = nil
	arg_28_0.animator = nil

	return
end

return var_0_0
