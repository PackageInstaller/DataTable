--[[ 
-----------------------------------------------------
@filename       : MainExploreBaseEffectExecuter
@Description    : 主线探索效果执行器基类
@date           : 2022-2-18 13:44:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("mainExplore.MainExploreBaseEffectExecuter", Class.impl())

function ctor(self)
end

function onAwake(self)
	self:__initData()
end

function __initData(self)
	-- self.mSn = SnMgr:getSn()
	self.mCallFun = nil
end

function setEffectCall(self, callFun)
	self.mCallFun = callFun
end

function runEffectCall(self)
	if(self.mCallFun)then
		self.mCallFun()
		self.mCallFun = nil
	end
end

function setSn(self, sn)
	self.mSn = sn
end

function getSn(self)
	return self.mSn
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

function __removeSn(self)
	-- if(self.mSn)then
	-- 	SnMgr:disposeSn(self.mSn)
	-- 	self.mSn = nil
	-- end
	self.mSn = nil
end

-- 被回收
function onRecover(self)
	self:__reset()
end

function __reset(self)
	self:__removeFrame()
	self:__removeSn()
	self:runEffectCall()
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
