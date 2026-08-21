-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClimbTowerDemo\\DoLoadWaitClimbTower.lua

local LoaderFactory = Framework.Resource.LoaderFactory
local DoLoadBase = require("System/Load/DoLoadBase")
local ClimbTowerDragCenter = require("ClimbTowerDemo/ClimbTowerDragCenter")
local strClassName = "DoLoadWaitClimbTower"
local DoLoadWaitClimbTower = Class(strClassName, DoLoadBase)

function DoLoadWaitClimbTower:ctor()
	return
end

function DoLoadWaitClimbTower:checkRate()
	if ClimbTowerDragCenter.isLoadFinish() then
		self.mCurRate = 1
	else
		self.mCurRate = 0
	end
end

return DoLoadWaitClimbTower
