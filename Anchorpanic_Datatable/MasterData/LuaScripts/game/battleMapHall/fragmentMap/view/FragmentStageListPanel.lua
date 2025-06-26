--[[ 
    主线关卡列表界面
]]
module("battleMap.FragmentStageListPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("battleMapHall/mainMap/MainMapStageListPanel.prefab")
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
-- blurTweenTime = 0.5
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
isAdapta = 1 -- 是否开启适配刘海 0 否 1 是
-- 构造函数
function ctor(self)
    super.ctor(self)
    local w, h = ScreenUtil:getScreenSize()
    self:setSize(w, h)
    self:setBg("dup_mainmap_bg.jpg", false, "mainMap")
    self:setTxtTitle(_TT(44217))
    self:setGuideTrans("guide_BtnCloseAll", self.gBtnCloseAll.transform)

    self:setGuideTrans("guide_BtnClose", self.gBtnClose.transform)
end

-- 适应全面屏，刘海缩进
function setAdapta(self)
    local notchHeight = systemSetting.SystemSettingManager:getNotchH()
    local topTrans, stageAwardTrans = self:getAdaptaTrans()
    if notchHeight ~= nil then
        local minV = topTrans.offsetMin;
        minV.x = notchHeight;
        topTrans.offsetMin = minV;

        local maxV = topTrans.offsetMax;
        maxV.x = -notchHeight;
        topTrans.offsetMax = maxV;

        local minV = stageAwardTrans.offsetMin;
        minV.x = notchHeight;
        stageAwardTrans.offsetMin = minV;

        local maxV = stageAwardTrans.offsetMax;
        maxV.x = -notchHeight;
        stageAwardTrans.offsetMax = maxV;
    end
end

function getAdaptaTrans(self)
    return self.base_childTrans["mGroupTop"], self:getChildTrans("mGroupStageAward")
end

function initData(self)
    self.mItemList = {}
    --阶段性奖励列表
    self.mStageAwardList = {}
    --当前的关卡进度
    self.mStageProgress = 0
    --阶段性奖励数量
    self.mStageAwardNum = 0
    --当前阶段性奖励列表
    self.mCurStageAwardList = {}
    --是否已领取完奖励
    self.mIsRecAllStageAward = true
    --阶段性奖励item
    self.mStageAwardItemList = {}
    self.isShowInfo = false
    -- 当前移动位置
    self.mCurPosX = 0
    -- 上一次移动位置
    self.mLastPosX = 0
    -- 移动倍数 倍数越小 速度越慢 取值区间 0~1
    self.mMultiple = 0.2

    self.mWeaknessGrid = {}
end

function configUI(self)
    self.mBtnStage = self:getChildGO("mBtnStage")
    self.mNodeStart = self:getChildTrans("NodeStart")
    self.mImgToucher = self:getChildGO("mImgToucher")
    self.mGroupContent = self:getChildTrans("Content")
    self.mNextAward = self:getChildTrans("mNextAward")
    self.mReceiveGroup = self:getChildGO("mReceiveGroup")
    self.mScrollerTrans = self:getChildTrans("Scroll View")
    self.mCompleteGroup = self:getChildGO("mCompleteGroup")
    self.mNextAwardGroup = self:getChildGO("mNextAwardGroup")
    self.mImgPro = self:getChildGO("mImgPro"):GetComponent(ty.Image)
    self.mTxtTips = self:getChildGO("mTxtTips"):GetComponent(ty.Text)
    self.mRectNodeStart = self.mNodeStart:GetComponent(ty.RectTransform)
    self.mRectContent = self.mGroupContent:GetComponent(ty.RectTransform)
    self.mTxtTitle = self:getChildTrans("TextTitle"):GetComponent(ty.Text)
    self.mTxtStageNum = self:getChildGO("mTxtStageNum"):GetComponent(ty.Text)
    self.mTxtChapter = self:getChildTrans("TextChapter"):GetComponent(ty.Text)
    self.mImgStyle = self:getChildGO("mImgStyle"):GetComponent(ty.AutoRefImage)
    self.mEventTrigger = self.mScrollerTrans:GetComponent(ty.LongPressOrClickEventTrigger)

    self.mImgEleBg = self:getChildGO("mImgEleBg")

    self:__infoPanelConfigUI()
end

-- 设置文本标题
function setTxtTitle(self, title)
    super.setTxtTitle(self, title)
    self:setGuideTrans("funcTips_guide_View_CloseAlll", self.gBtnCloseAll.transform)
end

function active(self, args)
    super.active(self, args)
    self.mBtnStage:SetActive(false)
    self.base_childGos["MoneyBar"]:SetActive(false)
    MoneyManager:setMoneyTidList()
    battleMap.FragmentMapManager:addEventListener(battleMap.FragmentMapManager.EVENT_DUP_UPDATE, self.onUpdateHandler, self)
    GameDispatcher:addEventListener(EventName.MAIN_STAGE_INFO_OPENING, self.__onShowStageInfoHandler, self)
    GameDispatcher:addEventListener(EventName.MAIN_STAGE_INFO_CLOSING, self.__onHideStageInfoHandler, self)
    GameDispatcher:addEventListener(EventName.CHANGE_MAIN_MAP_STYLE, self.onUpdateMainMapStyleHandler, self)

    GameDispatcher:addEventListener(EventName.SET_SELECT_MAIN_ITEM, self.onSetSelectHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_MIAN_STAGE_LIST, self.onUpdateMainStageListHnalder, self)
    -- battleMap.FragmentMapManager:addEventListener(battleMap.FragmentMapManager.EVENT_STAGE_AWARD_UPDATE, self.updateStageAward, self)


    -- 这里通知给MainMapTabView动画隐藏掉入口按钮
    GameDispatcher:dispatchEvent(EventName.MAIN_STAGE_LIST_PANEL_OPENING, {})
    self:setData(args)
    if self.isReshow then
        local stageId = battleMap.FragmentMapManager:getCurSelectMapStageId()
        self:onSetSelectHandler({stageId = stageId})
        self:onUpdateMainStageListHnalder({stageId = stageId})
    end

    self.needSmallerStage = sysParam.SysParamManager:getValue(1901)
    self.needTime = sysParam.SysParamManager:getValue(1902)

    if self.needTime ~= 999 and battleMap.FragmentMapManager:isStagePass(self.needSmallerStage) == nil then
        self:resFirstShow()
        self.mOnShowLastItemSn = LoopManager:addTimer(1, 0, self, self.onShowLastItem)
        self:onShowLastItem()
    end
end

function onSetSelectHandler(self, args)    
    self:resFirstShow()
    self:setSelectStage(args.stageId)
end

function onUpdateMainStageListHnalder(self, args)
    self:setHideInfo(args.stageId, false)
    self:infoPanelShow(args.stageId)
end

function onShowLastItem(self)
    if self.isShowInfo == false and storyTalk.StoryTalkManager:getCurHasStory() == false and guide.GuideManager:getCurHasGuide() == false and gs.PopPanelManager.HasSubPopActive() == false then
        self.isAddTime = self.isAddTime + 1
        if self.isAddTime >= self.needTime and self.isShowFirst == false then
            self.isShowFirst = true
            local lastId = battleMap.FragmentMapManager:getMainMapCurStage()
            self:showLasClickItemEff(lastId)
        end
    else
        self:resFirstShow()
    end
end

function showLasClickItemEff(self, lastId)
    for k, v in pairs(self.mItemList) do
        local item = v.item
        item:setShowFirstEff(lastId and item:getData().stageId == lastId or false)
    end
end

function resFirstShow(self)
    self.isShowFirst = false
    self.isAddTime = 0
    self:showLasClickItemEff()
end

function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    -- 背景缓动回调
    -- self.mEventTrigger.onBeginDrag:RemoveAllListeners()
    battleMap.FragmentMapManager:removeEventListener(battleMap.FragmentMapManager.EVENT_DUP_UPDATE, self.onUpdateHandler, self)
    GameDispatcher:removeEventListener(EventName.MAIN_STAGE_INFO_OPENING, self.__onShowStageInfoHandler, self)
    GameDispatcher:removeEventListener(EventName.MAIN_STAGE_INFO_CLOSING, self.__onHideStageInfoHandler, self)
    GameDispatcher:removeEventListener(EventName.CHANGE_MAIN_MAP_STYLE, self.onUpdateMainMapStyleHandler, self)
    GameDispatcher:removeEventListener(EventName.SET_SELECT_MAIN_ITEM, self.onSetSelectHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_MIAN_STAGE_LIST, self.onUpdateMainStageListHnalder, self)
    -- battleMap.FragmentMapManager:removeEventListener(battleMap.FragmentMapManager.EVENT_STAGE_AWARD_UPDATE, self.updateStageAward, self)
    self:removeItemList()
    self.mIsRecAllStageAward = true
    if (self.mDelayFrameSn) then
        LoopManager:removeFrameByIndex(self.mDelayFrameSn)
        self.mDelayFrameSn = nil
    end
    if (self.mActionFrameSn) then
        LoopManager:removeFrameByIndex(self.mActionFrameSn)
        self.mActionFrameSn = nil
    end
    if self.timeId then
        LoopManager:removeFrameByIndex(self.timeId)
        self.timeId = nil
    end
    if self.mShowSn then
        LoopManager:removeTimerByIndex(self.mShowSn)
        self.mShowSn = nil
    end

    if self.mOnShowLastItemSn then
        LoopManager:removeTimerByIndex(self.mOnShowLastItemSn)
        self.mOnShowLastItemSn = nil
    end
    self:removeStageAwardList()
    RedPointManager:remove(self.mImgPro.gameObject.transform)
    battleMap.FragmentMapManager:getIsChapterHasBubble()

    if self.mMoneyBatItem then 
        self.mMoneyBatItem:poolRecover()
        self.mMoneyBatItem = nil
    end
end

function initViewText(self)
    self.mTxtTips.text = _TT(60)--关卡进度
end

function addAllUIEvent(self)
    self:addUIEvent(self.mImgToucher, self.onClickEmptyHandler)
    self:addUIEvent(self.mBtnStage, self.onClickOpenStageAwardViewHandler)
    self:infoPanelAddAllUIEvent()
end

function __playOpenAction(self)
    if (self.panelType ~= 1) then
        local tweenTime = 1
        if (self.base_childGos and self.base_childGos["GameAction"]) then
            local canvasGroup = self.base_childGos["GameAction"]:GetComponent(ty.CanvasGroup)
            local _groupTweenFinishCall = function()
                self.mGroupTweener:Kill()
                self.mGroupTweener = nil
            end
            self.mGroupTweener = TweenFactory:canvasGroupAlphaTo(canvasGroup, 0, 1, tweenTime, nil, _groupTweenFinishCall)
        end

        if self.UIObject then
            local viewCanvasGroup = gs.GoUtil.AddComponent(self.UIObject, ty.CanvasGroup)
            local _viewTweenFinishCall = function()
                self.mViewTweener:Kill()
                self.mViewTweener = nil
            end
            self.mViewTweener = TweenFactory:canvasGroupAlphaTo(viewCanvasGroup, 0, 1, tweenTime, nil, _viewTweenFinishCall)
        end
    end
end

-- 背景层级错位缓动参数
function UpdateDoTweenBg(self)
    local gImgBgRect = self.gImgBg.gameObject:GetComponent(ty.RectTransform)
    local moveX = gImgBgRect.anchoredPosition.x - (self.mCurPosX - self.mRectContent.anchoredPosition.x) * self.mMultiple
    gs.TransQuick:LPosX(self.gImgBg.gameObject.transform, moveX)
    self.mCurPosX = self.mRectContent.anchoredPosition.x
end

function onClickEmptyHandler(self)
    self.mImgToucher:SetActive(false)
    self.isShowInfo = false
    self:setHideInfo(self.lastId, true)
end

function onClickOpenStageAwardViewHandler(self)
    for i, _ in ipairs(self.mStageAwardList) do
        self.mStageAwardList[i].stageProgress = self.mStageProgress
    end
    self.mIsRecAllStageAward = true
    GameDispatcher:dispatchEvent(EventName.OPEN_SATGEAWARD_VIEW, { self.mStageAwardList })
end

function onClickBackHallHandler(self)
    self:closeAll()
    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = LinkCode.Adventure })
