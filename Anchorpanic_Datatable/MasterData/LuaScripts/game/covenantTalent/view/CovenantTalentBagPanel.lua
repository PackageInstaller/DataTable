module('game.covenantTalent.view.CovenantTalentBagPanel.', Class.impl(View))

UIRes = UrlManager:getUIPrefabPath('covenantTalent/CovenantTalentBagPanel.prefab')

destroyTime = 0 -- 自动销毁时间-1默认
panelType = -1 -- 窗口类型 1 全屏 2 弹窗
isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    -- 英雄id
    self.m_curHeroId = nil
    -- 操作的卡槽芯片部位
    self.m_slotPos = nil
    -- 当前卡槽芯片部位穿戴的装备Vo，没有则为nil
    self.m_hasEquipVo = nil
    -- 选择的装备vo
    self.m_selectEquipVo = nil

    -- 已装备的获取资源的保存类型
    self.m_hasEquipSaveType = "HasEquipSaveType"
    -- 已选择的获取资源的保存类型
    self.m_hasSelectSaveType = "HasSelectSaveType"
    -- 已穿戴的装备界面起始X坐标
    self.m_hasStartPosX = -700

    -- 已装备的装备格子
    self.m_hasEquipGrid = nil
    -- 已选择的装备格子
    self.m_hasSelectGrid = nil
end

function configUI(self)
    self.m_rectGroupBag = self:getChildGO('GroupBag'):GetComponent(ty.RectTransform)
    self.m_toggleWear = self:getChildGO("ToggleWear"):GetComponent(ty.Toggle)
    self.m_toggleWear.isOn = false
    self.m_braceletsScroller = self:getChildGO('BraceletsScroller'):GetComponent(ty.LyScroller)
    self.m_braceletsScroller:SetItemRender(covenantTalent.CovenantTalentBagScrollerItem)

    -- 已穿戴的装备界面
    self.m_groupHasEquip = self:getChildGO('GroupHasEquip')
    self.m_rectHasEquip = self.m_groupHasEquip:GetComponent(ty.RectTransform)
    self.m_btnUnload = self:getChildGO('BtnUnload')

    -- 已选择的装备界面
    self.m_groupHasSelect = self:getChildGO('GroupHasSelect')
    self.m_groupHasSelectCG = self.m_groupHasSelect:GetComponent(ty.CanvasGroup)
    self.m_rectHasSelect = self.m_groupHasSelect:GetComponent(ty.RectTransform)
    self.m_btnReplace = self:getChildGO('BtnReplace')
    self.m_btnActive2 = self:getChildGO('BtnActive2')

    -- 激活界面
    self.m_groupActive = self:getChildGO('GroupActive')
    self.m_groupActiveCG = self.m_groupActive:GetComponent(ty.CanvasGroup)
    self.m_rectActive = self.m_groupActive:GetComponent(ty.RectTransform)
    self.m_btnActive1 = self:getChildGO('BtnActive1')


    self.m_textEmptyTip = self:getChildGO('BraceletsEmptyTip'):GetComponent(ty.Text)

    -- 排序相关
    self:initSort()
end

---------------------------------------------------------------start 排序相关--------------------------------------------------------------
-- 排序菜单
function initSort(self)

    self.m_toggle = self:getChildGO("ToggleWear"):GetComponent(ty.Toggle)
    self.m_checkmark = self:getChildGO('Checkmark')
    self.m_textToggleWear = self:getChildGO('TextToggleWear'):GetComponent(ty.Text)
    self:addToggleEvent()

    self.m_imgSortArrow = self:getChildTrans('ImgSortArrow')
    self:addUIEvent(self:getChildGO('BtnSort'), self.__clickSort)

    self.m_menu = self:getChildGO('Menu')
    self.m_dropDown = self:getChildGO('DropDown')
    self.m_itemSubMenu = self:getChildGO('ItemSubMenu')
    self:addUIEvent(self.m_menu, self.__clickMenu)

    self:__updateMenuList()
    self:__updateSortView()

    local _deActive = self.deActive
    self.deActive = function()
        _deActive(self)
        self:removeToggleEvent()
        self.tabBar:reset()

        self.m_isHeroWear = true
        self.m_isDescending = true
        self.m_isOpenMenu = false
        self.m_curSortType = nil
    end
