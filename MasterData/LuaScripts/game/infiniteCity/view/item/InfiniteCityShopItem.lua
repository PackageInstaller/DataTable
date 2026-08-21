module('infiniteCity.InfiniteCityShopItem', Class.impl(BaseReuseItem))

UIRes = UrlManager:getUIPrefabPath("infiniteCity/InfiniteCityShopItem.prefab")

EVENT_CHANGE = "EVENT_CHANGE"

--构造函数
function ctor(self)
    super.ctor(self)
end

function initData(self)
    self.mItemList = {}
    self.isShow = false
end

function configUI(self)

    self.mGroupNomal = self:getChildGO("mGroupNomal")
    self.mGroupShow = self:getChildGO("mGroupShow")
    self.mGroupShow:SetActive(false)

    ------------------------------------------------------------------------------
    self.mImgLimit = self:getChildGO('mImgLimit')
    self.mTxtLimitLab = self:getChildGO('mTxtLimitLab'):GetComponent(ty.Text)
    self.mTxtLimit = self:getChildGO('mTxtLimit'):GetComponent(ty.Text)

    self.mImgDisco = self:getChildGO('mImgDisco')
    self.mTxtDisco = self:getChildGO('mTxtDisco'):GetComponent(ty.Text)

    -- self.mGroupPrice = self:getChildGO('mGroupPrice')
    self.mTxtPriceOld = self:getChildGO('mTxtPriceOld'):GetComponent(ty.Text)

    self.mTxtPriceLab1 = self:getChildGO('mTxtPriceLab1'):GetComponent(ty.Text)
    self.mTxtPrice1 = self:getChildGO('mTxtPrice1'):GetComponent(ty.Text)
    self.mImgIcon1 = self:getChildGO('mImgIcon1'):GetComponent(ty.AutoRefImage)

    self.mTxtDes = self:getChildGO('mTxtDes'):GetComponent(ty.Text)

    --------------------------------------------------------------------------------
    self.mTxtPriceLab2 = self:getChildGO('mTxtPriceLab2'):GetComponent(ty.Text)
    self.mTxtPrice2 = self:getChildGO('mTxtPrice2'):GetComponent(ty.Text)
    self.mImgIcon2 = self:getChildGO('mImgIcon2'):GetComponent(ty.AutoRefImage)

    self.mTxtPriceLabAll = self:getChildGO('mTxtPriceLabAll'):GetComponent(ty.Text)
    self.mTxtPriceAll = self:getChildGO('mTxtPriceAll'):GetComponent(ty.Text)
    self.mImgIconAll = self:getChildGO('mImgIconAll'):GetComponent(ty.AutoRefImage)

    self.mTxtCutLab = self:getChildGO('mTxtCutLab'):GetComponent(ty.Text)
    self.mTxtCut = self:getChildGO('mTxtCut'):GetComponent(ty.Text)

    self.mNumberStepper = self:getChildGO('mNumberStepper'):GetComponent(ty.LyNumberStepper)
    self.mNumberStepper:Init(1, 1, 1, 10, self.onStepChange, self)

    self.mBtnBuy = self:getChildGO('mBtnBuy')

    ------------------------------------------------------------------------------
    self.mGroupItem = self:getChildTrans("mGroupItem")
    self.mTxtName = self:getChildGO('mTxtName'):GetComponent(ty.Text)

    self.mImgOver = self:getChildGO('mImgOver')
    self.mTxtOver = self:getChildGO('mTxtOver')

    -- self.mTxtNum = self:getChildGO('mTxtNum'):GetComponent(ty.Text)
    -- self.mImgIcon = self:getChildGO('mImgIcon'):GetComponent(ty.Image)
    -- self.mCanvasGroup = self.mGroup:GetComponent(ty.CanvasGroup)
    -- self.mImgColor = self:getChildGO('mImgColor'):GetComponent(ty.AutoRefImage)
    -- self.mGroupItem = self:getChildTrans('mGroupItem'):GetComponent(ty.AutoRefImage)
    self.mGroupParent = self:getChildGO('mGroupParent'):GetComponent(ty.CanvasGroup)

end

function active(self)
    super.active(self)
    -- self:addOnClick(self.mGroupNomal, self.onShow)
    -- self:addOnClick(self.mBtnBuy, self.onBuyHandler)
    self.mNumberStepper.CurrCount = 1
    self:closeContent()
