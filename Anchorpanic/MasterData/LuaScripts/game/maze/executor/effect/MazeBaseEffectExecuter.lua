-- 效果执行者基类
module("maze.MazeBaseEffectExecuter", Class.impl())

function ctor(self)
end

function onAwake(self)
	self:__initData()
end

function __initData(self)
	self.mSn = SnMgr:getSn()
	self.mCallFun = nil
end

function setEffectCall(self, callFun)
	self.mCallFun = callFun
end

function getSn(self)
	return self.mSn
end

function __getPos(self, mazeId, targetRow, targetCol)
	local mazeConfigVo = maze.MazeSceneManager:getMazeConfigVo(mazeId)
    local mazeSizeW, mazeSizeH = mazeConfigVo:getMapSize()
    local tileX, tileY = maze.getTilePosByRowCol(mazeSizeW, mazeSizeH, mazeConfigVo:getLayoutType(), targetRow, targetCol, mazeConfigVo:getTileSideLen(), mazeConfigVo:getTileHalfH())
	return math.Vector3(tileX, 0, tileY)
end

function __addFrame(self)
	if(not self.mUpdateSn)then
		self.mUpdateSn = RateLooper:addFrame(1, 0, self, self.__onStepHandler)
	end
end

function __onStepHandler(self, deltaTime)
end

function __removeFrame(self)
	if(self.mUpdateSn)then
		RateLooper:removeFrameByIndex(self.mUpdateSn)
		self.mUpdateSn = nil
	end
end

function __addTimer(self)
	if(not self.mTimerSn)then
		self.mTimerSn = RateLooper:addTimer(1, 0, self, self.__onTimerHandler)
	end
end

function __onTimerHandler(self, deltaTime)
end

function __removeTimer(self)
	if(self.mTimerSn)then
		RateLooper:removeTimerByIndex(self.mTimerSn)
		self.mTimerSn = nil
	end
end

function __removeSn(self)
	if(self.mSn)then
		SnMgr:disposeSn(self.mSn)
		self.mSn = nil
	end
end

-- 被回收
function onRecover(self)
	self:__reset()
end

function __reset(self)
	self:__removeFrame()
	self:__removeTimer()
	self:__removeSn()
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
