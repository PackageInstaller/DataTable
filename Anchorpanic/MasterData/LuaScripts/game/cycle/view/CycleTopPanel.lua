---无限城的货币栏 因期特殊性暂时用新面板代替
module("cycle.CycleTopPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("cycle/CycleTopPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 3 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 0 -- 是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
end

-- 析构
function dtor(self)
end

function initData(self)
    self.mCollectionItems = {}
    self.mIsOpenBuffList = false
end

function getAdaptaTrans(self)
    return self:getChildTrans("adaptaContent")
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)

    self.mTxtCommander = self:getChildGO("mTxtCommander"):GetComponent(ty.Text)
    self.mTxtReason = self:getChildGO("mTxtReason"):GetComponent(ty.Text)
    self.mTxtReasonValue = self:getChildGO("mTxtReasonValue"):GetComponent(ty.Text)
    self.mTxtReasonLimitValue = self:getChildGO("mTxtReasonLimitValue"):GetComponent(ty.Text)
    self.mTxtLevel = self:getChildGO("mTxtLevel"):GetComponent(ty.Text)
    self.mLVProgress = self:getChildGO("mLVProgress"):GetComponent(ty.Image)
    self.mTxtProgress = self:getChildGO("mTxtProgress"):GetComponent(ty.Text)
    self.mBtnBuffList = self:getChildGO("mBtnBuffList")
    self.mBuffTxt = self:getChildGO("mBuffTxt"):GetComponent(ty.Text)
    self.mTxtBuffCount = self:getChildGO("mTxtBuffCount"):GetComponent(ty.Text)
    self.mBtnFormation = self:getChildGO("mBtnFormation")
    self.mCollection = self:getChildGO("mCollection")
    self.mCollectionContent = self:getChildTrans("mCollectionContent")
    self.mCollectionItem = self:getChildGO("mCollectionItem")
    self.mLvItem = self:getChildGO("mLvItem")
    self.mCoinItem = self:getChildGO("mCoinItem")
    self.mHopeItem = self:getChildGO("mHopeItem")
    self.mReasonItem = self:getChildGO("mReasonItem")
    self.mRight = self:getChildGO("Right")
    self.mLeft = self:getChildGO("Left")

    self.mBtnCancle = self:getChildGO("mBtnCancle")
    self.mBtnRetMain = self:getChildGO("mBtnRetMain")

    self.mBtnHideCollection = self:getChildGO("mBtnHideCollection")

    self.mBtnTipsReason = self:getChildGO("mBtnTipsReason")
    self.mBtnTipsLv = self:getChildGO("mBtnTipsLv")
    self.mBtnTipsCoin = self:getChildGO("mBtnTipsCoin")
    self.mBtnTipsHope = self:getChildGO("mBtnTipsHope")

    self.mTipsReason = self:getChildGO("mTipsReason")
    self.mBtnHideTipsReason = self:getChildGO("mBtnHideTipsReason")
    self.mTitleReason = self:getChildGO("mTitleReason"):GetComponent(ty.Text)
    self.mDesReason = self:getChildGO("mDesReason"):GetComponent(ty.Text)

    self.mTipsHope = self:getChildGO("mTipsHope")
    self.mBtnHideTipsHope = self:getChildGO("mBtnHideTipsHope")
    self.mTitleHope = self:getChildGO("mTitleHope"):GetComponent(ty.Text)
    self.mDesHope = self:getChildGO("mDesHope"):GetComponent(ty.Text)

    self.mTipsCoin = self:getChildGO("mTipsCoin")
    self.mBtnHideTipsCoin = self:getChildGO("mBtnHideTipsCoin")
    self.mTitleCoin = self:getChildGO("mTitleCoin"):GetComponent(ty.Text)
    self.mDesCoin = self:getChildGO("mDesCoin"):GetComponent(ty.Text)

    self.mTipsLv = self:getChildGO("mTipsLv")
    self.mBtnHideTipsLv = self:getChildGO("mBtnHideTipsLv")
    self.mTitleLv = self:getChildGO("mTitleLv"):GetComponent(ty.Text)
    self.mNotMax = self:getChildGO("mNotMax")
    self.mTxtAddHope = self:getChildGO("mTxtAddHope"):GetComponent(ty.Text)
    self.mTxtAddReason = self:getChildGO("mTxtAddReason"):GetComponent(ty.Text)

    self.mTxtRecoveryReason = self:getChildGO("mTxtRecoveryReason"):GetComponent(ty.Text)
    self.mTxtNext = self:getChildGO("mTxtNext"):GetComponent(ty.Text)
    self.mMax = self:getChildGO("mMax")
    self.mTxtMax = self:getChildGO("mTxtMax"):GetComponent(ty.Text)

    self.mTopBar = self:getChildGO("mTopBar")
    self.mBotBar = self:getChildGO("mBotBar")

    self:setGuideTrans("guide_CycleTopPanel_HopeItem", self:getChildTrans("mHopeItem"))
    self:setGuideTrans("guide_CycleTopPanel_BtnTipsReason", self:getChildTrans("mBtnTipsReason"))
    self:setGuideTrans("guide_CycleTopPanel_BtnTipsLv", self:getChildTrans("mBtnTipsLv"))
    self:setGuideTrans("guide_CycleTopPanel_BtnTipsCoin", self:getChildTrans("mBtnTipsCoin"))
    self:setGuideTrans("guide_CycleTopPanel_BtnBuffList", self:getChildTrans("mBtnBuffList"))
