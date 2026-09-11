local StoreEquipFilterPanel = class("StoreEquipFilterPanel", ReduxView)

function StoreEquipFilterPanel:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:InitDropDown()
	self:AddListeners()

	self.sortController_ = self.sortControllerEx_:GetController("sort")
	self.colorController_ = self.filterControllerEx_:GetController("color")
end

function StoreEquipFilterPanel:InitDropDown()
	self.sortDropdown_.options:Clear()
	self.sortDropdown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("TIP_UPGRADE"), nil))
	self.sortDropdown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("AUTO_CHESS_2_HISTORY_TIP2"), nil))
	self.sortDropdown_:RefreshShownValue()
end

function StoreEquipFilterPanel:Dispose()
	StoreEquipFilterPanel.super.Dispose(self)
end

function StoreEquipFilterPanel:AddListeners()
	self:AddBtnListener(self.decomposeBtn_, nil, function()
		JumpTools.GoToSystem("/equipDecompose", {}, ViewConst.SYSTEM_ID.BAG)
	end)
	self:AddBtnListener(self.filterBtn_, nil, function()
		self:Go("equipFilter", {
			filterParams = self.filterParams_,
			equipPosition = self.equipPosition_
		})
	end)
	self:AddBtnListener(self.sortBtn_, nil, function()
		manager.notify:Invoke(SWITCH_SORT)
	end)
	self:AddToggleListener(self.sortDropdown_, function(arg_8_0)
		manager.notify:Invoke(SWITCH_SORT_RARE, arg_8_0)
	end)
end

function StoreEquipFilterPanel:RefreshUI(arg_9_1, arg_9_2)
	self.filterParams_ = arg_9_1
	self.equipPosition_ = arg_9_2
	self.cntText_.text = string.format("%d/%d", EquipTools.GetEquipNum(), GameSetting.max_equip.value[1])

	if arg_9_1.order == ItemConst.SORT_TYPE.DOWN then
		self.sortController_:SetSelectedState("down")
	else
		self.sortController_:SetSelectedState("up")
	end

	if #arg_9_1.suit > 0 or #arg_9_1.skill > 0 then
		self.colorController_:SetSelectedState("orange")
	else
		self.colorController_:SetSelectedState("normal")
	end
end

return StoreEquipFilterPanel
