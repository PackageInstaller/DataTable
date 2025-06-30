
module("Buff.BuffEftReactionHandler", Class.impl())
-------------------------------
local STAND_POS = 1
local BODY_POS = 2
local HEAD_POS = 3
--构造函数
function ctor(self)	
	self.m_buffEftDictQueue = {}

	GameDispatcher:addEventListener(EventName.BUFF_ADD_EFT, self._addEft, self)
	GameDispatcher:addEventListener(EventName.BUFF_UPDATE_EFT, self._updateEft, self)
	GameDispatcher:addEventListener(EventName.BUFF_REMOVE_EFT, self._removeEft, self)
end
function _updateEft(self, buffVo)
	local refID = buffVo:getRefID()
	-- print("_addEft 111111111111111111", refID)
	local buffRo =  Buff.BuffRoMgr:getBuffRo(refID)
	if buffRo then
		local liveObj = fight.SceneItemManager:getLivething(buffVo.m_entity.m_livethingID)
		if not liveObj or not liveObj:getTrans() then return end
		local liveVo = fight.SceneManager:getThing(buffVo.m_entity.m_livethingID)
		local buffData = liveVo:getBuffData(refID)
		local dictQueue = self.m_buffEftDictQueue[buffVo.m_entity.m_livethingID]
		if not dictQueue then
			return
		end
		local eftArr = buffRo:getHangStand()
		if not table.empty(eftArr) then
			local idx = buffData[2]
			if not idx then idx = 1 end
			local eftname = eftArr[idx]
			if not eftname then
				eftname = eftArr[1]
			end
			self:__updateEft(dictQueue[STAND_POS], eftname, buffVo)
		end
		eftArr = buffRo:getHangBody()
		if not table.empty(eftArr) then
			local idx = buffData[2]
			if not idx then idx = 1 end
			local eftname = eftArr[idx]
			if not eftname then
				eftname = eftArr[1]
			end
			self:__updateEft(dictQueue[BODY_POS], eftname, buffVo)
		end
		
		eftArr = buffRo:getHangHead()
		-- table.print(eftArr)
		if not table.empty(eftArr) then
			local idx = buffData[2]
			if not idx then idx = 1 end
			local eftname = eftArr[idx]
			if not eftname then
				eftname = eftArr[1]
			end
			self:__updateEft(dictQueue[HEAD_POS], eftname, buffVo)
		end
	end
end

