--[[
    1.1副本活动
]] module("mainActivity.ActiveDupStageListPanel", Class.impl(View))
UIRes = UrlManager:getUIPrefabPath("mainActivity/ActiveDupStageListPanel.prefab")
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
-- blurTweenTime = 0.5
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
isAdapta = 1 -- 是否开启适配刘海 0 否 1 是
isShowCloseAll = 0 -- 是否显示导航按钮

-- 构造函数
function ctor(self)
    super.ctor(self)
    local w, h = ScreenUtil:getScreenSize()
    self:setSize(w, h)
    self:setBg("Activecopy_bg_01.jpg", false, "mainActivity")
    self:setUICode(LinkCode.ActiveDup)
    self:setTxtTitle(_TT(85002))
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
    -- 阶段性奖励列表
    self.mStageAwardList = {}
    -- 当前的关卡进度
    self.mStageProgress = 0
    -- 阶段性奖励数量
    self.mStageAwardNum = 0
    -- 当前阶段性奖励列表
    self.mCurStageAwardList = {}
    -- 是否已领取完奖励
    self.mIsRecAllStageAward = true
    -- 阶段性奖励item
    self.mStageAwardItemList = {}
    self.isShowInfo = false
    -- 当前移动位置
    self.mCurPosX = 0
    -- 上一次移动位置
    self.mLastPosX = 0
    -- 移动倍数 倍数越小 速度越慢 取值区间 0~1
    self.mMultiple = 0.2

    self.mWeaknessGrid = {}
    self.mStarItemList = {}

    -- 当前是是否攻坚模式
    self.mIsHallModel = false
end

function configUI(self)
    self.mBtnStage = self:getChildGO("mBtnStage")
    self.mImageStage = self.mBtnStage:GetComponent(ty.AutoRefImage)
    self.mImgEffect = self:getChildGO("ImEffect")
    self.mNodeStart = self:getChildTrans("NodeStart")
    self.mImgToucher = self:getChildGO("mImgToucher")
    self.mGroupContent = self:getChildTrans("Content")
    self.mNextAward = self:getChildTrans("mNextAward")
    self.mReceiveGroup = self:getChildGO("mReceiveGroup")
    self.mScrollerTrans = self:getChildTrans("Scroll View")
    self.mCompleteGroup = self:getChildGO("mCompleteGroup")
    self.mNextAwardGroup = self:getChildGO("mNextAwardGroup")
    self.mTxtTips = self:getChildGO("mTxtTips"):GetComponent(ty.Image)
    self.mRectNodeStart = self.mNodeStart:GetComponent(ty.RectTransform)
    self.mRectContent = self.mGroupContent:GetComponent(ty.RectTransform)
    self.mTxtTitle = self:getChildTrans("TextTitle"):GetComponent(ty.Text)
    self.mTxtStageNum = self:getChildGO("mTxtStageNum"):GetComponent(ty.Text)
    self.mTxtChapter = self:getChildTrans("TextChapter"):GetComponent(ty.Text)
    self.mEventTrigger = self.mScrollerTrans:GetComponent(ty.LongPressOrClickEventTrigger)
    self.mImgEleBg = self:getChildGO("mImgEleBg")
    self:__infoPanelConfigUI()
    self.mBtnNormal = self:getChildGO("mBtnNormal")
    self.mBtnHard = self:getChildGO("mBtnHard")
    self.mBtnHell = self:getChildGO("mBtnHell")
    self:updateBtnView()
end

-- 设置文本标题
function setTxtTitle(self, title)
    super.setTxtTitle(self, title)
    self:setGuideTrans("funcTips_guide_View_CloseAlll", self.gBtnCloseAll.transform)
end

function active(self, args)
    super.active(self, args)
    self.base_childGos["MoneyBar"]:SetActive(false)
    MoneyManager:setMoneyTidList()
    mainActivity.ActiveDupManager:addEventListener(mainActivity.ActiveDupManager.EVENT_DUP_UPDATE, self.onUpdateHandler,
        self)
    GameDispatcher:addEventListener(EventName.CHANGE_MAIN_MAP_STYLE, self.onUpdateMainMapStyleHandler, self)
    GameDispatcher:addEventListener(EventName.SET_SELECT_MAINACTIVITY_ITEM, self.onSetSelectHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_MAINACTIVITY_STAGE_LIST, self.onUpdateMainStageListHnalder, self)
    mainActivity.ActiveDupManager:addEventListener(mainActivity.ActiveDupManager.EVENT_STAGE_AWARD_UPDATE,
        self.updateStageAward, self)
    if self.mNowSelectType ~= nil then
        args = self.mNowSelectType
    end
    self:setData(args)
    self.needSmallerStage = sysParam.SysParamManager:getValue(1901)
    self.needTime = sysParam.SysParamManager:getValue(1902)

    if self.needTime ~= 999 and mainActivity.ActiveDupManager:isStagePass(self.needSmallerStage) == nil then
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
    if self.isShowInfo == false and storyTalk.StoryTalkManager:getCurHasStory() == false and
        guide.GuideManager:getCurHasGuide() == false and gs.PopPanelManager.HasSubPopActive() == false then
        self.isAddTime = self.isAddTime + 1
        if self.isAddTime >= self.needTime and self.isShowFirst == false then
            self.isShowFirst = true
        end
    else
        self:resFirstShow()
    end
