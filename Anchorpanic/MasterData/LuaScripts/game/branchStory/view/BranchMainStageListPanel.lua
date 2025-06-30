module("branchStory.BranchMainStageListPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("branchStory/BranchMainStageListPanel.prefab")
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    local w, h = ScreenUtil:getScreenSize()
    self:setSize(w, h)
    self:setTxtTitle(_TT(44203))
    self:setBg("dup_mainmap_bg_1.jpg", false, "dup5")
    --self.gImgBg:GetComponent(ty.AutoRefImage):SetImgType(2)
    --gs.TransQuick:SizeDelta01(self.gImgBg.gameObject.transform, self:getScreenW() * 3)
    self:UICode()
end

function UICode(self)
    self:setUICode(LinkCode.BranchStoryMain)
end

function getAdaptaTrans(self)
    return self.base_childTrans["mGroupTop"]
end

function initData(self)
    self.mItemList = {}
    self.isShowInfo = false
    self.mSelectItem = nil
    --当前移动位置
    self.mCurPosX = 0
    --上一次移动位置
    self.mLastPosX = 0
    --移动倍数 倍数越小 速度越慢 取值区间 0~1
    self.mMultiple = 0.2
    self.mAwardList = {}
    self.mDupAwardList = {}
end

function configUI(self)
    self.mImgToucher = self:getChildGO('mImgToucher')
    self.mScrollerTrans = self:getChildTrans('Scroll View')
    self.mGroupContent = self:getChildTrans('Content')
    self.mRectContent = self.mGroupContent:GetComponent(ty.RectTransform)
    self.mNodeStart = self:getChildTrans('NodeStart')
    self.mRectNodeStart = self.mNodeStart:GetComponent(ty.RectTransform)
    self.mTextTitle = self:getChildTrans("TextTitle"):GetComponent(ty.Text)
    self.mTextChapter = self:getChildTrans("TextChapter"):GetComponent(ty.Text)
    self.mImgRight = self:getChildGO("mImgRight"):GetComponent(ty.AutoRefImage)
    self.mEventTrigger = self.mScrollerTrans:GetComponent(ty.LongPressOrClickEventTrigger)
    self.mBtnAward = self:getChildGO('BtnAward')
    self.mImgAward = self:getChildGO('ImgAward'):GetComponent(ty.AutoRefImage)
    self.mTextBtnTip = self:getChildGO("TextBtnTip"):GetComponent(ty.Text)
    self.mReceive = self:getChildGO('Receive')
    self.mComplete = self:getChildGO('Complete')
    self.mAwardNode = self:getChildTrans("mGroupAward")
    self:infoPanelConfigUI()
end

function active(self, args)
    super.active(self, args)
    self.type = args.type
    MoneyManager:setMoneyTidList()
    GameDispatcher:addEventListener(EventName.UPDATE_BRANCH_STORY_PANEL, self.__onUpdatePanelHandler, self)
    GameDispatcher:addEventListener(EventName.RES_REC_BRANCH_EQUIP_AWARD, self.updateAwardNode, self)
    
    self:setData(args)
end

function deActive(self)
    super.deActive(self)
    self:__infoPanelHide()
    self:recoverAward()
    -- self.mEventTrigger.onBeginDrag:RemoveAllListeners()
    GameDispatcher:removeEventListener(EventName.UPDATE_BRANCH_STORY_PANEL, self.__onUpdatePanelHandler, self)
    GameDispatcher:removeEventListener(EventName.RES_REC_BRANCH_EQUIP_AWARD, self.updateAwardNode, self)
    self:__removeItemList()
    if (self.mDelayFrameSn) then
        LoopManager:removeFrameByIndex(self.mDelayFrameSn)
        self.mDelayFrameSn = nil
    end
    if self.timeId then
        LoopManager:removeFrameByIndex(self.timeId)
        self.timeId = nil
    end
    RedPointManager:remove(self.mTextBtnTip.transform)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mImgToucher, self.__onClickEmptyHandler, "")
    self:addUIEvent(self.mBtnAward, self.__onClickAwardHandler)
    self:__infoPanelAddAllUIEvent()
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

function __onClickEmptyHandler(self)
    if(self.isShowInfo) then 
        self:__infoPanelHide()
    end
end

function __onClickAwardHandler(self)
    if (self.mChapterVo) then
        local canRec = branchStory.BranchMainManager:canRecMainChapterAward(self.mChapterVo.chapterId)
        if (canRec) then
            GameDispatcher:dispatchEvent(EventName.REQ_REC_BRANCH_EQUIP_AWARD, { chapterId = self.mChapterVo.chapterId })
        else
            local propsList = AwardPackManager:getAwardListById(self.mChapterVo.dropId)
            if (branchStory.BranchStoryManager:hasRecChapterAward(self.mChapterVo.chapterId) == false) then
                GameDispatcher:dispatchEvent(EventName.OPEN_DAILY_TASK_AWARD_PANEL, { tip = _TT(29107), propsList = propsList })
            else
                GameDispatcher:dispatchEvent(EventName.OPEN_DAILY_TASK_AWARD_PANEL, { tip = _TT(7), propsList = propsList })
            end
        end
    end
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

