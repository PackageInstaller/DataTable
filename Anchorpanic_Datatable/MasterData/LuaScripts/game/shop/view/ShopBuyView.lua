--[[
-----------------------------------------------------
@filename       : ShopBuyView
@Description    : 商店购买确认页面、快捷购买
@date           : 2020-08-31 19:31:01
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("game.shop.view.ShopBuyView", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("shop/ShopBuyView.prefab")
panelType = 2 -- 窗口类型 1 全屏 2 弹窗
destroyTime = 0
isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

function ctor(self)
    super.ctor(self)
    self:setSize(1120, 520)
end

-- 初始化数据
function initData(self)
    self.mPropsItems = {}
end
function configUI(self)
    self.mBtnBuy = self:getChildGO('mBtnBuy')
    self.mGroup = self:getChildTrans("mGroup")
    self.mMoney = self:getChildTrans("mMoney")
    self.mGroupNum = self:getChildGO('mGroupNum')
    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mCloseMask = self:getChildGO("CloseMask")
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
    self.mImgIcon = self:getChildGO('mImgIcon'):GetComponent(ty.AutoRefImage)
    self.mTxtInput = self:getChildGO("mTxtInput"):GetComponent(ty.InputField)
    self.mTxtDemandDec = self:getChildGO("mTxtDemandDec"):GetComponent(ty.Text)
    self.mTxtTitleName = self:getChildGO("mTxtTitleName"):GetComponent(ty.Text)
    self.mTxtNeedPrice = self:getChildGO("mTxtNeedPrice"):GetComponent(ty.Text)
    self.mImgColor = self:getChildGO("mImgColor"):GetComponent(ty.AutoRefImage)
    self.mGroupItem = self:getChildGO("mGroupItem"):GetComponent(ty.AutoRefImage)
    self.mGroupSlidingPos = self:getChildGO("mGroupSlidingPos"):GetComponent(ty.RectTransform)
    self.mNumberStepper = self:getChildGO('mNumberStepper'):GetComponent(ty.LyNumberStepper)
    self.mImgEquipBG = self:getChildGO("mImgEquipBG"):GetComponent(ty.AutoRefImage)
    self.mImgEquipIcon = self:getChildGO("mImgEquipIcon"):GetComponent(ty.AutoRefImage)
    self.mNumberStepper:Init(1, 1, 1, -1, self.onStepChange, self)
    self:setGuideTrans("guide_btn_shopbuy", self.mBtnBuy.transform)
    self.mHeroEggGetTitle = self:getChildGO("mHeroEggGetTitle")
    self.mProScroll = self:getChildGO("mProScroll"):GetComponent(ty.ScrollRect)
    self.mBtnHeroEggPro = self:getChildGO("mBtnHeroEggPro")
end

function active(self, args)
    super.active(self, args)
    local function inputChange(content)
        local str = string.gsub(content, "%-", "")
        self.mTxtInput.text = str
    end
    self.mTxtInput.onValueChanged:AddListener(inputChange)
    self.mMoney.gameObject:SetActive(false)
    self.mNumberStepper.CurrCount = 1
    if args.shopVo then
        self.mShopVo = args.shopVo
        self.mCloseCall = args.closeCall
    else
        self.mShopVo = args
    end
    self:setData()
    --TweenFactory:move2LPosX(self.mGroup, self.mGroupSlidingPos.localPosition.x, 0.5)
end

function deActive(self)
    super.deActive(self)
    if self.mMoneyBarItem then
        self.mMoneyBarItem:poolRecover()
        self.mMoneyBarItem = nil
    end
    self:recoverBtnGoDic()
    self:clearItemList()
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.onClickClose)
    self:addUIEvent(self.mCloseMask, self.onClickClose)
    self:addUIEvent(self.mBtnBuy, self.onBuyHandler)
    self:addUIEvent(self.mBtnHeroEggPro, self.onOpenHeroEggProClick)
end

function setData(self)
    if MoneyUtil.getMoneyCountByTid(self.mShopVo:getRealPayType()) >= self.mShopVo:getPrice() then
        local all = math.floor(MoneyUtil.getMoneyCountByTid(self.mShopVo:getRealPayType()) / self.mShopVo:getPrice())
        if self.mShopVo:getLimit() <= 0 then
            if all >= sysParam.SysParamManager:getValue(SysParamType.SHOP_MAX_BUY_NUM) then
                self.mNumberStepper.MaxCount = sysParam.SysParamManager:getValue(SysParamType.SHOP_MAX_BUY_NUM)
            else
                self.mNumberStepper.MaxCount = all
            end
        else
            if all <= self.mShopVo:getLimitCount() then
                if self.mShopVo:getLimitCount() >= sysParam.SysParamManager:getValue(SysParamType.SHOP_MAX_BUY_NUM) then
                    all = sysParam.SysParamManager:getValue(SysParamType.SHOP_MAX_BUY_NUM)
                end
                self.mNumberStepper.MaxCount = all
            else
                self.mNumberStepper.MaxCount = self.mShopVo:getLimitCount()
            end
        end
    else
        self.mNumberStepper.MaxCount = 1
    end

    self:setBtnLabel(self.mBtnBuy, nil, _TT(9))
    self.mTxtTitleName.text = _TT(9)--"购买"
    self.mTxtDemandDec.text = HtmlUtil:color(_TT(25005), "FFFFFFFF")
    self.mTxtName.text = self.mShopVo:getItemName()
    self:updatePrice(self.mShopVo:getPrice())
    self.mTxtOwnNum.text = _TT(25019) .. bag.BagManager:getPropsCountByTid(self.mShopVo:getItemTid())
    if (self.mShopVo:getLimit() > 0) then
        self.mTxtLimit.text = _TT(25023) .. MoneyUtil.shortValueStr(self.mShopVo:getLimitCount()) --库存
    else
        self.mTxtLimit.text = ""
    end

    local propsVo = props.PropsManager:getPropsVo({tid = self.mShopVo:getItemTid(), num = self.mShopVo:getItemNum()})
    if propsVo.type == PropsType.EQUIP and propsVo.subType == PropsEquipSubType.SLOT_7 then
        self.mImgIcon.gameObject:SetActive(false)
        self.mImgEquipBG.gameObject:SetActive(true)
        self.mImgEquipBG:SetImg(UrlManager:getNraceletColorUrl(propsVo.color), false)
        self.mImgEquipIcon:SetImg(UrlManager:getPropsIconUrl(propsVo.tid), false)
    else
        self.mImgIcon.gameObject:SetActive(true)
        self.mImgEquipBG.gameObject:SetActive(false)
        self.mImgIcon:SetImg(UrlManager:getPropsIconUrl(propsVo.tid), false)
    end
    self.mImgColor:SetImg(UrlManager:getPackPath("shop/shop_tips_color_" .. propsVo.color .. ".png"), false)

    if not self.mMoneyBarItem then
        self.mMoneyBarItem = MoneyItem:poolGet()
    end
    self.mMoneyBarItem:setData(self.mMoney, {tid = self.mShopVo:getRealPayType()})
    self.mTxtDes.text = propsVo:getDes()

    if self.mGridProp then
        self.mGridProp:poolRecover()
        self.mGridProp = nil
    end
    self:updateItem()
    self:updateEggInfo()
end

function setBuyNum(self, currCount)
    self.mNumberStepper.CurrCount = currCount

    self:updatePrice(self.mNumberStepper.CurrCount * self.mShopVo.price)
end

function updateItem(self)
    self:clearItem()
    local costPropsVo = props.PropsManager:getPropsVo({tid = self.mShopVo:getRealPayType(), num = 1})
    self.mGridProp = PropsGrid:create(self.mGroupItemProp, costPropsVo, 0.45)
    self.mGroupItem:SetImg(MoneyUtil.getMoneyIconUrlByTid(costPropsVo.tid), true)
    self.mGridProp:setShowColorBgState(false)
end

function clearItem(self)
    if self.mGridProp then
        self.mGridProp:poolRecover()
        self.mGridProp = nil
    end
end

function updateEggInfo(self)
    self:clearItemList()
    if not self.mHeroEggGetTitle then
        return
    end
    local costPropsVo = props.PropsManager:getPropsVo({tid = self.mShopVo:getItemTid(), num = 1})
    self.mHeroEggGetTitle:SetActive(costPropsVo.effectType == UseEffectType.USE_GET_HEROEGG)
    if costPropsVo.effectType == UseEffectType.USE_GET_HEROEGG then
        local ruleVo = props.PropsManager:getItemRuleDataByTid(costPropsVo.tid)
        local allItem = {}
        for k, vo in pairs(ruleVo.ruleDic) do
            for i = 1, #vo.itemList do
                table.insert(allItem, vo.itemList[i])
            end
        end
        for i = 1,#allItem do
            local propsGrid = PropsGrid:createByData({
                tid = allItem[i],
                num = 1,
                parent = self.mProScroll.content,
                scale = 0.7,
                showUseInTip = true
            })
            table.insert(self.mPropsItems, propsGrid)
        end
    end
end

function clearItemList(self)
    for i = 1, #self.mPropsItems, 1 do
        self.mPropsItems[i]:poolRecover()
    end
    self.mPropsItems = {}
end

function onOpenHeroEggProClick(self)
    local costPropsVo = props.PropsManager:getPropsVo({tid = self.mShopVo:getItemTid(), num = 1})
    GameDispatcher:dispatchEvent(EventName.OPEN_USE_HEROEGG_PRO_VIEW,{tid = costPropsVo.tid})
end

function onStepChange(self, cusCount, cusType)
    if cusType == 1 then
        -- '最大值'
        local MaxCount = sysParam.SysParamManager:getValue(SysParamType.SHOP_MAX_BUY_NUM)
        if self.mNumberStepper.MaxCount >= MaxCount then
            gs.Message.Show(_TT(272, MaxCount))
            return
        end
        gs.Message.Show(_TT(4018))
    elseif cusType == 2 then
        -- '最小值'
        gs.Message.Show(_TT(4019))
    end
    self:updatePrice(self.mNumberStepper.CurrCount * self.mShopVo.price)
end

function updatePrice(self, cusPrice)
    local colorStr = MoneyUtil.getMoneyCountByTid(self.mShopVo:getRealPayType()) < cusPrice and "ed1941ff" or "474C50FF"
    self.mTxtPrice.text = HtmlUtil:color(MoneyUtil.shortValueStr(cusPrice), colorStr)
    self.mTxtNeedPrice.text = MoneyUtil.shortValueStr(self.mShopVo:getPrice())
    if self.mShopVo.discount == 0 then
        self.mImgDisCount:SetActive(false)
        self.mTxtOldPrice.gameObject:SetActive(false)
    else
        self.mImgDisCount:SetActive(true)
        self.mTxtOldPrice.gameObject:SetActive(true)
        self.mTxtDisCount.text = _TT(25029, HtmlUtil:size(self.mShopVo.discount / 1000, 30))
        self.mTxtOldPrice.text = MoneyUtil.shortValueStr(self.mShopVo.old_price)
    end
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mTxtPrice.transform) --立即刷新
end

function onBuyHandler(self)
    local costTid = sysParam.SysParamManager:getValue(SysParamType.ARENA_CHALLENGE_COST_TID)
    --local shopVo = shop.ShopManager:getShopItemByTid(ShopType.NOMAL, costTid)
    if self.mShopVo.item_tid == costTid and self.mShopVo:getBuyTimes() >= self.mShopVo:getLimit() then
        gs.Message.Show(_TT(1379))
        return
    end

    local result, tips = MoneyUtil.judgeNeedMoneyCountByTid(self.mShopVo:getRealPayType(), self.mNumberStepper.CurrCount * self.mShopVo:getPrice(), true, true)
    if result and tips == "" then
        GameDispatcher:dispatchEvent(EventName.REQ_SHOP_BUY, {type = self.mShopVo:getType(), id = self.mShopVo:getId(), num = self.mNumberStepper.CurrCount})
        self:close()
        if self.mCloseCall then
            self.mCloseCall()
        end
    elseif result and tips ~= "" then
        UIFactory:alertMessge(tips, true, function()
            GameDispatcher:dispatchEvent(EventName.REQ_SHOP_BUY, {type = self.mShopVo:getType(), id = self.mShopVo:getId(), num = self.mNumberStepper.CurrCount})
            self:close()
            if self.mCloseCall then
                self.mCloseCall()
            end
        end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil
    )
elseif not result then
    UIFactory:alertMessge(tips, true, function()
        GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {linkId = LinkCode.Purchase})
        self:close()
        if self.mCloseCall then
            self.mCloseCall()
        end
    end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil
)
end
end
-----------------------------------------------------------
function recoverBtnGoDic(self)
    if (self.m_btnGoDic) then
        for hashCode, data in pairs(self.m_btnGoDic) do
            self:removeOnClick(data.go)
            gs.GOPoolMgr:RecoverOther(data.uniqueName, data.go)
        end
    end
    self.m_btnGoDic = {}
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
