--[[
-----------------------------------------------------
@filename       : ShopBuyView3
@Description    : 商店购买弹窗 图册
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("game.shop.view.ShopBuyView3", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("shop/ShopBuyView3.prefab")

panelType = 2 -- 窗口类型 1 全屏 2 弹窗
destroyTime = 0
--是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

function ctor(self)
    super.ctor(self)
    self:setSize(1120, 520)
end

-- 初始化数据
function initData(self)
    self.mSuitItemList = {}
    self.mPropsItems = {}
end
function configUI(self)
    self.mBtnBuy = self:getChildGO('mBtnBuy')
    self.mGroup = self:getChildTrans("mGroup")
    self.mMoney = self:getChildTrans("mMoney")
    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mGroupNum = self:getChildGO('mGroupNum')
    self.mCloseMask = self:getChildGO("CloseMask")
    self.mGroupSuit = self:getChildGO("mGroupSuit")
    self.mSuitTrans = self:getChildTrans("mSuitTrans")
    self.mImgDisCount = self:getChildGO("mImgDisCount")
    self.mBtnOpenFragmentsRule = self:getChildGO('mBtnRule')
    self.mGroupItemProp = self:getChildTrans("mGroupItemProp")
    self.mTxtDes = self:getChildGO('mTxtDes'):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO('mTxtName'):GetComponent(ty.Text)
    self.mTxtPrice = self:getChildGO('mTxtPrice'):GetComponent(ty.Text)
    self.mTxtLimit = self:getChildGO('mTxtLimit'):GetComponent(ty.Text)
    self.mTxtOwnNum = self:getChildGO('mTxtOwnNum'):GetComponent(ty.Text)
    self.mTxtOldPrice = self:getChildGO("mTxtOldPrice"):GetComponent(ty.Text)
    self.mTxtDisCount = self:getChildGO("mTxtDisCount"):GetComponent(ty.Text)
    self.mTxtInput = self:getChildGO("mTxtInput"):GetComponent(ty.InputField)
    self.mImgIcon = self:getChildGO('mImgIcon'):GetComponent(ty.AutoRefImage)
    self.mTxtSuitTitle = self:getChildGO("mTxtSuitTitle"):GetComponent(ty.Text)
    self.mImgColor = self:getChildGO("mImgColor"):GetComponent(ty.AutoRefImage)
    self.mTxtDemandDec = self:getChildGO("mTxtDemandDec"):GetComponent(ty.Text)
    self.mTxtTitleName = self:getChildGO("mTxtTitleName"):GetComponent(ty.Text)
    self.mTxtNeedPrice = self:getChildGO("mTxtNeedPrice"):GetComponent(ty.Text)
    self.mGroupItem = self:getChildGO("mGroupItem"):GetComponent(ty.AutoRefImage)
    self.mGroupSlidingPos = self:getChildGO("mGroupSlidingPos"):GetComponent(ty.RectTransform)
    self.mImgEquipBG = self:getChildGO("mImgEquipBG"):GetComponent(ty.AutoRefImage)
    self.mImgEquipIcon = self:getChildGO("mImgEquipIcon"):GetComponent(ty.AutoRefImage)
    self.mNumberStepper = self:getChildGO('mNumberStepper'):GetComponent(ty.LyNumberStepper)
    self.mNumberStepper:Init(1, 1, 1, -1, self.onStepChange, self)
    self.mHeroEggGetTitle = self:getChildGO("mHeroEggGetTitle")
    -- self.mProScroll = self:getChildGO("mProScroll"):GetComponent(ty.ScrollRect)
    -- self.mBtnHeroEggPro = self:getChildGO("mBtnHeroEggPro")

    self.mBtnPre = self:getChildGO("mBtnPre")
    self.mBtnPreInfo = self:getChildGO("mBtnPreInfo")
    self.mImgPreBg = self:getChildGO("mImgPreBg"):GetComponent(ty.AutoRefImage)
end

function active(self, args)
    super.active(self, args)
    self.gBtnClose:SetActive(false)
    self.directBuyVo = args
    self:setData()
end

function deActive(self)
    super.deActive(self)

    if self.time then
        LoopManager:removeTimerByIndex(self.time)
        self.time = nil
    end
end

function addAllUIEvent(self)
    self:addUIEvent(self.mCloseMask, self.onClickClose)
    self:addUIEvent(self.mBtnClose, self.onClickClose)
    self:addUIEvent(self.mBtnBuy, self.onBuyHandler)
    self:addUIEvent(self.mBtnPre, self.onPreHandler)
    self:addUIEvent(self.mBtnPreInfo, self.onPreInfoHandler)

end

--[[
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtSuitTitle.text = _TT(1316)--套装属性
end

function setData(self)
    self:setBtnLabel(self.mBtnBuy, nil, _TT(9))
    self.mTxtTitleName.text = _TT(9)--"购买"

    if self.directBuyVo.payType == MoneyType.MONEY then
        self.mTxtPrice.text = "消耗¥" .. self.directBuyVo:getMoneyCount()
    else
        self.mTxtPrice.text = self.directBuyVo:getMoneyCount()

        self.hasCount = MoneyUtil.getMoneyCountByTid(self.directBuyVo.payType)
        self.needCount = self.directBuyVo:getMoneyCount()
        if self.hasCount < self.needCount then
            self.mTxtPrice.color = gs.ColorUtil.GetColor("ed1941ff")
        else
            self.mTxtPrice.color = gs.ColorUtil.GetColor("474C50FF")
        end
    end
    self.mGroupItem:SetImg(MoneyUtil.getMoneyIconUrlByTid(self.directBuyVo.payType), true)
    self.mGroupItem.gameObject:SetActive(self.directBuyVo.payType ~= MoneyType.MONEY)

    local propsVo = props.PropsManager:getPropsConfigVo(self.directBuyVo.itemId)

    self.mTxtName.text = propsVo.name

    self.mTxtDes.text = propsVo:getDes()
    self.mImgIcon:SetImg(UrlManager:getPropsIconUrl(propsVo.tid), false)
    self.mImgColor:SetImg(UrlManager:getPackPath("shop/shop_tips_color_" .. propsVo.color .. ".png"), false)
    self.mImgIcon.gameObject:SetActive(true)
    self.mImgEquipBG.gameObject:SetActive(false)

    local paintingDataVo = purchase.FashionShopManager:getPaintingDataById(self.directBuyVo.fashionDic[1])
    self.mImgPreBg:SetImg(UrlManager:getBgPath("painting/"..paintingDataVo.preImg), true)

    if (self.directBuyVo:getTime() > 0) then
        if self.time then
            LoopManager:removeTimerByIndex(self.time)
            self.time = nil
        end

        self:updateTime()
        self.time = LoopManager:addTimer(1, 0, self, self.updateTime)
    end
end

function onBuyHandler(self)
    if self.directBuyVo.payType == MoneyType.MONEY then
        recharge.sendRecharge(recharge.RechargeType.FASHION_OTHER, nil, self.directBuyVo.id)
    else
        self.mPairtsFashionVo = self.directBuyVo
        local needMoney = self.mPairtsFashionVo:getMoneyCount()
        -- if self.mToggleDis.isOn and self.mPairtsFashionVo:getDiscountCost() > 0 then
        --     needMoney = self.mPairtsFashionVo:getDiscountCost()
        -- end

        if (MoneyUtil.getMoneyCountByTid(self.mPairtsFashionVo:getMoneyTid()) < needMoney) then
            UIFactory:alertMessge(_TT(25038, props.PropsManager:getName(self.mPairtsFashionVo:getMoneyTid())), true, function()
                if self.mPairtsFashionVo:getMoneyTid() == MoneyTid.PAY_ITIANIUM_TID then
                    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {linkId = LinkCode.Purchase})
                else
                    GameDispatcher:dispatchEvent(EventName.OPEN_CONVERT_TITANIUM_VIEW, {moneyList = {MoneyTid.PAY_ITIANIUM_TID, MoneyTid.FASHION_TID}, ratio = sysParam.SysParamManager:getValue(SysParamType.FASHION_ICAN_CONVERSION_RATIO)})
                end
                self:close()
            end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
            return
        end

        local isUseDis = 0
        local msgStr = _TT(121194) --"是否确认购买？"
        if self.mPairtsFashionVo:getDiscountCost() > 0 then
            isUseDis = self.mToggleDis.isOn == true and 1 or 0 --是否使用打折卡
            if isUseDis == 1 then
                msgStr = _TT(121195) --"是否确认购买？（本次将消耗一张时装打折卡）"

                local count = bag.BagManager:getPropsCountByTid(PROPS_TID.FASHION_DISCOUNT_CARE)
                if count <= 0 then
                    gs.Message.Show("当前仓库没有衣装特惠卡，无法使用")
                    return
                end
            end
        end
        UIFactory:alertMessge(msgStr, true, function()
            GameDispatcher:dispatchEvent(EventName.REQ_FASHION_SHOP_BUY, {id = self.mPairtsFashionVo.id, isUseDis = isUseDis})
        end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
    end

end

function updateTime(self)
    if self.directBuyVo:getTime() <= 0 then
        self:close()
    end
end

function onPreHandler(self)
    self.mBtnPreInfo.gameObject:SetActive(true)
end

function onPreInfoHandler(self)
    self.mBtnPreInfo.gameObject:SetActive(false)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
