module('hero.HeroBraceletsPanel', Class.impl(View))

UIRes = UrlManager:getUIPrefabPath('hero/HeroBraceletsPanel.prefab')
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
isShowBlackBg = 0
-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setTxtTitle(_TT(1335))
    self:setBg("", false)
    --self:setBg("mozu_bg_01.jpg", false, "hero5")
end

-- -- 初始化数据
function initData(self)
    self.mAttrList = {}
    self.mTipsAttrList = {}

    self:mMaterialInitData()
end

function configUI(self)
    super.configUI(self)

    self.mInfo = self:getChildGO("mInfo")
    self.mTxtBraceletsName = self:getChildGO("mTxtBraceletsName"):GetComponent(ty.Text)
    self.mTxtBraceletsLv = self:getChildGO("mTxtBraceletsLv"):GetComponent(ty.Text)
    self.mAttrItem = self:getChildGO("mAttrItem")
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.TMP_Text)
    self.mTxtDescLink = self:getChildGO("mTxtDes"):GetComponent(ty.TextMeshProLink)
    self.mTxtDescLink:SetEventCall(notice.HrefUtil.commonTitleDesLinkData)
    self.mTxtSkill = self:getChildGO("mTxtSkill"):GetComponent(ty.Text)
    self.mIsCurrent = self:getChildGO("mIsCurrent")
    self.mTxtCurrent = self:getChildGO("mTxtCurrent"):GetComponent(ty.Text)
    self.mBtnStrengthen = self:getChildGO("mBtnStrengthen")
    self.mRelGroup = self:getChildGO("mRelGroup")

    -- self.mImgBraceletsIcon = self:getChildGO("mImgBraceletsIcon"):GetComponent(ty.AutoRefImage)
    -- self.mImgButtum = self:getChildGO("mImgButtum"):GetComponent(ty.AutoRefImage)
    -- self.mImgRight = self:getChildGO("mImgRight"):GetComponent(ty.AutoRefImage)

    self.ShowBracelets = self:getChildGO("ShowBracelets")

    self.mBtnEquip = self:getChildGO("mBtnEquip")
    self.mBtnReplace = self:getChildGO("mBtnReplace")
    self.mBtnUnLoad = self:getChildGO("mBtnUnLoad")
    self.mBtnBackList = self:getChildGO("mBtnBackList")
    self.mBtnBackListIcon = self:getChildGO("mImgHeroIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtHeroName = self:getChildGO("mTxtHeroName"):GetComponent(ty.Text)
    self.mBtnRepTips = self:getChildGO("mBtnRepTips")

    self.mBtnLock = self:getChildGO("mBtnLockClick")
    self.mBtnLockImg = self.mBtnLock:GetComponent(ty.AutoRefImage)
    self:mMaterialConfighUI()

    self.mIsNotHas = self:getChildGO("mIsNotHas")
    self.mEmpty = self:getChildGO("mEmpty")

    self:setGuideTrans("funcTips_guide_HeroBracelets_Btn_Equip", self.mBtnEquip.transform)
    self:setGuideTrans("funcTips_guide_HeroBracelets_Btn_Strengthen", self.mBtnStrengthen.transform)

    self.mEmpowerInfo = self:getChildGO("mEmpowerInfo")
    self.EmpowerAttrContent = self:getChildTrans("EmpowerAttrContent")
    self.BaseAttrContent = self:getChildTrans("BaseAttrContent")

    self.mAni = self.UIObject:GetComponent(ty.Animator)

end

-- 设置文本标题
function setTxtTitle(self, title)
    super.setTxtTitle(self, title)
    self:setGuideTrans("funcTips_guide_View_CloseAlll", self.gBtnCloseAll.transform)
end

function initViewText(self)
    self.mTextEmpty.text = _TT(4017)
end

function active(self, args)
    super.active(self, args)
    GameDispatcher:addEventListener(EventName.UPDATE_PROPS_LOCK_STATE, self.onUpdatePropsHandler, self)

    GameDispatcher:addEventListener(EventName.UPDATE_HEAD_CHANGE, self.onHeroChangeUpdateHandler, self)
    GameDispatcher:addEventListener(EventName.BRACELETS_SELECT_CHANGE, self.onUpdateSelectHandler, self)
    hero.HeroEquipManager:addEventListener(hero.HeroEquipManager.HERO_EQUIP_LIST_UPDATE, self.onEquipUpdateHandler, self)
    self:showPanel()

    UISceneBgUtil:create3DBg("arts/sceneModule/ui_mozu_01/prefabs/ui_laohen_01.prefab")
end

function deActive(self)
    super.deActive(self)

    if self.mSelectEquip then
        self.mSelectEquip:removeEventListener(self.mSelectEquip.UPDATE_EQUIP_DETAIL_DATA, self.updateShowSelectInfo,
        self)
        self.mSelectEquip:removeEventListener(props.PropsVo.UPDATE, self.updateShowSelectInfo, self)
        self.mSelectEquip = nil
    end

    if self.materialPanel then
        self.materialPanel:close()
        self.materialPanel = nil
    end
    GameDispatcher:removeEventListener(EventName.UPDATE_PROPS_LOCK_STATE, self.onUpdatePropsHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_HEAD_CHANGE, self.onHeroChangeUpdateHandler, self)
    GameDispatcher:removeEventListener(EventName.BRACELETS_SELECT_CHANGE, self.onUpdateSelectHandler, self)
    hero.HeroEquipManager:removeEventListener(hero.HeroEquipManager.HERO_EQUIP_LIST_UPDATE, self.onEquipUpdateHandler,
    self)
    self:clearAttrItems()

    UISceneBgUtil:reset()
end

function onUpdatePropsHandler(self, args)
    if self.mSelectEquip.id == args.id then
        self:getChildGO("mBtnLock"):SetActive(args.lock == 1)
        self:getChildGO("mBtnUnLock"):SetActive(args.lock ~= 1)
    end
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnLock, self.onBtnLockClickHandler)
    self:addUIEvent(self.mBtnEquip, self.onBtnEquipClickHandler)
    self:addUIEvent(self.mBtnStrengthen, self.onBtnStrengthenClickHandler)
    self:addUIEvent(self.mBtnReplace, self.onBtnReplaceClickHandler)
    self:addUIEvent(self.mBtnUnLoad, self.onBtnUnLoadClickHandler)
    self:addUIEvent(self.mBtnBackList, self.onClickBackListHandler)
    self:addUIEvent(self.mBtnRepTips, function()
        TipsFactory:closeBraceletTips()
        local equipVo = braceletBuild.BraceletBuildManager:getHeroCanHaveEquip(self.mCurHeroId)
        self.mBraceletTips = TipsFactory:openBraceletTips({
            curHeroid = self.mCurHeroId,
            equipVo = equipVo,
            openType = BraceletTipConstOpenType.CurHeroSelf
        })
        if self.mBraceletTips then
            self.mBraceletTips:showMask()
        end
    end)

    self:addmMaterialAllUIEvent()
