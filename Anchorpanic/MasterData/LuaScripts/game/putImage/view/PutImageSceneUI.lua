-- @FileName:   PutImageSceneUI.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.putImage.view.PutImageSceneUI', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("putImage/PutImageSceneUI.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isScreensave = 1 -- 是否使用黑屏过渡(仅1全屏UI有效，默认开启，0关闭)
escapeClose = 0 -- 是否能通过esc关闭窗口
isShowCloseAll = 0

--构造函数
function ctor(self)
    super.ctor(self)
    self:setUICode(LinkCode.PutImage)
end

-- 设置货币栏
function setMoneyBar(self)
end

-- 初始化
function configUI(self)
    self.mTab1 = self:getChildGO("mTab1")
    self.mTabNormalText1 = self:getChildGO("mTabNormalText1"):GetComponent(ty.Text)
    self.mTabSelectText1 = self:getChildGO("mTabSelectText1"):GetComponent(ty.Text)
    self.mTabSelect1 = self:getChildGO("mTabSelect1")

    self.mTab2 = self:getChildGO("mTab2")
    self.mTabNormalText2 = self:getChildGO("mTabNormalText2"):GetComponent(ty.Text)
    self.mTabSelectText2 = self:getChildGO("mTabSelectText2"):GetComponent(ty.Text)
    self.mTabSelect2 = self:getChildGO("mTabSelect2")

    self.mImgGMBg = self:getChildGO("mImgGMBg"):GetComponent(ty.AutoRefImage)
    self.mImgGMBgRectTrans = self.mImgGMBg:GetComponent(ty.RectTransform)
    self.mImgGMMask = self:getChildGO("mImgGMMask")

    self.mImgBg = self:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage)

    self.ImgGroup = self:getChildGO("ImgGroup")
    self.mImgGrid = self:getChildGO("mImgGrid")

    self.mEfxGroup = self:getChildTrans("mEfxGroup")
    self.mEfx01 = self:getChildGO("mEfx01")
    self.mEfx01Rect = self.mEfx01:GetComponent(ty.RectTransform)
    self.mEfx02 = self:getChildGO("mEfx02")

    self.mEmptyRay = self:getChildGO("mEmptyRay")

    self.gTxtTitle = self:getChildGO("gTxtTitle"):GetComponent(ty.Text)
    self.gBtnClose = self:getChildGO("gBtnClose")
end

function initViewText(self)
    self.mTabNormalText1.text = _TT(138902)
    self.mTabSelectText1.text = _TT(138902)

    self.mTabNormalText2.text = _TT(138903)
    self.mTabSelectText2.text = _TT(138903)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mTab1, self.onClickTab1)
    self:addUIEvent(self.mTab2, self.onClickTab2)

    self:addUIEvent(self.gBtnClose, self.onClickClose, self:getCloseSoundPath())
end

--激活
function active(self, args)
    super.active(self)

    self:refreshView(args)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    self:RemoveEventListener()

    self:clearData()
end

-- 玩家点击关闭
function onClickClose(self)
    if self.m_dragGrid ~= nil then
        return
    end

    local confirmCall = function ()
        super.onClickClose(self)
    end

    UIFactory:alertMessge(_TT(74), isShowConfirm, confirmCall, _TT(1), nil, true, nil, nil, _TT(5))
end

function AddEventListener(self)

end

function RemoveEventListener(self)

end

---初始化游戏数据
function initGameData(self)
    self.m_clickGridList = {}
    self.m_recoverEfxDic = {}
    self.m_recoverEfxId = 0
end

function clearData(self)
    self:clearImgGridItem()
    self:clearRecoverEfx()

    self.m_clickGridList = nil
    self.m_dragGrid = nil
end

function onClickTab1(self)
    if self.m_dragGrid ~= nil then
        return
    end

    self.mTabSelect1:SetActive(true)
    self.mTabSelect2:SetActive(false)

    self.ImgGroup:SetActive(false)
end

function onClickTab2(self)
    if self.m_dragGrid ~= nil then
        return
    end

    self.mTabSelect1:SetActive(false)
    self.mTabSelect2:SetActive(true)

    self.ImgGroup:SetActive(true)
end

function refreshView(self, args)
    self:clearData()
    self:AddEventListener()

    self.m_dupConfigVo = args.dupVo
    self.m_areaId = args.area_id

    self.gTxtTitle.text = self.m_dupConfigVo:getName()

    self.mImgBg:SetImg(string.format("arts/ui/bg/putImage/putImage_GmBg_%02d.jpg", self.m_areaId))
    self.mImgGMMask:SetActive(true)
    self.mEfx01:SetActive(false)
    self.mEmptyRay:SetActive(false)

    self:initGameData()
    self:creatGridItem()

    self:onClickTab2()
