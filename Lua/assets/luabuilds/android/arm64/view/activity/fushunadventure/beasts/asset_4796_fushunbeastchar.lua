local FushunBeastChar = class("FushunBeastChar")

function FushunBeastChar:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.index = arg_1_2
	self.template_id = arg_1_3.id
	self.name = arg_1_3.name
	self.dir = -1
	self.maxHp = arg_1_3.hp
	self.hp = arg_1_3.hp
	self.attackDistance = arg_1_3.attackDistance
	self.score = arg_1_3.score
	self.energyScore = arg_1_3.energyScore
	self.escape = false
	self.freeze = false
	self.attacking = false
	self.animator = self._go:GetComponent(typeof(Animator))
	self.animatorEvent = self._go:GetComponent(typeof(DftAniEvent))
	self.collider2D = self._tf:GetComponent(typeof(UnityEngine.Collider2D))
	self.effectCollider2D = self._tf:Find("effect"):GetComponent(typeof(UnityEngine.Collider2D))
	self.hpBar = UIItemList.New(arg_1_1.transform:Find("hp"), arg_1_1.transform:Find("hp/tpl"))

	self:MakeHpBar()

	return
end

function FushunBeastChar:MakeHpBar()
	setActive(self.hpBar.container, true)
	self.hpBar:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
			setActive(arg_3_2:Find("mark"), arg_3_1 < self.hp)
		end

		return
	end)
	self.hpBar:align(self.maxHp)

	return
end

function FushunBeastChar:SetSpeed(arg_4_1)
	self.speed = arg_4_1

	return
end

function FushunBeastChar:SetPosition(arg_5_1)
	self._tf.localPosition = arg_5_1

	return
end

function FushunBeastChar:GetPosition()
	return self._tf.localPosition
end

function FushunBeastChar:GetAttackPosition()
	return self._tf.localPosition - Vector3(self.attackDistance, 0, 0)
end

function FushunBeastChar:Move()
	if self.attacking then
		return
	end

	self._tf:Translate(Vector3(-1 * self.speed * Time.deltaTime, 0, 0))
	self.animator:SetFloat("speed", self.speed)

	return
end

function FushunBeastChar:Attack()
	self.animatorEvent:SetEndEvent(nil)
	self.animatorEvent:SetEndEvent(function()
		self.attacking = false

		self:Unfreeze()
		self:Die()

		return
	end)
	self.animatorEvent:SetTriggerEvent(nil)
	self.animatorEvent:SetTriggerEvent(function()
		setActive(self.hpBar.container, false)

		return
	end)

	self.attacking = true

	self.animator:SetTrigger("attack")

	return
end

function FushunBeastChar:OnHit()
	self.escape = true

	self:Freeze()

	return
end

function FushunBeastChar:IsEscape()
	return self.escape
end

function FushunBeastChar:Die()
	self:UpdateHp(0)

	return
end

function FushunBeastChar:Hurt(arg_15_1)
	if self:IsDeath() or self:IsEscape() then
		return
	end

	self:UpdateHp(self.hp - arg_15_1)

	return
end

function FushunBeastChar:UpdateHp(arg_16_1)
	self.hp = math.max(arg_16_1, 0)

	self.hpBar:align(self.maxHp)

	return
end

function FushunBeastChar:IsFreeze()
	return self.freeze
end

function FushunBeastChar:Freeze()
	self.freeze = true

	return
end

function FushunBeastChar:Unfreeze()
	self.freeze = false

	return
end

function FushunBeastChar:IsDeath()
	return self.hp <= 0
end

function FushunBeastChar:WillDeath()
	return self:IsDeath() or self:IsEscape()
end

function FushunBeastChar:GetHp()
	return self.hp
end

function FushunBeastChar:Vanish()
	if self.vanish then
		return
	end

	if self:IsEscape() then
		self:Dispose()
	else
		self.vanish = true

		self.animatorEvent:SetEndEvent(nil)
		self.animatorEvent:SetEndEvent(function()
			self:Dispose()

			return
		end)
		self.animator:SetTrigger("vanish")
	end

	setActive(self.hpBar.container, false)

	return
end

function FushunBeastChar:GetScore()
	return self.score
end

function FushunBeastChar:GetEnergyScore()
	return self.energyScore
end

function FushunBeastChar:GetMaxHp()
	return self.maxHp
end

function FushunBeastChar:Dispose()
	self.animatorEvent:SetTriggerEvent(nil)
	self.animatorEvent:SetEndEvent(nil)

	if self._go then
		Destroy(self._go)
	end

	self._go = nil
	self._tf = nil
	self.animator = nil

	return
end

return FushunBeastChar