end

function setActiveTopPanel(self, isActive)
    self.UIRootNode:SetParent(GameView.story, false)
    self:setAdapta()
    self.UIObject:SetActive(isActive)
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
end

-- 隐藏收藏品
function onHideCollectionHandler(self)

    self.mCollection:SetActive(false)
    self.mIsOpenBuffList = false
end

function active(self)
    super.active(self)

    self.UIRootNode:SetParent(GameView.story, false)
    self:setAdapta()

    GameDispatcher:addEventListener(EventName.UPDA_CYCLE_TOP_PANEL, self.showPanel, self)
    GameDispatcher:addEventListener(EventName.UPDATE_CYCLE_COLLECTION, self.updateCollectionPanel, self)
    GameDispatcher:addEventListener(EventName.SET_CYCLE_CONTENT_PARENT, self.setParentContent, self)

    GameDispatcher:addEventListener(EventName.SET_CYCLE_TOP_PANEL_INFO, self.onSetInfo, self)
    self:showPanel()

    self.mIsOpenBuffList = false
    self.mCollection:SetActive(self.mIsOpenBuffList)
end

function setParentContent(self, args)
    self.UIRootNode.gameObject:SetActive(args.isShow)
    self.UIRootNode:SetParent(args.parentTrans, false)
    self:setDefAdapta()
end

function setDefAdapta(self)
    if self:getAdaptaTrans() then
        local minV = self:getAdaptaTrans().offsetMin;
        minV.x = 0
        self:getAdaptaTrans().offsetMin = minV

        local maxV = self:getAdaptaTrans().offsetMax;
        maxV.x = 0;
        self:getAdaptaTrans().offsetMax = maxV
    end
end

function deActive(self)
    super.deActive(self)

    if self.mCoinSn then
        LoopManager:removeFrameByIndex(self.mCoinSn)
        self.mCoinSn = nil
    end

    if self.mHopeSn then
        LoopManager:removeFrameByIndex(self.mHopeSn)
        self.mHopeSn = nil
    end

    self:recoverCollection()
    GameDispatcher:removeEventListener(EventName.UPDA_CYCLE_TOP_PANEL, self.showPanel, self)
    GameDispatcher:removeEventListener(EventName.SET_CYCLE_TOP_PANEL_INFO, self.onSetInfo, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_CYCLE_COLLECTION, self.updateCollectionPanel, self)
    GameDispatcher:removeEventListener(EventName.SET_CYCLE_CONTENT_PARENT, self.setParentContent, self)
end

