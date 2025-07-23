--[[ 
-----------------------------------------------------
@filename       : RogueLikeShopPanel
@Description    : 肉鸽商店界面
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]] module("rogueLike.RogueLikeShopPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("rogueLike/RogueLikeShopPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
end

-- 析构
function dtor(self)
end

function initData(self)
    self.mShowItemList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    self.mScrollView = self:getChildGO("mScrollView"):GetComponent(ty.ScrollRect)
    self.mBtnBuy = self:getChildGO("mBtnBuy")
    self.mBtnSell = self:getChildGO("mBtnSell")
    self.mBuySelect = self:getChildGO("mBuySelect")
    self.mSellSelect = self:getChildGO("mSellSelect")
    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mBtnReset = self:getChildGO("mBtnReset")
    -- self.mBtnLevelUp = self:getChildGO("mBtnLevelUp")
    self.mResetCost = self:getChildGO("mResetCost"):GetComponent(ty.Text)
    self.mLevelUpCost = self:getChildGO("mLevelUpCost"):GetComponent(ty.Text)

    self.mTxtCoin = self:getChildGO("mTxtCoin"):GetComponent(ty.Text)
    self.mTxtCost = self:getChildGO("mTxtCost"):GetComponent(ty.Text)

    self.mBtnSelect = self:getChildGO("mBtnSelect")
    ------------------------CurrentShow------------------------
    -- self.mSelectItemInfo = self:getChildGO("mSelectItemInfo")
    -- self.mIconSelect = self:getChildGO("mIconSelect"):GetComponent(ty.AutoRefImage)
    -- self.mTxtSelectName = self:getChildGO("mTxtSelectName"):GetComponent(ty.Text)
    -- self.mTxtSelectDes = self:getChildGO("mTxtSelectDes"):GetComponent(ty.Text)
    -- self.mBtnSelect = self:getChildGO("mBtnSelect")
    -- self.mTxtSelect = self:getChildGO("mTxtSelect"):GetComponent(ty.Text)
    -- self.mIconSelectCost = self:getChildGO("mIconSelectCost"):GetComponent(ty.AutoRefImage)

end

-- 激活
function active(self, args)
    super.active(self, args)
    GameDispatcher:addEventListener(EventName.UPDATE_ROGUELIKE_MAP_PANEL, self.onUpdateShopPanel, self)

    self.cellId = args.id
    self.eventId = args.eventId
    -- 0 buy 1 sell
    self.mSelectState = 0
    self:updateView()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_ROGUELIKE_MAP_PANEL, self.onUpdateShopPanel, self)
    GameDispatcher:dispatchEvent(EventName.REQ_UPDATE_SHOP_LOCK)
    self:recoverList()
end

function addAllUIEvent(self)
    -- self:addUIEvent(self.mBtnBuy, self.onSwitchState, nil, 0)
    -- self:addUIEvent(self.mBtnSell, self.onSwitchState, nil, 1)
    -- self:addUIEvent(self.mBtnLevelUp, self.onShopLevelUpClick)
    self:addUIEvent(self.mBtnSelect, self.onSelectBuyClick)
    self:addUIEvent(self.mBtnClose, self.onCloseShopClick)
    self:addUIEvent(self.mBtnReset, self.onResetShopClick)
    -- self:addUIEvent(self.mBtnSelect, self.onBtnSelectClick)
end

-- 刷新商店
function onUpdateShopPanel(self)
    if self.showItem then
        -- 回收之前打开的
        self.showItem:setSelect(false)
        self.showItem = nil
    end
    self.showId = nil
    self.needBuyCost = nil
    self.grooveId = nil
    self.price = 0

    self.mTxtCost.gameObject:SetActive(self.price > 0)
    self:updateView()
end

function onCloseShopClick(self)
    -- 关闭商店
    GameDispatcher:dispatchEvent(EventName.REQ_ROGUE_SHOP_CLOSE, {cellId = self.cellId, eventId = self.eventId})
    self:onClickClose()
end

