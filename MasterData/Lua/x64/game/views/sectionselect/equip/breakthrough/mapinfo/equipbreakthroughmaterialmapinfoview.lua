local EquipBreakThroughMaterialMapInfoView = class("EquipBreakThroughMaterialMapInfoView", ReduxView)

function EquipBreakThroughMaterialMapInfoView:UIName()
	return "UI/Stage/EquipBreakThroughMaterial/EquipChapterMapDetailsPop"
end

function EquipBreakThroughMaterialMapInfoView:UIParent()
	return manager.ui.uiMain.transform
end

function EquipBreakThroughMaterialMapInfoView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "name")
	self.toggleItemList_ = {
		EquipBreakThroughMaterialMapInfoBtn.New(self.teamInfoGo_, EquipBreakThroughMaterialConst.TOGGLE_TYPE.TEAM),
		EquipBreakThroughMaterialMapInfoBtn.New(self.buffGo_, EquipBreakThroughMaterialConst.TOGGLE_TYPE.BUFF)
	}
	self.selectToggleHandler_ = handler(self, self.RefreshToggle)
	self.teamInfoView_ = EquipBreakThroughMaterialTeamInfoView.New(self.teamContentGo_)
	self.buffView_ = EquipBreakThroughMaterialBuffView.New(self.buffContentGo_)
end

function EquipBreakThroughMaterialMapInfoView:OnEnter()
	self.toggleType_ = self.params_.toggleType

	for iter_4_0, iter_4_1 in ipairs(self.toggleItemList_) do
		iter_4_1:OnEnter(self.toggleType_)
	end

	manager.notify:RegistListener(EQUIP_BREAK_THROUGH_SELECT_TOGGLE, self.selectToggleHandler_)
	self:RefreshToggle(self.toggleType_)
	self.teamInfoView_:OnEnter()
	self.buffView_:OnEnter()
end

function EquipBreakThroughMaterialMapInfoView:OnExit()
	for iter_5_0, iter_5_1 in ipairs(self.toggleItemList_) do
		iter_5_1:OnExit()
	end

	manager.notify:RemoveListener(EQUIP_BREAK_THROUGH_SELECT_TOGGLE, self.selectToggleHandler_)
	self.teamInfoView_:OnExit()
	self.buffView_:OnExit()
end

function EquipBreakThroughMaterialMapInfoView:Dispose()
	EquipBreakThroughMaterialMapInfoView.super.Dispose(self)

	for iter_6_0, iter_6_1 in ipairs(self.toggleItemList_) do
		iter_6_1:Dispose()
	end

	self.toggleItemList_ = nil
	self.selectToggleHandler_ = nil

	self.teamInfoView_:Dispose()

	self.teamInfoView_ = nil

	self.buffView_:Dispose()

	self.buffView_ = nil
end

function EquipBreakThroughMaterialMapInfoView:AddListeners()
	return
end

function EquipBreakThroughMaterialMapInfoView:RefreshToggle(arg_8_1)
	if arg_8_1 == EquipBreakThroughMaterialConst.TOGGLE_TYPE.BUFF then
		self.controller_:SetSelectedState("buff")
	else
		self.controller_:SetSelectedState("team")
	end
end

return EquipBreakThroughMaterialMapInfoView