end

function __updateMenuList(self)
    -- 是否显示已穿戴的手环
    self.m_isHeroWear = self.m_isHeroWear == nil and true or false
    -- 是否选择了降序
    self.m_isDescending = self.m_isDescending == nil and true or false
    -- 是否打开排序菜单
    self.m_isOpenMenu = false
    -- 当前的排序类型列表数据
    self.m_sortList = { bag.BagSortType.LVL, bag.BagSortType.COLOR, bag.BagSortType.ID }
    -- 当前选择的排序类型
    self.m_curSortType = self.m_curSortType or self.m_sortList[1]
    -- 当前的排序内容列表数据
    self.m_sortPageList = {}
    for i = 1, #self.m_sortList do
        local sortType = self.m_sortList[i]
        if (sortType ~= bag.BagSortType.ID and sortType ~= self.m_curSortType) then
            table.insert(self.m_sortPageList, { page = sortType, nomalLan = bag.getSortName(sortType), nomalLanEn = "" })
        end
    end
    if (self.tabBar) then
        self.tabBar:reset()
    end
    self.tabBar = CustomTabBar:create(self.m_itemSubMenu, self.m_dropDown.transform, self.__clickSubMenu, self)
    self.tabBar:setData(self.m_sortPageList)
end

function addToggleEvent(self)
    local function onToggle(result)
        self.m_isHeroWear = result
        self:__updateSortView()
    end
    self.m_toggle.onValueChanged:AddListener(onToggle)
end

function removeToggleEvent(self)
    self.m_toggle.onValueChanged:RemoveAllListeners()
end

function __clickSort(self)
    self.m_isDescending = not self.m_isDescending
    self:__updateSortView()
end

function __clickMenu(self)
    self.m_isOpenMenu = not self.m_isOpenMenu
    self:__updateSortView()
end

function __clickSubMenu(self, sortType)
    self.m_isOpenMenu = false
    self.m_curSortType = sortType
    self:__updateMenuList()
    self:__updateSortView()
end

function __updateSortView(self)
    -- 已穿戴状态
    self.m_toggle.isOn = self.m_isHeroWear
    -- self.m_textToggleWear.text = self.m_isHeroWear and "显示已镶嵌的序列物" or "不显示已镶嵌的序列物"
    self.m_textToggleWear.text = self.m_isHeroWear and _TT(29521) or _TT(29522)
    self.m_checkmark:SetActive(self.m_isHeroWear)
    -- 排序按钮状态
    gs.TransQuick:ScaleY(self.m_imgSortArrow, self.m_isDescending and -0.7 or 0.7)
    -- 排序菜单状态
    self:setBtnLabel(self.m_menu, -1, bag.getSortName(self.m_curSortType))
    self.m_dropDown:SetActive(self.m_isOpenMenu)

    self.m_sortData = {}
    self.m_sortData.isHeroWear = self.m_isHeroWear
    self.m_sortData.isDescending = self.m_isDescending
    local sortList = {}
    table.insert(sortList, self.m_curSortType)
    for i = 1, #self.m_sortList do
        if (self.m_sortList[i] ~= self.m_curSortType) then
            table.insert(sortList, self.m_sortList[i])
        end
    end
    self.m_sortData.sortList = sortList
    self:__updateView(true)
end
---------------------------------------------------------------end 排序相关--------------------------------------------------------------
function active(self, args)
    super.active(self, args)
    covenantTalent.CovenantTalentManager:addEventListener(covenantTalent.CovenantTalentManager.COVENANT_TALENT_BAG_EQUIP_SELECT, self.__onEquipListSelectHandler, self)
    covenantTalent.CovenantTalentManager:addEventListener(covenantTalent.CovenantTalentManager.COVENANT_TALENT_HELPER_GENE_UPDATE, self.onGeneUpdateHandler, self)
    covenantTalent.CovenantTalentManager:addEventListener(covenantTalent.CovenantTalentManager.COVENANT_TALENT_HELPER_GENE_LV_UP, self.onGeneLvUpHandler, self)

    self:setData(args.helperId, args.subType, args.slotPos)

    gs.TransQuick:LPosX(self.m_rectHasEquip, self.m_hasStartPosX)
    gs.TransQuick:LPosX(self.m_rectGroupBag, 530)
    TweenFactory:move2LPosX(self.m_rectGroupBag, 0, 0.2, gs.DT.Ease.Linear)
