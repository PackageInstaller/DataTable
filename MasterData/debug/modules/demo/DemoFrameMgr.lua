-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Debug\\Modules\\Demo\\DemoFrameMgr.lua

local iFrameMgr = require("Common/FrameBattle/iFrameMgr")
local strClassName = "DemoFrameMgr"
local DemoFrameMgr = Class(strClassName, iFrameMgr)
local UpdateBeat = UpdateBeat
local Time = Time

function DemoFrameMgr:ctor(matrixInstance)
	self.isRunning = false
end

function DemoFrameMgr:destroy()
	if self.heartBeatTickFunc then
		UpdateBeat:Remove(self.heartBeatTickFunc)

		self.heartBeatTickFunc = nil
	end

	self.matrixInstance = nil
end

function DemoFrameMgr:start()
	if self.started then
		return
	end

	self.isRunning = true
	self.curFrame = 0
	self.timeAlreadyHandled = 0
	self.timePassed = 0

	self:_handleOutQueue()

	self.heartBeatTickFunc = Slot(self.tick, self)

	UpdateBeat:Add(self.heartBeatTickFunc)

	self.started = true
end

function DemoFrameMgr:running()
	return self.isRunning
end

function DemoFrameMgr:chaseNextTick()
	self.timePassed = self.timePassed + self.matrixFrameLength

	self:nextFrame()
end

local MAX_FRAME = 3

function DemoFrameMgr:tick()
	self.timePassed = self.timePassed + Time.deltaTime * 1000

	local unhandledFrameNumber = math.floor((self.timePassed - self.timeAlreadyHandled) / self.matrixFrameLength)

	for index = 1, math.min(unhandledFrameNumber, MAX_FRAME) do
		self:nextFrame()
	end
end

function DemoFrameMgr:nextFrame()
	self.curFrame = self.curFrame + 1

	self.matrixInstance:nextFrame()

	local outputQueue = self.matrixInstance:getFrameOutput()

	if outputQueue then
		for i, output in pairs(outputQueue) do
			EventCenter.sendEvent(output[1], output[2], unpack(output[3]))
		end
	end

	self.timeAlreadyHandled = self.curFrame * self.matrixFrameLength
end

function DemoFrameMgr:nextFrameWithoutEvent()
	self.curFrame = self.curFrame + 1

	self.matrixInstance:nextFrame()
end

function DemoFrameMgr:_handleOutQueue()
	local outputQueue = self.matrixInstance:getFrameOutput()

	if outputQueue then
		for i, output in pairs(outputQueue) do
			EventCenter.sendEvent(output[1], output[2], unpack(output[3]))
		end
	end
end

function DemoFrameMgr:pause()
	if self.heartBeatTickFunc then
		UpdateBeat:Remove(self.heartBeatTickFunc)
	end

	self.isRunning = false
end

function DemoFrameMgr:resume()
	if not self.started then
		return
	end

	if not self.isRunning then
		if self.heartBeatTickFunc then
			UpdateBeat:Add(self.heartBeatTickFunc)
		end

		self.isRunning = true
	end
end

return DemoFrameMgr
