local EquipBreakThroughMaterialBuffStageItem = class("EquipBreakThroughMaterialBuffStageItem", ReduxView)

function EquipBreakThroughMaterialBuffStageItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.selectHandler_ = handler(self, self.SelectItem)

	manager.notify:RegistListener(EQUIP_BREAK_THROUGH_SELECT_BUFF, self.selectHandler_)

	self.controller_ = ControllerUtil.GetController(self.transform_, "select")
end

function EquipBreakThroughMaterialBuffStageItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		manager.notify:Invoke(EQUIP_BREAK_THROUGH_SELECT_BUFF, self.index_)
	end)
end

function EquipBreakThroughMaterialBuffStageItem:Dispose()
	EquipBreakThroughMaterialBuffStageItem.super.Dispose(self)
	manager.notify:RemoveListener(EQUIP_BREAK_THROUGH_SELECT_BUFF, self.selectHandler_)

	self.selectHandler_ = nil
end

function EquipBreakThroughMaterialBuffStageItem:SetData(arg_5_1, arg_5_2, arg_5_3)
	self.index_ = arg_5_1
	self.mapStageID_ = arg_5_2

	self:RefreshUI()
	self:SelectItem(arg_5_3)
end

function EquipBreakThroughMaterialBuffStageItem:RefreshUI()
	local var_6_0 = EquipBreakThroughMaterialItemCfg[EquipBreakThroughMaterialData:GetStageData()[self.mapStageID_].buffList[self.index_]]

	self.nameText_.text = GetI18NText(var_6_0.name)
	self.descText_.text = getAffixDesc(var_6_0.params)
	self.icon_.sprite = getSprite("Atlas/EquipBreakThroughMaterialIcon", var_6_0.icon)
end

function EquipBreakThroughMaterialBuffStageItem:SelectItem(arg_7_1)
	if self.index_ == arg_7_1 then
		self.controller_:SetSelectedState("1")
	else
		self.controller_:SetSelectedState("0")
	end
end

return EquipBreakThroughMaterialBuffStageItem
