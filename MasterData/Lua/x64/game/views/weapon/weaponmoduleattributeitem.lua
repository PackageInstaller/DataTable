local WeaponModuleAttributeItem = class("WeaponModuleAttributeItem", ReduxView)

function WeaponModuleAttributeItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function WeaponModuleAttributeItem:Init()
	ComponentBinder.GetInstance():BindCfgUI(self, self.gameObject_)
end

function WeaponModuleAttributeItem:SetData(arg_3_1, arg_3_2)
	self.typeImage_.sprite = getSprite("Atlas/Common", PublicAttrCfg[arg_3_1].icon)
	self.typeText_.text = GetI18NText(PublicAttrCfg[arg_3_1].name)
	self.numText_.text = "+" .. arg_3_2
end

function WeaponModuleAttributeItem:SetIsShow(arg_4_1)
	SetActive(self.gameObject_, arg_4_1)
end

function WeaponModuleAttributeItem:Dispose()
	WeaponModuleAttributeItem.super.Dispose(self)
end

return WeaponModuleAttributeItem
