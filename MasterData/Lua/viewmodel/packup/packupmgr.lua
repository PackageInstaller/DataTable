PackUpMgr = {
    eventsListGroupMap = {},
    eventsListAreaMap = {},

    novelIndex = 0,
    showAni = true,
    puzzleUIList = {},
    gridUIList = {},
    puzzleMap = {},
    gridsMap = {},
    savePlacedItemsTb = {},

    curPackData = {},
    gridDataMap = {},

    tranItems = nil,
    puzzleScrollView = nil,
    config = nil,
}

PackUpMgr.InitPackage = function(rootTf, config)
    if not rootTf or not config then
        LuaDebug.error("InitPackage: 参数不能为空")
        return
    end

    PackUpMgr.tranItems = rootTf:Find("root/Middle/imgBG/tranItems"):GetComponent("RectTransform")
    local tranZeroPos = rootTf:Find("root/Middle/imgBG/tranItems/tranZeroPos"):GetComponent("Transform")

    local nullMap = {}
    if config.PackNull then
        for _, v in ipairs(config.PackNull) do
            nullMap[v] = true
        end
    end

    local gridDataMap = {}
    local packSize = config.PackSize or { 0, 0 }
    local rows, cols = packSize[1], packSize[2]

    local index = 0
    for i = 1, rows do
        for j = 1, cols do
            index = index + 1
            local key = (i - 1) .. "," .. (j - 1)
            gridDataMap[key] = nullMap[index] and 2 or 0
        end
    end

    PackUpMgr.SavePlacedItems = {}
    PackUpMgr.savePlacedItemsTb = {}
    PackUpMgr.curPackData = {
        start_pos = tranZeroPos.anchoredPosition,
        cell_size = tranZeroPos.rect.width,
        grid_rows = rows,
        grid_cols = cols,
        InitGrid = gridDataMap
    }
    PackUpMgr.gridDataMap = gridDataMap
end

PackUpMgr.PuzzleOnBeginDrag = function(scrPosition, itemKey)
    local puzzleItem = PackUpMgr.puzzleMap[itemKey]
    if not puzzleItem then return end

    puzzleItem:OnBeginDragHandler(scrPosition)

    if PackUpMgr.savePlacedItemsTb[itemKey] then
        PackUpMgr.savePlacedItemsTb[itemKey] = nil
        PackUpMgr.SetGrid()
    end
end

PackUpMgr.PuzzleOnDrag = function(scrPosition, itemKey)
    local puzzleItem = PackUpMgr.puzzleMap[itemKey]
    if not puzzleItem then return end

    puzzleItem:OnDragHandler(scrPosition)

    local ok, occ, placeAnchor = PackUpMgr.TryPlaceByWorldAnchor(puzzleItem)
    PackUpMgr.RefreshGridsState(occ, ok and 3 or 2)
end

PackUpMgr.PuzzleOnPointUp = function(itemKey)
    local puzzleItem = PackUpMgr.puzzleMap[itemKey]
    if not puzzleItem then return end

    local ok, occ, placeAnchor = PackUpMgr.TryPlaceByWorldAnchor(puzzleItem)

    if ok then
        puzzleItem.placed_at = placeAnchor
        local key = placeAnchor.x .. "," .. placeAnchor.y
        local grid = PackUpMgr.gridsMap[key]

        if grid then
            puzzleItem.transform.position = grid.transform.position
            PackUpMgr.savePlacedItemsTb[itemKey] = puzzleItem
            PackUpMgr.SetGrid()
            PackUpMgr.CheckPuzzleWin(puzzleItem)
        end
    else
        if PackUpMgr.CheckIsCollectPuzzle(puzzleItem) then
            PackUpMgr.CollectPuzzleItem(puzzleItem)
            puzzleItem.placed_at = nil
        elseif puzzleItem.placed_at then
            local key = puzzleItem.placed_at.x .. "," .. puzzleItem.placed_at.y
            local grid = PackUpMgr.gridsMap[key]
            if grid then
                puzzleItem.transform.position = grid.transform.position
                PackUpMgr.savePlacedItemsTb[itemKey] = puzzleItem
            end
            PackUpMgr.SetGrid()
        else
            PackUpMgr.SetGrid()
            PackUpMgr.CollectPuzzleItem(puzzleItem)
        end
    end
end

