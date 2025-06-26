-- @FileName:   RoundPrizePanel.lua
-- @Description:   描述
-- @Author: ZDH
-- @Date:   2024-12-20 17:42:57
-- @Copyright:   (LY) 2024 锚点降临

module("game.roundPrize.RoundPrizePanel", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("roundPrize/RoundPrizePanel.prefab")

-- 构造函数
function ctor(self)
    super.ctor(self)

end

function initData(self)

end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mBgImg = self:getChildGO("bg_1"):GetComponent(ty.AutoRefImage)
    self.mTextPrizeNum = self:getChildGO("mTextPrizeNum"):GetComponent(ty.Text)
    self.mTextActivityTime = self:getChildGO("mTextActivityTime"):GetComponent(ty.Text)
    self.mTextPrizeVal = self:getChildGO("mTextPrizeVal"):GetComponent(ty.Text)

    self.mBtnShop = self:getChildGO("mBtnShop")
    self.mBtnRule = self:getChildGO("mBtnRule")
    self.mBtn_Ten = self:getChildGO("mBtn_Ten")
    self.mBtn_One = self:getChildGO("mBtn_One")

    self.mImgMoneyTen = self:getChildGO("mImgMoneyTen"):GetComponent(ty.AutoRefImage)
    self.mImgMoneyOne = self:getChildGO("mImgMoneyOne"):GetComponent(ty.AutoRefImage)

    self.mTextMoneyTen = self:getChildGO("mTextMoneyTen"):GetComponent(ty.Text)
    self.mTextMoneyOne = self:getChildGO("mTextMoneyOne"):GetComponent(ty.Text)

    self.mProgressItem = self:getChildGO("mProgressItem")

    self.mRewardTips = self:getChildGO("mRewardTips"):GetComponent(ty.RectTransform)
    self.mText_1 = self:getChildGO("mText_1"):GetComponent(ty.Text)
    self.mTextRewardTips = self:getChildGO("mTextRewardTips"):GetComponent(ty.Text)
    self.mRewardGroup = self:getChildTrans("mRewardGroup")

    self.mSkipTween = self:getChildGO("mSkipTween")
    self.mImgSkip = self:getChildGO("mImgSkip"):GetComponent(ty.AutoRefImage)
    self.mText_2 = self:getChildGO("mText_2"):GetComponent(ty.Text)

    self.mImgSelect = self:getChildGO("mImgSelect"):GetComponent(ty.RectTransform)
    self.mEffect01 = self:getChildGO("mEffect01")

    self.mClosePropsTips = self:getChildGO("mClosePropsTips")

    self.shopRed = self:getChildGO("shopRed")
end

function initViewText(self)
    self:setBtnLabel(self.mBtnShop, 121200)
    self:setBtnLabel(self.mBtnRule, 121201)
    self:setBtnLabel(self.mBtn_Ten, 121204)
    self:setBtnLabel(self.mBtn_One, 121203)
    self.mText_2.text = _TT(121212)
    self.mText_1.text = _TT(121213)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnShop, self.onClickShop)
    self:addUIEvent(self.mBtnRule, self.onClickRule)
    self:addUIEvent(self.mBtn_Ten, self.onClickTen)
    self:addUIEvent(self.mBtn_One, self.onClickOne)

    self:addUIEvent(self.mTextPrizeVal.gameObject, self.onClickRule)

    self:addUIEvent(self.mSkipTween, self.onClickSkip)
    self:addUIEvent(self.mClosePropsTips, self.onClickClosePropsTips)
end

