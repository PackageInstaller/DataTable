-------------------------------------------------------------------------------
-- 和风战牌 - 卡牌信息
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-07-16 14:24:31
-------------------------------------------------------------------------------

local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class BattleCardGameCardInitVo : SettingRefBase @ AutoIds.IdSetting10002
local BattleCardGameCardInitVo = Class('BattleCardGameCardInitVo', SettingRefBase)


function BattleCardGameCardInitVo:__init()
    ---@type integer @ 卡牌id
    self.cardId = 0

    ---@type integer[] @ 所在初始卡组（不填表示不进初始卡组的初始卡，卡组为1-4，每个卡组必须为5卡）	
    self.deckList = {}

    ---@type table @ 所在初始卡组map
    self.deckMap = {}
end


function BattleCardGameCardInitVo:__delete()
    self.cardId   = nil
    self.deckList = nil
    self.deckMap  = nil
end


---@param row TableML.TableFileRow
---@return BattleCardGameCardInitVo
function BattleCardGameCardInitVo:FillVo(row)
    SettingRefBase.FillVo(self, row)

    self.cardId   = parse_number(row, 'id')
    self.deckList = parse_numbers(row, 'inDeck')

    self.deckMap = {}
    for _, deckId in ipairs(self.deckList) do
        self.deckMap[deckId] = true
    end

    return self
end


--- 是否 在初始卡组中
---@return boolean
function BattleCardGameCardInitVo:IsInDeck()
    return #self.deckList > 0
end


return BattleCardGameCardInitVo