end

function onUpdateHandler(self)
    self:updateStageListView(false)
end

function __onShowStageInfoHandler(self)
end

function __onHideStageInfoHandler(self)
end

-- 更新难易程度风格
function onUpdateMainMapStyleHandler(self, args)
    self:updateStyleView(false)
end

function setData(self, cusData)
    local chapterVo = cusData.chapterVo
    local stageVo = cusData.stageVo
    if chapterVo then
        self.mChapterVo = chapterVo
        self:updateView()
        if (stageVo) then
            self:ScrollToStageId(stageVo.stageId)
        end
    end
end

function updateView(self)
    if (self.mChapterVo.chapterId < 10) then
        self.mTxtChapter.text = "0" .. self.mChapterVo.chapterId
    else
        self.mTxtChapter.text = self.mChapterVo.chapterId
    end
    self.mTxtTitle.text = self.mChapterVo:getName()
    self:updateStyleView(true)
end

function updateStyleView(self, isInit)
    self:updateStageListView(isInit)
    local styleType = battleMap.FragmentMapManager:getStyle()
    if (styleType == battleMap.MainMapStyleType.Easy) then
        self.mImgStyle:SetImg(UrlManager:getPackPath("mainMap4/mainMap_02.png"), false)
    elseif (styleType == battleMap.MainMapStyleType.Difficulty) then
        self.mImgStyle:SetImg(UrlManager:getPackPath("mainMap4/mainMap_03.png"), false)
    elseif (styleType == battleMap.MainMapStyleType.SuperDifficulty) then
        self.mImgStyle:SetImg(UrlManager:getPackPath("mainMap4/mainMap_03.png"), false)
    end
