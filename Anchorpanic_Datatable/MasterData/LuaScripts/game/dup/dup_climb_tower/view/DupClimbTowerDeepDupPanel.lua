--[[ 
-----------------------------------------------------
@filename       : DupClimbTowerDeepDupPanel
@Description    : 爬塔副本区内副本页
@date           : 2021-01-28 17:13:57
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("dup.DupClimbTowerDeepDupPanel", Class.impl(View))
UIRes = UrlManager:getUIPrefabPath("domainSurvey/DupClimbTowerDeepDupPanel.prefab")
panelType = -1
isBlur = 0
isAdapta = 1 --是否开启适配刘海
destroyTime = -1 -- 自动销毁时间-1默认 0即时销毁 999不销毁
--构造函数
function ctor(self)
    super.ctor(self)
    self:UICode()
end

function UICode(self)
    self:setUICode(LinkCode.ChellengeDeepTower)
end

function initData(self)
    self.mItemList = {}
    self.skillItem = {}
    self.mFirstAwardList = {}
    self.isShowInfo = false
    self.mSelectItem = nil
    self.mDomainItem = nil
    self.isBack = true
    self.mAwardList = {}
end

function getAdaptaTrans(self)
    return self:getChildTrans("mGroupClose")
end

function configUI(self)
    -- self.mGoToucher = self:getChildGO('ImgToucher')
    self.mNodeStart = self:getChildTrans('NodeStart')
    self.mGroupContent = self:getChildTrans('Content')
    self.mDomainNode = self:getChildTrans('mDomainNode')
    self.mScrollerTrans = self:getChildTrans('Scroll View')
    self.mRectContent = self.mGroupContent:GetComponent(ty.RectTransform)
    self.mRectNodeStart = self.mNodeStart:GetComponent(ty.RectTransform)

    -- self.mBtnClose = self:getChildGO("mBtnClose")
    self.mBtnDupClose = self:getChildGO("mBtnDupClose")
    self.mBtnCloseAll = self:getChildGO("mBtnCloseAll")
    -- self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)

    self.mReceive = self:getChildGO('Receive')
    -- self.mBtnAward = self:getChildGO('BtnAward')
    self.mComplete = self:getChildGO('Complete')
    self.mAwardNode = self:getChildTrans("mGroupAward")
    self.mTextBtnTip = self:getChildGO("TextBtnTip"):GetComponent(ty.Text)
    self.mImgAward = self:getChildGO('ImgAward'):GetComponent(ty.AutoRefImage)

    self:infoPanelConfigUI()
end

function active(self, args)
    super.active(self, args)
    self:setAdapta()
    MoneyManager:setMoneyTidList()
    GameDispatcher:addEventListener(EventName.UPDATE_CLIMB_TOWER_PANEL, self.__onUpdatePanelHandler, self)
    GameDispatcher:addEventListener(EventName.FIVE_RESET, self.closeAll, self)
    if args.areaVo then
        self.mAreaVo = args.areaVo
        self.nowMsgInfo = dup.DupClimbTowerManager:getDeepDetail(self.mAreaVo.id)
        self:__updateView(true)
    end

    if (dup.DupClimbTowerManager:getIsInDeepMainPanel()) then
        -- GameDispatcher:dispatchEvent(EventName.CLIMB_TOWER_CHANGE, false, true)
    end
    self.isBack = true
end

function clickClose(self)
    self.lastId = nil
    self:close()
end

function closeAll(self)
    self.lastId = nil
    self.isBack = false
    self:close()
    GameDispatcher:dispatchEvent(EventName.CLOSE_ALL_CLIMB)
end

function deActive(self)
    super.deActive(self)
    if (self.isBack) then
        GameDispatcher:dispatchEvent(EventName.CLIMB_TOWER_CHANGE, true)
    end
    MoneyManager:setMoneyTidList()
    -- self:__infoPanelHide()
    GameDispatcher:removeEventListener(EventName.UPDATE_CLIMB_TOWER_PANEL, self.__onUpdatePanelHandler, self)
    GameDispatcher:removeEventListener(EventName.FIVE_RESET, self.closeAll, self)
    self:recoverDomainItem(self)
    self:__removeItemList()
    self:recoverAward()
    if (self.mDelayFrameSn) then
        LoopManager:removeFrameByIndex(self.mDelayFrameSn)
        self.mDelayFrameSn = nil
    end
    RedPointManager:remove(self.mTextBtnTip.transform)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnDupClose, self.clickClose, self:getCloseSoundPath())
    self:addUIEvent(self.mBtnCloseAll, self.openNavigationLink, self:getCloseSoundPath())
    self:__infoPanelAddAllUIEvent()