end

function resFirstShow(self)
    self.isShowFirst = false
    self.isAddTime = 0
end

function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    mainActivity.ActiveDupManager:removeEventListener(mainActivity.ActiveDupManager.EVENT_DUP_UPDATE,
        self.onUpdateHandler, self)
    GameDispatcher:removeEventListener(EventName.CHANGE_MAIN_MAP_STYLE, self.onUpdateMainMapStyleHandler, self)
    GameDispatcher:removeEventListener(EventName.SET_SELECT_MAINACTIVITY_ITEM, self.onSetSelectHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_MAINACTIVITY_STAGE_LIST, self.onUpdateMainStageListHnalder, self)
    mainActivity.ActiveDupManager:removeEventListener(mainActivity.ActiveDupManager.EVENT_STAGE_AWARD_UPDATE,
        self.updateStageAward, self)
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
    RedPointManager:remove(self.mImageStage.transform)
    self:recoverStarItem()
    if self.mMoneyBatItem then
        self.mMoneyBatItem:poolRecover()
        self.mMoneyBatItem = nil
    end
end

function initViewText(self)
    -- self.mTxtTips.text = _TT(60)--关卡进度
end

function addAllUIEvent(self)
    self:addUIEvent(self.mImgToucher, self.onClickEmptyHandler)
    self:addUIEvent(self.mBtnStage, self.onClickOpenStageAwardViewHandler)
    self:addUIEvent(self.mBtnNormal, self.onClickNormal)
    self:addUIEvent(self.mBtnHard, self.onClickClickHard)
    self:addUIEvent(self.mBtnHell, self.onClickHell)
    self:infoPanelAddAllUIEvent()
end

-- 玩家点击关闭
function onClickClose(self)
    super.onClickClose(self)
    self.mNowSelectType = nil
end

-- 玩家关闭所有窗口的c#回调
function onCloseAllCall(self)
    super.onCloseAllCall(self)
    self.mNowSelectType = nil
end

-- 试玩
function onClickNormal(self)
    -- gs.Message.Show("敬请关注!")

    local btn = self.mBtnList[mainActivity.ActiveDupStyleType.Easy]
    if btn.isLock then
        gs.Message.Show(btn.lockDes)
        return
    end
    mainActivity.ActiveDupManager:setStyle(mainActivity.ActiveDupStyleType.Easy)
    self:setData(mainActivity.ActiveDupStyleType.Easy)
end

-- 困难
function onClickClickHard(self)
    -- local btn = self.mBtnList[mainActivity.ActiveDupStyleType.Easy]
    -- if btn.isLock then
    --     gs.Message.Show( btn.lockDes)
    --     return
    -- end
    -- mainActivity.ActiveDupManager:setStyle(mainActivity.ActiveDupStyleType.Easy)
    -- self:setData(mainActivity.ActiveDupStyleType.Easy)
    local btn = self.mBtnList[mainActivity.ActiveDupStyleType.Difficulty]
    if btn.isLock then
        gs.Message.Show(btn.lockDes)
        return
    end
    local newestDupId = mainActivity.ActiveDupManager:getNewestDupId(mainActivity.ActiveDupStyleType.Easy)
    if newestDupId >= mainActivity.ActiveDupManager:getFirstDupByStype(mainActivity.ActiveDupStyleType.Easy) then
        mainActivity.ActiveDupManager:setStyle(mainActivity.ActiveDupStyleType.Difficulty)
        self:setData(mainActivity.ActiveDupStyleType.Difficulty)
    else
        gs.Message.Show("通关普通关卡后开启")
    end
end

