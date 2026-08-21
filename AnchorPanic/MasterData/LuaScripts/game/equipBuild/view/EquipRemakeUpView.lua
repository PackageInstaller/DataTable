--[[ 
-----------------------------------------------------
@filename       : EquipRemakeUpView
@Description    : 装备改造实际操作界面
@date           : 2021-01-12 17:11:22
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.equipBuild.view.EquipRemakeUpView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("equipBuild/EquipRemakeUpView.prefab")

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
    self.m_isDescending = true
    self.m_selectSortType = equipBuild.panelSortType.LEVEL
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
    super.configUI(self)

    self.mBtnClose = self:getChildGO('BtnClose')
    self.mBtnStateYes = self:getChildGO('BtnStateYes')
    self.mBtnStateNo = self:getChildGO('BtnStateNo')
    self.mBtnConfirm = self:getChildGO('BtnConfirm')
    self.mImgCostGO = self:getChildGO("ImgCost")
    self.mImgCost = self:getChildGO("ImgCost"):GetComponent(ty.AutoRefImage)
    self.mTextCost = self:getChildGO("TextCost"):GetComponent(ty.Text)
    self.mFilterNode = self:getChildTrans('NodeFilter')
    self.mTextTip = self:getChildGO("TextTip"):GetComponent(ty.Text)
    self.mTextCountTip = self:getChildGO("TextCountTip"):GetComponent(ty.Text)
    self.mTextCount = self:getChildGO("TextCount"):GetComponent(ty.Text)

    self.mLyScroller = self:getChildGO('LyScroller'):GetComponent(ty.LyScroller)
    self.mLyScroller:SetItemRender(equipBuild.EquipRemakeMaterialItem)

    self.mImgEmpty = self:getChildGO('EmptyStateItem')
    self.mmTxtEmptyTip = self:getChildGO("mTxtEmptyTip"):GetComponent(ty.Text)

    self.m_btnFilter = self:getChildGO("BtnFilter")
    self.m_transGroupSort = self:getChildTrans("ContentSort")
    self.m_transGroupFilter = self:getChildTrans("GroupFilter")
    self.mGroupFilter = self:getChildGO("mGroupFilter")
    self.mInfoGroup = self:getChildTrans("mInfoGroup")
    -- self.mBtnCloseTips = self:getChildGO("mBtnCloseTips")
    -- self.mBtnCloseTips2 = self:getChildGO("mBtnCloseTips2")
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
    equipBuild.EquipRemakeManager:addEventListener(equipBuild.EquipRemakeManager.EQUIP_REMAKE_MATERIAL_SELECT, self.__onRemakeMaterialSelectHandler, self)
    
    -- GameDispatcher:addEventListener(EventName.UPDATE_EQUIP_LOCK, self.closeEquipTips, self)
    -- GameDispatcher:addEventListener(EventName.CHANGE_BRACELETS, self.close, self)
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.__updateView, self)

    -- self.mask:SetActive(false)
    if(self.mVisibleCallFun)then
        self.mVisibleCallFun(true)
    end
    self:checkUpdateDefaultSelect()
end

-- 非激活
function deActive(self)
    super.deActive(self)
    equipBuild.EquipRemakeManager:removeEventListener(equipBuild.EquipRemakeManager.EQUIP_REMAKE_MATERIAL_SELECT, self.__onRemakeMaterialSelectHandler, self)
  
    role.RoleManager:getRoleVo():removeEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.__updateView, self)
    self.mLyScroller:CleanAllItem()
    if(self.mVisibleCallFun)then
        self.mVisibleCallFun(false)
    end
end

function onClickClose(self)
    super.onClickClose(self)
    TipsFactory:closeEquipTips()
end

