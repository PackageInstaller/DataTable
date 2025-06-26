module("hero.HeroSortView", Class.impl())

UIRes = UrlManager:getUIPrefabPath("hero/HeroSortView.prefab")

-- 构造函数
function ctor(self)
    self:__startLoad()
end

-- function getInstance(self)
--     if (not self.m_instance) then
--         self.m_instance = bag.BagSortView.new()
--     end
--     return self.m_instance
-- end

-- 为组件加入侦听点击事件
function addOnClick(self, obj, callBack, soundPath, ...)
    if obj == nil then
        error('obj is nil', 2)
    end
    if not obj:GetComponent(ty.Button) then
        error('btn is nil', 2)
    end
    local params = nil
    if select("#", ...) > 0 then
        params = {...}
    end
    local func = function()
        if (soundPath == nil) then
            AudioManager:playSoundEffect(UrlManager:getUIBaseSoundPath("ui_basic_click.prefab"))
        else
            AudioManager:playSoundEffect(soundPath)
        end
        if params then
            callBack(self, unpack(params))
        else
            callBack(self)
        end
    end
    gs.UIComponentProxy.AddListener(obj, func)
end

-- 为组件移除侦听点击事件
function removeOnClick(self, obj)
    gs.UIComponentProxy.RemoveListener(obj)
end

function setCallBack(self, cusCallObj, cusCallFun, ...)
    if select("#", ...) > 0 then
        self.m_params = {...}
    end
    self.m_callFun = cusCallFun
    self.m_callObj = cusCallObj
end

function setParentTrans(self, cusParent)
    if not self.m_uiGo then
        self:__startLoad()
    end
    self.m_uiGo.transform:SetParent(cusParent, false)
end

-- 设置左对齐
function setAlignLeft(self, posX)
    if not self.m_uiGo then
        logError("请先添加到父节点调用 setParentTrans ")
        return
    end
    gs.TransQuick:Anchor(self.mGroupMenu, 0, 1, 0, 1)
    gs.TransQuick:Pivot(self.mGroupMenu, 0, 0.5)
    gs.TransQuick:LPosX(self.mGroupMenu, posX or 122)
end

-- 设置居中对齐
function setAlignCenter(self, posX, posY)
    if not self.m_uiGo then
        logError("请先添加到父节点调用 setParentTrans ")
        return
    end
    gs.TransQuick:Anchor(self.mGroupMenu, 0.5, 0.5, 0.5, 0.5)
    gs.TransQuick:Pivot(self.mGroupMenu, 1, 0.5)
    gs.TransQuick:LPosX(self.mGroupMenu, posX or 564)
    gs.TransQuick:LPosY(self.mGroupMenu, posY or 268.58)
end

function __startLoad(self)
    AssetLoader.PreLoad(self.UIRes, self.__onLoadAssetComplete, self)
end

function __onLoadAssetComplete(self)
    self:__init()
end

function __init(self)
    self:__initUI()
    self:__initData()
    self:__initEvent()
end

function __initUI(self)
    self.m_uiGo = gs.GOPoolMgr:Get(self.UIRes)
    self.m_uiGos, self.m_uiTrans = GoUtil.GetChildHash(self.m_uiGo)

    -- 菜单
    self.mGroupMenu = self.m_uiTrans["GroupMenu"]
    self.mMenuSort = self.m_uiGos["MenuSort"]
    self.mMenuCommon = self.m_uiGos["MenuCommon"]
    self.mMenuCommonRound = self.m_uiGos["MenuCommonRound"]
    -- 子菜单
    self.mSubMenuCommon = self.m_uiGos["SubMenuCommon"]
    self.mSubMenuFilter = self.m_uiGos["SubMenuFilter"]

    self.mGoToucher = self.m_uiGos["ImgToucher"]

    self.mChangeShowType = self.m_uiGos["ChangeShowType"]
end

function __initData(self)
    -- 排序是否降序
    self.mSortDescending = false
    -- 是否显示全部
    self.mIsShowAll = false
    -- 是否显示红点战员
    self.mIsShowRed = false
    -- 是否过滤相同
    self.mIsFilterSame = false
    -- 是否过滤使用状态
    self.mIsFilterUseState = false
    -- 菜单列表
    self.mMenuList = {}
end

function __initEvent(self)
    self:addOnClick(self.mGoToucher, self.__onClickToucherHandler)
end

function __onClickToucherHandler(self)
    self:__resetAllSubMenu()
end

