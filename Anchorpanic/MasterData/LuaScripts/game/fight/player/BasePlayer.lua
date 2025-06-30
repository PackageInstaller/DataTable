module("fight.BasePlayer", Class.impl("game/fight/utils/TimeoutExecuter"))

function setData(self, expressionID, cusData)
	-- 保存player类ID
	self.m_expressionID = expressionID
	-- 用于消息判断的唯一识别
	self.m_sn = cusData[1]
	self.m_skill_vo = cusData[3]
	self.m_attacker_vo = cusData[4]
	self.m_target_vo = cusData[5]

	self.m_attacker = fight.SceneItemManager:getLivething(self.m_attacker_vo.id)
	if self.m_target_vo then
		self.m_target = fight.SceneItemManager:getLivething(self.m_target_vo.id)
	end
	--当前攻击的阶段
	self.m_attack_idx = 1;

	self:__addEvent();
	self:execute()
end

function __addEvent(self)
	GameDispatcher:addEventListener(EventName.FIGHT_SKILL_SELECT_TARGET, self.onStartAttackHandler, self)
	GameDispatcher:addEventListener(fight.AIEvent.SKILL_AI_END, self.onSkillEnd, self)
end

function __removeEvent(self)
	GameDispatcher:removeEventListener(EventName.FIGHT_SKILL_SELECT_TARGET, self.onStartAttackHandler, self)
	GameDispatcher:removeEventListener(fight.AIEvent.SKILL_AI_END, self.onSkillEnd, self)
end

function sn(self)
	return self.m_sn
end

function expressionId(self)
	return self.m_expressionID
end

function getActionTime(self,cusTime)
    return cusTime * ( 1 - self.m_attacker_vo:attSpeedInc())
end

-- 用于提供子类重载扩展的方法 BEGIN
-- 开始启动
function execute(self)
end
-- 开始执行攻击
function onStartAttackHandler(self, cusData)
	if cusData.sn == self.m_sn then
		local skillAI = fight.AIManager:getSkillAI(self.m_sn)
		if skillAI then
			skillAI:setWaitAniFinish()
		end
		self:playAttack(cusData.target)
		self.m_attack_idx = self.m_attack_idx + 1
	end
end

function onSkillEnd(self, cusData)
	if cusData.sn == self.m_sn then
		self:reset()
	end
end

-- 被打断
function onBreakSkillHandler(self, cusData)
end
-- 执行攻击逻辑
function playAttack(self, cusTarget)
end

-- 完成并回收
function reset(self)
	self:__removeEvent()
	
	super.reset(self)
	fight.PlayerManager:recoverSkillPlayer(self);
	self.m_sn = nil
end

-- 用于提供子类重载扩展的方法 END


return _M 
 
--[[ 替换语言包自动生成，请勿修改！
]]
