module("braceletBuild.BraceletStrengthenTabO", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("braceletBuild/tab/BraceletStrengthenTab.prefab")

State = { -- 无法强化
    CanNotStrengthen = 1, -- 强化
    Strengthen = 2, -- 突破
    BreakUp = 3, -- 最大级
    MaxLvl = 4
}

function initData(self)
    self.mEquipVo = nil
    self.mEquipGrid = nil

    self.mState = nil

    self.mTupoList = {}
    self.mGridList = {}

    self.mMainItemsAttr = {}
end

function configUI(self)

    -- 

    self.mRightContent = self:getChildTrans("mRightContent")
    -- self.mPropsImg = self:getChildTrans("mImgIcon"):GetComponent(ty.AutoRefImage)

    --self.mEquipNode = self:getChildTrans("mEquipNode")
    self.mTextItemName = self:getChildGO("mTextItemName"):GetComponent(ty.Text)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mImgButtum = self:getChildGO("mImgButtum"):GetComponent(ty.AutoRefImage)
    --self.mTxtLv = self:getChildGO("mTxtLv"):GetComponent(ty.Text)

    -- self.mImgAttBg = self:getChildTrans("mImgAttBg")
    -- self.mTxtAttr = self:getChildGO("mTxtAttr"):GetComponent(ty.Text)
    -- self.mTxtBeforeAttr = self:getChildGO("mTxtBeforeAttr"):GetComponent(ty.Text)
    -- self.mTxtAfterAttr = self:getChildGO("mTxtAfterAttr"):GetComponent(ty.Text)
    self.mStrengthenScrollView = self:getChildGO("mStrengthenScrollView"):GetComponent(ty.ScrollRect)
    self.mStrengthenAttrItem = self:getChildGO("mStrengthenAttrItem")

    self.mGroupStrengthen = self:getChildGO("mGroupStrengthen")
    -- 等级条
    self.mGroupStrengthenLvl = self:getChildGO("mGroupStrengthenLvl")
    self.mTextStrengthenLvl = self:getChildGO("mTextStrengthenLvl"):GetComponent(ty.Text)
    self.mTextStrengthenTargetLvl = self:getChildGO("mTextStrengthenTargetLvl"):GetComponent(ty.Text)

    self.mTextStrengthenAddExp = self:getChildGO("mTextStrengthenAddExp"):GetComponent(ty.Text)

    self.mStrengthenProgressBgRT = self:getChildGO("mStrengthenProgressBg"):GetComponent(ty.RectTransform)
    self.mStrengthenProgressBgProRT = self:getChildGO("mStrengthenProgressBgPro"):GetComponent(ty.RectTransform)
    self.mTextStrengthenExp = self:getChildGO("mTextStrengthenExp"):GetComponent(ty.Text)

    self.mMaxtrengthenLvl = self:getChildGO("mMaxtrengthenLvl"):GetComponent(ty.Text)

    self.mGroupAddLvl = self:getChildGO("mGroupAddLvl")
    self.mTextAddLvl = self:getChildGO("mTextAddLvl"):GetComponent(ty.Text)

    -- ============== 强化 ==============--
    -- 强化材料描述信息
    self.mTxtStrengInfo = self:getChildGO("mTxtStrengInfo")
    -- 强化内容
    self.mGroupStrengthenMaterial = self:getChildGO("mGroupStrengthenMaterial")
    -- 筛选排序
    self.mGroupStrengthenSort = self:getChildGO("mGroupStrengthenSort")

    self.mStrengthenScroller = self:getChildGO("mStrengthenScroller"):GetComponent(ty.LyScroller)
    self.mStrengthenScroller:SetItemRender(braceletBuild.BraceletStrengthenShowltem)

    self.mBtnAuto = self:getChildGO("mBtnAuto")

    self.mBtnStrengthen = self:getChildGO("mBtnStrengthen")
    self.mBtnReset = self:getChildGO("mBtnReset")

    self.mStrengthenCostIcon = self:getChildGO("mStrengthenCostIcon"):GetComponent(ty.AutoRefImage)
    self.mTextStrengthenCost = self:getChildGO("mTextStrengthenCost"):GetComponent(ty.Text)

    self.mImgAttChange = self:getChildGO("mImgAttChange")

    self.mClickTouch = self:getChildGO('mClickTouch')
    self.mClickTouch:GetComponent(ty.LongPressOrClickEventTrigger):SetIsPassEvent(true)

    self:initSearchMenu()

    -- ============== 突破 ==============--
    self.mGroupBreakUp = self:getChildGO("mGroupBreakUp")

    self.mTextBreakUpCurLvl = self:getChildGO("mTextBreakUpCurLvl"):GetComponent(ty.Text)
    self.mTextBreakUpNextLvl = self:getChildGO("mTextBreakUpNextLvl"):GetComponent(ty.Text)
    self.mTextBreakUpCurLvlNum = self:getChildGO("mTextBreakUpCurLvlNum"):GetComponent(ty.Text)
    self.mTextBreakUpNextLvlNum = self:getChildGO("mTextBreakUpNextLvlNum"):GetComponent(ty.Text)

    self.mTextRankAttrTitle = self:getChildGO("mTextRankAttrTitle"):GetComponent(ty.Text)

    self.mGroupBreakUpAttr = self:getChildTrans("mGroupBreakUpAttr")
    self.mAttrItem = self:getChildGO("mAttrItem")

    self.mTxtProp = self:getChildGO("mTxtProp"):GetComponent(ty.Text)

    self.mBreakUpCostItem = self:getChildGO("mBreakUpCostItem")
    self.mBreakUpCostContent = self:getChildTrans("mBreakUpCostContent")

    self.mBtnBreakUp = self:getChildGO("mBtnBreakUp")
    self.mTextBeakUpCost = self:getChildGO("mTextBeakUpCost"):GetComponent(ty.Text)
    self.mBreakUpCostIcon = self:getChildGO("mBreakUpCostIcon"):GetComponent(ty.AutoRefImage)

    self.mGroupMaxTip = self:getChildGO("mGroupMaxTip")
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnAuto, self.onBtnAutoClickHandler)
    self:addUIEvent(self.mBtnReset, self.onBtnResetClickHandler)
    self:addUIEvent(self.mBtnStrengthen, self.onBtnStrengthenClickHandler)
    self:addUIEvent(self.mBtnBreakUp, self.onBtnBreakClickHandler)
    self:addUIEvent(self.mClickTouch, self.onClickTouchHandler)
