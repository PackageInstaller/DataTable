module("purchase.PurchaseManager", Class.impl(Manager))

BUBBLE_CHANGE = "BUBBLE_CHANGE"

--构造函数
function ctor(self)
    super.ctor(self)
    self:__init()
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__init()
end

function __init(self)
    self:addEventListener(self.BUBBLE_CHANGE, self.getTabBubbleByType, self)
end

-- 解析配置表
function parseConfig(self)
end

-- 获取子界面红点
function getTabBubbleByType(self, tabType)
    local isBubble = false
    local funcId = nil
    if tabType == purchase.PurchaseTab.MONTH_CARD then

    elseif tabType == purchase.PurchaseTab.DIRECT_BUY then
        isBubble = purchase.DirectBuyManager:checkRed()
        funcId = funcopen.FuncOpenConst.FUNC_ID_PURCHASE_DIRECT_BUY
    elseif tabType == purchase.PurchaseTab.RECHARGE then
        isBubble = purchase.AccRechargeManager:getAccIsCanRecive()
        funcId = funcopen.FuncOpenConst.FUNC_ID_PURCHASE_RECHARGE
    elseif tabType == purchase.PurchaseTab.SKIN_SHOP then
        --isBubble = purchase.GradeGiftManager:getIsGradeGiftBubble()
    elseif tabType == purchase.PurchaseTab.GRADE_GIFT then
        isBubble = purchase.GradeGiftManager:getIsGradeGiftBubble()
        funcId = funcopen.FuncOpenConst.FUNC_ID_GRADE_GIFT
    end
    mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_SHOPPING, isBubble, funcId)
    return isBubble
end

--析构函数
function dtor(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]