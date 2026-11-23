
PlayerItemMgr = {
tipsItem = "",
needCount = 0,
vmName = "",
}


PlayerItemMgr.GetItemById = function(id)
    return DataMgr.Player.items[id]
end


PlayerItemMgr.GetItemCountById = function(id)
    local item = PlayerItemMgr.GetItemById(id)
    if item ~= nil then
        return item.count0
    end
    return 0
end


PlayerItemMgr.GetItemEnough = function(items)
    if IsNull(items) then
        return true
    end
    for i, item in ipairs(items) do
        local itemTemp = PlayerItemMgr.GetItemById(item.id)
        if itemTemp == nil then
            return false
        end
        if itemTemp.count0 < item.count then
            return false
        end
    end
    return true
end


PlayerItemMgr.SetTipsItem = function(itemId, needCount, vmName)
    PlayerItemMgr.tipsItem = itemId;
    PlayerItemMgr.needCount = needCount or 0;
    PlayerItemMgr.vmName = vmName;
end


PlayerItemMgr.GetTipsItem = function()
    return PlayerItemMgr.tipsItem;
end


PlayerItemMgr.GetNeedCount = function()
    return PlayerItemMgr.needCount;
end


PlayerItemMgr.GetVMName = function()
    return PlayerItemMgr.vmName;
end


PlayerItemMgr.IsFormulaLock = function(group, itemId)
    local buildingConfig = PlayerFoundationMgr.GetBuildingConfigByGroup(group);
    if (buildingConfig ~= nil) then
        local yieldsItem = buildingConfig.YieldsItem;
        local formulaMap = ConfigMgr.Config.FormulaMap;
        for _, v in pairs(formulaMap) do
            if (v.RecipeGroup == yieldsItem) then
                if (v.Produce[1].id == itemId) then
                    return not v.Unlock;
                end
            end
        end
    end
    return true;
end