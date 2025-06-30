--[[
****************************************************************************
Brief  :buffer 中的数据对象
Author :James Ou
Date   :2020-02-17
****************************************************************************
]]
module("Buff.BuffHandler", Class.impl())
-------------------------------
--构造函数
function ctor(self)
	self.m_norBuffSwitch = {}
	self.m_norBuffSwitch[1] = Buff.BuffFixedVo
	self.m_norBuffSwitch[2] = Buff.BuffPercentVo
	self.m_norBuffSwitch[3] = Buff.BuffIntervalFixedVo
	self.m_norBuffSwitch[4] = Buff.BuffIntervalPercentVo
	self.m_influBuffSwitch = {}
	self.m_influBuffSwitch[1] = Buff.BuffInfluFixedVo
	self.m_influBuffSwitch[2] = Buff.BuffInfluPercentVo
	self.m_influBuffSwitch[3] = Buff.BuffInfluInvalidVo
	self.m_influBuffSwitch[4] = Buff.BuffInfluExcludeVo

	self.m_specialBuffSwitch = {}
	-- buff的实体集合
	self.m_buffEntityDict = {}
	-- 需要手动更新的buff
	self.m_manualUpdateDict = {}
	-- buff数值改变的回调事件
	self.m_buffEventCall = function(liveID, isStart, buffRefID, attrKey, attrVal)
	end
end

-- 创建buff数据对象
function createBuff(self, buffRefID)
	local buffRo = Buff.BuffRoMgr:createBuffRo(buffRefID)
	-- local buffRo = Buff.BuffRo.new(buffRefID)
	-- buffRo:printKV()
	local dataType = buffRo:getDataType()
	if dataType==0 then
		local vo = LuaPoolMgr:poolGet(Buff.BuffVo)
		vo:setRo(buffRo)
		return vo
	end
	local cls = self.m_specialBuffSwitch[dataType]
	if cls then
		local vo = LuaPoolMgr:poolGet(cls)
		vo:setRo(buffRo)
		return vo
	end
	-- 触发间隔类buff
	if buffRo:getInterval()>0 then
		dataType = dataType+2
	end
	cls = self.m_norBuffSwitch[dataType]
	if cls then
		local vo = LuaPoolMgr:poolGet(cls)
		vo:setRo(buffRo)
		return vo
	else
		local influType = buffRo:getInfluenceType()
		cls = self.m_influBuffSwitch[influType]
		if cls then
			local vo = LuaPoolMgr:poolGet(cls)
			vo:setRo(buffRo)
			return vo
		end
	end

	local function _tryRequire()
		dataType = buffRo:getDataType()
		cls = require("game/fight/buff/vo/Buff_"..dataType)
		if cls then
			self.m_specialBuffSwitch[dataType] = cls
		end
	end
	if pcall(_tryRequire) then
		if cls then
			local vo = LuaPoolMgr:poolGet(cls)
			vo:setRo(buffRo)
			return vo
		end
	end

	Debug:log_warn("BuffHandler", "[%d] no buff vo to parse !!!", buffRefID)
end

-- function toCalculate(self, buffEntity, buffVo)
-- end

-- 对buff数值运算的调用
function handleStartup(self, buffEntity, buffVo)
	local valDict = buffVo:calculatedBuffVal()
	local liveVo = fight.SceneManager:getThing(buffEntity.m_livethingID)
	if liveVo and valDict then
		local buffRefID = buffVo:getRefID()
		if buffVo:IsCanInfluence()==true and not table.empty(buffEntity.m_influenceBuffVoDict) then
			for _, influVo in pairs(buffEntity.m_influenceBuffVoDict) do
				-- 整个buff阻断
				if influVo:rejectionBuffRefID(buffRefID)==true then
					return
				end
				--根据属性 确定些buffer是否受干扰类影响
				for attrKey, attrVo in pairs(valDict) do
					if influVo:isInfluencedAttr(attrKey) then
						influVo:addInfluencedRefID(buffRefID)
						local val = nil
						if attrVo.m_affKey~=nil then
							val = influVo:tryInfluencedAttr(attrVo.m_affKey, attrVo.m_val)
						else
							val = influVo:tryInfluencedAttr(attrKey, attrVo.m_val)
						end
						if val~=nil then
							attrVo.m_finalVal = attrVal
						end
					end
				end
			end
		end
		self:_toCalculatorSys(buffEntity.m_livethingID, buffVo)
	end	
