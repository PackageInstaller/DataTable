module("fight.Player_1000", Class.impl("game/fight/player/BasePlayer"))

function playAttack(self, cusTarget)
    self.m_attacker:updateAniSpeed()
    self.m_attacker:playAttack("3")
    -- self.m_attacker:turnDirByVector(self.m_target_vo.position)
    self:setTimeout(self:getActionTime(0.3), self, self.attUp)
    self:setTimeout(self:getActionTime(1.5), self, self.attDown)
end

function attUp(self)
    local tp = self.m_target_vo.position
    self.oldY = tp.y
    tp.y = tp.y + 2

    self.m_target:playAction('idle')

    if self.m_target.m_tran then
        self.m_target_tweener = TweenFactory:move2Lpos(self.m_target.m_tran, tp, self:getActionTime(0.3))
        fight.TweenManager:addTweener(self.m_target_tweener)
    end

end

function attDown(self)
    local tp = self.m_target_vo.position
    tp.y = self.oldY

    if self.m_target.m_tran then
        self.m_target_tweener = TweenFactory:move2Lpos(self.m_target.m_tran, tp, self:getActionTime(0.1))
        fight.TweenManager:addTweener(self.m_target_tweener)
    end

    local v3 = gs.Vector3(0, 1, 0)
    gs.CameraShakeUtil.Trigger(v3);

    self:reset()
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
