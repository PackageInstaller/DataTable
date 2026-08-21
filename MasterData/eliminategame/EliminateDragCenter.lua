-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/EliminateGame\\EliminateDragCenter.lua

local UIUtils = require("Framework.UI.UIUtils")
local EliminateModelCenter = require("EliminateGame/EliminateModelCenter")
local SceneLightManager = UnityEngine.PostProcessing.SceneLightManager
local EliminateDragCenter = {}
local DEFAULT_ZONE_NAME = "Wall1"
local MODE = {
	EDIT = 1
}
local CONFIG = {
	miniGamePlayDlg = MODE.EDIT
}
local self = EliminateDragCenter

self.inited = false

function EliminateDragCenter.start(state)
	EliminateModelCenter.init(self)

	self.zones = {}
	self.zoneMap = {}
	self.curMode = {}
	self.isDragingObj = false
	self.MODE = MODE
	self.curWallName = DEFAULT_ZONE_NAME
	self.effectIds = {}
	self.mainState = state

	for i = 1, Const.REARHOUSE_WALL_NUM do
		self.zoneMap["Wall" .. i] = i
	end

	self.inited = true
end

function EliminateDragCenter.getCurWallBoundsInfo(...)
	if self.curWallName and self.zones and next(self.zones) ~= nil then
		return self.zones[self.curWallName].bounds
	end
end

function EliminateDragCenter.getCurShowData(...)
	return EliminateModelCenter.getCurShowData()
end

function EliminateDragCenter.getCurWallName(...)
	return self.curWallName or DEFAULT_ZONE_NAME
end

function EliminateDragCenter.getZoneId(zoneName)
	return self.zoneMap[zoneName] or 1
end

function EliminateDragCenter.getZoneName(zoneId)
	for name, id in pairs(self.zoneMap or {}) do
		if id == zoneId then
			return name
		end
	end

	return DEFAULT_ZONE_NAME
end

function EliminateDragCenter.initWallData(index)
	local wallName = "Wall1"
	local wallClassName = "EliminateDragWall"
	local _class = require("EliminateGame/" .. wallClassName)

	self.zones[wallName] = _class(self, self.mainState, wallName, index)
end

function EliminateDragCenter:getZone()
	return self.zones[self.curWallName]
end

function EliminateDragCenter.getCurWallName(...)
	return self.curWallName or DEFAULT_ZONE_NAME
end

function EliminateDragCenter.getCurZone(...)
	if self.zones then
		return self.zones[self.curWallName]
	end
end

function EliminateDragCenter.dataReady(...)
	self.initData()
end

function EliminateDragCenter.setMode(ui)
	self.curMode.mode = CONFIG[ui.mUIName]
	self.curMode.ui = ui

	if ui.panelBg then
		ui.panelBg:setClickFunc(self.onClick)
	end

	SceneLightManager.EnableMainLightShadow(false)
end

function EliminateDragCenter.leaveMode()
	self.showBack(false)
end

function EliminateDragCenter.showBack(v)
	if self.inited == false then
		return
	end

	self.getCurZone():showBack(v)
end

function EliminateDragCenter.initData(data)
	EliminateModelCenter.dataReady()
	self.mainState:initWall(1)
	self.mainState:checkMainDlg()
end

function EliminateDragCenter.initWall()
	if next(self.zones) then
		UIUtils.StopRearHouseDrag()
	end

	for name, zone in pairs(self.zones) do
		zone:destroy()
	end

	self.zones = {}

	self.initWallData()
	EliminateModelCenter.initWall()
end

function EliminateDragCenter.createWhenEnterNextLevel()
	return EliminateModelCenter.createWhenLoadend()
end

function EliminateDragCenter.setCurDragObj(obj)
	self.curDragObj = obj
end

function EliminateDragCenter.changeEventState(name, x, y)
	UIUtils.RearHouseChangeState(name, x or 0, y or 0)
end

function EliminateDragCenter.createWhenLoadend(...)
	EliminateModelCenter.createWhenLoadend()
end

function EliminateDragCenter.showWarning(show, content)
	if self.curMode.mode == MODE.EDIT then
		self.curMode.ui:showWarning(show, content)
	end
end

function EliminateDragCenter.getShelfNum()
	return EliminateModelCenter.getShelfNum()
end

function EliminateDragCenter.getShelfSize()
	return EliminateModelCenter.getShelfSize()
end

function EliminateDragCenter.getHeroOffsetY()
	return EliminateModelCenter.getHeroOffsetY()
end

function EliminateDragCenter.getWallNode()
	return EliminateModelCenter.getWallNode()
end

function EliminateDragCenter.getPreAndEndAvgId()
	return EliminateModelCenter.getPreAndEndAvgId()
end

function EliminateDragCenter.getShelfFinishCueId()
	return EliminateModelCenter.getShelfFinishCueId()
end

function EliminateDragCenter.resetLevel()
	EliminateModelCenter.delAllObj()
	EliminateModelCenter.createWhenLoadend()
end

function EliminateDragCenter.leaveLevel()
	EliminateModelCenter.delAllObj()
end

function EliminateDragCenter.getPutPos(index, layer)
	return self.zones[self.curWallName]:getPutPos(index, layer)
end

function EliminateDragCenter.onDrag(delta)
	return
end

function EliminateDragCenter.onClick(...)
	self.clickObj = false

	self.changeEventState("click")
end

function EliminateDragCenter.onDragBegin(vec)
	self.changeEventState("dragBegin", vec.x, vec.y)
end

function EliminateDragCenter.onDragEnd(delta)
	self.changeEventState("dragEnd")

	if self.isDragingObj and self.curDragObj then
		self.curDragObj:onDragPut(false)
	end

	self.isDragingObj = false
end

function EliminateDragCenter.onTouchEnd(...)
	return
end

function EliminateDragCenter.onLongPress(...)
	self.onClick()
end

function EliminateDragCenter.isLoadFinish(...)
	if not self.inited then
		return false
	end

	if self.curWallName then
		local zone = self.zones[self.curWallName]

		return zone.inited == true
	end

	return false
end

function EliminateDragCenter.destroy(...)
	for name, zone in pairs(self.zones or {}) do
		zone:destroy()
	end

	self.zones = nil

	if self.reflectPlane then
		self.reflectPlane = nil
	end

	self.inited = false
	self.curMode = nil
	self.curDragObj = nil
	self.mainState = nil

	EliminateModelCenter.destroy()
	UIUtils.StopRearHouseDrag()
end

return EliminateDragCenter
