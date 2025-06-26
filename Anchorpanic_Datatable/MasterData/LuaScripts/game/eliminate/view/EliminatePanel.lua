--[[ 
-----------------------------------------------------
@filename       : EliminatePanel
@Description    : 消消乐
@date           : 2020-12-24 16:23:40
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('eliminate.EliminatePanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("eliminate/EliminatePanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认
panelType = 1 -- 窗口类型 1 全屏 2 弹窗
isShowCloseAll = 0 --是否显示导航按钮

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(101009)) --"消消乐"
    -- self:setUICode(LinkCode.HomePage)
    -- self:setBg("eliminate_bg.jpg", false, "eliminate")
end

-- 取父容器
function getParentTrans(self)
    return super.getParentTrans(self)
end

-- 初始化数据
function initData(self)
    super.initData(self)

    self.mDownThingVo = nil
    self.mUpThingVo = nil
    self.mClickThingVo = nil
    
    self.mNowRound = nil
    self.mTargetItemDic = nil

    self.mAutoTipGapTime = sysParam.SysParamManager:getValue(SysParamType.ELIMINATE_AUTO_TIP_TIME)
    self.mAutoTipTimerSn = nil
    self.mAutoTipTweener = nil
end

function configUI(self)
    super.configUI(self)
    
    self.mImgEliminateBg = self:getChildGO("mImgEliminateBg"):GetComponent(ty.AutoRefImage)
    self.mImgEliminateBg:SetImg(UrlManager:getBgPath("eliminate/eliminate_bg.jpg"))

    self.mMapTrans = self:getChildTrans("Map")
    self.mTileLayerTrans = self:getChildTrans("TileLayer")
    self.mThingLayerTrans = self:getChildTrans("ThingLayer")
    self.mEffectLayerTrans = self:getChildTrans("EffectLayer")
    self.mEventLayerTrans = self:getChildTrans("EventLayer")
    self.mMaskClickGo = self:getChildGO("MaskClick")
    
    self.mTileItemGo = self:getChildGO("TileItem")
    self.mThingItemGo = self:getChildGO("ThingItem")
    
    self.mMaskImg = self:getChildGO("ThingLayer"):GetComponent(ty.AutoRefImage)
    self.mMapEvent = self.mEventLayerTrans:GetComponent(ty.LongPressOrClickEventTrigger)

    self.mTxtRount = self:getChildTrans("mTxtRount"):GetComponent(ty.Text)
    self.mTxtTargetTip = self:getChildTrans("mTxtTargetTip"):GetComponent(ty.Text)
    self.mTargetTrans = self:getChildTrans("Target")
    self.mTargetItemGo = self:getChildGO("TargetItem")

    -- 自动提示组件
    self.mGroupAutoTipGo = self:getChildGO("GroupAutoTip")
    self.mGroupAutoTipTrans = self:getChildTrans("GroupAutoTip")

    -- 暂停相关
    self.mGroupPause = self:getChildGO("GroupPause")
    self.mTxtPause = self:getChildTrans("mTxtPause"):GetComponent(ty.Text)
    self.mBtnExit = self:getChildGO("mBtnExit")
    self.mBtnPlay = self:getChildGO("mBtnPlay")
    self.mBtnReplay = self:getChildGO("mBtnReplay")
end

function initViewText(self)
    self.mTxtPause.text = _TT(101010) --"暂停"
    self.mTxtTargetTip.text = _TT(101011) --"挑战目标"
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnExit, self.onClickExitHandler)
    self:addUIEvent(self.mBtnPlay, self.onClickPlayHandler)
    self:addUIEvent(self.mBtnReplay, self.onClickReplayHandler)
end

function close(self)
    super.close(self)
end

function onClickClose(self)
    super.onClickClose(self)
end

-- 玩家关闭所有窗口的c#回调
function onCloseAllCall(self)
    super.onCloseAllCall(self)
end

function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList()
    GameDispatcher:addEventListener(EventName.REPLAY_ELIMINATE_PANEL, self.onReplayEliminateHandler, self)
    GameDispatcher:addEventListener(EventName.CHECK_ELIMINATE_FINISH, self.onCheckFinishHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_ELIMINATE_COUNT, self.onUpdateCountHandler, self)
    self.mMapEvent.onPointerDown:AddListener(function()
        self:addUpdateFramSn()
    end)
    self.mMapEvent.onPointerUp:AddListener(function()
        self:removeUpdateFrameSn(false)
    end)
    self.mMapEvent.onPointerExit:AddListener(function()
        self:removeUpdateFrameSn(true)
    end)
    
    self:initData()
    self:initView()
end

function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    GameDispatcher:removeEventListener(EventName.REPLAY_ELIMINATE_PANEL, self.onReplayEliminateHandler, self)
    GameDispatcher:removeEventListener(EventName.CHECK_ELIMINATE_FINISH, self.onCheckFinishHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_ELIMINATE_COUNT, self.onUpdateCountHandler, self)
    self.mMapEvent.onPointerDown:RemoveAllListeners()
    self.mMapEvent.onPointerUp:RemoveAllListeners()
    self.mMapEvent.onPointerExit:RemoveAllListeners()

    eliminate.EliminateObjManager:resetTimerList()
    eliminate.EliminateObjManager:resetTileDic()
    eliminate.EliminateObjManager:resetThingDic()
    eliminate.EliminateEffectExecutor:reset()

    eliminate.EliminateManager:setNowThingCountDic(nil)

    self:removeAutoTip()
    self:clearTargetItemList()
end

------------------------------------------------------------------------鼠标相关----------------------------------------------------------------------------------
function getMouseRowCol(self)
    local mousePos = gs.Input.mousePosition
    local mouseX = mousePos.x
    local mouseY = mousePos.y
    local mouseWorldPos = gs.CameraMgr:ScreenToWorldByUICamera(mousePos)
    local localPos = self.mMapTrans:InverseTransformPoint(mouseWorldPos)
    local stageConfigVo = eliminate.EliminateManager:getRunStageConfigVo()
    local mouseRow, mouseCol = eliminate.GetTileRowCol(stageConfigVo.mapRow, stageConfigVo.mapCol, localPos)
    return mouseX, mouseY, mouseRow, mouseCol
end

function addUpdateFramSn(self)
    if(gs.Input.touchCount >= 2)then
        self:removeUpdateFrameSn(false)
        self:resetMouseThingVo()
        return
    end
    self:removeUpdateFrameSn(false)
    self.mUpdateFrameSn = LoopManager:addFrame(1, 0, self, self.onUpdateFrameHandler)

    self.mMouseDownX, self.mMouseDownY, self.mMouseDownRow, self.mMouseDownCol = self:getMouseRowCol()
    local stageConfigVo = eliminate.EliminateManager:getRunStageConfigVo()
    self.mMouseEnterX, self.mMouseEnterY = eliminate.GetTileLocalPos(stageConfigVo.mapRow, stageConfigVo.mapCol, self.mMouseDownRow, self.mMouseDownCol)
    self.mMouseEnterRow, self.mMouseEnterCol = self.mMouseDownRow, self.mMouseDownCol
    self:onDownTileHandler(self.mMouseDownRow, self.mMouseDownCol)
end

function removeUpdateFrameSn(self, isExitArea)
    if (self.mUpdateFrameSn) then
        LoopManager:removeFrameByIndex(self.mUpdateFrameSn)
        self.mUpdateFrameSn = nil
    else
        return
    end

    self.mMouseUpX, self.mMouseUpY, self.mMouseUpRow, self.mMouseUpCol = self:getMouseRowCol()
    if (self.mMouseDownRow == self.mMouseUpRow and self.mMouseDownCol == self.mMouseUpCol) then
        self:onClickTileHandler(self.mMouseUpRow, self.mMouseUpCol)
    else
        if(isExitArea)then
            self:onTileUpHandler(self.mMouseUpRow, self.mMouseUpCol)
        end
    end

    self.mMouseDownX = nil
    self.mMouseDownY = nil
    self.mMouseDownRow = nil
    self.mMouseDownCol = nil
    self.mMouseUpX = nil
    self.mMouseUpY = nil
    self.mMouseUpRow = nil
    self.mMouseUpCol = nil
    self.mMouseEnterX = nil
    self.mMouseEnterY = nil
    self.mMouseEnterRow = nil
    self.mMouseEnterCol = nil
end

function onUpdateFrameHandler(self)
    local mousePos = gs.Input.mousePosition
    if (math.abs(mousePos.x - self.mMouseEnterX) > eliminate.GetTileSize() / 2 or math.abs(mousePos.y - self.mMouseEnterY) > eliminate.GetTileSize() / 2) then
        local mouseX, mouseY, mouseRow, mouseCol = self:getMouseRowCol()
        if(mouseRow ~= self.mMouseEnterRow or mouseCol ~= self.mMouseEnterCol)then
            local stageConfigVo = eliminate.EliminateManager:getRunStageConfigVo()
            self.mMouseEnterX, self.mMouseEnterY = eliminate.GetTileLocalPos(stageConfigVo.mapRow, stageConfigVo.mapCol, mouseRow, mouseCol)
            self.mMouseEnterRow, self.mMouseEnterCol = mouseRow, mouseCol
            self:onMoveEnterTileHandler(self.mMouseEnterRow, self.mMouseEnterCol)
            self:removeUpdateFrameSn(false)
        end
    end
end

function onDownTileHandler(self, rowIndex, colIndex)
    -- print("按下了", rowIndex, colIndex)
    local thing = eliminate.EliminateObjManager:getThingByRowCol(rowIndex, colIndex)
    if(thing)then
        local thingVo = thing:getThingVo()
        if(thingVo:isCanMove())then
            self.mDownThingVo = thingVo
            self.mDownThingVo:setSelect(true)
        end
    end
    if(self.mClickThingVo ~= self.mDownThingVo)then
        local isAdjoin = eliminate.GetIsAdjoin(self.mClickThingVo, self.mDownThingVo)
        if(isAdjoin)then
            self:checkSwapThing(self.mClickThingVo, self.mDownThingVo)
            self:resetMouseThingVo()
        end
        if(self.mClickThingVo)then
            self.mClickThingVo:setSelect(false)
            self.mClickThingVo = nil
        end
    end
end

function onMoveEnterTileHandler(self, rowIndex, colIndex)
    -- print("移动了", rowIndex, colIndex)
    if(self.mDownThingVo)then
        local thing = eliminate.EliminateObjManager:getThingByRowCol(rowIndex, colIndex)
        if(thing)then
            local thingVo = thing:getThingVo()
            if(thingVo:isCanMove())then
                self.mUpThingVo = thingVo
                local isAdjoin = eliminate.GetIsAdjoin(self.mDownThingVo, self.mUpThingVo)
                if(isAdjoin)then
                    self:checkSwapThing(self.mDownThingVo, self.mUpThingVo)
                end
            end
        end
    end
    self:resetMouseThingVo()
end

function onTileUpHandler(self, rowIndex, colIndex)
    -- print("区域外抬起了", rowIndex, colIndex)
    self:resetMouseThingVo()
end

function onClickTileHandler(self, rowIndex, colIndex)
    -- print("点击了", rowIndex, colIndex)
    if(self.mClickThingVo == self.mDownThingVo)then
        local allEffectThingVoDic = eliminate.EliminateObjManager:getAllEffectThingVoDic(self.mClickThingVo, nil, nil)
        if(table.nums(allEffectThingVoDic) > 0)then
            self:addNowRound()
            self:removeAutoTip()
            self:resetMouseThingVo()
            self.mMaskClickGo:SetActive(true)
            eliminate.EliminateObjManager:checkPlayList(nil, nil, nil, allEffectThingVoDic)
        end
    else
        self.mClickThingVo = self.mDownThingVo
        self.mDownThingVo = nil
    end
end

function resetMouseThingVo(self)
    if(self.mDownThingVo)then
        self.mDownThingVo:setSelect(false)
        self.mDownThingVo = nil
    end
    if(self.mUpThingVo)then
        self.mUpThingVo:setSelect(false)
        self.mUpThingVo = nil
    end
    if(self.mClickThingVo)then
        self.mClickThingVo:setSelect(false)
        self.mClickThingVo = nil
    end
end

-- 检查交换
function checkSwapThing(self, startThingVo, endThingVo)
    if(startThingVo and endThingVo)then
        self.mMaskClickGo:SetActive(true)
        local function swapFinishCall()
            local minRowIndex, minColIndex, maxRowIndex, maxColIndex = eliminate.GetAffectRowColArea(startThingVo, endThingVo)
            local allMatchThingVoDic = eliminate.EliminateObjManager:getAllMatchThingVoDic(minRowIndex, minColIndex, maxRowIndex, maxColIndex)
            local allEffectThingVoDic = eliminate.EliminateObjManager:getAllEffectThingVoDic(startThingVo, endThingVo, nil)
            if(table.nums(allMatchThingVoDic) <= 0 and table.nums(allEffectThingVoDic) <= 0)then
                eliminate.EliminateObjManager:swapThing(startThingVo, endThingVo, function() self:onCheckFinishHandler() end)
            else
                self:addNowRound()
                self:removeAutoTip()
                eliminate.EliminateObjManager:checkPlayList(startThingVo, endThingVo, allMatchThingVoDic, allEffectThingVoDic)
            end
        end
        eliminate.EliminateObjManager:swapThing(startThingVo, endThingVo, swapFinishCall)
    end
end
------------------------------------------------------------------------鼠标相关----------------------------------------------------------------------------------

-- 玩家点击关闭
function onClickClose(self)
    self.mGroupPause:SetActive(true)
    self:removeAutoTip()
end

-- 点击退出
function onClickExitHandler(self)
    self.mGroupPause:SetActive(false)
    self:close()
end

-- 点击继续
function onClickPlayHandler(self)
    self.mGroupPause:SetActive(false)
    self:addAutoTipTimerSn()
end

-- 点击重玩
function onClickReplayHandler(self)
    self.mNowRound = nil
    eliminate.EliminateManager:setNowThingCountDic(nil)
    self.mGroupPause:SetActive(false)
    self:initView()
end

-- 重玩
function onReplayEliminateHandler(self)
    self:onClickReplayHandler()
end

-- 消消乐每次检查完毕通知
function onCheckFinishHandler(self)
    self.mMaskClickGo:SetActive(false)
    if(self.mTargetItemDic)then
        local isWin = true
        for targetType, data in pairs(self.mTargetItemDic) do
            local nowCount = eliminate.EliminateManager:getNowThingCount(targetType)
            if(nowCount < data.targetCount)then
                isWin = false
                break
            end
        end
        local stageConfigVo = eliminate.EliminateManager:getRunStageConfigVo()
        if(isWin)then
            self:removeAutoTip()
            GameDispatcher:dispatchEvent(EventName.OPEN_ELIMINATE_RESULT_PANEL, true)
            GameDispatcher:dispatchEvent(EventName.REQ_ELIMINATE_STAGE_PASS, stageConfigVo.mapId)
        else
            self.mNowRound = self.mNowRound or 0
            if(self.mNowRound >= stageConfigVo.maxRound)then
                self:removeAutoTip()
                GameDispatcher:dispatchEvent(EventName.OPEN_ELIMINATE_RESULT_PANEL, false)
            else
                self:addAutoTipTimerSn()
            end
        end
    end
end

-- 当前消除物件数量更新
function onUpdateCountHandler(self)
    self:updateThingCountView()
end

function initView(self)
    local stageConfigVo = eliminate.EliminateManager:getRunStageConfigVo()
    gs.TransQuick:SizeDelta(self.mMapTrans, eliminate.GetMapSize(stageConfigVo.mapRow, stageConfigVo.mapCol))
    self.mMaskImg:SetImg(stageConfigVo.maskBg, false)
    eliminate.EliminateObjManager:initConfigMap(self.mTileItemGo, self.mThingItemGo, self.mTileLayerTrans, self.mThingLayerTrans, self.mEffectLayerTrans)

    self:updateTargetView()
    self:updateThingCountView()
    self:updateNowRoundView()
    
    self:addAutoTipTimerSn()
end

function updateTargetView(self)
    self:clearTargetItemList()
    local stageConfigVo = eliminate.EliminateManager:getRunStageConfigVo()
    local list = stageConfigVo.targetList
    for i = 1, #list do
        local targetType = list[i][1]
        local targetCount =list[i][2]
        local item = SimpleInsItem:create(self.mTargetItemGo, self.mTargetTrans, "EliminateTargetItem")
        self.mTargetItemDic[targetType] = {item = item, targetCount = targetCount}
    end
end

function updateThingCountView(self)
    if(self.mTargetItemDic)then
        for targetType, data in pairs(self.mTargetItemDic) do
            local nowCount = eliminate.EliminateManager:getNowThingCount(targetType)
            data.item:getChildGO("mImgTargetTip"):SetActive(nowCount >= data.targetCount)
            data.item:getChildGO("mImgTarget"):GetComponent(ty.AutoRefImage):SetImg(eliminate.EliminateManager:getThingConfigVo(targetType).icon, false)
            data.item:getChildGO("mTxtTarget"):SetActive(nowCount < data.targetCount)
            data.item:getChildGO("mTxtTarget"):GetComponent(ty.Text).text = data.targetCount - nowCount
        end
    end
end

function updateNowRoundView(self)
    local stageConfigVo = eliminate.EliminateManager:getRunStageConfigVo()
    self.mTxtRount.text = string.format(_TT(101012), math.min(self.mNowRound or 0, stageConfigVo.maxRound), stageConfigVo.maxRound) -- 回合 %s/%s
end

function addNowRound(self)
    self.mNowRound = (self.mNowRound or 0)
    local stageConfigVo = eliminate.EliminateManager:getRunStageConfigVo()
    if(self.mNowRound < stageConfigVo.maxRound)then
        self.mNowRound = self.mNowRound + 1
        self:updateNowRoundView()
    end
end

function clearTargetItemList(self)
    if(self.mTargetItemDic)then
        for thingType, data in pairs(self.mTargetItemDic) do
            data.item:poolRecover()
        end
    end
    self.mTargetItemDic = {}
end

----------------------------------------------------------------------------- 自动提示 -----------------------------------------------------------------------------
function removeAutoTip(self)
    self:removeAutoTipTimerSn()
    self:removeAutoTipTweener()
end

function removeAutoTipTimerSn(self)
    if (self.mAutoTipTimerSn) then
        LoopManager:removeTimerByIndex(self.mAutoTipTimerSn)
        self.mAutoTipTimerSn = nil
    end
end

function addAutoTipTimerSn(self)
    self:removeAutoTipTimerSn()
    self.mAutoTipTimerSn = LoopManager:addTimer(self.mAutoTipGapTime, 1, self, self.onCheckAutoTipHandler)
end

function onCheckAutoTipHandler(self)
    self:addAutoTipTimerSn()
    self:addAutoTipTweener()
end

function removeAutoTipTweener(self)
    if (self.mAutoTipTweener) then
        self.mAutoTipTweener:Kill()
        self.mAutoTipTweener = nil
    end
    self.mGroupAutoTipGo:SetActive(false)
end

function addAutoTipTweener(self)
    local matchStartThingVo, matchEndThingVo = eliminate.EliminateObjManager:getOptimalSolution()
    local startThingVo = nil
    local endThingVo = nil
    if(matchStartThingVo ~= nil and matchEndThingVo ~= nil)then
        startThingVo = matchStartThingVo
        endThingVo = matchEndThingVo
    elseif(matchStartThingVo ~= nil or matchEndThingVo ~= nil)then
        startThingVo = matchStartThingVo and matchStartThingVo or matchEndThingVo
        endThingVo = startThingVo
    end
    if(startThingVo and endThingVo)then
        local startLocalPosX, startLocalPosY = eliminate.GetTileLocalPos(startThingVo.mapRow, startThingVo.mapCol, startThingVo.rowIndex, startThingVo.colIndex)
        local endLocalPosX, endLocalPosY = eliminate.GetTileLocalPos(endThingVo.mapRow, endThingVo.mapCol, endThingVo.rowIndex, endThingVo.colIndex)
        gs.TransQuick:LPosXY(self.mGroupAutoTipTrans, startLocalPosX, startLocalPosY)
        self.mGroupAutoTipGo:SetActive(true)
        self.mAutoTipTweener = TweenFactory:move2Lpos(self.mGroupAutoTipTrans, math.Vector3(endLocalPosX, endLocalPosY, 0), 1, gs.DT.Ease.Linear, 
        function() 
            self:removeAutoTipTweener() 
        end, true, gs.DT.LoopType.Restart, 2)
    end
end

return _M