end

function creatGridItem(self)
    local maxRow, maxCol = self.m_dupConfigVo:getMaxSize()
    local gridHeight = (PutImageConst.ImgHeight - ((maxRow + 1) * PutImageConst.Grid_Interval)) / maxRow
    local gridWidth = (PutImageConst.ImgWidth - ((maxCol + 1) * PutImageConst.Grid_Interval)) / maxCol

    self.mImgGMBg:SetImg(self.m_dupConfigVo:getImgBgPath())

    if gs.Application.isEditor then
        putImage.PutImageGridItem = require("game/putImage/view/item/PutImageGridItem")
    end

    local rectWidth = gridWidth / PutImageConst.ImgWidth
    local rectHeight = gridHeight / PutImageConst.ImgHeight

    self.m_imgGridList = {}
    local id = 0
    for r = 1, maxRow do
        for c = 1, maxCol do
            id = id + 1
            local config = self.m_dupConfigVo.jigsaw_list[id]

            local item = putImage.PutImageGridItem:create(self.mImgGrid, self.ImgGroup.transform, "PutImage_SceneUI_GridItem")
            item.m_go.name = id

            if not self.m_imgGridList[config.row] then
                self.m_imgGridList[config.row] = {}
            end
            self.m_imgGridList[config.row][config.col] = item

            local correct_posX = (c - 1) * (PutImageConst.Grid_Interval + gridWidth) + PutImageConst.Grid_Interval
            local correct_posY = (maxRow - r) * (PutImageConst.Grid_Interval + gridHeight) + PutImageConst.Grid_Interval

            local rect_x = correct_posX / PutImageConst.ImgWidth
            local rect_y = correct_posY / PutImageConst.ImgHeight

            item:SetRect(rect_x, rect_y, rectWidth, rectHeight)

            local upCall = function (gridItem)
                if self.m_dragGrid ~= nil then
                    self:onEndDragGrid(gridItem)
                    self.m_dragGrid = nil
                else
                    self:onClickGrid(gridItem)
                end
            end

            local dragCall = function (gridItem)
                if self.m_dragGrid ~= nil then
                    local args_1 = self.m_dragGrid:getArgs()
                    local args_2 = gridItem:getArgs()
                    if args_1.row ~= args_2.row or args_1.col ~= args_2.col then
                        return
                    end
                end

                self:onDragGrid(gridItem)
                self.m_dragGrid = gridItem
            end
            local recoverCall = function (gridItem)
                self:recoverGrid(gridItem)
            end

            item:SetCallback(upCall, dragCall, recoverCall)

            item:setArgs({correct_row = r, correct_col = c, row = config.row, col = config.col, width = gridWidth, height = gridWidth, max_row = maxRow, max_col = maxCol, img_path = self.m_dupConfigVo:getImgBgPath()})
            item:refreshPos()
        end
    end

    for row, col_dic in pairs(self.m_imgGridList) do
        for col, item in pairs(col_dic) do
            item:refreshRecover()
        end
    end
end

function recoverGrid(self, grid)
    local args = grid:getArgs()
    if table.empty(self.m_imgGridList[args.row]) then
        return
    end

    if table.empty(self.m_imgGridList[args.row][args.col]) then
        return
    end

    self.m_imgGridList[args.row][args.col]:poolRecover()
    self.m_imgGridList[args.row][args.col] = nil
end

function clearImgGridItem(self)
    if self.m_imgGridList then
        for row, col_dic in pairs(self.m_imgGridList) do
            for col, item in pairs(col_dic) do
                item:poolRecover()
            end
        end
    end

    self.m_imgGridList = nil
end

function getRecoverEfx(self, pos, size)
    local efxItem = SimpleInsItem:create(self.mEfx02, self.mEfxGroup, "PutImageSceneUI_RecoverEfxItem")
    local rectTrans = efxItem:getGo():GetComponent(ty.RectTransform)
    rectTrans.sizeDelta = size
    rectTrans.anchoredPosition = pos

    self.m_recoverEfxId = self.m_recoverEfxId + 1

    local animator = efxItem:getGo():GetComponent(ty.Animator)
    local time = AnimatorUtil.getAnimatorClipTime(animator, "PutImageSceneUI_Effect_Enter")
    local timeOutSn = self:setTimeout(time, self.deleteRecoverEfx, self.m_recoverEfxId)
    self.m_recoverEfxDic[self.m_recoverEfxId] = {item = efxItem, timeOutSn = timeOutSn}

    return time
end

function deleteRecoverEfx(self, id)
    if self.m_recoverEfxDic[id] then
        self.m_recoverEfxDic[id].item:poolRecover()
        self:clearTimeout(self.m_recoverEfxDic[id].timeOutSn)
        self.m_recoverEfxDic[id] = nil
    end
