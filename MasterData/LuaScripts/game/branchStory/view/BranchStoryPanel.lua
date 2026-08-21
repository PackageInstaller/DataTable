module("branchStory.BranchStoryPanel", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("branchStory/BranchStoryPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗


--构造函数
function ctor(self)
    super.ctor(self)
    self:setUICode(LinkCode.BranchStory)
end

-- 初始化数据
function initData(self)
    super.initData(self)

    self.mTabDic = {}
    self.tabClassDic = {}
    self.m_classInsDic = {}
end

function configUI(self)
    super.configUI(self)
end

function initTabBar(self)
end

function updateTab(self)
    local list = branchStory.BranchStoryConst:getTabList()
    self.tabBar = CustomTabBar:create(self:getChildGO("GroupTabItem"),self:getChildTrans("TabBarNode"),self.setPage, self)
    self.tabBar:setData(list)

    for type, item in pairs(self.tabBar.btnMap) do
        self:setGuideTrans("guide_BtnStoryPanel_"..type, item:getChildTrans("mBtnNomal"))
        if not branchStory.BranchStoryManager:getBranchStoryReshow() then 
            item:getGo():GetComponent(ty.UIDoTween):BeginTween()
        end
    end
end

function updateTabRed(self, index)
    if index == nil then
        for id, _ in pairs(self.tabBar.btnMap) do
            if id == branchStory.BranchStoryConst.EQUIP then 
                self:updateBubbleView(id)
            end
        end
    else
        if self.tabBar.btnMap[index] == nil then
            return
        end
        self:updateBubbleView(index)
    end
end

function updateBubbleView(self, index)
    local isBubble = branchStory.BranchStoryManager:isBubble()
    if (isBubble) then
        self.tabBar:addBubble(index, -81.5, 19)
    else
        self.tabBar:removeBubble(index)
    end
end


function active(self, args)
    super.active(self, args)
    branchStory.BranchStoryManager:setBranchStoryReshow(self.isReshow)
    self:updateTab()
    if args and args.type~=nil then 
        self.tabBar:setPage(args.type)
    else
        local lastIndex = branchStory.BranchStoryManager:getLastIndex()
        self.tabBar:setPage(lastIndex)
    end
    self:updateTabRed(nil)
    MoneyManager:setMoneyTidList({})
    GameDispatcher:addEventListener(EventName.CHANGE_STORY_PANEL,self.onChangePage,self)

    bag.BagManager:addEventListener(bag.BagManager.BAG_UPDATE, self.__onUpdatePanelHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_BRANCH_STORY_PANEL, self.__onUpdatePanelHandler, self)    
end

function onChangePage(self,index)
    self.tabBar:setPage(index)
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.CHANGE_STORY_PANEL,self.onChangePage,self)
    MoneyManager:setMoneyTidList({MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID})
    bag.BagManager:removeEventListener(bag.BagManager.BAG_UPDATE, self.__onUpdatePanelHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_BRANCH_STORY_PANEL, self.__onUpdatePanelHandler, self)

    local classDic = self.m_classInsDic
    for page, classObj in pairs(classDic) do
        classObj:__deActive()
    end
    if self.tabBar then
        self.tabBar:removeAllBubble()
        self.tabBar:reset()
        self.tabBar = nil
    end
end

-- 页签父节点
-- function getTabBarParent(self)
--     return self:getChildTrans("TabBarNode")
-- end

function getTabClass(self)
    self.tabClassDic[branchStory.BranchStoryConst.EQUIP] = branchStory.BranchEquipTabView
    self.tabClassDic[branchStory.BranchStoryConst.MAIN] = branchStory.BranchMainTabView
    self.tabClassDic[branchStory.BranchStoryConst.TACTIVS] = branchStory.BranchTactivsTabView
    self.tabClassDic[branchStory.BranchStoryConst.POWER] = branchStory.BranchPowerTabView
    return self.tabClassDic
end

function setPage(self, cusPage)
    if (self.curPage == cusPage) then
        self:subActive()
        return
    end
    self.curPage = cusPage

    local instance = self:getClassInsByType(cusPage)
    for type, classIns in pairs(self.m_classInsDic) do
        if (type ~= cusPage) then
            if (not classIns:getIsCache()) then
                classIns:setUICache(false)
                classIns:__deActive()
            end
        end
    end

    branchStory.BranchStoryManager:setBranchStoryReshow(nil)
    instance:setUICache(true)
    instance:__active()
    -- self:updateBg(cusPage)
end

function getClassInsByType(self, cusPage)
    local instance = self.m_classInsDic[cusPage]
    if (not instance) then
        local tabClass = self:getTabClass()[cusPage]
        if type(tabClass) == "table" then
            instance = tabClass.new()
        else
            instance = UI.new(tabClass)
        end

        if instance.subName ~= "TabSubView" then
            logWarn('TabView', instance._NAME .. ' 请尽量继承TabSubView ')
        end

        instance:setParentTrans(self:getTabViewParent())

        self.m_classInsDic[cusPage] = instance
    end
    return instance
end

-- 父节点
function getTabViewParent(self)
    return self:getChildTrans("Content")
end


-- 子页面激活
function subActive(self)
    if (self.curPage ~= nil) then
        local classIns = self.m_classInsDic[self.curPage]
        classIns:setUICache(true)
        classIns:__active()    
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
return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
