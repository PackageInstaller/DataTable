module("AIManager", Class.impl())
--构造函数
function ctor(self)
	self.m_fightAIDic = {}

	self.m_skillAIDic = {}
	self.m_skillAIClsDic ={}
	self.m_waitSkillAIGCDic = {}

	self:preloadAIFiles();
end
-- --析构函数
-- function dtor(self)
-- end

function preloadAIFiles(self)
	for i = 0 , 6 do 
		self.m_skillAIClsDic[i] = require( self:__getSkillAIClsPath(i) )
	end

	require(self:__getFightAIClsPath(1));
end

function disposeAll(self)
	self:recoverAllFightAI()
end

-- 通过live数据创建战斗ai
function createFightAI(self,liveVo)
	local ai = self:__createFightAI(liveVo)
	ai:setData(liveVo)
	self.m_fightAIDic[liveVo.id] = ai
	return ai
end
-- 回收战斗ai
function recoverFightAI(self,liveID)
	if self.m_fightAIDic[liveID] == nil then
		return
	end
	local ai = self.m_fightAIDic[liveID]
	self.m_fightAIDic[liveID] = nil
	ai:reset()
	self:__recoverFightAI(ai)
end

-- 回收所有战斗ai
function recoverAllFightAI(self)
	for k,v in pairs(self.m_fightAIDic) do
		self:recoverFightAI(k);
	end
end

-- 通过liveID获取战斗ai
function getFightAI(self, liveID)
	local ai = self.m_fightAIDic[liveID]
	if ai==nil then
		Debug:log_warn("AIManager", "liveID [%d] no this ai !!!", liveID)
		return
	end
	return ai
end

function __createFightAI(self, liveVo)
	if liveVo.m_fightAI_ID~=nil then
		local clsPath = self:__getFightAIClsPath(liveVo.m_fightAI_ID)
		local cls = require(clsPath)
		if not cls then
			Debug:log_warn("AIManager", "%s fail !!!", clsPath)
			return nil
		end
		local obj = cls.new()
		obj.__nobaseCls = true
		return obj
	else
		return LuaPoolMgr:poolGet(fight.FightAI)
	end
end

function __recoverFightAI(self,fightAI)
	if fightAI.__nobaseCls then
		Class.delete(fightAI)
		return
	end
	LuaPoolMgr:poolRecover(fightAI)
end


function __getFightAIClsPath(self,fightaiID)
	return "game/fight/ai/behavior/Behavior_"..fightaiID
end

-----skill ai-----
-- 创建技能ai
function createSkillAI(self,skillID)
	local aiCls = self:__loadSkillAI(skillID)

	local idx = self.m_waitSkillAIGCDic[skillID]
	if idx ~=nil then
		RateLooper:clearTimeout(idx)
		self.m_waitSkillAIGCDic[skillID] = nil
	end
	local ai = LuaPoolMgr:poolGet(aiCls)
	self.m_skillAIDic[ai:sn()] = ai
	return ai
end
-- 获取角色的技能ai
function getSkillAIList(self, liveID)
	local rets = {}
	for _,ai in pairs(self.m_skillAIDic) do
		if ai:liveID()==liveID then
			table.insert(rets, ai)
		end
	end
	return rets
end
-- 获取一个技能ai
function getSkillAI( self, skillSn )
	return self.m_skillAIDic[skillSn]
end
-- 回收技能ai
function recoverSkillAI(self,skillAI)
	self.m_skillAIDic[skillAI:sn()] = nil
	LuaPoolMgr:poolRecover(skillAI)
	if LuaPoolMgr:getPoolQuoteCount(skillAI.class) == 0 then
		local id = skillAI:skillID()
		self.m_waitSkillAIGCDic[id] = RateLooper:setTimeout(2,self,self.__unloadSkillAI,id)
	end
end

function __getSkillAIClsPath(self,skillID)
	return "game/fight/ai/skill/Skill_"..skillID
end

function __loadSkillAI(self,skillID)
	if self.m_skillAIClsDic[skillID] == nil then
		-- skillID = math.random( 1,6 )
		local clsPath = self:__getSkillAIClsPath(skillID)
		--print("load skill ai=>",clsPath)
		local function _tryRequire()
            self.m_skillAIClsDic[skillID] = require(clsPath)
		end
		if not pcall(_tryRequire) then
			Debug:log_warn("AIManager", "no class [%s] !!!", clsPath)
		end
	end
	return self.m_skillAIClsDic[skillID]
end

function __unloadSkillAI(self,skillID)
	LuaPoolMgr:clearClsPool(self.m_skillAIClsDic[skillID])
	self.m_skillAIClsDic[skillID] = nil
	local clsPath = self:__getSkillAIClsPath(skillID)

	package.loaded[clsPath] = nil
	_G["fight"]["Skill_"..skillID] = nil
end
-----skill ai end-----

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
