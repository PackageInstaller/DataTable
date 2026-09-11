local EquipBreakThroughMaterialAttributeItem = class("EquipBreakThroughMaterialAttributeItem", ReduxView)

function EquipBreakThroughMaterialAttributeItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
end

function EquipBreakThroughMaterialAttributeItem:Dispose()
	EquipBreakThroughMaterialAttributeItem.super.Dispose(self)
end

function EquipBreakThroughMaterialAttributeItem:SetData(arg_3_1, arg_3_2)
	self.icon_.sprite = getSprite("Atlas/EquipBreakThroughMaterialIcon", EquipBreakThroughMaterialItemCfg[arg_3_1].icon)
	self.descText_.text = string.format(GetI18NText(EquipBreakThroughMaterialItemCfg[arg_3_1].desc), getAttributeAffixValue(arg_3_1, arg_3_2) / 10)
end

return EquipBreakThroughMaterialAttributeItem
