module("equipBuild.EquipBuildPanel", Class.impl(TabView))

UIRes = UrlManager:getUIPrefabPath("equipBuild/EquipBuildPanel.prefab")
destroyTime = -1 -- 自动销毁时间-1默认

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setTxtTitle(_TT(53601))
    self:setBg("mozu_bg_01.jpg", false, "hero5")
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
    self.m_btnLast = self:getChildGO("BtnLast")
    self.m_btnNext = self:getChildGO("BtnNext")
end

function addAllUIEvent(self)
    self:addUIEvent(self.m_btnLast, self.onBtnLastClickHandler)
    self:addUIEvent(self.m_btnNext, self.onBtnNextClickHandler)
end

function getTabViewParent(self)
    return self.m_tabViewTrans
end

function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({ MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID }, 1)
    hero.HeroEquipManager:addEventListener(hero.HeroEquipManager.HERO_EQUIP_LIST_UPDATE, self.__onEquipUpdateHandler, self)
    self:getHeroEquipList()
    self:updateArrowBtnState()
    self.m_curHeroId = hero.HeroManager:getPanelShowHeroId()
    --如果不是自己的装备 不显示左右跳转按钮
    if self.m_curHeroId ~= equipBuild.EquipBuildManager:getHeroId() then
        self.m_btnLast:SetActive(false)
        self.m_btnNext:SetActive(false)
    end
end

function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    hero.HeroEquipManager:removeEventListener(hero.HeroEquipManager.HERO_EQUIP_LIST_UPDATE, self.__onEquipUpdateHandler, self)
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
    table.insert(funcOpenList, funcopen.FuncOpenConst.FUNC_ID_HERO_EQUIP_ATTR)
    table.insert(funcOpenList, funcopen.FuncOpenConst.FUNC_ID_HERO_EQUIP_STRENGTHEN)
    table.insert(funcOpenList, funcopen.FuncOpenConst.FUNC_ID_HERO_EQUIP_RETROFIT)
    table.insert(funcOpenList, funcopen.FuncOpenConst.FUNC_ID_HERO_EQUIP_REFACTOR)

    self.tabDataList = {}
    table.insert(self.tabDataList, equipBuild.BuildTabType.ATTRS)
    table.insert(self.tabDataList, equipBuild.BuildTabType.STRENGTHEN)
    table.insert(self.tabDataList, equipBuild.BuildTabType.REMAKE)
    table.insert(self.tabDataList, equipBuild.BuildTabType.RESTRUCTURE)

    for i = 1, #self.tabDataList do
        local tabType = self.tabDataList[i]
        if funcopen.FuncOpenManager:isOpen(funcOpenList[i]) then
            self.tabDataList[i] = { type = tabType, content = { equipBuild.getBuildName(tabType) }, nomalIcon = equipBuild.getBuildIcon(tabType), selectIcon = equipBuild.getBuildIcon(tabType) }
        else
            self.tabDataList[i] = nil
        end
    end

    return self.tabDataList
end

function getTabClass(self)
    self.tabClassDic[equipBuild.BuildTabType.ATTRS] = equipBuild.EquipAttrsTabView
    self.tabClassDic[equipBuild.BuildTabType.STRENGTHEN] = equipBuild.EquipStrengthenTabView
    self.tabClassDic[equipBuild.BuildTabType.REMAKE] = equipBuild.EquipRemakeTabView
    self.tabClassDic[equipBuild.BuildTabType.RESTRUCTURE] = equipBuild.EquipRestructureTabView
    return self.tabClassDic
end

--获取战员的武器列表
function getHeroEquipList(self)
    self.m_posList = {}
    local curHeroVo = hero.HeroManager:getHeroVo(equipBuild.EquipBuildManager:getHeroId())
    if curHeroVo then
        for i = 1, #curHeroVo.equipList do
            if curHeroVo.equipList[i].bagType == bag.BagType.Equip then 
                table.insert(self.m_posList, curHeroVo.equipList[i].subType)
            end
        end
        local function sort(v, v2)
            return v2 > v
        end
        table.sort(self.m_posList, sort)
    end
end

--更新箭头的显示状态
function updateArrowBtnState(self)
    if #self.m_posList > 0 then
        local currPos = equipBuild.EquipStrengthenManager:getOpenEquipVo().subType
        local index = table.indexof(self.m_posList, currPos)
        if(not index) then 
            self.m_btnLast:SetActive(false)
            self.m_btnNext:SetActive(false)
            return
        end
        self.m_btnLast:SetActive(index > 1)
        self.m_btnNext:SetActive(index < #self.m_posList)
    else
        self.m_btnLast:SetActive(false)
        self.m_btnNext:SetActive(false)
    end
end

function onBtnLastClickHandler(self)
    equipBuild.EquipStrengthenManager:setSelectMaterialData(nil)

    self:__changeEquip(true)
end

function onBtnNextClickHandler(self)
    equipBuild.EquipStrengthenManager:setSelectMaterialData(nil)

    self:__changeEquip(false)
end

function __changeEquip(self, last)
    local currPos = equipBuild.EquipStrengthenManager:getOpenEquipVo().subType
    local pos = self.m_posList[table.indexof(self.m_posList, currPos) + (last and -1 or 1)]
    local curHeroVo = hero.HeroManager:getHeroVo(equipBuild.EquipBuildManager:getHeroId())
    if (curHeroVo and curHeroVo.equipList) then
        for i = 1, #curHeroVo.equipList do
            if (curHeroVo.equipList[i].subType == pos) then
                equipBuild.EquipStrengthenManager:setOpenEquipVo(curHeroVo.equipList[i])
                -- equipBuild.EquipBuildManager:setEquipId(curHeroVo.equipList[i].id)
                self:subActive()
                self:updateArrowBtnState()
                break
            end
        end
    end
    GameDispatcher:dispatchEvent(EventName.CHANGE_BRACELETS)
end

function __onEquipUpdateHandler(self)
    self:getHeroEquipList()
    self:updateArrowBtnState()
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]