end

function onClickTouchHandler(self)
    self:__clickMenu()
end

-- 点击突破
function onBtnBreakClickHandler(self)
    local isEnough = equipBuild.EquipStrengthenManager:getIsEnoughBreakUp(self.mEquipVo.heroId, self.mEquipVo.id)
    if (isEnough) then
        if (MoneyUtil.judgeNeedMoneyCountByTid(self.breakUpConfigVo.costMoneyTid, self.breakUpConfigVo.costMoneyCount)) then
            GameDispatcher:dispatchEvent(EventName.REQ_EQUIP_BREAKUP, {
                heroId = self.mEquipVo.heroId,
                equipId = self.mEquipVo.id
            })
        end
    else
        gs.Message.Show(_TT(4306))
    end
end

-- 点击强化
function onBtnStrengthenClickHandler(self)
    if (#self.mSelectEquipList <= 0) then
        gs.Message.Show(_TT(4308))
    else
        local addExp, needMoneyCount, needMoneyTid, addLvl = self:getSelectExpAndMoneyNum()
        if (MoneyUtil.judgeNeedMoneyCountByTid(needMoneyTid, needMoneyCount)) then
            local function onReqStrengthenHandler()
                local costList = {}
                for i = 1, #self.mSelectEquipList do
                    table.insert(costList, {
                        id = self.mSelectEquipList[i]:getDataVo().id,
                        count = self.mSelectEquipList[i]:getArgs()
                    })
                end
                GameDispatcher:dispatchEvent(EventName.REQ_EQUIP_STRENGTHEN, {
                    heroId = self.mEquipVo.heroId,
                    equipId = self.mEquipVo.id,
                    costList = costList
                })
                self:onBtnResetClickHandler()
            end
            local isNeedPopTip = false
            for i = 1, #self.mSelectEquipList do
                if (self.mSelectEquipList[i]:getDataVo().type == PropsType.EQUIP and
                self.mSelectEquipList[i]:getDataVo().color >= ColorType.VIOLET) then
                    isNeedPopTip = true
                    break
                end
            end
            if (isNeedPopTip) then
                UIFactory:alertMessge(_TT(4309), true, function()
                    onReqStrengthenHandler()
                end, _TT(1), nil, true, function()
                end, _TT(2), _TT(5), nil, RemindConst.BRACELETS_STRENGTHEN)
            else
                onReqStrengthenHandler()
            end
        end
    end
end
-- 重置材料
function onBtnResetClickHandler(self)
    self.mSelectEquipList = {}
    braceletBuild.BraceletBuildManager:setSelectMaterialData(nil)
    self:updateViewInfo()
end

-- 点击自动添加
function onBtnAutoClickHandler(self)
    if (not self.mEquipVo) then
        return
    end

    local selectEquipScrollList = braceletBuild.BraceletBuildManager:getSelectMaterialData()
    local fastAddCountLimit = sysParam.SysParamManager:getValue(SysParamType.BRACELET_MATERIAL_AUTO_COUNT)
    if #selectEquipScrollList >= fastAddCountLimit then
        gs.Message.Show(_TT(4357))
        return
    end

    local _addExp = 0
    local isEnough = false
    local breakUpConfigVo = equipBuild.EquipStrengthenManager:getBreakUpConfigVo(self.mEquipVo.tid,
    self.mEquipVo.tuPoRank)
    local _needExp = equipBuild.EquipStrengthenManager:getExpByStrengthLvl(self.mEquipVo, self.mEquipVo.strengthenLvl,
    breakUpConfigVo.equipTargetLvl)

    for i = 1, #selectEquipScrollList do
        local propsVo = selectEquipScrollList[i]:getDataVo()
        -- 判断数量不超上限
        local convertExp, needMoneyTid, needMoneyCount = equipBuild.EquipStrengthenManager:getConvertExp(propsVo)
        _addExp = _addExp + convertExp * selectEquipScrollList[i]:getArgs()
        -- 满足满级的经验
        if self.mEquipVo.strengthenExp + _addExp >= _needExp then
            gs.Message.Show(_TT(4358))
            return
        end
    end

    local filterDic = {}
    for type in pairs(equipBuild.panelFilterTypeDic) do
        filterDic[type] = {}
        filterDic[type][equipBuild.filterSubTypeAll] = true
    end
    local equipId = self.mEquipVo.id
    local scrollList = braceletBuild.BraceletBuildManager:getPropsScrollList(UseEffectType.ADD_BRACELET_EXP,
    self.mEquipVo.id)
    scrollList = braceletBuild.BraceletBuildManager:getFilterList(scrollList, filterDic)
    equipBuild.EquipStrengthenManager:sortHandler(scrollList, equipBuild.panelSortType.DEFAULT, self.m_isDescending)
    if (scrollList and #scrollList > 0) then
        local name, colorList = self:getMenuName()
        for i = #scrollList, 1, -1 do
            local propsVo = scrollList[i]:getDataVo()
            if (table.indexof(colorList, propsVo.color) == false) then
                table.remove(scrollList, i)
            end

            if (propsVo.type == PropsType.EQUIP and propsVo.heroId > 0) then
                table.remove(scrollList, i)
            end

            for j = 1, #selectEquipScrollList do
                if propsVo.id == selectEquipScrollList[j]:getDataVo().id then
                    table.remove(scrollList, i)
                    break
                end
            end
        end

        if #scrollList <= 0 then
            gs.Message.Show(_TT(4311))
        end

        -- self:clearSelectEquipList(false)
        local _needMoneyTid = 0
        local _needMoneyCount = 0
        for i = 1, #scrollList do
            local propsVo = scrollList[i]:getDataVo()
            -- 判断数量不超上限
            if (#selectEquipScrollList < fastAddCountLimit) then
                local convertExp, needMoneyTid, needMoneyCount =                equipBuild.EquipStrengthenManager:getConvertExp(propsVo)
                local needCount = 0

                local has = 0
                local hasSelectedVo = nil
                for j = 1, #selectEquipScrollList do
                    if selectEquipScrollList[j]:getDataVo().id == propsVo.id then
                        hasSelectedVo = selectEquipScrollList[j]
                        has = selectEquipScrollList[j]:getArgs()
                        break
                    end
                end

                local forCount = propsVo.count - has

                for j = 1, forCount do
                    needCount = j
                    _addExp = _addExp + convertExp
                    if self.mEquipVo.strengthenExp + _addExp >= _needExp then
                        isEnough = true
                        break
                    end
                end
                -- scrollList[i]:setArgs(needCount)
                if hasSelectedVo == nil then
                    local scrollVo = LuaPoolMgr:poolGet(LyScrollerSelectVo)
                    scrollVo:setDataVo(propsVo)
                    scrollVo:setArgs(needCount)
                    scrollVo:setSelect(true)
                    table.insert(selectEquipScrollList, scrollVo)
                else
                    hasSelectedVo:setArgs(hasSelectedVo:getArgs() + needCount)
                end
                -- 满足满级的经验
                if self.mEquipVo.strengthenExp + _addExp >= _needExp then
                    -- Debug:log_info("",string.format("满足满级的经验--->%s,%s,%s",self.mEquipVo.strengthenExp , _addExp , _needExp))
                    isEnough = true
                    break
                end
            end
            if isEnough then
                break
            end
        end

        braceletBuild.BraceletBuildManager:setSelectMaterialData(selectEquipScrollList)
        self:updateViewInfo()
    else
        gs.Message.Show(_TT(4311)) -- 无可选择的芯片
    end
end

function initViewText(self)
    self:setBtnLabel(self.mBtnAuto, 4348, "自动选择")
    self:setBtnLabel(self.mBtnStrengthen, 4312, "开始强化")
    self:setBtnLabel(self.mBtnReset, 4350, "重置")

    -- self:getChildGO("TextMaxTip"):GetComponent(ty.Text).text = _TT(4376)

    -- self:setBtnLabel(self.mTextRankAttrTitle, 4350, "重置")
end

function initSearchMenu(self)
    self.m_menu = self.m_menu or self:getChildGO('Menu')
    self.m_dropDown = self.m_dropDown or self:getChildGO('DropDown')
    self.m_itemSubMenu = self.m_itemSubMenu or self:getChildGO('ItemSubMenu')
    self.m_imgGoUp = self.m_imgGoUp or self:getChildGO('ImgUp')
    self.m_imgGoDown = self.m_imgGoDown or self:getChildGO('ImgDown')
    self.m_actImg = self.m_actImg or self:getChildGO("mActImg")

    local _active = self.active
    self.active = function()
        _active(self)
        self:__updateMenuList()
        self:__updateMenuView()
        self:addUIEvent(self.m_menu, self.__clickMenu)
    end

    local _deActive = self.deActive
    self.deActive = function()
        _deActive(self)
        self.m_isDescending = true
        self.m_isOpenMenu = false
        self.m_curMenuType = nil
    end
end

function __clickMenu(self)
    self.m_isOpenMenu = not self.m_isOpenMenu
    self:__updateMenuView()
end

function __updateMenuList(self)
    -- 是否选择了降序
    self.m_isDescending = self.m_isDescending == nil and true or false
    -- 是否打开排序菜单
    self.m_isOpenMenu = false
    -- 当前的菜单类型列表数据
    self.m_menuList = self.m_menuList or { "BLUE", "VIOLET" }
    -- 当前选择的排序类型
    self.m_curMenuType = self.m_curMenuType or self.m_menuList[1]
    -- 当前的排序内容列表数据
    self.m_menuPageList = {}
    for i = 1, #self.m_menuList do
        local menuType = self.m_menuList[i]
        -- if(menuType ~= self.m_curMenuType)then
        local name, colorList = self:getMenuName(menuType)
        table.insert(self.m_menuPageList, {
            page = menuType,
            nomalLan = name,
            nomalLanEn = ""
        })
        -- end
    end
    if (self.tabBar) then
        self.tabBar:reset()
    end
    self.tabBar = CustomTabBar:create(self.m_itemSubMenu, self.m_dropDown.transform, self.__clickSubMenu, self)
    self.tabBar:setData(self.m_menuPageList)
    self.tabBar:setPage(self.m_curMenuType, false)
    self.tabBar:setDispatcherSame(false)
end

function __updateMenuView(self)
    -- 排序菜单状态
    self:setBtnLabel(self.m_menu, -1, self:getMenuName(self.m_curMenuType))
    self.m_dropDown:SetActive(self.m_isOpenMenu)
    self.m_imgGoUp:SetActive(self.m_isOpenMenu)
    self.m_imgGoDown:SetActive(not self.m_isOpenMenu)

    self.m_actImg:SetActive(self.m_isOpenMenu)
    self.mClickTouch:SetActive(self.m_isOpenMenu)
end

function getMenuName(self, menuType)
    menuType = menuType or self.m_curMenuType
    if (menuType == "GREEN") then
        return _TT(4344), { ColorType.GREEN } -- "绿色"
    elseif (menuType == "BLUE") then
        return _TT(4345), { ColorType.BLUE, ColorType.GREEN } -- "蓝色及以下"
    elseif (menuType == "VIOLET") then
        return _TT(4346), { ColorType.VIOLET, ColorType.BLUE, ColorType.GREEN } -- "紫色及以下"
    end
end

function __clickSubMenu(self, sortType)
    self.m_isOpenMenu = false
    self.m_curMenuType = sortType
    self:__updateMenuList()
    self:__updateMenuView()
end

function onBagUpdateHandler(self)
    self:updateViewInfo()
end

function onStrengthenMaterialSelectHandler(self)
    self:updateViewInfo()
end

function active(self, args)
    braceletBuild.BraceletBuildManager:setSelectMaterialData(nil)
    if self.materialPanel then
        -- self.mRightContent.gameObject:SetActive(true)
        self.materialPanel:setVisibleCall(nil)
        self.materialPanel:onClickClose()
    end

    bag.BagManager:addEventListener(bag.BagManager.BAG_UPDATE, self.onBagUpdateHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_EQUIP_STRENGTHEN_PANEL, self.onStrengthenMaterialSelectHandler,
    self)
    GameDispatcher:addEventListener(EventName.UPDATE_EQUIP_BREAKUP_PANEL, self.onStrengthenMaterialSelectHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_BRACELET_STRENGTHEN_MATERIAL_VIEW, self.onOpenMaterialViewHandler,
    self)

    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.updateViewInfo, self)
    GameDispatcher:addEventListener(EventName.SELECT_MATERIAL_CHANGE_EVENT, self.onMaterialChangeHandler, self)

    -- braceletBuild.BraceletBuildManager:addEventListener(braceletBuild.BraceletBuildManager.BRACELET_STRENGTHEN_MATERIAL, self.__onMaterialSelectHandler, self)

    self:updateViewInfo()

end

function deActive(self)
    self:recoverPropsGrid()
    self:recoverTupoItem()

    if self.materialPanel then
        self.materialPanel:close()
    end
    self.mSelectEquipList = {}
    braceletBuild.BraceletBuildManager:setSelectMaterialData(nil)

    bag.BagManager:removeEventListener(bag.BagManager.BAG_UPDATE, self.onBagUpdateHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_EQUIP_STRENGTHEN_PANEL, self.onStrengthenMaterialSelectHandler,
    self)
    GameDispatcher:removeEventListener(EventName.UPDATE_EQUIP_BREAKUP_PANEL, self.onStrengthenMaterialSelectHandler,
    self)
    GameDispatcher:removeEventListener(EventName.OPEN_BRACELET_STRENGTHEN_MATERIAL_VIEW, self.onOpenMaterialViewHandler,
    self)
    role.RoleManager:getRoleVo():removeEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.updateViewInfo, self)

    GameDispatcher:removeEventListener(EventName.SELECT_MATERIAL_CHANGE_EVENT, self.onMaterialChangeHandler, self)
    -- braceletBuild.BraceletBuildManager:removeEventListener(braceletBuild.BraceletBuildManager.BRACELET_STRENGTHEN_MATERIAL, self.__onMaterialSelectHandler, self)

    if self.mEquipVo then
        self.mEquipVo:removeEventListener(equip.EquipVo.UPDATE_EQUIP_DETAIL_DATA, self.updateViewInfo, self)
        self.mEquipVo:removeEventListener(props.PropsVo.UPDATE, self.updateView, self)
    end

    if self.mEquipGrid then
        self.mEquipGrid:poolRecover()
        self.mEquipGrid = nil
    end
end

function updateViewInfo(self)

    self:updateNodeInfo()

    -- self.mPropsImg:SetImg(UrlManager:getPropsIconUrl(self.mEquipVo.tid), false)
    self.strengthenConfigVo = equipBuild.EquipStrengthenManager:getStrengthenConfigVo(self.mEquipVo.subType,
    self.mEquipVo.tid, self.mEquipVo.strengthenLvl)

    if not self.strengthenConfigVo then
        -- 无法强化的
        self.mState = self.State.CanNotStrengthen
    else
        self.breakUpConfigVo = equipBuild.EquipStrengthenManager:getBreakUpConfigVo(self.mEquipVo.tid,
        self.mEquipVo.tuPoRank + 1)
        local maxStrengthenLvl = equipBuild.EquipStrengthenManager:getMaxStrengthenLvl(self.mEquipVo.tid)
        local isCanBreakUp = equipBuild.EquipStrengthenManager:isCanBreakUp(self.mEquipVo)

        if isCanBreakUp then
            self.mState = self.State.BreakUp
        else
            if self.mEquipVo.strengthenLvl < maxStrengthenLvl then
                self.mState = self.State.Strengthen
            else
                self.mState = self.State.MaxLvl
            end
        end
    end
    self:updateStateView()
end

-- 基础展示数据
function updateNodeInfo(self)
    if self.mEquipVo then
        self.mEquipVo:removeEventListener(equip.EquipVo.UPDATE_EQUIP_DETAIL_DATA, self.updateViewInfo, self)
        self.mEquipVo:removeEventListener(props.PropsVo.UPDATE, self.updateView, self)
    end

    self.mEquipVo = braceletBuild.BraceletBuildManager:getEquipVo()
    self.mEquipVo:addEventListener(equip.EquipVo.UPDATE_EQUIP_DETAIL_DATA, self.updateViewInfo, self)
    self.mEquipVo:addEventListener(props.PropsVo.UPDATE, self.updateView, self)

    if self.mEquipGrid then
        self.mEquipGrid:poolRecover()
        self.mEquipGrid = nil
    end

    -- self.mEquipGrid = EquipGrid3:create(self.mEquipNode, self.mEquipVo, 1)
    -- self.mEquipGrid:setClickEnable(false)
    -- self.mEquipGrid:setShowEquipStrengthenLvl(false)
    -- self.mEquipGrid:setIdxTap(false)
    -- self.mTextItemName.text = self.mEquipVo.name
    -- self.mTxtLv.text = self.mEquipVo.strengthenLvl

    -- self.mImgIcon:SetImg(UrlManager:getIconPath("bracelet/props_"..self.mEquipVo.tid..".png"), false)
    -- self.mImgButtum:SetImg(UrlManager:getPackPath("bracelet/Nucleariron_pnl_"..self.mEquipVo.color..".png"), false)

    self.mImgIcon:SetImg(UrlManager:getBraceletIconUrl(self.mEquipVo.tid), false)
    self.mImgButtum:SetImg(UrlManager:getNraceletColorUrl(self.mEquipVo.color), false)

    self:clearMainItemsAttr()
    local mainAttrList, _ = self.mEquipVo:getMainAttr()
    for i = 1, #mainAttrList do
        local item = SimpleInsItem:create(self.mStrengthenAttrItem, self.mStrengthenScrollView.content, "BraceletStrengthenTabOmainAttrs")

        local mainKey = mainAttrList[i].key
        local mainValue = mainAttrList[i].value
        item:getChildGO("mTxtAttr"):GetComponent(ty.Text).text = AttConst.getName(mainKey)
        item:getChildGO("mTxtBeforeAttr"):GetComponent(ty.Text).text = AttConst.getValueStr(mainKey, mainValue)

        item:getChildGO("mTxtAfterAttr"):SetActive(false)
        item:getChildGO("mImgAttChange"):SetActive(false)
        table.insert(self.mMainItemsAttr, item)
    end

    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mStrengthenScrollView.transform) -- 立即刷新

