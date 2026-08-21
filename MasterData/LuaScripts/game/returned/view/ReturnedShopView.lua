--[[ 
-----------------------------------------------------
@filename       : ReturnedShopView
@Description    : 常驻活动——直购礼包
@date           : 2023-10-31 17:27:16
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.returned.view.ReturnedShopView', Class.impl(TabSubView))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("returned/ReturnedShopView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

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
    self.mLyScroller = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.mLyScroller:SetItemRender(returned.ReturnedShopBuyItem)
    self.mTxtTips = self:getChildGO("mTxtTips"):GetComponent(ty.Text)
    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)
end

--激活
function active(self)
    super.active(self)
    MoneyManager:setMoneyTidList({ MoneyTid.PAY_ITIANIUM_TID }, 1)

    GameDispatcher:dispatchEvent(EventName.REQ_SHOP_TYPE_DATA, ShopType.RETURNED)
    shop.ShopManager:addEventListener(shop.ShopManager.EVENT_SHOP_DATA_UPDATE, self.onDataUpdateHandler, self)
    shop.ShopManager:addEventListener(shop.ShopManager.EVENT_SHOP_ITEM_UPDATE, self.onDataUpdateHandler, self)
    self:addTimer(1, 0, self.addTimer)
    self:updateView()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    shop.ShopManager:removeEventListener(shop.ShopManager.EVENT_SHOP_DATA_UPDATE, self.onDataUpdateHandler, self)
    shop.ShopManager:removeEventListener(shop.ShopManager.EVENT_SHOP_ITEM_UPDATE, self.onDataUpdateHandler, self)
    MoneyManager:setMoneyTidList()
    if self.mLyScroller then
        self.mLyScroller:CleanAllItem()
    end
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
    self.mTxtTips.text = "仅限在回归期间出售"
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    -- self:addUIEvent(self.aa,self.onClick)
end

function onDataUpdateHandler(self)
    self:updateView()
end

function updateView(self)
    local list = shop.ShopManager:getShopItemList(ShopType.RETURNED)
    table.sort(list, function(vo1, vo2)
        if vo1:isSoldout() == (vo2:isSoldout()) then
            return vo1:getId() < vo2:getId()
        else
            if (not vo1:isSoldout()) then
                return true
            else
                return false
            end
        end
    end)

    for k, v in pairs(list) do
        v.tweenId = 2 + (k - 1) * 2
    end

    if (self.mLyScroller.Count <= 0) then
        self.mLyScroller.DataProvider = list
    else
        self.mLyScroller:ReplaceAllDataProvider(list)
    end
end

function addTimer(self)
    local clientTime = GameManager:getClientTime()
    local remaindTime = returned.ReturnedManager.endTime - clientTime
    self.mTxtTime.text = string.format("活动剩余时间：%s", TimeUtil.getFormatTimeBySeconds_10(remaindTime))
end

return _M