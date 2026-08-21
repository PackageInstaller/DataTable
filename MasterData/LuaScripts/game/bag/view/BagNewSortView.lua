module("bag.BagNewSortView", Class.impl())

UIRes = UrlManager:getUIPrefabPath("bag/BagNewSortView.prefab")

--构造函数
function ctor(self)
    self:__startLoad()
end

--[[ 
    设置按钮的文本，优先默认名Text的文本
    langId 语言包id,优先
    name 跳过语言包，直接输入文本
    ... 语言包替换参数
]]
function setBtnLabel(self, obj, langId, name, ...)
    if not obj then error('obj is nil', 2) end
    if not obj:GetComponent(ty.Button) then error('obj not a Button', 2) end

    local btnLabCom
    local btnLab = obj.transform:Find("Text")
    if btnLab then
        btnLabCom = btnLab:GetComponent(ty.Text)
    else
        local btnLabComs = obj:GetComponentsInChildren(ty.Text)
        if btnLabComs then
            btnLabCom = btnLabComs[0]
        end
    end

    if not btnLabCom then error('btn no "Text"', 2) end

    if langId and type(langId) ~= "number" then error('langId not a number', 2) end
    -- 语言包优先
    local str = name
    if langId and type(langId) == "number" and langId > 0 then
        str = _TT(langId, ...)
    end

    btnLabCom.text = str
end

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
function setAlignLeft(self, posX, posY)
    -- if not self.m_uiGo then
    --     logError("请先添加到父节点调用 setParentTrans ")
    --     return
    -- end
    -- gs.TransQuick:Anchor(self.mGroupMenu,  0.5, 0.5, 0.5, 0.5)
    -- gs.TransQuick:Pivot(self.mGroupMenu, 0, 0.5)
    -- gs.TransQuick:LPosX(self.mGroupMenu, posX or -612)
    -- gs.TransQuick:LPosY(self.mGroupMenu, posY or 264)
end

-- 设置居中对齐
function setAlignCenter(self, posX, posY)
    -- if not self.m_uiGo then
    --     logError("请先添加到父节点调用 setParentTrans ")
    --     return
    -- end
    -- gs.TransQuick:Anchor(self.mGroupMenu, 0.5, 0.5, 0.5, 0.5)
    -- gs.TransQuick:Pivot(self.mGroupMenu, 1, 0.5)
    -- gs.TransQuick:LPosX(self.mGroupMenu, posX or 564)
    -- gs.TransQuick:LPosY(self.mGroupMenu, posY or 268.58)
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
    self.mGroupMenu = self.m_uiTrans["mGroupMenu"]
    self.mMenuSort = self.m_uiGos["mMenuSort"]
    self.mMenuCommon = self.m_uiGos["mMenuCommon"]
    -- 子菜单
    self.mSubMenuCommon = self.m_uiGos["mSubMenuCommon"]
    self.mSubMenuPos = self.m_uiGos["mSubMenuPos"]
    self.mSubMenuSuitScroll = self.m_uiGos["mSubMenuSuitScroll"]

    self.mGoToucher = self.m_uiGos["mGoToucher"]

    self.mBtnDetailFilter = self.m_uiGos["mBtnDetailFilter"]
    self.mTxtDetailFilter = self.m_uiGos["mTxtDetailFilter"]:GetComponent(ty.Text)
    self.mIconDetailFilter = self.m_uiGos["mIconDetailFilter"]:GetComponent(ty.Image)

    self.GroupShowTips = self.m_uiGos["GroupShowTips"]
    self.TextShowTips = self.m_uiGos["TextShowTips"]:GetComponent(ty.Text)
    self.ImgShowTipsSelect = self.m_uiGos["ImgShowTipsSelect"]
    self.ImgShowTipsClick = self.m_uiGos["ImgShowTipsClick"]

    self.TextShowTips.text = _TT(1400)
end

function __initData(self)
    -- 排序是否降序
    self.mSortDescending = nil
    self.mIsShowTips = bag.BagManager:getBreakBraceletsShowTips()
    self.mIsShowTipsGroup = false

    -- 菜单列表
    self.mMenuList = {}

    -- 特殊的筛选规则
    self.mSpecialColorList = {}
    self.mSelectSuitConfigVoList = {}
    self.mSelectMainAttrConfigVoList = {}
    self.mSelectSecondaryAttrConfigVoList = {}

    self.mSpecialSuitIdList = {}
    self.mSpecialMainAttrKeyList = {}
    self.mSpecialAttachAttrKeyList = {}

    self:refreshShowTipsState()
    self:setShowTipGroup()
    self:updateDetailFilterBtn()
