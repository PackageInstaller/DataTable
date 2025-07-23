--[[ 
-----------------------------------------------------
@filename       : ShopSubView
@Description    : 通用商店内容页
@date           : 2020-08-31 19:31:01
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
--
module("game.shop.view.sub.ShopSubView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("shop/ShopSubView.prefab")

-- 构造函数
function ctor(self)
    super.ctor(self)
end

function initData(self)
    self.mTabItemDic = {}
    self.tabDataList = {}
    self.mStraintCount = 0
end

function configUI(self)
    super.configUI(self)
    self.mImgUpLine = self:getChildGO("mImgUpLine")
    self.mBtnRefresh = self:getChildGO("mBtnRefresh")
    self.mGroupRefresh = self:getChildGO("mGroupRefresh")
    self.mGroupTabItem = self:getChildTrans("mGroupTabItem")
    self.mTxtCost = self:getChildGO("mTxtCost"):GetComponent(ty.Text)
    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)
    self.mTxtCount = self:getChildGO("mTxtCount"):GetComponent(ty.Text)
    self.mTxtCostTitle = self:getChildGO("mTxtCostTitle"):GetComponent(ty.Text)
    self.mTxtTimeTitle = self:getChildGO('mTxtTimeTitle'):GetComponent(ty.Text)
    self.mTxtCountTitle = self:getChildGO('mTxtCountTitle'):GetComponent(ty.Text)
    self.mImgPayIcon = self:getChildGO("mImgPayIcon"):GetComponent(ty.AutoRefImage)
    -- 商品
    self.mLyScroller = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.mLyScroller:SetItemRender(shop.ShopItem)
    self.mLimitScroller = self:getChildGO("mLimitScroller"):GetComponent(ty.LyScroller)
    self.mLimitScroller:SetItemRender(shop.ShopLimitItem)
end

function active(self, args)
    super.active(self, args)
    GameDispatcher:addEventListener(EventName.SET_SHOP_SUBINDEX, self.UpdateIndex, self)
    GameDispatcher:addEventListener(EventName.UPDATE_SHOP_TAB, self.updateShopVo, self)
    shop.ShopManager:addEventListener(shop.ShopManager.EVENT_SHOP_DATA_UPDATE, self.onDataUpdateHandler, self)
    shop.ShopManager:addEventListener(shop.ShopManager.EVENT_SHOP_TYPE_UPDATE, self.onShopUpdateHandler, self)
    shop.ShopManager:addEventListener(shop.ShopManager.EVENT_SHOP_ITEM_UPDATE, self.onDataUpdateHandler, self)
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_LVL, self.onUpdatePlayerInfoHandler, self)
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.updateShopMsgData, self)
    self:setData(args)
end

function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    GameDispatcher:removeEventListener(EventName.SET_SHOP_SUBINDEX, self.UpdateIndex, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_SHOP_TAB, self.updateShopVo, self)
    shop.ShopManager:removeEventListener(shop.ShopManager.EVENT_SHOP_DATA_UPDATE, self.onDataUpdateHandler, self)
    shop.ShopManager:removeEventListener(shop.ShopManager.EVENT_SHOP_TYPE_UPDATE, self.onShopUpdateHandler, self)
    shop.ShopManager:removeEventListener(shop.ShopManager.EVENT_SHOP_ITEM_UPDATE, self.onDataUpdateHandler, self)

    role.RoleManager:getRoleVo():removeEventListener(role.RoleVo.CHANGE_PLAYER_LVL, self.onUpdatePlayerInfoHandler, self)
    role.RoleManager:getRoleVo():removeEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.updateShopMsgData, self)
    if self.mLyScroller then
        self.mLyScroller:CleanAllItem()
    end
    if self.mLimitScroller then
        self.mLimitScroller:CleanAllItem()
    end
end

function UpdateIndex(self, index)
    self:setTabIndex(index)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtTimeTitle.text = _TT(25002)
    self.mTxtCountTitle.text = _TT(25001)
    self.mTxtCostTitle.text = _TT(25004)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnRefresh, self.onRefreshHandler)
end

function updateShopVo(self, shopVo)
    self:setData(shopVo)
end

-- 传入商店页签id
function setData(self, args)
    self.mShowSort = args.type
    self.mSubShowId = args.subType
    local list = shop.ShopManager:getShopShowList()
    for i, v in ipairs(list) do
        if v.sort == self.mShowSort then
            self.shopShowVo = v
            break
        end
    end
    self:updateBaseData()
