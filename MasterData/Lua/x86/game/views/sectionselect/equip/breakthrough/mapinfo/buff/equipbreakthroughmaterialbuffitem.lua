local EquipBreakThroughMaterialBuffItem = class("EquipBreakThroughMaterialBuffItem", ReduxView)

function EquipBreakThroughMaterialBuffItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
end

function EquipBreakThroughMaterialBuffItem:Dispose()
	EquipBreakThroughMaterialBuffItem.super.Dispose(self)
end

function EquipBreakThroughMaterialBuffItem:SetData(arg_3_1)
	self.nameText_.text = GetI18NText(EquipBreakThroughMaterialItemCfg[arg_3_1].name)
	self.descText_.text = getAffixDesc(EquipBreakThroughMaterialItemCfg[arg_3_1].params)
	self.icon_.sprite = getSprite("Atlas/EquipBreakThroughMaterialIcon", EquipBreakThroughMaterialItemCfg[arg_3_1].icon)
end

return EquipBreakThroughMaterialBuffItem
