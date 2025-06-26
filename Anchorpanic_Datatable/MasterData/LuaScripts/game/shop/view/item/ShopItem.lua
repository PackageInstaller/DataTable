module("game.shop.view.item.ShopItem", Class.impl("lib.component.BaseItemRender"))
--对应的ui文件
function onInit(self, go)
    super.onInit(self, go)
    ------------------------------------------------------------------------------
    self.isShow = false
    ------------------------------------------------------------------------------
    self.mImgOver = self:getChildGO("mImgOver")
    self.mImgDisco = self:getChildGO("mImgDisco")
    self.mImgLimit = self:getChildGO("mImgLimit")
    self.mGroupNomal = self:getChildGO("mGroupNomal")
    self.mGroupEndTime = self:getChildGO("mGroupEndTime")
    self.mDoTween = self.UIObject:GetComponent(ty.UIDoTween)
    self.mTxtNum = self:getChildGO("mTxtNum"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtOver = self:getChildGO("mTxtOver"):GetComponent(ty.Text)
    self.mTxtLimit = self:getChildGO("mTxtLimit"):GetComponent(ty.Text)
    self.mTxtPrice = self:getChildGO("mTxtPrice"):GetComponent(ty.Text)
    self.mTxtDisco = self:getChildGO("mTxtDisco"):GetComponent(ty.Text)
    self.mTxtEndTime = self:getChildGO("mTxtEndTime"):GetComponent(ty.Text)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtLimitLeft = self:getChildGO("mTxtLimitLeft"):GetComponent(ty.Text)
    self.mImgColor = self:getChildGO("mImgColor"):GetComponent(ty.AutoRefImage)
    self.mImgProp = self:getChildGO("mImgProp"):GetComponent(ty.AutoRefImage)
    self.mGroupItem = self:getChildGO("mGroupItem")

    self.mImgDormitoryAura = self:getChildGO("mImgDormitoryAura")
    self.mTxtAura = self:getChildGO("mTxtAura"):GetComponent(ty.Text)

    self.mImgGuild = self:getChildGO("mImgGuild")
    self.mTxtGuildLock = self:getChildGO("mTxtGuildLock"):GetComponent(ty.Text)

    ------------------------------------------------------------------------------
    self.mTxtOver.text = _TT(25011)
    self.mTxtLimitLeft.text = _TT(25009)
end

-- 激活
function active(self)
    super.active(self)
    bag.BagManager:addEventListener(bag.BagManager.BAG_UPDATE, self.onUpdateMoney, self)
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.onUpdateMoney, self)
    shop.ShopManager:addEventListener(shop.ShopManager.EVENT_SHOP_ITEM_UPDATE, self.onItemUpdateHandler, self)
    self:removeTimer()
    self:setTimerLoop()
end


--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    bag.BagManager:removeEventListener(bag.BagManager.BAG_UPDATE, self.onUpdateMoney, self)
    role.RoleManager:getRoleVo():removeEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.onUpdateMoney, self)
    shop.ShopManager:removeEventListener(shop.ShopManager.EVENT_SHOP_ITEM_UPDATE, self.onItemUpdateHandler, self)
    self:removeTimer()
end

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self.mGroupNomal, self.onShowContent)
end

function onUpdateMoney(self)
    self:updateView()
end

function removeTimer(self)
    if self.mLoop then
        LoopManager:removeTimerByIndex(self.mLoop)
        self.mLoop = nil
    end
end

function setData(self, param)
    super.setData(self, param)
    self.mShopVo = param
    self:updateView()
end

function updateView(self)
    local propsVo = props.PropsManager:getPropsVo({ tid = self.mShopVo:getItemTid(), num = 0 })
    self.mTxtNum.text = _TT(25036, self.mShopVo:getItemNum())
    self.mImgColor:SetImg(UrlManager:getPackPath("shop/shop_item_color_2_" .. propsVo.color .. ".png"), false)
    self.mImgProp:SetImg(UrlManager:getPropsIconUrl(propsVo.tid), false)
    self.mTxtName.text = self.mShopVo:getItemName()
    local price = self.mShopVo.price

    local colorStr = MoneyUtil.getMoneyCountByTid(self.mShopVo:getRealPayType()) < price and "fb2929ff" or "fffffffff"
    self.mTxtPrice.text = HtmlUtil:color(MoneyUtil.shortValueStr(price), colorStr)
    if self.mShopVo:getType() == ShopType.BLACK then
        if self.mShopVo:getDiscount() <= 0 then
            self.mImgDisco:SetActive(false)
        else
            self.mImgDisco:SetActive(true)
            local discount = self.mShopVo:getDiscount() / 1000
            self.mTxtDisco.text = _TT(25029, HtmlUtil:colorAndSize(discount, "fffffffff", 30))
        end
    else
        self.mImgDisco:SetActive(false)
    end

    self.mImgIcon:SetImg(self.mShopVo:getPayIcon(), true)

    if self.mShopVo:getLimit() > 0 and (self.mShopVo.type ~= ShopType.FRAGMENTS and
    self.mShopVo.type ~= ShopType.OUTPUT and self.mShopVo.type ~= ShopType.ASSIST) then
        self.mImgLimit:SetActive(true)
        self.mTxtLimit.text = self.mShopVo:getLimitCount()
    else
        self.mImgLimit:SetActive(false)
        self.mTxtLimit.text = ""
    end
    local namecolorStr = (self.mShopVo:isSoldout() ~= true and self.mShopVo:getLimit() ~= 0) and "7b7b7bff" or "40484Bff"
    -- 售罄
    if self.mShopVo:isSoldout() then
        self.mImgOver:SetActive(true)
        self.mImgLimit:SetActive(false)
        self.mTxtPrice.text = HtmlUtil:color(MoneyUtil.shortValueStr(price), namecolorStr)
        self.mTxtOver.text = _TT(25011)
        self:closeContent(true)
    else
        if self.mShopVo:isLock() then
            self.mImgOver:SetActive(true)
            self.mImgLimit:SetActive(false)
            self.mTxtOver.text = _TT(25030)
            self.mTxtLimit.gameObject:SetActive(false)
        else
            self.mImgOver:SetActive(false)
            self.mTxtLimit.gameObject:SetActive(true)
        end

    end

    self.mImgDormitoryAura:SetActive(self.mShopVo.type == ShopType.DECORATE and propsVo.type == PropsType.FURNITURE)
    if self.mShopVo.type == ShopType.DECORATE and propsVo.type == PropsType.FURNITURE then
        local baseData = dormitory.DormitoryManager:getDormitoryBaseVo(self.mShopVo:getItemTid())
        if baseData then
            self.mTxtAura.text = baseData.aura
        else
            self.mTxtAura.text = "0"
        end
    end

    if self.mShopVo.type == ShopType.GUILD then
        if guild.GuildManager:getGuildLv() < self.mShopVo:getGuildLv() then
            self.mImgGuild:SetActive(true)
            self.mTxtGuildLock.text = _TT(94516, self.mShopVo:getGuildLv())
        else
            self.mImgGuild:SetActive(false)
        end
    else
        self.mImgGuild:SetActive(false)
    end
    --guild.GuildManager:getGuildLv()

    self:removeTimer()
    self:setTimerLoop()
