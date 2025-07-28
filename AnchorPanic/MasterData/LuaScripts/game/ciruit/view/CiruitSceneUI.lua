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
end

function initViewText(self)
    self.mText_1.text = _TT(130014)
    self.mTextReset.text = _TT(130015)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)

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

    ciruit.CiruitManager:clearGridVo()
end

function close(self)
    super.close(self)

    GameDispatcher:dispatchEvent(EventName.CIRUIT_OPENSTAGEMAINUI, {area_id = ciruit.CiruitManager:getAreaIdByDupId(self.mDupConfigVo.tid)})
end

function refreshView(self, dupConfigVo)
    self.mDupConfigVo = dupConfigVo

    ciruit.CiruitManager:clearGridVo()
    ciruit.CiruitManager:initGridVo(self.mDupConfigVo)

    self:setTxtTitle(_TT(130019, ciruit.CiruitManager:getAreaIdByDupId(self.mDupConfigVo.tid), self.mDupConfigVo:getName()))

    self.mSceneLayout:SetActive(false)
    local function _finishCall()
        self.m_startView:setActive(false)
        self.mSceneLayout:SetActive(true)
    end
    self.m_startView:setActive(true)
    self.m_startView:start(_finishCall)

    self:creatSceneGrid()
    self:creatLibraryGrid()
end

function AddEventListener(self)
    GameDispatcher:addEventListener(EventName.CIRUIT_GRID_ROTATE, self.onGridRotate, self)
end

function RemoveEventListener(self)
    GameDispatcher:removeEventListener(EventName.CIRUIT_GRID_ROTATE, self.onGridRotate, self)
end

function creatLibraryGrid(self)
    self.m_HaveLibrary = not table.empty(self.mDupConfigVo.put_grid)
    self.mLibraryLayout:SetActive(self.m_HaveLibrary)
    self.mBtnReset:SetActive(self.m_HaveLibrary)

end

function creatSceneGrid(self)
    local width, height = self.mDupConfigVo.max_col * CiruitConst.GridSize, self.mDupConfigVo.max_row * CiruitConst.GridSize
    self.mPutLayoutRect.sizeDelta = gs.Vector2(width, height)

    local pos_x, pos_y = 0, 0
    if self.mDupConfigVo.max_col % 2 == 1 then
        pos_x = 60
    end
    if self.mDupConfigVo.max_row % 2 == 1 then
        pos_y = 60
    end
    gs.TransQuick:UIPos(self.mImgGridBg, pos_x, pos_y)

    self:clearGridPosItem()
    for i = 1, self.mDupConfigVo.max_row do
        if not self.m_GridPosItemDic[i] then
            self.m_GridPosItemDic[i] = {}
        end
        for j = 1, self.mDupConfigVo.max_col do
            local posItem = SimpleInsItem:create(self.mGridPosItem, self.mPutContent, "ciruit_scene_gridPosItem")
            posItem:getGo().name = string.format("row%s_col%s", i, j)
            posItem:getChildGO("mSelect"):SetActive(false)

            self.m_GridPosItemDic[i][j] = posItem
        end
    end

    self:clearGridItem()
    for id, grid in pairs(self.mDupConfigVo.grid_list) do
        local posItem = self.m_GridPosItemDic[grid.row][grid.col]
        local gridConfigVo = ciruit.CiruitManager:getGridConfig(grid.gird_id)
        if not gridConfigVo then
            logError("grid 配置找不到 grid_id = " .. grid.gird_id)
        else
            if gridConfigVo.grid_type == CiruitConst.GridType.Put then

            else
                local posTran = posItem:getChildTrans("mGridTran")
                local gridItem = ciruit.CiruitGridItem:create(self.mGridItem, posTran, "ciruit_scene_gridItem")
                table.insert(self.m_GridItemList, gridItem)

                local gridVo = ciruit.CiruitManager:getGridVo(grid.row, grid.col)
                gridItem:setData(gridVo)
                gridItem:rotate(gridConfigVo.init_angle)
            end
        end
    end
    ciruit.CiruitManager:checkGridPass()
    self:refreshGrid()
end

function onGridRotate(self)
    ciruit.CiruitManager:checkGridPass()
    self:refreshGrid()

    if ciruit.CiruitManager:checkSettlementPanel() then
        local dupId = self.mDupConfigVo.tid
        local curArea_id = ciruit.CiruitManager:getAreaIdByDupId(dupId)
        
        local nextDupId = ciruit.CiruitManager:getNextDupId(dupId)
        local isShowConfirm = nextDupId ~= nil

        local showAlertMessge = function ()
            local msg = _TT(130017, self.mDupConfigVo:getName())
            local confirmCall = function ()
                local nextArea_id = ciruit.CiruitManager:getAreaIdByDupId(nextDupId)

                if nextArea_id ~= curArea_id then
                    local nextAreaConfig = ciruit.CiruitManager:getAreaConfig(nextArea_id)
                    if not nextAreaConfig:isOpen() then
                        gs.Message.Show(_TT(130002, nextAreaConfig.begin_time.year, nextAreaConfig.begin_time.month, nextAreaConfig.begin_time.day))
                        return
                    end
                end

                local nextDupConfigVo = ciruit.CiruitManager:getDupConfig(nextDupId)
                if not nextDupConfigVo:isOpen() then
                    gs.Message.Show(_TT(130002, nextDupConfigVo.begin_time.year, nextDupConfigVo.begin_time.month, nextDupConfigVo.begin_time.day))
                    return
                end

                GameDispatcher:dispatchEvent(EventName.CIRUIT_OPENSCENEUI, nextDupConfigVo)
            end

            local cancelCall = function ()
                self:close()
                GameDispatcher:dispatchEvent(EventName.CIRUIT_OPENSTAGEMAINUI, {area_id = curArea_id})
            end
            UIFactory:alertMessge(msg, isShowConfirm, confirmCall, _TT(1), nil, true, cancelCall, 130018, _TT(5), true, nil, nil, 10)
        end

        if not ciruit.CiruitManager:getDupPassState(dupId) then
            ShowAwardPanel:getInstance():setCallFun(showAlertMessge)
            GameDispatcher:dispatchEvent(EventName.CIRUIT_REQ_PASSDUP, dupId)
        else
            showAlertMessge()
        end
    end
end

function refreshGrid(self)
    for _, girdItem in pairs(self.m_GridItemList) do
        girdItem:refreshPass()
    end
end

function clearGridItem(self)
    if self.m_GridItemList then
        for _, item in pairs(self.m_GridItemList) do
            item:poolRecover()
        end
    end

    self.m_GridItemList = {}
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