end

function deActive(self)
    super.deActive(self)
    -- self:removeOnClick(self.mGroupNomal)
    -- self:removeOnClick(self.mBtnBuy)
    self:clearItem();
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtPriceLab1.text = _TT(25005)--"单价"
    self.mTxtPriceLab2.text = _TT(25005)--"单价"
    self.mTxtPriceLabAll.text = _TT(25008)--"总价"
    self.mTxtLimitLab.text = _TT(25009)--"库存"
    self.mTxtCutLab.text = _TT(25010)--"已优惠"

    self:setBtnLabel(self.mBtnBuy, 9, "购买")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mGroupNomal, self.onShowContent)
    self:addUIEvent(self.mGroupShow, self.onShowContent)
    self:addUIEvent(self.mBtnBuy, self.onBuyHandler)
end

function setData(self, cusParent, cusShopVo)
    self:setParentTrans(cusParent)
    self.mShopVo = cusShopVo
    self:updataView()
    self:updatePrice()
end

function updataView(self)
    self.mNumberStepper.CurrCount = 1

    self:clearItem()
    local propsVo = props.PropsManager:getPropsVo({ tid = self.mShopVo:getItemTid(), num = self.mShopVo:getItemNum() })
    self.mGrid = PropsGrid:create(self.mGroupItem, propsVo, 0.9)

    self.mTxtDes.text = propsVo:getDes()

    self.mTxtName.text = self.mShopVo:getItemName()

    local price = self.mShopVo:getPrice()
    local colorStr = MoneyUtil.getMoneyCountByTid(self.mShopVo:getRealPayType()) < price and "ed1941ff" or "000000ff"
    self.mTxtPrice1.text = HtmlUtil:color(price, colorStr)
    self.mTxtPrice2.text = price

    if self.mShopVo:getDiscount() <= 0 then
        self.mTxtPriceOld.gameObject:SetActive(false)

        self.mImgDisco:SetActive(false)
        self.mTxtDisco.gameObject:SetActive(false)
    else
        self.mTxtPriceOld.gameObject:SetActive(true)
        -- self.mTxtPriceOld.text = string.format("原价%d", self.mShopVo:getOldPrice())
        self.mTxtPriceOld.text = _TT(25006, self.mShopVo:getOldPrice())

        self.mImgDisco:SetActive(true)
        self.mTxtDisco.gameObject:SetActive(true)
        -- self.mTxtDisco.text = string.format("降价%d", (self.mShopVo:getDiscount() / 1000)) .. "%"
        self.mTxtDisco.text = _TT(25007, (self.mShopVo:getDiscount() / 1000))
    end

    if self.mShopVo:getLimitCount() > 0 then
        self.mNumberStepper.MaxCount = self.mShopVo:getLimitCount()
    else
        self.mNumberStepper.MaxCount = 999
    end

    self.mImgIcon1:SetImg(self.mShopVo:getPayIcon(), true)
    self.mImgIcon2:SetImg(self.mShopVo:getPayIcon(), true)
    self.mImgIconAll:SetImg(self.mShopVo:getPayIcon(), true)

    -- self.mTxtNum.text = "X" .. self.mShopVo:getItemNum()
    if self.mShopVo:getLimit() > 0 then
        self.mImgLimit:SetActive(true)
        self.mTxtLimit.text = self.mShopVo:getLimitCount()
    else
        self.mImgLimit:SetActive(false)
        self.mTxtLimit.text = ""
    end
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mImgLimit.transform) --立即刷新

    -- 售罄
    if self.mShopVo:isSoldout() then
        self.mImgOver:SetActive(true)
        -- self.mCanvasGroup.alpha = 0.7
        self:closeContent(true)
    else
        self.mImgOver:SetActive(false)
        -- self.mCanvasGroup.alpha = 1
    end
end

function updateItem(self)
    self:clearItem()
    local propsVo = props.PropsManager:getPropsVo({ tid = self.mShopVo:getItemTid(), num = self.mShopVo:getItemNum() })
    self.mGrid = PropsGrid:create(self.mGroupItem, propsVo)
    -- self.mGroupItem:SetImg(UrlManager:getPropsIconUrl(self.mShopVo:getItemTid()), true)
    -- gs.TransQuick:Scale(self.mGroupItem.transform, 0.47, 0.47, 0.47)
    -- self.mImgColor:SetImg(UrlManager:getPropsLeftTopColorIconUrl(propsVo.color), true)
