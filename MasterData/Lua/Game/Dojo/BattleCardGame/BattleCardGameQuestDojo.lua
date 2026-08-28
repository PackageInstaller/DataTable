-------------------------------------------------------------------------------
-- 和风战牌 - 关卡数据
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-07-18 17:12:53
-------------------------------------------------------------------------------

local BaseDojo = import('Game.Dojo.BaseDojo')
---@class BattleCardGameQuestDojo : BaseDojo
---@field New fun():BattleCardGameQuestDojo
local BattleCardGameQuestDojo = Class('BattleCardGameQuestDojo', BaseDojo)


function BattleCardGameQuestDojo:__init()
    ---@type integer @ 关卡id（npc id）
    self.questId = 0

    ---@type integer @ 剩余奖励次数
    self.leftRewardTimes = 0
end


function BattleCardGameQuestDojo:__delete()
    self.questId         = nil
    self.leftRewardTimes = nil
end


---@param jsonData table
---@return BattleCardGameQuestDojo
function BattleCardGameQuestDojo:Fill(jsonData)
    BaseDojo.Fill(self, jsonData)

    self.questId         = checkInt(jsonData.npcId)
    self.leftRewardTimes = checkInt(jsonData.leftRewardTimes)

    return self
end


return BattleCardGameQuestDojo
