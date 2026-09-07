local CourtYardShipModule = class("CourtYardShipModule", import("..CourtYardPlaceableModule"))
local var_0_1 = 1

function CourtYardShipModule:Ctor(arg_1_1, arg_1_2, arg_1_3)
	var_0_1 = CourtYardConst.SHIP_SCALE

	CourtYardShipModule.super.Ctor(self, arg_1_1, arg_1_2)

	self._role = arg_1_3

	return
end

function CourtYardShipModule:OnInit()
	CourtYardShipModule.super.OnInit(self)
	pg.ViewUtils.SetLayer(self._tf, Layer.UI)
	self._tf:SetParent(self.floor)
	self._role:SetLocalPosition(Vector3(0, 25, 0))

	self.shadow = self._tf:Find("shadow")
	self.shadow.localPosition = Vector3(0, 25, 0)

	self.shadow:SetAsFirstSibling()

	self.spineAnimUI = self._role:GetSpineAnimUI()
	self.clickTF = self._tf:Find("click")
	self.chatTF = self._tf:Find("chat")
	self.chatTF.localScale = Vector3.zero
	self.additionTF = self._tf:Find("addition")
	self.additionTFs = {
		findTF(self.additionTF, "money"),
		findTF(self.additionTF, "intimacy"),
		findTF(self.additionTF, "exp")
	}
	self.additionTFPos = Vector3(0, 250, 0)
	self.inimacyBubble = self._tf:Find("intimacy")
	self.moneyBubble = self._tf:Find("money")
	self.animator = CourtYardShipAnimatorAgent.New(self)
	self._tf.localScale = Vector3(var_0_1, var_0_1, 1)
	self._tf:Find("grids").localScale = Vector3(1 / var_0_1, 1 / var_0_1, 1)

	self.animator:SetState(self.data:GetState())
	self:UpdateBubble(self.inimacyBubble, self.data.inimacy)
	self:UpdateBubble(self.moneyBubble, self.data.coin)
	self:InitAttachment()
	setActive(self.shadow, true)

	return
end

function CourtYardShipModule:AdjustYForInteraction()
	self._role:SetLocalPosition(Vector3(0, 0, 0))

	return
end

function CourtYardShipModule:ResetYForInteraction()
	self._role:SetLocalPosition(Vector3(0, 25, 0))

	return
end

function CourtYardShipModule:GetSpine()
	return self._role:GetRoleModel()
end

function CourtYardShipModule:AddListeners()
	self:AddListener(CourtYardEvent.SHIP_STATE_CHANGE, self.OnStateChange)
	self:AddListener(CourtYardEvent.SHIP_MOVE, self.OnMove)
	self:AddListener(CourtYardEvent.SHIP_POSITION_CHANGE, self.OnUpdatePosition)
	self:AddListener(CourtYardEvent.SHIP_GET_AWARD, self.OnAddAward)
	self:AddListener(CourtYardEvent.SHIP_INIMACY_CHANGE, self.OnInimacyChange)
	self:AddListener(CourtYardEvent.SHIP_COIN_CHANGE, self.OnCoinChange)
	self:AddListener(CourtYardEvent.SHIP_UPDATE_INTERACTION, self.OnUpdateInteraction)
	self:AddListener(CourtYardEvent.SHIP_WILL_INTERACTION, self.WillInterAction)
	self:AddListener(CourtYardEvent.SHIP_START_INTERACTION, self.StartInterAction)
	self:AddListener(CourtYardEvent.SHIP_STOP_INTERACTION, self.StopInterAction)

	return
end

function CourtYardShipModule:RemoveListeners()
	self:RemoveListener(CourtYardEvent.SHIP_STATE_CHANGE, self.OnStateChange)
	self:RemoveListener(CourtYardEvent.SHIP_MOVE, self.OnMove)
	self:RemoveListener(CourtYardEvent.SHIP_POSITION_CHANGE, self.OnUpdatePosition)
	self:RemoveListener(CourtYardEvent.SHIP_GET_AWARD, self.OnAddAward)
	self:RemoveListener(CourtYardEvent.SHIP_INIMACY_CHANGE, self.OnInimacyChange)
	self:RemoveListener(CourtYardEvent.SHIP_COIN_CHANGE, self.OnCoinChange)
	self:RemoveListener(CourtYardEvent.SHIP_UPDATE_INTERACTION, self.OnUpdateInteraction)
	self:RemoveListener(CourtYardEvent.SHIP_WILL_INTERACTION, self.WillInterAction)
	self:RemoveListener(CourtYardEvent.SHIP_START_INTERACTION, self.StartInterAction)
	self:RemoveListener(CourtYardEvent.SHIP_STOP_INTERACTION, self.StopInterAction)

	return