end
-- 切换内容
function onShowContent(self)
    if self.mShopVo:isLock() then
        gs.Message.Show(_TT(25031))
        return
    end

    if self.mShopVo:isSoldout() then
        -- 已售罄
        gs.Message.Show(_TT(25011))
        return
    end

    if not self.mShopVo:isEnoughLimit() then
        -- 等级限制
        gs.Message.Show(_TT(25012))
        return
    end

    GameDispatcher:dispatchEvent(EventName.OPEN_SHOP_BUY_VIEW, self.mShopVo)
end

function setTimerLoop(self)
    self.mGroupEndTime:SetActive(false)
    -- if self.mShopVo:getType() == ShopType.APOSTLES2 or self.mShopVo:getType() == ShopTabType.CONVERT then
    if self.mShopVo:getLimitType() == shop.limitType.DAY_LIMIT or self.mShopVo:getLimitType() == shop.limitType.WEEK_LIMIT or self.mShopVo:getLimitType() == shop.limitType.MONTH_LIMIT
    or self.mShopVo:getLimitType() == shop.limitType.ACTIVITY_RESIDENT or self.mShopVo:getLimitType() == shop.limitType.LIMIT_TIME_OFF then
        self.mGroupEndTime:SetActive(true)
        local updateTimer = function()
            local subTime = TimeUtil.getTimeDifference("day")
            --if self.mShopVo:getLimitType() == purchase.DirectBuyLimitType.EVERY_MONTH then
            --    subTime = TimeUtil.getTimeDifference("month")
            if self.mShopVo:getLimitType() == shop.limitType.WEEK_LIMIT then
                subTime = TimeUtil.getTimeDifference("week")
            elseif self.mShopVo:getLimitType() == shop.limitType.MONTH_LIMIT then
                subTime = TimeUtil.getTimeDifference("month")
            elseif self.mShopVo:getLimitType() == shop.limitType.ACTIVITY_RESIDENT then
                if dup.DupApostlesWarManager:getPanelInfo() then
                    subTime = dup.DupApostlesWarManager:getPanelInfo() and dup.DupApostlesWarManager:getPanelInfo():getEndTime() - GameManager:getClientTime() or 0
                end
            elseif self.mShopVo:getLimitType() == shop.limitType.LIMIT_TIME_OFF then
                subTime = self.mShopVo:getEndTime() - GameManager:getClientTime()
            end
            self.mTxtEndTime.text = TimeUtil.getFormatTimeBySeconds_10(subTime)
        end
        updateTimer()
        self.mLoop = LoopManager:addTimer(1, 0, self, function()
            updateTimer()
        end)
    end
    -- end
end
-- 关闭内容
function closeContent(self, isEvent)
    self:setIsShow(false)
    self.mGroupNomal:SetActive(not self.isShow)
    if isEvent then
        self:onItemChange({ item = self, isShow = false })
    end
end
-- 设置内容展示状态
function setIsShow(self, value)
    self.isShow = value
end

function onItemChange(self, args)
    if args.isShow then
        if self.showItem then
            -- 回收之前打开的
            self.showItem:closeContent()
            self.showItem = nil
        end
        self.showItem = args.item
    else
        self.showItem = nil
    end
end

-- 更新某个商品
function onItemUpdateHandler(self, cusData)
    local type = cusData.type
    local id = cusData.id
    if self.data.type == type and self.data.id == id then
        self:updateView()
    end
end

-- 缓动顺序
function getTweenIndex(self)
    if type(self.data) ~= "table" then
        return nil
    end
    return self.data.tweemFrame
end

-- 获取动态宽度
function getWidth(self)
    return 260
end
--获取动态高度
function getHeight(self)
    return 314
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(25031):	"拥有该战员才可兑换"
	语言包: _TT(25030):	"未获得"
]]