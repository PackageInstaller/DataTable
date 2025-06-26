module("fight.Player_1", Class.impl("game/fight/player/BasePlayer"))

function playAttack(self, cusTarget)
	if not self.m_attacker then
		return
	end
	
	self.m_attacker:updateAniSpeed()
	-- self.m_attacker:playAction(math.random(fight.FightDef.ACT_SKILL_MIX, fight.FightDef.ACT_SKILL_MAX))
	local function _finishCall()
		fight.FightManager:checkReturnCamera(self.m_attacker_vo.id)
		local skillAI = fight.AIManager:getSkillAI(self.m_sn)
		if skillAI then
			skillAI:onAniFinish()
		end
		self:reset()
	end

	if self.m_skill_vo:getType()==fight.FightDef.SKILL_TYPE_FINAL_SKILL then
		fight.FightManager:focusOnLive(self.m_attacker_vo.id)
		self.m_attacker:playAction(fight.FightDef.ACT_SKILL_MIX, _finishCall)
	elseif self.m_skill_vo:getType()==fight.FightDef.SKILL_TYPE_AOYI_SKILL then
		fight.FightManager:focusOnLive(self.m_attacker_vo.id)
		self.m_attacker:playAction(fight.FightDef.ACT_SKILL_MAX, _finishCall)
	elseif self.m_skill_vo:getType()==fight.FightDef.SKILL_TYPE_ACTIVE_SKILL then
		self.m_attacker:playAction(fight.FightDef.ACT_SKILL_1, _finishCall)
	else
		self.m_attacker:playAction(fight.FightDef.ACT_ATTACK_1, _finishCall)
	end

	-- if self.m_target_vo then
	-- 	self.m_attacker:turnDirByVector(self.m_target_vo.position)
	-- end
	
end

return _M 
 
--[[ 替换语言包自动生成，请勿修改！
]]
