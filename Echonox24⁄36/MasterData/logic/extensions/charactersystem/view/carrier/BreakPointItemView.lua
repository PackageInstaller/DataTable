-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/carrier/BreakPointItemView.lua

module("logic.extensions.charactersystem.view.carrier.BreakPointItemView", package.seeall)

local M = class("BreakPointItemView")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self._mainGo)

	self:_buildUI()
end

function M:_buildUI()
	self._breakImageList = {}

	table.insert(self._breakImageList, self._registry:findUIElement("break_point_776479048"))
	table.insert(self._breakImageList, self._registry:findUIElement("break_point_538017231"))
	table.insert(self._breakImageList, self._registry:findUIElement("break_point_111437492"))
	table.insert(self._breakImageList, self._registry:findUIElement("break_point_-1291026629"))
	table.insert(self._breakImageList, self._registry:findUIElement("break_point_23271056"))
end

function M:OnDestroy()
	self:_destroyUI()
end

function M:_destroyUI()
	self._breakImageList = false
end

function M:setRankView(rankLevel)
	for i, breakImage in ipairs(self._breakImageList) do
		goutil.setActive(breakImage, i <= rankLevel)
	end
end

function M:setVisible(visible)
	self._mainGo:SetActive(visible)
end

return M
