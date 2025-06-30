--[[
****************************************************************************
Brief  :STravelHandle 用于管理技能特效轨迹生命周期
Author :James Ou
Date   :2020-03-04
****************************************************************************
]]
module("STravelHandle", Class.impl())
-------------------------------
function ctor(self)
	-- 用于保存轨迹类数据
	self.m_travelList = {}
	-- 用于保存表现类数据
	self.m_perfDict = {}
	-- 暂时保存轨迹类需要手动更新的数据
	self.m_manualUpdateTravelList = {}
end
-- 添加轨迹
function addTravel(self, travel)
	local sn = travel:sn()
	local liveID = travel:getCasterID()
	local mList = self.m_manualUpdateTravelList[liveID]
	if table.empty(mList) then
		for _,tr in ipairs(self.m_travelList) do
			if tr:sn()==sn then
				Debug:log_warn("STravelHandle", "travel[%s] sn[%d] already has one travel !!!", sn, travel.class._NAME)
				return
			end
		end
		travel:setSpeed(RateLooper:getPlayRate())
		table.insert(self.m_travelList, travel)
	else -- 当前在手动状态的模式下
		for _,tr in ipairs(mList) do
			if tr:sn()==sn then
				Debug:log_warn("STravelHandle", "travel[%s] sn[%d] already has one travel !!!", sn, travel.class._NAME)
				return
			end
		end
		table.insert(mList, travel)
		travel:setSpeed(RateLooper:getPlayRate())
	end
end

-- 结束轨迹
function endTravel(self, sn)
	for i,tr in ipairs(self.m_travelList) do
		if tr:sn()==sn then	
			tr:onEnd()
			return
		end
	end
	
	for _, mList in pairs(self.m_manualUpdateTravelList) do
		for _,tr in ipairs(mList) do
			if tr:sn()==sn then
				tr:onEnd()
				return
			end
		end
	end
end

-- 移除轨迹
function removeTravel(self, sn)
	for i,tr in ipairs(self.m_travelList) do
		if tr:sn()==sn then
			Class.delete(tr)
			table.remove(self.m_travelList, i)
			return
		end
	end
	for liveID, mList in pairs(self.m_manualUpdateTravelList) do
		for i,tr in ipairs(mList) do
			if tr:sn()==sn then
				Class.delete(tr)
				table.remove(mList, i)
				if table.empty(mList) then
					self.m_manualUpdateTravelList[liveID] = nil
				end
				return
			end
		end
	end
end

-- 移除轨迹的消息事件
function removeTravelEvent(self, sn)
	for i,tr in ipairs(self.m_travelList) do
		if tr:sn()==sn then
			tr:setEventCall()
			return
		end
	end
	for _, mList in pairs(self.m_manualUpdateTravelList) do
		for _,tr in ipairs(mList) do
			if tr:sn()==sn then
				tr:setEventCall()
				return
			end
		end
	end
end
-- 移除所有轨迹
function removeAllTravel(self)
	for i,tr in ipairs(self.m_travelList) do
		tr:setEventCall()
		tr:onEnd()
		Class.delete(tr)
	end
	self.m_travelList = {}
	for liveID, mList in pairs(self.m_manualUpdateTravelList) do
		for i,tr in ipairs(mList) do
			tr:setEventCall()
			tr:onEnd()
			Class.delete(tr)
		end
	end
	self.m_manualUpdateTravelList = {}
end
-- 更新轨迹
function updateTravel(self, dt)
	for i=#self.m_travelList, 1, -1 do
		local travel = self.m_travelList[i]
		travel:updateTravel(dt)
	end
end

-- 对表现层发出命令
function perfHandle(self, travel, cmd, ...)
	local perf = self.m_perfDict[travel:sn()]
	if perf then
		perf:onTravelCmd(cmd, travel, ...)
	end
end
-- 添加表现层
function addPerf(self, travel)
	local sn = travel:sn()
	local perf = self.m_perfDict[sn]
	if perf then -- more has one
		Debug:log_warn("STravelHandle", "travel[%s] sn[%d] already has one perform !!!", sn, travel.class._NAME)
		return
	end
	perf = travel:createPerf()-- STravelFactory:perf(travel:getPerfID())
	if perf then
		perf.mc_sn = sn
		self.m_perfDict[sn] = perf
	end
end

-- 移除表现层
function removePerf(self, sn)
	local perf = self.m_perfDict[sn]
	if perf then
		Class.delete(perf)
		self.m_perfDict[sn] = nil
		return
	end
end

function removeAllPerf(self)
	for _,perf in pairs(self.m_perfDict) do
		perf:onEnd()
		Class.delete(perf)
	end
	self.m_perfDict = {}
end

-- 暂停所有轨迹
function pauseAllTravel(self)
	for _,tr in ipairs(self.m_travelList) do
		tr:pause()
	end
end
-- 继续所有轨迹
function resumeAllTravel(self)
	for _,tr in ipairs(self.m_travelList) do
		tr:resume()
	end
	self:removeAllPerf()
end
-- 对所有轨迹设置基础速度
function setNormalSpeed(self, speed)
	for _,tr in ipairs(self.m_travelList) do
		tr:setSpeed(speed)
	end
end

function setManualSpeed( self, speed )
	for liveID,mList in pairs(self.m_manualUpdateTravelList) do
		for _,tr in ipairs(mList) do
			tr:setSpeed(speed)
		end
	end
end

-- 设置手动更新时序的技能
function setToManual(self, beManual, liveID)
	if beManual then
		local mList = self.m_manualUpdateTravelList[liveID]
		if not mList then
			mList = {}
			self.m_manualUpdateTravelList[liveID] = mList
		end
		local cnt = #self.m_travelList
		for i=cnt, 1, -1 do
			local tr = self.m_travelList[i]
			if tr:getCasterID()==liveID then
				table.insert(mList, tr)
				table.remove(self.m_travelList, i)
			end
		end
		if table.empty(mList) then
			self.m_manualUpdateTravelList[liveID] = nil
		end
	else
		local mList = self.m_manualUpdateTravelList[liveID]
		if mList then
			for _,tr in ipairs(self.mList) do
				table.insert(self.m_travelList, tr)
			end
			self.m_manualUpdateTravelList[liveID] = nil
		end
	end
end

-- 手动更新travel
function manualUpdate(self, customDeltaTime)
	for _,mList in pairs(self.m_manualUpdateTravelList) do
		for _,tr in ipairs(self.mList) do
			tr:updateTravel(customDeltaTime)
		end
	end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
