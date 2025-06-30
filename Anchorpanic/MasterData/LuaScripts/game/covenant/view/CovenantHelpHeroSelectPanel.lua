--[[   
     盟约助手助力英雄选择界面
]]
module("covenant.CovenantHelpHeroSelectPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("covenant/CovenantHelpHeroSelectPanel.prefab")
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1169, 558)
    self:initData()
end

-- 初始化数据
function initData(self)
    self.m_helperId = nil
    self.m_pos = nil
    self.m_heroId = nil

    -- 是否显示排序界面
    self.m_isShowSort = false
    self.m_isDescending = true
    self.m_tempIsDescending = true
    self.m_selectSortType = showBoard.panelSortType.LEVEL
    self.m_tempSelectSortType = self.m_selectSortType
    self.m_selectFilterDic = {}
    self.m_tempSelectFilterDic = {}
    for type in pairs(showBoard.panelFilterTypeDic) do
        self.m_selectFilterDic[type] = {}
        self.m_selectFilterDic[type][showBoard.filterSubTypeAll] = true
        self.m_tempSelectFilterDic[type] = {}
        self.m_tempSelectFilterDic[type][showBoard.filterSubTypeAll] = true
    end
end

-- 初始化
function configUI(self)
    self.m_scrollerSelect = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.m_scrollerSelect:SetItemRender(self:__getHeadSelectItem())

    self.m_imgTitle = self:getChildGO("ImgTitle")
    self.m_groupSort = self:getChildGO("GroupSort")
    self.m_transGroupSort = self:getChildTrans("ContentSort")
    self.m_transGroupFilter = self:getChildTrans("GroupFilter")
    -- self.m_textTitleSort = self:getChildGO("TextTitleSort"):GetComponent(ty.Text)
    -- self.m_textTitleFilter = self:getChildGO("TextTitleFilter"):GetComponent(ty.Text)
    self.m_btnCancel = self:getChildGO("BtnCancel")
    self.m_btnConfirm = self:getChildGO("BtnConfirm")
    self.m_btnFilter = self:getChildGO("BtnFilter")
end

-- 激活
function active(self, args)
    super.active(self, args)
    covenant.CovenantManager:addEventListener(covenant.CovenantManager.COVENANT_HELP_HERO_SELECT, self.__onHeroSelectHandler, self)

    self:setData(args, true)
    self:__updateSortView()
    self:__updateFilterView()
end

-- 非激活
function deActive(self)
    super.deActive(self)
    covenant.CovenantManager:removeEventListener(covenant.CovenantManager.COVENANT_HELP_HERO_SELECT, self.__onHeroSelectHandler, self)
    self:__playerClose()
end

function initViewText(self)
    self:setBtnLabel(self.m_btnCancel, 2, "取消")
    self:setBtnLabel(self.m_btnConfirm, 1, "确定")
    self:setBtnLabel(self.m_btnFilter, 1001, "筛选")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.m_btnFilter, self.__onOpenSortViewHandler)
    self:addUIEvent(self.m_btnCancel, self.__onClickCancelHandler)
    self:addUIEvent(self.m_btnConfirm, self.__onClickConfirmHandler)
end

function __playerClose(self)
    self.m_isShowSort = false
    self.m_groupSort:SetActive(self.m_isShowSort)
    self.m_imgTitle:SetActive(not self.m_isShowSort)
    -- self.m_scrollerSelect.gameObject:SetActive(not self.m_isShowSort)
    gs.TransQuick:LPosX(self.m_scrollerSelect.transform, self.m_isShowSort and 2000 or 10)

    -- self:initData()
end

function __getHeadSelectItem(self)
    return covenant.CovenantHelpHeroSelectItem
end

-- 点击排序状态按钮
function __onOpenSortViewHandler(self)
    self.m_isShowSort = not self.m_isShowSort
    self.m_groupSort:SetActive(self.m_isShowSort)
    self.m_imgTitle:SetActive(not self.m_isShowSort)
    -- self.m_scrollerSelect.gameObject:SetActive(not self.m_isShowSort)
    gs.TransQuick:LPosX(self.m_scrollerSelect.transform, self.m_isShowSort and 2000 or 10)
end

-- 取消
function __onClickCancelHandler(self)
    self.m_isShowSort = false
    self.m_groupSort:SetActive(self.m_isShowSort)
    self.m_imgTitle:SetActive(not self.m_isShowSort)
    -- self.m_scrollerSelect.gameObject:SetActive(not self.m_isShowSort)
    gs.TransQuick:LPosX(self.m_scrollerSelect.transform, self.m_isShowSort and 2000 or 10)

    self:setData(nil, false)
end

-- 确认
function __onClickConfirmHandler(self)
    self.m_isShowSort = false
    self.m_groupSort:SetActive(self.m_isShowSort)
    self.m_imgTitle:SetActive(not self.m_isShowSort)
    -- self.m_scrollerSelect.gameObject:SetActive(not self.m_isShowSort)
    gs.TransQuick:LPosX(self.m_scrollerSelect.transform, self.m_isShowSort and 2000 or 10)

    self.m_selectSortType = self.m_tempSelectSortType
    self.m_selectFilterDic = {}
    for type, dic in pairs(self.m_tempSelectFilterDic) do
        if (not self.m_selectFilterDic[type]) then
            self.m_selectFilterDic[type] = {}
        end
        for subType, data in pairs(dic) do
            self.m_selectFilterDic[type][subType] = data
        end
    end
    self.m_isDescending = self.m_tempIsDescending
    self:setData(nil, false)