function onSetInfo(self, args)
    --cusLog("收到了更新 ------" .. args.title)

    -- local lineData = cycle.CycleManager:getCurrentCycleLineData()
    -- if lineData == nil then
    self.mTxtTitle.text = args.title
    -- else
    --     self.mTxtTitle.text = _TT(lineData.name)
    -- end

    for k, v in pairs(TOP_SHOW_TYPE) do
        local hasType = table.indexof01(args.showTypeList, v) > 0
        local item
        if v == TOP_SHOW_TYPE.LV then
            item = self.mTxtCommander
        elseif v == TOP_SHOW_TYPE.REASON then
            item = self.mTxtReason
        elseif v == TOP_SHOW_TYPE.COIN then
            item = self.mCoinItem
        elseif v == TOP_SHOW_TYPE.HOPE then
            item = self.mHopeItem
        elseif v == TOP_SHOW_TYPE.BUFFLIST then
            item = self.mBtnBuffList
        elseif v == TOP_SHOW_TYPE.FORMATION then
            item = self.mBtnFormation
        elseif v == TOP_SHOW_TYPE.CANCLE_RECRUIT then
            item = self.mBtnCancle
        elseif v == TOP_SHOW_TYPE.RET_MAIN then
            item = self.mBtnRetMain
        elseif v == TOP_SHOW_TYPE.TOPBAR then
            item = self.mTopBar
        elseif v == TOP_SHOW_TYPE.BOTBAR then
            item = self.mBotBar
        end

        item.gameObject:SetActive(hasType)
    end
end

function initViewText(self)
    self.mTxtReason.text = _TT(77610)
    self.mTxtCommander.text = _TT(77611)
    self.mBuffTxt.text = _TT(77781)

    self.mTitleReason.text = _TT(77825)
    self.mDesReason.text = _TT(77826)

    self.mTitleLv.text = _TT(77827)

    self.mTitleHope.text = _TT(77829)
    self.mDesHope.text = _TT(77830)

    self.mTitleCoin.text = _TT(77831)
    self.mDesCoin.text = _TT(77832)
end

