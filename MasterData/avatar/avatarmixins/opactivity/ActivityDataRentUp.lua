-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\ActivityDataRentUp.lua

local ActivityDataBase = require("Avatar/AvatarMixins/OpActivity/ActivityDataBase")
local ActivityDataRentUp = Class("ActivityDataRentUp", ActivityDataBase)

function ActivityDataRentUp:ctor()
	self.serverData = {}
end

function ActivityDataRentUp:updateMgrData(opActivityMgrItem)
	self.startTime = opActivityMgrItem.time.opentime
end

function ActivityDataRentUp:onMgrDataReady()
	CurAvatar:checkRentUpWeek()
end

return ActivityDataRentUp
