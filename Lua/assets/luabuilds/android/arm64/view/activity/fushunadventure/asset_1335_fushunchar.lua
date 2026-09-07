local FushunChar = class("FushunChar")
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4 = 4
local var_0_5 = 5

function FushunChar:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.animator = self._go:GetComponent(typeof(Animator))
	self.animatorEvent = self._go:GetComponent(typeof(DftAniEvent))
	self.contactFilter2D = UnityEngine.ContactFilter2D.New()
	self.contactFilter2D.useTriggers = true
	self.keys = {}
	self.state = var_0_1
	self.hp = 3
	self.harm = 0
	self.energy = 0
	self.exEnergyTarget = 100
	self.collider2D = self._go:GetComponent(typeof(UnityEngine.Collider2D))
	self.effectCollider2D = self._tf:Find("effect"):GetComponent(typeof(UnityEngine.Collider2D))

	self.animatorEvent:SetEndEvent(function()
		if self.state == var_0_5 then
			return
		end

		self.state = var_0_1

		if self.OnAttackFinish then
			self.OnAttackFinish()

			self.OnAttackFinish = nil
		end

		self.harm = 0

		if self.OnAnimEnd then
			self.OnAnimEnd()
		end

		return
	end)

	return
end

function FushunChar:GetAttackPosition()
	return Vector3(FushunAdventureGameConst.FUSHUN_ATTACK_DISTANCE + self._tf.localPosition.x, self._tf.localPosition.y, 0)
end

function FushunChar:ClearHarm()
	if self.state == var_0_5 then
		return
	end

	self.harm = 0

	return
end

function FushunChar:GetHarm()
	return math.max(0, self.harm)
end

function FushunChar:SetOnAnimEnd(arg_6_1)
	self.OnAnimEnd = arg_6_1

	return
end

function FushunChar:SetPosition(arg_7_1)
	self._tf.localPosition = arg_7_1

	return
end

function FushunChar:GetPosition()
	return self._tf.localPosition
end

function FushunChar:InAttackState()
	return self.state == var_0_2
end

function FushunChar:TriggerAction(arg_10_1, arg_10_2)
	if self.state == var_0_1 or self.state == var_0_2 then
		self.state = var_0_2
		self.harm = self.harm + 1
		self.OnAttackFinish = arg_10_2

		self:StartAction(arg_10_1)
	end

	return
end

function FushunChar:Miss()
	if self.state == var_0_5 then
		return
	end

	if self.OnAttackFinish then
		self.OnAttackFinish = nil
	end

	self.state = var_0_4

	self:StartAction("miss")

	return
end

function FushunChar:Hurt()
	if self.state == var_0_5 then
		return
	end

	if self.OnAttackFinish then
		self.OnAttackFinish = nil
	end

	self.state = var_0_3
	self.hp = self.hp - 1

	self:StartAction("damage")

	return
end

function FushunChar:AddEnergy(arg_13_1)
	if self.state == var_0_5 then
		return
	end

	self.energy = math.min(self.energy + arg_13_1, self.exEnergyTarget)

	return
end

function FushunChar:StartAction(arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(self.keys) do
		self.animator:ResetTrigger(iter_14_0)
	end

	self.animator:SetTrigger(arg_14_1)

	self.keys[arg_14_1] = true

	return
end

function FushunChar:GetHp()
	return self.hp
end

function FushunChar:IsDeath()
	return self.hp <= 0
end

function FushunChar:Die()
	self:StartAction("down")

	return
end

function FushunChar:GetEnergy()
	return self.energy
end

function FushunChar:GetEnergyTarget()
	return self.exEnergyTarget
end

function FushunChar:ReduceEnergy(arg_20_1)
	self.energy = self.energy - arg_20_1

	return
end

function FushunChar:ShouldInvincible()
	return self.state ~= var_0_5 and self.energy >= self.exEnergyTarget
end

function FushunChar:ShouldVincible()
	if self.state == var_0_5 and self.energy <= 0 then
		return true
	end

	return false
end

function FushunChar:InvincibleState()
	return self.state == var_0_5
end

function FushunChar:Invincible()
	self.harm = 1
	self.state = var_0_5

	return
end

function FushunChar:IsMissState()
	return self.state == var_0_4
end

function FushunChar:IsDamageState()
	return self.state == var_0_3
end

function FushunChar:Vincible()
	self:StartAction("EX_FINISH")

	self.harm = 0
	self.state = var_0_1

	return
end

function FushunChar:Destory()
	self.animatorEvent:SetEndEvent(nil)
	Destroy(self._go)

	self._go = nil
	self.animator = nil

	return
end

return FushunChar