-- 激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({ MoneyTid.ROUNDPRIZE_PROPS, MoneyTid.PAY_ITIANIUM_TID })

    GameDispatcher:addEventListener(EventName.ROUNDPRIZE_ONRECEIVEMAINPANMSG, self.refreshView, self)
    GameDispatcher:addEventListener(EventName.ROUNDPRIZE_ONRECEIVEPRIZEHANDLER, self.onPrize, self)
    bag.BagManager:addEventListener(bag.BagManager.BAG_UPDATE, self.bagUpdate, self)

    shop.ShopManager:addEventListener(shop.ShopManager.EVENT_SHOP_DATA_UPDATE, self.refreshShopRed, self)
    shop.ShopManager:addEventListener(shop.ShopManager.EVENT_SHOP_TYPE_UPDATE, self.onShopUpdateHandler, self)
    shop.ShopManager:addEventListener(shop.ShopManager.EVENT_SHOP_ITEM_UPDATE, self.refreshShopRed, self)

    self.m_SkipTween = StorageUtil:getBool1(gstor.ROUNDPRIZE_SKIPTWEEN)
    self:refreshSkipImg()

    if self.mRewardTips.gameObject.activeInHierarchy then
        self.mRewardTips.gameObject:SetActive(false)
        self.mClosePropsTips:SetActive(false)
    end

    self.mImgSelect.gameObject:SetActive(false)
    self.mEffect01:SetActive(false)

    local mainActivityVo = mainActivity.MainActivityManager:getMainActivityVoById(activity.ActivityId.RoundPrize)
    local overTime = mainActivityVo:getOverTimeDt()

    local md, hm = TimeUtil.getMDHByTime2(overTime)
    self.mTextActivityTime.text = _TT(121009, md .. " " .. hm)

    self.m_PrizeconfigVo = roundPrize.RoundPrizeManager:getProbabilityConfigVo()
    if self.m_PrizeconfigVo then
        self:clearPropsGrid()

        self.m_SelectAnchoredPosition_list = {}
        self.m_probabilityList = self.m_PrizeconfigVo:getProbabilityList()
        for i = 1, #self.m_probabilityList do
            local rectTrans = self:getChildTrans(string.format("mPropNode (%s)", i)):GetComponent(ty.RectTransform)

            local PropGrid = PropsGrid:createByData({ tid = self.m_probabilityList[i].tid, num = self.m_probabilityList[i].count, parent = rectTrans, showUseInTip = true })
            table.insert(self.m_PropsGridList, PropGrid)

            self.m_SelectAnchoredPosition_list[i] = rectTrans.anchoredPosition
        end
    end

    self:refreshMoney()
    self:refreshView()
    self:refreshShopRed()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList({})

    self:clearPropsGrid()
    self:clearProgressItem()
    self:clearPropsGrid()
    self:removeTweenFrameSn()
    self.m_TweenIndex = nil

    GameDispatcher:removeEventListener(EventName.ROUNDPRIZE_ONRECEIVEMAINPANMSG, self.refreshView, self)
    GameDispatcher:removeEventListener(EventName.ROUNDPRIZE_ONRECEIVEPRIZEHANDLER, self.onPrize, self)
    bag.BagManager:removeEventListener(bag.BagManager.BAG_UPDATE, self.bagUpdate, self)

    shop.ShopManager:removeEventListener(shop.ShopManager.EVENT_SHOP_DATA_UPDATE, self.refreshShopRed, self)
    shop.ShopManager:removeEventListener(shop.ShopManager.EVENT_SHOP_TYPE_UPDATE, self.onShopUpdateHandler, self)
    shop.ShopManager:removeEventListener(shop.ShopManager.EVENT_SHOP_ITEM_UPDATE, self.refreshShopRed, self)
end

function onShopUpdateHandler(self, cusType)
    if cusType == ShopType.ROUNDPRIZE then
        self:refreshShopRed()
    end
end

function bagUpdate(self)
    self:refreshShopRed()
    self:refreshMoney()
end

function refreshShopRed(self)
    self.shopRed:SetActive(roundPrize.RoundPrizeManager:isShowShopRed())
end

function refreshMoney(self)
    local color = MoneyUtil.getMoneyCountByTid(self.m_PrizeconfigVo.cost_ten_id) >= self.m_PrizeconfigVo.cost_ten_num and "202226" or "FF0000"
    self.mTextMoneyTen.text = string.format("<color=#%s>%s</color>", color, self.m_PrizeconfigVo.cost_ten_num)

    color = MoneyUtil.getMoneyCountByTid(self.m_PrizeconfigVo.cost_one_id) >= self.m_PrizeconfigVo.cost_one_num and "202226" or "FF0000"
    self.mTextMoneyOne.text = string.format("<color=#%s>%s</color>", color, self.m_PrizeconfigVo.cost_one_num)

    self.mImgMoneyTen:SetImg(MoneyUtil.getMoneyIconUrlByTid(self.m_PrizeconfigVo.cost_ten_id), false)
    self.mImgMoneyOne:SetImg(MoneyUtil.getMoneyIconUrlByTid(self.m_PrizeconfigVo.cost_one_id), false)
end