end

function onBtnLockClickHandler(self)
    local isLock = self.mSelectEquip.isLock == 0 and 1 or 0
    GameDispatcher:dispatchEvent(EventName.REQ_PROPS_LOCK_CHANGE, {
        propsVo = self.mSelectEquip,
        isLock = isLock
    })
end

-- 打开英雄选择界面
function onClickBackListHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_HERO_SHOW_SELECT_PANEL, {
        redType = hero.HeroFlagManager.FLAG_CAN_WEAR_BRACELETS
    })
end

-- 点击穿戴装备
function onBtnEquipClickHandler(self)
    self:onSelectEquipHandler({
        equipVo = self.mSelectEquip
    })
end

-- 强化手环点击
function onBtnStrengthenClickHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_BRACELETS_BUILD_PANEL, {
        equipVo = self.mSelectEquip,
        heroId = self.mCurHeroId
    })
end

-- 强化替换点击
function onBtnReplaceClickHandler(self)
    self:onSelectEquipHandler({
        equipVo = self.mSelectEquip
    })
end

function onSelectEquipHandler(self, args)
    if (args.equipVo.heroId ~= 0) then
        local heroVo = hero.HeroManager:getHeroVo(args.equipVo.heroId)
        UIFactory:alertMessge(_TT(1397, heroVo.name), true, function()
            --GameDispatcher:dispatchEvent(EventName.REQ_ABANDON_CYCLE)
            -- 抢夺
            GameDispatcher:dispatchEvent(EventName.REQ_HERO_ROB_BRACELET, {
                heroId = self.mCurHeroId,
                beRobbedEquipId = args.equipVo.id,
                beRobbedHeroId = args.equipVo.heroId
            })
        end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)

    else
        -- 穿戴
        GameDispatcher:dispatchEvent(EventName.REQ_HERO_ADD_BRACELET, {
            heroId = self.mCurHeroId,
            equipId = args.equipVo.id
        })
    end
