local CourtYardFeastShipModule = class("CourtYardFeastShipModule", import(".CourtYardShipModule"))

function CourtYardFeastShipModule:OnInit()
	CourtYardFeastShipModule.super.OnInit(self)

	self.feastAttachments = self._tf:Find("feastAttachments")
	self.bubbles = {
		self._tf:Find("feastAttachments/greet"),
		self._tf:Find("feastAttachments/drink"),
		self._tf:Find("feastAttachments/eat"),
		self._tf:Find("feastAttachments/dance"),
		self._tf:Find("feastAttachments/sleep")
	}
	self.expressList = {
		self._tf:Find("feastAttachments/express/1"),
		self._tf:Find("feastAttachments/express/2"),
		self._tf:Find("feastAttachments/express/3"),
		self._tf:Find("feastAttachments/express/4")
	}
	self.chatBubble = self._tf:Find("feastAttachments/chat")
	self.chatBubbleTxt = self._tf:Find("feastAttachments/chat/Text"):GetComponent(typeof(Text))
	self.specialMark = self._tf:Find("feastAttachments/specialmark")

	setActive(self.chatBubble, false)
	setParent(self.specialMark, self._tf)
	self.specialMark:SetAsFirstSibling()

	self.specialMark.localScale = Vector3(2, 2, 1)

	self:InitMark()

	self.timers = {}

	return
end

function CourtYardFeastShipModule:InitMark()
	setActive(self.specialMark, self.data:IsSpecial())
	self:OnFeastBubbleChange(self.data.bubble)

	self.bubbles[1]:GetComponent(typeof(Image)).raycastTarget = true

	onButton(self, self.bubbles[1], function()
		triggerButton(self.clickTF)

		return
	end, SFX_PANEL)

	return
end

function CourtYardFeastShipModule:AddListeners()
	CourtYardFeastShipModule.super.AddListeners(self)
	self:AddListener(CourtYardEvent.FEAST_SHIP_BUBBLE_CHANGE, self.OnFeastBubbleChange)
	self:AddListener(CourtYardEvent.FEAST_SHIP_CHAT_CHANGE, self.OnFeastChatChange)
	self:AddListener(CourtYardEvent.FEAST_SHIP_BUBBLE_INTERACTION, self.OnFeastShipBubbleInterAction)
	self:AddListener(CourtYardEvent.FEAST_SHIP_SHOW_EXPRESS, self.OnFeastShipShowExpress)

	return
end

function CourtYardFeastShipModule:RemoveListeners()
	CourtYardFeastShipModule.super.RemoveListeners(self)
	self:RemoveListener(CourtYardEvent.FEAST_SHIP_BUBBLE_CHANGE, self.OnFeastBubbleChange)
	self:RemoveListener(CourtYardEvent.FEAST_SHIP_CHAT_CHANGE, self.OnFeastChatChange)
	self:RemoveListener(CourtYardEvent.FEAST_SHIP_BUBBLE_INTERACTION, self.OnFeastShipBubbleInterAction)
	self:RemoveListener(CourtYardEvent.FEAST_SHIP_SHOW_EXPRESS, self.OnFeastShipShowExpress)

	return
end

function CourtYardFeastShipModule:OnFeastShipShowExpress(arg_6_1)
	if self.expressList[arg_6_1] then
		self:ClearChatAnimation()
		self:PlayExpressAnim(self.expressList[arg_6_1])
	end

	return
end

function CourtYardFeastShipModule:PlayExpressAnim(arg_7_1, arg_7_2, arg_7_3)
	arg_7_3 = defaultValue(arg_7_3, 0)
	arg_7_2 = defaultValue(arg_7_2, Vector3(1, 1, 1))

	LeanTween.scale(go(arg_7_1), arg_7_2, 0.5):setEase(LeanTweenType.easeOutBack):setDelay(arg_7_3):setOnComplete(System.Action(function()
		self:PlayExpressAnim(arg_7_1, Vector3(0, 0, 0), 2)

		return
	end))

	return
end

