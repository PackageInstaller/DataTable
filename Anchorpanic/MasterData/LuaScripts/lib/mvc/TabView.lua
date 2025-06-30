module('TabView', Class.impl(View))

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    self.m_classInsDic = {}
    self.curPage = nil
    self.tabBar = nil
    self.tabDataList = {}
    self.tabClassDic = {}
    self.args = {}
    self.showTabType = 1
end

--析构函数
function dtor(self)
    super.dtor(self)
end

--初始化UI
function configUI(self)
    super.configUI(self)
end

-- 设置窗口公共底板
function drawPanel(self)
    super.drawPanel(self)
    self:initTabBar()
end

function setTabBar(self)
    if #self:getTabDataList() <= 0 then
        return
    end

    if not self.tabViewGo then
        self.tabViewGo = AssetLoader.GetGO(UrlManager:getUIPrefabPath("compent/TabView.prefab"), self)
        self.tabView_childGos, self.tabView_childTrans = GoUtil.GetChildHash(self.tabViewGo)
        self.tabViewGo.transform:SetParent(self.base_childTrans["mGroupCusTab"], false)
    end

    self.tabBar = CustomTabBar:create(self.tabView_childGos["GroupTabItem"], self.tabView_childTrans["TabBarNode"], self.onClickMenuHandler, self, nil, "TabViewTabBar")
    self.tabBar:setData(self:getTabDataList())
end

-- 设置公共页签到指定挂点
function setTabBar2Parent(self, parent)
    if self.tabViewGo then
        self.tabViewGo.transform:SetParent(parent, false)
    end
end

function initTabBar(self)
    if self.showTabType == 2 then
        self:setTabBar()
        return
    end

    -- 菜单切卡
    self.tabBar = TabBar:poolGet()
    self.tabBar:addParent(self:getTabBarParent())
    self.tabBar:setData(112, -200, 300, 60, self:isHorizon(), 0)
    self.tabBar:setClickCallBack(self, self.onClickMenuHandler)

    -- 通用界面样式
    self:setAnchors(0.5, 0, 0.5, 1)
    self:setOffset(0, 0, 0, 124)
    self:setScrollerSize(178)
    self:setTabBtnPos(73)
    self:setTabGap(10)
end

function getTabViewParent(self)
    local parent
    if (self.UITrans) then
        parent = self.UITrans
    else
        parent = self.UIBaseTrans
    end
    return parent
end

function getTabBarParent(self)
    return self:getTabViewParent()
end

-- 更新页签列表
function updateTabBar(self)
    if self.tabBar and self.showTabType == 1 then
        self.tabBar:reset()
        self.tabBar:setItems(self:getTabDatas(), 2)
    end
end

-- 内部激活，请勿使用
function __active(self, args)
    self:updateTabBar()
    super.__active(self, args)
end

--激活
function active(self, args)
    super.active(self, args)
    self.activeArgs = args

    if self.tabBar and self.showTabType == 2 then
        self.tabBar:showTabTween()
    end

    self:autoSetype(args)
end

function autoSetype(self, args)
    local page
    if args and type(args) == "number" then
        page = args
    else
        page = (args and args.type) and args.type or self:getTabDatas()[1].type
    end
    if (table.nums(self:getTabDatas()) > 0) then
        if (self.curPage == nil) then
            self:setType(page, args, false)
        else
            self:setType(self.curPage, args)
        end
    end
end

--非激活
function deActive(self)
    super.deActive(self)
    self:subDeActive()
end

-- 新
function getTabDataList(self)
    local list = {}
    for k, v in pairs(self:getTabDatas()) do
        local data = { page = v.type, nomalLan = v.content[1], nomalLanEn = '', nomalIcon = v.nomalIcon, selectIcon = v.selectIcon }
        table.insert(list, data)
    end
    return list
end

function getTabDatas(self)
    return {}
end

function getTabClass(self)
    return {}
end

function isHorizon(self)
    return true
end

function setScrollerSize(self, cusWidth, cusHeight)
    self.tabBar:setSize(cusWidth, cusHeight)
end

function setTabBtnPos(self, cusPosX, cusPosY)
    self.tabBar:setPosition(cusPosX, cusPosY)
end

function setTabGap(self, gap, top, right, bottom, left)
    self.tabBar:setLayout(self:isHorizon(), gap, top, right, bottom, left)
end

-- 设置自适应方式
function setAnchors(self, minX, minY, maxX, maxY)
    self.tabBar:setAnchors(minX, minY, maxX, maxY)
end
-- 设置边距
function setOffset(self, minX, minY, maxX, maxY)
    self.tabBar:setOffset(minX, minY, maxX, maxY)
end

