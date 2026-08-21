-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\Tools\\PingPongTable.lua

local strClassName = "PingPongTable"
local PingPongTable = Class(strClassName)

function PingPongTable:ctor()
	self.tableOfPingPong = {
		[1] = 0,
		[2] = 0
	}
	self.currentIndex = 1
end

function PingPongTable:hitOne(judgeData, judgeFunc)
	local oldData = self.tableOfPingPong[self.currentIndex]
	local hitSuccess = judgeFunc(oldData, judgeData)

	if hitSuccess then
		self.tableOfPingPong[self.currentIndex] = judgeData
		self.currentIndex = self.currentIndex % 2 + 1
	end

	return hitSuccess
end

return PingPongTable
