local AffixDetailItemView = class("AffixDetailItemView", ReduxView)

function AffixDetailItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function AffixDetailItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AffixDetailItemView:InitUI()
	self:BindCfgUI()
end

function AffixDetailItemView:AddUIListener()
	return
end

function AffixDetailItemView:AddEventListeners()
	return
end

function AffixDetailItemView:SetData(arg_6_1, arg_6_2)
	self.index_ = arg_6_1
	self.data_ = arg_6_2
	self.cfg_ = AffixTypeCfg[arg_6_2[1]]
	self.level_ = arg_6_2[2]
	self.type_ = arg_6_2[3]

	self:UpdateView()
end

function AffixDetailItemView:UpdateView()
	self.icon_.sprite = getAffixSprite(self.data_)
	self.nameLabel_.text = getAffixName(self.data_)
	self.descLabel_.text = getAffixDesc(self.data_)
end

function AffixDetailItemView:OnEnter()
	self:AddEventListeners()
end

function AffixDetailItemView:OnExit()
	self:RemoveAllEventListener()
end

function AffixDetailItemView:OnMainHomeViewTop()
	return
end

function AffixDetailItemView:Dispose()
	self.data_ = nil

	AffixDetailItemView.super.Dispose(self)
end

return AffixDetailItemView
