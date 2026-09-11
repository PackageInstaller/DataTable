local ReserveProposalAttributeTagItem = class("ReserveProposalAttributeTagItem", ReduxView)

function ReserveProposalAttributeTagItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ReserveProposalAttributeTagItem:Init()
	self:BindCfgUI()
	self:InitController()
	self:AddListeners()
end

function ReserveProposalAttributeTagItem:InitController()
	self.selectController_ = self.controllerEx_:GetController("select")
	self.corlorController_ = self.controllerEx_:GetController("color")
end

function ReserveProposalAttributeTagItem:AddListeners()
	if self.btn_ then
		self:AddBtnListener(self.btn_, nil, handler(self, self.OnSelect))
	end
end

function ReserveProposalAttributeTagItem:SetData(arg_5_1)
	self.id_ = arg_5_1

	self:Refresh()
end

function ReserveProposalAttributeTagItem:Refresh()
	self:RefreshIcon()
end

function ReserveProposalAttributeTagItem:RefreshIcon()
	self.icon_.sprite = HeroTools.LoadSkillAttributeIcon(FormationProposalTagCfg[self.id_].icon)
end

function ReserveProposalAttributeTagItem:SetSelectCallBack(arg_8_1)
	self.callback_ = arg_8_1
end

function ReserveProposalAttributeTagItem:OnSelect()
	if self.callback_ then
		self.callback_(self.id_, self.isAll_)
	end
end

function ReserveProposalAttributeTagItem:SetSelect(arg_10_1)
	self.selectController_:SetSelectedState(arg_10_1 and "on" or "off")
end

function ReserveProposalAttributeTagItem:SetColor(arg_11_1)
	self.corlorController_:SetSelectedState(arg_11_1 and "on" or "off")
end

function ReserveProposalAttributeTagItem:GetId()
	return self.id_
end

function ReserveProposalAttributeTagItem:Show(arg_13_1)
	SetActive(self.gameObject_, arg_13_1)
end

return ReserveProposalAttributeTagItem