function showPanel(self)
    local curInfo = cycle.CycleManager:getResourceInfo()

    self.mTxtLevel.text = curInfo.lv
    local lvVo = cycle.CycleManager:getCycleLevelDataByLv(curInfo.lv)
    self.mTxtProgress.text = curInfo.exp .. "/" .. lvVo.nextExp
    self.mLVProgress.fillAmount = curInfo.exp / lvVo.nextExp

    self.mCollectionList = cycle.CycleManager:getLayerCollageList()
    local collectCount = 0
    if self.mCollectionList then
        collectCount = #self.mCollectionList
    end
    self.mTxtBuffCount.text = collectCount

    local oldInfo = cycle.CycleManager:getOldResourceInfo()

    self.oldCoin = oldInfo.coin and oldInfo.coin or 0
    self.newCoin = cycle.CycleManager:getResourceInfo().coin

    self.oldHope = oldInfo.hope_point and oldInfo.hope_point or 0
    self.newHope = cycle.CycleManager:getResourceInfo().hope_point

    self.oldReason = oldInfo.reason_point and oldInfo.reason_point or 0
    self.newReason = curInfo.reason_point

    self.oldReasonLimit = oldInfo.reason_point_limit and oldInfo.reason_point_limit or 0
    self.newReasonLimit = curInfo.reason_point_limit

    self.mCoinAniTime = 0.5
    self.mHopeAniTime = 0.5
    self.mReasonAniTime = 0.5
    self.mReasonLimitAniTime = 0.5

    self.mCoinTime = 0
    self.mHopeTime = 0
    self.mReasonTime = 0
    self.mReasonLimitTime = 0

    self.mCoinItem.transform:Find("mTxtCount"):GetComponent(ty.Text).text = self.oldCoin
    self.mHopeItem.transform:Find("mTxtCount"):GetComponent(ty.Text).text = self.oldHope
    self.mTxtReasonValue.text = oldInfo.reason_point
    self.mTxtReasonLimitValue.text = oldInfo.reason_point_limit

    if self.oldCoin ~= self.newCoin then
        if self.mCoinSn then
            LoopManager:removeFrameByIndex(self.mCoinSn)
            self.mCoinSn = nil
        end

        self.mCoinItem.transform:Find("mTxtCount"):GetComponent(ty.Text).color =
            self.oldCoin > self.newCoin and gs.ColorUtil.GetColor("fa3a2bff") or gs.ColorUtil.GetColor("18ec68ff")
        self.mCoinSn = LoopManager:addFrame(0, 0, self, self.loopAnimCoin)
    end

    if self.oldHope ~= self.newHope then
        if self.mHopeSn then
            LoopManager:removeFrameByIndex(self.mHopeSn)
            self.mHopeSn = nil
        end
        self.mHopeItem.transform:Find("mTxtCount"):GetComponent(ty.Text).color =
            self.oldHope > self.newHope and gs.ColorUtil.GetColor("fa3a2bff") or gs.ColorUtil.GetColor("18ec68ff")
        self.mHopeSn = LoopManager:addFrame(0, 0, self, self.loopAnimHope)
    end

    --
    if self.oldReason ~= self.newReason then
        if self.mReasonSn then
            LoopManager:removeFrameByIndex(self.mReasonSn)
            self.mReasonSn = nil
        end
        self.mTxtReasonValue.color = self.oldReason > self.newReason and gs.ColorUtil.GetColor("fa3a2bff") or
                                         gs.ColorUtil.GetColor("18ec68ff")
        self.mReasonSn = LoopManager:addFrame(0, 0, self, self.loopAnimReason)
    end

    if self.oldReasonLimit ~= self.newReasonLimit then
        if self.mReasonLimitSn then
            LoopManager:removeFrameByIndex(self.mReasonLimitSn)
            self.mReasonLimitSn = nil
        end
        self.mTxtReasonLimitValue.color = self.oldReasonLimit > self.newReasonLimit and
                                              gs.ColorUtil.GetColor("fa3a2bff") or gs.ColorUtil.GetColor("18ec68ff")
        self.mReasonLimitSn = LoopManager:addFrame(0, 0, self, self.loopAnimReasonLimit)
    end
end

function loopAnimReasonLimit(self)
    self.mReasonLimitTime = self.mReasonLimitTime + gs.Time.deltaTime
    if self.mReasonLimitTime <= self.mReasonLimitAniTime then
        self.mTxtReasonLimitValue.text = math.ceil(self.oldReasonLimit + (self.newReasonLimit - self.oldReasonLimit) *
                                                       (self.mReasonLimitTime / self.mReasonLimitAniTime))
    else
        self.mTxtReasonLimitValue.color = gs.ColorUtil.GetColor("ffffffff")
        self.mTxtReasonLimitValue.text = self.newReasonLimit
        if self.mReasonLimitSn then
            LoopManager:removeFrameByIndex(self.mReasonLimitSn)
            self.mReasonLimitSn = nil
        end
    end
end

function loopAnimReason(self)
    self.mReasonTime = self.mReasonTime + gs.Time.deltaTime
    if self.mReasonTime <= self.mReasonAniTime then
        self.mTxtReasonValue.text = math.ceil(self.oldReason + (self.newReason - self.oldReason) *
                                                  (self.mReasonTime / self.mReasonAniTime))
    else
        self.mTxtReasonValue.color = gs.ColorUtil.GetColor("ffffffff")
        self.mTxtReasonValue.text = self.newReason
        if self.mReasonSn then
            LoopManager:removeFrameByIndex(self.mReasonSn)
            self.mReasonSn = nil
        end
    end
end