function CourtYardFeastShipModule:ClearChatAnimation()
	CourtYardFeastShipModule.super.ClearChatAnimation(self)

	for iter_9_0, iter_9_1 in ipairs(self.expressList or {}) do
		if LeanTween.isTweening(iter_9_1.gameObject) then
			LeanTween.cancel(iter_9_1.gameObject)
		end

		iter_9_1.localScale = Vector3.zero
	end

	return
end

function CourtYardFeastShipModule:OnFeastBubbleChange(arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(self.bubbles) do
		setActive(iter_10_1, iter_10_0 == arg_10_1)
	end

	return
end

function CourtYardFeastShipModule:OnFeastChatChange(arg_11_1)
	local var_11_0 = arg_11_1 ~= ""

	setActive(self.chatBubble, arg_11_1 ~= "")

	self.chatBubbleTxt.text = arg_11_1

	self:RemoveDisappearTimer()

	if var_11_0 then
		self:DisappearTimer()
	end

	return
end

local var_0_1 = {
	"AiXin",
	"XinXin",
	"XinXin",
	"YinFu",
	"Zzz"
}

function CourtYardFeastShipModule:OnFeastShipBubbleInterAction(arg_12_1)
	local var_12_0 = self:GetView().poolMgr
	local var_12_1 = var_12_0["Get" .. (var_0_1[arg_12_1] or var_0_1[1]) .. "Pool"](var_12_0):Dequeue()

	var_12_1.transform:SetParent(self._tf, false)

	tf(var_12_1).localPosition = Vector3(0, 100, -100)
	tf(var_12_1).localScale = Vector3(3, 3, 3)

	local var_12_2 = #self.timers + 1
	local var_12_3

	self.cg.blocksRaycasts = false
	var_12_3 = Timer.New(function()
		var_12_3:Stop()
		table.remove(self.timers, var_12_2)
		self:Emit("ShipBubbleInterActionFinish", self.data.id)

		self.cg.blocksRaycasts = true

		return
	end, 0.01, 1)

	var_12_3:Start()
	table.insert(self.timers, var_12_3)

	return
end

function CourtYardFeastShipModule:DisappearTimer()
	self.disappearTimer = Timer.New(function()
		setActive(self.chatBubble, false)

		return
	end, CourtYardConst.FEAST_CHAT_TIME, 1)

	self.disappearTimer:Start()

	return
end

function CourtYardFeastShipModule:RemoveDisappearTimer()
	if self.disappearTimer then
		self.disappearTimer:Stop()

		self.disappearTimer = nil
	end

	return
end

function CourtYardFeastShipModule:OnStateChange(arg_17_1, arg_17_2)
	CourtYardFeastShipModule.super.OnStateChange(self, arg_17_1, arg_17_2)
	setActive(self.specialMark, not not (self.data:IsSpecial() and (arg_17_1 == CourtYardShip.STATE_IDLE or arg_17_1 == CourtYardShip.STATE_MOVE or arg_17_1 == CourtYardShip.STATE_MOVING_ZERO or arg_17_1 == CourtYardShip.STATE_MOVING_HALF or arg_17_1 == CourtYardShip.STATE_MOVING_ONE or arg_17_1 == CourtYardShip.STATE_TOUCH or arg_17_1 == CourtYardShip.STATE_GETAWARD)))

	self.feastAttachments.localPosition = arg_17_1 == CourtYardShip.STATE_INTERACT and Vector3(0, -85, 0) or Vector3.zero

	return
end

function CourtYardFeastShipModule:OnDestroy()
	self.cg.blocksRaycasts = true

	for iter_18_0, iter_18_1 in ipairs(self.timers or {}) do
		iter_18_1:Stop()
	end

	self.timers = nil

	self:RemoveDisappearTimer()

	if self.feastAttachments then
		setParent(self.specialMark, self.feastAttachments)

		self.specialMark.localScale = Vector3.one

		Object.Destroy(self.feastAttachments.gameObject)

		self.feastAttachments = nil
	end

	CourtYardFeastShipModule.super.OnDestroy(self)

	return
end

return CourtYardFeastShipModule
