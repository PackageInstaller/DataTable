local TugGameObject = class("TugGameObject")

function TugGameObject:Ctor(arg_1_1)
	self.speed = 0
	self.anger = 0
	self.constSpeed = arg_1_1.constSpeed or 0
	self.angerAddSpeed = arg_1_1.angerAddSpeed or 0
	self.angerStart = arg_1_1.angerStart or 0
	self.angerMax = arg_1_1.angerMax or 0
	self.angerDecay = arg_1_1.angerDecay or 0
	self.superAttackTimes = arg_1_1.superAttackTimes or 0
	self.skillASpeed = arg_1_1.skillASpeed or 0
	self.skillBSpeed = arg_1_1.skillBSpeed or 0
	self.state = SpKaliConst.TugEnemyState.none
	self.attackTimes = 0
	self.CDTime = 0
	self.NowCDTime = 0
	self.speedList = {}
	self.effectTime = 1
end

function TugGameObject:UpdatePlayGameData2(arg_2_1)
	if self.NowCDTime <= 0 then
		self:UpdateAnger(arg_2_1)
	else
		self.NowCDTime = Mathf.Clamp(self.NowCDTime - arg_2_1, 0, self.CDTime)
	end
end

function TugGameObject:SetCDTime(arg_3_1)
	self.CDTime = arg_3_1 or 0
	self.NowCDTime = arg_3_1
end

function TugGameObject:ReduceEffectTime()
	self.effectTime = 0
end

function TugGameObject:EnterCdTime()
	self.NowCDTime = self.CDTime
	self.state = SpKaliConst.TugEnemyState.CdState
	self.effectTime = 1
end

function TugGameObject:UpdateAnger(arg_6_1)
	if self.state == SpKaliConst.TugEnemyState.defense then
		self.anger = Mathf.Clamp(self.anger + self.angerAddSpeed * arg_6_1, 0, self.angerMax)
	elseif self.state == SpKaliConst.TugEnemyState.attack then
		self.anger = Mathf.Clamp(self.anger - self.angerDecay * arg_6_1, 0, self.angerMax)
	elseif self.state == SpKaliConst.TugEnemyState.SuperAttack then
		self.anger = Mathf.Clamp(self.anger - self.angerDecay * arg_6_1, 0, self.angerMax)
	end

	if self.state == SpKaliConst.TugEnemyState.CdState then
		if self.anger == self.angerMax then
			self.attackTimes = self.attackTimes + 1

			if self.attackTimes % self.superAttackTimes == 0 then
				self.state = SpKaliConst.TugEnemyState.SuperAttack
			else
				self.lastState = self.state
				self.state = SpKaliConst.TugEnemyState.attack
			end
		end

		if self.anger == 0 then
			self.state = SpKaliConst.TugEnemyState.defense
		end
	elseif not (self.anger > 0 and (self.state == SpKaliConst.TugEnemyState.attack or self.state == SpKaliConst.TugEnemyState.SuperAttack)) and not (self.anger < self.angerMax and self.state == SpKaliConst.TugEnemyState.defense) then
		self:EnterCdTime()
	end

	self:SetBehaviorByState()
end

function TugGameObject:SetSpeedList(arg_7_1, arg_7_2)
	self.speedList[arg_7_1] = arg_7_2
end

function TugGameObject:ResetSkillSpeed()
	for iter_8_0, iter_8_1 in ipairs(self.speedList) do
		self.speedList[iter_8_0] = 0
	end
end

function TugGameObject:SetBehaviorByState()
	self.gameManager = TugGame.GetInstance()

	if self.state == SpKaliConst.TugEnemyState.defense then
		-- block empty
	elseif self.state == SpKaliConst.TugEnemyState.attack then
		-- block empty
	elseif self.state == SpKaliConst.TugEnemyState.SuperAttack then
		-- block empty
	end
end

function TugGameObject:GetCDFillAmount()
	return 1 - self.NowCDTime / self.CDTime
end

function TugGameObject:SetState(arg_11_1)
	self.state = arg_11_1
end

function TugGameObject:UpdateSelfState(arg_12_1)
	self.anger = Mathf.Clamp(self.anger + self.angerAddSpeed * arg_12_1, 0, self.angerMax)
end

function TugGameObject:UpdatePlayGameData1(arg_13_1)
	self:UpdateSelfState(arg_13_1)
end

function TugGameObject:AddAnger(arg_14_1)
	self.anger = Mathf.Clamp(self.anger + arg_14_1, 0, self.angerMax)
end

function TugGameObject:GetAngerFillAmount()
	return self.anger / self.angerMax
end

return TugGameObject
