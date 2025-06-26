module("battleMap.MainMapTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("battleMapHall/mainMap/MainMapTabView.prefab")
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
--构造函数
function ctor(self)
    super.ctor(self)
    self:setUICode(LinkCode.MainMap)
end


function initData(self)
    self.mActionBgName = nil
    -- 当前章节数据vo
    self.mChapterVo = nil
    -- 滚动列表上下各空余数量
    self.mEmptyItemNum = 3
    -- 当前打开的第x章节的关卡列表
    self.mOpenChapterVo = nil
    -- 当前是否初次定位滑动
    self.mIsFirstMove = nil
    -- 是否结束拖拽
    self.mIsEndDrag = nil
    -- 是否正在滚动中
    self.mIsMoving = nil
end

function configUI(self)
    self.mBottomImg = self:getChildTrans("mImgBottom"):GetComponent(ty.AutoRefImage)
    self.mBottomAlpha = self:getChildTrans("mImgBottom"):GetComponent(ty.CanvasGroup)
    self.mImgTop = self:getChildTrans("mImgTop"):GetComponent(ty.AutoRefImage)
    self.mTopAlpha = self:getChildTrans("mImgTop"):GetComponent(ty.CanvasGroup)
    self.mRectLeft = self:getChildGO("mGroupLeft"):GetComponent(ty.RectTransform)

    self.mLyScrollerGo = self:getChildGO("LyScroller")
    self.mLyScrollRect = self.mLyScrollerGo:GetComponent(ty.ScrollRect).content:GetComponent(ty.RectTransform)
    self.mEventTrigger = self.mLyScrollerGo:GetComponent(ty.LongPressOrClickEventTrigger)
    self.mEventTrigger:SetIsPassEvent(true)
    self.mLyScroller = self.mLyScrollerGo:GetComponent(ty.LyScroller)
    self.mLyScroller:SetItemRender(battleMap.MainMapChapterItem)

    self.mSmallLyScroller = self:getChildGO("SmallLyScroller")
    self.mSmallLyScrollRect = self.mSmallLyScroller:GetComponent(ty.ScrollRect).content:GetComponent(ty.RectTransform)
    self.mSmallLyScroller = self.mSmallLyScroller:GetComponent(ty.LyScroller)
    self.mSmallLyScroller:SetItemRender(battleMap.MainMapSmallChapterItem)

    self.mStyleView = battleMap.MainMapStyleView.new()
    self.mStyleView:setParentTrans(self.UITrans)
    self.mBtnStart = self:getChildGO("mBtnStart")
    self.mGroupContent = self:getChildTrans("Content")
    self.mStandardTrans = self:getChildTrans("mImgStandard")

    -- 滚动器选中展示的相关
    self.mImgBg = self:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage)
    self.mImgBar = self:getChildTrans("Mask"):GetComponent(ty.AutoRefImage)
    self.mImgBarBg = self:getChildTrans("BarBg"):GetComponent(ty.AutoRefImage)
    self.mProgressBar = self:getChildGO('ProgressBar'):GetComponent(ty.ProgressBar)
    self.mProgressBar:InitData(4)
    self.mTxtContent = self:getChildTrans("mTxtContent"):GetComponent(ty.Text)
    self.mTxtNum = self:getChildGO("mTxtNum"):GetComponent(ty.Text)
    self.mCanvasGroupContent = self:getChildTrans("mTxtContent"):GetComponent(ty.CanvasGroup)
    self.mRectContent = self:getChildTrans("mTxtContent"):GetComponent(ty.RectTransform)
    self.mGoLock = self:getChildGO("mImgLock")

    self.mImgStart = self:getChildGO("mImgStart")
    self.mImgComplete = self:getChildGO("mImgComplete")
    self.mImgStyle = self:getChildGO("mImgStyle")

    self.mImgTabBg_1 = self:getChildGO("mImgTabBg_1"):GetComponent(ty.AutoRefImage)
    self.mImgTabBg_2 = self:getChildGO("mImgTabBg_2"):GetComponent(ty.AutoRefImage)


    self:setGuideTrans("guide_BtnMainStageStart", self:getChildTrans("mBtnStart"))
