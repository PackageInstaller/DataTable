module("braceletsCommunicate.BraceletsCommunicateManager", Class.impl(Manager))

------------------------------------------------------------
--构造函数
function ctor(self)
	super.ctor(self)
	self:__initData()
end

-- Override 重置数据
function resetData(self)
     super.resetData(self)
     self:__initData()
end

function __initData(self)
	self.mCommunicateConfigDic = {}
	self.mCommunicateMsgDic = {}
	self.mPrivateChat = {}
	self.mPublicChat = {}
	self.mNowSelectTargetId = nil
end

function setNowSelectTarget(self, value)
	self.mNowSelectTargetId = value
end

function getNowSelectTarget(self)
	return self.mNowSelectTargetId
end

function getNewestHasRead(self, targetId)
	return self:getNewestStoreNum(targetId) == 0
end

function getNewestStoreNum(self, targetId)
	local res = StorageUtil:getNumber1(targetId.."IsRead")
	return res
end

function setNewestHasRead(self, targetId, newestTalkId, hasRead)
	if hasRead then 
		StorageUtil:saveNumber1(targetId.."IsRead", 0)
		return
	end
	StorageUtil:saveNumber1(targetId.."IsRead", newestTalkId)
end

----------------------------------------------------------------------------配置相关--------------------------------------------------------------------------------------
-- 解析聊天配置表
function praseCommunicateConfig(self)
    local baseData = RefMgr:getData("communication_data")
    for k, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(braceletsCommunicate.BraceletsCommunicateConfigVo)
		vo:parseData(k, data)
		self.mCommunicateConfigDic[k] = vo
    end
end

-- 获取表情字典
function getCommunicateConfig(self, targetId)
	if(table.empty(self.mCommunicateConfigDic))then
		self:praseCommunicateConfig()
	end
	return self.mCommunicateConfigDic[targetId]
end

----------------------------------------------------------------------------服务器响应--------------------------------------------------------------------------------------
-- 更新通讯
function parseCommunicateMsg(self, msg)
	for k,v in pairs(msg.target_list) do
		local communicateVo = self.mCommunicateMsgDic[v.target_id]
		if communicateVo == nil then 
			communicateVo = LuaPoolMgr:poolGet(braceletsCommunicate.BraceletsCommunicateMsgVo)
			communicateVo:parseData(v)
		else
			for m,n in pairs(v.part_list) do
			 	communicateVo.segmentDic[n.part_id] = n.talk_list
			end
		end
		communicateVo:updateNewestInfo()
		self.mCommunicateMsgDic[communicateVo.targetId] = communicateVo
		local config = self:getCommunicateConfig(communicateVo.targetId)
		if config == nil then 
			logError(string.format("没有通讯配置%s", communicateVo.targetId))
		end 
		local hasConfig = false
		if config.type == 1 then 
			for k,v in pairs(self.mPrivateChat) do
				if v.targetId == communicateVo.targetId then 
					hasConfig = true
					break
				end
			end
			if not hasConfig then 
				table.insert(self.mPrivateChat, config)
			end
		else
			for k,v in pairs(self.mPublicChat) do
				if v.targetId == config.targetId then 
					hasConfig = true
					break
				end
			end
			if not hasConfig then 
				table.insert(self.mPublicChat, config)
			end
		end
		local newestSegId, newestTalkId, _ =  self.mCommunicateMsgDic[v.target_id]:getNewestSegmentId()
		GameDispatcher:dispatchEvent(EventName.UPDATE_COMMUNICATE_HISTORY, v.target_id)
	end
	mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_COMMUNICATION, self:checkIsRed())
end

function getCommunicateMsgVo(self, targetId)
	return self.mCommunicateMsgDic[targetId]
end

function getPrivateChat(self)
	table.sort( self.mPrivateChat, function(a,b) 
		return self:redPointSort(a, b)
	end)
	return self.mPrivateChat
end

--私聊
function getIsPrivate(self, targetId)
	return table.indexof(self:getPrivateChat(), self:getCommunicateMsgVo(targetId))
end

--群聊
function getPublicChat(self)
	table.sort(self.mPublicChat, function(a,b) 
		return self:redPointSort(a, b)
	end)
	return self.mPublicChat
end

