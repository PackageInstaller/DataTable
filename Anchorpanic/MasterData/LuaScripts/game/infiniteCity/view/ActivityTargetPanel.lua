--[[ 
-----------------------------------------------------
@filename       : ActivityTargetPanel
@Description    : 各类限时玩法活动目标总览
@date           : 2021-03-09 17:59:19
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.infiniteCity.view.ActivityTargetPanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("infiniteCity/ActivityTargetPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setBg("infiniteCity_bg_2.jpg", false, "infiniteCity")
end
--析构  
function dtor(self)
end

function initData(self)
    super.initData(self)
    self.tabClassDic = {}
    self.m_classInsDic = {}
end

-- 初始化
function configUI(self)
    -- self.aa = self:getChildGO(""):GetComponent(ty.Image)
    self.mGroupTab = self:getChildTrans("mGroupTab")
    self.mTabBarNode = self:getChildTrans("mTabBarNode")

end

--激活
function active(self, args)
    super.active(self, args)
    infiniteCity.InfiniteCityManager:addEventListener(infiniteCity.InfiniteCityManager.EVENT_TARGET_DATA_UPDATE, self.updateInfiniteCityRedFlag, self)

    self:updateTab()
    self:updateInfiniteCityRedFlag()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    infiniteCity.InfiniteCityManager:removeEventListener(infiniteCity.InfiniteCityManager.EVENT_TARGET_DATA_UPDATE, self.updateInfiniteCityRedFlag, self)

    self:subDeActive()
    self.tabBar:reset()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    -- self:addUIEvent(self.aa,self.onClick)
end

function updateTab(self)
    local list = {}
    if infiniteCity.InfiniteCityManager:isOpen() then
        -- list[1] = { page = 1, nomalLan = "无限城", nomalLanEn = "INFINITE CITY" }
        list[1] = { page = 1, nomalLan = _TT(27109), nomalLanEn = _TT(27110) }
    end
    self.tabBar = CustomTabBar:create(self:getChildGO("GroupTabItem"), self.mTabBarNode, self.setPage, self)
    self.tabBar:setData(list)
    self.tabBar:setPage(1)
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

    instance:setUICache(true)
    instance:__active()
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
    return self:getChildTrans("mGroupContent")
end

function getTabClass(self)
    self.tabClassDic[1] = infiniteCity.InfiniteCityTargetView
    return self.tabClassDic
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

-- 无限城目标红点
function updateInfiniteCityRedFlag(self)
    local isFlag = infiniteCity.InfiniteCityManager:getRedFlag()
    if isFlag then
        self:addBubble(1)
    else
        self:removeBubble(1)
    end
end

function addBubble(self, tabType)
    self.tabBar:addBubble(tabType, 100, 26)
end

function removeBubble(self, tabType)
    self.tabBar:removeBubble(tabType)
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