end

function deActive(self)
    super.deActive(self)
    covenantTalent.CovenantTalentManager:removeEventListener(covenantTalent.CovenantTalentManager.COVENANT_TALENT_BAG_EQUIP_SELECT, self.__onEquipListSelectHandler, self)
    covenantTalent.CovenantTalentManager:removeEventListener(covenantTalent.CovenantTalentManager.COVENANT_TALENT_HELPER_GENE_UPDATE, self.onGeneUpdateHandler, self)
    covenantTalent.CovenantTalentManager:removeEventListener(covenantTalent.CovenantTalentManager.COVENANT_TALENT_HELPER_GENE_LV_UP, self.onGeneLvUpHandler, self)
    self:__cleanSimObj()
end

function initViewText(self)
    self:setBtnLabel(self.m_btnUnload, 4327, "卸下")
    self.m_textEmptyTip.text = _TT(29523) --"暂无序列物"
end

function addAllUIEvent(self)
    self:addUIEvent(self.m_btnUnload, self.__onClickUnloadEquipView)
    self:addUIEvent(self.m_btnReplace, self.__onClickReplaceEquipView)
    self:addUIEvent(self.m_btnActive1, self.__onClickActiveGroove)
    self:addUIEvent(self.m_btnActive2, self.__onClickActiveGroove)
end

-- 请求激活
function __onClickActiveGroove(self)
    GameDispatcher:dispatchEvent(EventName.REQ_ACTIVE_GROOVE, { helperId = self.mHelperId, grooveId = self.geneData.id })
end

-- 点击装备卸下
function __onClickUnloadEquipView(self)
    if (self.m_hasEquipVo) then
        self:close()
        GameDispatcher:dispatchEvent(EventName.REQ_GENE_ORDER_UNLOAD, { helperId = self.mHelperId, grooveId = self.geneData.id })
    end
end

-- 点击装备穿戴或替换
function __onClickReplaceEquipView(self)
    -- if (self.m_selectEquipVo) then
    --     self:close()
    --     if (self.m_selectEquipVo.heroId ~= 0) then
    --         -- 抢夺
    --         GameDispatcher:dispatchEvent(EventName.REQ_HERO_ROB_EQUIP, { heroId = self.m_curHeroId, beRobbedEquipId = self.m_selectEquipVo.id, beRobbedHeroId = self.m_selectEquipVo.heroId })
    --     else
    --         -- 穿戴
    --         GameDispatcher:dispatchEvent(EventName.REQ_HERO_ADD_EQUIP, { heroId = self.m_curHeroId, equipId = self.m_selectEquipVo.id })
    --     end
    -- end
    if self.m_selectEquipVo then
        if self.m_selectEquipVo.heroId > 0 then
            -- 替换
            GameDispatcher:dispatchEvent(EventName.REQ_GENE_ORDER_REPLACE, { oldHelperId = self.m_selectEquipVo.heroId, oldOrderId = self.m_selectEquipVo.id, helperId = self.mHelperId, grooveId = self.geneData.id })
        else
            -- 安装
            GameDispatcher:dispatchEvent(EventName.REQ_GENE_ORDER_LOAD, { helperId = self.mHelperId, grooveId = self.geneData.id, orderId = self.m_selectEquipVo.id })
        end
    else
        if self.geneData.orderVo then
            -- 卸下
            GameDispatcher:dispatchEvent(EventName.REQ_GENE_ORDER_UNLOAD, { helperId = self.mHelperId, grooveId = self.geneData.id })
        else
            -- gs.Message.Show("请选择要安装的序列物")
            gs.Message.Show(_TT(29524))
        end

    end

    self:close()

end