function loopAnimHope(self)
    self.mHopeTime = self.mHopeTime + gs.Time.deltaTime
    if self.mHopeTime <= self.mHopeAniTime then
        self.mHopeItem.transform:Find("mTxtCount"):GetComponent(ty.Text).text = math.ceil(self.oldHope +
                                                                                              (self.newHope -
                                                                                                  self.oldHope) *
                                                                                              (self.mHopeTime /
                                                                                                  self.mHopeAniTime))
    else
        self.mHopeItem.transform:Find("mTxtCount"):GetComponent(ty.Text).color = gs.ColorUtil.GetColor("ffffffff")
        self.mHopeItem.transform:Find("mTxtCount"):GetComponent(ty.Text).text = self.newHope
        if self.mHopeSn then
            LoopManager:removeFrameByIndex(self.mHopeSn)
            self.mHopeSn = nil
        end
    end
end

function loopAnimCoin(self)
    self.mCoinTime = self.mCoinTime + gs.Time.deltaTime
    if self.mCoinTime <= self.mCoinAniTime then
        self.mCoinItem.transform:Find("mTxtCount"):GetComponent(ty.Text).text = math.ceil(self.oldCoin +
                                                                                              (self.newCoin -
                                                                                                  self.oldCoin) *
                                                                                              (self.mCoinTime /
                                                                                                  self.mCoinAniTime))
    else
        self.mCoinItem.transform:Find("mTxtCount"):GetComponent(ty.Text).color = gs.ColorUtil.GetColor("ffffffff")
        self.mCoinItem.transform:Find("mTxtCount"):GetComponent(ty.Text).text = self.newCoin
        if self.mCoinSn then
            LoopManager:removeFrameByIndex(self.mCoinSn)
            self.mCoinSn = nil
        end
    end
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnBuffList, self.openBuffList)
    self:addUIEvent(self.mBtnFormation, self.openFormation)
    self:addUIEvent(self.mBtnCancle, self.cancleRecruit)
    self:addUIEvent(self.mBtnRetMain, self.retToMain)
    self:addUIEvent(self.mBtnHideCollection, self.onHideCollectionHandler)

    self:addUIEvent(self.mBtnTipsReason, function()
        self.mTipsReason:SetActive(true)
    end)

    self:addUIEvent(self.mBtnTipsLv, function()
        local curInfo = cycle.CycleManager:getResourceInfo()
        local lvVo = cycle.CycleManager:getCycleLevelDataByLv(curInfo.lv + 1)
        if lvVo then
            self.mNotMax:SetActive(true)
            self.mMax:SetActive(false)
            self.mTxtAddHope.text = _TT(77828, lvVo.addHope)
            self.mTxtAddReason.text = _TT(77833, lvVo.addReasonLimit)
            self.mTxtRecoveryReason.text = _TT(77834, lvVo.recoveryReason)
        else
            self.mNotMax:SetActive(false)
            self.mMax:SetActive(true)
        end
        self.mTipsLv:SetActive(true)
    end)

    self:addUIEvent(self.mBtnTipsCoin, function()
        self.mTipsCoin:SetActive(true)
    end)

    self:addUIEvent(self.mBtnTipsHope, function()
        self.mTipsHope:SetActive(true)
    end)

    self:addUIEvent(self.mBtnHideTipsReason, function()
        self.mTipsReason:SetActive(false)
    end)

    self:addUIEvent(self.mBtnHideTipsLv, function()
        self.mTipsLv:SetActive(false)
    end)

    self:addUIEvent(self.mBtnHideTipsCoin, function()
        self.mTipsCoin:SetActive(false)
    end)

    self:addUIEvent(self.mBtnHideTipsHope, function()
        self.mTipsHope:SetActive(false)
    end)

end

function updateCollectionPanel(self)
    self.mCollectionList = cycle.CycleManager:getLayerCollageList()
    local collectCount = 0
    if self.mCollectionList then
        collectCount = #self.mCollectionList
    end
    self.mTxtBuffCount.text = collectCount
end

