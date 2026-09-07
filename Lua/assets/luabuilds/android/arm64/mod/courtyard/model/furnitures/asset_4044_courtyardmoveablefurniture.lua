local CourtYardMoveableFurniture = class("CourtYardMoveableFurniture", import(".CourtYardFurniture"))
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3

function CourtYardMoveableFurniture:Ctor(arg_1_1, arg_1_2)
	CourtYardMoveableFurniture.super.Ctor(self, arg_1_1, arg_1_2)

	self.moveState = var_0_1
	self.playPreheatAction = false

	return
end

function CourtYardMoveableFurniture:IsCar()
	if self.config.spine then
		return self.config.spine[1] and self.config.spine[1][4] ~= nil
	end

	return false
end

function CourtYardMoveableFurniture:GetAroundPositions()
	local var_3_0 = CourtYardMoveableFurniture.super.GetAroundPositions(self)

	if not self:IsCar() then
		return var_3_0
	end

	local var_3_1 = self.config.spine[1][4]

	if type(self.config.spine[1][4]) == "table" then
		local var_3_2 = {}

		for iter_3_0, iter_3_1 in ipairs(var_3_0) do
			if table.contains(var_3_1, iter_3_0) then
				table.insert(var_3_2, iter_3_1)
			end
		end

		return var_3_2
	else
		return var_3_0
	end

	return
end

function CourtYardMoveableFurniture:_ChangeState(arg_4_1)
	CourtYardMoveableFurniture.super._ChangeState(self, arg_4_1)

	if CourtYardFurniture.STATE_TOUCH == self.state then
		self:ChangeMoveState(var_0_2)
	end

	return
end

function CourtYardMoveableFurniture:ChangeState(arg_5_1)
	CourtYardMoveableFurniture.super.ChangeState(self, arg_5_1)

	if CourtYardFurniture.STATE_TOUCH == self.state then
		-- block empty
	elseif self:IsMoving() then
		self:Idle()
	end

	return
end

function CourtYardMoveableFurniture:IsMoveableSlot(arg_6_1)
	return arg_6_1.id == 1
end

function CourtYardMoveableFurniture:IsReadyMove()
	return self.moveState == var_0_2
end

function CourtYardMoveableFurniture:IsMoving()
	return self.moveState == var_0_3
end

function CourtYardMoveableFurniture:IsStop()
	return self.moveState == var_0_4
end

function CourtYardMoveableFurniture:SetPosition(arg_10_1)
	if self.moveState == var_0_3 then
		CourtYardMoveableFurniture.super.super.SetPosition(self, arg_10_1)
	else
		CourtYardMoveableFurniture.super.SetPosition(self, arg_10_1)
	end

	return
end

function CourtYardMoveableFurniture:GetSpeed()
	return (self.config.spine and self.config.spine[7] or nil) and self.config.spine[7]
end

function CourtYardMoveableFurniture:GetMoveTime()
	return 1 / self:GetSpeed()
end

function CourtYardMoveableFurniture:Move(arg_13_1)
	self:RemoveTimer()
	self:ChangeMoveState(var_0_3)

	self.moveTimer = Timer.New(function()
		self:ChangeMoveState(var_0_2)

		return
	end, self:GetMoveTime(), 1)

	self.moveTimer:Start()
	self:DispatchEvent(CourtYardEvent.FURNITURE_MOVE, arg_13_1)

	return
end

function CourtYardMoveableFurniture:Rest()
	self:RemoveTimer()
	self:ChangeMoveState(var_0_1)

	local var_15_0 = math.random(1)

	self.moveTimer = Timer.New(function()
		self:ChangeMoveState(var_0_2)

		return
	end, math.random(10, 20), 1)

	self.moveTimer:Start()

	return
end

function CourtYardMoveableFurniture:Idle()
	self:RemoveTimer()
	self:ChangeMoveState(var_0_1)
	self:SetPosition(self:GetPosition())
	self:DispatchEvent(CourtYardEvent.FURNITURE_STOP_MOVE)

	return
