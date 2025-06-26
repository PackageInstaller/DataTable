module('returned.ReturnedShopBuyItem', Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mImGlow = self:getChildGO("mImGlow")
    self.TextFree = self:getChildGO("TextFree")
    self.mGoToucher = self:getChildGO("ImgToucher")
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
    self.mTextMoneyPrice = self:getChildGO("TextMoneyPrice"):GetComponent(ty.Text)
    self.mImgMoneyIcon = self:getChildGO('ImgMoneyIcon'):GetComponent(ty.AutoRefImage)
    self.mTextSoldOut.text = _TT(25011) --"已售罄"
    self.TextDisco2Dec.text = "超值"
    self:addOnClick(self.mGoToucher, self.__onClickBuyHadler)
end

function setData(self, param)
    super.setData(self, param)
    local shopBuyVo = self.data
    self.mGridNode:SetImg(UrlManager:getPropsIconUrl(shopBuyVo:getItemTid()), true)

    local tag = shopBuyVo:getTag()
    self.mImgDisco.gameObject:SetActive(false)
    self.ImgDisco2.gameObject:SetActive(false)
    self.mImGlow:SetActive(false)
    if tag == 0 then
    elseif tag == 1 then
        self.mTextDisco.text = _TT(50022) --"免费"
    elseif tag == 2 then
        self.ImgDisco2.gameObject:SetActive(true)
        self.TextDisco2.text = shopBuyVo:getPriceRatio()
    elseif tag == 3 then
        self.mImgDisco.gameObject:SetActive(true)
        self.mImgDisco.color = gs.ColorUtil.GetColor("874cf2ff")
        self.mTextDisco.text = _TT(50035) --"热销"
    end

    local limitNum = shopBuyVo:getLimit()
    local hadBuyNum = shopBuyVo:getBuyTimes()
    self.mGroupSoldOut:SetActive(false)
    self.mImgBotBg.color = gs.ColorUtil.GetColor("000000ff")
    self.TextFree:GetComponent(ty.Text).text = _TT(50022)
    self.mTextRemain.gameObject:SetActive(true)
    if (limitNum == 0 and shopBuyVo:getLimitType() == purchase.DirectBuyLimitType.UN_LIMIT) then
        self.mTextRemain.text = _TT(25009) .. "∞"
    else
        if not shopBuyVo:isSoldout() then
            self.TextFree:SetActive(false)
            self.mImgBotBg.enabled = true
            if tag == 1 then
                self.mImGlow:SetActive(true)
            end
            self.mTextRemain.text = _TT(25009) .. (limitNum - hadBuyNum)
            if shopBuyVo:getPrice() <= 0 then
                RedPointManager:add(self.TextFree.transform, nil, 99.6, 16)
            end
        else
            self.TextFree:SetActive(true)
            self.mImgBotBg.enabled = false
            self.mGroupSoldOut:SetActive(true)
            self.ImgDisco2.gameObject:SetActive(false)
            self.TextFree:GetComponent(ty.Text).text = shopBuyVo:getPrice() <= 0 and _TT(411) or _TT(25011)
            self.mTextRemain.gameObject:SetActive(false)
            RedPointManager:remove(self.TextFree.transform)
        end
    end
    self.mTextName.text = shopBuyVo:getItemName()
    self.mTextPrice.gameObject:SetActive(false)
    self.mGroupMoneyPrice:SetActive(false)
    if (shopBuyVo:getPayType() == MoneyType.MONEY) then
        self.mTextPrice.gameObject:SetActive(not shopBuyVo:isSoldout())
        self.mTextPrice.text = shopBuyVo:getPrice()
    elseif (shopBuyVo:getPrice() <= 0) then
        self.TextFree:SetActive(true)
        self.mImgBotBg.color = gs.ColorUtil.GetColor("ffb644ff")
    else
        self.mGroupMoneyPrice:SetActive(not shopBuyVo:isSoldout())
        self.mImgMoneyIcon:SetImg(shopBuyVo:getPayIcon(), true)
        self.mTextMoneyPrice.text = shopBuyVo:getPrice()
    end
    local function __updateTickTime()
        local deltaTime = shopBuyVo:getEndTime() - GameManager:getClientTime()
        if ((deltaTime > 0) and not shopBuyVo:isSoldout()) then
            self.mTextEndTime.text = TimeUtil.getFormatTimeBySeconds_10(deltaTime)-- _TT(50012, TimeUtil.getFormatTimeBySeconds_10(deltaTime))
            self.mGroupEndTime:SetActive(true)
        elseif ((deltaTime <= 0) or (limitNum - hadBuyNum <= 0)) then
            self.mGroupEndTime:SetActive(false)
        end
    end
    __updateTickTime()

    self:removeTimer()
    if (shopBuyVo:getEndTime() ~= 0 and shopBuyVo:getEndTime() > GameManager:getClientTime() and not shopBuyVo:isSoldout()) then
        self.m_loopSn = LoopManager:addTimer(1, 0, self, __updateTickTime)
    end
    local isShow = (tag == 1) and true or not shopBuyVo:isSoldout()
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
        if self.data:getLimitType() ~= purchase.DirectBuyLimitType.UN_LIMIT and self.data:getLimitType() <= purchase.DirectBuyLimitType.EVERY_MONTH then
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
    if self.data:isLock() then
        gs.Message.Show(_TT(25031))
        return
    end

    if self.data:isSoldout() then
        -- 已售罄
        gs.Message.Show(_TT(25011))
        return
    end

    if not self.data:isEnoughLimit() then
        -- 等级限制
        gs.Message.Show(_TT(25012))
        return
    end

    GameDispatcher:dispatchEvent(EventName.OPEN_RETURNED_SHOP_BUY_PANEL, self.data)
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