function openBuffList(self)
    self.mIsOpenBuffList = not self.mIsOpenBuffList
    if self.mCollectionList == nil or #self.mCollectionList == 0 then
        self.mIsOpenBuffList = false
        return
    end
    self:recoverCollection()
    if self.mIsOpenBuffList then
        for i = 1, #self.mCollectionList do
            local v = self.mCollectionList[i]
            local item = SimpleInsItem:create(self.mCollectionItem, self.mCollectionContent, "CycleTopPanelcollectionItem")
            local icon = item:getChildGO("mImgCollection"):GetComponent(ty.AutoRefImage)
            local name = item:getChildGO("mTxtCollectionName"):GetComponent(ty.Text)
            local des = item:getChildGO("mTxtDes"):GetComponent(ty.Text)
            icon:SetImg(UrlManager:getCycelCollectionIcon(v.icon), false)
            name.text = _TT(v.name)
            des.text = _TT(v.des2)

            item:addUIEvent("mBtnClick", function()
                cycle.CycleShowAwardPanel:showPropsAwardMsg(v.id)
            end)
            -- mCollectionItem
            table.insert(self.mCollectionItems, item)
        end
    end
    self.mCollection:SetActive(self.mIsOpenBuffList)
end

function openFormation(self)
    formation.checkFormationFight(PreFightBattleType.Cycle, DupType.Cycle, 0, formation.TYPE.CYCLE, nil, nil)
end

function cancleRecruit(self)

    if cycle.CycleManager:getRecuritClicked() == false then
        self.selectType, self.recuritType = cycle.CycleManager:getCurTicketAndType()
        if self.recuritType == RECUIT_TYPE.STEP then
            GameDispatcher:dispatchEvent(EventName.REQ_CYCLE_STEP_INFO, {
                step = CYCLE_STEP.SELECT_RECRUIT,
                args = {0}
            })
        elseif self.recuritType == RECUIT_TYPE.POSTWAR then
            local currentCellId = cycle.CycleManager:getCurrentCell()
            GameDispatcher:dispatchEvent(EventName.REQ_CYCLE_TRIGGER_EVENT_FINISH, {
                cellId = currentCellId,
                args = {POSTWAR_TYPE.RECUIT, self.selectType, 0}
            })
        elseif self.recuritType == RECUIT_TYPE.EVENT then
            local currentCellId = cycle.CycleManager:getCurrentCell()
            local cellMsgVo = cycle.CycleManager:getCellDataById(currentCellId)
            if cellMsgVo then
                local currentEventId = cellMsgVo.eventId

                GameDispatcher:dispatchEvent(EventName.REQ_CYCLE_TRIGGER_EVENT_FINISH, {
                    cellId = currentCellId,
                    args = {0}
                })
            end

        elseif self.recuritType == RECUIT_TYPE.SHOP then
            GameDispatcher:dispatchEvent(EventName.REQ_CYCLE_SHOP_RECRUIT_HERO, {
                heroId = 0
            })

            GameDispatcher:dispatchEvent(EventName.SET_CYCLE_TOP_PANEL_INFO, {
                title = _TT(27523),
                showTypeList = { TOP_SHOW_TYPE.LV, TOP_SHOW_TYPE.REASON, TOP_SHOW_TYPE.COIN, TOP_SHOW_TYPE.HOPE, TOP_SHOW_TYPE.BUFFLIST, TOP_SHOW_TYPE.FORMATION,TOP_SHOW_TYPE.RET_MAIN,TOP_SHOW_TYPE.TOPBAR,TOP_SHOW_TYPE.BOTBAR }
            })
        
        end

        cycle.CycleManager:setRecuritClicked(true)
    end
    -- self.canClick = false
end

function recoverCollection(self)
    for k, v in pairs(self.mCollectionItems) do
        v:poolRecover()
    end
    self.mCollectionItems = {}
end

function retToMain(self)
    local isDup,isForm = cycle.CycleManager:getIsPre()
    if isDup and isForm then
        GameDispatcher:dispatchEvent(EventName.CLOSE_CYCLE_FORMATION_PANEL)
        return
    end

    GameDispatcher:dispatchEvent(EventName.CLOSE_CYCLE_GAME_VIEW)
    GameDispatcher:dispatchEvent(EventName.CLOSE_CYCLE_MAP_PANEL)
    GameDispatcher:dispatchEvent(EventName.CLOSE_CYCLE_STEP_PANEL_ALL)

    self.UIObject:SetActive(false)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
