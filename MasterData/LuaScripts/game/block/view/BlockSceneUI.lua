-- @FileName:   BlockSceneUI.lua
-- @Description:   描述
-- @Author: ZDH
-- @Date:   2024-07-03 17:48:19
-- @Copyright:   (LY) 2024 锚点降临

module('game.block.view.BlockSceneUI', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("block/BlockSceneUI.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isScreensave = 0 -- 是否使用黑屏过渡(仅1全屏UI有效，默认开启，0关闭)
isBlur = 0
escapeClose = 0 -- 是否能通过esc关闭窗口
isShowCloseAll = false

--构造函数
function ctor(self)
    super.ctor(self)
    -- self:setSize(750, 600)
    -- self:setBg("")
    -- self:setTxtTitle(_TT(138601))
    self:setUICode(LinkCode.Block)
end

function initData(self)

end

-- 初始化
function configUI(self)
    self.m_startView = fightUI.FightStartView.new()
    self.m_startView:initData(self:getChildGO('StartGroup'))

    self.mBtnPause = self:getChildGO("mBtnPause")
    self.mGroupPause = self:getChildGO("mGroupPause")
    self.mGroupStar = self:getChildTrans("mGroupStar")
    self.mBtnReplay = self:getChildGO("mBtnReplay")
    self.mBtnPlay = self:getChildGO("mBtnPlay")
    self.mBtnExit = self:getChildGO("mBtnExit")
    self.mBtnFinish = self:getChildGO("mBtnFinish")

    self.mImgStart = self:getChildGO("mImgStart")
    self.mImgPause = self:getChildGO("mImgPause")

    self.mapGroup = self:getChildTrans("mapGroup")
    self.mGridItem = self:getChildGO("mGridItem")
    self.mGridItemRect = self.mGridItem:GetComponent(ty.RectTransform)
    self.m_initSize = {width = self.mGridItemRect.rect.width, height = self.mGridItemRect.rect.height}
    self.mItem = self:getChildGO("mItem")

    self.mNextItem = self:getChildGO("mNextItem")
    self.nextGroup = self:getChildTrans("nextGroup")

    self.UITransRect = self.UITrans:GetComponent(ty.RectTransform)

    self.mTempContent = self:getChildTrans("mTempContent")

    self.mTextCurScore = self:getChildGO("mTextCurScore"):GetComponent(ty.Text)
    self.mTextTagerScore = self:getChildGO("mTextTagerScore"):GetComponent(ty.Text)
    self.mImgPass = self:getChildGO("mImgPass")

    self.mTextPassScore = self:getChildGO("mTextPassScore"):GetComponent(ty.Text)
    self.mTextTargerScore = self:getChildGO("mTextTargerScore"):GetComponent(ty.Text)
    self.mTextFinish = self:getChildGO("mTextFinish"):GetComponent(ty.Text)
    self.mTextNoFinish = self:getChildGO("mTextNoFinish"):GetComponent(ty.Text)

    self.mTxtPause = self:getChildGO("mTxtPause"):GetComponent(ty.Text)

    self.mFinish = self:getChildGO("mFinish")
    self.mNoFinish = self:getChildGO("mNoFinish")

end

function initViewText(self)
    self.mTextFinish.text = _TT(151245)
    self.mTextNoFinish.text = _TT(98966)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnPause, self.onPauseClick)

    self:addUIEvent(self.mBtnReplay, self.onReplayClick)
    self:addUIEvent(self.mBtnPlay, self.onPlayClick)
    self:addUIEvent(self.mBtnExit, self.onExitClick)
    self:addUIEvent(self.mBtnFinish, self.onFinishClick)
end

--激活
function active(self, args)
    super.active(self)

    self:AddEventListener()

    self:clearData()

    self.mGroupPause:SetActive(false)
    self:refreshPauseState(false)
    self:refreshView(args)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    self:RemoveEventListener()

    self:clearData()
end

function clearData(self)
    self:clearMap()
    self:clearNextGrid()

    self.mTextCurScore.text = "0"
    self.mTextTagerScore.text = "0"
    self.mImgPass:SetActive(false)

    self.m_isAutoPause = nil
end

function AddEventListener(self)
    GameDispatcher:addEventListener(EventName.BLOCK_UPDATE_PAUSESTATE, self.refreshPauseState, self)
end

function RemoveEventListener(self)
    GameDispatcher:removeEventListener(EventName.BLOCK_UPDATE_PAUSESTATE, self.refreshPauseState, self)
end

function refreshView(self, args)
    self.m_DupConfigVo = args

    self:clearData()

    local function _finishCall()
        self.m_startView:setActive(false)

        self:onStartGame()
    end
    self.m_startView:setActive(true)
    self.m_startView:start(_finishCall)
end

function onStartGame(self)
    self.m_curScore = 0
    self.mTextCurScore.text = self.m_curScore
    self.mTextTagerScore.text = self.m_DupConfigVo.target_score

    self:createMap()

    if gs.Application.isEditor then
        block.BlockGridItem = require("game/block/view/item/BlockGridItem")
    end
    for i = 1, 3 do
        self:createNextGrid()
    end
end

function createMap(self)
    self.m_mapGridList = {}

    self.m_gridSizeX = self.m_initSize.width + 1
    self.m_gridSizeY = self.m_initSize.height + 2

    self.m_intervalX = self.m_gridSizeX / 2
    self.m_intervalY = self.m_gridSizeY * (3 / 4)

    local id_index = 0

    self.m_mapRowColCount = {} --缓存每行的格子数量
    local pos_x, pos_y = 0, 0

    self.m_maxLineCount = self.m_DupConfigVo.size --总行数，奇数
    self.m_minCount = math.ceil(self.m_maxLineCount / 2) --中间的行号
    local count = self.m_minCount --每行的格子数
    for r = 1, self.m_maxLineCount do
        self.m_mapRowColCount[r] = count

        pos_x = math.ceil(count / 2) * self.m_gridSizeX * -1

        if r > self.m_minCount then
            pos_y = (r - self.m_minCount) * self.m_intervalY *- 1
        else
            pos_y = (self.m_maxLineCount - count) * self.m_intervalY
        end

        for c = 1, count do
            id_index = id_index + 1
            pos_x = pos_x + self.m_gridSizeX

            if self.m_DupConfigVo.begin_list[id_index].icon_id ~= -1 then
                local item = SimpleInsItem:create(self.mGridItem, self.mapGroup, "BlockSceneUI_GridItem")
                if not self.m_mapGridList[r] then
                    self.m_mapGridList[r] = {}
                end

                if self.m_DupConfigVo.begin_list[id_index].icon_id == 1 then
                    self.m_mapGridList[r][c] = {item = item, occupy = 1, map_row = r, map_col = c}
                    item:getChildGO("mImgSelect"):SetActive(true)
                    item:getChildGO("mImgSelect"):GetComponent(ty.Image).color = gs.ColorUtil.GetColor("CDDEDDFF")
                else
                    self.m_mapGridList[r][c] = {item = item, occupy = 0, map_row = r, map_col = c}
                    item:getChildGO("mImgSelect"):SetActive(false)
                end
                item:getChildGO("mEffect"):SetActive(false)

                if count % 2 == 1 then
                    item:setPos(pos_x, pos_y)
                else
                    item:setPos(pos_x - self.m_intervalX, pos_y)
                end

                item.m_go.name = r .. "_" .. c
            end
        end

        if r < self.m_minCount then
            count = count + 1
        else
            count = count - 1
        end
    end

    self.m_mapSizeDiff_y = (self.m_minCount - 1) * self.m_intervalY + (self.m_initSize.height / 2)
end

function clearMap(self)
    if self.m_mapGridList then
        for k, dic in pairs(self.m_mapGridList) do
            for _, v in pairs(dic) do
                v.item:poolRecover()
                v.item.occupy = nil
            end
        end
    end

    self.m_mapGridList = nil
end

function createNextGrid(self)
    local gridConfigList, maxWeight = block.BlockManager:getGridConfigList()
    local random_weight = math.random(1, maxWeight)
    local gridConfig = nil
    for i = 1, #gridConfigList do
        if random_weight <= gridConfigList[i].weight then
            gridConfig = gridConfigList[i]
            break
        end
    end

    -- local gridConfig = gridConfigList[16]
    -- for id, gridConfig in pairs(gridConfigList) do

    self.m_nextGridId = self.m_nextGridId + 1

    local item = block.BlockGridItem:create(self.mNextItem, self.nextGroup, "BlockSceneUI_NextItem")
    item:setData(gridConfig, self.m_nextGridId, self, self.onNextGridDrag, self.onNextGridDragEnd)
    item:showIcon(true)

    self.m_nextGridList[self.m_nextGridId] = item
    -- end
end

function deleteNextGrid(self, id)
    if self.m_nextGridList[id] then
        self.m_nextGridList[id]:poolRecover()
        self.m_nextGridList[id] = nil
    end
end

function clearNextGrid(self)
    if self.m_nextGridList then
        for k, v in pairs(self.m_nextGridList) do
            v:poolRecover()
        end
    end

    self.m_nextGridList = {}
    self.m_nextGridId = 0
end

function onNextGridDrag(self, gridItem)
    if self.m_tempGridItem == nil then
        local color = gridItem:getColor()
        local configVo = gridItem:getDataConfigVo()

        self.m_tempGridItem = block.BlockGridItem:create(self.mNextItem, self.mTempContent, "BlockSceneUI_NextItem")
        self.m_tempGridItem:setData2(configVo, color, self.m_gridSizeX, self.m_gridSizeY, self.m_initSize.height)
        self.m_tempGridItem:setAnchors(gs.Vector2(0.5, 0.5), gs.Vector2(0.5, 0.5))
        self.m_tempGridItem:showIcon(true)

        gridItem:showIcon(false)

        AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_block_1.prefab")
    end

    local ve2 = gs.Vector2(0, 0)
    local camera = gs.CameraMgr:GetUICamera();
    local vector2 = camera:ScreenToViewportPoint(gs.Input.mousePosition)

    local ScreenResolution_width = self.UITransRect.rect.width
    local ScreenResolution_heigt = self.UITransRect.rect.height

    ve2.x = (ScreenResolution_width * vector2.x) - (ScreenResolution_width / 2)
    ve2.y = (ScreenResolution_heigt * vector2.y) - (ScreenResolution_heigt / 2)

    self.m_tempGridItem:setAnchoredPosition(ve2)

    --落点标识计算
    if self.m_tempSelectGridlist then
        for r, colDic in pairs(self.m_tempSelectGridlist) do
            for c, grid in pairs(colDic) do
                grid.item:getChildGO("mImgSelect"):SetActive(false)
                grid.occupy = 0
            end
        end
    end

    self.m_tempSelectGridlist = self:getCanPutGrid(self.m_tempGridItem)
    if self.m_tempSelectGridlist then
        for r, colDic in pairs(self.m_tempSelectGridlist) do
            for c, grid in pairs(colDic) do
                grid.item:getChildGO("mImgSelect"):GetComponent(ty.Image).color = gs.ColorUtil.GetColor(gridItem:getColor())
                grid.item:getChildGO("mImgSelect"):SetActive(true)
                grid.occupy = 1
            end
        end
    end
end

function onNextGridDragEnd(self, gridItem)
    if self.m_tempSelectGridlist then
        local isAllOccupy = true

        local iconDic = self.m_tempGridItem:getAllIcon()
        for r, colDic in pairs(iconDic) do
            if self.m_tempSelectGridlist[r] == nil then
                isAllOccupy = false
                break
            end

            for c, icon in pairs(colDic) do
                if self.m_tempSelectGridlist[r][c] == nil then
                    isAllOccupy = false
                    break
                end
            end

            if not isAllOccupy then
                break
            end
        end

        if isAllOccupy then
            self:deleteNextGrid(gridItem.m_id)
            self:createNextGrid()

            AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_block_2.prefab")

            --检测是否可以消除
            --消除的个数
            local eliminateList = {}
            local eliminateTemp = {}
            local tempSaveGrid = function ()
                if not table.empty(eliminateTemp) then
                    for _, grid_ in pairs(eliminateTemp) do
                        if eliminateList[grid_.map_row] == nil then
                            eliminateList[grid_.map_row] = {}
                        end

                        eliminateList[grid_.map_row][grid_.map_col] = grid_
                    end
                    eliminateTemp = {}
                end
            end

            local insertTemp = function (row, col)
                if col > 0 and col <= self.m_mapRowColCount[row] then
                    local _grid = self.m_mapGridList[row][col]
                    if _grid == nil or _grid.occupy == 0 then
                        eliminateTemp = {}
                        return true
                    else
                        table.insert(eliminateTemp, _grid)
                    end
                end

                -- if self.m_mapGridList[row][col] then
                --     self.m_mapGridList[row][col].item:getChildGO("mImgSelect"):SetActive(true)
                -- end
            end

            for r, colDic in pairs(self.m_tempSelectGridlist) do
                for c, grid in pairs(colDic) do
                    -- logAll(grid.map_row.." - " .. grid.map_col)
                    --先判断横向是不是可以消除
                    for col = 1, self.m_mapRowColCount[grid.map_row] do
                        if insertTemp(grid.map_row, col) then
                            break
                        end
                    end
                    tempSaveGrid()

                    ----再判断斜的两条线是不是可以消除
                    --往/走，小于中间row row正常加减，col不做加减。否则col减一
                    for row = 1, self.m_maxLineCount do
                        local col = grid.map_col
                        if grid.map_row > self.m_minCount then
                            if row > self.m_minCount then
                                col = grid.map_col + (grid.map_row - row)
                            else
                                col = grid.map_col + (grid.map_row - self.m_minCount)
                            end
                        else
                            if row > self.m_minCount then
                                col = grid.map_col + (self.m_minCount - row)
                            end
                        end

                        if insertTemp(row, col) then
                            break
                        end
                    end
                    tempSaveGrid()

                    --往\走，小于中间row row正常加减，col加一。否则col不做加减
                    for row = 1, self.m_maxLineCount do
                        local col = grid.map_col
                        if grid.map_row > self.m_minCount then
                            if row < self.m_minCount then
                                col = grid.map_col + (row - self.m_minCount)
                            end
                        else
                            if row > self.m_minCount then
                                col = grid.map_col + (self.m_minCount - grid.map_row)
                            else
                                col = grid.map_col + (row - grid.map_row)
                            end
                        end

                        if insertTemp(row, col) then
                            break
                        end
                    end
                    tempSaveGrid()

                end
            end

            if not table.empty(eliminateList) then
                local count = 0

                for r, colDic in pairs(eliminateList) do
                    for c, grid in pairs(colDic) do
                        grid.item:getChildGO("mImgSelect"):SetActive(false)
                        grid.item:getChildGO("mEffect"):SetActive(false)
                        grid.item:getGo():GetComponent(ty.Animator):Play("BlockSceneUI_mapGroup_mGridItem_Exit", 0, 0)
                        grid.occupy = 0

                        count = count + 1
                    end
                end
                eliminateList = {}

                self.m_curScore = self.m_curScore + (count * self.m_DupConfigVo.remove_score)
                self.mTextCurScore.text = self.m_curScore
                self.mImgPass:SetActive(self.m_curScore >= self.m_DupConfigVo.target_score)

                AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_block_3.prefab")
            else
                for r, colDic in pairs(self.m_tempSelectGridlist) do
                    for c, grid in pairs(colDic) do
                        grid.item:getChildGO("mImgSelect"):SetActive(true)
                        grid.item:getGo():GetComponent(ty.Animator):Play("BlockSceneUI_mapGroup_mGridItem_Enter", 0, 0)
                    end
                end
            end
        else
            for r, colDic in pairs(self.m_tempSelectGridlist) do
                for c, grid in pairs(colDic) do
                    grid.item:getChildGO("mImgSelect"):SetActive(false)
                    grid.occupy = 0
                end
            end
        end

        if self.m_isAutoPause ~= true and self.m_curScore >= self.m_DupConfigVo.target_score and not block.BlockManager:isPassDup(self.m_DupConfigVo.id) then
            GameDispatcher:dispatchEvent(EventName.BLOCK_UPDATE_PAUSESTATE, true)
            self.mGroupPause:SetActive(true)

            self.mBtnExit:SetActive(false)
            self.mBtnFinish:SetActive(true)

            self:updateStarInfo()

            self.m_isAutoPause = true
        elseif not self:canPut(gridItem) then
            GameDispatcher:dispatchEvent(EventName.ONREQ_BLOCK_PASS_DUP, {dup_config = self.m_DupConfigVo, score = self.m_curScore})
        end

        self.m_tempSelectGridlist = nil
    end

    gridItem:showIcon(true)

    if self.m_tempGridItem ~= nil then
        self.m_tempGridItem:poolRecover()
        self.m_tempGridItem = nil
    end
end

function canPut(self)
    local tempGrid = block.BlockGridItem:create(self.mNextItem, self.mapGroup, "BlockSceneUI_TempItem")

    for next_id, nextGrid in pairs(self.m_nextGridList) do
        local color = nextGrid:getColor()
        local configVo = nextGrid:getDataConfigVo()
        tempGrid:setData2(configVo, color, self.m_gridSizeX, self.m_gridSizeY, self.m_initSize.height)
        tempGrid:setAnchors(gs.Vector2(0.5, 0.5), gs.Vector2(0.5, 0.5))
        tempGrid:showIcon(false)

        for row, colDic in pairs(self.m_mapGridList) do
            for col, map_grid in pairs(colDic) do
                local rectTrans = map_grid.item.m_go:GetComponent(ty.RectTransform)
                tempGrid:setAnchoredPosition(rectTrans.anchoredPosition)
                local value = self:putGrid(tempGrid, row, col)

                if not table.empty(value) then
                    local isAllOccupy = true
                    local iconDic = tempGrid:getAllIcon()
                    for r, colDic in pairs(iconDic) do
                        if value[r] == nil then
                            isAllOccupy = false
                            break
                        end

                        for c, icon in pairs(colDic) do
                            if value[r][c] == nil then
                                isAllOccupy = false
                                break
                            end
                        end

                        if not isAllOccupy then
                            break
                        end
                    end

                    if isAllOccupy then
                        -- logAll(string.format("第%s个可以摆放，位置为：%s_%s", nextGrid.m_trans:GetSiblingIndex(), row, col))

                        tempGrid:poolRecover()
                        return true
                    end
                end
            end
        end
    end

    for next_id, nextGrid in pairs(self.m_nextGridList) do
        -- logAll(next_id, "不可摆放的方块id = ")
    end

    tempGrid:poolRecover()
    return false
end

function getCanPutGrid(self, nextGrid)
    local Grid_Pos = self.mapGroup:InverseTransformPoint(nextGrid.m_trans.position)

    local Grid_Row = math.ceil((self.m_mapSizeDiff_y - Grid_Pos.y) / self.m_intervalY)
    if self.m_mapRowColCount[Grid_Row] then
        local minCount = math.ceil(self.m_mapRowColCount[Grid_Row] / 2)
        local mapSizeDiff_x = (minCount - 1) * self.m_initSize.width + self.m_intervalX
        local Grid_Col = math.ceil((Grid_Pos.x + mapSizeDiff_x) / self.m_gridSizeX)

        --矫正坐标
        Grid_Row, Grid_Col = self:getMapPosInHexagon(nextGrid, Grid_Row, Grid_Col, Grid_Pos)
        return self:putGrid(nextGrid, Grid_Row, Grid_Col)
    else
        return nil
    end

    return tab
end

function putGrid(self, nextGrid, grid_Row, grid_Col)
    local tab = {}

    -- logAll("中心坐标:"..grid_Row.." _ "..grid_Row)

    local iconDic = nextGrid:getAllIcon()
    for r, colDic in pairs(iconDic) do
        if not tab[r] then
            tab[r] = {}
        end

        for c, icon in pairs(colDic) do
            local icon_row = grid_Row - r
            local icon_col = grid_Col + c

            -- logAll(r .. '_' .. c)

            if (r > 0 and c < 0) or (r < 0 and c > 0) then --\
                if icon_row >= self.m_minCount then
                    if grid_Row <= self.m_minCount then
                        icon_col = grid_Col + self.m_minCount - grid_Row + c - 1
                    else
                        if c > 1 then
                            icon_col = grid_Col + c - 1
                        else
                            icon_col = grid_Col
                        end
                    end
                else
                    if r % 2 == 0 then
                        icon_col = icon_col + 1
                    end
                end
            elseif (r > 0 and c > 0) or (r < 0 and c < 0) then --/
                if icon_row > self.m_minCount then
                    if r % 2 == 0 then
                        if grid_Row >= self.m_minCount then
                            icon_col = icon_col - 1
                        end
                    end
                else
                    if grid_Row <= self.m_minCount then
                        icon_col = grid_Col
                    else
                        icon_col = grid_Col + grid_Row - self.m_minCount
                    end
                end
            end

            if not self.m_mapGridList[icon_row] then
                return nil
            end

            local grid = self.m_mapGridList[icon_row][icon_col]
            if grid and grid.occupy ~= 1 then
                tab[r][c] = grid
            else
                return nil
            end
        end
    end

    return tab
end

function getMapPosInHexagon(self, centerGird, initRow, initCol, gridPos)
    if self:inHexagon(centerGird.m_trans.localPosition, self.m_gridSizeY - 6, self.m_gridSizeX - 4, gridPos) then
        return initRow, initCol
    end

    --上下各多取一个精确计算中心点是否在六边形内
    for _r = initRow - 1, initRow + 1 do
        if self.m_mapGridList[_r] then
            for _c = initCol - 1, initCol + 1 do
                local grid = self.m_mapGridList[_r][_c]
                if grid then
                    if self:inHexagon(grid.item.m_trans.localPosition, self.m_gridSizeY - 6, self.m_gridSizeX - 4, gridPos) then
                        return _r, _c
                    end
                end
            end
        end
    end

    return initRow, initCol
end

--计算是不是在六边形内()
function inHexagon(self, center, height, width, point)
    local radiusR = height / 2
    local radiusRInner = width / 2

    local dir = point - center
    local d = dir.magnitude

    -- 1. 距离超过外接圆：外部
    if d > (radiusR) then
        return false
    end

    -- 2. 距离小于内切圆：内部
    if d < (radiusRInner) then
        return true
    end

    -- 3. 计算角度（弧度）
    local angle = gs.Mathf.Atan2(dir.y, dir.x) * gs.Mathf.Rad2Deg -- 范围(-180°, 180°)
    angle = (angle + 360) % 360 -- 转换为(0°, 360°)

    -- 4. 映射到0°~60°的标准扇形
    local angleNorm = angle % 60
    -- 对称处理（30°为对称轴）
    angleNorm = gs.Mathf.Abs(angleNorm - 30)

    -- 5. 计算该角度下的最大允许距离（边的边界）
    -- 正六边形边的方程：x * cosθ + y * sinθ = r（r为内切圆半径）
    local maxDistAtAngle = radiusRInner / gs.Mathf.Cos(angleNorm * gs.Mathf.Deg2Rad)

    -- 若点距离 ≤ 最大允许距离，则在内部
    return d <= maxDistAtAngle + 0.001
end

-------------------暂停界面Start--------------------------------

-- 暂停
function onPauseClick(self)
    GameDispatcher:dispatchEvent(EventName.BLOCK_UPDATE_PAUSESTATE, true)
    self.mGroupPause:SetActive(true)

    self.mBtnExit:SetActive(self.m_curScore < self.m_DupConfigVo.target_score)
    self.mBtnFinish:SetActive(self.m_curScore >= self.m_DupConfigVo.target_score)

    self:updateStarInfo()
end

-- 继续
function onPlayClick(self)
    GameDispatcher:dispatchEvent(EventName.BLOCK_UPDATE_PAUSESTATE, false)

    self.mGroupPause:SetActive(false)
end

-- 重新开始
function onReplayClick(self)
    GameDispatcher:dispatchEvent(EventName.BLOCK_UPDATE_PAUSESTATE, false)

    self.mGroupPause:SetActive(false)
    self:refreshView(self.m_DupConfigVo)
end

-- 退出
function onExitClick(self)
    self:close()
end

function onFinishClick(self)
    self.mGroupPause:SetActive(false)
    GameDispatcher:dispatchEvent(EventName.ONREQ_BLOCK_PASS_DUP, {dup_config = self.m_DupConfigVo, score = self.m_curScore})
end

function refreshPauseState(self, pauseState)
    self.mImgStart:SetActive(pauseState)
    self.mImgPause:SetActive(not pauseState)
end

-------------------暂停界面

-- 更新星级
function updateStarInfo(self)
    self.mTextPassScore.text = _TT(151209) .. self.m_curScore
    self.mTextTargerScore.text = _TT(151208) .. self.m_DupConfigVo.target_score
    self.mFinish:SetActive(self.m_curScore >= self.m_DupConfigVo.target_score)
    self.mNoFinish:SetActive(self.m_curScore < self.m_DupConfigVo.target_score)

end

-------------------暂停界面End--------------------------------

return _M