end

function __initEvent(self)
    self:addOnClick(self.mGoToucher, self.__onClickToucherHandler)
    self:addOnClick(self.ImgShowTipsClick, self.onClickShowTips)
end

function onClickShowTips(self)
    self.mIsShowTips = not self.mIsShowTips
    self:refreshShowTipsState()
    GameDispatcher:dispatchEvent(EventName.BREAK_EQUIP_SHOWTIPS, self.mIsShowTips)
end

function setShowTipGroup(self, state)
    if state ~= nil then
        self.mIsShowTipsGroup = state
    end

    self.GroupShowTips:SetActive(self.mIsShowTipsGroup)
end

function refreshShowTipsState(self)
    self.ImgShowTipsSelect:SetActive(not self.mIsShowTips)
    bag.BagManager:setBreakBraceletsShowTips(self.mIsShowTips)
end

function __onClickToucherHandler(self)
    self:__resetAllSubMenu()
end

function __resetAllMenu(self)
    -- 回收排序菜单
    self:__recoverMenuList(self:getMenuSortKey(false))
    self:__recoverMenuList(self:getMenuSortKey(true))

    -- 回收序列物菜单
    self:__recoverMenuList(self:getMenuOrderKey())
    -- 回收套装菜单
    self:__recoverMenuList(self:getMenuSuitKey())
    -- 回收装备部位菜单
    self:__recoverMenuList(self:getMenuPosKey())
end

function __resetAllSubMenu(self)
    -- 回收排序子菜单
    self:__recoverMenuList(self:getSubMenuSortKey(false))
    self:__recoverMenuList(self:getSubMenuSortKey(true))

    -- 回收序列物子菜单
    self:__recoverMenuList(self:getSubMenuOrderKey(false))
    self:__recoverMenuList(self:getSubMenuOrderKey(true))
    -- 回收套装菜单
    self:__recoverMenuList(self:getSubMenuSuitKey(false))
    self:__recoverMenuList(self:getSubMenuSuitKey(true))
    -- 回收装备部位子菜单
    self:__recoverMenuList(self:getSubMenuPosKey(false))
    self:__recoverMenuList(self:getSubMenuPosKey(true))

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

-- 添加排序通用菜单
function addSortMenu(self, sortTypeList, showSortType, isDescending, isOpenSubMenu)
    self:__resetAllSubMenu()
    self:__recoverMenuList(self:getMenuSortKey(false))
    self:__recoverMenuList(self:getMenuSortKey(true))

    -- 排序菜单按钮
    local item = SimpleInsItem:create(self.mMenuCommon, self.mGroupMenu, self.__cname .. "_self.mMenuCommon")
    local text = item:getChildGO("mTxt"):GetComponent(ty.Text)
    local goUp = item:getChildGO("mImgUp")
    local goDown = item:getChildGO("mImgDown")
    local goImgIcon = item:getChildGO("mImgIcon")
    local imgIcon = goImgIcon:GetComponent(ty.AutoRefImage)
    goImgIcon:SetActive(false)
    local function _updateMenuStyle()
        local data = self:getSimpleItem(self:getMenuSortKey(false))
        text.text = _TT(32, bag.getSortName(data.type))--"按" ..
        goUp:SetActive(not data.isOpen)
        goDown:SetActive(data.isOpen)

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
    item:addUIEvent("mImgClick", _clickMenuFun)
    table.insert(self.mMenuList, {obj = item, key = self:getMenuSortKey(false), typeList = sortTypeList, type = showSortType or sortTypeList[1], isOpen = isOpenSubMenu, updateMenuStyle = _updateMenuStyle})
    _updateMenuStyle()

    -- 排序菜单右侧的箭头按钮
    self.mSortDescending = isDescending
    local item = SimpleInsItem:create(self.mMenuSort, self.mGroupMenu, self.__cname .. "_self.mMenuSort")
    local goUp = item:getChildGO("mImgSortUp"):GetComponent(ty.AutoRefImage)
    local goDown = item:getChildGO("mImgSortDown"):GetComponent(ty.AutoRefImage)
    local function _updateMenuStyle()
        goUp:SetGray(self.mSortDescending)
        goDown:SetGray(not self.mSortDescending)
    end

    local function _clickBtnSortFun()
        self.mSortDescending = not self.mSortDescending
        _updateMenuStyle()
        self:__callFun()
    end
    item:addUIEvent("mImgClick", _clickBtnSortFun)
    table.insert(self.mMenuList, {obj = item, key = self:getMenuSortKey(true), typeList = nil, type = nil, isOpen = false, updateMenuStyle = nil})
    _updateMenuStyle()
