--[[ 
-----------------------------------------------------
@filename       : EquipStrengthenUpView
@Description    : 装备强化实际操作界面
@date           : 2021-01-12 17:11:22
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.equipBuild.view.EquipStrengthenUpView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("equipBuild/EquipStrengthenUpView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1169, 558)
end
--析构  
function dtor(self)
end

function initData(self)
    self.mList = {}

    -- 是否显示排序界面
    self.m_isShowSort = false
    self.m_isDescending = true
    self.m_tempIsDescending = true
    self.m_selectSortType = equipBuild.panelSortType.DEFAULT
    self.m_tempSelectSortType = self.m_selectSortType
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
end

-- 初始化
function configUI(self)
    -------------------------mGroupLeft--------------------------------
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtCurLv = self:getChildGO("mTxtCurLv"):GetComponent(ty.Text)
    self.mTxtMaxLv = self:getChildGO("mTxtMaxLv"):GetComponent(ty.Text)
    self.mTxtNextLv = self:getChildGO("mTxtNextLv"):GetComponent(ty.Text)
    self.mTxtExp = self:getChildGO("mTxtExp"):GetComponent(ty.Text)
    self.mTxtExpAdd = self:getChildGO("mTxtExpAdd"):GetComponent(ty.Text)
    self.mImgLvUpTips = self:getChildGO("mImgLvUpTips")
    self.mTxtLvUpTips = self:getChildGO("mTxtLvUpTips"):GetComponent(ty.Text)
    self.mProgressBar = self:getChildGO("ProgressBar"):GetComponent(ty.ProgressBar)
    self.mProgressBar:InitData(0)
    self.mPreBar = self:getChildTrans("Bar2")

    -------------------------mGroupSelect--------------------------------
    self.mGroupSelect = self:getChildGO("mGroupSelect")
    self.mBtnStrengthen = self:getChildGO("mBtnStrengthen")
    self.mBtnFast = self:getChildGO("mBtnFast")

    self.mLyScroller = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.mLyScroller:SetItemRender(equipBuild.EquipStrengthenSelectItem)

    self.m_imgStrengCostGo = self:getChildGO("ImgCostIcon_1")
    self.m_imgStrengCostIcon = self.m_imgStrengCostGo:GetComponent(ty.AutoRefImage)
    self.m_textStrengCost = self:getChildGO("TextCost_1"):GetComponent(ty.Text)

    self.mImgEmpty = self:getChildGO("mImgEmpty")
    -------------------------mGroupFilter--------------------------------
    self.m_btnFilter = self:getChildGO("BtnFilter")
    self.m_transGroupSort = self:getChildTrans("ContentSort")
    self.m_transGroupFilter = self:getChildTrans("GroupFilter")
    self.mGroupFilter = self:getChildGO("mGroupFilter")

    self.m_btnCancel = self:getChildGO("BtnCancel")
    self.m_btnConfirm = self:getChildGO("BtnConfirm")

end

--激活
function active(self, args)
    super.active(self, args)
    self.mEquipVo = args
    self.strengthenConfigVo = equipBuild.EquipStrengthenManager:getStrengthenConfigVo(self.mEquipVo.subType, self.mEquipVo.tid, self.mEquipVo.strengthenLvl)
    self.mMaxLv = equipBuild.EquipStrengthenManager:getMaxStrengthenLvl(self.mEquipVo.tid)
    self.mEquipVo:addEventListener(equip.EquipVo.UPDATE_EQUIP_DETAIL_DATA,self.updateView,self)
    equipBuild.EquipStrengthenManager:addEventListener(equipBuild.EquipStrengthenManager.EQUIP_STRENGTHEN_MATERIAL_SELECT, self.__onStrengthenMaterialSelectHandler, self)

    self:updateView()
    self:__updateSortView()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self.mProgressBar:SetValue(0, 0, false)
    equipBuild.EquipStrengthenManager:removeEventListener(equipBuild.EquipStrengthenManager.EQUIP_STRENGTHEN_MATERIAL_SELECT, self.__onStrengthenMaterialSelectHandler, self)
    if self.mEquipVo then
        self.mEquipVo:removeEventListener(equip.EquipVo.UPDATE_EQUIP_DETAIL_DATA,self.updateView,self)
        self.mEquipVo = nil
    end
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtTitle.text = _TT(4315)--"材料选择"
    -- self:setBtnLabel(self.aa, 10001, "按钮")
    self:setBtnLabel(self.m_btnCancel, 2, "取消")
    self:setBtnLabel(self.m_btnConfirm, 1, "确定")
    self:setBtnLabel(self.m_btnFilter, 4004, "芯片")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.m_btnFilter, self.__onOpenSortViewHandler)
    self:addUIEvent(self.m_btnCancel, self.__onClickCancelHandler)
    self:addUIEvent(self.m_btnConfirm, self.__onClickConfirmHandler)
    self:addUIEvent(self.mBtnStrengthen, self.onStrengthen)
    self:addUIEvent(self.mBtnFast, self.onClickFastAddHandler)
end

-- 点击筛选状态按钮
function __onOpenSortViewHandler(self)
    if self.m_isShowSort then
        return
    end
    self.m_isShowSort = not self.m_isShowSort
    self.mGroupFilter:SetActive(self.m_isShowSort)
    self.mGroupSelect:SetActive(not self.m_isShowSort)
    self.mImgEmpty:SetActive(false)

    self:__updateFilterView()
end

-- 取消
function __onClickCancelHandler(self)
    self.m_isShowSort = false
    self.mGroupFilter:SetActive(self.m_isShowSort)
    self.mGroupSelect:SetActive(not self.m_isShowSort)
    self:updateStrengthenView(false)
end

-- 确认
function __onClickConfirmHandler(self)
    self.m_isShowSort = false
    self.mGroupFilter:SetActive(self.m_isShowSort)
    self.mGroupSelect:SetActive(not self.m_isShowSort)
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

    self:updateStrengthenView(false)
end

function onStrengthen(self)
    if (#self.mEquipScrollerVoList <= 0) then
        -- gs.Message.Show("请先选择消耗材料")
        gs.Message.Show(_TT(4308))
    else
        local addExp, needMoneyCount, needMoneyTid = self:getSelectExpAndMoneyNum()
        
        if (MoneyUtil.judgeNeedMoneyCountByTid(needMoneyTid, needMoneyCount)) then
            local function onReqStrengthenHandler()
                local costList = {}
                for i = 1, #self.mEquipScrollerVoList do
                    table.insert(costList, { id = self.mEquipScrollerVoList[i]:getDataVo().id, count = self.mEquipScrollerVoList[i]:getArgs() })
                end
                GameDispatcher:dispatchEvent(EventName.REQ_EQUIP_STRENGTHEN, { heroId = self.mEquipVo.heroId, equipId = self.mEquipVo.id, costList = costList })
                self:close()
            end
            -- local isNotRemind = remind.RemindManager:isTodayNotRemain(RemindConst.EQUIP_STRENGTHEN)
            -- if (isNotRemind) then
            --     onReqStrengthenHandler()
            -- else
            local isNeedPopTip = false
            for i = 1, #self.mEquipScrollerVoList do
                if (self.mEquipScrollerVoList[i]:getDataVo().color >= ColorType.VIOLET) then
                    isNeedPopTip = true
                    break
                end
            end
            if (isNeedPopTip) then
                -- UIFactory:alertMessge("强化材料中包含了紫色及以上品质的芯片，是否继续强化？",
                UIFactory:alertMessge(_TT(4309),
                true, function() onReqStrengthenHandler() end, _TT(1), nil,
                true, function() end, _TT(2),
                _TT(5), nil, RemindConst.EQUIP_STRENGTHEN)
            else
                onReqStrengthenHandler()
            end
            -- end
        end
    end
end

function updateView(self)
    self:updateStrengthenView(true)
end

-- 更新强化界面
function updateStrengthenView(self, isInit)
    local equipId = self.mEquipVo.id
    if isInit then
        for i, v in ipairs(self.mList) do
            LuaPoolMgr:poolRecover(v)
        end
        self.mList = {}
        self.mList = equipBuild.EquipStrengthenManager:getPropsScrollList(UseEffectType.ADD_EQUIP_EXP, equipId)
    end
    local list = equipBuild.EquipStrengthenManager:getFilterList(self.mList, self.m_selectFilterDic)
    equipBuild.EquipStrengthenManager:sortHandler(list, self.m_selectSortType, self.m_isDescending)

    for i = 1, #list do
        local propsScrollVo = list[i]
        propsScrollVo:setSelect(false)
        local propsVo = propsScrollVo:getDataVo()
        for j = 1, #self.mEquipScrollerVoList do
            if (propsVo.id == self.mEquipScrollerVoList[j]:getDataVo().id) then
                propsScrollVo:setSelect(true)
                break
            end
        end
    end

    if isInit or self.mLyScroller.Count <= 0 then
        self.mLyScroller.DataProvider = list
    else
        self.mLyScroller:ReplaceAllDataProvider(list)
    end

    self.mImgEmpty:SetActive(#list <= 0)
    self.mGroupFilter:SetActive(self.m_isShowSort and #list > 0)
    self.mGroupSelect:SetActive(not self.m_isShowSort and #list > 0)

    self:updateTextView()
    self:__updateGuide(list)
end

function __updateGuide(self, scrollList)
    if(#scrollList > 0)then
        for i = 0, #scrollList - 1 do
            local equipVo = scrollList[i + 1]:getDataVo()
            local scrollItem = self.mLyScroller:GetItemLuaClsByIndex(i)
            -- 是否在显示列表内
            if(scrollItem) then
                if(self.mEquipVo.tid == 5071 and equipVo.tid == 8002)then
                    self:setGuideTrans("hero_equip_develop_strengthen_select_"..equipVo.tid, scrollItem:getTrans())
                end
            end
        end
    end
    if(self.mEquipVo.tid == 5071)then
        self:setGuideTrans("hero_equip_develop_strengthen_start_"..self.mEquipVo.tid, self.mBtnStrengthen.transform)
    end
end

function getScollerVo(self, propsId)
    for i = 1, #self.mEquipScrollerVoList do
        if (self.mEquipScrollerVoList[i]:getDataVo().id == propsId) then
            return self.mEquipScrollerVoList[i], i
        end
    end
end

-- 强化材料选择改变
function __onStrengthenMaterialSelectHandler(self, args)
    local sourceVo = args
    local clickPropsVo = sourceVo:getDataVo()
    local selectCount = sourceVo:getArgs()

    local equipId = self.mEquipVo.id
    local isAdd = true

    local selectVo, index = self:getScollerVo(clickPropsVo.id)
    if selectVo then
        if (clickPropsVo.type == PropsType.NORMAL and selectCount <= 0) or clickPropsVo.type == PropsType.EQUIP then
            selectVo:setArgs(selectCount)
            LuaPoolMgr:poolRecover(selectVo)
            table.remove(self.mEquipScrollerVoList, index)
        end
        isAdd = false
    end

    local _needExp = equipBuild.EquipStrengthenManager:getExpByStrengthLvl(self.mEquipVo, self.mEquipVo.strengthenLvl, self.mMaxLv)
    local addExp, needMoneyCount = self:getSelectExpAndMoneyNum()

    if not isAdd then
        if clickPropsVo.type == PropsType.NORMAL and selectCount > 0 then
            if selectCount > bag.BagManager:getPropsCountByTid(clickPropsVo.tid) then
                -- 恢复一个
                local count = selectCount - 1
                sourceVo:setArgs(count)
                if count <= 0 then
                    sourceVo:setSelect(false)
                end
            elseif (self.mEquipVo.strengthenExp + addExp < _needExp or selectCount < selectVo:getArgs()) then
                if selectVo then
                    selectVo:setArgs(selectCount)
                end
            else
                -- 恢复一个
                local count = selectCount - 1
                sourceVo:setArgs(count)
                if count <= 0 then
                    sourceVo:setSelect(false)
                end
                -- gs.Message.Show("已达经验上限")
                gs.Message.Show(_TT(4310))
            end
        end
    else
        if (self.mEquipVo.strengthenExp + addExp < _needExp) then
            local scrollVo = LuaPoolMgr:poolGet(LyScrollerSelectVo)
            scrollVo:setDataVo(clickPropsVo)
            scrollVo:setArgs(selectCount)
            scrollVo:setSelect(true)
            table.insert(self.mEquipScrollerVoList, scrollVo)
        else
            sourceVo:setArgs(0)
            sourceVo:setSelect(false)
            -- gs.Message.Show("已达经验上限")
            gs.Message.Show(_TT(4310))
        end
    end

    self:updateStrengthenView(false)
    self:updateTextView()
end

-- 获取当前已经选择的材料道具可以增加多少装备经验
function getSelectExpAndMoneyNum(self)
    local _addExp = 0
    local _needMoneyTid = 0
    local _needMoneyCount = 0
    for i = 1, #self.mEquipScrollerVoList do
        local propsVo = self.mEquipScrollerVoList[i]:getDataVo()
        local convertExp, needMoneyTid, needMoneyCount = equipBuild.EquipStrengthenManager:getConvertExp(propsVo)
        _addExp = _addExp + convertExp * self.mEquipScrollerVoList[i]:getArgs()
        _needMoneyTid = needMoneyTid
        _needMoneyCount = _needMoneyCount + needMoneyCount * self.mEquipScrollerVoList[i]:getArgs()
    end
    -- 动态增加的等级
    local _addLvl = 0
    local remaidExp = _addExp - (self.strengthenConfigVo.needExp - self.mEquipVo.strengthenExp)
    while (remaidExp > 0)
    do
        _addLvl = _addLvl + 1
        if self.mEquipVo.strengthenLvl + _addLvl < self.mMaxLv then
            local configVo = equipBuild.EquipStrengthenManager:getStrengthenConfigVo(self.mEquipVo.subType, self.mEquipVo.tid, self.mEquipVo.strengthenLvl + _addLvl)
            if configVo then
                remaidExp = remaidExp - configVo.needExp
            else
                remaidExp = 0
            end
        else
            remaidExp = 0
        end
    end
    return _addExp, _needMoneyCount, _needMoneyTid, _addLvl
end

-- 点击一键添加
function onClickFastAddHandler(self)
    local equipId = self.mEquipVo.id
    local scrollList = equipBuild.EquipStrengthenManager:getFilterList(self.mList, self.m_selectFilterDic)
    equipBuild.EquipStrengthenManager:sortHandler(scrollList, self.m_selectSortType, self.m_isDescending)

    if (scrollList and #scrollList > 0) then
        for i = 1, #scrollList do
            local selectVo, index = self:getScollerVo(scrollList[i]:getDataVo().id)
            if selectVo then
                selectVo:setArgs(0)
                selectVo:setSelect(false)
                LuaPoolMgr:poolRecover(selectVo)
                table.remove(self.mEquipScrollerVoList, index)
            end
        end

        self.mEquipScrollerVoList = {}
        local fastAddCountLimit = sysParam.SysParamManager:getValue(SysParamType.EQUIP_MATERIAL_AUTO_COUNT)
        local _addExp = 0
        local _needMoneyTid = 0
        local _needMoneyCount = 0
        local isEnough = false
        local _needExp = equipBuild.EquipStrengthenManager:getExpByStrengthLvl(self.mEquipVo, self.mEquipVo.strengthenLvl, self.mMaxLv)
        for i = 1, #scrollList do
            local propsVo = scrollList[i]:getDataVo()
            -- 判断数量不超上限
            if (i <= fastAddCountLimit) then
                local convertExp, needMoneyTid, needMoneyCount = equipBuild.EquipStrengthenManager:getConvertExp(propsVo)
                local needCount = 0
                for j = 1, propsVo.count do
                    needCount = j
                    _addExp = _addExp + convertExp
                    -- 满足满级的经验
                    if self.mEquipVo.strengthenExp + _addExp >= _needExp then
                        isEnough = true
                        break
                    end
                end
                scrollList[i]:setArgs(needCount)

                local scrollVo = LuaPoolMgr:poolGet(LyScrollerSelectVo)
                scrollVo:setDataVo(propsVo)
                scrollVo:setArgs(needCount)
                scrollVo:setSelect(true)
                table.insert(self.mEquipScrollerVoList, scrollVo)
            end
            if isEnough then
                break
            end
        end
        self:updateStrengthenView(false)
        self:updateTextView()
    else
        -- gs.Message.Show("无可选择的芯片")
        gs.Message.Show(_TT(4311))
    end
end

-- 更新数据显示
function updateTextView(self)
    local addExp, needMoneyCount, needMoneyTid, addLvl = self:getSelectExpAndMoneyNum()
    self.mTxtExp.text = "EXP:" .. self.mEquipVo.strengthenExp .. "/" .. self.strengthenConfigVo.needExp
    self.mTxtExpAdd.text = "+" .. addExp
    self.mTxtExpAdd.gameObject:SetActive(addExp > 0)
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mTxtExp.transform)

    -- 显示经验和等级变化
    self.mTxtCurLv.text = self.mEquipVo.strengthenLvl
    self.mTxtMaxLv.text = "/" .. self.mMaxLv
    self.mTxtNextLv.text = self.mEquipVo.strengthenLvl + addLvl
    self.mTxtNextLv.gameObject:SetActive(addLvl > 0)
    self.mImgLvUpTips:SetActive(addLvl > 0)
    self.mTxtLvUpTips.text = "+" .. addLvl
    self.mProgressBar:SetValue(self.mEquipVo.strengthenExp, self.strengthenConfigVo.needExp, false)
    gs.TransQuick:ScaleX(self.mPreBar, math.min(1, (addExp + self.mEquipVo.strengthenExp) / self.strengthenConfigVo.needExp))

    -- 强化消耗
    self.m_imgStrengCostIcon:SetImg(MoneyUtil.getMoneyIconUrlByTid(self.strengthenConfigVo.costMoneyTid), true)
    self.m_textStrengCost.text = needMoneyCount
    self.m_imgStrengCostGo:SetActive(needMoneyCount > 0)

    if needMoneyCount > 0 then
        self.m_textStrengCost.color = gs.ColorUtil.GetColor(MoneyUtil.judgeNeedMoneyCountByTid(needMoneyTid,needMoneyCount,false,false) and "FFFFFFFF" or "ed1941FF")
    end
end


-----------------------------------------------------------------------------排序界面相关杂七杂八---------------------------------------------------------------------------
function __updateSortView(self)
    self:__recoverBtnSortGoDic()
    for i = 1, #equipBuild.panelSortTypeList do
        local type = equipBuild.panelSortTypeList[i]
        local sortTypeItem = self:__getBtnSortGo("SortTypeItem", type)
        sortTypeItem.transform:SetParent(self.m_transGroupSort, false)
        local childGos, childTrans = GoUtil.GetChildHash(sortTypeItem)
        childTrans["TextSortType_1"]:GetComponent(ty.Text).text = equipBuild.getSortTypeName(type)
        childTrans["TextSortType_2"]:GetComponent(ty.Text).text = equipBuild.getSortTypeName(type)
        if (self.m_tempSelectSortType == type) then
            childGos["ImgSortTypeNormal"]:SetActive(false)
            childGos["ImgSortTypeSelect"]:SetActive(true)
            childGos["ImgUp"]:SetActive(not self.m_tempIsDescending)
            childGos["ImgDown"]:SetActive(self.m_tempIsDescending)
        else
            childGos["ImgSortTypeNormal"]:SetActive(true)
            childGos["ImgSortTypeSelect"]:SetActive(false)
        end
        if type == equipBuild.panelSortType.DEFAULT then
            childGos["ImgUp"]:SetActive(false)
            childGos["ImgDown"]:SetActive(false)
        end
    end
end

function __updateFilterView(self)
    self:__recoverFilterTypeGoDic()
    self:__recoverGroupFilterGoDic()
    for i = 1, #equipBuild.panelFilterTypeList do
        local type = equipBuild.panelFilterTypeList[i]
        local filterItem = self:__getGroupFilterGo("FilterItem")
        filterItem.transform:SetParent(self.m_transGroupFilter, false)
        local childGos, childTrans = GoUtil.GetChildHash(filterItem)
        childTrans["TextTitleFilter"]:GetComponent(ty.Text).text = equipBuild.getFilterTypeName(type)

        local subTypeList = equipBuild.panelFilterTypeDic[type]
        for j = 1, #subTypeList do
            local subType = subTypeList[j]
            local filterTypeItem = self:__getFilterTypeGo("FilterTypeItem", type, subType)
            filterTypeItem.transform:SetParent(childTrans["ContentFilter"], false)
            local typeChildGos, typeChildTrans = GoUtil.GetChildHash(filterTypeItem)

            if (self.m_tempSelectFilterDic[type][subType]) then
                typeChildGos["ImgFilterTypeNormal"]:SetActive(false)
                typeChildGos["ImgFilterTypeSelect"]:SetActive(true)
                typeChildTrans["TextFilterTypeNormal"]:GetComponent(ty.Text).text = ""
                typeChildTrans["TextFilterTypeSelect"]:GetComponent(ty.Text).text = equipBuild.getFilterSubTypeName(type, subType)
            else
                typeChildGos["ImgFilterTypeNormal"]:SetActive(true)
                typeChildGos["ImgFilterTypeSelect"]:SetActive(false)
                typeChildTrans["TextFilterTypeNormal"]:GetComponent(ty.Text).text = equipBuild.getFilterSubTypeName(type, subType)
                typeChildTrans["TextFilterTypeSelect"]:GetComponent(ty.Text).text = ""
            end

            gs.LayoutRebuilder.ForceRebuildLayoutImmediate(filterItem.transform)
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
        self.m_tempIsDescending = false
    end
    self.m_tempSelectSortType = data.type
    self.m_selectSortType = self.m_tempSelectSortType
    self.m_isDescending = self.m_tempIsDescending
    self:__updateSortView()
    self:updateStrengthenView(false)
end

-- 点击具体的过滤项
function __onClickFilterTypeHandler(self, btnGo)
    local data = self.m_filterTypeGoDic[btnGo:GetHashCode()]
    local allSubType = equipBuild.filterSubTypeAll
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
