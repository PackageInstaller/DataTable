--[[ 
-----------------------------------------------------
@filename       : DupDailyMainPanel
@Description    : 日常副本总入口
@date           : 2021-01-27 16:22:54
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("dup.DupDailyMainPanel", Class.impl(TabSubView))
UIRes = UrlManager:getUIPrefabPath("dupDaily/DupDailyPanel.prefab")
panelType = 1

--构造函数
function ctor(self)
    super.ctor(self)
    self:setUICode(LinkCode.DupDaily)
end

function initData(self)
    super.initData(self)
    self.mTabDic = {}
    self.tabClassDic = {}
    self.m_classInsDic = {}
end

function configUI(self)
    super.configUI(self)
end

function updateTab(self)
    local list = {}
    local noOpenList = {}
    for i, vo in ipairs(dup.DupDailyConst:getTabList()) do
        if funcopen.FuncOpenManager:isOpen(vo.funcId, false) == true then
            table.insert(list, vo)
        elseif funcopen.FuncOpenManager:isOpen(vo.funcId, false) == false then
            table.insert(noOpenList, vo)
        end
    end
    for _, vo1 in ipairs(noOpenList) do
        table.insert(list, vo1)
    end
    self.tabBar = CustomTabBar:create(self:getChildGO("mGroupTabItem"), self:getChildTrans("mTabBarNode"), self.setPage, self)
    self.tabBar:setData(list)
    for i, vo3 in ipairs(list) do
        if funcopen.FuncOpenManager:isOpen(vo3.funcId) == false then
            self.tabBar:setItemLock(vo3.page, true)
        else
            self.tabBar:setItemLock(vo3.page, false)
        end
    end
    for type, item in pairs(self.tabBar.btnMap) do
        self:setGuideTrans("guide_DupDailyPanel_" .. type, item:getChildTrans("mBtnNomal"))
    end
end

function active(self, args)
    super.active(self)
    self:updateTab()

    if args and args.dupType ~= nil then
        self.tabBar:setPage(args.dupType)
    else
        local lastIndex = dup.DupDailyBaseManager:getLastIndex()
        self.tabBar:setPage(lastIndex)
    end
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID })
end


function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID })
    local classDic = self.m_classInsDic
    for page, classObj in pairs(classDic) do
        classObj:__deActive()
    end
    if self.tabBar then
        self.tabBar:reset()
        self.tabBar = nil
    end
end

function isHorizon(self)
    return false
end

function getTabClass(self)
    self.tabClassDic[dup.DupDailyConst.DUPEXP] = dup.DupExpPanel
    self.tabClassDic[dup.DupDailyConst.DUPMONEY] = dup.DupMoneyPanel
    self.tabClassDic[dup.DupDailyConst.DUPHEROSTARUP] = dup.DupHeroStarUpPanel
    self.tabClassDic[dup.DupDailyConst.DUPEQUIPTUPO] = dup.DupEquipTupoPanel
    self.tabClassDic[dup.DupDailyConst.DUPHEROGROWUP] = dup.DupHeroGrowUpPanel
    self.tabClassDic[dup.DupDailyConst.DUPBRACELETS] = dup.DupBraceletsPanel
    self.tabClassDic[dup.DupDailyConst.DUPHEROSKILL] = dup.DupHeroSkillUpPanel
    return self.tabClassDic
end

function setPage(self, cusPage)
    if (self.curPage == cusPage) then
        self:subActive()
        return
    end
    if cusPage == nil then
        cusPage = dup.DupDailyBaseManager:getLastIndex()
    end
    self.curPage = cusPage
    dup.DupDailyBaseManager:setLastIndex(self.curPage)
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
    self:updateBg(cusPage)

end

function updateBg(self, cusTabType)
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
    return self:getChildTrans("mGroupChip")
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

function close(self)
    super.close(self)
end

function destroyPanel(self)
    super.destroyPanel(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
