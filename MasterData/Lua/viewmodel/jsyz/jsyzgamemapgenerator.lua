JSYZGameMapGenerator = {};




JSYZGameMapGenerator.Generate = function(mapConfig)
    local grid = {}
    local config = JSYZMap
    local cellType = JSYZCellType
    local gridSizeX = JSYZGame.gridSizeX
    local gridSizeY = JSYZGame.gridSizeY


    for i = 0, gridSizeX - 1 do
        grid[i] = {}
        for j = 0, gridSizeY - 1 do
            grid[i][j] = cellType.EMPTY
        end
    end


    if config.borderWall then

        for i = 0, gridSizeX - 1 do
            grid[i][0] = cellType.WALL
            grid[i][gridSizeY - 1] = cellType.WALL
        end

        for j = 0, gridSizeY - 1 do
            grid[0][j] = cellType.WALL
            grid[gridSizeX - 1][j] = cellType.WALL
        end
    end


    if config.fixedWallPattern.enabled then
        local rowInterval = config.fixedWallPattern.rowInterval
        local colInterval = config.fixedWallPattern.colInterval

        for i = 0, gridSizeX - 1, rowInterval do
            for j = 0, gridSizeY - 1, colInterval do
                if grid[i][j] == cellType.EMPTY then
                    grid[i][j] = cellType.WALL
                end
            end
        end
    else
        for posy, posxArr in pairs(mapConfig.Stones) do
            for _, posx in pairs(posxArr) do
                local x = posx - 1
                local y = posy - 1
                if (grid[x] ~= nil and grid[x][y] ~= nil) then
                    if grid[x][y] == cellType.EMPTY then
                        grid[x][y] = cellType.WALL
                    end
                end
            end
        end
    end


    for posy, posxArr in pairs(mapConfig.Boards) do
        for _, posx in pairs(posxArr) do
            local x = posx - 1
            local y = posy - 1
            if (grid[x] ~= nil and grid[x][y] ~= nil) then
                if grid[x][y] == cellType.EMPTY then
                    grid[x][y] = cellType.BRICK
                end
            end
        end
    end


    local itemIndex = {}
    local exitPos = { x = 0, y = 0 }
    local makeKey = JSYZGameUtils.MakeKey
    for _, entry in ipairs(mapConfig.ItemPos) do
        local key = makeKey(entry[1], entry[2])
        itemIndex[key] = entry[3]
        if (entry[3] == 5) then

            exitPos.x = entry[1]
            exitPos.y = entry[2]
            if grid[exitPos.x][exitPos.y] ~= cellType.WALL then
                grid[exitPos.x][exitPos.y] = cellType.BRICK
            end
        end
    end
    return grid, exitPos, itemIndex
end