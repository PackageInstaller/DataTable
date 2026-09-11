local T0StageContent = class("T0StageContent", BaseView)

function T0StageContent:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.actionCom = self.action_:GetComponent("T0GlobalWaitBubbleEventController")

	self:AddListeners()
end

function T0StageContent:AddListeners()
	self:AddBtnListener(self.leftHandBtn_, nil, function()
		self.actionCom:TriggerInteract("1")
	end)
	self:AddBtnListener(self.rightHandBtn_, nil, function()
		self.actionCom:TriggerInteract("2")
	end)
	self:AddBtnListener(self.bothHandBtn_, nil, function()
		self.actionCom:TriggerInteract("3")
	end)
end

function T0StageContent:Show()
	SetActive(self.gameObject_, true)
end

function T0StageContent:Hide()
	SetActive(self.gameObject_, false)
end

function T0StageContent:Toggle()
	if self.gameObject_.activeSelf then
		self:Hide()
	else
		self:Show()
	end
end

return T0StageContent