end

-- 卸载手环点击
function onBtnUnLoadClickHandler(self)
    GameDispatcher:dispatchEvent(EventName.REQ_HERO_DEL_BRACELET, {
        equipVo = self.mSelectEquip
    })
end

-- 战员变更
function onHeroChangeUpdateHandler(self)
    self:showPanel()
end

function showPanel(self)
    self.mInfo:SetActive(false)
    self.mEmpty:SetActive(true)
    self.mCurHeroId = hero.HeroManager:getPanelShowHeroId()
    local curHeroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
    local mHeroConfigVo = hero.HeroManager:getHeroConfigVo(curHeroVo.tid)

    -- if (curHeroVo.head) then
    --     self.mBtnBackListIcon:SetImg(UrlManager:getIconPath(curHeroVo.head), false)
    -- elseif curHeroVo.headUrl then
    --     self.mBtnBackListIcon:SetImg(curHeroVo.headUrl, false)
    -- else
    --     self.mBtnBackListIcon:SetImg(UrlManager:getHeroHeadUrl(curHeroVo.tid), false)
    -- end

    self.mBtnBackListIcon:SetImg(UrlManager:getHeroHeadUrlByModel(curHeroVo:getHeroModel()), false)

    self.mTxtHeroName.text = curHeroVo.name

    self:initMaterialPanel()
end

function initMaterialPanel(self)
    local args = {}
    args.heroId = self.mCurHeroId
    args.slotPos = PropsEquipSubType.SLOT_7
    args.equipVo = nil

    self:initMaterialData(args)
    -- 默认选中第一个
    if self.mLyScroller.DataProvider and #self.mLyScroller.DataProvider > 1 and self.mLyScroller.DataProvider[1]:getDataVo() ~= nil then
        self:onUpdateSelectHandler({
        equipVo = self.mLyScroller.DataProvider[1]:getDataVo()}, false)
    else
        self.mInfo:SetActive(false)
        self.mEmpty:SetActive(true)
    end
end

-- 手环选择变更
function onUpdateSelectHandler(self, args, playAni)
    -- if self.mSelectEquip and self.mSelectEquip.id == args.equipVo.id then
    --     return
    -- end
    if playAni ~= nil and playAni ~= false and (self.mSelectEquip == nil or (self.mSelectEquip.id ~= args.equipVo.id)) then--and (self.mSelectEquip == nil or (self.mSelectEquip and self.mSelectEquip.id ~= args.equipVo.id))
        self.mAni:SetTrigger("show")
    end

    if self.mSelectEquip then
        self.mSelectEquip:removeEventListener(self.mSelectEquip.UPDATE_EQUIP_DETAIL_DATA, self.updateShowSelectInfo,
        self)
        self.mSelectEquip:removeEventListener(props.PropsVo.UPDATE, self.updateShowSelectInfo, self)
        self.mSelectEquip = nil
    end

    self.mSelectEquip = args.equipVo
    --if self.mSelectEquip.isNew then
    self.isNew = read.ReadManager:isModuleRead(ReadConst.NEW_EQUIP, self.mSelectEquip.id)
    if self.isNew then
        GameDispatcher:dispatchEvent(EventName.REQ_MODULE_READ, {
            type = ReadConst.NEW_EQUIP,
            id = self.mSelectEquip.id
        })
    end

    --self.mSelectEquip:setIsNew(false)
    --end

    if (self.mSelectEquip) then
        self.mSelectEquip:addEventListener(self.mSelectEquip.UPDATE_EQUIP_DETAIL_DATA, self.updateShowSelectInfo, self)
        self.mSelectEquip:addEventListener(props.PropsVo.UPDATE, self.updateShowSelectInfo, self)

        self:updateShowSelectInfo()
    else
        self.mInfo:SetActive(false)
        self.mEmpty:SetActive(true)
    end

    self:updateMaterialView(false)