end

function __updateSubMenuSort(self)
    local data = self:getSimpleItem(self:getMenuSortKey(false))
    if (data.isOpen) then
        local subMenu = SimpleInsItem:create(self.mSubMenuCommon, data.obj:getChildTrans("mNodeCommon"), self.__cname .. "_self.mSubMenuCommon")
        for i = 1, #data.typeList do
            local type = data.typeList[i]
            if (type ~= bag.BagSortType.ID) then
                local item = SimpleInsItem:create(subMenu:getChildGO("mBtnCommon"), subMenu:getTrans(), self.__cname .. "_BtnCommon")
                local goImgSelect = item:getChildGO("mImgSelect")
                local goTextSelect = item:getChildGO("mTxtSelect")
                local textSelect = goTextSelect:GetComponent(ty.Text)
                local goTextUnSelect = item:getChildGO("mTxtUnSelect")
                local textUnSelect = goTextUnSelect:GetComponent(ty.Text)
                local goImgIcon = item:getChildGO("mImgIcon")
                local imgIcon = goImgIcon:GetComponent(ty.AutoRefImage)
                goImgIcon:SetActive(false)
                if (type == data.type) then
                    goImgSelect:SetActive(true)
                    goTextSelect:SetActive(true)
                    goTextUnSelect:SetActive(false)
                    textSelect.text = _TT(32, bag.getSortName(type))--"按" .. bag.getSortName(type)
                else
                    goImgSelect:SetActive(false)
                    goTextSelect:SetActive(false)
                    goTextUnSelect:SetActive(true)
                    textUnSelect.text = _TT(32, bag.getSortName(type))
                end

                local function _clickSubMenuItemFun()
                    self:__resetAllSubMenu()
                    if (data.type ~= type) then
                        data.type = type
                        data.updateMenuStyle()
                        self:__callFun()
                    end
                end
                item:addUIEvent("mImgClick", _clickSubMenuItemFun)
                table.insert(self.mMenuList, {obj = item, key = self:getSubMenuSortKey(false)})
            end
        end
        table.insert(self.mMenuList, {obj = subMenu, key = self:getSubMenuSortKey(true)})
    end
end

-- 添加序列物专用菜单
function addOrderMenu(self, orderFilterTypeList, orderShowFilterType, isOpenSubMenu)
    self:__resetAllSubMenu()
    self:__recoverMenuList(self:getMenuOrderKey())

    -- 序列物菜单按钮
    local item = SimpleInsItem:create(self.mMenuCommon, self.mGroupMenu, self.__cname .. "_self.mMenuCommon")
    local text = item:getChildGO("mTxt"):GetComponent(ty.Text)
    local goUp = item:getChildGO("mImgUp")
    local goDown = item:getChildGO("mImgDown")
    local goImgIcon = item:getChildGO("mImgIcon")
    local imgIcon = goImgIcon:GetComponent(ty.AutoRefImage)
    local function _updateMenuStyle()
        local data = self:getSimpleItem(self:getMenuOrderKey())
        text.text = data.type ~= -1 and bag.getOrderSubTypeName(data.type) or _TT(4011)
        goUp:SetActive(data.isOpen)
        goDown:SetActive(not data.isOpen)
        imgIcon:SetImg(bag.getOrderSubTypeIcon(data.type), false)
        goImgIcon:SetActive(data.type ~= -1 and true or false)

        -- UE说这里不要显示上下箭头了
        goUp:SetActive(false)
        goDown:SetActive(false)

        self:__setIsOpen(data.isOpen)
    end

    local function _clickMenuFun()
        local data = self:getSimpleItem(self:getMenuOrderKey())
        local isOpen = data.isOpen
        self:__resetAllSubMenu()
        data.isOpen = not isOpen
        _updateMenuStyle()
        self:__updateSubMenuOrder()
    end
    item:addUIEvent("mImgClick", _clickMenuFun)
    table.insert(self.mMenuList, {obj = item, key = self:getMenuOrderKey(), typeList = orderFilterTypeList, type = orderShowFilterType or orderFilterTypeList[1], isOpen = isOpenSubMenu, updateMenuStyle = _updateMenuStyle})
    _updateMenuStyle()