PackUpMgr.RefreshGridsState = function(grids, state)
    for k, v in pairs(PackUpMgr.gridDataMap) do
        local grid = PackUpMgr.gridsMap[k]
        if grid then
            grid:CheckState(v)
        end
    end

    if grids then
        for _, v in ipairs(grids) do
            local key = v.x .. "," .. v.y
            local grid = PackUpMgr.gridsMap[key]
            if grid then
                grid:CheckState(state)
            end
        end
    end
end

PackUpMgr.SetGrid = function()
    local occupiedSet = {}
    for _, p in pairs(PackUpMgr.savePlacedItemsTb) do
        if p.grid_points and p.placed_at then
            for _, q in ipairs(p.grid_points) do
                local keyX = p.placed_at.x + q.x
                local keyY = p.placed_at.y + q.y
                occupiedSet[keyX .. "," .. keyY] = true
            end
        end
    end

    PackUpMgr.gridDataMap = {}
    for k, v in pairs(PackUpMgr.curPackData.InitGrid) do
        if occupiedSet[k] and v == 0 then
            PackUpMgr.gridDataMap[k] = 1
        else
            PackUpMgr.gridDataMap[k] = v
        end
    end

    for k, v in pairs(PackUpMgr.gridDataMap) do
        local grid = PackUpMgr.gridsMap[k]
        if grid then
            grid:CheckState(v)
        end
    end
end

PackUpMgr.ResetPlacedItems = function()
    for k, v in pairs(PackUpMgr.savePlacedItemsTb) do
        v.placed_at = nil
        PackUpMgr.CollectPuzzleItem(v)
    end
    PackUpMgr.savePlacedItemsTb = {}
    PackUpMgr.SetGrid()
end

PackUpMgr.CheckIsCollectPuzzle = function(puzzleItem)
    if not puzzleItem or not PackUpMgr.tranItems then
        return false
    end

    local threshold = (PackUpMgr.tranItems.sizeDelta.x / 2) + PackUpMgr.tranItems.anchoredPosition.x
    return puzzleItem.transform.anchoredPosition.x > threshold
end

PackUpMgr.CollectPuzzleItem = function(puzzleItem)
    if not puzzleItem or not PackUpMgr.puzzleScrollView then
        return
    end
    puzzleItem:RestSize()
    puzzleItem.transform.parent = PackUpMgr.puzzleScrollView.content

    if puzzleItem.data then
        puzzleItem.data.isInit = true
    end
    puzzleItem.transform:SetSiblingIndex()
end

PackUpMgr.InitPackGridMap = function(indexKeyMap)
    PackUpMgr.gridsMap = {}
    if not PackUpMgr.gridUIList or not PackUpMgr.gridUIList.itemList then
        return
    end

    for i, v in ipairs(PackUpMgr.gridUIList.itemList) do
        local posKey = indexKeyMap[i]
        if posKey then
            PackUpMgr.gridsMap[posKey] = v
        end
    end
end

PackUpMgr.InitPackItemMap = function(indexKeyMap)
    PackUpMgr.puzzleMap = {}
    if not PackUpMgr.puzzleUIList or not PackUpMgr.puzzleUIList.itemList then
        return
    end

    for i, v in ipairs(PackUpMgr.puzzleUIList.itemList) do
        local posKey = indexKeyMap[i]
        if posKey then
            PackUpMgr.puzzleMap[posKey] = v
        end
    end
end

PackUpMgr.TryPlaceByWorldAnchor = function(_item)
    if not _item or not _item.transform then
        return false, {}, { x = 0, y = 0 }
    end

    local gx, gy = PackUpMgr.WorldToNearestCell(_item.transform.anchoredPosition)
    if not gx then
        return false, {}, { x = 0, y = 0 }
    end

    local placeAnchor = { x = gx, y = gy }
    local ok, occ = PackUpMgr.CanPlaceItemAt(PackUpMgr.curPackData, _item, placeAnchor)
    return ok, occ, placeAnchor
end

PackUpMgr.WorldToNearestCell = function(worldPos)
    if not worldPos or not PackUpMgr.curPackData then
        return nil
    end

    local bag = PackUpMgr.curPackData
    local s = bag.cell_size

    local gx_f, gy_f = PackUpMgr.worldToGridFloat(bag, worldPos)

    local function round_nearest(x)
        return x >= 0 and math.floor(x + 0.5) or math.ceil(x - 0.5)
    end

    local gx = round_nearest(gx_f)
    local gy = round_nearest(gy_f)

    local center_world_x = bag.start_pos.x + gx * s
    local center_world_y = bag.start_pos.y + gy * s

    local thr = s * 0.6
    local dx = worldPos.x - center_world_x
    local dy = worldPos.y - center_world_y
    local d2 = dx * dx + dy * dy

    if d2 > thr * thr then
        return nil
    end

    return gx, gy, { x = center_world_x, y = center_world_y }