end

function onEquipUpdateHandler(self)
    self:updateShowSelectInfo()
    self:updateMaterialView(false)
end

function updateShowSelectInfo(self)

    if self.mSelectEquip == nil then
        self.mInfo:SetActive(false)
        return
    end

    local skillEffectList, skillEffectDic = self.mSelectEquip:getSkillEffect()
    if skillEffectList == nil or #skillEffectList < 1 then
        self.mInfo:SetActive(false)
        return
    end
    ---------------------------------------------------------------------以上情形数据都未完整-------------------------------------------------------------
    self.mInfo:SetActive(true)
    self.mEmpty:SetActive(false)
    self.mTxtBraceletsName.text = self.mSelectEquip.name
    self.mTxtBraceletsLv.text = "Lv." .. self.mSelectEquip.strengthenLvl

    braceletBuild.BraceletBuildManager:setBraceletsInfo(self.mSelectEquip, self.ShowBracelets)
    -- self.mImgBraceletsIcon:SetImg(UrlManager:getBraceletIconUrl(self.mSelectEquip.tid), false)
    -- self.mImgButtum:SetImg(UrlManager:getNraceletColorUrl(self.mSelectEquip.color), false)
    -- self.mImgRight:SetImg(UrlManager:getNraceletRightColorUrl(self.mSelectEquip.color), false)

    local maxRefineLvl = braceletBuild.BraceletBuildManager:getMaxRefineLvl(self.mSelectEquip.tid)

    local currentRefineLvl = self.mSelectEquip.refineLvl
    local mStr = maxRefineLvl > currentRefineLvl and "bracelet/bracelet_refine_1.png" or
    "bracelet/bracelet_refine_2.png"
    for i = 1, maxRefineLvl do
        local img = self:getChildGO("mImgRel" .. i):GetComponent(ty.AutoRefImage)
        img:SetImg(UrlManager:getPackPath(mStr), false)
        img.color = gs.ColorUtil.GetColor(i > currentRefineLvl and "82898cff" or "ffffffff")
    end

    -- 只有有一个技能 但是顺应之前的写法
    local skillVo = fight.SkillManager:getSkillRo(skillEffectList[1].skillId)
    self.mTxtSkill.text = skillVo:getName()
    local des = equip.EquipSkillManager:getBraceletSkillDes(self.mSelectEquip, skillEffectList[1])
    self.mTxtDes.text = des

    self:clearAttrItems()
    local mainAttrList, _ = self.mSelectEquip:getMainAttr()
    for i = 1, #mainAttrList do
        local attrVo = mainAttrList[i]
        local attrTValue = attrVo.value

        local item = SimpleInsItem:create(self.mAttrItem, self.BaseAttrContent, "HeroBraceletsPanelattrItem")
        item:getChildGO("mTxtAttrName"):GetComponent(ty.Text).text = AttConst.getName(attrVo.key)
        item:getChildGO("mTxtAttrValue"):GetComponent(ty.Text).text = AttConst.getValueStr(attrVo.key, attrTValue)

        table.insert(self.mAttrList, item)
    end

    --赋能属性
    local equipBracelet_remake_attr = self.mSelectEquip:getBracelet_remake_attr()
    self.mEmpowerInfo:SetActive(not table.empty(equipBracelet_remake_attr))

    for i = 1, #equipBracelet_remake_attr do
        local item = SimpleInsItem:create(self.mAttrItem, self.EmpowerAttrContent, "HeroBraceletsPanelattrItem")
        table.insert(self.mAttrList, item)

        local key = equipBracelet_remake_attr[i].attrType
        local value = equipBracelet_remake_attr[i].attrValue

        item:getChildGO("mTxtAttrName"):GetComponent(ty.Text).text = AttConst.getName(key)
        item:getChildGO("mTxtAttrValue"):GetComponent(ty.Text).text = AttConst.getValueStr(key, value)
    end

    self:getChildGO("mBtnLock"):SetActive(self.mSelectEquip.isLock == 1)
    self:getChildGO("mBtnUnLock"):SetActive(self.mSelectEquip.isLock ~= 1)

    --self.mIsCurrent:SetActive(self.mSelectEquip.heroId == self.mCurHeroId)
    self.mIsCurrent:SetActive(self.mSelectEquip.heroId > 0)
    if self.mSelectEquip.heroId > 0 then
        if not self.mImgHeroIconCircle then
            self.mImgHeroIconCircle = self:getChildGO("mImgHeroIcon_min"):GetComponent(ty.AutoRefImage)
        end
        local heroVo = hero.HeroManager:getHeroVo(self.mSelectEquip.heroId)
        local iconUrl = UrlManager:getHeroHeadCircularByModel(heroVo:getHeroModel())
        self.mImgHeroIconCircle:SetImg(iconUrl, false)
        self.mTxtCurrent.text = _TT(4384, heroVo.name) -- XXX已穿戴
    end
    self.mBtnUnLoad:SetActive(self.mSelectEquip.heroId == self.mCurHeroId)

    local equipVo = braceletBuild.BraceletBuildManager:getHeroCanHaveEquip(self.mCurHeroId)

    self.mIsNotHas:SetActive(equipVo == nil)
    self.mBtnEquip:SetActive(self.mSelectEquip.heroId ~= self.mCurHeroId and equipVo == nil)
    self.mBtnReplace:SetActive(self.mSelectEquip.heroId ~= self.mCurHeroId and equipVo ~= nil)

    if equipVo and equipVo.id ~= self.mSelectEquip.id then
        self.mBtnRepTips:SetActive(true)
    else
        self.mBtnRepTips:SetActive(false)
    end