end

function __onHeroSelectHandler(self, args)
    if(self.m_heroId == args.heroId)then
        -- 移除发0
        GameDispatcher:dispatchEvent(EventName.REQ_COVENANT_HELP_HERO_SELECT, {helperId = self.m_helperId, pos = self.m_pos, heroId = 0})
    else
        GameDispatcher:dispatchEvent(EventName.REQ_COVENANT_HELP_HERO_SELECT, {helperId = self.m_helperId, pos = self.m_pos, heroId = args.heroId})
    end
    self:close()
end

function setData(self, cusData, isInit)
    if cusData then
        self.m_helperId = cusData.helperId
        self.m_pos = cusData.pos
        self.m_heroId = cusData.heroId
    end

    self:recoverListData(self.m_scrollerSelect.DataProvider)
    local scrollList = self:getDataList()
    if isInit then
        self.m_scrollerSelect.DataProvider = scrollList
    else
        self.m_scrollerSelect:ReplaceAllDataProvider(scrollList)
    end
end

function getDataList(self)
    local scrollList = {}
    local helpedList = {}
    local heroList, idDic = showBoard.ShowBoardManager:getHeroScrollList(nil, self.m_selectSortType, self.m_isDescending, self.m_selectFilterDic)
    local showRemoveVo = nil
    for i = 1, #heroList do
        local heroVo = heroList[i]:getDataVo()
        local isShowRemove = false
        if (self.m_heroId == heroVo.id) then
            isShowRemove = true
        end
        local scrollVo = LuaPoolMgr:poolGet(LyScrollerSelectVo)
        scrollVo:setDataVo({ helperId = self.m_helperId, pos = self.m_pos, heroVo = heroVo, isShowRemove = isShowRemove})
        if (isShowRemove) then
            showRemoveVo = scrollVo
        else
            if (heroVo.covanantHelperId ~= 0) then
                table.insert(helpedList, scrollVo)
            else
                table.insert(scrollList, scrollVo)
            end
        end
    end
    for i, v in ipairs(scrollList) do
        table.insert(helpedList, v)
    end
    
    scrollList = helpedList

    if (showRemoveVo) then
        table.insert(scrollList, 1, showRemoveVo)
    end

    return scrollList
end