end

function openNavigationLink(self)
    if not self.mNavigation then
        self.mNavigation = link.NavigationLink:new()
        self.mNavigation:setCloseAllCall(self.closeAll, self)
    end
    self.mNavigation:setParentTrans(self:getChildTrans("mGroupNavigation"), 0)
end

function initViewText(self)
    -- self.mTxtTitle.text = _TT(4534)
    self.mTxtAwardTitle.text = _TT(44212)
    self.mNeed.text = _TT(20121)
    self.mTextEnvironmentNothing:GetComponent(ty.Text).text = _TT(20122)
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

function onClickAwardHandler(self)
end

function __onClickEmptyHandler(self)
end

function __onUpdatePanelHandler(self)
    self:__updateStageListView(false)
end

function __onShowStageInfoHandler(self)
end

function __onHideStageInfoHandler(self)
    if self.mSelectItem then
        self.mSelectItem:setSelectState(false)
        self.mSelectItem = nil
    end
end

function __updateView(self, isInit)
    self:recoverDomainItem(self)
    self.mDomainItem = dup.DupClimbTowerDeepAreaItem:create(self.mDomainNode, { areaVo = self.mAreaVo }, 1, false)
    RedPointManager:remove(self.mDomainItem:getTrans())
    self:__updateStageListView(isInit)
    self:updateAwardNode()
end

