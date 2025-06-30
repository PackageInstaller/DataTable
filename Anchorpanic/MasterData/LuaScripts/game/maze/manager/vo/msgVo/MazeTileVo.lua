--[[ 
-----------------------------------------------------
@filename       : MazeTileVo
@Description    : 迷宫格子数据
@date           : 2021-08-07 14:16:01
@Author         : Zzz
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("maze.MazeTileVo", Class.impl())

function setData(self, cusData)
    -- 格子id
    self.mTileId = cusData.id
    -- 事件id
    self.mBaseEventId = cusData.base_event_id
    -- 0-删除，1-新增
    self.mState = cusData.state
end

function getTileId(self)
    return self.mTileId
end

function getBaseEventId(self)
    return self.mBaseEventId or 0
end

function getState(self)
    return self.mState
end

function isDel(self)
    return self.mState == 0
end

function isAdd(self)
    return self.mState == 1
end

function onRecover(self)
    self.mTileId = nil
    self.mBaseEventId = nil
    self.mState = nil
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
