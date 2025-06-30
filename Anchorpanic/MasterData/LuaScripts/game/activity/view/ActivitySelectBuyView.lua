module("activity.ActivitySelectBuyView", Class.impl(TabSubView))
UIRes = UrlManager:getUIPrefabPath("activity/ActivitySelectBuyView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认
panelType = -1 -- 窗口类型 1 全屏 2 弹窗
-- 构造函数
function ctor(self)
    super.ctor(self)
    -- self:setSize(0, 0)
    -- self:setTxtTitle(_TT(72115))
    -- self:setBg("manual_bg.jpg", false, "manual")
    -- self:setUICode(LinkCode.ActivitySelectBuy)
end

-- 初始化数据
function initData(self)
    super.initData(self)

    self.mSelectItemList = {}
    self.mSelectPropsItemList = {}
    self.mPropsGridList = {}

    self.mAniList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mSelectScroll = self:getChildGO("mSelectScroll"):GetComponent(ty.ScrollRect)

    self.mSelectItem = self:getChildGO("mSelectItem")
    self.mSelectPropsItem = self:getChildGO("mSelectPropsItem")

    self.mTxtEndTimer = self:getChildGO("mTxtEndTimer"):GetComponent(ty.Text)
    self.mBtnEveryDayGift = self:getChildGO("mBtnEveryDayGift")
    self.mBtnEveryDayGiftTf = self:getChildTrans("mBtnEveryDayGift")
    self.mImgGotEveryDayGiftMask = self:getChildGO("mImgGotEveryDayGiftMask")
end

-- 激活
function active(self, args)
    super.active(self, args)
    GameDispatcher:addEventListener(EventName.UPDATE_ACTIVITY_SELECT_BUY_VIEW, self.showPanel, self)
    GameDispatcher:addEventListener(EventName.UPDATE_ACTIVITY_RED, self.showPanel, self)

    MoneyManager:setMoneyTidList({})
    self:showPanel(true)
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_ACTIVITY_SELECT_BUY_VIEW, self.showPanel, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_ACTIVITY_RED, self.showPanel, self)
    self:clearPropsGridItemList()
    self:clearSelectPropsItemList()
    self:clearSelectItemList()

    for i = 1, #self.mAniList do
        self:clearTimeout(self.mAniList[i])
    end
    self.mAniList = {}

    if self.updateTimeSn then
        LoopManager:removeTimerByIndex(self.updateTimeSn)
        self.updateTimeSn = nil
    end
    RedPointManager:remove(self.mBtnEveryDayGiftTf)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnEveryDayGift, self.onClickBtnEveryDayGiftHandler)
end

function getMsgIndex(self, msgData, gridId)
    for k, v in pairs(msgData.grid_select_list) do
        if v.grid_id == gridId then
            return v.select_id
        end
    end
    return 0
end

