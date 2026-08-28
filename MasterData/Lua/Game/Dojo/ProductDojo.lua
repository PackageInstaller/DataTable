

---@class ProductDojo
local ProductDojo = Class("ProductDojo")

function ProductDojo:__init(jsonData)
    ---@type number
    self.productId = jsonData.productId
    ---@type number
    self.channelProductId = jsonData.channelProductId
    ---@type number | nil
    self.windowsPriceId = jsonData.windowsPriceId
    ---@type string | nil
    self.price = jsonData.price
    ---@type table
    self.prices = jsonData.prices
    ---@type table | nil
    self.channelProducts = jsonData.channelProducts
end

function ProductDojo:__delete()
end

return ProductDojo