end

function onClickHandler(self)
    self:onClickStartHandler()
end
-- 玩家点击关闭
function onClickClose(self)
    self:playerClose()
    super.onClickClose(self)
end

-- 玩家关闭所有窗口的c#回调
function onCloseAllCall(self)
    self:playerClose()
    super.onCloseAllCall(self)
end

function playerClose(self)
    self:initData()
end

function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList()
    self.mLyScroller:SetMoveCall(self, self.onMoveHandler)
    local function _onBeginDrag()
        self:onBeginDragHandler()
    end
    self.mEventTrigger.onBeginDrag:AddListener(_onBeginDrag)
    local function _onEndDrag()
        self:onEndDragHandler()
    end
    self.mEventTrigger.onEndDrag:AddListener(_onEndDrag)
    battleMap.MainMapManager:addEventListener(battleMap.MainMapManager.EVENT_DUP_UPDATE, self.onUpdateDataHandler, self)
    GameDispatcher:addEventListener(EventName.CHANGE_MAIN_MAP_STYLE, self.onUpdateMainMapStyleHandler, self)
    -- GameDispatcher:addEventListener(EventName.MAIN_STAGE_LIST_PANEL_OPENING, self.onTweenToHideHandler, self)
    -- GameDispatcher:addEventListener(EventName.MAIN_STAGE_LIST_PANEL_CLOSING, self.onTweenToShowHandler, self)
    GameDispatcher:addEventListener(EventName.CLOSE_MAIN_STAGE_LIST_PANEL, self.onDelOpenChapterVoHandler, self)
    battleMap.MainMapManager:addEventListener(battleMap.MainMapManager.MAIN_MAP_CHAPTER_SELECT_CHANGE, self.onSelectChapterHandler, self)

    self.mStyleView:active()
    if (self.mChapterVo) then
        local proPercent, proStr = self.mChapterVo:getStage(battleMap.MainMapManager:getStyle())
        self.mProgressBar:SetValue(proPercent, proStr, true)
        self:updateView(false, self.mChapterVo.chapterId)
    elseif (args.chapterId) then
        self:updateView(false, args.chapterId)
    else
        if (not fight.FightManager:getIsUIByFightEnd()) then
            battleMap.MainMapManager.style = nil
        end
        local stageId = battleMap.MainMapManager:getMainMapCurStage()
        self.mChapterVo = battleMap.MainMapManager:getChapterVoByStageId(stageId)
        if (self.mChapterVo == nil) then
            logError("请先找曹永繁曹老板解决。" .. stageId .. "无对应配置")
        end
        self:updateView(true, self.mChapterVo.chapterId)
    end
end

function deActive(self)
    self.mLyScroller:SetMoveCall(nil, nil)
    self.mSmallLyScroller:StopTweenMove()
    super.deActive(self)
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID })
    self.mEventTrigger.onBeginDrag:RemoveAllListeners()
    self.mEventTrigger.onEndDrag:RemoveAllListeners()
    battleMap.MainMapManager:removeEventListener(battleMap.MainMapManager.EVENT_DUP_UPDATE, self.onUpdateDataHandler, self)
    GameDispatcher:removeEventListener(EventName.CHANGE_MAIN_MAP_STYLE, self.onUpdateMainMapStyleHandler, self)
    -- GameDispatcher:removeEventListener(EventName.MAIN_STAGE_LIST_PANEL_OPENING, self.onTweenToHideHandler, self)
    -- GameDispatcher:removeEventListener(EventName.MAIN_STAGE_LIST_PANEL_CLOSING, self.onTweenToShowHandler, self)
    GameDispatcher:removeEventListener(EventName.CLOSE_MAIN_STAGE_LIST_PANEL, self.onDelOpenChapterVoHandler, self)
    battleMap.MainMapManager:removeEventListener(battleMap.MainMapManager.MAIN_MAP_CHAPTER_SELECT_CHANGE, self.onSelectChapterHandler, self)
    self.mProgressBar:SetValue(0, 0, false)
    self.mStyleView:deActive()
    if self.mLyScroller then
        self.mLyScroller:CleanAllItem()
    end
    if self.mSmallLyScroller then
        self.mSmallLyScroller:CleanAllItem()
    end
    self.mIsFirstMove = nil
    self.mIsEndDrag = nil
    self.mIsMoving = nil
    self:removeMoveHandler()

    if (self.mDelayCheckErrorSn) then
        LoopManager:removeFrameByIndex(self.mDelayCheckErrorSn)
        self.mDelayCheckErrorSn = nil
    end
