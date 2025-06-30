--[[
-----------------------------------------------------
@filename       : ShopBuyView2
@Description    : 商店购买弹窗
@date           : 2023-05-12 19:31:01
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("game.shop.view.ShopBuyView2", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("shop/ShopBuyView.prefab")

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
    self.mShopVo = args
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
    self:addUIEvent(self.mCloseMask, self.onClickClose)
    self:addUIEvent(self.mBtnClose, self.onClickClose)
    self:addUIEvent(self.mBtnBuy, self.onBuyHandler)
    self:addUIEvent(self.m_childGos["mBtnClickItem"], function()
        local equipVo = LuaPoolMgr:poolGet(props.EquipVo)
        equipVo:setTid(self.mShopVo:getItemTid())
        TipsFactory:equipTips(equipVo)

    end)
    self:addUIEvent(self.mBtnHeroEggPro, self.onOpenHeroEggProClick)
end

--[[
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtSuitTitle.text = _TT(1316)--套装属性
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
        self.m_childGos["mBtnClickItem"]:SetActive(true)
        self.mImgIcon.gameObject:SetActive(false)
        self.mImgEquipBG.gameObject:SetActive(true)
        self.mImgEquipBG:SetImg(UrlManager:getNraceletColorUrl(propsVo.color), false)
        self.mImgEquipIcon:SetImg(UrlManager:getPropsIconUrl(propsVo.tid), false)
    else
        if self.m_childGos["mBtnClickItem"].activeSelf == true then
            self.m_childGos["mBtnClickItem"]:SetActive(false)
        end
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
    self:updateSuit(self.mShopVo)
    self:updateEggInfo()
end

function setBuyNum(self, currCount)
    self.mNumberStepper.CurrCount = currCount
end

function updateItem(self)
    self:clearItem()
    local costPropsVo = props.PropsManager:getPropsVo({tid = self.mShopVo:getRealPayType(), num = 1})
    self.mGridProp = PropsGrid:create(self.mGroupItemProp, costPropsVo, 0.45)
    self.mGroupItem:SetImg(MoneyUtil.getMoneyIconUrlByTid(costPropsVo.tid), true)
    self.mGridProp:setShowColorBgState(false)
end

--更新套装弹窗信息
function updateSuit(self, Vo)
    if Vo == nil then
        return
    end
    self:clearSuitItem()
    local propsVo = props.PropsManager:getPropsVo({tid = Vo.item_tid, num = 1})
    --  self.mGroupSuit:SetActive(propsVo.effectType == UseEffectType.ADD_CHIP_GIFT)
    if propsVo.effectType == UseEffectType.ADD_CHIP_GIFT then
        local tid = AwardPackManager:getAwardListById(propsVo.effectList[1])[1].tid
        local equipConfigVo = equip.EquipManager:getEquipConfigVo(tid)
        if equipConfigVo == nil then
            tid = AwardPackManager:getAwardListById(tid)[1].tid
            equipConfigVo = equip.EquipManager:getEquipConfigVo(tid)
        end

        if equipConfigVo then
            local suitId = equipConfigVo and equipConfigVo.suitId or 0
            local suitConfigVo = equip.EquipSuitManager:getEquipSuitConfigVo(suitId)
            local suitList = {}
            if suitConfigVo then
                if suitConfigVo.suitSkillId_2 > 0 and suitConfigVo.suitSkillId_4 > 0 then
                    suitList[1] = suitConfigVo.suitSkillId_2
                    suitList[2] = suitConfigVo.suitSkillId_4
                elseif suitConfigVo.suitSkillId_4 > 0 then
                    suitList[1] = suitConfigVo.suitSkillId_4
                elseif suitConfigVo.suitSkillId_2 > 0 then
                    suitList[1] = suitConfigVo.suitSkillId_2
                end
                for i, vo in ipairs(suitList) do
                    local skillVo = fight.SkillManager:getSkillRo(vo)
                    local introduceItem = SimpleInsItem:create(self:getChildGO("mSuitGroup"), self.mSuitTrans, "ShopBuyView2SuitGroup")
                    introduceItem:getChildGO("mTxtTitleSuit"):GetComponent(ty.Text).text = _TT(4036 + i)
                    introduceItem:getChildGO("mTxtSuitDes"):GetComponent(ty.Text).text = skillVo:getDesc()
                    table.insert(self.mSuitItemList, introduceItem)
                end
            end
        end
    end
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

function clearSuitItem(self)
    if #self.mSuitItemList > 0 then
        for i, _ in ipairs(self.mSuitItemList) do
            self.mSuitItemList[i]:poolRecover()
        end
        self.mSuitItemList = {}
    end
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
    local result, tips = MoneyUtil.judgeNeedMoneyCountByTid(self.mShopVo:getRealPayType(), self.mNumberStepper.CurrCount * self.mShopVo:getPrice(), true, true)
    if (tips == "" and result == true) then
        GameDispatcher:dispatchEvent(EventName.REQ_SHOP_BUY, {type = self.mShopVo:getType(), id = self.mShopVo:getId(), num = self.mNumberStepper.CurrCount})
        self:close()
    else
        if self.mShopVo:getRealPayType() == MoneyTid.GOLD_COIN_TID then
            GameDispatcher:dispatchEvent(EventName.OPEN_CONVERT_VIEW)
            self:close()
            return
        elseif self.mShopVo:getRealPayType() == MoneyTid.ITIANIUM_TID then
            MoneyUtil.judgeNeedMoneyCountByTidTips(self.mShopVo:getRealPayType(), self.mNumberStepper.CurrCount, self.mShopVo, nil, function()
                self:close()
            end)
            return
        else
            gs.Message.Show(_TT(1231))
            return
        end
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
