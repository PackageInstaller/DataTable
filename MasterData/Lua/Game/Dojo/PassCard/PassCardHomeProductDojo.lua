-------------------------------------------------------------------------------
-- Pass卡 - 主页商品数据
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-11-29 16:19:28
-------------------------------------------------------------------------------

local BaseDojo = import('Game.Dojo.BaseDojo')

---@class PassCardHomeProductDojo : BaseDojo
---@field New fun():PassCardHomeProductDojo
local PassCardHomeProductDojo = Class('PassCardHomeProductDojo', BaseDojo)


function PassCardHomeProductDojo:__init()
    ---@type integer @ 商品id
    self.productId = 0

    ---@type string @ 渠道商品id
    self.channelProductId = 0

    ---@type table<string, string> @ 渠道id映射字典
    self.channelProducts = {}

    ---@type string @ 价格
    self.price = 0

    ---@type table[] @ 钻石购买价格 如果为空不支持钻石购买
    self.prices = {}

    ---@type table @ 原始数据（支付用）
    self.originData = nil
end


function PassCardHomeProductDojo:__delete()
    self.productId        = nil
    self.channelProductId = nil
    self.channelProducts  = nil
    self.price            = nil
    self.prices           = nil
end


---@param jsonData table
---@return PassCardHomeProductDojo
function PassCardHomeProductDojo:Fill(jsonData)
    BaseDojo.Fill(self, jsonData)

    self.prices = {}
    for currencyId, currencyData in pairs(checkTable(jsonData.prices)) do
        table.insert(self.prices, {
            goodsId = checkInt(currencyId),
            num     = checkNumber(currencyData.current),
        })
    end

    self.originData = jsonData

    return self
end


return PassCardHomeProductDojo
