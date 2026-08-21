module("lottery.LotteryGamePanel", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("lottery/LotteryGamePanel.prefab")

-- 构造函数
function ctor(self)
    super.ctor(self)

end

function initData(self)
    self.allCount = 28
    self.doubleItemDic = {}
    self.cardItemDic = {}

    self.propsItems = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mTxtTimerTitle = self:getChildGO("mTxtTimerTitle"):GetComponent(ty.Text)
    self.mTxtTimer = self:getChildGO("mTxtTimer"):GetComponent(ty.Text)
    self.mSliderBg = self:getChildTrans("mSliderBg"):GetComponent(ty.RectTransform)
    self.mSlider = self:getChildTrans("mSlider"):GetComponent(ty.RectTransform)
    self.mDoubleItem = self:getChildGO("mDoubleItem")
    self.mTxtCur = self:getChildGO("mTxtCur"):GetComponent(ty.Text)
    self.mBtnRule = self:getChildGO("mBtnRule")
    self.mTxtTarget = self:getChildGO("mTxtTarget"):GetComponent(ty.Text)
    self.mImgTargetIcon = self:getChildGO("mImgTargetIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtTargetCount = self:getChildGO("mTxtTargetCount"):GetComponent(ty.Text)
    self.mImgGeted = self:getChildGO("mImgGeted")
    self.mCardContent = self:getChildTrans("mCardContent")
    self.mCardItem = self:getChildGO("mCardItem")
    self.mTxtRound = self:getChildGO("mTxtRound"):GetComponent(ty.Text)
    self.mBtnNext = self:getChildGO("mBtnNext")
    self.mBtnMul = self:getChildGO("mBtnMul")

    self.mTargetInfo = self:getChildGO("mTargetInfo")
    self.mFX_01 = self:getChildGO("mFX_01")
end

function initViewText(self)
    self:setBtnLabel(self.mBtnNext, 138104, "")
    self:setBtnLabel(self.mBtnMul, 138105, "")
    self.mTxtTimerTitle.text = _TT(94557)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnRule, self.onClickRule)
    self:addUIEvent(self.mBtnNext, self.onClickNext)
    self:addUIEvent(self.mBtnMul, self.onClickMul)
    self:addUIEvent(self.mTargetInfo, self.onClickTargetInfo)
end

function onClickTargetInfo(self)
    local mainTid = self.lotteryDataVo:getDesPropsItemId(1)
    local propsVo = props.PropsManager:getPropsConfigVo(mainTid)
    TipsFactory:propsTips({
        propsVo = propsVo
    })
end

function onClickRule(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_LOTTERY_RULE_PANEL)
end

function onClickNext(self)
    local function toNext()
        GameDispatcher:dispatchEvent(EventName.REQ_LOTTERY_NEXT)
    end
    self.isGetedMain = self:getMainIsGeted()
    if self.isGetedMain == false then
        gs.Message.Show(_TT(138109))
        return
    end
    if #self.showCardList < self.allCount then
        -- gs.Message.Show(_TT(138106))
        UIFactory:alertMessge(_TT(138106), true, function()
            toNext()
        end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
    else
        toNext()
    end

end

function onClickMul(self)
    local tid = self.lotteryDataVo.costOneId
    local num = self.lotteryDataVo.costOneNum
    local result, tips = MoneyUtil.judgeNeedMoneyCountByTid(tid, num, true, true)
    if tips == "" and result then
        local isGeted = self:getMainIsGeted()
        local tid = self.lotteryDataVo.costOneId
        local propsVo = props.PropsManager:getPropsConfigVo(tid)

        if isGeted then
            UIFactory:alertMessge(_TT(138108, propsVo:getName()), true, function()
                GameDispatcher:dispatchEvent(EventName.CELEBRATION_NOCLICK, true)
                GameDispatcher:dispatchEvent(EventName.REQ_LOTTERY_SELECT, {
                    pos = 0
                })
            end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
        else
            UIFactory:alertMessge(_TT(138107, propsVo:getName()), true, function()
                GameDispatcher:dispatchEvent(EventName.CELEBRATION_NOCLICK, true)
                GameDispatcher:dispatchEvent(EventName.REQ_LOTTERY_SELECT, {
                    pos = 0
                })
            end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
        end
    else
        gs.Message.Show(_TT(76019))
        self:checkOpenShopBuyPanel(ShopType.HIDE_SHOP_TWO, MoneyTid.LOTTERY)
    end
end

-- 打开快捷购买窗口
function checkOpenShopBuyPanel(self, shopType, tid)
    local shopVo = shop.ShopManager:getShopItemByTid(shopType, tid)
    if shopVo then
        GameDispatcher:dispatchEvent(EventName.OPEN_SHOP_BUY_PANEL, shopVo)
        return true
    else
        return false
    end
end

function active(self, args)
    super.active(self, args)
    self.mFX_01:SetActive(false)
    MoneyManager:setMoneyTidList({MoneyTid.LOTTERY, MoneyTid.PAY_ITIANIUM_TID})
    GameDispatcher:addEventListener(EventName.UPDATE_LOTTERY_PANEL, self.updateShowPanel, self)
    GameDispatcher:addEventListener(EventName.UPDATE_LOTTERY_GAME_PANEL, self.resultHander, self)
    self:showPanel()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:clearAll()
    GameDispatcher:removeEventListener(EventName.UPDATE_LOTTERY_PANEL, self.updateShowPanel, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_LOTTERY_GAME_PANEL, self.resultHander, self)
    MoneyManager:setMoneyTidList({MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID})
    if self.updateTimeSn then
        LoopManager:removeTimerByIndex(self.updateTimeSn)
        self.updateTimeSn = nil
    end

    if self.tweenSn then
        LoopManager:removeTimerByIndex(self.tweenSn)
        self.tweenSn = nil
    end
end

function updateShowPanel(self)
    self.mFX_01:SetActive(false)
    self.mFX_01:SetActive(true)

    for k, v in pairs(self.cardItemDic) do
        v:getGo():GetComponent(ty.Animator):SetTrigger("show")
        v:getChildGO("mMainFx"):SetActive(false)
        v:getChildGO("mImgDouble"):SetActive(false)
    end
    self:clearPropsItem()
    self.tweenSn = LoopManager:addTimer(0.3, 0, self, function()
        --self.mFX_01:SetActive(false)
        self:showPanel()
        LoopManager:removeTimerByIndex(self.tweenSn)
        self.tweenSn = nil
    end)
end

function resultHander(self)
    self.curTime = lottery.LotteryManager:getCurTimes()
    local pro = 0
    if self.curTime >= self.maxNum then
        pro = 1
    else
        pro = self.curTime / self.maxNum
    end
    gs.TransQuick:SizeDelta01(self.mSlider, self.needH * pro)

    local result = lottery.LotteryManager:getLotteryResultData()
    if result == nil then
        return
    end
    local posDic = {}
    for i = 1, #result do
        for j = 1, #result[i].item_list, 1 do
            result[i].item_list[j].count = result[i].item_list[j].count * result[i].multiple
        end
        posDic[result[i].pos] = result[i]
    end

    for k, v in pairs(posDic) do
        self.cardItemDic[k]:getChildGO("mFx"):SetActive(true)

        self.cardItemDic[k]:getChildGO("mImgDouble"):SetActive(v.multiple > 1)
        self.cardItemDic[k]:getChildGO("mTxtDouble"):GetComponent(ty.Text).text = "X" .. v.multiple

        local jackId = v.jack_pot_id
        self.cardItemDic[k]:getChildGO("mMainFx"):SetActive(jackId == 1)

        local tid = self.lotteryDataVo:getDesPropsItemId(jackId)
        local num = self.lotteryDataVo:getDesPropsItemNum(jackId)
        local propsGrid = PropsGrid:createByData({
            tid = tid,
            num = num,
            parent = self.cardItemDic[k]:getChildTrans("mPropsContent")
        })
        propsGrid:setScale(0.6)
        propsGrid:showCount(num)
        table.insert(self.propsItems, propsGrid)
    end

    self.isGetedMain = self:getMainIsGeted()
    self.mImgGeted:SetActive(self.isGetedMain)
    self:updateLotteryFx()
    self.retween = LoopManager:addTimer(0.3, 0, self, function()
        if result ~= nil then
            local awardList = {}
            for k, v in pairs(posDic) do
                for i = 1, #v.item_list, 1 do
                    table.insert(awardList, v.item_list[i])
                end
            end
            ShowAwardPanel:showPropsAwardMsgNoSort(awardList)
            GameDispatcher:dispatchEvent(EventName.CELEBRATION_NOCLICK, false)
        end
        LoopManager:removeTimerByIndex(self.retween)
        self.retween = nil
    end)
    self:updateLotteryFx()

    self.mBtnMul:SetActive(self.allCount ~= #self.showCardList)
end

function updateLotteryFx(self)
    self.curTime = lottery.LotteryManager:getCurTimes()
    for k, v in pairs(self.doubleItemDic) do
        v:getChildGO("mFX_02"):SetActive(self.curTime == k - 1)
    end
end

function showPanel(self)
    self:clearAll()
    self.curRound = lottery.LotteryManager:getCurRound()
    self.curTime = lottery.LotteryManager:getCurTimes()
    self.showCardList = lottery.LotteryManager:getShowCardList()

    self.mTxtRound.text = _TT(138103, self.curRound)

    self.maxRound = lottery.LotteryManager:getMaxLotteryRound()
    if self.curRound > self.maxRound then
        self.curRound = self.maxRound
    end
    self.lotteryDataVo = lottery.LotteryManager:getLotteryDataByRound(self.curRound)
    self.maxNum = 0
    -- self.doubleNumList = {}
    for i = 1, #self.lotteryDataVo.numWeight, 1 do
        local doubleItem = SimpleInsItem:create(self.mDoubleItem, self.mSliderBg, "lotteryDoubleItem")
        doubleItem:getChildGO("mTxtDoubleItem"):GetComponent(ty.Text).text = _TT(138102)
        doubleItem:getChildGO("mTxtDoubleCount"):GetComponent(ty.Text).text = self.lotteryDataVo.numWeight[i][1]
        if self.lotteryDataVo.numWeight[i][1] > self.maxNum then
            self.maxNum = self.lotteryDataVo.numWeight[i][1]
        end
        self.doubleItemDic[self.lotteryDataVo.numWeight[i][1]] = doubleItem
        -- table.insert(self.doubleNumList, self.lotteryDataVo.numWeight[i][1] - 1)
    end

    self:updateLotteryFx()
    self.needH = self.mSliderBg.sizeDelta.x
    for k, item in pairs(self.doubleItemDic) do
        if k ~= self.maxNum then
            gs.TransQuick:UIPos(item:getGo():GetComponent(ty.RectTransform), self.needH * k / self.maxNum, 0)
        else
            gs.TransQuick:UIPos(item:getGo():GetComponent(ty.RectTransform), self.needH, 0)
        end
    end
    local pro = 1
    if self.curTime >= self.maxNum then
        pro = 1
    else
        pro = self.curTime / self.maxNum
    end
    gs.TransQuick:SizeDelta01(self.mSlider, self.needH * pro)

    for i = 1, self.allCount, 1 do
        local cardItem = SimpleInsItem:create(self.mCardItem, self.mCardContent, "lotteryCardItem")
        cardItem:getChildGO("mFx"):SetActive(false)
        local cardInfo = self:getCardInfo(i)
        cardItem:getChildGO("mMainFx"):SetActive(false)
        if cardInfo ~= nil then
            cardItem:getChildGO("mImgDouble"):SetActive(cardInfo.multiple > 1)
            cardItem:getChildGO("mTxtDouble"):GetComponent(ty.Text).text = "X" .. cardInfo.multiple

            local jackId = cardInfo.jack_pot_id
            cardItem:getChildGO("mMainFx"):SetActive(jackId == 1)
            local tid = self.lotteryDataVo:getDesPropsItemId(jackId)
            local num = self.lotteryDataVo:getDesPropsItemNum(jackId)
            local propsGrid = PropsGrid:createByData({
                tid = tid,
                num = num,
                parent = cardItem:getChildTrans("mPropsContent")
            })
            propsGrid:setScale(0.6)
            propsGrid:showCount(num)
            table.insert(self.propsItems, propsGrid)
        else
            cardItem:getChildGO("mImgDouble"):SetActive(false)
        end

        cardItem:addUIEvent(nil, function()
            if cardInfo == nil then
                self:onClickCard(i)
            end
        end)
        self.cardItemDic[i] = cardItem
    end
    local mainTid = self.lotteryDataVo:getDesPropsItemId(1)
    local mainNum = self.lotteryDataVo:getDesPropsItemNum(1)

    self.mImgTargetIcon:SetImg(UrlManager:getPropsIconUrl(mainTid), false)
    self.mTxtTargetCount.text = mainNum

    self.isGetedMain = self:getMainIsGeted()
    self.mImgGeted:SetActive(self.isGetedMain)

    self.isMaxRound = lottery.LotteryManager:getMaxLotteryRound() == self.curRound

    -- self.mBtnNext:SetActive(not self.isMaxRound)
    self.mBtnMul:SetActive(self.allCount ~= #self.showCardList)
    if self.updateTimeSn then
        LoopManager:removeTimerByIndex(self.updateTimeSn)
        self.updateTimeSn = nil
    end

    self:updateTime()
    self.updateTimeSn = LoopManager:addTimer(1, 0, self, self.updateTime)
end

function updateTime(self)
    if activity.ActivityManager:getActivityVoById(activity.ActivityId.Lottery) then
        local clientTime = GameManager:getClientTime()
        local remainingTime = activity.ActivityManager:getActivityVoById(activity.ActivityId.Lottery):getEndTime() -
                                  clientTime
        local timeTxt = remainingTime <= 0 and "活动已结束" or TimeUtil.getFormatTimeBySeconds_9(remainingTime)

        self.mTxtTimer.text = timeTxt

        if remainingTime <= 0 then
            LoopManager:removeTimerByIndex(self.updateTimeSn)
            self.updateTimeSn = nil
            -- self:close()
            return
        end
    end
end

function onClickCard(self, pos)
    local cardInfo = self:getCardInfo(pos)
    if cardInfo ~= nil then
        return
    end

    local tid = self.lotteryDataVo.costOneId
    local num = self.lotteryDataVo.costOneNum
    local result, tips = MoneyUtil.judgeNeedMoneyCountByTid(tid, num, true, true)
    if tips == "" and result then
        GameDispatcher:dispatchEvent(EventName.CELEBRATION_NOCLICK, true)
        GameDispatcher:dispatchEvent(EventName.REQ_LOTTERY_SELECT, {
            pos = pos
        })
    else
        gs.Message.Show(tips)
        self:checkOpenShopBuyPanel(ShopType.HIDE_SHOP_TWO, MoneyTid.LOTTERY)
    end
end

function getCardInfo(self, cardId)
    for i = 1, #self.showCardList, 1 do
        if self.showCardList[i].pos == cardId then
            return self.showCardList[i]
        end
    end
    return nil
end

function getMainIsGeted(self)
    self.showCardList = lottery.LotteryManager:getShowCardList()
    for i = 1, #self.showCardList do
        if self.showCardList[i].jack_pot_id == 1 then
            return true
        end
    end
    return false
end

function clearAll(self)
    self:clearDoubleItem()
    self:clearCardItem()
    self:clearPropsItem()
end

function clearCardItem(self)
    for k, item in pairs(self.cardItemDic) do
        item:poolRecover()
    end
    self.cardItemDic = {}
end

function clearDoubleItem(self)
    for k, item in pairs(self.doubleItemDic) do
        item:poolRecover()
    end
    self.doubleItemDic = {}
end

function clearPropsItem(self)
    for i = 1, #self.propsItems, 1 do
        self.propsItems[i]:poolRecover()
    end
    self.propsItems = {}
end

return _M