-- 装备选择
function __onEquipListSelectHandler(self, args)
    if self.m_selectEquipVo and self.m_selectEquipVo.id == args.orderVo.id and self.m_selectEquipVo.tid == args.orderVo.tid and self.m_selectEquipVo.heroId == args.orderVo.heroId then
        self.m_selectEquipVo = nil
    else
        self.m_selectEquipVo = args.orderVo
    end
    self:__updateView(true)
end

function onGeneLvUpHandler(self)
    self:__cleanSimObj(self.m_hasEquipSaveType)
    local childGos, childTrans = GoUtil.GetChildHash(self.m_groupHasEquip)
    self:__updateHasEquipView(childGos, childTrans, self.m_hasEquipVo, self.m_hasEquipSaveType)

    if self.geneData and self.geneData.isActive == 1 then
        self.m_groupActive:SetActive(false)
    end
end

function onGeneUpdateHandler(self)
    self:__cleanSimObj(self.m_hasEquipSaveType)
    local childGos, childTrans = GoUtil.GetChildHash(self.m_groupHasEquip)
    self:__updateHasEquipView(childGos, childTrans, self.m_hasEquipVo, self.m_hasEquipSaveType)

    self:__updateSelectGroupVisible(false)
    if self.geneData and self.geneData.isActive == 1 then
        self.m_groupActive:SetActive(false)
    end
end

function setData(self, cusHeroId, cusSubType, cusSlotPos)
    self.m_slotPos = cusSlotPos
    -- self.m_curHeroId = cusHeroId
    -- local heroVo = hero.HeroManager:getHeroVo(self.m_curHeroId)
    -- self.m_hasEquipVo = heroVo:getEquipByPos(self.m_slotPos)
    self.m_subType = cusSubType
    self.mHelperId = cusHeroId
    self.geneData = covenantTalent.CovenantTalentManager:getGeneData(self.mHelperId, self.m_slotPos)
    self.m_hasEquipVo = self.geneData.orderVo

    -- 更新已装备界面只更新一次
    self:__cleanSimObj(self.m_hasEquipSaveType)
    local childGos, childTrans = GoUtil.GetChildHash(self.m_groupHasEquip)
    self:__updateHasEquipView(childGos, childTrans, self.m_hasEquipVo, self.m_hasEquipSaveType)

    self:__updateView(true)
end

function __updateView(self, cusIsInit)
    -- if (not self.m_hasAllHeroEasyEquip) then
    --     local function allHeroEasyEquipUpdate()
    --         GameDispatcher:removeEventListener(EventName.UPDATE_ALL_HERO_EQUIP, allHeroEasyEquipUpdate, self)
    --         self.m_hasAllHeroEasyEquip = true
    --         self:__updateView(cusIsInit)
    --     end
    --     GameDispatcher:addEventListener(EventName.UPDATE_ALL_HERO_EQUIP, allHeroEasyEquipUpdate, self)
    --     GameDispatcher:dispatchEvent(EventName.REQ_ALL_HERO_EQUIP, {})
    --     return
    -- end
    self:__cleanSimObj(self.m_hasSelectSaveType)
    self:__updateEquipView(cusIsInit)
    self:__updateHasEquipVisible()
    self:__updateHasSelectVisible()
end

