module('hero.HeroEquipSuitPanel', Class.impl(View))

UIRes = UrlManager:getUIPrefabPath('hero/HeroEquipSuitPanel.prefab')

destroyTime = 0 -- 自动销毁时间-1默认
panelType = -1 -- 窗口类型 1 全屏 2 弹窗

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
    -- 选择的套装id
    self.m_selectSuitId = nil
    -- 选择的装备id
    self.m_selectEquipId = nil

    -- 已装备的获取资源的保存类型
    self.m_hasEquipSaveType = "HasEquipSaveType"
    -- 已选择的获取资源的保存类型
    self.m_hasSelectSaveType = "HasSelectSaveType"
    -- 已穿戴的装备界面起始X坐标
    self.m_hasStartPosX = 540
end

function configUI(self)
    self.m_rectGroupBag = self:getChildGO('GroupBag'):GetComponent(ty.RectTransform)

    self.m_groupSuit = self:getChildGO('GroupSuit')
    self.m_suitScroller = self:getChildGO('SuitScroller'):GetComponent(ty.LyScroller)
    self.m_suitScroller:SetItemRender(hero.HeroEquipSuitScrollerItem)
    self.m_textSuitTitle = self:getChildGO('TextSuitTitle'):GetComponent(ty.Text)
    self.m_btnCloseSuit = self:getChildGO('BtnCloseSuit')

    self.m_groupEquip = self:getChildGO('GroupEquip')
    self.m_equipScroller = self:getChildGO('EquipScroller'):GetComponent(ty.LyScroller)
    self.m_equipScroller:SetItemRender(hero.HeroEquipBagScrollerItem)
    -- 装备卡槽部位选择切卡
    self.m_tabBarEquipSlot = TabBar:poolGet()
    self.m_tabBarEquipSlot:addParent(self:getChildTrans('TabBarNode'))
    self.m_tabBarEquipSlot:setData(0, 0, 30, 552, false, 0)
    self.m_tabBarEquipSlot:setClickCallBack(self, self.__onClickEquipSlotHandler)
    self.m_textEquipTitle = self:getChildGO('TextEquipTitle'):GetComponent(ty.Text)
    self.m_btnHideEquip = self:getChildGO('BtnHideEquip')
    
    self.m_tabBarEquipSlot:reset()
    local tabDatas = {}
    for i = 1, 6 do
        table.insert(tabDatas, TabData:poolGet():setData(30, 92, bag.getEquipPosStr(i), UrlManager:getPackPath("bag/bag_9.png"), UrlManager:getPackPath("bag/bag_10.png"), 20, nil, i, "acafb1ff", "000000ff", nil, nil, nil, true))
    end
    self.m_tabBarEquipSlot:setItems(tabDatas)

    -- 已穿戴的装备界面
    self.m_groupHasEquip = self:getChildGO('GroupHasEquip')
    self.m_rectHasEquip = self.m_groupHasEquip:GetComponent(ty.RectTransform)
    self.m_btnHasEquipDevelop = self:getChildGO('BtnHasEquipDevelop')
    self.m_btnUnload = self:getChildGO('BtnUnload')
    self.m_textHasEquipDevelop = self:getChildGO('TextHasEquipDevelop'):GetComponent(ty.Text)
    self.m_textUnload = self:getChildGO('TextUnload'):GetComponent(ty.Text)
    self.m_textHasEquipTip = self:getChildGO('TextHasEquipTip'):GetComponent(ty.Text)

    -- 已选择的装备界面
    self.m_groupHasSelect = self:getChildGO('GroupHasSelect')
    self.m_groupHasSelectCG = self:getChildGO('GroupHasSelect'):GetComponent(ty.CanvasGroup)
    self.m_rectHasSelect = self.m_groupHasSelect:GetComponent(ty.RectTransform)
    self.m_btnHasSelectDevelop = self:getChildGO('BtnHasSelectDevelop')
    self.m_btnLoad = self:getChildGO('BtnLoad')
    self.m_textHasSelectDevelop = self:getChildGO('TextHasSelectDevelop'):GetComponent(ty.Text)
    self.m_textLoad = self:getChildGO('TextLoad'):GetComponent(ty.Text)
    self.m_textHasSelectTip = self:getChildGO('TextHasSelectTip'):GetComponent(ty.Text)

    -- 装备背包空物品提示
    self.m_equipSuitEmptyTip = self:getChildGO('EquipSuitEmptyTip')
    self.m_textSuitTip = self:getChildGO('TextSuitTip'):GetComponent(ty.Text)
    self.m_textSuitTipEng = self:getChildGO('TextSuitTipEnglish'):GetComponent(ty.Text)
    self.m_equipEmptyTip = self:getChildGO('EquipEmptyTip')
    self.m_textTip = self:getChildGO('TextTip'):GetComponent(ty.Text)
    self.m_textTipEng = self:getChildGO('TextTipEnglish'):GetComponent(ty.Text)

    -- 排序页面
    self.m_sortView = bag.BagSortView.new()
    self.m_sortView:setParentTrans(self.UITrans)
    self.m_sortView:setPos(-1037, -22, nil, nil)
    self.m_sortView:setCallBack(self, self.__onClickSortItemHandler)