end

function CourtYardMoveableFurniture:Stop()
	self:RemoveTimer()
	self:ChangeMoveState(var_0_4)
	self:SetPosition(self:GetPosition())
	self:DispatchEvent(CourtYardEvent.FURNITURE_STOP_MOVE)

	return
end

function CourtYardMoveableFurniture:ReStart()
	self:ChangeMoveState(var_0_2)

	return
end

function CourtYardMoveableFurniture:ChangeMoveState(arg_20_1)
	self.moveState = arg_20_1

	return
end

function CourtYardMoveableFurniture:IsSpineSlotAndExistPreheatAction(arg_21_1)
	if not isa(arg_21_1, CourtYardFurnitureSpineSlot) then
		return false
	end

	return arg_21_1.preheatAction ~= nil
end

function CourtYardMoveableFurniture:StartInteraction(arg_22_1)
	if self:IsSpineSlotAndExistPreheatAction(arg_22_1) then
		self.playPreheatAction = true

		self:_ChangeState(CourtYardFurniture.STATE_INTERACT)
		self:DispatchEvent(CourtYardEvent.FURNITURE_START_INTERACTION, arg_22_1)
		self:Idle()
	else
		CourtYardMoveableFurniture.super.StartInteraction(self, arg_22_1)

		if self:IsMoveableSlot(arg_22_1) then
			self:ChangeMoveState(var_0_2)
		end
	end

	return
end

function CourtYardMoveableFurniture:OnPreheatActionEnd(arg_23_1)
	if self:IsSpineSlotAndExistPreheatAction(arg_23_1) then
		self.playPreheatAction = false

		self:ChangeMoveState(var_0_2)
	end

	return
end

function CourtYardMoveableFurniture:CanInterAction()
	if self.playPreheatAction then
		return false
	end

	return CourtYardMoveableFurniture.super.CanInterAction(self)
end

function CourtYardMoveableFurniture:ClearInteraction(arg_25_1)
	if self:IsSpineSlotAndExistPreheatAction(arg_25_1) then
		if #_.select(self.slots, function(arg_26_0)
			return arg_26_0.id ~= arg_25_1.id and arg_26_0:IsUsing()
		end) == 0 then
			self:_ChangeState(CourtYardFurniture.STATE_IDLE)
			self:Idle()
		end

		self:DispatchEvent(CourtYardEvent.FURNITURE_STOP_INTERACTION, arg_25_1)
	else
		CourtYardMoveableFurniture.super.ClearInteraction(self, arg_25_1)

		if self:IsMoveableSlot(arg_25_1) then
			self:Idle()
		end
	end

	return
end

function CourtYardMoveableFurniture:RemoveTimer()
	if self.moveTimer then
		self.moveTimer:Stop()

		self.moveTimer = nil
	end

	return
end

function CourtYardMoveableFurniture:IsDifferentDirectionForCard(arg_28_1)
	local var_28_0 = self:GetPosition()
	local var_28_1 = self.config.dir == 1 and {
		1,
		2
	} or {
		2,
		1
	}

	return self.dir ~= (arg_28_1.x > var_28_0.x and var_28_1[1] or arg_28_1.y > var_28_0.y and var_28_1[2] or (arg_28_1.x < var_28_0.x and arg_28_1.y == var_28_0.y or arg_28_1.y > var_28_0.y and arg_28_1.x == var_28_0.x) and var_28_1[1] or var_28_1[2])
end

function CourtYardMoveableFurniture:IsDifferentDirection(arg_29_1)
	if self:IsCar() then
		return self:IsDifferentDirectionForCard(arg_29_1)
	else
		return CourtYardMoveableFurniture.super.IsDifferentDirection(self, arg_29_1)
	end

	return
end

function CourtYardMoveableFurniture:Dispose()
	CourtYardMoveableFurniture.super.Dispose(self)
	self:RemoveTimer()

	self.playPreheatAction = false

	return
end

return CourtYardMoveableFurniture
