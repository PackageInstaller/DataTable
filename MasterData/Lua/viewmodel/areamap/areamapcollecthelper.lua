AreaMapCollectHelper = {}

AreaMapCollectHelper.ChestState = {
    CanGet = 1,
    Received = 2,
    CanNotGet = 3,
}
AreaMapCollectHelper.GetCollectRedCount = function(currentArea)
    local allChestList = AreaMapCollectHelper.GetChestList(currentArea)
    local redCount = 0
    for k, v in pairs(allChestList) do
        for i, chestData in ipairs(v) do
            if chestData.states == AreaMapCollectHelper.ChestState.CanGet then
                redCount = redCount + 1
            end
        end
    end
    return tonumber(redCount)
end

local GetChestState = function(chestData)
    if chestData.completed then
        return AreaMapCollectHelper.ChestState.Received
    else
        if chestData.current >= chestData.target then
            return AreaMapCollectHelper.ChestState.CanGet
        else
            return AreaMapCollectHelper.ChestState.CanNotGet
        end
    end
end


AreaMapCollectHelper.GetChestList = function(currentArea)
    local dataMissions = DataMgr.Player.missions
    local cfgMissions = ConfigMgr.Config.missionMap
    local allChestList = { main = {}}


    if dataMissions[currentArea]==nil then
        return allChestList;
    end
    local phaseData = dataMissions[currentArea]["205"]
    for k, v in pairs(phaseData or {}) do
        table.insert(allChestList["main"], { 
            id = v.id,
            states = GetChestState(v),
            current = v.current,
            target = v.target,
            completed = v.completed
        })
    end

    phaseData = dataMissions[currentArea]["206"]
    for k,v in pairs(phaseData or {}) do
        local missionCfg = cfgMissions[k]
        if missionCfg ~= nil then
            if allChestList[missionCfg.group] == nil then
                allChestList[missionCfg.group] = {}
            end
            table.insert(allChestList[missionCfg.group], {
                id = v.id, 
                states = GetChestState(v),
                current = v.current,
                target = v.target,
                completed = v.completed
            })
        end
    end
    for k, v in pairs(allChestList) do
        table.sort(allChestList[k],function(a,b)
            return tonumber(a.id)<tonumber(b.id)
        end)
    end
    return allChestList
end