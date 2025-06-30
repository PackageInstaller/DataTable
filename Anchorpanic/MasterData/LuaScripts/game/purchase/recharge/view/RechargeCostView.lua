--[[ 
-----------------------------------------------------
@filename       : RechargeCostView
@Description    : 充值界面
@date           : 2023-3-28 15:59:00
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("purchase.RechargeCostView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("purchase/RechargeView.prefab")

function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    self.rechargeItems = {}
end

function configUI(self)
    self.accRechargeBtn = self:getChildGO("accRechargeBtn")
    self.mScroller = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.mScroller:SetItemRender(purchase.RechargeCostItem)
end

function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({ MoneyTid.PAY_ITIANIUM_TID, MoneyTid.ITIANIUM_TID })
    GameDispatcher:addEventListener(EventName.UPDATE_RECHARGEPANEL, self.__updatePanel, self)
    GameDispatcher:addEventListener(EventName.UPDATE_ACCRECHARGEPANEL, self.updateBubble, self)
    self:onShow()
    self:updateBubble()
end

function __updatePanel(self)
    self:onShow()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self:setBtnLabel(self.accRechargeBtn, 50049, "充值奖励")
end

function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    GameDispatcher:removeEventListener(EventName.UPDATE_RECHARGEPANEL, self.__updatePanel, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_ACCRECHARGEPANEL, self.updateBubble, self)
    if self.mScroller.Count > 0 then
        self.mScroller:CleanAllItem()
    end
    RedPointManager:remove(self.accRechargeBtn.transform)
end


function updateBubble(self)
    local isFlag = purchase.AccRechargeManager:getAccIsCanRecive()
    if isFlag then
        RedPointManager:add(self.accRechargeBtn.transform, nil, 70, 17.5)
    else
        RedPointManager:remove(self.accRechargeBtn.transform)
    end
end

function addAllUIEvent(self)
    super.addAllUIEvent(self)
    self:addUIEvent(self.accRechargeBtn, self.openAccRechargePanel)
end

function onShow(self)
    local rechargeList = recharge.RechargeManager:getAllRechargeList(recharge.RechargeType.MONEY_ITIANIUM)
    for i = 1, #rechargeList do
        rechargeList[i].index = i
        rechargeList[i].tweenId = i
    end
    if self.mScroller.Count <= 0 then
        self.mScroller.DataProvider = rechargeList
    else
        self.mScroller:ReplaceAllDataProvider(rechargeList)
    end
end

function openAccRechargePanel(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_ACCRECHARGE)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]