function __updateStageListView(self, isInit)
    self:__removeItemList()
    local scrollToDupId = nil
    local hasSelect = false
    local totalH = 0
    local parentTrans = self.mNodeStart
    local list = self.mAreaVo:dups()
    
    local nowDupId = self.nowMsgInfo.maxDup
    if(nowDupId ~= nil) then 
        scrollToDupId = nowDupId
        hasSelect = true
    elseif (self.lastId and table.indexof(list, self.lastId)) then
        scrollToDupId = self.lastId
        hasSelect = true
    end

    for i = 1, #list do
        local dupId = list[i]
        local item = dup.DupClimbTowerDeepDupItem:create(parentTrans, { data = dup.DupClimbTowerManager:getDeepDupVo(dupId), msgInfo = self.nowMsgInfo }, 1, false)
        local isCanFight
        if self.nowMsgInfo.curDup ~= 0 then
            isCanFight = dupId <= self.nowMsgInfo.curDup
        else
            isCanFight = dupId <= nowDupId
        end
        if(isInit and isCanFight) then 
            scrollToDupId = dupId
        elseif (not hasSelect and isCanFight) then
            scrollToDupId = dupId

        end
        local function __onClickDupItemHandler()
            -- 已通关/未通关
            if self.nowMsgInfo.curDup == 0 or dupId <= self.nowMsgInfo.curDup then
                self:__infoPanelShow(dupId)
                self:__setSelectDup(dupId)
            else
                -- 未解锁
                gs.Message.Show(_TT(44211))
            end
        end

        item:setCallBack(self, function() __onClickDupItemHandler() end)
        table.insert(self.mItemList, item)
        parentTrans = item:getNextNodeTrans()
        if (i == #list) then
            local _, _, endY = self:__getItemPosY(item)
            totalH = endY + self:getScreenH() * 0.5
            gs.TransQuick:SizeDelta02(self.mRectContent, totalH)
            if (scrollToDupId) then
                self:__scrollToDupId(scrollToDupId, not isInit)
            else
                -- 移动到最后
                local item = self.mItemList[#self.mItemList]
                if (item) then
                    self:__scrollToDupId(item:getDupVo().dupId)
                end
            end
            self:__infoPanelShow(self.nowMsgInfo.curDup == 0 and self.nowMsgInfo.maxDup or self.nowMsgInfo.curDup)
            self:__setSelectDup(self.nowMsgInfo.curDup == 0 and self.nowMsgInfo.maxDup or self.nowMsgInfo.curDup)
        end
    end
end

function updateAwardNode(self)
    self:recoverAward()
    self.mComplete:SetActive(false)
    self.mReceive:SetActive(false)
    if (dup.DupClimbTowerManager:canRecDeepAward(self.mAreaVo.id) == 1) then
        local hasRec = dup.DupClimbTowerManager:hasRecChapterAward(self.mAreaVo.id)
        if (not hasRec) then
            self.mComplete:SetActive(false)
            self.mReceive:SetActive(true)
            RedPointManager:add(self.mTextBtnTip.transform, nil, -57, 48)
        else
            self.mComplete:SetActive(true)
            self.mReceive:SetActive(false)
            RedPointManager:remove(self.mTextBtnTip.transform)
            return
        end
    end
end

function __scrollToDupId(self, dupId, isTween)
    self.lastId = dupId
    local stageItem = nil
    for k, item in pairs(self.mItemList) do
        if (item:getDupVo().dupId == dupId) then
            stageItem = item
        end
    end
    if (stageItem) then
        local starY, middleY, endY = self:__getItemPosY(stageItem)
        -- 默认移动到左边部分的中间
        local moveToY = middleY  +  self:getScreenH() / 2
        local scrollerH = self.mScrollerTrans.rect.height
        local totalContentH = self.mRectContent.rect.height
        local pos = self.mRectContent.anchoredPosition
        -- if (totalContentH - moveToY <= scrollerH * 0.5) then
        --     -- 移动到最后
        --     pos.y = -totalContentH
        -- else
            -- 移动到moveToX
        pos.y = -moveToY
        -- end
        if (isTween) then
            TweenFactory:move2LPosY(self.mRectContent, pos.y, 0.3)
        else
            self.mRectContent.anchoredPosition = pos
            self.mCurPosY = self.mRectContent.anchoredPosition.y
            -- self:UpdateDoTweenBg()
        end
    end
end

function getScreenH(self)
    local w, h = ScreenUtil:getScreenSize(nil)
    return h
end

function getSelectItem(self)
    return self.mSelectItem
end

-- 设置关卡选中状态
function __setSelectDup(self, dupId)
    for k, item in pairs(self.mItemList) do
        if (item:getDupVo().dupId == dupId) then
            item:setSelectState(true)
            self.mSelectItem = item
        else
            item:setSelectState(false)
        end
    end
    self:__scrollToDupId(dupId, true)
end

function __getItemPosY(self, item)
    local w, h = item:getSize()
    local relativePos = item:getRelativePos(self.mGroupContent)
    local starY = relativePos.y
    local middleY = starY + h / 2
    local endY = starY + h
    return starY, middleY, endY
end

function recoverDomainItem(self)
    if self.mDomainItem then
        self.mDomainItem:poolRecover()
    end
    self.mDomainItem = nil
end

function __removeItemList(self)
    for i = #self.mItemList, 1, -1 do
        local item = self.mItemList[i]
        item:poolRecover()
        table.remove(self.mItemList, i)
    end
end

-----------------------------------------------------------------------------Info面板内容----------------------------------------------------------------------------------
function infoPanelConfigUI(self)
    self.mStageInfoPanel = self:getChildGO("StageInfoPanel")
    self.mTxtAwardTitle = self:getChildGO("TextAwardTitle"):GetComponent(ty.Text)
    self.mNeed = self:getChildGO("mNeed"):GetComponent(ty.Text)
    self.mNeedHeroTxt = self:getChildGO("mNeedHeroTxt"):GetComponent(ty.Text)

    -- self.mTxtStageId = self:getChildGO("TextStageId"):GetComponent(ty.Text)
    self.mTxtStageName = self:getChildGO("TextStageName"):GetComponent(ty.Text)
    self.mTxtStageDes = self:getChildGO("TextStageDes"):GetComponent(ty.Text)
    self.mScroller = self:getChildGO("Scroller"):GetComponent(ty.ScrollRect)
    self.mScrollContent = self.mScroller.content
    -- self.ScrollerEnvironment = self:getChildGO("ScrollerEnvironment"):GetComponent(ty.ScrollRect)
    -- self.EnvironmentContent = self.ScrollerEnvironment.content
    self.mGoReceiveSign = self:getChildGO("ReceiveSign")
    self.mGoEnvironmentSign = self:getChildGO("EnvironmentSign")
    self.mBtnFight = self:getChildGO("BtnFight")
    self.mRectDetail = self:getChildGO("GroupDetail"):GetComponent(ty.RectTransform)
    self.mTxtChallengeTimes = self:getChildGO("mTxtChallengeTimes"):GetComponent(ty.Text)
    -- self.mBtnClose = self:getChildGO("mBtnClose")

    self.mTextEnvironmentNothing = self:getChildGO("TextEnvironmentNothing")
    self.mAni = self.mStageInfoPanel:GetComponent(ty.Animator)

    self:setGuideTrans("survey_tofight_challenge", self.mBtnFight.transform)
end

function __infoPanelAddAllUIEvent(self)
    self:addUIEvent(self.mBtnFight, self.__onFightHandler)
end

function __infoPanelHide(self)
    self:__onHideStageInfoHandler()
    if (self.isShowInfo) then
        self.mAni:SetTrigger("show")
    end

    self.animaState = self.mAni:GetCurrentAnimatorStateInfo(0)
    self.isShowInfo = false
    self.hideLoop = LoopManager:addTimer(self.animaState.length * 0.3, 1, self, self.closeInfoViewPanel)
    self:__scrollToDupId(self.lastId, true)
end

function closeInfoViewPanel(self)
    LoopManager:removeTimerByIndex(self.hideLoop)
    if not self.isShowInfo then
        self.mStageInfoPanel:SetActive(false)
    else
        self.mAni:SetTrigger("show")
    end
    self.hideLoop = nil
end

function __infoPanelShow(self, cusDupId)
    self:__onShowStageInfoHandler()
    if self.isShowInfo and cusDupId ~= self.lastId then
        self.mAni:SetTrigger("show")
    end
    self.isShowInfo = true
    self.mDupId = cusDupId
    self.mDupVo = dup.DupClimbTowerManager:getDeepDupVo(cusDupId)
    -- self.mTxtStageId.text = ""
    self.mTxtStageName.text = self.mDupVo:getName()
    self.mTxtStageDes.text = self.mDupVo:getDescribe()
    local allCount = dup.DupClimbTowerManager:getDeepAreaData()[self.mDupVo.areaId].maxTime
    local resCount = dup.DupClimbTowerManager:getDeepDetail(self.mDupVo.areaId).times
    local txt = _TT(24515, resCount, allCount)
    if(resCount == 0) then 
        txt = _TT(24517, resCount, allCount)
    end
    self.mTxtChallengeTimes.text = txt
    self:__updateItem()
end

function __updateItem(self)
    self.mBtnFight:SetActive(self.mDupVo.dupId >= self.nowMsgInfo.curDup and self.nowMsgInfo.curDup ~= 0)
    self:__removeItem()
    for i = 1, #self.mDupVo.firstAward do
        local firstAward = PropsGrid:create(self.mScrollContent, { self.mDupVo.firstAward[i].tid, self.mDupVo.firstAward[i].num }, 1, false)
        firstAward:setIsFirstPass(true)
        if self.nowMsgInfo.curDup == 0 or self.mDupVo.dupId < self.nowMsgInfo.curDup then
            firstAward:setIconGray(true)
            firstAward:setHasRec(true)
        end
        table.insert(self.mFirstAwardList, firstAward)
    end

    local text = ""
    for i = 1, #self.mDupVo.eleType do 
        local count = self.mDupVo.eleTypeNum[i]
        if(i ~= 0 and count ~= nil) then 
            local color, name = hero.getHeroTypeName(self.mDupVo.eleType[i])
            text = text .. _TT(24516, name, count)
        end
    end
    if(text == "") then 
        text = _TT(24508) --"-无应激反应-"
    end
    self.mNeedHeroTxt.text = text
    gs.TransQuick:UIPosX(self.mScrollContent, 0)
end

function __removeItem(self)
    if (self.skillItem) then
        for i = #self.skillItem, 1, -1 do
            local item = self.skillItem[i]
            item:poolRecover()
        end
    end
    self.skillItem = {}

    if (self.mFirstAwardList) then
        for i = #self.mFirstAwardList, 1, -1 do
            local item = self.mFirstAwardList[i]
            item:poolRecover()
        end
    end
    self.mFirstAwardList = {}
end

function recoverAward(self)
    for i = 1, #self.mAwardList do
        self.mAwardList[i]:poolRecover()
    end
    self.mAwardList = {}
end

function __onFightHandler(self)
    self.isBack = false
    self:close()
    local formatoinCallFun = function(callReason)
        if (callReason == formation.CALL_FUN_REASON.PLAYER_CLOSE) then
            GameDispatcher:dispatchEvent(EventName.OPEN_DEEP_TOWER_DUP_PANEL, { areaVo = self.mAreaVo })
        end
    end
    if (dup.DupClimbTowerManager:getDeepDetail(self.mDupVo.areaId).times <= 0) then 
        gs.Message.Show("剩余挑战次数不足")
    end
    formation.checkFormationFight(PreFightBattleType.ElementTower, nil, self.mDupId, formation.TYPE.ELEMENT, self.mAreaVo.id, nil, formatoinCallFun)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]