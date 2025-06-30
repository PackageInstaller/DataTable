-- 回归礼包的购买界面
module('game.returned.view.ReturnedBuyMoneyView', Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("purchase/DirectBuyMoneyView.prefab")

panelType = 2 -- 窗口类型 1 全屏 2 弹窗
destroyTime = 0

function ctor(self)
    super.ctor(self)
    self:setSize(1120, 520)
    --self:setTxtTitle('')
end

function initData(self)
    self.mSubPropsItem = {}
    self.mTimeCountSn = nil
end

function configUI(self)
    self.mCloseMask = self:getChildGO("CloseMask")
    self.mTxtName = self:getChildGO('mTxtName'):GetComponent(ty.Text)

    self.mTxtLimit = self:getChildGO('mTxtLimit'):GetComponent(ty.Text)
    self.mTxtDes = self:getChildGO('mTxtDes'):GetComponent(ty.Text)
    self.mBtnBuy = self:getChildGO('mBtnBuy')
    self.mTxtTimeCount = self:getChildGO('mTxtTimeCount'):GetComponent(ty.Text)
    self.mImgIcon = self:getChildGO('mImgIcon'):GetComponent(ty.AutoRefImage)
    self.mTxtPrePrice = self:getChildGO("mTxtPrePrice"):GetComponent(ty.Text)
    self.mColorMask = self:getChildGO("mColorMask"):GetComponent(ty.AutoRefImage)
    --add
    self.mImgDisco = self:getChildGO("mImgDisco"):GetComponent(ty.Image)
    self.mTxtDisco = self:getChildGO("mTxtDisco"):GetComponent(ty.Text)

    self.mGroupOnePrice = self:getChildGO('GroupOnePrice')
    self.mPropMoneyIcon = self:getChildGO("PropMoneyIcon"):GetComponent(ty.AutoRefImage)
    self.mPropTxtPrice = self:getChildGO("mPropTxtPrice"):GetComponent(ty.Text)
    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mTxtCost = self:getChildGO("mTxtCost"):GetComponent(ty.Text)
    self.mGroupBuy = self:getChildGO("mGroupBuy")
    self.mGroupSub = self:getChildTrans("mGroupSub")

    self.mGroupStamina = self:getChildGO("mGroupStamina")
    self.mGroupSub2 = self:getChildTrans("mGroupSub2")
end

function active(self, args)
    super.active(self, args)
    GameDispatcher:addEventListener(EventName.UPDATE_DIRECT_BUY_INFO, self.onDirectBuyComplete, self)

    self.mDirectBuyVo = args
    self:setData()
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_DIRECT_BUY_INFO, self.onDirectBuyComplete, self)

    self:recoverSubPropsItem()
    self:recoverListItem()
    self:recoverTimer()
end

function addAllUIEvent(self)
    self:addUIEvent(self.mCloseMask, self.onClickClose)
    self:addUIEvent(self.mBtnBuy, self.__onBuyHandler)
    self:addUIEvent(self.mBtnClose, self.close)
end

function initViewText(self)
    self:setBtnLabel(self.mBtnBuy, 9, "购买")
    self.mTxtCost.text = _TT(50066) --"消耗"
end

