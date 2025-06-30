--[[ 
-----------------------------------------------------
@filename       : RankMainPanel
@Description    : 排行榜总页面
@date           : 2021-08-16 14:35:15
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.rank.view.RankMainPanel', Class.impl(TabView))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("rank/RankMainPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isShow3DBg = 1

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1500, 800)
    self.tabBar:reset()
    self:setOffset(0, 0, 0, 0)
    self:setTxtTitle("排行榜")
    self:setBg("", false)
    self:setUICode(LinkCode.RANK_MAIN)
end
--析构  
function dtor(self)
end

function initData(self)
    self.showTabType = 2
    super.initData(self)
    self.tabData = {}
    self.mGroupTabHeight = 0
end

-- 初始化
function configUI(self)
    self.mGroup = self:getChildTrans("mGroup")
    self.mGroupTab = self:getChildTrans("mGroupTab")
    self.mViewportRect = self:getChildTrans("Viewport"):GetComponent(ty.RectTransform)
    self.mGroupTabRect = self:getChildGO("mGroupTab"):GetComponent(ty.RectTransform)
    self.mScrollRect = self:getChildGO("Scroll View"):GetComponent(ty.ScrollRect)
end

--激活
function active(self, args)
    self.subType = args.subType
    self.mScrollRect.enabled = true
    super.active(self, args)
    self:onUpdateContent()
end

function onUpdateContent(self)
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mGroupTab)
    if self.mGroupTabRect.sizeDelta.y <= self.mGroupTabHeight then
        gs.TransQuick:LPosY(self.mGroupTab, 0)
    end
    if self.mGroupTabHeight <= 0 then
        self.mGroupTabHeight = self.mGroupTabRect.sizeDelta.y
    end
    self:onMoveLocation(self.curPage)
end

function onMoveLocation(self, cusTabBar)
    local btnPosY = math.abs(self.tabData[cusTabBar].UITrans.anchoredPosition.y - self.tabData[cusTabBar].UITrans.sizeDelta.y)
    local spacing = self.mViewportRect.rect.height - btnPosY
    if spacing < 0 then
        gs.TransQuick:LPosY(self.mGroupTab, math.abs(spacing))
    end
end

function autoSetype(self, args)
    local page
    if args and type(args) == "number" then
        page = args
    else
        page = (args and args.type) and args.type or self:getTabDatas()[1].type
    end
    self:setTabbar()
    if (self.curPage == nil) then
        self:setType(page, args)
    else
        self:setType(self.curPage, args)
    end
end

function getActiveArgs(self)
    return { type = self:getPage() }
end

function updateTabBar(self)
    if self.tabBar then
        self.tabBar:reset()
        self.tabBar:setItems(self:getTabDatas(), 1)
    end
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:clearTabItem()
    self.curPage = nil
end


-- 设置货币栏
function setMoneyBar(self)
end
function getTabDatas(self)
    return self.tabDataList
end

function getTabClass(self)
    local list = rank.RankManager:getRankShowList()
    for i, vo in ipairs(list) do
        self.tabClassDic[vo.id] = rank.RankBaseView
    end
    return self.tabClassDic
end

function getTabViewParent(self)
    return self.mGroup
end

function getTabBarParent(self)
    return self.mGroupTab
end

function setTabbar(self)
    self:clearTabItem()
    local list = rank.RankManager:getRankShowList()
    for i, vo in pairs(list) do
        if funcopen.FuncOpenManager:isOpen(vo.funIds[1]) then
            local tabItem = UI.new(rank.RankTabItem)
            tabItem:setParentTrans(self.mGroupTab)
            tabItem:setData(vo, i, self.setTabIndex, self, self.subType, i)
            self.tabData[i] = tabItem
        end
    end
end

function clearTabItem(self)
    for k, item in pairs(self.tabData) do
        item:deActive()
        item:destroy()
        item = nil
    end
    self.tabData = {}
end

function setType(self, cusTabType, cusArgs)
    if (self.curPage == cusTabType) then
        return
    end
    super.setType(self, cusTabType, cusArgs)
    self:setTabIndex(cusTabType)
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mGroupTab)
end

-- 设置tab
function setTabIndex(self, index)
    for i, item in pairs(self.tabData) do
        item:setSelect(false)
    end
    local tabItem = self.tabData[index]
    tabItem:setSelect(true)
    self:setType(index)
end

function onCloseAllCall(self)
    super.onCloseAllCall(self)
    self:playerClose()
end

function onClickClose(self)
    super.onClickClose(self)
    self:playerClose()
end

function playerClose(self)
    -- GameDispatcher:dispatchEvent(EventName.CUSTOM_CONVENANT_SCENE_CHANGE)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
