JSYZGameAI = {};


JSYZGameAI.SmartChase = function(enemy, player, grid, bombs, explosions, dangerMap)
    if not enemy or not player or not grid or not bombs or not dangerMap then
        return nil
    end

    if enemy.dangerAvoidance then
        local currentKey = JSYZGameUtils.MakeKey(enemy.x, enemy.y)
        local dangerTime = dangerMap[currentKey]

        if dangerTime and dangerTime < enemy.riskThreshold then
            local safePos = JSYZGameDangerMap.FindNearestSafePosition(
                enemy.x, enemy.y, dangerMap, grid, bombs, enemy.riskThreshold
            )

            if safePos then
                local path = JSYZGamePathfinding.FindPath(
                    enemy.x, enemy.y, safePos.x, safePos.y,
                    grid, bombs, explosions, dangerMap, 999
                )

                if path and #path > 0 then
                    return path[1]
                end
            end
        end
    end

    local distance = JSYZGameUtils.DistanceManhattan(enemy.x, enemy.y, player.x, player.y)
    if distance <= enemy.chaseRange then
        local path = JSYZGamePathfinding.FindPath(
            enemy.x, enemy.y, player.x, player.y,
            grid, bombs, explosions, dangerMap, enemy.riskThreshold
        )

        if path and #path > 0 then
            local smoothPath = JSYZGamePathfinding.SmoothPath(path, grid, bombs)
            if smoothPath and #smoothPath > 0 then
                return smoothPath[1]
            end
            return path[1]
        end
    end

    return nil
end


JSYZGameAI.Aggressive = function(enemy, player, grid, bombs, explosions, dangerMap)
    local distance = JSYZGameUtils.DistanceManhattan(enemy.x, enemy.y, player.x, player.y)

    if distance <= enemy.chaseRange then
        local path = JSYZGamePathfinding.FindPath(
            enemy.x, enemy.y, player.x, player.y,
            grid, bombs, explosions, nil, nil
        )

        if path and #path > 0 then
            return path[1]
        end
    end

    return nil
end


JSYZGameAI.PatrolOnly = function(enemy, player, grid, bombs, explosions, dangerMap)
    local distance = JSYZGameUtils.DistanceManhattan(enemy.x, enemy.y, player.x, player.y)

    if distance <= enemy.chaseRange then
        local path = JSYZGamePathfinding.FindPath(
            enemy.x, enemy.y, player.x, player.y,
            grid, bombs, explosions, dangerMap, enemy.riskThreshold
        )

        if path and #path > 0 then
            return path[1]
        end
    end

    return nil
end

JSYZGameAI.Execute = function(enemy, player, grid, bombs, explosions, dangerMap)
    local aiType = enemy.aiType

    if aiType == "smart_chase" then
        return JSYZGameAI.SmartChase(enemy, player, grid, bombs, explosions, dangerMap)
    elseif aiType == "aggressive" then
        return JSYZGameAI.Aggressive(enemy, player, grid, bombs, explosions, dangerMap)
    elseif aiType == "patrol_only" then
        return JSYZGameAI.PatrolOnly(enemy, player, grid, bombs, explosions, dangerMap)
    end

    return nil
end