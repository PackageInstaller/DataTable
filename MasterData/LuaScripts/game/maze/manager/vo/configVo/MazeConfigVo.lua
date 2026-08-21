--[[ 
-----------------------------------------------------
@filename       : MazeConfigVo
@Description    : 迷宫地图配置数据
@date           : 2021-08-07 14:16:01
@Author         : Zzz
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("maze.MazeConfigVo", Class.impl())

function setData(self, mazeId, cusData)
    self.mMazeId = mazeId
    self.mRowNum = cusData.row_num
    self.mColNum = cusData.col_num
    self.mIsEvenNumOut = cusData.is_even_num_out == 2

    self.mMapOffsetX = cusData.offset_x
    self.mMapOffsetY = cusData.offset_y
    self.mMapOffsetZ = cusData.offset_z

    self.mName = cusData.name
    self.mSceneId = cusData.scene_id

    self.mBirthTileId = cusData.birth_tile_id
    self.mPassAwardId = cusData.challenge_award
    self.mFirstTalkId = cusData.first_talk_id
    
    -- 华丽箱子总数量
    self.allGorgeousBoxNum = cusData.box_list[1] or 0
    -- 普通箱子总数量
    self.allNormalBoxNum = cusData.box_list[2] or 0

    -- 华丽箱子奖励包id
    self.gorgeousBoxAwardId = cusData.reward_list[1] or 0
    -- 普通箱子奖励包id
    self.normalBoxAwardId = cusData.reward_list[2] or 0

    -- 异常环境列表
    self.abnormalList = cusData.abnormal_list
    -- 限制开启的玩家等级
    self.limitPlayerLevel = cusData.limit_level
    --限制开启的通过副本Id
    self.unLockDupId = cusData.unlock_stage

    self:setBirthRow(nil)
    self:setBirthCol(nil)
end

function getGorgeousBoxAwardList(self)
    if(not self.mGorgeousBoxAwardList)then
        self.mGorgeousBoxAwardList = {}
        local propsList = AwardPackManager:getAwardListById(self.gorgeousBoxAwardId)
        for i = 1, #propsList do
            local propsVo = props.PropsVo.new()
            propsVo:setTid(propsList[i].tid)
            propsVo.count = propsList[i].num
            table.insert(self.mGorgeousBoxAwardList,propsVo)
        end
    end
    return self.mGorgeousBoxAwardList
end

function getAbnormalBoxAwardList(self)
    if(not self.mAbnormalBoxAwardList)then
        self.mAbnormalBoxAwardList = {}
        local propsList = AwardPackManager:getAwardListById(self.normalBoxAwardId)
        for i = 1, #propsList do
            local propsVo = props.PropsVo.new()
            propsVo:setTid(propsList[i].tid)
            propsVo.count = propsList[i].num
            table.insert(self.mAbnormalBoxAwardList,propsVo)
        end
    end
    return self.mAbnormalBoxAwardList
end

function getMazeId(self)
    return self.mMazeId or 0
end

function getRowNum(self)
    return self.mRowNum or 0
end

function getColNum(self)
    return self.mColNum or 0
end

function getIsEvenNumOut(self)
    return self.mIsEvenNumOut
end

function getOffsetX(self)
    return self.mMapOffsetX
end

function getOffsetY(self)
    return self.mMapOffsetY
end

function getOffsetZ(self)
    return self.mMapOffsetZ
end

function getName(self)
    return self.mName or ""
end

function getSceneId(self)
    return self.mSceneId
end

function getBirthTileId(self)
    return self.mBirthTileId
end

function getPassAwardId(self)
    return self.mPassAwardId
end

function getFirstTalkId(self)
    return self.mFirstTalkId
end

function setBirthRow(self, row)
    self.mBirthRow = row
end

function getBirthRow(self)
    return self.mBirthRow
end

function setBirthCol(self, col)
    self.mBirthCol = col
end

function getBirthCol(self)
    return self.mBirthCol
end

function getMapSize(self)
    if(not self.mSizeW and not self.mSizeH)then
        self.mSizeW, self.mSizeH = maze.getMapSizeByRowCol(self:getLayoutType(), self:getRowNum(), self:getColNum(), self:getTileSideLen(), self:getTileHalfH())
    end
    return self.mSizeW, self.mSizeH
end

function getLayoutType(self)
    -- 六边形格子的放置方向（横向放置 或 纵向放置）
    return maze.LAYOUT_VERTICAL
    -- return maze.LAYOUT_HORIZONTAL
end

-- 关系公式
-- tileHalfH = tileSideLen * 0.866025404
-- tileSideLen = 2 * tileHalfH * 0.577350269
-- 六边形中心到边的距离
function getTileHalfH(self)
    if(not self.mTileHalfH)then
        self.mTileHalfH = 0.5
    end
    return self.mTileHalfH
end

-- 六边形中心到顶点的距离
function getTileSideLen(self)
    if(not self.mTileSideLen)then
        self.mTileSideLen = 2 * self:getTileHalfH() * 0.577
    end
    return self.mTileSideLen
end

-- 资源实际缩放值，调整以和单位cube大小匹配
function getTileRealScale(self)
    if(not self.mRealTileScale)then
        -- 六边形格子资源中心到边实际距离为0.5
        local realTileHalfH = 0.5
        self.mRealTileScale = self:getTileHalfH() / realTileHalfH
    end
    return self.mRealTileScale
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
