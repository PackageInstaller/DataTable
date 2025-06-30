--[[   
     装备通用材料选择界面
]] module('hero.HeroEquipMaterialPanel', Class.impl(View))
UIRes = UrlManager:getUIPrefabPath('hero/HeroEquipMaterialPanel.prefab')

destroyTime = -1 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 0 -- 是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）
blurTweenTime = 0 -- 模糊背景的渐变时间（仅2弹窗面板有效，默认不渐变，单位秒）
isScreensave = 0 -- 是否使用黑屏过渡(仅1全屏UI有效，默认开启，0关闭)
-- 罗马数字
PropsEquipSubTypeStr = {"Ⅰ", "Ⅱ", "Ⅲ", "Ⅳ", "Ⅴ", "Ⅵ"}

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(nil, nil)
    self:setTxtTitle('')
end

-- 初始化数据
function initData(self)
    -- 是否降序
    self.mIsDescending = true
    -- 是否默认显示处于状态的
    self.mIsStateYes = true
    -- 已选择的道具id列表
    self.mSelectIdList = {}
    -- 外部设置选择的数量上限
    self.mLimitCount = nil
    -- 外部设置的不再提示内容
    self.mConfirmTip = nil
    -- 外部设置的不再提示类型
    self.mConfirmRemindType = nil
    -- 外部设置的不再提示的检查方法
    self.mCheckIsTipFun = nil
    -- 外部设置的消耗货币tid
    self.mCostMoneyTid = nil
    -- 外部设置的消耗货币数量
    self.mCostMoneyCount = nil
    -- 外部设置的回调方法
    self.mCallFun = nil
    -- 外部设置的回调设置显示隐藏方法
    self.mVisibleCallFun = nil

    self.mList = {}
    self.mEquipScrollerList = {}

    -- 是否显示排序界面
    self.m_isShowSort = false
    self.m_isDescending = true
    self.m_selectFilterDic = {}
    self.m_tempSelectFilterDic = {}
    for type in pairs(equipBuild.panelFilterTypeDic) do
        self.m_selectFilterDic[type] = {}
        self.m_selectFilterDic[type][equipBuild.filterSubTypeAll] = true
        self.m_tempSelectFilterDic[type] = {}
        self.m_tempSelectFilterDic[type][equipBuild.filterSubTypeAll] = true
    end

    -- 选择的材料情况
    self.mEquipScrollerVoList = {}
    self.mMenuList = {}
    -- 是否已请求全部战员简易装备信息
    self.m_hasAllHeroEasyEquip = nil
    
    self:initDetailFilterData()
end

function initDetailFilterData(self)
    -- 特殊的筛选规则
    self.mSpecialColorList = {}
    self.mSelectSuitConfigVoList = {}
    self.mSelectMainAttrConfigVoList = {}
    self.mSelectSecondaryAttrConfigVoList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mFilterNode = self:getChildTrans('NodeFilter')

    self.mLyScroller = self:getChildGO('LyScroller'):GetComponent(ty.LyScroller)
    self.mLyRect = self.mLyScroller:GetComponent(ty.ScrollRect)
    self.mLyScroller:SetItemRender(hero.HeroEquipMaterialItem)
    self.mLyScroller:StopLayoutChange()

    self.mImgEmpty = self:getChildGO('EmptyStateItem')
    self.mTextEmpty = self:getChildGO("mTxtEmptyTip"):GetComponent(ty.Text)

    self.m_btnFilter = self:getChildGO("BtnFilter")
    self.m_transGroupSort = self:getChildTrans("ContentSort")
    self.m_transGroupFilter = self:getChildTrans("GroupFilter")
    self.mGroupFilter = self:getChildGO("mGroupFilter")

    self.mBtnOff = self:getChildGO("mBtnOff")
    self.mBtnAuto = self:getChildGO("mBtnAuto")
    self.mSortGroup = self:getChildGO("mSortGroup")
    self.mInfoGroup = self:getChildGO("mInfoGroup")

    self.mBtnDetailFilter = self:getChildGO("mBtnDetailFilter")
    self.mTxtDetailFilter = self:getChildGO("mTxtDetailFilter"):GetComponent(ty.Text)
    self.mIconDetailFilter = self:getChildGO("mIconDetailFilter"):GetComponent(ty.Image)
    self:initSearchMenu()

    self:setGuideTrans("funcTips_guide_HeroEquipMaterial_btn_off", self.mBtnOff.transform)
end

