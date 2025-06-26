module("game.shop.view.item.ShopLimitItem", Class.impl("lib.component.BaseItemRender"))

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
    self.mDoTween = self.UIObject:GetComponent(ty.UIDoTween)
    self.mTxtNum = self:getChildGO("mTxtNum"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtOver = self:getChildGO("mTxtOver"):GetComponent(ty.Text)
    self.mTxtLimit = self:getChildGO("mTxtLimit"):GetComponent(ty.Text)
    self.mTxtPrice = self:getChildGO("mTxtPrice"):GetComponent(ty.Text)
    self.mTxtDisco = self:getChildGO("mTxtDisco"):GetComponent(ty.Text)
    self.mImgProp = self:getChildGO("mImgProp"):GetComponent(ty.AutoRefImage)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtLimitLeft = self:getChildGO("mTxtLimitLeft"):GetComponent(ty.Text)
    self.mImgColor = self:getChildGO("mImgColor"):GetComponent(ty.AutoRefImage)
    self.mGroupItem = self:getChildGO("mGroupItem")
    self.mTxtOriginalPrice = self:getChildGO("mTxtOriginalPrice"):GetComponent(ty.Text)
    ------------------------------------------------------------------------------
    self.mTxtOver.text = _TT(25011)
    self.mTxtLimitLeft.text = _TT(25009)

end

-- 激活
function active(self)
    super.active(self)
    bag.BagManager:addEventListener(bag.BagManager.BAG_UPDATE, self.onMoneyChange, self)
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.onMoneyChange, self)
    shop.ShopManager:addEventListener(shop.ShopManager.EVENT_SHOP_ITEM_UPDATE, self.onItemUpdateHandler, self)
end


--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    bag.BagManager:removeEventListener(bag.BagManager.BAG_UPDATE, self.onMoneyChange, self)
    role.RoleManager:getRoleVo():removeEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.onMoneyChange, self)
    shop.ShopManager:removeEventListener(shop.ShopManager.EVENT_SHOP_ITEM_UPDATE, self.onItemUpdateHandler, self)
    LoopManager:removeFrameByIndex(self.mFrameSign)
    LoopManager:removeFrameByIndex(self.mFrameAniSign)
    self.mFrameAniSign = nil
    self.mFrameSign = nil
end

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self.mGroupNomal, self.onShowContent)
end

function onMoneyChange(self)
    self:updateView()
end

function setData(self, param)
    super.setData(self, param)
    self.mShopVo = param
    self:updateView()
end

function updateView(self)
    local propsVo = props.PropsManager:getPropsVo({ tid = self.mShopVo:getItemTid(), num = 0 })
    self.mTxtOriginalPrice.gameObject:SetActive(self.mShopVo.discount > 0)
    self.mTxtOriginalPrice.text = self.mShopVo:getOldPrice()
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self:getChildTrans("mImgOriginalPrice"))
    self.mTxtNum.text = _TT(25036, self.mShopVo:getItemNum())
    self.mImgColor:SetImg(UrlManager:getPackPath("shop/shop_item_color_2_" .. propsVo.color .. ".png"), false)
    self.mImgProp:SetImg(UrlManager:getPropsIconUrl(propsVo.tid), false)
    self.mTxtName.text = self.mShopVo:getItemName()
    local price = self.mShopVo.price
    local colorStr = MoneyUtil.getMoneyCountByTid(self.mShopVo:getRealPayType()) < price and "fb2929ff" or "202226ff"
    self.mTxtPrice.text = HtmlUtil:color(MoneyUtil.shortValueStr(price), colorStr)

    if self.mShopVo:getType() == ShopType.BLACK then
        if self.mShopVo:getDiscount() <= 0 then
            self.mImgDisco:SetActive(false)
        else
            self.mImgDisco:SetActive(true)
            local discount = self.mShopVo:getDiscount() / 1000
            self.mTxtDisco.text = discount
        end
    else
        self.mImgDisco:SetActive(false)
    end

    self.mImgIcon:SetImg(self.mShopVo:getPayIcon(), true)

    if self.mShopVo:getLimit() > 0 and self.mShopVo:getItemConfigVo().type ~= PropsType.HERO_FRAGMENT then
        self.mImgLimit:SetActive(true)
        self.mTxtLimit.text = self.mShopVo:getLimitCount()
    else
        self.mImgLimit:SetActive(false)
        self.mTxtLimit.text = ""
    end

    -- 售罄
    if self.mShopVo:isSoldout() then
        self.mImgOver:SetActive(true)
        self.mImgLimit:SetActive(false)
        self.mTxtPrice.text = MoneyUtil.shortValueStr(price)
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