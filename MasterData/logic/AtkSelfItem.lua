-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/AtkSelfItem.lua

module("logic.extensions.mission.view.AtkSelfItem", package.seeall)

local AtkSelfItem = class("AtkSelfItem")

function AtkSelfItem:ctor()
	return
end

function AtkSelfItem:init(parentGo, srcPrefab)
	local go = goutil.cloneAndSetParent(srcPrefab, parentGo.transform, srcPrefab.name)

	self._go = go
	self._node = goutil.findChild(go, "node")

	goutil.setActive(go, false)
end

function AtkSelfItem:setIsOpen(isOpen)
	goutil.setActive(self._go, isOpen)
end

function AtkSelfItem:destroy()
	goutil.destroy(self._go)

	self._go = nil
	self._node = nil
end

return AtkSelfItem