------------------------------------------------------------------------ 特殊显示全部战员 ------------------------------------------------------------------------
-- 设置显示全部战员
function setShowAll(self, visible, isShowAll, customX, customY)
    if (not self.mGoShowAll) then
        self.mGoShowAll = self.m_uiGos["GroupShowAll"]
        self.mTransShowAll = self.m_uiTrans["GroupShowAll"]
        self.mGoShowAllNormal = self.m_uiGos["ImgShowAllNormal"]
        self.mGoShowAllSelect = self.m_uiGos["ImgShowAllSelect"]
        self.mTextShowAll = self.m_uiGos["TextShowAllTip"]:GetComponent(ty.Text)
        self.mGoShowAllClick = self.m_uiGos["ImgShowAllClick"]

        if (customX ~= nil or customY ~= nil) then
            self.mGoShowAll:GetComponent(ty.LayoutElement).ignoreLayout = true
            gs.TransQuick:LPosXY(self.mTransShowAll, customX, customY)
        end
    end
    self.mGoShowAll:SetActive(visible)
    if (visible) then
        self.mIsShowAll = isShowAll
        self:__updateShowAll()
        self:addOnClick(self.mGoShowAllClick, self.__onClickShowAllHandler)
    else
        self:removeOnClick(self.mGoShowAllClick, self.__onClickShowAllHandler)
    end
end

-- 隐藏全部按钮
function setHideShowAll(self)
    if not self.mGoShowAll then
        self.mGoShowAll = self.m_uiGos["GroupShowAll"]
    end
    self.mGoShowAll:SetActive(false)
end

-- 显示全部战员
function __onClickShowAllHandler(self)
    self.mIsShowAll = not self.mIsShowAll
    self:__updateShowAll()
    self:__callFun()
end
-- 更新是否显示全部战员
function __updateShowAll(self)
    self.mGoShowAllNormal:SetActive(not self.mIsShowAll)
    self.mGoShowAllSelect:SetActive(self.mIsShowAll)
    self.mTextShowAll.text = _TT(1342)
end

-- 设置显示红点战员
function setShowRed(self, visible, isShowRed, customX, customY)
    if (not self.mGoShowRed) then
        self.mGoShowRed = self.m_uiGos["GroupShowRed"]
        self.mTransShowRed = self.m_uiTrans["GroupShowRed"]
        self.mGoShowRedNormal = self.m_uiGos["ImgShowRedNormal"]
        self.mGoShowRedSelect = self.m_uiGos["ImgShowRedSelect"]
        self.mTextShowRed = self.m_uiGos["TextShowRed"]:GetComponent(ty.Text)
        self.mGoShowRedClick = self.m_uiGos["ImgShowRedClick"]
        self:__updateShowRed()
        if (customX ~= nil or customY ~= nil) then
            self.mGoShowRed:GetComponent(ty.LayoutElement).ignoreLayout = true
            gs.TransQuick:LPosXY(self.mTransShowRed, customX, customY)
        end
    end
    self.mGoShowRed:SetActive(visible)
    if (visible) then
        self.mIsShowRed = isShowRed
        self:__updateShowAll()
        self:addOnClick(self.mGoShowRedClick, self.__onClickShowRedHandler)
    else
        self:removeOnClick(self.mGoShowRedClick, self.__onClickShowRedHandler)
    end
end

-- 隐藏全部按钮
function setHideShowRed(self)
    if not self.mGoShowRed then
        self.mGoShowRed = self.m_uiGos["GroupShowRed"]
    end
    self.mGoShowRed:SetActive(false)
end

-- 显示红点战员
function __onClickShowRedHandler(self)
    self.mIsShowRed = not self.mIsShowRed
    self:__updateShowRed()
    self:__callFun()
end
-- 更新是否显示红点战员
function __updateShowRed(self)
    self.mGoShowRedNormal:SetActive(not self.mIsShowRed)
    self.mGoShowRedSelect:SetActive(self.mIsShowRed)
    self.mTextShowRed.text = "只看红点"
end


------------------------------------------------------------------------ 特殊显示全部战员 ------------------------------------------------------------------------

------------------------------------------------------------------------ 特殊过滤相同 ------------------------------------------------------------------------
-- 设置过滤相同
function setFilterSame(self, visible, isFilter, customX, customY)
end

-- 过滤相同
function __onClickFilterSameHandler(self)
    self.mIsFilterSame = not self.mIsFilterSame
    self:__updateFilterSame()
    self:__callFun()
end

