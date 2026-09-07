local MainCardItem = class("MainCardItem")

function MainCardItem:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.isLoaded = false

	self:Init(arg_1_1, arg_1_2, arg_1_3)

	return
end

function MainCardItem:Init(arg_2_1, arg_2_2, arg_2_3)
	self.key = arg_2_1.key
	self.id = arg_2_1.id
	self.index = arg_2_1.index
	self.hasSend = false
	self.cardPoolMgr = arg_2_2

	if arg_2_1.allCount then
		self:SetAllCount(arg_2_1.allCount)
	end

	if arg_2_3 then
		self:SetUIRoot(arg_2_3)
	end

	self.mainPlayerSeat = arg_2_1.mainPlayerSeat

	self.cardPoolMgr:GetCardGameObjectById(self.id, function(arg_3_0)
		self.tf = tf(arg_3_0)
		self.isLoaded = true
		self.selectedCardTf = self.tf:Find("vfx_bar_kapai01")
		self.unSelectedCardTf = self.tf:Find("vfx_bar_kapai02")

		self:SetSelected(false)

		local var_3_0 = GetOrAddComponent(arg_3_0, typeof(CheaterTavernCard))

		var_3_0.key = self.key
		var_3_0.parm = self.id

		self:InitCardView()

		return
	end)

	return
end

function MainCardItem:SetIndex(arg_4_1)
	self.index = arg_4_1

	return
end

function MainCardItem:SetUIRoot(arg_5_1)
	self.rootTransform = arg_5_1

	return
end

function MainCardItem:SetAllCount(arg_6_1)
	self.allCount = arg_6_1

	return
end

function MainCardItem:SetCurveOffsetY(arg_7_1, arg_7_2, arg_7_3)
	self.cureveX = arg_7_1
	self.cureveY = arg_7_2
	self.cureveZ = arg_7_3

	return
end

function MainCardItem:InitCardView()
	if self.hasSend then
		return
	end

	setActive(self.tf.gameObject, true)
	setParent(self.tf, self.rootTransform, false)

	local var_8_0 = math.ceil(math.abs(self.index - (self.allCount + 1) / 2)) * IslandCheaterTavernConst.cardRoationOffset

	if self.index - (self.allCount + 1) / 2 < 0 then
		var_8_0 = -var_8_0
	end

	setLocalRotation(self.tf, Quaternion.Euler(0, 180, var_8_0))
	setLocalPosition(self.tf, Vector3(-(self.allCount * IslandCheaterTavernConst.cardWidth + (self.allCount - 1) * IslandCheaterTavernConst.cardSpace) / 2 + IslandCheaterTavernConst.cardWidth / 2 + (self.index - 1) * (IslandCheaterTavernConst.cardWidth + IslandCheaterTavernConst.cardSpace), -((self.index - (self.allCount + 1) / 2) * (self.index - (self.allCount + 1) / 2)) * 0.01, -0.001 * (self.index - 1)))
	setLocalScale(self.tf, Vector3(1, 1, 1))

	return
end

function MainCardItem:SetSelected(arg_9_1)
	self.isSelected = arg_9_1

	if self.isSelected then
		setLocalPosition(self.tf, Vector3(self.tf.localPosition.x, self.tf.localPosition.y + 0.02, self.tf.localPosition.z))
		setActive(self.selectedCardTf, true)
		setActive(self.unSelectedCardTf, false)
	else
		setLocalPosition(self.tf, Vector3(self.tf.localPosition.x, self.tf.localPosition.y - 0.02, self.tf.localPosition.z))
		setActive(self.selectedCardTf, false)
		setActive(self.unSelectedCardTf, true)
	end

	return
end

function MainCardItem:Update()
	if not self.isLoaded then
		return
	end

	self:UpdateMoveToTable()
	self:UpdateFlipTableCard()

	return
end

function MainCardItem:UpdateMoveToTable()
	if not self.moveToTable then
		return
	end

	if not self.isLoaded then
		return
	end

	self.deltaTime = Time.deltaTime + self.deltaTime

	local var_11_0 = self.deltaTime / IslandCheaterTavernConst.moveToTableTime
	local var_11_1 = self.cureveZ:Evaluate(self.deltaTime / IslandCheaterTavernConst.moveToTableTime)
	local var_11_2 = Vector3.Lerp(self.startPos, self.endPos, var_11_1)

	if self.mainPlayerSeat == 1 then
		var_11_2.z = var_11_2.z + self.cureveX:Evaluate(var_11_0) * 0.3
	elseif self.mainPlayerSeat == 2 then
		var_11_2.x = var_11_2.x + self.cureveX:Evaluate(var_11_0) * 0.3
	elseif self.mainPlayerSeat == 3 then
		var_11_2.z = var_11_2.z - self.cureveX:Evaluate(var_11_0) * 0.3
	else
		var_11_2.x = var_11_2.x - self.cureveX:Evaluate(var_11_0) * 0.3
	end

	var_11_2.y = var_11_2.y + self.cureveY:Evaluate(var_11_0) * 0.3
	self.tf.position = var_11_2
	self.tf.rotation = Quaternion.Slerp(self.startRotation, self.endRotation, var_11_1)
	self.tf.localScale = Vector3.Lerp(self.startScale, self.endScale, var_11_1)

	if var_11_0 >= 1 then
		self.moveToTable = false

		if IslandCheaterTavernConst.putCardTest then
			onDelayTick(function()
				self.tf.position = self.startPos

				self:SetSelected(false)

				self.tf.rotation = self.startRotation
				self.tf.localScale = self.startScale

				return
			end, 1)
		end
	end

	return
