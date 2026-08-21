module("maze.MazeBaseEventThingVo", Class.impl("lib.event.EventDispatcher"))

function onRecover(self)
    self:setMazeId(nil)
    self:setTileId(nil)
end

function setData(self, mazeId, tileId)
    self:setMazeId(mazeId)
    self:setTileId(tileId)
end

function getType(self)
    return nil
end

function setMazeId(self, mazeId)
    self.mMazeId = mazeId
end

function getMazeId(self)
    return self.mMazeId
end

function setTileId(self, tileId)
    self.mTileId = tileId
end

function getTileId(self)
    return self.mTileId
end

function getRow(self)
    return self:getTileConfigVo():getRow()
end

function getCol(self)
    return self:getTileConfigVo():getCol()
end

function getTileXY(self)
    local layoutType = self:getMazeConfigVo():getLayoutType()
    local tileHalfH = self:getMazeConfigVo():getTileHalfH()
    local tileSideLen = self:getMazeConfigVo():getTileSideLen()
    local mazeSizeW, mazeSizeH = self:getMazeConfigVo():getMapSize()
    local tileX, tileY = maze.getTilePosByRowCol(mazeSizeW, mazeSizeH, layoutType, self:getRow(), self:getCol(), tileSideLen, tileHalfH)
    return tileX, tileY
end

function getTileConfigVo(self)
    return maze.MazeSceneManager:getTileConfigVoById(self:getMazeId(), self:getTileId())
end

function getMazeConfigVo(self)
    return maze.MazeSceneManager:getMazeConfigVo(self:getMazeId())
end

function getThing(self)
    return maze.MazeSceneThingManager:getThing(self:getType(), self:getRow(), self:getCol())
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
