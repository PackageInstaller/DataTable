-- @FileName:   RoundPrizeShopPanel.lua
-- @Description:   描述
-- @Author: ZDH
-- @Date:   2024-12-20 17:42:57
-- @Copyright:   (LY) 2024 锚点降临

module("game.roundPrizeTwo.RoundPrizeShopTwoPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("roundPrizeTwo/RoundPrizeShopTwoPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)

end

function initData(self)

end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mText_1 = self:getChildGO("mText_1"):GetComponent(ty.Text)
    self.mImgNumIcon = self:getChildGO("mImgNumIcon"):GetComponent(ty.AutoRefImage)
    self.mTextNums = self:getChildGO("mTextNums"):GetComponent(ty.Text)

    self.mItem = self:getChildGO("mItem")
    self.content = self:getChildTrans("content")
end

function initViewText(self)
    self.mText_1.text = _TT(121207)
end

-- 激活
function active(self, args)
    super.active(self, args)

    bag.BagManager:addEventListener(bag.BagManager.BAG_UPDATE, self.refreshMoney, self)

    shop.ShopManager:addEventListener(shop.ShopManager.EVENT_SHOP_DATA_UPDATE, self.refreshItem, self)
    shop.ShopManager:addEventListener(shop.ShopManager.EVENT_SHOP_TYPE_UPDATE, self.onShopUpdateHandler, self)
    shop.ShopManager:addEventListener(shop.ShopManager.EVENT_SHOP_ITEM_UPDATE, self.refreshItem, self)

    self:refreshItem()
    self:refreshMoney()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    bag.BagManager:removeEventListener(bag.BagManager.BAG_UPDATE, self.refreshMoney, self)

    shop.ShopManager:removeEventListener(shop.ShopManager.EVENT_SHOP_DATA_UPDATE, self.refreshItem, self)
    shop.ShopManager:removeEventListener(shop.ShopManager.EVENT_SHOP_TYPE_UPDATE, self.onShopUpdateHandler, self)
    shop.ShopManager:removeEventListener(shop.ShopManager.EVENT_SHOP_ITEM_UPDATE, self.refreshItem, self)

    self:clearItem()
end

-- 商店数据更新
function onShopUpdateHandler(self, cusType)
    if cusType == ShopType.ROUNDPRIZETWO then
        self:refreshItem()
    end
end

function refreshItem(self)
    self:clearItem()
    local shopDataList = shop.ShopManager:getShopItemList(ShopType.ROUNDPRIZETWO)
    for i = 1, #shopDataList do
        local item = SimpleInsItem:create(self.mItem, self.content, "RoundPrizeShopTwoPanel_item")
        table.insert(self.m_itemList, item)

        local PropGrid = PropsGrid:createByData({tid = shopDataList[i].item_tid, num = shopDataList[i].item_num, parent = item:getChildTrans("propsNode"), showUseInTip = true})
        table.insert(self.m_itemProps, PropGrid)

        item:getChildGO("mTextName"):GetComponent(ty.Text).text = shopDataList[i]:getItemName()

        if shopDataList[i]:getLimit() > 0 then
            item:getChildGO("mTextLimit"):GetComponent(ty.Text).text = _TT(25009) .. shopDataList[i]:getLimitCount()
        else
            item:getChildGO("mTextLimit"):GetComponent(ty.Text).text = _TT(121216)
        end

        -- item:getChildGO("mTextNull"):GetComponent(ty.Text).text = _TT(25011)
        -- 售罄
        if shopDataList[i]:isSoldout() then
            item:getChildGO("mTextNull"):SetActive(true)
            -- item:getChildGO("mTxtTips"):SetActive(false)
        else
            if shopDataList[i]:isLock() then
                item:getChildGO("mTextNull"):SetActive(true)
                item:getChildGO("mTxtTips"):SetActive(false)
            else
                item:getChildGO("mTextNull"):SetActive(false)
                -- item:getChildGO("mTxtTips"):SetActive(true)
            end
        end

        item:getChildGO("mImgPrice"):GetComponent(ty.AutoRefImage):SetImg(MoneyUtil.getMoneyIconUrlByTid(shopDataList[i]:getPayTid()), false)

        local namecolorStr = MoneyUtil.getMoneyCountByTid(shopDataList[i]:getRealPayType()) < shopDataList[i].price and "fa3a2bFF" or "202226FF"
        item:getChildGO("mTxtTips"):GetComponent(ty.Text).text = HtmlUtil:color(MoneyUtil.shortValueStr(shopDataList[i].price), namecolorStr)

        item:addUIEvent("mClick", function ()
            if shopDataList[i]:isLock() then
                gs.Message.Show(_TT(25031))
                return
            end

            if shopDataList[i]:isSoldout() then
                -- 已售罄
                gs.Message.Show(_TT(25011))
                return
            end

            if not shopDataList[i]:isEnoughLimit() then
                -- 等级限制
                gs.Message.Show(_TT(25012))
                return
            end

            GameDispatcher:dispatchEvent(EventName.OPEN_SHOP_BUY_VIEW, shopDataList[i])
        end)
    end
end

function refreshMoney(self)
    local prizeconfigVo = roundPrizeTwo.RoundPrizeTwoManager:getProbabilityConfigVo()
    if prizeconfigVo then
        local money_tid = prizeconfigVo.minimum_item
        self.mTextNums.text = bag.BagManager:getPropsCountByTid(money_tid)
        self.mImgNumIcon:SetImg(MoneyUtil.getMoneyIconUrlByTid(money_tid), false)
    end
end

function clearItem(self)
    if self.m_itemList then
        for k, v in pairs(self.m_itemList) do
            v:poolRecover()
        end
    end

    self.m_itemList = {}

    if self.m_itemProps then
        for k, v in pairs(self.m_itemProps) do
            v:poolRecover()
        end
    end

    self.m_itemProps = {}
end

return _M