-- 设置是否可以重复点击触发
function setIsRepeatTrigger(self, isRepeat)
    self.tabBar:setIsRepeatTrigger(isRepeat)
end

-- 点击菜单
function onClickMenuHandler(self, cusTabType)
    self:setType(cusTabType)
end

function setType(self, cusTabType, cusArgs, cusIsDispatch)
    self.tabBar:setType(cusTabType, cusIsDispatch)
    if (self.curPage == cusTabType) then
        -- 如果是重复触发，则先deActive
        if (self.tabBar:getIsRepeatTrigger()) then
            self:subDeActive()
        end
        self:subActive()
        return
    end

    self:setPage(cusTabType)
    local instance = self:getClassInsByType(cusTabType)
    for type, classIns in pairs(self.m_classInsDic) do
        if (type ~= cusTabType) then
            if (not classIns:getIsCache()) then
                classIns:setUICache(false)
                classIns:__deActive()
            end
        end
    end
    if cusArgs then
        self.args[self.curPage] = table.copy(cusArgs)
    elseif not self.args[self.curPage] then
        self.args[self.curPage] = self:getActiveArgs()
    end
    -- if (not instance:getActive()) then
    instance:setUICache(true)
    instance:__active(self.args[self.curPage], self.isReshow)
    self.isReshow = false
    -- end
end

function getPage(self)
    return self.curPage
end

function setPage(self, cusType)
    self.curPage = cusType
    if self.activeArgs and self.activeArgs.type then
        self.activeArgs.type = cusType
    end
    self:setActiveArgs(self.activeArgs)
end

-- 可Override后提供需要active传入子页面的参数
function getActiveArgs(self)
    return { type = self:getPage() }
end

function getClassInsByType(self, cusTabType)
    local instance = self.m_classInsDic[cusTabType]
    if (not instance) then
        local tabClass = self:getTabClass()[cusTabType]
        if type(tabClass) == "table" then
            instance = tabClass.new()
        else
            instance = UI.new(tabClass)
        end

        if instance.subName ~= "TabSubView" then
            logWarn('TabView', instance._NAME .. ' 请尽量继承TabSubView ')
        end

        instance:setParentTrans(self:getTabViewParent())

        self.m_classInsDic[cusTabType] = instance
    end
    return instance
end

--打开窗口
function open(self, args, isReshow)
    super.open(self, args, isReshow)
end

-- 关闭窗口
function close(self)
    super.close(self)
end

-- 玩家点击关闭
function onClickClose(self)
    if (self:__getIsCanCloseSubView(self.curPage)) then
        if (self.curPage ~= nil) then
            local classIns = self.m_classInsDic[self.curPage]
            if (classIns.onClickClose) then
                classIns:onClickClose()
            end
        end
        self:reset()
        super.onClickClose(self)
    end
end

-- 玩家关闭所有窗口的c#回调
function onCloseAllCall(self)
    if (self.curPage ~= nil) then
        local classIns = self.m_classInsDic[self.curPage]
        if (classIns.onCloseAllCall) then
            classIns:onCloseAllCall()
        end
    end
    self:reset()
    super.onCloseAllCall(self)
end

function __getIsCanCloseSubView(self, type)
    local instance = self.m_classInsDic[type]
    if (instance and instance.__isCanSubViewClose__) then
        return instance:__isCanSubViewClose__()
    end
    return true
end

-- 子页面激活
function subActive(self)
    if (self.curPage ~= nil) then
        local classIns = self.m_classInsDic[self.curPage]
        classIns:setUICache(true)
        classIns:__active(self.args[self.curPage], self.isReshow)
        self.isReshow = false
    end
end

-- 子页面非激活
function subDeActive(self)
    if (self.curPage ~= nil) then
        local classIns = self.m_classInsDic[self.curPage]
        classIns:setUICache(false)
        classIns:__deActive()
    end
end

function addBubble(self, tabType, x, y)
    if self.showTabType == 2 then
        self.tabBar:addBubble(tabType, x or 61, y or 24)
    else
        self.tabBar:addBubble(tabType, x or 61, y or 24)
    end
end

function addBubbleWithImg(self, tabType, imgPath, x, y)
    self.tabBar:addBubbleWithImg(tabType, imgPath, x or 95, y or 20)
end

function removeBubble(self, tabType)
    self.tabBar:removeBubble(tabType)
end

function reset(self)
    if (self.tabBar) then
        self.tabBar:removeAllBubble()
    end
    self:subDeActive()
    self.curPage = nil
end

-- 销毁
function destroyPanel(self)
    self:reset()
    for type, classIns in pairs(self.m_classInsDic) do
        classIns:destroy(false)
    end
    self.m_classInsDic = {}

    super.destroyPanel(self)
end

return _M