end

function clearRecoverEfx(self)
    if self.m_recoverEfxDic then
        for k, efxItem in pairs(self.m_recoverEfxDic) do
            efxItem.item:poolRecover()
            self:clearTimeout(efxItem.timeOutSn)
        end
    end
    self.m_recoverEfxDic = nil
    self.m_recoverEfxId = nil
end

--拖动格子
function onDragGrid(self, grid)
    for k, item in pairs(self.m_clickGridList) do
        item:OperateSelect(false)
    end
    self.m_clickGridList = {}

    local rectTrans = grid:getGo():GetComponent(ty.RectTransform)

    local ve2 = gs.Vector2(0, 0)
    local camera = gs.CameraMgr:GetUICamera();
    local vector2 = camera:ScreenToViewportPoint(gs.Input.mousePosition)

    local Screen_rectTrans = self.UIObject:GetComponent(ty.RectTransform)
    local ScreenResolution_width = Screen_rectTrans.rect.width
    local ScreenResolution_heigt = Screen_rectTrans.rect.height

    local anchoredPosition = {
        x = self.mImgGMBgRectTrans.anchoredPosition.x - self.mImgGMBgRectTrans.rect.width / 2 + ScreenResolution_width / 2,
        y = self.mImgGMBgRectTrans.anchoredPosition.y - self.mImgGMBgRectTrans.rect.height / 2 + ScreenResolution_heigt / 2,
    }

    ve2.x = (ScreenResolution_width * vector2.x) - anchoredPosition.x - rectTrans.rect.width / 2
    ve2.y = (ScreenResolution_heigt * vector2.y) - anchoredPosition.y - rectTrans.rect.height / 2

    rectTrans.anchoredPosition = ve2
    rectTrans:SetSiblingIndex(999)

    if not self.mEfx01.activeInHierarchy then
        local args = grid:getArgs()

        self.mEfx01Rect.sizeDelta = gs.Vector2(args.width, args.height)

        local pos_x = (args.col - 1) * (PutImageConst.Grid_Interval + args.width) + PutImageConst.Grid_Interval
        local pos_y = (args.max_row - args.row) * (PutImageConst.Grid_Interval + args.height) + PutImageConst.Grid_Interval
        self.mEfx01Rect.anchoredPosition = gs.Vector2(pos_x, pos_y)
        self.mEfx01:SetActive(true)
    end

    self:getDragPosGrid(grid)
end

--单击格子
function onClickGrid(self, grid)
    --检测是不是重复点击
    if not table.empty(self.m_clickGridList) then
        local args_1 = self.m_clickGridList[1]:getArgs()
        local args_2 = grid:getArgs()
        if args_1.row == args_2.row and args_1.col == args_2.col then
            self.m_clickGridList[1]:OperateSelect(false)
            self.m_clickGridList = {}

            AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_jigsaw_3.prefab")
            return
        end
    end

    table.insert(self.m_clickGridList, grid)

    if table.nums(self.m_clickGridList) == 2 then
        self:exchangeGridPos(self.m_clickGridList[1], self.m_clickGridList[2])

        self.m_clickGridList = {}

        AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_jigsaw_3.prefab")
    else
        grid:OperateSelect(true)
        AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_jigsaw_1.prefab")
    end
end

--结束拖动
function onEndDragGrid(self, grid)
    if self.m_dragPosGrid then
        self:exchangeGridPos(grid, self.m_dragPosGrid)
        self.m_dragPosGrid = nil
    else
        self.m_dragGrid:refreshPos()
    end

    self.mEfx01:SetActive(false)

    AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_jigsaw_3.prefab")
end

--交换位置
function exchangeGridPos(self, grid_1, grid_2)
    local args_1 = grid_1:getArgs()
    local pos_1 = {row = args_1.row, col = args_1.col}

    local args_2 = grid_2:getArgs()
    local pos_2 = {row = args_2.row, col = args_2.col}

    args_1.row = pos_2.row
    args_1.col = pos_2.col

    args_2.row = pos_1.row
    args_2.col = pos_1.col

    self.m_imgGridList[args_1.row][args_1.col] = grid_1
    self.m_imgGridList[args_2.row][args_2.col] = grid_2

    grid_1:refreshPos()
    grid_1:OperateSelect(false)
    local recover_1 = grid_1:refreshRecover()

    grid_2:refreshPos()
    grid_2:OperateSelect(false)
    local recover_2 = grid_2:refreshRecover()

    if not self:checkGameOver() then
        if recover_1 then
            local pos_x = (args_1.col - 1) * (PutImageConst.Grid_Interval + args_1.width) + PutImageConst.Grid_Interval
            local pos_y = (args_1.max_row - args_1.row) * (PutImageConst.Grid_Interval + args_1.height) + PutImageConst.Grid_Interval
            self:getRecoverEfx(gs.Vector2(pos_x, pos_y), gs.Vector2(args_1.width, args_1.height))
        end

        if recover_2 then
            local pos_x = (args_2.col - 1) * (PutImageConst.Grid_Interval + args_2.width) + PutImageConst.Grid_Interval
            local pos_y = (args_2.max_row - args_2.row) * (PutImageConst.Grid_Interval + args_2.height) + PutImageConst.Grid_Interval
            self:getRecoverEfx(gs.Vector2(pos_x, pos_y), gs.Vector2(args_2.width, args_2.height))
        end
    end

    if recover_1 or recover_2 then
        AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_jigsaw_2.prefab")
    end