end

function CourtYardShipModule:InitAttachment()
	onButton(self, self.clickTF, function()
		self:Emit("TouchShip", self.data.id)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_BOAT_CLICK)

		return
	end)
	onButton(self, self.inimacyBubble, function()
		self:Emit("GetShipInimacy", self.data.id)

		return
	end, SFX_PANEL)
	onButton(self, self.moneyBubble, function()
		self:Emit("GetShipCoin", self.data.id)

		return
	end, SFX_PANEL)

	return
end

function CourtYardShipModule:OnBeginDrag()
	if not self:GetView():GetCurrStorey():AllModulesAreCompletion() then
		return
	end

	self:Emit("DragShip", self.data.id)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_BOAT_DRAG)

	return
end

function CourtYardShipModule:OnDragging(arg_13_1)
	self:Emit("DragingShip", self.data.id, arg_13_1)

	return
end

function CourtYardShipModule:OnDragEnd(arg_14_1)
	self:Emit("DragShipEnd", self.data.id, arg_14_1)

	return
end

function CourtYardShipModule:OnUpdatePosition(arg_15_1, arg_15_2)
	self:UpdatePosition(arg_15_1, arg_15_2)

	return
end

function CourtYardShipModule:OnStateChange(arg_16_1, arg_16_2)
	if arg_16_1 ~= CourtYardShip.STATE_MOVING_ZERO and arg_16_1 ~= CourtYardShip.STATE_MOVING_HALF and arg_16_1 ~= CourtYardShip.STATE_MOVING_ONE then
		self:ClearMove()
	end

	self.animator:SetState(arg_16_1)

	if arg_16_1 == CourtYardShip.STATE_TOUCH then
		self:ClearChatAnimation()
		self:PlayChatAnim()
	end

	return
end

function CourtYardShipModule:PlayChatAnim(arg_17_1, arg_17_2, arg_17_3)
	arg_17_3 = defaultValue(arg_17_3, true)
	arg_17_2 = defaultValue(arg_17_2, 0)
	arg_17_1 = defaultValue(arg_17_1, Vector3(2, 2, 2))

	if not arg_17_3 then
		return
	end

	LeanTween.scale(go(self.chatTF), arg_17_1, 0.5):setEase(LeanTweenType.easeOutBack):setDelay(arg_17_2):setOnComplete(System.Action(function()
		self:PlayChatAnim(Vector3(0, 0, 0), 2, false)

		return
	end))

	return
end

function CourtYardShipModule:ClearChatAnimation()
	if LeanTween.isTweening(go(self.chatTF)) then
		LeanTween.cancel(go(self.chatTF))
	end

	self.chatTF.localScale = Vector3.zero

	return
end

function CourtYardShipModule:OnUpdateInteraction(arg_20_1)
	self.animator:PlayInteractioAnim(arg_20_1.action)

	return
end

function CourtYardShipModule:OnAnimtionFinish(arg_21_1)
	self:Emit("ShipAnimtionFinish", self.data.id, arg_21_1)

	return
end

function CourtYardShipModule:OnMove(arg_22_1, arg_22_2)
	self:ClearMove()

	local var_22_0 = self.data:GetPosition()
	local var_22_1 = CourtYardCalcUtil.Map2Local(arg_22_1)
	local var_22_2 = self.data:GetMoveTime()

	self._role:SetLocalScale(Vector3((arg_22_1.x < var_22_0.x and arg_22_1.y == var_22_0.y or arg_22_1.x == var_22_0.x and arg_22_1.y > var_22_0.y) == false and 1 or -1, 1, 1))
	LeanTween.moveLocal(self._go, CourtYardCalcUtil.TrPosition2LocalPos(self:GetParentTF(), self._tf.parent, Vector3(var_22_1.x, var_22_1.y, 0) + arg_22_2), var_22_2)

	for iter_22_0 = 1, self.interactionTF.childCount do
		local var_22_3 = self.interactionTF:GetChild(iter_22_0 - 1)

		var_22_3.localScale = Vector3(math.abs(var_22_3.localScale.x), var_22_3.localScale.y, var_22_3.localScale.z)
	end

	self.interactionTF.localScale = self._role:GetLocalScale()

	return