end

function initViewText(self)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnStart, self.onClickStartHandler)
end

function onTweenToShowHandler(self)
end

function onTweenToHideHandler(self)
end

function onDelOpenChapterVoHandler(self)
    self.mOpenChapterVo = nil
end

function onClickStartHandler(self)
    local firstStageId = self.mChapterVo:getFirstStageId(battleMap.MainMapManager:getStyle())
    local firstStageVo = battleMap.MainMapManager:getStageVo(firstStageId)
    local stageId = firstStageVo.stageId
    if battleMap.MainMapManager:isStagePass(stageId) or battleMap.MainMapManager:isStageCanFight(stageId) then
        local roleVo = role.RoleManager:getRoleVo()
        if roleVo:getPlayerLvl() < self.mChapterVo.m_level then
            gs.Message.Show(string.format(_TT(1152), self.mChapterVo.m_level))
            return
        else
            if (not table.empty(firstStageVo.beginTime) ) then
                local clientTime = GameManager:getClientTime()

                if clientTime < TimeUtil.transTime(firstStageVo.beginTime) then
                    local day, time = TimeUtil.getMDHByTime2(TimeUtil.transTime(firstStageVo.beginTime))
                    gs.Message.Show(day .. " " .. time .. "开放")
                    return
                end
            end
            
            self.mOpenChapterVo = self.mChapterVo
            self:removeMoveHandler()
            GameDispatcher:dispatchEvent(EventName.OPEN_MAIN_STAGE_LIST_PANEL, { chapterVo = self.mOpenChapterVo })
        end
    else
        -- local isActive, needPassStageId = firstStageVo:isActive()
        -- local needStageVo = battleMap.MainMapManager:getStageVo(needPassStageId)
        -- 未解锁
        gs.Message.Show(_TT(53608))
    end
end

function onSelectChapterHandler(self, args)
    self.mChapterVo = args.chapterVo
    local isClick = args.isClick
    if (isClick) then
        self:removeMoveHandler()
        self:scrollToIndex(self:getIndexByChapterId(self.mChapterVo.chapterId), true)
    else
        self:updateStyleView()
        AudioManager:playSoundEffect(UrlManager:getUIBaseSoundPath("ui_basic_switch.prefab"))
    end
end

function getIndexByChapterId(self, chapterId)
    local dataList = self.mLyScroller.DataProvider
    if (dataList) then
        for i = 1, #dataList do
            if (dataList[i] ~= false and dataList[i].chapterVo.chapterId == chapterId) then
                return i - self.mEmptyItemNum
            end
        end
    end
end

function onBeginDragHandler(self)
    self.mIsEndDrag = false
    self:removeMoveHandler()
end

function onEndDragHandler(self)
    self.mIsEndDrag = true
    self:getSpeed(true)
end