end

function updateStateView(self)
    if self.mState == self.State.CanNotStrengthen then
        self.mGroupMaxTip:SetActive(true)
        self.mGroupStrengthen:SetActive(false)
        self.mGroupBreakUp:SetActive(false)

    elseif self.mState == self.State.Strengthen then
        self.mGroupMaxTip:SetActive(false)
        self.mGroupStrengthen:SetActive(true)
        self.mGroupBreakUp:SetActive(false)

        self:updateEquipAttr()
    elseif self.mState == self.State.BreakUp then
        self.mGroupMaxTip:SetActive(false)
        self.mGroupStrengthen:SetActive(false)
        self.mGroupBreakUp:SetActive(true)

        self:updateBreakUp()
    elseif (self.mState == self.State.MaxLvl) then
        self.mGroupMaxTip:SetActive(true)
        self.mGroupStrengthen:SetActive(false)
        self.mGroupBreakUp:SetActive(false)

        self.mMaxtrengthenLvl.text = self.mEquipVo.strengthenLvl
    end
end

function updateBreakUp(self)
    local tuPoRank = self.mEquipVo.tuPoRank
    self.mTextRankAttrTitle.text = _TT(4316) -- string.format("解锁第RANK%s附加属性",tuPoRank)

    self.mTextBreakUpCurLvl.text = _TT(1068) .. self.breakUpConfigVo.equipNeedLvl
    self.mTextBreakUpNextLvl.text = _TT(1068) .. self.breakUpConfigVo.equipTargetLvl

    self.mTextBreakUpCurLvlNum.text = "" .. self.breakUpConfigVo.equipNeedLvl
    self.mTextBreakUpNextLvlNum.text = "" .. self.breakUpConfigVo.equipTargetLvl

    self:clearMainItemsAttr()

    -- local strengthPreAttr = self.mEquipVo:getStrengthenAttrByLvl(self.mEquipVo.strengthenLvl + addLvl)
    local strengthPreAttr = self.mEquipVo:getBracelesAttrLvl(tuPoRank + 1)
    local mainAttrList, _ = self.mEquipVo:getMainAttr()
    if strengthPreAttr and mainAttrList then

        for i = 1, #mainAttrList do
            local mainKey = mainAttrList[i].key
            local mainValue = mainAttrList[i].value

            local preKey = mainKey
            local preValue = 0

            preValue = self:getKeyToValue(mainKey, strengthPreAttr)

            local item = SimpleInsItem:create(self.mStrengthenAttrItem, self.mStrengthenScrollView.content, "BraceletStrengthenTabOmainAttrs")
            item:getChildGO("mTxtAttr"):GetComponent(ty.Text).text = AttConst.getName(mainKey)
            item:getChildGO("mTxtBeforeAttr"):GetComponent(ty.Text).text = AttConst.getValueStr(mainKey, mainValue)
            if preValue > 0 then
                item:getChildGO("mTxtAfterAttr"):GetComponent(ty.Text).text = AttConst.getValueStr(preKey,
                preValue - mainValue)
            end

            item:getChildGO("mImgAttChange"):SetActive(preValue > 0 and mainValue ~= preValue)
            item:getChildGO("mTxtAfterAttr"):SetActive(preValue > 0 and mainValue ~= preValue)
            table.insert(self.mMainItemsAttr, item)

        end

        -- self:clearMainItemsAttr()

        -- for i = 1, #strengthPreAttr do
        --     local mainKey = mainAttrList[i].key
        --     local mainValue = mainAttrList[i].value
        --     local preKey = strengthPreAttr[i].key
        --     local preValue = strengthPreAttr[i].value
        --     local item = SimpleInsItem:create(self.mStrengthenAttrItem, self.mStrengthenScrollView.content,
        --         "mainAttrs_tupo" .. i)

        --     local mainKey = mainAttrList[i].key
        --     local mainValue = mainAttrList[i].value
        --     item:getChildGO("mTxtAttr"):GetComponent(ty.Text).text = AttConst.getName(mainKey)
        --     item:getChildGO("mTxtBeforeAttr"):GetComponent(ty.Text).text = AttConst.getValueStr(mainKey, mainValue)
        --     if preValue > 0 then
        --         item:getChildGO("mTxtAfterAttr"):GetComponent(ty.Text).text = AttConst.getValueStr(preKey,
        --         preValue - mainValue)
        --     end

        --     item:getChildGO("mImgAttChange"):SetActive(true)
        --     item:getChildGO("mTxtAfterAttr"):SetActive(true)
        --     table.insert(self.mTupoList, item)
        -- end
    end

    -- local strengthPreAttr = self.mEquipVo:getStrengthenAttrByLvl(tuPoRank)

    -- local attachAttrList, _ = self.mEquipVo:getMainAttr()
    -- local has = false
    -- if attachAttrList then
    --     for i = 1, #attachAttrList do
    --         local attachAttrVo = attachAttrList[i]
    --         if (attachAttrVo.breakUpRank == tuPoRank + 1) then
    --             local item = SimpleInsItem:create(self.mAttrItem, self.mGroupBreakUpAttr, "AttrItem3" .. i)
    --             item:setText("TextAttrName", nil, AttConst.getName(attachAttrVo.key))
    --             item:setText("TextCurAttr", nil, AttConst.getValueStr(attachAttrVo.key, attachAttrVo.value))
    --             table.insert(self.mTupoList, item)
    --             has = true
    --             break
    --         end
    --     end
    -- end
    -- self.mTextRankAttrTitle.gameObject:SetActive(has)

    self:recoverPropsGrid()
    local list = self.breakUpConfigVo.costPropsList
    for i = 1, #list do
        local item = SimpleInsItem:create(self.mBreakUpCostItem, self.mBreakUpCostContent, "EquipStrengthenCostItem")
        local propsGrid = PropsGrid:create(item:getChildTrans("BreakUpCostGrid"), { list[i].tid, 1 }, 1)
        propsGrid:setIsShowCount(false)
        local ownNum = bag.BagManager:getPropsCountByTid(list[i].tid)
        item:setText("TextBreakUpCost", nil,
        HtmlUtil:color(ownNum, ownNum >= list[i].count and "ffffffff" or "fa3a2bff") .. "/" ..
        list[i].count)
        table.insert(self.mGridList, item)
        table.insert(self.mGridList, propsGrid)
    end

    -- 消耗提示
    self.mBreakUpCostIcon:SetImg(MoneyUtil.getMoneyIconUrlByTid(self.breakUpConfigVo.costMoneyTid), true)
    self.mTextBeakUpCost.text = self.breakUpConfigVo.costMoneyCount
    self.mTextBeakUpCost.color = gs.ColorUtil.GetColor(MoneyUtil.judgeNeedMoneyCountByTid(self.breakUpConfigVo
    .costMoneyTid,
    self.breakUpConfigVo.costMoneyCount, false, false) and "FFFFFFFF" or ColorUtil.RED_NUM)