end

function clearAttrItems(self)
    for i = 1, #self.mAttrList do
        self.mAttrList[i]:poolRecover()
    end
    self.mAttrList = {}
end

-------------------------------------------------------------materialTips-------------------------------------------------------------
function mMaterialInitData(self)
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
    self.m_selectFilterDic = {}
    self.m_tempSelectFilterDic = {}
    for type in pairs(equipBuild.panelFilterTypeDic) do
        self.m_selectFilterDic[type] = {}
        self.m_selectFilterDic[type][equipBuild.filterSubTypeAll] = true
        self.m_tempSelectFilterDic[type] = {}
        self.m_tempSelectFilterDic[type][equipBuild.filterSubTypeAll] = true
    end

    self.mMenuList = {}
end

function mMaterialConfighUI(self)
    self.mLyScroller = self:getChildGO('LyScroller'):GetComponent(ty.LyScroller)
    self.mLyScrollRect = self:getChildGO("LyScroller"):GetComponent(ty.ScrollRect)
    self.mLyScroller:SetItemRender(hero.HeroBraceletsBagScrollerItem)
    --self.mImgEmpty = self:getChildGO('EmptyStateItem')
    self.mTextEmpty = self:getChildGO("mTxtEmptyTip"):GetComponent(ty.Text)
    self:initSearchMenu()
end

function addmMaterialAllUIEvent(self)
    self:addUIEvent(self:getChildGO("mBtnGetBracelets"), function()
        logInfo("点击获取手环")
    end)
end

function initMaterialData(self)
    self:updateMaterialView(true)
end

function updateBraceletsHandler(self, args)

    self:updateMaterialView(false)
end