end

function active(self, args)
    hero.HeroEquipManager:addEventListener(hero.HeroEquipManager.HERO_BAG_SUIT_SELECT, self.__onSuitListSelectHandler, self)
    hero.HeroEquipManager:addEventListener(hero.HeroEquipManager.HERO_BAG_EQUIP_SELECT, self.__onEquipListSelectHandler, self)
    bag.BagManager:addEventListener(bag.BagManager.BAG_UPDATE, self.__onBagUpdateHandler, self)

    gs.TransQuick:LPosX(self.m_rectHasEquip,self.m_hasStartPosX)
    self:setData(args.heroId, args.equipSlotPos)

    gs.TransQuick:LPosX(self.m_rectGroupBag,-540)
    TweenFactory:move2LPosX(self.m_rectGroupBag,0,0.2 , gs.DT.Ease.Linear)
end

function deActive(self)
    hero.HeroEquipManager:removeEventListener(hero.HeroEquipManager.HERO_BAG_SUIT_SELECT, self.__onSuitListSelectHandler, self)
    hero.HeroEquipManager:removeEventListener(hero.HeroEquipManager.HERO_BAG_EQUIP_SELECT, self.__onEquipListSelectHandler, self)
    bag.BagManager:removeEventListener(bag.BagManager.BAG_UPDATE, self.__onBagUpdateHandler, self)
    self:__recoverTxtGoDic()
end

function initViewText(self)
    self.m_textSuitTitle.text = _TT(1326)
    self.m_textHasEquipDevelop.text = _TT(1327)
    self.m_textUnload.text = _TT(1328)
    self.m_textHasSelectDevelop.text = _TT(1327)
    self.m_textHasEquipTip.text = _TT(1329)
    self.m_textHasSelectTip.text = _TT(1330)

    self.m_textSuitTip.text = "- 背包内暂无芯片 -" --"- 背包内暂无芯片 -"
    self.m_textSuitTipEng.text = "NO CHIPS"
    self.m_textTip.text = _TT(4314) --"- 暂未拥有当前芯片 -"
    self.m_textTipEng.text = "NO CHIPS"
end

function addAllUIEvent(self)
    self:addUIEvent(self.m_btnCloseSuit, self.close)
    self:addUIEvent(self.m_btnHideEquip, self.__onClickHideEquipView)
    self:addUIEvent(self.m_btnHasEquipDevelop, self.__onClickHasEquipBuildView)
    self:addUIEvent(self.m_btnUnload, self.__onClickUnloadEquipView)
    self:addUIEvent(self.m_btnHasSelectDevelop, self.__onClickHasSelectBuildView)
    self:addUIEvent(self.m_btnLoad, self.__onClickLoadEquipView)
end

-- 移除
function destroy(self, isAuto)
    super.destroy(self, isAuto)

    if self.m_sortView then
        self.m_sortView:destroy()
        self.m_sortView = nil
    end
end

-- 点击已穿装备培养
function __onClickHasEquipBuildView(self)
    if (self.m_hasEquipVo) then
        self:close()
        GameDispatcher:dispatchEvent(EventName.OPEN_EQUIP_BUILD_PANEL, { equipVo = self.m_hasEquipVo })
    end
end

-- 点击装备卸下
function __onClickUnloadEquipView(self)
    if (self.m_hasEquipVo) then
        self:close()
        GameDispatcher:dispatchEvent(EventName.REQ_HERO_DEL_EQUIP, { equipVo = self.m_hasEquipVo })
    end
end

-- 点击已选择装备培养
function __onClickHasSelectBuildView(self)
    if (self.m_selectEquipId) then
        local equipVo = bag.BagManager:getPropsVoById(self.m_selectEquipId)
        self:close()
        GameDispatcher:dispatchEvent(EventName.OPEN_EQUIP_BUILD_PANEL, { equipVo = equipVo })
    end
end

