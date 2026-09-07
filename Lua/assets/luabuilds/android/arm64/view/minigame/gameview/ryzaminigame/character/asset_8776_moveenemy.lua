local MoveEnemy = class("MoveEnemy", import("view.miniGame.gameView.RyzaMiniGame.character.TargetMove"))

function MoveEnemy:InitUI(arg_1_1)
	self.hp = arg_1_1.hp or 3
	self.hpMax = self.hp
	self.speed = arg_1_1.speed or 1
	self.search = arg_1_1.search or 4
	self.wander = arg_1_1.wander or 3
	self.mainTarget = self.rtScale:Find("main")

	self:PlayWait()
	self.mainTarget:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		self.lock = false

		if self.hp <= 0 then
			self:Destroy()
		end

		return
	end)

	return
end

function MoveEnemy:InitRegister(arg_3_1)
	self:Register("burn", function()
		self:Hurt(1)

		return
	end, {
		{
			0,
			0
		}
	})

	return
end

function MoveEnemy:Hurt(arg_5_1)
	self.hp = self.hp - arg_5_1

	self.responder:SyncStatus(self, "hp", {
		num = self.hp,
		max = self.hpMax
	})

	if self.hp > 0 then
		self:PlayDamage()
	else
		self:DeregisterAll()
		self:PlayDead()
	end

	return
end

MoveEnemy.SpeedDistance = {
	[0] = 0,
	1,
	1.5,
	2,
	2.5,
	3,
	3.5,
	4
}

function MoveEnemy:TimeUpdate(arg_6_1)
	if not self.lock then
		local var_6_0, var_6_1 = self:GetMoveInfo()
		local var_6_2

		if var_6_0 then
			var_6_2 = self:MoveDelta(var_6_0, self:GetSpeedDis() * arg_6_1)

			self:ClearWander()
		else
			if not self.wanderPos then
				self.wanderPos = self.pos
				self.wanderDir = NewPos(0, 0)
				self.wanderTime = 1.5
			end

			if arg_6_1 >= self.wanderTime then
				self.wanderDir = (self.wanderPos + NewPos(math.random() * 2 - 1, math.random() * 2 - 1) * self.wander - self.realPos):Normalize()
			end

			var_6_2 = MoveEnemy.super.MoveDelta(self, self.wanderDir, self:GetSpeedDis() * arg_6_1)
			self.wanderTime = var_6_2.x == 0 and var_6_2.y == 0 and self.wanderTime - arg_6_1 or 1.5
			self.wanderDir = var_6_2:Normalize()
			var_6_1 = self.wanderDir
		end

		if var_6_1.x == 0 and var_6_1.y == 0 then
			self:PlayWait()
		else
			self:PlayMove(RyzaMiniGameConfig.GetFourDirMark(var_6_1))
		end

		self:MoveUpdate(var_6_2)
	end

	self:TimeTrigger(arg_6_1)

	if self.hide then
		self:UpdateAlpha()
	end

	return
end

function MoveEnemy:MoveDelta(arg_7_1, arg_7_2)
	if (arg_7_1 - self.realPos).x == 0 and (arg_7_1 - self.realPos).y == 0 then
		return NewPos(0, 0)
	else
		return (arg_7_1 - self.realPos) * math.min(1, arg_7_2 / math.sqrt((arg_7_1 - self.realPos):SqrMagnitude()))
	end

	return
end

function MoveEnemy:GetMoveInfo()
	if self.responder:SearchRyza(self, self.search) then
		local var_8_0 = self.responder:Wayfinding(self)

		if var_8_0 and #var_8_0 > 0 then
			local var_8_1 = var_8_0[#var_8_0]

			if (var_8_0[#var_8_0] - self.realPos):SqrMagnitude() > (var_8_0[#var_8_0] - self.pos):SqrMagnitude() then
				var_8_1 = self.pos
			end

			local var_8_2 = var_8_1 - self.realPos

			if (var_8_1 - self.realPos).x ~= 0 or var_8_2.y ~= 0 then
				var_8_2 = var_8_2 * (1 / math.sqrt(var_8_2:SqrMagnitude()))
			end

			return var_8_1, var_8_2
		end
	end

	local var_8_4 = NewPos(0, 0)
end

function MoveEnemy:ClearWander()
	self.wanderPos = nil
	self.wanderDir = nil
	self.wanderTime = nil

	return
end

function MoveEnemy:PlayWait()
	self:PlayAnim("Wait_" .. (string.split(self.status, "_")[2] or "S"))

	return
end

function MoveEnemy:PlayMove(arg_11_1)
	self:PlayAnim("Move_" .. arg_11_1)

	return
end

function MoveEnemy:PlayDamage()
	if not self.lock then
		self:PlayAnim("Damage_" .. (string.split(self.status, "_")[2] or "S"))
	end

	return
end

function MoveEnemy:PlayDead()
	self:SetHide(false)
	self:PlayAnim("Dead_" .. (string.split(self.status, "_")[2] or "S"))

	return
end

MoveEnemy.loopDic = {
	Move = true,
	Wait = true
}

function MoveEnemy:GetUIHeight()
	return 128
end

function MoveEnemy:SetHide(arg_15_1)
	MoveEnemy.super.SetHide(self, arg_15_1)
	self:UpdateAlpha()

	return
end

local var_0_1 = 7

function MoveEnemy:UpdateAlpha()
	GetOrAddComponent(self._tf, typeof(CanvasGroup)).alpha = not self.hide and 1 or self.responder.reactorRyza.hide and (self.responder.reactorRyza.realPos - self.realPos):SqrMagnitude() < var_0_1 * var_0_1 and 0.7 or 0

	return
end

function MoveEnemy:TimeTrigger(arg_17_1)
	if self.hp > 0 and self.responder:CollideRyza(self) then
		self:Calling("hit", {
			1,
			self.realPos
		}, MoveRyza)
	end

	return
end

return MoveEnemy
