-------------------------------------------------------------------------------
-- 和风战牌 - 玩家数据
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-09-02 14:03:15
-------------------------------------------------------------------------------

local BattleCardGameUtils = import('Game.UI.BattleCardGame.BattleCardGameUtils')

local BaseDojo = import('Game.Dojo.BaseDojo')
---@class BattleCardGamePlayerDojo : BaseDojo
---@field New fun():BattleCardGamePlayerDojo
local BattleCardGamePlayerDojo = Class('BattleCardGamePlayerDojo', BaseDojo)


function BattleCardGamePlayerDojo:__init()
    ---@type integer @ 玩家id
    self.playerId = 0

    ---@type string @ 玩家名称
    self.playerName = ''

    ---@type integer @ 头像id
    self.avatarId = 0
    
    ---@type integer @ 头像框id
    self.frameId = 0

    ---@type integer[] @ 拥有的卡牌列表
    self.handCards = {}

    ---@type integer[] @ 打出的卡牌列表
    self.playCards = {}

    ---@type integer[] @ 打牌的顺序列表
    self.playOrder = {}

    ---@type integer @ 需要交换的卡牌位置（只互换一张）
    self.swapIndex = 0
end


function BattleCardGamePlayerDojo:__delete()
    self.playerId   = nil
    self.playerName = nil
    self.avatarId   = nil
    self.frameId    = nil
    self.handCards  = nil
    self.playCards  = nil
    self.playOrder  = nil
    self.swapIndex  = nil
end


function BattleCardGamePlayerDojo:Cleanup()
    self.playerId   = 0
    self.playerName = ''
    self.avatarId   = 0
    self.frameId    = 0
    self.handCards  = {}
    self.playCards  = {}
    self.playOrder  = {}
    self.swapIndex  = 0
end


--- 获取当前应该打出的卡牌索引
---@return integer
function BattleCardGamePlayerDojo:GetOrderCardIndex()
    -- 检测卡牌是否已经被使用
    local usedIndexMap = {}
    for _, usedIndex in ipairs(self.playCards) do
        usedIndexMap[tostring(usedIndex)] = true
    end

    -- 找到当前应该打出的卡牌
    local findCardIndex = -1
    for _, cardIndex in ipairs(self.playOrder) do
        if not usedIndexMap[tostring(cardIndex)] then
            findCardIndex = checkInt(cardIndex)
            break
        end
    end
    return findCardIndex
end


return BattleCardGamePlayerDojo
