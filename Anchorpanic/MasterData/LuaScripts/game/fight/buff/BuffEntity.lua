--[[
****************************************************************************
Brief  :buffer实体 用于可添加buffer的单位持有的组件
Author :James Ou
Date   :2020-02-17
****************************************************************************
]]
module("Buff.BuffEntity", Class.impl())
-------------------------------
function ctor(self)
	self.m_livethingID = nil
	self.m_buffQueue = {}
	-- -- 因为只显示最新一个Buff
	-- self.m_curBuffRefID = nil
	-- 简单的处理
	self.m_buffDict = {}
end

--添加需要buff持有者ID
function setLivethingID(self, livethingID)
	self.m_livethingID = livethingID
end
function getLivethingID(self)
	return self.m_livethingID
end

function getBuff( self, buffRefID )
	for _,vo in ipairs(self.m_buffQueue) do
		if vo:getRefID()==buffRefID then
			return vo
		end
	end
end

function getBuffQueue(self)
	return self.m_buffQueue
end

--添加buffer
function addBuff(self, casterID, buffRefID)--, beInfluence, customValDict, customShowTiem)
	local curVo = self:getBuff(buffRefID)
	if not curVo then
		local bVo = LuaPoolMgr:poolGet(Buff.BuffVo)
		bVo:setEntity(self)
		bVo:setRefID(buffRefID)
		bVo:setCaster(casterID)
		table.insert(self.m_buffQueue, bVo)
		curVo = bVo
		curVo:addEft()
	end
	return curVo
	-- curVo:addOverCount()

	-- -- if self.m_curBuffRefID~=buffRefID then
	-- -- 	local old = self:getBuff(self.m_curBuffRefID)
	-- -- 	if old then
	-- -- 		old:removeEft()
	-- -- 	end
	-- -- 	curVo:addEft()
	-- -- 	self.m_curBuffRefID = buffRefID
	-- -- end
	-- curVo:addEft()
	-- return curVo
end
function updateBuff(self, buffRefID)
	local curVo = self:getBuff(buffRefID)
	if not curVo then return end
	curVo:updateEft()
end
--移除buffer
function removeBuff(self, buffRefID)
	local curVo = self:getBuff(buffRefID)
	if curVo then
		-- 减引用数
		-- curVo:reductionOverCount()
		-- if curVo:overCount()<=0 then
			-- 引用数为0后 移除特效
			curVo:removeEft()
			for i=#self.m_buffQueue,1,-1 do
				if self.m_buffQueue[i]:getRefID()==buffRefID then
					table.remove(self.m_buffQueue, i)
				end
			end
			LuaPoolMgr:poolRecover(curVo)
		-- else
		-- 	return
		-- end
	end
	-- -- 如果当前显示是正是移除ID 重新找一个新作显示
	-- if self.m_curBuffRefID==buffRefID then
	-- 	local lastVo = self.m_buffQueue[#self.m_buffQueue]
	-- 	if lastVo then
	-- 		lastVo:addEft()
	-- 		self.m_curBuffRefID = lastVo:getRefID()
	-- 	else
	-- 		self.m_curBuffRefID = nil
	-- 	end
	-- end
end

--清空buffer
function clearBuff(self)
	local refIDMap = {}

	for _, bVo in ipairs(self.m_buffQueue) do
		refIDMap[bVo:getRefID()] = true
	end
	for k,_ in pairs(refIDMap) do
		self:removeBuff(k)
	end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