end

-- 刷新配置数据页面
function updateBaseData(self)
    self:clearTabItem()
    local typeList = self.shopShowVo.shopType
    local shopLangList = self.shopShowVo.shopLang
    local engLangList = self.shopShowVo.engLang
    local lvlList = self.shopShowVo.lvl
    local showIndex = 1
    self.mGroupTabItem.gameObject:SetActive(#typeList > 1)
    if self.mSubShowId then
        showIndex = table.indexof01(typeList, self.mSubShowId) > 0 and table.indexof01(typeList, self.mSubShowId) or 1
    else
        if #typeList > 1 then
            for i = 1, #typeList do
                if funcopen.FuncOpenManager:isOpen(self.shopShowVo.pageFuncId[i]) then
                    showIndex = i
                    break
                end
            end
        end
    end
    if #typeList > 1 then
        self:createTabItem(typeList)
    end
    self:setTabSelect(showIndex)
    self.mImgUpLine:SetActive(((self:getShopType() == ShopType.BLACK) or (#typeList > 1)))
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

function createTabItem(self, typeList)
    self.mTabItemDic = {}
    for index, type in ipairs(typeList) do
        if funcopen.FuncOpenManager:isOpen(self.shopShowVo.pageFuncId[index]) then
            local tabItem = UI.new(shop.ShopTabChildItem)
            tabItem:setParentTrans(self.mGroupTabItem)
            tabItem:setData(self.shopShowVo.shopLang[index], index, self.setTabSelect, self)
            self.mTabItemDic[index] = tabItem
        end
    end
end

-- 请求商店类型数据
function reqShopTypeData(self)
    GameDispatcher:dispatchEvent(EventName.REQ_SHOP_TYPE_DATA, self:getShopType())
end

-- 二级菜单点击tab
function setTabIndex(self, index)
    local typeList = self.shopShowVo.shopType
    self:setShopType(typeList[index], index)
end

-- 选择商店二级类型
function setShopType(self, cusType, cusIndex)
    self.curShopType = cusType
    self.mLyScroller.gameObject:SetActive(self.curShopType ~= ShopType.BLACK)
    self.mLimitScroller.gameObject:SetActive(self.curShopType == ShopType.BLACK)
    self:reqShopTypeData()
    if self.mLyScroller.gameObject.activeSelf == true then
        self.mLyScroller:CleanAllItem()
    else
        self.mLimitScroller:CleanAllItem()
    end
    self:updateShopList()
    local payList = self.shopShowVo.payType[cusIndex]
    MoneyManager:setMoneyTidList(payList, 1)
end

-- 当前商店类型
function getShopType(self)
    return self.curShopType
end

-- 商店数据更新
function onShopUpdateHandler(self, cusType)
    if self:getShopType() == cusType then
        self:updateShopMsgData()
    end
end

-- 更新商店服务器相关数据
function updateShopMsgData(self)
    self.mShopData = shop.ShopManager:getShopData(self:getShopType())
    if not self.mShopData then
        return
    end
    -- 刷新次数
    if self.mShopData:getRefreshLimit() > 0 then
        self.mImgPayIcon:SetImg(self.mShopData:getPayIcon(), true)
        local costNum = MoneyUtil.getMoneyCountByType(self.mShopData:getPayType()) >= self.mShopData:getCostNum() and HtmlUtil:color(self.mShopData:getCostNum(), "FFFFFFFF") or HtmlUtil:color(self.mShopData:getCostNum(), "ed1941ff")
        self.mTxtCost.text = costNum
        self.mTxtCount.text = _TT(29120, HtmlUtil:color(self.mShopData:getRemaindTime(), "ffb136ff"), self.mShopData:getRefreshLimit())
        self.mGroupRefresh:SetActive(true)
    else
        self.mGroupRefresh:SetActive(false)
    end
    -- 刷新时间
    if self.mShopData:getRefreshTime() > 0 then
        self.mTxtTime.gameObject:SetActive(true)
        self:addTimer(1, 0, self.timeStep)
        self:timeStep()
    else
        self.mTxtTime.gameObject:SetActive(false)
        self:removeTimerByIndex()
    end
end

-- 更新商店列表
function updateShopList(self)
    self.mShoplist = shop.ShopManager:getShopItemList(self:getShopType())
    self:addShopItem()
end

-- 添加商品item
function addShopItem(self)
    local Scroller = self:getShopType() == ShopType.BLACK and self.mLimitScroller or self.mLyScroller
    if self:getShopType() == ShopType.FRAGMENTS or self:getShopType() == ShopType.OUTPUT or self:getShopType() == ShopType.ASSIST then
        table.sort(self.mShoplist, function(vo1, vo2)
            if vo1:isSoldout() == (vo2:isSoldout()) then
                return vo1.lock < vo2.lock
            else
                if (not vo1:isSoldout()) then
                    return true
                else
                    return false
                end
            end
        end)
    end
    self:onCalculate(self.mShoplist)
    if Scroller.Count <= 0 then
        Scroller.DataProvider = self.mShoplist
    else
        Scroller:ReplaceAllDataProvider(self.mShoplist)
    end
    local listitem = Scroller:GetItemListCount()
end
-- 玩家等级变化
function onUpdatePlayerInfoHandler(self)
    self:onDataUpdateHandler()
end

-- 交错效果动效计算
function onCalculate(self, shoplist)
    local colNum = 4
    if self:getShopType() == ShopType.BLACK then
        colNum = 2
    end
    local rowLength = math.ceil(#shoplist / colNum)
    rowLength = rowLength > 6 and 6 or rowLength
    local frameList = {}
    local curFrameIndex = 1
    for k = 1, #shoplist do
        local frame = k --隔帧处理(2 * k) - 1
        table.insert(frameList, frame)
    end
    for col = 1, colNum do
        for row = 0, rowLength do
            local searchIndex = (colNum * row) + col
            if shoplist[searchIndex] then
                if curFrameIndex > #shoplist then
                    curFrameIndex = #shoplist
                end
                shoplist[searchIndex].tweemFrame = frameList[curFrameIndex]
                curFrameIndex = curFrameIndex + 1
            else
                break
            end
        end
    end
end
-- 商品售完移动到最后
function onShopListSort(self)
    table.sort(self.mShoplist, function(vo1, vo2)
        return false
    end)
    --local tempList = {}
    --for i, shopVo in ipairs(self.mShoplist) do
    --    if (shopVo:isSoldout() ~= false) then
    --        table.insert(tempList, self.mShoplist[i])
    --    end
    --end
    --for _, tempShopVo in ipairs(tempList) do
    --    table.remove(self.mShoplist, table.indexof01(self.mShoplist, tempShopVo))
    --    table.insert(self.mShoplist, tempShopVo)
    --end
end

-- 商品数据更新
function onDataUpdateHandler(self)
    self:updateShopList()
end

-- 时间步进器
function timeStep(self)
    local refreshTime = 0
    if not self.mShopData then
        return
    end
    refreshTime = self.mShopData:getRefreshTime()
    local clientTime = GameManager:getClientTime()
    local time = refreshTime - clientTime
    if time < 0 then
        return
    end
    -- 刷新倒计时：
    self.mTxtTime.text = HtmlUtil:color(TimeUtil.getHMSByTime(time), "ffb136ff")
end

-- 刷新操作
function onRefreshHandler(self)
    if not self.mShopData then
        return
    end
    local result, tips = MoneyUtil.judgeNeedMoneyCountByType(self.mShopData:getPayType(), self.mShopData:getCostNum(), true, true)
    if (tips ~= "") then
        MoneyUtil.judgeNeedMoneyCountByTidTips(self.mShopData:getPayType(), self.mShopData:getCostNum(), nil, nil, nil)
        return
    end
    if self.mShopData:getCanRefresh() then
        -- if remind.RemindManager:isTodayNotRemain(RemindConst.SHOP_BLACK_REFRESH) then
        --     GameDispatcher:dispatchEvent(EventName.REQ_SHOP_REFRESH, self:getShopType())
        -- else
        -- 刷新二级弹窗确认
        UIFactory:alertMessge(_TT(25028, self.mShopData:getCostNum()), true, function()
            GameDispatcher:dispatchEvent(EventName.REQ_SHOP_REFRESH, self:getShopType())
        end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, RemindConst.SHOP_BLACK_REFRESH)
        -- end
    else
        --没有刷新次数
        gs.Message.Show(_TT(25003))
    end
end

-- 移除
function destroy(self, isAuto)
    super.destroy(self, isAuto)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]