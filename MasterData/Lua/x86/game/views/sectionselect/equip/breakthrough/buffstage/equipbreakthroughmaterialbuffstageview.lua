local EquipBreakThroughMaterialBullStageView = class("EquipBreakThroughMaterialBullStageView", ReduxView)

function EquipBreakThroughMaterialBullStageView:UIName()
	return "UI/Stage/EquipBreakThroughMaterial/EquipChapterMapProcessUI"
end

function EquipBreakThroughMaterialBullStageView:UIParent()
	return manager.ui.uiPop.transform
end

function EquipBreakThroughMaterialBullStageView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.buffList_ = LuaList.New(handler(self, self.RefreshItem), self.buffUIList_, EquipBreakThroughMaterialBuffStageItem)
	self.okBtnController_ = ControllerUtil.GetController(self.okBtnTf_, "name")
	self.selectHandler_ = handler(self, self.SelectItem)
end

function EquipBreakThroughMaterialBullStageView:OnEnter()
	self.okBtnController_:SetSelectedState("false")

	self.selectIndex_ = nil
	self.mapStageID_ = self.params_.mapStageID
	self.cancelText_.text = string.format(GetTips("EQUIP_BREAK_THROUGH_BUFF_HEAL"), GameSetting.equip_crossroads_buff_healing.value[1])

	manager.notify:RegistListener(EQUIP_BREAK_THROUGH_SELECT_BUFF, self.selectHandler_)
	self.buffList_:StartScroll(#EquipBreakThroughMaterialData:GetStageData()[self.mapStageID_].buffList)
end

function EquipBreakThroughMaterialBullStageView:OnExit()
	manager.notify:RemoveListener(EQUIP_BREAK_THROUGH_SELECT_BUFF, self.selectHandler_)
end

function EquipBreakThroughMaterialBullStageView:Dispose()
	EquipBreakThroughMaterialBullStageView.super.Dispose(self)

	self.selectHandler_ = nil

	self.buffList_:Dispose()

	self.buffList_ = nil
end

function EquipBreakThroughMaterialBullStageView:AddListeners()
	self:AddBtnListener(self.okBtn_, nil, function()
		if self.selectIndex_ == nil then
			return
		end

		EquipBreakThroughMaterialAction.ChooseBuff(self.mapStageID_, EquipBreakThroughMaterialData:GetStageData()[self.mapStageID_].buffList[self.selectIndex_], function(arg_9_0)
			if isSuccess(arg_9_0.result) then
				self:Back()
				manager.notify:Invoke(EQUIP_BREAK_THROUGH_MATERIAL_STAGE_UPDATE)
			end
		end)
	end)
	self:AddBtnListener(self.cancelBtn_, nil, function()
		EquipBreakThroughMaterialAction.ChooseBuff(self.mapStageID_, 0, function(arg_11_0)
			if isSuccess(arg_11_0.result) then
				self:Back()
				manager.notify:Invoke(EQUIP_BREAK_THROUGH_MATERIAL_STAGE_UPDATE)
				ShowTips(string.format(GetTips("EQUIP_BREAK_THROUGH_TEAM_HEAL"), GameSetting.equip_crossroads_buff_healing.value[1]))
			end
		end)
	end)
end

function EquipBreakThroughMaterialBullStageView:RefreshItem(arg_12_1, arg_12_2)
	arg_12_2:SetData(arg_12_1, self.mapStageID_, self.selectIndex_)
end

function EquipBreakThroughMaterialBullStageView:SelectItem(arg_13_1)
	self.okBtnController_:SetSelectedState("true")

	self.selectIndex_ = arg_13_1
end

return EquipBreakThroughMaterialBullStageView