end

PackUpMgr.worldToGridFloat = function(bag, world)
    local s = bag.cell_size
    local sx = bag.start_pos.x
    local sy = bag.start_pos.y
    local gx_f = (world.x - sx) / s
    local gy_f = (world.y - sy) / s
    return gx_f, gy_f
end

PackUpMgr.CanPlaceItemAt = function(bag, item, placeAnchor)
    if not bag or not item or not item.grid_points or not placeAnchor then
        return false, {}
    end

    local occ = {}
    local pass = true

    for _, p in ipairs(item.grid_points) do
        local gx = placeAnchor.x + p.x
        local gy = placeAnchor.y + p.y

        if gx < 0 or gx >= bag.grid_cols or gy < 0 or gy >= bag.grid_rows then
            pass = false
        else
            local state = PackUpMgr.gridDataMap[gx .. "," .. gy]

            if state == 2 then
                pass = false
            elseif state == 1 then
                pass = false
            else
                table.insert(occ, { x = gx, y = gy })
            end
        end
    end

    return pass, occ
end

PackUpMgr.CheckPuzzleWin = function(item)
    for k, _ in pairs(PackUpMgr.puzzleMap) do
        if not PackUpMgr.savePlacedItemsTb[k] then
            return false
        end
    end

    if item and item.Finishcallback then
        item:Finishcallback()
    end
    return true
end

PackUpMgr.ClearData = function()
    PackUpMgr.eventsListAreaMap = {}
    PackUpMgr.eventsListGroupMap = {}
    PackUpMgr.novelIndex = 0
end

PackUpMgr.GetShopCfgData = function()
    local cfgShopList = DataExHelper.Check_ConfigQuestEventByText("PackUpShop")
    if cfgShopList then
        table.sort(cfgShopList, function(a, b) return a.sort < b.sort end)
    end
    return cfgShopList or {}
end

PackUpMgr.GetPuzzleRewardCfgData = function()
    local rewardListByGroup = {}
    local list = DataExHelper.Check_ConfigQuestEventByText("PackUp")

    if not list then return rewardListByGroup end

    for _, v in ipairs(list) do
        if v.conditionArgs and #v.conditionArgs > 0 then
            local key = v.conditionArgs[1]
            if key and key ~= "" then
                rewardListByGroup[key] = rewardListByGroup[key] or {}
                table.insert(rewardListByGroup[key], v)
            end
        end
    end

    return rewardListByGroup
end

PackUpMgr.GetActiveEventsByArea = function(area)
    if not area then return {} end

    if not PackUpMgr.eventsListAreaMap[area] then
        PackUpMgr.eventsListAreaMap[area] = {}

        if ConfigMgr.Config and ConfigMgr.Config.activityMapEventList then
            for _, v in ipairs(ConfigMgr.Config.activityMapEventList) do
                if v.area == area then
                    table.insert(PackUpMgr.eventsListAreaMap[area], v)
                end
            end
        end
    end

    return PackUpMgr.eventsListAreaMap[area]
end

PackUpMgr.GetGroupsByPackUp = function()    
    local groupList = {}

    if ConfigMgr.Config and ConfigMgr.Config.activityMapGroupList then
        for _, v in ipairs(ConfigMgr.Config.activityMapGroupList) do
            if v.area == "PackUp" then
                table.insert(groupList, v)
            end
        end
    end

    return groupList
end

PackUpMgr.GetEventsByGroupId = function(groupId)
    if not groupId then return {} end

    if not PackUpMgr.eventsListGroupMap[groupId] then
        PackUpMgr.eventsListGroupMap[groupId] = {}

        if ConfigMgr.Config and ConfigMgr.Config.activityMapEventList then
            for _, v in ipairs(ConfigMgr.Config.activityMapEventList) do
                if v.groupId == groupId then
                    table.insert(PackUpMgr.eventsListGroupMap[groupId], v)
                end
            end
        end
    end

    return PackUpMgr.eventsListGroupMap[groupId]
end

