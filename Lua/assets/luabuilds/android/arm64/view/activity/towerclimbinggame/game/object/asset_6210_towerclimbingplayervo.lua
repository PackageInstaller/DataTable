local TowerClimbingPlayerVO = class("TowerClimbingPlayerVO")
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3
local var_0_5 = 4
local var_0_6 = 5
local var_0_7 = 6

function TowerClimbingPlayerVO:Ctor(arg_1_1, arg_1_2)
	self.view = arg_1_1
	self.id = arg_1_2.id
	self.life = arg_1_2.life
	self.pageIndex = arg_1_2.pageIndex
	self.higestscore = arg_1_2.higestscore or 0
	self.shipConfig = pg.ship_data_statistics[self.id]
	self.skinId = self.shipConfig.skin_id
	self.shipName = pg.ship_skin_template[self.skinId].prefab
	self.mapScore = arg_1_2.mapScore or 0
	self.verticalVelocity = TowerClimbingGameSettings.JUMP_VELOCITY
	self.horizontalVelocity = TowerClimbingGameSettings.MOVE_VELOCITY
	self.beInjuredVelocity = TowerClimbingGameSettings.BEINJURED_VELOCITY
	self.state = var_0_1
	self.isStand = true
	self.prevMoveDir = var_0_3
	self.score = 0
	self.isStand = true
	self.InvincibleTime = 0

	return
end

function TowerClimbingPlayerVO:IsOverMapScore()
	return self.score > self.mapScore
end

function TowerClimbingPlayerVO:UpdateStand(arg_3_1)
	self.isStand = arg_3_1

	return
end

function TowerClimbingPlayerVO:SetPosition(arg_4_1)
	self.position = arg_4_1

	self:SendPlayerEvent("ChangePosition", arg_4_1)

	return
end

function TowerClimbingPlayerVO:GetShipName()
	return self.shipName
end

function TowerClimbingPlayerVO:CanJump()
	return not self:IsDeath() and self.state ~= var_0_2 and self.isStand
end

function TowerClimbingPlayerVO:Jump()
	if self:IsFatalInjured() then
		return
	end

	if not self:CanJump() then
		return
	end

	self:SendPlayerEvent("Jump", self.verticalVelocity)

	self.state = var_0_2

	return
end

function TowerClimbingPlayerVO:MoveRight()
	if self:IsFatalInjured() then
		return
	end

	if self:IsDeath() then
		return
	end

	self.prevMoveDir = var_0_4

	self:SendPlayerEvent("MoveRight", self.horizontalVelocity)

	self.state = var_0_4

	return
end

function TowerClimbingPlayerVO:MoveLeft()
	if self:IsFatalInjured() then
		return
	end

	if self:IsDeath() then
		return
	end

	self.prevMoveDir = var_0_3

	self:SendPlayerEvent("MoveLeft", self.horizontalVelocity)

	self.state = var_0_3

	return
end

function TowerClimbingPlayerVO:Idle()
	if self:IsDeath() then
		return
	end

	self:SendPlayerEvent("Idle")

	self.state = var_0_1

	return
end

function TowerClimbingPlayerVO:BeInjured()
	if self:IsFatalInjured() then
		return
	end

	if self:IsDeath() then
		return
	end

	local var_11_0 = self.beInjuredVelocity

	if self.prevMoveDir == var_0_4 then
		var_11_0.x = -var_11_0.x
	end

	self:SendPlayerEvent("BeInjured", var_11_0)

	self.state = var_0_5

	self:ReduceLife(1)

	return
end

function TowerClimbingPlayerVO:BeFatalInjured(arg_12_1)
	if self:IsFatalInjured() then
		return
	end

	if self:IsDeath() then
		return
	end

	self.state = var_0_7

	self:ReduceLife(1)
	self:SendPlayerEvent("BeFatalInjured", arg_12_1)

	return
end

function TowerClimbingPlayerVO:ReduceLife(arg_13_1)
	self.life = self.life - arg_13_1

	if self.life == 0 then
		self.state = var_0_6

		self:SendPlayerEvent("Dead")
	end

	self:SendMapEvent("OnPlayerLifeUpdate", self.life)

	return
end

function TowerClimbingPlayerVO:IsIdle()
	return self.state == var_0_1
end

function TowerClimbingPlayerVO:IsDeath()
	return self.state == var_0_6
end

function TowerClimbingPlayerVO:IsFatalInjured()
	return self.state == var_0_7
end

function TowerClimbingPlayerVO:AddScore()
	self.score = self.score + 1

	self:SendMapEvent("OnScoreUpdate", self.score)

	return
end

function TowerClimbingPlayerVO:AddInvincibleEffect(arg_18_1)
	self.InvincibleTime = arg_18_1

	local var_18_0 = self:IsInvincible()

	if self:IsInvincible() ~= var_18_0 then
		self:SendPlayerEvent("Invincible", var_18_0)
	end

	return
end

function TowerClimbingPlayerVO:GetInvincibleTime()
	return self.InvincibleTime
end

function TowerClimbingPlayerVO:SetInvincibleTime(arg_20_1)
	self:AddInvincibleEffect(arg_20_1)

	return
end

function TowerClimbingPlayerVO:IsInvincible()
	return self.InvincibleTime > 0
end

function TowerClimbingPlayerVO:SendPlayerEvent(arg_22_1, ...)
	local var_22_0 = self.view.map:GetPlayer()

	var_22_0[arg_22_1](var_22_0, unpack({
		...
	}))

	return
end

function TowerClimbingPlayerVO:SendMapEvent(arg_23_1, ...)
	self.view.map[arg_23_1](self.view.map, unpack({
		...
	}))

	return
end

function TowerClimbingPlayerVO:IsOverHigestScore()
	return self.score > self.higestscore
end

function TowerClimbingPlayerVO:Dispose()
	return
end

return TowerClimbingPlayerVO