end

function __onDefaultClickHandler(self)
    local propsVo = props.PropsManager:getPropsVo({ tid = self.mShopVo:getItemTid(), num = self.mShopVo:getItemNum() })
    local rect = self.mGroupItem:GetComponent(ty.RectTransform)
    if (propsVo.type == PropsType.EQUIP) then
        TipsFactory:equipTips(propsVo, nil, { rectTransform = rect })
    elseif (propsVo.type ~= PropsType.EQUIP) then
        TipsFactory:propsTips({ propsVo = propsVo }, { rectTransform = rect })
    end
end

function clearItem(self)
    if self.mGrid then
        self.mGrid:poolRecover()
        self.mGrid = nil
    end
end

function onBuyHandler(self)
    if self.mShopVo:isSoldout() then
        -- gs.Message.Show('已售罄')
        gs.Message.Show(_TT(25011))
        return
    end

    if not self.mShopVo:isEnoughLimit() then
        -- gs.Message.Show('等级限制')
        gs.Message.Show(_TT(25012))
        return
    end
    -- GameDispatcher:dispatchEvent(EventName.OPEN_SHOP_BUY_PANEL, self.mShopVo)
    if (MoneyUtil.judgeNeedMoneyCountByTid(self.mShopVo:getRealPayType(), self.mNumberStepper.CurrCount * self.mShopVo:getPrice(), true, true)) then
        GameDispatcher:dispatchEvent(EventName.REQ_SHOP_BUY, { type = self.mShopVo:getType(), id = self.mShopVo:getId(), num = self.mNumberStepper.CurrCount })
        -- self:close()
    end
end

function getShopVo(self)
    return self.mShopVo
end

function getCanvasGroup(self)
    return self.mGroupParent
end

function onStepChange(self, cusCount, cusType)
    if cusType == 1 then
        -- gs.Message.Show('最大值')
        gs.Message.Show(_TT(4018))
    elseif cusType == 2 then
        -- gs.Message.Show('最小值')
        gs.Message.Show(_TT(4019))
    end
    self:updatePrice()
end

function updatePrice(self, cusPrice)
    local price = self.mNumberStepper.CurrCount * self.mShopVo:getPrice()

    local colorStr = MoneyUtil.getMoneyCountByTid(self.mShopVo:getRealPayType()) < price and "ed1941ff" or "000000ff"
    self.mTxtPriceAll.text = HtmlUtil:color(price, colorStr)

    if self.mShopVo:getDiscount() > 0 then
        self.mTxtCut.text = self.mShopVo:getOldPrice() * self.mNumberStepper.CurrCount - price
        self.mTxtCutLab.gameObject:SetActive(true)
    else
        self.mTxtCutLab.gameObject:SetActive(false)
    end

    -- self.mTxtPriceAll:GetComponent(ty.ContentSizeFitter):SetLayoutHorizontal()
end

-- 切换内容
function onShowContent(self)
    if self.mShopVo:isSoldout() then
        -- gs.Message.Show('已售罄')
        gs.Message.Show(_TT(25011))
        return
    end

    self:setIsShow(self.isShow == false)
    self.mGroupNomal:SetActive(not self.isShow)
    self.mGroupShow:SetActive(self.isShow)
    gs.TransQuick:SizeDelta(self.UITrans, self:getWidth(), self.UITrans.sizeDelta.y)
    self:dispatchEvent(self.EVENT_CHANGE, { item = self, isShow = self.isShow })
end
-- 关闭内容
function closeContent(self, isEvent)
    self:setIsShow(false)
    self.mGroupShow:SetActive(self.isShow)
    self.mGroupNomal:SetActive(not self.isShow)
    gs.TransQuick:SizeDelta(self.UITrans, self:getWidth(), self.UITrans.sizeDelta.y)
    if isEvent then
        self:dispatchEvent(self.EVENT_CHANGE, { item = self, isShow = false })
    end
end
-- 设置内容展示状态
function setIsShow(self, value)
    self.isShow = value
end

-- 获取动态宽度
function getWidth(self)
    if self.isShow then
        return 356
    end
    return 285
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
