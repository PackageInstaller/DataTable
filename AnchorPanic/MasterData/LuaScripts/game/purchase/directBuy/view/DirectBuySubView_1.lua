-- 直购礼包商店
module('game.purchase.view.DirectBuySubView_1', Class.impl('lib.component.BaseContainer'))

UIRes = UrlManager:getUIPrefabPath('purchase/DirectBuySubView_1.prefab')

--构造函数
function ctor(self)
    super.ctor(self)
end

function dtor(self)
end

function initData(self)
    self.mSubTabType = 1
end

function configUI(self)
    self.mScroller = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.mScroller:SetItemRender(purchase.DirectBuyItem)

    self.mGroupTabItem = self:getChildTrans("mGroupTabItem")
end

function active(self)
    super.active(self)
    GameDispatcher:addEventListener(EventName.UPDATE_DIRECT_BUY_INFO, self.__onUpdateViewHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_DIRECT_BUY_GO, self.__onUpdateViewHandler, self)
    GameDispatcher:dispatchEvent(EventName.REQ_DIRECT_BUY_INFO)

    self:createTabItem()
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_DIRECT_BUY_INFO, self.__onUpdateViewHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_DIRECT_BUY_GO, self.__onUpdateViewHandler, self)
    self.mScroller:CleanAllItem()
end

function __onUpdateViewHandler(self, args)
    self:__updateView()
end

function __updateView(self, isInit)
    if (self.mSubTabType) then
        local list = purchase.DirectBuyManager:getDirectBuyList(self.mSubTabType)
        for k, v in pairs(list) do
            v.tweenId = k
        end
        if self.mScroller.Count <= 0 or isInit == true then
            self.mScroller.DataProvider = list
        else
            self.mScroller:ReplaceAllDataProvider(list)
        end
    end
end

function setTabIndex(self, index)
    self.mSubTabType = index
    self:__updateView(true)
end

function show(self, parent, subPage)
    -- self.mSubTabType = subPage
    self:setParentTrans(parent)
    self:__updateView()
    self:setTabSelect(1)
end


function setTabSelect(self, index)
    if self.mTabItemDic then
        for i, item in pairs(self.mTabItemDic) do
            item:setSelect(index == i)
        end
    end
    self:setTabIndex(index)
end

function clearTabItem(self)
    if self.mTabItemDic then
        for k, item in pairs(self.mTabItemDic) do
            item:destroy()
        end
        self.mTabItemDic = nil
    end
end

function createTabItem(self)
    local typeList = { shopLang = { 50070, 50071 } }
    self.mTabItemDic = {}
    for i = 1, 2 do
        local tabItem = UI.new(shop.ShopTabChildItem)
        tabItem:setParentTrans(self.mGroupTabItem)
        tabItem:setData(typeList, i, self.setTabSelect, self)
        self.mTabItemDic[i] = tabItem
    end
end


-- 移除
function destroy(self, isAuto)
    super.destroy(self, isAuto)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]