end

-- 回收突破显示用的材料道具格子
function recoverPropsGrid(self)
    for i = #self.mGridList, 1, -1 do
        local item = self.mGridList[i]
        item:poolRecover()
    end
    self.mGridList = {}
end

function recoverTupoItem(self)
    if self.mTupoList then
        for i, v in pairs(self.mTupoList) do
            v:poolRecover()
        end
    end
    self.mTupoList = {}
end

function updateEquipAttr(self)
    self:updateStrengthenPreInfo()
end

function updateStrengthenPreInfo(self)

    local needExp = self.strengthenConfigVo.needExp
    local ratio = self.mEquipVo.strengthenExp / needExp
    local maxLv

    self.mTextStrengthenLvl.text = self.mEquipVo.strengthenLvl
    if (self.mState ~= self.State.MaxLvl) then
        if (self.breakUpConfigVo) then
            maxLv = self.breakUpConfigVo.equipNeedLvl
            self.mTextStrengthenTargetLvl.text = maxLv
        else
            local breakUpConfigVo = equipBuild.EquipStrengthenManager:getBreakUpConfigVo(self.mEquipVo.tid,
            self.mEquipVo.tuPoRank)
            maxLv = breakUpConfigVo.equipTargetLvl
            self.mTextStrengthenTargetLvl.text = breakUpConfigVo.equipTargetLvl
        end

        self.mTextStrengthenExp.text = string.format("%s/%s", self.mEquipVo.strengthenExp, needExp)
        gs.TransQuick:SizeDelta01(self.mStrengthenProgressBgProRT, self.mStrengthenProgressBgRT.sizeDelta.x * ratio)
    else
        maxLv = self.mEquipVo.strengthenLvl
        self.mTextStrengthenTargetLvl.text = maxLv
        self.mTextStrengthenExp.text = "0/0"
        ratio = 0
        gs.TransQuick:SizeDelta01(self.mStrengthenProgressBgProRT, 0)
    end

    local addExp, needMoneyCount, needMoneyTid, addLvl = self:getSelectExpAndMoneyNum()
    if addLvl > 0 then
        local strengthPreAttr = self.mEquipVo:getStrengthenAttrByLvl(self.mEquipVo.strengthenLvl + addLvl)
        local mainAttrList, _ = self.mEquipVo:getMainAttr()
        self:clearMainItemsAttr()
        for i = 1, #mainAttrList do
            local mainKey = mainAttrList[i].key
            local mainValue = mainAttrList[i].value

            local preKey = 0
            local preValue = 0
            if strengthPreAttr and strengthPreAttr[i] and strengthPreAttr[i].key > 0 then
                preKey = strengthPreAttr[i].key
                preValue = strengthPreAttr[i].value
            end

            local item = SimpleInsItem:create(self.mStrengthenAttrItem, self.mStrengthenScrollView.content, "BraceletStrengthenTabOmainAttrs")

            item:getChildGO("mTxtAttr"):GetComponent(ty.Text).text = AttConst.getName(mainKey)
            item:getChildGO("mTxtBeforeAttr"):GetComponent(ty.Text).text = AttConst.getValueStr(mainKey, mainValue)
            if preValue > 0 then
                item:getChildGO("mTxtAfterAttr"):GetComponent(ty.Text).text = AttConst.getValueStr(preKey,
                preValue - mainValue)
            end

            item:getChildGO("mImgAttChange"):SetActive(preValue > 0 and mainValue ~= preValue)
            item:getChildGO("mTxtAfterAttr"):SetActive(preValue > 0 and mainValue ~= preValue)
            table.insert(self.mMainItemsAttr, item)
        end
        -- if strengthPreAttr and mainAttrList then
        --     self:clearMainItemsAttr()

        --     for i = 1, #strengthPreAttr do
        --         local mainKey = mainAttrList[i].key
        --         local mainValue = mainAttrList[i].value
        --         local preKey = strengthPreAttr[i].key
        --         local preValue = strengthPreAttr[i].value
        --         local item = SimpleInsItem:create(self.mStrengthenAttrItem, self.mStrengthenScrollView.content,
        --             "mainAttrs" .. i)

        --         local mainKey = mainAttrList[i].key
        --         local mainValue = mainAttrList[i].value
        --         item:getChildGO("mTxtAttr"):GetComponent(ty.Text).text = AttConst.getName(mainKey)
        --         item:getChildGO("mTxtBeforeAttr"):GetComponent(ty.Text).text = AttConst.getValueStr(mainKey, mainValue)

        --         item:getChildGO("mTxtAfterAttr"):GetComponent(ty.Text).text = AttConst.getValueStr(preKey,
        --             preValue - mainValue)
        --         item:getChildGO("mImgAttChange"):SetActive(true)
        --         item:getChildGO("mTxtAfterAttr"):SetActive(true)
        --         table.insert(self.mMainItemsAttr, item)
        --     end
        -- end
    else

        local mainAttrList, _ = self.mEquipVo:getMainAttr()

        self:clearMainItemsAttr()
        for i = 1, #mainAttrList do
            local item = SimpleInsItem:create(self.mStrengthenAttrItem, self.mStrengthenScrollView.content, "BraceletStrengthenTabOmainAttrs")

            local mainKey = mainAttrList[i].key
            local mainValue = mainAttrList[i].value
            item:getChildGO("mTxtAttr"):GetComponent(ty.Text).text = AttConst.getName(mainKey)
            item:getChildGO("mTxtBeforeAttr"):GetComponent(ty.Text).text = AttConst.getValueStr(mainKey, mainValue)

            item:getChildGO("mTxtAfterAttr"):SetActive(false)
            item:getChildGO("mImgAttChange"):SetActive(false)
            table.insert(self.mMainItemsAttr, item)
        end
    end
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mStrengthenScrollView.transform) -- 立即刷新

    local selectEquipScrollList = braceletBuild.BraceletBuildManager:getSelectMaterialData()
    local scrollList = {}
    self.mSelectEquipList = {}
    local equipId = self.mEquipVo.id
    local maxCount = sysParam.SysParamManager:getValue(SysParamType.BRACELET_MATERIAL_AUTO_COUNT)
    for index = 1, maxCount do
        local scrollVo = LuaPoolMgr:poolGet(LyScrollerSelectVo)
        scrollVo:setDataVo({
            index = index,
            targetEquipVo = self.mEquipVo,
            equipScrollVo = selectEquipScrollList[index]
        })
        scrollVo:setSelect(false)
        table.insert(scrollList, scrollVo)
        if (selectEquipScrollList[index]) then
            table.insert(self.mSelectEquipList, selectEquipScrollList[index])
        end
    end
    if self.mStrengthenScroller.Count <= 0 then
        self.mStrengthenScroller.DataProvider = scrollList
    else
        self.mStrengthenScroller:ReplaceAllDataProvider(scrollList)
    end

    self.mTextStrengthenAddExp.text = addExp
    self.mTextStrengthenAddExp.gameObject:SetActive(addExp > 0)

    if self.mState ~= self.State.MaxLvl then
        local pro = gs.Mathf.Clamp((addExp + self.mEquipVo.strengthenExp) / self.strengthenConfigVo.needExp, 0, 1)
        gs.TransQuick:SizeDelta01(self.mStrengthenProgressBgProRT, self.mStrengthenProgressBgRT.sizeDelta.x * pro)
    else
        gs.TransQuick:SizeDelta01(self.mStrengthenProgressBgProRT, 0)
    end

    self.mStrengthenCostIcon:SetImg(MoneyUtil.getMoneyIconUrlByTid(self.strengthenConfigVo.costMoneyTid), true)
    self.mTextStrengthenCost.text = needMoneyCount
    self.mTextStrengthenCost.gameObject:SetActive(needMoneyCount > 0)

    if addLvl > 0 then
        local lv = math.min(addLvl, maxLv - self.mEquipVo.strengthenLvl)
        if lv > 0 then
            self.mTextStrengthenLvl.color = gs.ColorUtil.GetColor("FFFFFFFF")
            self.mTextStrengthenLvl.text = self.mEquipVo.strengthenLvl + addLvl
        else
            self.mTextStrengthenLvl.text = self.mEquipVo.strengthenLvl
            self.mTextStrengthenLvl.color = gs.ColorUtil.GetColor("FFFFFFFF")
        end
    else
        self.mTextStrengthenLvl.text = self.mEquipVo.strengthenLvl
        self.mTextStrengthenLvl.color = gs.ColorUtil.GetColor("FFFFFFFF")
    end

    if needMoneyCount > 0 then
        self.mTextStrengthenCost.color = gs.ColorUtil.GetColor(
        MoneyUtil.judgeNeedMoneyCountByTid(needMoneyTid, needMoneyCount, false, false) and "FFFFFFFF" or "ed1941FF")
    end