-- 移除
function destroy(self, isAuto)
    super.destroy(self, isAuto)
    if self.mSortView then
        self.mSortView:destroy()
        self.mSortView = nil
    end
end

-- 设置全屏透明遮罩
function setMask(self)
end

-- 激活
function active(self, args)
    super.active(self, args)
    self:initIndexTab()
    hero.HeroEquipManager:addEventListener(hero.HeroEquipManager.HERO_EQUIP_MATERIAL_VIEW_SELECT_EQUIP,
        self.__onMaterialSelectHandler, self)

    if (self.mVisibleCallFun) then
        self.mVisibleCallFun(true)
    end
end

-- 非激活
function deActive(self)
    super.deActive(self)
    self.mLyScroller.onClick:RemoveAllListeners()
    self.m_selectedItem = nil
    if (self.mLyScroller) then
        self.mLyScroller:CleanAllItem()
    end
    hero.HeroEquipManager:removeEventListener(hero.HeroEquipManager.HERO_EQUIP_MATERIAL_VIEW_SELECT_EQUIP,
        self.__onMaterialSelectHandler, self)
    if self.equipTips then
        self.equipTips:poolRecover()
        self.equipTips = nil
    end
    -- self.mSortView:resetAll()
    if (self.mVisibleCallFun) then
        self.mVisibleCallFun(false)
    end

    for k, v in pairs(self.mEquipScrollerList) do
        v.scrollVo:onRecover()
        self.mEquipScrollerList = {}
    end
end

function initViewText(self)
    self.mTextEmpty.text = _TT(4017)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnOff, self.__onClickOffHandler)
    self:addUIEvent(self.mBtnAuto, self.__onClickAutoHandler)
    self:addUIEvent(self.mBtnDetailFilter, self.onOpenDetailFilterPanel)

    self.mLyScroller.onClick:AddListener(function()
        -- for i = 1,#self.mLyScroller.DataProvider do
        --     self.mLyScroller.DataProvider[i].scrollVo:setSelectState(false)
        -- end
        if self.m_selectedItem and self.m_selectedItem:getSelectState() then
            self.m_selectedItem:setSelectState(false)
        end
        equipBuild.EquipBuildManager:setNowSelectEquip(nil)
    end)
end

-- 特殊的筛选规则界面
function onOpenDetailFilterPanel(self, args)
    local callFun = function(selectColorList, selectSuitConfigVoList, selectMainAttrConfigVoList, selectSecondaryAttrConfigVoList)
        self.mSpecialColorList = selectColorList
        self.mSelectSuitConfigVoList = selectSuitConfigVoList
        self.mSelectMainAttrConfigVoList = selectMainAttrConfigVoList
        self.mSelectSecondaryAttrConfigVoList = selectSecondaryAttrConfigVoList

        self:__updateView(true)
    end
    if self.mEquipFilterRulePanel == nil then
        self.mEquipFilterRulePanel = UI.new(bag.EquipFilterRulePanel)
        self.mEquipFilterRulePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDetailFilterPanelHandler, self)
    end
    self.mEquipFilterRulePanel:open({callFun = callFun, selectColorList = self.mSpecialColorList, suitConfigVoList = self.mSelectSuitConfigVoList, selectMainAttrConfigVoList = self.mSelectMainAttrConfigVoList, selectSecondaryAttrConfigVoList = self.mSelectSecondaryAttrConfigVoList})
end

function updateDetailFilterBtn(self)
    if(#self.mSpecialColorList <= 0 and #self.mSelectSuitConfigVoList <= 0 and #self.mSelectMainAttrConfigVoList <= 0 and #self.mSelectSecondaryAttrConfigVoList <= 0)then
        self.mTxtDetailFilter.text = _TT(40065) -- 筛选
        self.mTxtDetailFilter.color = gs.ColorUtil.GetColor("c6d4e1FF")
        self.mIconDetailFilter.color = gs.ColorUtil.GetColor("c6d4e1FF")
    else
        self.mTxtDetailFilter.text = _TT(1421) -- 已筛选
        self.mTxtDetailFilter.color = gs.ColorUtil.GetColor("ffffffFF")
        self.mIconDetailFilter.color = gs.ColorUtil.GetColor("ffffffFF")
    end
end

-- ui销毁
function onDestroyDetailFilterPanelHandler(self)
    self.mEquipFilterRulePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDetailFilterPanelHandler, self)
    self.mEquipFilterRulePanel = nil
end

-- 改造
function __onClickAutoHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_EQUIP_BUILD_PANEL, {
        equipVo = equipBuild.EquipBuildManager:getNowSelectEquip()
    })