function refreshView(self)
    local main_info = roundPrize.RoundPrizeManager:getMainInfo()
    if main_info then
        self.mTextPrizeNum.text = _TT(121199, main_info.acc_times)
        self.mTextPrizeVal.text = _TT(121202, main_info.unlucky_times)

        local rewardConfigVo = roundPrize.RoundPrizeManager:getRewardConfigVo()
        if rewardConfigVo then
            self:clearProgressItem()
            for i = 1, #rewardConfigVo do
                local item = SimpleInsItem:create(self.mProgressItem, self:getChildTrans("mPoint_" .. i), "RoundPrizePanel_ProgressItem")
                item:setPos()
                table.insert(self.m_ProgressItemList, item)

                item:getChildGO("mTextLabel"):GetComponent(ty.Text).text = _TT(121205, rewardConfigVo[i].id)

                local isGet = roundPrize.RoundPrizeManager:isGetReward(rewardConfigVo[i].id)
                item:getChildGO("mGeted"):SetActive(isGet)
                item:getChildGO("mImgBg_1"):SetActive(not isGet)
                item:getChildGO("mImgBg_2"):SetActive(isGet)

                local canGet = main_info.acc_times >= rewardConfigVo[i].id
                item:getChildGO("mRed"):SetActive(canGet and not isGet)

                item:getChildGO("mImgPint"):SetActive(canGet)

                item:addUIEvent("mClick", function()
                    if canGet and not isGet then
                        GameDispatcher:dispatchEvent(EventName.ROUNDPRIZE_ONREQGETREWARD, rewardConfigVo[i].id)
                        return
                    end

                    self:onShowRewardTips(i, rewardConfigVo[i])
                end)
            end

            for i = 2, #rewardConfigVo do
                self:getChildGO("mImgProgress_" .. (i - 1)):GetComponent(ty.Image).fillAmount = (main_info.acc_times - rewardConfigVo[i - 1].id) / (rewardConfigVo[i].id - rewardConfigVo[i - 1].id)
            end
        end
    end
    
    if (RefMgr:getSpecialConfig() and sdk.SdkManager:getIsChannelHarmonious()) then
        self.mBgImg:SetImg(UrlManager:getBgPath("roundPrize/bg_01_har.jpg"))
    else
        self.mBgImg:SetImg(UrlManager:getBgPath("roundPrize/bg_01.jpg"))
    end
end

function onPrize(self, msg)
    if gs.Application.isEditor then
        roundPrize.RoundPrizeShowAwardPanel = require('game/roundPrize/view/RoundPrizeShowAwardPanel')
    end

    if self.m_SkipTween then
        roundPrize.RoundPrizeShowAwardPanel:showPropsAwardMsg(msg.award, function()
            self.mImgSelect.gameObject:SetActive(false)
            self.mEffect01:SetActive(false)
        end)
        return
    end

    self.m_PrizeAward = msg.award

    self.m_TweenPos = nil

    local order_list = msg.order_list
    for i = 1, #order_list do
        local reward = self.m_probabilityList[order_list[i]]
        if reward.tid == self.m_PrizeconfigVo.minimum_item then
            self.m_TweenPos = order_list[i]
            break
        else
            local max_quality = 0
            local rewardConfigVo = props.PropsManager:getPropsConfigVo(reward.tid)
            if rewardConfigVo.color > max_quality then
                max_quality = rewardConfigVo.color
                self.m_TweenPos = order_list[i]
            end
        end
    end

    self:onStartPrizeTween()
end

function onStartPrizeTween(self)
    GameDispatcher:dispatchEvent(EventName.CELEBRATION_NOCLICK, true)

    self.m_TweenIndex = 0

    self.m_TweenTime = 0
    self.m_TweenSpeed = 3

    self:removeTweenFrameSn()
    self.m_TweenFrameSn = LoopManager:addFrame(1, 0, self, self.refreshSelect)
end

function refreshSelect(self)
    if self.m_TweenTime >= 0.15 then
        self.m_TweenIndex = self.m_TweenIndex + 1
        if self.m_TweenIndex > 12 then
            self.m_TweenIndex = 1
        end

        self.mImgSelect.anchoredPosition = self.m_SelectAnchoredPosition_list[self.m_TweenIndex]
        self.m_TweenTime = 0

        if not self.mImgSelect.activeInHierarchy then
            self.mImgSelect.gameObject:SetActive(true)
        end
    end

    self.m_TweenTime = self.m_TweenTime + (gs.Time.deltaTime * self.m_TweenSpeed)
    if self.m_TweenSpeed <= 1 then
        if self.m_TweenIndex == self.m_TweenPos then
            self.mEffect01:SetActive(true)

            self:setTimeout(0.5, function()
                roundPrize.RoundPrizeShowAwardPanel:showPropsAwardMsg(self.m_PrizeAward, function()
                    self.mImgSelect.gameObject:SetActive(false)
                    self.mEffect01:SetActive(false)
                end)
                GameDispatcher:dispatchEvent(EventName.CELEBRATION_NOCLICK, false)
            end)
            self:removeTweenFrameSn()
        end
    else
        self.m_TweenSpeed = self.m_TweenSpeed - (gs.Time.deltaTime * 1.2)
    end
end

function removeTweenFrameSn(self)
    if self.m_TweenFrameSn then
        LoopManager:removeFrameByIndex(self.m_TweenFrameSn)
        self.m_TweenFrameSn = nil
    end
end

function onClickClosePropsTips(self)
    if self.mRewardTips.gameObject.activeInHierarchy then
        self.mRewardTips.gameObject:SetActive(false)
        self.mClosePropsTips:SetActive(false)
    end
