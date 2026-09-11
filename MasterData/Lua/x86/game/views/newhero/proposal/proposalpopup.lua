local ProposalPopup = class("ProposalPopup", ReduxView)

function ProposalPopup:UIName()
	return "Widget/System/Hero_equip/EquipSchemeNamePopUI"
end

function ProposalPopup:UIParent()
	return manager.ui.uiPop.transform
end

function ProposalPopup:Init()
	self:InitUI()
	self:AddUIListener()

	self.backHandler_ = handler(self, self.Back)
end

function ProposalPopup:InitUI()
	self:BindCfgUI()
	self:GetOrAddComponent(self.input_.gameObject, typeof(InputFieldHelper))
	dealEnter(self.input_.gameObject)
end

function ProposalPopup:OnEnter()
	local var_5_0, var_5_1 = gameContext:GetLastHistoryAndParams()

	if string.char(string.byte(var_5_0)) == "/" then
		var_5_0 = string.sub(var_5_0, 2)
	end

	self.lastRecord_ = var_5_0
	self.input_.text = GetI18NText(self.params_.defaultText) or ""

	manager.notify:RegistListener(INPUT_POP_BACK, self.backHandler_)
end

function ProposalPopup:OnExit()
	manager.notify:RemoveListener(INPUT_POP_BACK, self.backHandler_)
end

function ProposalPopup:AddUIListener()
	self:AddBtnListener(self.cancelbtnBtn_, nil, function()
		OperationRecorder.Record(self.lastRecord_, "proposal_cancelBtn")
		manager.notify:Invoke(INPUT_POP_CLICK_CANCEL)
		JumpTools.Back()
	end)
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		manager.notify:Invoke(INPUT_POP_CLICK_CLOSE, self.input_.text, self.input_)
		JumpTools.Back()
	end)
	self:AddBtnListener(self.okbtnBtn_, nil, function()
		OperationRecorder.Record(self.lastRecord_, "proposal_okBtn")
		manager.notify:Invoke(INPUT_POP_CLICK_OK, self.input_.text, self.input_)
	end)
end

function ProposalPopup:Dispose()
	self:RemoveAllListeners()

	self.backHandler_ = nil

	ProposalPopup.super.Dispose(self)
end

return ProposalPopup
