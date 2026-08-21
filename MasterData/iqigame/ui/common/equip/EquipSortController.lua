-- chunkname: @IQIGame\\UI\\Common\\Equip\\EquipSortController.lua

local EquipScreenData = require("IQIGame/UI/Common/Equip/EquipScreenData")
local CommonSortingPopupListView = require("IQIGame.UI.Common.CommonSortingPopupListView")
local EquipScreenPopupPanel = require("IQIGame/UI/Common/Equip/EquipScreenPopupPanel")
local controller = {
	SortType = 1
}

function controller.New(view, callback)
	local obj = Clone(controller)

	obj:__Init(view, callback)

	return obj
end

function controller:__Init(view, callback)
	self.view = view

	LuaCodeInterface.BindOutlet(self.view, self)

	self.OnValueChangeEvent = callback
	self.ScreenData = EquipScreenData.New()

	function self.__OnShowScreenBtnClickEventProxy()
		self.screenPopupPanel:Show(self.ScreenData)
	end

	self.btn:GetComponent("Button").onClick:AddListener(self.__OnShowScreenBtnClickEventProxy)

	self.sortPopupList = CommonSortingPopupListView.New(self.sortPopup, function(_index)
		self:__OnSortingTypeChange(_index)
	end)

	self.sortPopupList:SetData(CommonSortingPopupListView.GetEquipSortingData(), 1, false)

	self.screenPopupPanel = EquipScreenPopupPanel.New(self.screenPopup, function(_screenData)
		self:__OnEquipScreenChange(_screenData)
	end)

	self.screenPopupPanel:Hide()
end

function controller:Show(sortType, screenData, isNotice)
	self.ScreenData = screenData == nil and EquipScreenData.New() or screenData

	self.screenPopupPanel:Hide()
	self.sortPopupList:ChangeSelect(sortType, isNotice)
end

function controller:Dispose()
	self.btn:GetComponent("Button").onClick:RemoveListener(self.__OnShowScreenBtnClickEventProxy)
	self.sortPopupList:Dispose()
	self.screenPopupPanel:Dispose()
	LuaCodeInterface.ClearOutlet(self.view, self)

	self.view = nil
end

function controller:__OnSortingTypeChange(type)
	self.SortType = type

	if self.OnValueChangeEvent ~= nil then
		self.OnValueChangeEvent(true)
	end
end

function controller:__OnEquipScreenChange(screenData)
	self.ScreenData = screenData

	if self.OnValueChangeEvent ~= nil then
		self.OnValueChangeEvent(false)
	end
end

return controller
