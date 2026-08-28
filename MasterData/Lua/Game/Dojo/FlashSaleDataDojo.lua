--region import

--endregion

--region defines

--endregion

---@class FlashSaleDataDojo
local FlashSaleDataDojo = Class('FlashSaleDataDojo')


function FlashSaleDataDojo:__init()
    self.superRewards = {} ---list 展示用超级大奖
    self.showCollectGoodsId = {} --- list 展示用可选物品
    self.rechargeId = 0 --- int购买id
    self.buyLimit = 0 --- int 购买限量
    self.stock = 0 --- int 库存
    self.countDown = 0 --- int倒计时 秒
    self.productId = 0 --- int productId
    self.channelProductId = 0 --- int channelProductId
    self.channelProducts = {} --- int channelProductId
    self.price = 0 --- int价格
    self.ruleId = 0
    self.luckyNumConf = {}
    self.windowsPriceId = 0
    self.prices = {}
end


function FlashSaleDataDojo:__delete()

end


---Fill
---填充数据
---@param jsonData table
function FlashSaleDataDojo:Fill(jsonData)
    local isSet = isSet
    local type  = type
    for key, value in pairs(jsonData) do
        --只更新自己关心的数据
        if isSet(jsonData,key) and table.haskey(self,key) then
            if type(value) == "function" then
                self[key] = checkString(value)
            elseif key == "countDown" then
                self[key] = GameUtils.ToTimeStamp(value)
            elseif key == "prices" then
                self[key] = self:ParsePrices(value)
            else
                if key == "luckyNumConf" and value.prices then
                    self.prices = self:ParsePrices(value.prices)
                end
                self[key] = value
            end
        end
    end
end

function FlashSaleDataDojo:ParsePrices(value)
    print("ParsePrices", table.toString(value))
    local prices = {}
    for goodsId, value in pairs(value) do
        prices.goodsId  = goodsId
        prices.priceNum = value.current
    end
    return prices
end

function FlashSaleDataDojo:IsGoodExchange()
    return table.count(self.prices) > 0
end

return FlashSaleDataDojo
