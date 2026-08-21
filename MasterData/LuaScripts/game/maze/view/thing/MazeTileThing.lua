module("maze.MazeTileThing", Class.impl(maze.MazeBaseEventThing))

function getLayer(self)
    return maze.LAYER_TILE
end

function onRecover(self)
    super.onRecover(self)
end

function create(self, mazeConfigVo, tileConfigVo, finishCall)
    super.create(self, mazeConfigVo, tileConfigVo, finishCall)
end

function updateModel(self, finishCall)
    super.updateModel(self, finishCall)
    if (self:getMazeConfigVo():getLayoutType() == maze.LAYOUT_VERTICAL) then
        gs.TransQuick:SetLRotation(self:getTrans(), 0, 0, 0)
    elseif (self:getMazeConfigVo():getLayoutType() == maze.LAYOUT_HORIZONTAL) then
        gs.TransQuick:SetLRotation(self:getTrans(), 0, -90, 0)
    end
end

function getEventConfigVo(self)
    return maze.MazeSceneManager:getEventConfigVo(self:getEventId())
end

function getEventId(self)
    local tileId = self:getTileId()
    local tileVo = maze.MazeSceneManager:getMazeTileVo(tileId)
    local configVo = self:getTileConfigVo()
    if(tileVo)then
        if(tileVo:isDel())then
            local mazeEventVo = maze.MazeSceneManager:getMazeEventVo(tileId)
            local row, col = maze.MazeSceneManager:getRowColByTileId(self:getMazeId(), tileId)
            Debug:log_error("MazeTileThing", string.format("询问后端是否删除了格子%s(%s行%s列)上的地板却保留了格子上的事件%s", tileId, row, col, mazeEventVo:getEventId()))
        elseif(tileVo:isAdd())then
            return tileVo:getBaseEventId()
        else
            Debug:log_error("MazeTileThing", "含有格子新状态未处理：" .. tileVo:getState())
        end
    else
        return self:getTileConfigVo():getBaseEventId()
    end
end

function getEventVo(self)
    return nil
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
