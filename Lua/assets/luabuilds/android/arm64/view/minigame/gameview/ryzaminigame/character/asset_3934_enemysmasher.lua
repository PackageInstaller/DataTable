local EnemySmasher = class("EnemySmasher", import("view.miniGame.gameView.RyzaMiniGame.character.MoveEnemy"))

EnemySmasher.ConfigSkillCD = 10
EnemySmasher.ConfigSkillCount = 3
EnemySmasher.ImpackRange = 20

function EnemySmasher:InitUI(arg_1_1)
	EnemySmasher.super.InitUI(self, arg_1_1)

	self.hp = arg_1_1.hp or 2
	self.hpMax = self.hp
	self.speed = arg_1_1.speed or 2

	eachChild(self.rtScale:Find("front"), function(arg_2_0)
		arg_2_0:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
			setActive(arg_2_0, false)

			return
		end)

		return
	end)
	self.mainTarget:GetComponent(typeof(DftAniEvent)):SetTriggerEvent(function()
		self.triggerCount = defaultValue(self.triggerCount, 0) + 1

		switch(self.triggerCount, {
			function()
				setActive(self.rtScale:Find("front/EF_Bullet_UP"), true)

				return
			end,
			function()
				setActive(self.rtScale:Find("front/EF_Bullet_UP_High"), true)

				return
			end
		})

		self.triggerCount = self.triggerCount % 2

		return
	end)
	self.mainTarget:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		switch(self.status, {
			Attack_S = function()
				self.impackCD = 0
				self.impackCount = self.ConfigSkillCount

				return
			end
		})

		self.lock = false

		if self.hp <= 0 then
			self:Destroy()
		end

		return
	end)

	self.skillCD = 0
	self.impackCount = 0

	return
end

function EnemySmasher:TimeTrigger(arg_9_1)
	EnemySmasher.super.TimeTrigger(self, arg_9_1)

	self.skillCD = self.skillCD - arg_9_1

	if not self.lock and self.skillCD <= 0 and self.responder:SearchRyza(self, self.search) and (self.responder.reactorRyza.pos - self.pos):SqrMagnitude() >= 4 then
		self:PlayAnim("Attack_S")

		self.skillCD = self.ConfigSkillCD
		self.skillCenterPos = self.responder.reactorRyza.realPos
	end

	if self.impackCount > 0 then
		if (function()
			if self.responder.reactorRyza.hide then
				return false
			else
				local var_10_0 = self.responder.reactorRyza.realPos - self.skillCenterPos

				return (self.responder.reactorRyza.realPos - self.skillCenterPos).x * (self.responder.reactorRyza.realPos - self.skillCenterPos).x < self.ImpackRange * self.ImpackRange / 4 and var_10_0.y * var_10_0.y < self.ImpackRange * self.ImpackRange / 4
			end

			return
		end)() then
			self.impackCD = self.impackCD - arg_9_1

			if self.impackCD <= 0 then
				self.impackCount = self.impackCount - 1
				self.impackCD = 0.5

				self.responder:Create({
					name = "Impack",
					pos = {
						self.responder.reactorRyza.pos.x,
						self.responder.reactorRyza.pos.y
					},
					realPos = {
						self.responder.reactorRyza.realPos.x,
						self.responder.reactorRyza.realPos.y
					}
				})
			end
		else
			self.impackCount = 0
			self.impackCD = nil
		end
	end

	return
end

return EnemySmasher
