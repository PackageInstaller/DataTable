-------------------------------------------------------------------------------
-- 夜寻迷宫 - 关卡商店道具数据
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-01-03 20:38:57
-------------------------------------------------------------------------------

local BaseDojo = import('Game.Dojo.BaseDojo')
---@class PatrolMazeQuestProducttDojo : BaseDojo
---@field New fun():PatrolMazeQuestProducttDojo
local PatrolMazeQuestProducttDojo = Class('PatrolMazeQuestProducttDojo', BaseDojo)


function PatrolMazeQuestProducttDojo:__init()
    ---@type integer @ 商品id
    self.productId = 0

    ---@type integer @ 道具id
    self.goodsId = 0

    ---@type integer @ 道具数量
    self.goodsNum = 0

    ---@type integer @ 总库存（-1无限）
    self.totalStock = 0

    ---@type integer @ 当前库存（-1无限）
    self.currentStock = 0

    ---@type table<string, table> @ 价格map（key：货币id）
    self.priceDataMap = {}

    ---@type table[] @ 价格信息列表
    self.priceDataList = {}
end


function PatrolMazeQuestProducttDojo:__delete()
    self.productId     = nil
    self.goodsId       = nil
    self.goodsNum      = nil
    self.totalStock    = nil
    self.currentStock  = nil
    self.priceDataMap  = nil
    self.priceDataList = nil
end


---@param jsonData table
---@return PatrolMazeQuestProducttDojo
function PatrolMazeQuestProducttDojo:Fill(jsonData)
    self.productId    = checkInt(jsonData.productId)
    self.goodsId      = checkInt(jsonData.goodsId)
    self.goodsNum     = checkInt(jsonData.num)
    self.totalStock   = checkInt(jsonData.stock)
    self.currentStock = checkInt(jsonData.currentStock)
    self.priceDataMap = checkTable(jsonData.prices)
    self.priceDataList = {}
    for currencyId, _ in pairs(self.priceDataMap) do
        table.insert(self.priceDataList, {
            currency = checkInt(currencyId),
            current  = self:GetCurrentPrice(currencyId),
            original = self:GetOriginalPrice(currencyId),
        })
    end
    return self
end


--- 获取当前售价
---@param currencyId integer
---@return number
function PatrolMazeQuestProducttDojo:GetCurrentPrice(currencyId)
    return checkNumber(checkTable(self.priceDataMap[tostring(currencyId)]).current)
end


--- 获取原始售价
---@param currencyId integer
---@return number
function PatrolMazeQuestProducttDojo:GetOriginalPrice(currencyId)
    return checkNumber(checkTable(self.priceDataMap[tostring(currencyId)]).original)
end


return PatrolMazeQuestProducttDojo
