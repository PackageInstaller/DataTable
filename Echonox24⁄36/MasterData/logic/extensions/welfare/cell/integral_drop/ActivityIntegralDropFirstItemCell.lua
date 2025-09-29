-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/cell/integral_drop/ActivityIntegralDropFirstItemCell.lua

module("logic.extensions.welfare.cell.integral_drop.ActivityIntegralDropFirstItemCell", package.seeall)

local M = class("ActivityIntegralDropFirstItemCell", ActivityIntegralDropItemCell)

function M:buildUI()
	self._registry = ViewElementsRegistry.New(self.mainGO)
	self._normalSlideObj = self._registry:findUIElement("item1_-2107585052")
	self._normalSlideImage = self._registry:findUIElement("item1_236288413", UIComponentType.Image)
	self._goMarkReach = self._registry:findUIElement("item1_1946780976")
	self._txtNumRech = goutil.findChildTextComponent(self._goMarkReach, "txtNum")
	self._goMarkUnReach = self._registry:findUIElement("item1_156839966")
	self._txtNumUnRech = goutil.findChildTextComponent(self._goMarkUnReach, "txtNum")
end

return M