function setData(self)
    self.mTxtName.text = self.mDirectBuyVo:getItemName()
    local limitNum = self.mDirectBuyVo:getLimit()
    local hadBuyNum = purchase.DirectBuyManager:getHadBuyNum(self.mDirectBuyVo:getId())
    if (limitNum == 0 and self.mDirectBuyVo:getLimitType() == purchase.DirectBuyLimitType.UN_LIMIT) then
        self.mTxtLimit.text = _TT(25009) .. "∞"
    else
        if (limitNum - hadBuyNum > 0) then
            self.mTxtLimit.text = _TT(25009) .. (limitNum - hadBuyNum)
        else
            self.mTxtLimit.text = ""
        end
    end

    local propsVo = props.PropsManager:getPropsVo({ tid = self.mDirectBuyVo:getItemTid(), num = self.mDirectBuyVo:getItemNum() })
    self.mImgIcon:SetImg(UrlManager:getPropsIconUrl(propsVo.tid), false)
    self.mColorMask:SetImg(UrlManager:getPackPath("shop/shop_tips_color_" .. propsVo.color .. ".png"), false)
    self.mTxtDes.text = propsVo:getDes()

    if (self.mDirectBuyVo:getPrice() <= 0) then
        self.mGroupOnePrice:SetActive(false)
    else
        self.mGroupOnePrice:SetActive(true)
        self.mPropMoneyIcon:SetImg(self.mDirectBuyVo:getPayIcon(), true)
        local txt = self.mDirectBuyVo:getPrice()
        self.mPropMoneyIcon.gameObject:SetActive(true)
        if self.mDirectBuyVo:getPayType() == MoneyType.MONEY then
            self.mPropMoneyIcon.gameObject:SetActive(false)
            txt = _TT(50011, txt) -- .. "元"
        end
        self.mPropTxtPrice.text = txt
    end

    local tag = self.mDirectBuyVo:getTag()
    self.mImgDisco.gameObject:SetActive(tag == 2)
    self.mTxtPrePrice.gameObject:SetActive(false)
    if tag == 0 then

    elseif tag == 1 then

    elseif tag == 2 then
        self.mTxtDisco.text = self.mDirectBuyVo:getPriceRatio()
    elseif tag == 3 then

    end

    self:recoverSubPropsItem()
    self:recoverListItem()

    if self.mDirectBuyVo:getId() == tonumber(recharge.rechargeDirectId.sevenStamina) then
        -- 7天体力礼包（体力周卡）
        self.mGroupBuy:SetActive(false)
        self.mGroupStamina:SetActive(true)

        local param = sysParam.SysParamManager:getValue(SysParamType.DIRECT_BUY_STAMINA)
        for i = 1, 7 do
            local item = SimpleInsItem:create(self:getChildGO("GroupStaminaItem"), self.mGroupSub2, "DupImpliedDupPanelEnterItem")
            item:setText("mTxtStaminaDay", nil, string.format("%02d", i))
            local propsItem = PropsGrid:create(item:getChildTrans("mGrouStaminaProps"), param)
            table.insert(self.mSubPropsItem, propsItem)
            table.insert(self.mStaminaItemList, item)
        end
    else
        self.mGroupBuy:SetActive(true)
        self.mGroupStamina:SetActive(false)

        local subProps = AwardPackManager:getAwardListById(self.mDirectBuyVo:getDropId())
        if (subProps) then
            for k, v in pairs(subProps) do
                local item = PropsGrid:create(self.mGroupSub, v, 1)
                table.insert(self.mSubPropsItem, item)
            end
        end
    end


    -- self.mTxtTimeCount.text = _TT(50012, TimeUtil.getFormatTimeBySeconds_10(deltaTime))
    local timeCount = function()
        local deltaTime = self.mDirectBuyVo:getEndTime() - GameManager:getClientTime()
        if (deltaTime > 0) then
            self.mTxtTimeCount.text = _TT(50012, TimeUtil.getFormatTimeBySeconds_10(deltaTime))
            self.mTxtTimeCount.gameObject:SetActive(true)
        else
            self.mTxtTimeCount.gameObject:SetActive(false)
        end
    end
    self:recoverTimer()
    if (self.mDirectBuyVo:getEndTime() ~= 0 and self.mDirectBuyVo:getEndTime() > GameManager:getClientTime()) then
        self.mTimeCountSn = LoopManager:addTimer(1, 0, self, timeCount)
    end
    timeCount()
end
-- 回收项
function recoverListItem(self)
    if self.mStaminaItemList then
        for i, v in pairs(self.mStaminaItemList) do
            v:poolRecover()
        end
    end
    self.mStaminaItemList = {}
end
-- 回收计时器
function recoverTimer(self)
    if (self.mTimeCountSn) then
        LoopManager:removeTimerByIndex(self.mTimeCountSn)
        self.mTimeCountSn = nil
    end
end

-- 购买按钮
function __onBuyHandler(self)
    local costTid = sysParam.SysParamManager:getValue(SysParamType.ARENA_CHALLENGE_COST_TID)
    --local shopVo = shop.ShopManager:getShopItemByTid(ShopType.NOMAL, costTid)
    if self.mDirectBuyVo.item_tid == costTid and self.mDirectBuyVo:getBuyTimes() >= self.mDirectBuyVo:getLimit() then
        gs.Message.Show(_TT(1379))
        return
    end

    local result, tips = MoneyUtil.judgeNeedMoneyCountByTid(self.mDirectBuyVo:getRealPayType(), self.mDirectBuyVo:getPrice(), true, true)
    if result and tips == "" then
        GameDispatcher:dispatchEvent(EventName.REQ_SHOP_BUY, { type = self.mDirectBuyVo:getType(), id = self.mDirectBuyVo:getId(), num = 1 })
        self:close()
    elseif result and tips ~= "" then
        UIFactory:alertMessge(tips, true, function()
            GameDispatcher:dispatchEvent(EventName.REQ_SHOP_BUY, { type = self.mDirectBuyVo:getType(), id = self.mDirectBuyVo:getId(), num = 1 })
            self:close()
        end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil
        )
    elseif not result then
        UIFactory:alertMessge(tips, true, function()
            GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = LinkCode.Purchase })
            self:close()
        end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil
        )
    end
end

function onDirectBuyComplete(self)
    self:close()
end

-- 回收展示内容项
function recoverSubPropsItem(self)
    for k, v in pairs(self.mSubPropsItem) do
        v:poolRecover()
    end
    self.mSubPropsItem = {}
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(50022):	"免费"
	语言包: _TT(50022):	"免费"
]]