end
-- 处理数值还原
function handleRestore(self, buffEntity, buffVo)
	local liveVo = fight.SceneManager:getThing(buffEntity.m_livethingID)
	if liveVo then
		local calVoList = {}
		local valDict = buffVo:calculatedBuffVal()
		for _, attrVo in pairs(valDict) do
			local change = nil
			if attrVo.m_gainType==1 then
				change = 2
			elseif attrVo.m_gainType==2 then
				change = 1
			end
			if change then
				local calVo = fight.CalculatorAttVo.new()
				calVo.id = buffEntity.m_livethingID
				calVo.type = attrVo.m_affKey or attrVo.m_key
				calVo.value = attrVo.m_finalVal or attrVo.m_val
				calVo.change = change
				calVo.showType = buffVo:getShowType()
				calVo.triggerId = buffVo:getCaster()
				table.insert(calVoList, calVo)
			end
		end
		GameDispatcher:dispatchEvent(EventName.FIGTH_UPDATE_ATT, calVoList)
	end
end
-- 处理状态开始
function handleStatusStart(self, buffEntity, buffVo, statusID)
	local liveVo = fight.SceneManager:getThing(buffEntity.m_livethingID)
	if liveVo then
		local calVoList = {}
		local calVo = fight.CalculatorAttVo.new()
		calVo.id = buffEntity.m_livethingID
		calVo.type = statusID
		calVo.value = 1
		calVo.change = 0
		calVo.showType = buffVo:getShowType()
		calVo.triggerId = buffVo:getCaster()
		table.insert(calVoList, calVo)
		GameDispatcher:dispatchEvent(EventName.FIGTH_UPDATE_ATT, calVoList)
	end
end
-- 处理状态结束
function handleStatusEnd(self, buffEntity, buffVo, statusID)
	local liveVo = fight.SceneManager:getThing(buffEntity.m_livethingID)
	if liveVo then
		local calVoList = {}
		local calVo = fight.CalculatorAttVo.new()
		calVo.id = buffEntity.m_livethingID
		calVo.type = statusID
		calVo.value = 0
		calVo.change = 0
		calVo.showType = buffVo:getShowType()
		calVo.triggerId = buffVo:getCaster()
		table.insert(calVoList, calVo)
		GameDispatcher:dispatchEvent(EventName.FIGTH_UPDATE_ATT, calVoList)
	end
end

function _toCalculatorSys(self, liveID, buffVo, attrVo)
	local calVoList = {}
	local valDict = buffVo:calculatedBuffVal()
	for _, attrVo in pairs(valDict) do
		local calVo = fight.CalculatorAttVo.new()
		calVo.id = liveID
		calVo.type = attrVo.m_affKey or attrVo.m_key
		calVo.value = attrVo.m_finalVal or attrVo.m_val
		calVo.change = attrVo.m_gainType
		calVo.showType = buffVo:getShowType()
    	calVo.triggerId = buffVo:getCaster()
		table.insert(calVoList, calVo)
	end
	GameDispatcher:dispatchEvent(EventName.FIGTH_UPDATE_ATT, calVoList)
end

-- casterID 施法者
-- liveID 被添加buff的目标
-- buffRefID buffID
function addBuff(self, casterID, liveID, buffRefID)--, beInfluence, customValDict, customShowTiem)
	local bEntity = self.m_buffEntityDict[liveID]
	if not bEntity then
		bEntity = self.m_manualUpdateDict[liveID]
		if not bEntity then
			bEntity = Buff.BuffEntity.new()
			bEntity:setLivethingID(liveID)
			-- bEntity:setEventCall(BuffDef.EVENT_ATTR_DATA, self.m_buffEventCall)
			self.m_buffEntityDict[liveID] = bEntity
		end
	end
	-- -- 弹buff效果飘字
	-- local buffRo = Buff.BuffRoMgr:getBuffRo(buffRefID)
	-- if buffRo and not table.empty(buffRo:getSpIcon()) then
	-- 	local targetLiveVo = fight.SceneManager:getThing(liveID)
	-- 	local objLive = fight.SceneItemManager:getLivething(liveID)
    --     if objLive and targetLiveVo then
	-- 		local pos = objLive:getPointPos(fight.FightDef.POINT_TOP)
	-- 		for _,v in ipairs(buffRo:getSpIcon()) do
	-- 			fightUI.FightFlyUtil:fly3DImg(UrlManager:getFightArtfontPath(v), pos, targetLiveVo:isAttacker()==1)
	-- 		end
    --     end
	-- end

	return bEntity:addBuff(casterID, buffRefID)--, beInfluence, customValDict, customShowTiem)