end

function onMaterialChangeHandler(self)
    self:updateViewInfo()
    -- self:updateStrengthenPreInfo()
end

function clearMainItemsAttr(self)
    for i = 1, #self.mMainItemsAttr, 1 do
        self.mMainItemsAttr[i]:poolRecover()
    end
    self.mMainItemsAttr = {}
end

-- 获取当前已经选择的材料道具可以增加多少装备经验
function getSelectExpAndMoneyNum(self)
    local selectEquipScrollList = braceletBuild.BraceletBuildManager:getSelectMaterialData()
    local _addExp = 0
    local _needMoneyTid = 0
    local _needMoneyCount = 0
    for i = 1, #selectEquipScrollList do
        local propsVo = selectEquipScrollList[i]:getDataVo()
        local convertExp, needMoneyTid, needMoneyCount = equipBuild.EquipStrengthenManager:getConvertExp(propsVo)
        _addExp = _addExp + convertExp * selectEquipScrollList[i]:getArgs()
        _needMoneyTid = needMoneyTid
        _needMoneyCount = _needMoneyCount + needMoneyCount * selectEquipScrollList[i]:getArgs()
    end
    -- 动态增加的等级
    local _addLvl = 0
    local breakUpConfigVo = equipBuild.EquipStrengthenManager:getBreakUpConfigVo(self.mEquipVo.tid,
    self.mEquipVo.tuPoRank)
    local remaidExp = _addExp - (self.strengthenConfigVo.needExp - self.mEquipVo.strengthenExp)
    if remaidExp > 0 and self.mEquipVo.strengthenLvl < breakUpConfigVo.equipTargetLvl then
        _addLvl = 1
    end
    while (remaidExp > 0) do
        if self.mEquipVo.strengthenLvl + _addLvl < breakUpConfigVo.equipTargetLvl then
            local configVo = equipBuild.EquipStrengthenManager:getStrengthenConfigVo(self.mEquipVo.subType,
            self.mEquipVo.tid, self.mEquipVo.strengthenLvl + _addLvl)
            if configVo then
                remaidExp = remaidExp - configVo.needExp
                if remaidExp >= 0 then
                    _addLvl = _addLvl + 1
                end
            else
                remaidExp = 0
            end
        else
            remaidExp = 0
        end
    end
    return _addExp, _needMoneyCount, _needMoneyTid, _addLvl
end

function onOpenMaterialViewHandler(self, args)
    self.materialPanel = braceletBuild.BraceletMaterialPanel.new()
    local function _onDestroyPanelHandler(self)
        self.materialPanel:removeEventListener(View.EVENT_VIEW_DESTROY, _onDestroyPanelHandler, self)
        self.materialPanel = nil
    end
    self.materialPanel:addEventListener(View.EVENT_VIEW_DESTROY, _onDestroyPanelHandler, self)

    local function _showRightView(visible)
        -- self.mRightContent.gameObject:SetActive(not visible)
        if not visible then
            self:updateViewInfo()
        end
    end
    self.materialPanel:setVisibleCall(_showRightView)
    self.materialPanel:setData(args)
    self.materialPanel:open()

end

return _M