-- 超难
function onClickHell(self)
    local btn = self.mBtnList[mainActivity.ActiveDupStyleType.Hard]
    if btn.isLock then
        gs.Message.Show(btn.lockDes)
        return
    end
    local newestDupId = mainActivity.ActiveDupManager:getNewestDupId(mainActivity.ActiveDupStyleType.Difficulty)
    if newestDupId >= mainActivity.ActiveDupManager:getFirstDupByStype(mainActivity.ActiveDupStyleType.Difficulty) then
        mainActivity.ActiveDupManager:setStyle(mainActivity.ActiveDupStyleType.Hard)
        self:setData(mainActivity.ActiveDupStyleType.Hard)
    else
        gs.Message.Show("通关困难关卡后开启")
    end
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
            self.mGroupTweener = TweenFactory:canvasGroupAlphaTo(canvasGroup, 0, 1, tweenTime, nil,
                _groupTweenFinishCall)
        end

        if self.UIObject then
            local viewCanvasGroup = gs.GoUtil.AddComponent(self.UIObject, ty.CanvasGroup)
            local _viewTweenFinishCall = function()
                self.mViewTweener:Kill()
                self.mViewTweener = nil
            end
            self.mViewTweener = TweenFactory:canvasGroupAlphaTo(viewCanvasGroup, 0, 1, tweenTime, nil,
                _viewTweenFinishCall)
        end
    end
end

-- 背景层级错位缓动参数
function UpdateDoTweenBg(self)
    local gImgBgRect = self.gImgBg.gameObject:GetComponent(ty.RectTransform)
    local moveX = gImgBgRect.anchoredPosition.x - (self.mCurPosX - self.mRectContent.anchoredPosition.x) *
                      self.mMultiple
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
    GameDispatcher:dispatchEvent(EventName.OPEN_ACTIVEDUPAWARD_VIEW)
end

function onClickBackHallHandler(self)
    self:closeAll()
    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {
        linkId = LinkCode.Adventure
    })
end

function onUpdateHandler(self)
    self:updateStageListView(false)
end

function updateBtnView(self)
    self.mBtnList = {}

    local activeData = mainActivity.MainActivityManager:getMainActivityVoById(activity.ActivityId.NomalLevel)
    local normal = self.mBtnNormal.transform:Find("mStateNormal")
    local select = self.mBtnNormal.transform:Find("mStateSelect")
    local lock = self.mBtnNormal.transform:Find("mStateLock")
    local normalName = normal:Find("mTxtNormal"):GetComponent(ty.Text)
    local selectName = select:Find("mTxtNormal"):GetComponent(ty.Text)
    local lockText = lock:Find("mTxtLockTime"):GetComponent(ty.Text)
    normalName.text = activeData:getName()
    selectName.text = activeData:getName()
    lockText.text = activeData:getLockDec()
    select.gameObject:SetActive(false)

    if mainActivity.ActiveDupManager:getCanRecAllByStyle(mainActivity.ActiveDupStyleType.Easy) then
        RedPointManager:add(self.mBtnNormal.transform, nil, 71.6,23.3)
    else
        RedPointManager:remove(self.mBtnNormal.transform)
    end

    if not activeData:getIsCanOpen() then
        lock.gameObject:SetActive(true)
        normal.gameObject:SetActive(false)
    else
        lock.gameObject:SetActive(false)
        normal.gameObject:SetActive(true)
    end
    self.mBtnList[mainActivity.ActiveDupStyleType.Easy] = {
        item = self.mBtnNormal,
        normal = normal,
        select = select,
        lock = lock,
        isLock = not activeData:getIsCanOpen(),
        lockDes = activeData:getLockDec()
    }

    local activeData = mainActivity.MainActivityManager:getMainActivityVoById(activity.ActivityId.DifficultyLevel)
    local normal = self.mBtnHard.transform:Find("mStateNormal")
    local select = self.mBtnHard.transform:Find("mStateSelect")
    local lock = self.mBtnHard.transform:Find("mStateLock")
    local normalName = normal:Find("mTxtNormal"):GetComponent(ty.Text)
    local selectName = select:Find("mTxtNormal"):GetComponent(ty.Text)
    local lockText = lock:Find("mTxtLockTime"):GetComponent(ty.Text)
    normalName.text = activeData:getName()
    selectName.text = activeData:getName()
    lockText.text = activeData:getLockDec()
    select.gameObject:SetActive(false)
    if mainActivity.ActiveDupManager:getCanRecAllByStyle(mainActivity.ActiveDupStyleType.Difficulty) then
        RedPointManager:add(self.mBtnHard.transform, nil, 71.6,23.3)
    else
        RedPointManager:remove(self.mBtnHard.transform)
    end

    if not activeData:getIsCanOpen() then
        lock.gameObject:SetActive(true)
        normal.gameObject:SetActive(false)
    else
        lock.gameObject:SetActive(false)
        normal.gameObject:SetActive(true)
    end
    self.mBtnList[mainActivity.ActiveDupStyleType.Difficulty] = {
        item = self.mBtnHard,
        normal = normal,
        select = select,
        lock = lock,
        isLock = not activeData:getIsCanOpen(),
        lockDes = activeData:getLockDec()
    }

    local activeData = mainActivity.MainActivityManager:getMainActivityVoById(activity.ActivityId.HellLevel)
    local normal = self.mBtnHell.transform:Find("mStateNormal")
    local select = self.mBtnHell.transform:Find("mStateSelect")
    local lock = self.mBtnHell.transform:Find("mStateLock")
    local normalName = normal:Find("mTxtNormal"):GetComponent(ty.Text)
    local selectName = select:Find("mTxtNormal"):GetComponent(ty.Text)
    local lockText = lock:Find("mTxtLockTime"):GetComponent(ty.Text)
    normalName.text = activeData:getName()
    selectName.text = activeData:getName()
    lockText.text = activeData:getLockDec()
    select.gameObject:SetActive(false)
    if mainActivity.ActiveDupManager:getCanRecAllByStyle(mainActivity.ActiveDupStyleType.Hard) then
        RedPointManager:add(self.mBtnHell.transform, nil, 71.6,23.3)
    else
        RedPointManager:remove(self.mBtnHell.transform)
    end
    if not activeData:getIsCanOpen() then
        lock.gameObject:SetActive(true)
        normal.gameObject:SetActive(false)
    else
        lock.gameObject:SetActive(false)
        normal.gameObject:SetActive(true)
    end
    self.mBtnList[mainActivity.ActiveDupStyleType.Hard] = {
        item = self.mBtnHell,
        normal = normal,
        select = select,
        lock = lock,
        isLock = not activeData:getIsCanOpen(),
        lockDes = activeData:getLockDec()
    }