end

function refreshBuff(self, liveID, buffRefID)
	local bEntity = self.m_buffEntityDict[liveID]
	if not bEntity then
		bEntity = self.m_manualUpdateDict[liveID]
		if not bEntity then
			return
		end
	end
	return bEntity:updateBuff(buffRefID)
end
-- 对指定的 liveID 移除 buff
function removeBuff(self, liveID, buffRefID, isAll)
	local bEntity = self.m_buffEntityDict[liveID]
	if not bEntity then
		bEntity = self.m_manualUpdateDict[liveID]
		if not bEntity then
			return
		end
	end
	bEntity:removeBuff(buffRefID, isAll)
end
-- 获取指定 liveID 的 buff
function getBuff(self, liveID, buffRefID)
	local bEntity = self.m_buffEntityDict[liveID]
	if not bEntity then
		bEntity = self.m_manualUpdateDict[liveID]
		if not bEntity then
			return
		end
	end
	return bEntity:getBuff(buffRefID)
end
-- 获取指定 liveID 的所有 buff
function getAllBuff(self, liveID)
	local bEntity = self.m_buffEntityDict[liveID]
	if not bEntity then
		bEntity = self.m_manualUpdateDict[liveID]
		if not bEntity then
			return
		end
	end
	return bEntity:getBuffQueue()
end
-- 判断是否持有 buffRefID
function haveBuff(self, liveID, buffRefID)
	if self:getBuff(liveID, buffRefID) then
		return true
	end
	return false
end
-- 移除buff的监听事件
function removeBuffEvent(self, liveID, buffRefID)
	local bEntity = self.m_buffEntityDict[liveID]
	if not bEntity then
		bEntity = self.m_manualUpdateDict[liveID]
		if not bEntity then
			return
		end
	end
	-- local vo = bEntity:getBuff(buffRefID)
	-- if vo then
	-- 	vo:setEndCall()
	-- end
end
-- 对指定的 liveID 清空 buff
function clearBuff(self, liveID)
	local bEntity = self.m_buffEntityDict[liveID]
	if not bEntity then
		bEntity = self.m_manualUpdateDict[liveID]
		if not bEntity then
			return
		end
	end
	bEntity:clearBuff()
end
-- 对指定的 liveID 删除 buff
function deleteBuff(self, liveID)
	local bEntity = self.m_buffEntityDict[liveID]
	if not bEntity then
		bEntity = self.m_manualUpdateDict[liveID]
		if not bEntity then
			return
		end
		self.m_manualUpdateDict[liveID] = nil
	end
	bEntity:clearBuff()
	self.m_buffEntityDict[liveID] = nil
end

function removeAllBuff( self )
	for _,bEntity in pairs(self.m_buffEntityDict) do
		-- local buffvos = bEntity:getAllBuff()
		-- for _,vo in ipairs(buffvos) do
		-- 	vo:setEndCall()
		-- end
		bEntity:clearBuff()
	end
	self.m_buffEntityDict = {}
	for _,bEntity in pairs(self.m_manualUpdateDict) do
		-- local buffvos = bEntity:getAllBuff()
		-- for _,vo in ipairs(buffvos) do
		-- 	vo:setEndCall()
		-- end
		bEntity:clearBuff()
	end
	self.m_manualUpdateDict = {}
end

-- 正常更新所有 buff
function updateBuff(self, deltaTime)
	local updateList = {}
	for _, bEntity in pairs(self.m_buffEntityDict) do
		table.insert(updateList, bEntity)
		-- bEntity:updateBuff(deltaTime)
	end
	for _, bEntity in ipairs(updateList) do
		bEntity:updateBuff(deltaTime)
	end
end
-- 把buff设去手动更新
function setToManual(self, beManual, liveID)
	if beManual then
		local bEntity = self.m_buffEntityDict[liveID]
		if bEntity then
			self.m_manualUpdateDict[liveID] = bEntity
			self.m_buffEntityDict[liveID] = nil
		end
	else
		local bEntity = self.m_manualUpdateDict[liveID]
		if bEntity then
			self.m_buffEntityDict[liveID] = bEntity
			self.m_manualUpdateDict[liveID] = nil
		end
	end
end
-- 手动更新buff
function manualUpdate(self, customDeltaTime)
	for _,bEntity in pairs(self.m_manualUpdateDict) do
		bEntity:updateBuff(customDeltaTime)
	end
end



return _M


 
--[[ 替换语言包自动生成，请勿修改！
]]