function onResetShopClick(self)
    -- 刷新商店
    if MoneyUtil.judgeNeedMoneyCountByTid(MoneyTid.FUNCTION_TID, self.mShopData.refreshCoin) then
        GameDispatcher:dispatchEvent(EventName.REQ_ROGUE_SHOP_RESET, {cellId = self.cellId})
    end
end

-- function onShopLevelUpClick(self)
--     -- 升级商店
--     if self.mShopData.maxLv == 1 then
--         gs.Message.Show("已经满级无法继续升级")
--         return
--     end
--     if MoneyUtil.judgeNeedMoneyCountByTid(MoneyTid.FUNCTION_TID, self.mShopData.lvUpCoin) then
--         GameDispatcher:dispatchEvent(EventName.REQ_ROGUE_SHOP_LEVEL_UP, {cellId = self.cellId})
--     end
-- end

-- 购买出售按钮点击
-- function onBtnSelectClick(self)
--     if self.mSelectState == 0 then
--         if MoneyUtil.judgeNeedMoneyCountByTid(MoneyTid.FUNCTION_TID, self.needBuyCost) then
--             GameDispatcher:dispatchEvent(EventName.REQ_ROGUE_SHOP_BUY, {cellId = self.cellId, grooveId = self.grooveId})
--         end
--     else
--         GameDispatcher:dispatchEvent(EventName.REQ_ROGUE_SHOP_SELL, {cellId = self.cellId, goodsId = self.showId})
--     end
-- end

function onSelectBuyClick(self)
    if self.grooveId == nil then
        gs.Message.Show("请选择需要购买的商品")
        return
    end

    if MoneyUtil.judgeNeedMoneyCountByTid(MoneyTid.FUNCTION_TID, self.needBuyCost) then
        GameDispatcher:dispatchEvent(EventName.REQ_ROGUE_SHOP_BUY, {cellId = self.cellId, grooveId = self.grooveId})
    end
end

function updateView(self)
    local playerVo = role.RoleManager:getRoleVo()
    self.mTxtCoin.text = playerVo:getFunctionCoin()
    self.mCurrentBuff = rogueLike.RogueLikeManager:getBuffList()
    self.mShopData = rogueLike.RogueLikeManager:getShopData()
    self.mResetCost.text = self.mShopData.refreshCoin
    self.mLevelUpCost.text = self.mShopData.maxLv == 0 and self.mShopData.lvUpCoin or "已经满级"

    self.showList = self.mShopData.goodList

    if self.mShopData.refreshCoin == 99999 then
        self.mBtnReset:SetActive(false)
        self.mResetCost.gameObject:SetActive(false)
    else
        self.mBtnReset:SetActive(true)
        self.mResetCost.gameObject:SetActive(true)
    end
  
    self:recoverList()
    for i = 1, #self.showList do
        local item = rogueLike.RogueLikeBuffItemResuse:poolGet()
        item:addEventListener(item.EVENT_CHANGE, self.onItemChange, self)
        item:setData(self.mScrollView.content, self.cellId, self.showList[i].goods_id, true, self.showList[i].is_buy,self.showList[i].improve_efficiency)
        table.insert(self.mShowItemList, item)
    end
end

-- 回收项
function recoverList(self)
    if self.mShowItemList then
        for i, v in pairs(self.mShowItemList) do
            v:removeEventListener(v.EVENT_CHANGE, self.onItemChange, self)
            v:poolRecover()
        end
    end
    self.mShowItemList = {}
end

function getBuffShopData(self, buffId)
    for i = 1, #self.showList do
        if self.showList[i].goods_id == buffId then
            return self.showList[i]
        end
    end
    return nil
end

function onItemChange(self, args)
    if self.showItem then
        -- 回收之前打开的
        self.showItem:setSelect(false)
        self.showItem = nil
    end

    self.showItem = args.item
    self.showId = self:getBuffShopData(self.showItem.mBuffId).showId
    self.grooveId = self:getBuffShopData(self.showItem.mBuffId).groove_id
    self.price = self:getBuffShopData(self.showItem.mBuffId).price
    self.needBuyCost = self.price
    self.mTxtCost.text = self.price
    self.mTxtCost.gameObject:SetActive(self.price > 0)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
