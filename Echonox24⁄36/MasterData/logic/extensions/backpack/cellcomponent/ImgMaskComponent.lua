-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cellcomponent/ImgMaskComponent.lua

module("logic.extensions.backpack.cellcomponent.ImgMaskComponent", package.seeall)

local M = class("ImgMaskComponent", CellBaseComponent)

function M:onInit()
	local registry = self._cell:getViewElementsRegistry()

	self._imgMaskGo = registry:findUIElement("backpack_item_1646665409")
end

function M:setVisible(visible)
	self._imgMaskGo:SetActive(visible)
end

return M
