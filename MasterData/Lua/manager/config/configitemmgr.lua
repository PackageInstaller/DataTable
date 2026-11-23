
ConfigItemMgr = {}

local itemTypeMap = nil

ConfigItemMgr.GetItemById = function(itemId)
    return ConfigMgr.Config.itemMap[itemId]
end

ConfigItemMgr.GetItemsByType = function(itemType)
    local itemTypes
    if itemTypeMap == nil then
        itemTypeMap = {}
        for k, temp in pairs(ConfigMgr.Config.itemMap) do
            if itemTypeMap[temp.type] == nil then
                itemTypeMap[temp.type] = {}
            end
            table.insert(itemTypeMap[temp.type], temp)
        end
        for k, v in pairs(itemTypeMap) do
            table.sort(v, function(a, b)
                return tonumber(a.id) < tonumber(b.id)
            end)
        end
    end
    itemTypes = itemTypeMap[itemType]
    return itemTypes
end

ConfigItemMgr.GetItemExchangeConfig = function(exchangeId)
    local exchangeConfig = ConfigMgr.Config.ItemsExchangeMap[exchangeId]
    if exchangeConfig ~= nil then
        return exchangeConfig
    end
end