end

-- 卸下和替换
function __onClickOffHandler(self)
    GameDispatcher:dispatchEvent(EventName.CLICK_UNLOAD_EQUIP)
    gs.TransQuick:SizeDelta02(self.mLyScroller.transform, 452)
    if self.m_selectedArg then
        self:__onMaterialSelectHandler(self.m_selectedArg)
    end
    self:updateInfoTips(nil, nil)
end

function updateInfoTips(self, nowEquip, equipVo)

    -- for i = 1 ,#self.mLyScroller.DataProvider do
    --     if equipVo.id == self.mLyScroller.DataProvider[i].scrollVo:getDataVo().id then
    --         self.mLyScroller.DataProvider[i].scrollVo:setSelect(true)
    --     end
    -- end

    self.mBtnOff:SetActive(equipVo)
    self.mBtnAuto:SetActive(equipVo)
    gs.TransQuick:SizeDelta02(self.mLyScroller.transform, equipVo and 382 or 452)
    local subType = 0
    if (equipVo) then
        if (not self.equipTips) then
            self.equipTips = equipBuild.EquipInfoTipsItem:poolGet()
        end
        self.equipTips:setData(equipVo)
        self.equipTips:setParent(self.mInfoGroup.transform)
        if nowEquip == nil then
            self.equipTips:setContrastActive(false)
        end

        subType = equipVo.subType
    else
        if self.equipTips then
            self.equipTips:poolRecover()
            self.equipTips = nil
        end
        return
    end

    local curHeroVo = hero.HeroManager:getHeroVo(self.m_curHeroId)
    local vo = curHeroVo:getEquipByPos(equipVo.subType)
    local txt = _TT(4323)
    if vo == nil then
        txt = _TT(4324) -- 穿戴
    elseif vo.id == equipVo.id then
        txt = _TT(4327) -- 卸下
    end
    self.mBtnOff.transform:Find("Text"):GetComponent(ty.Text).text = txt
    self.mBtnAuto.transform:Find("Text"):GetComponent(ty.Text).text = _TT(4321)
end

-- 设置外部回调设置显示隐藏方法
function setVisibleCall(self, visibleCallFun)
    self.mVisibleCallFun = visibleCallFun
end

-- 设置外部回调方法
function setData(self, dataVo)
    self.m_equipVo = dataVo.equipVo
    self.m_curHeroId = dataVo.heroId

    self.needShowTip = dataVo.needShowTips
    gs.TransQuick:SizeDelta02(self.mLyScroller.transform, self.m_equipVo and 382 or 452)

    self:__setTabIndex(dataVo.slotPos)
end

function __updateView(self, cusIsInit, reset)
    if (not self.m_hasAllHeroEasyEquip) then
        self.m_hasAllHeroEasyEquip = true
        local function allHeroEasyEquipUpdate()
            GameDispatcher:removeEventListener(EventName.UPDATE_ALL_HERO_EQUIP, allHeroEasyEquipUpdate, self)
            self:__updateView(cusIsInit)

            if self.needShowTip then
                self:showTips()
            end
        end
        GameDispatcher:addEventListener(EventName.UPDATE_ALL_HERO_EQUIP, allHeroEasyEquipUpdate, self)
        GameDispatcher:dispatchEvent(EventName.REQ_ALL_HERO_EQUIP, {})
        return
    end

    self:__updateSuitMenuList()
    self:__updateSuitMenuView()
    self:updateStrengthenView(cusIsInit)
    self:updateDetailFilterBtn()
end

function showTips(self)
    if self.mLyScroller.DataProvider and #self.mLyScroller.DataProvider >= 1 and self.mLyScroller.DataProvider[1].scrollVo:getDataVo().heroId == self.m_curHeroId then
        for k, v in pairs(self.mLyScroller.DataProvider) do
            v.scrollVo:setSelect(false)
        end
        --self.m_selectedArg = nil
        --self.mLyScroller.DataProvider[1].scrollVo:setSelect(true)
        equipBuild.EquipBuildManager:setNowSelectEquip(self.mLyScroller.DataProvider[1].scrollVo:getDataVo())
        hero.HeroEquipManager:dispatchEvent(hero.HeroEquipManager.HERO_EQUIP_MATERIAL_VIEW_SELECT_EQUIP, {equipVo = self.mLyScroller.DataProvider[1].scrollVo:getDataVo(), scrollVo = self.mLyScroller.DataProvider[1].scrollVo})
        self:updateInfoTips(nil, self.mLyScroller.DataProvider[1].scrollVo:getDataVo())
    else
        equipBuild.EquipBuildManager:setNowSelectEquip(nil)
    end
