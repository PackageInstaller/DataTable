--[[****************************************************************************
Brief  :战斗CD冷却管理
Author :Zzz
Date   :2020-03-2
****************************************************************************
]]
module('fight.CDManager', Class.impl('lib.event.EventDispatcher'))

-- 技能cd结束
SKILL_CD_FINISH = "SKILL_CD_FINISH"

function ctor(self)
	super.ctor(self)
	self:__init()
end

function dtor(self)
end

function __init(self)
	-- CD存储
	self.cdDic = {}
	self.m_rate_residue = 0
end

function __isNeedCdTick(self, cusSkillVo)
	if(cusSkillVo.type == SkillType.SKILL) then
		return true
	end
	return false
end

-- 检测攻方或者守方的某个技能是否在冷却中
function isCDing(self, cusLivethingId, cusSkillVo)
	if(self:__isNeedCdTick(cusSkillVo)) then
		if self.cdDic[cusLivethingId] and self.cdDic[cusLivethingId] [cusSkillVo.id] then
			local cdVo = self.cdDic[cusLivethingId] [cusSkillVo.id]
			if cdVo == nil then
				return true
			end
			return cdVo.skillCd > 0
		end
	end
	return true
end

-- 设置当前攻防双方技能（主动技能）
function setAllSkill(self, cusLivethingDic)
	self:__init()
	
	for _, livethingVo in pairs(cusLivethingDic) do
		local skillList = livethingVo:getSkills()
		if skillList then
			for _, skillVo in pairs(skillList) do
				if(self:__isNeedCdTick(skillVo)) then
					local cdVo = LuaPoolMgr:poolGet(fight.CdDicVo)
					cdVo:setData(livethingVo, skillVo)
					if(self.cdDic[cdVo.livethingId] == nil) then
						self.cdDic[cdVo.livethingId] = {}
					end
					self.cdDic[cdVo.livethingId] [cdVo.skillId] = cdVo
					-- print("开始设置：", cdVo.livethingId, cdVo.skillId, cdVo.skillCd)
				end
			end
		end
	end

	RateLooper:addFrame(1, 0, self, self.__step)
end

-- 开始冷却攻方或守方技能
function resetCd(self, cusLivethingId, cusSkillVo)
	if(self:__isNeedCdTick(cusSkillVo)) then
		-- print("技能冷却:", cusLivethingId, cusSkillVo.id)
		if(self.cdDic[cusLivethingId] and self.cdDic[cusLivethingId] [cusSkillVo.id]) then
			-- 获取技能cd减少百分比
			-- local cdp = livethingVo:getAtt(fight.AttConst.ATTR_CD_DEC) - livethingVo:getAtt(fight.AttConst.ATTR_CD_ADD_DEC)
			-- cdp = math.min(cdp * 0.0001, 0.7)
			local cdp
			local cdVo = self.cdDic[cusLivethingId] [cusSkillVo.id]
			local skillConfigVo = fight.SkillManager:getSkillRo(cusSkillVo.id)
			if(skillConfigVo ~= nil) then
				cdp = 0
				cdVo.skillCd = skillConfigVo.skillCd *(1 - cdp)
			end
		end
	end
end

-- 获取某个技能的剩余冷却cd
function getRemainValue(self, cusLivethingId, cusSkillId)
	local cdVo = self.cdDic[cusLivethingId] [cusSkillId]
	local value = cdVo.skillCd
	return value
end

function __step(self, deltaTime)
	local function _cdStep(t)
		local cd
		for isAttaker, _ in pairs(self.cdDic) do
			for skillId, cdVo in pairs(_) do
				cd = math.max(cdVo.skillCd - t, 0)
				if(cdVo.skillCd > 0 and cd == 0) then
					self:dispatchEvent(SKILL_CD_FINISH, cdVo)
				end
				cdVo.skillCd = cd
			end
		end
	end
	
	local frame = RateLooper.FRAME
	local frameTime = 1 / frame
	
	-- 非整数速率累计到下次
	local rate = RateLooper:getPlayRate()
	local rate, residue = math.modf(rate);
	self.m_rate_residue = self.m_rate_residue + residue
	local integer, residue = math.modf(self.m_rate_residue)
	self.m_rate_residue = residue
	rate = rate + integer
	
	-- 延迟补帧数
	local applyCount = math.max(math.floor(deltaTime / frameTime), 1)
	-- 先取消延迟补帧
	applyCount = 1
	-- -- 时差设为真实时差(按60帧但游戏如果按高帧执行会导致计时变快)
	-- frameTime = LoopManager:getDeltaTime()
	
	for i = 1, applyCount do
		if rate <= 1 then		--减速/原速
			_cdStep(frameTime)
		else					--加速
			for j = 1, rate do
				_cdStep(frameTime)
			end
		end
	end
end

-- 战斗结束后，重置
function reset(self)
	for livethingId, _ in pairs(self.cdDic) do
		for skillId, cdVo in pairs(_) do
			LuaPoolMgr:poolRecover(cdVo)
		end
	end
	self.cdDic = {}
	RateLooper:removeFrame(self, self.__step);
end

-- -- 减CD
-- function cutCD(self, cusLivethingId, cusSkillId, cusCd)
--     local cdVo = self.cdDic[cusLivethingId][cusSkillId]
--     cdVo.skillCd = cdVo.skillCd - cusCd
-- end
-- -- 清除CD
-- function clearCD(self, cusLivethingId, cusSkillId)
--     local cdVo = self.cdDic[cusLivethingId][cusSkillId]
--     cdVo.skillCd = 0
-- end
return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
