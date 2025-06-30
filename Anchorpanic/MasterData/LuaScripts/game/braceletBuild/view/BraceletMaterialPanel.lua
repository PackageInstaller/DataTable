--[[   
     装备通用材料选择界面
]]
module('braceletBuild.BraceletMaterialPanel', Class.impl(View))
UIRes = UrlManager:getUIPrefabPath('braceletBuild/BraceletMaterialPanel.prefab')

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）
blurTweenTime = 0 --模糊背景的渐变时间（仅2弹窗面板有效，默认不渐变，单位秒）
isScreensave = 0 --是否使用黑屏过渡(仅1全屏UI有效，默认开启，0关闭)

--构造函数
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

    -- 是否显示排序界面
    self.m_isShowSort = false
    self.m_isDescending = false
    self.m_selectSortType = equipBuild.panelSortType.COLOR
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

function setMask(self)
    super.setMask(self)
    -- local trigger = self.mask:GetComponent(ty.LongPressOrClickEventTrigger)
    -- trigger:SetIsPassEvent(true)
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mBtnClose = self:getChildGO('BtnClose')
    self.mBtnConfirm = self:getChildGO('BtnConfirm')
    self.mImgCost = self:getChildGO("ImgCost"):GetComponent(ty.AutoRefImage)
    self.mTextCost = self:getChildGO("TextCost"):GetComponent(ty.Text)
    self.mFilterNode = self:getChildTrans('NodeFilter')
    self.mTextTip = self:getChildGO("TextTip"):GetComponent(ty.Text)
    self.mTextCountTip = self:getChildGO("TextCountTip"):GetComponent(ty.Text)
    self.mTextCount = self:getChildGO("TextCount"):GetComponent(ty.Text)

    self.mLyScroller = self:getChildGO('LyScroller'):GetComponent(ty.LyScroller)
    self.mLyScroller:SetItemRender(braceletBuild.BraceletMaterialItem)

    self.mImgEmpty = self:getChildGO('EmptyStateItem')
    self.mTextEmpty = self:getChildGO("mTxtEmptyTip"):GetComponent(ty.Text)

    self.m_btnFilter = self:getChildGO("BtnFilter")
    self.m_transGroupSort = self:getChildTrans("ContentSort")
    self.m_transGroupFilter = self:getChildTrans("GroupFilter")
    self.mGroupFilter = self:getChildGO("mGroupFilter")
    
    self:initSearchMenu()
end

-- 移除
function destroy(self, isAuto)
    super.destroy(self, isAuto)

    if self.mSortView then
        self.mSortView:destroy()
        self.mSortView = nil
    end
end

-- 激活
function active(self, args)
    super.active(self, args)
    braceletBuild.BraceletBuildManager:addEventListener(braceletBuild.BraceletBuildManager.BRACELET_STRENGTHEN_MATERIAL, self.__onMaterialSelectHandler, self)
    if(self.mVisibleCallFun)then
        self.mVisibleCallFun(true)
    end
    --self.mask:SetActive(false)
end

function clearSelectProps(self)
    self.mEquipScrollerVoList = nil
end

-- 非激活
function deActive(self)
    --braceletBuild.BraceletBuildManager:setSelectMaterialData(self.mEquipScrollerVoList)
    self:setMaterialData()
    super.deActive(self)

    braceletBuild.BraceletBuildManager:removeEventListener(braceletBuild.BraceletBuildManager.BRACELET_STRENGTHEN_MATERIAL, self.__onMaterialSelectHandler, self)
    -- self.mSortView:resetAll()
    --self.mask:SetActive(false)
    if(self.mVisibleCallFun)then
        self.mVisibleCallFun(false)
    end

    self.mLyScroller:CleanAllItem()
end

function onClickClose(self)
    super.onClickClose(self)
    TipsFactory:closeBraceletTips()
end


function setMaterialData(self)
    braceletBuild.BraceletBuildManager:setSelectMaterialData(self.mEquipScrollerVoList)
end

function initViewText(self)
    self:setBtnLabel(self.mBtnConfirm, 1, "确定")
    self.mTextEmpty.text = _TT(71414)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.close)
    self:addUIEvent(self.mBtnConfirm, self.__onClickConfirmHandler)
end


function __onClickConfirmHandler(self)
    braceletBuild.BraceletBuildManager:setSelectMaterialData(self.mEquipScrollerVoList)
    self:close()
