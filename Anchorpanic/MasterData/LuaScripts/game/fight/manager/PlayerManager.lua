module("PlayerManager", Class.impl())
--构造函数
function ctor(self)
	self.m_skillPlayerDic = {};
	self.m_skillPlayerClsDic ={};
	self.m_waitSkillPlayerGCDic = {};
	self.m_isRename = false
end

--析构函数

function dtor(self)

end

function setIsRename(self, beRename)
	self.m_isRename = beRename
end

function getIsRename(self)
	return self.m_isRename
end

-----skill player-----
function creaetSkillPlayer(self,cusData)
	if cusData==nil then return end
	local expressionID = cusData[2]
	local player = self:__getSkillPlayer(expressionID)
	player:setData(expressionID, cusData)
	self.m_skillPlayerDic[player:sn()] = player
end

function breakSkillPlayer(self,cusSn)
	local player = self.m_skillPlayerDic[cusSn]
	if player ~= nil then
		player:onBreakSkillHandler();
	end
end

function __getSkillPlayer(self,cusExpressionId)
	local playerCls = self:__loadSkillPlayer(cusExpressionId)

	local idx = self.m_waitSkillPlayerGCDic[cusExpressionId]
	if idx ~=nil then
		RateLooper:clearTimeout(idx)
		self.m_waitSkillPlayerGCDic[cusExpressionId] = nil
	end
	local player = LuaPoolMgr:poolGet(playerCls)
	return player
end

function recoverSkillPlayer(self,cusPlayer)
	self.m_skillPlayerDic[cusPlayer:sn()] = nil
	LuaPoolMgr:poolRecover(cusPlayer)
	if LuaPoolMgr:getPoolQuoteCount(cusPlayer.class) == 0 then
		local id = cusPlayer:expressionId()
		self.m_waitSkillPlayerGCDic[id] = RateLooper:setTimeout(60,self,self.__unloadSkillPlayer,id)
	end
end

function recoverAllSkillPlayer(self)
	for k,v in pairs(self.m_skillPlayerDic) do
		self:recoverSkillPlayer(v);
	end
end

function __getSkillPlayerClsName(self,cusExpressionId)
	return "game/fight/player/Player_"..cusExpressionId
end

function __loadSkillPlayer(self,cusExpressionId)
	if self.m_skillPlayerClsDic[cusExpressionId] == nil then
		local clsPath = self:__getSkillPlayerClsName(cusExpressionId)
		--print("load skill player=>",clsPath)
		self.m_skillPlayerClsDic[cusExpressionId] = require(clsPath)
	end
	return self.m_skillPlayerClsDic[cusExpressionId]
end

function __unloadSkillPlayer(self,cusExpressionId)
	LuaPoolMgr:clearClsPool(self.m_skillPlayerClsDic[cusExpressionId])
	self.m_skillPlayerClsDic[cusExpressionId] = nil
	local playerClsName = self:__getSkillPlayerClsName(cusExpressionId)
	--print("__unloadSkillPlayer=>",cusExpressionId)

	package.loaded[playerClsName] = nil
	_G["fight"]["Player_"..cusExpressionId] = nil
end


-----skill player end-----

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