-- 更新是否过滤相同战员
function __updateFilterSame(self)
    self.mGoFilterSameNormal:SetActive(not self.mIsFilterSame)
    self.mGoFilterSameSelect:SetActive(self.mIsFilterSame)
    self.mTextFilterSame.text = _TT(1343)
end
------------------------------------------------------------------------ 特殊过滤使用状态 ------------------------------------------------------------------------

-- 设置过滤使用状态
function setFilterUseState(self, visible, isFilter, customX, customY)
    if (not self.mGoFilterUseState) then
        self.mGoFilterUseState = self.m_uiGos["GroupUseState"]
        self.mTransFilterUseState = self.m_uiTrans["GroupUseState"]
        self.mBtnUseStateYes = self.m_uiGos["BtnUseStateYes"]
        self.mBtnUseStateNo = self.m_uiGos["BtnUseStateNo"]
        self.mTextUseStateYes = self.m_uiGos["TextUseStateYes"]:GetComponent(ty.Text)
        self.mTextUseStateNo = self.m_uiGos["TextUseStateNo"]:GetComponent(ty.Text)

        if (customX ~= nil or customY ~= nil) then
            self.mGoFilterUseState:GetComponent(ty.LayoutElement).ignoreLayout = true
            gs.TransQuick:LPosXY(self.mTransFilterUseState, customX, customY)
        end
    end
    self.mGoFilterUseState:SetActive(visible)
    if (visible) then
        self.mIsFilterUseState = isFilter
        self:__updateFilterUseState()
        self:addOnClick(self.mBtnUseStateYes, self.__onClickFilterUseStateYesHandler)
        self:addOnClick(self.mBtnUseStateNo, self.__onClickFilterUseStateNoHandler)
    else
        self:removeOnClick(self.mBtnUseStateYes, self.__onClickFilterUseStateYesHandler)
        self:removeOnClick(self.mBtnUseStateNo, self.__onClickFilterUseStateNoHandler)
    end
end

-- 过滤使用状态
function __onClickFilterUseStateYesHandler(self)
    self.mIsFilterUseState = false
    self:__updateFilterUseState()
    self:__callFun()
end

-- 过滤使用状态
function __onClickFilterUseStateNoHandler(self)
    self.mIsFilterUseState = true
    self:__updateFilterUseState()
    self:__callFun()
end

-- 更新是否过滤使用状态
function __updateFilterUseState(self)
    self.mTextUseStateYes.text = "行动中"
    self.mTextUseStateNo.text = "行动中"
    self.mBtnUseStateYes:SetActive(self.mIsFilterUseState)
    self.mBtnUseStateNo:SetActive(not self.mIsFilterUseState)
end

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
function __resetAllMenu(self)
    -- 回收排序菜单
    self:__recoverMenuList(self:getMenuSortKey(false))
    self:__recoverMenuList(self:getMenuSortKey(true))

    -- 回收筛选菜单
    self:__recoverMenuList(self:getMenuFilterKey())
end

function __resetAllSubMenu(self)
    -- 回收排序子菜单
    self:__recoverMenuList(self:getSubMenuSortKey(false))
    self:__recoverMenuList(self:getSubMenuSortKey(true))

    -- 回收筛选菜单
    self:__recoverMenuList(self:getSubMenuFilterKey(false))
    self:__recoverMenuList(self:getSubMenuFilterKey(true))

    for i = #self.mMenuList, 1, -1 do
        local menuData = self.mMenuList[i]
        menuData.isOpen = false
        if (menuData.updateMenuStyle) then
            menuData.updateMenuStyle()
        end
    end

    self:__setIsOpen(false)
end

function __setIsOpen(self, isOpen)
    self.mGoToucher:SetActive(isOpen)
end

function addChangeTypeBtn(self, callBack)
    self:__resetAllSubMenu()
    -- self:__recoverMenuList(self:getMenuSortKey(false))
    local item = SimpleInsItem:create(self.mChangeShowType, self.mGroupMenu, self.__cname .. "_self.mChangeType")
    -- item:SetActive(true)
    local image = item:getChildGO("ImageIcon"):GetComponent(ty.AutoRefImage)
    local function changeImg()
        if (not hero.HeroManager:getIsVer()) then
            image:SetImg(UrlManager:getCommon5Path("common_0276.png"))
        else
            image:SetImg(UrlManager:getCommon5Path("common_0277.png"))
        end
    end
    changeImg()
    local function selfCallback()
        hero.setHeroPanelOffset(0)
        callBack()
        changeImg()
    end
    item:addUIEvent("ImgClick", selfCallback)
    table.insert(self.mMenuList, {
        obj = item,
        key = self:getMenuSortKey(true),
        typeList = nil,
        type = nil,
        isOpen = true,
        isFirstTime = true,
        updateMenuStyle = nil
    })