end

--获取当前位置对应的图片格子，空代表没有
function getDragPosGrid(self, grid)
    local args = grid:getArgs()
    local rectTrans = grid:getGo():GetComponent(ty.RectTransform)
    local anchoredPosition = {x = rectTrans.anchoredPosition.x + rectTrans.rect.width / 2, y = rectTrans.anchoredPosition.y + rectTrans.rect.height / 2}

    local row = args.max_row - math.floor((anchoredPosition.y - PutImageConst.Grid_Interval) / (PutImageConst.Grid_Interval + args.height))
    local col = math.floor((anchoredPosition.x - PutImageConst.Grid_Interval) / (PutImageConst.Grid_Interval + args.width) + 1)

    if args.row == row and args.col == col then
        return
    end

    if self.m_imgGridList[row] and self.m_imgGridList[row][col] then
        if self.m_dragPosGrid then
            local old_args = self.m_dragPosGrid:getArgs()
            if old_args.row == row and old_args.col == col then
                return
            else
                self.m_dragPosGrid:OperateSelect(false)
            end
        end

        self.m_dragPosGrid = self.m_imgGridList[row][col]
        self.m_dragPosGrid:OperateSelect(true)
    else
        if self.m_dragPosGrid then
            self.m_dragPosGrid:OperateSelect(false)
            self.m_dragPosGrid = nil
        end
    end
end

function checkGameOver(self)
    for row, col_dic in pairs(self.m_imgGridList) do
        if not table.empty(col_dic) then
            return false
        end
    end

    local activityVo = mainActivity.MainActivityManager:getMainActivityVoById(activity.ActivityId.PutImage)
    if not activityVo:getIsCanOpen() or activityVo:getTimeRemaining() <= 0 then
        gs.Message.Show(_TT(95053))
        return
    end

    self.mEmptyRay:SetActive(true)

    local nextDupConfig = putImage.PutImageManager:getNextDupConfig(self.m_dupConfigVo.id)
    local isShowConfirm = nextDupConfig ~= nil

    local showAlertMessge = function ()
        local msg = _TT(138904, self.m_dupConfigVo:getName())
        local confirmCall = function ()
            local nextArea_id = putImage.PutImageManager:getAreaIdByDupId(nextDupConfig.id)
            if nextArea_id ~= self.m_areaId then
                local nextAreaConfig = putImage.PutImageManager:getAreaConfig(nextArea_id)
                if not nextAreaConfig:isOpen() then
                    gs.Message.Show(_TT(130002, nextAreaConfig.begin_time.year, nextAreaConfig.begin_time.month, nextAreaConfig.begin_time.day))

                    self:close()
                    return
                end
            end

            if not nextDupConfig:isOpen() then
                self:close()

                gs.Message.Show(_TT(130002, nextDupConfig.begin_time.year, nextDupConfig.begin_time.month, nextDupConfig.begin_time.day))
                return
            end
            self:refreshView({dupVo = nextDupConfig, area_id = nextArea_id})
        end

        local cancelCall = function ()
            self:close()
        end

        if not isShowConfirm then
            msg = _TT(130020)
        end

        UIFactory:alertMessge(msg, isShowConfirm, confirmCall, _TT(1), nil, true, cancelCall, 130018, _TT(5), true, nil, nil, 10)
    end

    self.mImgGMMask:SetActive(false)

    local time = self:getRecoverEfx(gs.Vector2(0, 0), gs.Vector2(PutImageConst.ImgWidth, PutImageConst.ImgHeight))
    self:setTimeout(time, function ()
        if not putImage.PutImageManager:isPassDup(self.m_dupConfigVo.id) then
            ShowAwardPanel:getInstance():setCallFun(showAlertMessge)
            GameDispatcher:dispatchEvent(EventName.PUTIMAGE_PASS_DUP, self.m_dupConfigVo.id)
        else
            showAlertMessge()
        end
    end)

    return true
end

return _M
