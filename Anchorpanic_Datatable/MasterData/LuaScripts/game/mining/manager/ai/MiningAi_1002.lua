--[[ 
-----------------------------------------------------
@filename       : MiningAi_1002
@Description    : 菠菜ai
@date           : 2023-11-29 11:07:07
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.mining.manager.ai.MiningAi_1002', Class.impl("game.mining.manager.ai.MiningAi"))


-- 碰撞触发
function colliderEnter(self, cusParent)
    self:stopAI()
    self:boom()
end

function boom(self)
    AudioManager:playSoundEffect(UrlManager:getUISoundPath("minigames/mng_sm_7.prefab"))
    self.mEventVo = mining.MiningManager:getEventVo(self.mEventId)
    for i, v in ipairs(self.mEventVo.skillIds) do
        local skillVo = mining.MiningManager:getEventSkillVo(self.mEventId)
        if skillVo.type == 2 then
            local overTime = GameManager:getClientTime() + skillVo.param[1]
            mining.MiningManager.spinachOverTime = overTime
            mining.MiningManager.spinachSpeed = skillVo.param[2] / 10000
            GameDispatcher:dispatchEvent(EventName.MINING_SPEED_UP)
        end
    end
    self.animTimeoutId = LoopManager:setTimeout(0.1, self, function()
        self:destroyLive()
    end)
end



return _M