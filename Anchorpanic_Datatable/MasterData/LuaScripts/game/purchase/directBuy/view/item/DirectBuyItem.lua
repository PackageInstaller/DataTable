module('purchase.DirectBuyItem', Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mImGlow = self:getChildGO("mImGlow")
    self.TextFree = self:getChildGO("TextFree")
    self.mGoToucher = self:getChildGO("ImgToucher")
    self.mGoToucherImg = self:getChildGO("ImgToucher"):GetComponent(ty.AutoRefImage)
    self.mGroupEndTime = self:getChildGO("mGroupEndTime")
    self.mGroupSoldOut = self:getChildGO("mGroupSoldOut")
    self.mGroupMoneyPrice = self:getChildGO("GroupMoneyPrice")
    self.mTextName = self:getChildGO("TextName"):GetComponent(ty.Text)
    self.mImgDisco = self:getChildGO('ImgDisco'):GetComponent(ty.Image)
    self.mTextPrice = self:getChildGO("TextPrice"):GetComponent(ty.Text)
    self.mImgBotBg = self:getChildGO("mImgBotBg"):GetComponent(ty.Image)
    self.mTextDisco = self:getChildGO('TextDisco'):GetComponent(ty.Text)
    self.ImgDisco2 = self:getChildGO('ImgDisco2'):GetComponent(ty.Image)
    self.TextDisco2 = self:getChildGO('TextDisco2'):GetComponent(ty.Text)
    self.mTextRemain = self:getChildGO("TextRemain"):GetComponent(ty.Text)
    self.mTextEndTime = self:getChildGO("TextEndTime"):GetComponent(ty.Text)
    self.mTextSoldOut = self:getChildGO('TextSoldOut'):GetComponent(ty.Text)
    self.TextDisco2Dec = self:getChildGO("TextDisco2Dec"):GetComponent(ty.Text)
    self.mGridNode = self:getChildTrans("GridNode"):GetComponent(ty.AutoRefImage)
    self.mGridNodeEff = self:getChildTrans("GridNodeEff"):GetComponent(ty.AutoRefImage)
    self.mTextMoneyPrice = self:getChildGO("TextMoneyPrice"):GetComponent(ty.Text)
    self.mImgMoneyIcon = self:getChildGO('ImgMoneyIcon'):GetComponent(ty.AutoRefImage)
    self.mTextSoldOut.text = _TT(25011) -- "已售罄"
    self.TextDisco2Dec.text = "超值"
    self.mIsHot = self:getChildGO("mIsHot")
    self.mBgEff = self:getChildGO("mBgEff")
    self:addOnClick(self.mGoToucher, self.__onClickBuyHadler)
end

function setData(self, param)
    super.setData(self, param)
    local directBuyVo = self.data

    self.mGoToucherImg:SetImg(UrlManager:getPackPath("purchase/store_pnl_" .. directBuyVo.color .. ".png", false))
    self.mGridNode:SetImg(UrlManager:getPropsIconUrl(directBuyVo:getItemTid()), true)

    self.mGridNodeEff:SetImg(UrlManager:getPropsIconUrl(directBuyVo:getItemTid()), true)
    self.mBgEff:SetActive(directBuyVo.color == 3)

    local tag = directBuyVo:getTag()
    self.mImgDisco.gameObject:SetActive(false)
    self.ImgDisco2.gameObject:SetActive(false)
    self.mImGlow:SetActive(false)
    if tag == 0 then
    elseif tag == 1 then
        self.mTextDisco.text = _TT(50022) -- "免费"
    elseif tag == 2 then
        self.ImgDisco2.gameObject:SetActive(true)
        self.TextDisco2.text = directBuyVo:getPriceRatio()
        -- elseif tag == 3 then
        -- self.mIsHot:SetActive(true)
        -- self.mImgDisco.gameObject:SetActive(true)
        -- self.mImgDisco.color = gs.ColorUtil.GetColor("874cf2ff")
        -- self.mTextDisco.text = _TT(50035) --"热销"
    end
    self.mIsHot:SetActive(tag == 3)
    local limitNum = directBuyVo:getLimit()
    local hadBuyNum = purchase.DirectBuyManager:getHadBuyNum(directBuyVo:getId())
    self.mGroupSoldOut:SetActive(false)
    self.mImgBotBg.color = gs.ColorUtil.GetColor("000000ff")
    self.TextFree:GetComponent(ty.Text).text = _TT(50022)
    self.mTextRemain.gameObject:SetActive(true)
    if (limitNum == 0 and directBuyVo:getLimitType() == purchase.DirectBuyLimitType.UN_LIMIT) then
        self.mTextRemain.text = _TT(25009) .. "∞"
    else
        if (limitNum - hadBuyNum > 0) then
            self.TextFree:SetActive(false)
            self.mImgBotBg.enabled = true
            if tag == 1 then
                self.mImGlow:SetActive(true)
            end
            self.mTextRemain.text = _TT(25009) .. (limitNum - hadBuyNum)
            if directBuyVo:getPrice() <= 0 then
                RedPointManager:add(self.TextFree.transform, nil, 99.6, 16)
            end
        else
            self.TextFree:SetActive(true)
            self.mImgBotBg.enabled = false
            self.mGroupSoldOut:SetActive(true)
            self.mIsHot:SetActive(false)
            self.ImgDisco2.gameObject:SetActive(false)
            self.TextFree:GetComponent(ty.Text).text = directBuyVo:getPrice() <= 0 and _TT(411) or _TT(25011)
            self.mTextRemain.gameObject:SetActive(false)
            RedPointManager:remove(self.TextFree.transform)
        end
    end
    self.mTextName.text = directBuyVo:getItemName()
    self.mTextPrice.gameObject:SetActive(false)
    self.mGroupMoneyPrice:SetActive(false)
    if (directBuyVo:getPayType() == MoneyType.MONEY) then
        self.mTextPrice.gameObject:SetActive((limitNum - hadBuyNum > 0))
        self.mTextPrice.text = directBuyVo:getPrice()
    elseif (directBuyVo:getPrice() <= 0) then
        self.TextFree:SetActive(true)
        self.mImgBotBg.color = gs.ColorUtil.GetColor("ffb644ff")
    else
        self.mGroupMoneyPrice:SetActive((limitNum - hadBuyNum > 0))
        self.mImgMoneyIcon:SetImg(directBuyVo:getPayIcon(), true)
        self.mTextMoneyPrice.text = directBuyVo:getPrice()
    end
    local function __updateTickTime()
        local deltaTime = directBuyVo:getEndTime() - GameManager:getClientTime()
        if ((deltaTime > 0) and (limitNum - hadBuyNum > 0)) then
            self.mTextEndTime.text = TimeUtil.getFormatTimeBySeconds_10(deltaTime) -- _TT(50012, TimeUtil.getFormatTimeBySeconds_10(deltaTime))
            self.mGroupEndTime:SetActive(true)
        elseif ((deltaTime <= 0) or (limitNum - hadBuyNum <= 0)) then
            self.mGroupEndTime:SetActive(false)
        end
    end
    __updateTickTime()

    self:removeTimer()
    if (directBuyVo:getEndTime() ~= 0 and directBuyVo:getEndTime() > GameManager:getClientTime() and
        (limitNum - hadBuyNum > 0)) then
        self.m_loopSn = LoopManager:addTimer(1, 0, self, __updateTickTime)
    end
    local isShow = (tag == 1) and true or (limitNum - hadBuyNum > 0)
    self:setTimerLoop(tag, isShow)
end

function removeTimer(self)
    if (self.m_loopSn) then
        LoopManager:removeTimerByIndex(self.m_loopSn)
        self.m_loopSn = nil
    end
    if self.mloopTimer then
        LoopManager:removeTimerByIndex(self.mloopTimer)
        self.mloopTimer = nil
    end
end

function setTimerLoop(self, tag, isShow)
    if tag >= 1 and isShow then
        if self.data:getLimitType() ~= purchase.DirectBuyLimitType.UN_LIMIT and self.data:getLimitType() <=
            purchase.DirectBuyLimitType.EVERY_MONTH then
            self.mGroupEndTime:SetActive(true)
            local updateTimer = function()
                local subTime = TimeUtil.getTimeDifference("day")
                if self.data:getLimitType() == purchase.DirectBuyLimitType.EVERY_MONTH then
                    subTime = TimeUtil.getTimeDifference("month")
                elseif self.data:getLimitType() == purchase.DirectBuyLimitType.EVERY_WEEK then
                    subTime = TimeUtil.getTimeDifference("week")
                end
                self.mTextEndTime.text = TimeUtil.getFormatTimeBySeconds_10(subTime)
            end
            updateTimer()
            self.mloopTimer = LoopManager:addTimer(1, 0, self, function()
                updateTimer()
            end)
        end
    else
        self.mGroupEndTime:SetActive(false)
    end
end

function __clearItem(self)
    if self.mGrid then
        self.mGrid:poolRecover()
        self.mGrid = nil
    end
end

function __onClickBuyHadler(self)
 
    local directBuyVo = self.data
    if (directBuyVo:getEndTime() == 0 or directBuyVo:getEndTime() - GameManager:getClientTime() > 0) then
        local limitNum = directBuyVo:getLimit()
        local hadBuyNum = purchase.DirectBuyManager:getHadBuyNum(directBuyVo:getId())
        print("点击了道具:".. directBuyVo:getId())
        if (not (limitNum == 0 and directBuyVo:getLimitType() == purchase.DirectBuyLimitType.UN_LIMIT) and limitNum -
            hadBuyNum <= 0) then
            gs.Message.Show2(_TT(25011)) -- "已售罄"
        else
            if directBuyVo:getPrice() <= 0 then
                local isEnought, tips = MoneyUtil.judgeNeedMoneyCountByTid(directBuyVo:getPayType(),
                    directBuyVo:getPrice(), true, true)
                if (isEnought) then
                    GameDispatcher:dispatchEvent(EventName.REQ_DIRECT_BUY_GO, {
                        id = directBuyVo:getId(),
                        num = 1
                    })
                end
                return
            end
   
            GameDispatcher:dispatchEvent(EventName.OPEN_DIRECT_BUY_MONEY_PANEL, directBuyVo)
        end
    else
        gs.Message.Show(_TT(50025))
        -- 请求后端刷新数据
        GameDispatcher:dispatchEvent(EventName.REQ_DIRECT_BUY_INFO)
    end
end

function deActive(self)
    super.deActive(self)
    -- self:__clearItem()
    self:removeTimer()
    RedPointManager:remove(self.TextFree.transform)
end

function onDelete(self)
    super.onDelete(self)
    -- self:__clearItem()
    self:removeOnClick(self.mGoToucher)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(50025):	"商品已下架"
	语言包: _TT(50024):	"直购描述"
	语言包: _TT(50023):	"直购标题"
	语言包: _TT(50022):	"免费"
]]