--- 按照红点排序
function redPointSort(self, paramA, paramB)
	local ARed, BRed = false
	local msgVoA = self:getCommunicateMsgVo(paramA.targetId)
    local newestSegIdA, newestTalkIdA, indexA = msgVoA:getNewestSegmentId()
    local nowTalkVoA = paramA:getTalkVo(newestSegIdA, newestTalkIdA)
    if nowTalkVoA.nextId[1] ~= 0 or not self:getNewestHasRead(paramA.targetId) then 
        ARed = true
    end

    local msgVoB = self:getCommunicateMsgVo(paramB.targetId)
    local newestSegIdB, newestTalkIdB, indexB = msgVoB:getNewestSegmentId()
    local nowTalkVoB = paramB:getTalkVo(newestSegIdB, newestTalkIdB)
    if nowTalkVoB.nextId[1] ~= 0 or not self:getNewestHasRead(paramB.targetId) then 
        BRed = true
    end

    if (ARed and BRed) or (not ARed and not BRed) then 
    	return paramA.targetId < paramB.targetId
    else
    	return ARed
    end
end

function updateCommunicate(self, msg)
	local vo = self:getCommunicateMsgVo(msg.target_id)
	local isEnd = false
	for i = #msg.next_talk_list, 1, -1 do
		isEnd = msg.next_talk_list[i] == 0
		table.insert(vo:getTalkList(msg.part_id), 1, msg.next_talk_list[i])
		
	    local segId, newestTalkId, index = vo:updateNewestInfo() -- 更新最新数据
	    local talkVo = self:getCommunicateConfig(vo.targetId):getTalkVo(segId, newestTalkId)
	    if talkVo.reward == 0 and index == 1 then 
		    braceletsCommunicate.BraceletsCommunicateManager:setNewestHasRead(vo.targetId, newestTalkId, false)
		else
			braceletsCommunicate.BraceletsCommunicateManager:setNewestHasRead(vo.targetId, newestTalkId, true)
			if index == 2 then  
				if talkVo.type == 1 and #talkVo.relation > 0 then 	--最后一段为自己对话且有奖励
					local heroVo = hero.HeroManager:getHeroConfigVo(talkVo.relation[1]) 
		            local who = heroVo.name
		            gs.Message.Show(who .. "好感度+"..talkVo.relation[2])
				elseif talkVo.reward ~= 0 then 
					braceletsCommunicate.BraceletsCommunicateManager:setNewestHasRead(vo.targetId, newestTalkId, true) 	--设置已读
				end
			else
				if talkVo.reward ~= 0 then 
					braceletsCommunicate.BraceletsCommunicateManager:setNewestHasRead(vo.targetId, newestTalkId, false)	--首次来奖励未读
				end
			end
		end
		GameDispatcher:dispatchEvent(EventName.UPDATE_COMMUNICATE_TARGET, {targetId = msg.target_id, partId = msg.part_id, talkId = msg.next_talk_list[i], isEnd = isEnd})
	end
	mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_COMMUNICATION, self:checkIsRed())
end

-- 总红点
function checkIsRed(self)
	for k,v in pairs(self.mCommunicateMsgDic) do
		local targetConfig = self:getCommunicateConfig(v.targetId)
		if targetConfig == nil then 
			logError(string.format("没有通讯配置%s", v.targetId))
		end
		local newestSegId, newestTalkId, index = v:getNewestSegmentId()
		if index == 1 then 
			local talkVo = targetConfig:getTalkVo(newestSegId, newestTalkId)
			if talkVo.nextId[1] ~= 0 or not self:getNewestHasRead(v.targetId) then 
				return true
			end
		end
	end
	return false
end

-- 分组红点
function checkClassicRed(self, isPublic)
	local targetChat = self.mPrivateChat
	if isPublic then 
		targetChat = self.mPublicChat
	end
	local count = 0
	for k,v in pairs(targetChat) do
		local msgVo = self:getCommunicateMsgVo(v.targetId)
		local newestSegId, newestTalkId, index = msgVo:getNewestSegmentId()
		if index == 1 then 
			local talkVo = v:getTalkVo(newestSegId, newestTalkId)
			if talkVo.nextId[1] ~= 0 or not self:getNewestHasRead(v.targetId) then 
				count = count + 1
				-- return true
			end
		end
	end
	return count > 0, count
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(14):	"系统"
]]
