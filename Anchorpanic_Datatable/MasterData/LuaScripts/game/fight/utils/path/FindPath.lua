local FindPath = Class.class('FindPath')
AStar = require("game/fight/utils/path/AStar").new()
BStar = require("game/fight/utils/path/BStar").new()
function FindPath:find(cusStartTile,cusEndTile,cusFinderId)
    local dirCol = cusEndTile.col - cusStartTile.col
    local dirRow = cusEndTile.row - cusStartTile.row

    dirCol = dirCol > 0 and 1 or (dirCol < 0 and -1 or 0)
    dirRow = dirRow > 0 and 1 or (dirRow < 0 and -1 or 0)
    if not fight.SceneUtil.isFeasibleTitle(cusEndTile.col, cusEndTile.row) then
        cusEndTile = fight.SceneUtil.boundaryTitle(cusStartTile, cusEndTile)
    end
    if fight.SceneManager:isEmptyTile(fight.Tile(cusStartTile.col + dirCol,cusStartTile.row + dirRow),cusFinderId) then
        return {cusEndTile};
    end
    local path = BStar:find(cusStartTile,cusEndTile,cusFinderId)
    if path == nil then
        -- print("B star no path")
        path = AStar:find(cusStartTile,cusEndTile,cusFinderId)

        -- if path == nil then
        --     print("A star no path")
        -- else
        --     print("A star path",#path)
        -- end
    end

    return path;
end

function FindPath:poolTileRecover(tile)
    if tile.s_isAStar then
        -- AStar:poolTileRecover(tile)
    end
end

return FindPath
 
--[[ 替换语言包自动生成，请勿修改！
]]
