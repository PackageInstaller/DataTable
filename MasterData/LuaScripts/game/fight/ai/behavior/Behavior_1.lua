module('fight.Behavior_1', Class.impl(fight.FightAI))
MoveCls = require('game/fight/ai/move/Move_1')

function ctor(self)
    -- super.ctor(self)
    self.m_move_ctl = MoveCls.new()
    self.m_livingTime = 0
    self.m_isStart = false
end

function setLiveTime(self, time)
    self.m_livingTime = time
end

function start(self)
    self.m_isStart = true
end

function stop(self)
    self.m_isStart = false
end

function step(self, deltaTime)
    if self.m_isStart then
        self.m_livingTime = self.m_livingTime-deltaTime
        if self.m_livingTime<=0 then
            -- 召唤结束
            self.m_l_vo:setHp(0)
        else
            local id = self.m_l_vo:getSummonerID()
            local summoner = fight.SceneManager:getThing(id)
            if summoner then
                local targetTile = fight.SceneUtil.removeRangeTargetTile(
                    self.m_l_vo,
                    summoner,
                    1
                )
                self.m_move_ctl:setData(self.m_l_vo)
                self.m_move_ctl:moveTo(targetTile)
            end
            super.step(self, deltaTime)
        end
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