PackUpMgr.CheckGroupIsLock = function(cfgGroup)
    if not cfgGroup then
        return false
    end   
    if cfgGroup.unlockParam and cfgGroup.unlockParam ~= "" then
         local eventMap = DataExHelper.GetActivityMapEventMap()
        if eventMap then
            local unlockEvent = eventMap[cfgGroup.unlockParam]
            if unlockEvent then
                return not PackUpMgr.CheckEventIsComplete(unlockEvent)
            end
        end
    end

    return false
end

PackUpMgr.CheckEventIsUnLock = function(event)
    if not event then return false end

    if event.unlockType == 0 or not event.unlockParam or event.unlockParam == "" then
        return true
    end

    if event.unlockType == 1 then
        local eventMap = DataExHelper.GetActivityMapEventMap()
        if eventMap then
            local unlockEvent = eventMap[event.unlockParam]
            if unlockEvent then
                return PackUpMgr.CheckEventIsComplete(unlockEvent)
            end
        end
        return false
    else
        LuaDebug.error("Config Error: 不支持的unlockType=" .. tostring(event.unlockType))
        return false
    end
end

PackUpMgr.CheckEventIsComplete = function(event)
    if not event or not event.type then return false end

    if event.type == 1 then
        return DataHelper.CheckNovelComplete(event.eventParam)
    elseif event.type == 2 or event.type == 4 then
        return DataHelper.CheckDungeonComplete(event.eventParam)
    elseif event.type == 3 then
        return PackUpMgr.CheckGameIsComplete(event.eventParam)
    else
        return true
    end
    return false
end

PackUpMgr.CheckGameIsComplete = function(id)
    return DataMgr.Player.PackUpGameMap[id] ~= nil
end

PackUpMgr.GetEventLocPosition = function(strPos)
    if not strPos or strPos == "" then
        return Vector2.zero
    end

    local posArray = NumTool.split(strPos, ",")
    if #posArray >= 2 then
        local x = tonumber(posArray[1])
        local y = tonumber(posArray[2])
        if x and y then
            return Vector2(x, y)
        end
    end

    return Vector2.zero
end

PackUpMgr.GetEventsProByGroup = function(groupId)
    local events = PackUpMgr.GetEventsByGroupId(groupId)
    if not events or #events == 0 then
        return 0, 0
    end

    local completedCount = 0
    for _, v in ipairs(events) do
        if PackUpMgr.CheckEventIsComplete(v) then
            completedCount = completedCount + 1
        end
    end

    return completedCount, #events
end

PackUpMgr.GetGroupsUnLockProIndex = function()
    local unlockedCount = 0
    local groups = PackUpMgr.GetGroupsByPackUp()

    for _, v in ipairs(groups) do
        local isLock = PackUpMgr.CheckGroupIsLock(v)
        if not isLock then
            unlockedCount = unlockedCount + 1
        end
    end

    return math.min(unlockedCount, #groups)
end

PackUpMgr.GetHistoryProIndex = function()
    if not DataMgr.Player or not DataMgr.Player.uid then
        return 0
    end

    local key = DataMgr.Player.uid .. "_PackUp_PRO"
    return PlayerPrefs.GetInt(key)
end

PackUpMgr.UpdateHistoryProIndex = function(index)
    if not DataMgr.Player or not DataMgr.Player.uid or not index then
        return
    end

    local key = DataMgr.Player.uid .. "_PackUp_PRO"
    PlayerPrefs.SetInt(key, index)
end

PackUpMgr.GetHistoryIndex = function(index)
    if not DataMgr.Player or not DataMgr.Player.uid then
        return 0
    end

    local key = DataMgr.Player.uid .. "_PackUp_Index"..index
    return PlayerPrefs.GetInt(key)
end

PackUpMgr.UpdateHistoryIndex = function(index)
    if not DataMgr.Player or not DataMgr.Player.uid or not index then
        return
    end

    local key = DataMgr.Player.uid .. "_PackUp_Index"..index
    PlayerPrefs.SetInt(key, 1)
end

PackUpMgr.GetMedalList = function()
    local medalConfigs = ConfigMgr.Config.Medals
    if not medalConfigs then return {} end

    local tempList = {}
    for _, v in pairs(medalConfigs) do
        if v.Activity == "4150" then
            local item = {
                id = v.Id,
                icon = LuaMgr.GetSprite("ZhanXunIcon", v.Id),
                name = LuaMgr.GetLangText(v.NameLan),
                desc = LuaMgr.GetLangText(v.DesLan),
                remark = LuaMgr.GetLangText(v.RemarksLan),
            }
            table.insert(tempList, item)
        end
    end

    return tempList
end

PackUpMgr.GetTotalScore = function(_id)
    if not _id or not DataMgr.Player or not DataMgr.Player.MedalStepMap then
        return { Current = 0, Target = 1 }
    end

    return DataMgr.Player.MedalStepMap[_id] or { Current = 0, Target = 1 }
end

PackUpMgr.GetNovelRecord = function(id)
    if not id or not DataMgr.Player or not DataMgr.Player.completedChapters then
        return false
    end

    for _, v in ipairs(DataMgr.Player.completedChapters) do
        if v == id then
            return true
        end
    end

    return false
end

PackUpMgr.SetNovelIndex = function(index)
    PackUpMgr.novelIndex = index or 0
end

PackUpMgr.GetNovelIndex = function()
    return PackUpMgr.novelIndex
end

PackUpMgr.GetDungeonRecord = function(id)
    if not id or not DataMgr.Player or not DataMgr.Player.dungeonRecords then
        return nil
    end

    return DataMgr.Player.dungeonRecords[id]
end

PackUpMgr.IsUnlock = function(id, isTips)
    if not id or id == "" then
        return true
    end

    local record = PackUpMgr.GetDungeonRecord(id)
    if not record or not record.historyRating or record.historyRating == "" then
        if isTips then
            local unlockName = ConfigMgr.Config.dungeonMap[id];
            if (unlockName == nil) then
                unlockName = ""
            end
            local tips = string.format(ConfigMgr.LangGlobal("10001"), unlockName)
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tips)
        end
        return false
    end

    return true
