--[[
-----------------------------------------------------
@filename       : DormitoryObject
@Description    : 宿舍物件
@date           : 2021-07-21 11:07:25
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dormitory.utils.DormitoryObject', Class.impl())

function ctor(self)
    self.m_points = {}
    self.mDirAngle = 1
    self.mSite = nil
    self.mCurArea = nil
    self.mCurTileInfo = nil
    self.mCurCenterTile = nil
    self.mTileRoot = gs.GameObject.Find("tile")
    self.maxCol = DormitoryCost.COL_COUNT
    self.maxRow = DormitoryCost.ROW_COUNT

    --交互点
    self.mInteractPointList = {}

    self:initData()
end

function initData(self)
    self.mInitCol = math.floor(self.maxCol / 2)
    self.mInitRow = math.floor(self.maxRow / 2)
end

-- 获取可用的tile
function getInitColRow(self, col, row)
    local index = 0
    local function getTile()
        local min_col = col - index
        min_col = min_col < 0 and 0 or min_col

        local max_col = col + index
        max_col = max_col > self.maxCol and self.maxCol or max_col

        local min_row = row - index
        min_row = min_row < 0 and 0 or min_row

        local max_row = row + index
        max_row = max_row > self.maxRow and self.maxRow or max_row

        local cusTile = {}

        --▷
        for c = min_col, max_col do
            cusTile = {col = c, row = max_row}
            --既没有超出边界也没有重叠
            if not self:isOutBorder(cusTile) and not self:getIsCover(cusTile) then
                return cusTile
            end
        end

        --▽
        for r = max_row, min_row, -1 do
            cusTile = {col = max_col, row = r}
            --既没有超出边界也没有重叠
            if not self:isOutBorder(cusTile) and not self:getIsCover(cusTile) then
                return cusTile
            end
        end

        --◁
        for c = max_col, min_col, -1 do
            cusTile = {col = c, row = min_row}
            if not self:isOutBorder(cusTile) and not self:getIsCover(cusTile) then
                return cusTile
            end
        end

        --△
        for r = min_row, max_row do
            cusTile = {col = min_col, row = r}
            if not self:isOutBorder(cusTile) and not self:getIsCover(cusTile) then
                return cusTile
            end
        end

        local maxIndex = self.maxCol > self.maxRow and self.maxCol or self.maxRow
        if index > maxIndex then
            return index
        end
        index = index + 1
        return getTile()
    end

    local tileData = getTile()
    if type(tileData) == "number" then
        logAll("====找不到位置====")
        return {col = col, row = row}
    end

    return tileData
end

function createObject(self, cusSite, cusPropsVo, cusInfo, configInfo, finishCall)
    self.mSite = cusSite
    self.propsVo = cusPropsVo

    self.baseData = dormitory.DormitoryManager:getDormitoryBaseVo(cusPropsVo.tid)
    if cusInfo then
        self.mMsgInfo = cusInfo
        self.mDirAngle = cusInfo.dir
        self.mCurCenterTile = {col = self.mMsgInfo.col, row = self.mMsgInfo.row}
    elseif configInfo then
        self.mDirAngle = configInfo.dir
        self.mCurCenterTile = {col = configInfo.col, row = configInfo.row}
    else
        self.mCurCenterTile = self:getInitColRow(self.mInitCol, self.mInitRow)
        local furnitureVo = dormitory.DormitoryManager:getFurnitureInfo(cusPropsVo.id)
        self.mMsgInfo = furnitureVo
    end
    self:updateHoldFurniture()

    self.m_rootGo = gs.GameObject()
    self.m_trans = self.m_rootGo.transform
    self:initObjectInfo()

    local isSelect = cusInfo == nil and configInfo == nil
    self:setupPrefab(UrlManager:getFurniturePrefabUrl(self:getResName()), finishCall, isSelect)

    GameDispatcher:addEventListener(EventName.SELECT_FURNITURE_CANCEL, self.onCancelSelect, self)
    GameDispatcher:addEventListener(EventName.PUT_FURNITURE_SURE, self.onSurePut, self)
    GameDispatcher:addEventListener(EventName.STORAGE_FURNITURE, self.onStorage, self)
    GameDispatcher:addEventListener(EventName.TURN_FURNITURE, self.onTurn, self)
    GameDispatcher:addEventListener(EventName.DORMITORY_UPDATE_FURNINTERACT_STATE, self.updateActionPointTile, self)
    GameDispatcher:addEventListener(EventName.ENTER_DORMITORY_EDIT, self.updateActionPointTile, self)
    GameDispatcher:addEventListener(EventName.QUIT_DORMITORY_EDIT, self.updateActionPointTile, self)
end

function initObjectInfo(self)
    self:updatePosition()
    self:setAngle()
    self:updateOccupyArea()
end

function getTid(self)
    return self.baseData.tid
end

function getLength(self)
    return self.baseData.length
end

function getWidth(self)
    return self.baseData.width
end

function getHight(self)
    return self.baseData.height
end

function getResName(self)
    return self.baseData.resName
end

-- 旋转
function onTurn(self)
    if not self.isSelectState then
        return
    end
    if self.baseData.isRotate == 0 then
        gs.Message.Show2(_TT(49714))
        return
    end
    local angle = self.mDirAngle == 4 and 1 or self.mDirAngle + 1
    self.mDirAngle = angle
    self:setAngle()
    self:updateShowTips()
end

-- 收纳回包
function onStorage(self)
    if not self.isSelectState then
        return
    end

    self.isSelectState = false
    self:setGridState(false)
    self:storageHanlder()
    dormitory.DormitorySceneController:deleteFurnitureNum(self.propsVo.subType, self.propsVo.id)
end
-- 收纳处理
function storageHanlder(self)
    if dormitory.DormitoryManager:getFurnitureInfo(self.propsVo.id) then
        self:setMoveInfo(true)
    elseif dormitory.DormitoryManager:getMoveInfo(self.propsVo.id) then
        dormitory.DormitoryManager:removeMoveInfo(self.propsVo.id)
    end
    -- 从临时背包移动回背包
    dormitory.DormitoryManager:moveToSourceBag(self.propsVo)
    self:removeFurniture()
end
-- 撤下家具
function removeFurniture(self)
    dormitory.DormitorySceneController:resetTileTip()

    self:resetOccupyArea()
    self:onRecover()
end
-- 确定摆放更改
function onSurePut(self, propsId)
    if propsId == nil then
        if not self.isSelectState then
            return
        end
    elseif propsId ~= self.propsVo.id then
        return
    end

    local code = 0
    if not self:getIsCover() then
        code = 1
        self.isSelectState = false
        dormitory.DormitorySceneController:resetTileTip()
        if dormitory.DormitoryManager:getMoveInfo(self.propsVo.id) then
            dormitory.DormitoryManager:removeMoveInfo(self.propsVo.id)
        end

        self:resetOccupyArea()
        self:updateHoldFurniture()
        self:setMoveInfo()
        self:updateOccupyArea()
        self:setGridState(false)
    end
    GameDispatcher:dispatchEvent(EventName.PUT_FURNITURE_RETURN, {result = code})

    --恢复去除描边
    self:SetOutLineColor_normalState()
end
-- 取消摆放更改
function onCancelSelect(self)
    if not self.isSelectState then
        return
    end
    self.isSelectState = false
    self:resetOccupyArea()
    dormitory.DormitorySceneController:resetTileTip()

    self:setGridState(false)
    -- 优先移动信息
    local moveInfo = dormitory.DormitoryManager:getMoveInfo(self.propsVo.id)
    local info = moveInfo or self.mMsgInfo
    if info then
        self.mCurCenterTile = {col = info.col, row = info.row}
        self.mDirAngle = info.dir
        self:initObjectInfo()
        self:updateHoldFurniture()
        self:setAngle()
    else
        -- 从临时背包移动回背包
        dormitory.DormitoryManager:moveToSourceBag(self.propsVo)
        self:onRecover()
        dormitory.DormitorySceneController:deleteFurnitureNum(self.propsVo.subType, self.propsVo.id)
    end

    --恢复去除描边
    self:SetOutLineColor_normalState()
end

-- 家具选中
function furnitureSelect(self)
    if dormitory.DormitoryManager.hasSelectFurniture then
        return
    end

    self.isSelectState = true
    dormitory.DormitoryManager.hasSelectFurniture = true

    GameDispatcher:dispatchEvent(EventName.SELECT_FURNITURE_PUT, {pos = self.m_trans.position})

    self:setGridState(true)

    self:updateShowTips()
end

-- 设置网格显示状态
function setGridState(self, isActive)
    local girdGo = self.mTileRoot.transform:Find(DormitoryCost.TILE_NAME_LIST[self.mSite]).gameObject
    girdGo:GetComponent(ty.MeshRenderer).enabled = true
    girdGo:SetActive(isActive)
end

-- 点击
function onPointClickHandler(self)
    if dormitory.DormitoryManager.isEditState == false or dormitory.DormitoryManager.hasSelectFurniture then
        return
    end

    if self.isSelectState then
        return
    end

    if gs.UnityEngineUtil.GetRaycastUIResults(gs.Vector2(gs.UnityEngineUtil.GetMousePosX(), gs.UnityEngineUtil.GetMousePosY())).Count > 1 then
        return
    end

    self:resetOccupyArea()
    self:furnitureSelect()
end
-- 鼠标按下
function onPointDownHandler(self)
    -- if not self.isSelectState then
    --     local SelectFurnitureVo = dormitory.DormitorySceneController.roomScene:getCurSelectFurniture()
    --     if SelectFurnitureVo then
    --         SelectFurnitureVo:onStartDrag()
    --     end
    --     return
    -- end

    if not self.isSelectState then return end

    self:onStartDrag()
end
--开始拖动
function onStartDrag(self)
    self.isStartDrag = true

    self.mFrameSn = LoopManager:addFrame(1, 0, self, self.onFrame)

    GameDispatcher:dispatchEvent(EventName.START_DRAG_FURNITURE)
end
-- 鼠标按下释放
function onPointerUpHandler(self)
    if not self.isStartDrag then
        local SelectFurnitureVo = dormitory.DormitorySceneController.roomScene:getCurSelectFurniture()
        if SelectFurnitureVo then
            SelectFurnitureVo:onEndDrag()
        end
        return
    end
    self:onEndDrag()
end
--结束拖动
function onEndDrag(self)
    self.isStartDrag = false
    -- self:updateOccupyArea()
    self:clearFrameSn()
    self.mCurTileInfo = nil

    GameDispatcher:dispatchEvent(EventName.END_DRAG_FURNITURE)
end

function clearFrameSn(self)
    if self.mFrameSn then
        LoopManager:removeFrameByIndex(self.mFrameSn)
        self.mFrameSn = nil
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
            local r = math.floor(lpos.z / DormitoryCost.TITE_SIZE)
            -- print('================lpos', lpos.x, lpos.y, lpos.z, c, r)
            if self.mCurTileInfo then
                local offsetCol = c - self.mCurTileInfo.col
                local offsetRow = r - self.mCurTileInfo.row

                if math.abs(offsetCol) > 0 or math.abs(offsetRow) > 0 then
                    -- print('================lpos', lpos.x, lpos.y, lpos.z, c, r, offsetCol, offsetRow)
                    if self:isOutBorder({col = self.mCurCenterTile.col + offsetCol, row = self.mCurCenterTile.row + offsetRow}) then
                        -- 超出边界
                        return
                    end

                    self.mCurCenterTile = {col = self.mCurCenterTile.col + offsetCol, row = self.mCurCenterTile.row + offsetRow}

                    self:resetOccupyArea()
                    self:updateOccupyArea()
                    self:updateHoldFurniture()

                    self:updateShowTips()

                    self:updatePosition()
                end
            end
            self.mCurTileInfo = {col = c, row = r}
        end
    end
end

-- 更新模型位置
function updatePosition(self)
    local tile = dormitory.DormitorySceneController:getTile(self.mSite, self.mCurCenterTile.col, self.mCurCenterTile.row)
    if tile then
        local pos = tile:getPosition()
        local posX = pos.x + self:getOffsetPos().x - DormitoryCost.TITE_SIZE / 2
        local posY = pos.y + self:getOffsetPos().y - DormitoryCost.TITE_SIZE / 2
        local posZ = pos.z + self:getOffsetPos().z - DormitoryCost.TITE_SIZE / 2

        pos = gs.Vector3(posX, 0.01, posZ)
        self:setPosition(pos)
    end

    if self.isSelectState then
        GameDispatcher:dispatchEvent(EventName.FURNITURE_MOVE, {pos = self.m_trans.position})
        GameDispatcher:dispatchEvent(EventName.DORMITORY_UPDATE_FURNINTERACT_STATE)
    end
end

--更新交互点所在的格子 跟更新交互点的状态
function updateActionPointTile(self)
    local floorTileRoot = gs.GameObject.Find(DormitoryCost.FLOOR_TILE_ROOT)
    if floorTileRoot ~= nil and not gs.GoUtil.IsGoNull(floorTileRoot) then
        local floorTileRootTrans = floorTileRoot.transform

        for _, data in pairs(self.mInteractPointList) do
            local pos = floorTileRootTrans:InverseTransformPoint(data.point.position)
            data.col = math.ceil(pos.x / DormitoryCost.TITE_SIZE)
            data.row = math.ceil(pos.z / DormitoryCost.TITE_SIZE)
            data.tile = nil
            data.canMove = false

            local tile = dormitory.DormitorySceneController:getTile(DormitoryCost.SITE_FLOOR, data.col, data.row)
            if tile then
                data.tile = tile

                local tilePos = tile:getPosition()
                pos = tilePos

                if data.tile:getState() == 0 then
                    data.canMove = true
                end
            end

            if dormitory.DormitoryManager.isEditState then
                if data.efx_green == nil or gs.GoUtil.IsGoNull(data.efx_green) then
                    data.efx_green = gs.ResMgr:LoadGO("arts/fx/3d/role/prefab/common/buff_shouzhang_green.prefab")
                    data.efx_green.transform:SetParent(floorTileRoot.transform)
                    data.efx_green.transform.localPosition = pos
                    data.efx_green.transform:SetParent(data.point.transform)
                    data.efx_green.transform.localEulerAngles = gs.VEC3_ZERO
                end
                data.efx_green:SetActive(data.canMove)

                if data.efx_red == nil or gs.GoUtil.IsGoNull(data.efx_red) then
                    data.efx_red = gs.ResMgr:LoadGO("arts/fx/3d/role/prefab/common/buff_shouzhang_red.prefab")
                    data.efx_red.transform:SetParent(floorTileRoot.transform)
                    data.efx_red.transform.localPosition = pos
                    data.efx_red.transform:SetParent(data.point.transform)
                    data.efx_red.transform.localEulerAngles = gs.VEC3_ZERO
                end
                data.efx_red:SetActive(not data.canMove)
            else
                if data.efx_red then
                    data.efx_red:SetActive(false)
                end
                if data.efx_green then
                    data.efx_green:SetActive(false)
                end
            end
        end
    end
end

-- 设置移动信息到缓存列表
function setMoveInfo(self, isStorage)
    local data = {}
    if isStorage then
        -- 收纳
        data.move = 1
    else
        if self.mMsgInfo then
            -- 移动
            data.move = 0
        else
            -- 摆放
            data.move = 2
        end
    end

    data.id = self.propsVo.id
    data.tid = self.propsVo.tid
    data.row = self.mCurCenterTile.row
    data.col = self.mCurCenterTile.col
    data.location = self.mSite
    data.dir = self.mDirAngle
    data.subType = self.propsVo.subType

    dormitory.DormitoryManager:setMoveInfo(data)
end

-- 更新重叠辅助
function updateShowTips(self)
    dormitory.DormitorySceneController:resetTileTip()

    local startCol, endCol, startRow, endRow = self:getBuildArea(self.mCurCenterTile)
    endCol = endCol > DormitoryCost.COL_COUNT and DormitoryCost.COL_COUNT or endCol
    endRow = endRow > DormitoryCost.ROW_COUNT and DormitoryCost.ROW_COUNT or endRow

    local isCover = self:getIsCover()
    for i = startCol, endCol do
        for r = startRow, endRow do
            dormitory.DormitorySceneController:setTileShowTip(self.mSite, i, r, isCover)
        end
    end
    if isCover then
        self:SetOutLineColor_highlightState("FF0000FF")
    else
        self:SetOutLineColor_highlightState("73E6FFFF")
    end

    -- for i = startCol, endCol do
    --     for r = 1, DormitoryCost.ROW_COUNT do
    --         dormitory.DormitorySceneController:setTileShowTip(self.mSite, i, r, isCover)
    --     end
    -- end
    -- for i = startRow, endRow do
    --     for c = 1, DormitoryCost.COL_COUNT do
    --         dormitory.DormitorySceneController:setTileShowTip(self.mSite, c, i, isCover)
    --     end
    -- end
end

-- 恢复本来占用的
function resetOccupyArea(self)
    if self.mCurArea then
        for c = self.mCurArea.startCol, self.mCurArea.endCol do
            for r = self.mCurArea.startRow, self.mCurArea.endRow do
                local id = dormitory.DormitorySceneController:getTileState(self.mSite, c, r)
                if id == self.propsVo.id then
                    -- logAll("解除占用")
                    dormitory.DormitorySceneController:setTileHoldFurniture(self.mSite, c, r, 0)
                end
            end
        end
        self.mCurArea = nil
    end
end

-- 更新占用格子
function updateOccupyArea(self)
    local startCol, endCol, startRow, endRow = self:getBuildArea(self.mCurCenterTile)
    self.mCurArea = {startCol = startCol, endCol = endCol, startRow = startRow, endRow = endRow}
end

-- 更新格子锁定的家具
function updateHoldFurniture(self)
    -- 设置新占用格子
    local startCol, endCol, startRow, endRow = self:getBuildArea(self.mCurCenterTile)
    for c = startCol, endCol do
        for r = startRow, endRow do
            -- logAll(self.propsVo.id, "更新占用" .. c .. "-" .. r)
            dormitory.DormitorySceneController:setTileHoldFurniture(self.mSite, c, r, self.propsVo.id)
        end
    end

    GameDispatcher:dispatchEvent(EventName.DORMITORY_UPDATE_FURNINTERACT_STATE)
end

-- 边界判断
function isOutBorder(self, cusTile)
    local startCol, endCol, startRow, endRow = self:getBuildArea(cusTile)
    if startCol <= 0 or endCol > DormitoryCost.COL_COUNT then
        return true
    end
    if startRow <= 0 or endRow > DormitoryCost.ROW_COUNT then
        return true
    end
    return false
end

-- 是否覆盖冲突
function getIsCover(self, cusTile)
    cusTile = cusTile or self.mCurCenterTile
    local startCol, endCol, startRow, endRow = self:getBuildArea(cusTile)

    if endCol > DormitoryCost.COL_COUNT or endRow > DormitoryCost.ROW_COUNT then
        return true
    end
    for c = startCol, endCol do
        for r = startRow, endRow do
            local state = dormitory.DormitorySceneController:getTileState(self.mSite, c, r, self.propsVo.id)
            if state ~= 0 and state ~= self.propsVo.id then
                return true
            end
        end
    end

    -- 地面和墙面冲突（挂饰应该不会超过8格厚度吧）
    local getH = function(site, c, r)
        local h = 0
        local propsId = dormitory.DormitorySceneController:getTileState(site, c, r)
        if propsId ~= 0 then
            if propsId == DormitoryCost.DOOR_CLIENT_ID then
                h = dormitory.DormitoryManager:getCurDoorDeep()
            else
                local tid = dormitory.DormitoryManager:getFurnitruePropsTid(propsId)
                local data = dormitory.DormitoryManager:getDormitoryBaseVo(tid)
                h = data.height
            end
        end
        return h
    end

    local max_col = self.maxCol - 8
    local max_row = self.maxRow - 8

    if startRow < 8 or endRow < 8 then --后
        local otherStartCol = self.maxCol - endCol + 1
        local otherEndCol = self.maxCol - startCol + 1
        -- DormitoryCost.SITE_WALL_BACK
        for c = otherStartCol, otherEndCol do
            for r = 1, self:getHight() do
                local height = getH(DormitoryCost.SITE_WALL_BACK, c, r)
                if height > 0 and startRow <= height then
                    return true
                end
            end
        end

    elseif startRow > max_row or endRow > max_row then --前
        -- DormitoryCost.SITE_WALL_FRONT
        for c = startCol, endCol do
            for r = 1, self:getHight() do
                local height = getH(DormitoryCost.SITE_WALL_FRONT, c, r)
                if height > 0 and endRow > (self.maxRow - height) then
                    return true
                end
            end
        end
    end

    if startCol < 8 or endCol < 8 then --左
        -- DormitoryCost.SITE_WALL_LEFT
        for c = startRow, endRow do
            for r = 1, self:getHight() do
                local height = getH(DormitoryCost.SITE_WALL_LEFT, c, r)
                if height > 0 and startCol <= height then
                    return true
                end
            end
        end

    elseif startCol > max_col or endCol > max_col then --右
        -- DormitoryCost.SITE_WALL_RIGHT
        local otherStartRow = self.maxRow - endRow + 1
        local otherEndRow = self.maxCol - startRow + 1
        for c = otherStartRow, otherEndRow do
            for r = 1, self:getHight() do
                local height = getH(DormitoryCost.SITE_WALL_RIGHT, c, r)
                if height > 0 and endCol > (self.maxCol - height) then
                    return true
                end
            end
        end
    end

    return false
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
        pos = gs.Vector3(width / 2 * DormitoryCost.TITE_SIZE, 0, length / 2 * DormitoryCost.TITE_SIZE)

    else
        pos = gs.Vector3(length / 2 * DormitoryCost.TITE_SIZE, 0, width / 2 * DormitoryCost.TITE_SIZE)
    end

    return pos
end

-- 启动模型
function setupPrefab(self, prefabname, finishCall, isSelect)
    if not self.m_rootGo or gs.GoUtil.IsGoNull(self.m_rootGo) then
        logError("本对象已被销毁了 " .. prefabname)
        return
    end
    self.m_prefabName = prefabname
    local function _loadAysnModeCall(go)
        self.m_loadSn = 0
        if go then
            if not self.m_rootGo or gs.GoUtil.IsGoNull(self.m_rootGo) then
                logError("本对象已被销毁了22 " .. prefabname)
                gs.GameObject.Destroy(go)
                return
            end
            self.m_model = go
            -- self.m_model:AddComponent(ty.MeshCollider)
            self.m_modelTrans = self.m_model.transform
            local mouseEvent = self.m_model:AddComponent(ty.GoMouseEvent)
            mouseEvent:SetCallFun(self, self.onPointClickHandler, self.onPointDownHandler, self.onPointerUpHandler)

            self.m_modelTrans:SetParent(self.m_trans, false)
            self.m_model:SetActive(true)
            if string.find(prefabname, "monster") then
                self.m_modelTrans.localPosition = gs.Vector3(0, 0.01, 0)
            else
                gs.TransQuick:PosScale(self.m_modelTrans)
            end
            self.m_rootGo.name = self:getResName()

            self.m_defLayer = gs.LayerMask.LayerToName(self.m_model.layer)
            if self.m_displayLayer and self.m_displayLayer ~= self.m_defLayer then
                self:setDisplayLayer(self.m_displayLayer)
            end

            self.m_modelMaterials = self.m_model:GetComponent(ty.ModelMaterials)
            if not self.m_modelMaterials or gs.GoUtil.IsCompNull(self.m_modelMaterials) then
                self.m_modelMaterials = self.m_model:AddComponent(ty.ModelMaterials)
            end
            if self.m_modelMaterials ~= nil and not gs.GoUtil.IsCompNull(self.m_modelMaterials) then
                self.m_modelMaterials:SetOutLineColor_highlightState();
                self.m_modelMaterials:RecordColorValue_outline();
            end

            self:setToParent(self:getParentTrans(), false)

            if isSelect then
                self:furnitureSelect()
            end

            for i = 1, 3 do
                local point = self.m_modelTrans:Find(string.format("heroActionPoint_%s_1", i))
                if point and not gs.GoUtil.IsTransNull(point) then
                    local data = {}
                    data.point = point
                    data.childPoint = self.m_modelTrans:Find(string.format("heroActionPoint_%s_2", i))
                    data.heroTid = 0
                    data.actName = self.baseData.interact_name[i]
                    self.mInteractPointList[i] = data
                end

            end
            self:updateActionPointTile()

            if finishCall then
                finishCall(true, self)
            end
        else
            logError("object Model " .. self.m_prefabName .. "not exist")
            if finishCall then
                finishCall(false, self)
            end
        end
    end
    self:clearModel()
    if self.m_loadSn and self.m_loadSn ~= 0 then
        gs.ResMgr:CancelLoadAsync(self.m_loadSn)
    end
    self.m_loadSn = gs.ResMgr:LoadGOAysn(self.m_prefabName, _loadAysnModeCall)
end

function getParentTrans(self)
    return dormitory.DormitorySceneController.roomScene:getSiteHanging(self.mSite)
end

function setPosition(self, lpos)
    if not lpos then return end
    self.m_position = lpos
    if self.m_trans then
        gs.TransQuick:LPos(self.m_trans, self.m_position.x, self.m_position.y, self.m_position.z)
    end
end

function setToParent(self, parent, worldPositionStays)
    self.m_parentTrans = parent
    if self.m_trans then
        if worldPositionStays == nil then
            worldPositionStays = false
        end
        self.m_trans:SetParent(parent, worldPositionStays)
        self.m_parentTrans = nil
    end
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

    gs.TransQuick:SetRotation(self.m_trans, 0, angle, 0)
    self:updatePosition()
end

-- 正面朝向角度
function getLookAngle(self)
    return 0
end

-- 清空模型 (并不是删除! 删除请用destroy)
function clearModel(self)
    if self.m_loadSn and self.m_loadSn ~= 0 then
        gs.ResMgr:CancelLoadAsync(self.m_loadSn)
        self.m_loadSn = 0
    end
    if self.m_model then
        local mouseEvent = self.m_model:GetComponent(ty.GoMouseEvent)
        if mouseEvent then
            mouseEvent:SetCallFun(nil, nil, nil, nil)
        end

        gs.GameObject.Destroy(self.m_model)
        self.m_model = nil
        self.m_modelTrans = nil
        self.m_ani = nil
    end
end

function onRecover(self)
    self:destroy()
end

function destroy(self)
    GameDispatcher:removeEventListener(EventName.SELECT_FURNITURE_CANCEL, self.onCancelSelect, self)
    GameDispatcher:removeEventListener(EventName.PUT_FURNITURE_SURE, self.onSurePut, self)
    GameDispatcher:removeEventListener(EventName.STORAGE_FURNITURE, self.onStorage, self)
    GameDispatcher:removeEventListener(EventName.TURN_FURNITURE, self.onTurn, self)
    GameDispatcher:removeEventListener(EventName.DORMITORY_UPDATE_FURNINTERACT_STATE, self.updateActionPointTile, self)
    GameDispatcher:removeEventListener(EventName.ENTER_DORMITORY_EDIT, self.updateActionPointTile, self)
    GameDispatcher:removeEventListener(EventName.QUIT_DORMITORY_EDIT, self.updateActionPointTile, self)

    self:clearFrameSn()
    self:clearModel()
    if self.m_rootGo then
        gs.GameObject.Destroy(self.m_rootGo)
        self.m_rootGo = nil
        self.m_trans = nil
    end
end

--获取可以交互的点
function getCanActionPoint(self, heroPos)
    if self.mInteractPointList and not table.empty(self.mInteractPointList) then
        if heroPos ~= nil then
            local distance = 999999999
            local pointData = nil
            local curDistance = 0

            for k, v in pairs(self.mInteractPointList) do
                if v.heroTid == 0 and v.tile and v.canMove then
                    curDistance = gs.Vector3.Distance(v.tile:getPosition(), heroPos)
                    if curDistance < distance then
                        distance = curDistance
                        pointData = v
                    end
                end
            end
            return pointData
        else
            for k, v in pairs(self.mInteractPointList) do
                if v.heroTid == 0 and v.canMove then
                    return v
                end
            end
        end
    end
end

--获取所有的交互点
function getAllInteractData(self)
    return self.mInteractPointList
end

---描边
function SetOutLineColor_highlightState(self, color)
    if self.m_modelMaterials then
        self.m_modelMaterials.HighlightStateColor_outLine = gs.ColorUtil.GetColor(color)
        self.m_modelMaterials:SetOutLineColor_highlightState()
    end
end

--恢复描边
function SetOutLineColor_normalState(self)
    if self.m_modelMaterials then
        self.m_modelMaterials:SetOutLineColor_normalState()
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
语言包: _TT(49714):"不可旋转"
]]
