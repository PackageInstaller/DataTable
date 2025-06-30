--[[
-----------------------------------------------------
@filename       : DormitoryObject02
@Description    : 宿舍物件(墙面物件左面和右面)
@date           : 2021-10-13 16:44:56
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dormitory.utils.DormitoryObject02', Class.impl(dormitory.DormitoryObject01))

function ctor(self)
    super.ctor(self)

    self.maxCol = DormitoryCost.COL_COUNT
    self.maxRow = DormitoryCost.HIGHT_COUNT

    self:initData()
end

-- function initData(self)
--     self.mInitCol = 10
--     self.mInitRow = 5
-- end

-- 更新模型位置
function updatePosition(self)
    local tile = dormitory.DormitorySceneController:getTile(self.mSite, self.mCurCenterTile.col, self.mCurCenterTile.row)
    if tile then
        local pos = tile:getPosition()
        local posX = pos.x + self:getOffsetPos().x - DormitoryCost.TITE_SIZE / 2
        local posY = pos.y + self:getOffsetPos().y - DormitoryCost.TITE_SIZE / 2
        local posZ = pos.z + (self:getOffsetPos().z - DormitoryCost.TITE_SIZE / 2) * self:getDirValue()

        pos = gs.Vector3(0, posY, posZ)
        self:setPosition(pos)
    end
    if self.isSelectState then
        GameDispatcher:dispatchEvent(EventName.FURNITURE_MOVE, {pos = self.m_trans.position})
    end
end

-- 获取占用格子区域
function getBuildArea(self, cusTile)
    local startCol = 0
    local endCol = 0
    local startRow = 0
    local endRow = 0
    if cusTile then
        local col = tonumber(cusTile.col)
        local row = tonumber(cusTile.row)

        local length = self:getLength()
        local width = self:getWidth()

        startCol = col
        startRow = row

        if self.mDirAngle % 2 == 0 then
            endCol = startCol + width - 1
            endRow = startRow + length - 1
        else
            endCol = startCol + length - 1
            endRow = startRow + width - 1
        end
    end
    return startCol, endCol, startRow, endRow
end

-- 取非中心格子偏移
function getOffsetPos(self)
    local pos = gs.Vector3(0, 0, 0)
    local length = self:getLength()
    local width = self:getWidth()

    if self.mDirAngle % 2 == 0 then
        pos = gs.Vector3(0, length / 2 * DormitoryCost.TITE_SIZE, width / 2 * DormitoryCost.TITE_SIZE)

    else
        pos = gs.Vector3(0, width / 2 * DormitoryCost.TITE_SIZE, length / 2 * DormitoryCost.TITE_SIZE)
    end

    return pos
end

-- 正面朝向角度
function getLookAngle(self)
    if self.mSite == DormitoryCost.SITE_WALL_LEFT then
        return 90
    elseif self.mSite == DormitoryCost.SITE_WALL_RIGHT then
        return 270
    end
end

function getDirValue(self)
    if self.mSite == DormitoryCost.SITE_WALL_LEFT then
        return 1
    elseif self.mSite == DormitoryCost.SITE_WALL_RIGHT then
        return - 1
    end
end

-- 是否覆盖冲突
function getIsCover(self, cusTile)
    cusTile = cusTile or self.mCurCenterTile
    local startCol, endCol, startRow, endRow = self:getBuildArea(cusTile)
    if endCol > self.maxCol or endRow > DormitoryCost.HIGHT_COUNT then
        return true
    end
    -- 同面判断
    for c = startCol, endCol do
        for r = startRow, endRow do
            local state = dormitory.DormitorySceneController:getTileState(self.mSite, c, r, self.propsVo.id)
            if state ~= 0 and state ~= self.propsVo.id then
                return true
            end
        end
    end

    local otherStartRow = 1
    local otherEndRow = 1
    local otherStartCol = 1
    local otherEndCol = 1
    if self.mSite == DormitoryCost.SITE_WALL_LEFT then
        otherStartRow = startCol
        otherEndRow = endCol

        otherStartCol = 1
        otherEndCol = self:getHight()

    elseif self.mSite == DormitoryCost.SITE_WALL_RIGHT then
        --这里需要反过来，因为右边是从上到下，地面是从下到上
        otherStartRow = DormitoryCost.ROW_COUNT - endCol + 1
        otherEndRow = DormitoryCost.ROW_COUNT - startCol + 1

        otherStartCol = DormitoryCost.COL_COUNT - self:getHight() + 1
        otherEndCol = DormitoryCost.COL_COUNT
    end

    for c = otherStartCol, otherEndCol do
        for r = otherStartRow, otherEndRow do
            local propsId = dormitory.DormitorySceneController:getTileState(DormitoryCost.SITE_FLOOR, c, r)
            if propsId ~= 0 then
                local tid = dormitory.DormitoryManager:getFurnitruePropsTid(propsId)
                local data = dormitory.DormitoryManager:getDormitoryBaseVo(tid)

                if startRow <= data.height then
                    return true
                end
            end
        end
    end

    return false
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
