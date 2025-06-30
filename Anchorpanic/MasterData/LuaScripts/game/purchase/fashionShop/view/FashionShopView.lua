--[[ 
-----------------------------------------------------
@filename       : FashionShopView
@Description    : 皮肤商店
@date           : 2023-03 19:58:23
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('purchase.FashionShopView', Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath('purchase/FashionShopView.prefab')
panelType = 1 -- 窗口类型 1 全屏 2 弹窗

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.curType = 1
end

function configUI(self)
    super.configUI(self)
    self.mLyScroller = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.mLyScroller:SetItemRender(purchase.FashionShopItem)
end

function active(self, args)
    super.active(self, args)
    local fashionShopVo = purchase.FashionShopManager:getFashionShopVoByType(self:getPageType())
    MoneyManager:setMoneyTidList({ fashionShopVo:getMoneyTid() })
    GameDispatcher:addEventListener(EventName.UPDATE_SKIN_SHOP, self.updateView, self)
    self:updateView()
end

function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    GameDispatcher:removeEventListener(EventName.UPDATE_SKIN_SHOP, self.updateView, self)
    if self.mLyScroller then
        self.mLyScroller:CleanAllItem()
    end
end

function initViewText(self)
    super.initViewText(self)
end

function addAllUIEvent(self)

end

function getPageType(self)
    return fashionShop.ShopType.NOMAL
end

function updateView(self)
    local list = purchase.FashionShopManager:getCurShopList(self:getPageType())
    table.sort(list, function(vo1, vo2)
        local v1 = vo1:getIsSellOut() and 0 or 1
        local v2 = vo2:getIsSellOut() and 0 or 1
        if v1 > v2 then
            return true
        elseif v1 < v2 then
            return false
        else
            return vo1.sort < vo2.sort
        end
    end)

    for i, vo in ipairs(list) do
        list[i].isShow = false
        list[i].tweenId = i
    end
    if self.mLyScroller.Count <= 0 then
        self.mLyScroller.DataProvider = list
    else
        self.mLyScroller:ReplaceAllDataProvider(list)
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]