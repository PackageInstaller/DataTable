--[[ 
-----------------------------------------------------
@filename       : MiningAi_1003
@Description    : 宝箱ai
@date           : 2023-11-29 11:07:07
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.mining.manager.ai.MiningAi_1003', Class.impl("game.mining.manager.ai.MiningAi"))


-- 碰撞触发
function colliderEnter(self, cusParent)
    self:stopAI()
    self:boom()
    self.mMinigLive:setToClawParent(cusParent)
    return true
end

function boom(self)
    self.mMinigLive:showAnim("MiningBox_Show")
    local eventId = 0
    self.mEventVo = mining.MiningManager:getEventVo(self.mEventId)
    for i, v in ipairs(self.mEventVo.skillIds) do
        local skillVo = mining.MiningManager:getEventSkillVo(self.mEventId)
        if skillVo.type == 3 then
            local maxNum = 0
            for i, v in ipairs(skillVo.param) do
                maxNum = maxNum + v[2]
            end

            local round = math.random(1, maxNum)
            for i, v in ipairs(skillVo.param) do
                if round <= v[2] then
                    eventId = v[1]
                    break
                else
                    round = round - v[2]
                end
            end
        end
    end
    if eventId == 1002 then
        -- 菠菜
        mining.MiningManager.boxCatchEventId = 0
        self.ai_1002 = require("game/mining/manager/ai/MiningAi_1002")
    else
        -- 设置宝箱抓去打开得到的事件id
        mining.MiningManager.boxCatchEventId = eventId
    end
end

-- 重置ai
function reset(self, isRecover)
    super.reset(self)
    if self.ai_1002 then
        self.ai_1002:reset()
    end
end

-- 抓取完成触发
function finishEvent(self)
    if self.ai_1002 then
        self.ai_1002:setData(1002, nil)
        self.ai_1002:boom()
    end
end


return _M