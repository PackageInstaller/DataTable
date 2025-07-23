--[[
****************************************************************************
Brief  :SkillTravelBase 技能特效轨迹基础类
Author :James Ou
Date   :2020-03-03
****************************************************************************
]]
module("SkillTravelBase", Class.impl())
-------------------------------
function ctor(self)
	-- 特效基础物体
	self.m_rootEntity = nil
	-- 基础特效资源名
	self.m_rootPrefabName = nil
	-- 技能的发射点
	self.m_lanuchPoint = nil
	-- 施法者ID
	self.m_casterID = nil
	-- 目标ID
	self.m_targetID = nil
	-- 目标点
	self.m_targetVec3 = nil
	-- 基础速度
	self.m_speed = 1
	-- 是否暂停中
	self.m_isPause = false
	-- 标志开始计时
	self.m_timeStart = nil
	-- 施法者阵营
	self.m_side = nil

	---扩展属性----------------------------------------
	-- 范围内的受击者
	self.m_rangeTarget = {}
	-- 是否可以追踪目标
	self.m_isTrack = false
	
	-- 移动过程中是否可以攻击范围内目标
	self.m_isMoveAtk = false
	-- 移动过程中击中其它目标是否结束
	self.m_isMoveAtkEnd = true
	
	-- 结束时的爆炸特效名 (有的话，在结束时触发)
	self.m_endEftName = nil

	-- 时间制约型技能使用 (即技能的开展到结束有指定的时间限制)
	self.m_timeLimit = nil
	-- 在特定时间内 产生伤害或数值的间隔 (是个数组间隔不是平均的)
	self.m_injuryIntervals = nil
	-- 在特定时间内 产生伤害或数值的间隔 (是数值间隔是平均值)
	self.m_averageInjuryInterval = nil 
	-- 用于平均间隔的时间计算
	self.m_averageIntervalelapsedTime = 0
	-- 触发间隔事件的计数器
	self.m_intervalCnt = 0
end

-- 移除特效轨迹
function removeTrave(self)
end
-- 启动
function start(self, lanuchPoint)
	self.m_timeStart = true
	self.m_lanuchPoint = lanuchPoint
end
-- 设置基础特效资源名
function setRootPrefabName(self, name)
	self.m_rootPrefabName = name
end
-- 暂停
function pause(self)
	self.m_isPause = true
	if self.m_rootEntity then
		self.m_rootEntity:SetSpeed(0)
	end
end
-- 继续
function resume(self)
	self.m_isPause = false
	if self.m_rootEntity then
		self.m_rootEntity:SetSpeed(self.m_speed)
	end
end

-- 设置施法者实体ID
function setCasterID(self, casterID)
	self.m_casterID = casterID
end
-- 目标id
function getTragetID(self)
	return self.m_targetID 
end
-- 设置朝向目标实体ID
function setTargetID(self, targetID)
	self.m_targetID = targetID
end
-- 设置朝向目标坐标
function setTargetVec3(self, vec3)
	self.m_targetVec3 = vec3
end
-- 设置基础速度
function setSpeed(self, speed)
	self.m_speed = speed
end
-- 设置移动中是否会有追踪功能
function setTrackEnable(self, beTrack)
	self.m_isTrack = beTrack
end
-- 设置施法者阵营
function setSide(self ,side)
	self.m_side = side
end
---扩展属性----------------------------------------
-- 设置移动中是否有攻击行为
function setMoveAtkData(self, isMoveAtk, isMoveAtkEnd)
	self.m_isMoveAtk = isMoveAtk
	self.m_isMoveAtkEnd = isMoveAtkEnd
end
-- 设置结束时的爆炸特效
function setEndEftName(self, eftName)
	self.m_endEftName = eftName
end

-- 设置制约时间
function setTimeLimit(self, timeLimit)
	self.m_timeLimit = timeLimit
end

-- 设置触发事件间隔 averageInterval 为平均值
function setInjuryInterval00(self, averageInterval)
	self.m_averageInjuryInterval = averageInterval
	self.m_injuryIntervals = nil
end
-- 设置触发事件间隔 intervals 为间隔数组
function setInjuryInterval01(self, intervals)
	self.m_injuryIntervals = intervals
	self.m_averageInjuryInterval = nil
end

-- 更新 具体由子类实现
function updateTravel(self, timeDelta)
	if self.m_timeStart and self.m_isPause==false then
		-- 有时间制约的处理
		if self.m_timeLimit then
			self.m_timeLimit = self.m_timeLimit-timeDelta
			if self.m_timeLimit<=0 then
				self:onEnd()
				self.m_timeStart = false
				return false
			end
		end
		-- 定时触发伤害或计算事件的处理
		if not table.empty(self.m_injuryIntervals) then
			local interval = self.m_injuryIntervals[1]
			interval = interval-timeDelta
			if interval<=0 then
				table.remove(self.m_injuryIntervals, 1)
				self.m_intervalCnt = self.m_intervalCnt+1
				self:onIntervalInjury(self.m_intervalCnt)
				if not table.empty(self.m_injuryIntervals) then
					self.m_injuryIntervals[1] = self.m_injuryIntervals[1]+interval
				end
			end
		elseif self.m_averageInjuryInterval then
			self.m_averageIntervalelapsedTime = self.m_averageIntervalelapsedTime+timeDelta
			if self.m_averageIntervalelapsedTime>=self.m_averageInjuryInterval then
				self.m_averageIntervalelapsedTime = 0
				self.m_intervalCnt = self.m_intervalCnt+1
				self:onIntervalInjury(self.m_intervalCnt)
			end
		end
		return true
	end
	return false
end

function onTriggerEnter( col )
	-- 要做目录范围判断 
	-- to do
	table.insert(self.m_rangeTarget, col)
end

function onTriggerExit( col )
	for i,target in ipairs(self.m_rangeTarget) do
		if target == col then
			table.remove(self.m_rangeTarget, i)
		end
	end
end

-- 触发间隔伤害
function onIntervalInjury(self, cnt)
end
-- 整个播放结束
function onEnd(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
