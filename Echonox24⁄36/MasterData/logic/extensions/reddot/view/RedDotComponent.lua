-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/reddot/view/RedDotComponent.lua

module("logic.extensions.reddot.view.RedDotComponent", package.seeall)

local M = class("RedDotComponent")

function M:ctor(compContainer)
	self._viewNode = compContainer.gameObject
	self._keyMap = {}
	self._parentKeyMap = {}
	self._rejectMap = {}
	self._redDotCount = 0
	self._redDotNumNode = goutil.findChildTextComponent(self:getViewNode(), "type2/txtNum")
end

function M:Awake()
	GlobalDispatcher:addEventListener(EventType.RED_DOT_VIEW_EVENT, self.onEvent, self)
	GlobalDispatcher:addEventListener(EventType.RED_DOT_RESET, self.onReset, self)
end

function M:OnDestroy()
	GlobalDispatcher:removeEventListener(EventType.RED_DOT_VIEW_EVENT, self.onEvent, self)
	GlobalDispatcher:removeEventListener(EventType.RED_DOT_RESET, self.onReset, self)
end

function M:setViewNode(viewNode)
	self._viewNode = viewNode
end

function M:getViewNode()
	return self._viewNode
end

function M:onReset(e)
	self._redDotCount = 0

	self:_setActive(false)
end

function M:onEvent(e, redDotData)
	if redDotData then
		local isUpdate = false
		local changeKey = redDotData.key

		if redDotData.parentKey then
			if self._keyMap[redDotData.key] and not redDotData.isParentChange then
				isUpdate = true
			elseif self._keyMap[redDotData.parentKey] then
				isUpdate = true
				changeKey = redDotData.parentKey
			end
		elseif self._keyMap[redDotData.key] then
			isUpdate = self._keyMap[redDotData.key]
		end

		if isUpdate then
			self:_dealRedDotCount(self:_dealRedOffsetValue(redDotData.isActive))
			self:_updateDotView()
		elseif self._rejectMap[redDotData.key] then
			self:_updateDotView()
		end
	end
end

function M:_setActive(isActive)
	goutil.setActive(self._viewNode, isActive)

	if isActive and not goutil.isNil(self._redDotNumNode) then
		self._redDotNumNode.text = self._redDotCount
	end
end

function M:_dealRedOffsetValue(isActive)
	return isActive and 1 or -1
end

function M:_dealRedDotCount(offsetValue)
	self._redDotCount = self._redDotCount + offsetValue
	self._redDotCount = self._redDotCount < 0 and 0 or self._redDotCount
end

function M:_updateDotView()
	local isRejectActive = false

	for k, v in pairs(self._rejectMap) do
		isRejectActive = RedDotModel.instance:getDotIsActive(k)

		if isRejectActive then
			break
		end
	end

	self:_setActive(self._redDotCount > 0 and not isRejectActive)
end

function M:_keyMapInit(keyMap, keyList)
	for k, v in pairs(keyList or {}) do
		keyMap[v] = true
	end
end

function M:updateKeyMap(keyList, parentKeyList, rejectKeyList)
	self._keyMap = {}
	self._parentKeyMap = {}
	self._rejectMap = {}
	self._redDotCount = 0

	self:_keyMapInit(self._keyMap, keyList)
	self:_keyMapInit(self._parentKeyMap, parentKeyList)
	self:_keyMapInit(self._rejectMap, rejectKeyList)
end

function M:updateRedDot(keyList, parentKeyList, rejectKeyList)
	self._redDotCount = 0

	if keyList or parentKeyList then
		self:updateKeyMap(keyList, parentKeyList, rejectKeyList)
	end

	for k, v in pairs(keyList or {}) do
		local isParentActive, num = RedDotModel.instance:getDotIsActiveByParentKey(v, true)

		if isParentActive then
			self:_dealRedDotCount(num)
		elseif RedDotModel.instance:getDotIsActive(v) then
			self:_dealRedDotCount(1)
		end
	end

	self:_updateDotView()
end

return M
