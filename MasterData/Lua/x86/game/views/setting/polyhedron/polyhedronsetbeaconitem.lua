local PolyhedronOverBeaconItem = class("PolyhedronOverBeaconItem", ReduxView)

function PolyhedronOverBeaconItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function PolyhedronOverBeaconItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function PolyhedronOverBeaconItem:InitUI()
	self:BindCfgUI()
end

function PolyhedronOverBeaconItem:AddUIListener()
	return
end

function PolyhedronOverBeaconItem:SetData(arg_5_1)
	self.id = arg_5_1
	self.m_icon.sprite = pureGetSpriteWithoutAtlas(PolyhedronConst.BEACON_ICON_PATH .. PolyhedronBeaconCfg[self.id].icon)
	self.m_name.text = GetI18NText(PolyhedronBeaconCfg[self.id].name)
	self.m_des.text = GetI18NText(PolyhedronBeaconCfg[self.id].desc)

	self:SetActive(true)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_desTrs)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform_)
end

function PolyhedronOverBeaconItem:RegistCallBack(arg_6_1)
	self.clickFunc = arg_6_1
end

function PolyhedronOverBeaconItem:Dispose()
	PolyhedronOverBeaconItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

function PolyhedronOverBeaconItem:SetActive(arg_8_1)
	SetActive(self.gameObject_, arg_8_1)
end

return PolyhedronOverBeaconItem