function __updateEft(self, queue, eftname, buffVo)
	local eftVo, index = self:_getEftVo(queue, buffVo)
	if eftVo then
		table.remove(queue, index)
		if not table.empty(queue) then
			local lastEftVo = queue[#queue]
			if lastEftVo then
				if lastEftVo.reaction~=true then
					lastEftVo.eftGo:SetActive(false)
				else
					lastEftVo.reactionActive = true
				end
			end
		end
		if eftVo.eftname~=eftname then
			if eftVo.eftGo and not gs.GoUtil.IsGoNull(eftVo.eftGo) then
				eftVo.isRemove = true
				if eftVo.reaction~=true then
					gs.GameObject.Destroy(eftVo.eftGo)
				end
			end
			local eftGo = gs.ResMgr:LoadGO(UrlManager:get3DBuffPath(eftname))
			if eftGo then
				-- eftGo.transform:SetParent(liveObj:getTrans())
				gs.TransQuick:SetParentOrg(eftGo.transform, liveObj:getTrans())
				local charAppend = eftGo:GetComponent(ty.CharAppendEffect)
				if charAppend then
					charAppend.CharSet = liveObj:getRootGO()
				end
				eftVo = {sn=buffVo:sn(), refID=buffVo:getRefID(), eftname=eftname, eftGo=eftGo, pos=eftGo.transform.localPosition}
				table.insert(queue, eftVo)
			end
		else
			if eftVo.tweener then
				eftVo.tweener:Kill()
				eftVo.tweener = nil
			end
			eftVo.eftGo:SetActive(true)
			eftVo.reactionActive = nil
			table.insert(queue, eftVo)
		end
	end
end
--添加特效
function _addEft(self, buffVo)
	local refID = buffVo:getRefID()
	-- print("_addEft 111111111111111111", refID)
	local buffRo =  Buff.BuffRoMgr:getBuffRo(refID)
	if buffRo then
		local liveObj = fight.SceneItemManager:getLivething(buffVo.m_entity.m_livethingID)
		--print("_addEft 22222222222222", buffVo.m_entity.m_livethingID, liveObj)
		-- 目标已经不存在了, 不用加buffer了
		if not liveObj or not liveObj:getTrans() then return end
		local liveVo = fight.SceneManager:getThing(buffVo.m_entity.m_livethingID)
		local buffData = liveVo:getBuffData(refID)
		local dictQueue = self.m_buffEftDictQueue[buffVo.m_entity.m_livethingID]
		if not dictQueue then
			dictQueue = {}
			dictQueue[STAND_POS] = {}
			dictQueue[BODY_POS] = {}
			dictQueue[HEAD_POS] = {}
			self.m_buffEftDictQueue[buffVo.m_entity.m_livethingID] = dictQueue
		end
		local eftArr = buffRo:getHangStand()
		if not table.empty(eftArr) then
			local idx = buffData[2]
			if not idx then idx = 1 end
			local eftname = eftArr[idx]
			if not eftname then
				eftname = eftArr[1]
			end
			self:_setupBuff(dictQueue, STAND_POS, eftname, buffVo, liveObj)
		end
		eftArr = buffRo:getHangBody()
		if not table.empty(eftArr) then
			local idx = buffData[2]
			if not idx then idx = 1 end
			local eftname = eftArr[idx]
			if not eftname then
				eftname = eftArr[1]
			end
			self:_setupBuff(dictQueue, BODY_POS, eftname, buffVo, liveObj)
		end
		
		eftArr = buffRo:getHangHead()
		-- table.print(eftArr)
		if not table.empty(eftArr) then
			local idx = buffData[2]
			if not idx then idx = 1 end
			local eftname = eftArr[idx]
			if not eftname then
				eftname = eftArr[1]
			end
			self:_setupBuff(dictQueue, HEAD_POS, eftname, buffVo, liveObj)
		end
	end
end
-- buff的元素反应
function reaction(self, liveID, buffRefID1, buffRefID2)
	-- print("reaction ", self, self.m_buffEftDictQueue, liveID)
	local queue = self.m_buffEftDictQueue[liveID]
	if queue then
		local liveObj = fight.SceneItemManager:getLivething(liveID)
		-- 目标已经不存在了, 不用加buffer了
		if not liveObj or not liveObj:getTrans() then return end

		local arr = queue[HEAD_POS]
		if table.empty(arr) then return end
		local bufferEft1 = nil
		local bufferEft2 = nil
		for _, eftVo in ipairs(arr) do
			if buffRefID1==eftVo.refID and not bufferEft1 then
				bufferEft1 = eftVo
			elseif buffRefID2==eftVo.refID and not bufferEft2 then
				bufferEft2 = eftVo
			end
		end
		
		if not bufferEft1 then
			local buffRo =  Buff.BuffRoMgr:getBuffRo(buffRefID1)
			if buffRo then
				local eftArr = buffRo:getHangHead()
				if not table.empty(eftArr) then
					local eftname = eftArr[1]
					local eftGo = gs.ResMgr:LoadGO(UrlManager:get3DBuffPath(eftname))
					if eftGo then
						-- eftGo.transform:SetParent(liveObj:getTrans())
						gs.TransQuick:SetParentOrg(eftGo.transform, liveObj:getTrans())
						local charAppend = eftGo:GetComponent(ty.CharAppendEffect)
						if charAppend then
							charAppend.CharSet = liveObj:getRootGO()
						end
						bufferEft1 = {refID=buffRefID1, eftGo=eftGo, isReactionNew=true, pos=eftGo.transform.localPosition}
					end
				end
			end
		end
		if not bufferEft2 then
			local buffRo =  Buff.BuffRoMgr:getBuffRo(buffRefID2)
			if buffRo then
				local eftArr = buffRo:getHangHead()
				if not table.empty(eftArr) then
					local eftname = eftArr[1]
					local eftGo = gs.ResMgr:LoadGO(UrlManager:get3DBuffPath(eftname))
					if eftGo then
						-- eftGo.transform:SetParent(liveObj:getTrans())
						gs.TransQuick:SetParentOrg(eftGo.transform, liveObj:getTrans())
						local charAppend = eftGo:GetComponent(ty.CharAppendEffect)
						if charAppend then
							charAppend.CharSet = liveObj:getRootGO()
						end
						bufferEft2 = {refID=buffRefID2, eftGo=eftGo, isReactionNew=true, pos=eftGo.transform.localPosition}
					end
				end
			end
		end
		if not bufferEft1 or not bufferEft2 then
			if bufferEft1 and bufferEft1.isReactionNew==true then
				gs.GameObject.Destroy(bufferEft1.eftGo)
			end
			if bufferEft2 and bufferEft2.isReactionNew==true then
				gs.GameObject.Destroy(bufferEft2.eftGo)
			end
			return
		end

		bufferEft1.reaction = true
		bufferEft2.reaction = true
		if bufferEft1.eftGo.activeSelf==false then
			bufferEft1.eftGo:SetActive(true)
			bufferEft1.reactionActive = true
		end
		if bufferEft2.eftGo.activeSelf==false then
			bufferEft2.eftGo:SetActive(true)
			bufferEft2.reactionActive = true
		end
		if bufferEft1.tweener then
			bufferEft1.tweener:Kill()
		end
		if bufferEft2.tweener then
			bufferEft2.tweener:Kill()
		end
		gs.TransQuick:LPos(bufferEft1.eftGo.transform, bufferEft1.pos)
		gs.TransQuick:LPos(bufferEft2.eftGo.transform, bufferEft2.pos)
		
		bufferEft1.tweener = bufferEft1.eftGo.transform:DOMoveLOffsetX(-0.18,0.1)
		bufferEft2.tweener = bufferEft2.eftGo.transform:DOMoveLOffsetX(0.18,0.1)

		local function _reactionTimeOut1()
			bufferEft1.reactionTimeOutSn = nil
			bufferEft1.reaction = nil
			if bufferEft1.isRemove==true or bufferEft1.isReactionNew==true then
				if not gs.GoUtil.IsGoNull(bufferEft1.eftGo) then --预防提前跟角色一起移除了
					gs.GameObject.Destroy(bufferEft1.eftGo)
				end
			elseif bufferEft1.reactionActive==true then
				bufferEft1.eftGo:SetActive(false)
				bufferEft1.reactionActive = nil
			else
				bufferEft1.tweener = bufferEft1.eftGo.transform:DOLocalMove(bufferEft2.pos,0.01)
			end
		end
		local function _reactionTimeOut2()
			bufferEft2.reactionTimeOutSn = nil
			bufferEft2.reaction = nil
			if bufferEft2.isRemove==true or bufferEft2.isReactionNew==true then
				if not gs.GoUtil.IsGoNull(bufferEft2.eftGo) then --预防提前跟角色一起移除了
					gs.GameObject.Destroy(bufferEft2.eftGo)
				end
			elseif bufferEft2.reactionActive==true then
				bufferEft2.eftGo:SetActive(false)
				bufferEft2.reactionActive = nil
			else
				bufferEft2.tweener = bufferEft2.eftGo.transform:DOLocalMove(bufferEft2.pos,0.01)
			end
		end
		RateLooper:clearTimeout(bufferEft1.reactionTimeOutSn)
		RateLooper:clearTimeout(bufferEft2.reactionTimeOutSn)
		bufferEft1.reactionTimeOutSn = RateLooper:setTimeout(4, self, _reactionTimeOut1)
		bufferEft2.reactionTimeOutSn = RateLooper:setTimeout(4, self, _reactionTimeOut2)
	end
end

function _setupBuff(self, queue, posType, eftname, buffVo, liveObj)
	if not table.empty(queue[posType]) then
		local lastEftVo = queue[posType][#queue[posType]]
		if lastEftVo then
			lastEftVo.eftGo:SetActive(false)
		end
	end
	local eftGo = gs.ResMgr:LoadGO(UrlManager:get3DBuffPath(eftname))
	if eftGo then
		-- eftGo.transform:SetParent(liveObj:getTrans())
		gs.TransQuick:SetParentOrg(eftGo.transform, liveObj:getTrans())
		local charAppend = eftGo:GetComponent(ty.CharAppendEffect)
		if charAppend then
			charAppend.CharSet = liveObj:getRootGO()
		end
		local eftVo = {sn=buffVo:sn(), refID=buffVo:getRefID(), eftname=eftname, eftGo=eftGo, pos=eftGo.transform.localPosition}
		table.insert(queue[posType], eftVo)
	end
end

function _getEftVo(self, queue, buffVo)
	for index, value in ipairs(queue) do
		if value.sn==buffVo:sn() then
			return value, index
		end
	end
end
--移除特效
function _removeEft(self, buffVo)
	local dictQueue = self.m_buffEftDictQueue[buffVo.m_entity.m_livethingID]
	if not dictQueue then return end

	for _,queue in pairs(dictQueue) do
		local queueCnt = #queue
		for i=queueCnt,1,-1 do
			local v = queue[i]
			if v.sn==buffVo:sn() then
				table.remove(queue, i)
				if v.eftGo and not gs.GoUtil.IsGoNull(v.eftGo) then
					v.isRemove = true
					if v.eftGo.activeSelf==true and v.reactionActive~=true then
						if not table.empty(queue) then
							local nV = queue[#queue]
							if nV and nV.eftGo then
								nV.reactionActive = nil
								nV.eftGo:SetActive(true)
							end
						end
					end
					if v.reaction~=true then
						gs.GameObject.Destroy(v.eftGo)
					end
				end
				break
			end
		end
	end
end


return _M



 
--[[ 替换语言包自动生成，请勿修改！
]]
