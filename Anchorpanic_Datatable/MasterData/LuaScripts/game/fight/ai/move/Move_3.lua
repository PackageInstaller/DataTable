module("fight.Move_3", Class.impl())

function setData(self, cusVo)
    self.m_l_vo = cusVo
    self.m_targetTrans = nil
    self.m_moveTw = nil
    self.m_rotateTw = nil
    self.m_finishCall = nil
    self.m_moveResultCall = function()
        if self.m_finishCall then self.m_finishCall() end
    end
end

-- speedTime : 速度倍数
function moveTo(self, position, finishCall, speedTime, angle, ease)
    if self.mMoveTween then
        self.mMoveTween:Kill()
    end
    if self.mRotateTween then
        self.mRotateTween:Kill()
    end
    if self.m_l_vo.position:equals(position) then
        if finishCall then finishCall() end
        return false
    end
    self.m_finishCall = finishCall
    local live = fight.SceneItemManager:getLivething(self.m_l_vo.id)
    if live and live:getTrans() then
        self.m_l_vo.position:copy(position)
        live.m_position:copy(position)
        self.mMoveTween = TweenFactory:move2pos(live:getTrans(), position, speedTime, ease, self.m_moveResultCall)
        -- fight.TweenManager:addTweener(TweenFactory:move2pos(live:getTrans(), position, speedTime, ease, self.m_moveResultCall))
        -- if not self.m_moveTw then
        -- 	self.m_moveTw = TweenFactory:move2pos(live:getTrans(), position, speedTime, ease, finishCall)
        -- 	self.m_moveTw:SetAutoKill(false)
        -- else
        -- 	self.m_moveTw:SetTarget(live:getTrans())
        -- 	self.m_moveTw:ChangeEndValue(position, false)
        -- 	if ease then
        -- 		self.m_moveTw:SetEase(ease)
        -- 	end
        -- 	self.m_moveTw:Restart()
        -- end
        if angle ~= nil then
            self.mRotateTween = fight.TweenManager:addTweener(TweenFactory:lRotateY(live:getTrans(), angle, speedTime))
        end
        return true
    end

    if finishCall then finishCall() end
    return false
end

function reset(self)
    self.m_finishCall = nil
    -- self.m_l_vo:stopMove(nil)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]