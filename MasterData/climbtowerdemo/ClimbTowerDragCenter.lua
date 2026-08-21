-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClimbTowerDemo\\ClimbTowerDragCenter.lua

local UIUtils = require("Framework.UI.UIUtils")
local ClimbTowerModelCenter = require("ClimbTowerDemo/ClimbTowerModelCenter")
local SceneLightManager = UnityEngine.PostProcessing.SceneLightManager
local ClimbTowerDragCenter = {}
local DEFAULT_ZONE_NAME = "Wall1"
local MODE = {
	EDIT = 1
}
local CONFIG = {
	climbTowerEditDlg = MODE.EDIT
}
local self = ClimbTowerDragCenter

self.inited = false

function ClimbTowerDragCenter.start(state)
	ClimbTowerModelCenter.init(self)

	self.zones = {}
	self.zoneMap = {}
	self.curMode = {}
	self.clickObj = false
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

function ClimbTowerDragCenter.getCurWallBoundsInfo(...)
	if self.curWallName and self.zones and next(self.zones) ~= nil then
		return self.zones[self.curWallName].bounds
	end
end

function ClimbTowerDragCenter.getCurShowData(...)
	return ClimbTowerModelCenter.getCurShowData()
end

function ClimbTowerDragCenter.getCurWallName(...)
	return self.curWallName or DEFAULT_ZONE_NAME
end

function ClimbTowerDragCenter.getZoneId(zoneName)
	return self.zoneMap[zoneName] or 1
end

function ClimbTowerDragCenter.getZoneName(zoneId)
	for name, id in pairs(self.zoneMap or {}) do
		if id == zoneId then
			return name
		end
	end

	return DEFAULT_ZONE_NAME
end

function ClimbTowerDragCenter.initWallData(index)
	local wallName = "Wall1"
	local wallClassName = "ClimbTowerDragWall"
	local _class = require("ClimbTowerDemo/" .. wallClassName)

	self.zones[wallName] = _class(self, self.mainState, wallName, index)
end

function ClimbTowerDragCenter:getZone()
	return self.zones[self.curWallName]
end

function ClimbTowerDragCenter.getCurWallName(...)
	return self.curWallName or DEFAULT_ZONE_NAME
end

function ClimbTowerDragCenter.getCurZone(...)
	if self.zones then
		return self.zones[self.curWallName]
	end
end

function ClimbTowerDragCenter.dataReady(...)
	self.initData()
end

function ClimbTowerDragCenter.setMode(ui)
	self.curMode.mode = CONFIG[ui.mUIName]
	self.curMode.ui = ui

	if ui.panelBg then
		ui.panelBg:setDragFunc(self.onDrag)
		ui.panelBg:setClickFunc(self.onClick)
		ui.panelBg:setDragBeginFunc(self.onDragBegin)
		ui.panelBg:setDragEndFunc(self.onDragEnd)
		ui.panelBg:setPinchFunc(self.onPinch)
		ui.panelBg:setLongPressFunc(self.onLongPress)
		ui.panelBg:setTouchEndFunc(self.onTouchEnd)
	end

	SceneLightManager.EnableMainLightShadow(false)
end

function ClimbTowerDragCenter.showBack(v)
	if self.inited == false then
		return
	end

	self.getCurZone():showBack(v)
end

function ClimbTowerDragCenter.initData(data)
	ClimbTowerModelCenter.dataReady()
	self.mainState:initWall(1)
	self.mainState:checkMainDlg()
end

function ClimbTowerDragCenter.initWall()
	if next(self.zones) then
		UIUtils.StopRearHouseDrag()
	end

	for name, zone in pairs(self.zones) do
		zone:destroy()
	end

	self.zones = {}

	self.initWallData()
	ClimbTowerModelCenter.initWall()
end

function ClimbTowerDragCenter.getHeroRowAndColOffSet()
	return ClimbTowerModelCenter.getHeroRowAndColOffSet()
end

function ClimbTowerDragCenter.getTowerHeight()
	return ClimbTowerModelCenter.getTowerHeight()
end

function ClimbTowerDragCenter.getWallNode()
	return ClimbTowerModelCenter.getWallNode()
end

function ClimbTowerDragCenter.createWhenEnterNextLevel()
	return ClimbTowerModelCenter.createWhenLoadend()
end

function ClimbTowerDragCenter.getCameraMoveSpace()
	return ClimbTowerModelCenter.getCameraMoveSpace()
end

function ClimbTowerDragCenter.getPreAndEndAvgId()
	return ClimbTowerModelCenter.getPreAndEndAvgId()
end

function ClimbTowerDragCenter.getPutPos(towerIndex, layer)
	return self.zones[self.curWallName]:getPutPos(towerIndex, layer)
end

function ClimbTowerDragCenter.setCurDragObj(obj)
	if obj == nil then
		return
	end

	self.curDragObj = obj
end

function ClimbTowerDragCenter.changeEventState(name, x, y)
	UIUtils.RearHouseChangeState(name, x or 0, y or 0)
end

function ClimbTowerDragCenter.createWhenLoadend(...)
	ClimbTowerModelCenter.createWhenLoadend()
end

function ClimbTowerDragCenter.showWarning(show, content)
	if self.curMode.mode == MODE.EDIT and self.curMode.ui.showWarning then
		self.curMode.ui:showWarning(show, content)
	end
end

function ClimbTowerDragCenter.setClickingObj(...)
	self.clickObj = true
end

function ClimbTowerDragCenter.setDraging(v)
	self.isDragingObj = v
end

function ClimbTowerDragCenter.createMyNewLayerData(layer, tower)
	ClimbTowerModelCenter.createMyNewLayerData(layer, tower)
end

function ClimbTowerDragCenter.createNewMySelfModel(initData)
	ClimbTowerModelCenter.createNewMySelfModel(initData)
end

function ClimbTowerDragCenter.resetLevel()
	ClimbTowerModelCenter.delAllObj()
	self.mainState:tweenMoveCamreaBack(1)
	ClimbTowerModelCenter.createWhenLoadend()
end

function ClimbTowerDragCenter.leaveLevel()
	ClimbTowerModelCenter.delAllObj()
	self.mainState:tweenMoveCamreaBack(1)
	BeginnerManager.noticeMiniGame(Const.MINI_GAME_TYPE_CLIMB_TOWER)
end

function ClimbTowerDragCenter.onDrag(delta)
	return
end

function ClimbTowerDragCenter.onClick(...)
	self.clickObj = false

	self.changeEventState("click")
end

function ClimbTowerDragCenter.onDragBegin(vec)
	self.changeEventState("dragBegin", vec.x, vec.y)
end

function ClimbTowerDragCenter.onDragEnd(delta)
	self.changeEventState("dragEnd")

	if self.isDragingObj and self.curDragObj then
		self.curDragObj:onDragPut(false)
	end

	self.isDragingObj = false
end

function ClimbTowerDragCenter.onLongPress(...)
	self.onClick()
end

function ClimbTowerDragCenter.isLoadFinish(...)
	if not self.inited then
		return false
	end

	if self.curWallName then
		local zone = self.zones[self.curWallName]

		return zone.inited == true
	end

	return false
end

function ClimbTowerDragCenter.destroy(...)
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

	ClimbTowerModelCenter.destroy()
	UIUtils.StopRearHouseDrag()
end

return ClimbTowerDragCenter
