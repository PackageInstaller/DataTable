local GvgMapWorld = require("app.view.module.gvg.view.gvgMap.GvgMapWorld")
local GvgMapComp = class("GvgMapComp", require("app.fairyGUI.gvg.UI_GvgMapComp"))

function GvgMapComp:ctor()
	self._data = nil

	self:_initTiledMap()
end

function GvgMapComp:_initTiledMap()
	self._mapWorld = GvgMapWorld.new(self)

	self._mapWorld:startObserver(self.m_touchMap)
	self.m_tiledHolder:addNode(self._mapWorld)
	self.m_operateComp:setTouchable(false)
end

function GvgMapComp:updateView(arg_3_1)
	self._data = arg_3_1
end

function GvgMapComp:updateFloorCompPos(arg_4_1, arg_4_2)
	self.m_floorComp:setPosition(arg_4_1, arg_4_2)
	self.m_floorComp:updateCurPos(arg_4_1, arg_4_2)
	self.m_operateComp:setPosition(arg_4_1, arg_4_2)
	self._mapWorld:checkAndLoadParts(self:getCenterPos())
end

function GvgMapComp:getCenterPos()
	return
end

return GvgMapComp
