local PolyhedronSetEquipItem = class("PolyhedronSetEquipItem", ReduxView)

function PolyhedronSetEquipItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function PolyhedronSetEquipItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function PolyhedronSetEquipItem:InitUI()
	self:BindCfgUI()
end

function PolyhedronSetEquipItem:AddUIListener()
	return
end

function PolyhedronSetEquipItem:SetData(arg_5_1)
	self.m_icon.sprite = getSpriteViaConfig("EquipIcon_s", EquipSuitCfg[arg_5_1].icon)
	self.m_name.text = EquipSuitCfg[arg_5_1].name
	self.m_des.text = EquipTools.GetEffectDesc(EquipSuitCfg[arg_5_1].suit_effect[1])

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_des.transform)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform_)
end

function PolyhedronSetEquipItem:SetActive(arg_6_1)
	SetActive(self.gameObject_, arg_6_1)
end

function PolyhedronSetEquipItem:Dispose()
	PolyhedronSetEquipItem.super.Dispose(self)
end

return PolyhedronSetEquipItem