end

-- 更新难易程度风格
function onUpdateMainMapStyleHandler(self, args)
    self:updateStyleView(false)
end

function setData(self, cusData)
    self.mNowSelectType = cusData

    local prefixVersion = download.ResDownLoadManager:getServerVersionValue(gs.AssetSetting.PrefixVersionKey)
    
    if not StorageUtil:getBool1(prefixVersion .. "mainActivity" .. self.mNowSelectType) then
        StorageUtil:saveBool1(prefixVersion .. "mainActivity" .. self.mNowSelectType,true)
        GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
        self:updateBtnView()
    end

    mainActivity.ActiveDupManager:setStyle(self.mNowSelectType)
    -- local chapterVo = cusData.chapterVo
    self.stageList = mainActivity.ActiveDupManager:getStageListByType(self.mNowSelectType)
    self.mStageAwardList = mainActivity.ActiveDupManager:getAllStepConfig()
    self:updateView()
    for k, v in pairs(self.mBtnList) do
        v.normal.gameObject:SetActive(k ~= self.mNowSelectType and v.isLock == false)
        v.select.gameObject:SetActive(k == self.mNowSelectType)
    end
    self:infoPanelHide()
end

function updateView(self)
    self:updateStyleView(true)
end

function updateStyleView(self, isInit)
    self:updateStageListView(isInit)
    local styleType = mainActivity.ActiveDupManager:getStyle()
    if (styleType == mainActivity.ActiveDupStyleType.Easy) then
        self:setTxtTitle(_TT(92005)) -- 自陷落地
        self:setBg("Activecopy_bg_01.jpg", false, "mainActivity")
    elseif (styleType == mainActivity.ActiveDupStyleType.Difficulty) then
        self:setTxtTitle(_TT(92006)) -- 至深处
        self:setBg("Activecopy_bg_02.jpg", false, "mainActivity")
    elseif (styleType == mainActivity.ActiveDupStyleType.Hard) then
        self:setTxtTitle(_TT(92007)) -- 至深处
        self:setBg("Activecopy_bg_03.jpg", false, "mainActivity")
    end
end

