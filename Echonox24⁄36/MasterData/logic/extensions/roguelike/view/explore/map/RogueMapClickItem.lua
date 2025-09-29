-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/map/RogueMapClickItem.lua

module("logic.extensions.roguelike.view.explore.map.RogueMapClickItem", package.seeall)

local M = class("RogueMapClickItem")
local kMapItemSize = 102

function M:ctor(container)
	local go = container.gameObject

	self._go = go
	self._btnClick = UIComponentType.ButtonAdapter(go)

	self:bindEvents()
end

function M:getGo()
	return self._go
end

function M:bindEvents()
	if self._isBind then
		return
	end

	self._btnClick:AddClickListener(self.onClick, self)

	self._isBind = true
end

function M:unbindEvents()
	self._isBind = false

	self._btnClick:RemoveClickListener()
end

function M:onClick()
	if self._callback then
		self._callback()
	end
end

function M:setPointItem(pointItem)
	self._point = pointItem
end

function M:updateData(data)
	self._callback = data.callback

	local coordinate = data.coordinate
	local tra = self._go.transform
	local pos = Vector3.New((coordinate[1] + data.offset) * kMapItemSize, coordinate[2] * -kMapItemSize + 100, 0)

	tra.localPosition = pos

	local pointData = {}

	pointData.isFinish = data.isFinish
	pointData.icon = data.icon
	pointData.mo = data.mo

	self._point:updateData(pointData)

	self._go.name = string.format("%d %d-%d", data.mapId, coordinate[1], coordinate[2])

	goutil.setActive(self._go, data.visible)
end

function M:onClear()
	return
end

return M