end

PackUpMgr.SetShowAni = function(_bShow)
    PackUpMgr.showAni = _bShow
end

PackUpMgr.CheckShowAni = function()
    return PackUpMgr.showAni
end



PackUpMgr.CheckEntranceRedDot = function()
    local bCollect = PackUpMgr.CheckCollectEntranceRedDot()
    local bPlay = PackUpMgr.CheckPlayRedDot()
    if (bPlay or bCollect) then
        return 1
    else
        return 0
    end
end

PackUpMgr.CheckCollectEntranceRedDot = function()
    local bRed = false
    for k, v in pairs(ConfigMgr.Config.PackUpCollectMap) do
        local data = DataMgr.Player.PackUpCollectMap[v.Id]
        local item = DataMgr.Player.items[v.UnClock[1].id]
        local isFinish = data == 1
        local canGet = item ~= nil and item.count0 > 0
        if (not isFinish and canGet) then
            bRed = true
            break
        end
    end
    if (bRed) then
        RedMgr.Singleton:UpdateClientRedData("17003", 1)
    else
        RedMgr.Singleton:UpdateClientRedData("17003", 0)
    end
    return bRed
end

PackUpMgr.CheckRandomShopRedDot = function()
    local bRed = false
    local groupList = PackUpMgr.GetGroupsByPackUp();
    for i, value in ipairs(groupList) do
        local eventList = PackUpMgr.GetEventsByGroupId(value.id)
        if eventList ~= nil and #eventList >= 0 then
            for k, v in ipairs(eventList) do
                local pUnLock = PackUpMgr.CheckEventIsUnLock(v);                       
                if (v.type == 6 and pUnLock) then
                    bRed = true
                    break
                end               
            end
        end
    end
    if (not RedMgr.Singleton:CheckRedCondition("17005") and bRed) then
        bRed = false
    end
    if (bRed) then
        RedMgr.Singleton:UpdateClientRedData("17005", 1)
    else
        RedMgr.Singleton:UpdateClientRedData("17005", 0)
    end
    return bRed
end

PackUpMgr.CheckPlayRedDot = function()
    local bRed = false
    local list = PackUpMgr.GetActiveEventsByArea("PackUp")
    for k, v in pairs(list) do
        local pUnLock = PackUpMgr.CheckEventIsUnLock(v);
        local pPass = PackUpMgr.CheckEventIsComplete(v);
        if (pUnLock and not pPass) then
            bRed = true;
            break;
        end
    end
    if (not RedMgr.Singleton:CheckRedCondition("17004") and bRed) then
        bRed = false
    end
    local shop = PackUpMgr.CheckRandomShopRedDot();
    if (shop) then
        bRed = true;
    end
     if (bRed) then
        RedMgr.Singleton:UpdateClientRedData("17004", 1)
    else
        RedMgr.Singleton:UpdateClientRedData("17004", 0)
    end
    return bRed
end



return PackUpMgr