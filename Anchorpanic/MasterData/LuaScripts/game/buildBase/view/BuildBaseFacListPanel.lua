module("buildBase.BuildBaseFacListPanel", Class.impl(View))
-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("buildBase/BuildBaseFacListPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isScreensave = 0
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setTxtTitle(_TT(72108))
    -- self:setUICode(LinkCode.Covenant)
    self:setBg("", false)
end

function dtor(self)

end

function initData(self)
    self.mSortType = buildBase.BuildBaseManager:getOrderType()
    self.mTabList = {}
    self.mMoneyItemList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mFacProduceItem = self:getChildGO("mFacProduceItem")
    self.TextEmptyTip = self:getChildTrans("TextEmptyTip")
    self.mBtnFuncTips = self:getChildGO("mBtnFuncTips")
    self.Scroll = self:getChildGO("Scroll"):GetComponent(ty.LyScroller)
    self.Scroll:SetItemRender(buildBase.BuildBaseFacProduceItem)
    self.NodeFilter = self:getChildGO("NodeFilter")
    self.TabBarNode = self:getChildTrans("TabBarNode")
    self.mBuildBaseFacTabItem = self:getChildGO("mBuildBaseFacTabItem")
    self.mMb = self:getChildTrans("mMoneyBar")
    self:setGuideTrans("funcTips_guide_factory_3", self:getChildTrans("TabBarNode"))
    self:setGuideTrans("funcTips_guide_factory_4", self:getChildTrans("mGuideNode"))
end

-- 激活
function active(self, args)
    super.active(self, args)
    self:initMoneyItem()
    self:updateView()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    if self.Scroll then
        self.Scroll:CleanAllItem()
    end
    self:recoverTabItem()
    self:recoverMoneyItem()
end

--MoneyBar
function initMoneyItem(self)
    local list = { MoneyTid.UAV_TID, MoneyTid.POWER_TID, MoneyTid.TITANITE_TID }
    self.base_childGos["MoneyBar"]:SetActive(false)
    for i = 1, #list do
        local item = MoneyItem:poolGet()
        item:setData(self.mMb, { tid = list[i], frontType = self.frontType })
        item:getChildGO("mBtnGet"):SetActive(false)
        item:getChildGO("mBtnArea"):GetComponent(ty.Button).enabled = false
        table.insert(self.mMoneyItemList, item)
    end
end

--回收MoneyBar
function recoverMoneyItem(self)
    if #self.mMoneyItemList > 0 then
        for _, item in pairs(self.mMoneyItemList) do
            item:poolRecover()
        end
        self.mMoneyItemList = {}
    end
end

function updateView(self)
    self:updateLeft()
    self:updateRight()
end

function updateLeft(self)
    self:recoverTabItem()
    local typeConfigVo = buildBase.BuildBaseManager:getFacConfigData()
    local selfLv = buildBase.BuildBaseManager:getShipLv(buildBase.BuildBaseManager:getNowBuildId())
    for k, v in pairs(typeConfigVo) do
        local tabItem = SimpleInsItem:create(self.mBuildBaseFacTabItem, self.TabBarNode, "BuildBaseFacListPaneltabType")
        local select = tabItem:getChildGO("mImgSelect")
        local icon = tabItem:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
        local title = tabItem:getChildGO("mTxtTitle"):GetComponent(ty.Text)
        local lock = tabItem:getChildGO("mLockBg")
        local lockTxt = tabItem:getChildGO("mTxtLock"):GetComponent(ty.Text)
        select:SetActive(v.type == self.mSortType)
        icon:SetImg(UrlManager:getIconPath(v.icon), false)
        title.text = _TT(v.name)
        title.color = gs.ColorUtil.GetColor(v.type == self.mSortType and "000000ff" or "ffffffff")
        lock:SetActive(selfLv < v.needLevel)
        if selfLv < v.needLevel then
            lockTxt.text = _TT(76183, v.needLevel)
        end
        tabItem:addUIEvent(nil, function()
            if self.mSortType ~= v.type and selfLv >= v.needLevel then
                self.mSortType = v.type
                buildBase.BuildBaseManager:setOrderType(self.mSortType)
                self:updateTab()
                self:updateRight()
                self.Scroll:JumpToTop()
            end
        end)
        table.insert(self.mTabList, { item = tabItem, data = v })
    end
end

function updateRight(self)
    local typeConfigVo = buildBase.BuildBaseManager:getFacItemsConfigData(self.mSortType)
    local selfLv = buildBase.BuildBaseManager:getShipLv(buildBase.BuildBaseManager:getNowBuildId())
    local dataList = typeConfigVo.items
    table.sort(dataList, function(a, b)
        local unlockA = selfLv >= a.needLevel
        local unlockB = selfLv >= b.needLevel
        if unlockA == not unlockB then
            if a.needLevel == b.needLevel then
                return a.id < b.id
            end
            return a.needLevel < b.needLevel
        end
        return a.id < b.id
    end)
    if self.Scroll.Count <= 0 then
        self.Scroll.DataProvider = dataList
    else
        self.Scroll:ReplaceAllDataProvider(dataList)
    end
end

function updateTab(self)
    for k, v in pairs(self.mTabList) do
        local select = v.item:getChildGO("mImgSelect")
        local title = v.item:getChildGO("mTxtTitle"):GetComponent(ty.Text)
        select:SetActive(v.data.type == self.mSortType)
        title.color = gs.ColorUtil.GetColor(v.data.type == self.mSortType and "000000ff" or "ffffffff")
    end
end

function recoverTabItem(self)
    for k, v in pairs(self.mTabList) do
        v.item:poolRecover()
    end
    self.mTabList = {}
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnFuncTips, self.onClickFuncTipsHandler)
end

function onClickFuncTipsHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FUNCTIPS_VIEW, { id = LinkCode.BuildBaseFactor2 })
end

-- 关闭所有UI
function onCloseAllCall(self)
    super.onCloseAllCall(self)
    self:playerClose(false)
end

-- 玩家点击关闭
function onClickClose(self)
    super.onClickClose(self)
    self:playerClose(true)
end

function playerClose(self)

end

function closeAll(self)
    super.closeAll(self)

    GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.MAIN_CITY)
end


return _M