end

function CourtYardShipModule:OnAddAward(arg_23_1, arg_23_2)
	if arg_23_2 == 3 and arg_23_1 <= 0 then
		return
	end

	for iter_23_0, iter_23_1 in pairs(self.additionTFs) do
		setActive(iter_23_1, arg_23_2 == iter_23_0)
	end

	local var_23_0 = self.additionTFs[arg_23_2]

	if arg_23_2 ~= 1 then
		arg_23_1 = ""
	end

	setText(self.additionTFs[arg_23_2]:Find("Text"), arg_23_1 or "")

	if arg_23_2 == 2 then
		if self:GetView().poolMgr:GetHeartPool() then
			local var_23_1 = self:GetView().poolMgr:GetHeartPool():Dequeue()

			var_23_1.transform:SetParent(self._tf, false)

			tf(var_23_1).localPosition = Vector3(0, 200, -100)
			tf(var_23_1).localScale = Vector3(100, 100, 100)
		end
	end

	local var_23_2 = 1 / var_0_1

	if CourtYardCalcUtil.GetTransformSign(self._tf, self.rect) < 0 then
		self.additionTF.localScale = Vector3(-var_23_2, var_23_2, var_23_2)
	end

	LeanTween.cancel(self.additionTF.gameObject)

	self.additionTF.transform.localPosition = self.additionTFPos

	LeanTween.moveY(rtf(self.additionTF), self.additionTFPos.y + 110, 1.2):setOnComplete(System.Action(function()
		self.additionTF.localScale = Vector3(var_23_2, var_23_2, var_23_2)

		setActive(var_23_0, false)

		return
	end))

	return
end

function CourtYardShipModule:UpdateBubble(arg_25_1, arg_25_2)
	setActive(arg_25_1, arg_25_2 ~= 0)

	if LeanTween.isTweening(arg_25_1.gameObject) then
		LeanTween.cancel(arg_25_1.gameObject)
	end

	if arg_25_2 ~= 0 then
		arg_25_1.localScale = Vector3(2, 2, 0)
	end

	if arg_25_2 ~= 0 then
		floatAni(arg_25_1, 20, 1)
	end

	return
end

function CourtYardShipModule:OnInimacyChange(arg_26_1)
	self:UpdateBubble(self.inimacyBubble, arg_26_1)

	return
end

function CourtYardShipModule:OnCoinChange(arg_27_1)
	self:UpdateBubble(self.moneyBubble, arg_27_1)

	return
end

function CourtYardShipModule:ClearMove()
	LeanTween.cancel(self._go)

	return
end

function CourtYardShipModule:WillInterAction(arg_29_1)
	return
end

function CourtYardShipModule:StartInterAction(arg_30_1)
	setActive(self.shadow, false)
	setAnchoredPosition(self._tf, (arg_30_1:GetOffset()))

	local var_30_0 = arg_30_1:GetScale()

	self._role:SetLocalScale(Vector3(arg_30_1:GetOwner():GetNormalDirection() * var_30_0.x, var_30_0.y, var_30_0.z))
	self:AdjustYForInteraction()

	return
end

function CourtYardShipModule:StopInterAction()
	setActive(self.shadow, true)
	self:ResetTransform()
	self:ResetYForInteraction()

	return
end

function CourtYardShipModule:ResetTransform()
	self._tf.localScale = Vector3(var_0_1, var_0_1, 1)
	self._tf.localEulerAngles = Vector3.zero

	return
end

function CourtYardShipModule:HideAttachment(arg_33_1)
	if self._role then
		self._role:SetOrbitVisible(not arg_33_1)
	end

	return
end

function CourtYardShipModule:OnDispose()
	CourtYardShipModule.super.OnDispose(self)
	self:ClearChatAnimation()
	self:ResetTransform()

	if self.animator then
		self.animator:Dispose()

		self.animator = nil
	end

	if self.spineAnimUI then
		self.spineAnimUI:SetActionCallBack(nil)

		self.spineAnimUI = nil
	end

	self:ClearMove()

	if self._role then
		self._role:Dispose()

		self._role = nil
	end

	return
end

function CourtYardShipModule:OnDestroy()
	self:GetView().poolMgr:GetShipPool():Enqueue(self._go)

	return
end

return CourtYardShipModule