end
-- 更新强化界面
function updateStrengthenView(self, isInit, resetSelect)
    if isInit then
        local sortData = {isDescending = self.m_isDescending, sortList = self:getSortList(), isHeroWear = self.mIsStateYes}        
        -- 特殊筛选
        local colorList = #self.mSpecialColorList > 0 and self.mSpecialColorList or nil
        local suitIdList = nil
        if(#self.mSelectSuitConfigVoList > 0)then
            suitIdList = {}
            for i = 1, #self.mSelectSuitConfigVoList do
                table.insert(suitIdList, self.mSelectSuitConfigVoList[i].suitId)
            end
        end
        local slotPosList = self.m_currTabIndex and self.m_currTabIndex or nil
        local equipList = braceletBuild.BraceletBuildManager:getDetailRuleEquipList(bag.BagType.Equip, bag.BagTabType.EQUIP, suitIdList, slotPosList, colorList, sortData)
        local mainAttrCount = #self.mSelectMainAttrConfigVoList
        local attachAttrCount = #self.mSelectSecondaryAttrConfigVoList
        if(mainAttrCount > 0 or attachAttrCount > 0)then
            for i = #equipList, 1, -1 do
                local equipVo = equipList[i]
                local filterMainAttrList, filterMainAttrDic, filterAttachAttrList, filterAttachAttrDic = nil, nil, nil, nil
                local totalAttrList, totalAttrDic = equipVo:getTotalAttr()
                if (totalAttrList == nil and totalAttrDic == nil) then
                    filterMainAttrList, filterMainAttrDic, filterAttachAttrList, filterAttachAttrDic = equipVo:getFilterAttr()
                else
                    filterMainAttrList, filterMainAttrDic = equipVo:getMainAttr()
                    filterAttachAttrList, filterAttachAttrDic = equipVo:getTuPoAttachAttr()
                end

                local isHadRemove = false
                if(mainAttrCount > 0 and not isHadRemove)then
                    local isInMainAttr = false
                    for _, attrConfigVo in pairs(self.mSelectMainAttrConfigVoList) do
                        if(filterMainAttrDic[attrConfigVo:getRefID()])then
                            isInMainAttr = true
                            break
                        end
                    end
                    if(not isInMainAttr)then
                        isHadRemove = true
                        table.remove(equipList, i)
                    end
                end

                if(attachAttrCount > 0 and not isHadRemove)then
                    local isHadAllAttachAttr = true
                    for _, attrConfigVo in pairs(self.mSelectSecondaryAttrConfigVoList) do
                        if(not filterAttachAttrDic[attrConfigVo:getRefID()])then
                            isHadAllAttachAttr = false
                            break
                        end
                    end
                    if(not isHadAllAttachAttr)then
                        isHadRemove = true
                        table.remove(equipList, i)
                    end
                end
            end
        end

        local curHeroVo = hero.HeroManager:getHeroVo(self.m_curHeroId)
        if curHeroVo and curHeroVo.equipList and self.m_equipVo then
            for i = 1, #curHeroVo.equipList do
                if curHeroVo.equipList[i].subType == self.m_equipVo.subType and table.indexof01(equipList,curHeroVo.equipList[i]) <= 0 then
                    table.insert(equipList,1, curHeroVo.equipList[i])
                end
            end
        end

        local scrollList = {}
        for i = 1, #equipList do
            local equipVo = equipList[i]
            local scrollerVo = LyScrollerSelectVo.new()
            scrollerVo:setDataVo(equipVo)
            scrollerVo:setSelect(false)
            table.insert(scrollList, {scrollVo = scrollerVo, heroId = self.m_curHeroId})
        end

        -- 过滤 属于自己的装备排在最前面
        self.mEquipScrollerList = {}
        local otherEquip = {}
        self:updateInfoTips(nil, nil)
        for i = 1, #scrollList do
            if scrollList[i].scrollVo:getDataVo().heroId == self.m_curHeroId then
                -- if resetSelect then
                --     cusLog("============================")
                --     scrollList[i].scrollVo:setSelect(true)
                --     equipBuild.EquipBuildManager:setNowSelectEquip(scrollList[i].scrollVo:getDataVo())
                --     self:updateInfoTips(nil, scrollList[i].scrollVo:getDataVo())
                -- end
                table.insert(self.mEquipScrollerList, scrollList[i])

            else
                table.insert(otherEquip, scrollList[i])
            end
        end

        for i = 1, #otherEquip do
            table.insert(self.mEquipScrollerList, otherEquip[i])
        end
        self.m_selectedArg = nil

        -- if #self.mEquipScrollerList > 1 then
        --     self.mEquipScrollerList[1].scrollVo:setSelect(true)
        -- end
    end

    if isInit or self.mLyScroller.Count <= 0 then
        self.mLyScroller.DataProvider = self.mEquipScrollerList
    else
        self.mLyScroller:ReplaceAllDataProvider(self.mEquipScrollerList)
    end
    self.mImgEmpty:SetActive(#self.mEquipScrollerList <= 0)
end

function getSortList(self)
    local typeList = bag.getSortList(bag.BagTabType.EQUIP)
    local sortTypeList = {}
    for i = 1, #typeList do
        local type = typeList[i]
        if (type == self.m_selectSortType) then
            table.insert(sortTypeList, 1, type)
        else
            table.insert(sortTypeList, type)
        end
    end
    return sortTypeList
end

function initIndexTab(self)
    self.m_tabDic = {}
    for pos = 1, 6 do
        local go = self:getChildGO("Tab_" .. pos)
        local text = go.transform:Find('TextIdx'):GetComponent(ty.Text)
        text.text = PropsEquipSubTypeStr[pos]
        self.m_tabDic['Tab_' .. pos] = {
            go = go,
            imgBg = go.transform:Find('ImgBg').gameObject,
            imgSelected = go.transform:Find('ImgSelected').gameObject,
            text = text
        }
        self:addUIEvent(go, self.__onTabChangeHandler, nil, pos)
    end
end

function initSearchMenu(self)
    self.m_suitmenu = self.m_suitmenu or self:getChildGO('SuitMenu')
    self.m_suitdropDown = self.m_suitdropDown or self:getChildGO('SuitDropDown')
    self.m_suititemSubMenu = self.m_suititemSubMenu or self:getChildGO('SuitItemSubMenu')
    self.m_suitimgGoUp = self.m_suitimgGoUp or self:getChildGO('SuitImgUp')
    self.m_suitimgGoDown = self.m_suitimgGoDown or self:getChildGO('SuitImgDown')
    self.mSubMenuSuitScroll = self.mSubMenuSuitScroll or self:getChildGO('SubMenuSuitScroll')

    self.m_menu = self.m_menu or self:getChildGO('Menu')
    self.m_dropDown = self.m_dropDown or self:getChildGO('DropDown')
    self.m_itemSubMenu = self.m_itemSubMenu or self:getChildGO('ItemSubMenu')
    self.m_imgGoUp = self.m_imgGoUp or self:getChildGO('ImgUp')
    self.m_imgGoDown = self.m_imgGoDown or self:getChildGO('ImgDown')

    self.m_descending = self.m_descending or self:getChildGO('ImgClick')

    local _active = self.active
    self.active = function()
        _active(self)
        self:__updateDescendingState()
        self:__updateMenuList()
        self:__updateMenuView()
        self:addUIEvent(self.m_suitmenu, self.__clickSuitMenu)
        self:addUIEvent(self.m_menu, self.__clickMenu)
        self:addUIEvent(self.m_descending, self.__clickDescending)
    end

    local _deActive = self.deActive
    self.deActive = function()
        _deActive(self)
        self:__resetAllSubMenu()
        self.m_isDescending = true
        self.m_isOpenSuitMenu = false
        self.m_isOpenMenu = false
        self.m_selectSortType = nil
    
        -- self:initDetailFilterData()
    end
end

function __updateDescendingState(self)
    self.m_imgSortUp = self.m_imgSortUp or self:getChildGO('ImgSortUp')
    self.m_imgSortDown = self.m_imgSortDown or self:getChildGO('ImgSortDown')

    self.m_imgSortUp:SetActive(not self.m_isDescending)
    self.m_imgSortDown:SetActive(self.m_isDescending)
end

function __updateMenuList(self)
    -- 是否打开排序菜单
    self.m_isOpenMenu = false
    -- 当前的菜单类型列表数据
    self.m_menuList = bag.getSortList(bag.BagTabType.EQUIP)
    -- 当前选择的排序类型
    self.m_selectSortType = self.m_selectSortType or self.m_menuList[1]
    -- 当前的排序内容列表数据
    self.m_menuPageList = {}
    for i = 1, #self.m_menuList do
        local menuType = self.m_menuList[i]
        if (menuType ~= bag.BagSortType.ID) then
            local name = bag.getSortName(menuType)
            table.insert(self.m_menuPageList, {
                page = menuType,
                nomalLan = name,
                nomalLanEn = ""
            })
        end
    end
    if (self.tabBar) then
        self.tabBar:reset()
    end
    self.tabBar = CustomTabBar:create(self.m_itemSubMenu, self.m_dropDown.transform, self.__clickSubMenu, self)
    self.tabBar:setData(self.m_menuPageList)
    self.tabBar:setPage(self.m_selectSortType, false)
end

function __clickMenu(self)
    if self.m_isOpenSuitMenu then
        self:__clickSuitMenu()
    end

    self.m_isOpenMenu = not self.m_isOpenMenu
    self:__updateMenuView()
end

function __clickSubMenu(self, sortType)
    self.m_isOpenMenu = false
    self.m_selectSortType = sortType

    GameDispatcher:dispatchEvent(EventName.CLOSE_BRACELETS_CONTRAST_TIPS)
    self:__updateMenuList()
    self:__updateMenuView()
    self:updateStrengthenView(true)
end

function __clickSuitMenu(self)
    if self.m_isOpenMenu then
        self:__clickMenu()
    end

    self.m_isOpenSuitMenu = not self.m_isOpenSuitMenu
    self:__updateSuitMenuView()
end

function __clickSuitSubMenu(self, suit)
    self.m_isOpenSuitMenu = false
    self.m_selectSuit = suit

    GameDispatcher:dispatchEvent(EventName.CLOSE_BRACELETS_CONTRAST_TIPS)
    self:__updateSuitMenuList()
    self:__updateSuitMenuView()
    self:updateStrengthenView(true)
end

function __updateMenuView(self)
    -- 排序菜单状态
    self:setBtnLabel(self.m_menu, -1, bag.getSortName(self.m_selectSortType))
    self.m_dropDown:SetActive(self.m_isOpenMenu)
    self.m_imgGoUp:SetActive(self.m_isOpenMenu)
    self.m_imgGoDown:SetActive(not self.m_isOpenMenu)
end

function __updateSuitMenuList(self)
    self:__resetAllSubMenu()
    self.m_isOpenSuitMenu = false

    -- self.m_suitmenuList = equip.EquipSuitManager:getFormatSuitConfigList(self.m_currTabIndex, self.mIsStateYes)
    self.m_suitmenuList = equip.EquipSuitManager:getFormatSuitConfigList(nil, self.mIsStateYes)
    table.insert(self.m_suitmenuList, 1, {
        suitId = -1,
        name = _TT(4011)
    })
    self.m_selectSuit = self.m_selectSuit or self.m_suitmenuList[1]
    local subMenu = SimpleInsItem:create(self.mSubMenuSuitScroll, self.m_suitdropDown.transform,
        self.__cname .. "_self.mSubMenuSuit")
    for i = 1, #self.m_suitmenuList do
        local type = self.m_suitmenuList[i]
        local item = type.suitId ~= -1 and
                         SimpleInsItem:create(subMenu:getChildGO("BtnSuit"), subMenu:getChildTrans("SubMenuSuit"),
                self.__cname .. "_BtnSuit") or
                         SimpleInsItem:create(subMenu:getChildGO("BtnSuitAll"), subMenu:getChildTrans("SubMenuSuit"),
                self.__cname .. "_BtnSuitAll")
        local goImgUnSelect = item:getChildGO("ImgUnSelect")
        local goImgSelect = item:getChildGO("ImgSelect")
        local goTextUnSelect = item:getChildGO("TextUnSelect")
        local goTextSelect = item:getChildGO("TextSelect")
        local goTextUnCount = item:getChildGO("TextUnCount")
        local goTextCount = item:getChildGO("TextCount")
        local goTextUnFeatures = item:getChildGO("TextUnFeatures")
        local goTextFeatures = item:getChildGO("TextFeatures")
        local textUnSelect = goTextUnSelect:GetComponent(ty.Text)
        local textSelect = goTextSelect:GetComponent(ty.Text)
        local textUnCount = goTextUnCount:GetComponent(ty.Text)
        local textCount = goTextCount:GetComponent(ty.Text)
        local textUnFeatures = goTextUnFeatures:GetComponent(ty.Text)
        local textFeatures = goTextFeatures:GetComponent(ty.Text)
        textUnSelect.text = type.name
        textSelect.text = type.name
        local count = 0
        if (type.suitId == -1) then
            count = #bag.BagManager:getPropsListByType(PropsType.EQUIP, nil, bag.BagType.Equip)
        else
            -- count = type:getSuitEquipCount(self.m_currTabIndex, self.mIsStateYes)
            count = type:getSuitEquipCount(nil, nil)
        end
        textUnCount.text = type.suitId ~= -1 and count or string.format("(%s)", count)
        textCount.text = type.suitId ~= -1 and count or string.format("(%s)", count)
        local alpha = (count > 0 and 1 or 0.5)
        local color = textUnCount.color
        color.a = alpha
        textUnCount.color = color
        local unColor = textCount.color
        unColor.a = alpha
        textCount.color = unColor
        textUnFeatures.text = type ~= -1 and type.featuresDes or ""
        textFeatures.text = type ~= -1 and type.featuresDes or ""

        if (type.suitId == self.m_selectSuit.suitId) then
            goImgUnSelect:SetActive(false)
            goImgSelect:SetActive(true)
            goTextUnSelect:SetActive(false)
            goTextSelect:SetActive(true)
            goTextUnCount:SetActive(false)
            goTextCount:SetActive(true)
            goTextUnFeatures:SetActive(false)
            goTextFeatures:SetActive(true)
        else
            goImgUnSelect:SetActive(true)
            goImgSelect:SetActive(false)
            goTextUnSelect:SetActive(true)
            goTextSelect:SetActive(false)
            goTextUnCount:SetActive(true)
            goTextCount:SetActive(false)
            goTextUnFeatures:SetActive(true)
            goTextFeatures:SetActive(false)
        end
        if (type.suitId ~= -1) then
            local icon = equip.EquipSuitManager:getEquipSuitConfigVo(type.suitId).icon
            item:getChildGO("ImgIcon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getIconPath(icon), false)
        end

        local function _clickSubMenuItemFun()
            if (self.m_selectSuit.suitId ~= type.suitId) then
                self:__resetAllSubMenu()
                self:__clickSuitSubMenu(type)
            else
                self:__clickSuitMenu()
            end
        end
        item:addUIEvent("ImgClick", _clickSubMenuItemFun)
        table.insert(self.mMenuList, item)
    end
    table.insert(self.mMenuList, subMenu)
end

function __resetAllSubMenu(self)
    for i = #self.mMenuList, 1, -1 do
        self.mMenuList[i]:recover()
        table.remove(self.mMenuList, i)
    end
end

function __updateSuitMenuView(self)
    self:setBtnLabel(self.m_suitmenu, -1, self.m_selectSuit.name)
    self.m_suitdropDown:SetActive(self.m_isOpenSuitMenu)
    self.m_suitimgGoUp:SetActive(self.m_isOpenSuitMenu)
    self.m_suitimgGoDown:SetActive(not self.m_isOpenSuitMenu)
end

function __clickDescending(self)
    if self.m_isOpenSuitMenu then
        self:__clickSuitMenu()
    end

    GameDispatcher:dispatchEvent(EventName.CLOSE_BRACELETS_CONTRAST_TIPS)
    local temp = not self.m_isDescending
    self.m_isDescending = temp
    self:__updateDescendingState();
    self:updateStrengthenView(true)
end

function recoverListData(self, list)
    if (list and #list > 0) then
        for i, v in ipairs(list) do
            LuaPoolMgr:poolRecover(v)
        end
    end
end

function __onMaterialSelectHandler(self, args)

    for k, v in pairs(self.mEquipScrollerList) do
        v.scrollVo:setSelect(v.scrollVo == args.scrollVo)
    end

    if self.m_selectedArg then
        local scrollVo 
        for k,v in pairs(self.mEquipScrollerList) do
            if v.scrollVo == self.m_selectedArg.scrollVo then 
                scrollVo = v.scrollVo
                break
            end
        end
        if self.m_selectedArg.scrollVo == args.scrollVo then 
            scrollVo:setSelect(not scrollVo:getSelect())
            self.m_selectedArg = nil
            return
        else
            scrollVo:setSelect(false)
            for k,v in pairs(self.mEquipScrollerList) do
                if v.scrollVo == args.scrollVo then 
                    v.scrollVo:setSelect(true)
                    break
                end
            end
            self.m_selectedArg = args
        end
    else
        for k,v in pairs(self.mEquipScrollerList) do
            if v.scrollVo == args.scrollVo then 
                v.scrollVo:setSelect(true)
                break
            end
        end
        self.m_selectedArg = args
    end
    self.isNew = read.ReadManager:isModuleRead(ReadConst.NEW_EQUIP, args.equipVo.id)
    if self.isNew then
        GameDispatcher:dispatchEvent(EventName.REQ_MODULE_READ, {
            type = ReadConst.NEW_EQUIP,
            id = args.equipVo.id
        })
    end
    self:updateStrengthenView(false)
end

function __onTabChangeHandler(self, index)
    -- GameDispatcher:dispatchEvent(EventName.CLOSE_BRACELETS_CONTRAST_TIPS)
    hero.HeroEquipManager:dispatchEvent(hero.HeroEquipManager.HERO_EQUIP_TAB_VIEW_SELECT_EQUIP, {
        index = index
    })
    self:updateStrengthenView(true, true)

    self:showTips()
    -- if self.m_curHeroId == self.mEquipScrollerList[1].heroId then
    --     --self.mEquipScrollerList[1].scrollVo:setSelect(true)
    --     self:updateInfoTips(nil, self.mEquipScrollerList[1].scrollVo:getDataVo())
    -- end

    -- scrollList[i].scrollVo:getDataVo().heroId == self.m_curHeroId
end

function __setTabIndex(self, curIndex)
    local update = self.m_currTabIndex ~= curIndex
    if update then
        self:__setSelectTab(self.m_currTabIndex, false)
        self.m_currTabIndex = curIndex
        self:__setSelectTab(self.m_currTabIndex, true)
        GameDispatcher:dispatchEvent(EventName.CLOSE_BRACELETS_CONTRAST_TIPS)
    end
    self:__updateView(true)
end

function __setSelectTab(self, curIndex, cusBol)
    if curIndex then
        local tabObj = self.m_tabDic['Tab_' .. curIndex]
        tabObj.imgBg:SetActive(not cusBol)
        tabObj.imgSelected:SetActive(cusBol)
        tabObj.text.color = cusBol and gs.ColorUtil.GetColor("404548FF") or gs.ColorUtil.GetColor("BCBDBDFF")
    end
end

-- 根据是有包含已有装备获取所有的套装列表
function getHasSuitConfigList(self, isAddAllId, slotPos)
    local suitConfigList = {}
    local sortData = {
        isDescending = self.m_isDescending,
        sortList = self:getSortList(),
        isHeroWear = self.mIsStateYes
    }
    local equipList = braceletBuild.BraceletBuildManager:getEquipList(bag.BagType.Equip, bag.BagTabType.EQUIP,
        equip.EquipSuitManager.All_SUIT_EQUIP_ID, nil, sortData, self.m_curHeroId)
    for i = 1, #equipList do
        if slotPos == nil or slotPos == equipList[i].subType then
            local equipConfigVo = equip.EquipManager:getEquipConfigVo(equipList[i].tid)
            local isHad = false
            for j = 1, #suitConfigList do
                if (equipConfigVo) then
                    if (suitConfigList[j].suitId == equipConfigVo.suitId) then
                        isHad = true
                        break
                    end
                else
                    Debug:log_error('HeroEquipSuitPanel', '战员芯片配置表找不到tid：' .. equipList[i].tid)
                end
            end
            if (not isHad) then
                if (equipConfigVo) then
                    local suitConfigVo = equip.EquipSuitManager:getEquipSuitConfigVo(equipConfigVo.suitId)
                    table.insert(suitConfigList, suitConfigVo)
                end
            end
        end
    end

    if #suitConfigList > 1 then
        local suitSort = function(a, b)
            return a.suitId < b.suitId
        end
        table.sort(suitConfigList, suitSort)
    end

    if ((isAddAllId == nil or isAddAllId == true) and #suitConfigList > 0) then
        -- 手动设置一个全部的选项
        local suitConfigVo = equip.EquipSuitConfigVo.new()
        suitConfigVo.suitId = equip.EquipSuitManager.All_SUIT_EQUIP_ID
        suitConfigVo.name = nil
        suitConfigVo.effectDes = nil
        suitConfigVo.suitSkillId_2 = nil
        suitConfigVo.suitSkillId_4 = nil

        table.insert(suitConfigList, 1, suitConfigVo)
    end
    return suitConfigList
end

function __onClickTouchHandler(self)
    if self.m_isOpenSuitMenu then
        self:__clickSuitMenu()
    end
    if self.m_isOpenMenu then
        self:__clickMenu()
    end
end

function onClickClose(self)
    super.onClickClose(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
