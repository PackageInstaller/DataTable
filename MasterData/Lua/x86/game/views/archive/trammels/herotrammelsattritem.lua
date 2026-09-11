local HeroTrammelsAttrItem = class("HeroTrammelsAttrItem", ReduxView)

function HeroTrammelsAttrItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function HeroTrammelsAttrItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroTrammelsAttrItem:InitUI()
	self:BindCfgUI()
end

function HeroTrammelsAttrItem:AddUIListener()
	return
end

function HeroTrammelsAttrItem:SetData(arg_5_1)
	self.m_attrName.text = PublicAttrCfg[arg_5_1[1]].name
	self.m_attrAdd.text = PublicAttrCfg[arg_5_1[1]].percent == 1 and string.format("+%.2f%%", arg_5_1[2] / 10) or string.format("+%d", arg_5_1[2])
end

function HeroTrammelsAttrItem:Dispose()
	HeroTrammelsAttrItem.super.Dispose(self)
end

return HeroTrammelsAttrItem
