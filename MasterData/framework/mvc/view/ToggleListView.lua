-- chunkname: @framework/mvc/view/ToggleListView.lua

module("framework.mvc.view.ToggleListView", package.seeall)

local ToggleListView = class("ToggleListView", BaseView)

function ToggleListView:ctor(tabContainerId, toggleGroupPath, toggleChecker, toggleCheckerObj)
	ToggleListView.super.ctor(self)

	self._tabContainerId = tabContainerId
	self._toggleGroupPath = toggleGroupPath
	self._toggleChecker = toggleChecker
	self._toggleCheckerObj = toggleCheckerObj
	self._toggleGroupGO = nil
	self._toggleGroup = nil
	self._toggleDict = {}
	self._tabContainer = nil
end

function ToggleListView:onInitView()
	self._toggleGroupGO = gohelper.findChild(self.viewGO, self._toggleGroupPath)
	self._toggleGroup = self._toggleGroupGO:GetComponent(typeof(UnityEngine.UI.ToggleGroup))

	local toggleGroupTransform = self._toggleGroupGO.transform
	local count = toggleGroupTransform.childCount

	for i = 1, count do
		local childTrs = toggleGroupTransform:GetChild(i - 1)
		local childGO = childTrs.gameObject
		local toggle = childGO:GetComponent(typeof(UnityEngine.UI.Toggle))

		if toggle then
			local toggleWrap = gohelper.onceAddComponent(childGO, typeof(SLFramework.UGUI.ToggleWrap))
			local toggleId = string.getLastNum(toggleWrap.name)

			self._toggleDict[toggleId or i] = toggleWrap
		end
	end
end

function ToggleListView:addEvents()
	if self._toggleChecker then
		for toggleId, toggleWrap in pairs(self._toggleDict) do
			toggleWrap:AddBlockClick(self._onBlockToggle, self, toggleId)
		end
	end
end

function ToggleListView:removeEvents()
	if self._toggleChecker then
		for _, toggleWrap in pairs(self._toggleDict) do
			toggleWrap:RemoveBlockClick()
		end
	end
end

function ToggleListView:onOpen()
	if self.viewParam and self.viewParam.defaultTabIds then
		if not self.viewParam.defaultTabIds[self._tabContainerId] then
			local defaultTabId = 1
			local originAllowSwitchOff = self._toggleGroup.allowSwitchOff

			self._toggleGroup.allowSwitchOff = true

			for toggleId, toggleWrap in pairs(self._toggleDict) do
				toggleWrap:AddOnValueChanged(self._onToggleValueChanged, self, toggleId)

				toggleWrap.isOn = toggleId == defaultTabId
			end

			self._toggleGroup.allowSwitchOff = originAllowSwitchOff
		end
	end
end

function ToggleListView:onClose()
	for _, toggleWrap in pairs(self._toggleDict) do
		toggleWrap:RemoveOnValueChanged()
	end
end

function ToggleListView:onDestroyView()
	self._toggleGroupPath = nil
	self._toggleGroupGO = nil
	self._toggleGroup = nil
	self._toggleDict = nil
end

function ToggleListView:_onBlockToggle(toggleId)
	if self._toggleChecker and (self._toggleCheckerObj and self._toggleChecker(self._toggleCheckerObj, toggleId) or not self._toggleCheckerObj and not self._toggleChecker(toggleId)) then
		self._toggleDict[toggleId]:TriggerClick()
	end
end

function ToggleListView:_onToggleValueChanged(toggleId, isOn)
	if isOn then
		self.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, self._tabContainerId, toggleId)
	end
end

return ToggleListView