end

function onClickShop(self)
    GameDispatcher:dispatchEvent(EventName.ROUNDPRIZE_OPENSHOPPANEL)
end

function onClickRule(self)
    GameDispatcher:dispatchEvent(EventName.ROUNDPRIZE_OPENRULEPANEL)
end

function onClickTen(self)
    self:sendPrize(10)
end

function onClickOne(self)
    self:sendPrize(1)
end

function onClickSkip(self)
    self.m_SkipTween = not self.m_SkipTween
    StorageUtil:saveBool1(gstor.ROUNDPRIZE_SKIPTWEEN, self.m_SkipTween)

    self:refreshSkipImg()
end

function refreshSkipImg(self)
    if self.m_SkipTween then
        self.mImgSkip:SetImg("arts/ui/pack/common5/common_0017.png")
    else
        self.mImgSkip:SetImg("arts/ui/pack/common5/common_0018.png")
    end
end

function sendPrize(self, num)
    local costTid = 0
    local costCount = 0

    local configVo = roundPrize.RoundPrizeManager:getProbabilityConfigVo()
    if configVo then
        if num == 1 then
            costTid = configVo.cost_one_id
            costCount = configVo.cost_one_num
        elseif num == 10 then
            costTid = configVo.cost_ten_id
            costCount = configVo.cost_ten_num
        end
    end

    local hasCount = MoneyUtil.getMoneyCountByTid(costTid)
    if (hasCount >= costCount) then
        GameDispatcher:dispatchEvent(EventName.ROUNDPRIZE_ONREQPRIZE, num)
    else
        local itemVo = props.PropsManager:getPropsConfigVo(costTid)
        if itemVo.type == 0 then
            logError("道具不足，商城无出售")
            return
        end

        local shopVo = shop.ShopManager:getShopItemByTid(ShopType.HIDE_SHOP, costTid)
        if (shopVo) then
            local needCount = costCount - hasCount
            local needMoney = needCount * shopVo:getPrice()
            local moneyTid = shopVo:getRealPayType()
            local moneyName = props.PropsManager:getName(moneyTid)

            local buyCall = function()
                local hasMoney = MoneyUtil.getMoneyCountByTid(moneyTid)
                if (hasMoney >= needMoney) then
                    GameDispatcher:dispatchEvent(EventName.REQ_SHOP_BUY, { type = shopVo:getType(), id = shopVo:getId(), num = needCount })
                else
                    UIFactory:alertMessge(_TT(66), true, function()
                        GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = LinkCode.Purchase })
                    end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
                end
            end

            local costName = props.PropsManager:getName(costTid)
            UIFactory:alertMessge(_TT(28038, needCount, costName, needMoney, moneyName), true, buyCall, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
        else
            gs.Message.Show(_TT(156))--"道具不足"
        end
    end
end

function onShowRewardTips(self, index, configVo)
    if not self.mRewardTips.gameObject.activeInHierarchy then
        self.mRewardTips.gameObject:SetActive(true)
        self.mClosePropsTips:SetActive(true)
    end

    if index == 1 then
        self.mRewardTips.anchoredPosition = gs.Vector2(-290, self.mRewardTips.anchoredPosition.y)
    elseif index == 2 then
        self.mRewardTips.anchoredPosition = gs.Vector2(-290, self.mRewardTips.anchoredPosition.y)
    elseif index == 5 then
        self.mRewardTips.anchoredPosition = gs.Vector2(-125, self.mRewardTips.anchoredPosition.y)
    else
        local anchoredPosition = self:getChildGO("mPoint_" .. index):GetComponent(ty.RectTransform).anchoredPosition
        self.mRewardTips.anchoredPosition = anchoredPosition
    end

    self.mTextRewardTips.text = _TT(121206, configVo.id)

    self:clearRewardProps()
    for i = 1, #configVo.reward do
        local PropGrid = PropsGrid:createByData({ tid = configVo.reward[i][1], num = configVo.reward[i][2], parent = self.mRewardGroup, showUseInTip = true })
        table.insert(self.m_RewardPropsList, PropGrid)
    end
end

function clearRewardProps(self)
    if self.m_RewardPropsList then
        for k, v in pairs(self.m_RewardPropsList) do
            v:poolRecover()
        end
    end

    self.m_RewardPropsList = {}
end

function clearPropsGrid(self)
    if self.m_PropsGridList then
        for k, v in pairs(self.m_PropsGridList) do
            v:poolRecover()
        end
    end

    self.m_PropsGridList = {}
end

function clearProgressItem(self)
    if self.m_ProgressItemList then
        for k, v in pairs(self.m_ProgressItemList) do
            v:poolRecover()
        end
    end

    self.m_ProgressItemList = {}
end

return _M