function recoverListData(self, list)
    if (list and #list > 0) then
        for i, v in ipairs(list) do
            LuaPoolMgr:poolRecover(v)
        end
    end
end

-----------------------------------------------------------------------------排序界面相关杂七杂八---------------------------------------------------------------------------
function __updateSortView(self)
    self:__recoverBtnSortGoDic()
    for i = 1, #showBoard.panelSortTypeList do
        local type = showBoard.panelSortTypeList[i]
        local sortTypeItem = self:__getBtnSortGo("SortTypeItem", type)
        sortTypeItem.transform:SetParent(self.m_transGroupSort, false)
        local childGos, childTrans = GoUtil.GetChildHash(sortTypeItem)
        childTrans["TextSortType_1"]:GetComponent(ty.Text).text = showBoard.getSortTypeName(type)
        childTrans["TextSortType_2"]:GetComponent(ty.Text).text = showBoard.getSortTypeName(type)
        if (self.m_tempSelectSortType == type) then
            childGos["ImgSortTypeNormal"]:SetActive(false)
            childGos["ImgSortTypeSelect"]:SetActive(true)
            childGos["ImgUp"]:SetActive(not self.m_tempIsDescending)
            childGos["ImgDown"]:SetActive(self.m_tempIsDescending)
        else
            childGos["ImgSortTypeNormal"]:SetActive(true)
            childGos["ImgSortTypeSelect"]:SetActive(false)
        end
    end
end

function __updateFilterView(self)
    self:__recoverFilterTypeGoDic()
    self:__recoverGroupFilterGoDic()
    for i = 1, #showBoard.panelFilterTypeList do
        local type = showBoard.panelFilterTypeList[i]
        local filterItem = self:__getGroupFilterGo("FilterItem")
        filterItem.transform:SetParent(self.m_transGroupFilter, false)
        local childGos, childTrans = GoUtil.GetChildHash(filterItem)
        childTrans["TextTitleFilter"]:GetComponent(ty.Text).text = showBoard.getFilterTypeName(type)

        local subTypeList = showBoard.panelFilterTypeDic[type]
        for j = 1, #subTypeList do
            local subType = subTypeList[j]
            local filterTypeItem = self:__getFilterTypeGo("FilterTypeItem", type, subType)
            filterTypeItem.transform:SetParent(childTrans["ContentFilter"], false)
            local typeChildGos, typeChildTrans = GoUtil.GetChildHash(filterTypeItem)

            if (self.m_tempSelectFilterDic[type][subType]) then
                typeChildGos["ImgFilterTypeNormal"]:SetActive(false)
                typeChildGos["ImgFilterTypeSelect"]:SetActive(true)
                typeChildTrans["TextFilterTypeNormal"]:GetComponent(ty.Text).text = ""
                typeChildTrans["TextFilterTypeSelect"]:GetComponent(ty.Text).text = showBoard.getFilterSubTypeName(type, subType)
            else
                typeChildGos["ImgFilterTypeNormal"]:SetActive(true)
                typeChildGos["ImgFilterTypeSelect"]:SetActive(false)
                typeChildTrans["TextFilterTypeNormal"]:GetComponent(ty.Text).text = showBoard.getFilterSubTypeName(type, subType)
                typeChildTrans["TextFilterTypeSelect"]:GetComponent(ty.Text).text = ""
            end
        end
    end
end

function __getGoUniqueName(self, goName)
    return self.__cname .. "_" .. goName
end

function __getGroupFilterGo(self, goName)
    local uniqueName = self:__getGoUniqueName(goName)
    local go = gs.GOPoolMgr:GetOther(uniqueName)
    if (not go or gs.GoUtil.IsGoNull(go)) then
        go = gs.GameObject.Instantiate(self:getChildGO(goName))
    end
    go:SetActive(true)
    self.m_groupFilterGoDic[go:GetHashCode()] = { go = go, uniqueName = uniqueName }
    return go
end

function __recoverGroupFilterGoDic(self)
    if (self.m_groupFilterGoDic) then
        for hashCode, data in pairs(self.m_groupFilterGoDic) do
            gs.GOPoolMgr:RecoverOther(data.uniqueName, data.go)
        end
    end
    self.m_groupFilterGoDic = {}
end

function __getFilterTypeGo(self, goName, type, subType)
    local uniqueName = self:__getGoUniqueName(goName)
    local go = gs.GOPoolMgr:GetOther(uniqueName)
    if (not go or gs.GoUtil.IsGoNull(go)) then
        go = gs.GameObject.Instantiate(self:getChildGO(goName))
    end
    go:SetActive(true)
    self:addOnClick(go, self.__onClickFilterTypeHandler, nil, go)
    self.m_filterTypeGoDic[go:GetHashCode()] = { go = go, uniqueName = uniqueName, type = type, subType = subType }
    return go
end

function __recoverFilterTypeGoDic(self)
    if (self.m_filterTypeGoDic) then
        for hashCode, data in pairs(self.m_filterTypeGoDic) do
            self:removeOnClick(data.go, self.__onClickFilterTypeHandler)
            gs.GOPoolMgr:RecoverOther(data.uniqueName, data.go)
        end
    end
    self.m_filterTypeGoDic = {}
end

function __getBtnSortGo(self, goName, type)
    local uniqueName = self:__getGoUniqueName(goName)
    local go = gs.GOPoolMgr:GetOther(uniqueName)
    if (not go or gs.GoUtil.IsGoNull(go)) then
        go = gs.GameObject.Instantiate(self:getChildGO(goName))
    end
    go:SetActive(true)
    self:addOnClick(go, self.__onClickSortTypeHandler, nil, go)
    self.m_btnSortGoDic[go:GetHashCode()] = { go = go, uniqueName = uniqueName, type = type }
    return go
end

function __recoverBtnSortGoDic(self)
    if (self.m_btnSortGoDic) then
        for hashCode, data in pairs(self.m_btnSortGoDic) do
            self:removeOnClick(data.go, self.__onClickSortTypeHandler)
            gs.GOPoolMgr:RecoverOther(data.uniqueName, data.go)
        end
    end
    self.m_btnSortGoDic = {}
end

-- 点击具体的排序项
function __onClickSortTypeHandler(self, btnGo)
    local data = self.m_btnSortGoDic[btnGo:GetHashCode()]
    if (self.m_tempSelectSortType == data.type) then
        self.m_tempIsDescending = not self.m_tempIsDescending
    else
        self.m_tempIsDescending = true
    end
    self.m_tempSelectSortType = data.type
    self.m_selectSortType = self.m_tempSelectSortType
    self.m_isDescending = self.m_tempIsDescending
    self:__updateSortView()
    self:setData(nil, false)
end

-- 点击具体的过滤项
function __onClickFilterTypeHandler(self, btnGo)
    local data = self.m_filterTypeGoDic[btnGo:GetHashCode()]
    local allSubType = showBoard.filterSubTypeAll
    local subTypeDic = self.m_tempSelectFilterDic[data.type]
    if (data.subType == allSubType) then
        for subType, data in pairs(subTypeDic) do
            subTypeDic[subType] = nil
        end
        subTypeDic[data.subType] = true
    else
        if (subTypeDic[data.subType]) then
            subTypeDic[data.subType] = nil

            local isSelectAll = true
            for subType, data in pairs(subTypeDic) do
                if (data) then
                    isSelectAll = nil
                    break
                end
            end
            subTypeDic[allSubType] = isSelectAll
        else
            subTypeDic[data.subType] = true
            subTypeDic[allSubType] = nil
        end
    end
    self:__updateFilterView()
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