function showPanel(self,firstShow)
    local list = activity.ActitvityExtraManager:getSelectBuyData()

    for i = 1, #self.mAniList do
        self:clearTimeout(self.mAniList[i])
    end
    self.mAniList = {}

    self:clearPropsGridItemList()
    self:clearSelectPropsItemList()
    self:clearSelectItemList()
    for i = 1, #list do
        local item = SimpleInsItem:create(self.mSelectItem, self.mSelectScroll.content, "mSelectItem")
        
        if firstShow then
            item.m_go:SetActive(false)
            local aniSn = self:setTimeout(0.08 + i * 0.05, function()
                item.m_go:SetActive(true)
                item.m_go:GetComponent(ty.UIDoTween):BeginTween()
            end)
            table.insert(self.mAniList, aniSn)
        end

        local msgData = activity.ActitvityExtraManager:getSelectGiftMsgData(list[i].id)
        local isBuy = msgData.is_buy == 1

        item:getChildGO("mTxtTitle"):GetComponent(ty.Text).text = _TT(list[i].name)
        item:getChildGO("mTxtBuy"):GetComponent(ty.Text).text = "¥" .. list[i].price
        item:getChildGO("mTxtScale"):GetComponent(ty.Text).text = list[i].scale.."%".._TT(25037)

        item:getChildGO("mImgBuyed"):SetActive(isBuy)
        item:getChildGO("mBtnBuy"):SetActive(not isBuy)

        item:addUIEvent("mBtnBuy", function()
            local hasNil = false
            for k, v in pairs(msgData.grid_select_list) do
                if v.select_id == 0 then
                    hasNil = true
                end
            end
            if hasNil then
                GameDispatcher:dispatchEvent(EventName.OPEN_ACTIVITY_SELECT_VIEW, {
                    id = list[i].id
                })
            else
                recharge.sendRecharge(recharge.RechargeType.SELECT_GIFT, nil, list[i].id)
            end
        end)

        local normItem = SimpleInsItem:create(self.mSelectPropsItem, item:getChildTrans("mSelectContent"),
            "mSelectPropsItem")
        normItem:getChildGO("mImgNor"):SetActive(true)
        local propsGrid = PropsGrid:createByData({
            tid = list[i].normalItemTid,
            num = list[i].normalItemNum,
            parent = normItem:getChildTrans("mPropsContent"),
            scale = 0.56,
            showUseInTip = false
        })

        local longClick = normItem:getChildGO("mBtnClick"):GetComponent(ty.LongPressOrClickEventTrigger)
        longClick.onClick:RemoveAllListeners()
        longClick.onLongPress:RemoveAllListeners()
        
        longClick.onLongPress:AddListener(function ()
            local tid = list[i].normalItemTid
                    local propsVo = props.PropsManager:getPropsConfigVo(tid)

                    if (propsVo.type == PropsType.EQUIP) then
                        TipsFactory:equipTips(propsVo, nil)
                    elseif propsVo.type == PropsType.HERO then
                        if not fight.FightManager:getIsFighting() then
                            GameDispatcher:dispatchEvent(EventName.OPEN_HERO_DETAILSINFOPANEL, {heroTid = propsVo.tid})
                        else
                            logInfo("=============战斗场景的弹窗不打开")
                        end
                        --local heroId = hero.HeroManager:getHeroIdByTid(propsVo.tid)
                        --GameDispatcher:dispatchEvent(EventName.OPEN_HERO_DETAILS_PANEL, { heroId = heroId, heroTid = propsVo.tid, isShowFashion = false })
                    elseif (propsVo.type ~= PropsType.EQUIP) then
                        TipsFactory:propsTips({propsVo = propsVo, isShowUseBtn = self.mIsShowUseInTip})
                    end
        end)


        table.insert(self.mPropsGridList, propsGrid)
        table.insert(self.mSelectPropsItemList, normItem)
        for j = 1, #list[i].selectList do

            local msgSelectId = self:getMsgIndex(msgData, j)
            local childItem = SimpleInsItem:create(self.mSelectPropsItem, item:getChildTrans("mSelectContent"),
                "mSelectPropsItem")
            childItem:getChildGO("mImgNor"):SetActive(false)

            if msgSelectId > 0 then
                local selectPropsGrid = PropsGrid:createByData({
                    tid = list[i].selectList[j].data.childList[msgSelectId].tid,
                    num = list[i].selectList[j].data.childList[msgSelectId].num,
                    parent = childItem:getChildTrans("mPropsContent"),
                    scale = 0.56,
                    showUseInTip = false
                })
                table.insert(self.mPropsGridList, selectPropsGrid)
            end

            local longClick = childItem:getChildGO("mBtnClick"):GetComponent(ty.LongPressOrClickEventTrigger)
            longClick.onClick:RemoveAllListeners()
            longClick.onLongPress:RemoveAllListeners()
           
            longClick.onClick:AddListener(function ()
                if not isBuy then
                    GameDispatcher:dispatchEvent(EventName.OPEN_ACTIVITY_SELECT_VIEW, {
                        id = list[i].id
                    })
                end
            end)

            longClick.onLongPress:AddListener(function ()
                if msgSelectId > 0 then
                    local tid = list[i].selectList[j].data.childList[msgSelectId].tid
                    local propsVo = props.PropsManager:getPropsConfigVo(tid)

                    if (propsVo.type == PropsType.EQUIP) then
                        TipsFactory:equipTips(propsVo, nil)
                    elseif propsVo.type == PropsType.HERO then
                        if not fight.FightManager:getIsFighting() then
                            GameDispatcher:dispatchEvent(EventName.OPEN_HERO_DETAILSINFOPANEL, {heroTid = propsVo.tid})
                        else
                            logInfo("=============战斗场景的弹窗不打开")
                        end
                        --local heroId = hero.HeroManager:getHeroIdByTid(propsVo.tid)
                        --GameDispatcher:dispatchEvent(EventName.OPEN_HERO_DETAILS_PANEL, { heroId = heroId, heroTid = propsVo.tid, isShowFashion = false })
                    elseif (propsVo.type ~= PropsType.EQUIP) then
                        TipsFactory:propsTips({propsVo = propsVo, isShowUseBtn = self.mIsShowUseInTip})
                    end
                end
            end)


            -- childItem:addUIEvent("mBtnClick", function()
                
            -- end)

            table.insert(self.mSelectPropsItemList, childItem)
        end

        table.insert(self.mSelectItemList, item)
    end

    if self.updateTimeSn then
        LoopManager:removeTimerByIndex(self.updateTimeSn)
        self.updateTimeSn = nil
    end

    self:updateTime()
    self.updateTimeSn = LoopManager:addTimer(1, 0, self, self.updateTime)

       --更新每日奖励可领取状态
    local isCanGetEveryDayRewardState = not activity.ActivityManager:checkIsGotDailyReward(activity.ActivityId.SelectBuy)
    self.mImgGotEveryDayGiftMask:SetActive(not isCanGetEveryDayRewardState)
    if isCanGetEveryDayRewardState then
        RedPointManager:add(self.mBtnEveryDayGiftTf, nil, 25, 20)
    else
        RedPointManager:remove(self.mBtnEveryDayGiftTf)
    end
