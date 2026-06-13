local ShopData = BaseClass("ShopData")
local M = ShopData
local tInsert = table.insert
local shopItemDataCls = require("DataCenter.Shop.ShopItemData")

function M:__init(shopId, refreshCountDown, shopItems)
    self.shopId = shopId
    self.shopConfig = ConfigHelper.GetCfgByLua("shop", shopId)
    self:UpdateData(refreshCountDown, shopItems)
end

function M:UpdateData(refreshCountDown, shopItems)
    self.refreshCountDown = refreshCountDown
    self.shopItems = {}
    if shopItems then
        local len = #shopItems

        for i = 1, len do
            local shopItemDataInst = shopItemDataCls.New(shopItems[i], self.shopId)
            tInsert(self.shopItems, shopItemDataInst)
        end

        table.sort(self.shopItems, function(a, b)
            if a.shopItemConfig and b.shopItemConfig then
                return a.shopItemConfig.order < b.shopItemConfig.order
            end
            return false
        end)
    end
end

function M:UpdateItem(shopItem)
    if not shopItem then return end --皮肤商店shopItem是没有的

    for _, v in pairs(self.shopItems) do
        if v.shopItem and (v.shopItem.ItemId == shopItem.ItemId) then
            v:UpdateData(shopItem)
            return
        end
    end

    local shopItemDataInst = shopItemDataCls.New(shopItem, self.shopId)
    tInsert(self.shopItems, shopItemDataInst)
    table.sort(self.shopItems, function(a, b)
        if a.shopItemConfig and b.shopItemConfig then
            return a.shopItemConfig.order < b.shopItemConfig.order
        end
        return false
    end)
end

function M:GetShopItemData(itemId)
    for k, v in pairs(self.shopItems) do
        if v.shopItem.ItemId == itemId then
            return v.shopItem
        end
    end
    return nil
end

function M:CheckRedPoint(id)
    for k, v in pairs(self.shopItems) do
        --存在未售罄的免费商品
        if v.type == ShopConst.ShopItemType.Free and v.Num ~= v.shopItemConfig.buyCount then
            if id and id ~= 0 then
                if v.shopItemConfig.id == id then
                    return true
                end
            else
                return true
            end
        end
    end
    return false
end

return ShopData
