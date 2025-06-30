module("fight.Player_3040", Class.impl("game/fight/player/BasePlayer"))

function playAttack(self, cusTarget)
	self.m_attacker:updateAniSpeed()
	self.m_attacker:playAttackQueue({"1","2"})
	self:reset()
end

return _M 
 
--[[ 替换语言包自动生成，请勿修改！
]]
