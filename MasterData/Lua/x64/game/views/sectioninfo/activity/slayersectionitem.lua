local SlayerSectionItem = class("SlayerSectionItem", ReduxView)

function SlayerSectionItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function SlayerSectionItem:Init()
	self:InitUI()
end

function SlayerSectionItem:InitUI()
	self:BindCfgUI()
end

function SlayerSectionItem:SetActive(arg_4_1)
	SetActive(self.gameObject_, arg_4_1)
end

function SlayerSectionItem:SetData(arg_5_1)
	self.m_lab.text = GetI18NText(arg_5_1)

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform_)
end

return SlayerSectionItem
