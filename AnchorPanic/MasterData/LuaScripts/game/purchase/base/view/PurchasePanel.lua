
module('purchase.PurchasePanel', Class.impl(TabView))

UIRes = UrlManager:getUIPrefabPath('purchase/PurchasePanel.prefab')
panelType = 1 -- 窗口类型 1 全屏 2 弹窗
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
isShow3DBg = 1
--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(52022))
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.showTabType = 2
end

function configUI(self)
    super.configUI(self)
end

function active(self, args)
    super.active(self, args)
    purchase.PurchaseManager:addEventListener(purchase.PurchaseManager.BUBBLE_CHANGE, self.updateBubble, self)
    self:updateBubbleHandler()
end

function deActive(self)
    super.deActive(self)
    Perset3dHandler:setupShowData(MainCityConst.UI_COMMON_3D_BG, nil, nil, UrlManager:getBgPath("common/common_bg_020.jpg"))
    purchase.PurchaseManager:removeEventListener(purchase.PurchaseManager.BUBBLE_CHANGE, self.updateBubble, self)
    MoneyManager:setMoneyTidList()
    self:removeOnClick(self.accRechargeBtn)
end

function initViewText(self)
    super.initViewText(self)
end

function isHorizon(self)
    return false
end

-- 页签父节点
function getTabBarParent(self)
    return self:getChildTrans("TabBarNode")
end

function getTabDatas(self)
    self.tabDataList = {}
    local list = purchase.getTabList()
    for _, vo in pairs(list) do
        table.insert(self.tabDataList, { type = vo.page, content = { vo.nomalLan }, nomalIcon = vo.nomalIcon, selectIcon = vo.nomalIcon })
    end
    return self.tabDataList
end

function getTabClass(self)
    self.tabClassDic[purchase.PurchaseTab.MONTH_CARD] = purchase.MonthCardView
    self.tabClassDic[purchase.PurchaseTab.DIRECT_BUY] = purchase.DirectBuyView
    self.tabClassDic[purchase.PurchaseTab.RECHARGE] = purchase.RechargeCostView
    self.tabClassDic[purchase.PurchaseTab.SKIN_SHOP] = purchase.FashionShopView
    self.tabClassDic[purchase.PurchaseTab.GRADE_GIFT] = purchase.GradeGiftView
    return self.tabClassDic
end

function setType(self, cusTabType, cusArgs, cusIsDispatch)
    super.setType(self, cusTabType, cusArgs, cusIsDispatch)
    if (cusTabType == purchase.PurchaseTab.RECHARGE) then
         Perset3dHandler:setupShowData(MainCityConst.UI_COMMON_3D_BG, nil, nil, UrlManager:getBgPath("recharge/recharge_bg.jpg"))
    else 
         Perset3dHandler:setupShowData(MainCityConst.UI_COMMON_3D_BG, nil, nil, UrlManager:getBgPath("common/common_bg_020.jpg"))
    end
    if (cusTabType == purchase.PurchaseTab.MONTH_CARD) then
        MoneyManager:setMoneyTidList()
    elseif (cusTabType == purchase.PurchaseTab.DIRECT_BUY) or (cusTabType == purchase.PurchaseTab.RECHARGE) then
        MoneyManager:setMoneyTidList({ MoneyTid.PAY_ITIANIUM_TID, MoneyTid.ITIANIUM_TID })
    elseif (cusTabType == purchase.PurchaseTab.SKIN_SHOP) or (cusTabType == purchase.PurchaseTab.GRADE_GIFT) then
        MoneyManager:setMoneyTidList({ MoneyTid.PAY_ITIANIUM_TID })
    end

end

function setPage(self, cusType)
    super.setPage(self, cusType)
end

function updateBubbleHandler(self)
    for k,v in pairs(self.tabClassDic) do
        self:updateBubble(k)
    end
end

function updateBubble(self, tabType)
    local isBubble =purchase.PurchaseManager:getTabBubbleByType(tabType)
    if (isBubble) then
        self:addBubble(tabType)
    else
        self:removeBubble(tabType)
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]