function onMoveHandler(self, offset)
    if (self.mIsEndDrag == nil) then
        -- 初始定位时触发的移动
        local speed = self:getSpeed(false)
        if (speed <= 500) then
            self.mIsMoving = false
        else
            self.mIsMoving = true
        end
    else
        -- 判断惯性滑动速度，过小直接定位
        if (self.mIsEndDrag) then
            local speed = self:getSpeed(false)
            if (speed <= 500) then
                self.mIsMoving = false
            else
                self.mIsMoving = true
            end
        else
            self.mIsMoving = true
        end
    end

    if (self.mIsMoving) then
        if (not self.mMoveOffsetY) then
            self.mMoveOffsetY = offset.y
        end

        local isMoveUp = nil
        if (self.mIsFirstMove ~= nil) then
            if ((self.mMoveOffsetY - offset.y) < 0) then
                isMoveUp = false
            else
                isMoveUp = true
            end
        end
        GameDispatcher:dispatchEvent(EventName.MAIN_SCROLLER_START_ROLL, { isMoveUp = isMoveUp })
        self.mMoveOffsetY = offset.y
    else
        self.mMoveOffsetY = nil
    end
    if (not self.mMoveFrameSn) then
        self.mMoveFrameSn = LoopManager:addFrame(1, 0, self, self.__onMoveFrameHandler)
    end
end

function removeMoveHandler(self)
    self.mIsMoving = false
    self.mLyScroller:StopTweenMove()
    self.mSmallLyScroller:StopTweenMove()
    if (self.mMoveFrameSn) then
        LoopManager:removeFrameByIndex(self.mMoveFrameSn)
        self.mMoveFrameSn = nil
    end
end

function setTabBag(self, chapterId)
    self.mImgTabBg_2:SetImg(string.format("arts/ui/bg/mainMap/dup_mainmap_bg_%s.jpg", chapterId), false)
    if self.mLastchapterId then
        if self.mLastchapterId ~= chapterId then
            self.mImgTabBg_1:SetImg(string.format("arts/ui/bg/mainMap/dup_mainmap_bg_%s.jpg", self.mLastchapterId), false)
            self.mImgTabBg_2:GetComponent(ty.UIDoTween):EndTween()
            self.mImgTabBg_2:GetComponent(ty.UIDoTween):BeginTween()

            self.mLastchapterId = chapterId
        end
    else
        self.mLastchapterId = chapterId
    end
end

function __onMoveFrameHandler(self)
    if (self.mIsMoving) then
        self.mIsMoving = false
    else
        if (self.mIsEndDrag) then
            self.mIsEndDrag = false
            self:removeMoveHandler()
            local nearIndex = self:getNearIndex()
            local index = self:scrollToIndex(nearIndex, false)
            local dataIndex = index - self.mEmptyItemNum
            self.mChapterVo = battleMap.MainMapManager:getChapterList()[dataIndex]
            self:updateStyleView()
        else
            -- 玩家拖拽停止不放开 或者 设置目标索引自动定位，此处主要针对后者当非玩家拖拽情况时需要手动清理滚动
            if (not gs.Input:GetMouseButton(0)) then
                local speed = self:getSpeed(false)
                if (speed <= 500) then
                    GameDispatcher:dispatchEvent(EventName.MAIN_SCROLLER_END_ROLL, { chapterVo = self.mChapterVo })
                    self:removeMoveHandler()
                    self.mIsFirstMove = false
                end
                self:setTabBag(self.mChapterVo.chapterId)
            end
        end
    end

    self:refreshContentPosY()
end

--刷新content的位置
function refreshContentPosY(self)
    local ratio = battleMap.MainMapChapterItem:itemH() / battleMap.MainMapSmallChapterItem:itemH()
    local middleY = (self.mLyScrollRect.anchoredPosition.y + battleMap.MainMapChapterItem:scrollerH() / 2) / ratio
    local targetY = middleY - battleMap.MainMapSmallChapterItem:scrollerH() / 2
    gs.TransQuick:UIPosY(self.mSmallLyScrollRect, targetY)
end

