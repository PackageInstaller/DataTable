--[[ 
-----------------------------------------------------
@filename       : ShopRecommendedView
@Description    : 碎片商店内容页
@date           : 2022-02-08 11:38:16
@Author         : Jacob
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
--
module('game.shop.view.sub.ShopRecommendedView', Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("shop/ShopRecommendedView.prefab")
function ctor(self)
    super.ctor(self)
end

function initData(self)
    self.mItemList = {}
end

function configUI(self)
    super.configUI(self)
    self.mBtnPreview = self:getChildGO("mBtnPreview")
    self.mGroupGrowth = self:getChildGO("mGroupGrowth")
    self.mGroupMonthly = self:getChildGO("mGroupMonthly")
    self.mGroupFirstCharge = self:getChildGO("mGroupFirstCharge")
    self.mGroupAwardTrans = self:getChildTrans("mGroupAwardTrans")
    self.mGroupFashion = self:getChildGO("mGroupFashion")
    self.mGroupStrength = self:getChildGO("mGroupStrength")
    self.mImgRecom = self:getChildGO("mImgRecom"):GetComponent(ty.AutoRefImage)
end

function active(self, args)
    super.active(self, args)
    self:updateview()
end

function deActive(self)
    super.deActive(self)
    self:removeAllItem()
end

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnPreview, self.onClickLockHandler)
    self:addUIEvent(self.mGroupGrowth, self.onClickHandler, nil, LinkCode.GrowthFund)
    self:addUIEvent(self.mGroupMonthly, self.onClickBuyMonthly)
    self:addUIEvent(self.mGroupFashion, self.onClickHandler, nil, LinkCode.FashionShop)
    self:addUIEvent(self.mGroupStrength, self.onClickBuyStrength)
end
--跳转id
function onClickHandler(self, uicode)
    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = uicode })
end

function onClickBuyMonthly(self)
    if (purchase.MonthCardManager:getHadBuyTimes() < sysParam.SysParamManager:getValue(SysParamType.MONTY_CARD_LIMIT_BUY_TIMES)) then
        recharge.sendRecharge(recharge.RechargeType.MONTH_CARD, nil, nil)
    else
        gs.Message.Show(_TT(50028))
    end
end

function onClickBuyStrength(self)
    if (purchase.MonthCardManager:getStrengthBuyTimes() < sysParam.SysParamManager:getValue(SysParamType.STRENGTH_BUY_MAX_COUNT)) then
        recharge.sendRecharge(recharge.RechargeType.STRENGTH_CARD, nil, nil)
    else
        gs.Message.Show(_TT(50028))
    end
end

function updateview(self)

    if not firstCharge.FirstChargeManager:getIsReCharge() then
        self.mGroupFashion:SetActive(false)
        self.mGroupFirstCharge:SetActive(true)

        self:removeAllItem()
        local firstChargeList = firstCharge.FirstChargeManager:getFirstChargeList()
        for _, firstChargeVo in ipairs(firstCharge.FirstChargeManager:getFirstChargeList()) do
            local propVo = firstChargeVo:getItemList()[1]
            local propGrid = PropsGrid:createByData({ tid = propVo[1], num = propVo[2], parent = self.mGroupAwardTrans, scale = 0.54, showUseInTip = true })
            propGrid:setIsShowCanRec(true)
            table.insert(self.mItemList, propGrid)
        end
    else
        self.mGroupFashion:SetActive(true)
        self.mGroupFirstCharge:SetActive(false)
    end


    self.mGroupGrowth:SetActive(not purchase.GrowthFundManager:getIsGrowthFundMoney())
    self.mGroupStrength:SetActive(purchase.GrowthFundManager:getIsGrowthFundMoney())

    if (RefMgr:getSpecialConfig() and sdk.SdkManager:getIsChannelHarmonious()) then
        self.mImgRecom:SetImg(UrlManager:getPackPath("shop/shop_recom_15_har.png"))
    end
end

function removeAllItem(self)
    if #self.mItemList > 0 then
        for _, item in ipairs(self.mItemList) do
            item:poolRecover()
            item = nil
        end
        self.mItemList = {}
    end
end

--查看泠详情
function onClickLockHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_HERO_RECRUITINFOPANEL, { heroTid = 1004 })
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(25034):	"辅助"
	语言包: _TT(25033):	"输出"
	语言包: _TT(25032):	"坦克"
	语言包: _TT(25196):	"全部"
]]