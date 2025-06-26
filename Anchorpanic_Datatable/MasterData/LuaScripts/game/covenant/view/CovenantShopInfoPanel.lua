module('covenant.CovenantShopInfoPanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("covenant/CovenantShopInfoPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function initData(self)
end

-- 初始化
function configUI(self)
    self.mGroupLeft = self:getChildGO("GroupLeft")
    self.mGridNode = self:getChildTrans("GridNode")
    self.mTextName = self:getChildGO("TextName"):GetComponent(ty.Text)
    self.mTextOneCount = self:getChildGO("TextOneCount"):GetComponent(ty.Text)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    
    self.mGroupRight = self:getChildGO("GroupRight")
    self.mTextSelectTitle = self:getChildGO("TextSelectTitle"):GetComponent(ty.Text)

    self.mTextBuyTitle = self:getChildGO('TextBuyTitle'):GetComponent(ty.Text)
    self.mTxtLimit = self:getChildGO('TextLimit'):GetComponent(ty.Text)
    self.mTextHas = self:getChildGO('TextHas'):GetComponent(ty.Text)

    self.mImgDisco = self:getChildGO('mImgDisco')
    self.mTxtDisco = self:getChildGO('mTxtDisco'):GetComponent(ty.Text)

    self.mTxtPriceOld = self:getChildGO('mTxtPriceOld'):GetComponent(ty.Text)

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
    self.mBtnMin = self:getChildGO('mBtnMin')
    self.mBtnMax = self:getChildGO('mBtnMax')

    self.mBtnBuy = self:getChildGO('mBtnBuy')
end

--激活
function active(self, args)
    super.active(self, args)
    self:__updateView(args)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:clearItem();
end

function initViewText(self)
    self.mTextBuyTitle.text = _TT(29558)
    self.mTextSelectTitle.text = _TT(29559)
    self.mTxtPriceLab2.text = _TT(25005) .. ":" --"单价"
    self.mTxtPriceLabAll.text = _TT(25008)--"总价"
    self.mTxtCutLab.text = _TT(25010)--"已优惠"

    self:setBtnLabel(self.mBtnBuy, 9, "购买")
    self:setBtnLabel(self.mBtnMin, 29571, "最少")
    self:setBtnLabel(self.mBtnMax, 29572, "最多")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnBuy, self.onBuyHandler)
    self:addUIEvent(self.mBtnMin, self.onMinHandler)
    self:addUIEvent(self.mBtnMax, self.onMaxHandler)
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

    if not self.mShopVo:isEnoughPlayerLvl() then
        -- gs.Message.Show('等级限制')
        gs.Message.Show(_TT(25012))
        return
    end

    if not self.mShopVo:isEnoughPerstigeStage() then
        -- gs.Message.Show('声望等阶限制')
        gs.Message.Show('声望等阶限制')
        return
    end
    -- GameDispatcher:dispatchEvent(EventName.OPEN_SHOP_BUY_PANEL, self.mShopVo)
    if (MoneyUtil.judgeNeedMoneyCountByTid(self.mShopVo:getRealPayType(), self.mNumberStepper.CurrCount * self.mShopVo:getPrice(), true, true)) then
        GameDispatcher:dispatchEvent(EventName.REQ_SHOP_BUY, { type = self.mShopVo:getType(), id = self.mShopVo:getId(), num = self.mNumberStepper.CurrCount })
        self:close()
    end
end

function onMinHandler(self)
    self.mNumberStepper.CurrCount = 1
end

function onMaxHandler(self)
    self.mNumberStepper.CurrCount = self.mNumberStepper.MaxCount
end

function __updateView(self, shopVo)
    self.mShopVo = shopVo
    
    self:clearItem()
    self.mNumberStepper.CurrCount = 1

    self.mTextName.text = self.mShopVo:getItemName()
    -- if(self.mShopVo:getItemNum() > 1)then
        self.mTextOneCount.text = "x" .. self.mShopVo:getItemNum()
    -- else
    --     self.mTextOneCount.text = ""
    -- end

    local propsVo = props.PropsManager:getPropsVo({ tid = self.mShopVo:getItemTid(), num = self.mShopVo:getItemNum() })
    self.mGrid = PropsGrid:create(self.mGridNode, propsVo, 1.5)
    self.mTxtDes.text = propsVo:getDes()

    local price = self.mShopVo:getPrice()
    local colorStr = MoneyUtil.getMoneyCountByTid(self.mShopVo:getRealPayType()) < price and "ed1941ff" or "000000ff"
    self.mTxtPrice2.text = price

    if self.mShopVo:getLimit() > 0 then
        self.mTxtLimit.text = _TT(25009) .. self.mShopVo:getLimitCount()--"库存"
    else
        self.mTxtLimit.text = ""
    end
    
    self.mTextHas.text = _TT(25019) .. ":" .. bag.BagManager:getPropsCountByTid(self.mShopVo:getItemTid()) --持有

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

    self.mImgIcon2:SetImg(self.mShopVo:getPayIcon(), true)
    self.mImgIconAll:SetImg(self.mShopVo:getPayIcon(), true)

    self:updatePrice()
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

    local colorStr = MoneyUtil.getMoneyCountByTid(self.mShopVo:getRealPayType()) < price and "ed1941ff" or "FFFFFFFF"
    self.mTxtPriceAll.text = HtmlUtil:color(price, colorStr)

    if self.mShopVo:getDiscount() > 0 then
        self.mTxtCut.text = self.mShopVo:getOldPrice() * self.mNumberStepper.CurrCount - price
        self.mTxtCutLab.gameObject:SetActive(true)
    else
        self.mTxtCutLab.gameObject:SetActive(false)
    end

    -- self.mTxtPriceAll:GetComponent(ty.ContentSizeFitter):SetLayoutHorizontal()
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(29559):	"已选中物品"
	语言包: _TT(29558):	"购买数量"
]]