end

function updateTime(self)
    if activity.ActivityManager:getActivityVoById(activity.ActivityId.SelectBuy) then
        local clientTime = GameManager:getClientTime()
        local remainingTime = activity.ActivityManager:getActivityVoById(activity.ActivityId.SelectBuy):getEndTime() -
                                  clientTime
        local timeTxt = remainingTime <= 0 and "活动已结束" or _TT(3530) ..
                            HtmlUtil:colorAndSize(TimeUtil.getFormatTimeBySeconds_9(remainingTime), "ffffffff", 20)

        self.mTxtEndTimer.text = timeTxt

        if remainingTime <= 0 then
            LoopManager:removeTimerByIndex(self.updateTimeSn)
            self.updateTimeSn = nil
            -- self:close()
            return
        end
    end
end

function clearSelectItemList(self)
    for i = 1, #self.mSelectItemList do
        self.mSelectItemList[i]:poolRecover()
    end
    self.mSelectItemList = {}
end

function clearSelectPropsItemList(self)
    for i = 1, #self.mSelectPropsItemList do
        self.mSelectPropsItemList[i]:poolRecover()
    end
    self.mSelectPropsItemList = {}
end

function clearPropsGridItemList(self)
    for i = 1, #self.mPropsGridList do
        self.mPropsGridList[i]:poolRecover()
    end
    self.mPropsGridList = {}
end

function onClickBtnEveryDayGiftHandler(self)
    --判断已领取
    if activity.ActivityManager:checkIsGotDailyReward(activity.ActivityId.SelectBuy) then
        return
    end
    GameDispatcher:dispatchEvent(EventName.REQ_GET_ACTIVITY_DAILY_REWARD, {activity_id = activity.ActivityId.SelectBuy})
end

return _M