-- 更新背包装备界面
function __updateEquipView(self, cusIsInit)
    local equipList = covenantTalent.CovenantTalentManager:getEquipList(bag.BagTabType.ORDER, self.m_subType, self.m_sortData, self.mHelperId)
    local isSelectInList = false
    local scrollList = {}
    local _startIndex = 0
    for i = 1, #equipList do
        local equipVo = equipList[i]
        local scrollerVo = LyScrollerSelectVo.new()
        scrollerVo:setDataVo(equipVo)
        scrollerVo:setSelect(false)
        if (self.m_selectEquipVo == nil) then
            -- 不必做默认选中处理
            -- if(i == 1)then
            -- 	self.m_selectEquipVo = equipVo
            -- 	scrollerVo:setSelect(true)
            -- end
        elseif (self.m_selectEquipVo.id == equipVo.id and self.m_selectEquipVo.tid == equipVo.tid and self.m_selectEquipVo.heroId == equipVo.heroId) then
            isSelectInList = true
            scrollerVo:setSelect(true)
        end
        if (equipVo.heroId ~= 0) then
            _startIndex = _startIndex + 1
            table.insert(scrollList, _startIndex, scrollerVo)
        else
            table.insert(scrollList, scrollerVo)
        end
    end
    -- 选择了的装备信息如果不在列表里则置空
    if (not isSelectInList) then
        self.m_selectEquipVo = nil
    end

    if (self.m_braceletsScroller.Count <= 0 or cusIsInit == nil or cusIsInit == true) then
        self.m_braceletsScroller.DataProvider = scrollList
    else
        self.m_braceletsScroller:ReplaceAllDataProvider(scrollList)
    end
    self.m_textEmptyTip.gameObject:SetActive(#scrollList <= 0)
end

-- 更新已穿戴装备的界面
function __updateHasEquipVisible(self)
    local isShow
    if (self.m_hasEquipVo) then
        isShow = true
    else
        isShow = false
    end
    self.m_groupHasEquip:SetActive(isShow)
    if self.geneData and self.geneData.isActive == 0 then
        self.m_groupActive:SetActive(not isShow)
    end
end

-- 更新选中装备的界面
function __updateHasSelectVisible(self)
    local isShow
    if (self.m_selectEquipVo) then
        isShow = true
    else
        isShow = false
    end
    self:__updateSelectGroupVisible(isShow)

    if (isShow) then
        local childGos, childTrans = GoUtil.GetChildHash(self.m_groupHasSelect)
        self:__updateHasEquipView(childGos, childTrans, self.m_selectEquipVo, self.m_hasSelectSaveType)
    end
end

function __updateSelectGroupVisible(self, isShow)
    local hasSPosX = self.m_hasStartPosX
    local hasEposX = -923
    local hasTX = hasEposX - hasSPosX
    if isShow then
        self.m_groupHasSelect:SetActive(true)
        TweenFactory:canvasGroupAlphaTo(self.m_groupHasSelectCG, 0, 1, 0.2, gs.DT.Ease.Linear)
        TweenFactory:scaleTo(self.m_rectHasSelect, { x = 1.05, y = 1.05, z = 1.05 }, { x = 1, y = 1, z = 1 }, 0.4, gs.DT.Ease.Linear)
        TweenFactory:move2LPosX(self.m_rectHasEquip, hasEposX, 0.2 * (hasEposX - self.m_rectHasEquip.localPosition.x) / hasTX, gs.DT.Ease.Linear)
        TweenFactory:move2LPosX(self.m_rectActive, hasEposX, 0.2 * (hasEposX - self.m_rectActive.localPosition.x) / hasTX, gs.DT.Ease.Linear)
    else
        self.m_groupHasSelect:SetActive(false)
        TweenFactory:scaleTo(self.m_rectHasSelect, { x = 1.1, y = 1.1, z = 1.1 }, { x = 1, y = 1, z = 1 }, 0.2, gs.DT.Ease.Linear)
        TweenFactory:move2LPosX(self.m_rectHasEquip, hasSPosX, 0.2 * (self.m_rectHasEquip.localPosition.x - hasSPosX) / hasTX, gs.DT.Ease.Linear)
        TweenFactory:move2LPosX(self.m_rectActive, hasSPosX, 0.2 * (self.m_rectActive.localPosition.x - hasSPosX) / hasTX, gs.DT.Ease.Linear)
    end
end

function __updateHasEquipView(self, childGos, childTrans, equipVo, saveType)
    if (not childGos or not childTrans or not equipVo) then
        return
    end
    if (self.m_selectEquipDataLoadCompleteHandler) then
        equipVo:removeEventListener(equipVo.UPDATE_EQUIP_DETAIL_DATA, self.m_selectEquipDataLoadCompleteHandler, self)
        self.m_selectEquipDataLoadCompleteHandler = nil
    end
    if (equipVo:getTotalAttr() == nil) then
        self.m_selectEquipDataLoadCompleteHandler = function()
            self:__updateHasEquipView(childGos, childTrans, equipVo, saveType)
        end
        equipVo:addEventListener(equipVo.UPDATE_EQUIP_DETAIL_DATA, self.m_selectEquipDataLoadCompleteHandler, self)
        return
    end

    -- 更新基本显示
    childGos["TextName"]:GetComponent(ty.Text).text = equipVo:getName()
    if childGos["BtnActive2"] then
        childGos["BtnActive2"]:SetActive(self.geneData.isActive == 0)
        childGos["ImgActivating"]:SetActive(self.geneData.isActive == 1)
    end

    self:__updateInfo(childGos, childTrans, equipVo, saveType)
    self:__updateBaseAttr(childGos, childTrans, equipVo, saveType)
    self:__updateSkill(childGos, childTrans, equipVo, saveType)
    self:__updateBtn(childGos, childTrans, equipVo, saveType)
    -- gs.LayoutRebuilder.ForceRebuildLayoutImmediate(childTrans["Content"])
end

-- 更新信息
function __updateInfo(self, childGos, childTrans, equipVo, saveType)
    childGos["TextName"]:GetComponent(ty.Text).text = equipVo.name
    -- childGos["TextLvlTitle"]:GetComponent(ty.Text).text = _TT(27129) --"等级"
    -- childGos["TextCurLvl"]:GetComponent(ty.Text).text = equipVo.strengthenLvl
    -- local breakUpConfigVo = equipBuild.EquipStrengthenManager:getBreakUpConfigVo(equipVo.tid, equipVo.tuPoRank)
    -- if (breakUpConfigVo) then
    --     childGos["TextNextLvl"]:GetComponent(ty.Text).text = "/" .. breakUpConfigVo.equipTargetLvl
    -- else
    --     childGos["TextNextLvl"]:GetComponent(ty.Text).text = ""
    -- end
    if (saveType == self.m_hasEquipSaveType) then
        if (self.m_hasEquipGrid) then
            self.m_hasEquipGrid:poolRecover()
            self.m_hasEquipGrid = nil
        end
        self.m_hasEquipGrid = OrderGrid:create(childTrans['EquipNode'], equipVo, 0.4)
        self.m_hasEquipGrid:setClickEnable(false)
    else
        if (self.m_hasSelectGrid) then
            self.m_hasSelectGrid:poolRecover()
            self.m_hasSelectGrid = nil
        end
        self.m_hasSelectGrid = OrderGrid:create(childTrans['EquipNode'], equipVo, 0.4)
        self.m_hasSelectGrid:setClickEnable(false)
    end

    if (saveType == self.m_hasEquipSaveType) then
        childGos['HeroIconWearFor']:SetActive(false)
    elseif (saveType == self.m_hasSelectSaveType) then
        if (equipVo.heroId == 0) then
            childGos['HeroIconWearFor']:SetActive(false)
        else
            childGos['HeroIconWearFor']:SetActive(true)
            -- local heroVo = hero.HeroManager:getHeroVo(equipVo.heroId)
            -- childGos["ImgHero"]:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getHeroHeadUrl(heroVo.tid), false)
            childGos["ImgHero"]:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getIconPath(string.format("helper/helperHead/helper_head_%s.png", equipVo.heroId)), false)
            childGos["TextHeroWearState"]:GetComponent(ty.Text).text = _TT(4329) --"穿戴中"
        end
    end

    local isCanRefine = braceletsBuild.BraceletsRefineManager:isCanRefine(equipVo.tid)
    if (isCanRefine) then
        childGos["GroupRefineLvl"]:SetActive(true)
        local maxRefineLvl = braceletsBuild.BraceletsRefineManager:getMaxRefineLvl(equipVo.tid)
        for lvl = 1, maxRefineLvl do
            local item = self:__getSimpleObj(childGos["ItemRefineLvl"], childTrans["GroupRefineLvl"], saveType)
            item:getChildGO("ImgRefineLvl"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getBraceletsRefineLvlIconUrl(equipVo.refineLvl < lvl), true)
        end
    else
        childGos["GroupRefineLvl"]:SetActive(false)
    end
