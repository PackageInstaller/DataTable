module("braceletBuild.BraceletBuildPanel", Class.impl(TabView))

UIRes = UrlManager:getUIPrefabPath("braceletBuild/BraceletBuildPanel.prefab")
destroyTime = -1 -- 自动销毁时间-1默认
isShowBlackBg = 0
-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setTxtTitle(_TT(1335))
    self:setBg("", false)
    --self:setBg("mozu_bg_01.jpg", false, "hero5")
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.showTabType = 2
    self.m_curTabType = nil
end

function configUI(self)
    super.configUI(self)
    self.m_tabViewTrans = self:getChildTrans("GroupTabView")
end

-- 设置文本标题
function setTxtTitle(self, title)
    super.setTxtTitle(self, title)
    self:setGuideTrans("funcTips_guide_View_CloseAlll", self.gBtnCloseAll.transform)
end

function getTabViewParent(self)
    return self.m_tabViewTrans
end

function active(self, args)
    super.active(self, args)

    --MoneyManager:setMoneyTidList({ MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID }, 1)
    self.m_curHeroId = hero.HeroManager:getPanelShowHeroId()

    UISceneBgUtil:create3DBg("arts/sceneModule/ui_mozu_01/prefabs/ui_laohen_01.prefab")

end

function deActive(self)
    super.deActive(self)

    UISceneBgUtil:reset()
end

function isHorizon(self)
    return false
end

-- 页签父节点
function getTabBarParent(self)
    return self:getChildTrans("TabBarNode")
end

function getTabDatas(self)
    local funcOpenList = {}
    table.insert(funcOpenList, funcopen.FuncOpenConst.FUNC_ID_HERO_BRACELETS_STRENGTHEN)
    table.insert(funcOpenList, funcopen.FuncOpenConst.FUNC_ID_HERO_BRACELETS_REFINE)
    table.insert(funcOpenList, funcopen.FuncOpenConst.FUNC_ID_HERO_BRACELETS_EMPOWER)

    self.tabDataList = {}
    table.insert(self.tabDataList, braceletBuild.BuildTabType.STRENGTHEN)
    table.insert(self.tabDataList, braceletBuild.BuildTabType.REFINE)
    table.insert(self.tabDataList, braceletBuild.BuildTabType.EMPOWER)

    for i = 1, #self.tabDataList do
        local tabType = self.tabDataList[i]
        if funcopen.FuncOpenManager:isOpen(funcOpenList[i]) then
            self.tabDataList[i] = {type = tabType, content = {braceletBuild.getBuildName(tabType)}, nomalIcon = braceletBuild.getBuildIcon(tabType), selectIcon = braceletBuild.getBuildIcon(tabType)}
        else
            self.tabDataList[i] = nil
        end
    end
    return self.tabDataList
end

function getTabClass(self)
    self.tabClassDic[braceletBuild.BuildTabType.STRENGTHEN] = braceletBuild.BraceletStrengthenTab
    self.tabClassDic[braceletBuild.BuildTabType.REFINE] = braceletBuild.BraceletRefineTab
    self.tabClassDic[braceletBuild.BuildTabType.EMPOWER] = braceletBuild.BraceletEmpowerTab
    return self.tabClassDic
end

return _M
