local CourtYardShip = class("CourtYardShip", import("..map.CourtYardDepthItem"))

CourtYardShip.STATE_IDLE = 0
CourtYardShip.STATE_MOVE = 1
CourtYardShip.STATE_MOVING_ZERO = 2
CourtYardShip.STATE_MOVING_HALF = 3
CourtYardShip.STATE_MOVING_ONE = 4
CourtYardShip.STATE_DRAG = 5
CourtYardShip.STATE_TOUCH = 6
CourtYardShip.STATE_GETAWARD = 7
CourtYardShip.STATE_STOP = 8
CourtYardShip.STATE_INTERACT = 9
CourtYardShip.STATE_CANCEL_INTERACT = 10

function CourtYardShip:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.id = arg_1_2.id
	self.configId = arg_1_2.configId
	self.prefab = arg_1_2:getPrefab()
	self.attachments = arg_1_2:getAttachmentPrefab()
	self.inimacy = arg_1_4 or 0
	self.coin = arg_1_3 or 0
	self.skinId = arg_1_2.skinId
	self.groupId = arg_1_2.groupId
	self.config = pg.ship_data_statistics[self.configId]
	self.moveTime = math.floor(1 / self.config.backyard_speed)

	CourtYardShip.super.Ctor(self, arg_1_1, self.id, 1, 1)

	self.state = CourtYardShip.STATE_IDLE
	self.moveCnt = 0
	self.sideIndex = 0

	return
end

function CourtYardShip:GetLevel()
	return 2
end

function CourtYardShip:GetSkinID()
	return self.skinId
end

function CourtYardShip:GetGroupID()
	return self.groupId
end

function CourtYardShip:GetObjType()
	return CourtYardConst.OBJ_TYPE_SHIP
end

function CourtYardShip:SetPosition(arg_6_1)
	CourtYardShip.super.SetPosition(self, arg_6_1)

	if self.state == CourtYardShip.STATE_MOVING_HALF then
		return
	end

	self:DispatchEvent(CourtYardEvent.SHIP_POSITION_CHANGE, arg_6_1, self:GetOffset())

	return
end

function CourtYardShip:InActivityRange(arg_7_1)
	local var_7_0 = self:GetHost():GetStorey():GetRange()

	return arg_7_1.x < var_7_0.x and arg_7_1.y < var_7_0.y and arg_7_1.x >= 0 and arg_7_1.y >= 0
end

function CourtYardShip:GetDeathType()
	return CourtYardConst.DEPTH_TYPE_SHIP
end

function CourtYardShip:GetShipType()
	return CourtYardConst.SHIP_TYPE_SELF
end

function CourtYardShip:_ChangeState(arg_10_1, arg_10_2)
	self.state = arg_10_1

	self:DispatchEvent(CourtYardEvent.SHIP_STATE_CHANGE, arg_10_1, arg_10_2)

	return
end

function CourtYardShip:ChangeState(arg_11_1, arg_11_2)
	self:Clear()

	if arg_11_1 == CourtYardShip.STATE_IDLE then
		self:OnStateIdle()
	elseif arg_11_1 == CourtYardShip.STATE_MOVING_ONE then
		self:OnStateMoveOne()
	elseif (arg_11_1 == CourtYardShip.STATE_STOP or arg_11_1 == CourtYardShip.STATE_TOUCH or arg_11_1 == CourtYardShip.STATE_GETAWARD) and self.state == CourtYardShip.STATE_INTERACT then
		-- block empty
	elseif arg_11_1 == CourtYardShip.STATE_INTERACT then
		self:OnInterAction(arg_11_2)
	else
		self:_ChangeState(arg_11_1)
	end

	return
end

function CourtYardShip:ShouldResetPosition()
	return self.state == CourtYardShip.STATE_STOP or self.state == CourtYardShip.STATE_CANCEL_INTERACT
end

function CourtYardShip:WillInteraction()
	self:DispatchEvent(CourtYardEvent.SHIP_WILL_INTERACTION, slot)

	return
end

function CourtYardShip:StartInteraction(arg_14_1, arg_14_2)
	if arg_14_2 then
		self.interactionSlot = arg_14_1
	else
		self:ChangeState(CourtYardShip.STATE_INTERACT, arg_14_1)
	end

	return
end

function CourtYardShip:OnPreheatActionEnd()
	return
end

function CourtYardShip:UpdateInteraction(...)
	self:DispatchEvent(CourtYardEvent.SHIP_UPDATE_INTERACTION, ...)

	return
end

function CourtYardShip:ClearInteraction(arg_17_1, arg_17_2, arg_17_3)
	self.interactionSlot = nil

	if not arg_17_3 then
		self:ChangeState(CourtYardShip.STATE_CANCEL_INTERACT)
		self:DispatchEvent(CourtYardEvent.SHIP_STOP_INTERACTION, arg_17_1)
	end

	return
