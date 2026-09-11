local ProposalEquipItem = class("ProposalEquipItem", EquipBaseView)

function ProposalEquipItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:InitUI()
	ProposalEquipItem.super.Init(self, 1)
end

function ProposalEquipItem:InitUI()
	self.equipInfoGo_ = self:FindGo("EquipInfoUI")
	self.equipSkillGo_ = self:FindGo("EquipSkillInfoUI")
	self.maskGo_ = self:FindGo("mask")
end

function ProposalEquipItem:ShowEquipInfo(arg_3_1)
	SetActive(self.equipInfoGo_, true)
	SetActive(self.maskGo_, true)
	self:RefreshEquipInfo((EquipData:GetEquipData(arg_3_1)))
end

return ProposalEquipItem