end

-- 添加排序通用菜单
function addSortMenu(self, sortTypeList, showSortType, isDescending, isOpenSubMenu, isLitleView)
    self:__resetAllSubMenu()
    self:__recoverMenuList(self:getMenuSortKey(false))
    self:__recoverMenuList(self:getMenuSortKey(true))

    -- 排序菜单按钮
    local item = SimpleInsItem:create(self.mMenuCommon, self.mGroupMenu, self.__cname .. "_self.mMenuCommon")
    item:getChildGO("mImgMenuBgRoll"):SetActive(false)
    item:getChildGO("mImgMenuBgRect"):SetActive(true)
    local text = item:getChildGO("Text"):GetComponent(ty.Text)
    text.color = isLitleView and gs.ColorUtil.GetColor("202226ff") or gs.ColorUtil.GetColor("ffffffff")
    local goUp = item:getChildGO("ImgUp")
    local goDown = item:getChildGO("ImgDown")
    local goImgIcon = item:getChildGO("ImgIcon")
    local imgIcon = goImgIcon:GetComponent(ty.AutoRefImage)
    goUp:GetComponent(ty.Image).color = isLitleView and gs.ColorUtil.GetColor("202226ff") or
                                            gs.ColorUtil.GetColor("ffffffff")
    goDown:GetComponent(ty.Image).color = isLitleView and gs.ColorUtil.GetColor("202226ff") or
                                              gs.ColorUtil.GetColor("ffffffff")
    item:getChildGO("mImgMenuBgRect"):GetComponent(ty.AutoRefImage).color = isLitleView and
                                                                                gs.ColorUtil.GetColor("16172Bff") or
                                                                                gs.ColorUtil.GetColor("ffffffff")
    imgIcon.color = isLitleView and gs.ColorUtil.GetColor("202226ff") or gs.ColorUtil.GetColor("ffffffff")
    goImgIcon:SetActive(false)
    local function _updateMenuStyle()
        local data = self:getSimpleItem(self:getMenuSortKey(false))
        text.text = showBoard.getSortTypeName(data.type)
        goUp:SetActive(data.isOpen)
        goDown:SetActive(not data.isOpen)

        self:__setIsOpen(data.isOpen)
    end

    local function _clickMenuFun()
        local data = self:getSimpleItem(self:getMenuSortKey(false))
        local isOpen = data.isOpen
        self:__resetAllSubMenu()
        data.isOpen = not isOpen
        _updateMenuStyle()
        self:__updateSubMenuSort()
    end
    item:addUIEvent("ImgClick", _clickMenuFun)
    table.insert(self.mMenuList, {
        obj = item,
        key = self:getMenuSortKey(false),
        typeList = sortTypeList,
        type = showSortType or sortTypeList[1],
        isOpen = isOpenSubMenu,
        updateMenuStyle = _updateMenuStyle
    })
    _updateMenuStyle()

    -- 排序菜单右侧的箭头按钮
    self.mSortDescending = isDescending
    local item = SimpleInsItem:create(self.mMenuSort, self.mGroupMenu, self.__cname .. "_self.mMenuSort")
    local goUp = item:getChildGO("ImgSortUp")
    local goDown = item:getChildGO("ImgSortDown")
    item:getChildGO("ImageBg"):GetComponent(ty.Image).color =
        isLitleView and gs.ColorUtil.GetColor("202226ff") or gs.ColorUtil.GetColor("ffffffff")
    goUp:GetComponent(ty.Image).color = isLitleView and gs.ColorUtil.GetColor("202226ff") or
                                            gs.ColorUtil.GetColor("ffffffff")
    goDown:GetComponent(ty.Image).color = isLitleView and gs.ColorUtil.GetColor("202226ff") or
                                              gs.ColorUtil.GetColor("ffffffff")
    local function _updateMenuStyle()
        goUp:SetActive(not self.mSortDescending)
        goDown:SetActive(self.mSortDescending)
    end

    local function _clickBtnSortFun()
        self.mSortDescending = not self.mSortDescending
        _updateMenuStyle()
        self:__callFun()
    end
    item:addUIEvent("ImgClick", _clickBtnSortFun)
    table.insert(self.mMenuList, {
        obj = item,
        key = self:getMenuSortKey(true),
        typeList = nil,
        type = nil,
        isOpen = false,
        updateMenuStyle = nil
    })
    _updateMenuStyle()
