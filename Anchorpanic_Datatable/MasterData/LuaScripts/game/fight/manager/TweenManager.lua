--[[****************************************************************************
Brief  :战斗缓动变速管理
Author :Zzz
Date   :2020-03-2
****************************************************************************
]]
module("TweenManager", Class.impl())

function ctor(self)
	-- 缓动列表原始速度字典
	self.m_originalSpeedDic = nil
	-- 缓动列表，速度 = tween原始速度 x 战斗倍速
	self.m_tweenerDic = nil
	self.m_timeScale = nil
	
	-- 缓动组字典，速度 = tween原始速度 x 战斗倍速 x 特殊倍速（道具加速，被控减速...）
	self.m_tweenGroupDic = nil
	
	self:__init()
end

function __init(self)
	self.m_originalSpeedDic = {}
	self.m_tweenerDic = {}
	self.m_tweenGroupDic = {}
	self.m_timeScale = 1
end

function setTimeScale(self, cusTimeScale)
	if self.m_timeScale == cusTimeScale then
		return;
	end
	self:__updateAll(cusTimeScale);
	self.m_timeScale = cusTimeScale;
end

function getTimeScale(self)
	return self.m_timeScale;
end

-- 自定义某一组缓动组的速度
function setTimeScaleByGroupId(self, cusCustomTimeScale, cusCustomGroupId)
	-- 原始速度
	local originalSpeed
	local tweenDic = self.m_tweenGroupDic[cusCustomGroupId]
	if tweenDic ~= nil then
		for _hashCode, _tweener in pairs(tweenDic) do
			originalSpeed = self.m_originalSpeedDic[_hashCode]
			_tweener.timeScale = originalSpeed * cusCustomTimeScale * self.m_timeScale
		end
	end
end

-- 统一设置所有缓动在原始速度基础上的倍速
function __updateAll(self, cusTimeScale)
	for _i, _tweener in pairs(self.m_tweenerDic) do
		originalSpeed = self.m_originalSpeedDic[_tweener:GetHashCode()]
		originalSpeed = originalSpeed == nil and 1 or originalSpeed
		_tweener.timeScale = originalSpeed * cusTimeScale;
	end
end

function resetAll(self)
	self.m_originalSpeedDic = {}
	self.m_tweenerDic = {}
	self.m_tweenGroupDic = {}
end

function addTweener(self, cusTweener, cusCustomTimeScale, cusCustomGroupId)
	if cusCustomTimeScale == nil then
		cusCustomTimeScale = 1
	end
	
	if cusTweener ~= nil then
		local hashCode = cusTweener:GetHashCode()
		self.m_tweenerDic[hashCode] = cusTweener
		if cusCustomGroupId ~= nil then
			if self.m_tweenGroupDic[cusCustomGroupId] == nil then
				self.m_tweenGroupDic[cusCustomGroupId] = {}
			end
			self.m_tweenGroupDic[cusCustomGroupId] [hashCode] = cusTweener
		end
		
		self.m_originalSpeedDic[hashCode] = cusCustomTimeScale
		cusTweener.timeScale = cusCustomTimeScale * self.m_timeScale;
		
		local callBack = cusTweener.onComplete;
		local function _tempCall()
			self.m_originalSpeedDic[hashCode] = nil
			self.m_tweenerDic[hashCode] = nil
			if(cusCustomGroupId ~= nil) then
				local tweenDic = self.m_tweenGroupDic[cusCustomGroupId]
				if tweenDic ~= nil then
					tweenDic[hashCode] = nil
				end
			end
			if callBack ~= nil then
				callBack();
			end
		end
		cusTweener:OnComplete(_tempCall)
	end
	return cusTweener
end
return _M 
 
--[[ 替换语言包自动生成，请勿修改！
]]
