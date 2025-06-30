module("hero.HeroDetailsInfoPanel", Class.impl(TabView))

UIRes = UrlManager:getUIPrefabPath("hero/HeroDetailsInfoPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setTxtTitle(_TT(1223))--"档案"
    self:setBg("", false)
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.showTabType = 2
end

function configUI(self)
    super.configUI(self)
    self.mModelPlayer = ModelScenePlayer.new()
end

function getTabBarParent(self)
    return self:getChildTrans("TabBarNode")
end

function getActiveArgs(self)
    return { heroTid = self.activeArgs.heroTid, isNoMass = true }

end

function active(self, args)
    super.active(self, { heroTid = args.heroTid, isNoMass = true })

    self.curHeroVo = hero.HeroManager:getHeroConfigVo(self.activeArgs.heroTid)
    self:updateView()
end

-- 设置货币栏
function setMoneyBar(self)
end

-- UI事件管理
function addAllUIEvent(self)

end

function setType(self, cusTabType, cusArgs, cusIsDispatch)
    if (self.curPage and cusTabType ~= self.curPage) then
        self.args[self.curPage] = nil
    end
    super.setType(self, cusTabType, cusArgs, false)
end

function deActive(self)
    super.deActive(self)
    self:recoverModel(true)
    self.mIsInit = false
end

function close(self)
    super.close(self)
    -- if (bag.BagManager.mOpenHeroDetail) then
    --     GameDispatcher:dispatchEvent(EventName.DEACTIVE_SELECT_HERO_VIEW, true)
    -- end
end

function closeAll(self)
    -- if (bag.BagManager.mOpenHeroDetail) then
    --     GameDispatcher:dispatchEvent(EventName.CLOSE_SELECT_HERO_VIEW)
    -- end
    super.closeAll(self)
end

function getTabDatas(self)
    self.tabDataList = {}
    table.insert(self.tabDataList, { type = favorable.FavorableConst.HERO_DETAIL, content = { favorable.FavorableConst.TAB_LIST2[favorable.FavorableConst.HERO_DETAIL].nomalLan }, nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_15.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_15.png") })
    table.insert(self.tabDataList, { type = hero.DevelopTabType.SKILL, content = { hero.getDevelopName(hero.DevelopTabType.SKILL) }, nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_35.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_35.png") })
    return self.tabDataList
end

function getTabClass(self)
    self.tabClassDic[favorable.FavorableConst.HERO_DETAIL] = hero.HeroDetailsSubPanel
    self.tabClassDic[hero.DevelopTabType.SKILL] = hero.HeroSkillIntroduceTabView
    return self.tabClassDic
end

function updateView(self)
    self:__updateModelView(self.curHeroVo)
end

function updateHeroNode(self)
    if (self.mModelPlayer:getModelTrans()) then
        self.mModelPlayer:getModelTrans().gameObject:SetActive(favorable.FavorableManager.mDetailShow3D)
    end
end

function __updateModelView(self, heroVo)
    if (heroVo) then
        self.mModelPlayer:setModelData(heroVo:getUIModel(), false, true, 1, true, MainCityConst.ROLE_MODE_CULTIVATE, UrlManager:getBgPath("hero5/hero5_bg_4.png"), nil, nil, function()
            self:updateHeroNode()
        end)
    else
        self:recoverModel(false)
    end
end

function recoverModel(self, isResetMaincity)
    self.mModelPlayer:reset(isResetMaincity)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]