-- 点击装备穿戴或替换
function __onClickLoadEquipView(self)
    local roleVo = role.RoleManager:getRoleVo()
    local systemParam = sysParam.SysParamManager:getValue(920 + self.m_slotPos)
    if roleVo < systemParam then
        gs.Message.Show(_TT(1308, systemParam))
        return
    end

    if (self.m_selectEquipId) then
        self:close()
        GameDispatcher:dispatchEvent(EventName.REQ_HERO_ADD_EQUIP, { heroId = self.m_curHeroId, equipId = self.m_selectEquipId })
    end
end

-- 点击隐藏背包装备界面，显示背包套装界面
function __onClickHideEquipView(self)
    self.m_selectSuitId = nil
    self.m_selectEquipId = nil
    self:__updateView(true)
end

-- 点击排序
function __onClickSortItemHandler(self, sortData)
    self.m_sortData = sortData
    self:__updateView(false)
end

-- 点击装备卡槽部位选择切卡
function __onClickEquipSlotHandler(self, slotPos)
    self.m_slotPos = slotPos
    self.m_selectEquipId = nil
    self:__updateView(true)
    self:setData(self.m_curHeroId, self.m_slotPos)
end

-- 套装选择
function __onSuitListSelectHandler(self, args)
    self.m_selectSuitId = args.suitId
    self.m_selectEquipId = nil
    self:__updateView(true)
    self.m_sortView:setData(bag.getSortList(bag.BagTabType.EQUIP))
end

-- 装备选择
function __onEquipListSelectHandler(self, args)
    if self.m_selectEquipId == args.equipId  then
        self.m_selectEquipId = nil
    else
        self.m_selectEquipId = args.equipId
    end
    self:__updateView(false)
end

-- 背包更新
function __onBagUpdateHandler(self)
    self.m_selectEquipId = nil
    self:__updateView(false)
end

function setData(self, cusHeroId, cusSlotPos)
    self.m_slotPos = cusSlotPos
    self.m_curHeroId = cusHeroId
    local heroVo = hero.HeroManager:getHeroVo(self.m_curHeroId)
    self.m_hasEquipVo = heroVo:getEquipByPos(self.m_slotPos)

    self.m_tabBarEquipSlot:setType(self.m_slotPos)

    -- 更新已装备界面只更新一次
    self:__recoverTxtGoDic(self.m_hasEquipSaveType)
    local childGos, childTrans = GoUtil.GetChildHash(self.m_groupHasEquip)
    self:__updateHasEquipView(childGos, childTrans, self.m_hasEquipVo, self.m_hasEquipSaveType)

    self:__updateView(true)
end

function __updateView(self, cusIsInit)
    self:__recoverTxtGoDic(self.m_hasSelectSaveType)
    if (self.m_selectSuitId) then
        self.m_groupSuit:SetActive(false)
        self.m_groupEquip:SetActive(true)
        self:__updateEquipView(cusIsInit)
    else
        self.m_groupSuit:SetActive(true)
        self.m_groupEquip:SetActive(false)
        self:__updateSuitView(cusIsInit)
        self.m_sortView:setVisible(false)
    end

    self:__updateHasEquipVisible()
    self:__updateHasSelectVisible()
end