function setData(self, cusData)
    local chapterVo = cusData.chapterVo
    local stageVo = cusData.stageVo
    if chapterVo then
        self.mChapterVo = chapterVo
        self:__updateView(true)
        if (stageVo) then
            self:__scrollToStageId(stageVo.stageId)
        end
    end
end

function __updateView(self, isInit)
    if (self.mChapterVo.chapterId < 10) then
        self.mTextChapter.text = "0" .. self.mChapterVo.chapterId
    else
        self.mTextChapter.text = self.mChapterVo.chapterId
    end
    self.mTextTitle.text = self.mChapterVo:getInsideName()
    self:__updateStageListView(isInit)
    self:updateAwardNode()
end

function __updateStageListView(self, isInit)
    self:__removeItemList()
    local scrollToStageId = nil
    local totalW = 0
    local parentTrans = self.mNodeStart
    local list = self.mChapterVo.stageIdList
    for i = 1, #list do
        local stageVo = branchStory.BranchMainManager:getMainStageConfigVo(list[i])
        local item = branchStory.BranchMainStageItem:create(parentTrans, { type = stageVo.chapterId, data = stageVo }, 1, false)

        local isCanFight = not branchStory.BranchMainManager:isMainStagePass(stageVo.chapterId, stageVo.stageId) and
        branchStory.BranchMainManager:canMainStageFight(stageVo.chapterId, stageVo.stageId)
        if (not isHasSelect and isCanFight) then
            scrollToStageId = stageVo.stageId
        end
        if (not isHasSelect) then
            isHasSelect = isCanFight
        end
        item:setCallBack(self, function() self:__onClickStageItemHandler() end, stageVo)
        table.insert(self.mItemList, item)
        parentTrans = item:getNextNodeTrans()
        if (i == #list) then
            local _, _, endX = self:__getItemPosX(item)
            totalW = endX + self:getScreenW() * 0.5
        end
    end
    gs.TransQuick:SizeDelta01(self.mRectContent, totalW)
    -- 没有当前正在打的，即所有都打通关了，默认跳到最后一关
    if (scrollToStageId) then
        self:__scrollToStageId(scrollToStageId, not isInit)
    else
        local item = self.mItemList[#self.mItemList]
        if (item) then
            self:__scrollToStageId(item:getStageVo().stageId, not isInit)
        end
    end
end

function updateAwardNode(self)
    self:recoverAward()
    self.mComplete:SetActive(false)   
    self.mReceive:SetActive(false)
    if (not branchStory.BranchStoryManager:hasRecChapterAward(self.mChapterVo.chapterId)) then
        self:updateRedPoint()
        local propsList = AwardPackManager:getAwardListById(self.mChapterVo.dropId)
        for k,v in pairs(propsList) do
            local propsGrid = PropsGrid:createByData({ tid = v.tid, num = v.num, parent = self.mAwardNode, scale = 0.4, showUseInTip = true })
            table.insert(self.mDupAwardList, propsGrid)
        end
    else
        self.mComplete:SetActive(true)   
        self.mReceive:SetActive(false)
        RedPointManager:remove(self.mTextBtnTip.transform)
    end
end

function updateRedPoint(self)
    local passCount = branchStory.BranchStoryManager:getPassStageCount(self.mChapterVo.chapterId)
    local isFull = passCount >= #self.mChapterVo.stageIdList
    if (isFull) then
        self.mComplete:SetActive(false)   
        self.mReceive:SetActive(true)
        RedPointManager:add(self.mTextBtnTip.transform, nil, 0, 0)
    else
        RedPointManager:remove(self.mTextBtnTip.transform)
    end
end

function __scrollToStageId(self, stageId, isTween)
    self.lastId = stageId
    local scollOver = function()
        local stageItem = nil
        for k, item in pairs(self.mItemList) do
            if (item:getStageVo().stageId == stageId) then
                stageItem = item
            end
        end
        if (stageItem) then
            local starX, middleX, endX = self:__getItemPosX(stageItem)
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
            pos.x = pos.x >= 0 and 0 or pos.x
            pos.x = pos.x <= (scrollerW - totalContentW) and (scrollerW - totalContentW) or pos.x
            if (isTween) then
                TweenFactory:move2LPosX(self.mRectContent, pos.x, 0.3)
            else
                self.mRectContent.anchoredPosition = pos
                self.mCurPosX = self.mRectContent.anchoredPosition.x
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

--背景层级错位缓动参数
function UpdateDoTweenBg(self)
    local gImgBgRect = self.gImgBg.gameObject:GetComponent(ty.RectTransform)
    local moveX = gImgBgRect.anchoredPosition.x - (self.mCurPosX - self.mRectContent.anchoredPosition.x) * self.mMultiple
    gs.TransQuick:LPosX(self.gImgBg.gameObject.transform, moveX)
    self.mCurPosX = self.mRectContent.anchoredPosition.x
end

function __onClickStageItemHandler(self, stageVo)
    local stageId = stageVo.data.stageId
    -- 已通关/未通关
    if branchStory.BranchMainManager:isMainStagePass(stageVo.data.chapterId, stageId) or
    branchStory.BranchMainManager:canMainStageFight(stageVo.data.chapterId, stageId)
    then
        self:__infoPanelShow(stageId)
        self:__setSelectStage(stageId)
    else
        -- 未解锁
        gs.Message.Show(_TT(44211))
    end
end

function getSelectItem(self)
    return self.mSelectItem
end

-- 设置关卡选中状态
function __setSelectStage(self, stageId)
    for k, item in pairs(self.mItemList) do
        if (item:getStageVo().stageId == stageId) then
            item:setSelectState(true)
            self.mSelectItem = item
        else
            item:setSelectState(false)
        end
    end
    self:__scrollToStageId(stageId, true)
end

function __getItemPosX(self, item)
    local w, h = item:getSize()
    local relativePos = item:getRelativePos(self.mGroupContent)
    local starX = relativePos.x
    local middleX = starX + w / 2
    local endX = starX + w
    return starX, middleX, endX
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
    self.mTxtAwardTitle = self:getChildGO("TextAwardTitle"):GetComponent(ty.Text)
    self.mTxtStageId = self:getChildGO("TextStageId"):GetComponent(ty.Text)
    self.mTxtStageName = self:getChildGO("TextStageName"):GetComponent(ty.Text)
    self.mTxtStageDes = self:getChildGO("TextStageDes"):GetComponent(ty.Text)
    self.mScroller = self:getChildGO("Scroller"):GetComponent(ty.ScrollRect)
    self.mScrollContent = self.mScroller.content
    self.mImgCost = self:getChildGO("ImgCost"):GetComponent(ty.AutoRefImage)
    self.mTxtCost = self:getChildGO("TextCost"):GetComponent(ty.Text)
    self.mBtnFight = self:getChildGO("BtnFight")
    self.mRectDetail = self:getChildGO("GroupDetail"):GetComponent(ty.RectTransform)
    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mAni = self:getChildGO("StageInfoPanel"):GetComponent(ty.Animator)
end

function __infoPanelAddAllUIEvent(self)
    self:addUIEvent(self.mBtnFight, self.__onFightHandler)
    self:addUIEvent(self.mBtnClose, self.__infoPanelHide)
end

function __infoPanelHide(self)
    self:__onHideStageInfoHandler()
    if(self.isShowInfo) then 
        self.mAni:SetTrigger("show")
    end

    self.animaState = self.mAni:GetCurrentAnimatorStateInfo(0)
    self.isShowInfo = false
    self.hideLoop = LoopManager:addTimer(0.3, 1, self, self.closeInfoViewPanel)
    self:__scrollToStageId(self.lastId, true)
end

function closeInfoViewPanel(self)
    LoopManager:removeTimerByIndex(self.hideLoop)
    if not self.isShowInfo then 
        self:getChildGO("StageInfoPanel"):SetActive(false)
    else
        self.mAni:SetTrigger("exit")
    end
    self.hideLoop = nil
end

function __infoPanelShow(self, cusStageId)
    self:__onShowStageInfoHandler()
    self:getChildGO("StageInfoPanel"):SetActive(true)
    if self.isShowInfo and cusStageId ~= self.lastId then
        self.mAni:SetTrigger("exit")
    end
    self.isShowInfo = true
    self:updateInfoPanel(cusStageId)
    self:__updateItem()
end

function updateInfoPanel(self, cusStageId)
    self.mStageId = cusStageId
    self.mStageVo = branchStory.BranchMainManager:getMainStageConfigVo(cusStageId)
    self.mTxtStageId.text = ""
    self.mTxtStageName.text = self.mStageVo:getName()
    self.mTxtStageDes.text = self.mStageVo:getDes()

    local costTid = self.mStageVo.costTid
    local costCount = self.mStageVo.costNum
    self.mImgCost:SetImg(MoneyUtil.getMoneyIconUrlByTid(costTid), true)
    self.mTxtCost.text = costCount -- .. "/" .. bag.BagManager:getPropsCountByTid(costTid)
    self.mTxtCost.gameObject:SetActive(costCount > 0)

    if (self.mStageVo.type == battleMap.MainMapStageType.Boss) then
        gs.TransQuick:SizeDelta(self.mRectDetail, 1100, 0)
    else
        gs.TransQuick:SizeDelta(self.mRectDetail, 1260, 0)
    end
    if (self.mStageVo.type == battleMap.MainMapStageType.Normal or self.mStageVo.type == battleMap.MainMapStageType.StoryFight) then
        self.mImgPreview:SetImg(UrlManager:getPackPath("mainMap/main_map_stage_0_" .. self.mStageVo.type .. ".png"), true)
    else
        self.mImgPreview:SetImg(UrlManager:getPackPath("mainMap/main_map_stage_" .. self.mStageVo.type .. ".png"), true)
    end
    self.mTxtAwardTitle.text = _TT(44212)
end

function __updateItem(self)
    self:__removeItem()
    local isPass = branchStory.BranchMainManager:isMainStagePass(self.mStageVo.chapterId, self.mStageVo.stageId)

    local awardList = AwardPackManager:getAwardListById(self.mStageVo.awardPackId)
    if #awardList > 4 then
        gs.TransQuick:Pivot(self.mScrollContent, 0, 0.5)
        gs.TransQuick:UIPos(self.mScrollContent, 400, 0)
    else
        gs.TransQuick:Pivot(self.mScrollContent, 1, 0.5)
        gs.TransQuick:UIPos(self.mScrollContent, 0, 0)
    end
    gs.TransQuick:SizeDelta01(self.mScrollContent, (#awardList - 1) * 114 + 55 * 2)
    for i = 1, #awardList do
        local vo = awardList[i]
        local propsGrid = PropsGrid:create(self.mScrollContent, { vo.tid, vo.num }, 1, false)
        propsGrid:setPosition(math.Vector3((i - 1) * 114 + 55, 0, 0))
        table.insert(self.mAwardList, propsGrid)
        propsGrid:setIconGray(isPass == true)
        propsGrid:setHasRec(isPass == true)
    end
    -- end
    gs.TransQuick:UIPosX(self.mScrollContent, 0)
end

function __removeItem(self)
    if (self.mAwardList) then
        for i = #self.mAwardList, 1, -1 do
            local item = self.mAwardList[i]
            item:poolRecover()
        end
    end
    self.mAwardList = {}
end

function __onFightHandler(self)
    local isEnough, tipStr = MoneyUtil.judgeNeedMoneyCountByTid(self.mStageVo.costTid, self.mStageVo.costNum, true, false)
    if (isEnough) then
        self:__sendFight()
    else
        gs.Message.Show2(tipStr)
    end
end

function __sendFight(self)
    self:getChildGO("StageInfoPanel"):SetActive(false)
    local callOpenStageListPanel = function()
        -- 纯剧情播放完毕回到对应章节的关卡列表界面，或者打开阵型后又返回来
        GameDispatcher:dispatchEvent(
        EventName.OPEN_BRANCH_MAIN_PANEL,
        { chapterVo = self.mChapterVo, stageVo = self.mStageVo, type = self.mStageVo.chapterId }
        )
    end

    local formatoinCallFun = function(callReason)
        if (callReason == formation.CALL_FUN_REASON.PLAYER_CLOSE) then
            callOpenStageListPanel()
        end
    end

    if (self.mStageVo.type == battleMap.MainMapStageType.Story) then
        local finishCall = function(isSuccess, storyRo)
            if (isSuccess) then
                -- if(not storyTalk.StoryTalkManager:isPassStory(storyRo:getRefID()))then
                if
                (not branchStory.BranchMainManager:isMainStagePass(
                self.mStageVo.chapterId,
                self.mStageVo.stageId
                ))
                then
                    GameDispatcher:dispatchEvent(
                    EventName.REQ_DUP_STORY_FINISH,
                    { battleType = PreFightBattleType.BranchMain, fieldId = self.mStageVo.stageId }
                    )
                end
                callOpenStageListPanel()
                guide.GuideCondition:condition14()
            else
                -- gs.Message.Show("无剧情可播放")
                gs.Message.Show(_TT(49007))
            end
        end
        storyTalk.StoryTalkManager:justStoryNoFight(PreFightBattleType.BranchMain, self.mStageVo.stageId, finishCall)
    else
        formation.checkFormationFight(PreFightBattleType.BranchMain, nil, self.mStageId, nil, nil, nil, formatoinCallFun)
    end
end

function recoverAward(self)
    for i=1, #self.mDupAwardList do
        self.mDupAwardList[i]:poolRecover()
    end
    self.mDupAwardList = {}
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(44212):	"奖励预览"
	语言包: _TT(44211):	"请先通关前置关卡"
	语言包: _TT(7):	"已领取"
]]