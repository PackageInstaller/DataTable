-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/view/common/RoomOrderItem.lua

module("logic.extensions.house.view.common.RoomOrderItem", package.seeall)

local M = class("RoomOrderItem")

function M:ctor(compContainer)
	self._mainGO = compContainer.gameObject

	self:_buildUI()
end

function M:OnDestroy()
	self:unbindEvents()
end

function M:_buildUI()
	self._imgIcon = goutil.findChildImageComponent(self._mainGO, "normal/icon")
	self._txtName = goutil.findChildTextComponent(self._mainGO, "txtName")

	self:bindEvents()
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:getMainGO()
	return self._mainGO
end

function M:setVisible(visible)
	goutil.setActive(self._mainGO, visible)
end

function M:setIcon(iconType, iconName)
	if iconType and iconName then
		IconLoader.setSprite(self._imgIcon, iconType, iconName)
	end
end

function M:setName(nameStr)
	self._txtName.text = nameStr or ""
end

function M:setNameColor(colorStr)
	if not string.nilorempty(colorStr) then
		self._txtName.color = parsecolor(colorStr)
	end
end

return M
