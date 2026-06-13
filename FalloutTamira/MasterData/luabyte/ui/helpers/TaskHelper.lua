local TaskHelper = {}
local tInsert = table.insert

-- function TaskHelper.GetTaskDesc(descFormat, cfg)
--     local desTable = {}
--     if cfg.limitValue1 > 0 then
--         tInsert(desTable, cfg.limitValue1)
--     end
--     if cfg.limitValue2 > 0 then
--         tInsert(desTable, cfg.limitValue2)
--     end
--     local des = string.gsub(descFormat, "%%s", SafeUnpack(desTable))
--     return des
-- end

function TaskHelper.GetProgress(data)
    return data.value0 / data.limitValue1
end

function TaskHelper.Sort(data)
    if data == nil then
        return nil
    end
    table.sort(data, function(a, b)
            if a.state == b.state then
                if a.order == b.order then
                    return a.id < b.id
                else
                    return a.order < b.order
                end
            else
                local tempA = a.state == 1 and -1 or a.state
                local tempB = b.state == 1 and -1 or b.state
                return tempA < tempB
            end
        end
    )
    return data
end

function TaskHelper.SortTasks(data)
    table.sort(data, function(a, b)
        if a.state == b.state then
            if a.order == b.order then
                return a.id < b.id
            else
                return a.order < b.order
            end
        else
            local stateA = a.state == 1 and -1 or a.state
            local stateB = b.state == 1 and -1 or b.state
            return stateA < stateB
        end
    end)
    return data
end

function TaskHelper.GetCurrentMainTask()
    local currentLevel = IPlayerData.level
    local cfgs =
        ConfigHelper.GetCfgsByLua("mainTask", function(a)
            return a.level <= currentLevel
        end
    )
    table.sort(cfgs, function(a, b)
            return a.id > b.id
        end
    )
    return cfgs[1]
end

function TaskHelper.GetMainTaskPropertion(id)
    local cfgs = ConfigHelper.GetCfgsByLua("mainTask")
    for i = 1, #cfgs do
        if cfgs[i].id == id then
            return (i - 1) / #cfgs
        end
    end
end

--筛选服务器数据，获得已领取并且未完成的主线任务config
function TaskHelper.FindDoingMainTaskConfig(data)
    if data == nil then
        return nil
    end
    local curLevel = TaskHelper.FindCurrentOpenLevel(data)
    local cfgs = ConfigHelper.GetCfgsByLua("mainTask")
    for i = 1, #cfgs do
        if cfgs[i].level == curLevel then
            return cfgs[i]
        end
    end
    return nil
end

function TaskHelper.FindDoingMainTaskList(list)
    local maxMainGorupOpenLevel = 0
    local currentLevel = TaskHelper.FindCurrentOpenLevel(list)
    if list == nil then
        return {}
    end
    local result = {}
    for i = 1, #list do
        -- body
        if list[i].cfg.openParam1[1] == currentLevel then
            -- body
            tInsert(result, list[i])
        end
    end
    return result
end

--筛选服务器数据，获得已领取并且未完成的任务等级
function TaskHelper.FindCurrentOpenLevel(list)
    if list == nil then
        return 0
    end
    table.sort(
        list,
        function(a, b)
            return a.id < b.id
        end
    )
    local minLevel = 99999
    for i = 1, #list do
        if list[i].state < 2 then
            if list[i].cfg.openParam1[1] < minLevel then
                minLevel = list[i].cfg.openParam1[1]
            end
        end
    end
    return minLevel
end

--获得数据中等级相同的部分
function TaskHelper.GetSameLevelData(data, level)
    local result = {}
    for k, v in pairs(data) do
        if v.cfg.openParam1[1] == level then
            tInsert(result, v)
        end
    end
    return result
end

function TaskHelper.GetTaskListByLimit(limit)
    local cfgs = ConfigHelper.GetCfgsByLua("task", {limit = limit})
    return cfgs
end

return TaskHelper