end

function CourtYardShip:OnStateIdle()
	self:_ChangeState(CourtYardShip.STATE_IDLE)

	self.timer = Timer.New(function()
		self.moveCnt = math.random(1, 5)

		self:_ChangeState(CourtYardShip.STATE_MOVE)

		return
	end, math.random(10, 20), 1)

	self.timer:Start()

	return
end

function CourtYardShip:OnStateMoveOne()
	self:_ChangeState(CourtYardShip.STATE_MOVING_ONE)
	self:ClearMarkPosition()

	self.timer = Timer.New(function()
		self.moveCnt = self.moveCnt - 1

		if self.moveCnt <= 0 then
			self:ChangeState(CourtYardShip.STATE_IDLE)
		else
			self:_ChangeState(CourtYardShip.STATE_MOVE)
		end

		return
	end, self.moveTime * 0.5, 1)

	self.timer:Start()

	return
end

function CourtYardShip:OnInterAction(arg_22_1)
	self.interactionSlot = arg_22_1

	self:_ChangeState(CourtYardShip.STATE_INTERACT)
	self:DispatchEvent(CourtYardEvent.SHIP_START_INTERACTION, arg_22_1)

	return
end

function CourtYardShip:GetInterActionData()
	return self.interactionSlot
end

function CourtYardShip:Move(arg_24_1)
	self:MarkPosition(arg_24_1)
	self:ChangeState(CourtYardShip.STATE_MOVING_ZERO)

	self.timer = Timer.New(function()
		self:ChangeState(CourtYardShip.STATE_MOVING_HALF)

		return
	end, self.moveTime * 0.5, 1)

	self.timer:Start()
	self:DispatchEvent(CourtYardEvent.SHIP_MOVE, arg_24_1, self:GetOffset())

	return
end

function CourtYardShip:GetState()
	return self.state
end

function CourtYardShip:GetPrefab()
	assert(pg.ship_skin_template[self.skinId], "ship_skin_template not exist: " .. self.configId .. " " .. self.skinId)

	if pg.ship_skin_template[self.skinId].double_char and pg.ship_skin_template[self.skinId].double_char == 1 and self.sideIndex and self.sideIndex ~= 0 then
		if self.sideIndex == 1 then
			return self.prefab .. "_L"
		elseif self.sideIndex == 2 then
			return self.prefab .. "_R"
		end
	end

	return self.prefab
end

function CourtYardShip:getPrefab()
	return self:GetPrefab()
end

function CourtYardShip:SetSide(arg_29_1)
	self.sideIndex = arg_29_1

	return
end

function CourtYardShip:GetSide(arg_30_1)
	return self.sideIndex
end

function CourtYardShip:IsDoubleSkin()
	local var_31_0 = pg.ship_skin_template[self.skinId]

	assert(pg.ship_skin_template[self.skinId], "ship_skin_template not exist: " .. self.configId .. " " .. self.skinId)

	return var_31_0.double_char and var_31_0.double_char == 1 or false
end

function CourtYardShip:getAttachmentPrefab()
	return self.attachments
end

function CourtYardShip:GetMoveTime()
	return self.moveTime
end

function CourtYardShip:Clear()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function CourtYardShip:ChangeInimacy(arg_35_1)
	self.inimacy = arg_35_1

	self:DispatchEvent(CourtYardEvent.SHIP_INIMACY_CHANGE, arg_35_1)

	return
end

function CourtYardShip:ChangeCoin(arg_36_1)
	self.coin = arg_36_1

	self:DispatchEvent(CourtYardEvent.SHIP_COIN_CHANGE, arg_36_1)

	return
end

function CourtYardShip:ClearInimacy()
	if self.inimacy <= 0 then
		return
	end

	self:ChangeInimacy(0)
	self:ChangeState(CourtYardShip.STATE_GETAWARD)
	self:DispatchEvent(CourtYardEvent.SHIP_GET_AWARD, self.inimacy, 2)

	return
end

function CourtYardShip:ClearCoin()
	if self.coin <= 0 then
		return
	end

	self:ChangeCoin(0)
	self:ChangeState(CourtYardShip.STATE_GETAWARD)
	self:DispatchEvent(CourtYardEvent.SHIP_GET_AWARD, self.coin, 1)

	return
end

function CourtYardShip:AddExp(arg_39_1)
	self:DispatchEvent(CourtYardEvent.SHIP_GET_AWARD, arg_39_1, 3)

	return
end

function CourtYardShip:GetInterActionBgm()
	return nil
end

function CourtYardShip:Dispose()
	CourtYardShip.super.Dispose(self)
	self:Clear()

	local var_41_0 = self:GetInterActionData()

	if var_41_0 then
		var_41_0:Stop()
	end

	return
end

return CourtYardShip
