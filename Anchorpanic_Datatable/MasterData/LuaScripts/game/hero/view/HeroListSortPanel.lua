module("hero.HeroListSortPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("hero/HeroListSortPanel.prefab")
destroyTime = -1 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
end

function configUI(self)
    self.m_transGroupSort = self:getChildTrans("ContentSort")
    self.m_transGroupFilter = self:getChildTrans("GroupFilter")
    self.m_textTitleSort = self:getChildGO("TextTitleSort"):GetComponent(ty.Text)
    self.m_textTitleFilter = self:getChildGO("TextTitleFilter"):GetComponent(ty.Text)
    self.m_btnCancel = self:getChildGO("BtnCancel")
    self.m_btnConfirm = self:getChildGO("BtnConfirm")
    self.mToggle = self:getChildGO("mToggle"):GetComponent(ty.Toggle)
end

function active(self, args)
    super.active(self, args)
    self:setData(args)
end

function deActive(self)
    super.deActive(self)
end

function initViewText(self)
    self.m_textTitleSort.text = _TT(1002) --"排序"
    self.m_textTitleFilter.text = _TT(1001)--"筛选"
    self:setBtnLabel(self.m_btnCancel, 2, "取消")
    self:setBtnLabel(self.m_btnConfirm, 1, "确定")
end

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self.m_btnCancel, self.__onClickCancelHandler)
    self:addUIEvent(self.m_btnConfirm, self.__onClickConfirmHandler)
end

-- 取消
function __onClickCancelHandler(self)
    -- self.m_isShowSort = false
    -- self:setData(false)
    self.m_cancelCallFun()
end

-- 确认
function __onClickConfirmHandler(self)
    -- self.m_isShowSort = false
    -- self.m_selectSortType = self.m_tempSelectSortType
    -- self.m_selectFilterDic = {}
    -- for type, dic in pairs(self.m_tempSelectFilterDic) do
    --     if(not self.m_selectFilterDic[type])then
    --         self.m_selectFilterDic[type] = {}
    --     end
    --     for subType, data in pairs(dic) do
    --         self.m_selectFilterDic[type][subType] = data
    --     end
    -- end
    -- self.m_isDescending = self.m_tempIsDescending
    -- self:setData(true)
    self.m_confirmCallFun(self.m_tempSelectSortType, self.m_tempIsDescending, self.m_tempSelectFilterDic, self.mToggle.isOn)

    local state = self.mToggle.isOn and "1" or "0"
    hero.HeroManager:setFilterSameHero(state)
end

function setData(self, args)
    self.m_cancelCallFun = args.cancelCallFun
    self.m_confirmCallFun = args.confirmCallFun
    self.m_tempSelectFilterDic = args.tempSelectFilterDic
    self.m_tempSelectSortType = args.tempSelectSortType
    self.m_tempIsDescending = args.tempIsDescending
    self:__updateSortView()
    self:__updateFilterView()

    self.mToggle.isOn = hero.HeroManager:getFilterSameHero() == "1"
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
    self:__updateSortView()
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