end

function MainCardItem:MoveToTable(arg_13_1, arg_13_2)
	if not self.isLoaded then
		return
	end

	setActive(self.selectedCardTf, false)

	self.hasSend = true
	self.moveToTable = true
	self.deltaTime = 0
	self.startPos = self.tf.position
	self.startScale = self.tf.localScale
	self.startRotation = self.tf.rotation

	local var_13_0 = -(arg_13_2 * (IslandCheaterTavernConst.cardWidth * 2) + (arg_13_2 - 1) * 0) / 2 + IslandCheaterTavernConst.cardWidth * 2 / 2 + (arg_13_1 - 1) * (IslandCheaterTavernConst.cardWidth * 2 + 0)
	local var_13_1 = 0
	local var_13_2 = 0

	if self.mainPlayerSeat % 2 == 0 then
		var_13_1 = var_13_0
	else
		var_13_2 = var_13_0
	end

	self.endPos = Vector3(6.29 + var_13_1, 0.92 + 0.001 * arg_13_1, 2.11 + var_13_2)
	self.endRotation = Quaternion.Euler(90, IslandCheaterTavernConst.seatRotatonY[self.mainPlayerSeat], 0)
	self.endScale = Vector3(2, 2, 2)

	return
end

function MainCardItem:UpdateFlipTableCard()
	if not self.isFliping then
		return
	end

	self.flipDeltaTime = self.flipDeltaTime + Time.deltaTime

	local var_14_0 = math.min(self.flipDeltaTime / IslandCheaterTavernConst.FlipCardTime, 1)

	self.tf.rotation = self.startFlipRotation * Quaternion.AngleAxis(Mathf.Lerp(0, 180, var_14_0), self.localUp)

	if var_14_0 >= 1 then
		self.isFliping = false
	end

	return
end

function MainCardItem:FlipTableCard(arg_15_1, arg_15_2, arg_15_3)
	if self.id ~= arg_15_1 then
		local var_15_0 = self.tf.position
		local var_15_1 = self.tf.rotation
		local var_15_2 = self.tf.localScale

		self.cardPoolMgr:ReturnGameObjectById(self.id, self.tf.gameObject)

		self.tf = nil

		self.cardPoolMgr:GetCardGameObjectById(arg_15_1, function(arg_16_0)
			self.tf = arg_16_0.transform
			self.selectedCardTf = self.tf:Find("vfx_bar_kapai01")

			setActive(self.selectedCardTf, false)

			self.tf.position = var_15_0
			self.tf.rotation = var_15_1
			self.tf.localScale = var_15_2

			return
		end, true)

		self.id = arg_15_1
	end

	setParent(self.tf, nil)

	self.isFliping = true
	self.deltaTime = 0
	self.flipDeltaTime = 0
	self.startPos = self.tf.position
	self.startFlipRotation = Quaternion.Euler(90, IslandCheaterTavernConst.seatRotatonY[self.mainPlayerSeat], 0)
	self.localUp = self.startFlipRotation * Vector3.forward

	local var_15_3 = -(arg_15_3 * (IslandCheaterTavernConst.cardWidth * 2) + (arg_15_3 - 1) * 0) / 2 + IslandCheaterTavernConst.cardWidth * 2 / 2 + (arg_15_2 - 1) * (IslandCheaterTavernConst.cardWidth * 2 + 0)
	local var_15_4 = 0
	local var_15_5 = 0

	if self.mainPlayerSeat % 2 == 0 then
		var_15_4 = var_15_3
	else
		var_15_5 = var_15_3
	end

	self.tf.position = Vector3(6.29 + var_15_4, 0.92 + 0.001 * arg_15_2, 2.11 + var_15_5)

	return
end

function MainCardItem:SetActive(arg_17_1)
	setActive(self.tf, arg_17_1)

	return
end

function MainCardItem:Destroy()
	if IsNil(self.tf) then
		return
	end

	self.selectedCardTf = nil
	self.unSelectedCardTf = nil

	self.cardPoolMgr:ReturnGameObjectById(self.id, self.tf.gameObject)

	self.tf = nil

	return
end

return MainCardItem