function updateStageListView(self, isInit)
    self:removeItemList()
    self:removeStageAwardList()
    self.mCurStageAwardList = {}
    local parentTrans = {}
    gs.TransQuick:SizeDelta01(self.mRectContent, 0)
    gs.TransQuick:UIPosX(self.mRectNodeStart, self:getScreenW() / 2)
    local stageVo = self.stageList[1]
    parentTrans[stageVo.stageId] = self.mNodeStart
    local params = {
        totalW = {}
    }
    self:generateStageItem(parentTrans, isInit, params)
    if #params.totalW > 0 then
        table.sort(params.totalW, function(last, next)
            return last > next
        end)
        gs.TransQuick:SizeDelta01(self.mRectContent, params.totalW[1])
    else
        gs.TransQuick:SizeDelta01(self.mRectContent, self:getScreenW())
    end
    if self.m_stageId then
        self:setSelectStage(self.m_stageId)
        self:infoPanelShow(self.m_stageId)
    end
    -- 没有当前正在打的，即所有都打通关了，默认跳到最后一关
    local m_dupIndex = self.lastId or mainActivity.ActiveDupManager:getNewestDupId()
    if (m_dupIndex) then
        self:ScrollToStageId(m_dupIndex, not isInit)
    else
        local item = self.mItemList[#self.mItemList].item
        if (item) then
            self:ScrollToStageId(item:getData().stageId)
        end
    end
    self:updateStageAward()
end

function generateStageItem(self, nextStages, isInit, params)
    for k, v in pairs(nextStages) do
        local stageVo = mainActivity.ActiveDupManager:getStageVo(k)
        local parentTrans = v
        local fixRotate = -v.parent.eulerAngles.z
        local item = mainActivity.ActiveDupStageItem:create(parentTrans, stageVo, 1, false)
        item:getTrans().localEulerAngles = gs.Vector3(0, 0, fixRotate)
        item:setSelectState(false)

        -- if ( self.m_stageId == stageVo.stageId) then
        -- end
        table.insert(self.mItemList, {
            item = item,
            stageVo = stageVo
        })
        local nextTranses = item:getNextNodeTrans()
        if table.nums(nextTranses) > 0 then

            self:generateStageItem(item:getNextNodeTrans(), isInit, params)
        else
            local starX, middleX, endX = self:getItemPosX(item)
            table.insert(params.totalW, endX + self:getScreenW() / 20 * 13)
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

function updateStageAward(self)
    local showStepStar = mainActivity.ActiveDupManager:getNoRecStepStar(self.mNowSelectType)
    self.mStageAwardNum = mainActivity.ActiveDupManager:getAllStarNum()
    self.mTxtStageNum.text = self.mStageAwardNum .. "/" .. showStepStar -- self.mStageProgress --.. HtmlUtil:colorAndSize("/" .. self.mStageAwardNum, "82898Cff", 20)
    self.mTxtTips.color = gs.ColorUtil.GetColor(mainActivity.ActiveDupManager:getCanRecAll() and "ffe76fff" or
                                                    "ffffffff")
    -- self.mImageStage:SetImg(mainActivity.ActiveDupManager:getCanRecAll() and UrlManager:getPackPath("mainActivity/Activelevels_icon_03.png") or UrlManager:getPackPath("mainActivity/Activelevels_icon_02.png"))
    self.mImgEffect:SetActive(mainActivity.ActiveDupManager:getCanRecAll())
    if mainActivity.ActiveDupManager:getCanRecAll() then
        RedPointManager:add(self.mImageStage.transform, nil, 40, 40)
    else
        RedPointManager:remove(self.mImageStage.transform)
    end

    self:updateBtnView()
end

-- 设置关卡选中状态
function setSelectStage(self, stageId)
    mainActivity.ActiveDupManager:setCurSelectMapStageId(stageId)
    for k, v in pairs(self.mItemList) do
        local item = v.item
        item:setSelectState(false)
        if (item:getData().stageId == stageId) then
            if mainActivity.ActiveDupManager:isStagePass(stageId) or
                mainActivity.ActiveDupManager:isStageCanFight(stageId) then
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
        self.m_stageId = nil
        self.mInfoAnimator:SetTrigger("exit")
        if not self.mShowSn and self.MainMapStageInfoPanel.activeSelf == true then
            self.mShowSn = LoopManager:addTimer(0.3, 1, self, function()
                local panel = self.MainMapStageInfoPanel
                if (panel) then
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

-- 玩家点击关闭
function onClickClose(self)
    self:onClickEmptyHandler()
    mainActivity.ActiveDupManager:setCurSelectMapStageId(nil)
    super.onClickClose(self)
end

-- 玩家关闭所有窗口的c#回调
function onCloseAllCall(self)
    self:onClickEmptyHandler()
    super.onCloseAllCall(self)
end

function close(self)
    super.close(self)
    -- GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {
    --     linkId = LinkCode.MainActivity
    -- })
    -- GameDispatcher:dispatchEvent(EventName.MAIN_STAGE_LIST_PANEL_CLOSING, {})
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
    self.MainMapStageInfoPanel = self:getChildGO("ActiveDupStageInfoPanel")
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
    self.mMoneyItem = self:getChildTrans("mMoneyItem")
    self.mBtnInfoClose = self:getChildGO("mBtnClose")
    self.mTxtStageDes.gameObject:SetActive(true)
    self.mBgImg = self:getChildGO("mBgImg"):GetComponent(ty.AutoRefImage)
    self.mStarItem = self:getChildGO("mStarItem")
    self.mGroupStar = self:getChildTrans("mGroupStar")
    self.ScrollDes = self:getChildGO("ScrollDes")

    self.mIconTitle = self:getChildGO("mIconTitle"):GetComponent(ty.AutoRefImage)

    self.mBtnModelNomal = self:getChildGO("mBtnModelNomal")
    self.mBtnModelHall = self:getChildGO("mBtnModelHall")
    self.mImgLock = self:getChildGO("mImgLock")

end

function onChangeModel(self)
    local url = UrlManager:getPackPath("mainActivity/Activecopy_info_01.png")
    local hellUrl = UrlManager:getPackPath("mainActivity/Activecopy_info_02.png")
    self.mIconTitle:SetImg(self.mIsHallModel and hellUrl or url)

    local iconIndex = 1
    iconIndex = iconIndex + self.m_stageVo.styleType + (self.mIsHallModel and 3 or 0)
    self.mBgImg:SetImg(UrlManager:getPackPath("mainActivity/Activecopy_pnl_" .. iconIndex .. ".jpg"), false)
    self:__updateItem()
end

function infoPanelAddAllUIEvent(self)
    self:addUIEvent(self.mBtnFight, self.onFightHandler)
    self:addUIEvent(self.mBtnGiveUp, self.onGiveUpHandler)
    self:addUIEvent(self.mBtnClose, self.onClickEmptyHandler)
    self:addUIEvent(self.mBtnInfoClose, self.onClickEmptyHandler)

    self:addUIEvent(self.mBtnAnemyFormation, self.onOpenFormationPanel)
    self:addUIEvent(self.mBtnModelNomal, self.onClickNomalModel)
    self:addUIEvent(self.mBtnModelHall, self.onClickHallModel)

end

function onClickNomalModel(self)
    self.mIsHallModel = false
    self:updateBtnModel()
end

function onClickHallModel(self)
    local starList = mainActivity.ActiveDupManager:getStarListByStage(self.m_stageVo.stageId)
    if #starList < 3 then
        -- gs.Message.Show("通关三星后解锁攻坚模式")
        gs.Message.Show(_TT(92028))
    else
        self.mIsHallModel = true
        self:updateBtnModel()
    end
end

function updateBtnModel(self)
    if #self.m_stageVo.starList > 3 then
        self.mBtnModelNomal:SetActive(self.mIsHallModel)
        self.mBtnModelHall:SetActive(not self.mIsHallModel)
        local code = self.mIsHallModel and 92027 or 1359 -- 攻坚挑战，挑战
        self:setBtnLabel(self.mBtnFight, code)
        self:onChangeModel()
    else
        self.mBtnModelNomal:SetActive(false)
        self.mBtnModelHall:SetActive(false)
    end
end

function onOpenFormationPanel(self)
    if self.m_stageVo.type == mainActivity.MainMapStageType.Story then
        gs.Message.Show("该关卡不支持查看！")
        return
    end
    local dupVo = mainActivity.ActiveDupManager:getStageVo(self.lastId)
    if self.mIsHallModel then
        dupVo = mainActivity.ActiveDupManager:getStageVoByHell(self.lastId)
    end
    GameDispatcher:dispatchEvent(EventName.OPEN_FORMATION_PREVIEW, {
        dupVo = dupVo
    })
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
    self.m_stageVo = mainActivity.ActiveDupManager:getStageVo(cusStageId)
    self.mFormationIconNode.gameObject:SetActive(self.m_stageVo.type ~= mainActivity.MainMapStageType.Story)
    self.mTxtStageId.text = self.m_stageVo.indexName
    self.mTxtStageName.text = self.m_stageVo:getName()
    self.mTxtStageDes.text = self.m_stageVo.des

    self.mIsHallModel = false
    self.mBtnModelNomal:SetActive(true)
    self.mBtnModelHall:SetActive(false)
    local iconIndex = 1
    iconIndex = iconIndex + self.m_stageVo.styleType + (self.mIsHallModel and 3 or 0)
    self.mBgImg:SetImg(UrlManager:getPackPath("mainActivity/Activecopy_pnl_" .. iconIndex .. ".jpg"), false)

    local costTid = MoneyTid.ANTIEPIDEMIC_SERUM_TID
    local costCount = self.m_stageVo.costStamina
    self.mImgCost:SetImg(MoneyUtil.getMoneyIconUrlByTid(costTid), true)
    self.mTxtCost.text = MoneyUtil.getMoneyCountByTid(MoneyTid.ANTIEPIDEMIC_SERUM_TID) >= costCount and
                             HtmlUtil:color(costCount, "474C50ff") or HtmlUtil:color(costCount, "BD2A2AFF")

    if self.m_stageVo.type == mainActivity.MainMapStageType.Story then
        self.mBtnTxt.text = _TT(26)
    else
        self.mBtnTxt.text = _TT(27)
    end

    local exploreStageId = mainActivity.ActiveDupManager:getCurExploreStageId()
    if (exploreStageId == self.m_stageVo.stageId) then
        self.mBtnGiveUp:SetActive(true)
    else
        self.mBtnGiveUp:SetActive(false)
    end

    if not self.mMoneyBatItem then
        self.mMoneyBatItem = MoneyItem:poolGet()
        self.mMoneyBatItem:setData(self.mMoneyItem, {
            tid = 10,
            frontType = 1
        })
        self.mMoneyBatItem:getAdaptaTrans().localPosition = gs.VEC3_ZERO
    end

    self.mTxtAwardTitle.text = _TT(71311)
    self:__updateItem()
    self:onUpdateMainMapStyleHandler()
    self:setGuideTrans("tofight_challenge", self.mBtnFight.transform)
    self:updateSuggest()
    self:recoverStarItem()
    if self.m_stageVo.type == mainActivity.MainMapStageType.Story then
        self.ScrollDes:SetActive(true)
        self.mGroupStar.gameObject:SetActive(false)
        self.mBtnAnemyFormation:SetActive(false)
        self.mBtnModelNomal:SetActive(false)
        self.mBtnModelHall:SetActive(false)
    else
        self.ScrollDes:SetActive(false)
        self.mGroupStar.gameObject:SetActive(true)
        self.mBtnAnemyFormation:SetActive(true)
        local starList = mainActivity.ActiveDupManager:getStarListByStage(self.m_stageVo.stageId)
        for k, v in pairs(self.m_stageVo.starList) do
            local item = SimpleInsItem:create(self.mStarItem, self.mGroupStar, "StarItem")
            local starImg = item:getChildGO("mImgStar"):GetComponent(ty.Image)
            local mDesc = item:getChildGO("mDesc"):GetComponent(ty.Text)
            local starConfig = mainActivity.ActiveDupManager:getStarConfigData(v)
            mDesc.text = _TT(starConfig.des)
            local color = "82898cff"
            if table.indexof(starList, v) then
                color = "ffe76fff"
            end
            starImg.color = gs.ColorUtil.GetColor(color)
            table.insert(self.mStarItemList, item)
        end
        -- local isShowHall = #self.m_stageVo.starList > 3 and #starList >= 3
        self:updateBtnModel()
        self.mImgLock:SetActive(#starList < 3)
    end
end

function __updateItem(self)
    self:__removeItem()
    local baseStagePass = mainActivity.ActiveDupManager:isStagePass(self.m_stageVo.stageId)
    local isPass = baseStagePass
    self.mGroupStamina:SetActive((self.m_stageVo.costStamina ~= 0) and not baseStagePass)
    if (not baseStagePass or not self.m_stageVo.awardPackId) then

        local awardId = self.m_stageVo.firstAwardId
        if self.mIsHallModel then
            awardId = self.m_stageVo.raidAward
            local starList = mainActivity.ActiveDupManager:getStarListByStage(self.m_stageVo.stageId)
            isPass = baseStagePass and #starList == 4
        end

        local tempList = AwardPackManager:getAwardListById(awardId)
        local awardList = table.copy(tempList)

        if dup.DupMainManager:getIsMatchActivityMoney(PreFightBattleType.ActiveDup) and self.m_stageVo.costStamina > 0 and
            not baseStagePass then
            local propVo = props.PropsManager:getPropsVo({
                tid = sysParam.SysParamManager:getValue(SysParamType.ACTIVE_DEADLINE_PROP),
                num = self.m_stageVo.costStamina
            })
            propVo.state = 3
            table.insert(awardList, propVo)
        end

        for i = 1, #awardList do
            local vo = awardList[i]
            local propsGrid = PropsGrid:create(self.mScrollContent, {vo.tid, (vo.num or vo.count)}, 0.95, false)
            table.insert(self.m_awardList, propsGrid)
            propsGrid:setHasRec(isPass == true)
            propsGrid:setIconGray(isPass == true)
            local isDeadlineProp = sysParam.SysParamManager:getValue(SysParamType.ACTIVE_DEADLINE_PROP)
            if isDeadlineProp == vo.tid then
                propsGrid:setIsDeadline(true)
            else
                propsGrid:setIsFirstPass(true)
            end
        end
    else
        local awardId = self.m_stageVo.awardPackId
        if self.mIsHallModel then
            awardId = self.m_stageVo.raidAward
            local starList = mainActivity.ActiveDupManager:getStarListByStage(self.m_stageVo.stageId)
            isPass = baseStagePass and #starList == 4
        end
        local tempList = AwardPackManager:getAwardListById(awardId)
        local awardList = table.copy(tempList)

        if dup.DupMainManager:getIsMatchActivityMoney(PreFightBattleType.ActiveDup) and self.m_stageVo.costStamina > 0 and
            not baseStagePass then
            local propVo = props.PropsManager:getPropsVo({
                tid = sysParam.SysParamManager:getValue(SysParamType.ACTIVE_DEADLINE_PROP),
                num = self.m_stageVo.costStamina
            })
            propVo.state = 3
            table.insert(awardList, propVo)
        end

        for i = 1, #awardList do
            local vo = awardList[i]
            local propsGrid = PropsGrid:create(self.mScrollContent, {vo.tid, (vo.num or vo.count)}, 0.95, false)
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
    local styleType = mainActivity.ActiveDupManager:getStyle()
    if (styleType == mainActivity.ActiveDupStyleType.Easy) then
    elseif (styleType == mainActivity.ActiveDupStyleType.Difficulty) then
    end
end

function updateSuggest(self)
    self:recoverEleGrid()
    local suggestEle = self.m_stageVo.suggestEle
    for i = 1, #suggestEle do
        local item = SimpleInsItem:create(self.mImgEleBg, self.mFormationIconNode, "elegridMainStage")
        local type = item:getChildGO("mImgEleType"):GetComponent(ty.AutoRefImage)
        type:SetImg(UrlManager:getHeroEleTypeIconUrl(suggestEle[i]), false)
        table.insert(self.mWeaknessGrid, item)
    end
end

function onFightHandler(self)
    local isPass = mainActivity.ActiveDupManager:isStagePass(self.m_stageVo.stageId)
    local costStamina = isPass and 0 or self.m_stageVo.costStamina
    local isEnough = stamina.StaminaManager:checkStamina(PreFightBattleType.MainMapStage, nil, costStamina,
        self.__sendFight, self)
end

function onGiveUpHandler(self)
    UIFactory:alertMessge(_TT(71312), true, function()
        self:infoPanelHide()
        local exploreStageId = mainActivity.ActiveDupManager:getCurExploreStageId()
        if (exploreStageId > 0) then
            local mapConfigVo = mainExplore.MainExploreSceneManager:getDupMapConfigVo(DupType.DUP_MAIN_LINE,
                exploreStageId)
            GameDispatcher:dispatchEvent(EventName.REQ_RESET_MAIN_EXPLORE_MAP, {
                mapId = mapConfigVo.mapId
            })
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
    local curIsPass = mainActivity.ActiveDupManager:isStagePass(self.m_stageVo.stageId)
    local callOpenStageListPanel = function()
        -- 纯剧情播放完毕回到对应章节的关卡列表界面，或者打开阵型后又返回来
        GameDispatcher:dispatchEvent(EventName.OPEN_ACTIVEDUP_STAGE_PANEL, mainActivity.ActiveDupManager:getStyle())
    end

    local formatoinCallFun = function(callReason)
        if (callReason == formation.CALL_FUN_REASON.PLAYER_CLOSE) then
            callOpenStageListPanel()
        end
    end

    if (self.m_stageVo.type == mainActivity.MainMapStageType.Story) then
        local finishCall = function(isSuccess, storyRo)
            if (isSuccess) then
                if (not mainActivity.ActiveDupManager:isStagePass(self.m_stageVo.stageId)) then
                    self.isShowInfo = false
                    GameDispatcher:dispatchEvent(EventName.REQ_DUP_STORY_FINISH, {
                        battleType = PreFightBattleType.ActiveDup,
                        fieldId = self.m_stageVo.stageId
                    })
                end
                callOpenStageListPanel()
                guide.GuideCondition:condition14()
            else
                gs.Message.Show(_TT(49007))
            end
        end
        storyTalk.StoryTalkManager:justStoryNoFight(PreFightBattleType.ActiveDup, self.m_stageVo.stageId, finishCall)
    else
        local battType = PreFightBattleType.ActiveDup
        if self.mIsHallModel then
            battType = PreFightBattleType.ActiveDupHell
        end
        local formationType = formation.TYPE.ACTIVEDUP
        if self.m_stageVo.isNormal == 1 then
            formationType = formation.TYPE.NORMAL
        end

        -- 是否有支援我方的怪物id列表
        local supportMonterList = self.m_stageVo.supportMonterList
        if (supportMonterList and #supportMonterList > 0) then
            formation.checkFormationFight(battType, DupType.ActiveDup, self.m_stageId, formationType, nil,
                supportMonterList, formatoinCallFun)
        else
            formation.checkFormationFight(battType, DupType.ActiveDup, self.m_stageId, formationType, nil, nil,
                formatoinCallFun)
        end
    end
end

function recoverStarItem(self)
    for k, v in pairs(self.mStarItemList) do
        v:poolRecover()
    end
    self.mStarItemList = {}
end

function recoverEleGrid(self)
    for k, v in pairs(self.mWeaknessGrid) do
        v:poolRecover()
    end
    self.mWeaknessGrid = {}
end

return _M

--[[ 替换语言包自动生成，请勿修改！
语言包: _TT(71312):"放弃则会探索失败，且当前探索进度都将重置\n是否继续"
语言包: _TT(71311):"首通预览"
语言包: _TT(71310):"地图探索"
]]