end

-- 更新基础属性
function __updateBaseAttr(self, childGos, childTrans, equipVo, saveType)
    local totalAttrList, totalAttrDic = equipVo:getTotalAttr()
    -- local nuclearAttrList, nuclearAttrDic = equipVo:getNuclearAttr()
    -- local attachAttrList, attachAttrDic = equipVo:getTuPoAttachAttr()
    for i = 1, #totalAttrList do
        local attrVo = totalAttrList[i]
        local attrTValue = 0
        -- 总属性 = 基础属性 + 核能属性 + 突破附加属性，所以这里如果有核能属性或突破附加属性，则需要进行相减
        -- 过滤核能属性
        -- local nuclearAttr = nuclearAttrDic[attrVo.key]
        -- if nuclearAttr then
        --     attrTValue = (attrVo.value - nuclearAttr)
        -- else
        attrTValue = attrVo.value
        -- end
        -- 过滤激活了的突破附加属性
        -- local attachAttrVo = attachAttrDic[attrVo.key]
        -- if attachAttrVo and attachAttrVo.isActive then
        --     attrTValue = (attrVo.value - attachAttrVo.value)
        -- else
        -- attrTValue = attrVo.value
        -- end
        if (attrTValue > 0) then
            local item = self:__getSimpleObj(childGos["AttrItem"], childTrans["GroupAttr"], saveType)
            item:getChildGO("TextAttrName"):GetComponent(ty.Text).text = AttConst.getName(attrVo.key)
            item:getChildGO("TextAttrValue"):GetComponent(ty.Text).text = AttConst.getValueStr(attrVo.key, attrTValue)
        end
    end
    -- gs.LayoutRebuilder.ForceRebuildLayoutImmediate(childTrans["GroupAttr"])
