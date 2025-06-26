-- @FileName:   CiruitSceneUI.lua
-- @Description:   描述
-- @Author: ZDH
-- @Date:   2024-07-03 17:48:19
-- @Copyright:   (LY) 2024 锚点降临

module('game.ciruit.view.CiruitSceneUI', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("ciruit/CiruitSceneUI.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isScreensave = 0 -- 是否使用黑屏过渡(仅1全屏UI有效，默认开启，0关闭)
isBlur = 0
escapeClose = 0 -- 是否能通过esc关闭窗口
isShowCloseAll = false

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setBg("")
    self:setTxtTitle(_TT(130001))
    self:setUICode(LinkCode.Ciruit)
end

function initData(self)

end

-- 初始化
function configUI(self)
    self.m_startView = fightUI.FightStartView.new()
    self.m_startView:initData(self:getChildGO('StartGroup'))

    self.mTextTips = self:getChildGO("mTextTips"):GetComponent(ty.Text)
    self.mText_1 = self:getChildGO("mText_1"):GetComponent(ty.Text)
    self.mTextPutNum = self:getChildGO("mTextPutNum"):GetComponent(ty.Text)
    self.mTextReset = self:getChildGO("mTextReset"):GetComponent(ty.Text)

    self.mSceneLayout = self:getChildGO("mSceneLayout")
    self.mPutLayout = self:getChildGO("mPutLayout")
    self.mLibraryLayout = self:getChildGO("mLibraryLayout")

    self.mPutLayoutRect = self.mPutLayout:GetComponent(ty.RectTransform)

    self.mGridPosItem = self:getChildGO("mGridPosItem")
    self.mGridItem = self:getChildGO("mGridItem")
    self.mPutContent = self:getChildTrans("mPutContent")

    self.mLibraryContent = self:getChildTrans("mLibraryContent")

    self.mBtnReset = self:getChildGO("mBtnReset")

    self.mImgGridBg = self:getChildGO("mImgGridBg"):GetComponent(ty.RectTransform)

    self.mPutGridContent = self:getChildGO("mPutGridContent"):GetComponent(ty.RectTransform)

    self.mRayEmpty = self:getChildGO("mRayEmpty")
end

function initViewText(self)
    self.mText_1.text = _TT(130014)
    self.mTextReset.text = _TT(130015)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnReset, self.onRevokePutGrid)
end

--激活
function active(self, args)
    super.active(self)

    self:AddEventListener()

    self:refreshView(args)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    self:RemoveEventListener()

    self:clearGridPosItem()
    self:clearGridItem()

    ciruit.CiruitManager:clearData()
end

function close(self)
    super.close(self)

    GameDispatcher:dispatchEvent(EventName.CIRUIT_OPENSTAGEMAINUI, {area_id = ciruit.CiruitManager:getAreaIdByDupId(self.m_DupConfigVo.tid)})
end

function refreshView(self, dupConfigVo)
    self.m_DupConfigVo = dupConfigVo

    self.mTextTips.text = self.m_DupConfigVo:getHelpTips()

    ciruit.CiruitManager:clearData()

    self:clearGridPosItem()
    self:clearGridItem()

    self:setTxtTitle(_TT(130019, ciruit.CiruitManager:getAreaIdByDupId(self.m_DupConfigVo.tid), self.m_DupConfigVo:getName()))

    self.mSceneLayout:SetActive(false)
    local function _finishCall()
        self.m_startView:setActive(false)
        self.mSceneLayout:SetActive(true)
        self.mRayEmpty:SetActive(false)
    end
    self.m_startView:setActive(true)
    self.m_startView:start(_finishCall)

    ciruit.CiruitManager:initData(self.m_DupConfigVo)
    self:createScenePosGridItem()

    self:creatSceneGrid()
    self:creatLibraryGrid()
    self:refreshLibaryCount()
end

function AddEventListener(self)
    GameDispatcher:addEventListener(EventName.CIRUIT_GRID_ROTATE, self.refreshGrid, self)
end

function RemoveEventListener(self)
    GameDispatcher:removeEventListener(EventName.CIRUIT_GRID_ROTATE, self.refreshGrid, self)
end

--撤回摆放的部件
function onRevokePutGrid(self)
    if self.m_sceneGridItemDic then
        for grid_id, item in pairs(self.m_sceneGridItemDic) do
            if item:isEnabledPut() then
                item:poolRecover()
                self.m_sceneGridItemDic[grid_id] = nil
            end
        end
    end

    if self.m_libaryGridItemDic then
        for grid_id, item in pairs(self.m_libaryGridItemDic) do
            item:poolRecover()
        end

        self.m_libaryGridItemDic = nil
    end

    self:refreshGrid()
    self:creatLibraryGrid()
    self:refreshLibaryCount()
    -- end
end

function onLibrayGridDragStart(self, gridItem)
    local alphaGo = gs.GameObject.Instantiate(gridItem:getGo())
    self.m_alphaTrans = alphaGo.transform

    local gridTrans = gridItem:getTrans()
    gs.TransQuick:SetParentOrg(self.m_alphaTrans, gridTrans.parent)
    self.m_alphaTrans:SetSiblingIndex(gridTrans:GetSiblingIndex())
    alphaGo:AddComponent(ty.CanvasGroup).alpha = 0.5

    gridItem:readyPut()

    local trans = gridItem:getTrans()
    local rectTrans = trans:GetComponent(ty.RectTransform)

    rectTrans.anchorMin = gs.VEC2_ZERO
    rectTrans.anchorMax = gs.VEC2_ZERO

    gs.TransQuick:SetParentOrg(gridTrans, self.mPutGridContent)

    self:refreshItemPos(rectTrans, gridItem:getId())
end

function onLibraryGridDrag(self, gridItem)
    local trans = gridItem:getTrans()
    local rectTrans = trans:GetComponent(ty.RectTransform)

    self:refreshItemPos(rectTrans, gridItem:getId())
end

function onLibrayGridDragEnd(self, gridItem)
    gs.GameObject.Destroy(self.m_alphaTrans.gameObject)
    self.m_alphaTrans = nil

    local trans = gridItem:getTrans()
    local rectTrans = trans:GetComponent(ty.RectTransform)

    local inPutPos = self:getInPutAnchoredPosition(rectTrans.anchoredPosition)
    local dragCol = math.ceil(inPutPos.x / CiruitConst.GridSize)
    local dragRow = math.ceil(inPutPos.y / CiruitConst.GridSize)

    local isCanPut = false

    local id = gridItem:getId()

    if ciruit.CiruitManager:canPut(dragRow, dragCol, gridItem:getId()) then
        local dropGridPosItem = self.m_GridPosItemDic[dragRow][dragCol]
        if dropGridPosItem then
            local posTran = dropGridPosItem:getChildTrans("mGridTran")

            local trans = gridItem:getTrans()
            local rectTrans = trans:GetComponent(ty.RectTransform)
            rectTrans.anchorMin = gs.Vector2(0.5, 0.5)
            rectTrans.anchorMax = gs.Vector2(0.5, 0.5)
            gs.TransQuick:SetParentOrg(trans, posTran)

            gridItem:putInScene(dragRow, dragCol)
            self.m_sceneGridItemDic[id] = gridItem
            self.m_libaryGridItemDic[id] = nil

            dropGridPosItem:getChildGO("mSelect"):SetActive(false)

            isCanPut = true
        end
    end

    if not isCanPut then
        gridItem:revokePut()

        self.m_sceneGridItemDic[id] = nil
        self.m_libaryGridItemDic[id] = gridItem
    end

    self:refreshGrid()
    self:refreshLibaryCount()
end

function refreshItemPos(self, rectTrans, grid_id)
    local ve2 = gs.Vector2(0, 0)
    local camera = gs.CameraMgr:GetUICamera();
    local vector2 = camera:ScreenToViewportPoint(gs.Input.mousePosition)

    local ScreenResolution_width = self.mPutGridContent.rect.width
    local ScreenResolution_heigt = self.mPutGridContent.rect.height

    ve2.x = ScreenResolution_width * vector2.x
    ve2.y = ScreenResolution_heigt * vector2.y

    rectTrans.anchoredPosition = ve2

    local inPutPos = self:getInPutAnchoredPosition(ve2)
    local dragCol = math.ceil(inPutPos.x / CiruitConst.GridSize)
    local dragRow = math.ceil(inPutPos.y / CiruitConst.GridSize)

    for row, col_dic in pairs(self.m_GridPosItemDic) do
        for col, gridPosItem in pairs(col_dic) do
            gridPosItem:getChildGO("mSelect"):SetActive(false)
        end
    end

    if not ciruit.CiruitManager:canPut(dragRow, dragCol, grid_id) then
        return
    end

    local dropGridPosItem = self.m_GridPosItemDic[dragRow][dragCol]
    if dropGridPosItem then
        dropGridPosItem:getChildGO("mSelect"):SetActive(true)
    end
end

function getInPutAnchoredPosition(self, pos)
    local putPos = self.mPutLayoutRect.anchoredPosition
    return gs.Vector2(pos.x - putPos.x, (self.mPutGridContent.rect.height - pos.y) + putPos.y)
end

function refreshLibaryCount(self)
    local putCount = 0
    local libaryCount = #self.m_DupConfigVo.put_grid

    for grid_id, item in pairs(self.m_sceneGridItemDic) do
        if item:isEnabledPut() then
            putCount = putCount + 1
        end
    end
    self.mTextPutNum.text = _TT(130013, putCount, libaryCount)
end

function creatLibraryGrid(self)
    local emptyLibrary = table.empty(self.m_DupConfigVo.put_grid)
    self.mLibraryLayout:SetActive(not emptyLibrary)
    self.mBtnReset:SetActive(not emptyLibrary)

    if not emptyLibrary then
        local onLibrayGridDragStart = function (gridItem)
            self:onLibrayGridDragStart(gridItem)
        end

        local onLibraryGridDrag = function (gridItem)
            self:onLibraryGridDrag(gridItem)
        end

        local onLibrayGridDragEnd = function (gridItem)
            self:onLibrayGridDragEnd(gridItem)
        end

        self.m_libaryGridItemDic = {}
        for i = 1, #self.m_DupConfigVo.put_grid do
            local grid_id = self.m_DupConfigVo.put_grid[i]

            local gridConfigVo = ciruit.CiruitManager:getGridConfig(grid_id)
            if not gridConfigVo then
                logError("grid 配置找不到 grid_id = " .. grid_id)
            else
                local id = 80000 + i

                local gridItem = self:getGridItem(self.mLibraryContent)

                local gridVo = ciruit.CiruitManager:creatGridVo(id, gridConfigVo)
                gridItem:setData(gridVo)
                gridItem:enabledDarg(onLibrayGridDragStart, onLibraryGridDrag, onLibrayGridDragEnd)

                self.m_libaryGridItemDic[gridItem:getId()] = gridItem
            end
        end
    end
end

function creatSceneGrid(self)
    local width, height = self.m_DupConfigVo.max_col * CiruitConst.GridSize, self.m_DupConfigVo.max_row * CiruitConst.GridSize
    self.mPutLayoutRect.sizeDelta = gs.Vector2(width, height)

    local pos_x, pos_y = 0, 0
    if self.m_DupConfigVo.max_col % 2 == 1 then
        pos_x = 60
    end
    if self.m_DupConfigVo.max_row % 2 == 1 then
        pos_y = 60
    end
    gs.TransQuick:UIPos(self.mImgGridBg, pos_x, pos_y)

    self.m_sceneGridItemDic = {}

    for id, grid in pairs(self.m_DupConfigVo.grid_list) do
        local posItem = self.m_GridPosItemDic[grid.row][grid.col]
        if not posItem then
            logError("超出最大行，或最大列了 row = " .. grid.row .. " col = " .. grid.col)
            return
        end
        local gridConfigVo = ciruit.CiruitManager:getGridConfig(grid.gird_id)
        if not gridConfigVo then
            logError("grid 配置找不到 grid_id = " .. grid.gird_id)
        else
            if gridConfigVo.grid_type == CiruitConst.GridType.Put then

            else
                local posTran = posItem:getChildTrans("mGridTran")
                gridItem = self:getGridItem(posTran)

                local trans = gridItem:getTrans()
                local rectTrans = trans:GetComponent(ty.RectTransform)
                rectTrans.anchorMin = gs.Vector2(0.5, 0.5)
                rectTrans.anchorMax = gs.Vector2(0.5, 0.5)
                gs.TransQuick:LPos(trans, 0, 0, 0)

                local gridVo = ciruit.CiruitManager:creatGridVo(id, gridConfigVo)
                gridItem:setData(gridVo)
                gridItem:putInScene(grid.row, grid.col)

                self.m_sceneGridItemDic[gridItem:getId()] = gridItem
            end
        end
    end

    self:refreshGrid()
end

--创建场景占位格子
function createScenePosGridItem(self)
    for r = 1, self.m_DupConfigVo.max_row do
        if not self.m_GridPosItemDic[r] then
            self.m_GridPosItemDic[r] = {}
        end
        for c = 1, self.m_DupConfigVo.max_col do
            local posItem = SimpleInsItem:create(self.mGridPosItem, self.mPutContent, "ciruit_scene_gridPosItem")
            posItem:getGo().name = string.format("row%s_col%s", r, c)
            posItem:getChildGO("mSelect"):SetActive(false)

            self.m_GridPosItemDic[r][c] = posItem
        end
    end
end

--获取一个新的的格子
function getGridItem(self, parantTrans)
    local gridItem = ciruit.CiruitGridItem:create(self.mGridItem, parantTrans, "ciruit_scene_gridItem")
    return gridItem
end

function refreshGrid(self)
    ciruit.CiruitManager:checkGridPass()

    for _, girdItem in pairs(self.m_sceneGridItemDic) do
        girdItem:refreshPass()
    end

    if ciruit.CiruitManager:checkSettlementPanel() then
        AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_link_2.prefab")

        local dupId = self.m_DupConfigVo.tid
        local curArea_id = ciruit.CiruitManager:getAreaIdByDupId(dupId)

        local nextDupId = ciruit.CiruitManager:getNextDupId(dupId)
        local isShowConfirm = nextDupId ~= nil

        local showAlertMessge = function ()
            local msg = _TT(130017, self.m_DupConfigVo:getName())
            local confirmCall = function ()
                local nextArea_id = ciruit.CiruitManager:getAreaIdByDupId(nextDupId)

                if nextArea_id ~= curArea_id then
                    local nextAreaConfig = ciruit.CiruitManager:getAreaConfig(nextArea_id)
                    if not nextAreaConfig:isOpen() then
                        gs.Message.Show(_TT(130002, nextAreaConfig.begin_time.year, nextAreaConfig.begin_time.month, nextAreaConfig.begin_time.day))

                        self:close()
                        return
                    end
                end

                local nextDupConfigVo = ciruit.CiruitManager:getDupConfig(nextDupId)
                if not nextDupConfigVo:isOpen() then
                    self:close()

                    gs.Message.Show(_TT(130002, nextDupConfigVo.begin_time.year, nextDupConfigVo.begin_time.month, nextDupConfigVo.begin_time.day))
                    return
                end

                GameDispatcher:dispatchEvent(EventName.CIRUIT_OPENSCENEUI, nextDupConfigVo)
            end

            local cancelCall = function ()
                self:close()
            end

            if not isShowConfirm then
                msg = _TT(130020)
            end

            UIFactory:alertMessge(msg, isShowConfirm, confirmCall, _TT(1), nil, true, cancelCall, 130018, _TT(5), true, nil, nil, 10)
        end

        self.mRayEmpty:SetActive(true)
        self:setTimeout(0.5, function ()
            if not ciruit.CiruitManager:getDupPassState(dupId) then
                ShowAwardPanel:getInstance():setCallFun(showAlertMessge)
                GameDispatcher:dispatchEvent(EventName.CIRUIT_REQ_PASSDUP, dupId)
            else
                showAlertMessge()
            end
        end)
    end
end

function clearGridItem(self)
    if self.m_sceneGridItemDic then
        for _, item in pairs(self.m_sceneGridItemDic) do
            item:poolRecover()
        end
    end

    if self.m_libaryGridItemDic then
        for _, item in pairs(self.m_libaryGridItemDic) do
            item:poolRecover()
        end
    end

    self.m_sceneGridItemDic = nil
    self.m_libaryGridItemDic = nil
end

function clearGridPosItem(self)
    if self.m_GridPosItemDic then
        for _, rowList in pairs(self.m_GridPosItemDic) do
            for col, item in pairs(rowList) do
                item:poolRecover()
            end
        end
    end

    self.m_GridPosItemDic = {}
end

return _M