end

function __updateSubMenuOrder(self)
    local data = self:getSimpleItem(self:getMenuOrderKey())
    if (data.isOpen) then
        local subMenu = SimpleInsItem:create(self.mSubMenuCommon, data.obj:getChildTrans("mNodeCommon"), self.__cname .. "_self.mSubMenuCommon")
        for i = 1, #data.typeList do
            local type = data.typeList[i]
            local item = SimpleInsItem:create(subMenu:getChildGO("mBtnCommon"), subMenu:getTrans(), self.__cname .. "_BtnCommon")
            local goImgSelect = item:getChildGO("mImgSelect")
            local goTextSelect = item:getChildGO("mTxtSelect")
            local textSelect = goTextSelect:GetComponent(ty.Text)
            local goTextUnSelect = item:getChildGO("mTxtUnSelect")
            local textUnSelect = goTextUnSelect:GetComponent(ty.Text)
            local goImgIcon = item:getChildGO("mImgIcon")
            local imgIcon = goImgIcon:GetComponent(ty.AutoRefImage)
            goImgIcon:SetActive(type ~= -1 and true or false)
            textSelect.text = type ~= -1 and bag.getOrderSubTypeName(type) or _TT(4011)
            textUnSelect.text = type ~= -1 and bag.getOrderSubTypeName(type) or _TT(4011)
            imgIcon:SetImg(bag.getOrderSubTypeIcon(type), false)
            if (type == data.type) then
                goImgSelect:SetActive(true)
                goTextSelect:SetActive(true)
                goTextUnSelect:SetActive(false)
            else
                goImgSelect:SetActive(false)
                goTextSelect:SetActive(false)
                goTextUnSelect:SetActive(true)
            end

            local function _clickSubMenuItemFun()
                self:__resetAllSubMenu()
                if (data.type ~= type) then
                    data.type = type
                    data.updateMenuStyle()
                    self:__callFun()
                end
            end
            item:addUIEvent("mImgClick", _clickSubMenuItemFun)
            table.insert(self.mMenuList, {obj = item, key = self:getSubMenuOrderKey(false)})
        end
        table.insert(self.mMenuList, {obj = subMenu, key = self:getSubMenuOrderKey(true)})
    end
end

-- 添加装备套装专用菜单
function addSuitMenu(self, suitFilterTypeList, suitShowFilterType, isOpenSubMenu)
    self:__resetAllSubMenu()
    self:__recoverMenuList(self:getMenuSuitKey())

    -- 套装菜单按钮
    local item = SimpleInsItem:create(self.mMenuCommon, self.mGroupMenu, self.__cname .. "_self.mMenuCommon")
    local text = item:getChildGO("mTxt"):GetComponent(ty.Text)
    local goUp = item:getChildGO("mImgUp")
    local goDown = item:getChildGO("mImgDown")
    local goImgIcon = item:getChildGO("mImgIcon")
    local function _updateMenuStyle()
        local data = self:getSimpleItem(self:getMenuSuitKey())
        text.text = data.type ~= -1 and data.type.name or _TT(4011)
        goUp:SetActive(not data.isOpen)
        goDown:SetActive(data.isOpen)
        goImgIcon:SetActive(false)

        self:__setIsOpen(data.isOpen)
    end

    local function _clickMenuFun()
        local data = self:getSimpleItem(self:getMenuSuitKey())
        local isOpen = data.isOpen
        self:__resetAllSubMenu()
        data.isOpen = not isOpen
        _updateMenuStyle()
        self:__updateSubMenuSuit()
    end
    item:addUIEvent("mImgClick", _clickMenuFun)
    table.insert(self.mMenuList, {obj = item, key = self:getMenuSuitKey(), typeList = suitFilterTypeList, type = suitShowFilterType or suitFilterTypeList[1], isOpen = isOpenSubMenu, updateMenuStyle = _updateMenuStyle})
    _updateMenuStyle()
end

function isShowHeroWear(self, isShow)
    self.mIsShowHeroWear = isShow
end