end

function __updateSubMenuSort(self)
    local data = self:getSimpleItem(self:getMenuSortKey(false))
    if (data.isOpen) then
        local subMenu = SimpleInsItem:create(self.mSubMenuCommon, data.obj:getChildTrans("NodeCommon"),
            self.__cname .. "_self.mSubMenuCommon")
        for i = 1, #data.typeList do
            local type = data.typeList[i]
            if (type ~= bag.BagSortType.ID) then
                local item = SimpleInsItem:create(subMenu:getChildGO("BtnCommon"), subMenu:getTrans(),
                    self.__cname .. "_BtnCommon")
                local goImgSelect = item:getChildGO("ImgSelect")
                local goTextSelect = item:getChildGO("TextSelect")
                local textSelect = goTextSelect:GetComponent(ty.Text)
                local goTextUnSelect = item:getChildGO("TextUnSelect")
                local textUnSelect = goTextUnSelect:GetComponent(ty.Text)
                local goImgIcon = item:getChildGO("ImgIcon")
                local imgIcon = goImgIcon:GetComponent(ty.AutoRefImage)
                goImgIcon:SetActive(false)
                if (type == data.type) then
                    goImgSelect:SetActive(true)
                    goTextSelect:SetActive(true)
                    goTextUnSelect:SetActive(false)
                    textSelect.text = showBoard.getSortTypeName(type)
                else
                    goImgSelect:SetActive(false)
                    goTextSelect:SetActive(false)
                    goTextUnSelect:SetActive(true)
                    textUnSelect.text = showBoard.getSortTypeName(type)
                end

                local function _clickSubMenuItemFun()
                    self:__resetAllSubMenu()
                    if (data.type ~= type) then
                        data.type = type
                        data.updateMenuStyle()
                        self:__callFun()
                    end
                end
                item:addUIEvent("ImgClick", _clickSubMenuItemFun)
                table.insert(self.mMenuList, {
                    obj = item,
                    key = self:getSubMenuSortKey(false)
                })
            end
        end
        table.insert(self.mMenuList, {
            obj = subMenu,
            key = self:getSubMenuSortKey(true)
        })
    end
end

-- 添加筛选专用菜单
function addFilterMenu(self, panelFilterTypeList, panelFilterTypeDic, selectFilterTypeDic, isLike, isLock,
    isOpenSubMenu, isLitleView)
    self:__resetAllSubMenu()
    self:__recoverMenuList(self:getMenuFilterKey())

    local tempSelectFilterTypeDic = {}
    for _type, _subTypeDic in pairs(selectFilterTypeDic) do
        if (not tempSelectFilterTypeDic[_type]) then
            tempSelectFilterTypeDic[_type] = {}
        end
        for _subType, bool in pairs(_subTypeDic) do
            tempSelectFilterTypeDic[_type][_subType] = bool
        end
    end

    -- 筛选菜单按钮
    local item = SimpleInsItem:create(self.mMenuCommon, self.mGroupMenu, self.__cname .. "_self.mMenuCommon")
    item:getChildGO("mImgMenuBgRoll"):SetActive(true)
    item:getChildGO("mImgMenuBgRect"):SetActive(false)
    local text = item:getChildGO("Text"):GetComponent(ty.Text)
    local goUp = item:getChildGO("ImgUp")
    local goDown = item:getChildGO("ImgDown")
    local goImgIcon = item:getChildGO("ImgIcon")
    local imgIcon = goImgIcon:GetComponent(ty.AutoRefImage)
    item:getChildGO("mImgMenuBgRoll"):GetComponent(ty.AutoRefImage).color = isLitleView and
                                                                                gs.ColorUtil.GetColor("16172Bff") or
                                                                                gs.ColorUtil.GetColor("ffffffff")
    text.color = isLitleView and gs.ColorUtil.GetColor("202226ff") or gs.ColorUtil.GetColor("ffffffff")
    imgIcon.color = isLitleView and gs.ColorUtil.GetColor("202226ff") or gs.ColorUtil.GetColor("ffffffff")
    local function _updateMenuStyle()
        local data = self:getSimpleItem(self:getMenuFilterKey())
        text.text = _TT(1001) -- "筛选"
        goUp:SetActive(data.isOpen)
        goDown:SetActive(not data.isOpen)
        goImgIcon:SetActive(true)

        -- UE说这里不要显示上下箭头了
        goUp:SetActive(false)
        goDown:SetActive(false)

        self:__setIsOpen(data.isOpen)
    end

    local function _clickMenuFun()
        local data = self:getSimpleItem(self:getMenuFilterKey())
        local isOpen = data.isOpen
        self:__resetAllSubMenu()
        data.isOpen = not isOpen
        data.isFirstTime = true
        _updateMenuStyle()
        self:__updateSubMenuFilter()
    end
    item:addUIEvent("ImgClick", _clickMenuFun)
    table.insert(self.mMenuList, {
        obj = item,
        key = self:getMenuFilterKey(),
        typeList = panelFilterTypeList,
        typeDic = panelFilterTypeDic,
        selectTypeDic = selectFilterTypeDic,
        tempSelectTypeDic = tempSelectFilterTypeDic,
        isLike = isLike,
        isLock = isLock,
        isOpen = isOpenSubMenu,
        isFirstTime = true,
        updateMenuStyle = _updateMenuStyle
    })
    _updateMenuStyle()
