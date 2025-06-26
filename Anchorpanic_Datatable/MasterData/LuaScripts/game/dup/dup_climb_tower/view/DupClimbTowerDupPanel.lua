--[[ 
-----------------------------------------------------
@filename       : DupClimbTowerDupPanel
@Description    : 爬塔副本区内副本页
@date           : 2021-01-28 17:13:57
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("dup.DupClimbTowerDupPanel", Class.impl(View))
UIRes = UrlManager:getUIPrefabPath("domainSurvey/DomainSurveyFightPanel.prefab")
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
    self:setUICode(LinkCode.ChellengeTower)
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
    self.mShowAwardList = {}
    self.mWeaknessGrid = {}
end

function getAdaptaTrans(self)
    return self:getChildTrans("mGroupClose")
end

function configUI(self)
    self.mGoToucher = self:getChildGO('ImgToucher')
    self.mNodeStart = self:getChildTrans('NodeStart')
    self.mGroupContent = self:getChildTrans('Content')
    self.mDomainNode = self:getChildTrans('mDomainNode')
    self.mScrollerTrans = self:getChildTrans('Scroll View')
    self.mRectContent = self.mGroupContent:GetComponent(ty.RectTransform)
    self.mRectNodeStart = self.mNodeStart:GetComponent(ty.RectTransform)

    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mBtnDupClose = self:getChildGO("mBtnDupClose")
    self.mBtnCloseAll = self:getChildGO("mBtnCloseAll")
    -- self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)

    self.mReceive = self:getChildGO('Receive')
    self.mBtnAward = self:getChildGO('BtnAward')
    self.mComplete = self:getChildGO('Complete')
    self.mAwardNode = self:getChildTrans("mGroupAward")
    self.mTextBtnTip = self:getChildGO("TextBtnTip"):GetComponent(ty.Text)
    self.mImgAward = self:getChildGO('ImgAward'):GetComponent(ty.AutoRefImage)
    -- self.mAwardTipsGroup = self:getChildGO("mAwardTipsGroup")
    -- self.mTxtCondition = self:getChildGO("mTxtCondition"):GetComponent(ty.Text)
    -- self.mAwardContent = self:getChildTrans("mAwardContent")
    -- self.mBtnHide = self:getChildGO("mBtnHide")
    -- self.mAwardTipsAni = self.mAwardTipsGroup:GetComponent(ty.Animator)
    self:infoPanelConfigUI()
end

function active(self, args)
    super.active(self, args)
    -- self.mAwardTipsGroup:SetActive(false)
    self:setAdapta()
    MoneyManager:setMoneyTidList()
    GameDispatcher:addEventListener(EventName.UPDATE_CLIMB_TOWER_PANEL, self.__onUpdatePanelHandler, self)
    if args.areaVo then
        self.mAreaVo = args.areaVo
        self:__updateView(true)
    end

    if (dup.DupClimbTowerManager:getIsInMainPanel()) then
        GameDispatcher:dispatchEvent(EventName.CLIMB_TOWER_CHANGE, false, true)
    end
    self.isBack = true
end

function openNavigationLink(self)
    if not self.mNavigation then
        self.mNavigation = link.NavigationLink:new()
        self.mNavigation:setCloseAllCall(self.closeAll, self)
    end
    self.mNavigation:setParentTrans(self:getChildTrans("mGroupNavigation"), 0)
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
    -- self.mAwardTipsGroup:SetActive(false)
    if (self.isBack) then
        GameDispatcher:dispatchEvent(EventName.CLIMB_TOWER_CHANGE, true)
    end
    MoneyManager:setMoneyTidList()
    self:__infoPanelHide()
    -- self:recoverShowAwardItem()
    GameDispatcher:removeEventListener(EventName.UPDATE_CLIMB_TOWER_PANEL, self.__onUpdatePanelHandler, self)
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
    self:addUIEvent(self.mGoToucher, self.__onClickEmptyHandler, "")
    self:addUIEvent(self.mBtnClose, self.__onClickEmptyHandler, "")
    self:addUIEvent(self.mBtnDupClose, self.clickClose, self:getCloseSoundPath())
    self:addUIEvent(self.mBtnCloseAll, self.openNavigationLink, self:getCloseSoundPath())
    self:addUIEvent(self.mBtnAward, self.onClickAwardHandler)
    -- self:addUIEvent(self.mBtnHide, self.onClickHideAwardTips)
    self:__infoPanelAddAllUIEvent()
end

function initViewText(self)
    -- self.mTxtTitle.text = _TT(4534)
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
    if (self.mAreaVo) then
        local canRec = dup.DupClimbTowerManager:canRecMainChapterAward(self.mAreaVo.areaId)
        if (canRec) then
            GameDispatcher:dispatchEvent(EventName.REC_CLIMB_TOWER_AWARD, { areaId = self.mAreaVo.areaId })
            table.insert(dup.DupClimbTowerManager.mAwardAreaList, self.mAreaVo.areaId)
            self:updateAwardNode()
        else
            local propsList = {}
            for k, v in pairs(self.mAreaVo.awardList) do
                table.insert(propsList, { tid = v[1], count = v[2] })
            end
            GameDispatcher:dispatchEvent(EventName.OPEN_MAZE_AWARDPREVIEW_PANEL, { propsList = propsList, title = 44218 })
            -- if (dup.DupClimbTowerManager:hasRecChapterAward(self.mAreaVo.areaId) == false) then
            --     self.mTxtCondition.text = _TT(29107)
            -- else
            --     self.mTxtCondition.text = _TT(7)
            -- end
            -- self:recoverShowAwardItem()
            -- for _, propVo in pairs(propsList) do
            --     local propItem = PropsGrid:createByData({ tid = propVo.tid, num = propVo.num, parent = self.mAwardContent, scale = 1, showUseInTip = true })
            --     table.insert(self.mShowAwardList, propItem)
            -- end
            -- self.mAwardTipsGroup:SetActive(true)
            -- self.mAwardTipsAni:SetTrigger("enter")
        end
    end
end

function __onClickEmptyHandler(self)
    if (self.isShowInfo) then
        self:__infoPanelHide()
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

function __updateView(self, isInit)
    self:recoverDomainItem(self)
    self.mDomainItem = dup.DupClimbTowerAreaItem:create(self.mDomainNode, { areaVo = self.mAreaVo }, 1, false)
    RedPointManager:remove(self.mDomainItem:getTrans())
    self:__updateStageListView(isInit)
    self:updateAwardNode()
end

function __updateStageListView(self, isInit)
    self:__removeItemList()
    local scrollToDupId = nil
    local hasSelect = false
    local totalW = 0
    local parentTrans = self.mNodeStart
    local list = self.mAreaVo.mDupList
    local nowDupId = dup.DupClimbTowerManager:getNowDupId()
    if (nowDupId ~= nil) then
        scrollToDupId = nowDupId
        hasSelect = true
    elseif (self.lastId and table.indexof(list, self.lastId)) then
        scrollToDupId = self.lastId
        hasSelect = true
    end

    for i = 1, #list do
        local dupId = list[i]
        local item = dup.DupClimbTowerDupItem:create(parentTrans, { data = dup.DupClimbTowerManager:getDupVo(dupId) }, 1, false)
        local isCanFight
        if dup.DupClimbTowerManager:curDupId() ~= 0 then
            isCanFight = dupId <= dup.DupClimbTowerManager:curDupId()
        else
            isCanFight = dupId <= dup.DupClimbTowerManager:maxDupId()
        end
        if (isInit and isCanFight) then
            scrollToDupId = dupId
        elseif (not hasSelect and isCanFight) then
            scrollToDupId = dupId

        end
        local function __onClickDupItemHandler()
            -- 已通关/未通关
            if dup.DupClimbTowerManager:curDupId() == 0 or dupId <= dup.DupClimbTowerManager:curDupId() then
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
            local _, _, endX = self:__getItemPosX(item)
            totalW = endX + self:getScreenW() * 0.5
            gs.TransQuick:SizeDelta01(self.mRectContent, totalW)
            if (scrollToDupId) then
                self:__scrollToDupId(scrollToDupId, not isInit)
            else
                -- 移动到最后
                local item = self.mItemList[#self.mItemList]
                if (item) then
                    self:__scrollToDupId(item:getDupVo().dupId)
                end
            end
        end
    end
end

function updateAwardNode(self)
    self:recoverAward()
    if not self.mAreaVo.awardList or table.empty(self.mAreaVo.awardList) then
        self.mBtnAward:SetActive(false)
        return
    end
    self.mBtnAward:SetActive(true)
    self.mComplete:SetActive(false)
    self.mReceive:SetActive(false)
    if (dup.DupClimbTowerManager:getDupProgressByAreaId(self.mAreaVo.areaId) == 1) then
        local hasRec = dup.DupClimbTowerManager:hasRecChapterAward(self.mAreaVo.areaId)
        if (not hasRec) then
            self.mComplete:SetActive(false)
            self.mReceive:SetActive(true)
            RedPointManager:add(self.mTextBtnTip.transform, nil, -57, 48)
        else
            self.mComplete:SetActive(true)
            self.mReceive:SetActive(false)
            RedPointManager:remove(self.mTextBtnTip.transform)
        end
    end
    for k, v in pairs(self.mAreaVo.awardList) do
        local propsGrid = PropsGrid:createByData({ tid = v[1], num = v[2], parent = self.mAwardNode, scale = 1, showUseInTip = true })
        table.insert(self.mAwardList, propsGrid)
    end
end

-- function onClickHideAwardTips(self)
--     local aniTime = AnimatorUtil.getAnimatorClipTime(self.mAwardTipsAni, "AwardTipsGroup_Enter")
--     self.mAwardTipsAni:SetTrigger("exit")
--     self:addTimer(aniTime, aniTime, function()
--         self.mAwardTipsGroup:SetActive(false)
--     end)
-- end

function __scrollToDupId(self, dupId, isTween)
    self.lastId = dupId
    local stageItem = nil
    for k, item in pairs(self.mItemList) do
        if (item:getDupVo().dupId == dupId) then
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
        if (isTween) then
            TweenFactory:move2LPosX(self.mRectContent, pos.x, 0.3)
        else
            self.mRectContent.anchoredPosition = pos
            self.mCurPosX = self.mRectContent.anchoredPosition.x
            -- self:UpdateDoTweenBg()
        end
    end
end

function getScreenW(self)
    local w, h = ScreenUtil:getScreenSize(nil)
    return w
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

function __getItemPosX(self, item)
    local w, h = item:getSize()
    local relativePos = item:getRelativePos(self.mGroupContent)
    local starX = relativePos.x
    local middleX = starX + w / 2
    local endX = starX + w
    return starX, middleX, endX
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

-- function recoverShowAwardItem(self)
--     for i,v in pairs(self.mShowAwardList) do
--         v:poolRecover()
--     end
--     self.mShowAwardList = {}
-- end

-----------------------------------------------------------------------------Info面板内容----------------------------------------------------------------------------------
function infoPanelConfigUI(self)
    self.mStageInfoPanel = self:getChildGO("StageInfoPanel")
    self.mTxtAwardTitle = self:getChildGO("mTxtAwardTitle"):GetComponent(ty.Text)
    self.mTxtEnvironment = self:getChildGO("mTxtEnvironment"):GetComponent(ty.Text)

    self.mTxtStageId = self:getChildGO("mTxtStageId"):GetComponent(ty.Text)
    self.mTxtStageName = self:getChildGO("mTxtStageName"):GetComponent(ty.Text)
    self.mTxtStageDes = self:getChildGO("TextStageDes"):GetComponent(ty.Text)
    self.mScroller = self:getChildGO("Scroller"):GetComponent(ty.ScrollRect)
    self.mScrollContent = self.mScroller.content
    -- self.ScrollerEnvironment = self:getChildGO("ScrollerEnvironment"):GetComponent(ty.ScrollRect)
    -- self.EnvironmentContent = self.ScrollerEnvironment.content
    -- self.mGoEnvironmentSign = self:getChildGO("EnvironmentSign")
    self.mBtnFight = self:getChildGO("mBtnFight")
    self.mRectDetail = self:getChildGO("GroupDetail"):GetComponent(ty.RectTransform)
    self.mBtnClose = self:getChildGO("mBtnClose")

    self.mTextEnvironmentNothing = self:getChildGO("TextEnvironmentNothing")
    self.mAni = self.mStageInfoPanel:GetComponent(ty.Animator)

    self:getChildGO("mTxtRecommandFormation"):GetComponent(ty.Text).text = "推荐阵容"
    self.mFormationIconNode = self:getChildTrans("mFormationIconNode")
    self.mImgEleBg = self:getChildGO("mImgEleBg")
    self.mBtnAnemyFormation = self:getChildGO("mBtnAnemyFormation")

    self:setGuideTrans("survey_tofight_challenge", self.mBtnFight.transform)
end

function __infoPanelAddAllUIEvent(self)
    self:addUIEvent(self.mBtnFight, self.__onFightHandler)
    self:addUIEvent(self.mBtnClose, self.__infoPanelHide)
    self:addUIEvent(self.mBtnAnemyFormation, self.onOpenFormationPanel)
end

function onOpenFormationPanel(self)
    self.isBack = false
    self:close()

    local formatoinCallFun = function()
        gs.CameraMgr:SetSceneCameraVisible(true)
        gs.CameraMgr:GetDefSceneCameraTrans().gameObject:SetActive(false)
        GameDispatcher:dispatchEvent(EventName.OPEN_CLIMB_TOWER_AREA_PANEL, { areaVo = self.mAreaVo })
    end
    GameDispatcher:dispatchEvent(EventName.OPEN_FORMATION_PREVIEW, { dupVo = self.mDupVo, closeCallBack = formatoinCallFun })
end

function __infoPanelHide(self)
    self:__onHideStageInfoHandler()
    self:recoverEleGrid()
    if (self.isShowInfo) then
        self.mAni:SetTrigger("show")
    end

    self.isShowInfo = false
    self.hideLoop = LoopManager:addTimer(0.3, 1, self, self.closeInfoViewPanel)
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
    self.mStageInfoPanel:SetActive(true)
    if self.isShowInfo and cusDupId ~= self.lastId then
        self.mAni:SetTrigger("exit")
    end
    self.isShowInfo = true

    self.mDupId = cusDupId
    self.mDupVo = dup.DupClimbTowerManager:getDupVo(cusDupId)
    self.mTxtStageId.text = ""
    self.mTxtStageName.text = self.mDupVo:getName()
    self.mTxtStageDes.text = self.mDupVo:getDescribe()

    self.mTxtAwardTitle.text = _TT(44212)
    self.mTxtEnvironment.text = _TT(20121)
    self.mTextEnvironmentNothing:GetComponent(ty.Text).text = _TT(20122)
    self:__updateItem()
    self:updateSuggest()
end

function __updateItem(self)
    self:__removeItem()
    for i = 1, #self.mDupVo.firstAward do
        local firstAward = PropsGrid:create(self.mScrollContent, { self.mDupVo.firstAward[i].tid, self.mDupVo.firstAward[i].num }, 1, false)
        firstAward:setIsFirstPass(true)
        if dup.DupClimbTowerManager:curDupId() == 0 or self.mDupVo.dupId < dup.DupClimbTowerManager:curDupId() then
            firstAward:setIconGray(true)
            firstAward:setHasRec(true)
        end
        table.insert(self.mFirstAwardList, firstAward)
    end

    -- local skillList = self.mDupVo.support_skill
    -- if #skillList > 0 then
    --     self.mTextEnvironmentNothing:SetActive(false)
    --     for i, v in ipairs(skillList) do
    --         local skillVo = fight.SkillManager:getSkillRo(v)
    --         local item = SimpleInsItem:create(self.mGoEnvironmentSign, self.EnvironmentContent, "EnvironmentContent")
    --         item:getChildGO("Image"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getSkillIconPath(skillVo:getIcon()), false)
    --         -- item:getChildGO("mTxtName"):GetComponent(ty.Text).text = skillVo:getName()
    --         item:addUIEvent("Image", function()
    --             TipsFactory:skillTips(nil, v, nil, true)
    --         end)
    --         table.insert(self.skillItem, item)
    --     end
    -- else
    --     self.mTextEnvironmentNothing:SetActive(true)
    -- end
    gs.TransQuick:UIPosX(self.mScrollContent, 0)
end

function updateSuggest(self)
    self:recoverEleGrid()
    local suggestEle = self.mDupVo.suggestEle
    for i = 1, #suggestEle do
        local item = SimpleInsItem:create(self.mImgEleBg, self.mFormationIconNode, "elegrid")
        local type = item:getChildGO("mImgEleType"):GetComponent(ty.AutoRefImage)
        type:SetImg(UrlManager:getHeroEleTypeIconUrl(suggestEle[i]), false)
        table.insert(self.mWeaknessGrid, item)
    end
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

function recoverEleGrid(self)
    for k, v in pairs(self.mWeaknessGrid) do
        v:poolRecover()
    end
    self.mWeaknessGrid = {}
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

    --临时的处理 没有办法了
    local formatoinCallFun = function(callReason)
        if (callReason == formation.CALL_FUN_REASON.PLAYER_CLOSE) then
            GameDispatcher:dispatchEvent(EventName.OPEN_CLIMB_TOWER_AREA_PANEL, { areaVo = self.mAreaVo })
        end
    end
    formation.checkFormationFight(PreFightBattleType.ClimbTowerDup, nil, self.mDupId, formation.TYPE.CLIMBTOWER, nil, nil, formatoinCallFun)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]