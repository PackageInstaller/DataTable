local EquipBreakThroughMaterialMapInfoBtn = class("EquipBreakThroughMaterialMapInfoBtn", ReduxView)

function EquipBreakThroughMaterialMapInfoBtn:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.toggleType_ = arg_1_2

	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "toggle")
	self.selectToggleHandler_ = handler(self, self.RefreshToggle)
end

function EquipBreakThroughMaterialMapInfoBtn:OnEnter(arg_2_1)
	self:RefreshToggle(arg_2_1)
	manager.notify:RegistListener(EQUIP_BREAK_THROUGH_SELECT_TOGGLE, self.selectToggleHandler_)
end

function EquipBreakThroughMaterialMapInfoBtn:OnExit()
	manager.notify:RemoveListener(EQUIP_BREAK_THROUGH_SELECT_TOGGLE, self.selectToggleHandler_)
end

function EquipBreakThroughMaterialMapInfoBtn:Dispose()
	EquipBreakThroughMaterialMapInfoBtn.super.Dispose(self)

	self.selectToggleHandler_ = nil
end

function EquipBreakThroughMaterialMapInfoBtn:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		manager.notify:Invoke(EQUIP_BREAK_THROUGH_SELECT_TOGGLE, self.toggleType_)
	end)
end

function EquipBreakThroughMaterialMapInfoBtn:RefreshToggle(arg_7_1)
	if self.toggleType_ == arg_7_1 then
		self.controller_:SetSelectedState("on")
	else
		self.controller_:SetSelectedState("off")
	end
end

return EquipBreakThroughMaterialMapInfoBtn