-- 更新背包套装界面
function __updateSuitView(self, cusIsInit)
    local suitConfigList = equip.EquipSuitManager:getHasSuitConfigList(true,self.m_slotPos)
    local suitData = {}
    for i = 1,#suitConfigList do
        suitData[i] = {data = suitConfigList[i],slotPos = self.m_slotPos}
    end

    if (cusIsInit) then
        self.m_suitScroller.DataProvider = suitData
    else
        self.m_suitScroller:ReplaceAllDataProvider(suitData)
    end

    self.m_equipSuitEmptyTip:SetActive(#suitConfigList <= 0)

    self:__updateGuideSuit(suitData)
end

function __updateGuideSuit(self, suitConfigList)
    if (#suitConfigList > 0) then
        local heroVo = hero.HeroManager:getHeroVo(self.m_curHeroId)
        for i = 0, #suitConfigList - 1 do
            local suitConfigVo = suitConfigList[i + 1]
            local scrollItem = self.m_suitScroller:GetItemLuaClsByIndex(i)
            -- 是否在显示列表内
            if (scrollItem) then
                if (suitConfigVo.data.suitId == -1 and heroVo.id == 1) then
                    self:setGuideTrans("hero_equip_develop_suit_" .. suitConfigVo.data.suitId .. "_" .. heroVo.id, scrollItem.UIObject.transform)
                end
            end
        end
    end
end

-- 更新背包装备界面
function __updateEquipView(self, cusIsInit)
    if (self.m_selectSuitId == equip.EquipSuitManager.All_SUIT_EQUIP_ID) then
        self.m_textEquipTitle.text = _TT(4011) --全部
    else
        local suitConfigVo = equip.EquipSuitManager:getEquipSuitConfigVo(self.m_selectSuitId)
        self.m_textEquipTitle.text = suitConfigVo.name
    end
    self.m_tabBarEquipSlot:setType(self.m_slotPos)

    if not self.m_sortData then
        self.m_sortData = { isDescending = true, sortList = bag.getSortList(bag.BagTabType.EQUIP) }
    end

    local equipList = bag.BagManager:getBagPagePropsList(bag.BagTabType.EQUIP, {self.m_selectSuitId}, {self.m_slotPos}, nil, self.m_sortData, bag.BagType.Equip)
    local scrollList = {}
    for i = 1, #equipList do
        local equipVo = equipList[i]
        local scrollerVo = LyScrollerSelectVo.new()
        scrollerVo:setDataVo(equipVo)
        scrollerVo:setSelect(false)
        if (self.m_selectEquipId == nil) then
            -- 不必做默认选中处理
            -- if(i == 1)then
            -- 	self.m_selectEquipId = equipVo.id
            -- 	scrollerVo:setSelect(true)
            -- end
        elseif (self.m_selectEquipId == equipVo.id) then
            scrollerVo:setSelect(true)
        end
        table.insert(scrollList, scrollerVo)
    end

    if (cusIsInit) then
        self.m_equipScroller.DataProvider = scrollList
    else
        self.m_equipScroller:ReplaceAllDataProvider(scrollList)
    end
    self.m_equipEmptyTip:SetActive(#scrollList <= 0)

    self:__updateGuideEquip(scrollList)
end

function __updateGuideEquip(self, scrollList)
    if (#scrollList > 0) then
        local heroVo = hero.HeroManager:getHeroVo(self.m_curHeroId)
        for i = 0, #scrollList - 1 do
            local equipVo = scrollList[i + 1]:getDataVo()
            local scrollItem = self.m_equipScroller:GetItemLuaClsByIndex(i)
            -- 是否在显示列表内
            if (scrollItem) then
                if (equipVo.tid == 5071 and heroVo.id == 1) then
                    self:setGuideTrans("hero_equip_develop_equip_" .. equipVo.tid .. "_" .. heroVo.id, scrollItem:getTrans())
                end
            end
        end
    end
end

function __updateGuideBtn(self, name, equipVo, trans)
    if (equipVo.tid == 5071 and self.m_curHeroId == 1) then
        self:setGuideTrans(name .. "_" .. equipVo.tid .. "_" .. self.m_curHeroId, trans)
    end
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
    if (isShow) then
        self:__updateGuideBtn("hero_equip_develop_equip_build", self.m_hasEquipVo, self.m_btnHasEquipDevelop.transform)
    end
end

-- 更新选中装备的界面
function __updateHasSelectVisible(self)
    local isShow
    if (self.m_selectEquipId) then
        isShow = true
    else
        isShow = false
    end
    self:__updateSelectGroupVisible(isShow)

    if (isShow) then
        local childGos, childTrans = GoUtil.GetChildHash(self.m_groupHasSelect)
        local equipVo = bag.BagManager:getPropsVoById(self.m_selectEquipId)
        self:__updateHasEquipView(childGos, childTrans, equipVo, self.m_hasSelectSaveType)
        self:__updateGuideBtn("hero_equip_develop_equip_wear", equipVo, self.m_btnLoad.transform)
    end
end

function __updateSelectGroupVisible(self, isShow)
    local hasSPosX = self.m_hasStartPosX
    local hasEposX = 930
    local hasTX = hasEposX - hasSPosX
    if isShow then
        self.m_groupHasSelect:SetActive(true)
        TweenFactory:canvasGroupAlphaTo(self.m_groupHasSelectCG, 0,1, 0.2, gs.DT.Ease.Linear)
        TweenFactory:scaleTo(self.m_rectHasSelect,{x=1.05,y=1.05,z=1.05},{x=1,y=1,z=1},0.4, gs.DT.Ease.Linear)
        TweenFactory:move2LPosX(self.m_rectHasEquip,hasEposX,0.2 * (hasEposX - self.m_rectHasEquip.localPosition.x)/hasTX, gs.DT.Ease.Linear)
    else
        self.m_groupHasSelect:SetActive(false)
        TweenFactory:scaleTo(self.m_rectHasSelect,{x=1.1,y=1.1,z=1.1},{x=1,y=1,z=1},0.2, gs.DT.Ease.Linear)
        TweenFactory:move2LPosX(self.m_rectHasEquip,hasSPosX,0.2 * (self.m_rectHasEquip.localPosition.x - hasSPosX)/hasTX, gs.DT.Ease.Linear)
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
    childGos["ImgLock"]:SetActive(equipVo.isLock == 1)

    self:__updateBaseAttr(childGos, childTrans, equipVo, saveType)
    self:__updateTuPoAttachAttr(childGos, childTrans, equipVo, saveType)
    -- self:__updateNuclearAttr(childGos, childTrans, equipVo, saveType)
    self:__updateSkill(childGos, childTrans, equipVo, saveType)
    self:__updateSuit(childGos, childTrans, equipVo, saveType)
    self:__updateRemake(childGos, childTrans, equipVo, saveType)
    self:__updateBtn(childGos, childTrans, equipVo, saveType)
end

-- 更新基础属性
function __updateBaseAttr(self, childGos, childTrans, equipVo, saveType)
    childGos["TextTitleBase"]:GetComponent(ty.Text).text = _TT(1331)

    childGos["GroupBaseAttr"]:SetActive(true)

    local totalAttrList, totalAttrDic = equipVo:getTotalAttr()
    local nuclearAttrList, nuclearAttrDic = equipVo:getNuclearAttr()
    local attachAttrList, attachAttrDic = equipVo:getTuPoAttachAttr()
    for i = 1, #totalAttrList do
        local attrVo = totalAttrList[i]
        local attrTValue = 0
        -- 总属性 = 基础属性 + 核能属性 + 突破附加属性，所以这里如果有核能属性或突破附加属性，则需要进行相减
        -- 过滤核能属性
        local nuclearAttr = nuclearAttrDic[attrVo.key]
        if nuclearAttr then
            attrTValue = (attrVo.value - nuclearAttr)
        else
            attrTValue = attrVo.value
        end
        -- 过滤激活了的突破附加属性
        local attachAttrVo = attachAttrDic[attrVo.key]
        if attachAttrVo and attachAttrVo.isActive then
            attrTValue = (attrVo.value - attachAttrVo.value)
        else
            attrTValue = attrVo.value
        end
        if (attrTValue > 0) then
            local txtCloneGo = self:__getTxtGo(childGos, "TextBaseAttr", saveType)
            txtCloneGo.transform:SetParent(childTrans["ShowBase"], false)
            txtCloneGo:GetComponent(ty.Text).text = AttConst.getName(attrVo.key)
            txtCloneGo.transform:Find("TextBaseValue"):GetComponent(ty.Text).text = AttConst.getValueStr(attrVo.key, attrTValue)
            txtCloneGo.transform:Find("ImgLine").gameObject:SetActive(i ~= #totalAttrList)
        end
    end

    local function _updateBaseAttrMenu()
        childGos["ShowBase"]:SetActive(self.m_isOpenBaseAttr)
        local scale = childTrans["ImgArrowBase"].localScale
        scale.y = self.m_isOpenBaseAttr and -1 or 1
        childTrans["ImgArrowBase"].localScale = scale
    end

    local function _onClickBaseAttrMenuHandler()
        self.m_isOpenBaseAttr = not self.m_isOpenBaseAttr
        _updateBaseAttrMenu()
    end
    self:addOnClick(childGos["MenuBase"], _onClickBaseAttrMenuHandler)
    self.m_isOpenBaseAttr = true
    _updateBaseAttrMenu()

    local _close = self.close
    self.close = function()
        _close(self)
        self:removeOnClick(childGos["MenuBase"], _onClickBaseAttrMenuHandler)
    end
end

-- 更新突破附加属性
function __updateTuPoAttachAttr(self, childGos, childTrans, equipVo, saveType)
    childGos["TextTitleTuPoAttach"]:GetComponent(ty.Text).text = _TT(1332)

    local attachAttrList, attachAttrDic = equipVo:getTuPoAttachAttr()
    if (#attachAttrList > 0) then
        childGos["GroupTuPoAttachAttr"]:SetActive(true)

        for i = 1, #attachAttrList do
            local attachAttrVo = attachAttrList[i]
            local itemCloneGo = self:__getTxtGo(childGos, "TuPoAttachAttrItem", saveType)
            itemCloneGo.transform:SetParent(childTrans["ShowTuPoAttach"], false)
            local textAttr = itemCloneGo.transform:Find("TextTuPoAttachAttr"):GetComponent(ty.Text)
            local textAttrTip = itemCloneGo.transform:Find("TextTuPoAttachAttrTip"):GetComponent(ty.Text)
            local imgStateBg = itemCloneGo.transform:Find("ImgTuPoAttachStateBg"):GetComponent(ty.AutoRefImage)
            local imgStateIcon = itemCloneGo.transform:Find("ImgTuPoAttachStateIcon"):GetComponent(ty.AutoRefImage)
            if(attachAttrVo.isActive)then
                textAttr.text = HtmlUtil:color(AttConst.getName(attachAttrVo.key) .. HtmlUtil:color("+" .. AttConst.getValueStr(attachAttrVo.key, attachAttrVo.value), "81cdffff"), ColorUtil.PURE_WHITE_NUM)
                textAttrTip.gameObject:SetActive(false)
                imgStateBg.color = gs.ColorUtil.GetColor("000000FF")
                imgStateBg:SetImg(UrlManager:getCommonPath("common_1004.png"), false)
                imgStateIcon:SetImg(UrlManager:getCommonPath("common_5082.png"), true)
            else
                textAttr.text = HtmlUtil:color(AttConst.getName(attachAttrVo.key) .. "+" .. AttConst.getValueStr(attachAttrVo.key, attachAttrVo.value), "7f868bff")
                textAttrTip.gameObject:SetActive(true)
                textAttrTip.text = _TT(1309, attachAttrVo.breakUpRank - equipVo.tuPoRank)
                imgStateBg.color = gs.ColorUtil.GetColor("FFFFFF15")
                imgStateBg:SetImg(UrlManager:getCommonPath("common_1004.png"), false)
                imgStateIcon:SetImg(UrlManager:getCommonPath("common_5013.png"), true)
            end
        end
    else
        childGos["GroupTuPoAttachAttr"]:SetActive(false)
    end

    local function _updateTuPoAttachMenu()
        childGos["ShowTuPoAttach"]:SetActive(self.m_isOpenTuPoAttach)
        local scale = childTrans["ImgArrowTuPoAttach"].localScale
        scale.y = self.m_isOpenTuPoAttach and -1 or 1
        childTrans["ImgArrowTuPoAttach"].localScale = scale
    end

    local function _onClickTuPoAttachMenuHandler()
        self.m_isOpenTuPoAttach = not self.m_isOpenTuPoAttach
        _updateTuPoAttachMenu()
    end
    self:addOnClick(childGos["MenuTuPoAttach"], _onClickTuPoAttachMenuHandler)
    self.m_isOpenTuPoAttach = true
    _updateTuPoAttachMenu()

    local _close = self.close
    self.close = function()
        _close(self)
        self:removeOnClick(childGos["MenuTuPoAttach"], _onClickTuPoAttachMenuHandler)
    end
end

-- 更新技能
function __updateSkill(self, childGos, childTrans, equipVo, saveType)
    childGos["TextTitleSkill"]:GetComponent(ty.Text).text = _TT(1041)

    childGos["GroupSkill"]:SetActive(false)
    local skillEffectList, skillEffectDic = equipVo:getSkillEffect()
    if (skillEffectList and #skillEffectList > 0) then
        childGos["GroupSkill"]:SetActive(true)

        for i = 1, #skillEffectList do
            local des = equip.EquipSkillManager:getSkillDes(equipVo, skillEffectList[i])
            local txtCloneGo = self:__getTxtGo(childGos, "TextSkill", saveType)
            txtCloneGo.transform:SetParent(childTrans["ShowSkill"], false)
            txtCloneGo:GetComponent(ty.Text).text = des
        end
    end

    local function _updateSkillMenu()
        childGos["ShowSkill"]:SetActive(self.m_isOpenSkill)
        local scale = childTrans["ImgArrowSkill"].localScale
        scale.y = self.m_isOpenSkill and -1 or 1
        childTrans["ImgArrowSkill"].localScale = scale
    end

    local function _onClickSkillMenuHandler()
        self.m_isOpenSkill = not self.m_isOpenSkill
        _updateSkillMenu()
    end
    self:addOnClick(childGos["MenuSkill"], _onClickSkillMenuHandler)
    self.m_isOpenSkill = true
    _updateSkillMenu()

    local _close = self.close
    self.close = function()
        _close(self)
        self:removeOnClick(childGos["MenuSkill"], _onClickSkillMenuHandler)
    end
end

-- 更新套装属性
function __updateSuit(self, childGos, childTrans, equipVo, saveType)
    childGos["TextTitleSuit"]:GetComponent(ty.Text).text = _TT(1316)

    local equipConfigVo = equip.EquipManager:getEquipConfigVo(equipVo.tid)
    local suitId = equipConfigVo.suitId
    local suitConfigVo = equip.EquipSuitManager:getEquipSuitConfigVo(suitId)
    if (not suitConfigVo or (suitConfigVo.suitSkillId_2 <= 0 and suitConfigVo.suitSkillId_4 <= 0)) then
        childGos["GroupSuit"]:SetActive(false)
        childGos["ImgSuit"]:SetActive(false)
    else
        childGos["GroupSuit"]:SetActive(true)
        childGos["ImgSuit"]:SetActive(true)
        childGos["ImgSuit"]:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getEquipSuitIconUrl(suitId), true)

        local count = 0
        local suitIdDic = equip.EquipManager:getEquipSuitIdDic()
        local equipTidDic = suitIdDic[suitId]
        local equipList = {}
        local heroVo = hero.HeroManager:getHeroVo(self.m_curHeroId)
        if heroVo then
            if (saveType == self.m_hasSelectSaveType) then
                table.insert(equipList, equipVo)
            end
            for i = 1, #heroVo.equipList do
                if (saveType == self.m_hasEquipSaveType) then
                    table.insert(equipList, heroVo.equipList[i])
                elseif (saveType == self.m_hasSelectSaveType) then
                    if (self.m_hasEquipVo and self.m_hasEquipVo.id == heroVo.equipList[i].id) then
                        -- 如果当前是选择的装备界面，则当前英雄身上装备列表的正在查看的装备id进行排除
                    else
                        table.insert(equipList, heroVo.equipList[i])
                    end
                end
            end
        end
        if (equipList) then
            for i = 1, #equipList do
                local propsVo = equipList[i]
                if (equipTidDic[propsVo.tid]) then
                    count = count + 1
                    if (count >= 4) then
                        break
                    end
                end
            end
        end

        childGos["TextShowSuitTitle"]:GetComponent(ty.Text).text = suitConfigVo.name
        -- 2件套描述
        if (suitConfigVo.suitSkillId_2 > 0) then
            local txtCloneGo = self:__getTxtGo(childGos, "TextSuitDes", saveType)
            txtCloneGo.transform:SetParent(childTrans["ShowSuit"], false)
            local skillVo = fight.SkillManager:getSkillRo(suitConfigVo.suitSkillId_2)
            if (count >= 2) then
                txtCloneGo.transform:Find("ImgPoint").gameObject:SetActive(false)
                txtCloneGo.transform:Find("ImgActive").gameObject:SetActive(true)
                txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color(_TT(1310, skillVo:getDesc()), count >= 2 and "ffffffff" or "7f868bff")
            else
                txtCloneGo.transform:Find("ImgPoint").gameObject:SetActive(true)
                txtCloneGo.transform:Find("ImgActive").gameObject:SetActive(false)
                txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color(_TT(1310, self:clearHtml(skillVo:getDesc())), count >= 2 and "ffffffff" or "7f868bff")
            end
        end
        -- 4件套描述
        if (suitConfigVo.suitSkillId_4 > 0) then
            local txtCloneGo = self:__getTxtGo(childGos, "TextSuitDes", saveType)
            txtCloneGo.transform:SetParent(childTrans["ShowSuit"], false)
            local skillVo = fight.SkillManager:getSkillRo(suitConfigVo.suitSkillId_4)
            if (count >= 4) then
                txtCloneGo.transform:Find("ImgPoint").gameObject:SetActive(false)
                txtCloneGo.transform:Find("ImgActive").gameObject:SetActive(true)
                txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color(_TT(1311, skillVo:getDesc()), count >= 4 and "ffffffff" or "7f868bff")
            else
                txtCloneGo.transform:Find("ImgPoint").gameObject:SetActive(true)
                txtCloneGo.transform:Find("ImgActive").gameObject:SetActive(false)
                txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color(_TT(1311, self:clearHtml(skillVo:getDesc())), count >= 4 and "ffffffff" or "7f868bff")
            end
        end
    end

    local function _updateSuitMenu()
        childGos["ShowSuit"]:SetActive(self.m_isOpenSuit)
        local scale = childTrans["ImgArrowSuit"].localScale
        scale.y = self.m_isOpenSuit and -1 or 1
        childTrans["ImgArrowSuit"].localScale = scale
    end

    local function _onClickSuitMenuHandler()
        self.m_isOpenSuit = not self.m_isOpenSuit
        _updateSuitMenu()
    end
    self:addOnClick(childGos["MenuSuit"], _onClickSuitMenuHandler)
    self.m_isOpenSuit = true
    _updateSuitMenu()

    local _close = self.close
    self.close = function()
        _close(self)
        self:removeOnClick(childGos["MenuSuit"], _onClickSuitMenuHandler)
    end
end

function clearHtml(self, htmlStr)
    local s, c = string.gsub(htmlStr, "<[%a%A]->", "")
    return s
end

-- 更新改造属性
function __updateRemake(self, childGos, childTrans, equipVo, saveType)
    childGos["TextTitleRemake"]:GetComponent(ty.Text).text = "改造属性"

    childGos["GroupRemake"]:SetActive(false)
    local remakePosAttrList, remakePosAttrDic = equipVo:getRemakeAttr()
    for pos, attrData in pairs(remakePosAttrDic) do
        local key = attrData.key
        local value = attrData.value
        local maxValue = attrData.maxValue
        local colorStr = ""
        if (value >= maxValue) then
            colorStr = ColorUtil.RED_NUM
        else
            colorStr = ColorUtil.BLUE_NUM
        end

        local txtCloneGo = self:__getTxtGo(childGos, "TextRemakeDes", saveType)
        txtCloneGo.transform:SetParent(childTrans["ShowRemake"], false)
        txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color(AttConst.getName(key) .._TT(71445, HtmlUtil:color(AttConst.getValueStr(key, value), colorStr), HtmlUtil:color(AttConst.getValueStr(key, maxValue), ColorUtil.RED_NUM)), ColorUtil.WHITE_NUM)
        childGos["GroupRemake"]:SetActive(true)
    end

    local function _updateRemakeMenu()
        childGos["ShowRemake"]:SetActive(self.m_isOpenRemake)
        local scale = childTrans["ImgArrowRemake"].localScale
        scale.y = self.m_isOpenRemake and -1 or 1
        childTrans["ImgArrowRemake"].localScale = scale
    end

    local function _onClickRemakeMenuHandler()
        self.m_isOpenRemake = not self.m_isOpenRemake
        _updateRemakeMenu()
    end
    self:addOnClick(childGos["MenuRemake"], _onClickRemakeMenuHandler)
    self.m_isOpenRemake = true
    _updateRemakeMenu()

    local _close = self.close
    self.close = function()
        _close(self)
        self:removeOnClick(childGos["MenuRemake"], _onClickRemakeMenuHandler)
    end
end

-- 更新按钮
function __updateBtn(self, childGos, childTrans, equipVo)
    if (self.m_hasEquipVo) then
        self.m_textLoad.text = _TT(1333)
    else
        self.m_textLoad.text = _TT(1334)
    end
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------
function __getGoUniqueName(self, goName)
    return self.__cname .. "_" .. goName
end

function __getTxtGo(self, childGos, goName, saveType)
    local uniqueName = self:__getGoUniqueName(goName)
    local go = gs.GOPoolMgr:GetOther(uniqueName)
    if (not go or gs.GoUtil.IsGoNull(go)) then
        if (childGos and childGos[goName]) then
            go = gs.GameObject.Instantiate(childGos[goName])
        end
    end
    go:SetActive(true)
    if (not self.m_txtGoDic) then
        self.m_txtGoDic = {}
    end
    if (not self.m_txtGoDic[saveType]) then
        self.m_txtGoDic[saveType] = {}
    end
    self.m_txtGoDic[saveType][go:GetHashCode()] = { go = go, uniqueName = uniqueName }
    return go
end

function __recoverTxtGoDic(self, saveType)
    if (self.m_txtGoDic) then
        for type, dic in pairs(self.m_txtGoDic) do
            if (not saveType or (saveType and saveType == type)) then
                for hashCode, data in pairs(dic) do
                    gs.GOPoolMgr:RecoverOther(data.uniqueName, data.go)
                end
            end
        end
    end
    if (self.m_txtGoDic and saveType) then
        self.m_txtGoDic[saveType] = {}
    else
        self.m_txtGoDic = {}
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(1334):	"穿戴"
	语言包: _TT(1333):	"替换"
	语言包: _TT(1316):	"套装属性"
	语言包: _TT(1332):	"附加属性"
	语言包: _TT(1331):	"主属性"
	语言包: _TT(1330):	"当  前  选  择"
	语言包: _TT(1329):	"装  备  中"
	语言包: _TT(1327):	"培养"
	语言包: _TT(1328):	"卸下"
	语言包: _TT(1327):	"培养"
	语言包: _TT(1326):	"套装类型"
	语言包: _TT(1041):	"技能"
	语言包: _TT(1272):	"需要达到"
]]