function initViewText(self)
    self:setBtnLabel(self.mBtnConfirm, 4008, "改造")
    self.mmTxtEmptyTip.text = _TT(71414)
    self.mTextTip.text = _TT(4354)
    self.mTextCount.text  = "0/1"
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.close)
    self:addUIEvent(self.mBtnConfirm, self.__onClickConfirmHandler)
    -- self:addUIEvent(self.mBtnCloseTips, self.closeEquipTips)
    -- self:addUIEvent(self.mBtnCloseTips2, self.closeEquipTips)
end

function showEquipTips(self, equipVo)
    -- if(equipVo and equipVo.type == bag.BagTabType.EQUIP) then
    --     if (not self.equipTips) then
    --         self.equipTips = equipBuild.EquipInfoTipsItem:poolGet()
    --     end
    --     self.equipTips:setData(equipVo)
    --     self.equipTips:setParent(self.mInfoGroup)
    --     if nowEquip == nil then
    --         self.equipTips:setContrastActive(false)
    --     end
    --     -- self.mBtnCloseTips:SetActive(true)
    -- else
    --     self:closeEquipTips()
    -- end
end

function closeEquipTips(self, equipId)
    -- if self.equipTips then
    --     self.equipTips:poolRecover()
    --     self.equipTips = nil
    -- end
    -- -- self.mBtnCloseTips:SetActive(false)
    -- if equipId then 
    --     local vo, index = self:getScollerVo(equipId)
    --     table.remove(self.mEquipScrollerVoList, index)
    --     self.mLyScroller:CleanAllItem()
    --     self:__updateView()
    -- end
end

function __onClickConfirmHandler(self)
    local costMoneyTid = self.remakeConfigVo:getPayId()
    local costMoneyCount = self.remakeConfigVo:getPayNum()
    if (self.m_equipMaterialVo == nil) then
        gs.Message.Show(_TT(1077))
        return 
    else
        if (MoneyUtil.judgeNeedMoneyCountByTid(costMoneyTid, costMoneyCount)) then

            local function onReqRemakeHandler()
                GameDispatcher:dispatchEvent(EventName.REQ_EQUIP_REMAKE, { heroId = self.mEquipVo.heroId, equipId = self.mEquipVo.id, remakePos = self.m_curSelectPos, costId = self.m_equipMaterialVo.id })
                self:onClickClose()
            end
            local isNeedPopTip = self.m_equipMaterialVo.color >= ColorType.ORANGE
            if (isNeedPopTip) then
                UIFactory:alertMessge(_TT(71415),
                true, function() onReqRemakeHandler() end, _TT(1), nil,
                true, function() end, _TT(2),
                _TT(71416), nil, RemindConst.EQUIP_REMAKE)
            else
                onReqRemakeHandler()
            end
            -- end
        end
    end
    self:onClickClose()
end

-- 设置外部回调设置显示隐藏方法
function setVisibleCall(self, visibleCallFun)
    self.mVisibleCallFun = visibleCallFun
end