end

function updateStageListView(self, isInit)
    self:removeItemList()
    self:removeStageAwardList()
    self.mCurStageAwardList = {}
    local scrollToStageId = nil
    local parentTrans = {}
    gs.TransQuick:SizeDelta01(self.mRectContent, 0)
    gs.TransQuick:UIPosX(self.mRectNodeStart, self:getScreenW() / 2)
    local list = self.mChapterVo:getStageVoList(battleMap.FragmentMapManager:getStyle())
    local stageVo = list[1]
    parentTrans[stageVo.stageId] = self.mNodeStart
    local params = {totalW = totalW, isHasSelect = false}
    self:generateStageItem(parentTrans, isInit, params)
    gs.TransQuick:SizeDelta01(self.mRectContent, params.totalW)
    local index = 1
    -- for k,v in pairs(list) do
    --     if #v.stageAwardList > 0 then
    --         v.awardIndex = index
    --         index = index + 1
    --         table.insert(self.mStageAwardList, v)
    --     end
    -- end
    
    -- 没有当前正在打的，即所有都打通关了，默认跳到最后一关
    if (scrollToStageId) then
        self:ScrollToStageId(scrollToStageId, not isInit)
    else
        local item = self.mItemList[#self.mItemList].item
        if (item) then
            self:ScrollToStageId(item:getData().stageId)
        end
    end
    for i = 1, #self.mItemList do
        local stageVo = self.mItemList[i].stageVo
        local _name = "tofight_" .. self.mChapterVo.chapterId .. "_" .. stageVo.stageId

        local item = self.mItemList[i].item
        local function _onDelayHandler()

            -- 此处很奇怪，退出到登录界面该计时器已经显示移除但是还会触发，故加此判断
            if (self.mActionFrameSn) then
                self:setGuideTrans(_name, item:getClickTrans())
            end
        end
        self.mActionFrameSn = LoopManager:addFrame(3, 1, self, _onDelayHandler)

    end

    if self.isShowInfo then
        self:infoPanelHide()
    end
    -- self:updateStageAward()
end

function generateStageItem(self, nextStages, isInit, params)
    for k,v in pairs(nextStages) do
        local stageVo = battleMap.FragmentMapManager:getStageVo(k)
        local parentTrans = v 
        local fixRotate = -v.parent.eulerAngles.z
        local item = battleMap.FragmentStageItem:create(parentTrans, stageVo, 1, false)
        item:getTrans().localEulerAngles = gs.Vector3(0, 0, fixRotate)
        local isCanFight = not battleMap.FragmentMapManager:isStagePass(stageVo.stageId) and battleMap.FragmentMapManager:isStageCanFight(stageVo.stageId)
        item:setSelectState(false)

        if (not isInit and self.m_stageId == stageVo.stageId) then
            item:setSelectState(true)
            scrollToStageId = stageVo.stageId
            params.isHasSelect = true
        elseif (not params.isHasSelect and isCanFight) then
            scrollToStageId = stageVo.stageId
        end
        if (not params.isHasSelect) then
            params.isHasSelect = isCanFight
        end

        table.insert(self.mItemList, {item = item, stageVo = stageVo})
        local nextTranses = item:getNextNodeTrans()
        if table.nums(nextTranses) > 0 then 
            self:generateStageItem(item:getNextNodeTrans(), isInit, params)
        else
            local starX, middleX, endX = self:getItemPosX(item)
            params.totalW = endX + self:getScreenW() / 20 * 13 --- self:getScreenW() / 2
        end
    end
end

function ScrollToStageId(self, stageId, isTween)
    self.lastId = stageId
    local scollOver = function()
        local stageItem = nil
        for k, v in pairs(self.mItemList) do
            local item = v.item
            if (item:getData().stageId == stageId) then
                stageItem = item
            end
        end
        if (stageItem) then
            local starX, middleX, endX = self:getItemPosX(stageItem)
            -- 默认移动到左边部分的中间
            local moveToX = 0
            if self.isShowInfo then
                moveToX = middleX - self:getScreenW() / 20 * 7
            else
                moveToX = middleX - self:getScreenW() / 2
            end
            local scrollerW = self.mScrollerTrans.rect.width
            local totalContentW = self.mRectContent.rect.width
            local pos = self.mRectContent.anchoredPosition
            if (totalContentW - moveToX <= scrollerW) then
                -- 移动到最后
                pos.x = -(totalContentW - scrollerW)
            else
                -- 移动到moveToX
                pos.x = -moveToX
            end
            if (isTween) then
                TweenFactory:move2LPosX(self.mRectContent, pos.x, 0.3)
            else
                self.mRectContent.anchoredPosition = pos
                self.mCurPosX = self.mRectContent.anchoredPosition.x
                -- 背景跟随缓动
                -- self:UpdateDoTweenBg()
            end
        end
    end
    if (self.mDelayFrameSn) then
        LoopManager:removeFrameByIndex(self.mDelayFrameSn)
        self.mDelayFrameSn = nil
    end
    self.mDelayFrameSn = LoopManager:addFrame(3, 1, self, scollOver)
end

function getScreenW(self)
    local w, h = ScreenUtil:getScreenSize(nil)
    return w
end

-- function updateStageAward(self)
--     self.mStageAwardNum = 0
--     self.mCurStageAwardList = {}
--     local isRecAllStageAward = true
--     if #self.mStageAwardItemList > 0 then
--         for i, _ in ipairs(self.mStageAwardItemList) do
--             self.mStageAwardItemList[i]:poolRecover()
--         end
--         self.mStageAwardItemList = {}
--     end

--     for _, stageVo in ipairs(self.mStageAwardList) do
--         local pressStageSort, sum = self.mChapterVo:getStage(battleMap.FragmentMapManager:getStyle())
--         self.mStageProgress = pressStageSort
--         if (self.mStageAwardNum == 0 and stageVo and (table.indexof(battleMap.FragmentMapManager:getReceivedStageAwardList(), stageVo.stageId) == false)) then
--             self.mStageAwardNum = stageVo.sort
--             if (self.mStageProgress >= 0) and (#self.mCurStageAwardList <= 0) then
--                 self.mCurStageAwardList = stageVo.stageAwardList
--             end
--         end
--     end
--     for _, stageAwardVo in ipairs(self.mStageAwardList) do
--         if table.indexof(battleMap.FragmentMapManager:getReceivedStageAwardList(), stageAwardVo.stageId) == false then
--             isRecAllStageAward = false
--         end
--     end
--     if isRecAllStageAward and #self.mStageAwardList > 0 then
--         self.mStageAwardNum = self.mStageProgress
--         self.mCurStageAwardList = self.mStageAwardList[#self.mStageAwardList].stageAwardList
--     end
--     for i, awardVo in ipairs(self.mCurStageAwardList) do
--         local tempGrid = PropsGrid:create(self.mNextAward, { awardVo[1], awardVo[2] }, 1, false)
--         tempGrid:setHasRec(isRecAllStageAward)
--         tempGrid:setBotScale(1.5)
--         table.insert(self.mStageAwardItemList, tempGrid)
--     end
--     logInfo("奖励列表长度" .. #self.mStageAwardItemList .. "奖励进度" .. self.mStageProgress)
--     self.mTxtStageNum.text = self.mStageProgress .. HtmlUtil:colorAndSize("/" .. self.mStageAwardNum, "82898Cff", 20)
--     self.mImgPro.fillAmount = self.mStageProgress / self.mStageAwardNum
--     self.mReceiveGroup:SetActive(false)
--     if self.mStageProgress >= self.mStageAwardNum and isRecAllStageAward == false then
--         RedPointManager:add(self.mImgPro.gameObject.transform, nil, -60.5, 55)
--     else
--         RedPointManager:remove(self.mImgPro.gameObject.transform)
--     end
-- end

function onClickStageItemHandler(self, stageVo)
    self:resFirstShow()
    local stageId = stageVo.stageId
    self:setSelectStage(stageId)
    local function _openStage()
        GameDispatcher:dispatchEvent(EventName.OPEN_MAIN_STAGE_INFO, { stageId = stageId })
        self:setHideInfo(stageId, false)
        self:infoPanelShow(stageId)
    end
    -- 已通关/未通关
    if battleMap.FragmentMapManager:isStagePass(stageId) or battleMap.FragmentMapManager:isStageCanFight(stageId) then
        _openStage()
    else
        local isActive, needPassStageId = stageVo:isActive()
        local needStageVo = battleMap.FragmentMapManager:getStageVo(needPassStageId)
        -- 未解锁
        gs.Message.Show(_TT(31717, battleMap.getMainMapStyleName(needStageVo.styleType), needStageVo.indexName))
    end
end

-- 设置关卡选中状态
function setSelectStage(self, stageId)
    battleMap.FragmentMapManager:setCurSelectMapStageId(stageId)
    for k, v in pairs(self.mItemList) do
        local item = v.item
        item:setSelectState(false)
        if (item:getData().stageId == stageId) then
            if battleMap.FragmentMapManager:isStagePass(stageId) or battleMap.FragmentMapManager:isStageCanFight(stageId) then
                item:setSelectState(true)
            else
                if (item:getData():isActive() == true) then
                    item:setSelectState(false)
                    self.mItemList[k - 1].item:setSelectState(true)
                end
                gs.Message.Show(_TT(44211))
                return
            end
        end
    end
    self:ScrollToStageId(stageId, true)
end

function setHideInfo(self, stageId, InfoHide)
    -- 隐藏详细信息面板
    if InfoHide then
        self.mInfoAnimator:SetTrigger("exit")
        if not self.mShowSn and self.MainMapStageInfoPanel.activeSelf == true then
            self.mShowSn = LoopManager:addTimer(AnimatorUtil.getAnimatorClipTime(self.mInfoAnimator, "MainMapStageInfoPanel_Exit"), 1, self, function()
                local panel = self.MainMapStageInfoPanel
                if(panel) then 
                    panel:SetActive(false)
                end
                LoopManager:removeTimerByIndex(self.mShowSn)
                self.mShowSn = nil
            end)
            for k, v in pairs(self.mItemList) do
                local item = v.item
                if (item:getData().stageId == stageId) then
                    item:setShowInfo(true, false)
                    item:setSelectState(false)
                else
                    item:setShowInfo(true, false)
                end
            end
        end
    else
        if stageId ~= self.m_stageId then
            if self.MainMapStageInfoPanel.activeSelf == true then
                self.mInfoAnimator:SetTrigger("show")
            end
        end
        self.mImgToucher:SetActive(true)
        for k, v in pairs(self.mItemList) do
            local item = v.item
            if (item:getData().stageId == stageId) then
                item:setShowInfo(true, true)
            else
                item:setShowInfo(false, false)
            end
        end
    end
end

function getItemPosX(self, item)
    local w, h = item:getSize()
    local relativePos = item:getRelativePos(self.mGroupContent)
    local starX = relativePos.x
    local middleX = starX + w / 2
    local endX = starX + w
    return starX, middleX, endX
end

function removeItemList(self)
    for i = #self.mItemList, 1, -1 do
        local item = self.mItemList[i].item
        item:poolRecover()
        table.remove(self.mItemList, i)
    end
end

function removeStageAwardList(self)
    if #self.mStageAwardList > 0 then
        self.mStageAwardList = {}
    end
    if #self.mStageAwardItemList > 0 then
        for i, _ in ipairs(self.mStageAwardItemList) do
            self.mStageAwardItemList[i]:poolRecover()
        end
        self.mStageAwardItemList = {}
    end
end

function onClickClose(self)
    self:onClickEmptyHandler()
    battleMap.FragmentMapManager:setCurSelectMapStageId(nil)
    super.onClickClose(self)
end

-- 玩家关闭所有窗口的c#回调
function onCloseAllCall(self)
    self:onClickEmptyHandler()
    super.onCloseAllCall(self)
end

function close(self)
    super.close(self)
    GameDispatcher:dispatchEvent(EventName.MAIN_STAGE_LIST_PANEL_CLOSING, {})
end

-----------------------------------------------------------------------------Info面板内容----------------------------------------------------------------------------------
function __infoPanelConfigUI(self)
    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mGroupStamina = self:getChildGO("TextCost")
    self.mTxtCost = self:getChildGO("TextCost"):GetComponent(ty.Text)
    self.mTxtStageId = self:getChildGO("mTxtStageId"):GetComponent(ty.Text)
    self.mScroller = self:getChildGO("Scroller"):GetComponent(ty.ScrollRect)
    self.mImgCost = self:getChildGO("ImgCost"):GetComponent(ty.AutoRefImage)
    self.mTxtStageDes = self:getChildGO("TextStageDes"):GetComponent(ty.Text)
    self.mTxtStageName = self:getChildGO("mTxtStageName"):GetComponent(ty.Text)
    self.mTxtAwardTitle = self:getChildGO("mTxtAwardTitle"):GetComponent(ty.Text)

    self.MainMapStageInfoPanel = self:getChildGO("MainMapStageInfoPanel")
    self.mInfoAnimator = self.MainMapStageInfoPanel:GetComponent(ty.Animator)
    self.mScrollContent = self.mScroller.content

    self.mBtnFight = self:getChildGO("mBtnFight")
    self.mBtnTxt = self:getChildGO("BtnTxt"):GetComponent(ty.Text)
    self.mBtnGiveUp = self:getChildGO("mBtnGiveUp")
    self:setBtnLabel(self.mBtnGiveUp, 49009, "放弃")
    self.mRectDetail = self:getChildGO("GroupDetail"):GetComponent(ty.RectTransform)
    self.mBtnCose = self:getChildGO("mBtnClose")

    self:getChildGO("mTxtRecommandFormation"):GetComponent(ty.Text).text = "推荐阵容"
    self.mFormationIconNode = self:getChildTrans("mFormationIconNode")
    self:getChildGO("mTxtRecommand"):GetComponent(ty.Text).text = _TT(3073)
    self.mTxtRecommandLv = self:getChildGO("mTxtRecommandLv"):GetComponent(ty.Text)
    self.mBtnAnemyFormation = self:getChildGO("mBtnAnemyFormation")

    self.mRecommandFormation = self:getChildGO("mFormationIconNode")
    -- self.mRecommandLv = self:getChildGO("mTxtRecommand")
    self.mMoneyItem = self:getChildTrans("mMoneyItem")
    self.mBtnInfoClose = self:getChildGO("mBtnClose")
    self.mTxtStageDes.gameObject:SetActive(true)
end

function infoPanelAddAllUIEvent(self)
    self:addUIEvent(self.mBtnFight, self.onFightHandler)
    self:addUIEvent(self.mBtnGiveUp, self.onGiveUpHandler)
    self:addUIEvent(self.mBtnClose, self.onClickEmptyHandler)
    self:addUIEvent(self.mBtnInfoClose,self.onClickEmptyHandler)

    self:addUIEvent(self.mBtnAnemyFormation, self.onOpenFormationPanel)
end

function onOpenFormationPanel(self)
    if self.m_stageVo.type == battleMap.MainMapStageType.Story then
        gs.Message.Show(_TT(85052))
        return
    end
    local dupVo = battleMap.FragmentMapManager:getStageVo(self.lastId)
    GameDispatcher:dispatchEvent(EventName.OPEN_FORMATION_PREVIEW, { dupVo = dupVo })
end

function infoPanelHide(self)
    self.isShowInfo = false
    self:recoverEleGrid()
    self:setHideInfo(self.lastId, true)
    self:ScrollToStageId(self.lastId, true)
end

function infoPanelShow(self, cusStageId)
    if self.isShowInfo == false then
        if self.MainMapStageInfoPanel.activeSelf == true then
            if self.mShowSn then
                LoopManager:removeTimerByIndex(self.mShowSn)
                self.mShowSn = nil
            end
            self.MainMapStageInfoPanel:SetActive(false)
        end
        self.MainMapStageInfoPanel:SetActive(true)
    end
    self.isShowInfo = true
    self.m_stageId = cusStageId
    self.m_stageVo = battleMap.FragmentMapManager:getStageVo(cusStageId)
    self.mTxtStageId.text = self.m_stageVo.indexName
    self.mTxtStageName.text = self.m_stageVo:getName()
    self.mTxtStageDes.text = self.m_stageVo.des
    local costTid = MoneyTid.ANTIEPIDEMIC_SERUM_TID
    local costCount = self.m_stageVo.costStamina
    self.mImgCost:SetImg(MoneyUtil.getMoneyIconUrlByTid(costTid), true)
    self.mTxtCost.text = MoneyUtil.getMoneyCountByTid(MoneyTid.ANTIEPIDEMIC_SERUM_TID) >= costCount and HtmlUtil:color(costCount, "474C50ff") or HtmlUtil:color(costCount, "BD2A2AFF")

    if self.m_stageVo.type == battleMap.MainMapStageType.Story then
        self.mBtnTxt.text = _TT(26)
    else
        self.mBtnTxt.text = _TT(27)
    end

    -- local exploreStageId = battleMap.FragmentMapManager:getCurExploreStageId()
    -- if (exploreStageId == self.m_stageVo.stageId) then
    --     self.mBtnGiveUp:SetActive(true)
    -- else
    --     self.mBtnGiveUp:SetActive(false)
    -- end

    if not self.mMoneyBatItem then 
        self.mMoneyBatItem = MoneyItem:poolGet()
        self.mMoneyBatItem:setData(self.mMoneyItem, { tid = 10, frontType = 2 })
        self.mMoneyBatItem:getAdaptaTrans().localPosition = gs.VEC3_ZERO
    end

    -- gs.TransQuick:SizeDelta01(self:getChildTrans("mBtnFight"), btnFightWidth)
    self.mTxtAwardTitle.text = _TT(71311)
    self:__updateItem()
    self:onUpdateMainMapStyleHandler()
    self:setGuideTrans("tofight_challenge", self.mBtnFight.transform)
    self:updateSuggest()
end

function __updateItem(self)
    self:__removeItem()
    local isPass = battleMap.FragmentMapManager:isStagePass(self.m_stageVo.stageId)
    self.mGroupStamina:SetActive((not isPass) and (self.m_stageVo.costStamina ~= 0))
    if (not isPass or not self.m_stageVo.awardPackId) then
        local awardList = AwardPackManager:getAwardListById(self.m_stageVo.firstAwardId)
        for i = 1, #awardList do
            local vo = awardList[i]
            local propsGrid = PropsGrid:create(self.mScrollContent, { vo.tid, vo.num }, 0.95, false)
            table.insert(self.m_awardList, propsGrid)
            propsGrid:setHasRec(isPass == true)
            propsGrid:setIconGray(isPass == true)
        end
    else
        local awardList = AwardPackManager:getAwardListById(self.m_stageVo.awardPackId)
        for i = 1, #awardList do
            local vo = awardList[i]
            local propsGrid = PropsGrid:create(self.mScrollContent, { vo.tid, vo.num }, 0.95, false)
            table.insert(self.m_awardList, propsGrid)
            propsGrid:setHasRec(isPass == true)
            propsGrid:setIconGray(isPass == true)
        end
    end
    gs.TransQuick:UIPosX(self.mScrollContent, 0)
end

function __removeItem(self)
    if (self.m_awardList) then
        for i = #self.m_awardList, 1, -1 do
            local item = self.m_awardList[i]
            item:poolRecover()
        end
    end
    self.m_awardList = {}
end

-- 更新难易程度风格
function onUpdateMainMapStyleHandler(self, style)
    local styleType = battleMap.FragmentMapManager:getStyle()
    if (styleType == battleMap.MainMapStyleType.Easy) then
    elseif (styleType == battleMap.MainMapStyleType.Difficulty) then
    end
end

function updateSuggest(self)
    self:recoverEleGrid()
    local suggestEle = self.m_stageVo.suggestEle
    for i=1,#suggestEle do
        local item = SimpleInsItem:create(self.mImgEleBg, self.mFormationIconNode, "elegridMainStage")
        local type = item:getChildGO("mImgEleType"):GetComponent(ty.AutoRefImage)
        type:SetImg(UrlManager:getHeroEleTypeIconUrl(suggestEle[i]), false)
        table.insert(self.mWeaknessGrid, item)
    end
end

function onFightHandler(self)
    local isPass = battleMap.FragmentMapManager:isStagePass(self.m_stageVo.stageId)
    local costStamina = isPass and 0 or self.m_stageVo.costStamina
    local isEnough = stamina.StaminaManager:checkStamina(PreFightBattleType.Fragment, nil, costStamina, self.__sendFight, self)
end

function onGiveUpHandler(self)
    UIFactory:alertMessge(_TT(71312), true, function()
        self:infoPanelHide()
        local exploreStageId = battleMap.FragmentMapManager:getCurExploreStageId()
        if (exploreStageId > 0) then
            local mapConfigVo = mainExplore.MainExploreSceneManager:getDupMapConfigVo(DupType.DUP_MAIN_LINE, exploreStageId)
            GameDispatcher:dispatchEvent(EventName.REQ_RESET_MAIN_EXPLORE_MAP, { mapId = mapConfigVo.mapId })
        end
    end, _TT(1), -- "确定"
    nil, true, function()
    end, _TT(2), -- "取消"
    _TT(4341), -- "提示"
    nil, RemindConst.XXX)
end

function __sendFight(self)
    self.MainMapStageInfoPanel:SetActive(false)
    self:close()

    GameDispatcher:dispatchEvent(EventName.CLOSE_MAIN_STAGE_LIST_PANEL, {})

    local curIsPass = battleMap.FragmentMapManager:isStagePass(self.m_stageVo.stageId)
    local callOpenStageListPanel = function()
        -- 纯剧情播放完毕回到对应章节的关卡列表界面，或者打开阵型后又返回来
        local chapterVo, stageVo = battleMap.FragmentMapManager:getChapterVoByStageId(self.m_stageVo.stageId)
        if (chapterVo and stageVo) then
            -- 第一章最后一关是剧情领取奖励不走结算，永繁说是一次性要改的，以后他要再改就打死他
            if (chapterVo.chapterId == 1 and chapterVo:getEndStageId(battleMap.FragmentMapManager:getStyle()) == stageVo.stageId and not curIsPass) then
                GameDispatcher:dispatchEvent(EventName.OPEN_FRAGMENT_STAGEVIEW, { chapterVo = chapterVo})
            else
                GameDispatcher:dispatchEvent(EventName.OPEN_FRAGMENT_STAGEVIEW, { chapterVo = chapterVo})
            end
        end
    end

    local formatoinCallFun = function(callReason)
        if (callReason == formation.CALL_FUN_REASON.PLAYER_CLOSE) then
            callOpenStageListPanel()
        end
    end

    if (self.m_stageVo.type == battleMap.FragmentMapStageType.Story) then
        local finishCall = function(isSuccess, storyRo)
            if (isSuccess) then
                if (not battleMap.FragmentMapManager:isStagePass(self.m_stageVo.stageId)) then
                    GameDispatcher:dispatchEvent(EventName.REQ_DUP_STORY_FINISH, { battleType = PreFightBattleType.Fragment, fieldId = self.m_stageVo.stageId })
                end
                callOpenStageListPanel()
                guide.GuideCondition:condition14()
            else
                gs.Message.Show(_TT(49007))
            end
        end
        storyTalk.StoryTalkManager:justStoryNoFight(PreFightBattleType.Fragment, self.m_stageVo.stageId, finishCall)
    else
        -- 是否有支援我方的怪物id列表
        local supportMonterList = self.m_stageVo.supportMonterList
        if (supportMonterList and #supportMonterList > 0) then
            formation.checkFormationFight(PreFightBattleType.Fragment, DupType.DUP_MAIN_LINE, self.m_stageId, formation.TYPE.MAIN_SUPPORT, nil, supportMonterList, formatoinCallFun)
        else
            formation.checkFormationFight(PreFightBattleType.Fragment, DupType.DUP_MAIN_LINE, self.m_stageId, nil, nil, nil, formatoinCallFun)
        end
    end
end

function recoverEleGrid(self)
    for k,v in pairs(self.mWeaknessGrid) do
        v:poolRecover()
    end
    self.mWeaknessGrid = {}
end
return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(71312):	"放弃则会探索失败，且当前探索进度都将重置\n是否继续"
	语言包: _TT(71311):	"首通预览"
	语言包: _TT(71310):	"地图探索"
]]