end

-- 设置外部回调设置显示隐藏方法
function setVisibleCall(self, visibleCallFun)
    self.mVisibleCallFun = visibleCallFun
end

-- 设置外部回调方法
function setData(self, equipVo,callFun)
    self.mEquipVo = equipVo
    self.strengthenConfigVo = equipBuild.EquipStrengthenManager:getStrengthenConfigVo(self.mEquipVo.subType, self.mEquipVo.tid, self.mEquipVo.strengthenLvl)
    self.breakUpConfigVo = equipBuild.EquipStrengthenManager:getBreakUpConfigVo(self.mEquipVo.tid, self.mEquipVo.tuPoRank)
    self.mEquipScrollerVoList = braceletBuild.BraceletBuildManager:getSelectMaterialData()
    self:__updateView()
end

function __updateView(self)
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
        self.mList = braceletBuild.BraceletBuildManager:getPropsScrollList(UseEffectType.ADD_BRACELET_EXP, equipId)
    end
    local list = braceletBuild.BraceletBuildManager:getFilterList(self.mList, self.m_selectFilterDic)
    equipBuild.EquipStrengthenManager:sortHandler(list, self.m_selectSortType, self.m_isDescending)

    
    --list = self:filterUse(list)
    local showList = {}
    for i = 1, #list do
        local propsScrollVo = list[i]
        propsScrollVo:setSelect(false)
        local propsVo = propsScrollVo:getDataVo()
        for j = 1, #self.mEquipScrollerVoList do
            if (propsVo.id == self.mEquipScrollerVoList[j]:getDataVo().id) then
                propsScrollVo:setSelect(true)
                propsScrollVo:setArgs(self.mEquipScrollerVoList[j]:getArgs())
                break
            end
        end

        if propsVo.heroId == nil or propsVo.heroId == 0 then
            table.insert(showList,list[i])
        end
    end


    local propsList = {}
    local otherList = {}

    for i = 1,#showList do
        if showList[i].m_dataVo.type == 1 then
            table.insert(propsList,showList[i])
        else
            table.insert(otherList,showList[i])
        end
    end

    for i= 1,#otherList do
        table.insert(propsList,otherList[i])
    end

    if isInit or self.mLyScroller.Count <= 0 then
        self.mLyScroller.DataProvider = propsList
    else
        self.mLyScroller:ReplaceAllDataProvider(propsList)
    end

    self.mImgEmpty:SetActive(#propsList <= 0)

    self:updateTextView()
    -- self.mGroupFilter:SetActive(self.m_isShowSort and #list > 0)
    -- self.mGroupSelect:SetActive(not self.m_isShowSort and #list > 0)

    -- self:__updateGuide(list)
end

function initSearchMenu(self)
    self.m_menu = self.m_menu or self:getChildGO('Menu')
    self.m_dropDown = self.m_dropDown or self:getChildGO('DropDown')
    self.m_itemSubMenu = self.m_itemSubMenu or self:getChildGO('ItemSubMenu')
    self.m_imgGoUp = self.m_imgGoUp or self:getChildGO('ImgUp')
    self.m_imgGoDown = self.m_imgGoDown or self:getChildGO('ImgDown')

    self.m_descending = self.m_descending or self:getChildGO('ImgClick')
    self.btnClose = self:getChildGO("mBtnCloseMenu")
    self.btnClose:SetActive(false)


    local _active = self.active
    self.active = function()
        _active(self)
        self:__updateDescendingState()
        self:__updateMenuList()
        self:__updateMenuView()
        self:addUIEvent(self.m_menu, self.__clickMenu)
        self:addUIEvent(self.m_descending, self.__clickDescending)
        self:addUIEvent(self.btnClose,self.onCloseMenu)
    end

    local _deActive = self.deActive
    self.deActive = function()
        _deActive(self)
        self.m_isDescending = true
        self.m_isOpenMenu = false
        self.m_selectSortType = nil
    end
end

function onCloseMenu(self)
    self.m_isOpenMenu = false
    self.btnClose:SetActive(false)
    self:__updateMenuView()
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
    self.m_menuList = equipBuild.panelSortTypeList
    -- 当前选择的排序类型
    self.m_selectSortType = self.m_selectSortType or self.m_menuList[1]
    -- 当前的排序内容列表数据
    self.m_menuPageList = {}
    for i = 1, #self.m_menuList do
        local menuType = self.m_menuList[i]
        -- if(menuType ~= self.m_selectSortType)then
            local name, colorList = equipBuild.getSortTypeName(menuType)
            table.insert(self.m_menuPageList, {page = menuType, nomalLan = name, nomalLanEn = ""})
        -- end
    end
    if(self.tabBar)then
        self.tabBar:reset()
    end
    self.tabBar = CustomTabBar:create(self.m_itemSubMenu, self.m_dropDown.transform, self.__clickSubMenu, self)
    self.tabBar:setData(self.m_menuPageList)
    self.tabBar:setPage(self.m_selectSortType,false)
end

function __clickMenu(self)
    self.m_isOpenMenu = not self.m_isOpenMenu
    self.btnClose:SetActive(self.m_isOpenMenu)
    self:__updateMenuView()
end

function __clickSubMenu(self, sortType)
    self.m_isOpenMenu = false
    self.m_selectSortType = sortType
    self:__updateMenuList()
    self:__updateMenuView()
    self:updateStrengthenView(false)
end

function __updateMenuView(self)
    -- 排序菜单状态
    self:setBtnLabel(self.m_menu, -1, equipBuild.getSortTypeName(self.m_selectSortType))
    self.m_dropDown:SetActive(self.m_isOpenMenu)
    self.m_imgGoUp:SetActive(self.m_isOpenMenu)
    self.m_imgGoDown:SetActive(not self.m_isOpenMenu)
end

function __clickDescending(self)
    local temp = not self.m_isDescending
    self.m_isDescending = temp
    self:__updateDescendingState();
    self:updateStrengthenView(false)
end


function recoverListData(self, list)
    if (list and #list > 0) then
        for i, v in ipairs(list) do
            LuaPoolMgr:poolRecover(v)
        end
    end
end

function __updateCost(self)
end

function __onMaterialSelectHandler(self, args)
    local sourceVo = args
    local clickPropsVo = sourceVo:getDataVo()
    local selectCount = sourceVo:getArgs()

    local isAdd = true

    local selectVo, index = self:getScollerVo(clickPropsVo.id)
    if selectVo then
        if (clickPropsVo.type == PropsType.NORMAL and selectCount <= 0) or (clickPropsVo.type == PropsType.EQUIP and clickPropsVo.isLock == 1) or selectCount == 0 then
            selectVo:setArgs(selectCount)
            LuaPoolMgr:poolRecover(selectVo)
            table.remove(self.mEquipScrollerVoList, index)
        end

        -- if clickPropsVo:getDataVo().isLock == 1 then
        --     selectVo:setArgs(0)
        --     LuaPoolMgr:poolRecover(selectVo)
        --     table.remove(self.mEquipScrollerVoList, index)
        -- end
        isAdd = false
    end
    if(isAdd and #self.mEquipScrollerVoList == sysParam.SysParamManager:getValue(SysParamType.BRACELET_MATERIAL_AUTO_COUNT))then
        gs.Message.Show(_TT(4357))
        return
    end
    local _needExp = equipBuild.EquipStrengthenManager:getExpByStrengthLvl(self.mEquipVo, self.mEquipVo.strengthenLvl, self.breakUpConfigVo.equipTargetLvl)
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
    for i=1,#self.mEquipScrollerVoList do
        if self.mEquipScrollerVoList[i]:getDataVo().isLock == 1 then
            table.remove(self.mEquipScrollerVoList,i)
        end
    end
    

    self:updateStrengthenView(false)
    self:updateTextView()

    braceletBuild.BraceletBuildManager:setSelectMaterialData(self.mEquipScrollerVoList)
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
        if self.mEquipVo.strengthenLvl + _addLvl < self.breakUpConfigVo.equipTargetLvl then
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

function updateTextView(self)
    self.mTextCount.text = string.format("%s/%s", #self.mEquipScrollerVoList, sysParam.SysParamManager:getValue(SysParamType.BRACELET_MATERIAL_AUTO_COUNT))
end

function getScollerVo(self, propsId)
    for i = 1, #self.mEquipScrollerVoList do
        if (self.mEquipScrollerVoList[i]:getDataVo().id == propsId) then
            return self.mEquipScrollerVoList[i], i
        end
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(71414):	"搜索不到对应材料"
]]
