--[[ 
-----------------------------------------------------
@filename       : MazeEventConfigVo
@Description    : 迷宫格子配置数据
@date           : 2021-08-07 14:16:01
@Author         : Zzz
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("maze.MazeTileConfigVo", Class.impl())

function setData(self, mazeId, tileId, cusData)
    self.mMazeId = mazeId
    self.mTileId = tileId
    self.mRow = cusData.row
    self.mCol = cusData.col
    self.mBaseEventId = cusData.base_event_id
    
    self.mEventTalkData = cusData.talk_id
end

function getMazeId(self)
    return self.mMazeId
end

function getTileId(self)
    return self.mTileId or 0
end

function getRow(self)
    return self.mRow or 0
end

function getCol(self)
    return self.mCol or 0
end

function getBaseEventId(self)
    return self.mBaseEventId or 0
end

-- 1:对话在事件触发表现前，2:对话在事件触发表现后
function getEventTalkData(self)
    if(#self.mEventTalkData > 0)then
        local isPlayBefore = self.mEventTalkData[1] == 1
        local talkId = self.mEventTalkData[2]
        return isPlayBefore, talkId
    else
        return nil, nil
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
