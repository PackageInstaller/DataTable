JSYZGamePathfinding = {};


JSYZGamePathfinding.FindPath = function(startX, startY, targetX, targetY, grid, bombs, explosions, dangerMap,
                                        riskThreshold)
    if startX == targetX and startY == targetY then
        return {}
    end

    local gridSizeX = JSYZGame.gridSizeX
    local gridSizeY = JSYZGame.gridSizeY
    local maxIterations = JSYZGame.maxPathfindingIterations

    local openList = {}
    local closedList = {}
    local cameFrom = {}

    local makeKey = JSYZGameUtils.MakeKey
    local startKey = makeKey(startX, startY)

    local gScore = { [startKey] = 0 }
    local fScore = { [startKey] = JSYZGameUtils.DistanceManhattan(startX, startY, targetX, targetY) }

    table.insert(openList, { x = startX, y = startY, key = startKey })
    local openSet = { [startKey] = true }

    local directions = { { 0, 1 }, { 1, 0 }, { 0, -1 }, { -1, 0 } }
    local iterations = 0

    while #openList > 0 do
        iterations = iterations + 1
        if iterations > maxIterations then
            return nil
        end

        local currentIndex = 1
        local currentMinF = fScore[openList[1].key] or math.huge
        for i = 2, #openList do
            local f = fScore[openList[i].key] or math.huge
            if f < currentMinF then
                currentMinF = f
                currentIndex = i
            end
        end

        local current = table.remove(openList, currentIndex)
        openSet[current.key] = nil

        if current.x == targetX and current.y == targetY then
            return JSYZGamePathfinding.ReconstructPath(cameFrom, current.key)
        end

        closedList[current.key] = true

        for _, dir in ipairs(directions) do
            local nx = current.x + dir[1]
            local ny = current.y + dir[2]
            local neighborKey = makeKey(nx, ny)

            if nx >= 0 and nx < gridSizeX and ny >= 0 and ny < gridSizeY then
                if not closedList[neighborKey] then
                    local cellType = grid[nx][ny]

                    local hasBomb = JSYZGamePathfinding.HasBombAt(nx, ny, bombs)
                    local hasExplosion = JSYZGamePathfinding.HasExplosionAt(nx, ny, explosions)

                    local walkable = (cellType == JSYZCellType.EMPTY or
                            cellType == JSYZCellType.EXIT or
                            (nx == targetX and ny == targetY)) and
                        not hasBomb and not hasExplosion

                    if walkable and dangerMap and riskThreshold then
                        local dangerTime = dangerMap[neighborKey]
                        if dangerTime and dangerTime < riskThreshold then
                            walkable = false
                        end
                    end

                    if walkable then
                        local tentativeG = gScore[current.key] + 1

                        if not gScore[neighborKey] or tentativeG < gScore[neighborKey] then
                            cameFrom[neighborKey] = current.key
                            gScore[neighborKey] = tentativeG
                            fScore[neighborKey] = tentativeG + JSYZGameUtils.DistanceManhattan(nx, ny, targetX, targetY)

                            if not openSet[neighborKey] then
                                table.insert(openList, { x = nx, y = ny, key = neighborKey })
                                openSet[neighborKey] = true
                            end
                        end
                    end
                end
            end
        end
    end

    return nil
end


JSYZGamePathfinding.ReconstructPath = function(cameFrom, currentKey)
    local path = {}
    local parseKey = JSYZGameUtils.ParseKey

    while cameFrom[currentKey] do
        local x, y = parseKey(currentKey)
        table.insert(path, { x = x, y = y })
        currentKey = cameFrom[currentKey]
    end


    local i, j = 1, #path
    while i < j do
        path[i], path[j] = path[j], path[i]
        i = i + 1
        j = j - 1
    end

    return path
end


JSYZGamePathfinding.HasBombAt = function(x, y, bombs)
    for _, bomb in ipairs(bombs) do
        if bomb.x == x and bomb.y == y then
            return true
        end
    end
    return false
end


JSYZGamePathfinding.HasExplosionAt = function(x, y, explosions)
    if not explosions then return false end
    for _, exp in ipairs(explosions) do
        if exp.x == x and exp.y == y then
            return true
        end
    end
    return false
end


JSYZGamePathfinding.HasLineOfSight = function(x1, y1, x2, y2, grid, bombs)
    local dx = math.abs(x2 - x1)
    local dy = math.abs(y2 - y1)
    local steps = math.max(dx, dy)

    if steps == 0 then return true end

    local xStep = (x2 - x1) / steps
    local yStep = (y2 - y1) / steps
    local cellType = JSYZCellType

    for i = 0, steps do
        local x = math.floor(x1 + xStep * i + 0.5)
        local y = math.floor(y1 + yStep * i + 0.5)

        if x < 0 or x >= JSYZGame.gridSizeX or
            y < 0 or y >= JSYZGame.gridSizeY then
            return false
        end

        local cell = grid[x][y]
        if cell == cellType.WALL or cell == cellType.BRICK then
            return false
        end

        if JSYZGamePathfinding.HasBombAt(x, y, bombs) then
            return false
        end
    end

    return true
end


JSYZGamePathfinding.SmoothPath = function(path, grid, bombs)
    if not path or #path <= 2 then
        return path
    end

    local smoothed = { path[1] }
    local current = 1

    while current < #path do
        local farthest = current + 1

        for i = #path, current + 1, -1 do
            if JSYZGamePathfinding.HasLineOfSight(
                    path[current].x, path[current].y,
                    path[i].x, path[i].y,
                    grid, bombs) then
                farthest = i
                break
            end
        end

        table.insert(smoothed, path[farthest])
        current = farthest
    end

    return smoothed
end