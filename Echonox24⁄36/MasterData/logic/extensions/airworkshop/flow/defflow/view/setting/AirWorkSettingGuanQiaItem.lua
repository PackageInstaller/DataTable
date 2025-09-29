-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/setting/AirWorkSettingGuanQiaItem.lua

module("logic.extensions.airworkshop.flow.defflow.view.setting.AirWorkSettingGuanQiaItem", package.seeall)

local M = class("AirWorkSettingGuanQiaItem")

function M:ctor(container)
	self._go = container.gameObject
	self._txtType = goutil.findChildTextComponent(self._go, "txtTab")
	self._itemGroup = goutil.findChild(self._go, "itemGroup")
	self._itemGo = goutil.findChild(self._go, "itemGroup/tabItem")

	goutil.addChildToParent(self._itemGo, self._itemGroup.transform.parent.gameObject)
	goutil.setActive(self._itemGo, false)
	self:_bindEvents()
end

function M:_bindEvents()
	return
end

function M:_unbindEvents()
	self:removeToggleListener()
end

function M:removeToggleListener()
	for _, toggleComp in pairs(self._toggles or {}) do
		toggleComp:RemoveListener()
	end
end

function M:OnDestroy()
	self:_unbindEvents()

	self._handler = false
end

function M:setHandler(handler)
	self._handler = handler
end

function M:updateData(data)
	self._data = data or {}

	local length = #self._data

	if length == 0 then
		return
	end

	self._txtType.text = self._data[1].co.typeName

	self:removeToggleListener()
	goutil.clearChildren(self._itemGroup)

	self._toggles = {}

	for i, v in ipairs(self._data) do
		local itemGo = goutil.cloneAndSetParent(self._itemGo, self._itemGroup.transform, "item" .. i)

		goutil.setActive(itemGo, true)

		local txtTitle = goutil.findChildTextComponent(itemGo, "imgDi/txtTitle")

		txtTitle.text = v.co.tagName

		local toggle = itemGo:GetComponent(UIComponentType.SpaceXToggle)

		toggle.IsOn = v.isSelect

		table.insert(self._toggles, toggle)
		toggle:AddListener(function(_, isOn)
			self:_toggleClick(i, isOn)
		end, nil)
	end
end

function M:getTagIds()
	local tagIdList = {}

	for i, v in ipairs(self._toggles) do
		if v.IsOn then
			table.insert(tagIdList, self._data[i].co.id)
		end
	end

	return tagIdList
end

function M:_toggleClick(index, isOn)
	if isOn and not self:_canSelect() then
		self._toggles[index].IsOn = false

		FloatWordMgr.instance:show(lang("tip_air_workshop_setting_maxflag"))

		return
	end

	local params = {}

	params.id = self._data[index].co.id
	params.isSelect = isOn

	printWarn("====AirWorkSettingGuanQiaItem index==>", index, isOn, params.id)
	GlobalDispatcher:dispatchEvent(EventType.AIRWORKSHOP_TAG_CHANGE, params)
end

function M:_canSelect()
	local canSelect = false

	if self._handler then
		canSelect = self._handler:checkTagCanSelect()
	end

	return canSelect
end

function M:setAlpha(value)
	for i, v in ipairs(self._toggles) do
		local canvasGroup = goutil.addComponentOnce(v.gameObject, ComponentType.CanvasGroup)

		if not v.IsOn then
			canvasGroup.alpha = value
		end
	end
end

return M