function __updateSubMenuSuit(self)
    local data = self:getSimpleItem(self:getMenuSuitKey())
    if (data.isOpen) then
        local subMenu = SimpleInsItem:create(self.mSubMenuSuitScroll, data.obj:getChildTrans("mNodeSuit"), self.__cname .. "_self.mSubMenuSuit")
        for i = 1, #data.typeList do
            local type = data.typeList[i]
            local item = type ~= -1 and SimpleInsItem:create(subMenu:getChildGO("mBtnSuit"), subMenu:getChildTrans("mSubMenuSuit"), self.__cname .. "_BtnSuit") or SimpleInsItem:create(subMenu:getChildGO("mBtnSuitAll"), subMenu:getChildTrans("mSubMenuSuit"), self.__cname .. "_BtnSuitAll")
            local goImgUnSelect = item:getChildGO("mImgUnSelect")
            local goImgSelect = item:getChildGO("mImgSelect")
            local goTextUnSelect = item:getChildGO("mTxtUnSelect")
            local goTextSelect = item:getChildGO("mTxtSelect")
            local goTextUnCount = item:getChildGO("mTxtUnCount")
            local goTextCount = item:getChildGO("mTxtCount")
            local goTextUnFeatures = item:getChildGO("mTxtUnFeatures")
            local goTextFeatures = item:getChildGO("mTxtFeatures")
            local textUnSelect = goTextUnSelect:GetComponent(ty.Text)
            local textSelect = goTextSelect:GetComponent(ty.Text)
            local textUnCount = goTextUnCount:GetComponent(ty.Text)
            local textCount = goTextCount:GetComponent(ty.Text)
            local textUnFeatures = goTextUnFeatures:GetComponent(ty.Text)
            local textFeatures = goTextFeatures:GetComponent(ty.Text)

            textUnSelect.text = type ~= -1 and type.name or _TT(4011)
            textSelect.text = type ~= -1 and type.name or _TT(4011)
            local count = 0
            if (type == -1) then
                local list = bag.BagManager:getPropsListByType(PropsType.EQUIP, nil, bag.BagType.Equip)
                if (self.mIsShowHeroWear == nil or self.mIsShowHeroWear == true) then
                    count = #list
                else
                    for i = 1, #list do
                        if (list[i].heroId <= 0) then
                            count = count + 1
                        end
                    end
                end
            else
                count = type:getSuitEquipCount(nil, self.mIsShowHeroWear)
            end
            textUnCount.text = type ~= -1 and count or string.format("(%s)", count)
            textCount.text = type ~= -1 and count or string.format("(%s)", count)
            local alpha = (count > 0 and 1 or 0.5)
            local color = textUnCount.color
            color.a = alpha
            textUnCount.color = color
            local unColor = textCount.color
            unColor.a = alpha
            textCount.color = unColor
            textUnFeatures.text = type ~= -1 and type.featuresDes or ""
            textFeatures.text = type ~= -1 and type.featuresDes or ""

            if (type == data.type) then
                goImgUnSelect:SetActive(false)
                goImgSelect:SetActive(true)
                goTextUnSelect:SetActive(false)
                goTextSelect:SetActive(true)
                goTextUnCount:SetActive(false)
                goTextCount:SetActive(true)
                goTextUnFeatures:SetActive(false)
                goTextFeatures:SetActive(true)
                textCount.color = gs.ColorUtil.GetColor("000000ff")
            else
                goImgUnSelect:SetActive(true)
                goImgSelect:SetActive(false)
                goTextUnSelect:SetActive(true)
                goTextSelect:SetActive(false)
                goTextUnCount:SetActive(true)
                goTextCount:SetActive(false)
                goTextUnFeatures:SetActive(true)
                goTextFeatures:SetActive(false)
                textCount.color = gs.ColorUtil.GetColor("ffffffff")
            end
            if (type ~= -1) then
                item:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getIconPath(type.icon), false)
            end

            local function _clickSubMenuItemFun()
                self:__resetAllSubMenu()
                if (data.type ~= type) then
                    data.type = type
                    data.updateMenuStyle()
                    self:__callFun()
                end
            end
            item:addUIEvent("mImgClick", _clickSubMenuItemFun)
            table.insert(self.mMenuList, {obj = item, key = self:getSubMenuSuitKey(false)})
        end
        table.insert(self.mMenuList, {obj = subMenu, key = self:getSubMenuSuitKey(true)})
    end
end