-- 设置外部回调方法
function setData(self, args)
    self.mEquipVo = args.equipVo
    self.m_curSelectPos = args.pos
    self.remakeConfigVo = equipBuild.EquipRemakeManager:getEquipRemakeVo(self.mEquipVo.tid)
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
        self.mList = equipBuild.EquipRemakeManager:getPropsScrollList(self.remakeConfigVo:getCostList(), self.mEquipVo.id)

    end
    local list = equipBuild.EquipRemakeManager:getFilterList(self.mList, self.m_selectFilterDic)
    equipBuild.EquipRemakeManager:sortHandler(list, self.m_selectSortType, self.m_isDescending, true)

    for i = 1, #list do
        local propsScrollVo = list[i]
        propsScrollVo:setSelect(false)
        local propsVo = propsScrollVo:getDataVo()
        if (self.m_equipMaterialVo and self.m_equipMaterialVo.id == propsVo.id and self.m_equipMaterialVo.isLock == 0) then
            propsScrollVo:setSelect(true)
        end
    end

    -- table.sort(list,function (vo1,vo2)
    --     return vo1:getDataVo().isLock < vo2:getDataVo().isLock
    -- end)

    if isInit or self.mLyScroller.Count <= 0 then
        self.mLyScroller.DataProvider = list
    else
        self.mLyScroller:ReplaceAllDataProvider(list)
    end
    self.mImgEmpty:SetActive(#list <= 0)

    self:updateTextView()
end

function checkUpdateDefaultSelect(self)
    if(not self.m_equipMaterialVo)then
        local list = self.mLyScroller:GetItemList()
        local count = list.Count
        if(count > 0)then
            for i = 0, count - 1 do
                local scrollItem = list[i]
                local itemData = scrollItem:getData()
                local equipVo = itemData:getDataVo()
                if (equipVo and equipVo.isLock == 0) then
                    scrollItem:onClickGridHandler()
                    break
                end
            end
        end
    end
end

-- 刷新item状态，数据全刷，ui仅更新可见项，不重置列表
function updateItemState(self)
    local list = equipBuild.EquipRemakeManager:getFilterList(self.mList, self.m_selectFilterDic)

    for i = 1, #list do
        local propsScrollVo = list[i]
        propsScrollVo:setSelect(false)
        local propsVo = propsScrollVo:getDataVo()
        if (self.m_equipMaterialVo and self.m_equipMaterialVo.id == propsVo.id and self.m_equipMaterialVo.isLock == 0) then
            propsScrollVo:setSelect(true)
        end
    end

    local list = self.mLyScroller:GetItemList()
    local count = list.Count
    for i = 0, count - 1 do
        local item = list[i]
        local propsVo = item.data:getDataVo()
        item:setSelectState(false)
        if (self.m_equipMaterialVo and self.m_equipMaterialVo.id == propsVo.id and self.m_equipMaterialVo.isLock == 0) then
            item:setSelectState(true)
        end
    end
end

function initSearchMenu(self)
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
        self:addUIEvent(self.m_menu, self.__clickMenu)
        self:addUIEvent(self.m_descending, self.__clickDescending)
    end

    local _deActive = self.deActive
    self.deActive = function()
        _deActive(self)
        self.m_isDescending = true
        self.m_isOpenMenu = false
        self.m_selectSortType = nil
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
    self.m_menuList = equipBuild.panelRemakeSortTypeList
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
    self:__updateDescendingState()
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

function __onRemakeMaterialSelectHandler(self, args)
    if(args)then
        self.m_equipMaterialVo = args
        -- self:updateStrengthenView(false)
        self:updateItemState()
        self:updateTextView()
        -- self:showEquipTips(self.m_equipMaterialVo)
    end
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
    local costMoneyTid = self.remakeConfigVo:getPayId()
    local count =  self.m_equipMaterialVo==nil and 0 or 1
    local costMoneyCount = self.remakeConfigVo:getPayNum() * count
    self.mImgCost:SetImg(MoneyUtil.getMoneyIconUrlByTid(costMoneyTid), true)
    self.mTextCost.text = costMoneyCount
    self.mTextCost.color = gs.ColorUtil.GetColor(MoneyUtil.judgeNeedMoneyCountByTid(costMoneyTid,costMoneyCount,false,false) and "FFFFFFFF" or "ed1941FF")
    self.mTextCost.gameObject:SetActive(costMoneyCount > 0)
    self.mImgCostGO:SetActive(costMoneyCount > 0)

    if (self.m_equipMaterialVo == nil) then
        self.mTextCount.text = "0/1"
    else
        self.mTextCount.text = "1/1"
    end
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
	语言包: _TT(71416):	"改造提示"
	语言包: _TT(71415):	"改造材料中包含了橙色及以上品质的芯片，是否继续改造？（同一条改造属性在同个芯片中无法重复出现）？"
	语言包: _TT(71414):	"搜索不到对应材料"
	语言包: _TT(2):	"取消"
	语言包: _TT(1):	"确定"
]]