end

function __updateSubMenuFilter(self)
    local data = self:getSimpleItem(self:getMenuFilterKey())
    if (data.isOpen) then
        local subMenu = SimpleInsItem:create(self.mSubMenuFilter, data.obj:getChildTrans("NodeFilter"),
            self.__cname .. "_self.mSubMenuSuit")
        if data.isFirstTime then
            local go = subMenu:getGo()
            if go then
                local tweenComponent = go:GetComponent(ty.UIDoTween)
                if tweenComponent and  not gs.GoUtil.IsCompNull(tweenComponent) then
                    tweenComponent:BeginTween()
                    data.isFirstTime=false
                end
            end
        end
        for i = 1, #data.typeList do
            local type = data.typeList[i]
            local filterItem = nil
            -- if (type == showBoard.panelFilterType.DEFINE_TYPE) then
            --     filterItem = SimpleInsItem:create(subMenu:getChildGO("FilterDefineParentItem"),
            --         subMenu:getChildTrans("GroupFilter"), self.__cname .. "_FilterDefineParentItem")
            --     filterItem:getChildGO("TextTitleFilter"):GetComponent(ty.Text).text = showBoard.getFilterTypeName(type)
            -- else
                filterItem = SimpleInsItem:create(subMenu:getChildGO("FilterNormalParentItem"),
                    subMenu:getChildTrans("GroupFilter"), self.__cname .. "_FilterNormalParentItem")
                filterItem:getChildGO("TextTitleFilter"):GetComponent(ty.Text).text = showBoard.getFilterTypeName(type)
            --end
            local subTypeList = data.typeDic[type]
            for j = 1, #subTypeList do
                local subType = subTypeList[j]
                local filterTypeItem = nil
                if (type == showBoard.panelFilterType.COLOR) then
                    filterTypeItem = SimpleInsItem:create(subMenu:getChildGO("FilterColorItem"),
                        filterItem:getChildTrans("ContentFilter"), self.__cname .. "_FilterColorItem")
                elseif (type == showBoard.panelFilterType.STAR_LVL) then
                    filterTypeItem = SimpleInsItem:create(subMenu:getChildGO("FilterColorItem"),
                        filterItem:getChildTrans("ContentFilter"), self.__cname .. "_FilterStarLvItem")
                elseif (type == showBoard.panelFilterType.PROFESSION) then
                    filterTypeItem = SimpleInsItem:create(subMenu:getChildGO("FilterJobItem"),
                        filterItem:getChildTrans("ContentFilter"), self.__cname .. "_FilterJobItem")
                    local url = showBoard.getFilterSubTypeIcon(type, subType)
                    local mImgFilterIcon = filterTypeItem:getChildGO("ImgFilterIcon")
                    if mImgFilterIcon then
                        if url ~= nil then
                            mImgFilterIcon:SetActive(true)
                            mImgFilterIcon:GetComponent(ty.AutoRefImage):SetImg(url, false)
                        else
                            mImgFilterIcon:SetActive(false)
                        end
                    end
                elseif (type == showBoard.panelFilterType.DEFINE_TYPE) then
                    filterTypeItem = SimpleInsItem:create(subMenu:getChildGO("FilterDefineItem"),
                        filterItem:getChildTrans("ContentFilter"), self.__cname .. "_FilterDefineItem")
                    local mImgFilterIcon = filterTypeItem:getChildGO("ImgFilterIcon")
                    if mImgFilterIcon then
                        mImgFilterIcon:SetActive(false)
                    end
                elseif (type == showBoard.panelFilterType.ELEMENT) then
                    filterTypeItem = SimpleInsItem:create(subMenu:getChildGO("FilterDefineItem"),
                        filterItem:getChildTrans("ContentFilter"), self.__cname .. "_FilterElementItem")
                    local mImgFilterIcon = filterTypeItem:getChildGO("ImgFilterIcon")
                    local url = showBoard.getFilterSubTypeIcon(type, subType)
                    if mImgFilterIcon then
                        if url then
                            mImgFilterIcon:SetActive(true)
                            mImgFilterIcon:GetComponent(ty.AutoRefImage):SetImg(url, false)
                        else
                            mImgFilterIcon:SetActive(false)
                        end
                    end
                    if subType ~= showBoard.filterSubTypeAll then
                        local color, _ = hero.getHeroTypeName(subType)
                        filterTypeItem:getChildGO("TextFilterTypeNormal"):GetComponent(ty.Text).color = gs.ColorUtil
                                                                                                            .GetColor(
                            color)
                    else
                        filterTypeItem:getChildGO("TextFilterTypeNormal"):GetComponent(ty.Text).color = gs.ColorUtil
                                                                                                            .GetColor(
                            "ffffffff")
                    end
                end
                if not data.tempSelectTypeDic[type] then
                    logError("==============aaaaa",type,table.nums(data.tempSelectTypeDic))
                end
                -- data.tempSelectTypeDic[type] and 
                if (data.tempSelectTypeDic[type] and data.tempSelectTypeDic[type][subType]) then
                    -- filterTypeItem:getChildGO("ImgFilterTypeNormal"):SetActive(false)
                    filterTypeItem:getChildGO("ImgFilterTypeSelect"):SetActive(true)
                    filterTypeItem:getChildGO("TextFilterTypeNormal"):GetComponent(ty.Text).text =
                        showBoard.getFilterSubTypeName(type, subType)
                    -- filterTypeItem:getChildGO("TextFilterTypeSelect"):GetComponent(ty.Text).text = ""
                else
                    -- filterTypeItem:getChildGO("ImgFilterTypeNormal"):SetActive(true)
                    filterTypeItem:getChildGO("ImgFilterTypeSelect"):SetActive(false)
                    filterTypeItem:getChildGO("TextFilterTypeNormal"):GetComponent(ty.Text).text =
                        showBoard.getFilterSubTypeName(type, subType)
                    -- filterTypeItem:getChildGO("TextFilterTypeSelect"):GetComponent(ty.Text).text = ""
                end

                local function _clickFilterTypeItemFun()
                    local allSubType = showBoard.filterSubTypeAll
                    local subTypeDic = data.tempSelectTypeDic[type]
                    if (subType == allSubType) then
                        for subType, data in pairs(subTypeDic) do
                            subTypeDic[subType] = nil
                        end
                        subTypeDic[subType] = true
                    else
                        if (subTypeDic[subType]) then
                            subTypeDic[subType] = nil

                            local isSelectAll = true
                            for subType, data in pairs(subTypeDic) do
                                if (data) then
                                    isSelectAll = nil
                                    break
                                end
                            end
                            subTypeDic[allSubType] = isSelectAll
                        else
                            subTypeDic[subType] = true
                            subTypeDic[allSubType] = nil
                        end
                    end
                    self:__recoverMenuList(self:getSubMenuFilterKey(false))
                    self:__recoverMenuList(self:getSubMenuFilterKey(true))
                    self:__updateSubMenuFilter()
                end
                filterTypeItem:addUIEvent("ImgClick", _clickFilterTypeItemFun)

                table.insert(self.mMenuList, {
                    obj = filterTypeItem,
                    key = self:getSubMenuFilterKey(false)
                })
            end
            table.insert(self.mMenuList, {
                obj = filterItem,
                key = self:getSubMenuFilterKey(false)
            })
        end
        subMenu:getChildGO("TextFilterReset"):GetComponent(ty.Text).text = _TT(1344)
        subMenu:getChildGO("TextFilterConfirm"):GetComponent(ty.Text).text = _TT(1)
        local function _onClickFilterConfirmHandler()
            data.selectTypeDic = {}
            for _type, _subTypeDic in pairs(data.tempSelectTypeDic) do
                if (not data.selectTypeDic[_type]) then
                    data.selectTypeDic[_type] = {}
                end
                for _subType, bool in pairs(_subTypeDic) do
                    data.selectTypeDic[_type][_subType] = bool
                end
            end
            data.tempSelectTypeDic = {}

            self:__resetAllSubMenu()
            data.updateMenuStyle()
            self:__callFun()
        end
        local function _onClickFilterResetHandler()
            data.tempSelectTypeDic = {}
            for i = 1, #data.typeList do
                local _type = data.typeList[i]
                data.tempSelectTypeDic[_type] = {}
                data.tempSelectTypeDic[_type][showBoard.filterSubTypeAll] = true
            end
            data.isLike = false
            data.isLock = false
            self:__recoverMenuList(self:getSubMenuFilterKey(false))
            self:__recoverMenuList(self:getSubMenuFilterKey(true))
            self:__updateSubMenuFilter()
            --self:__callFun()
            --self:__resetAllSubMenu()
            --data.updateMenuStyle()
            --self:__callFun()
            _onClickFilterConfirmHandler()
        end
        
        self:addOnClick(subMenu:getChildGO("BtnReset"), _onClickFilterResetHandler)
        self:addOnClick(subMenu:getChildGO("BtnConfirm"), _onClickFilterConfirmHandler)
        table.insert(self.mMenuList, {
            obj = subMenu,
            key = self:getSubMenuFilterKey(true)
        })
    end
