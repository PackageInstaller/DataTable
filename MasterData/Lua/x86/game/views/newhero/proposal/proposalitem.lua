local EquipProposalItem = class("EquipProposalItem", ReduxView)

function EquipProposalItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
	self:AddUIListener()
end

function EquipProposalItem:InitUI()
	self:BindCfgUI()

	self.selectController_ = self.proposalCon_:GetController("select")
	self.nameController_ = self.proposalCon_:GetController("name")
end

function EquipProposalItem:AddUIListener()
	self:AddBtnListener("", nil, function()
		self.func()
	end)
	self:AddBtnListener(self.btnChangeName_, nil, function()
		self.changeNameFunc()
	end)
end

function EquipProposalItem:RefreshUI(arg_6_1)
	self.label1Text_.text = GetI18NText(arg_6_1.proposal_name)
	self.label2Text_.text = GetI18NText(arg_6_1.proposal_name)
end

function EquipProposalItem:ShowSelect(arg_7_1)
	self.selectController_:SetSelectedState(arg_7_1 and "select" or "unselect")
	self.nameController_:SetSelectedState(arg_7_1 and "change" or "name")
end

function EquipProposalItem:RegistCallBack(arg_8_1, arg_8_2)
	self.func = arg_8_1
	self.changeNameFunc = arg_8_2
end

function EquipProposalItem:Dispose()
	self:RemoveAllListeners()
	EquipProposalItem.super.Dispose(self)
end

return EquipProposalItem
