-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Debug\\Modules\\Demo\\ServerFrameMgr.lua

local iFrameMgr = require("Common/FrameBattle/iFrameMgr")
local strClassName = "ServerFrameMgr"
local ServerFrameMgr = Class(strClassName, iFrameMgr)

function ServerFrameMgr:ctor(matrixInstance)
	self.curFrame = 0
end

function ServerFrameMgr:nextFrame()
	self.curFrame = self.curFrame + 1

	self.matrixInstance:nextFrame()
end

function ServerFrameMgr:_handleOutQueue()
	local outputQueue = self.matrixInstance:getFrameOutput()

	if outputQueue then
		for i, output in pairs(outputQueue) do
			EventCenter.sendEvent(output[1], output[2], unpack(output[3]))
		end
	end
end

return ServerFrameMgr
