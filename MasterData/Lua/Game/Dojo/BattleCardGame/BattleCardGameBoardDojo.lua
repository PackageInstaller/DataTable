-------------------------------------------------------------------------------
-- 和风战牌 - 棋盘数据
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-09-02 14:03:15
-------------------------------------------------------------------------------

local BattleCardGameUtils = import('Game.UI.BattleCardGame.BattleCardGameUtils')

local BaseDojo = import('Game.Dojo.BaseDojo')
---@class BattleCardGameBoardDojo : BaseDojo
---@field New fun():BattleCardGameBoardDojo
local BattleCardGameBoardDojo = Class('BattleCardGameBoardDojo', BaseDojo)


function BattleCardGameBoardDojo:__init()
    ---@type integer @ 行数
    self.rowNum = 0

    ---@type integer @ 列数
    self.colNum = 0

    ---@type integer @ 位置id
    self.siteId = 0
    
    ---@type integer @ 卡牌id
    self.cardId = 0

    ---@type integer @ 宿主id
    self.ownerId = 0

    ---@type table<string, string> @ 最新属性值
    self.attrMap = {}
end


function BattleCardGameBoardDojo:__delete()
    self.rowNum  = nil
    self.colNum  = nil
    self.siteId  = nil
    self.cardId  = nil
    self.ownerId = nil
    self.attrMap = nil
end


function BattleCardGameBoardDojo:Cleanup()
    self.cardId  = 0
    self.ownerId = 0
    self.attrMap = {}
end


---@return boolean
function BattleCardGameBoardDojo:IsEmpty()
    return self.cardId == 0
end


return BattleCardGameBoardDojo