end

function getSimpleItem(self, key)
    for i = #self.mMenuList, 1, -1 do
        if (self.mMenuList[i].key == key) then
            return self.mMenuList[i]
        end
    end
end
-- 排序
function getMenuSortKey(self, isRightBtn)
    return isRightBtn and "btn_sort" or "menu_sort"
end
function getSubMenuSortKey(self, isMenu)
    return isMenu and "sub_menu_sort" or "sub_menu_item_sort"
end
-- 筛选
function getMenuFilterKey(self)
    return "menu_filter"
end
function getSubMenuFilterKey(self, isMenu)
    return isMenu and "sub_menu_filter" or "sub_menu_item_filter"
end

function __recoverMenuList(self, key)
    for i = #self.mMenuList, 1, -1 do
        if (key) then
            if (self.mMenuList[i].key == key) then
                self.mMenuList[i].obj:recover()
                table.remove(self.mMenuList, i)
            end
        else
            self.mMenuList[i].obj:recover()
            table.remove(self.mMenuList, i)
        end
    end
end

function __callFun(self)
    if (self.m_callFun and self.m_callObj) then
        -- 调用外部处理
        if self.m_params then
            self.m_callFun(self.m_callObj, unpack(self.m_params))
        else
            self.m_callFun(self.m_callObj)
        end
    end