-- 更新强化界面
function updateMaterialView(self, isInit)
    self.m_sortData = {}
    self.m_sortData.isHeroWear = self.m_isHeroWear
    self.m_sortData.isDescending = self.m_isDescending
    self.m_sortList = bag.getSortList(bag.BagTabType.BRACELETS)

    local sortList = {}
    -- table.insert(sortList, self.m_selectSortType)
    -- for i = 1, #self.m_sortList do
    --     if (self.m_sortList[i] ~= self.m_selectSortType) then
    --         table.insert(sortList, self.m_sortList[i])
    --     end
    -- end

    if self.m_selectSortType == nil then
        self.m_selectSortType = self.m_sortList[1]
    end
    sortList[1] = self.m_selectSortType
    self.m_sortData.sortList = sortList

    local equipList = braceletBuild.BraceletBuildManager:getEquipList(bag.BagType.Bracelets, bag.BagTabType.BRACELETS,
    nil, self.m_slotPos, self.m_sortData, self.m_curHeroId)

    local selfEquip = braceletBuild.BraceletBuildManager:getHeroCanHaveEquip(self.mCurHeroId)
    -- 永远把自己的装备排在最前面
    local idx = table.indexof(equipList, selfEquip)
    if idx then
        table.remove(equipList, idx)
        table.insert(equipList, 1, selfEquip)
    end

    local scrollList = {}
    for i = 1, #equipList do
        local equipVo = equipList[i]
        if (equipVo.subType == PropsEquipSubType.SLOT_7) then
            local scrollerVo = LyScrollerSelectVo.new()
            scrollerVo:setDataVo(equipVo)
            scrollerVo:setSelect(false)

            if self.mSelectEquip and self.mSelectEquip.id == equipVo.id then
                scrollerVo:setSelect(true)
            end
            table.insert(scrollList, scrollerVo)
        end
    end

    if #scrollList <= 12 then
        for i = 1, 12 - #scrollList do
            local scrollerVo = LyScrollerSelectVo.new()
            scrollerVo:setDataVo(nil)
            scrollerVo:setSelect(false)
            table.insert(scrollList, scrollerVo)
        end

        self.mLyScrollRect.enabled = false
    else
        self.mLyScrollRect.enabled = true
    end

    if isInit or self.mLyScroller.Count <= 0 then
        self.mLyScroller.DataProvider = scrollList
    else
        self.mLyScroller:ReplaceAllDataProvider(scrollList)
    end
    --self.mImgEmpty:SetActive(#scrollList <= 0)
    --self.mInfo:SetActive(#scrollList > 0)
end

function getSortList(self)
    local typeList = bag.getSortList(bag.BagTabType.BRACELETS)
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

---------------------------------------------------------------------------------------------------

function initSearchMenu(self)
    self.btnClose = self:getChildGO("BtnClose")

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

    self.btnClose:SetActive(false)
    local _active = self.active
    self.active = function()
        _active(self)
        self:__updateDescendingState()
        self:__updateMenuList()
        self:__updateMenuView()
        self:addUIEvent(self.m_suitmenu, self.__clickSuitMenu)
        self:addUIEvent(self.m_menu, self.__clickMenu)
        self:addUIEvent(self.m_descending, self.__clickDescending)
        self:addUIEvent(self.btnClose, self.onCloseMenu)
    end

    local _deActive = self.deActive
    self.deActive = function()
        _deActive(self)
        self:__resetAllSubMenu()
        self.m_isDescending = true
        self.m_isOpenSuitMenu = false
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
    self.m_menuList = bag.getSortList(bag.BagTabType.BRACELETS)
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
    self.btnClose:SetActive(self.m_isOpenMenu)
    self:__updateMenuView()
end

function __clickSubMenu(self, sortType)
    self.m_isOpenMenu = false
    self.m_selectSortType = sortType

    -- GameDispatcher:dispatchEvent(EventName.CLOSE_BRACELETS_CONTRAST_TIPS)
    self:__updateMenuList()
    self:__updateMenuView()
    self:updateMaterialView(false)
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
    self:updateMaterialView(false)
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

    self.m_suitmenuList = {{
        suitId = -1,
        name = _TT(4011)}, {
        name = "橙",
        suitId = 4
        }, {
        name = "紫",
        suitId = 3
        }, {
        name = "蓝",
        suitId = 2
    }}

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

        if (type.suitId == self.m_selectSuit.suitId) then
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
    self.m_suitdropDown:SetActive(self.m_isOpenSuitMenu)
    self.m_suitimgGoUp:SetActive(self.m_isOpenSuitMenu)
    self.m_suitimgGoDown:SetActive(not self.m_isOpenSuitMenu)
end

function __clickDescending(self)
    if self.m_isOpenSuitMenu then
        self:__clickSuitMenu()
    end

    -- GameDispatcher:dispatchEvent(EventName.CLOSE_BRACELETS_CONTRAST_TIPS)
    local temp = not self.m_isDescending
    self.m_isDescending = temp
    self:__updateDescendingState();
    self:updateMaterialView(false)
end

return _M