end

-- 更新技能
function __updateSkill(self, childGos, childTrans, equipVo, saveType)
    local skillEffectList, skillEffectDic = equipVo:getSkillEffect()
    if (skillEffectList and #skillEffectList > 0) then
        for i = 1, #skillEffectList do
            local skillVo = fight.SkillManager:getSkillRo(skillEffectList[i].skillId)
            local item = self:__getSimpleObj(childGos["ItemSkill"], childTrans["GroupSkill"], saveType)
            item:getChildGO("TextSkillTitle"):GetComponent(ty.Text).text = skillVo:getName()
            local des = equip.EquipSkillManager:getSkillDes(equipVo, skillEffectList[i])
            item:getChildGO("TextSkill"):GetComponent(ty.Text).text = des
            -- gs.LayoutRebuilder.ForceRebuildLayoutImmediate(childTrans["ItemSkill"])
        end
    end
    -- gs.LayoutRebuilder.ForceRebuildLayoutImmediate(childTrans["GroupSkill"])
end

-- 更新按钮
function __updateBtn(self, childGos, childTrans, equipVo, saveType)
    if (self.m_hasEquipVo) then
        self:setBtnLabel(self.m_btnReplace, 4323, "替换")
    else
        self:setBtnLabel(self.m_btnReplace, 4324, "安装")
    end
end

function __getSimpleObj(self, go, parentsTrans, saveType)
    local item = SimpleInsItem:create(go, parentsTrans)
    if (not self.m_simpleObjDic) then
        self.m_simpleObjDic = {}
    end
    if (not self.m_simpleObjDic[saveType]) then
        self.m_simpleObjDic[saveType] = {}
    end
    table.insert(self.m_simpleObjDic[saveType], item)
    return item
end

function __cleanSimObj(self, saveType)
    if (self.m_simpleObjDic) then
        if (saveType) then
            if (self.m_simpleObjDic[saveType]) then
                for i = #self.m_simpleObjDic[saveType], 1, -1 do
                    local item = self.m_simpleObjDic[saveType][i]
                    item:poolRecover()
                end
            end
            self.m_simpleObjDic[saveType] = {}
        else
            for saveType, list in pairs(self.m_simpleObjDic) do
                for i = #list, 1, -1 do
                    local item = list[i]
                    item:poolRecover()
                end
                self.m_simpleObjDic[saveType] = {}
            end
        end
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