end

function getIsDescending(self)
    return self.mSortDescending
end

function getIsFilterSame(self)
    return self.mIsFilterSame
end

function getIsShowAll(self)
    return self.mIsShowAll
end

function getIsShowRed(self)
    return self.mIsShowRed
end

function getIsFilterUseState(self)
    return self.mIsFilterUseState
end

-- 获取排序的类型列表
function getSortTypeList(self)
    local data = self:getSimpleItem(self:getMenuSortKey(false))
    local sortTypeList = {}
    for i = 1, #data.typeList do
        local type = data.typeList[i]
        if (type == data.type) then
            table.insert(sortTypeList, 1, type)
        else
            table.insert(sortTypeList, type)
        end
    end
    return sortTypeList
end

-- 获取排序的类型
function getSortFilterType(self)
    local data = self:getSimpleItem(self:getMenuSortKey(false))
    return data and data.type or nil
end

-- 获取筛选类型
function getSearchFilterDic(self)
    local data = self:getSimpleItem(self:getMenuFilterKey(false))
    return data and data.selectTypeDic or nil
end

-- 获取是否筛选喜欢
function getIsLike(self)
    local data = self:getSimpleItem(self:getMenuFilterKey(false))
    return data and data.isLike or false
end

-- 获取是否筛选锁定
function getIsLock(self)
    local data = self:getSimpleItem(self:getMenuFilterKey(false))
    return data and data.isLock or false
end

function destroy(self)
    self:setFilterSame(false)
    self:setShowAll(false)
    if self.mGoShowRed then 
        self:setShowRed(false)
    end
    self:removeOnClick(self.mGoToucher)
    self:resetAll()
    gs.GameObject.Destroy(self.m_uiGo)
    self.m_uiGo = nil
end

function resetAll(self)
    self:__resetAllSubMenu()
    self:__resetAllMenu()
    self:__initData()
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(1344):	"重置选择"
	语言包: _TT(1343):	"过滤相同战员"
	语言包: _TT(1342):	"显示全部战员"
	语言包: _TT(1):	"确定"
]]
