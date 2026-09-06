-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/AtkEnemyItem.lua

module("logic.extensions.mission.view.AtkEnemyItem", package.seeall)

local AtkEnemyItem = class("AtkEnemyItem")

function AtkEnemyItem:ctor()
	return
end

function AtkEnemyItem:init(parentGo, srcPrefab)
	local go = goutil.cloneAndSetParent(srcPrefab, parentGo.transform, srcPrefab.name)

	self._go = go
	self._node = goutil.findChild(go, "node")

	goutil.setActive(go, false)
end

function AtkEnemyItem:setIsOpen(isOpen)
	goutil.setActive(self._go, isOpen)
end

function AtkEnemyItem:destroy()
	goutil.destroy(self._go)

	self._go = nil
	self._node = nil
end

return AtkEnemyItem
