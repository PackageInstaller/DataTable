-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/view/gm/HouseGMBehaviorItem.lua

module("logic.extensions.house.view.gm.HouseGMBehaviorItem", package.seeall)

local M = class("HouseGMBehaviorItem")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGO = self._compContainer.gameObject

	self:buildUI()
	self:bindEvents()
end

function M:destroy()
	self:unbindEvents()

	self._behaviorType = false
	self._handler = false
end

function M:buildUI()
	self._toggle = self._mainGO:GetComponent(UIComponentType.SpaceXToggle)
	self._txtNormal = goutil.findChildTextComponent(self._mainGO, "normal/Text")
	self._txtSelected = goutil.findChildTextComponent(self._mainGO, "select/Text")
end

function M:bindEvents()
	self._toggle:AddListener(self._onToggle, self)
end

function M:unbindEvents()
	self._toggle:RemoveListener()
end

function M:setSelected(selected)
	self._toggle.IsOn = selected
end

function M:setBehaviorType(behavior)
	self._behaviorType = behavior

	local behaviorStr = HouseEnum.BehaviorType2Text[behavior]

	self._txtNormal.text = behaviorStr
	self._txtSelected.text = behaviorStr
end

function M:setHandler(handler)
	self._handler = handler
end

function M:_onToggle(toggle, isOn)
	self._handler:changeBehavior(self._behaviorType, isOn)
end

return M