-- 添加装备部位专用菜单
function addPosMenu(self, posFilterTypeList, posShowFilterType, isOpenSubMenu)
    self:__resetAllSubMenu()
    self:__recoverMenuList(self:getMenuPosKey())

    -- 部位菜单按钮
    local item = SimpleInsItem:create(self.mMenuCommon, self.mGroupMenu, self.__cname .. "_self.mMenuCommon")
    local text = item:getChildGO("mTxt"):GetComponent(ty.Text)
    local goUp = item:getChildGO("mImgUp")
    local goDown = item:getChildGO("mImgDown")
    local goImgIcon = item:getChildGO("mImgIcon")
    local imgIcon = goImgIcon:GetComponent(ty.AutoRefImage)
    local function _updateMenuStyle()
        local data = self:getSimpleItem(self:getMenuPosKey())
        text.text = data.type ~= -1 and _TT(33, bag.getEquipPosStr(data.type)) or _TT(33, _TT(4011))
        goUp:SetActive(not data.isOpen)
        goDown:SetActive(data.isOpen)
        goImgIcon:SetActive(false)

        -- UE说这里不要显示上下箭头了
        -- goUp:SetActive(false)
        -- goDown:SetActive(false)

        self:__setIsOpen(data.isOpen)
    end

    local function _clickMenuFun()
        local data = self:getSimpleItem(self:getMenuPosKey())
        local isOpen = data.isOpen
        self:__resetAllSubMenu()
        data.isOpen = not isOpen
        _updateMenuStyle()
        self:__updateSubMenuPos()
    end
    item:addUIEvent("mImgClick", _clickMenuFun)
    table.insert(self.mMenuList, {obj = item, key = self:getMenuPosKey(), typeList = posFilterTypeList, type = posShowFilterType or posFilterTypeList[1], isOpen = isOpenSubMenu, updateMenuStyle = _updateMenuStyle})
    _updateMenuStyle()
end

function __updateSubMenuPos(self)
    local data = self:getSimpleItem(self:getMenuPosKey())
    if (data.isOpen) then
        local subMenu = SimpleInsItem:create(self.mSubMenuPos, data.obj:getChildTrans("mNodePos"), self.__cname .. "SubMenuPos")
        for i = 1, #data.typeList do
            local type = data.typeList[i]
            local item = SimpleInsItem:create(subMenu:getChildGO("mBtnPos"), subMenu:getTrans(), self.__cname .. "_BtnPos")
            local goImgUnSelect = item:getChildGO("mImgUnSelect")
            local goImgSelect = item:getChildGO("mImgSelect")
            local goTextUnSelect = item:getChildGO("mTxtUnSelect")
            local goTextSelect = item:getChildGO("mTxtSelect")
            local textUnSelect = goTextUnSelect:GetComponent(ty.Text)
            local textSelect = goTextSelect:GetComponent(ty.Text)
            textUnSelect.text = type ~= -1 and bag.getEquipPosStr(type) or _TT(4011)
            textSelect.text = type ~= -1 and bag.getEquipPosStr(type) or _TT(4011)
            if (type == data.type) then
                goImgUnSelect:SetActive(false)
                goImgSelect:SetActive(true)
                goTextUnSelect:SetActive(false)
                goTextSelect:SetActive(true)
            else
                goImgUnSelect:SetActive(true)
                goImgSelect:SetActive(false)
                goTextUnSelect:SetActive(true)
                goTextSelect:SetActive(false)
            end

            local function _clickSubMenuItemFun()
                self:__resetAllSubMenu()
                if (data.type ~= type) then
                    data.type = type
                    data.updateMenuStyle()
                    self:__callFun()
                end
            end
            item:addUIEvent("mImgClick", _clickSubMenuItemFun)
            table.insert(self.mMenuList, {obj = item, key = self:getSubMenuPosKey(false)})
        end
        table.insert(self.mMenuList, {obj = subMenu, key = self:getSubMenuPosKey(true)})
    end
end

-- 添加装备详细筛选菜单
function showDetailFilterMenu(self, isShow)
    if(isShow)then
        self.mBtnDetailFilter:SetActive(true)
        self:addOnClick(self.mBtnDetailFilter, function() self:onOpenDetailFilterPanel() end)
    else
        self.mBtnDetailFilter:SetActive(false)
    end
end

