JSYZGameDangerMap = {};


JSYZGameDangerMap.Update = function(bombs, grid)
    local dangerMap = {}
    local makeKey = JSYZGameUtils.MakeKey
    local cellType = JSYZCellType
    local gridSizeX = JSYZGame.gridSizeX
    local gridSizeY = JSYZGame.gridSizeY
    local directions = { { 0, 0 }, { 1, 0 }, { -1, 0 }, { 0, 1 }, { 0, -1 } }

    for _, bomb in ipairs(bombs) do
        for _, dir in ipairs(directions) do
            for i = 0, bomb.range do
                if i == 0 and (dir[1] ~= 0 or dir[2] ~= 0) then
                    goto continue
                end

                local nx = bomb.x + dir[1] * i
                local ny = bomb.y + dir[2] * i

                if nx < 0 or nx >= gridSizeX or ny < 0 or ny >= gridSizeY then
                    break
                end

                if grid[nx][ny] == cellType.WALL then
                    break
                end

                local key = makeKey(nx, ny)
                local currentMin = dangerMap[key]

                if not currentMin or bomb.timer < currentMin then
                    dangerMap[key] = bomb.timer
                end

                if grid[nx][ny] == cellType.BRICK then
                    break
                end

                ::continue::
            end
        end
    end

    return dangerMap
end


JSYZGameDangerMap.IsSafe = function(x, y, dangerMap, threshold)
    local key = JSYZGameUtils.MakeKey(x, y)
    local dangerTime = dangerMap[key]

    if not dangerTime then
        return true
    end

    return dangerTime >= threshold
end


JSYZGameDangerMap.FindNearestSafePosition = function(startX, startY, dangerMap, grid, bombs, threshold)
    local queue = { { x = startX, y = startY, dist = 0 } }
    local visited = { [JSYZGameUtils.MakeKey(startX, startY)] = true }
    local directions = { { 0, 1 }, { 1, 0 }, { 0, -1 }, { -1, 0 } }
    local makeKey = JSYZGameUtils.MakeKey
    local gridSizeX = JSYZGame.gridSizeX
    local gridSizeY = JSYZGame.gridSizeY
    local cellType = JSYZCellType

    local searchLimit = 50
    local checked = 0

    while #queue > 0 and checked < searchLimit do
        checked = checked + 1
        local current = table.remove(queue, 1)

        if JSYZGameDangerMap.IsSafe(current.x, current.y, dangerMap, threshold) then
            return current
        end

        for _, dir in ipairs(directions) do
            local nx = current.x + dir[1]
            local ny = current.y + dir[2]
            local key = makeKey(nx, ny)

            if nx >= 0 and nx < gridSizeX and ny >= 0 and ny < gridSizeY then
                if not visited[key] then
                    visited[key] = true
                    local cell = grid[nx][ny]

                    if cell == cellType.EMPTY or cell == cellType.EXIT then
                        local hasBomb = JSYZGamePathfinding.HasBombAt(nx, ny, bombs)
                        if not hasBomb then
                            table.insert(queue, { x = nx, y = ny, dist = current.dist + 1 })
                        end
                    end
                end
            end
        end
    end

    return nil
end