function getSpeed(self, isInit)
    if (not gs.GoUtil.IsCompNull(self.mLyScrollRect)) then
        local scrollerY = self.mLyScrollRect.anchoredPosition.y
        local emptyH = self.mEmptyItemNum * battleMap.MainMapChapterItem:itemH() - (battleMap.MainMapChapterItem:itemH() - (battleMap.MainMapChapterItem:scrollerH() - battleMap.MainMapChapterItem:itemH()) / 2)
        if (scrollerY <= emptyH or scrollerY >= #self.mLyScroller.DataProvider * battleMap.MainMapChapterItem:itemH() - emptyH - battleMap.MainMapChapterItem:scrollerH()) then
            return 0
        else
            if (isInit or not self.m_oldY) then
                self.m_oldY = self.mLyScrollRect.anchoredPosition.y
            end
            local speed = math.abs((self.mLyScrollRect.anchoredPosition.y - self.m_oldY) / LoopManager:getDeltaTime())
            self.m_oldY = self.mLyScrollRect.anchoredPosition.y
            return tonumber(string.format("%.2f", speed))
        end
    else
        return 0
    end
end

-- 获取邻近基准线的index
function getNearIndex(self)
    local itemH = battleMap.MainMapChapterItem:itemH()
    if (not self.mLyScrollerH) then
        self.mLyScrollerH = self.mLyScrollerGo:GetComponent(ty.RectTransform).sizeDelta.y
    end
    local rectIntegersY, rectDecimalsY = math.modf(self.mLyScrollRect.anchoredPosition.y)
    rectDecimalsY = rectDecimalsY >= 0.5 and 1 or 0
    rectIntegersY = rectIntegersY + rectDecimalsY

    local indexIntegers, indexDecimals = math.modf((rectIntegersY + self.mLyScrollerH / 2 + itemH / 2) / itemH)
    indexDecimals = indexDecimals >= 0.5 and 1 or 0
    indexIntegers = indexIntegers + indexDecimals
    return indexIntegers
end

function scrollToIndex(self, toIndex, isDataIndex, delay, minDispatchDelay)
    if (isDataIndex) then
        toIndex = toIndex + self.mEmptyItemNum
    end
    local minIndex = self.mEmptyItemNum + 1
    toIndex = toIndex <= minIndex and minIndex or toIndex
    local maxIndex = #self.mLyScroller.DataProvider - self.mEmptyItemNum
    toIndex = toIndex >= maxIndex and maxIndex or toIndex
    if (not self.mLyScrollerH) then
        self.mLyScrollerH = self.mLyScrollerGo:GetComponent(ty.RectTransform).sizeDelta.y
    end
    local centenY = self.mLyScrollerH / 2
    local itemH = battleMap.MainMapChapterItem:itemH()

    minDispatchDelay = minDispatchDelay or 0
    delay = delay or 0.15
    if (delay <= minDispatchDelay) then
        GameDispatcher:dispatchEvent(EventName.MAIN_SCROLLER_START_ROLL, { isMoveUp = nil })
    end
    self.mLyScroller:SetItemIndex(toIndex, 0, -(centenY + itemH / 2), delay)
    if (delay <= minDispatchDelay) then
        GameDispatcher:dispatchEvent(EventName.MAIN_SCROLLER_END_ROLL, { chapterVo = self.mChapterVo })
    end
    self:setTabBag(self.mChapterVo.chapterId)
    return toIndex
end

-- 副本数据更新
function onUpdateDataHandler(self, args)
    local chapterId = self.mChapterVo and self.mChapterVo.chapterId or nil
    self:updateView(false, chapterId)
    self:updateStyleView()
end

-- 更新难易程度风格
function onUpdateMainMapStyleHandler(self, args)
    local stageId = battleMap.MainMapManager:getCurTypeStageTd(args.styleType)
    self.mChapterVo = battleMap.MainMapManager:getChapterVoByStageId(stageId)
    battleMap.MainMapManager:setStageStyle(args.styleType)
    local chapterId = self.mChapterVo and self.mChapterVo.chapterId or nil
    self.mChapterVo = nil
    self:updateView(true, chapterId)
    self:updateStyleView()
end

function updateView(self, isInit, selectChapterId)
    self:updateChapterList(isInit, selectChapterId)
end

function updateChapterList(self, cusIsInit, selectChapterId)
    local list = {}
    local selectIndex = 1
    local chapterList = battleMap.MainMapManager:getChapterList()
    for startPos = 1, self.mEmptyItemNum do
        table.insert(list, false)
    end
    for i = 1, #chapterList do
        local isShowRed = false
        local chapterVo = chapterList[i]
        local progress, sum = chapterVo:getStage(battleMap.MainMapManager:getStyle())
        for _, stageVo in ipairs(chapterVo:getStageVoList(battleMap.MainMapManager:getStyle())) do
            if stageVo and progress >= stageVo.sort and #stageVo.stageAwardList > 0 and (table.indexof(battleMap.MainMapManager:getReceivedStageAwardList(), stageVo.stageId) == false) then
                isShowRed = true
            end
        end
        table.insert(list, { isStart = i == 1, isEnd = i == #chapterList, chapterVo = chapterVo, standardTrans = self.mStandardTrans, isBubble = isShowRed })
        if (selectChapterId == chapterVo.chapterId) then
            selectIndex = i
        end
    end
    for endPos = 1, self.mEmptyItemNum do
        table.insert(list, false)
    end

    if (self.mLyScroller.Count <= 0 or self.mSmallLyScroller.Count <= 0 or cusIsInit == nil or cusIsInit == true) then
        self.mLyScroller.DataProvider = list
        self.mSmallLyScroller.DataProvider = list
    else
        self.mLyScroller:ReplaceAllDataProvider(list)
        self.mSmallLyScroller:ReplaceAllDataProvider(list)
    end

    self:refreshContentPosY()

    self.mChapterVo = chapterList[selectIndex]

    if (self.mDelayCheckErrorSn) then
        LoopManager:removeFrameByIndex(self.mDelayCheckErrorSn)
        self.mDelayCheckErrorSn = nil
    end
    self.mDelayCheckErrorSn = LoopManager:addFrame(5, 1, self,
    function()
        if (self:checkIsError()) then
            gs.TransQuick:UIPosY(self.mLyScroller:GetContent(), self.mLyScroller:GetContent().anchoredPosition.y - 1)
            self:scrollToIndex(selectIndex, true, 0.1, 0.1)
        end
    end)
    self:scrollToIndex(selectIndex, true, 0)
end

-- 在某些机型下某下卡顿下虚拟列表表没有触发onValueChanged，此处检测透明度以判断虚拟列表是否显示异常，以便强制触发延迟处的偏移定位
function checkIsError(self)
    local list = self.mLyScroller:GetItemList()
    local count = list.Count
    for i = 0, count - 1 do
        local alpha = list[i]:getAlpha()
        if (alpha > 0) then
            return false
        end
    end
    return true
end

function updateStyleView(self)
    local styleType = battleMap.MainMapManager:getStyle()
    self.mStyleView:setData({ battleMap.MainMapStyleType.Easy, battleMap.MainMapStyleType.Difficulty, battleMap.MainMapStyleType.SuperDifficulty }, styleType, false, self.mChapterVo)

    -- if (styleType == battleMap.MainMapStyleType.Easy) then
    --     self.mImgStyle:SetActive(false)
    --     self.mImgBar:SetImg(UrlManager:getPackPath("mainMap/main_map_easy_bar.png"), false)
    --     self.mImgBarBg:SetImg(UrlManager:getPackPath("mainMap/main_map_easy_bar_bg.png"), false)
    -- elseif (styleType == battleMap.MainMapStyleType.Difficulty) then
    --     self.mImgStyle:SetActive(true)
    --     self.mImgBar:SetImg(UrlManager:getPackPath("mainMap/main_map_difficulty_bar.png"), false)
    --     self.mImgBarBg:SetImg(UrlManager:getPackPath("mainMap/main_map_difficulty_bar_bg.png"), false)
    -- end
    -- local proPercent, proStr = self.mChapterVo:getStage(styleType)
    -- self.mProgressBar:SetValue(0, 100, false)
    -- self.mProgressBar:SetValue(proPercent, proStr, true)
    -- self.mImgComplete:SetActive(proPercent >= proStr)
    -- local contentStr = self.mChapterVo:getName()
    -- if (self.mTxtContent.text ~= contentStr) then
    --     if (self.mScaleTweener) then
    --         self.mScaleTweener:Kill()
    --         self.mScaleTweener = nil
    --     end
    --     if (self.mAlphaTweener) then
    --         self.mAlphaTweener:Kill()
    --         self.mAlphaTweener = nil
    --     end
    --     self.mScaleTweener = TweenFactory:scaleTo(self.mRectContent, math.Vector3(1.3, 1.3, 1), math.Vector3(1, 1, 1), 0.3, nil,
    --     function()
    --         self.mScaleTweener:Kill()
    --         self.mScaleTweener = nil
    --     end)
    --     self.mAlphaTweener = TweenFactory:canvasGroupAlphaTo(self.mCanvasGroupContent, 0.5, 1, 0.3, nil,
    --     function()
    --         self.mAlphaTweener:Kill()
    --         self.mAlphaTweener = nil
    --     end)
    -- end
    -- self.mTxtContent.text = contentStr
    -- self.mTxtNum.text = "0" .. self.mChapterVo.chapterId
    -- self.mImgBg:SetImg(UrlManager:getIconPath("mainMap/mainMap_chapter_" .. self.mChapterVo.chapterId .. ".png"), false)

    -- -- 显示是否解锁的标识
    -- local firstStageId = self.mChapterVo:getFirstStageId(battleMap.MainMapManager:getStyle())
    -- local firstStageVo = battleMap.MainMapManager:getStageVo(firstStageId)
    -- local isActive, needPassStageId = firstStageVo:isActive()
    -- local needLevl = role.RoleManager:getRoleVo():getPlayerLvl() >= self.mChapterVo.m_level
    -- if (isActive and needLevl) then
    --     self.mGoLock:SetActive(false)
    --     self.mProgressBar.gameObject:SetActive(true)
    --     self.mImgStart.gameObject:SetActive(true)
    -- else
    --     self.mGoLock:SetActive(true)
    --     self.mProgressBar.gameObject:SetActive(false)
    --     self.mImgStart.gameObject:SetActive(false)
    -- end

    -- -- -- 专门更新对应风格类型章节的背景
    -- local styleType = battleMap.MainMapManager:getStyle()
    -- local chapterId = self.mChapterVo.chapterId
    -- local bgName = UrlManager:getMainMapChapterBgUrl(styleType, chapterId)
    -- local oldImg = self.mBottomImg:GetImgKey()
    -- if (oldImg == bgName) then
    --     return
    -- end
    -- self:setActionBg(bgName)
end

-- 设置页面背景图
function setActionBg(self, cusBgName)
    -- print("\n设置资源：", cusBgName)
    if (self.mActionBgName == nil) then
        self.mBottomImg:SetImg(cusBgName, true)
        self.mBottomAlpha.alpha = 0
        self.mImgTop:SetImg(cusBgName, true)
        self.mTopAlpha.alpha = 1
        self.mActionBgName = cusBgName
    else
        self.mActionBgName = cusBgName
        if (self.mTopTweener) then
            self.mTopTweener:Kill()
            self.mTopTweener = nil
            self.mTopAlpha.alpha = 1
        end
        if (not self.mTopTweener and not self.m_bottomTweener and self.mActionBgName ~= "") then
            local oldImg = self.mBottomImg:GetImgKey()
            local newImg = self.mActionBgName
            self.mActionBgName = ""

            self.mBottomImg:SetImg(newImg, true)
            self.mBottomAlpha.alpha = 1
            self.mImgTop:SetImg(oldImg, true)
            self.mTopAlpha.alpha = 0

            self.mTopTweener = TweenFactory:canvasGroupAlphaTo(self.mTopAlpha, 1, 0, 1, nil,
            function()
                self.mTopTweener = nil
                if (not self.mTopTweener and not self.m_bottomTweener and self.mActionBgName ~= "") then
                    self:setActionBg(self.mActionBgName)
                end
            end)
        end
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]