-- 特殊的筛选规则界面
function onOpenDetailFilterPanel(self, args)
    local callFun = function(selectColorList, selectSuitConfigVoList, selectMainAttrConfigVoList, selectSecondaryAttrConfigVoList)
        local suitIdList = {}
        for i = 1, #selectSuitConfigVoList do
            table.insert(suitIdList, selectSuitConfigVoList[i].suitId)
        end
        self.mSpecialMainAttrKeyList = {}
        for i = 1, #selectMainAttrConfigVoList do
            local key = selectMainAttrConfigVoList[i]:getRefID()
            if(table.indexof(self.mSpecialMainAttrKeyList, key) == false)then
                table.insert(self.mSpecialMainAttrKeyList, key)
            end
        end
        self.mSpecialAttachAttrKeyList = {}
        for i = 1, #selectSecondaryAttrConfigVoList do
            local key = selectSecondaryAttrConfigVoList[i]:getRefID()
            if(table.indexof(self.mSpecialAttachAttrKeyList, key) == false)then
                table.insert(self.mSpecialAttachAttrKeyList, key)
            end
        end
        self.mSpecialColorList = selectColorList
        self.mSelectSuitConfigVoList = selectSuitConfigVoList
        self.mSelectMainAttrConfigVoList = selectMainAttrConfigVoList
        self.mSelectSecondaryAttrConfigVoList = selectSecondaryAttrConfigVoList
        self.mSpecialSuitIdList = suitIdList
        self:updateDetailFilterBtn()
        self:__callFun()
    end
    if self.mEquipFilterRulePanel == nil then
        self.mEquipFilterRulePanel = UI.new(bag.EquipFilterRulePanel)
        self.mEquipFilterRulePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDetailFilterPanelHandler, self)
    end
    self.mEquipFilterRulePanel:open({callFun = callFun, selectColorList = self.mSpecialColorList, suitConfigVoList = self.mSelectSuitConfigVoList, selectMainAttrConfigVoList = self.mSelectMainAttrConfigVoList, selectSecondaryAttrConfigVoList = self.mSelectSecondaryAttrConfigVoList})
end

-- ui销毁
function onDestroyDetailFilterPanelHandler(self)
    self.mEquipFilterRulePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDetailFilterPanelHandler, self)
    self.mEquipFilterRulePanel = nil
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

-- 获取特殊的筛选规则
function getDetailFilterData(self)
    return #self.mSpecialColorList > 0 and self.mSpecialColorList or nil, #self.mSpecialSuitIdList > 0 and self.mSpecialSuitIdList or nil, #self.mSpecialMainAttrKeyList > 0 and self.mSpecialMainAttrKeyList or nil, #self.mSpecialAttachAttrKeyList > 0 and self.mSpecialAttachAttrKeyList or nil
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
-- 套装
function getMenuSuitKey(self)
    return "menu_suit"
end
function getSubMenuSuitKey(self, isMenu)
    return isMenu and "sub_menu_suit" or "sub_menu_item_suit"
end
-- 部位
function getMenuPosKey(self)
    return "menu_pos"
end
function getSubMenuPosKey(self, isMenu)
    return isMenu and "sub_menu_pos" or "sub_menu_item_pos"
end
-- 序列物
function getMenuOrderKey(self)
    return "menu_order"
end
function getSubMenuOrderKey(self, isMenu)
    return isMenu and "sub_menu_order" or "sub_menu_item_order"
end

function __recoverMenuList(self, key)
    for i = #self.mMenuList, 1, -1 do
        if (key) then
            if (self.mMenuList[i].key == key) then
                self.mMenuList[i].obj:poolRecover()
                table.remove(self.mMenuList, i)
            end
        else
            self.mMenuList[i].obj:poolRecover()
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

-- 获取套装的筛选类型
function getSuitFilterType(self)
    local data = self:getSimpleItem(self:getMenuSuitKey(false))
    return data and data.type or nil
end

-- 获取部位的筛选类型
function getPosFilterType(self)
    local data = self:getSimpleItem(self:getMenuPosKey(false))
    return data and data.type or nil
end

-- 获取序列物的筛选类型
function getOrderFilterType(self)
    local data = self:getSimpleItem(self:getMenuOrderKey(false))
    return data and data.type or nil
end

function destroy(self)
    self:removeOnClick(self.mGoToucher)
    self:removeOnClick(self.mBtnDetailFilter)
    self:removeOnClick(self.ImgSowTipsClick)
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
]]
