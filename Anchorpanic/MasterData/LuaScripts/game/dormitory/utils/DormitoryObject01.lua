--[[
-----------------------------------------------------
@filename       : DormitoryObject01
@Description    : 宿舍物件(墙面物件正面和背面)
@date           : 2021-08-04 20:08:32
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dormitory.utils.DormitoryObject01', Class.impl(dormitory.DormitoryObject))

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

-- 更新重叠辅助
function updateShowTips(self)
    dormitory.DormitorySceneController:resetTileTip()

    local startCol, endCol, startRow, endRow = self:getBuildArea(self.mCurCenterTile)
    endCol = endCol > self.maxCol and self.maxCol or endCol
    endRow = endRow > self.maxRow and self.maxRow or endRow

    local isCover = self:getIsCover()
    -- for c = startCol, endCol do
    --     for r = 1, self.maxRow do
    --         dormitory.DormitorySceneController:setTileShowTip(self.mSite, c, r, isCover)
    --     end
    -- end
    -- for r = startRow, endRow do
    --     for c = 1, self.maxCol do
    --         dormitory.DormitorySceneController:setTileShowTip(self.mSite, c, r, isCover)
    --     end
    -- end
    for i = startCol, endCol do
        for r = startRow, endRow do
            dormitory.DormitorySceneController:setTileShowTip(self.mSite, i, r, isCover)
        end
    end
end

-- 边界判断
function isOutBorder(self, cusTile)
    local startCol, endCol, startRow, endRow = self:getBuildArea(cusTile)
    if startCol <= 0 or endCol > self.maxCol then
        return true
    end
    if startRow <= 0 or endRow > self.maxRow then
        return true
    end
    return false
end

-- 更新模型位置
function updatePosition(self)
    local tile = dormitory.DormitorySceneController:getTile(self.mSite, self.mCurCenterTile.col, self.mCurCenterTile.row)
    if tile then
        local pos = tile:getPosition()
        local posX = pos.x + (self:getOffsetPos().x - DormitoryCost.TITE_SIZE / 2) * self:getDirValue()
        local posY = pos.y + self:getOffsetPos().y - DormitoryCost.TITE_SIZE / 2
        local posZ = pos.z + self:getOffsetPos().z - DormitoryCost.TITE_SIZE / 2

        pos = gs.Vector3(posX, posY, 0)
        self:setPosition(pos)
    end
    if self.isSelectState then
        GameDispatcher:dispatchEvent(EventName.FURNITURE_MOVE, {pos = self.m_trans.position})
    end
end

function onFrame(self)
    local sceneCamera = gs.CameraMgr:GetToScreenSceneCamera()
    local hitInfo = gs.UnityEngineUtil.RaycastByUICamera(sceneCamera, DormitoryCost.TILE_LAYER_NAME, 100)

    if hitInfo and hitInfo.collider then
        local tileGo = hitInfo.collider.gameObject
        local pos = hitInfo.point

        if string.find(tileGo.name, DormitoryCost.TILE_NAME_LIST[self.mSite]) ~= nil then
            local lpos = tileGo.transform:InverseTransformPoint(pos)
            local c = math.floor(lpos.x / DormitoryCost.TITE_SIZE)
            local r = math.floor(lpos.y / DormitoryCost.TITE_SIZE)
            -- print('================lpos', lpos.x, lpos.y, lpos.z, c, r)
            if self.mCurTileInfo then
                local offsetCol = c - self.mCurTileInfo.col
                local offsetRow = r - self.mCurTileInfo.row

                if math.abs(offsetCol) > 0 or math.abs(offsetRow) > 0 then
                    if self:isOutBorder({col = self.mCurCenterTile.col - offsetCol, row = self.mCurCenterTile.row + offsetRow}) then
                        -- 超出边界
                        return
                    end

                    self.mCurCenterTile = {col = self.mCurCenterTile.col - offsetCol, row = self.mCurCenterTile.row + offsetRow}

                    self:resetOccupyArea()
                    self:updateOccupyArea()
                    self:updateHoldFurniture()

                    self:updatePosition()
                    self:updateShowTips()
                end
            end
            self.mCurTileInfo = {col = c, row = r}

        end

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
        pos = gs.Vector3(width / 2 * DormitoryCost.TITE_SIZE, length / 2 * DormitoryCost.TITE_SIZE, 0)

    else
        pos = gs.Vector3(length / 2 * DormitoryCost.TITE_SIZE, width / 2 * DormitoryCost.TITE_SIZE, 0)
    end

    return pos
end

function setAngle(self)
    local angle = 0
    if self.mDirAngle == 1 then
        angle = 0
    end
    if self.mDirAngle == 2 then
        angle = 90
    end
    if self.mDirAngle == 3 then
        angle = 180
    end
    if self.mDirAngle == 4 then
        angle = 270
    end

    gs.TransQuick:SetRotation(self.m_trans, 0, self:getLookAngle(), angle)
    self:updatePosition()
end

-- 正面朝向角度
function getLookAngle(self)
    if self.mSite == DormitoryCost.SITE_WALL_FRONT then
        return 180
    elseif self.mSite == DormitoryCost.SITE_WALL_BACK then
        return 0
    end
end

function getDirValue(self)
    if self.mSite == DormitoryCost.SITE_WALL_FRONT then
        return 1
    elseif self.mSite == DormitoryCost.SITE_WALL_BACK then
        return - 1
    end
end

-- 是否覆盖冲突
function getIsCover(self, cusTile)
    cusTile = cusTile or self.mCurCenterTile
    local startCol, endCol, startRow, endRow = self:getBuildArea(cusTile)
    if endCol > DormitoryCost.COL_COUNT or endRow > DormitoryCost.HIGHT_COUNT then
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
    -- 厚度判断
    if self.mSite == DormitoryCost.SITE_WALL_FRONT then
        otherStartRow = DormitoryCost.ROW_COUNT - self:getHight() + 1
        otherEndRow = DormitoryCost.ROW_COUNT
        otherStartCol = startCol
        otherEndCol = endCol
    elseif self.mSite == DormitoryCost.SITE_WALL_BACK then
        otherStartRow = 1
        otherEndRow = self:getHight()

        --这里需要反过来，因为下边是从右到左，地面是从左到右
        otherStartCol = DormitoryCost.ROW_COUNT - endCol + 1
        otherEndCol = DormitoryCost.ROW_COUNT - startCol + 1
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
